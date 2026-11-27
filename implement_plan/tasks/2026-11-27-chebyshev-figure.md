# Spec: figure comparing the Chebyshev function and R_1 (Example 8JS9, Section 1.5)

## Goal

Example 8JS9 ("The smoothed prime sum of the trivial character", result id 122, Section 1.5 "The Riemann zeta case") gets three new figure panels, (c), (d) and (e), for 1 <= x <= 20. Readers should see that:
- the Chebyshev function Psi_1 jumps by Lambda(n) at each prime power n;
- R_1 is continuous and piecewise linear with corners at the same n;
- the slope of R_1 jumps there by Lambda(n)/n.

Read `docs/CONVENTIONS.md` first and follow it.

## Files

1. **New** `scripts/plot-chebyshev-vs-smoothed.mjs`. Writes three SVGs:
   - `public/static/figures/chebyshev-psi.svg`
   - `public/static/figures/chebyshev-smoothed.svg`
   - `public/static/figures/chebyshev-slope.svg`

   Run it with `node scripts/plot-chebyshev-vs-smoothed.mjs`, and commit the SVG outputs as well.
2. **New** `scripts/chebyshev-figure-2026-11-27.sql`. The D1 edit of result 122. Do NOT run it against the remote DB.

## Plot requirements

- Copy the look of `scripts/plot-smoothed-prime-sum.mjs`: same `<style>` block (fonts, colours, dark-mode media query), `.grid`, `.axis`, `.ticks`, `.var`, `.legend`, `.legend-bg`. Reuse its von Mangoldt sieve.
- **One panel per SVG, with NO title text inside the SVG.** The LaTeX titles go above the images in the page text. A one-row legend inside the plot area (top-left, on a `.legend-bg` box) is fine.
- **All three SVGs share the same x-geometry**, so the panels line up vertically on the page: W=640, LEFT=62, RIGHT=20, x-range [1, 20], x-ticks 1, 5, 10, 15, 20, x-label italic "x". Plot height about 200 px each. The y-ranges are your choice, with round ticks.
- Each SVG gets its own unique `clipPath` id (prefix it with the file name), because all three appear on one page.
- **In all three panels:** a thin dotted vertical guide line (new class `.pp`, grey, dasharray "1 3") at each prime power n <= 20: 2, 3, 4, 5, 7, 8, 9, 11, 13, 16, 17, 19.
- **Panel (c), chebyshev-psi.svg:**
  - Psi_1(x) = sum_{n<=x} Lambda(n) as a true step function: vertical risers at the jumps, value right-continuous. Solid, class `c-r`.
  - The line y = x, dashed, class `c-m`.
  - Legend: "Ψ₁(x)", "x".
- **Panel (d), chebyshev-smoothed.svg:**
  - R_1(x) = sum_{n<=x} Lambda(n)(x/n - 1). Sample exactly at 1, every prime power and 20; it is linear in between. Solid `c-r`, with a small filled dot (r=3, same colour) at each corner (x = prime power).
  - M_1(x) = x ln x - (1+gamma) x, dashed `c-m`, finely sampled.
  - Legend: "R₁(x)", "M₁(x)".
- **Panel (e), chebyshev-slope.svg:**
  - S(x) = sum_{n<=x} Lambda(n)/n (the slope of R_1 off the prime powers) as a step function like (c), class `c-r`.
  - ln x - gamma, dashed `c-m`.
  - Legend: "slope of R₁", "ln x − γ".
- **Console output:** print R_1(20), Psi_1(20) and S(20), each to 3 decimals.
- **Aria labels:**
  - (c): "The Chebyshev function Psi_1(x) and the line x for x from 1 to 20"
  - (d): "R_1(x) and M_1(x) for x from 1 to 20, with corners of R_1 at the prime powers"
  - (e): "The slope of R_1, a step function with jumps Lambda(n)/n, and ln x minus gamma"

## SQL requirements (`scripts/chebyshev-figure-2026-11-27.sql`)

Follow the pattern of `scripts/one-row-maps-2026-11-26.sql`, plus a revisions row like `scripts/move-auxiliary-data-2026-11-27.sql` (check that file for the exact `revisions` columns and snapshot JSON keys of a result).

1. **Guard:**
   ```
   INSERT OR ROLLBACK INTO write_guard (ok) SELECT 0 WHERE NOT EXISTS (SELECT 1 FROM results WHERE id IS 122 AND tag IS '8JS9' AND revision IS 5 AND instr(statement_tex, 'while $1.41 < G_{\mathbf 1}(x) < 2.21$ for $1 \le x \le 1000$.') > 0);
   ```
2. **Update:**
   ```
   UPDATE results SET statement_tex = statement_tex || <NEW TEXT>, statement_html_cache = NULL, revision = 6, updated_at = '2026-11-27 12:00:00', updated_by = 'claude' WHERE id = 122;
   ```
3. **Revisions:** insert the revision-6 snapshot of result 122. Build the snapshot JSON from the row after the update, using SQLite `json_object(...)` over the row. Do not hand-escape the TeX.
4. **Refs:** add the two new edges:
   ```
   INSERT OR IGNORE INTO refs (source_result_id, source_proof_id, target_tag) VALUES (122, NULL, '8JV3'), (122, NULL, '8JUT');
   ```
   Skip either one if it already exists; check whether `refs` has a unique index, otherwise use `WHERE NOT EXISTS`.
5. **Rebuild flag:** set `needs_rebuild` to '1' in `settings`, as the chapter3 script does.

<NEW TEXT> is exactly this, as an SQL string literal with `'` doubled. It starts with a blank line:

```tex


\emph{Comparison with the Chebyshev function.} Let $\Psi_{\mathbf 1}(x)=\sum_{n\le x}\Lambda(n)$ be the \hyperref[8JUT]{Chebyshev function}. By \ref{8JV3}, $R_{\mathbf 1}(x)=x\int_1^x\Psi_{\mathbf 1}(t)\,t^{-2}\,dt$. Both functions have their breakpoints at the prime powers $n$. At $n$ the step function $\Psi_{\mathbf 1}$ jumps by $\Lambda(n)$, while $R_{\mathbf 1}$ stays continuous and its slope jumps by $\Lambda(n)/n$. Between consecutive prime powers $R_{\mathbf 1}$ is linear with slope
\[ R_{\mathbf 1}'(x)=\sum_{n\le x}\frac{\Lambda(n)}{n}. \]
Panels (c)--(e) show this for $1\le x\le 20$. The dotted vertical lines mark the prime powers $2,3,4,5,7,8,9,11,13,16,17,19$, and the dashed curves are the smooth approximations $x$, $M_{\mathbf 1}(x)$ and $M_{\mathbf 1}'(x)=\ln x-\gamma$.
\begin{center}
\textbf{(c)} $\Psi_{\mathbf 1}(x)$ and $x$, for $1\le x\le 20$
\end{center}
\includegraphics[width=1, alt=The Chebyshev function Psi_1(x), a step function jumping by log p at each prime power p^k, against the line x, for x from 1 to 20]{/static/figures/chebyshev-psi.svg}
\begin{center}
\textbf{(d)} $R_{\mathbf 1}(x)$ and $M_{\mathbf 1}(x)$, for $1\le x\le 20$
\end{center}
\includegraphics[width=1, alt=R_1(x), continuous and piecewise linear with corners at the prime powers, against M_1(x), for x from 1 to 20]{/static/figures/chebyshev-smoothed.svg}
\begin{center}
\textbf{(e)} The slope $R_{\mathbf 1}'(x)=\sum_{n\le x}\Lambda(n)/n$ and $\ln x-\gamma$, for $1\le x\le 20$
\end{center}
\includegraphics[width=1, alt=The slope of R_1, a step function jumping by Lambda(n)/n at each prime power n, against ln x minus gamma, for x from 1 to 20]{/static/figures/chebyshev-slope.svg}
```

## Constraints

- Do not touch the remote DB. No `wrangler d1 execute --remote`, no `wrangler deploy`.
- Do not edit other figures or scripts.
- No Python is needed. Node 26 has `node:sqlite` if you want a local test.

## Acceptance

1. `node scripts/plot-chebyshev-vs-smoothed.mjs` runs cleanly and writes the three SVGs. Each is valid XML with exactly one `<svg>` root, no `class="title"` text, and a unique clipPath id.
2. Local SQL test:
   - Restore `backup-before-chapter3-self-contained-2026-11-27.sql` (gitignored, in the repo root) into an in-memory DB with `node:sqlite`.
   - Apply `scripts/chapter3-self-contained-2026-11-27.sql`, then the new script, inside one transaction.
   - Show that result 122 has revision 6 and ends with the new text.
   - Show that `json_extract(snapshot_json,'$.statement_tex')` of the new revision equals `statement_tex`.
   - Show that a second run is blocked by the guard.

   Put the test in `scripts/check-chebyshev-figure-2026-11-27.mjs`.
3. **Report:** list the files changed, the printed values R_1(20), Psi_1(20) and S(20), and the test output.
