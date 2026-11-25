Implemented round 3. The migration adds Definition 2.1.1 (`8JV2`) for \(e_D\) and \(e_L\), links their uses in `8JU7` and `8JUA`, and adds the Adriazola bibliography entry.

**Files added** · [SQL migration](C:/Users/bbh8149/xiaoxiang_zhou/structured/github/math_sketchbook/scripts/ch2-error-exponents-2026-11-25.sql) · [Checker](C:/Users/bbh8149/xiaoxiang_zhou/structured/github/math_sketchbook/implement_plan/tasks/2026-11-25-ch2-error-exponents.check.mjs) · [Report](C:/Users/bbh8149/xiaoxiang_zhou/structured/github/math_sketchbook/implement_plan/tasks/2026-11-25-ch2-error-exponents.md.report.md)

**Tests** · The new checker printed `ALL CHECKS PASSED` with zero TeX warnings and verified that reapplication writes nothing. `npm test` passed all 24 tests. The round 2 checker passed all three historical setups and correctly rejected reapplication to the current database.

**Open issue** · Headless Chrome timed out during the preview width check. pdfLaTeX measurements put the widest new display at approximately 438 px in the 680 px column. The migration was tested only on temporary database copies.