Implemented the §1.2 smoothed prime sum motivation. All SQL testing used temporary database copies.

**Files changed**

- [SQL script](C:/Users/bbh8149/xiaoxiang_zhou/structured/github/math_sketchbook/scripts/motivate-smoothed-prime-sum-2026-11-25.sql)
- [Checker](C:/Users/bbh8149/xiaoxiang_zhou/structured/github/math_sketchbook/implement_plan/tasks/2026-11-25-motivate-smoothed-prime-sum.check.mjs)
- [Report with final TeX and full checker output](C:/Users/bbh8149/xiaoxiang_zhou/structured/github/math_sketchbook/implement_plan/tasks/2026-11-25-motivate-smoothed-prime-sum.md.report.md)

**Tests**

- SQL checker passed with zero TeX warnings across 16 sources. The write guard rejected and rolled back reapplication.
- `npm test` passed all 24 tests.

**Open issues**

8JJ5 and 8JQ3 had no baseline revision snapshots. The checker verified their position-only changes. Browser-based formula width measurement was unavailable. The introduction is about half as long as 8JU4 by prose word count and 76% as long by raw TeX length.