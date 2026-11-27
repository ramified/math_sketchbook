# Spec: Mellin inversion in Appendix A (27 Nov 2026)

## Goal

Add the theorem "Mellin inversion" (new tag `MCV8`) to Section A.1 (tag APXS, section id 119), right after the example MCV4. Link the phrase "Mellin inversion" in 8JV3 to it.

Read `docs/CONVENTIONS.md` first.

## Current state (remote, already applied)

APXS contains, by position:

| Position | Tag | id | Revision |
|---|---|---|---|
| 1 | 8JS2 | 115 | 4 |
| 2 | MCV4 | 191 | 2 |
| 3 | MCV2 | 189 | 1 |
| 4 | MCV3 | 190 | 1 |
| 5 | MCV5 | 192 | 2 |
| 6 | MCV6 | 193 | 2 |
| 7 | MCV7 | 194 | 2 |
| 9 | 8JS8 (unlisted) | 121 | |

MCV9 is retired. 8JV3 is at revision 4.

## File

**New** `scripts/mellin-inversion-2026-11-27.sql`. Follow `scripts/mellin-appendix-2026-11-27.sql` and `scripts/mellin-appendix-reorder-2026-11-27.sql`: the guard, the `revisions` snapshot keys, `json_object` snapshots, caches set to NULL, a `tags` row, `refs`, and `needs_rebuild`. Use author 'claude' and the timestamp '2026-11-27 16:00:00'. For the proof row use `status 'ai_generated'`, `generated_by 'claude'`, `generator_detail 'Claude Opus 5.5'`, position 1.

**Guard:** abort unless
- every row in the table above has the stated tag, id, revision and position;
- 8JV3 is at revision 4 and contains the exact phrase `otherwise Mellin inversion would make`;
- the tag `MCV8` does not exist.

**Changes:**
1. Shift MCV2, MCV3, MCV5, MCV6 and MCV7 up by one position (to 4, 5, 6, 7, 8). Bump each revision and write snapshots.
2. Insert MCV8 at position 3: type 'theorem', title `Mellin inversion`, published, active, listed. Add its proof.
3. In 8JV3, replace `otherwise Mellin inversion would make` with `otherwise \hyperref[MCV8]{Mellin inversion} would make`. Only the first occurrence; use `replace` on that exact phrase. Bump the revision, clear the cache, write the snapshot.
4. Refs: MCV8 statement → 8JS2, 8JV4; MCV8 proof → 8JS8; 8JV3 statement → MCV8 (add it to the existing edges).

### MCV8 statement
```tex
Let $f$ be as in the \hyperref[8JS2]{definition of the Mellin transform}, with exponent $c_0$, and let $c>c_0$ be real such that $\mathcal M f$ is \hyperref[8JV4]{absolutely integrable on $\Re s=c$}. Put
\[
I\colon(0,\infty)\longrightarrow\C,\qquad x\longmapsto\frac1{2\pi i}\int_{c-i\infty}^{c+i\infty}(\mathcal Mf)(s)\,x^s\,ds.
\]
Then $I$ is continuous and vanishes on $(0,1)$, and $I(x)=f(x)$ for almost every $x\ge1$ and for every $x>1$ at which $f$ is continuous.
```

### MCV8 proof
```tex
Put $\varphi(u)=f(e^u)\,e^{-cu}$ for $u\ge0$ and $\varphi(u)=0$ for $u<0$. Then $\varphi$ is integrable on $\R$ by \hyperref[8JS8]{absolute convergence}, and the substitution $x=e^u$ gives
\[
(\mathcal Mf)(c+i\tau)=\int_{-\infty}^{\infty}\varphi(u)\,e^{-i\tau u}\,du=\hat\varphi(\tau).
\]
By hypothesis $\hat\varphi$ is integrable, so by the Fourier inversion theorem $\check\varphi(u)=\frac1{2\pi}\int_{-\infty}^{\infty}\hat\varphi(\tau)\,e^{i\tau u}\,d\tau$ is continuous and equals $\varphi$ almost everywhere. With $s=c+i\tau$ we have $ds=i\,d\tau$, hence
\[
I(x)=x^c\,\check\varphi(\ln x).
\]
So $I$ is continuous, $I(x)=f(x)$ for almost every $x\ge1$, and $I=0$ almost everywhere on $(0,1)$, hence everywhere there. If $f$ is continuous at $x>1$, then $I$ and $f$ are continuous at $x$ and agree almost everywhere near $x$, so $I(x)=f(x)$.
```

## Constraints

No remote DB writes, no deploy, no commit. Copy the TeX verbatim. Do not change other rows.

## Acceptance

**`scripts/check-mellin-inversion-2026-11-27.mjs`** (Node 26, `node:sqlite`):
1. Restore `backup-before-mellin-appendix-reorder-2026-11-27.sql` (repo root, gitignored). Its state is right before the reorder script. Restore it the way `scripts/check-mellin-appendix-2026-11-27.mjs` restores its backup: foreign keys off during the restore, then on.
2. Apply `scripts/mellin-appendix-reorder-2026-11-27.sql`, then the new script.
3. **Assert:**
   - APXS order: 8JS2, MCV4, MCV8, MCV2, MCV3, MCV5, MCV6, MCV7, with positions 1 to 8, and 8JS8 at 9;
   - snapshots match their rows;
   - a rerun is blocked by the guard;
   - the refs equal the targets parsed by `src/latex.ts` renderTex (as in `scripts/check-mellin-appendix-2026-11-27.mjs`) for MCV8's statement and proof and for 8JV3's statement;
   - renderTex/KaTeX gives no warnings on those fields, using the stored macros.

Report the files changed and the check output.
