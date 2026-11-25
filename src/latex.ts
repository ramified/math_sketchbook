// LaTeX snippet -> HTML.
//
// One parser (unified-latex) is used for everything: rendering, live preview, warnings, finding \ref{...}
// (dependency graph) and rewriting readable aliases to tags. Math is rendered with KaTeX on the server.
//
// \ref{TAG} is NOT turned into a final link here: it becomes a placeholder REF_OPEN + TAG + REF_CLOSE, which is
// replaced by "Lemma 1.2.3" when the page is served (see numbering.ts). That way cached HTML never contains
// numbers that could go stale when results are moved.
// \hyperref[TAG]{text} links its own text instead: REF_OPEN + TAG + REF_SEP + rendered text + REF_CLOSE.

import { parse } from "@unified-latex/unified-latex-util-parse";
import katex from "katex";

export const REF_OPEN = "";
export const REF_CLOSE = "";
export const REF_SEP = "";
const PUA_RE =/[-]/g;
const REF_TARGET_RE = /^[A-Za-z0-9][A-Za-z0-9:._-]{0,63}$/;

export interface Warning {
  line?: number;
  message: string;
}

export interface RenderOutput {
  html: string;
  refs: string[]; // distinct \ref targets, in order of appearance
  warnings: Warning[];
}

export type Macros = Record<string, string | object>;

// ---- minimal AST typing (unified-latex) ----
interface Pos {
  start: { offset: number; line: number };
  end: { offset: number };
}
interface Arg {
  type: "argument";
  content: Node[];
  openMark: string;
  closeMark: string;
}
interface Node {
  type: string;
  content?: string | Node[];
  env?: string | Node;
  args?: Arg[];
  position?: Pos;
}

const MATH_ENVS = new Set([
  "equation", "equation*", "align", "align*", "gather", "gather*", "multline", "multline*",
  "alignat", "alignat*", "flalign", "flalign*", "CD", "eqnarray", "eqnarray*", "displaymath", "math",
]);
const DIAGRAM_ENVS = new Set(["tikzcd", "tikzpicture", "xy"]);

const SIMPLE_TEXT_MACROS: Record<string, string> = {
  S: "§", P: "¶", ldots: "…", dots: "…", textellipsis: "…",
  LaTeX: "LaTeX", TeX: "TeX", "%": "%", "&": "&", "#": "#", $: "$", _: "_", "{": "{", "}": "}",
  ",": " ", " ": " ", quad: " ", qquad: "  ", textendash: "–", textemdash: "—",
  "@": "", "/": "", noindent: "", indent: "", label: "", smallskip: "", medskip: "", bigskip: "",
  hfill: "", centering: "", ss: "ß", ae: "æ", oe: "œ", o: "ø", aa: "å",
};
const ACCENTS: Record<string, string> = {
  "'": "́", "`": "̀", "^": "̂", '"': "̈", "~": "̃", "=": "̄",
  ".": "̇", u: "̆", v: "̌", H: "̋", c: "̧", k: "̨",
};
const WRAP_MACROS: Record<string, [string, string]> = {
  emph: ["<em>", "</em>"], textit: ["<em>", "</em>"], textsl: ["<em>", "</em>"],
  textbf: ["<strong>", "</strong>"], texttt: ["<code>", "</code>"], underline: ["<u>", "</u>"],
  textsc: ['<span class="smallcaps">', "</span>"], textrm: ["", ""], textup: ["", ""], textnormal: ["", ""],
  text: ["", ""], textsf: ["", ""], mbox: ["", ""],
  footnote: ['<span class="footnote">(', ")</span>"],
};
const REF_MACROS = new Set(["ref", "cref", "Cref", "autoref"]);
const FIGURE_SRC_RE = /^\/static\/figures\/[A-Za-z0-9_-][A-Za-z0-9._-]*\.(svg|png|jpe?g|webp)$/;
const CITE_MACROS = new Set(["cite", "citep", "citet"]);

export function escapeHtml(s: string): string {
  return s.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;")
    .replace(/'/g, "&#39;");
}

function safeUrl(u: string): string | null {
  const t = u.trim();
  return /^(https?:\/\/|mailto:|\/)/i.test(t) ? t : null;
}

/** Text of a node list, ignoring markup (used for \ref/\cite/\url arguments). */
function plainText(nodes: Node[] | undefined): string {
  if (!nodes) return "";
  let s = "";
  for (const n of nodes) {
    if (n.type === "string") s += n.content as string;
    else if (n.type === "whitespace") s += " ";
    else if (n.type === "macro" && typeof n.content === "string" && n.content.length === 1 && !/[a-zA-Z]/.test(n.content))
      s += n.content; // escaped chars like \_ or \%
    else if (Array.isArray(n.content)) s += plainText(n.content);
  }
  return s;
}

/** The last non-empty mandatory argument, or the last argument. */
function mainArg(n: Node): Node[] | undefined {
  const args = n.args ?? [];
  for (let i = args.length - 1; i >= 0; i--) if (args[i].openMark === "{") return args[i].content;
  for (let i = args.length - 1; i >= 0; i--) if (args[i].content.length) return args[i].content;
  return undefined;
}
function optArg(n: Node): Node[] | undefined {
  const a = (n.args ?? []).find((a) => a.openMark === "[");
  return a?.content;
}
function envName(n: Node): string {
  if (typeof n.env === "string") return n.env;
  if (n.env && typeof n.env === "object") return String((n.env as Node).content ?? "");
  return "";
}

type Seg = { kind: "inline" | "block" | "par"; html: string };

class Renderer {
  refs: string[] = [];
  warnings: Warning[] = [];
  private src: string;
  private macros: Macros;
  constructor(src: string, macros: Macros) {
    this.src = src;
    this.macros = macros;
  }

  warn(n: Node | undefined, message: string) {
    if (this.warnings.length < 50) this.warnings.push({ line: n?.position?.start.line, message });
  }

  slice(n: Node): string {
    return n.position ? this.src.slice(n.position.start.offset, n.position.end.offset) : "";
  }

  math(tex: string, display: boolean, n: Node): string {
    if (/\\(ref|cref|eqref)\b/.test(tex)) this.warn(n, "\\ref inside math is not supported; put it outside the $...$.");
    try {
      return katex.renderToString(tex, {
        displayMode: display,
        throwOnError: true,
        strict: "ignore",
        trust: false,
        macros: { ...this.macros },
      });
    } catch (e) {
      const msg = e instanceof Error ? e.message : String(e);
      this.warn(n, `Math error: ${msg}`);
      const cls = display ? "math-error display" : "math-error";
      return `<span class="${cls}" title="${escapeHtml(msg)}">${escapeHtml(tex)}</span>`;
    }
  }

  inlineMath(n: Node): string {
    const s = this.slice(n);
    const inner = s.startsWith("$") ? s.slice(1, -1) : s.slice(2, -2);
    return holdLastBase(this.math(inner, false, n));
  }

  /** Turn a node list into segments: inline html, block html, and paragraph breaks. */
  segs(nodes: Node[] | undefined): Seg[] {
    const out: Seg[] = [];
    let text = "";
    // Inline math waits for the text right after it, so it can be glued to the punctuation on both sides.
    let pending: { lead: string; html: string } | null = null;
    const settle = () => {
      if (!pending) return;
      const trail = MATH_TRAIL_RE.exec(text)?.[0] ?? "";
      text = text.slice(trail.length);
      out.push({ kind: "inline", html: glueMath(pending.lead, pending.html, trail) });
      pending = null;
    };
    const flush = () => {
      settle();
      if (text) out.push({ kind: "inline", html: typography(text) });
      text = "";
    };
    for (const n of nodes ?? []) {
      switch (n.type) {
        case "string":
          text += n.content as string;
          break;
        case "whitespace":
          text += " ";
          break;
        case "comment":
          break;
        case "parbreak":
          flush();
          out.push({ kind: "par", html: "" });
          break;
        case "inlinemath": {
          settle();
          const lead = MATH_LEAD_RE.exec(text)?.[0] ?? "";
          text = text.slice(0, text.length - lead.length);
          flush();
          pending = { lead, html: this.inlineMath(n) };
          break;
        }
        default:
          flush();
          out.push(...this.node(n));
      }
    }
    flush();
    return out;
  }

  inline(nodes: Node[] | undefined): string {
    return assemble(this.segs(nodes), false);
  }

  node(n: Node): Seg[] {
    switch (n.type) {
      case "inlinemath":
        return [{ kind: "inline", html: this.inlineMath(n) }];
      case "displaymath": {
        const s = this.slice(n);
        const inner = s.startsWith("$$") ? s.slice(2, -2) : s.slice(2, -2);
        return [{ kind: "block", html: `<div class="math-display">${this.math(inner, true, n)}</div>` }];
      }
      case "mathenv":
        return [{ kind: "block", html: `<div class="math-display">${this.math(this.slice(n), true, n)}</div>` }];
      case "environment":
        return this.environment(n);
      case "macro":
        return this.macro(n);
      case "group":
        return [{ kind: "inline", html: this.inline(n.content as Node[]) }];
      case "verbatim":
      case "verb":
        return [{ kind: "inline", html: `<code>${escapeHtml(String(n.content ?? ""))}</code>` }];
      default:
        if (Array.isArray(n.content)) return this.segs(n.content);
        return [];
    }
  }

  macro(n: Node): Seg[] {
    const name = n.content as string;
    if (REF_MACROS.has(name)) {
      const raw = plainText(mainArg(n));
      const targets = raw.split(",").map((t) => t.trim()).filter(Boolean);
      const parts: string[] = [];
      for (const t of targets) {
        if (!REF_TARGET_RE.test(t)) {
          this.warn(n, `Invalid reference target "${t}".`);
          parts.push(`<span class="ref-broken">??${escapeHtml(t)}</span>`);
          continue;
        }
        if (!this.refs.includes(t)) this.refs.push(t);
        parts.push(REF_OPEN + t + REF_CLOSE);
      }
      return [{ kind: "inline", html: parts.join(", ") }];
    }
    if (name === "hyperref") {
      const t = plainText(optArg(n)).trim();
      const text = this.inline(mainArg(n));
      if (!REF_TARGET_RE.test(t)) {
        this.warn(n, t ? `Invalid reference target "${t}".` : "\\hyperref needs a target: \\hyperref[TAG]{text}.");
        return [{ kind: "inline", html: text }];
      }
      if (!this.refs.includes(t)) this.refs.push(t);
      return [{ kind: "inline", html: REF_OPEN + t + REF_SEP + text + REF_CLOSE }];
    }
    if (name === "eqref") {
      this.warn(n, "\\eqref (equation labels) is not supported yet.");
      return [{ kind: "inline", html: "(?)" }];
    }
    if (CITE_MACROS.has(name)) {
      const keys = plainText(mainArg(n)).split(",").map((k) => k.trim()).filter(Boolean);
      const note = optArg(n);
      const links = keys.map((k) => `<a class="cite" href="/bibliography#cite-${encodeURIComponent(k)}">${escapeHtml(k)}</a>`);
      const noteHtml = note && note.length ? ", " + this.inline(note) : "";
      return [{ kind: "inline", html: `[${links.join(", ")}${noteHtml}]` }];
    }
    // Object.hasOwn, not `in`: a command like \toString or \constructor must not hit Object.prototype.
    if (Object.hasOwn(WRAP_MACROS, name)) {
      const [a, b] = WRAP_MACROS[name];
      return [{ kind: "inline", html: a + this.inline(mainArg(n)) + b }];
    }
    if (Object.hasOwn(ACCENTS, name) && n.args?.length) {
      const base = plainText(mainArg(n));
      return [{ kind: "inline", html: escapeHtml((base + ACCENTS[name]).normalize("NFC")) }];
    }
    if (Object.hasOwn(SIMPLE_TEXT_MACROS, name)) return [{ kind: "inline", html: escapeHtml(SIMPLE_TEXT_MACROS[name]) }];
    if (name === "\\" || name === "newline" || name === "linebreak") return [{ kind: "inline", html: "<br>" }];
    if (name === "par") return [{ kind: "par", html: "" }];
    if (name === "url") {
      const u = plainText(mainArg(n));
      const ok = safeUrl(u);
      return [{ kind: "inline", html: ok ? `<a href="${escapeHtml(ok)}">${escapeHtml(u)}</a>` : escapeHtml(u) }];
    }
    if (name === "href") {
      const args = (n.args ?? []).filter((a) => a.openMark === "{");
      const u = plainText(args[0]?.content);
      const ok = safeUrl(u);
      const label = this.inline(args[1]?.content);
      return [{ kind: "inline", html: ok ? `<a href="${escapeHtml(ok)}">${label}</a>` : label }];
    }
    if (name === "includegraphics") return [this.figure(n)];
    if (name === "item") {
      this.warn(n, "\\item outside a list.");
      return this.segs(mainArg(n));
    }
    this.warn(n, `Unsupported command \\${name}.`);
    const inner = (n.args ?? []).map((a) => this.inline(a.content)).join("");
    return [{ kind: "inline", html: `<span class="tex-unknown">\\${escapeHtml(name)}</span>${inner}` }];
  }

  /**
   * \includegraphics[width=0.8\textwidth, alt=Some text]{/static/figures/name.svg}: a centred image. Only files
   * shipped with the site under /static/figures/ are allowed, so content can never embed outside URLs.
   */
  figure(n: Node): Seg {
    const src = plainText(mainArg(n)).trim();
    if (!FIGURE_SRC_RE.test(src)) {
      this.warn(n, `\\includegraphics only accepts files under /static/figures/ (got "${src}").`);
      return { kind: "block", html: `<span class="tex-unknown">\\includegraphics{${escapeHtml(src)}}</span>` };
    }
    const opts = plainText(optArg(n));
    const w = /width\s*=\s*([0-9]*\.?[0-9]+)/.exec(opts);
    const pct = w ? Math.min(100, Math.max(10, Number(w[1]) <= 1 ? Number(w[1]) * 100 : Number(w[1]))) : 100;
    const alt = /alt\s*=\s*([^,]*)/.exec(opts)?.[1].trim() ?? "";
    return {
      kind: "block",
      html: `<figure class="tex-figure"><img src="${escapeHtml(src)}" alt="${escapeHtml(alt)}" style="width:${pct}%" loading="lazy"></figure>`,
    };
  }

  environment(n: Node): Seg[] {
    const env = envName(n);
    const body = n.content as Node[];
    if (MATH_ENVS.has(env)) {
      const s = this.slice(n);
      const tex = env === "displaymath" || env === "math" ? s.replace(/^\\begin\{\w+\}|\\end\{\w+\}$/g, "") : s;
      return [{ kind: env === "math" ? "inline" : "block", html: `<div class="math-display">${this.math(tex, env !== "math", n)}</div>` }];
    }
    if (DIAGRAM_ENVS.has(env)) {
      this.warn(n, `${env} diagrams are not rendered yet; shown as source.`);
      return [{ kind: "block", html: `<pre class="tex-diagram">${escapeHtml(this.slice(n))}</pre>` }];
    }
    if (env === "itemize" || env === "enumerate" || env === "description") return [this.list(env, body)];
    if (env === "quote" || env === "quotation")
      return [{ kind: "block", html: `<blockquote>${assemble(this.segs(body), true)}</blockquote>` }];
    if (env === "center") return [{ kind: "block", html: `<div class="center">${assemble(this.segs(body), true)}</div>` }];
    if (env === "verbatim") return [{ kind: "block", html: `<pre>${escapeHtml(plainText(body))}</pre>` }];
    this.warn(n, `Unsupported environment ${env}; its content is shown as plain text.`);
    return [{ kind: "block", html: `<div class="env-unknown">${assemble(this.segs(body), true)}</div>` }];
  }

  list(env: string, body: Node[]): Seg {
    type Item = { label?: Node[]; nodes: Node[] };
    const items: Item[] = [];
    for (const n of body ?? []) {
      if (n.type === "macro" && n.content === "item") {
        items.push({ label: optArg(n), nodes: [...(mainArg(n) ?? [])] });
      } else if (items.length) {
        items[items.length - 1].nodes.push(n);
      } else if (n.type !== "whitespace" && n.type !== "parbreak" && n.type !== "comment") {
        this.warn(n, `Text before the first \\item in ${env}.`);
      }
    }
    if (env === "description") {
      const parts = items.map((it) => `<dt>${this.inline(it.label)}</dt><dd>${assemble(this.segs(it.nodes), false)}</dd>`);
      return { kind: "block", html: `<dl>${parts.join("")}</dl>` };
    }
    const tag = env === "enumerate" ? "ol" : "ul";
    const parts = items.map((it) => {
      const content = assemble(this.segs(it.nodes), false);
      return it.label
        ? `<li class="labeled"><span class="item-label">${this.inline(it.label)}</span> ${content}</li>`
        : `<li>${content}</li>`;
    });
    return { kind: "block", html: `<${tag}>${parts.join("")}</${tag}>` };
  }
}

function typography(raw: string): string {
  const t = raw
    .replace(PUA_RE, "")
    .replace(/``/g, "“").replace(/''/g, "”").replace(/`/g, "‘")
    .replace(/---/g, "—").replace(/--/g, "–")
    .replace(/[ \t\r\n]+/g, " ")
    .replace(/~/g, " ");
  return escapeHtml(t);
}

/**
 * Browsers may break a line right after an inline formula, even before "." or ")", because KaTeX builds it from
 * inline-blocks. Chrome takes the rule for that break from the parent of the formula's last piece, so wrap that
 * piece in a no-wrap span (style.css). The formula can still break between its earlier pieces.
 */
function holdLastBase(html: string): string {
  const open = '<span class="katex-base">';
  const close = "</span></span>"; // end of .katex-html and of .katex
  const i = html.lastIndexOf(open);
  if (i < 0 || !html.endsWith(close)) return html;
  const j = html.length - close.length;
  if (html.slice(i, j).includes("katex-newline")) return html;
  return `${html.slice(0, i)}<span class="katex-tail">${html.slice(i, j)}</span>${html.slice(j)}`;
}

/** Opening punctuation right before inline math, and closing punctuation right after it (raw TeX text). */
const MATH_LEAD_RE = /[([`‘“]+$/;
const MATH_TRAIL_RE = /^[.,;:!?)\]'’”]+/;

/**
 * Inline math with the punctuation touching it, such as "(" before or ")." after, in one no-wrap span, so neither
 * "(" ends a line nor "." starts one. style.css lets the formula itself still break inside the span. Words and
 * hyphens ("$L$-functions") are left out: in a no-wrap span they would only lose their own break points.
 */
function glueMath(lead: string, math: string, trail: string): string {
  if (!lead && !trail) return math;
  return `<span class="math-nobr">${typography(lead)}${math}${typography(trail)}</span>`;
}

/**
 * Join segments into HTML. With wrapParas, inline runs become <p> paragraphs. Without it (list items, inline args),
 * a single paragraph is left unwrapped.
 */
function assemble(segs: Seg[], wrapParas: boolean): string {
  const groups: { kind: "p" | "block"; html: string }[] = [];
  let cur = "";
  const close = () => {
    if (cur.trim()) groups.push({ kind: "p", html: cur.trim() });
    cur = "";
  };
  for (const s of segs) {
    if (s.kind === "inline") cur += s.html;
    else if (s.kind === "par") close();
    else {
      close();
      groups.push({ kind: "block", html: s.html });
    }
  }
  close();
  if (!wrapParas && groups.length === 1 && groups[0].kind === "p") return groups[0].html;
  return groups.map((g) => (g.kind === "p" ? `<p>${g.html}</p>` : g.html)).join("\n");
}

function parseSafe(src: string): { ast: Node | null; error?: string } {
  try {
    return { ast: parse(src) as unknown as Node };
  } catch (e) {
    return { ast: null, error: e instanceof Error ? e.message : String(e) };
  }
}

/** Render a LaTeX snippet (block mode: paragraphs, lists, display math). */
export function renderTex(src: string, macros: Macros): RenderOutput {
  // The private-use characters are reserved for \ref placeholders; they must never come from the source.
  src = src.replace(PUA_RE, "");
  if (!src.trim()) return { html: "", refs: [], warnings: [] };
  const { ast, error } = parseSafe(src);
  if (!ast) {
    return {
      html: `<pre class="tex-error">${escapeHtml(src)}</pre>`,
      refs: [],
      warnings: [{ message: `Could not parse LaTeX: ${error}` }],
    };
  }
  const r = new Renderer(src, macros);
  const html = assemble(r.segs(ast.content as Node[]), true);
  return { html, refs: r.refs, warnings: r.warnings };
}

/** Render a short inline snippet such as a title (no paragraphs). */
export function renderInlineTex(src: string, macros: Macros): string {
  src = src.replace(PUA_RE, "");
  if (!src.trim()) return "";
  const { ast } = parseSafe(src);
  if (!ast) return escapeHtml(src);
  try {
    return new Renderer(src, macros).inline(ast.content as Node[]);
  } catch {
    return escapeHtml(src); // a broken title must never take a page down
  }
}

/** Locate every \ref-like target in the source (with offsets), for alias rewriting. */
export function findRefTargets(src: string): { target: string; start: number; end: number }[] {
  const { ast } = parseSafe(src);
  if (!ast) return [];
  const found: { target: string; start: number; end: number }[] = [];
  const visit = (nodes: Node[] | undefined) => {
    for (const n of nodes ?? []) {
      const isHyper = n.type === "macro" && n.content === "hyperref";
      if (n.type === "macro" && (REF_MACROS.has(n.content as string) || isHyper)) {
        const arg = isHyper ? optArg(n) : mainArg(n);
        const first = arg?.find((x) => x.position);
        const last = [...(arg ?? [])].reverse().find((x) => x.position);
        if (first?.position && last?.position) {
          const start = first.position.start.offset;
          const end = last.position.end.offset;
          // a single argument may hold several comma-separated targets
          let offset = start;
          for (const piece of src.slice(start, end).split(",")) {
            const lead = piece.length - piece.trimStart().length;
            const t = piece.trim();
            if (t) found.push({ target: t, start: offset + lead, end: offset + lead + t.length });
            offset += piece.length + 1;
          }
        }
      }
      if (Array.isArray(n.content)) visit(n.content);
      for (const a of n.args ?? []) visit(a.content);
    }
  };
  visit(ast.content as Node[]);
  return found;
}

/** Replace \ref targets for which `map` returns a new value (used to turn aliases into tags). */
export function rewriteRefTargets(src: string, map: (target: string) => string | null): string {
  const hits = findRefTargets(src).sort((a, b) => b.start - a.start);
  let out = src;
  for (const h of hits) {
    const rep = map(h.target);
    if (rep && rep !== h.target) out = out.slice(0, h.start) + rep + out.slice(h.end);
  }
  return out;
}

/**
 * Build the KaTeX macro table from the shared macro file (\newcommand, \renewcommand, \def, \DeclareMathOperator).
 */
export function buildMacros(macroSrc: string): { macros: Macros; error?: string } {
  const macros: Macros = {};
  // Normalise everything to \gdef, which (unlike \newcommand/\renewcommand in KaTeX) may redefine built-ins
  // such as \Re.
  const prepared = macroSrc
    .replace(/\\DeclareMathOperator(\*?)\s*\{?(\\[A-Za-z]+)\}?\s*\{([^{}]*)\}/g,
      (_m, star: string, name: string, body: string) => `\\gdef${name}{\\operatorname${star}{${body}}}`)
    .replace(/\\(?:re|provide)?newcommand\*?\s*\{?(\\[A-Za-z]+)\}?\s*(?:\[(\d)\])?\s*\{/g, (_m, name: string, n?: string) => {
      let params = "";
      for (let i = 1; i <= Number(n ?? 0); i++) params += `#${i}`;
      return `\\gdef${name}${params}{`;
    });
  // Split into top-level definitions (brace-balanced chunks) so one bad definition does not break the others.
  const chunks: { text: string; line: number }[] = [];
  let cur = "";
  let depth = 0;
  let startLine = 1;
  prepared.split(/\r?\n/).forEach((rawLine, i) => {
    const line = rawLine.replace(/(^|[^\\])%.*$/, "$1");
    if (!cur.trim()) startLine = i + 1;
    cur += line + "\n";
    for (let j = 0; j < line.length; j++) {
      if (line[j] === "\\") j++;
      else if (line[j] === "{") depth++;
      else if (line[j] === "}") depth--;
    }
    if (depth <= 0 && cur.trim()) {
      chunks.push({ text: cur, line: startLine });
      cur = "";
      depth = 0;
    }
  });
  if (cur.trim()) chunks.push({ text: cur, line: startLine });

  const errors: string[] = [];
  for (const c of chunks) {
    try {
      katex.renderToString(c.text, { macros, globalGroup: true, throwOnError: true, strict: "ignore" });
    } catch (e) {
      errors.push(`line ${c.line}: ${e instanceof Error ? e.message : String(e)}`);
    }
  }
  return errors.length ? { macros, error: errors.join("; ") } : { macros };
}

/** Parse "\bibitem{key} text" entries. */
export function parseBibliography(src: string): { key: string; tex: string }[] {
  const out: { key: string; tex: string }[] = [];
  const re = /\\bibitem\s*\{([^}]+)\}/g;
  const marks: { key: string; start: number; end: number }[] = [];
  let m: RegExpExecArray | null;
  while ((m = re.exec(src))) marks.push({ key: m[1].trim(), start: m.index, end: re.lastIndex });
  marks.forEach((mk, i) => out.push({ key: mk.key, tex: src.slice(mk.end, marks[i + 1]?.start ?? src.length).trim() }));
  return out;
}
