Implemented and reviewed the `c+iy` notation change across all 18 scoped fields. Added the guarded SQL migration, its generator, the acceptance checker, and the [word-level review](C:/Users/bbh8149/xiaoxiang_zhou/structured/github/math_sketchbook/implement_plan/tasks/2026-11-27-ck-notation.review.md). Updated both plot generators and regenerated the three SVGs below.

**Tests passed on Node 26.** The acceptance checker restored the backup, applied both migrations, and rejected a rerun and text or revision drift in every scoped field. All 18 fields rendered without KaTeX warnings, parsed references stayed the same, and all 18 revision snapshots matched their rows. The HTML caches cleared and `needs_rebuild` was set. Regenerating the SQL and review produced identical files.

```text
interval-criterion-a.svg     |  8 ++++----
interval-criterion-b.svg     | 10 +++++-----
zeta-taylor-coefficients.svg  |  6 +++---
3 files changed, 12 insertions(+), 12 deletions(-)
```

Verified that the SVG changes are label-only. I treated figure accessibility labels as part of the rename and used `c_1` for the local bound in 8JT3.

**Open issues** — None within scope. The out-of-scope `gamma-kernel-a.svg` still says `sigma` in its accessibility label. No `AGENTS.md` was found. No remote writes, deploy, or commit were performed.