import assert from "node:assert/strict";
import { test } from "node:test";
import { loadBook, type Ctx, type Entry } from "../src/book.ts";
import { findRefTargets, renderTex } from "../src/latex.ts";
import { previewTex, saveResult, saveUnderstanding } from "../src/store.ts";
import type { ProofRow, ResultRow, SectionRow } from "../src/types.ts";
import { chapterPage, homePage, knowlResult, knowlSection, resultPage, sectionPage } from "../src/views/reader.ts";

const tag = "8JT2";
const entry: Entry = {
  id: 1, tag, kind: "result", number: "1.1.1", label: "Lemma 1.1.1", title: "A result",
  parentId: 2, hidden: false, listed: true,
};
const section: SectionRow = {
  id: 2, tag: "SEC1", kind: "section", parent_id: 3, appendix: 0, title: "A section", position: 1,
  intro_tex: "", intro_html_cache: "<p>The introduction.</p>", revision: 1, updated_at: "", updated_by: null,
};
const sectionEntry: Entry = {
  id: section.id, tag: section.tag, kind: "section", parentId: section.parent_id,
  number: "1.1", label: "Section 1.1", title: section.title, hidden: false, listed: true,
};
const result: ResultRow = {
  id: 1, tag, type: "lemma", title: entry.title, statement_tex: "", statement_html_cache: "<p>The statement.</p>",
  section_id: 2, position: 1, visibility: "published", state: "active", listed: 1,
  understanding: "unclear", replaced_by_id: null, revision: 1, updated_at: "", updated_by: null,
};
const proof: ProofRow = {
  id: 1, result_id: result.id, position: 1, body_tex: "", body_html_cache: "<p>The proof.</p>",
  status: "ai_generated", understanding: "unclear", generated_by: "claude", generator_detail: null,
  reviewed_by: "Editor", review_notes: null, visibility: "published", revision: 1, updated_at: "",
};

function context(fold_drafts?: string): Ctx {
  return {
    env: {} as Ctx["env"], db: {} as D1Database, settings: fold_drafts === undefined ? {} : { fold_drafts }, macros: {},
    book: {
      chapters: [], sectionsOf: new Map(), resultsOf: new Map(),
      byTag: new Map([[tag, entry], [section.tag, sectionEntry]]), sectionById: new Map([[section.id, sectionEntry]]),
    },
  };
}

test("unclear renders a block with math, paragraphs, lists and public references", () => {
  const tex = String.raw`a \begin{unclear}[secret note \ref{8JA9}] b $x$

\begin{itemize}\item See \ref{8JT2}.\end{itemize}
\end{unclear} c`;
  const rendered = renderTex(tex, {});
  assert.deepEqual(rendered.warnings, []);
  assert.equal((rendered.html.match(/<details class="draft-block">/g) ?? []).length, 1);
  assert.match(rendered.html, /^<p>a<\/p>\s*<details[\s\S]*?<math[\s\S]*?<mi>x<\/mi>[\s\S]*?<ul>[\s\S]*?<\/details>\s*<p>c<\/p>$/);
  assert.doesNotMatch(rendered.html, /secret note|8JA9/);
  assert.deepEqual(rendered.refs, [tag]);
  assert.deepEqual(findRefTargets(tex).map(({ target }) => target), [tag]);

  const preview = previewTex(tex, { aliasToTag: new Map(), tags: new Set([tag]) }, "");
  assert.match(preview.html, /<details class="draft-block" open><summary>.*secret note/);
  assert.deepEqual(preview.warnings, []);
});

test("an unfinished unclear environment keeps its note out of public output", () => {
  const tex = String.raw`Before \begin{unclear}[secret {note with ] inside}] body`;
  const rendered = renderTex(tex, {});
  assert.doesNotMatch(rendered.html, /secret/);
  assert.match(rendered.html, /body/);
});

test("removing the draft note preserves a bracketed start to its body", () => {
  const tex = String.raw`\begin{unclear}% a comment
[secret note][public text] body\end{unclear}`;
  const rendered = renderTex(tex, {});
  assert.deepEqual(rendered.warnings, []);
  assert.doesNotMatch(rendered.html, /secret note/);
  assert.match(rendered.html, /<p>\[public text\] body<\/p>/);
});

test("section folds and contents hide drafts without changing result numbers", async () => {
  const results: ResultRow[] = [
    { ...result, id: 4, tag: "8JT1", position: 1, understanding: "clear" },
    { ...result, position: 2 },
    { ...result, id: 5, tag: "8JT3", position: 3, understanding: "partial" },
  ];
  const sections = [{ ...section, id: 3, tag: "CH01", kind: "chapter", parent_id: null }, section];
  const db = {
    prepare: (sql: string) => ({ results: sql.includes("FROM sections") ? sections : results }),
    batch: async (statements: unknown[]) => statements,
  } as unknown as D1Database;
  const book = await loadBook(db, false);
  const on = { ...context("1"), book };
  const page = await sectionPage(on, section, results, new Map());
  const [first, draft, third] = page.match(/<article\b[\s\S]*?<\/article>/g) ?? [];
  assert.match(page, /<div id="page-folds">[\s\S]*?Expand all[\s\S]*?Collapse all[\s\S]*?<details class="intro-fold">[\s\S]*?<\/details>\s*<article/);
  assert.match(first, /<article class="result type-lemma" id="8JT1" data-tag="8JT1">/);
  assert.match(first, /<details class="draft-result"><summary[^>]*>[\s\S]*?Lemma 1\.1\.1[\s\S]*?class="tag-link" href="\/tag\/8JT1"/);
  assert.match(third, /<details class="draft-result"><summary[^>]*>[\s\S]*?Lemma 1\.1\.3/);
  assert.doesNotMatch(first + third, /draft-hidden|draft-marker/);
  assert.match(draft, /<article class="result type-lemma draft-hidden" id="8JT2" data-tag="8JT2">/);
  assert.match(draft, /<details class="draft-result"><summary[^>]*>[\s\S]*?Lemma 1\.1\.2[\s\S]*?class="draft-marker">draft<\/span><\/summary>[\s\S]*?The statement\./);
  assert.doesNotMatch(page, /unclear|partial|clear/);

  const home = homePage(on);
  assert.match(home, /<li><a href="\/tag\/SEC1#8JT1"><span class="result-label">Lemma 1\.1\.1<\/span>/);
  assert.match(home, /<li class="draft-hidden"><a href="\/tag\/SEC1#8JT2"><span class="result-label">Lemma 1\.1\.2<\/span>/);
  assert.match(home, /<li><a href="\/tag\/SEC1#8JT3"><span class="result-label">Lemma 1\.1\.3<\/span>/);

  for (const setting of [undefined, "0", "true"]) {
    const off = { ...context(setting), book };
    const page = await sectionPage(off, section, results, new Map());
    assert.doesNotMatch(page + homePage(off), /draft-result|draft-hidden|draft-marker|intro-fold|fold-controls|Show drafts/);
    assert.match(page, /<article class="result type-lemma" id="8JT2" data-tag="8JT2">\s*<header/);
    assert.match(homePage(off), /<li><a href="\/tag\/SEC1#8JT2">/);
  }
});

test("chapter and section introductions fold in page views and stay open in knowls", async () => {
  const tex = String.raw`The introduction. \begin{unclear}[private note]A draft passage.\end{unclear}`;
  const intro = { ...section, intro_tex: tex, intro_html_cache: renderTex(tex, {}).html };
  const chapter: SectionRow = { ...intro, id: 3, tag: "CH01", kind: "chapter", parent_id: null };
  const on = context("1");
  const off = context("0");
  for (const ctx of [on, off]) {
    ctx.book.byTag.set(chapter.tag, {
      ...sectionEntry, id: chapter.id, tag: chapter.tag, kind: "chapter", parentId: null, number: "1", label: "Chapter 1",
    });
  }

  for (const page of [await sectionPage(on, intro, [], new Map()), await chapterPage(on, chapter)]) {
    assert.match(page, /data-fold-action="expand">Expand all/);
    assert.match(page, /data-fold-action="collapse">Collapse all/);
    assert.match(page, /<details class="intro-fold"><summary>Introduction<\/summary><div class="intro"><p>The introduction\.\s*<\/p>/);
    assert.match(page, /<details class="draft-block">/);
    assert.doesNotMatch(page, /private note/);
  }

  for (const page of [await sectionPage(off, intro, [], new Map()), await chapterPage(off, chapter)]) {
    assert.match(page, /<div class="intro"><p>The introduction\./);
    assert.match(page, /<details class="draft-block" open>/);
    assert.doesNotMatch(page, /intro-fold|fold-controls/);
  }

  const knowl = await knowlSection(on, intro);
  assert.match(knowl, /<div class="statement"><p>The introduction\./);
  assert.match(knowl, /<details class="draft-block">/);
  assert.doesNotMatch(knowl, /intro-fold|fold-controls|private note/);

  const empty = await sectionPage(on, { ...section, intro_html_cache: "" }, [], new Map());
  assert.doesNotMatch(empty, /intro-fold|fold-controls/);
});

test("result pages and knowls show the statement while draft proofs stay folded", async () => {
  const proofs = [proof, { ...proof, id: 2, understanding: "clear" as const }];
  const on = context("1");
  const page = await resultPage(on, result, proofs, [], [], []);
  assert.match(page, /Show drafts/);
  assert.doesNotMatch(page, /view in context|draft-hidden/);
  assert.match(page, /<p class="draft-banner">This is still a rough draft and may not read smoothly\.<\/p>\s*<div class="statement">/);
  assert.match(page, /<details class="proof draft-proof"><summary><span class="proof-label">Proof 1 \(draft\)\./);
  assert.match(page, /<section class="proof"><div class="proof-head"><span class="proof-label">Proof 2\./);
  const knowl = await knowlResult(on, result, proofs);
  assert.match(knowl, /draft-banner/);
  assert.match(knowl, /<details class="proof draft-proof">/);
  for (const readerHtml of [page, knowl]) {
    assert.doesNotMatch(readerHtml, /draft-result|badge-|written by|Claude|reviewed by|🤖|🛠|✅|understanding_note/);
  }
});

test("result pages keep the context link for visible results", async () => {
  for (const [ctx, row] of [[context(), result], [context("1"), { ...result, understanding: "clear" }]] as const) {
    const page = await resultPage(ctx, row, [], [], [], []);
    assert.match(page, /<a href="\/tag\/SEC1#8JT2">view in context<\/a>/);
    assert.doesNotMatch(page, /draft-banner/);
  }
});

test("reader opens cached unclear blocks at serve time with folding off", async () => {
  const cached = renderTex(String.raw`\begin{unclear}[private note]\ref{8JT2}\end{unclear}`, {}).html;
  const row = { ...result, statement_html_cache: cached };
  const off = await resultPage(context(), row, [proof], [], [], []);
  const on = await resultPage(context("1"), row, [proof], [], [], []);
  assert.match(off, /<body class="drafts-unfolded">/);
  assert.match(off, /<details class="draft-block" open>/);
  assert.match(off, /<section class="proof">/);
  assert.match(on, /<details class="draft-block">/);
  assert.doesNotMatch(off + on, /private note/);
  assert.match(on, /<a class="ref" href="\/tag\/8JT2"/);
});

test("proof-part paragraphs around an unclear block remain separate", () => {
  const rendered = renderTex(String.raw`\emph{(i)} First.

\begin{unclear}\emph{(iii)} A marker inside the block.\end{unclear}

\emph{(ii)} Second.`, {});
  assert.deepEqual(rendered.warnings, []);
  assert.match(rendered.html, /^<p><em>\(i\)<\/em> First\.<\/p>\s*<details[\s\S]*<p><em>\(iii\)<\/em>[\s\S]*<\/details>\s*<p><em>\(ii\)<\/em> Second\.<\/p>$/);
});

test("the store rejects invalid result, proof and dashboard understanding levels", async () => {
  const db = {
    prepare(sql: string) {
      assert.equal(sql, "SELECT * FROM results WHERE tag = ?");
      return { bind: () => ({ first: async () => result }) };
    },
  } as unknown as D1Database;
  const fields = { revision: 1, type: "lemma", section_id: 2 };
  await assert.rejects(saveResult(db, "editor", tag, { ...fields, understanding: "verified" }), /Invalid understanding/);
  await assert.rejects(saveResult(db, "editor", tag, {
    ...fields, proofs: [{ ...proof, understanding: "verified" }],
  }), /Invalid proof understanding/);
  await assert.rejects(saveUnderstanding(db, { tag, level: "verified" }), /Invalid understanding/);
});
