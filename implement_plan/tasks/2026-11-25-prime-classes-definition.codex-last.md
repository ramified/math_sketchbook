Split `8JVC` into three definitions, moved their rationale into the §2.2 intro, and updated the cross-references. Standardized all set-builder notation in Chapters 2 and 3 and verified that every formula and number in the modulo-840 example matches the baseline.

Created the three requested files. [SQL patch](<G:/我的大学材料/文件/个人练习/文件类/github/math_sketchbook/scripts/prime-classes-definition-2026-11-25.sql>) · [Checker](<G:/我的大学材料/文件/个人练习/文件类/github/math_sketchbook/implement_plan/tasks/2026-11-25-prime-classes-definition.check.mjs>) · [Report](<G:/我的大学材料/文件/个人练习/文件类/github/math_sketchbook/implement_plan/tasks/2026-11-25-prime-classes-definition.md.report.md>)

The checker used a temporary SQLite copy, verified that reapplication made zero writes, and rendered 214 text fields with zero warnings. The widest touched display was estimated at 587.4 px. `npm test` hit a sandbox `spawn EPERM` error. All 25 tests passed with `node --test --test-isolation=none "test/*.test.ts"`.

The final checker run printed `ALL CHECKS PASSED`.