import { html, raw, type SafeHtml } from "../html.ts";
import { type Ctx, titleHtml } from "../book.ts";
import { RESULT_TYPES, PROOF_STATUSES, GENERATORS, STATUS_BADGES, type ProofRow, type ResultRow, type SectionRow, type User } from "../types.ts";
import { layout } from "./layout.ts";

function page(ctx: Ctx, title: string, body: SafeHtml): string {
  return layout({ title: `${title} — editor`, bookTitle: ctx.settings.book_title ?? "Notes", body, editor: true });
}

/** Embed data for editor.js safely inside a <script type="application/json">. */
function jsonScript(id: string, data: unknown): SafeHtml {
  const s = JSON.stringify(data).replace(/</g, "\\u003c").replace(/>/g, "\\u003e").replace(/&/g, "\\u0026");
  return raw(`<script type="application/json" id="${id}">${s}</script>`);
}

function options<T extends string | number>(items: readonly { value: T; label: string }[], selected: T | undefined): SafeHtml[] {
  return items.map((i) => html`<option value="${i.value}"${i.value === selected ? raw(" selected") : ""}>${i.label}</option>`);
}

function texPair(name: string, value: string, rows = 8, label = ""): SafeHtml {
  return html`<div class="tex-pair">
  <label class="tex-label">${label}</label>
  <textarea name="${name}" rows="${rows}" spellcheck="false" data-preview>${value}</textarea>
  <div class="preview" aria-live="polite"></div>
  <ul class="preview-warnings"></ul>
</div>`;
}

export function dashboardPage(ctx: Ctx, user: User): string {
  const typeOpts = options(RESULT_TYPES.map((t) => ({ value: t, label: t })), "lemma");
  const chapters = ctx.book.chapters.map(
    (ch) => html`<li class="toc-chapter">
  <span class="num">${ch.number}</span> ${raw(titleHtml(ctx, ch.title))} <a class="edit-link" href="/edit/section/${ch.tag}">edit</a>
  <ol>${(ctx.book.sectionsOf.get(ch.id) ?? []).map(
    (s) => html`<li class="toc-section"><span class="num">${s.number}</span> ${raw(titleHtml(ctx, s.title))} <a class="edit-link" href="/edit/section/${s.tag}">edit</a>
    <ul class="toc-results">${(ctx.book.resultsOf.get(s.id) ?? []).map(
      (r) => html`<li><a href="/edit/result/${r.tag}">${r.label}${r.title ? html` (${raw(titleHtml(ctx, r.title))})` : ""}</a> <code>${r.tag}</code>${r.hidden ? html` <em>(hidden)</em>` : ""}${r.listed ? "" : html` <em>(unlisted)</em>`}</li>`,
    )}</ul>
    <form class="inline-form" data-create="/api/edit/new-result">
      <input type="hidden" name="section_id" value="${s.id}">
      <select name="type" aria-label="type">${typeOpts}</select> <button type="submit">+ New result here</button>
    </form></li>`,
  )}</ol>
  <form class="inline-form" data-create="/api/edit/new-section">
    <input type="hidden" name="kind" value="section"><input type="hidden" name="parent_id" value="${ch.id}">
    <input name="title" placeholder="New section title" aria-label="New section title"> <button type="submit">+ New section</button>
  </form></li>`,
  );
  return page(ctx, "Editor", html`<h1>Editor</h1>
<p>Logged in as <strong>${user.email}</strong> (${user.role}). Saving publishes immediately; every save is kept in the history.</p>
<form method="post" action="/logout" class="inline-form"><button type="submit">Log out</button></form>
<p><a href="/edit/settings">Book title, macros &amp; bibliography</a></p>
${ctx.macroError ? html`<p class="warning">Macro file error: ${ctx.macroError}</p>` : ""}
<nav class="toc edit-toc"><ol>${chapters}</ol></nav>
<form class="inline-form" data-create="/api/edit/new-section">
  <input type="hidden" name="kind" value="chapter">
  <input name="title" placeholder="New chapter title" aria-label="New chapter title"> <button type="submit">+ New chapter</button>
</form>`);
}

export interface RestoreInfo {
  revisionId: number;
  revision: number;
  entity: "result" | "proof";
  snapshot: Record<string, unknown>;
  proofId?: number;
}

export function resultEditPage(ctx: Ctx, r: ResultRow, proofs: ProofRow[], aliases: string[], restore: RestoreInfo | null): string {
  const e = ctx.book.byTag.get(r.tag);
  // restore = pre-fill the form from an old revision (nothing is saved until you press Save)
  let type = r.type, title = r.title, statement = r.statement_tex;
  const proofForms: { p: Partial<ProofRow>; restored?: boolean }[] = proofs.map((p) => ({ p }));
  if (restore?.entity === "result") {
    const s = restore.snapshot;
    type = (s.type as ResultRow["type"]) ?? type;
    title = (s.title as string) ?? title;
    statement = (s.statement_tex as string) ?? statement;
  } else if (restore?.entity === "proof") {
    const s = restore.snapshot as Partial<ProofRow>;
    const restored = {
      body_tex: s.body_tex ?? "", status: s.status ?? "polishing", generated_by: s.generated_by ?? "human",
      generator_detail: s.generator_detail ?? null, reviewed_by: s.reviewed_by ?? null, review_notes: s.review_notes ?? null,
    };
    const i = proofForms.findIndex((f) => f.p.id === restore.proofId);
    if (i >= 0) proofForms[i] = { p: { ...proofForms[i].p, ...restored }, restored: true };
    else proofForms.push({ p: restored, restored: true });
  }

  const sections = ctx.book.chapters.flatMap((c) => ctx.book.sectionsOf.get(c.id) ?? []).map((s) => ({
    id: s.id,
    label: `${s.number} ${s.title}`,
    results: (ctx.book.resultsOf.get(s.id) ?? []).map((x) => ({ id: x.id, label: x.label + (x.title ? ` (${x.title})` : "") })),
  }));

  return page(ctx, `Edit ${r.tag}`, html`
<p class="breadcrumb"><a href="/edit">Editor</a> › ${e?.label ?? r.tag} <code>${r.tag}</code>
 · <a href="/tag/${r.tag}" target="_blank" rel="noopener">public page ↗</a> · <a href="/edit/history/${r.tag}">history</a></p>
${restore ? html`<p class="notice">Form pre-filled from revision ${restore.revision} (${restore.entity}). Review it, then press <strong>Save &amp; publish</strong> to restore — or <a href="/edit/result/${r.tag}">discard</a>.</p>` : ""}
${jsonScript("sections-data", sections)}
<form id="edit-form" data-save-url="/api/edit/result/${r.tag}" data-public-url="/tag/${r.tag}">
  <input type="hidden" name="revision" value="${r.revision}">
  <div class="meta-grid">
    <label>Type <select name="type">${options(RESULT_TYPES.map((t) => ({ value: t, label: t })), type)}</select></label>
    <label>Title <input name="title" value="${title}" placeholder="optional, LaTeX allowed"></label>
    <label>Section <select name="section_id" data-current="${r.section_id}">${options(sections.map((s) => ({ value: s.id, label: s.label })), r.section_id)}</select></label>
    <label>Position <select name="place_after" data-self="${r.id}"><option value="keep">(keep current position)</option></select></label>
    <label class="span2 checkbox"><input type="checkbox" name="listed"${r.listed ? raw(" checked") : ""}> Listed in its section and numbered
      <small>Untick for a small definition that readers reach only by clicking a link, e.g. <code>\\hyperref[TAG]{Dirichlet character}</code>.</small></label>
    <label class="span2">Readable aliases <input name="aliases" value="${aliases.join(", ")}" placeholder="e.g. dirichlet-orthogonality (comma separated)">
      <small>Write <code>\\ref{alias}</code> anywhere; on save it is replaced by <code>\\ref{TAG}</code>. To link your own words, write <code>\\hyperref[alias]{words}</code>.</small></label>
  </div>
  ${texPair("statement_tex", statement, 8, "Statement")}
  <h2>Proofs</h2>
  <div id="proofs">${proofForms.map((f) => proofFieldset(f.p, f.restored))}</div>
  <button type="button" id="add-proof">+ Add proof</button>
  <template id="proof-template">${proofFieldset({ status: "polishing", generated_by: "human" })}</template>
  <div class="save-bar">
    <button type="submit" class="primary">Save &amp; publish</button> <span id="save-status" role="status"></span>
    <small>Ctrl+S also saves.</small>
  </div>
  <ul id="save-warnings" class="warnings"></ul>
</form>`);
}

function proofFieldset(p: Partial<ProofRow>, restored = false): SafeHtml {
  return html`<fieldset class="proof-edit${restored ? " restored" : ""}"${p.id ? raw(` data-id="${p.id}" data-revision="${p.revision}"`) : ""}>
  <legend>Proof ${p.id ? html`<small>#${p.id}</small>` : html`<small>(new)</small>`}</legend>
  <div class="meta-grid">
    <label>Status <select name="status">${options(PROOF_STATUSES.map((s) => ({ value: s, label: STATUS_BADGES[s] })), p.status)}</select></label>
    <label>Written by <select name="generated_by">${options(GENERATORS.map((g) => ({ value: g, label: g })), p.generated_by)}</select></label>
    <label>Generator detail <input name="generator_detail" value="${p.generator_detail ?? ""}" placeholder="e.g. model name"></label>
    <label>Reviewed by <input name="reviewed_by" value="${p.reviewed_by ?? ""}"></label>
  </div>
  ${texPair("body_tex", p.body_tex ?? "", 10, "Proof")}
  <label>Review notes (not shown publicly) <textarea name="review_notes" rows="2">${p.review_notes ?? ""}</textarea></label>
  <div class="proof-actions">
    <button type="button" data-move="-1">↑</button> <button type="button" data-move="1">↓</button>
    <button type="button" class="danger" data-remove>Remove this proof</button>
  </div>
</fieldset>`;
}

export function sectionEditPage(ctx: Ctx, s: SectionRow): string {
  const chapters = ctx.book.chapters;
  const siblings = s.kind === "chapter" ? chapters : ctx.book.sectionsOf.get(s.parent_id ?? -1) ?? [];
  const e = ctx.book.byTag.get(s.tag);
  return page(ctx, `Edit ${s.tag}`, html`
<p class="breadcrumb"><a href="/edit">Editor</a> › ${e?.label ?? s.tag} <code>${s.tag}</code> · <a href="/tag/${s.tag}" target="_blank" rel="noopener">public page ↗</a></p>
<form id="edit-form" data-save-url="/api/edit/section/${s.tag}" data-public-url="/tag/${s.tag}">
  <input type="hidden" name="revision" value="${s.revision}">
  <div class="meta-grid">
    <label class="span2">Title <input name="title" value="${s.title}"></label>
    ${s.kind === "section" ? html`<label>Chapter <select name="parent_id">${options(chapters.map((c) => ({ value: c.id, label: `${c.number} ${c.title}` })), s.parent_id ?? undefined)}</select></label>` : ""}
    <label>Position <select name="place_after_static">
      <option value="keep">(keep current position)</option><option value="start">At the beginning</option>
      ${siblings.filter((x) => x.id !== s.id).map((x) => html`<option value="${x.id}">After ${x.number} ${x.title}</option>`)}
    </select></label>
  </div>
  ${texPair("intro_tex", s.intro_tex, 6, "Introduction")}
  <div class="save-bar"><button type="submit" class="primary">Save &amp; publish</button> <span id="save-status" role="status"></span></div>
  <ul id="save-warnings" class="warnings"></ul>
</form>`);
}

export function settingsPage(ctx: Ctx, rows: { key: string; value: string; revision: number }[]): string {
  const get = (k: string) => rows.find((r) => r.key === k) ?? { key: k, value: "", revision: 1 };
  const form = (key: string, label: string, field: SafeHtml, help: SafeHtml | string = "") => html`
<form class="setting-form" data-save-url="/api/edit/setting" data-key="${key}">
  <input type="hidden" name="revision" value="${get(key).revision}">
  <h2>${label}</h2>${help ? html`<p class="muted">${help}</p>` : ""}
  ${field}
  <div class="save-bar"><button type="submit" class="primary">Save</button> <span class="save-status" role="status"></span> <a href="/edit/history/setting:${key}">history</a></div>
</form>`;
  return page(ctx, "Settings", html`<p class="breadcrumb"><a href="/edit">Editor</a> › Settings</p>
${form("book_title", "Book title", html`<input name="value" value="${get("book_title").value}">`)}
${form("macros", "Shared macros", html`<textarea name="value" rows="12" spellcheck="false">${get("macros").value}</textarea>`,
    html`One per line: <code>\\newcommand</code>, <code>\\renewcommand</code>, <code>\\def</code>, <code>\\DeclareMathOperator</code>. Used in all math (KaTeX).`)}
${form("bibliography", "Bibliography", html`<textarea name="value" rows="10" spellcheck="false">${get("bibliography").value}</textarea>`,
    html`Entries like <code>\\bibitem{Davenport} H. Davenport, \\emph{Multiplicative Number Theory}.</code> Cite with <code>\\cite{Davenport}</code> or <code>\\cite[Thm.~2]{Davenport}</code>.`)}
<h2>Maintenance</h2>
<p><button type="button" id="rebuild">Re-render everything and rebuild the reference graph</button> <span id="rebuild-status"></span></p>`);
}

export interface HistoryItem {
  id: number;
  entity: string;
  entity_key: string;
  revision: number;
  operation_id: string;
  snapshot_json: string;
  author: string | null;
  created_at: string;
}

export function historyPage(ctx: Ctx, heading: string, items: HistoryItem[], restoreBase: string | null, backUrl: string): string {
  return page(ctx, "History", html`<p class="breadcrumb"><a href="/edit">Editor</a> › <a href="${backUrl}">${heading}</a> › history</p>
<h1>History: ${heading}</h1>
<p class="muted">Newest first. “Load into editor” pre-fills the form with that version; nothing changes until you save.</p>
<ol class="history">${items.map((it) => {
    const snap = JSON.parse(it.snapshot_json) as Record<string, unknown>;
    const tex = (snap.statement_tex ?? snap.body_tex ?? snap.intro_tex ?? snap.value ?? "") as string;
    const what = it.entity === "proof" ? `proof #${it.entity_key}${snap.deleted ? " (deleted)" : ""}` : it.entity;
    return html`<li><strong>${it.created_at}</strong> · ${what} · revision ${it.revision} · ${it.author ?? "?"}
      ${snap.status ? html` · ${STATUS_BADGES[snap.status as keyof typeof STATUS_BADGES] ?? ""}` : ""}
      ${restoreBase && (it.entity === "result" || it.entity === "proof") ? html` · <a href="${restoreBase}?restore=${it.id}">Load into editor</a>` : ""}
      <details><summary>Show source</summary><pre>${tex}</pre></details></li>`;
  })}</ol>`);
}

export function loginPage(ctx: Ctx | null, next: string, error: string | null): string {
  return layout({
    title: "Editor login", bookTitle: ctx?.settings.book_title ?? "Notes",
    body: html`<h1>Editor login</h1>
${error ? html`<p class="warning">${error}</p>` : ""}
<form method="post" action="/login" class="login-form">
  <input type="hidden" name="next" value="${next}">
  <label>Password <input type="password" name="password" autocomplete="current-password" required autofocus></label>
  <button type="submit">Log in</button>
</form>`,
  });
}

export function errorPage(ctx: Ctx | null, status: number, message: string): string {
  return layout({
    title: "Error", bookTitle: ctx?.settings.book_title ?? "Notes",
    body: html`<h1>${status === 403 ? "Not allowed" : status === 401 ? "Please log in" : "Error"}</h1><p>${message}</p>`,
  });
}
