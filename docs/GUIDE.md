# grh-notes: full guide

Back to the [README](../README.md).

## 1. Run it locally

You need [Node.js](https://nodejs.org) (LTS or newer). In a terminal in this folder:

```powershell
npm install
```

```powershell
npm run setup
```

```powershell
npm run dev
```

Then open <http://localhost:8787>. The editor is at <http://localhost:8787/edit>. Locally you are logged in
automatically as `editor@localhost`, and that only works on `localhost`.

- `npm run setup` creates the local database and loads the placeholder book. Run it only once. To start over,
  delete the `.wrangler` folder and run it again.
- `npm test` runs the automated tests.

## 2. Deploy to Cloudflare (one-time setup, about 20 minutes)

1. Create a free account at <https://dash.cloudflare.com>, then log in from the terminal:
   ```powershell
   npx wrangler login
   ```
2. Create the database:
   ```powershell
   npx wrangler d1 create grh-notes
   ```
   Copy the printed `database_id` into `wrangler.toml`, replacing `00000000-0000-0000-0000-000000000000`.
3. Create the tables and load the starting content:
   ```powershell
   npm run db:migrate:remote
   ```
   ```powershell
   npm run db:seed:remote
   ```
4. Publish the site:
   ```powershell
   npm run deploy
   ```
   It prints your address, something like `https://grh-notes.<your-subdomain>.workers.dev`. The public pages work
   now. `/edit` says "not configured" until you finish step 5.
5. **Editor password.** Pick a long random password (at least 16 characters; a password manager can generate
   one) and store it as a Cloudflare secret. The command asks you to type it:
   ```powershell
   npx wrangler secret put EDITOR_PASSWORD
   ```
   The new password takes effect immediately, no deploy needed. Visit `/edit`, enter the password, and you stay
   logged in on that browser for 30 days. To log out everywhere, set a new password with the same command.

From then on, **content changes need no deploying**: you edit in the browser and the change is live. Run
`npm run deploy` again only when the *code* changes.

**Backups.** D1 keeps 30 days of point-in-time history ("Time Travel"; see `npx wrangler d1 time-travel --help`).
For a copy on your own computer, run:

```powershell
npm run db:backup
```

**Cost.** Free-tier Workers get about 10 ms of CPU time per request. Reading pages is cheap because the HTML is
cached in the database. Saving one result re-renders only that result. If the book grows very large and
"re-render everything" (Settings page) starts failing, the $5/month Workers Paid plan raises the limit to
30 s.

## 3. Writing content

### Add a new result

1. Go to `/edit`.
2. Under the section you want, pick a type (lemma, theorem, …) and click **+ New result here**. A permanent tag
   such as `7KQX` is created at once. Tags never use 0, O, 1, I or L.
3. Fill in the title (optional; LaTeX allowed), the statement, and one or more proofs. Each proof has a status,
   who wrote it (human / claude / gpt), and reviewer fields. Review notes are visible only in the editor.
4. Optionally add **readable aliases** such as `dirichlet-orthogonality`. You can then write
   `\ref{dirichlet-orthogonality}` anywhere; on save it is replaced by `\ref{7KQX}`, and `/tag/dirichlet-orthogonality`
   redirects to the result.
5. Use **Position** to move a result within its section, or **Section** to move it elsewhere. Numbers such as
   "Lemma 1.2.3" are recomputed automatically; tags and URLs never change.
6. Press **Save & publish** (or Ctrl+S). Warnings, such as unknown references or LaTeX errors, appear under
   the preview and after saving.

**History.** Each result has a *history* link. "Load into editor" fills the form with an old version, and nothing
changes until you save.

Chapters and sections are created on the `/edit` page. The book title, the shared macros and the bibliography
are edited at `/edit/settings`.

### LaTeX that works

- **Math:** `$…$`, `\(…\)`, `\[…\]`, `$$…$$`, plus `equation`, `align`, `gather`, `multline`, `alignat`, `CD` (with or
  without `*`). Anything KaTeX supports is fine: <https://katex.org/docs/supported>.
- **Text:** paragraphs (blank line), `\emph`, `\textbf`, `\textit`, `\texttt`, `\textsc`, `itemize` / `enumerate` /
  `description` with `\item` or `\item[(a)]`, `quote`, `center`, `\\`, `~`, ` `` '' `, `--`, `---`, `\S`, `\ldots`,
  `\url`, `\href`, `\footnote`, accents such as `\'e`. Unicode such as `é` or `ő` works too.
- **References:** `\ref{TAG}` or `\ref{alias}` for a result, section or chapter. Several at once with `\ref{A,B}`.
- **Citations:** `\cite{key}` and `\cite[Thm.~3]{key}`, using `\bibitem{key}` entries on the Settings page.
- **Macros:** the shared macro file (Settings) accepts `\newcommand`, `\renewcommand`, `\def` and
  `\DeclareMathOperator`. It applies to all math on the site.
- **Not supported yet:** `\label` / `\eqref` for equations (`\label` is silently ignored), `\ref` *inside* math, and
  tikz-cd. Unsupported commands are shown in red, with a warning in the editor.

### Plans for later (the data model is already prepared)

- **tikz-cd.** Simple commutative diagrams work today with `\begin{CD} A @>f>> B \end{CD}`. For real tikz-cd, the
  plan is to keep the tikz source in the result and produce an SVG when you save, either compiled in the browser
  (TikZJax) or exported from [quiver](https://q.uiop.me). The SVG would be stored in Cloudflare R2 and shown in
  place of the source. Right now a `tikzcd` environment is shown as source code with a warning.
- **AI-generated content.** Proofs already record `status`, `generated_by`, `generator_detail` and reviewer fields.
  Results and proofs have a `visibility` column (`published` / `draft`) so future AI drafts can stay hidden until
  approved. A `generation_runs` table and a `reviews` table (reviews tied to an exact proof revision) are reserved.
- **Reviewer role.** The `users.role` column already accepts `reviewer`. Reviewers can currently open the editor
  pages but cannot change anything.
- **Splitting a proof into sub-lemmas.** Create the new lemma (it gets a new tag), move part of the proof into it,
  and write `\ref{NEWTAG}` in the old proof. No existing tag or URL changes. The columns
  `results.derived_from_proof_id` / `derived_from_proof_revision` record where a lemma came from.
- **Retiring results.** Results are never deleted. `results.state = 'retired'` keeps the tag's page alive (with an
  optional link to its replacement).

## 4. Project layout

```
src/index.ts        routes (public pages, knowl API, editor pages, editor API)
src/latex.ts        LaTeX → HTML (unified-latex parser + KaTeX), alias rewriting, macros
src/book.ts         book structure, numbering, cached HTML, \ref placeholders → "Lemma 1.2.3"
src/store.ts        saving: validation, atomic batches, history, reference graph
src/auth.ts         editor password login (signed session cookie)
src/views/          HTML templates (reader and editor)
public/static/      CSS, knowl.js (click-to-expand), editor.js (preview & save)
migrations/         database schema (see comments in 0001_init.sql)
seed/seed.sql       placeholder book
test/               automated tests (npm test)
```

Changed the LaTeX renderer? Bump `RENDER_VERSION` in `src/book.ts`; all cached HTML is then re-rendered
automatically on the next page view.
