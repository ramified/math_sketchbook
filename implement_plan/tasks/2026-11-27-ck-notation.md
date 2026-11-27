# Spec: write s = c + iy in the A_k estimates (27 Nov 2026)

## Goal

In the Taylor-coefficient estimates of Sections 1.4 and 1.5, the point is now written $\sigma+i\tau$. Write it as $c+iy$, as the user asked. Rename the names that would then clash.

Read `docs/CONVENTIONS.md` first.

## Rename rules (user decisions)

| Old | New | Meaning |
|---|---|---|
| `\sigma` | `c` | the real part, the kernel parameter in $K_k(u)=u^ke^{-\sigma u}/k!$, the line $\Re s=\sigma$ |
| `\sigma_0` | `c_0` | the threshold in 8JT2 and 8JUP |
| `\tau` | `y` | the imaginary part; `d\tau` becomes `dy` |
| lower-bound constant `c` (as in `c\,d^{-k}`, `c>0`, `C/c`) | `C_1` | |
| residues `c_\rho`, `c_p`, `c_\beta`, `c_0`, `c_{p_*}`, `c_{-2n}`, and "with residue $c$" | `\operatorname{Res}_\rho`, `\operatorname{Res}_p`, `\operatorname{Res}_\beta`, `\operatorname{Res}_0`, `\operatorname{Res}_{p_*}`, `\operatorname{Res}_{-2n}`, "with residue $\operatorname{Res}_p$" | |

**Order matters.** First rename the old constant `c` and the residues `c_…`, then `\sigma` to `c`. Do not touch `C`, `C_\psi`, `C_*` or other capital-C names.

**Spacing:** write `e^{-cu}`, `c^{-k-1}`, `c-\theta`, `c+iy`, `\Re s=c`. Write "real $c$" where the text says "real $\sigma$". The step labels `\text{(c)}` and `\item[(c)]` are labels, not variables. Keep them.

## Scope (exactly these fields; current revisions are in the guard)

Section 1.4 (section 104):

| Tag | Field | Id | Revision |
|---|---|---|---|
| 8JT2 | statement | result 123 | 5 |
| 8JT2 | proof | proof 109 | 14 |
| 8JT3 | proof | proof 110 | 1 |
| 8JT4 | statement | result 125 | 2 |
| 8JT4 | proof | proof 111 | 3 |
| 8JT5 | statement | result 136 | 2 |
| 8JT5 | proof | proof 121 | 2 |
| 8JT6 | statement | result 137 | 2 |
| 8JT7 | statement | result 138 | 1 |
| 8JT8 | statement | result 139 | 1 |
| 8JT9 | statement | result 140 | 1 |
| 8JP5 | proof | proof 102 | 10 |

Section 1.5 (section 110):

| Tag | Field | Id | Revision |
|---|---|---|---|
| 8JTA | statement | result 141 | 8 |
| 8JUM | statement | result 145 | 2 |
| 8JUM | proof | proof 125 | 2 |
| 8JUP | statement | result 146 | 1 |
| 8JUP | proof | proof 126 | 1 |
| 8JUQ | proof | proof 127 | 1 |

In 8JTA, change only the A_k parts:
- panel (c) text and its title (`A_k(\frac32 + i\tau)` becomes `A_k(\frac32 + iy)`, `0 \le \tau \le 50` becomes `0 \le y \le 50`, `\tau = \gamma` becomes `y = \gamma`, `\sigma - \frac12 = 1` becomes `c - \frac12 = 1`);
- the sentence "Each pole $p$ of $H_{\mathbf 1}$, with residue $c$, contributes $c/(z - p)^{k+1}$" becomes "…with residue $\operatorname{Res}_p$, contributes $\operatorname{Res}_p/(z - p)^{k+1}$".

**Out of scope:** Chapter 3 ($\sigma_\xi$ in 8JUD, 8JU7, 8JVH), the appendix (MCV3, MCV5, MCV8 and 8JV4 keep $\sigma$ and $\tau$), and 8JS2's exponent $c_0$.

## Figures

These SVGs show $\sigma$ or $\tau$ as text:
- `public/static/figures/interval-criterion-a.svg`, `interval-criterion-b.svg` (made by `scripts/plot-interval-criterion.mjs`);
- `zeta-taylor-coefficients.svg` (made by `scripts/plot-zeta-example.mjs`).

Change only the label strings in those scripts (σ becomes italic c, τ becomes italic y, in the same style as the other italic letters there), then regenerate. The variable names in the code may stay. Confirm that no other SVG that these scripts write changes except by the regenerated labels; report the `git diff --stat`.

## Implementation

1. Write `scripts/gen-ck-notation-2026-11-27.mjs`. It reads the fields from `backup-before-taylor-coefficients-2026-11-27.sql` after applying `scripts/taylor-coefficients-definition-2026-11-27.sql` (restore the way `scripts/check-mellin-appendix-2026-11-27.mjs` does, with foreign keys off during the restore). It applies the renames with explicit, reviewable rules, and writes:
   - `scripts/ck-notation-2026-11-27.sql`:
     - a guard on every field (id, revision, and `body_tex`/`statement_tex` equal to the backup text);
     - `UPDATE … SET <field> = '<new text>'` with the full new text;
     - html caches set to NULL;
     - revision + 1;
     - `revisions` snapshots via `json_object` with the keys used in `scripts/taylor-coefficients-definition-2026-11-27.sql`;
     - `needs_rebuild` set to '1';
     - author 'claude', timestamp '2026-11-27 20:00:00';
   - `implement_plan/tasks/2026-11-27-ck-notation.review.md`: for every field, a word-level before/after diff (e.g. `git diff --no-index --word-diff=plain` on temp files), so the main session can review every change.
2. Check by hand that each changed field reads correctly. Pay particular attention to the constant `c` and residues `c_…` being renamed before `\sigma`, and to no stray `\sigma` or `\tau` being left in scope.

## Constraints

No remote DB writes, no deploy, no commit.

## Acceptance (`scripts/check-ck-notation-2026-11-27.mjs`, Node 26 `node:sqlite`)

1. Restore the backup, apply the taylor script, then the new script. A rerun is blocked by the guard.
2. **In every scoped field:**
   - no `\sigma` and no `\tau` remain;
   - no `c_\rho`, `c_p`, `c_\beta`, `c_{p_*}`, `c_{-2n}`, and no residue `c_0` remain;
   - in 8JT2 and 8JUP, `c_0` appears only as the threshold.
3. KaTeX through `src/latex.ts` renderTex (as in the earlier check scripts) gives no warnings on every scoped field.
4. The refs parsed from each field are unchanged from before.
5. Snapshots match their rows.

**Report:** files changed, the check output, the figure `git diff --stat`, and any place where a rule was ambiguous and how you resolved it.
