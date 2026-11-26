# Prime classes and weighted counts

## Revised §2.2

| Order | Tag | Title | Role |
| --- | --- | --- | --- |
| 1 | 8JVC | Residue groups for the two averages | Defines the moduli $N_1,N$, the subgroup $U_1$, the quotient $A$, and the kernel $A_0$. |
| 2 | 8JVP | Quadratic coordinates for counting and weights | Defines $B$ and the map $\pi$ with quadratic bits at $d,q$, then gives $\Phi,f,\xi_c$. |
| 3 | 8JVQ | Prime-power classes and primitive characters | Defines $I_p,F_p$, the coset assigned to $p^i$, and the passage from $\xi\in\widehat B$ to $\xi^*$. |
| 4 | 8JU9 | The weighted prime-power count | Uses the classes and weight labels to define $S(t,a,w)$ and $M(a,w)$. |
| 5 | 8JVD | Exact Fourier expansion of the centered count | Expresses the centered count as a finite character sum of smoothed prime sums. |
| 6 | 8JVM | Prime classes modulo $840$ | Works through the three definitions and identifies the odd powers of $13$ in the count. |

The introductory text in `8JV7` places the motivation in the three paragraphs after its opening.

- The paragraph linked to `8JVC` explains how the $2$-power coordinate lets $A$ grow to accommodate the shift set $T$. It explains why the $\psi(v)=1$ condition makes $\psi$ well-defined on $A$, and why $A_0$ and its cosets govern the two §2.1 averages.
- The paragraph linked to `8JVP` explains how $\pi$ supplies independent quadratic bits. The $d$-bit selects the half counted in the arithmetic argument, and the $q$-bit distinguishes the reference-weight positions. It also explains the shifts into $\Phi$, the normalization $2/|B|=1/f$, and where the auxiliary twists are estimated.
- The paragraph linked to `8JVQ` explains why primes dividing $N$ need cosets to spread their mass and why the Fourier expansion uses primitive character values to recover the coset averages. The closing paragraph connects those averages to Chapter 1 smoothing and the main term computed in `8JVD`.

The previous links to `8JVC` now point to the definitions relevant to each use. `8JU7`, `8JVE`, `8JVK`, and proof 117 of `8JUD` cite `8JVC` and `8JVP`. `8JUC` and `8JVD` cite `8JVP` and `8JVQ`. The section intro, `8JU9`, and `8JVM` cite all three. `8JUW` adds a direct link to `8JVQ` for the character notation. The review preserved the original hypotheses, residue maps, cosets, and character conventions. The checker matched every mathematical expression and number in the modulo-$840$ example to the baseline.

## Set-builder notation

| Location | Previous form | Canonical form |
| --- | --- | --- |
| `8JVC` statement, $U_1$ | Subgroup described in prose | Displays $v\in(\mathbb Z/N_1\mathbb Z)^\times$ with $v\equiv\pm1\pmod{2^{e+2}}$ and $\psi(v)=1$. |
| `8JVP` statement, $\Phi$, moved from `8JVC` | Brace set with a colon after $((0,e_2),v)$ | The element is written as $((0,e_2),v)\in B$, followed by the original two conditions. |
| `8JUW` statement, $\mathcal H$ | Colon after $\xi\in\widehat B$ | Uses $\xi\in\widehat B$ and the condition $\xi\vert_{A_0}=1$. |
| `8JUW` statement, $\mathcal K$ | Colon after $\xi\in\mathcal H$ | Uses $\xi\in\mathcal H$ and the condition $\xi^*\in\mathcal C_\psi$. |
| `8JVK` statement, $\Phi_u$ | Colon after $((0,1),z+u)$, with $\subseteq\Phi$ outside the braces | The element is written as $((0,1),z+u)\in\Phi$, followed by $z\in T_2$. |

All five use the literal TeX delimiter `\;\middle|\;` inside `\left\{` and `\right\}`. A source scan of every intro, title, statement, and proof in Chapters 2 and 3 found four colon-form set builders in the post-coset baseline. It found five canonical builders in the patched copy and verified the enumerated sets against the baseline.

## Verification

The checker applied the backup, then the coset SQL, then the prime-classes SQL to a temporary `node:sqlite` database. It verified the guard against the pre-coset state, stale revisions for every edited row, and reapplication. Each rejection preserved both SQLite’s total change count and the database bytes. It also checked reference targets and stored edges, revision snapshots, NULL caches, `needs_rebuild=1`, and SQLite integrity. The patch updates 11 existing rows and adds results 170–171 with tags `8JVP`–`8JVQ`. The checker rendered 214 book text fields with 0 warnings.

The checker estimates display widths from KaTeX layout metrics at an 18 px body size. The six widest displays in touched text fit within the 680 px target.

| Location | Display | Estimated width |
| --- | --- | ---: |
| `8JVD` statement | Exact Fourier expansion | 587.4 px |
| `8JVE` statement | Parameters $n,h,h_2,\delta_2,Q$ | 560.5 px |
| `8JUD` proof 117 | Bound for the change in $G_{\xi^*}$ | 544.0 px |
| `8JU9` statement | Aligned weighted count and main term | 539.2 px |
| `8JVC` statement | Displayed definition of $U_1$ | 533.3 px |
| `8JVP` statement | Aligned definitions of $\Phi,f,\xi_c$ | 502.4 px |

The task checker printed `ALL CHECKS PASSED`. The sandbox returned `spawn EPERM` when `npm test` tried to start isolated test processes. All 25 repository tests passed with `node --test --test-isolation=none "test/*.test.ts"`.
