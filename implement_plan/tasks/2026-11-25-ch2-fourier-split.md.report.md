# Chapter 2 Fourier split

## Book structure

The four Chapter 2 sections follow the order of the calculation. The two averages are first proved without the arithmetic notation. The next sections introduce the count and the data needed to normalize it. The final section combines them. Chapter 3 follows the common-window, per-shift bound, and parameter-normalization sequence of the existing argument.

| Number | ID | Tag | Parent | Position | Kind | Title |
| --- | ---: | --- | --- | ---: | --- | --- |
| 2 | 105 | 8JU2 | — | 2 | chapter | The Fourier step |
| 2.1 | 112 | 8JV6 | 8JU2 | 1 | section | Two finite-group averages |
| 2.2 | 113 | 8JV7 | 8JU2 | 2 | section | Prime classes and weighted counts |
| 2.3 | 114 | 8JV8 | 8JU2 | 3 | section | The normalized count and its arithmetic bound |
| 2.4 | 108 | 8JU5 | 8JU2 | 4 | section | Recovering the weighted prime sum |
| 3 | 111 | 8JV5 | — | 3 | chapter | The arithmetic bound |
| 3.1 | 106 | 8JU3 | 8JV5 | 1 | section | A common interval for the auxiliary data |
| 3.2 | 107 | 8JU4 | 8JV5 | 2 | section | Bounding the centered count by theta lifts |
| 3.3 | 109 | 8JU6 | 8JV5 | 3 | section | Balancing and normalizing the errors |

In the result table, titles are the stored TeX titles. The listed column is the database's display flag.

| Section | Position | ID | Tag | Type | Listed | Title | Content |
| --- | ---: | ---: | --- | --- | ---: | --- | --- |
| 2.1 | 1 | 157 | 8JV9 | lemma | 1 | Averaging over a subgroup | A uniform subgroup mean is the indicator of trivial restriction. |
| 2.1 | 2 | 158 | 8JVA | lemma | 1 | Averaging with prescribed coset proportions | The target mean is 1 or \(1/(3o+1)\), with error at most \(or\) for per-coset error \(r\). |
| 2.1 | 3 | 159 | 8JVB | example | 1 | Ten shifts in a group with three cosets | The actual subset of \(\mathbb Z/30\mathbb Z\) gives means 1 and \(1/10\). |
| 2.2 | 1 | 160 | 8JVC | definition | 1 | The finite group of prime classes | A unit-group quotient and CRT specify the class cosets and primitive characters at all primes. |
| 2.2 | 2 | 128 | 8JU9 | definition | 1 | The weighted prime-power count | Defines \(S(t,a,w)\) and \(M(a,w)\) with the positive-part smoothing. |
| 2.2 | 3 | 161 | 8JVD | lemma | 1 | Exact Fourier expansion of the centered count | The expansion produces the primitive sums and both main-term contributions. |
| 2.2 | 4 | 168 | 8JVM | example | 0 | Prime classes modulo $840$ | Computes the quotient, the two auxiliary signs, and the class of 13. |
| 2.3 | 1 | 167 | 8JVK | lemma | 1 | Scales and weights in the chain | States the positions, widths, and cutoffs of the weight functions. |
| 2.3 | 2 | 162 | 8JVE | definition | 1 | Data for the Fourier step | Collects the window, coset proportions, weight conditions, and normalization parameters. |
| 2.3 | 3 | 163 | 8JVF | definition | 1 | The normalized centered count $D_\psi(x)$ | Defines the centered sum for each shift and its normalized mean. |
| 2.3 | 4 | 164 | 8JVG | theorem | 1 | Arithmetic bound | Gives \(D_\psi(x)\le20x^{1/2+\eta}\) uniformly on arbitrarily distant windows. |
| 2.4 | 1 | 165 | 8JVH | lemma | 1 | Analytic estimates for the auxiliary characters | Records the large-cutoff estimate and the two pointwise estimates for auxiliary characters. |
| 2.4 | 2 | 133 | 8JUE | lemma | 0 | Changing a weight at fixed scale | Integrates the derivative of the weighted smoothed sum between breakpoints. |
| 2.4 | 3 | 153 | 8JUW | definition | 1 | The auxiliary-character sum $\Sigma(x)$ | Sums the absolute contributions of the surviving twists outside the cyclic family. |
| 2.4 | 4 | 132 | 8JUD | lemma | 1 | The Fourier comparison | Derives \(\mathcal G_\psi(x)\le D_\psi(x)+4/(x\delta_2)+(3o+4)x^{1/2+\varepsilon}\). |
| 2.4 | 5 | 166 | 8JVJ | corollary | 1 | The Chapter 1 interval estimate | Combines the two bounds and absorbs the constant using \(11\varepsilon/8\) of slack. |
| 3.1 | 1 | 154 | 8JV2 | definition | 1 | The error exponents $e_D$ and $e_L$ | Records how the two exponents enter the lattice estimates. |
| 3.1 | 2 | 126 | 8JU7 | lemma | 1 | Simultaneous choice of auxiliary data | Obtains windows with a fixed pair of primes, approximated coset proportions, and compatible chain data. |
| 3.1 | 3 | 127 | 8JU8 | lemma | 0 | The cohomological length bound | Records uniform weighted length bounds used for finite-place divisibility. |
| 3.2 | 1 | 129 | 8JUA | proposition | 1 | A bound for each translate | Bounds every \(\Delta_u\) by the same arithmetic error. |
| 3.2 | 2 | 130 | 8JUB | lemma | 0 | Rank from the period matrices | Bounds the rank from a trace-square inequality. |
| 3.2 | 3 | 131 | 8JUC | lemma | 0 | Matching the main terms | Cancels the geometric normalizations and identifies the count's main term. |
| 3.3 | 1 | 134 | 8JUF | proposition | 1 | The arithmetic bound from the four errors | Divides the per-shift estimate by \(Q\delta_2/2\) and obtains the arithmetic exponent. |
| 3.3 | 2 | 135 | 8JUG | lemma | 0 | Sizes of the four normalized errors | Sizes the four terms in \(\mathcal B/Q\) with the construction's parameter inequalities. |
| 1.2 | 1 | 155 | 8JV3 | motivation | 1 | From $L'(s,\chi)/L(s,\chi)$ to the smoothed prime sum | Points to the Chapter 2 count where the smoothing kernel reappears. |
| 1.3 | 1 | 110 | 8JK2 | theorem | 1 | Arithmetic interval estimate | Keeps the exponent \(1/2+9\varepsilon\) and links to the new comparison and corollary. |

The Chapter 1 section introduction at 7HH9 points to 8JU2 for the Fourier deduction and to 8JV5 for the arithmetic proof outline. The reference to 8JU4 in 8JV3 now points to 8JU9, where the kernel appears. The revised 8JUW points to the Chapter 2 data and definition of the finite group. All prior document IDs, tags, aliases, and proof owners are retained. Rewritten proofs use the AI-generated status and GPT provenance, with prior versions in revision history.

## The normalization

At an admissible scale, \(p_t(g)=g+((1,1),t)\) permutes the weight labels across the counted classes. The second shift, \(u\), moves the large-weight positions along \(A_0\). For a given choice of data at \(x\), the definition is

\[
\begin{aligned}
\Delta_u&=\sum_{t\in T}\sum_{j=1}^m
\bigl(S(t,a_t,w_{u,j})-\Re M(a_t,w_{u,j})\bigr),\\
D_\psi(x)&=\frac{2}{Q\delta_2}\frac{1}{|A_0|}
\sum_{u\in A_0}\Delta_u .
\end{aligned}
\]

The main term is the real part of the explicit \(M(a_t,w_{u,j})\) from 8JU9. Every pair \((t,j)\) enters the sum with weight one, and the subgroup average gives each \(u\) weight \(1/|A_0|\). After replacing the large weights by \(b\), each pair contributes \(b h_2/f\) per surviving character before its phase and coset coefficient. Thus the common coefficient, including the one on the trivial character, is

\[
hm\,\frac{b h_2}{f}
= hmb\,\frac{h_2}{2n}
= \frac{Q\delta_2}{2}.
\]

The division accounts for the factor \(h\) implicit in the sum over \(t\). The resulting coefficients on the retained characters are the proportions calculated in 8JVA, with the discrepancy estimated in 8JUD.

## Formula and proof audit

I used `pdftotext` on both references. The page numbers below are their printed page numbers.

| Item | Treatment and source |
| --- | --- |
| Subgroup and coset averages | Full permutation arguments and the triangle inequality. The coset computation and discrepancy agree with Adriazola, Lemma 5.18, p. 38, and the Outline, §10, p. 10. The example is a direct finite calculation. |
| Group and local coefficients | CRT definition and full local and dual orthogonality proofs. Adriazola, Proposition 5.14, pp. 34–35, gives the quotient and its signs. Proposition 3.3, pp. 13–14, and Outline §§11–12, pp. 11–12, give the primitive-character convention and the coset count. |
| Smoothing and centering | Full derivation using the Chapter 1 \(R_\chi-G_\chi\) identity, Adriazola (2.1), (5.1), and (3.9)–(3.10), and Outline §12, p. 12. The weight-independent linear terms survive only at the first-coordinate sign. |
| Common windows and interface | Inputs from Adriazola, Theorem A and §6.3, pp. 42–44, Definition 18.1 and Proposition 18.4, pp. 269–272, and Outline §§3, 9–11. The weight intervals and scale bounds are from (5.17), Proposition 5.16, and Definition 18.5 through Corollary 18.8, pp. 35–37, 272–274. |
| Large cutoff and twist estimates | Cited analytic inputs. Adriazola, Theorems 5.10 and 5.12, pp. 30 and 33, and §6.3, pp. 43–44, and Outline §§11, 13, pp. 11, 13, supply the uniform decay, the pointwise bound, and the logarithmic-derivative bound. The \(q,d\) factor for each auxiliary character is derived directly from the group coordinates. |
| Changing weights and cutoffs | The weight derivative and finite-breakpoint integration are proved in full, using the classical Chebyshev estimate quoted in Adriazola, Lemma 4.1, p. 15, and Outline §13, p. 13. The cutoff derivative uses partial summation of that same estimate. It needs no additional Mertens estimate. |
| Full Fourier comparison | The replacements, two averages, subgroup character count, sign, and normalization are proved in 8JUD. The calculation follows the structure of Adriazola, Theorem 4.2 and Corollary 4.4, pp. 16–18, and Outline §§13–14, pp. 13–14. The explicit normalized cutoff and coset errors are derived there from the stated data. |
| Arithmetic estimate and Chapter 1 deduction | The Chapter 3 outline cites the deep chain-record and lattice inputs. The normalization and exponent calculation are elementary and shown in 8JUF and 8JUG. Compare Adriazola, Proposition 4.3, pp. 17–18, Theorem A, pp. 42–43, and Definition 18.9 through §18.6, pp. 274–281, with Outline §§12, 14. The deduction of 8JK2 is fully shown in 8JVJ. |

## Corrections and editorial decisions

- The quotient has \(|B|=4n\) and \(|\Phi|=f=2n\). The local coefficient is \(2/|I_p|\) on the indicated coset. The CRT proof gives \(\xi^*(p^i)\) exactly, including when \(p\mid N\). At \(p=d\) one of the two coset elements lies outside \(\Phi\), giving coefficient \(1\), as in Proposition 3.3.
- I use \(N\) for the auxiliary modulus and \(N_0\) for the fixed conductor, so \(M(a,w)\) denotes the main-term function throughout Chapter 2. The exact expansion uses cutoffs \(a/w_\alpha\ge1\), the domain of \(G_\chi\) in Chapter 1. The weight data ensure that domain at every use of the expansion.
- The sign contribution to the main term is \(+aL'(1,\xi_c^*)/L(1,\xi_c^*)\). The minus sign in the nontrivial \(M_\chi\) meets the coefficient \(-1\) from the complement of \(\Phi\). This is a first logarithmic derivative.
- The old \(4o\) bound was safe but counted all survivors. There are \(4o\) survivors and exactly \(3o\) auxiliary terms. The eventual \(4x^{1/2+\varepsilon}\) in the new comparison comes from bounding \(4oL_x\) and the separate coset error \(o x^{-1+\varepsilon}\sum_{\xi\in\mathcal K}|G_{\xi^*}(x)|\). Their growth is logarithmic and \(O_\psi(x^\varepsilon(1+\ln x)^2)\), respectively.
- I used the explicit width \(\rho_w=W+mh_0\) from Adriazola for the large weights. This avoids conflating the outline's \(\eta+1\) allowance for the nodes with the requested bound's exponent margin \(\eta\).
- Adriazola gets \(C=3\) for the excess using \(\max(2,e_D,e_L+1)+1\). The Outline uses \(C=e_D+e_L+3=5\). I retained the book's conservative exponent accounting. Adding \(13/8\) from \(\mathcal B/Q\) and \(1\) from \(\delta_2^{-1}\) yields \(61/8\), leaving \(11/8\) of \(\varepsilon\) to absorb the constant in 8JK2.
- In the common-window description, \(T\) is the set satisfying the proportions in Proposition 5.20. The auxiliary subset \(T_2\) used to place the large weights uses the separate construction in Proposition 5.17.

## Points for editorial review

- Adriazola §18.3, p. 277, leaves the passage from the section estimates to the uniform constants and exponents of Hypothesis 18.10 unchecked. The paper's Theorem A assembly also invokes Hypothesis 17.11, p. 251. Chapter 3 cites these deep inputs and the Lean development. The chain-record hypotheses and the Lean source remain outside this independent check.
- The Outline gives the cohomological \(401\) cutoff in §11 for the rescaling and describes the ledger for the four errors. Chapter 3 retains the existing summary of the cohomological estimate and the geometric main-term comparison. Their scale-level identities were checked against the references, and the underlying local-global matching and identification of all individual period normalizations remain cited inputs.
- Adopting Adriazola's stronger exponent is an editorial choice for the main session. This split retains the existing \(9\varepsilon\) margin in Chapter 1.

## Round 1 verification

The checker applied the migration to a temporary `node:sqlite` database imported from the designated backup and printed `ALL CHECKS PASSED`. The stale proof revision and the second application both failed the guard without writes. It checked the section and result layout, links and reference edges, revision snapshots, cache invalidation, and the rebuild flag. It rendered 10 section intros, 22 result statements and titles, and 13 proofs with zero TeX warnings. The backup's rebuild flag was already set.

Display widths are estimates from the KaTeX layout tree and glyph metrics, with the book's 18 px body size and KaTeX's 1.21 multiplier. The checker measured the full width of each aligned display, including its column gaps.

| Display | Estimated width |
| --- | ---: |
| 8JVD, exact centered Fourier sum | 587.4 px |
| 8JVH, decay estimate and its normalized error budget | 581.9 px |
| 8JVE, the five normalization parameters | 560.5 px |
| 8JVF, the definitions of \(\Delta_u\) and \(D_\psi(x)\) | 558.1 px |
| 8JUD proof, the bound using \(L_x\) | 544.0 px |
| 8JU9, the count and its main term | 539.2 px |

All 25 repository tests passed with `NODE_OPTIONS=--test-isolation=none`. The default subprocess isolation hit Windows `spawn EPERM` in this workspace.

## Round 2 changes

- §2.3 now starts with 8JVK, so readers have the scales and weight functions before 8JVE defines the Fourier data. Its proof cites Adriazola, Definition 18.5, Propositions 5.16, 5.17, and 18.7, and Corollary 18.8 (pp. 35–37, 272–274). It points to 8JU7 for the construction. §3.2 links back to 8JVK, and its three remaining results occupy positions 1–3.
- The Chapter 2 introduction now introduces the windows before the inequalities. §2.3 traces a term of weight \(w\) to cutoff \(a_t/w\). On \(\Phi_u\), the cutoff is near \(x\), and at the other positions it is at least \(X'/3\), where 8JVH(i) bounds the contribution. The introduction explains why the subgroup shift \(u\) filters the characters and why the coset proportions of \(t\) give the Chapter 1 weights. It derives the denominator \(hm\cdot bh_2/f=Q\delta_2/2\) from the number of pairs, the number of positions, the reference weight, and the Fourier coefficient.
- §2.2 explains what the real cyclotomic residues, the value of \(\psi\), and the two quadratic signs record. The unlisted example 8JVM uses the quadratic character modulo 5 and \(e=1,q=3,d=7\). Hand calculation and independent enumeration agree that \(U_1=\{1,9,31,39\}\) among the 16 units modulo 40, with \(|A|=4\) and \(A_0=\{(0,0),(1,0)\}\) in the example's coordinates. Thus \(|B|=16\) and \(|\Phi|=8\). The prime 13 has residues \(6\bmod7\), \(1\bmod3\), \(5\bmod8\), and \(3\bmod5\), which give \(F_{13}=((1,0),(1,1))\).
- 8JVJ bounds \(4/(x\delta_2)\) by \(4x^{1/2+\varepsilon}\), which makes the Fourier error constant \(3o+8\). The window starts beyond the thresholds for the Fourier comparison, the weight bounds, the analytic estimates, and the arithmetic estimate, as well as the threshold for absorbing the combined constant \(3o+28\). 8JVH calls its logarithmic-derivative constant \(C_{\rm twist}(\psi,\varepsilon)\). 8JUF now states its quantifiers explicitly, and the §3.2 divisibility example uses \(K\) for the integer.
- The checker resolves aliases and checks Chapter 2 titles, introductions, statements, and proofs for Chapter 3 references. The allowed links are the Chapter 3 overview in introductions and the cited arithmetic sources in the proofs of 8JVG and 8JVK.

The checker rebuilt a temporary SQLite database from the designated backup and printed `ALL CHECKS PASSED`. The guard rejected both the stale baseline and the second application without writes. The checker verified 10 section introductions, 24 result statements and titles, and 13 proofs with zero TeX warnings. The widest display was the centered Fourier expansion in 8JVD at an estimated 587.4 px. The six widest displays and their estimates are the same as in the Round 1 table.

All 25 repository tests passed with `NODE_OPTIONS=--test-isolation=none`. The default test run hit Windows `spawn EPERM` while starting the test subprocesses.
