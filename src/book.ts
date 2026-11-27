// Reading side: load the book structure, compute numbers, render cached HTML, fill in \ref placeholders.

import { buildMacros, renderTex, renderInlineTex, escapeHtml, REF_OPEN, REF_CLOSE, REF_SEP, type Macros } from "./latex.ts";
import type { Env, ResultRow, ProofRow, SectionRow, ResultType } from "./types.ts";

export interface Entry {
  tag: string;
  id: number;
  kind: "chapter" | "section" | "result";
  number: string; // "1.2.3"
  label: string; // "Lemma 1.2.3"
  title: string; // raw TeX title
  type?: ResultType;
  parentId: number | null; // chapter id for sections, section id for results
  hidden: boolean; // draft or retired: not numbered on the public site
  listed: boolean; // false: shown only through links (no number, not listed in its section on the public site)
  refHtml?: string; // link text for a plain \ref to an unlisted result (its rendered title)
}

export interface Book {
  chapters: Entry[];
  sectionsOf: Map<number, Entry[]>; // chapter id -> sections
  resultsOf: Map<number, Entry[]>; // section id -> results
  byTag: Map<string, Entry>;
  sectionById: Map<number, Entry>;
}

export interface Ctx {
  env: Env;
  db: D1Database;
  settings: Record<string, string>;
  macros: Macros;
  macroError?: string;
  book: Book;
}

/** Bump when the LaTeX renderer changes: all cached HTML is then re-rendered on the next request. */
export const RENDER_VERSION = "5";

export function typeName(t: string): string {
  return t.charAt(0).toUpperCase() + t.slice(1);
}

const macroCache = new Map<string, { macros: Macros; error?: string }>();
export function macrosFor(src: string): { macros: Macros; error?: string } {
  let m = macroCache.get(src);
  if (!m) {
    m = buildMacros(src);
    if (macroCache.size > 20) macroCache.clear();
    macroCache.set(src, m);
  }
  return m;
}

export async function loadSettings(db: D1Database): Promise<Record<string, string>> {
  const { results } = await db.prepare("SELECT key, value FROM settings").all<{ key: string; value: string }>();
  return Object.fromEntries(results.map((r) => [r.key, r.value]));
}

function appendixLetter(index: number): string {
  let letters = "";
  while (index > 0) {
    index--;
    letters = String.fromCharCode(65 + (index % 26)) + letters;
    index = Math.floor(index / 26);
  }
  return letters;
}

export async function loadBook(db: D1Database, includeHidden: boolean): Promise<Book> {
  const [secs, ress] = await db.batch([
    db.prepare("SELECT id, tag, parent_id, kind, title, position, appendix FROM sections ORDER BY position, id"),
    db.prepare("SELECT id, tag, type, title, section_id, position, visibility, state, listed FROM results ORDER BY position, id"),
  ]);
  const sections = secs.results as Pick<SectionRow, "id" | "tag" | "parent_id" | "kind" | "title" | "position" | "appendix">[];
  const results = ress.results as Pick<ResultRow, "id" | "tag" | "type" | "title" | "section_id" | "position" | "visibility" | "state" | "listed">[];

  const book: Book = { chapters: [], sectionsOf: new Map(), resultsOf: new Map(), byTag: new Map(), sectionById: new Map() };
  const chapters = sections.filter((s) => s.kind === "chapter").sort((a, b) => a.appendix - b.appendix);
  let chapterNo = 0;
  let appendixNo = 0;
  for (const ch of chapters) {
    const number = ch.appendix ? appendixLetter(++appendixNo) : String(++chapterNo);
    const chEntry: Entry = {
      tag: ch.tag, id: ch.id, kind: "chapter", number, label: `${ch.appendix ? "Appendix" : "Chapter"} ${number}`,
      title: ch.title, parentId: null, hidden: false, listed: true,
    };
    book.chapters.push(chEntry);
    book.byTag.set(ch.tag, chEntry);
    book.sectionById.set(ch.id, chEntry);
    const subs: Entry[] = [];
    let secNo = 0;
    for (const s of sections.filter((x) => x.kind === "section" && x.parent_id === ch.id)) {
      secNo++;
      const num = `${number}.${secNo}`;
      const e: Entry = { tag: s.tag, id: s.id, kind: "section", number: num, label: `Section ${num}`, title: s.title, parentId: ch.id, hidden: false, listed: true };
      subs.push(e);
      book.byTag.set(s.tag, e);
      book.sectionById.set(s.id, e);
      const rs: Entry[] = [];
      let k = 0;
      for (const r of results.filter((x) => x.section_id === s.id)) {
        const hidden = r.visibility !== "published" || r.state !== "active";
        if (hidden && !includeHidden) continue;
        const listed = r.listed !== 0;
        const n = !listed ? "" : hidden ? `${num}.?` : `${num}.${++k}`;
        const re: Entry = {
          tag: r.tag, id: r.id, kind: "result", number: n, label: n ? `${typeName(r.type)} ${n}` : typeName(r.type),
          title: r.title, type: r.type, parentId: s.id, hidden, listed,
        };
        // Unlisted results stay reachable by tag (links, knowls, their own page) but are only listed in the editor.
        if (listed || includeHidden) rs.push(re);
        book.byTag.set(r.tag, re);
      }
      book.resultsOf.set(s.id, rs);
    }
    book.sectionsOf.set(ch.id, subs);
  }
  return book;
}

export async function loadCtx(env: Env, includeHidden: boolean): Promise<Ctx> {
  const db = env.DB;
  const settings = await loadSettings(db);
  if (settings.render_version !== RENDER_VERSION) {
    // Renderer changed (new deploy): just drop the caches (cheap SQL); each page re-renders lazily on first view,
    // so no single request has to render the whole book.
    await db.batch([
      db.prepare("UPDATE results SET statement_html_cache = NULL"),
      db.prepare("UPDATE proofs SET body_html_cache = NULL"),
      db.prepare("UPDATE sections SET intro_html_cache = NULL"),
      db.prepare("INSERT INTO settings (key, value) VALUES ('render_version', ?) ON CONFLICT(key) DO UPDATE SET value = excluded.value").bind(RENDER_VERSION),
    ]);
    settings.render_version = RENDER_VERSION;
  }
  const { macros, error } = macrosFor(settings.macros ?? "");
  const book = await loadBook(db, includeHidden);
  const ctx: Ctx = { env, db, settings, macros, macroError: error, book };
  for (const e of book.byTag.values()) {
    if (!e.listed) e.refHtml = e.title ? titleHtml(ctx, e.title) : escapeHtml(e.label);
  }
  return ctx;
}

// OPEN tag [SEP text] CLOSE; the text (from \hyperref) is already rendered HTML.
const REF_PLACEHOLDER = new RegExp(`${REF_OPEN}([^${REF_SEP}${REF_CLOSE}]*)(?:${REF_SEP}([^${REF_CLOSE}]*))?${REF_CLOSE}`, "g");

/** Replace \ref placeholders by links labelled with the current numbers (or the \hyperref text). */
export function fillRefs(cached: string, book: Book): string {
  return cached.replace(REF_PLACEHOLDER, (_, tag: string, text: string | undefined) => {
    const e = book.byTag.get(tag);
    const t = escapeHtml(tag);
    if (!e) return `<span class="ref-broken" title="Unknown reference ${t}">${text ?? `??${t}`}</span>`;
    return `<a class="ref" href="/tag/${t}" data-tag="${t}">${text ?? e.refHtml ?? escapeHtml(e.label)}</a>`;
  });
}

/** Like fillRefs but plain text (for titles, which are often inside links already). */
export function labelRefs(cached: string, book: Book): string {
  return cached.replace(REF_PLACEHOLDER, (_, tag: string, text: string | undefined) =>
    text ?? escapeHtml(book.byTag.get(tag)?.label ?? `??${tag}`),
  );
}

const titleCache = new Map<string, string>();
export function titleHtml(ctx: Ctx, title: string): string {
  if (!title) return "";
  const key = (ctx.settings.macros ?? "") + "\u0000" + title;
  let h = titleCache.get(key);
  if (h === undefined) {
    h = renderInlineTex(title, ctx.macros);
    if (titleCache.size > 2000) titleCache.clear();
    titleCache.set(key, h);
  }
  return labelRefs(h, ctx.book);
}

/** Cached HTML for a result statement / proof / section intro, rendering and storing it if missing. */
export async function statementHtml(ctx: Ctx, r: Pick<ResultRow, "id" | "statement_tex" | "statement_html_cache">): Promise<string> {
  let c = r.statement_html_cache;
  if (c === null) {
    c = renderTex(r.statement_tex, ctx.macros).html;
    await ctx.db.prepare("UPDATE results SET statement_html_cache = ? WHERE id = ? AND statement_tex = ?").bind(c, r.id, r.statement_tex).run();
  }
  return fillRefs(c, ctx.book);
}
export async function proofHtml(ctx: Ctx, p: Pick<ProofRow, "id" | "body_tex" | "body_html_cache">): Promise<string> {
  let c = p.body_html_cache;
  if (c === null) {
    c = renderTex(p.body_tex, ctx.macros).html;
    await ctx.db.prepare("UPDATE proofs SET body_html_cache = ? WHERE id = ? AND body_tex = ?").bind(c, p.id, p.body_tex).run();
  }
  return fillRefs(c, ctx.book);
}
export async function introHtml(ctx: Ctx, s: Pick<SectionRow, "id" | "intro_tex" | "intro_html_cache">): Promise<string> {
  let c = s.intro_html_cache;
  if (c === null) {
    c = renderTex(s.intro_tex, ctx.macros).html;
    await ctx.db.prepare("UPDATE sections SET intro_html_cache = ? WHERE id = ? AND intro_tex = ?").bind(c, s.id, s.intro_tex).run();
  }
  return fillRefs(c, ctx.book);
}

/** Statements for building the refs rows of one result (statement + each proof). */
export function refInserts(db: D1Database, resultId: number, stmtRefs: string[], proofRefs: { proofId: number; refs: string[] }[]): D1PreparedStatement[] {
  const out: D1PreparedStatement[] = [];
  for (const t of new Set(stmtRefs)) {
    out.push(db.prepare("INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (?, NULL, ?)").bind(resultId, t));
  }
  for (const p of proofRefs) {
    for (const t of new Set(p.refs)) {
      out.push(db.prepare("INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (?, ?, ?)").bind(resultId, p.proofId, t));
    }
  }
  return out;
}

/** Re-render every cache and rebuild the whole reference graph (after seeding or on request). */
export async function rebuildAll(env: Env): Promise<{ results: number; proofs: number }> {
  const db = env.DB;
  const settings = await loadSettings(db);
  const { macros } = macrosFor(settings.macros ?? "");
  const [rs, ps, ss] = await db.batch([
    db.prepare("SELECT id, statement_tex FROM results"),
    db.prepare("SELECT id, result_id, body_tex FROM proofs"),
    db.prepare("SELECT id, intro_tex FROM sections"),
  ]);
  // Every write below only applies if the source text is still what we rendered, so a save that happens while
  // the rebuild runs is never overwritten with older HTML or references.
  const stmts: D1PreparedStatement[] = [];
  const stillR = "EXISTS (SELECT 1 FROM results WHERE id = ? AND statement_tex = ?)";
  const stillP = "EXISTS (SELECT 1 FROM proofs WHERE id = ? AND body_tex = ?)";
  for (const r of rs.results as { id: number; statement_tex: string }[]) {
    const out = renderTex(r.statement_tex, macros);
    const k = [r.id, r.statement_tex];
    stmts.push(db.prepare("UPDATE results SET statement_html_cache = ? WHERE id = ? AND statement_tex = ?").bind(out.html, ...k));
    stmts.push(db.prepare(`DELETE FROM refs WHERE source_result_id = ? AND source_proof_id IS NULL AND ${stillR}`).bind(r.id, ...k));
    for (const t of new Set(out.refs)) {
      stmts.push(db.prepare(`INSERT OR IGNORE INTO refs (source_result_id, source_proof_id, target_tag) SELECT ?, NULL, ? WHERE ${stillR}`).bind(r.id, t, ...k));
    }
  }
  for (const p of ps.results as { id: number; result_id: number; body_tex: string }[]) {
    const out = renderTex(p.body_tex, macros);
    const k = [p.id, p.body_tex];
    stmts.push(db.prepare("UPDATE proofs SET body_html_cache = ? WHERE id = ? AND body_tex = ?").bind(out.html, ...k));
    stmts.push(db.prepare(`DELETE FROM refs WHERE source_proof_id = ? AND ${stillP}`).bind(p.id, ...k));
    for (const t of new Set(out.refs)) {
      stmts.push(db.prepare(`INSERT OR IGNORE INTO refs (source_result_id, source_proof_id, target_tag) SELECT ?, ?, ? WHERE ${stillP}`).bind(p.result_id, p.id, t, ...k));
    }
  }
  for (const s of ss.results as { id: number; intro_tex: string }[]) {
    stmts.push(db.prepare("UPDATE sections SET intro_html_cache = ? WHERE id = ? AND intro_tex = ?").bind(renderTex(s.intro_tex, macros).html, s.id, s.intro_tex));
  }
  if (stmts.length) await db.batch(stmts);
  return { results: rs.results.length, proofs: ps.results.length };
}
