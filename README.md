# grh-notes

An online notebook for understanding GRH.

- **Online:** <https://grh-notes.ramified.workers.dev>
- **Local:** <http://localhost:8787> (editor at `/edit`)

## Run locally

First time: `npm install` then `npm run setup`. After that: `npm run dev`.

## Publish code changes

`npm run deploy` (run `npx wrangler login` first if it asks).

Full guide: [docs/GUIDE.md](docs/GUIDE.md).

## References

- *The Generalized Riemann Hypothesis for Dirichlet L-functions: from smoothed prime sums to zeros on the
  critical line* (AI-generated natural-language outline of the Lean proof, 21 Nov 2026), posted by Ruida Di on
  [MathHelm](https://mathhelm.org/t/390/maybe-we-have-overestimated-the-difficulty-of-riemann-hypothesis).
  Local copy: [docs/references/GRH-natural-language-outline.pdf](docs/references/GRH-natural-language-outline.pdf).
- *Dirichlet L-functions and the critical line* (Ulam, 93-page edition), an expanded
  exposition of the analytic reduction and arithmetic estimate. [Online PDF](https://www.ulam.ai/research/rh-long.pdf) ·
  [Local PDF](docs/references/dirichlet-l-functions-and-the-critical-line.pdf).
- *The Riemann Hypothesis in Lean: a human-readable blueprint of Alpöge’s proof*
  (draft of 24 November 2026, 76 pages), a guide to the main steps and their Lean declarations.
  [Online PDF](https://drive.google.com/file/d/1-3dAIG1_cmfzkZieK-lw8S5F-v_C9_dI/view) ·
  [Local PDF](docs/references/rh-lean-blueprint-2026-11-24.pdf).
- L. Alpöge, *Remark*, <https://alpo.ge/remark.pdf>; Lean source: <https://github.com/Deicyde/riemann-hypothesis>.
- https://mathoverflow.net/questions/518068/where-to-begin-understanding-the-proof-of-the-riemann-hypothesis
