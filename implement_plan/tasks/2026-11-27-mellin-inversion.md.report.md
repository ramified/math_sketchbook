Added Mellin inversion (`MCV8`) after `MCV4` in Appendix A.1 and linked its first mention in `8JV3`.

**Files changed**

- [mellin-inversion-2026-11-27.sql](C:/Users/bbh8149/xiaoxiang_zhou/structured/github/math_sketchbook/scripts/mellin-inversion-2026-11-27.sql)
- [check-mellin-inversion-2026-11-27.mjs](C:/Users/bbh8149/xiaoxiang_zhou/structured/github/math_sketchbook/scripts/check-mellin-inversion-2026-11-27.mjs)

**Tests run**

`node scripts/check-mellin-inversion-2026-11-27.mjs` passed on Node 26.

```text
PASS: backup restored, reorder and inversion applied, rerun rolled back
PASS: APXS order and row changes match the spec, and only the first exact phrase is linked
PASS: 8 revision snapshots match their rows and needs_rebuild is set
PASS: 3 TeX fields rendered without warnings and their stored refs match
```

A separate comparison confirmed that the statement and proof TeX match the spec verbatim.

**Open issues** — None for the implementation. No `AGENTS.md` was found in the repository or its parent directories.