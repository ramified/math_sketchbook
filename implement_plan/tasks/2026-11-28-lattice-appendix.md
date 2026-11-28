# Spec: Appendix B "Lattices, slopes and theta series" (28 Nov 2026)

## Goal

Add a second appendix chapter to the book (remote D1 `grh-notes`): the background on lattices, slopes, the
Bost slope inequality, Hermitian lattices over CM fields, theta series and theta lifts that Chapters 2 and 4 use
(Q7MN, Q7MQ, 8JUA, 8JU4, C4W2, 8JV2). Readers are bachelor students: B.1–B.3 work over $\Z$ and need only linear
algebra; B.4–B.6 need basic algebraic number theory and Fourier analysis.

The user approved this outline. Write the TeX yourself from the mathematical content below. **Read
`docs/CONVENTIONS.md` first and follow it strictly** (no reasoning inside definitions/statements; one claim per
part with matching `\emph{(i)}` proof paragraphs; short proofs on the key step; typed variables and quantifiers
before displays; aligned chains with right-column labels; maps on one row with `\colon`/`\longmapsto`;
set-builder `\left\{\;\middle|\;\right\}`; `\ln`, `\le`; examples unlisted and linked from the result they
illustrate). Keep every display narrower than the ~680 px text column (short lines, no long text in displays).
Unsupported: `\ref` inside math, `\label`/`\eqref`. Math is allowed in `\hyperref` words.

The work is split into **two parts, done in two separate runs**. This run does only the part named in the
message that started it.

## Common rules for both SQL scripts

Follow `scripts/mellin-appendix-2026-11-27.sql` (and `scripts/chapter2-lattice-blackboxes-2026-11-28.sql`):
- guard at the top: `INSERT OR ROLLBACK INTO write_guard (ok) SELECT 0 WHERE ...`;
- `tags` rows for every new tag, `aliases` rows for the aliases listed below;
- `revisions` rows for every new or changed section/result/proof/setting, snapshots built with SQLite
  `json_object(...)` from the rows after the change, with exactly the snapshot keys `src/store.ts` uses
  (results and proofs include `understanding`; result snapshots include `listed` and `aliases`); for changed
  existing rows, also insert the baseline snapshot of the current revision with `INSERT OR IGNORE` as earlier
  scripts do;
- all `*_html_cache` of new or changed rows NULL; `refs` rows for every `\ref`/`\hyperref` target in each new or
  changed statement/proof (statement refs: `source_proof_id` NULL), computed with the site renderer;
- `settings.needs_rebuild = '1'`;
- author/updated_by/created_by `'codex'`; timestamps `'2026-11-28 15:00:00'` (part 1) and
  `'2026-11-28 15:30:00'` (part 2); operation ids `lattice-appendix-part1-2026-11-28` and
  `lattice-appendix-part2-2026-11-28`;
- new results: `visibility 'published'`, `state 'active'`; **do not set `understanding`** (the default
  `'unclear'` keeps them folded for readers, as intended); proofs: `status 'ai_generated'`,
  `generated_by 'gpt'`, `generator_detail 'Codex (spec by Claude Opus 5.5)'`, one proof row per result that
  has a proof, position 1;
- never change any text other than what this spec names. Do not touch rows whose latest revision author is
  `admin`.

Baseline: `backup-before-lattice-appendix-2026-11-28.sql` (repo root, gitignored, exported 2026-11-28 12:05;
already contains migrations 0004 and 0005). Look up ids and current revisions there.

Tags never use the characters 0, O, 1, I, L. The guard of each part must abort if any of its new tags or aliases
already exists.

## Bibliography (part 1)

Append to the `bibliography` setting (revision bump + setting revision row as in
`scripts/ch2-error-exponents-2026-11-25.sql`; guard on its current revision):

```tex
\bibitem{Zhang} R. Zhang, \emph{A preliminary note on Alpöge's proposed proof of the generalized Riemann hypothesis}, 22 November 2026.
\bibitem{Bost2001} J.-B. Bost, \emph{Algebraic leaves of algebraic foliations over number fields}, Publ. Math. IHÉS 93 (2001), 161–221.
\bibitem{Stuhler1976} U. Stuhler, \emph{Eine Bemerkung zur Reduktionstheorie quadratischer Formen}, Arch. Math. (Basel) 27 (1976), 604–610.
\bibitem{Grayson1984} D. R. Grayson, \emph{Reduction theory using semistability}, Comment. Math. Helv. 59 (1984), 600–634.
\bibitem{Serre1973} J.-P. Serre, \emph{A Course in Arithmetic}, Graduate Texts in Mathematics 7, Springer, 1973.
\bibitem{Weil1964} A. Weil, \emph{Sur certains groupes d'opérateurs unitaires}, Acta Math. 111 (1964), 143–211.
\bibitem{Cassels1978} J. W. S. Cassels, \emph{Rational Quadratic Forms}, Academic Press, 1978.
\bibitem{Siegel1935} C. L. Siegel, \emph{Über die analytische Theorie der quadratischen Formen}, Ann. of Math. 36 (1935), 527–606.
\bibitem{Gross1999} B. H. Gross, \emph{Algebraic modular forms}, Israel J. Math. 113 (1999), 61–93.
\bibitem{Kudla1984} S. S. Kudla, \emph{Seesaw dual reductive pairs}, in: Automorphic Forms of Several Variables (Katata, 1983), Progr. Math. 46, Birkhäuser, 1984, 244–268.
```

## Part 1 — chapter, B.1–B.3, bibliography (`scripts/lattice-appendix-part1-2026-11-28.sql`)

### Chapter and sections

- Chapter tag `APXB`, kind `chapter`, `appendix = 1`, `position = 101`, title `Lattices, slopes and theta series`.
  Intro (2–3 sentences): collects the facts on lattices and theta series behind the lattice comparison of
  \ref{Q7MK} and the outline in \ref{8JV5}; B.1–B.3 work over $\Z$ and need only linear algebra; B.4–B.6 add
  CM fields and theta series.
- Sections (parent APXB): `BSE2` "Euclidean lattices" (pos 1), `BSE3` "Degree and slopes" (pos 2),
  `BSE4` "The slope inequality" (pos 3). Part 2 adds `BSE5`, `BSE6`, `BSE7`. Each intro: one or two sentences
  saying what the section computes and which main-chapter result uses it (BSE3: the slope that replaces
  $\ln|N|$ in \ref{WJQV}; BSE4: the size bound in \ref{Q7MQ} and step (2) of \ref{8JUA}).

Notation for the whole appendix: a Euclidean lattice $L$, $L_\R=L\otimes_\Z\R$, $|x|=\langle x,x\rangle^{1/2}$,
$\operatorname{covol}$, $\widehat{\deg}$ (write `\widehat{\deg}`), $\mu$, $\mu_{\max}$, $\mu_{\min}$, $\|\varphi\|$,
$h(\varphi)$.

### B.1 Euclidean lattices (section BSE2)

| pos | tag | type | listed | title | alias |
|---|---|---|---|---|---|
| 1 | KA22 | definition | 1 | Euclidean lattice | euclidean-lattice |
| 2 | KA23 | lemma | 0 | The covolume does not depend on the basis | |
| 3 | KA25 | definition | 1 | Sublattices and quotient lattices | |
| 4 | KA26 | definition | 1 | The dual lattice | dual-lattice |
| 5 | KA27 | lemma | 1 | Covolumes of sublattices, quotients and duals | |
| 6 | KA24 | example | 0 | The hexagonal lattice $A_2$ | |

- **KA22.** A Euclidean lattice is a pair $(L,\langle\cdot,\cdot\rangle)$: $L$ a free $\Z$-module of finite rank
  $n\ge0$, $\langle\cdot,\cdot\rangle$ a positive definite symmetric bilinear form on $L_\R$. For a basis
  $e_1,\dots,e_n$, Gram matrix $G=(\langle e_i,e_j\rangle)_{i,j}$ and
  $\operatorname{covol}(L)=(\det G)^{1/2}$, which \hyperref[KA23]{does not depend on the basis}; covol $=1$ if
  $n=0$. Example: $\Z^n$ with the standard product has covolume $1$. Link the example KA24 at the end.
- **KA23** (unlisted). (i) independence of the basis; (ii) $\operatorname{covol}(L)$ is the Lebesgue volume of
  the parallelotope $\{\sum t_ie_i : 0\le t_i<1\}$ in orthonormal coordinates of $L_\R$. Proof: (i) a change of
  basis $U\in\mathrm{GL}_n(\Z)$ gives $U^{\mathsf T}GU$ and $\det U=\pm1$; (ii) $G=A^{\mathsf T}A$ for the
  coordinate matrix $A$.
- **KA25.** A sublattice of $L$ is a subgroup $L'\subset L$ with the restriction of $\langle\cdot,\cdot\rangle$
  to $L'_\R\subset L_\R$. It is saturated if $L'=L\cap L'_\R$. For saturated $L'$ the quotient lattice
  $L/L'$ is the group $L/L'$ with the inner product transported by the orthogonal projection
  $\pi\colon L_\R\to(L'_\R)^\perp$ (so $|x+L'|=|\pi(x)|$ is the distance from $x$ to $L'_\R$).
- **KA26.** $L^\vee=\left\{y\in L_\R \;\middle|\; \langle y,x\rangle\in\Z \text{ for every } x\in L\right\}$
  with the restricted inner product.
- **KA27.** (i) For a sublattice $L'$ of rank $n$: $\operatorname{covol}(L')=[L:L']\operatorname{covol}(L)$.
  (ii) For saturated $L'$: $\operatorname{covol}(L)=\operatorname{covol}(L')\operatorname{covol}(L/L')$.
  (iii) $\operatorname{covol}(L^\vee)=\operatorname{covol}(L)^{-1}$ and $(L^\vee)^\vee=L$. Link KA24.
  Proofs: (i) elementary divisors: a basis $e_i$ of $L$ and integers $d_i\ge1$ with $(d_ie_i)$ a basis of $L'$;
  Gram matrix $DGD$, index $\prod d_i$. (ii) a basis of $L'$ extends to one of $L$ (as $L/L'$ is torsion free);
  the Gram determinant factors as $\det G'$ times the Gram determinant of the projections $\pi(e_{r+1}),\dots$
  (base times height). (iii) the dual basis $e_i^\vee$ is a basis of $L^\vee$ with Gram matrix $G^{-1}$.
- **KA24** (unlisted). $A_2=\Z e_1+\Z e_2\subset\R^2$, $e_1=(\sqrt2,0)$, $e_2=(1/\sqrt2,\sqrt{3/2})$; Gram
  $\begin{pmatrix}2&1\\1&2\end{pmatrix}$, covolume $\sqrt3$; dual Gram
  $\tfrac13\begin{pmatrix}2&-1\\-1&2\end{pmatrix}$, covolume $1/\sqrt3$; $2A_2$ has index $4$ and covolume
  $4\sqrt3$; $\Z e_1$ is saturated with covolume $\sqrt2$ and the quotient has covolume $\sqrt{3/2}$ (distance of
  $e_2$ to $\R e_1$), and $\sqrt2\cdot\sqrt{3/2}=\sqrt3$.

### B.2 Degree and slopes (section BSE3)

| pos | tag | type | listed | title | alias |
|---|---|---|---|---|---|
| 1 | KB22 | definition | 1 | Arakelov degree and slope | arakelov-degree |
| 2 | KB23 | motivation | 1 | An integer as a rank-one lattice | |
| 3 | KB24 | lemma | 1 | Degrees of sublattices, quotients and duals | |
| 4 | KB2B | lemma | 0 | A norm-decreasing isomorphism raises the degree | |
| 5 | KB25 | definition | 1 | Maximal and minimal slopes | |
| 6 | KB26 | lemma | 0 | Finiteness of sublattices of large degree | |
| 7 | KB28 | lemma | 0 | Degrees of sums and intersections | |
| 8 | KB29 | lemma | 1 | The maximal destabilizing sublattice | |
| 9 | KB27 | theorem | 1 | The Harder–Narasimhan filtration | harder-narasimhan |
| 10 | KB2C | definition | 1 | Harder–Narasimhan slopes | |
| 11 | KB2D | lemma | 1 | The pieces above a threshold | |
| 12 | KB2E | example | 0 | Two orthogonal vectors, and $A_2$ | |

- **KB22.** $\widehat{\deg}(L)=-\ln\operatorname{covol}(L)$; for $n\ge1$, $\mu(L)=\widehat{\deg}(L)/n$.
  For $v\ne0$: $\widehat{\deg}(\Z v)=-\ln|v|$. Cite \cite{Stuhler1976} and \cite[Section 4.3]{Zhang} for this
  normalization (in a sentence after the definition, no reasoning).
- **KB23** (motivation, no proof). \ref{WJQV} compares two bounds for $\ln|N|$, $N\in\Z\smallsetminus\{0\}$.
  In $\Z\subset\R$ with the standard metric, $N\Z$ has $\widehat{\deg}(N\Z)=-\ln|N|$ and index $|N|$; for an
  integer $m\ge1$ with $m\mid N$, $N\Z\subset m\Z$ and $\widehat{\deg}(m\Z)=-\ln m$. Divisibility is an inclusion
  of lattices and size is a degree; \ref{8V4M} becomes $\widehat{\deg}(N\Z)\le\widehat{\deg}(m\Z)$ via
  KB24(i). \ref{Q7MN} replaces $\Z$ by lattices of large rank, where the two bounds are compared through slopes
  (\ref{KC24}).
- **KB24.** (i) $L'$ of rank $n$: $\widehat{\deg}(L')=\widehat{\deg}(L)-\ln[L:L']$.
  (ii) $L'$ saturated: $\widehat{\deg}(L)=\widehat{\deg}(L')+\widehat{\deg}(L/L')$ (so $\mu(L)$ is the
  rank-weighted mean of $\mu(L')$ and $\mu(L/L')$ when both ranks are positive).
  (iii) $\widehat{\deg}(L^\vee)=-\widehat{\deg}(L)$, $\mu(L^\vee)=-\mu(L)$. Proofs: $-\ln$ of KA27.
- **KB2B** (unlisted). Euclidean lattices $E,F$ of rank $n$, a group isomorphism $\psi\colon E\to F$ with
  $\|\psi_\R\|\le e^h$ for a real $h$. Then $\widehat{\deg}(F)\ge\widehat{\deg}(E)-nh$. Proof: in orthonormal
  coordinates $\operatorname{covol}(F)=|\det\psi_\R|\operatorname{covol}(E)$ (KA23(ii)), and
  $|\det\psi_\R|\le\|\psi_\R\|^n$ (product of singular values).
- **KB25.** For $n\ge1$: $\mu_{\max}(L)=\max\mu(L')$ over nonzero saturated $L'\subset L$;
  $\mu_{\min}(L)=\min\mu(L/L')$ over saturated $L'\ne L$; these \hyperref[KB26]{exist}. $L$ is semistable if
  $\mu_{\max}(L)=\mu(L)$.
- **KB26** (unlisted). For each integer $1\le r\le n$ and real $c$ there are finitely many saturated
  $L'\subset L$ of rank $r$ with $\widehat{\deg}(L')\ge c$; so the max and min in KB25 are attained. Proof:
  $\Lambda^rL$ with $\langle x_1\wedge\dots\wedge x_r,y_1\wedge\dots\wedge y_r\rangle=\det(\langle x_i,y_j\rangle)$
  is a Euclidean lattice; a basis $f_1,\dots,f_r$ of $L'$ gives $f_1\wedge\dots\wedge f_r$ of norm
  $\operatorname{covol}(L')$, which determines $L'_\R$, hence $L'=L\cap L'_\R$; a lattice has finitely many vectors
  of bounded norm. For the min use $\mu(L/L')=(\widehat{\deg}L-\widehat{\deg}L')/(n-r)$.
- **KB28** (unlisted). Saturated $A,B\subset L$: $A\cap B$ is saturated and
  $\widehat{\deg}(A+B)\ge\widehat{\deg}(A)+\widehat{\deg}(B)-\widehat{\deg}(A\cap B)$ ($A+B$ with the metric of
  $L$). Proof: $A/(A\cap B)\to(A+B)/B$ is a group isomorphism that does not increase norms (distance to
  $(A\cap B)_\R$ is at least distance to $B_\R$); apply KB2B with $h=0$ and KB24(ii) twice.
- **KB29.** For $n\ge1$ there is a unique saturated $L_{\rm des}\subset L$ with
  $\mu(L_{\rm des})=\mu_{\max}(L)$ containing every saturated sublattice of slope $\mu_{\max}(L)$. Proof: take
  $A$ of slope $\mu_{\max}$ of maximal rank; for $B$ of slope $\mu_{\max}$, KB28 and
  $\widehat{\deg}(A\cap B)\le\mu_{\max}\operatorname{rk}(A\cap B)$ give that the saturation of $A+B$ has slope
  $\ge\mu_{\max}$; maximality of the rank forces it to equal $A$, so $B\subset A$. One aligned chain.
- **KB27.** Define $L_0=0$ and $L_{i+1}$ = preimage in $L$ of $(L/L_i)_{\rm des}$ until $L_k=L$.
  (i) $0=L_0\subsetneq\dots\subsetneq L_k=L$ are saturated, each $L_i/L_{i-1}$ is semistable, and
  $\mu(L_1/L_0)>\dots>\mu(L_k/L_{k-1})$.
  (ii) $\mu_{\max}(L)=\mu(L_1)$ and $\mu_{\min}(L)=\mu(L/L_{k-1})$.
  (iii) For $1\le i\le k$ the filtration of $L_i$ constructed in the same way is $L_0,\dots,L_i$, and that of
  $L/L_i$ is $(L_j/L_i)_{j\ge i}$.
  Cite \cite{Stuhler1976,Grayson1984}. Link KB2E. Proofs: (i) semistability from KB29; strict decrease: if
  $\mu(L_{i+1}/L_i)\ge\mu(L_i/L_{i-1})$, then $L_{i+1}/L_{i-1}$ has slope $\ge\mu_{\max}(L/L_{i-1})$ and is not
  contained in $L_i/L_{i-1}$, against KB29. (iii) quotient: by construction; $L_i$: $L_1\subset L_i$ and
  $\mu_{\max}(L_i)\le\mu(L_1)$, so $(L_i)_{\rm des}=L_1$, then induct. (ii) $\mu_{\max}$ by definition; for
  $\mu_{\min}$: "$\le$" from the quotient $L/L_{k-1}$; "$\ge$" by induction on $k$: for a saturated $M\ne L$ let
  $S$ be the saturation of $L_1+M$; then $\widehat{\deg}(L/M)=\widehat{\deg}(L/S)+\widehat{\deg}(S/M)$,
  $\widehat{\deg}(S/M)\ge\widehat{\deg}(L_1/(L_1\cap M))$ by KB28, the quotient $L_1/(L_1\cap M)$ of the
  semistable $L_1$ has slope $\ge\mu(L_1)$ (when nonzero), and $L/S$ is a quotient of $L/L_1$, whose last
  slope is $\mu(L/L_{k-1})$; ranks add since $S_\R=(L_1)_\R+M_\R$. Use a short `\emph{(1)}`/`\textbf{}` step
  structure here; it is the longest proof of part 1.
- **KB2C.** With the filtration of KB27, the HN slopes $\mu_1(L)\ge\dots\ge\mu_n(L)$ list each
  $\mu(L_i/L_{i-1})$ with multiplicity $\operatorname{rk}(L_i/L_{i-1})$. For real $t$, $L_{\ge t}$ is the largest
  $L_i$ with $\mu(L_i/L_{i-1})\ge t$, and $L_{\ge t}=0$ if there is none.
- **KB2D.** For real $t$: (i) $\sum_j\mu_j(L)=\widehat{\deg}(L)$; (ii)
  $\operatorname{rk}L_{\ge t}=\#\{j \mid \mu_j(L)\ge t\}$; (iii) if $L_{\ge t}\ne0$ then
  $\mu_{\min}(L_{\ge t})\ge t$; (iv) if $L_{\ge t}\ne L$ then $\mu_{\max}(L/L_{\ge t})<t$. Proofs: KB24(ii);
  definition; KB27(iii) with (ii); KB27(iii) with (ii).
- **KB2E** (unlisted). $L=\Z e_1\oplus\Z e_2$ orthogonal, $0<a=|e_1|\le b=|e_2|$:
  $\mu(L)=-\tfrac12\ln(ab)$; if $a<b$ then $L_1=\Z e_1$, HN slopes $-\ln a>-\ln b$, $\mu_{\max}=-\ln a$,
  $\mu_{\min}=-\ln b$ (a primitive $xe_1+ye_2$ with $y\ne0$ has norm $\ge b$); if $a=b$, $L$ is semistable. Also
  $A_2$ (KA24) is semistable: $\mu(A_2)=-\tfrac14\ln3$, and every nonzero $v\in A_2$ has $|v|\ge\sqrt2$, so
  rank-one sublattices have slope $\le-\tfrac12\ln2<-\tfrac14\ln3$.

### B.3 The slope inequality (section BSE4)

| pos | tag | type | listed | title | alias |
|---|---|---|---|---|---|
| 1 | KC22 | definition | 1 | Norm and height of a map | |
| 2 | KC24 | theorem | 1 | The slope inequality | slope-inequality |
| 3 | KC25 | example | 0 | Divisibility as a slope inequality | |
| 4 | KC27 | lemma | 1 | Restricting many maps loses little of the target | |
| 5 | KC28 | theorem | 1 | A lower bound for the mean slope | mean-slope-bound |

(Part 2 adds KC29 at position 6.)

- **KC22.** A morphism $\varphi\colon E\to F$ of Euclidean lattices is a $\Z$-linear map; $\|\varphi\|$ is the
  operator norm of $\varphi_\R$, and for $\varphi\ne0$ the height is $h(\varphi)=\ln\|\varphi\|$. The image
  $\varphi(E)$ carries the inner product of $F$.
- **KC24.** \cite[Section 4.1]{Bost2001}, \cite[Section 4.3]{Zhang}. For a nonzero morphism $\varphi$:
  (i) $\mu_{\min}(\varphi(E))\ge\mu_{\min}(E)-h(\varphi)$; (ii) $\mu_{\min}(E)\le\mu_{\max}(F)+h(\varphi)$.
  Link KC25. Proofs: (i) for saturated $M'\ne\varphi(E)$ put $M=\varphi^{-1}(M')$; $E/M\to\varphi(E)/M'$ is a
  group isomorphism of norm $\le\|\varphi\|$ for the quotient metrics; KB2B. (ii) chain
  $\mu_{\max}(F)\ge\mu(\text{saturation of }\varphi(E))\ge\mu(\varphi(E))\ge\mu_{\min}(\varphi(E))\ge
  \mu_{\min}(E)-h(\varphi)$ with labels (KB24(i); $L'=0$ in KB25; (i)).
- **KC25** (unlisted). $E=\Z$ standard, $F=m\Z\subset\R$ for an integer $m\ge1$, $N\ne0$ with $m\mid N$,
  $\varphi(x)=Nx$: $h=\ln|N|$, $\mu_{\min}(E)=0$, $\mu_{\max}(F)=-\ln m$; KC24(ii) gives $\ln m\le\ln|N|$. With
  $m=\prod_{p\in P}p^{e_p}$ this is \ref{8V4M} for integer exponents.
- **KC27.** \cite[Lemma 4.2]{Zhang}, over $\R$. Real inner product space $H$ of dimension $D\ge1$; finitely
  many linear maps $B_i\colon\R^{r_i}\to H$ ($r_i\ge1$), $R=\sum_ir_i$; positive reals $\gamma_i$;
  $K_i=\gamma_iB_i^*B_i$, $Q=\sum_i\gamma_iB_iB_i^*$. Assume reals $0\le e\le\tfrac14$ and $\eta\ge0$ with
  $\sum_i\|K_i-I\|_{\rm HS}^2\le eR$ and $\operatorname{tr}(Q^2)\le(1+\eta)(\operatorname{tr}Q)^2/D$. Then for real
  $\kappa\ge0$ and subspaces $E_i\subset\R^{r_i}$ with $\sum_i\operatorname{codim}E_i\le\kappa R$:
  $\operatorname{codim}_H\sum_iB_iE_i\le(\eta+4\kappa+4\sqrt{\kappa e})D$.
  Proof (Idea + four steps; put $t=\operatorname{tr}Q$, $T=(\sum_iB_iE_i)^\perp$, $w=\dim T$):
  (1) $|t-R|\le R\sqrt e$ by Cauchy–Schwarz, so $t\ge R/2$;
  (2) $\operatorname{tr}(P_TQ)\le\sum_i\operatorname{tr}(P_{E_i^\perp}K_i)\le R(\kappa+\sqrt{\kappa e})$
  (as $B_i^*T\perp E_i$; then $\operatorname{tr}(P_{E^\perp}K)=\operatorname{codim}E+\operatorname{tr}(P_{E^\perp}(K-I))$
  and Cauchy–Schwarz);
  (3) $\operatorname{tr}(P_TQ)\ge tw/D-t\sqrt{\eta w/D}$, using
  $\|Q-(t/D)I\|_{\rm HS}^2=\operatorname{tr}Q^2-t^2/D\le\eta t^2/D$ and $\|P_T\|_{\rm HS}=\sqrt w$;
  (4) combine with $R\le2t$: $w/D-\sqrt{\eta w/D}\le2(\kappa+\sqrt{\kappa e})$, and
  $\sqrt{\eta w/D}\le(\eta+w/D)/2$. Mention in the proof that for $E_i=\R^{r_i}$ this is the kind of rank
  estimate in \ref{8JUB}.
- **KC28.** \cite[Proposition 4.3]{Zhang}, over $\Z$. Euclidean lattices $C$ of rank $D\ge1$ and
  $N_1,\dots,N_k$ of ranks $r_i\ge1$, $R=\sum r_i$; morphisms $b_i\colon N_i\to C$; reals $h_i$ with
  $h(b_i)\le h_i$ whenever $b_i\ne0$; reals $s$, $u\ge0$, $H\ge0$ with
  $Rs\le\sum_ir_i(\mu(N_i)-h_i)$, $\mu_{\max}(N_i)-h_i\le s+u$ for every $i$, and $s-\mu_{\min}(C)\le H$. Assume
  linear isomorphisms $\alpha_i\colon\R^{r_i}\to(N_i)_\R$ and $\beta\colon C_\R\to\R^D$ such that the maps
  $B_i=\beta\circ(b_i)_\R\circ\alpha_i$ satisfy the hypotheses of KC27 for some $\gamma_i$, $e$, $\eta$. Then
  $\mu(C)\ge s-4u\ln(1+H/u)-(\eta+4\sqrt e)H$, with $u\ln(1+H/u)=0$ when $u=0$.
  Proof (Idea + steps, one chain at the end): (1) **Few adjusted slopes are low.** The $R$ numbers
  $\mu_j(N_i)-h_i$ have mean $\ge s$ (KB2D(i)) and are $\le s+u$ (KB27(ii)); for $\lambda>0$ at most
  $Ru/(u+\lambda)$ of them are $<s-\lambda$ (from $Rs\le k(s-\lambda)+(R-k)(s+u)$). (2) **Keep the high
  pieces.** $N_i(\lambda)=(N_i)_{\ge s-\lambda+h_i}$ has $\sum_i\operatorname{codim}\le Ru/(u+\lambda)$
  (KB2D(ii)). (3) **Their images lie in $C_{\ge s-\lambda}$.** If $b_i(N_i(\lambda))\ne0$ then
  $\mu_{\min}(b_i(N_i(\lambda)))\ge s-\lambda$ (KC24(i), KB2D(iii)); a nonzero image in
  $C/C_{\ge s-\lambda}$ would contradict KC24(ii) for the projection (norm $\le1$) and KB2D(iv). (4) **Few
  slopes of $C$ are low.** KC27 with $\kappa=u/(u+\lambda)$ and $E_i=\alpha_i^{-1}(N_i(\lambda)_\R)$ gives
  $\#\{j \mid \mu_j(C)<s-\lambda\}\le(\eta+4u/(u+\lambda)+4\sqrt e)D$ (KB2D(ii)). (5) **Integrate.**
  $s-\mu(C)\le\frac1D\sum_j(s-\mu_j(C))_+=\int_0^H\frac1D\#\{j \mid \mu_j(C)<s-\lambda\}\,d\lambda$, as
  $\mu_j(C)\ge\mu_{\min}(C)\ge s-H$; insert (4).

### Part 1 acceptance

`scripts/check-lattice-appendix-part1-2026-11-28.mjs` (Node 26, `node:sqlite`, modelled on
`scripts/check-mellin-appendix-2026-11-27.mjs`): restore the backup into memory, apply part 1 in one transaction,
then check: guard blocks a second run; revision rows and snapshots match the rows; refs match the targets parsed by
`renderTex` for every new statement/proof/intro; `renderTex` with the stored macros gives **no warnings** on all
new TeX (statements, proofs, intros, titles, bibliography); numbering via `loadBook`: APXB "B", BSE2–BSE4
"B.1"–"B.3", listed results numbered in order (KA22 B.1.1, KA25 B.1.2, KA26 B.1.3, KA27 B.1.4, KB22 B.2.1, …),
unlisted unnumbered, all existing numbers unchanged; every new result has `understanding = 'unclear'`. Also check
numerically (brute force in the script) every number claimed in KA24 and KB2E. Run `npm test` too.

## Part 2 — B.4–B.6, KC29, main-chapter links (`scripts/lattice-appendix-part2-2026-11-28.sql`)

Baseline for part 2: the backup with part 1 applied. The guard also requires the part-1 tags to exist.

Sections (parent APXB): `BSE5` "Hermitian lattices over CM fields" (pos 4), `BSE6` "Theta series" (pos 5),
`BSE7` "Theta lifts in the definite case" (pos 6).

### KC29 (section BSE4, position 6, remark, listed, no proof) "How the comparison uses the mean slope bound"

In \ref{Q7MN} the period maps go from domain lattices (the $N_i$) to the dual lattice $R^\vee$ (the $C$), with
heights bounded by the $h_u$ of \ref{8JV2}. \ref{KC28} bounds $\mu(R^\vee)=-\mu(R)$ from below (KB24(iii)),
i.e. $\mu(R)$ from above: the size side of \ref{WJQV}, black box \ref{Q7MQ}. The spanning hypothesis of KC27 is
where the rank estimate \ref{8JUB} enters. The lattices of the book are over the ring of integers of a CM field,
with the normalization of \ref{KD27}.

### B.4 Hermitian lattices over CM fields (section BSE5)

| pos | tag | type | listed | title | alias |
|---|---|---|---|---|---|
| 1 | KD22 | definition | 1 | CM field | |
| 2 | KD23 | lemma | 0 | Complex conjugation on a CM field | |
| 3 | KD25 | definition | 1 | Hermitian spaces and unitary groups | |
| 4 | KD27 | definition | 1 | Hermitian lattices and their normalized slope | hermitian-lattice |
| 5 | KD26 | lemma | 1 | The underlying Euclidean lattice | |
| 6 | KD28 | lemma | 1 | The standard lattice has slope zero | |
| 7 | KD24 | example | 0 | The Gaussian field | |
| 8 | KD29 | remark | 1 | Lattices over CM fields in the book | |

- **KD22.** A number field $E$ with a totally real subfield $E^+$, $[E:E^+]=2$, $E$ totally imaginary. $c$ = the
  nontrivial automorphism of $E/E^+$; $\sigma\circ c=\overline{\sigma}$ for every embedding
  $\sigma\colon E\to\C$ (\hyperref[KD23]{link}). Examples $\Q(i)$ (KD24), $\Q(\zeta_m)$ with
  $E^+=\Q(\zeta_m+\zeta_m^{-1})$ for $m\ge3$.
- **KD23** (unlisted). Proof: $E=E^+(\alpha)$ with $\alpha^2\in E^+$; $\sigma(\alpha)\notin\R$ and
  $\sigma(\alpha)^2\in\R$, so $\sigma(\alpha)$ is purely imaginary and $\overline{\sigma(\alpha)}=-\sigma(\alpha)=\sigma(c\alpha)$;
  both sides agree on $E^+$.
- **KD25.** Hermitian space $(V,h)$ over a CM field $E$: finite-dimensional, $h$ $E$-linear in the first
  variable, $h(w,v)=c(h(v,w))$, nondegenerate. For an embedding $\sigma$, $h_\sigma$ = the Hermitian form on
  $V_\sigma=V\otimes_{E,\sigma}\C$ extending $\sigma\circ h$; $V$ is totally definite if every $h_\sigma$ is
  positive definite. $U(V)=\left\{g\in\mathrm{GL}_E(V)\;\middle|\;h(gv,gw)=h(v,w)\text{ for all }v,w\in V\right\}$.
- **KD27.** A Hermitian $\mathcal O_E$-lattice $\Lambda$: a finitely generated torsion-free $\mathcal O_E$-module with,
  for each embedding $\sigma$, a positive definite Hermitian form $h_\sigma$ on
  $\Lambda_\sigma=\Lambda\otimes_{\mathcal O_E,\sigma}\C$ such that
  $h_{\overline\sigma}(x\otimes1,y\otimes1)=\overline{h_\sigma(x\otimes1,y\otimes1)}$ for $x,y\in\Lambda$. Its underlying
  Euclidean lattice $\Lambda_\Z$ is $\Lambda$ with
  $\langle x,y\rangle=\tfrac12\sum_\sigma h_\sigma(x\otimes1,y\otimes1)$ (\hyperref[KD26]{a Euclidean lattice}).
  For $\Lambda\ne0$, $\mu_E(\Lambda)=2\mu(\Lambda_\Z)-\ln2+\ln|\Delta_E|/[E:\Q]$. Cite \cite[Section 4.3]{Zhang}.
- **KD26.** (i) $\Lambda_\Z$ is a Euclidean lattice of rank $[E:\Q]\operatorname{rk}_{\mathcal O_E}\Lambda$.
  (ii) For totally definite $(V,h)$ and a finitely generated $\mathcal O_E$-submodule $\Lambda\subset V$ spanning $V$,
  the forms $h_\sigma$ make $\Lambda$ a Hermitian $\mathcal O_E$-lattice with
  $\langle x,y\rangle=\tfrac12\operatorname{Tr}_{E/\Q}h(x,y)$. (iii) In (ii),
  $U(\Lambda)=\left\{g\in U(V)\;\middle|\;g\Lambda=\Lambda\right\}$ is finite. Proofs: (i) the form is real
  (conjugate pairs) and positive definite on $\Lambda_\R\cong\prod_{\sigma\in\Phi}\Lambda_\sigma$ for one
  embedding $\sigma$ from each conjugate pair; (ii) direct; (iii) $g$ is an isometry of $\Lambda_\Z$, determined by
  the images of a basis, which lie among finitely many vectors of bounded norm.
- **KD28.** For an integer $r\ge1$, $\mathcal O_E^r$ with $h_\sigma(x,y)=\sum_k\sigma(x_k)\overline{\sigma(y_k)}$ has
  $\mu_E=0$. Proof: for a $\Z$-basis $\omega_j$ of $\mathcal O_E$, the Gram matrix is $\tfrac12AA^*$ with
  $A=(\sigma(\omega_j))$, $|\det A|^2=|\Delta_E|$, so $\operatorname{covol}(\mathcal O_E)=2^{-d/2}|\Delta_E|^{1/2}$
  ($d=[E:\Q]$).
- **KD24** (unlisted). $E=\Q(i)$, $E^+=\Q$, $\mathcal O_E=\Z[i]$, $\Delta_E=-4$; $V=E^n$ with
  $h(v,w)=\sum_kv_k\overline{w_k}$ is totally definite; $\Lambda=\Z[i]^n$ has $\langle x,y\rangle=\operatorname{Re}\sum_k x_k\overline{y_k}$,
  so $\Lambda_\Z=\Z^{2n}$ and $\mu_E(\Lambda)=0-\ln2+\tfrac12\ln4=0$; $U(\Lambda)$ is the group of monomial matrices
  with entries in $\{\pm1,\pm i\}$, of order $4^nn!$ (the vectors of norm one are $\pm e_k,\pm ie_k$).
- **KD29.** In the book: the auxiliary field $E$ is an abelian CM field (\ref{8JV2}, \ref{C4W2}); the
  spaces $X_j$ of the chain are totally definite Hermitian spaces, so their unitary groups are compact at every real
  place; the lattices $R$ of automorphic forms are Hermitian lattices over the ring of integers of a CM field
  with Petersson metrics \cite[Section 1.3]{Zhang}; the term $\ln|\Delta_E|/[E:\Q]=\ln\mathrm{rd}_E$ is the
  root discriminant in $\Lambda_\upsilon$ of \ref{8JV2}. Since $\mu_E$ is $2\mu$ plus a constant, B.2–B.3 apply
  to the underlying Euclidean lattices; for filtrations by $\mathcal O_E$-submodules see \cite{Grayson1984}.

### B.5 Theta series (section BSE6)

| pos | tag | type | listed | title | alias |
|---|---|---|---|---|---|
| 1 | KE22 | definition | 1 | Fourier transform | |
| 2 | KE26 | lemma | 0 | Counting lattice points | |
| 3 | KE23 | theorem | 1 | Poisson summation | poisson-summation |
| 4 | KE24 | lemma | 1 | The Fourier transform of a Gaussian | |
| 5 | KE25 | definition | 1 | Theta series of a lattice | theta-series |
| 6 | KE27 | theorem | 1 | The inversion formula | |
| 7 | KE28 | example | 0 | Theta series of $\Z^n$ and $A_2$ | |
| 8 | KE2A | remark | 1 | Theta series and the Weil representation | |

- **KE22.** $V$ a Euclidean space of dimension $n$ (Lebesgue measure from orthonormal coordinates),
  $\mathcal S(V)$ the Schwartz space; $\widehat f(\xi)=\int_Vf(x)e^{-2\pi i\langle x,\xi\rangle}\,dx$.
- **KE26** (unlisted). (i) There is $C>0$ with $\#\{x\in L : |x|\le T\}\le C(1+T)^n$ for real $T\ge0$
  (disjoint balls of radius $\rho/2$, $\rho$ the minimum nonzero norm). (ii) For real $y_0>0$,
  $\sum_{x\in L}e^{-\pi y_0|x|^2}<\infty$.
- **KE23.** $L$ Euclidean lattice, $V=L_\R$, $f\in\mathcal S(V)$:
  $\sum_{x\in L}f(x)=\operatorname{covol}(L)^{-1}\sum_{y\in L^\vee}\widehat f(y)$, both absolutely convergent
  (\hyperref[KE26]{link}). Proof: the periodization $F(v)=\sum_{x\in L}f(v+x)$ is smooth and $L$-periodic; its
  Fourier coefficient at $y\in L^\vee$ is $\operatorname{covol}(L)^{-1}\widehat f(y)$ (unfold the integral over
  $V/L$); its Fourier series converges absolutely to $F$; take $v=0$. Cite \cite[Chapter VII]{Serre1973}.
- **KE24.** For $\tau$ in the upper half plane $\mathbb H$, $g_\tau(x)=e^{\pi i\tau|x|^2}$ is in $\mathcal S(V)$ and
  $\widehat{g_\tau}=(\tau/i)^{-n/2}g_{-1/\tau}$, principal branch. Proof: reduce to $n=1$; for $\tau=it$ the
  Gaussian integral; both sides holomorphic in $\tau$.
- **KE25.** $\theta_L(\tau)=\sum_{x\in L}e^{\pi i\tau\langle x,x\rangle}$ for $\tau\in\mathbb H$, absolutely and
  locally uniformly \hyperref[KE26]{convergent}, so holomorphic. If $L$ is even
  ($\langle x,x\rangle\in2\Z$ for $x\in L$): $\theta_L(\tau)=\sum_{m\ge0}r_L(m)q^m$ with $q=e^{2\pi i\tau}$,
  $r_L(m)=\#\left\{x\in L\;\middle|\;\langle x,x\rangle=2m\right\}$. Link KE28.
- **KE27.** $\theta_L(-1/\tau)=(\tau/i)^{n/2}\operatorname{covol}(L)^{-1}\theta_{L^\vee}(\tau)$ for $\tau\in\mathbb H$.
  Proof: KE23 with $f=g_{-1/\tau}$ and KE24, using $(-1/\tau)/i=(\tau/i)^{-1}$.
- **KE28** (unlisted). $\theta(\tau)=\theta_\Z(\tau)=\sum_{k\in\Z}e^{\pi ik^2\tau}$ satisfies
  $\theta(-1/\tau)=(\tau/i)^{1/2}\theta(\tau)$; $\theta_{\Z^n}=\theta^n$ counts representations as sums of $n$
  squares; for $n=2$ the coefficients of $e^{\pi im\tau}$, $m=0,\dots,5$, are $1,4,4,0,4,8$. $A_2$ is even and
  $\theta_{A_2}=1+6q+6q^3+6q^4+12q^7+O(q^9)$ (values of $a^2+ab+b^2$); with KA24,
  $\theta_{A_2}(-1/\tau)=(\tau/i)\,3^{-1/2}\,\theta_{A_2^\vee}(\tau)$.
- **KE2A** (no proof). The Fourier transform and multiplication by $e^{\pi i|x|^2}$ generate a projective action of
  $\mathrm{SL}_2(\R)$ on $\mathcal S(V)$, the Weil representation \cite{Weil1964}; $\theta_L(\tau)$ is the
  functional $f\mapsto\sum_{x\in L}f(x)$ applied to $g_\tau$, and KE23 is its behaviour under the Fourier transform.
  The theta kernels of \ref{C4W2} are the adelic version for the tensor product of a Hermitian and a
  skew-Hermitian space \cite[Section 4.1]{Zhang}.

### B.6 Theta lifts in the definite case (section BSE7)

| pos | tag | type | listed | title | alias |
|---|---|---|---|---|---|
| 1 | KF22 | definition | 1 | Even lattices and genera | |
| 2 | KF23 | theorem | 1 | Finiteness | |
| 3 | KF24 | definition | 1 | Functions on classes and the mass | |
| 4 | KF25 | definition | 1 | The theta lift | theta-lift |
| 5 | KF27 | lemma | 1 | Coefficients and products of theta lifts | |
| 6 | KF26 | theorem | 1 | Siegel's formula | |
| 7 | KF28 | example | 0 | The genus of discriminant $-23$ | |
| 8 | KF29 | remark | 1 | Theta lifts in the book | |

- **KF22.** Integral and even Euclidean lattices; isometries; $O(L)$; genus: $L\otimes\Z_p\cong L'\otimes\Z_p$
  (as quadratic $\Z_p$-modules) for every prime $p$, same rank. Cite \cite{Cassels1978}.
- **KF23.** For an even lattice $L$: (i) $O(L)$ is finite; (ii) the genus of $L$ contains finitely many
  isometry classes. Proofs: (i) as in KD26(iii); (ii) \cite[Chapter 9]{Cassels1978}.
- **KF24.** A genus $\mathcal G$ with class representatives $L_1,\dots,L_h$; $M(\mathcal G)$ = complex functions on
  the classes (algebraic modular forms of trivial weight for the definite orthogonal group \cite{Gross1999});
  $\langle f,g\rangle_{\mathcal G}=\sum_kf(L_k)\overline{g(L_k)}/|O(L_k)|$; mass
  $m(\mathcal G)=\sum_k1/|O(L_k)|$. Link KF28.
- **KF25.** For $f\in M(\mathcal G)$: $\Theta(f)(\tau)=\sum_k\frac{f(L_k)}{|O(L_k)|}\theta_{L_k}(\tau)$. Link KF28.
- **KF27.** (i) $\Theta(f)=\sum_{m\ge0}\langle f,r_\bullet(m)\rangle_{\mathcal G}\,q^m$, where
  $r_\bullet(m)$ is the function $L_k\mapsto r_{L_k}(m)$. (ii) For genera $\mathcal G',\mathcal G''$ and
  $f'\in M(\mathcal G')$, $f''\in M(\mathcal G'')$:
  $\sum_{k,l}\frac{f'(L'_k)f''(L''_l)}{|O(L'_k)||O(L''_l)|}\theta_{L'_k\oplus L''_l}=\Theta(f')\Theta(f'')$.
  Proofs: (i) group by norm; (ii) $\theta_{L'\oplus L''}=\theta_{L'}\theta_{L''}$ by splitting the sum over
  $x=(x',x'')$.
- **KF26.** (cited) $\Theta(1)/m(\mathcal G)$ depends only on $\mathcal G$, and Siegel expressed each coefficient as a
  product of local representation densities \cite{Siegel1935}. Proof: the citation. Link KF28.
- **KF28** (unlisted). Discriminant $-23$: $L_1$ with Gram $\begin{pmatrix}2&1\\1&12\end{pmatrix}$
  ($x^2+xy+6y^2$), $L_2$ with Gram $\begin{pmatrix}4&1\\1&6\end{pmatrix}$ ($2x^2+xy+3y^2$; the form $2x^2-xy+3y^2$
  gives an isometric lattice via $(x,y)\mapsto(x,-y)$). The genus has these two classes; $|O(L_1)|=4$,
  $|O(L_2)|=2$, mass $3/4$.
  $\theta_{L_1}=1+2q+2q^4+4q^6+4q^8+2q^9+O(q^{10})$,
  $\theta_{L_2}=1+2q^2+2q^3+2q^4+2q^6+2q^8+2q^9+O(q^{10})$.
  Average: $\Theta(1)/m=\tfrac13(\theta_{L_1}+2\theta_{L_2})=1+\tfrac23\sum_{m\ge1}\Bigl(\sum_{d\mid m}\bigl(\tfrac d{23}\bigr)\Bigr)q^m$
  through $q^9$. For $f(L_1)=4$, $f(L_2)=-2$ (so $\langle f,1\rangle=0$): $\Theta(f)=\theta_{L_1}-\theta_{L_2}$ agrees
  with $2q\prod_{n\ge1}(1-q^n)(1-q^{23n})=2(q-q^2-q^3+q^6+q^8)+O(q^{10})$, a cusp form. Say only what is checked
  (through $q^9$).
- **KF29** (no proof). In the book the orthogonal groups are replaced by definite unitary groups $U(X_j)$
  (\ref{KD25}): automorphic forms on them are functions on finitely many classes of Hermitian lattices (vector
  valued for nontrivial weight) \cite{Gross1999}; each theta lift of the chain in \ref{C4W2} is a weighted sum over
  lattice classes against a theta kernel, as in \ref{KF25} (see \ref{Q7MN}); Kudla's seesaw identities
  \cite{Kudla1984} exchange the order of two such sums as in \ref{KF27}(ii) — used in step (1) of \ref{8JUA}.
  \cite[Section 4.1]{Zhang}.

### Main-chapter links (part 2)

Each replacement uses SQL `replace(...)` on the exact phrase; the guard must require each phrase to occur
**exactly once** and each row to be at the revision below (author of latest revision is not `admin`). Bump
revision, NULL the cache, write baseline + new snapshots, rebuild refs of the changed field.

| row | current rev | old phrase | new phrase |
|---|---|---|---|
| section WJQV (id 117) intro | 5 | `a lattice whose slope replaces $\ln|N|$` | `a lattice whose \hyperref[KB22]{slope} replaces $\ln|N|$` |
| section 8JU4 (id 107) intro | 8 | `A Bost-type slope inequality bounds` | `A \hyperref[KC24]{Bost-type slope inequality} bounds` |
| section 8JU4 (id 107) intro | 8 | `a chain of $m$ theta lifts between unitary groups` | `a chain of $m$ \hyperref[KF25]{theta lifts} between unitary groups` |
| result Q7MN (id 209) statement | 1 | `Its slope $\mu(R)\in\R$` | `Its \hyperref[KB22]{slope} $\mu(R)\in\R$` |
| result Q7MN (id 209) statement | 1 | `The period maps take values in the dual $R^\vee$, whose slope is $-\mu(R)$.` | `The period maps take values in the \hyperref[KA26]{dual} $R^\vee$, whose slope is \hyperref[KB24]{$-\mu(R)$}.` |
| result Q7MN (id 209) statement | 1 | `Its theta kernel gives the map by a weighted sum over lattice classes.` | `Its theta kernel gives the map by a \hyperref[KF25]{weighted sum over lattice classes}.` |
| result C4W2 (id 187) statement | 1 | `successive theta lifts between spaces of automorphic forms on definite unitary groups` | `successive \hyperref[KF25]{theta lifts} between spaces of automorphic forms on \hyperref[KD25]{definite unitary groups}` |
| result 8JV2 (id 154) statement | 4 | `Here $\mu(R)$ is the slope of the lattice $R$` | `Here $\mu(R)$ is the \hyperref[KD27]{slope} of the lattice $R$` |
| proof 114 of 8JUA | 6 | `A seesaw identity compares` | `A \hyperref[KF27]{seesaw identity} compares` |
| proof 114 of 8JUA | 6 | `A Bost-type inequality gives an upper bound` | `A \hyperref[KC24]{Bost-type inequality} gives an upper bound` |
| proof 162 of Q7MQ | 1 | (append at the end, new paragraph) | `The appendix result \ref{KC28} shows how a lower bound of this kind for a mean slope is proved.` |

The Q7MN row text must be confirmed in the backup; if any phrase is not found exactly once, stop and report
instead of improvising.

### Part 2 acceptance

`scripts/check-lattice-appendix-part2-2026-11-28.mjs`: restore the backup, apply part 1 then part 2, and run all
part-1 checks for the part-2 rows plus: numbering BSE5–BSE7 "B.4"–"B.6", KC29 listed in B.3; no `renderTex`
warning on any new or changed field (including the seven changed main-chapter fields); refs for changed fields
match the parser; existing numbering unchanged; brute-force checks of every number claimed in KD24 (order of
$U(\Z[i]^n)$ for $n=1,2$ by enumeration), KE28 and KF28 (theta coefficients through $q^9$, $|O(L_k)|$ by
enumerating vectors, the $\eta$-product, the divisor-sum average with the Kronecker symbol). `npm test` passes.

## Constraints

- No remote DB writes, no deploy, no remote migration. Do not commit. Do not edit `src/`.
- Report in `implement_plan/tasks/2026-11-28-lattice-appendix.md.report.md` (append a section per part): files,
  test/check outputs, any deviation from this spec and why, and anything in the mathematics you believe is wrong.
