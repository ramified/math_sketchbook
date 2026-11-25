import { test } from "node:test";
import assert from "node:assert/strict";
import { renderTex, renderInlineTex, buildMacros, rewriteRefTargets, findRefTargets, REF_OPEN, REF_CLOSE, parseBibliography } from "../src/latex.ts";

const { macros, error } = buildMacros(String.raw`\newcommand{\Q}{\mathbb{Q}}
\newcommand{\abs}[1]{\left|#1\right|}
\DeclareMathOperator{\Li}{Li}
\renewcommand{\Re}{\operatorname{Re}}
\newcommand{\pair}[2]{\langle #1,
  #2 \rangle} % multi-line definition`);

test("macros: renewcommand of built-ins, multi-line, errors isolated", () => {
  const r = renderTex(String.raw`$\Re s$ $\pair{a}{b}$`, macros);
  assert.deepEqual(r.warnings, []);
  assert.ok(!r.html.includes("ℜ"));
  const bad = buildMacros(String.raw`\newcommand{\A}{\frac{1}
\newcommand{\B}{b}`);
  assert.ok(bad.error);
});

test("macros build", () => {
  assert.equal(error, undefined);
  const r = renderTex(String.raw`$\Q$ and $\abs{x}$ and $\Li(x)$`, macros);
  assert.deepEqual(r.warnings, []);
  assert.match(r.html, /katex/);
});

test("text mode", () => {
  const r = renderTex(String.raw`Hello \emph{world} -- see \ref{4CHK} and \cite[Thm.~1]{Dav}.

\begin{itemize}
\item one
\item[(b)] two
\end{itemize}
<script>`, macros);
  assert.deepEqual(r.refs, ["4CHK"]);
  assert.ok(r.html.includes("<em>world</em>"));
  assert.ok(r.html.includes(REF_OPEN + "4CHK" + REF_CLOSE));
  assert.ok(r.html.includes("<ul><li>one</li>"));
  assert.ok(r.html.includes('class="item-label">(b)</span>'));
  assert.ok(r.html.includes("&lt;script&gt;"));
  assert.ok(r.html.includes("–"));
  assert.match(r.html, /\[<a class="cite" href="\/bibliography#cite-Dav">Dav<\/a>, Thm. 1\]/);
});

test("display math and environments", () => {
  const r = renderTex(String.raw`\[ \sum_n a_n \]
\begin{align} a &= b \\ c &= d \end{align}
\begin{CD} A @>>> B \end{CD}`, macros);
  assert.deepEqual(r.warnings, []);
  assert.equal((r.html.match(/math-display/g) ?? []).length, 3);
});

test("math errors become warnings", () => {
  const r = renderTex(String.raw`$\frac{1}$ and \foo{x}`, macros);
  assert.equal(r.warnings.length, 2);
  assert.match(r.html, /math-error/);
});

test("alias rewriting", () => {
  const src = String.raw`see \ref{dirichlet-char} and \ref{ 4CHK , grh } and $x$`;
  assert.deepEqual(findRefTargets(src).map((t) => t.target), ["dirichlet-char", "4CHK", "grh"]);
  const out = rewriteRefTargets(src, (t) => ({ "dirichlet-char": "4CHK", grh: "6EQS" } as Record<string, string>)[t] ?? null);
  assert.equal(out, String.raw`see \ref{4CHK} and \ref{ 4CHK , 6EQS } and $x$`);
});

test("bibliography", () => {
  assert.deepEqual(parseBibliography(String.raw`\bibitem{A} One. \bibitem{B} Two.`), [
    { key: "A", tex: "One." },
    { key: "B", tex: "Two." },
  ]);
});

test("commands named like Object.prototype members do not crash", () => {
  const r = renderTex(String.raw`\toString{x} \constructor \hasOwnProperty`, macros);
  assert.equal(r.warnings.length, 3);
  assert.equal(renderInlineTex(String.raw`A \toString title`, macros).includes("tex-unknown"), true);
});

test("placeholder characters in the source are stripped", () => {
  const r = renderTex("\\url{\uE000ABCD\uE001} and \uE000ABCD\uE001", macros);
  assert.deepEqual(r.refs, []);
  assert.ok(!/[\uE000\uE001]/.test(r.html));
});

test("javascript urls are not linked", () => {
  const r = renderTex(String.raw`\href{javascript:alert(1)}{x} \url{https://a.b}`, macros);
  assert.ok(!r.html.includes("javascript:"));
  assert.ok(r.html.includes('href="https://a.b"'));
});

test("\hyperref links its own text; aliases in it are rewritten", async () => {
  const { fillRefs } = await import("../src/book.ts");
  const r = renderTex(String.raw`a \hyperref[8JA9]{Dirichlet $\chi$} and \ref{8JC4}; \hyperref{x}`, macros);
  assert.deepEqual(r.refs, ["8JA9", "8JC4"]);
  assert.equal(r.warnings.length, 1); // \hyperref without a target
  const entry = (tag: string, label: string, listed: boolean, refHtml?: string) =>
    [tag, { tag, id: 1, kind: "result", number: "", label, title: "", parentId: 1, hidden: false, listed, refHtml }] as const;
  const book = { chapters: [], sectionsOf: new Map(), resultsOf: new Map(), sectionById: new Map(),
    byTag: new Map([entry("8JA9", "Definition", false, "Dirichlet character"), entry("8JC4", "Definition 1.1.3", true)]) } as never;
  const out = fillRefs(r.html, book);
  assert.match(out, /<a class="ref" href="\/tag\/8JA9" data-tag="8JA9">Dirichlet <span class="katex">/);
  assert.match(out, /data-tag="8JC4">Definition 1\.1\.3<\/a>/);
  // a plain \ref to an unlisted result shows its title
  assert.match(fillRefs(renderTex(String.raw`\ref{8JA9}`, macros).html, book), />Dirichlet character<\/a>/);
  assert.equal(rewriteRefTargets(String.raw`\hyperref[chi]{a} \ref{chi}`, (t) => (t === "chi" ? "8JA9" : null)), String.raw`\hyperref[8JA9]{a} \ref{8JA9}`);
});

test("includegraphics: local figures only, width and alt options", () => {
  const ok = renderTex(String.raw`See:
\includegraphics[width=0.8\textwidth, alt=Graph of G]{/static/figures/g1.svg}`, macros);
  assert.deepEqual(ok.warnings, []);
  assert.match(ok.html, /<figure class="tex-figure"><img src="\/static\/figures\/g1\.svg" alt="Graph of G" style="width:80%" loading="lazy"><\/figure>/);
  for (const bad of ["https://evil.example/x.svg", "/static/figures/../style.css", "/static/x.svg", "javascript:alert(1)"]) {
    const r = renderTex(String.raw`\includegraphics{` + bad + "}", macros);
    assert.equal(r.warnings.length, 1, bad);
    assert.ok(!r.html.includes("<img"), bad);
  }
});

test("inline math keeps touching punctuation on its line", () => {
  // "(" before and ")." after go into one no-wrap span with the formula
  const a = renderTex(String.raw`one ($x = 1$). Next`, macros).html;
  assert.match(a, /^<p>one <span class="math-nobr">\(<span class="katex">/);
  assert.match(a, /<\/span>\)\.<\/span> Next<\/p>$/);
  // spaces on both sides: no wrapper, but the formula's last piece is still held
  const b = renderTex(String.raw`one $x + y$ two`, macros).html;
  assert.ok(!b.includes("math-nobr"));
  assert.equal(b.match(/class="katex-tail"/g)?.length, 1);
  assert.match(b, /<span class="katex-tail"><span class="katex-base">[\s\S]*<\/span><\/span><\/span><\/span> two<\/p>$/);
  // only punctuation is glued (not "-functions"), and typography still applies to it
  const c = renderTex("the $L$-functions and ``$y$''", macros).html;
  assert.equal(c.match(/class="math-nobr"/g)?.length, 1);
  assert.match(c, /<\/span>-functions and <span class="math-nobr">“<span class="katex">/);
  assert.match(c, /<\/span>”<\/span><\/p>$/);
  // display math is untouched
  assert.ok(!renderTex(String.raw`\[ x = 1 \]`, macros).html.includes("katex-tail"));
});
