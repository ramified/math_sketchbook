# Figure design: geometry of the interval criterion (Proposition 1.4.7, tag 8JP5)

Purpose: show the two cases of Step 3 of the proof. Two separate panels (two SVG files), no titles inside
the SVGs (titles are written in LaTeX in the proof). Schematic, not to scale (in reality σ is much larger
than 1 and all poles lie in 0 < Re s < 1).

## Common to both panels

- Canvas 640 × 340 px. Math window: Re s ∈ [−0.4, 7.0], Im s ∈ [−3.3, 3.3], same scale on both axes
  (circles must look round).
- Real axis (horizontal) and imaginary axis (vertical, at Re s = 0), thin grey, with small arrowheads.
- Vertical dashed line **Re s = θ** at Re s = 2; label "Re s = θ" at its top.
- Vertical solid line **Re s = σ** at Re s = 6; label "Re s = σ" at its top.
- Light red shading of the strip θ < Re s < 6 (between the two lines), with a small label near the bottom
  inside it: "Re s > θ".
- Horizontal bracket below the real axis from Re s = θ to Re s = σ, labelled "D*" (D with subscript *),
  meaning D* = σ − θ.
- The real point σ on the real axis: small filled dot, label "σ" below-right.
- Poles: filled dark dots (radius 4 px). Poles to be highlighted: red dots (radius 5 px).
- Math labels in a serif italic font (e.g. "Latin Modern Math", "Cambria Math", "Times New Roman", serif),
  subscripts via <tspan> with baseline shift; plain words in system-ui. No other text.
- Light/dark: same CSS approach as scripts/plot-gamma-kernel.mjs (a <style> block with
  @media (prefers-color-scheme: dark) overrides). Transparent background.

## Panel (a): case (a), some pole is horizontally closer to the line than D

Poles (all with their conjugates):
- ρ₁ = 3 + 1.8i and ρ̄₁ = 3 − 1.8i — **red**; label "ρ₁" and "ρ̄₁" (rho with bar) next to them.
- 1.5 ± 0.9i, 1.0 ± 2.6i — dark.

Geometry to draw:
- Grey dashed circle centred at σ = 6 with radius D = |σ − ρ₁| = √(9 + 3.24) ≈ 3.50; it passes through both
  ρ₁ and ρ̄₁ (they are equally close to σ: this is why the proof leaves the real axis).
  Grey segment σ → ρ̄₁ labelled "D" at its midpoint.
- The point z = σ + iτ = 6 + 1.8i on the line Re s = σ: small blue filled dot, label "z = σ + iτ" to its right.
- Blue solid circle centred at z with radius d = |z − ρ₁| = 3; it touches ρ₁ and contains no other pole.
  Blue segment z → ρ₁ (horizontal) labelled "d" above its midpoint.
- Optional small annotation near ρ₁: nothing else.

Check: d = 3 < D ≈ 3.50 < D* = 4, and ρ₁ is the unique pole at distance d from z
(other distances: to ρ̄₁ ≈ 4.69, to 1.5+0.9i ≈ 4.59, to 1+2.6i ≈ 5.06).

## Panel (b): case (b), every pole has horizontal distance at least D

Poles:
- β = 3.2 on the real axis — **red**; label "β = σ − D" below it.
- 2.6 ± 2.2i, 1.2 ± 1.2i, 0.8 ± 2.8i — dark.

Geometry to draw:
- Grey dashed circle centred at σ = 6 with radius D = σ − β = 2.8; it touches β and contains no other pole.
  Grey segment σ → β along the real axis labelled "D" above its midpoint.
- Dotted vertical line Re s = σ − D (through β), from Im s = −3.1 to 3.1, with small label at its top:
  "Re s = σ − D". All poles lie on or left of this line.

Check: D = 2.8 < D* = 4; other poles: horizontal distance ≥ 3.4 ≥ D and Euclidean distance to σ > 2.8
(2.6+2.2i: ≈ 4.05; 1.2+1.2i: ≈ 4.95; 0.8+2.8i: ≈ 5.91).

## Output

- `public/static/figures/interval-criterion-a.svg`, `public/static/figures/interval-criterion-b.svg`
- Generator: `scripts/plot-interval-criterion.mjs` (Node ESM, no dependencies), run with
  `node scripts/plot-interval-criterion.mjs`, printing the checks above.

## Use in the proof (LaTeX titles above each image)

- Case (a): `\textbf{(a)} Case (a): $z = \sigma + i\tau$ is closer to $\rho_1$ than $\sigma$ is to any pole; $\rho_1$ and $\bar\rho_1$ are equally close to $\sigma$.`
- Case (b): `\textbf{(b)} Case (b): the pole nearest to $\sigma$ is the real pole $\beta = \sigma - D$, and every pole lies in $\Re s \le \sigma - D$.`
