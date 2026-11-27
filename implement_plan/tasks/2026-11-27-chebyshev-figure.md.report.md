Implemented panels (c)–(e) for Example 8JS9 and verified the revision-6 update in local SQLite. The remote database was untouched.

**Files added**

- `scripts/plot-chebyshev-vs-smoothed.mjs`
- `scripts/chebyshev-figure-2026-11-27.sql`
- `scripts/check-chebyshev-figure-2026-11-27.mjs`
- `public/static/figures/chebyshev-psi.svg`
- `public/static/figures/chebyshev-smoothed.svg`
- `public/static/figures/chebyshev-slope.svg`

**Tests run**

- Plot generator passed and printed `R_1(20) = 30.232`, `Psi_1(20) = 19.266`, and `S(20) = 2.475`.
- All three SVGs passed XML, clip ID, alignment, and prime-power geometry checks.
- Local SQL checker passed. It verified the exact TeX append, cleared HTML cache, matching revision-6 snapshot, both reference edges, the rebuild flag, and rollback on rerun.
- The site renderer displayed all three panels without TeX warnings. `npm test` passed 25 of 25 tests.

**Open issues**

- Git could not create `.git/index.lock` in this workspace, so the six files are uncommitted.
- The existing site renderer truncates HTML alt text at the first comma. The SQL preserves the supplied TeX verbatim, and each SVG contains its full requested ARIA label.