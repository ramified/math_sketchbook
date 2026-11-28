Implemented “返工 1.” With folding enabled, every listed result starts collapsed. **Show drafts** reveals unclear results in sections and the contents while preserving their numbers. **Expand all** and **Collapse all** affect only visible result folds.

- **Files changed** — `reader.ts`, `layout.ts`, `knowl.js`, `pinboard.js`, `style.css`, `understanding.test.ts`, `GUIDE.md`, and the [implementation report](C:/Users/bbh8149/xiaoxiang_zhou/structured/github/math_sketchbook/implement_plan/tasks/2026-11-28-understanding-labels.md.report.md).
- **Tests** — `npm run typecheck` passed. `npm test` passed all 35 tests. The reader script smoke check passed.
- **Open issues** — The manual browser check remains pending as specified. No `AGENTS.md` was found. All verification ran locally.

## 返工 1, item 7 (section and chapter intros folded)

Implemented item 7. With draft folding enabled, non-empty chapter and section introductions start collapsed and respond to **Expand all** and **Collapse all**. Section knowls still show the introduction inline, and nested draft blocks keep their own controls.

- **Files changed** — `reader.ts`, `layout.ts`, `knowl.js`, `style.css`, `understanding.test.ts`, `GUIDE.md`, and the [implementation report](C:/Users/bbh8149/xiaoxiang_zhou/structured/github/math_sketchbook/implement_plan/tasks/2026-11-28-understanding-labels.md.report.md).
- **Tests** — `npm run typecheck` passed. `npm test` passed all 36 tests. The simulated reader control check and `git diff --check` also passed.
- **Open issues** — Headless Chrome failed to start. The manual browser check remains pending as specified. No `AGENTS.md` was found. No database or deployment commands ran.
