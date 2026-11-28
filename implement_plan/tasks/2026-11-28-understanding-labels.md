# Spec: understanding labels and folded drafts (28 Nov 2026)

## Goal

Most content is AI-generated and the editor does not yet understand much of it. Add an editor-only
**understanding level** to results and proofs, plus an inline `unclear` environment. On the reader site,
content the editor has not understood is **folded by default** (one line, click to expand). It is never
removed: a reader who clicks a reference, opens the result's own page, or expands the fold sees it in full.

Also remove "who wrote it" badges from the reader site. Readers should not see 🤖/🛠/✅ badges or
"written by Claude/GPT".

This is a code change only. Do **not** touch the remote database and do not deploy. Local DB and tests only.

## Levels

`understanding` on `results` and `proofs`: `'unclear' | 'partial' | 'clear'`.

| value | editor label | reader effect (when folding is on) |
|---|---|---|
| `unclear` (default for new rows) | Not yet understood | folded |
| `partial` | Partly understood | shown normally |
| `clear` | Understood | shown normally |

Readers never see the level's name. They only see "folded or not", and folds are labelled "draft".

## Master switch

New editable setting `fold_drafts` (`'1'` = on; missing or anything else = off). Add it to
`EDITABLE_SETTINGS` and the settings page as a checkbox or a small text field. **Off by default.** While it
is off, reader pages look exactly as they do today, minus the removed badges. Unclear blocks render as plain
content: open, with no summary line and no styling. This lets the editor mark everything first and then
switch folding on.

## Changes

### 1. Migration `migrations/0005_understanding.sql`
- `ALTER TABLE results ADD COLUMN understanding TEXT NOT NULL DEFAULT 'unclear' CHECK (understanding IN ('unclear','partial','clear'));`
- The same for `proofs`.
- Existing proofs: `UPDATE proofs SET understanding = 'clear' WHERE status = 'polished';` Everything else stays `unclear`.
- Comment at the top explaining the column (editor-only; folds content for readers when `fold_drafts` = '1').

### 2. Types and book structure
- `src/types.ts`: `UNDERSTANDING_LEVELS`, the type, and editor labels. Add the field to `ResultRow` and `ProofRow`.
- `src/book.ts` `loadBook`: select `understanding` and put it on `Entry` (results only), so dashboards can show it.
- `src/book.ts`: bump `RENDER_VERSION` to `"6"` (the latex renderer changes).

### 3. LaTeX: `unclear` environment (`src/latex.ts`)
`\begin{unclear}[optional note]...\end{unclear}` renders as a block:
```html
<details class="draft-block"><summary>A step here is still a rough draft.</summary><div class="draft-body">…content…</div></details>
```
The optional note is **editor-only**. Do not put it into the reader HTML. Put it in a `data-note` attribute
only if you can strip it for readers; otherwise drop it. No warning for this environment. Nested content
(math, lists, paragraphs, `\ref`) works as in any other block. Proof parts `\emph{(i)}` paragraphs inside a
proof must still be detected when they are *outside* an unclear block (check `proofparts.js`).

### 4. Reader rendering (`src/views/reader.ts`)
`fold` = `ctx.settings.fold_drafts === '1'`.
- **Remove** `badge()` and `provenance()` from the reader proof heading. The heading is just "Proof." / "Proof 2.".
  (The editor keeps its status/generated_by fields; `STATUS_BADGES` may still be used in editor views.)
- **Section page, unclear result, fold on:** keep the article in place with its number. Wrap it so that by
  default only one line shows: the normal heading (label, title, tag link) followed by a muted word "draft"
  and a ▸ toggle. Expanding shows the full statement and proofs. Use `<details class="draft-result">` with the
  heading in `<summary>`, or an equivalent. The article keeps `id="TAG"` and `data-tag`, so `#TAG` anchors and
  pinboard still work. If the URL hash targets a folded result, open it (small JS in `knowl.js` or a new file).
- **Result's own page and knowl, unclear result:** show it fully expanded, with a thin muted banner above the
  statement: "This is still a rough draft and may not read smoothly."
- **Unclear proof, fold on:** always collapsed, everywhere, including the result's own page (where other proofs
  are open). Summary: "Proof (draft)."
- **Fold off:** none of the above. Unclear blocks are served as `<details class="draft-block" open>`, and a
  body class makes their summary invisible and removes styling. Do this at serve time, not in the cache, with
  a string replace in the function that fills cached HTML, or with a body class plus CSS/JS. The cache must
  not depend on the setting.
- **Reader toggle:** when fold is on, add a small control in the site header, "Show drafts", stored in
  `localStorage`. When it is on, all `details.draft-result`, `details.draft-block` and draft proofs start
  open. Banners and markers stay.
- **Contents page (home TOC):** unchanged. Unclear results are still listed with their numbers.

### 5. Editor
- Result form: a select "Understanding" (three labels) next to "Listed". Proof fieldset: the same select per
  proof. New proofs default to `unclear`. Validate in `src/store.ts` with `oneOf`. Include `understanding` in
  the revision snapshots for results and proofs. When restoring an old snapshot that lacks it, keep the
  current value.
- Dashboard `/edit`: after each result, show a compact select with the three levels that saves immediately
  through a new endpoint `POST /api/edit/understanding` `{ tag, level }`. The endpoint uses the same auth and
  CSRF/origin checks as the other editor APIs and requires edit rights. It updates only the column: no
  revision bump, no history row (it is a private bookmark, not content). It also needs a select for the
  section/chapter "mark all results in this section as …" with confirmation.
- Dashboard: per chapter, counts "understood n · partly n · not yet n".
- Editor preview: render the unclear block visibly (light tinted background, plus the note if any).

### 6. CSS (`public/static/style.css`, `editor.css`)
Quiet styling: the fold line is a muted, single line; "draft" in small grey text; the banner is a thin
grey-left-border note. No red, no robot icons. Bump `ASSET_VERSION` in `src/views/layout.ts`.

### 7. Docs
Add a short subsection to `docs/GUIDE.md` §3: the levels, `\begin{unclear}`, the `fold_drafts` switch.

## Constraints
- Do not change numbering, `refs`, `visibility`, or `listed` logic.
- Reader HTML must not contain the editor note of an `unclear` block, `understanding_note`, or the level names.
- Keep existing tests passing. Do not run anything against `--remote`. Do not deploy.

## Acceptance
```powershell
npm run typecheck
```
```powershell
npm test
```
New tests (in `test/`):
1. `renderTex` of `a \begin{unclear}[secret note] b $x$ \end{unclear} c` produces one `details.draft-block`
   containing the math. The reader output does not contain `secret note`. There are no warnings.
2. `resultBlock` (or the section page function) with a fake ctx: with `fold_drafts='1'`, an unclear result is
   wrapped in the fold with its label still present. A partial/clear one is not. With fold off, neither is.
3. An unclear proof is collapsed on the result page when fold is on, while a clear proof is open.
4. Reader proof headings contain neither `badge-` nor `written by`.
5. Store validation rejects `understanding: 'verified'`.

Manual check (Claude does this after the report): `npm run setup` on a fresh local DB if needed, apply
migration 0005 locally, `npm run dev`, then check a section page with fold on and off, the knowl of an
unclear result, and the dashboard select.

## Report
Write `implement_plan/tasks/2026-11-28-understanding-labels.md.report.md`: files changed, decisions taken where
this spec left room, and test output.

## 返工 1 (28 Nov 2026): fold every result, hide unclear ones from the flow

The first version is deployed. The editor wants a different reader behaviour **when `fold_drafts = '1'`**.
Nothing changes when it is off. Do not touch the remote DB and do not deploy.

### New reader behaviour (fold on)
1. **Every listed result on a section page is folded to its heading line**, whatever its level. The line is
   the normal heading: label, title and tag link. Clicking it expands the statement and proofs in place.
   `partial` and `clear` results get no "draft" marker. Keep `id="TAG"` and `data-tag` on the article, and
   keep opening the fold when the URL hash targets it.
2. **`unclear` results do not appear on the section page or in the home contents (TOC).** Numbering is
   unchanged: they keep their numbers, so readers see gaps such as 3.3.1 then 3.3.4. Do **not** change
   `loadBook` numbering. `\ref`, knowls and `/tag/TAG` still work exactly as now (full content plus the
   "rough draft" banner). On an unclear result's own page, omit the "view in context" link.
3. Implement (2) by still sending the unclear items, marked `class="draft-hidden"` (both the section-page
   article and the TOC `<li>`), and hiding them with CSS unless the root has the class `show-drafts`. The header
   toggle "Show drafts" (localStorage, already exists) now adds or removes that class. When shown, an unclear
   result appears in the flow folded, with its "draft" marker. Remove the old behaviour where the toggle opened
   every fold.
4. Add a small "Expand all / Collapse all" control at the top of a section page's result list (fold on only).
   It acts on the visible result folds.
5. Unchanged: draft proofs are always collapsed, with the "Proof (draft)." summary. `\begin{unclear}` blocks
   still fold. Section intros are not folded. Knowls and result pages are unchanged. The editor dashboard is
   unchanged.
6. Bump `ASSET_VERSION`. Update `docs/GUIDE.md`.

### Acceptance
`npm run typecheck` and `npm test` pass. Update or add tests:
- With fold on: a clear result on a section page is wrapped in a closed fold with no "draft" marker. An
  unclear result is present only with `draft-hidden`. In the home TOC, the unclear item has `draft-hidden`.
  The numbering of the following result is unchanged (it still has the gap).
- With fold off: no folds and no `draft-hidden` anywhere (current behaviour).
- An unclear result's own page has no "view in context" link and still has the banner.
Append a "返工 1" section to the report file.

### 返工 1, item 7: section and chapter intros are folded too (fold on only)
A non-empty intro on a section or chapter page is wrapped in its own fold, like a result: a closed
`<details class="intro-fold">` whose one-line summary is "Introduction". It sits in the same place, above the
results, and "Expand all / Collapse all" covers it as well. The intro has no understanding level.
`\begin{unclear}` inside an intro still folds as usual. The knowl of a section (`knowlSection`) shows the
intro unfolded. With fold off, intros are unchanged. Add a test: with fold on, a section page wraps a
non-empty intro in a closed `intro-fold`; with fold off, it does not.
