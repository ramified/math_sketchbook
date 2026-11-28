import { html, raw, type SafeHtml } from "../html.ts";
import { type Ctx, type Entry, titleHtml, statementHtml, proofHtml, introHtml, readerHtml } from "../book.ts";
import type { ProofRow, ResultRow, SectionRow } from "../types.ts";
import { parseBibliography, renderTex, stripDraftNotes } from "../latex.ts";
import { layout } from "./layout.ts";

function page(ctx: Ctx, title: string, body: SafeHtml): string {
  const bookTitle = ctx.settings.book_title ?? "Notes";
  return layout({
    title: title ? `${stripDraftNotes(title)} — ${bookTitle}` : bookTitle, bookTitle, body,
    foldDrafts: ctx.settings.fold_drafts === "1",
  });
}

export function entryHeading(ctx: Ctx, e: Entry): SafeHtml {
  const t = titleHtml(ctx, e.title);
  return html`<span class="result-label">${e.label}</span>${t ? html` <span class="result-title">(${raw(t)})</span>` : ""}`;
}

/** One result with its statement and proofs, in a section, on its own page, or in a knowl. */
export async function resultBlock(ctx: Ctx, r: ResultRow, proofs: ProofRow[], place: "section" | "page" | "knowl" = "section"): Promise<SafeHtml> {
  const e = ctx.book.byTag.get(r.tag);
  if (!e) return html``;
  const statement = await statementHtml(ctx, r);
  const fold = ctx.settings.fold_drafts === "1";
  const draft = fold && r.understanding === "unclear";
  const sectionFold = fold && place === "section";
  const proofParts: SafeHtml[] = [];
  let i = 0;
  for (const p of proofs) {
    i++;
    const label = proofs.length > 1 ? `Proof ${i}` : "Proof";
    const body = await proofHtml(ctx, p);
    const draftProof = fold && p.understanding === "unclear";
    const head = html`<span class="proof-label">${label}${draftProof ? " (draft)" : ""}.</span>`;
    const content = html`<div class="proof-body">${raw(body)}<span class="qed" aria-label="end of proof">∎</span></div>`;
    proofParts.push(
      draftProof || place !== "page"
        ? html`<details class="proof${draftProof ? " draft-proof" : ""}"><summary>${head}</summary>${content}</details>`
        : html`<section class="proof"><div class="proof-head">${head}</div>${content}</section>`,
    );
  }
  const heading = entryHeading(ctx, e);
  const headingLabel = sectionFold
    ? html`<span class="result-heading">${heading}</span>`
    : place === "knowl" ? heading : html`<a class="result-link" href="/tag/${r.tag}">${heading}</a>`;
  const headingContent = html`
    ${headingLabel}
    <a class="tag-link" href="/tag/${r.tag}" title="Permanent link">${r.tag}</a>
  `;
  const content = html`<div class="statement">${raw(statement)}</div>${proofParts}`;
  return html`<article class="result type-${r.type}${sectionFold && draft ? " draft-hidden" : ""}"${place === "knowl" ? "" : html` id="${r.tag}"`} data-tag="${r.tag}">
  ${sectionFold
    ? html`<details class="draft-result"><summary class="result-head">${headingContent}${draft ? html`<span class="draft-marker">draft</span>` : ""}</summary>${content}</details>`
    : html`<header class="result-head">${headingContent}</header>
      ${draft ? html`<p class="draft-banner">This is still a rough draft and may not read smoothly.</p>` : ""}
      ${content}`}
</article>`;
}

export function homePage(ctx: Ctx): string {
  const fold = ctx.settings.fold_drafts === "1";
  const toc = ctx.book.chapters.map(
    (ch) => html`<li class="toc-chapter">
  <a href="/tag/${ch.tag}"><span class="num">${ch.number}</span> ${raw(titleHtml(ctx, ch.title))}</a>
  <ol>${(ctx.book.sectionsOf.get(ch.id) ?? []).map(
    (s) => html`<li class="toc-section"><a href="/tag/${s.tag}"><span class="num">${s.number}</span> ${raw(titleHtml(ctx, s.title))}</a>
      <ul class="toc-results">${(ctx.book.resultsOf.get(s.id) ?? []).map(
        (r) => html`<li${fold && r.understanding === "unclear" ? html` class="draft-hidden"` : ""}><a href="/tag/${s.tag}#${r.tag}">${entryHeading(ctx, r)}</a></li>`,
      )}</ul></li>`,
  )}</ol></li>`,
  );
  return page(ctx, "", html`<h1>${ctx.settings.book_title ?? "Notes"}</h1>
<p class="lede">Click any reference (like “Lemma 1.1.2”) to expand it in place. Click it again, or press ×, to collapse it. Hover over a result, a displayed formula or a figure and press the pin to keep it in the pinboard beside the text.</p>
<nav class="toc" aria-label="Table of contents"><ol>${toc}</ol></nav>`);
}

function breadcrumb(ctx: Ctx, e: Entry): SafeHtml {
  const parts: SafeHtml[] = [html`<a href="/">Contents</a>`];
  const chain: Entry[] = [];
  let cur: Entry | undefined = e.parentId !== null ? ctx.book.sectionById.get(e.parentId) : undefined;
  while (cur) {
    chain.unshift(cur);
    cur = cur.parentId !== null ? ctx.book.sectionById.get(cur.parentId) : undefined;
  }
  for (const c of chain) parts.push(html`<a href="/tag/${c.tag}">${c.number} ${raw(titleHtml(ctx, c.title))}</a>`);
  return html`<nav class="breadcrumb">${parts.map((p, i) => (i ? html` › ${p}` : p))}</nav>`;
}

function pageIntroAndResults(ctx: Ctx, intro: string, results: SafeHtml[] = []): SafeHtml {
  const introBody = html`<div class="intro">${raw(intro)}</div>`;
  const hasIntro = intro.trim() !== "";
  if (ctx.settings.fold_drafts !== "1" || (!hasIntro && !results.length)) {
    return html`${introBody}
${results}`;
  }
  return html`<div id="page-folds">
  <div class="fold-controls">
    <button type="button" data-fold-action="expand">Expand all</button>
    <button type="button" data-fold-action="collapse">Collapse all</button>
  </div>
  ${hasIntro ? html`<details class="intro-fold"><summary>Introduction</summary>${introBody}</details>` : ""}
  ${results}
</div>`;
}

export async function chapterPage(ctx: Ctx, ch: SectionRow): Promise<string> {
  const e = ctx.book.byTag.get(ch.tag)!;
  const intro = await introHtml(ctx, ch);
  const secs = ctx.book.sectionsOf.get(ch.id) ?? [];
  return page(ctx, e.label, html`${breadcrumb(ctx, e)}
<h1><span class="num">${e.label}</span> ${raw(titleHtml(ctx, ch.title))} <a class="tag-link" href="/tag/${ch.tag}">${ch.tag}</a></h1>
${pageIntroAndResults(ctx, intro)}
<ol class="section-list">${secs.map((s) => html`<li><a href="/tag/${s.tag}"><span class="num">${s.number}</span> ${raw(titleHtml(ctx, s.title))}</a></li>`)}</ol>`);
}

export async function sectionPage(ctx: Ctx, s: SectionRow, results: ResultRow[], proofsBy: Map<number, ProofRow[]>): Promise<string> {
  const e = ctx.book.byTag.get(s.tag)!;
  const intro = await introHtml(ctx, s);
  const blocks: SafeHtml[] = [];
  for (const r of results) if (ctx.book.byTag.has(r.tag)) blocks.push(await resultBlock(ctx, r, proofsBy.get(r.id) ?? []));
  // previous / next section across the whole book
  const all = ctx.book.chapters.flatMap((c) => ctx.book.sectionsOf.get(c.id) ?? []);
  const idx = all.findIndex((x) => x.id === s.id);
  const prev = all[idx - 1];
  const next = all[idx + 1];
  return page(ctx, `${e.number} ${s.title}`, html`${breadcrumb(ctx, e)}
<h1><span class="num">${e.number}</span> ${raw(titleHtml(ctx, s.title))} <a class="tag-link" href="/tag/${s.tag}">${s.tag}</a></h1>
${pageIntroAndResults(ctx, intro, blocks)}
<nav class="prevnext">
  ${prev ? html`<a href="/tag/${prev.tag}">← ${prev.number} ${raw(titleHtml(ctx, prev.title))}</a>` : html`<span></span>`}
  ${next ? html`<a href="/tag/${next.tag}">${next.number} ${raw(titleHtml(ctx, next.title))} →</a>` : html`<span></span>`}
</nav>`);
}

export async function resultPage(
  ctx: Ctx, r: ResultRow, proofs: ProofRow[], usesTags: string[], usedByTags: string[], aliases: string[],
): Promise<string> {
  const e = ctx.book.byTag.get(r.tag)!;
  const section = ctx.book.sectionById.get(r.section_id);
  const inContext = section && e.listed && !(ctx.settings.fold_drafts === "1" && r.understanding === "unclear");
  const list = (tags: string[]) =>
    tags.length
      ? html`<ul class="dep-list">${tags.map((t) => {
          const d = ctx.book.byTag.get(t);
          return d ? html`<li><a class="ref" href="/tag/${t}" data-tag="${t}">${d.label}</a>${d.title ? html` (${raw(titleHtml(ctx, d.title))})` : ""}</li>` : html`<li class="ref-broken">??${t}</li>`;
        })}</ul>`
      : html`<p class="muted">None.</p>`;
  return page(ctx, e.listed || !e.title ? e.label : `${e.label}: ${e.title}`, html`${breadcrumb(ctx, e)}
${await resultBlock(ctx, r, proofs, "page")}
<div class="result-meta">
  <p>Permanent link: <code>/tag/${r.tag}</code>${aliases.length ? html` · also <code>${aliases.join(", ")}</code>` : ""}
   · ${inContext ? html`<a href="/tag/${section.tag}#${r.tag}">view in context</a> · ` : ""}<a href="/edit/result/${r.tag}">edit</a></p>
  <div class="deps"><div><h2>Uses</h2>${list(usesTags)}</div><div><h2>Used by</h2>${list(usedByTags)}</div></div>
</div>`);
}

export function retiredPage(ctx: Ctx, r: ResultRow, replacement: string | null): string {
  return page(ctx, r.tag, html`<h1>Tag ${r.tag}</h1><p>This result has been retired.${replacement ? html` It was replaced by <a href="/tag/${replacement}">${replacement}</a>.` : ""}</p>`);
}

export function notFoundPage(ctx: Ctx, what: string): string {
  return page(ctx, "Not found", html`<h1>Not found</h1><p>${what}</p><p><a href="/">Back to contents</a></p>`);
}

export function bibliographyPage(ctx: Ctx): string {
  const items = parseBibliography(stripDraftNotes(ctx.settings.bibliography ?? ""));
  return page(ctx, "Bibliography", html`<h1>Bibliography</h1>
<dl class="bibliography">${items.map((it) => html`<dt id="cite-${it.key}">[${it.key}]</dt><dd>${raw(readerHtml(ctx, renderTex(it.tex, ctx.macros).html))}</dd>`)}</dl>`);
}

/** HTML fragment returned to the knowl script. */
export async function knowlResult(ctx: Ctx, r: ResultRow, proofs: ProofRow[]): Promise<string> {
  return (await resultBlock(ctx, r, proofs, "knowl")).value;
}

export async function knowlSection(ctx: Ctx, s: SectionRow): Promise<string> {
  const e = ctx.book.byTag.get(s.tag)!;
  const intro = await introHtml(ctx, s);
  const children = s.kind === "chapter" ? ctx.book.sectionsOf.get(s.id) ?? [] : ctx.book.resultsOf.get(s.id) ?? [];
  return html`<article class="result" data-tag="${s.tag}">
<header class="result-head"><span class="result-label">${e.label}</span> <span class="result-title">${raw(titleHtml(ctx, s.title))}</span></header>
<div class="statement">${raw(intro)}</div>
<ul class="dep-list">${children.map((c) => html`<li><a class="ref" href="/tag/${c.tag}" data-tag="${c.tag}">${c.label}</a>${c.title ? html` ${raw(titleHtml(ctx, c.title))}` : ""}</li>`)}</ul>
</article>`.value;
}
