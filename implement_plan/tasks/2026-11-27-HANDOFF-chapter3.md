# Handoff: Chapter 3 self-contained rewrite (27 Nov 2026)

## Where things stand

**Live on the site** (already applied to the remote D1 database):
- notation cleanup (`scripts/notation-cleanup-2026-11-26.sql`);
- the 8JU7 move (`scripts/move-auxiliary-data-2026-11-27.sql`);
- the refs resync (`scripts/refs-sync-2026-11-27.sql`);
- the new Chapter 2 on Chebyshev's method (`scripts/chebyshev-chapter-2026-11-27.sql`).

**Written and tested locally, NOT applied:**
- `scripts/chapter3-self-contained-2026-11-27.sql`: makes Chapter 3 depend only on the black box 8JVG.
  - Proves the auxiliary primes (8JU7) and Estimates B/C (8JVH) from primary theorems.
  - Turns 8JVK into the definition "Admissible scales and weights".
  - Moves the theta-lift and window material to Chapter 4 (new tags C4S2, C4W2).
  - Adds C3R2 (shifting G_chi) and C3T2 (the sets T, T_2).
- Full text: `implement_plan/tasks/2026-11-27-chapter3-self-contained.md.report.md`.
- Local verifier: `python -I scripts/check-chapter3-self-contained-2026-11-27.py`. It needs `backup-before-chebyshev-chapter-2026-11-27.sql`, which is gitignored. On another computer, export a fresh copy first; see the note under step 3.

## Proof-check result (done 27 Nov, codex gpt-6.2-sol)

Full output: re-run it if needed. The findings, ranked by severity:

- **Chapter 3 checks out.** 8JU7, C3R2, 8JVH (i)/(ii), C3T2 and 8JUV are correct, and so is the use of 8JVG in 8JVE/8JVF/8JUD/8JVJ. The quantifiers are: exists Y, for all x in the window, there exists a tuple. The primes may vary with x. The constant 61/8 and the threshold (3o+28)^{8/(11 eps)} were rechecked.
- **Citations:**
  - McCurley Thm 1, Bennett et al. Prop 1.11, Thorner-Zaman Thm 1.1 (arXiv v2: theta values, V_b and the error exponents all match) and Behrend: all match.
  - Montgomery 12.2: the notes' (Q^2T)^{5(1-sigma)/2}(log)^{14} is a valid weakening of the reported 2(1-sigma)/sigma form for sigma >= 4/5. The original page was not seen.
- **Fixes needed, both in Chapter 4 / the 8JVG justification only:**
  1. The cohomological cutoff must be **1 <= r < floor(x^{400})** (Adriazola Def. 18.1(D6)), not r < x^{400}. Fix the 8JU8 edit and the handoff text at report lines ~176-179 and ~577.
  2. Add one sentence identifying the source's excess with 8JVG's count. Take upsilon_t = a_t, a_E = xb, and S_0 = {p : p | N, p != d} in Adriazola (3.10). For those p, (p/d) = 1 by reciprocity and the supplement at 2, so their cosets lie in Phi, and the coset at d gives the single contribution.
- 8JVG remains conditional on Adriazola's Hypotheses 17.11 and 18.10. This is known; it is the black box.

## Step 1: independent proof check (done; kept for re-runs)

The first run hung: the codex process had no network connection after a DNS outage. Run it again, from the repository root:

```
codex exec -m gpt-6.2-sol -s read-only --skip-git-repo-check "<PROMPT>"
```

with this prompt:

> Read-only proof check. Read implement_plan/tasks/2026-11-27-chapter3-self-contained.md.report.md, which has the full TeX of a rewrite of Chapter 3 of a math-notes site. Check these results rigorously as a referee:
> - C3R2 "Shifting the smoothed prime sum": the contour shift and the Schwarz-lemma bound on L'/L;
> - 8JU7 "Simultaneous choice of auxiliary primes": the selection of q, d by a mean square over candidate primes plus a density exclusion; the zero-free boxes Re s>1-1/400; Estimate B |G_chi(y)| <= y^{1/2+eps} on [Y_base, Y_base^J];
> - 8JVH (i), Estimate C, and (ii), the L'/L bound;
> - C3T2: T with exact coset proportions, and T_2 from Behrend spheres;
> - 8JUV: the new proof that L(1,chi) != 0;
> - the new black-box statement 8JVG, and whether 8JVE, 8JVF, 8JUD, 8JVJ still use it consistently (quantifiers, thresholds, and whether the primes may vary with x).
>
> For each, report: correct / gap / error, with the exact step and a concrete counterexample or the missing inequality. Check every numeric exponent and constant (e.g. 1/400, 1/100, theta=32/37 or 7/12, the density exponents) for consistency within the argument. Separately, list every cited external theorem as it is stated in the notes (McCurley 1984 Thm 1, Bennett-Martin-O'Bryant-Rechnitzer 2018 Prop 1.11, Thorner-Zaman Thm 1.1, Montgomery 1971 Thm 12.2, Behrend 1946), and say whether the statement matches the published theorem, flagging anything unsure. Be concise: findings only, ranked by severity. Do not edit any files.

## Step 2: known citation issues to fix before applying

- **Montgomery, Topics in Multiplicative Number Theory (LNM 227), Theorem 12.2.**
  - The notes state it as (Q^2T)^{5(1-sigma)/2}(log QT)^{14} for sigma >= 4/5.
  - Secondary sources give its main form as sum_{q<=Q} sum*_chi N(alpha,T,chi) << (Q^2T)^{3(1-alpha)/(2-alpha)} (log QT)^9 for 1/2 <= alpha <= 1 (arXiv 1804.05561, Lemma 4.16).
  - The book also has a form for alpha >= 4/5 with exponent 2(1-alpha)/alpha and (log)^{14}; this is unconfirmed.
  - Quote the theorem exactly. The notes' weaker exponent probably still suffices, but check this.
- **Thorner-Zaman, "Refinements to the prime number theorem for arithmetic progressions", arXiv 2108.10878, Theorem 1.1.** Not verified: arXiv could not be reached from the session. Check theta (7/12? 32/37?), the hypotheses, and the error term against the paper.
- **The 8JU8 change from x^{401} to x^{400}** in Chapter 4 is an unrequested mathematical edit. Confirm or revert it.

## Step 3: apply (after the proof check and the fixes)

Run these from the repository root.

1. Back up the remote database:
   ```
   npx wrangler d1 export grh-notes --remote --output backup-before-chapter3-self-contained-2026-11-27.sql
   ```
2. Test locally against that fresh backup:
   - In `scripts/check-chapter3-self-contained-2026-11-27.py`, point the base dump to the new backup.
   - Remove the chebyshev step from it, because that script is already live.
   - Run it with `python -I`.
3. Apply the script:
   ```
   npx wrangler d1 execute grh-notes --remote --yes --file scripts/chapter3-self-contained-2026-11-27.sql
   ```
   The guard rolls everything back if any row changed since the script was written.
4. Resync the "Uses / Used by" links. The site only rebuilds them via Settings → "Re-render everything", or with this tool:
   - Dump these four tables to JSON with `npx wrangler d1 execute grh-notes --remote --json --command "<query>"`:
     - `SELECT r.id, r.tag, r.statement_tex FROM results r` → rs.json
     - `SELECT p.id, p.result_id, r.tag, p.body_tex FROM proofs p JOIN results r ON r.id=p.result_id` → ps.json
     - `SELECT source_result_id, source_proof_id, target_tag FROM refs` → refs.json
     - `SELECT value FROM settings WHERE key='macros'` → mac.json
   - Run:
     ```
     node scripts/refs-sync.mts <repo-root> rs.json ps.json refs.json mac.json out.sql
     ```
     It prints the changed edges and writes `out.sql`. Apply `out.sql` with `wrangler d1 execute --remote --file`. Running it again should print "no changes".
5. Verify:
   - Open /tag/8JU7, 8JVH, 8JVK, 8JVG, C3R2, C3T2, C4S2 and C4W2, and check that no `.katex-error` appears.
   - Run the chapter-dependency scan: Chapter 3 should link to Chapter 4 only from 8JVG and the 8JU2 intro, and should cite no Adriazola or Outline.

## Still open after this

- **Black box:** 8JVG (and Chapter 4) still rest on Adriazola's Hypotheses 17.11 and 18.10. Chapter 4 is an outline.
- **Constants:** in Chapter 2, Prop 2.1.5 and Prop 2.2.5 use "absolute" constants n_0 and C without explicit values.
