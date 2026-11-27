-- Make Chapter 3 self-contained apart from the arithmetic bound.
-- Baseline: backup-before-chebyshev-chapter-2026-11-27.sql, then
-- scripts/chebyshev-chapter-2026-11-27.sql.
-- Apply as one atomic batch. In SQLite, wrap the whole file in a transaction.
-- Reference edges were computed with src/latex.ts renderTex and the stored macros.

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM sections WHERE id = 105 AND revision = 5 AND tag IS '8JU2' AND title IS 'The Fourier step' AND parent_id IS NULL AND position IS 3
      AND instr(intro_tex, 'Chapter 1 reduces the problem to an upper bound for the \hyperref[8JG8]{weighted prime sum} $\mathcal G_\psi$. Here we recover that sum from counts of prime powers sorted by residue class. Fix any \hyperref[8JH4]{primitive character} $\psi$ and any real $\eta>0$ as the margin above the square-root exponent. \ref{8JU7} gives intervals $[Y,Y^{3/2}]$ with $Y$ arbitrarily large. For every $x$ in a chosen interval we have the arithmetic bound on the \hyperref[8JVF]{normalized count} $D_\psi(x)$ and the Fourier comparison:') > 0)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id = 106 AND revision = 9 AND tag IS '8JU3' AND title IS 'Error exponents and cohomological lengths' AND parent_id IS 111 AND position IS 1
      AND instr(intro_tex, 'In Chapter 3, \ref{8JU7} chooses the window $[Y,Y^{3/2}]$, the auxiliary primes $q,d$, the groups $A,A_0$ of \ref{8JVC}, and the shift set $T$ at each scale. The lattice estimates must work at each $x$ in that window. This section records what they need there: the \hyperref[8JV2]{error exponents} of the theta-lift chain and the \hyperref[8JU8]{cohomological bound}, which is used in the finite-place divisibility estimate.') > 0)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id = 107 AND revision = 7 AND tag IS '8JU4' AND title IS 'Bounding the centered count by theta lifts' AND parent_id IS 111 AND position IS 2
      AND instr(intro_tex, 'This section uses the scales and weights of \ref{8JVK} and explains the bound in \ref{8JUA} for every shift $u\in A_0$. The count and its main term are defined in \ref{8JU9}, and the centered sum over $t$ and $j$ is defined in \ref{8JVF}.') > 0)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id = 108 AND revision = 4 AND tag IS '8JU5' AND title IS 'Recovering the weighted prime sum' AND parent_id IS 105 AND position IS 4
      AND instr(intro_tex, 'We now compare the \hyperref[8JVF]{normalized count} with $\mathcal G_\psi(x)$. The Fourier expansion in \ref{8JVD} puts a copy of $G_\chi$ at each cutoff $\upsilon_t/w_{u,j}(\alpha)$, using the scales and weight functions of \ref{8JVK}. We replace the weights near $b$ by $b$ and bound the contribution of the other weights at their much larger cutoffs. The two averages then keep the desired characters with the Chapter 1 weights. We estimate separately the changes in the cutoffs and in the coset proportions.') > 0)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id = 109 AND revision = 4 AND tag IS '8JU6' AND title IS 'Balancing and normalizing the errors' AND parent_id IS 111 AND position IS 3
      AND instr(intro_tex, 'The bound in \ref{8JUA} holds for each $u\in A_0$, so it also bounds the average of the centered counts. We divide it by the \hyperref[8JVF]{Chapter 3 normalization} to prove the arithmetic bound. The two largest terms in the error balance when the number of lifts $m$ is near $\sqrt x$. \ref{8JUG} gives the four estimates and \ref{8JUF} combines them.') > 0)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id = 111 AND revision = 4 AND tag IS '8JV5' AND title IS 'The arithmetic bound' AND parent_id IS NULL AND position IS 4
      AND instr(intro_tex, 'This chapter outlines the proof of the \hyperref[8JVG]{arithmetic bound} used in Chapter 3. We start from the window and auxiliary data of \ref{8JU7}, record the error exponents and the cohomological bound on it, then outline how the theta lifts bound the centered counts separately for each subgroup shift $u\in A_0$, and finally normalize that bound.') > 0)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id = 113 AND revision = 6 AND tag IS '8JV7' AND title IS 'Prime classes and weighted counts' AND parent_id IS 105 AND position IS 2
      AND instr(intro_tex, 'The weighted prime-power count in \ref{8JU9} assigns classes to prime powers and attaches weights to those classes. Three definitions supply the groups, the labels, and the local character values.') > 0)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id = 114 AND revision = 5 AND tag IS '8JV8' AND title IS 'The normalized count and its arithmetic bound' AND parent_id IS 105 AND position IS 3
      AND instr(intro_tex, 'We now specify the data needed to normalize the counting formula of \ref{8JU9}. \ref{8JU7} gives windows $[Y,Y^{3/2}]$ with $Y$ arbitrarily large. The primes $q,d$ are fixed on each window, while the groups and the shift set $T$ from \ref{8JU7} can depend on the point $x$. At each $x\ge x_{\rm wt}$, \ref{8JVK} gives the scale $\upsilon_t$ for each $t\in T$ and a weight function $w_{u,j}$ for each $u\in A_0$ and each lift $j=1,\dots,m$ in the theta-lift chain. \ref{8JVE} collects the data, including the coset proportions of $T$.') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 126 AND revision = 7 AND tag IS '8JU7' AND title IS 'Simultaneous choice of auxiliary data' AND section_id IS 114 AND position IS 1 AND type IS 'lemma'
      AND instr(statement_tex, 'For each primitive $\psi$ there is $0<\varepsilon_0=\varepsilon_0(\psi)\le1/52$. For each $0<\varepsilon<\varepsilon_0$, fix the exponent $J=J(\psi,\varepsilon)\ge2$ of \cite[Proposition 18.4]{Adriazola}. For each $Y_0\ge3$ there exist a base $Y_{\rm base}\ge3$, a real $Y\ge Y_0$ with $Y_{\rm base}\le Y$ and $Y^2\le Y_{\rm base}^J$, and auxiliary primes $q,d$ fixed on $[Y,Y^{3/2}]$. The primes satisfy the conclusions of \cite[Theorems 5.10 and 5.12]{Adriazola} at $Y_{\rm base}$ with $K=J$ and $\tau=\varepsilon$. At each real $x$ in the window, admissible data in the sense of \cite[Definition 18.1]{Adriazola} give the groups of \ref{8JVC} and \ref{8JVP} and a nonempty set $T\subseteq A$. For each coset $C\in A/A_0$ the proportions $\mu_C,\lambda_C$ of \ref{8JVA} with $k=3$ satisfy') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 127 AND revision = 4 AND tag IS '8JU8' AND title IS 'The cohomological length bound' AND section_id IS 106 AND position IS 2 AND type IS 'lemma'
      AND instr(statement_tex, 'Let $E$ be an auxiliary field, $S_\ell$ its set of places above the prime $\ell$, and $G_{E,S_\ell}$ the Galois group of the maximal extension of $E$ unramified at finite places outside $S_\ell$. For a positive integer $r$ set') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 129 AND revision = 3 AND tag IS '8JUA' AND title IS 'A bound for each translate' AND section_id IS 107 AND position IS 1 AND type IS 'proposition'
      AND instr(statement_tex, 'Use the \hyperref[8JVE]{Fourier data} and the \hyperref[8JVF]{centered sums} $\Delta_u$ on a window of \ref{8JU7}. Let $a_E$ be the common size parameter in the estimates at each step and let $k$ be the parameter controlling the rank error. Set') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 130 AND revision = 3 AND tag IS '8JUB' AND title IS 'Rank from the period matrices' AND section_id IS 107 AND position IS 2 AND type IS 'lemma'
      AND instr(statement_tex, 'Let $B_i$ be the matrices for the period maps into a common $D$-dimensional Hermitian space. For any positive real normalizing weights $\gamma_i$ indexed by these matrices, put') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 131 AND revision = 7 AND tag IS '8JUC' AND title IS 'Matching the main terms' AND section_id IS 107 AND position IS 3 AND type IS 'lemma'
      AND instr(statement_tex, 'Use $\Phi,f$ and $\xi_c$ from \ref{8JVP} and the primitive representative $\xi_c^*$ from \ref{8JVQ}. In the normalization of \cite[Section 8]{Outline}, let $v_0$ be the geometric normalization parameter. For the scales $\upsilon_t$ of \ref{8JVK}, put') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 132 AND revision = 4 AND tag IS '8JUD' AND title IS 'The Fourier comparison' AND section_id IS 108 AND position IS 4 AND type IS 'lemma'
      AND instr(statement_tex, 'For each primitive $\psi$ of order $o$, take $\varepsilon_0(\psi)$ from \ref{8JU7}. For each $0<\varepsilon<\varepsilon_0(\psi)$ there is $x_{\rm cmp}=x_{\rm cmp}(\psi,\varepsilon)\ge\max(x_{\rm wt},x_{\rm aux})$, with $x_{\rm wt}$ from \ref{8JVK} and $x_{\rm aux}$ from \ref{8JVH}. For every window $[Y,Y^{3/2}]$ and primes $q,d$ as in \ref{8JU7}, and every real $x\in[Y,Y^{3/2}]$ with $x\ge x_{\rm cmp}$, take the \hyperref[8JVE]{Fourier data} and the estimates of \ref{8JVH}. Then') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 134 AND revision = 4 AND tag IS '8JUF' AND title IS 'The arithmetic bound from the four errors' AND section_id IS 109 AND position IS 1 AND type IS 'proposition'
      AND instr(statement_tex, 'For each primitive $\psi$, take $\varepsilon_0(\psi)$ from \ref{8JU7}. For each $0<\varepsilon<\varepsilon_0(\psi)$ there is a threshold $x_{\rm arith}=x_{\rm arith}(\psi,\varepsilon)\ge x_{\rm wt}$, with $x_{\rm wt}$ from \ref{8JVK}. For every $Y_0\ge3$, there is a window $[Y,Y^{3/2}]$ of \ref{8JU7} with $Y\ge\max(Y_0,x_{\rm arith})$, a pair of auxiliary primes $q,d$ fixed on the window, and error exponents $e_D=2$, $e_L=0$. For every real $x$ in that window the normalized count of \ref{8JVF} satisfies') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 135 AND revision = 2 AND tag IS '8JUG' AND title IS 'Sizes of the four normalized errors' AND section_id IS 109 AND position IS 2 AND type IS 'lemma'
      AND instr(statement_tex, 'For the parameters of \ref{8JUA}, with $Q,\delta_2$ as in \ref{8JVE}, one has') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 153 AND revision = 5 AND tag IS '8JUW' AND title IS 'The auxiliary-character sum $\Sigma(x)$' AND section_id IS 108 AND position IS 3 AND type IS 'definition'
      AND instr(statement_tex, 'Use the data of \ref{8JVE} and the character notation of \ref{8JVQ}. Identify $A$ with its image under the embedding $A\to B$ of \ref{8JVP}. With $\mathcal C_\psi$ the \hyperref[8JG8]{cyclic family}, put') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 154 AND revision = 3 AND tag IS '8JV2' AND title IS 'The error exponents $e_D$ and $e_L$' AND section_id IS 106 AND position IS 1 AND type IS 'definition'
      AND instr(statement_tex, 'For a chain of $m$ theta lifts at scale $x$ with parameter $\varepsilon>0$ and translates $t\in T$, write $h=|T|$, $n=|A|$, and $b=\exp(x^\varepsilon)$ as in \ref{8JVE}. The number of large weights per level is $h_2=|T_2|$ in that notation. Write $k$ for the rank-error parameter of the chain. Put') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 162 AND revision = 5 AND tag IS '8JVE' AND title IS 'Data for the Fourier step' AND section_id IS 114 AND position IS 3 AND type IS 'definition'
      AND instr(statement_tex, 'Fix a primitive $\psi$ of order $o$, a real $\varepsilon>0$, and a point $x\ge3$ in a window $[Y,Y^{3/2}]$. Use the residue groups and primes of \ref{8JVC} and the quadratic coordinates of \ref{8JVP}. Take a nonempty $T\subseteq A$. For the proportions $\mu_C,\lambda_C$ of \ref{8JVA} with $k=3$, require') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 163 AND revision = 3 AND tag IS '8JVF' AND title IS 'The normalized centered count $D_\psi(x)$' AND section_id IS 114 AND position IS 4 AND type IS 'definition'
      AND instr(statement_tex, 'At any point $x$ with data as in \ref{8JVE}, use $S$ and $M$ from \ref{8JU9}. The centered sum $\Delta\colon A_0\to\R$ and the real normalized value $D_\psi(x)$ for those data are') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 164 AND revision = 3 AND tag IS '8JVG' AND title IS 'Arithmetic bound' AND section_id IS 114 AND position IS 5 AND type IS 'theorem'
      AND instr(statement_tex, 'For each primitive $\psi$, take $\varepsilon_0(\psi)$ from \ref{8JU7}. For every $\eta>0$, every $0<\varepsilon<\varepsilon_0(\psi)$ with $61\varepsilon/8\le\eta$, and every $Y_0\ge3$, there is a window $[Y,Y^{3/2}]$ and a pair of auxiliary primes $q,d$ as in \ref{8JU7}, with $Y\ge\max(Y_0,x_{\rm aux})$ for $x_{\rm aux}$ from \ref{8JVH}, with the following property. At every real $x$ in the window there are data as in \ref{8JVE}, built from the choices of \ref{8JU7} and \ref{8JVK}, satisfying the estimates of \ref{8JVH}, with') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 165 AND revision = 3 AND tag IS '8JVH' AND title IS 'Analytic estimates for the auxiliary characters' AND section_id IS 108 AND position IS 1 AND type IS 'lemma'
      AND instr(statement_tex, 'For each primitive $\psi$, take $\varepsilon_0(\psi)$ from \ref{8JU7}. For each $0<\varepsilon<\varepsilon_0(\psi)$ there is $x_{\rm aux}=x_{\rm aux}(\psi,\varepsilon)\ge x_{\rm wt}$, with $x_{\rm wt}$ from \ref{8JVK}, such that the following estimates hold for every window $[Y,Y^{3/2}]$ and primes $q,d$ as in \ref{8JU7} and every real $x\in[Y,Y^{3/2}]$ with $x\ge x_{\rm aux}$. Use the Fourier data of \ref{8JVE}, the representative $\xi^*$ from \ref{8JVQ}, and the \hyperref[8JF7]{smoothed prime sum} $G_{\xi^*}$.') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 167 AND revision = 4 AND tag IS '8JVK' AND title IS 'Scales and weights for the theta lifts' AND section_id IS 114 AND position IS 2 AND type IS 'lemma'
      AND instr(statement_tex, 'For each primitive $\psi$, take $\varepsilon_0(\psi)$ from \ref{8JU7}. For each $0<\varepsilon<\varepsilon_0(\psi)$ there is $x_{\rm wt}=x_{\rm wt}(\varepsilon)\ge3$ such that the following holds for every window $[Y,Y^{3/2}]$ and primes $q,d$ as in \ref{8JU7} and every real $x\in[Y,Y^{3/2}]$ with $x\ge x_{\rm wt}$. Use the groups of \ref{8JVC} and \ref{8JVP} and the nonempty $T\subseteq A$ of \ref{8JU7} at $x$. Put') > 0)
  OR EXISTS (SELECT 1 FROM tags WHERE tag = 'C3R2')
  OR EXISTS (SELECT 1 FROM results WHERE id = 184)
  OR EXISTS (SELECT 1 FROM tags WHERE tag = 'C3T2')
  OR EXISTS (SELECT 1 FROM results WHERE id = 185)
  OR EXISTS (SELECT 1 FROM tags WHERE tag = 'C4S2')
  OR EXISTS (SELECT 1 FROM results WHERE id = 186)
  OR EXISTS (SELECT 1 FROM tags WHERE tag = 'C4W2')
  OR EXISTS (SELECT 1 FROM results WHERE id = 187)
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id = 112 AND revision = 6 AND result_id IS 126 AND position IS 1
      AND instr(body_tex, '\emph{(1)} Fix $J$ as in \cite[Proposition 18.4]{Adriazola} for this $\psi,\varepsilon$. Choose $q$, then $d$, at $Y_{\rm base}$ using \cite[Theorems 5.10 and 5.12]{Adriazola} with $K=J$ and $\tau=\varepsilon$. Zero-density and mean-square estimates bound the candidates that fail the zero-free or smoothed-sum tests. Taking the union over the finitely many characters at the fixed modulus still leaves admissible primes. The pair works on $[Y_{\rm base},Y_{\rm base}^J]$, which contains $[Y,Y^{3/2}]$ by $Y_{\rm base}\le Y$ and $Y^2\le Y_{\rm base}^J$. See also \cite[Section 11]{Outline}.') > 0)
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id = 113 AND revision = 1 AND result_id IS 127 AND position IS 1
      AND instr(body_tex, 'At odd $\ell$ the two projectors $(1\pm(-1)^r c)/2$ for complex conjugation $c$ split the length into two pieces. The source treats $\ell=2$ separately and uses cyclotomic control and counting by residual character type for the odd-prime pieces. For the positive piece, the estimate for $\ell-1\nmid 2r$ already sums over primes. For $\ell-1\mid 2r$, the primes satisfy $\ell\le 2r+1$, so the componentwise bounds suffice. The finitely many exceptional odd primes have separate bounds. These inputs give, in total, a bound of the form $\exp(o(x^\varepsilon))$ on the common interval. The bound is uniform in the finite set $S$. See \cite[Sections 3--5 and Appendix A]{Outline}.') > 0)
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id = 114 AND revision = 5 AND result_id IS 129 AND position IS 1
      AND instr(body_tex, '\emph{(1) Compare periods in a common lattice.} A chain of theta lifts passes between totally definite unitary groups. A seesaw identity compares each period with a Bessel period in a common model. Local vector matching and the common test vectors make the integral comparison compatible with the covolume estimate. The \hyperref[8JUB]{matrix rank estimate} controls the dimension lost when combining the period maps.') > 0)
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id = 117 AND revision = 9 AND result_id IS 132 AND position IS 1
      AND instr(body_tex, '\emph{(a) Expand the centered count and control the changes of weight.}') > 0)
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id = 118 AND revision = 4 AND result_id IS 133 AND position IS 1
      AND instr(body_tex, 'For $v\in(0,\upsilon]$, put $F(v)=vG_\chi(\upsilon/v)\in\C$. For real $z\ge1$, put $\Theta(z)=\sum_{n\le z}\Lambda(n)\in[0,\infty)$. We use the Chebyshev bound $0\le\Theta(z)\le3z$ for $z\ge1$ (see \cite[Lemma 4.1]{Adriazola}). The expression for $F$ from \ref{8JF7} is a sum of $\Lambda(n)\chi(n)(\upsilon/n-v)_+$ plus the main-term correction. There are finitely many breakpoints $v=\upsilon/n$ between $w$ and $w''$. The sum is continuous there, since the term crossing the cutoff is zero at its breakpoint.') > 0)
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id = 119 AND revision = 5 AND result_id IS 134 AND position IS 1
      AND instr(body_tex, 'Choose $x_{\rm arith}\ge x_{\rm wt}$ large enough for the per-shift bound of \ref{8JUA} and the estimates of \ref{8JUG}. The chain-record threshold uses the exponent $J(\psi,\varepsilon)$ fixed in \ref{8JU7}. Apply \ref{8JU7} with starting bound $\max(Y_0,x_{\rm arith})$. On the resulting window, the integral theta-lift data with error exponents $e_D=2$ and $e_L=0$ come from \cite[Hypothesis 18.10]{Adriazola} at the fixed $J$, as in the proof of Theorem A in Section 18.6. At every $x$ in the resulting window, using $\mathcal B$ and $E_{\rm err}$ of \ref{8JUA}, we have') > 0)
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id = 130 AND revision = 1 AND result_id IS 152 AND position IS 1
      AND instr(body_tex, 'This is Dirichlet''s theorem \cite{Davenport}.') > 0)
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id = 135 AND revision = 2 AND result_id IS 164 AND position IS 1
      AND instr(body_tex, 'Apply \ref{8JUF} with requested lower bound $\max(Y_0,x_{\rm aux})$ for $Y$. This gives $Y\ge\max(Y_0,x_{\rm arith},x_{\rm aux})$, with $x_{\rm arith}\ge x_{\rm wt}$. On this window, \ref{8JU7} supplies the groups, primes and coset proportions. \ref{8JVK} gives the weight properties, and \ref{8JUG} gives the lower bound on $\delta_2$. The bound of \ref{8JUF} applies at every $x$ in the window. Since $x\ge3$ and $61\varepsilon/8\le\eta$, it gives $D_\psi(x)\le20x^{1/2+61\varepsilon/8}\le20x^{1/2+\eta}$.') > 0)
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id = 136 AND revision = 2 AND result_id IS 165 AND position IS 1
      AND instr(body_tex, 'For (i), use the conductor bound $\ln\operatorname{cond}(\xi^*)\le C(\psi)x^{\varepsilon/5}(\ln x)^2$ in \cite[Section 6.3, pp.~43--44]{Adriazola}. It follows from the bounds for $q,d$ at $Y_{\rm base}\le x$ and $N_1\le8N_0|A|$. Real characters involving $q$ or $d$ have the uniform real-zero exclusion in Corollary 5.13. The remaining real characters have conductors dividing a fixed modulus, since real characters of $2$-power conductor have conductor at most $8$. Proposition 5.3 and its trivial-character variant therefore give a uniform large-cutoff bound for $y\ge X''/3$. In the exponential terms of that estimate, the powers $\varepsilon/3-\varepsilon/5$ and $\varepsilon/6$ both exceed $\varepsilon/8$. Increasing $x_{\rm aux}$ gives the stated bound, including $2f(x+1)\omega_x\le1/x$ by Proposition 5.16(iv).') > 0)
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id = 137 AND revision = 2 AND result_id IS 166 AND position IS 1
      AND instr(body_tex, 'Fix $\psi$ and $0<\varepsilon<\varepsilon_0(\psi)$ from \ref{8JU7}, and set $\eta=61\varepsilon/8$. Write $o$ for the order of $\psi$. Use $x_{\rm cmp}$ from \ref{8JUD}, which is at least $x_{\rm wt}$ from \ref{8JVK} and $x_{\rm aux}$ from \ref{8JVH}. For a prescribed $Y_0\ge1$, apply \ref{8JVG} with the requested lower bound for $Y$ equal to') > 0)
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id = 138 AND revision = 2 AND result_id IS 167 AND position IS 1
      AND instr(body_tex, 'The sequence of maps is the one in \cite[Sections 5.8 and 7, p.~54]{Adriazola}. The kernel of each step defines a map on automorphic forms by summation over the lattice classes at that level. The fixed rank increment is the number of copies of the auxiliary hermitian space added at each step, as in Section 18.1.') > 0)
  OR EXISTS (SELECT 1 FROM proofs WHERE id = 149)
  OR EXISTS (SELECT 1 FROM proofs WHERE id = 150)
  OR EXISTS (SELECT 1 FROM proofs WHERE id = 151)
  OR NOT EXISTS (SELECT 1 FROM settings WHERE key = 'bibliography' AND revision = 9
      AND instr(value, '\bibitem{Outline} \emph{The Generalized Riemann Hypothesis for Dirichlet $L$-functions: from smoothed prime sums to zeros on the critical line}, AI-generated natural-language outline of the Lean proof, 21 November 2026.') > 0
      AND instr(value, '\bibitem{Honda1968} T. Honda, \emph{Formal groups and zeta-functions}, Osaka J. Math. 5 (1968), 199–213. \url{https://ir.library.osaka-u.ac.jp/repo/ouka/all/8997/}') > 0)
  OR NOT EXISTS (SELECT 1 FROM settings WHERE key = 'needs_rebuild');

-- Ensure the preceding revision has a snapshot before changing its row.

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '105', 5, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JU2", "parent_id": null, "kind": "chapter", "title": "The Fourier step", "intro_tex": "Chapter 1 reduces the problem to an upper bound for the \\hyperref[8JG8]{weighted prime sum} $\\mathcal G_\\psi$. Here we recover that sum from counts of prime powers sorted by residue class. Fix any \\hyperref[8JH4]{primitive character} $\\psi$ and any real $\\eta>0$ as the margin above the square-root exponent. \\ref{8JU7} gives intervals $[Y,Y^{3/2}]$ with $Y$ arbitrarily large. For every $x$ in a chosen interval we have the arithmetic bound on the \\hyperref[8JVF]{normalized count} $D_\\psi(x)$ and the Fourier comparison:\n\\[\n\\begin{aligned}\nD_\\psi(x)&\\le Cx^{1/2+\\eta},\\\\\n\\mathcal G_\\psi(x)&\\le D_\\psi(x)+O_{\\psi,\\eta}(x^{1/2+\\eta}).\n\\end{aligned}\n\\]\nTogether they give $\\mathcal G_\\psi(x)\\le C''x^{1/2+\\eta}$. The constants are independent of the interval and of $x$ in it. Chapter 4 (\\ref{8JV5}) gives the proof outline for the first inequality.\n\nThis chapter proves the second inequality. We learn two finite-group averages, expand the prime-power count in characters, and specify the data supplied by the arithmetic bound. Finally we apply the two averages to the expansion and track the errors. The only analytic estimates the averaging uses are collected in \\ref{8JVH}.", "position": 3}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '106', 9, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JU3", "parent_id": 111, "kind": "section", "title": "Error exponents and cohomological lengths", "intro_tex": "In Chapter 3, \\ref{8JU7} chooses the window $[Y,Y^{3/2}]$, the auxiliary primes $q,d$, the groups $A,A_0$ of \\ref{8JVC}, and the shift set $T$ at each scale. The lattice estimates must work at each $x$ in that window. This section records what they need there: the \\hyperref[8JV2]{error exponents} of the theta-lift chain and the \\hyperref[8JU8]{cohomological bound}, which is used in the finite-place divisibility estimate.\n\nThe auxiliary field in Adriazola''s construction has group $B=\\Z/2\\Z\\times\\Z/2\\Z\\times A$ as in \\ref{8JVP}. The two signs are cut out by the quadratic fields associated with $d$ and $q$, and $A$ comes from the fixed conductor and a cyclotomic tower. The subgroup $A_0$ is the kernel of the target character on $A$. The choice of the shift set $T$ in \\ref{8JU7} uses the freedom along the tower to obtain many shifts without too many collisions in short progressions. The estimates for the coset proportions are stated in \\ref{8JU7}. See \\cite[Sections 5.7--5.8 and 18.1]{Adriazola} and \\cite[Sections 3 and 9--11]{Outline}.", "position": 1}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '107', 7, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JU4", "parent_id": 111, "kind": "section", "title": "Bounding the centered count by theta lifts", "intro_tex": "This section uses the scales and weights of \\ref{8JVK} and explains the bound in \\ref{8JUA} for every shift $u\\in A_0$. The count and its main term are defined in \\ref{8JU9}, and the centered sum over $t$ and $j$ is defined in \\ref{8JVF}.\n\nFor a model, if a nonzero integer $K$ is divisible by all primes in a set $P$, then $\\sum_{p\\in P}\\ln p\\le\\ln|K|$. Here the integer is replaced by lattices built from a chain of $m$ theta lifts between unitary groups. Prime powers in the relevant classes force extra divisibility. A Bost-type slope inequality bounds the same lattice quantities from above. Comparing the bounds gives the estimate on the count. The \\hyperref[8JUB]{matrix rank lemma} and \\hyperref[8JUC]{main-term identity} give two elementary pieces of this comparison.", "position": 2}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '108', 4, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JU5", "parent_id": 105, "kind": "section", "title": "Recovering the weighted prime sum", "intro_tex": "We now compare the \\hyperref[8JVF]{normalized count} with $\\mathcal G_\\psi(x)$. The Fourier expansion in \\ref{8JVD} puts a copy of $G_\\chi$ at each cutoff $\\upsilon_t/w_{u,j}(\\alpha)$, using the scales and weight functions of \\ref{8JVK}. We replace the weights near $b$ by $b$ and bound the contribution of the other weights at their much larger cutoffs. The two averages then keep the desired characters with the Chapter 1 weights. We estimate separately the changes in the cutoffs and in the coset proportions.\n\nSome extra characters pass the subgroup average. Their prime sums are small by the choice of the auxiliary primes $q,d$ in \\ref{8JU7}. \\ref{8JVH} records the analytic estimates, and \\ref{8JUD} proves the comparison. The final corollary combines it with the arithmetic bound.", "position": 4}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '109', 4, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JU6", "parent_id": 111, "kind": "section", "title": "Balancing and normalizing the errors", "intro_tex": "The bound in \\ref{8JUA} holds for each $u\\in A_0$, so it also bounds the average of the centered counts. We divide it by the \\hyperref[8JVF]{Chapter 3 normalization} to prove the arithmetic bound. The two largest terms in the error balance when the number of lifts $m$ is near $\\sqrt x$. \\ref{8JUG} gives the four estimates and \\ref{8JUF} combines them.", "position": 3}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '111', 4, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JV5", "parent_id": null, "kind": "chapter", "title": "The arithmetic bound", "intro_tex": "This chapter outlines the proof of the \\hyperref[8JVG]{arithmetic bound} used in Chapter 3. We start from the window and auxiliary data of \\ref{8JU7}, record the error exponents and the cohomological bound on it, then outline how the theta lifts bound the centered counts separately for each subgroup shift $u\\in A_0$, and finally normalize that bound.\n\nThe deep inputs come from the Lean development and the chain-record hypotheses in \\cite[Sections 6.2 and 18]{Adriazola}. A first reading can take the Chapter 3 theorem as a black box and return here to see where its hypotheses and error sizes come from.", "position": 4}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '113', 6, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JV7", "parent_id": 105, "kind": "section", "title": "Prime classes and weighted counts", "intro_tex": "The weighted prime-power count in \\ref{8JU9} assigns classes to prime powers and attaches weights to those classes. Three definitions supply the groups, the labels, and the local character values.\n\nThe \\hyperref[8JVC]{residue groups for the averages} give the two averages of \\ref{8JV6} their inputs. The modulus $N_1$ lets $A$ record both the residue modulo $2^{e+2}$ up to sign and the value of $\\psi$. The groups of residues up to sign form the real cyclotomic tower, so increasing $e$ gives room to choose the shift set $T$ for the coset average in \\ref{8JVA}. Requiring $\\psi_{N_1}(v)=1$ in $U_1$ makes the induced character $\\psi_A$ on $A$ independent of the representative of a class. The uniform average in \\ref{8JV9} uses $A_0=\\ker\\psi_A$. Since the image of $\\psi_A$ has order $o$, the cosets indexed by $A/A_0$ are the $o$ character-value classes for the second average.\n\nThe \\hyperref[8JVP]{quadratic coordinates} enlarge $A$ to $B$. The map $\\pi$ sends a unit modulo $N=N_1qd$ to its two quadratic bits followed by its class in $A$. The Chinese remainder theorem lets the bits vary independently of the class in $A$. The bit at $d$ distinguishes the half with $\\xi_c=-1$, which gives the extra divisibility in the arithmetic argument. The complementary half $\\Phi$ labels the weights. The bit at $q$ distinguishes the positions with weights near the reference value in \\ref{8JVK}. For any shift $t\\in A$, the map $p_t$ of \\ref{8JU9} adds $(1,1,t)$. This translation flips the first quadratic bit and gives a bijection from $B\\smallsetminus\\Phi$ to $\\Phi$. Among the characters that survive the subgroup average, those using either quadratic bit are the auxiliary twists. Their smoothed prime sums are small at the target cutoff $x$, as in \\ref{8JVH}.\n\nThe \\hyperref[8JVQ]{prime-power classes and primitive characters} give the inputs to the Fourier expansion in \\ref{8JVD}. Away from $N$, the class of $p^i$ is a single element, and only odd powers of a prime with $\\xi_c(\\vartheta_p)=-1$ enter the count. The \\hyperref[8JVM]{example modulo $840$} computes such a class. At $p\\mid N$, the prime power has no unit class modulo $N$. The coset $i\\vartheta_p+I_p$ uses its residue away from $p$ and shares its mass uniformly across the corresponding classes. The portion outside $\\Phi$ enters the count. For each $\\xi\\in\\widehat B$, the value $\\xi^*(p^i)$ gives the coset average in the Fourier expansion, including when $p\\mid N$.\n\nThe count in \\ref{8JU9} and the Fourier expansion in \\ref{8JVD} allow arbitrary positive weight functions (with $w_\\alpha\\le\\upsilon$ in the Fourier expansion), and \\ref{8JVK} in §3.3 supplies the particular weight functions $w_{u,j}$ used in the normalized count of \\ref{8JVF}.", "position": 2}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '114', 5, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JV8", "parent_id": 105, "kind": "section", "title": "The normalized count and its arithmetic bound", "intro_tex": "We now specify the data needed to normalize the counting formula of \\ref{8JU9}. \\ref{8JU7} gives windows $[Y,Y^{3/2}]$ with $Y$ arbitrarily large. The primes $q,d$ are fixed on each window, while the groups and the shift set $T$ from \\ref{8JU7} can depend on the point $x$. At each $x\\ge x_{\\rm wt}$, \\ref{8JVK} gives the scale $\\upsilon_t$ for each $t\\in T$ and a weight function $w_{u,j}$ for each $u\\in A_0$ and each lift $j=1,\\dots,m$ in the theta-lift chain. \\ref{8JVE} collects the data, including the coset proportions of $T$.\n\nFix any point $x$ and any choice of data as in \\ref{8JVE} there. For each $t\\in T$, $1\\le j\\le m$, and $u\\in A_0$, use \\ref{8JU9} to compute the count $S(t,\\upsilon_t,w_{u,j})$ and subtract its main term $\\Re M(\\upsilon_t,w_{u,j})$. Add these differences over all $t$ and $j$ to get $\\Delta_u$. Then average $\\Delta_u$ over $u$, giving each $u$ weight $1/|A_0|$.\n\nA term of weight $w$ has cutoff $\\upsilon_t/w$. This comes from writing $(\\upsilon_t/p^i-w)_+=w((\\upsilon_t/w)/p^i-1)_+$, so the summand vanishes for $p^i\\ge \\upsilon_t/w$. In the positions $\\Phi_u$ of \\ref{8JVK}, $w$ is close to $b=\\exp(x^\\varepsilon)$, where $\\varepsilon>0$ is a small parameter. The number $\\upsilon_t$ is close to $xb$. Thus $\\upsilon_t/w$ is near $x$, and we call these the terms at scale $x$. The comparison in \\ref{8JUD} replaces their weights by $b$ and uses $|\\upsilon_t/b-x|\\le1$ to return to cutoff $x$.\n\nAt every other position, $w\\le2b''$ with $b''=xb/X''$ and $X''=\\exp(x^{\\varepsilon/3})$. Since $\\upsilon_t\\ge (x-1)b$ and $x\\ge3$, the cutoff is at least $(x-1)X''/(2x)\\ge X''/3$. These cutoffs are much larger than $x$ for large $x$. The decay estimate in \\ref{8JVH}(i) bounds their contribution.\n\nThe two kinds of shifts have different jobs. Changing $u\\in A_0$ moves the positions in $\\Phi_u$ along $A_0$. The average over $u$ removes characters that are nontrivial on $A_0$, by \\ref{8JV9}. The shift $t\\in T$ permutes the weight labels as in \\ref{8JU9}. The coset proportions of $T$ give the surviving characters the Chapter 1 weights by \\ref{8JVA} with $k=3$. Each $t$ enters the sum once, so the final division accounts for the factor $h=|T|$.\n\nEach $(t,j)$ has $h_2=|T_2|$ positions at scale $x$. After replacement each supplies weight $b$ and has Fourier coefficient $1/f$ at the trivial character, where $f=2n$ and $n=|A|$. There are $hm$ pairs $(t,j)$, and the average over $u$ preserves this coefficient. With $\\delta_2=h_2/n$ and $Q=hmb$, the total weight at scale $x$ is\n\\[\nhm\\cdot\\frac{bh_2}{f}\n=(hmb)\\frac{h_2}{2n}=\\frac{Q\\delta_2}{2}.\n\\]\nThis is the denominator in the \\hyperref[8JVF]{definition of $D_\\psi(x)$}. The next section derives the common factor for the surviving characters and then applies the coset weights. After division, the weighted sum $\\mathcal G_\\psi(x)$ has coefficient one, with the replacements and the coset discrepancy contributing the errors estimated there. Chapter 4 supplies the one-sided bound on $D_\\psi(x)$.", "position": 3}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '126', 7, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JU7", "type": "lemma", "title": "Simultaneous choice of auxiliary data", "statement_tex": "For each primitive $\\psi$ there is $0<\\varepsilon_0=\\varepsilon_0(\\psi)\\le1/52$. For each $0<\\varepsilon<\\varepsilon_0$, fix the exponent $J=J(\\psi,\\varepsilon)\\ge2$ of \\cite[Proposition 18.4]{Adriazola}. For each $Y_0\\ge3$ there exist a base $Y_{\\rm base}\\ge3$, a real $Y\\ge Y_0$ with $Y_{\\rm base}\\le Y$ and $Y^2\\le Y_{\\rm base}^J$, and auxiliary primes $q,d$ fixed on $[Y,Y^{3/2}]$. The primes satisfy the conclusions of \\cite[Theorems 5.10 and 5.12]{Adriazola} at $Y_{\\rm base}$ with $K=J$ and $\\tau=\\varepsilon$. At each real $x$ in the window, admissible data in the sense of \\cite[Definition 18.1]{Adriazola} give the groups of \\ref{8JVC} and \\ref{8JVP} and a nonempty set $T\\subseteq A$. For each coset $C\\in A/A_0$ the proportions $\\mu_C,\\lambda_C$ of \\ref{8JVA} with $k=3$ satisfy\n\\[\n|\\mu_C-\\lambda_C|\\le x^{-1+\\varepsilon}.\n\\]\nFor the window argument see \\cite[Section 11]{Outline} and \\cite[Proposition 18.4]{Adriazola}. For the coset proportions of $T$, see \\cite[Lemma 5.18 and Proposition 5.20]{Adriazola}.", "section_id": 114, "position": 1, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '127', 4, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JU8", "type": "lemma", "title": "The cohomological length bound", "statement_tex": "Let $E$ be an auxiliary field, $S_\\ell$ its set of places above the prime $\\ell$, and $G_{E,S_\\ell}$ the Galois group of the maximal extension of $E$ unramified at finite places outside $S_\\ell$. For a positive integer $r$ set\n$$\nS_{\\ell,r}(E)=\\ker\\left(\n H^1(G_{E,S_\\ell},\\Q_\\ell/\\Z_\\ell(-r))\n \\longrightarrow \\prod_{v\\mid\\ell}H^1(E_v,\\Q_\\ell/\\Z_\\ell(-r))\n\\right).\n$$\nOn the interval supplied by the field-existence input in the proof of \\ref{8JU7}, let $s=\\lfloor x^{401}\\rfloor$ and $b=\\exp(x^\\varepsilon)$. For every finite set $S$ of primes the groups in the sum are finite and satisfy\n$$\n\\sum_{\\ell\\in S}(\\ln\\ell)\\sum_{1\\le r<s}\n \\operatorname{length}_{\\Z_\\ell} S_{\\ell,r}(E)\\le\\sqrt b.\n$$", "section_id": 106, "position": 2, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 0}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '129', 3, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JUA", "type": "proposition", "title": "A bound for each translate", "statement_tex": "Use the \\hyperref[8JVE]{Fourier data} and the \\hyperref[8JVF]{centered sums} $\\Delta_u$ on a window of \\ref{8JU7}. Let $a_E$ be the common size parameter in the estimates at each step and let $k$ be the parameter controlling the rank error. Set\n\\[\n\\mathcal B=h a_E\\left(1+\\frac{m^2}{k}\\right)\n +m\\left(2nmbx^\\varepsilon\n      +\\frac{h_2kb x^{2\\varepsilon}}{n^2}\\right).\n\\]\nFor the \\hyperref[8JV2]{error exponents} $e_D,e_L$, there is a common $E_{\\rm err}\\ge0$ such that for every $u\\in A_0$,\n\\[\n\\Delta_u\\le E_{\\rm err}\n\\le x^{(e_D+e_L+3)\\varepsilon}\\mathcal B.\n\\]", "section_id": 107, "position": 1, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '130', 3, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JUB", "type": "lemma", "title": "Rank from the period matrices", "statement_tex": "Let $B_i$ be the matrices for the period maps into a common $D$-dimensional Hermitian space. For any positive real normalizing weights $\\gamma_i$ indexed by these matrices, put\n\\begin{align*}\nK_{ij}&=\\sqrt{\\gamma_i\\gamma_j}\\,B_i^*B_j,\\\\\nP&=\\sum_i\\gamma_i B_iB_i^*.\n\\end{align*}\nIf $P\\ne 0$ and $\\operatorname{tr}(P^2)\\le(1+\\eta)(\\operatorname{tr}P)^2/D$, then $\\operatorname{rank}P\\ge D/(1+\\eta)$.", "section_id": 107, "position": 2, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 0}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '131', 7, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JUC", "type": "lemma", "title": "Matching the main terms", "statement_tex": "Use $\\Phi,f$ and $\\xi_c$ from \\ref{8JVP} and the primitive representative $\\xi_c^*$ from \\ref{8JVQ}. In the normalization of \\cite[Section 8]{Outline}, let $v_0$ be the geometric normalization parameter. For the scales $\\upsilon_t$ of \\ref{8JVK}, put\n\\begin{align*}\nA_*&=\\sum_{t\\in T}\\upsilon_t,\\\\\n\\ell&=\\Re\\left(\\frac{L''(1,\\xi_c^*)}{L(1,\\xi_c^*)}\\right).\n\\end{align*}\nThe divisibility main term is\n\\[\nD_{\\rm div}=m\\sum_t \\upsilon_t\\bigl(\\ln \\upsilon_t-1-\\gamma-\\ln(\\pi/v_0)+\\ell\\bigr).\n\\]\nAt each level $1\\le j\\le m$, write $w_j\\colon\\Phi\\to(0,\\infty)$ for its weight function and $w_{j,\\alpha}=w_j(\\alpha)$ for $\\alpha\\in\\Phi$. The chain uses $w_j=w_{u,j}$ of \\ref{8JVK} for a fixed $u\\in A_0$. Let $g_0$ be the common logarithmic index term and $E_{\\rm count}$ the error in the counting lower bound. With\n\\[\n\\lambda=\\sum_j\\frac1f\\sum_{\\alpha\\in\\Phi}\\ln(w_{j,\\alpha}v_0/\\pi)\n      +mg_0-E_{\\rm count},\n\\]\none has\n\\[\nD_{\\rm div}-A_*\\lambda+mA_*g_0\n=\\sum_{t,j}\\Re M(\\upsilon_t,w_j)+A_*E_{\\rm count},\n\\]\nwhere $M$ is as in \\ref{8JU9}.", "section_id": 107, "position": 3, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 0}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '132', 4, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JUD", "type": "lemma", "title": "The Fourier comparison", "statement_tex": "For each primitive $\\psi$ of order $o$, take $\\varepsilon_0(\\psi)$ from \\ref{8JU7}. For each $0<\\varepsilon<\\varepsilon_0(\\psi)$ there is $x_{\\rm cmp}=x_{\\rm cmp}(\\psi,\\varepsilon)\\ge\\max(x_{\\rm wt},x_{\\rm aux})$, with $x_{\\rm wt}$ from \\ref{8JVK} and $x_{\\rm aux}$ from \\ref{8JVH}. For every window $[Y,Y^{3/2}]$ and primes $q,d$ as in \\ref{8JU7}, and every real $x\\in[Y,Y^{3/2}]$ with $x\\ge x_{\\rm cmp}$, take the \\hyperref[8JVE]{Fourier data} and the estimates of \\ref{8JVH}. Then\n\\[\n\\mathcal G_\\psi(x)\n\\le D_\\psi(x)+\\frac{4}{x\\delta_2}\n        +(3o+4)x^{1/2+\\varepsilon},\n\\]\nwhere $D_\\psi$ is defined in \\ref{8JVF}.", "section_id": 108, "position": 4, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '134', 4, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JUF", "type": "proposition", "title": "The arithmetic bound from the four errors", "statement_tex": "For each primitive $\\psi$, take $\\varepsilon_0(\\psi)$ from \\ref{8JU7}. For each $0<\\varepsilon<\\varepsilon_0(\\psi)$ there is a threshold $x_{\\rm arith}=x_{\\rm arith}(\\psi,\\varepsilon)\\ge x_{\\rm wt}$, with $x_{\\rm wt}$ from \\ref{8JVK}. For every $Y_0\\ge3$, there is a window $[Y,Y^{3/2}]$ of \\ref{8JU7} with $Y\\ge\\max(Y_0,x_{\\rm arith})$, a pair of auxiliary primes $q,d$ fixed on the window, and error exponents $e_D=2$, $e_L=0$. For every real $x$ in that window the normalized count of \\ref{8JVF} satisfies\n\\[\nD_\\psi(x)\\le 20x^{1/2+61\\varepsilon/8}.\n\\]", "section_id": 109, "position": 1, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '135', 2, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JUG", "type": "lemma", "title": "Sizes of the four normalized errors", "statement_tex": "For the parameters of \\ref{8JUA}, with $Q,\\delta_2$ as in \\ref{8JVE}, one has\n\\begin{align*}\n0\\le a_E&\\le 2xb, & h&\\ge\\tfrac12 n x^{-\\varepsilon/8},\\\\\nx^{1/2-\\varepsilon}\\le m&\\le x^{1/2+\\varepsilon/2},&\nxm&\\le k\\le n^2x^{1/2-\\varepsilon},\\\\\nx^{-\\varepsilon}\\le\\delta_2&\\le1.\n\\end{align*}\nIn particular $\\mathcal B/Q\\le 10x^{1/2+13\\varepsilon/8}$.", "section_id": 109, "position": 2, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 0}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '153', 5, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JUW", "type": "definition", "title": "The auxiliary-character sum $\\Sigma(x)$", "statement_tex": "Use the data of \\ref{8JVE} and the character notation of \\ref{8JVQ}. Identify $A$ with its image under the embedding $A\\to B$ of \\ref{8JVP}. With $\\mathcal C_\\psi$ the \\hyperref[8JG8]{cyclic family}, put\n\\[\n\\begin{aligned}\n\\mathcal H &= \\left\\{\\xi\\in\\widehat B \\;\\middle|\\; \\xi|_{A_0}=1\\right\\},\\\\\n\\mathcal K &= \\left\\{\\xi\\in\\mathcal H \\;\\middle|\\; \\xi^*\\in\\mathcal C_\\psi\\right\\}.\n\\end{aligned}\n\\]\nAt each $x$ in the window of \\ref{8JVE}, define the nonnegative real sum\n\\[\n\\Sigma(x)=\\sum_{\\xi\\in\\mathcal H\\smallsetminus\\mathcal K}\n                 |G_{\\xi^*}(x)|.\n\\]", "section_id": 108, "position": 3, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '154', 3, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JV2", "type": "definition", "title": "The error exponents $e_D$ and $e_L$", "statement_tex": "For a chain of $m$ theta lifts at scale $x$ with parameter $\\varepsilon>0$ and translates $t\\in T$, write $h=|T|$, $n=|A|$, and $b=\\exp(x^\\varepsilon)$ as in \\ref{8JVE}. The number of large weights per level is $h_2=|T_2|$ in that notation. Write $k$ for the rank-error parameter of the chain. Put\n$$\nB_0=2nmbx^\\varepsilon,\\qquad N_c=\\frac{h_2 k b x^{2\\varepsilon}}{n^2}.\n$$\nFor $u_0\\in A_0$, let $S$ be the sum of the \\hyperref[8JU9]{weighted prime-power counts} over $t\\in T$ and the $m$ levels, with the weight functions $w_{u_0,j}$ of \\ref{8JVK}. Let $\\Gamma$ be the total divisibility gain of the lifts at the inert primes and $I$ the index loss there.\n\nThe nonnegative numbers $e_D,e_L$ are error exponents if there is a constant $C>0$, independent of $x$, such that for the theta-lift chains at all scales $x$ of the construction and for every $u_0\\in A_0$,\n$$\nS-\\Gamma\\leqslant C\\,hmb\\,x^{e_L\\varepsilon},\n\\qquad 0\\leqslant I\\leqslant C\\,hmb\\,x^{e_L\\varepsilon},\n$$\nand, for every auxiliary prime $T_u$ of the chain,\n$$\n\\mu(R)+h_u-L\\leqslant D_u+C\\,h\\,\\upsilon\\Lambda_{\\upsilon}+C\\,m(B_0+N_c)\\,x^{e_D\\varepsilon}.\n$$\nHere $\\mu(R)$ is the slope of the lattice $R$ of automorphic forms at the top of the chain, $h_u$ bounds the height of the period map at $T_u$, $L$ is the sum of the local terms of the lifts, $D_u$ is the divisibility main term at $T_u$, $\\upsilon=xb$, and $\\Lambda_{\\upsilon}=\\ln(\\upsilon\\,\\mathrm{rd}_E)$ with $\\mathrm{rd}_E$ the root discriminant of the auxiliary field $E$.\nSee \\cite[Definition 18.9]{Adriazola}.", "section_id": 106, "position": 1, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '162', 5, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JVE", "type": "definition", "title": "Data for the Fourier step", "statement_tex": "Fix a primitive $\\psi$ of order $o$, a real $\\varepsilon>0$, and a point $x\\ge3$ in a window $[Y,Y^{3/2}]$. Use the residue groups and primes of \\ref{8JVC} and the quadratic coordinates of \\ref{8JVP}. Take a nonempty $T\\subseteq A$. For the proportions $\\mu_C,\\lambda_C$ of \\ref{8JVA} with $k=3$, require\n\\[\n|\\mu_C-\\lambda_C|\\le x^{-1+\\varepsilon}\\qquad(C\\in A/A_0).\n\\]\nChoose $b,X'',b'',\\rho_w,m$ and a nonempty $T_2\\subseteq A_0$ with the properties in \\ref{8JVK}, together with the positive scales $\\upsilon_t$ for $t\\in T$ and the weight functions $w_{u,j}\\colon\\Phi\\to(0,\\infty)$ for $u\\in A_0$ and $1\\le j\\le m$ specified there. Put\n\\begin{align*}\nn&=|A|,\\quad h=|T|,\\quad h_2=|T_2|,\\\\\n\\delta_2&=\\frac{h_2}{n},\\\\\nQ&=hmb.\n\\end{align*}\nRequire $x^{-\\varepsilon}\\le\\delta_2\\le1$.", "section_id": 114, "position": 3, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '163', 3, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JVF", "type": "definition", "title": "The normalized centered count $D_\\psi(x)$", "statement_tex": "At any point $x$ with data as in \\ref{8JVE}, use $S$ and $M$ from \\ref{8JU9}. The centered sum $\\Delta\\colon A_0\\to\\R$ and the real normalized value $D_\\psi(x)$ for those data are\n\\begin{align*}\n\\Delta_u\n &=\\sum_{t\\in T}\\sum_{j=1}^{m}\n \\bigl(S(t,\\upsilon_t,w_{u,j})-\\Re M(\\upsilon_t,w_{u,j})\\bigr)\n &&(u\\in A_0),\\\\\nD_\\psi(x)\n &=\\frac{2}{Q\\delta_2}\\cdot\\frac1{|A_0|}\n       \\sum_{u\\in A_0}\\Delta_u .\n\\end{align*}", "section_id": 114, "position": 4, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '164', 3, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JVG", "type": "theorem", "title": "Arithmetic bound", "statement_tex": "For each primitive $\\psi$, take $\\varepsilon_0(\\psi)$ from \\ref{8JU7}. For every $\\eta>0$, every $0<\\varepsilon<\\varepsilon_0(\\psi)$ with $61\\varepsilon/8\\le\\eta$, and every $Y_0\\ge3$, there is a window $[Y,Y^{3/2}]$ and a pair of auxiliary primes $q,d$ as in \\ref{8JU7}, with $Y\\ge\\max(Y_0,x_{\\rm aux})$ for $x_{\\rm aux}$ from \\ref{8JVH}, with the following property. At every real $x$ in the window there are data as in \\ref{8JVE}, built from the choices of \\ref{8JU7} and \\ref{8JVK}, satisfying the estimates of \\ref{8JVH}, with\n\\[\nD_\\psi(x)\\le 20x^{1/2+\\eta}.\n\\]", "section_id": 114, "position": 5, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '165', 3, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JVH", "type": "lemma", "title": "Analytic estimates for the auxiliary characters", "statement_tex": "For each primitive $\\psi$, take $\\varepsilon_0(\\psi)$ from \\ref{8JU7}. For each $0<\\varepsilon<\\varepsilon_0(\\psi)$ there is $x_{\\rm aux}=x_{\\rm aux}(\\psi,\\varepsilon)\\ge x_{\\rm wt}$, with $x_{\\rm wt}$ from \\ref{8JVK}, such that the following estimates hold for every window $[Y,Y^{3/2}]$ and primes $q,d$ as in \\ref{8JU7} and every real $x\\in[Y,Y^{3/2}]$ with $x\\ge x_{\\rm aux}$. Use the Fourier data of \\ref{8JVE}, the representative $\\xi^*$ from \\ref{8JVQ}, and the \\hyperref[8JF7]{smoothed prime sum} $G_{\\xi^*}$.\n\n\\begin{enumerate}\n\\item[(i)] For each $\\xi\\in\\widehat B$ and each real $y\\ge X''/3$,\n\\[\n|G_{\\xi^*}(y)|\\le y\\omega_x,\\qquad\n\\omega_x=\\exp(-x^{\\varepsilon/8}),\\qquad\n2f(x+1)\\omega_x\\le 1/x.\n\\]\n\\item[(ii)] For every $\\xi$ indexing the \\hyperref[8JUW]{auxiliary-character sum},\n\\[\n|G_{\\xi^*}(x)|\\le x^{1/2+\\varepsilon},\\qquad\n\\left|\\frac{L''(1,\\xi^*)}{L(1,\\xi^*)}\\right|\n\\le C_{\\rm twist}(\\psi,\\varepsilon)\\ln(x+1).\n\\]\nHere $C_{\\rm twist}(\\psi,\\varepsilon)>0$ is independent of the window and of $x$.\n\\end{enumerate}", "section_id": 108, "position": 1, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '167', 4, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JVK", "type": "lemma", "title": "Scales and weights for the theta lifts", "statement_tex": "For each primitive $\\psi$, take $\\varepsilon_0(\\psi)$ from \\ref{8JU7}. For each $0<\\varepsilon<\\varepsilon_0(\\psi)$ there is $x_{\\rm wt}=x_{\\rm wt}(\\varepsilon)\\ge3$ such that the following holds for every window $[Y,Y^{3/2}]$ and primes $q,d$ as in \\ref{8JU7} and every real $x\\in[Y,Y^{3/2}]$ with $x\\ge x_{\\rm wt}$. Use the groups of \\ref{8JVC} and \\ref{8JVP} and the nonempty $T\\subseteq A$ of \\ref{8JU7} at $x$. Put\n\\[\n\\begin{aligned}\nb&=\\exp(x^\\varepsilon),\\\\\nX''&=\\exp(x^{\\varepsilon/3})\\ge3,\\\\\nb''&=\\frac{xb}{X''}.\n\\end{aligned}\n\\]\nThe data at $x$ include a chain of $m\\ge1$ successive theta lifts between spaces of automorphic forms on definite unitary groups of increasing rank. There is a nonempty subset $T_2\\subseteq A_0$ and, for each $t\\in T$, a positive scale $\\upsilon_t$ with $|\\upsilon_t/b-x|\\le1$. For each $u\\in A_0$, put\n\\[\n\\Phi_u=\\left\\{(0,1,z+u)\\in\\Phi \\;\\middle|\\; z\\in T_2\\right\\}.\n\\]\nThere is a real $\\rho_w$ with $0\\le\\rho_w\\le b$ and $6f(x+1)\\rho_w\\le b/x$. For each $u\\in A_0$ and each integer $1\\le j\\le m$, the weight function $w_{u,j}\\colon\\Phi\\to(0,\\infty)$ records the archimedean parameter at each label $\\alpha\\in\\Phi$ for the $j$th lift. It satisfies\n\\[\n\\begin{aligned}\n b\\le w_{u,j}(\\alpha)\\le b+\\rho_w &\\qquad(\\alpha\\in\\Phi_u),\\\\\n 0<w_{u,j}(\\alpha)\\le2b'' &\\qquad(\\alpha\\in\\Phi\\smallsetminus\\Phi_u).\n\\end{aligned}\n\\]", "section_id": 114, "position": 2, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '112', 6, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 126, "body_tex": "\\emph{(1)} Fix $J$ as in \\cite[Proposition 18.4]{Adriazola} for this $\\psi,\\varepsilon$. Choose $q$, then $d$, at $Y_{\\rm base}$ using \\cite[Theorems 5.10 and 5.12]{Adriazola} with $K=J$ and $\\tau=\\varepsilon$. Zero-density and mean-square estimates bound the candidates that fail the zero-free or smoothed-sum tests. Taking the union over the finitely many characters at the fixed modulus still leaves admissible primes. The pair works on $[Y_{\\rm base},Y_{\\rm base}^J]$, which contains $[Y,Y^{3/2}]$ by $Y_{\\rm base}\\le Y$ and $Y^2\\le Y_{\\rm base}^J$. See also \\cite[Section 11]{Outline}.\n\n\\emph{(2)} The field-existence input gives a window $[W,W^2]$ with control of a weighted sum of cohomological lengths, which the lattice estimates use later. The set $T$ is chosen with the coset proportions of \\cite[Lemma 5.18 and Proposition 5.20]{Adriazola}. The subset $T_2$ used for the large weights in \\ref{8JVK} comes from the separate construction in Proposition 5.17.\n\n\\emph{(3)} To account for a fixed factor in the tower parameter, use the cohomological data at $x/\\kappa$ for a fixed $\\kappa\\ge1$. For $Y=\\kappa W$ and $W\\ge\\kappa^3$, both $x$ and $x/\\kappa$ stay in $[W,W^2]$ throughout $[Y,Y^{3/2}]$. The spare power in the cohomological cutoff permits this rescaling. See \\cite[Section 11]{Outline} and \\cite[Proposition 18.4]{Adriazola}. Take $\\varepsilon_0(\\psi)$ to be the bound $\\varepsilon_1$ in \\cite[Hypothesis 18.10]{Adriazola}. For the fixed $J$, the chain data at these scales use the threshold and exponents of that hypothesis, as in the proof of Theorem A in Section 18.6. Take $Y_{\\rm base}$ large enough for prime selection and admissibility and $Y$ large enough for the chain-record threshold.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '113', 1, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 127, "body_tex": "At odd $\\ell$ the two projectors $(1\\pm(-1)^r c)/2$ for complex conjugation $c$ split the length into two pieces. The source treats $\\ell=2$ separately and uses cyclotomic control and counting by residual character type for the odd-prime pieces. For the positive piece, the estimate for $\\ell-1\\nmid 2r$ already sums over primes. For $\\ell-1\\mid 2r$, the primes satisfy $\\ell\\le 2r+1$, so the componentwise bounds suffice. The finitely many exceptional odd primes have separate bounds. These inputs give, in total, a bound of the form $\\exp(o(x^\\varepsilon))$ on the common interval. The bound is uniform in the finite set $S$. See \\cite[Sections 3--5 and Appendix A]{Outline}.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '114', 5, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 129, "body_tex": "\\emph{(1) Compare periods in a common lattice.} A chain of theta lifts passes between totally definite unitary groups. A seesaw identity compares each period with a Bessel period in a common model. Local vector matching and the common test vectors make the integral comparison compatible with the covolume estimate. The \\hyperref[8JUB]{matrix rank estimate} controls the dimension lost when combining the period maps.\n\n\\emph{(2) Eliminate the common slope.} Divisibility gives a lower bound for the mean quotient slope after subtracting map heights. A Bost-type inequality gives an upper bound for that slope in terms of the common lattice slope. Subtraction eliminates the slopes. Cohomological lengths bound the loss in divisibility, while the covolume, rank and height estimates bound the other losses.\n\n\\emph{(3) Identify the centered count.} The logarithms of the weights $w_{u,j}(\\alpha)$ from \\ref{8JVK} in the divisibility threshold give the average over $\\alpha\\in\\Phi$. The geometric normalizations cancel as in \\ref{8JUC}, leaving the sum of the main terms $M(\\upsilon_t,w_{u,j})$ of \\ref{8JU9}. The resulting estimate on the centered count is the one in \\cite[Section 12, (12.2)]{Outline}. Compare \\cite[Corollary 3.4 and Theorem A(ii)]{Adriazola}, where Section 18.6 obtains the stronger power $x^{3\\varepsilon}$ under the chain-record hypotheses. With the fixed exponents here, $x^{3\\varepsilon}\\le x^{(e_D+e_L+3)\\varepsilon}$ for $x\\ge1$.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '117', 9, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 132, "body_tex": "\\emph{(a) Expand the centered count and control the changes of weight.}\nFix any $u\\in A_0$, $t\\in T$, and integer $1\\le j\\le m$. In the complex sum of \\ref{8JVD} for $(t,\\upsilon_t,w_{u,j})$, keep the positions whose labels lie in $\\Phi_u$ of \\ref{8JVK}, replace their weights by $b$, and omit terms at all other positions. This defines $P\\colon A_0\\times T\\to\\C$ by taking $P(u,t)$ to be the resulting sum before taking real parts. It is independent of $j$.\n\nAt a label $\\alpha=p_t(g)\\in\\Phi_u$, write $w=w_{u,j}^t(g)=w_{u,j}(\\alpha)$. Then \\ref{8JUE} bounds the change in $wG_{\\xi^*}(\\upsilon_t/w)$ by $3(x+1)\\rho_w$, using $\\upsilon_t\\le(x+1)b$ and $b\\le w\\le b+\\rho_w\\le2b\\le \\upsilon_t$. At each other label $\\alpha=p_t(g)\\in\\Phi\\smallsetminus\\Phi_u$, the weight $w=w_{u,j}^t(g)$ satisfies $w\\le2b''$ and\n\\[\n\\frac{\\upsilon_t}{w}\\ge\\frac{(x-1)b}{2b''}\n=\\frac{x-1}{2x}\\,X''\\ge X''/3 .\n\\]\nAll original cutoffs are at least $1$, as required by \\ref{8JVD}, since $2b\\le \\upsilon_t$ and $X''/3\\ge1$. By \\ref{8JVH}(i), each omitted term before its Fourier coefficient has absolute value at most $w(\\upsilon_t/w)\\omega_x\\le(x+1)b\\omega_x$. There are at most $f$ positions and $2f$ characters, and the coefficient has modulus $1/f$. Thus the error for each $(u,t,j)$ is bounded by\n\\[\n6f(x+1)\\rho_w+2f(x+1)b\\omega_x\\le2b/x .\n\\]\nThe first term is at most $b/x$ by \\ref{8JVK}. The second is at most $b/x$ by the bound for $2f(x+1)\\omega_x$ in \\ref{8JVH}(i).\n\n\\emph{(b) Average over $u$.}\nFor each $z\\in T_2$, the class assigning the weight at $(0,1,z+u)$ is $g=(1,0,z+u-t)$, by $p_t$ in \\ref{8JU9}. For $t\\in T$ put $y_t=\\upsilon_t/b$. For $\\xi\\in\\widehat B$ put $\\sigma_\\xi=\\xi(1,0,0)\\in\\{1,-1\\}$. Identify $A$ with its embedded copy as in \\ref{8JVP}. Then\n\\[\nP(u,t)=\\frac b f\\sum_{\\xi\\in\\widehat B}\n \\sigma_\\xi\\xi(t)G_{\\xi^*}(y_t)\n \\sum_{z\\in T_2}\\overline{\\xi(z)}\\,\\overline{\\xi(u)} .\n\\]\nBy \\ref{8JV9}, the mean over $u$ kills all $\\xi$ outside $\\mathcal H$ of \\ref{8JUW}. For $\\xi\\in\\mathcal H$, every $z\\in T_2$ gives $\\xi(z)=1$. Consequently\n\\[\n\\frac1{|A_0|}\\sum_{u\\in A_0}P(u,t)\n=\\frac{b\\delta_2}{2}\\sum_{\\xi\\in\\mathcal H}\n       \\sigma_\\xi\\xi(t)G_{\\xi^*}(y_t).\n\\]\nThe coefficient is $bh_2/f=b\\delta_2/2$. After summation over $h$ choices of $t$ and $m$ choices of $j$, it becomes $Q\\delta_2/2$. In particular that is the coefficient of $G_{\\mathbf1}(x)$ after moving to $x$. Dividing the error $2hmb/x$ from (a) by this factor gives $4/(x\\delta_2)$.\n\n\\emph{(c) Move the cutoffs to $x$.}\nFor $\\xi\\in\\mathcal H$, use the complex value $\\ell_\\xi=L''(1,\\xi^*)/L(1,\\xi^*)$ when $\\xi^*\\ne\\mathbf1$, and $\\ell_\\xi=0$ otherwise. Off the integer breakpoints, differentiating $G_{\\xi^*}(y)$ gives the sum $\\sum_{n\\le y}\\Lambda(n)\\xi^*(n)/n$ plus $\\ell_\\xi$ for nontrivial $\\xi^*$, or plus $-\\ln y+\\gamma$ for the trivial character. Use $\\Theta(v)=\\sum_{n\\le v}\\Lambda(n)$ for real $v\\ge1$ as in the proof of \\ref{8JUE}. The Chebyshev bound $\\Theta(v)\\le3v$ and partial summation give\n\\[\n\\sum_{n\\le y}\\frac{\\Lambda(n)}n\n=\\frac{\\Theta(y)}y+\\int_1^y\\frac{\\Theta(v)}{v^2}\\,dv\n\\le 3+3\\ln y .\n\\]\nEach sum is continuous at its breakpoints, so integration on the pieces between $y_t$ and $x$ gives\n\\[\n|G_{\\xi^*}(y_t)-G_{\\xi^*}(x)|\n\\le L_x=3+|\\gamma|+4\\ln(x+1)+\\max_{\\xi\\in\\mathcal H}|\\ell_\\xi|.\n\\]\nHere $|y_t-x|\\le1$ and $x\\ge3$. The quotient $B/A_0=\\Z/2\\Z\\times\\Z/2\\Z\\times(A/A_0)$ has $4o$ characters, so this replacement costs at most $4oL_x$ after the division in (b).\n\n\\emph{(d) Apply the coset average.}\nFor $\\xi\\in\\mathcal H$ put $\\beta_\\xi=h^{-1}\\sum_{t\\in T}\\xi(t)\\in\\C$. After the replacement in (c), the normalized expression is\n\\[\n\\Re\\sum_{\\xi\\in\\mathcal H}\n       \\sigma_\\xi\\beta_\\xi G_{\\xi^*}(x).\n\\]\nBy the product coordinates in \\ref{8JVP} and the subgroup $A_0$ in \\ref{8JVC}, the characters in $\\mathcal H$ are the $o$ powers of $\\psi_A$ on $A/A_0$ with each of the four pairs of quadratic signs on the other two factors. The $o$ choices with both signs trivial give $\\mathcal K$ and have $\\sigma_\\xi=1$. The remaining $3o$ have a quadratic factor at $q$ or $d$: the Chinese remainder factors at those primes are independent of $A$, and a nontrivial factor forces that prime into the primitive conductor. This also shows why no extra character induces a member of $\\mathcal C_\\psi$.\n\nFor $\\xi\\in\\mathcal K$, the $k=3$ target $c_3(\\xi|_A)$ is $a_{\\xi^*}$ of \\ref{8JG8}. Applying \\ref{8JVA} with $k=3$ gives $|\\beta_\\xi-a_{\\xi^*}|\\le\\nu_x=o x^{-1+\\varepsilon}$. For every other $\\xi$, $|\\sigma_\\xi\\beta_\\xi|\\le1$. Combining (a)--(d) now gives\n\\begin{align*}\n\\mathcal G_\\psi(x)\n &\\le D_\\psi(x)+\\frac{4}{x\\delta_2}+\\Sigma(x)\\\\\n &\\quad+4oL_x+\\nu_x\\sum_{\\xi\\in\\mathcal K}|G_{\\xi^*}(x)|.\n\\end{align*}\nIn this inequality $\\Sigma(x)\\le3o\\,x^{1/2+\\varepsilon}$ by \\ref{8JVH}(ii). That lemma also gives $L_x=O_{\\psi,\\varepsilon}(\\ln(x+1))$, since the other $\\ell_\\xi$ come from the fixed family $\\mathcal C_\\psi$. The growth bound in \\ref{8JS3} gives\n\\[\n\\nu_x\\sum_{\\xi\\in\\mathcal K}|G_{\\xi^*}(x)|\n=O_\\psi\\bigl(x^\\varepsilon(1+\\ln x)^2\\bigr).\n\\]\nThe sum of these two errors is $o(x^{1/2+\\varepsilon})$, uniformly in the window, since the constants depend only on $\\psi,\\varepsilon$. Choose $x_{\\rm cmp}\\ge\\max(x_{\\rm wt},x_{\\rm aux})$ so that the sum is at most $4x^{1/2+\\varepsilon}$ at every $x\\ge x_{\\rm cmp}$.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '118', 4, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 133, "body_tex": "For $v\\in(0,\\upsilon]$, put $F(v)=vG_\\chi(\\upsilon/v)\\in\\C$. For real $z\\ge1$, put $\\Theta(z)=\\sum_{n\\le z}\\Lambda(n)\\in[0,\\infty)$. We use the Chebyshev bound $0\\le\\Theta(z)\\le3z$ for $z\\ge1$ (see \\cite[Lemma 4.1]{Adriazola}). The expression for $F$ from \\ref{8JF7} is a sum of $\\Lambda(n)\\chi(n)(\\upsilon/n-v)_+$ plus the main-term correction. There are finitely many breakpoints $v=\\upsilon/n$ between $w$ and $w''$. The sum is continuous there, since the term crossing the cutoff is zero at its breakpoint.\n\nFor nontrivial $\\chi$ the correction is the constant $\\upsilon L''(1,\\chi)/L(1,\\chi)$. Off the breakpoints, $F''(v)=-\\sum_{n\\le \\upsilon/v}\\Lambda(n)\\chi(n)$ and $|F''(v)|\\le3\\upsilon/v$. For the trivial character the correction is $-\\upsilon\\ln(\\upsilon/v)+(1+\\gamma)\\upsilon$, giving $F''(v)=\\upsilon/v-\\Theta(\\upsilon/v)$. Since $0\\le\\Theta(\\upsilon/v)\\le3\\upsilon/v$, its absolute value is at most $2\\upsilon/v$. In either case, integrate the derivative on each subinterval and use continuity at its endpoints. The bound $3\\upsilon/v\\le3\\upsilon/\\min(w,w'')$ on the whole interval gives the result.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '119', 5, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 134, "body_tex": "Choose $x_{\\rm arith}\\ge x_{\\rm wt}$ large enough for the per-shift bound of \\ref{8JUA} and the estimates of \\ref{8JUG}. The chain-record threshold uses the exponent $J(\\psi,\\varepsilon)$ fixed in \\ref{8JU7}. Apply \\ref{8JU7} with starting bound $\\max(Y_0,x_{\\rm arith})$. On the resulting window, the integral theta-lift data with error exponents $e_D=2$ and $e_L=0$ come from \\cite[Hypothesis 18.10]{Adriazola} at the fixed $J$, as in the proof of Theorem A in Section 18.6. At every $x$ in the resulting window, using $\\mathcal B$ and $E_{\\rm err}$ of \\ref{8JUA}, we have\n\\begin{align*}\nD_\\psi(x)\n &\\le \\frac{2E_{\\rm err}}{Q\\delta_2} &&\\text{(a)}\\\\\n &\\le 2x^{(e_D+e_L+3)\\varepsilon}\n              \\frac{\\mathcal B}{Q}\\delta_2^{-1} &&\\text{(b)}\\\\\n &\\le 20x^{1/2+(e_D+e_L+45/8)\\varepsilon} &&\\text{(c)}\\\\\n &=20x^{1/2+61\\varepsilon/8}. &&\\text{(d)}\n\\end{align*}\n(a) Average $\\Delta_u\\le E_{\\rm err}$ and divide by $Q\\delta_2/2>0$.\n(b) Apply the per-shift bound of \\ref{8JUA}.\n(c) Use $\\mathcal B/Q\\le 10x^{1/2+13\\varepsilon/8}$ and $\\delta_2^{-1}\\le x^\\varepsilon$ from \\ref{8JUG}; the exponent increment is $3+13/8+1=45/8$.\n(d) Insert the chosen exponents.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '130', 1, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 152, "body_tex": "This is Dirichlet''s theorem \\cite{Davenport}.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '135', 2, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 164, "body_tex": "Apply \\ref{8JUF} with requested lower bound $\\max(Y_0,x_{\\rm aux})$ for $Y$. This gives $Y\\ge\\max(Y_0,x_{\\rm arith},x_{\\rm aux})$, with $x_{\\rm arith}\\ge x_{\\rm wt}$. On this window, \\ref{8JU7} supplies the groups, primes and coset proportions. \\ref{8JVK} gives the weight properties, and \\ref{8JUG} gives the lower bound on $\\delta_2$. The bound of \\ref{8JUF} applies at every $x$ in the window. Since $x\\ge3$ and $61\\varepsilon/8\\le\\eta$, it gives $D_\\psi(x)\\le20x^{1/2+61\\varepsilon/8}\\le20x^{1/2+\\eta}$.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '136', 2, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 165, "body_tex": "For (i), use the conductor bound $\\ln\\operatorname{cond}(\\xi^*)\\le C(\\psi)x^{\\varepsilon/5}(\\ln x)^2$ in \\cite[Section 6.3, pp.~43--44]{Adriazola}. It follows from the bounds for $q,d$ at $Y_{\\rm base}\\le x$ and $N_1\\le8N_0|A|$. Real characters involving $q$ or $d$ have the uniform real-zero exclusion in Corollary 5.13. The remaining real characters have conductors dividing a fixed modulus, since real characters of $2$-power conductor have conductor at most $8$. Proposition 5.3 and its trivial-character variant therefore give a uniform large-cutoff bound for $y\\ge X''/3$. In the exponential terms of that estimate, the powers $\\varepsilon/3-\\varepsilon/5$ and $\\varepsilon/6$ both exceed $\\varepsilon/8$. Increasing $x_{\\rm aux}$ gives the stated bound, including $2f(x+1)\\omega_x\\le1/x$ by Proposition 5.16(iv).\n\nFor (ii), every index has a quadratic factor at $q$ or $d$, as explained in \\ref{8JU5}. Theorems 5.10(ii)--(iii) and 5.12(ii)--(iii) apply on $[Y_{\\rm base},Y_{\\rm base}^{J}]$ with the fixed $J=J(\\psi,\\varepsilon)$ of \\ref{8JU7}. The logarithmic derivative is bounded by $401c_0J\\ln Y_{\\rm base}\\le401c_0J\\ln(x+1)$, with the absolute $c_0$ of those theorems. These estimates are uniform over the windows of \\ref{8JU7}. Choose $x_{\\rm aux}\\ge x_{\\rm wt}$ to meet the requirements of (i).", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '137', 2, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 166, "body_tex": "Fix $\\psi$ and $0<\\varepsilon<\\varepsilon_0(\\psi)$ from \\ref{8JU7}, and set $\\eta=61\\varepsilon/8$. Write $o$ for the order of $\\psi$. Use $x_{\\rm cmp}$ from \\ref{8JUD}, which is at least $x_{\\rm wt}$ from \\ref{8JVK} and $x_{\\rm aux}$ from \\ref{8JVH}. For a prescribed $Y_0\\ge1$, apply \\ref{8JVG} with the requested lower bound for $Y$ equal to\n\\[\n\\max\\bigl(Y_0,x_{\\rm cmp},(3o+28)^{8/(11\\varepsilon)}\\bigr).\n\\]\nAt every $x$ on that window, the lower bound $\\delta_2\\ge x^{-\\varepsilon}$ in \\ref{8JVE} gives\n\\[\n\\frac{4}{x\\delta_2}\\le4x^{\\varepsilon-1}\\le4x^{1/2+\\varepsilon}.\n\\]\nThus the error in \\ref{8JUD} is at most $(3o+8)x^{1/2+\\varepsilon}$. Combining \\ref{8JVG} and \\ref{8JUD} now gives\n\\begin{align*}\n\\mathcal G_\\psi(x)\n&\\le 20x^{1/2+61\\varepsilon/8}+(3o+8)x^{1/2+\\varepsilon}\\\\\n&\\le (3o+28)x^{1/2+61\\varepsilon/8}.\n\\end{align*}\nThe difference $9\\varepsilon-61\\varepsilon/8$ is $11\\varepsilon/8>0$. Our choice of starting point gives $x^{11\\varepsilon/8}\\ge3o+28$ throughout the window, so the last bound is at most $x^{1/2+9\\varepsilon}$. More generally, choosing $61\\varepsilon/8\\le\\eta$ gives the upper bound $O_{\\psi,\\eta}(x^{1/2+\\eta})$ on arbitrarily distant windows.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '138', 2, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 167, "body_tex": "The sequence of maps is the one in \\cite[Sections 5.8 and 7, p.~54]{Adriazola}. The kernel of each step defines a map on automorphic forms by summation over the lattice classes at that level. The fixed rank increment is the number of copies of the auxiliary hermitian space added at each step, as in Section 18.1.\n\nThe scales $\\upsilon_t$ are the integers in \\cite[Definition 18.5]{Adriazola}. The set $T_2$ is the image of the integer set in Proposition 5.17 under multiplication by a generator of $A_0$, as in Section 5.8. Proposition 18.7 gives a base value $b_1(\\alpha)$ at each label for each $u$ and sets\n\\[\nw_{u,j}(\\alpha)=b_1(\\alpha)+(j-\\tfrac12)h_0,\\qquad h_0=2\\lceil x^{402}\\rceil .\n\\]\nThese are the second family of archimedean parameters in Corollary 18.8, one function of the label per lift. At the labels in $\\Phi_u$ the base values lie between $\\lceil b\\rceil$ and $\\lceil b\\rceil+W-1$, where $W$ is the number of roots of unity in the auxiliary field. Use $\\rho_w=W+mh_0$.\n\nProposition 5.16 and Corollary 18.8 apply with $|A|\\le2x^{9/4}$, $m\\le2\\sqrt x$ and $W\\le32|A|^2$. These bounds follow from admissibility and are uniform in the window, the primes and the character. Since the proposition fixes the exponent of $h_0$ at $402$ here, its threshold depends only on $\\varepsilon$. Increase it, still using only $\\varepsilon$, to ensure $X''\\ge3$ and the integer intervals in Definition 18.5 are nonempty. For those intervals, $k\\le2x^{9/2+10\\varepsilon}$ by Proposition 5.15(i), so both $xb/(kx^{13})$ and $b''/x^2$ eventually exceed $1$. Proposition 5.16(iii) gives $|\\upsilon_t/b-x|\\le1$, and (i)--(ii) with Corollary 18.8 give the weight bounds.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('setting', 'bibliography', 9, '2503743b-4b31-43ea-90a5-e722b4987310', '{"value": "\\bibitem{Outline} \\emph{The Generalized Riemann Hypothesis for Dirichlet $L$-functions: from smoothed prime sums to zeros on the critical line}, AI-generated natural-language outline of the Lean proof, 21 November 2026.\n\\bibitem{Alpoge} L. Alpöge, \\emph{Remark}, \\url{https://alpo.ge/remark.pdf}.\n\\bibitem{Davenport} H. Davenport, \\emph{Multiplicative Number Theory}, 3rd ed., Graduate Texts in Mathematics 74, Springer, 2000.\n\\bibitem{Adriazola} J. Adriazola, \\emph{The Alpöge Proof of the Riemann Hypothesis}, Arizona State University, 2026.\n\\bibitem{Erdos1932} P. Erdős, \\emph{Beweis eines Satzes von Tschebyschef}, Acta Sci. Math. (Szeged) 5 (1932), 194–198. \\url{https://acta.bibl.u-szeged.hu/13396/}\n\\bibitem{Honda1968} T. Honda, \\emph{Formal groups and zeta-functions}, Osaka J. Math. 5 (1968), 199–213. \\url{https://ir.library.osaka-u.ac.jp/repo/ouka/all/8997/}"}', 'codex', '2026-11-27 16:00:00');

-- Reserve new tags.

INSERT INTO tags (tag, kind, created_at)
VALUES ('C3R2', 'result', '2026-11-27 16:00:00');

INSERT INTO tags (tag, kind, created_at)
VALUES ('C3T2', 'result', '2026-11-27 16:00:00');

INSERT INTO tags (tag, kind, created_at)
VALUES ('C4S2', 'result', '2026-11-27 16:00:00');

INSERT INTO tags (tag, kind, created_at)
VALUES ('C4W2', 'result', '2026-11-27 16:00:00');

-- Install the new text and save each new revision.

UPDATE sections
SET intro_tex = 'Chapter 1 reduces the problem to an upper bound for the \hyperref[8JG8]{weighted prime sum} $\mathcal G_\psi$. Here we recover that sum from counts of prime powers sorted by residue class. Fix any \hyperref[8JH4]{primitive character} $\psi$ and any real $\eta>0$ as the margin above the square-root exponent. The arithmetic bound \ref{8JVG} supplies windows $[Y,Y^{3/2}]$ with $Y$ arbitrarily large and a choice of data at each $x$. For every $x$ in a chosen interval we have the arithmetic bound on the \hyperref[8JVF]{normalized count} $D_\psi(x)$ and the Fourier comparison:
\[
\begin{aligned}
D_\psi(x)&\le Cx^{1/2+\eta},\\
\mathcal G_\psi(x)&\le D_\psi(x)+O_{\psi,\eta}(x^{1/2+\eta}).
\end{aligned}
\]
Together they give $\mathcal G_\psi(x)\le C''x^{1/2+\eta}$. The constants are independent of the interval and of $x$ in it. Chapter 4 (\ref{8JV5}) outlines the first inequality, the arithmetic input used here.

This chapter proves the second inequality. We learn two finite-group averages, expand the prime-power count in characters, and specify the data supplied by the arithmetic bound. Finally we apply the two averages to the expansion and track the errors. We choose auxiliary primes in \ref{8JU7} and prove their analytic estimates in \ref{8JVH}.',
    revision = 6,
    updated_at = '2026-11-27 16:00:00',
    intro_html_cache = NULL
WHERE id = 105;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '105', 6, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JU2", "parent_id": null, "kind": "chapter", "title": "The Fourier step", "intro_tex": "Chapter 1 reduces the problem to an upper bound for the \\hyperref[8JG8]{weighted prime sum} $\\mathcal G_\\psi$. Here we recover that sum from counts of prime powers sorted by residue class. Fix any \\hyperref[8JH4]{primitive character} $\\psi$ and any real $\\eta>0$ as the margin above the square-root exponent. The arithmetic bound \\ref{8JVG} supplies windows $[Y,Y^{3/2}]$ with $Y$ arbitrarily large and a choice of data at each $x$. For every $x$ in a chosen interval we have the arithmetic bound on the \\hyperref[8JVF]{normalized count} $D_\\psi(x)$ and the Fourier comparison:\n\\[\n\\begin{aligned}\nD_\\psi(x)&\\le Cx^{1/2+\\eta},\\\\\n\\mathcal G_\\psi(x)&\\le D_\\psi(x)+O_{\\psi,\\eta}(x^{1/2+\\eta}).\n\\end{aligned}\n\\]\nTogether they give $\\mathcal G_\\psi(x)\\le C''x^{1/2+\\eta}$. The constants are independent of the interval and of $x$ in it. Chapter 4 (\\ref{8JV5}) outlines the first inequality, the arithmetic input used here.\n\nThis chapter proves the second inequality. We learn two finite-group averages, expand the prime-power count in characters, and specify the data supplied by the arithmetic bound. Finally we apply the two averages to the expansion and track the errors. We choose auxiliary primes in \\ref{8JU7} and prove their analytic estimates in \\ref{8JVH}.", "position": 3}', 'codex', '2026-11-27 16:00:00');

UPDATE sections
SET intro_tex = '\ref{C4S2} gives the arithmetic inputs on a common window. The field-existence step locates the window, and admissibility gives the cohomological bound in \ref{8JU8}. The chain records supply the \hyperref[8JV2]{error exponents} for the lattice comparison.

The auxiliary field has group $B=\Z/2\Z\times\Z/2\Z\times A$ as in \ref{8JVP}. The signs are cut out by the quadratic fields associated with $d$ and $q$. The group $A$ comes from the fixed conductor and the cyclotomic tower, and $A_0$ is the kernel of the target character on $A$. In the arithmetic construction the shifts in $T$ have both the coset proportions of \ref{8JVE} and restrictions along short progressions that enter the divisibility estimate. See \cite[Sections 5.7--5.8 and 18.1]{Adriazola}.',
    revision = 10,
    updated_at = '2026-11-27 16:00:00',
    intro_html_cache = NULL
WHERE id = 106;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '106', 10, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JU3", "parent_id": 111, "kind": "section", "title": "Error exponents and cohomological lengths", "intro_tex": "\\ref{C4S2} gives the arithmetic inputs on a common window. The field-existence step locates the window, and admissibility gives the cohomological bound in \\ref{8JU8}. The chain records supply the \\hyperref[8JV2]{error exponents} for the lattice comparison.\n\nThe auxiliary field has group $B=\\Z/2\\Z\\times\\Z/2\\Z\\times A$ as in \\ref{8JVP}. The signs are cut out by the quadratic fields associated with $d$ and $q$. The group $A$ comes from the fixed conductor and the cyclotomic tower, and $A_0$ is the kernel of the target character on $A$. In the arithmetic construction the shifts in $T$ have both the coset proportions of \\ref{8JVE} and restrictions along short progressions that enter the divisibility estimate. See \\cite[Sections 5.7--5.8 and 18.1]{Adriazola}.", "position": 1}', 'codex', '2026-11-27 16:00:00');

UPDATE sections
SET intro_tex = '\ref{C4W2} constructs the scales and weights of \ref{8JVK} from the theta lifts. The comparison gives the bound in \ref{8JUA} for every shift $u\in A_0$. The count and its main term are defined in \ref{8JU9}, and the centered sum over $t$ and $j$ is defined in \ref{8JVF}.

For a model, if a nonzero integer $K$ is divisible by all primes in a set $P$, then $\sum_{p\in P}\ln p\le\ln|K|$. Here the integer is replaced by lattices built from a chain of $m$ theta lifts between unitary groups. Prime powers in the relevant classes force extra divisibility. A Bost-type slope inequality bounds the same lattice quantities from above. Comparing the bounds gives the estimate on the count. The \hyperref[8JUB]{matrix rank lemma} and \hyperref[8JUC]{main-term identity} give two elementary pieces of this comparison.',
    intro_html_cache = NULL,
    revision = 8,
    updated_at = '2026-11-27 16:00:00'
WHERE id = 107;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '107', 8, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JU4", "parent_id": 111, "kind": "section", "title": "Bounding the centered count by theta lifts", "intro_tex": "\\ref{C4W2} constructs the scales and weights of \\ref{8JVK} from the theta lifts. The comparison gives the bound in \\ref{8JUA} for every shift $u\\in A_0$. The count and its main term are defined in \\ref{8JU9}, and the centered sum over $t$ and $j$ is defined in \\ref{8JVF}.\n\nFor a model, if a nonzero integer $K$ is divisible by all primes in a set $P$, then $\\sum_{p\\in P}\\ln p\\le\\ln|K|$. Here the integer is replaced by lattices built from a chain of $m$ theta lifts between unitary groups. Prime powers in the relevant classes force extra divisibility. A Bost-type slope inequality bounds the same lattice quantities from above. Comparing the bounds gives the estimate on the count. The \\hyperref[8JUB]{matrix rank lemma} and \\hyperref[8JUC]{main-term identity} give two elementary pieces of this comparison.", "position": 2}', 'codex', '2026-11-27 16:00:00');

UPDATE sections
SET intro_tex = 'We now compare the \hyperref[8JVF]{normalized count} with $\mathcal G_\psi(x)$. The Fourier expansion in \ref{8JVD} puts a copy of $G_\chi$ at each cutoff $\upsilon_t/w_{u,j}(\alpha)$, using the admissible scales and weights of \ref{8JVK}. We replace the weights near $b$ by $b$ and bound the contribution of the other weights at their much larger cutoffs. The two averages then keep the desired characters with the Chapter 1 weights. We estimate separately the changes in the cutoffs and in the coset proportions.

Some extra characters pass the subgroup average. Their prime sums are small by the choice of the auxiliary primes $q,d$ in \ref{8JU7}. \ref{8JVH} proves the analytic estimates, and \ref{8JUD} proves the comparison. The final corollary combines it with the arithmetic bound.',
    intro_html_cache = NULL,
    revision = 5,
    updated_at = '2026-11-27 16:00:00'
WHERE id = 108;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '108', 5, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JU5", "parent_id": 105, "kind": "section", "title": "Recovering the weighted prime sum", "intro_tex": "We now compare the \\hyperref[8JVF]{normalized count} with $\\mathcal G_\\psi(x)$. The Fourier expansion in \\ref{8JVD} puts a copy of $G_\\chi$ at each cutoff $\\upsilon_t/w_{u,j}(\\alpha)$, using the admissible scales and weights of \\ref{8JVK}. We replace the weights near $b$ by $b$ and bound the contribution of the other weights at their much larger cutoffs. The two averages then keep the desired characters with the Chapter 1 weights. We estimate separately the changes in the cutoffs and in the coset proportions.\n\nSome extra characters pass the subgroup average. Their prime sums are small by the choice of the auxiliary primes $q,d$ in \\ref{8JU7}. \\ref{8JVH} proves the analytic estimates, and \\ref{8JUD} proves the comparison. The final corollary combines it with the arithmetic bound.", "position": 4}', 'codex', '2026-11-27 16:00:00');

UPDATE sections
SET intro_tex = 'The bound in \ref{8JUA} holds for each $u\in A_0$, so it also bounds the average of the centered counts. We divide it by the \hyperref[8JVF]{Chapter 3 normalization} to prove the arithmetic bound. The two largest terms in the error balance when the number of lifts $m$ is near $\sqrt x$. \ref{8JUG} gives the four estimates and \ref{8JUF} combines them for the data on the windows of \ref{C4S2}.',
    revision = 5,
    updated_at = '2026-11-27 16:00:00',
    intro_html_cache = NULL
WHERE id = 109;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '109', 5, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JU6", "parent_id": 111, "kind": "section", "title": "Balancing and normalizing the errors", "intro_tex": "The bound in \\ref{8JUA} holds for each $u\\in A_0$, so it also bounds the average of the centered counts. We divide it by the \\hyperref[8JVF]{Chapter 3 normalization} to prove the arithmetic bound. The two largest terms in the error balance when the number of lifts $m$ is near $\\sqrt x$. \\ref{8JUG} gives the four estimates and \\ref{8JUF} combines them for the data on the windows of \\ref{C4S2}.", "position": 3}', 'codex', '2026-11-27 16:00:00');

UPDATE sections
SET intro_tex = 'This chapter outlines the arithmetic bound \ref{8JVG}. The field-existence and chain-record inputs in \ref{C4S2} give data at each point of a common window. \ref{C4W2} checks the weight bounds for the resulting chain of theta lifts. The lattice comparison bounds the centered count for every $u\in A_0$, and the scale estimates give the error after normalizing.

The outlines use the cohomological and chain-record hypotheses in \cite[Hypotheses 17.11 and 18.10]{Adriazola}. The window, the chain and the bound in this chapter are conditional on those inputs.',
    revision = 5,
    updated_at = '2026-11-27 16:00:00',
    intro_html_cache = NULL
WHERE id = 111;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '111', 5, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JV5", "parent_id": null, "kind": "chapter", "title": "The arithmetic bound", "intro_tex": "This chapter outlines the arithmetic bound \\ref{8JVG}. The field-existence and chain-record inputs in \\ref{C4S2} give data at each point of a common window. \\ref{C4W2} checks the weight bounds for the resulting chain of theta lifts. The lattice comparison bounds the centered count for every $u\\in A_0$, and the scale estimates give the error after normalizing.\n\nThe outlines use the cohomological and chain-record hypotheses in \\cite[Hypotheses 17.11 and 18.10]{Adriazola}. The window, the chain and the bound in this chapter are conditional on those inputs.", "position": 4}', 'codex', '2026-11-27 16:00:00');

UPDATE sections
SET intro_tex = 'The weighted prime-power count in \ref{8JU9} assigns classes to prime powers and attaches weights to those classes. Three definitions supply the groups, the labels, and the local character values.

The \hyperref[8JVC]{residue groups for the averages} give the two averages of \ref{8JV6} their inputs. The modulus $N_1$ lets $A$ record both the residue modulo $2^{e+2}$ up to sign and the value of $\psi$. The groups of residues up to sign form the real cyclotomic tower, so increasing $e$ gives room to choose the shift set $T$ for the coset average in \ref{8JVA}. Requiring $\psi_{N_1}(v)=1$ in $U_1$ makes the induced character $\psi_A$ on $A$ independent of the representative of a class. The uniform average in \ref{8JV9} uses $A_0=\ker\psi_A$. Since the image of $\psi_A$ has order $o$, the cosets indexed by $A/A_0$ are the $o$ character-value classes for the second average.

The \hyperref[8JVP]{quadratic coordinates} enlarge $A$ to $B$. The map $\pi$ sends a unit modulo $N=N_1qd$ to its two quadratic bits followed by its class in $A$. The Chinese remainder theorem lets the bits vary independently of the class in $A$. The bit at $d$ distinguishes the half with $\xi_c=-1$, which gives the extra divisibility in the arithmetic argument. The complementary half $\Phi$ labels the weights. The bit at $q$ distinguishes the positions with weights near the reference value in \ref{8JVK}. For any shift $t\in A$, the map $p_t$ of \ref{8JU9} adds $(1,1,t)$. This translation flips the first quadratic bit and gives a bijection from $B\smallsetminus\Phi$ to $\Phi$. Among the characters that survive the subgroup average, those using either quadratic bit are the auxiliary twists. Their smoothed prime sums are small at the target cutoff $x$, as in \ref{8JVH}.

The \hyperref[8JVQ]{prime-power classes and primitive characters} give the inputs to the Fourier expansion in \ref{8JVD}. Away from $N$, the class of $p^i$ is a single element, and only odd powers of a prime with $\xi_c(\vartheta_p)=-1$ enter the count. The \hyperref[8JVM]{example modulo $840$} computes such a class. At $p\mid N$, the prime power has no unit class modulo $N$. The coset $i\vartheta_p+I_p$ uses its residue away from $p$ and shares its mass uniformly across the corresponding classes. The portion outside $\Phi$ enters the count. For each $\xi\in\widehat B$, the value $\xi^*(p^i)$ gives the coset average in the Fourier expansion, including when $p\mid N$.

The count in \ref{8JU9} and the Fourier expansion in \ref{8JVD} allow arbitrary positive weight functions (with $w_\alpha\le\upsilon$ in the Fourier expansion), and \ref{8JVK} specifies the admissible weight functions $w_{u,j}$ used in the normalized count of \ref{8JVF}.',
    revision = 7,
    updated_at = '2026-11-27 16:00:00',
    intro_html_cache = NULL
WHERE id = 113;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '113', 7, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JV7", "parent_id": 105, "kind": "section", "title": "Prime classes and weighted counts", "intro_tex": "The weighted prime-power count in \\ref{8JU9} assigns classes to prime powers and attaches weights to those classes. Three definitions supply the groups, the labels, and the local character values.\n\nThe \\hyperref[8JVC]{residue groups for the averages} give the two averages of \\ref{8JV6} their inputs. The modulus $N_1$ lets $A$ record both the residue modulo $2^{e+2}$ up to sign and the value of $\\psi$. The groups of residues up to sign form the real cyclotomic tower, so increasing $e$ gives room to choose the shift set $T$ for the coset average in \\ref{8JVA}. Requiring $\\psi_{N_1}(v)=1$ in $U_1$ makes the induced character $\\psi_A$ on $A$ independent of the representative of a class. The uniform average in \\ref{8JV9} uses $A_0=\\ker\\psi_A$. Since the image of $\\psi_A$ has order $o$, the cosets indexed by $A/A_0$ are the $o$ character-value classes for the second average.\n\nThe \\hyperref[8JVP]{quadratic coordinates} enlarge $A$ to $B$. The map $\\pi$ sends a unit modulo $N=N_1qd$ to its two quadratic bits followed by its class in $A$. The Chinese remainder theorem lets the bits vary independently of the class in $A$. The bit at $d$ distinguishes the half with $\\xi_c=-1$, which gives the extra divisibility in the arithmetic argument. The complementary half $\\Phi$ labels the weights. The bit at $q$ distinguishes the positions with weights near the reference value in \\ref{8JVK}. For any shift $t\\in A$, the map $p_t$ of \\ref{8JU9} adds $(1,1,t)$. This translation flips the first quadratic bit and gives a bijection from $B\\smallsetminus\\Phi$ to $\\Phi$. Among the characters that survive the subgroup average, those using either quadratic bit are the auxiliary twists. Their smoothed prime sums are small at the target cutoff $x$, as in \\ref{8JVH}.\n\nThe \\hyperref[8JVQ]{prime-power classes and primitive characters} give the inputs to the Fourier expansion in \\ref{8JVD}. Away from $N$, the class of $p^i$ is a single element, and only odd powers of a prime with $\\xi_c(\\vartheta_p)=-1$ enter the count. The \\hyperref[8JVM]{example modulo $840$} computes such a class. At $p\\mid N$, the prime power has no unit class modulo $N$. The coset $i\\vartheta_p+I_p$ uses its residue away from $p$ and shares its mass uniformly across the corresponding classes. The portion outside $\\Phi$ enters the count. For each $\\xi\\in\\widehat B$, the value $\\xi^*(p^i)$ gives the coset average in the Fourier expansion, including when $p\\mid N$.\n\nThe count in \\ref{8JU9} and the Fourier expansion in \\ref{8JVD} allow arbitrary positive weight functions (with $w_\\alpha\\le\\upsilon$ in the Fourier expansion), and \\ref{8JVK} specifies the admissible weight functions $w_{u,j}$ used in the normalized count of \\ref{8JVF}.", "position": 2}', 'codex', '2026-11-27 16:00:00');

UPDATE sections
SET intro_tex = 'We now specify the data needed to normalize the counting formula of \ref{8JU9}. In \ref{8JU7} we choose auxiliary primes that work on a full range of scales, and in \ref{C3T2} we construct the sets of shifts and columns used in the averaging. \ref{8JVK} defines the admissible scales $\upsilon_t$ and weight functions $w_{u,j}$ at a point $x$, and \ref{8JVE} collects the Fourier data.

Fix any point $x$ and any choice of data as in \ref{8JVE} there. For each $t\in T$, $1\le j\le m$, and $u\in A_0$, use \ref{8JU9} to compute the count $S(t,\upsilon_t,w_{u,j})$ and subtract its main term $\Re M(\upsilon_t,w_{u,j})$. Add these differences over all $t$ and $j$ to get $\Delta_u$. Then average $\Delta_u$ over $u$, giving each $u$ weight $1/|A_0|$.

A term of weight $w$ has cutoff $\upsilon_t/w$. This comes from writing $(\upsilon_t/p^i-w)_+=w((\upsilon_t/w)/p^i-1)_+$, so the summand vanishes for $p^i\ge \upsilon_t/w$. In the positions $\Phi_u$ of \ref{8JVK}, $w$ is close to $b=\exp(x^\varepsilon)$, where $\varepsilon>0$ is a small parameter. The number $\upsilon_t$ is close to $xb$. Thus $\upsilon_t/w$ is near $x$, and we call these the terms at scale $x$. The comparison in \ref{8JUD} replaces their weights by $b$ and uses $|\upsilon_t/b-x|\le1$ to return to cutoff $x$.

At every other position, $w\le2b''$ with $b''=xb/X''$ and $X''=\exp(x^{\varepsilon/3})$. Since $\upsilon_t\ge (x-1)b$ and $x\ge3$, the cutoff is at least $(x-1)X''/(2x)\ge X''/3$. These cutoffs are much larger than $x$ for large $x$. The decay estimate in \ref{8JVH}(i) bounds their contribution.

The two kinds of shifts have different jobs. Changing $u\in A_0$ moves the positions in $\Phi_u$ along $A_0$. The average over $u$ removes characters that are nontrivial on $A_0$, by \ref{8JV9}. The shift $t\in T$ permutes the weight labels as in \ref{8JU9}. The coset proportions of $T$ give the surviving characters the Chapter 1 weights by \ref{8JVA} with $k=3$. Each $t$ enters the sum once, so the final division accounts for the factor $h=|T|$.

Each $(t,j)$ has $h_2=|T_2|$ positions at scale $x$. After replacement each supplies weight $b$ and has Fourier coefficient $1/f$ at the trivial character, where $f=2n$ and $n=|A|$. There are $hm$ pairs $(t,j)$, and the average over $u$ preserves this coefficient. With $\delta_2=h_2/n$ and $Q=hmb$, the total weight at scale $x$ is
\[
hm\cdot\frac{bh_2}{f}
=(hmb)\frac{h_2}{2n}=\frac{Q\delta_2}{2}.
\]
This is the denominator in the \hyperref[8JVF]{definition of $D_\psi(x)$}. The next section derives the common factor for the surviving characters and then applies the coset weights. After division, the weighted sum $\mathcal G_\psi(x)$ has coefficient one, with the replacements and the coset discrepancy contributing the errors estimated there. \ref{8JVG} states the one-sided bound on $D_\psi(x)$.',
    revision = 6,
    updated_at = '2026-11-27 16:00:00',
    intro_html_cache = NULL
WHERE id = 114;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '114', 6, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JV8", "parent_id": 105, "kind": "section", "title": "The normalized count and its arithmetic bound", "intro_tex": "We now specify the data needed to normalize the counting formula of \\ref{8JU9}. In \\ref{8JU7} we choose auxiliary primes that work on a full range of scales, and in \\ref{C3T2} we construct the sets of shifts and columns used in the averaging. \\ref{8JVK} defines the admissible scales $\\upsilon_t$ and weight functions $w_{u,j}$ at a point $x$, and \\ref{8JVE} collects the Fourier data.\n\nFix any point $x$ and any choice of data as in \\ref{8JVE} there. For each $t\\in T$, $1\\le j\\le m$, and $u\\in A_0$, use \\ref{8JU9} to compute the count $S(t,\\upsilon_t,w_{u,j})$ and subtract its main term $\\Re M(\\upsilon_t,w_{u,j})$. Add these differences over all $t$ and $j$ to get $\\Delta_u$. Then average $\\Delta_u$ over $u$, giving each $u$ weight $1/|A_0|$.\n\nA term of weight $w$ has cutoff $\\upsilon_t/w$. This comes from writing $(\\upsilon_t/p^i-w)_+=w((\\upsilon_t/w)/p^i-1)_+$, so the summand vanishes for $p^i\\ge \\upsilon_t/w$. In the positions $\\Phi_u$ of \\ref{8JVK}, $w$ is close to $b=\\exp(x^\\varepsilon)$, where $\\varepsilon>0$ is a small parameter. The number $\\upsilon_t$ is close to $xb$. Thus $\\upsilon_t/w$ is near $x$, and we call these the terms at scale $x$. The comparison in \\ref{8JUD} replaces their weights by $b$ and uses $|\\upsilon_t/b-x|\\le1$ to return to cutoff $x$.\n\nAt every other position, $w\\le2b''$ with $b''=xb/X''$ and $X''=\\exp(x^{\\varepsilon/3})$. Since $\\upsilon_t\\ge (x-1)b$ and $x\\ge3$, the cutoff is at least $(x-1)X''/(2x)\\ge X''/3$. These cutoffs are much larger than $x$ for large $x$. The decay estimate in \\ref{8JVH}(i) bounds their contribution.\n\nThe two kinds of shifts have different jobs. Changing $u\\in A_0$ moves the positions in $\\Phi_u$ along $A_0$. The average over $u$ removes characters that are nontrivial on $A_0$, by \\ref{8JV9}. The shift $t\\in T$ permutes the weight labels as in \\ref{8JU9}. The coset proportions of $T$ give the surviving characters the Chapter 1 weights by \\ref{8JVA} with $k=3$. Each $t$ enters the sum once, so the final division accounts for the factor $h=|T|$.\n\nEach $(t,j)$ has $h_2=|T_2|$ positions at scale $x$. After replacement each supplies weight $b$ and has Fourier coefficient $1/f$ at the trivial character, where $f=2n$ and $n=|A|$. There are $hm$ pairs $(t,j)$, and the average over $u$ preserves this coefficient. With $\\delta_2=h_2/n$ and $Q=hmb$, the total weight at scale $x$ is\n\\[\nhm\\cdot\\frac{bh_2}{f}\n=(hmb)\\frac{h_2}{2n}=\\frac{Q\\delta_2}{2}.\n\\]\nThis is the denominator in the \\hyperref[8JVF]{definition of $D_\\psi(x)$}. The next section derives the common factor for the surviving characters and then applies the coset weights. After division, the weighted sum $\\mathcal G_\\psi(x)$ has coefficient one, with the replacements and the coset discrepancy contributing the errors estimated there. \\ref{8JVG} states the one-sided bound on $D_\\psi(x)$.", "position": 3}', 'codex', '2026-11-27 16:00:00');

UPDATE results
SET title = 'Simultaneous choice of auxiliary primes',
    statement_tex = 'Fix a primitive $\psi$ of conductor $N_0$, put $M=8N_0$, and let $0<\varepsilon<1/52$ and $J\ge2$. At a base $Y_{\rm base}\ge3$, put $z=Y_{\rm base}^{\varepsilon/5}$ and $z''=z(\ln Y_{\rm base})^2$. The prime conditions at this base and exponent consist of the following.

\begin{enumerate}
\item[(a)] The primes $q,d$ are distinct and prime to $M$, with $q\equiv3\bmod8$, $d\equiv7\bmod16$, $z/2<\ln q\le z$ and $z''/2<\ln d\le z''$. The prime $q$ and each odd prime $p\le z$ divide $d+1$.
\item[(b)] For every primitive $\nu$ of conductor dividing $M$ and every $(i,j)\in\{0,1\}^2\smallsetminus\{(0,0)\}$, put $\chi=\nu(\frac{\cdot}{q})^i(\frac{\cdot}{d})^j$, taking a factor of exponent zero to be the conductor-one character. This product is primitive and $L(s,\chi)$ has no zeros for
\[
\Re s>1-\frac1{400},\qquad |\Im s|\le M\exp(z+jz'').
\]
\item[(c)] For every such $\chi$ and every real $y\in[Y_{\rm base},Y_{\rm base}^{J}]$,
\[
 |G_\chi(y)|\le y^{1/2+\varepsilon}.
\]
\end{enumerate}

There is a threshold $Y_{\rm prime}=Y_{\rm prime}(\psi,\varepsilon,J)\ge3$ such that every real $Y_{\rm base}\ge Y_{\rm prime}$ admits one pair meeting all these conditions. Condition (c) is the prime-sum part of Estimate B.',
    statement_html_cache = NULL,
    position = 2,
    revision = 8,
    updated_at = '2026-11-27 16:00:00',
    updated_by = 'codex'
WHERE id = 126;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '126', 8, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JU7", "type": "lemma", "title": "Simultaneous choice of auxiliary primes", "statement_tex": "Fix a primitive $\\psi$ of conductor $N_0$, put $M=8N_0$, and let $0<\\varepsilon<1/52$ and $J\\ge2$. At a base $Y_{\\rm base}\\ge3$, put $z=Y_{\\rm base}^{\\varepsilon/5}$ and $z''=z(\\ln Y_{\\rm base})^2$. The prime conditions at this base and exponent consist of the following.\n\n\\begin{enumerate}\n\\item[(a)] The primes $q,d$ are distinct and prime to $M$, with $q\\equiv3\\bmod8$, $d\\equiv7\\bmod16$, $z/2<\\ln q\\le z$ and $z''/2<\\ln d\\le z''$. The prime $q$ and each odd prime $p\\le z$ divide $d+1$.\n\\item[(b)] For every primitive $\\nu$ of conductor dividing $M$ and every $(i,j)\\in\\{0,1\\}^2\\smallsetminus\\{(0,0)\\}$, put $\\chi=\\nu(\\frac{\\cdot}{q})^i(\\frac{\\cdot}{d})^j$, taking a factor of exponent zero to be the conductor-one character. This product is primitive and $L(s,\\chi)$ has no zeros for\n\\[\n\\Re s>1-\\frac1{400},\\qquad |\\Im s|\\le M\\exp(z+jz'').\n\\]\n\\item[(c)] For every such $\\chi$ and every real $y\\in[Y_{\\rm base},Y_{\\rm base}^{J}]$,\n\\[\n |G_\\chi(y)|\\le y^{1/2+\\varepsilon}.\n\\]\n\\end{enumerate}\n\nThere is a threshold $Y_{\\rm prime}=Y_{\\rm prime}(\\psi,\\varepsilon,J)\\ge3$ such that every real $Y_{\\rm base}\\ge Y_{\\rm prime}$ admits one pair meeting all these conditions. Condition (c) is the prime-sum part of Estimate B.", "section_id": 114, "position": 2, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

UPDATE results
SET statement_tex = 'Let $E$ be an auxiliary field, $S_\ell$ its set of places above the prime $\ell$, and $G_{E,S_\ell}$ the Galois group of the maximal extension of $E$ unramified at finite places outside $S_\ell$. For a positive integer $r$ set
$$
S_{\ell,r}(E)=\ker\left(
 H^1(G_{E,S_\ell},\Q_\ell/\Z_\ell(-r))
 \longrightarrow \prod_{v\mid\ell}H^1(E_v,\Q_\ell/\Z_\ell(-r))
\right).
$$
For the admissible data at $x$ in \ref{C4S2}, let $s=\lfloor x^{400}\rfloor$ and $b=\exp(x^\varepsilon)$. For every finite set $S$ of primes the groups in the sum are finite and satisfy
$$
\sum_{\ell\in S}(\ln\ell)\sum_{1\le r<s}
 \operatorname{length}_{\Z_\ell} S_{\ell,r}(E)\le\sqrt b.
$$',
    statement_html_cache = NULL,
    position = 3,
    revision = 5,
    updated_at = '2026-11-27 16:00:00'
WHERE id = 127;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '127', 5, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JU8", "type": "lemma", "title": "The cohomological length bound", "statement_tex": "Let $E$ be an auxiliary field, $S_\\ell$ its set of places above the prime $\\ell$, and $G_{E,S_\\ell}$ the Galois group of the maximal extension of $E$ unramified at finite places outside $S_\\ell$. For a positive integer $r$ set\n$$\nS_{\\ell,r}(E)=\\ker\\left(\n H^1(G_{E,S_\\ell},\\Q_\\ell/\\Z_\\ell(-r))\n \\longrightarrow \\prod_{v\\mid\\ell}H^1(E_v,\\Q_\\ell/\\Z_\\ell(-r))\n\\right).\n$$\nFor the admissible data at $x$ in \\ref{C4S2}, let $s=\\lfloor x^{400}\\rfloor$ and $b=\\exp(x^\\varepsilon)$. For every finite set $S$ of primes the groups in the sum are finite and satisfy\n$$\n\\sum_{\\ell\\in S}(\\ln\\ell)\\sum_{1\\le r<s}\n \\operatorname{length}_{\\Z_\\ell} S_{\\ell,r}(E)\\le\\sqrt b.\n$$", "section_id": 106, "position": 3, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 0}', 'codex', '2026-11-27 16:00:00');

UPDATE results
SET statement_tex = 'Fix $\psi$ and $0<\varepsilon<\varepsilon_0(\psi)$ from \ref{C4S2}. There is a threshold $x_{\rm div}=x_{\rm div}(\psi,\varepsilon)\ge x_{\rm wt}(\varepsilon)$ from which the following holds for the chains of \ref{C4S2} with scales and weights from \ref{C4W2}. Use their \hyperref[8JVE]{Fourier data} and \hyperref[8JVF]{centered sums} $\Delta_u$. Let $a_E$ be the common size parameter in the estimates at each step and let $k$ be the parameter controlling the rank error. Set
\[
\mathcal B=h a_E\left(1+\frac{m^2}{k}\right)
 +m\left(2nmbx^\varepsilon
      +\frac{h_2kb x^{2\varepsilon}}{n^2}\right).
\]
For the \hyperref[8JV2]{error exponents} $e_D,e_L$, there is a common $E_{\rm err}\ge0$ such that for every $u\in A_0$,
\[
\Delta_u\le E_{\rm err}
\le x^{(e_D+e_L+3)\varepsilon}\mathcal B.
\]',
    statement_html_cache = NULL,
    position = 2,
    revision = 4,
    updated_at = '2026-11-27 16:00:00'
WHERE id = 129;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '129', 4, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JUA", "type": "proposition", "title": "A bound for each translate", "statement_tex": "Fix $\\psi$ and $0<\\varepsilon<\\varepsilon_0(\\psi)$ from \\ref{C4S2}. There is a threshold $x_{\\rm div}=x_{\\rm div}(\\psi,\\varepsilon)\\ge x_{\\rm wt}(\\varepsilon)$ from which the following holds for the chains of \\ref{C4S2} with scales and weights from \\ref{C4W2}. Use their \\hyperref[8JVE]{Fourier data} and \\hyperref[8JVF]{centered sums} $\\Delta_u$. Let $a_E$ be the common size parameter in the estimates at each step and let $k$ be the parameter controlling the rank error. Set\n\\[\n\\mathcal B=h a_E\\left(1+\\frac{m^2}{k}\\right)\n +m\\left(2nmbx^\\varepsilon\n      +\\frac{h_2kb x^{2\\varepsilon}}{n^2}\\right).\n\\]\nFor the \\hyperref[8JV2]{error exponents} $e_D,e_L$, there is a common $E_{\\rm err}\\ge0$ such that for every $u\\in A_0$,\n\\[\n\\Delta_u\\le E_{\\rm err}\n\\le x^{(e_D+e_L+3)\\varepsilon}\\mathcal B.\n\\]", "section_id": 107, "position": 2, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

UPDATE results
SET statement_html_cache = NULL,
    position = 3,
    revision = 4,
    updated_at = '2026-11-27 16:00:00'
WHERE id = 130;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '130', 4, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JUB", "type": "lemma", "title": "Rank from the period matrices", "statement_tex": "Let $B_i$ be the matrices for the period maps into a common $D$-dimensional Hermitian space. For any positive real normalizing weights $\\gamma_i$ indexed by these matrices, put\n\\begin{align*}\nK_{ij}&=\\sqrt{\\gamma_i\\gamma_j}\\,B_i^*B_j,\\\\\nP&=\\sum_i\\gamma_i B_iB_i^*.\n\\end{align*}\nIf $P\\ne 0$ and $\\operatorname{tr}(P^2)\\le(1+\\eta)(\\operatorname{tr}P)^2/D$, then $\\operatorname{rank}P\\ge D/(1+\\eta)$.", "section_id": 107, "position": 3, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 0}', 'codex', '2026-11-27 16:00:00');

UPDATE results
SET statement_tex = 'Use $\Phi,f$ and $\xi_c$ from \ref{8JVP} and the primitive representative $\xi_c^*$ from \ref{8JVQ}. In the normalization of \cite[Section 8]{Outline}, let $v_0$ be the geometric normalization parameter. For the scales $\upsilon_t$ in \ref{C4W2}, put
\begin{align*}
A_*&=\sum_{t\in T}\upsilon_t,\\
\ell&=\Re\left(\frac{L''(1,\xi_c^*)}{L(1,\xi_c^*)}\right).
\end{align*}
The divisibility main term is
\[
D_{\rm div}=m\sum_t \upsilon_t\bigl(\ln \upsilon_t-1-\gamma-\ln(\pi/v_0)+\ell\bigr).
\]
At each level $1\le j\le m$, write $w_j\colon\Phi\to(0,\infty)$ for its weight function and $w_{j,\alpha}=w_j(\alpha)$ for $\alpha\in\Phi$. The chain uses $w_j=w_{u,j}$ from \ref{C4W2} for a fixed $u\in A_0$. Let $g_0$ be the common logarithmic index term and $E_{\rm count}$ the error in the counting lower bound. With
\[
\lambda=\sum_j\frac1f\sum_{\alpha\in\Phi}\ln(w_{j,\alpha}v_0/\pi)
      +mg_0-E_{\rm count},
\]
one has
\[
D_{\rm div}-A_*\lambda+mA_*g_0
=\sum_{t,j}\Re M(\upsilon_t,w_j)+A_*E_{\rm count},
\]
where $M$ is as in \ref{8JU9}.',
    statement_html_cache = NULL,
    position = 4,
    revision = 8,
    updated_at = '2026-11-27 16:00:00'
WHERE id = 131;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '131', 8, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JUC", "type": "lemma", "title": "Matching the main terms", "statement_tex": "Use $\\Phi,f$ and $\\xi_c$ from \\ref{8JVP} and the primitive representative $\\xi_c^*$ from \\ref{8JVQ}. In the normalization of \\cite[Section 8]{Outline}, let $v_0$ be the geometric normalization parameter. For the scales $\\upsilon_t$ in \\ref{C4W2}, put\n\\begin{align*}\nA_*&=\\sum_{t\\in T}\\upsilon_t,\\\\\n\\ell&=\\Re\\left(\\frac{L''(1,\\xi_c^*)}{L(1,\\xi_c^*)}\\right).\n\\end{align*}\nThe divisibility main term is\n\\[\nD_{\\rm div}=m\\sum_t \\upsilon_t\\bigl(\\ln \\upsilon_t-1-\\gamma-\\ln(\\pi/v_0)+\\ell\\bigr).\n\\]\nAt each level $1\\le j\\le m$, write $w_j\\colon\\Phi\\to(0,\\infty)$ for its weight function and $w_{j,\\alpha}=w_j(\\alpha)$ for $\\alpha\\in\\Phi$. The chain uses $w_j=w_{u,j}$ from \\ref{C4W2} for a fixed $u\\in A_0$. Let $g_0$ be the common logarithmic index term and $E_{\\rm count}$ the error in the counting lower bound. With\n\\[\n\\lambda=\\sum_j\\frac1f\\sum_{\\alpha\\in\\Phi}\\ln(w_{j,\\alpha}v_0/\\pi)\n      +mg_0-E_{\\rm count},\n\\]\none has\n\\[\nD_{\\rm div}-A_*\\lambda+mA_*g_0\n=\\sum_{t,j}\\Re M(\\upsilon_t,w_j)+A_*E_{\\rm count},\n\\]\nwhere $M$ is as in \\ref{8JU9}.", "section_id": 107, "position": 4, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 0}', 'codex', '2026-11-27 16:00:00');

UPDATE results
SET statement_tex = 'Fix a primitive $\psi$ of order $o$ and $0<\varepsilon<1/52$. There is a threshold $x_{\rm cmp}=x_{\rm cmp}(\psi,\varepsilon)\ge x_{\rm aux}(\psi,\varepsilon)$, with $x_{\rm aux}$ from \ref{8JVH}. At every $x\ge x_{\rm cmp}$ take any Fourier data of \ref{8JVE} whose primes satisfy the hypotheses of \ref{8JVH}. Then
\[
\mathcal G_\psi(x)
\le D_\psi(x)+\frac{4}{x\delta_2}
        +(3o+4)x^{1/2+\varepsilon},
\]
where $D_\psi$ is defined in \ref{8JVF}.',
    statement_html_cache = NULL,
    revision = 5,
    updated_at = '2026-11-27 16:00:00'
WHERE id = 132;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '132', 5, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JUD", "type": "lemma", "title": "The Fourier comparison", "statement_tex": "Fix a primitive $\\psi$ of order $o$ and $0<\\varepsilon<1/52$. There is a threshold $x_{\\rm cmp}=x_{\\rm cmp}(\\psi,\\varepsilon)\\ge x_{\\rm aux}(\\psi,\\varepsilon)$, with $x_{\\rm aux}$ from \\ref{8JVH}. At every $x\\ge x_{\\rm cmp}$ take any Fourier data of \\ref{8JVE} whose primes satisfy the hypotheses of \\ref{8JVH}. Then\n\\[\n\\mathcal G_\\psi(x)\n\\le D_\\psi(x)+\\frac{4}{x\\delta_2}\n        +(3o+4)x^{1/2+\\varepsilon},\n\\]\nwhere $D_\\psi$ is defined in \\ref{8JVF}.", "section_id": 108, "position": 4, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

UPDATE results
SET statement_tex = 'Let $\psi$ be primitive and $0<\varepsilon<\varepsilon_0(\psi)$ from \ref{C4S2}. Put
\[
x_{\rm arith}(\psi,\varepsilon)=
\max\bigl(x_{\rm chain}(\psi,\varepsilon),x_{\rm wt}(\varepsilon),
          x_{\rm div}(\psi,\varepsilon)\bigr),
\]
with the thresholds from \ref{C4S2}, \ref{C4W2}, and \ref{8JUA}. For every $Y_0\ge3$, there is a window $[Y,Y^{3/2}]$ with $Y\ge\max(Y_0,x_{\rm arith})$. At every real $x$ in the window there are admissible arithmetic data of \ref{C4S2}, with primes satisfying \ref{8JU7} and admissible scales and weights from \ref{C4W2}. For the corresponding Fourier data of \ref{8JVE},
\[
D_\psi(x)\le20x^{1/2+61\varepsilon/8}.
\]',
    statement_html_cache = NULL,
    revision = 5,
    updated_at = '2026-11-27 16:00:00'
WHERE id = 134;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '134', 5, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JUF", "type": "proposition", "title": "The arithmetic bound from the four errors", "statement_tex": "Let $\\psi$ be primitive and $0<\\varepsilon<\\varepsilon_0(\\psi)$ from \\ref{C4S2}. Put\n\\[\nx_{\\rm arith}(\\psi,\\varepsilon)=\n\\max\\bigl(x_{\\rm chain}(\\psi,\\varepsilon),x_{\\rm wt}(\\varepsilon),\n          x_{\\rm div}(\\psi,\\varepsilon)\\bigr),\n\\]\nwith the thresholds from \\ref{C4S2}, \\ref{C4W2}, and \\ref{8JUA}. For every $Y_0\\ge3$, there is a window $[Y,Y^{3/2}]$ with $Y\\ge\\max(Y_0,x_{\\rm arith})$. At every real $x$ in the window there are admissible arithmetic data of \\ref{C4S2}, with primes satisfying \\ref{8JU7} and admissible scales and weights from \\ref{C4W2}. For the corresponding Fourier data of \\ref{8JVE},\n\\[\nD_\\psi(x)\\le20x^{1/2+61\\varepsilon/8}.\n\\]", "section_id": 109, "position": 1, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

UPDATE results
SET statement_tex = 'For the chain parameters of \ref{8JUA} at $x\ge x_{\rm div}(\psi,\varepsilon)$, with $Q,\delta_2$ as in \ref{8JVE}, one has
\begin{align*}
0\le a_E&\le 2xb, & h&\ge\tfrac12 n x^{-\varepsilon/8},\\
x^{1/2-\varepsilon}\le m&\le x^{1/2+\varepsilon/2},&
xm&\le k\le n^2x^{1/2-\varepsilon},\\
x^{-\varepsilon}\le\delta_2&\le1.
\end{align*}
In particular $\mathcal B/Q\le 10x^{1/2+13\varepsilon/8}$.',
    statement_html_cache = NULL,
    revision = 3,
    updated_at = '2026-11-27 16:00:00'
WHERE id = 135;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '135', 3, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JUG", "type": "lemma", "title": "Sizes of the four normalized errors", "statement_tex": "For the chain parameters of \\ref{8JUA} at $x\\ge x_{\\rm div}(\\psi,\\varepsilon)$, with $Q,\\delta_2$ as in \\ref{8JVE}, one has\n\\begin{align*}\n0\\le a_E&\\le 2xb, & h&\\ge\\tfrac12 n x^{-\\varepsilon/8},\\\\\nx^{1/2-\\varepsilon}\\le m&\\le x^{1/2+\\varepsilon/2},&\nxm&\\le k\\le n^2x^{1/2-\\varepsilon},\\\\\nx^{-\\varepsilon}\\le\\delta_2&\\le1.\n\\end{align*}\nIn particular $\\mathcal B/Q\\le 10x^{1/2+13\\varepsilon/8}$.", "section_id": 109, "position": 2, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 0}', 'codex', '2026-11-27 16:00:00');

UPDATE results
SET statement_tex = 'Use the data of \ref{8JVE} and the character notation of \ref{8JVQ}. Identify $A$ with its image under the embedding $A\to B$ of \ref{8JVP}. With $\mathcal C_\psi$ the \hyperref[8JG8]{cyclic family}, put
\[
\begin{aligned}
\mathcal H &= \left\{\xi\in\widehat B \;\middle|\; \xi|_{A_0}=1\right\},\\
\mathcal K &= \left\{\xi\in\mathcal H \;\middle|\; \xi^*\in\mathcal C_\psi\right\}.
\end{aligned}
\]
For these data at $x$, define the nonnegative real sum
\[
\Sigma(x)=\sum_{\xi\in\mathcal H\smallsetminus\mathcal K}
                 |G_{\xi^*}(x)|.
\]',
    statement_html_cache = NULL,
    revision = 6,
    updated_at = '2026-11-27 16:00:00'
WHERE id = 153;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '153', 6, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JUW", "type": "definition", "title": "The auxiliary-character sum $\\Sigma(x)$", "statement_tex": "Use the data of \\ref{8JVE} and the character notation of \\ref{8JVQ}. Identify $A$ with its image under the embedding $A\\to B$ of \\ref{8JVP}. With $\\mathcal C_\\psi$ the \\hyperref[8JG8]{cyclic family}, put\n\\[\n\\begin{aligned}\n\\mathcal H &= \\left\\{\\xi\\in\\widehat B \\;\\middle|\\; \\xi|_{A_0}=1\\right\\},\\\\\n\\mathcal K &= \\left\\{\\xi\\in\\mathcal H \\;\\middle|\\; \\xi^*\\in\\mathcal C_\\psi\\right\\}.\n\\end{aligned}\n\\]\nFor these data at $x$, define the nonnegative real sum\n\\[\n\\Sigma(x)=\\sum_{\\xi\\in\\mathcal H\\smallsetminus\\mathcal K}\n                 |G_{\\xi^*}(x)|.\n\\]", "section_id": 108, "position": 3, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

UPDATE results
SET statement_tex = 'For a chain of $m$ theta lifts at scale $x$ with parameter $\varepsilon>0$ and translates $t\in T$, write $h=|T|$, $n=|A|$, and $b=\exp(x^\varepsilon)$ as in \ref{8JVE}. The number of large weights per level is $h_2=|T_2|$ in that notation. Write $k$ for the rank-error parameter of the chain. Put
$$
B_0=2nmbx^\varepsilon,\qquad N_c=\frac{h_2 k b x^{2\varepsilon}}{n^2}.
$$
For $u_0\in A_0$, let $S$ be the sum of the \hyperref[8JU9]{weighted prime-power counts} over $t\in T$ and the $m$ levels, with the admissible weight functions $w_{u_0,j}$ from \ref{C4W2}. Let $\Gamma$ be the total divisibility gain of the lifts at the inert primes and $I$ the index loss there.

The nonnegative numbers $e_D,e_L$ are error exponents if there is a constant $C>0$, independent of $x$, such that for the theta-lift chains at all scales $x$ of the construction and for every $u_0\in A_0$,
$$
S-\Gamma\leqslant C\,hmb\,x^{e_L\varepsilon},
\qquad 0\leqslant I\leqslant C\,hmb\,x^{e_L\varepsilon},
$$
and, for every auxiliary prime $T_u$ of the chain,
$$
\mu(R)+h_u-L\leqslant D_u+C\,h\,\upsilon\Lambda_{\upsilon}+C\,m(B_0+N_c)\,x^{e_D\varepsilon}.
$$
Here $\mu(R)$ is the slope of the lattice $R$ of automorphic forms at the top of the chain, $h_u$ bounds the height of the period map at $T_u$, $L$ is the sum of the local terms of the lifts, $D_u$ is the divisibility main term at $T_u$, $\upsilon=xb$, and $\Lambda_{\upsilon}=\ln(\upsilon\,\mathrm{rd}_E)$ with $\mathrm{rd}_E$ the root discriminant of the auxiliary field $E$.
See \cite[Definition 18.9]{Adriazola}.',
    statement_html_cache = NULL,
    position = 2,
    revision = 4,
    updated_at = '2026-11-27 16:00:00'
WHERE id = 154;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '154', 4, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JV2", "type": "definition", "title": "The error exponents $e_D$ and $e_L$", "statement_tex": "For a chain of $m$ theta lifts at scale $x$ with parameter $\\varepsilon>0$ and translates $t\\in T$, write $h=|T|$, $n=|A|$, and $b=\\exp(x^\\varepsilon)$ as in \\ref{8JVE}. The number of large weights per level is $h_2=|T_2|$ in that notation. Write $k$ for the rank-error parameter of the chain. Put\n$$\nB_0=2nmbx^\\varepsilon,\\qquad N_c=\\frac{h_2 k b x^{2\\varepsilon}}{n^2}.\n$$\nFor $u_0\\in A_0$, let $S$ be the sum of the \\hyperref[8JU9]{weighted prime-power counts} over $t\\in T$ and the $m$ levels, with the admissible weight functions $w_{u_0,j}$ from \\ref{C4W2}. Let $\\Gamma$ be the total divisibility gain of the lifts at the inert primes and $I$ the index loss there.\n\nThe nonnegative numbers $e_D,e_L$ are error exponents if there is a constant $C>0$, independent of $x$, such that for the theta-lift chains at all scales $x$ of the construction and for every $u_0\\in A_0$,\n$$\nS-\\Gamma\\leqslant C\\,hmb\\,x^{e_L\\varepsilon},\n\\qquad 0\\leqslant I\\leqslant C\\,hmb\\,x^{e_L\\varepsilon},\n$$\nand, for every auxiliary prime $T_u$ of the chain,\n$$\n\\mu(R)+h_u-L\\leqslant D_u+C\\,h\\,\\upsilon\\Lambda_{\\upsilon}+C\\,m(B_0+N_c)\\,x^{e_D\\varepsilon}.\n$$\nHere $\\mu(R)$ is the slope of the lattice $R$ of automorphic forms at the top of the chain, $h_u$ bounds the height of the period map at $T_u$, $L$ is the sum of the local terms of the lifts, $D_u$ is the divisibility main term at $T_u$, $\\upsilon=xb$, and $\\Lambda_{\\upsilon}=\\ln(\\upsilon\\,\\mathrm{rd}_E)$ with $\\mathrm{rd}_E$ the root discriminant of the auxiliary field $E$.\nSee \\cite[Definition 18.9]{Adriazola}.", "section_id": 106, "position": 2, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

UPDATE results
SET statement_tex = 'Fix a primitive $\psi$ of order $o$, a real $0<\varepsilon<1/52$, and a point $x\ge3$. Use the residue groups and primes of \ref{8JVC} and the quadratic coordinates of \ref{8JVP}, with $n=|A|\le2x^{9/4}$. Choose a nonempty $T\subseteq A$ with proportions $\mu_C,\lambda_C$ as in \ref{8JVA} at $k=3$ satisfying
\[
|\mu_C-\lambda_C|\le x^{-1+\varepsilon}\qquad(C\in A/A_0).
\]
Choose admissible scales and weights at $x$ as in \ref{8JVK}. We use the notation
\begin{align*}
h&=|T|,\qquad h_2=|T_2|,\\
\delta_2&=h_2/n,\qquad Q=hmb .
\end{align*}
In particular $x^{-\varepsilon}\le\delta_2\le1$. When applying the analytic estimates, the primes must also satisfy \ref{8JU7} at a base and exponent with $Y_{\rm base}\le x\le Y_{\rm base}^J$.',
    statement_html_cache = NULL,
    position = 5,
    revision = 6,
    updated_at = '2026-11-27 16:00:00'
WHERE id = 162;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '162', 6, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JVE", "type": "definition", "title": "Data for the Fourier step", "statement_tex": "Fix a primitive $\\psi$ of order $o$, a real $0<\\varepsilon<1/52$, and a point $x\\ge3$. Use the residue groups and primes of \\ref{8JVC} and the quadratic coordinates of \\ref{8JVP}, with $n=|A|\\le2x^{9/4}$. Choose a nonempty $T\\subseteq A$ with proportions $\\mu_C,\\lambda_C$ as in \\ref{8JVA} at $k=3$ satisfying\n\\[\n|\\mu_C-\\lambda_C|\\le x^{-1+\\varepsilon}\\qquad(C\\in A/A_0).\n\\]\nChoose admissible scales and weights at $x$ as in \\ref{8JVK}. We use the notation\n\\begin{align*}\nh&=|T|,\\qquad h_2=|T_2|,\\\\\n\\delta_2&=h_2/n,\\qquad Q=hmb .\n\\end{align*}\nIn particular $x^{-\\varepsilon}\\le\\delta_2\\le1$. When applying the analytic estimates, the primes must also satisfy \\ref{8JU7} at a base and exponent with $Y_{\\rm base}\\le x\\le Y_{\\rm base}^J$.", "section_id": 114, "position": 5, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

UPDATE results
SET statement_tex = 'Fix data as in \ref{8JVE} at $x$, including the admissible scales and weights from \ref{8JVK}. Use $S$ and $M$ from \ref{8JU9}. The centered sum $\Delta\colon A_0\to\R$ and the real normalized value $D_\psi(x)$ for those data are
\begin{align*}
\Delta_u
 &=\sum_{t\in T}\sum_{j=1}^{m}
 \bigl(S(t,\upsilon_t,w_{u,j})-\Re M(\upsilon_t,w_{u,j})\bigr)
 &&(u\in A_0),\\
D_\psi(x)
 &=\frac{2}{Q\delta_2}\cdot\frac1{|A_0|}
       \sum_{u\in A_0}\Delta_u .
\end{align*}',
    statement_html_cache = NULL,
    position = 6,
    revision = 4,
    updated_at = '2026-11-27 16:00:00'
WHERE id = 163;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '163', 4, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JVF", "type": "definition", "title": "The normalized centered count $D_\\psi(x)$", "statement_tex": "Fix data as in \\ref{8JVE} at $x$, including the admissible scales and weights from \\ref{8JVK}. Use $S$ and $M$ from \\ref{8JU9}. The centered sum $\\Delta\\colon A_0\\to\\R$ and the real normalized value $D_\\psi(x)$ for those data are\n\\begin{align*}\n\\Delta_u\n &=\\sum_{t\\in T}\\sum_{j=1}^{m}\n \\bigl(S(t,\\upsilon_t,w_{u,j})-\\Re M(\\upsilon_t,w_{u,j})\\bigr)\n &&(u\\in A_0),\\\\\nD_\\psi(x)\n &=\\frac{2}{Q\\delta_2}\\cdot\\frac1{|A_0|}\n       \\sum_{u\\in A_0}\\Delta_u .\n\\end{align*}", "section_id": 114, "position": 6, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

UPDATE results
SET statement_tex = 'For each primitive $\psi$ there is $0<\varepsilon_0=\varepsilon_0(\psi)\le1/52$. For every $\eta>0$, every $0<\varepsilon<\varepsilon_0$ with $61\varepsilon/8\le\eta$, and every $Y_0\ge3$, there is a window $[Y,Y^{3/2}]$ with $Y\ge\max(Y_0,x_{\rm aux}(\psi,\varepsilon))$ for $x_{\rm aux}$ from \ref{8JVH}. At every real $x$ in this window there are $Y_{\rm base},J$ with $Y_{\rm base}\le x\le Y_{\rm base}^J$ and primes $q,d$ satisfying \ref{8JU7} at that base and exponent. There are Fourier data as in \ref{8JVE} using these primes, in particular admissible scales and weights as in \ref{8JVK}, for which
\[
D_\psi(x)\le20x^{1/2+\eta}.
\]
The primes and the other data may depend on $x$. The bound is for the value of $D_\psi(x)$ from \ref{8JVF} built with those same data.',
    statement_html_cache = NULL,
    position = 7,
    revision = 4,
    updated_at = '2026-11-27 16:00:00',
    updated_by = 'codex'
WHERE id = 164;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '164', 4, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JVG", "type": "theorem", "title": "Arithmetic bound", "statement_tex": "For each primitive $\\psi$ there is $0<\\varepsilon_0=\\varepsilon_0(\\psi)\\le1/52$. For every $\\eta>0$, every $0<\\varepsilon<\\varepsilon_0$ with $61\\varepsilon/8\\le\\eta$, and every $Y_0\\ge3$, there is a window $[Y,Y^{3/2}]$ with $Y\\ge\\max(Y_0,x_{\\rm aux}(\\psi,\\varepsilon))$ for $x_{\\rm aux}$ from \\ref{8JVH}. At every real $x$ in this window there are $Y_{\\rm base},J$ with $Y_{\\rm base}\\le x\\le Y_{\\rm base}^J$ and primes $q,d$ satisfying \\ref{8JU7} at that base and exponent. There are Fourier data as in \\ref{8JVE} using these primes, in particular admissible scales and weights as in \\ref{8JVK}, for which\n\\[\nD_\\psi(x)\\le20x^{1/2+\\eta}.\n\\]\nThe primes and the other data may depend on $x$. The bound is for the value of $D_\\psi(x)$ from \\ref{8JVF} built with those same data.", "section_id": 114, "position": 7, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

UPDATE results
SET statement_tex = 'Fix a primitive $\psi$ and $0<\varepsilon<1/52$. There is $x_{\rm aux}=x_{\rm aux}(\psi,\varepsilon)\ge3$ with the following property. Take any $x\ge x_{\rm aux}$, groups as in \ref{8JVC} and \ref{8JVP} with $n=|A|\le2x^{9/4}$, and primes $q,d$ satisfying the conditions of \ref{8JU7} for some $Y_{\rm base},J$ with $Y_{\rm base}\le x\le Y_{\rm base}^J$. Use the primitive representatives $\xi^*$ of \ref{8JVQ}, the sums $G_{\xi^*}$ of \ref{8JF7}, and $X''=\exp(x^{\varepsilon/3})$. The threshold is independent of $J$ and of the base.

\begin{enumerate}
\item[(i)] For each $\xi\in\widehat B$ and each real $y\ge X''/3$,
\[
|G_{\xi^*}(y)|\le y\omega_x,\qquad
\omega_x=\exp(-x^{\varepsilon/8}),\qquad
2f(x+1)\omega_x\le 1/x.
\]
\item[(ii)] For every $\xi$ indexing the \hyperref[8JUW]{auxiliary-character sum},
\[
|G_{\xi^*}(x)|\le x^{1/2+\varepsilon},\qquad
\left|\frac{L''(1,\xi^*)}{L(1,\xi^*)}\right|
\le C_{\rm twist}(\psi,\varepsilon)\ln(x+1).
\]
Here $C_{\rm twist}(\psi,\varepsilon)>0$ is independent of the window and of $x$.
\end{enumerate}',
    statement_html_cache = NULL,
    revision = 4,
    updated_at = '2026-11-27 16:00:00'
WHERE id = 165;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '165', 4, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JVH", "type": "lemma", "title": "Analytic estimates for the auxiliary characters", "statement_tex": "Fix a primitive $\\psi$ and $0<\\varepsilon<1/52$. There is $x_{\\rm aux}=x_{\\rm aux}(\\psi,\\varepsilon)\\ge3$ with the following property. Take any $x\\ge x_{\\rm aux}$, groups as in \\ref{8JVC} and \\ref{8JVP} with $n=|A|\\le2x^{9/4}$, and primes $q,d$ satisfying the conditions of \\ref{8JU7} for some $Y_{\\rm base},J$ with $Y_{\\rm base}\\le x\\le Y_{\\rm base}^J$. Use the primitive representatives $\\xi^*$ of \\ref{8JVQ}, the sums $G_{\\xi^*}$ of \\ref{8JF7}, and $X''=\\exp(x^{\\varepsilon/3})$. The threshold is independent of $J$ and of the base.\n\n\\begin{enumerate}\n\\item[(i)] For each $\\xi\\in\\widehat B$ and each real $y\\ge X''/3$,\n\\[\n|G_{\\xi^*}(y)|\\le y\\omega_x,\\qquad\n\\omega_x=\\exp(-x^{\\varepsilon/8}),\\qquad\n2f(x+1)\\omega_x\\le 1/x.\n\\]\n\\item[(ii)] For every $\\xi$ indexing the \\hyperref[8JUW]{auxiliary-character sum},\n\\[\n|G_{\\xi^*}(x)|\\le x^{1/2+\\varepsilon},\\qquad\n\\left|\\frac{L''(1,\\xi^*)}{L(1,\\xi^*)}\\right|\n\\le C_{\\rm twist}(\\psi,\\varepsilon)\\ln(x+1).\n\\]\nHere $C_{\\rm twist}(\\psi,\\varepsilon)>0$ is independent of the window and of $x$.\n\\end{enumerate}", "section_id": 108, "position": 1, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

UPDATE results
SET type = 'definition',
    title = 'Admissible scales and weights',
    statement_tex = 'Fix real $x\ge3$ and $\varepsilon>0$, the groups of \ref{8JVC} and \ref{8JVP}, and a nonempty $T\subseteq A$. Put
\[
\begin{aligned}
b&=\exp(x^\varepsilon),\\
X''&=\exp(x^{\varepsilon/3}),\\
b''&=\frac{xb}{X''}.
\end{aligned}
\]
Admissible scales and weights at $x$ consist of an integer $m\ge1$, a subset $T_2\subseteq A_0$, a positive real $\upsilon_t$ for each $t\in T$, a real $\rho_w$ and functions $w_{u,j}\colon\Phi\to(0,\infty)$ for $u\in A_0$ and $1\le j\le m$. Require
\[
 X''\ge3,\qquad
 x^{-\varepsilon}\le\frac{|T_2|}{|A|}\le1,\qquad
 |\upsilon_t/b-x|\le1,\qquad
 0\le\rho_w\le b,\qquad 6f(x+1)\rho_w\le b/x.
\]
For $u\in A_0$, put
\[
 \Phi_u=\left\{(0,1,z+u)\in\Phi\;\middle|\;z\in T_2\right\}.
\]
The bounds for each weight function are
\[
\begin{aligned}
 b\le w_{u,j}(\alpha)\le b+\rho_w &\qquad(\alpha\in\Phi_u),\\
 0<w_{u,j}(\alpha)\le2b'' &\qquad(\alpha\in\Phi\smallsetminus\Phi_u).
\end{aligned}
\]',
    statement_html_cache = NULL,
    position = 4,
    revision = 5,
    updated_at = '2026-11-27 16:00:00'
WHERE id = 167;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '167', 5, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "8JVK", "type": "definition", "title": "Admissible scales and weights", "statement_tex": "Fix real $x\\ge3$ and $\\varepsilon>0$, the groups of \\ref{8JVC} and \\ref{8JVP}, and a nonempty $T\\subseteq A$. Put\n\\[\n\\begin{aligned}\nb&=\\exp(x^\\varepsilon),\\\\\nX''&=\\exp(x^{\\varepsilon/3}),\\\\\nb''&=\\frac{xb}{X''}.\n\\end{aligned}\n\\]\nAdmissible scales and weights at $x$ consist of an integer $m\\ge1$, a subset $T_2\\subseteq A_0$, a positive real $\\upsilon_t$ for each $t\\in T$, a real $\\rho_w$ and functions $w_{u,j}\\colon\\Phi\\to(0,\\infty)$ for $u\\in A_0$ and $1\\le j\\le m$. Require\n\\[\n X''\\ge3,\\qquad\n x^{-\\varepsilon}\\le\\frac{|T_2|}{|A|}\\le1,\\qquad\n |\\upsilon_t/b-x|\\le1,\\qquad\n 0\\le\\rho_w\\le b,\\qquad 6f(x+1)\\rho_w\\le b/x.\n\\]\nFor $u\\in A_0$, put\n\\[\n \\Phi_u=\\left\\{(0,1,z+u)\\in\\Phi\\;\\middle|\\;z\\in T_2\\right\\}.\n\\]\nThe bounds for each weight function are\n\\[\n\\begin{aligned}\n b\\le w_{u,j}(\\alpha)\\le b+\\rho_w &\\qquad(\\alpha\\in\\Phi_u),\\\\\n 0<w_{u,j}(\\alpha)\\le2b'' &\\qquad(\\alpha\\in\\Phi\\smallsetminus\\Phi_u).\n\\end{aligned}\n\\]", "section_id": 114, "position": 4, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

INSERT INTO results (id, tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, state, replaced_by_id, derived_from_proof_id, derived_from_proof_revision, revision, created_at, updated_at, created_by, updated_by, listed)
VALUES (184, 'C3R2', 'lemma', 'Shifting the smoothed prime sum', 'Let $\chi$ be primitive of conductor $D$, including $\mathbf1$ when $D=1$. Suppose $L(s,\chi)$ has no zeros for $\Re s>1-\lambda$, $|\Im s|\le H+2$, where $0<\lambda\le1/400$ and $H\ge2$. For every $y\ge1$ and $1<a\le2$, the sum of \ref{8JF7} satisfies
\[
|G_\chi(y)|\ll
\lambda^{-2}\ln(3D(H+4))
\left(y^{1-\lambda/2}\ln(3/\lambda)+\frac{y^a}{H}\right)
+\frac{y^a}{(a-1)H}.
\]
The implied constant is absolute.', NULL, 114, 1, 'published', 'active', NULL, NULL, NULL, 1, '2026-11-27 16:00:00', '2026-11-27 16:00:00', 'codex', 'codex', 0);

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '184', 1, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "C3R2", "type": "lemma", "title": "Shifting the smoothed prime sum", "statement_tex": "Let $\\chi$ be primitive of conductor $D$, including $\\mathbf1$ when $D=1$. Suppose $L(s,\\chi)$ has no zeros for $\\Re s>1-\\lambda$, $|\\Im s|\\le H+2$, where $0<\\lambda\\le1/400$ and $H\\ge2$. For every $y\\ge1$ and $1<a\\le2$, the sum of \\ref{8JF7} satisfies\n\\[\n|G_\\chi(y)|\\ll\n\\lambda^{-2}\\ln(3D(H+4))\n\\left(y^{1-\\lambda/2}\\ln(3/\\lambda)+\\frac{y^a}{H}\\right)\n+\\frac{y^a}{(a-1)H}.\n\\]\nThe implied constant is absolute.", "section_id": 114, "position": 1, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 0}', 'codex', '2026-11-27 16:00:00');

INSERT INTO results (id, tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, state, replaced_by_id, derived_from_proof_id, derived_from_proof_revision, revision, created_at, updated_at, created_by, updated_by, listed)
VALUES (185, 'C3T2', 'lemma', 'Choosing the sets of shifts and columns', 'Fix a primitive $\psi$ of order $o$, a real $0<\varepsilon<1/52$ and a constant $K\ge2$. There is a threshold $x_{\rm col}=x_{\rm col}(\psi,\varepsilon,K)\ge3$ with the following properties. For each real $x\ge x_{\rm col}$ one can choose $e$ in \ref{8JVC} so that $n=|A|$ satisfies $x^{2+8\varepsilon}\le n\le 2x^{2+8\varepsilon}$. For every such $e$, the following sets exist.

\begin{enumerate}
\item[(i)] A nonempty $T\subseteq A$ of size between $\tfrac12 n x^{-\varepsilon/8}$ and $n x^{-\varepsilon/8}$, with $\mu_C=\lambda_C$ for all cosets of $A_0$, using $k=3$ in \ref{8JVA}.
\item[(ii)] For every integer $2\le L\le K\ln x$, a subset $T_2\subseteq A_0$ of size at least $n x^{-\varepsilon}$. More precisely, $A_0$ is cyclic, and for a generator $a_0$ one can take $T_2=\left\{s a_0\;\middle|\;s\in S\right\}$, where $S$ consists of integers $0\le s<|A_0|/(4L)$. No distinct $s_1,s_2,s_3\in S$ satisfy $j(s_2-s_1)=i(s_3-s_1)$ modulo $|A_0|$ with $0<|i|,|j|\le L$. Consequently, among any $L$ consecutive terms of a progression with step of order greater than $4L$ in $A$, at most two belong to any given translate of $T_2$. An orbit of a step of order at most $4L$ meets each translate in at most one point.
\end{enumerate}
The Fourier comparison uses only the coset proportion bound $|\mu_C-\lambda_C|\le x^{-1+\varepsilon}$ and the size and containment of $T_2$.', NULL, 114, 3, 'published', 'active', NULL, NULL, NULL, 1, '2026-11-27 16:00:00', '2026-11-27 16:00:00', 'codex', 'codex', 1);

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '185', 1, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "C3T2", "type": "lemma", "title": "Choosing the sets of shifts and columns", "statement_tex": "Fix a primitive $\\psi$ of order $o$, a real $0<\\varepsilon<1/52$ and a constant $K\\ge2$. There is a threshold $x_{\\rm col}=x_{\\rm col}(\\psi,\\varepsilon,K)\\ge3$ with the following properties. For each real $x\\ge x_{\\rm col}$ one can choose $e$ in \\ref{8JVC} so that $n=|A|$ satisfies $x^{2+8\\varepsilon}\\le n\\le 2x^{2+8\\varepsilon}$. For every such $e$, the following sets exist.\n\n\\begin{enumerate}\n\\item[(i)] A nonempty $T\\subseteq A$ of size between $\\tfrac12 n x^{-\\varepsilon/8}$ and $n x^{-\\varepsilon/8}$, with $\\mu_C=\\lambda_C$ for all cosets of $A_0$, using $k=3$ in \\ref{8JVA}.\n\\item[(ii)] For every integer $2\\le L\\le K\\ln x$, a subset $T_2\\subseteq A_0$ of size at least $n x^{-\\varepsilon}$. More precisely, $A_0$ is cyclic, and for a generator $a_0$ one can take $T_2=\\left\\{s a_0\\;\\middle|\\;s\\in S\\right\\}$, where $S$ consists of integers $0\\le s<|A_0|/(4L)$. No distinct $s_1,s_2,s_3\\in S$ satisfy $j(s_2-s_1)=i(s_3-s_1)$ modulo $|A_0|$ with $0<|i|,|j|\\le L$. Consequently, among any $L$ consecutive terms of a progression with step of order greater than $4L$ in $A$, at most two belong to any given translate of $T_2$. An orbit of a step of order at most $4L$ meets each translate in at most one point.\n\\end{enumerate}\nThe Fourier comparison uses only the coset proportion bound $|\\mu_C-\\lambda_C|\\le x^{-1+\\varepsilon}$ and the size and containment of $T_2$.", "section_id": 114, "position": 3, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

INSERT INTO results (id, tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, state, replaced_by_id, derived_from_proof_id, derived_from_proof_revision, revision, created_at, updated_at, created_by, updated_by, listed)
VALUES (186, 'C4S2', 'proposition', 'Windows with admissible chains', 'Assume the field-existence and chain-record inputs of \cite[Hypotheses 17.11 and 18.10]{Adriazola}. For each primitive $\psi$, let $0<\varepsilon_0(\psi)\le1/52$ be the bound $\varepsilon_1$ of Hypothesis 18.10. Given $0<\varepsilon<\varepsilon_0(\psi)$, there are a fixed $J=J(\psi,\varepsilon)\ge2$ and a threshold $x_{\rm chain}=x_{\rm chain}(\psi,\varepsilon)\ge3$. For every $Y_0\ge3$, there is a window $[Y,Y^{3/2}]$ with $Y\ge\max(Y_0,x_{\rm chain})$ and a common base $3\le Y_{\rm base}\le Y$ with $Y^2\le Y_{\rm base}^J$. At each real $x$ in this window there are data as in \cite[Definitions 6.1 and 18.1]{Adriazola}, including primes meeting \ref{8JU7} at this base, a tower with $x^{2+8\varepsilon}\le n=|A|\le2x^{2+8\varepsilon}$, and the sets $T,T_2$ satisfying the coset and density conditions in \ref{8JVE}. They give the cohomological bound of \ref{8JU8} and admit chain records with the error exponents $e_D=2$, $e_L=0$ of \ref{8JV2}. The choice of admissible data with these records is made at each $x$.', NULL, 106, 1, 'published', 'active', NULL, NULL, NULL, 1, '2026-11-27 16:00:00', '2026-11-27 16:00:00', 'codex', 'codex', 1);

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '186', 1, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "C4S2", "type": "proposition", "title": "Windows with admissible chains", "statement_tex": "Assume the field-existence and chain-record inputs of \\cite[Hypotheses 17.11 and 18.10]{Adriazola}. For each primitive $\\psi$, let $0<\\varepsilon_0(\\psi)\\le1/52$ be the bound $\\varepsilon_1$ of Hypothesis 18.10. Given $0<\\varepsilon<\\varepsilon_0(\\psi)$, there are a fixed $J=J(\\psi,\\varepsilon)\\ge2$ and a threshold $x_{\\rm chain}=x_{\\rm chain}(\\psi,\\varepsilon)\\ge3$. For every $Y_0\\ge3$, there is a window $[Y,Y^{3/2}]$ with $Y\\ge\\max(Y_0,x_{\\rm chain})$ and a common base $3\\le Y_{\\rm base}\\le Y$ with $Y^2\\le Y_{\\rm base}^J$. At each real $x$ in this window there are data as in \\cite[Definitions 6.1 and 18.1]{Adriazola}, including primes meeting \\ref{8JU7} at this base, a tower with $x^{2+8\\varepsilon}\\le n=|A|\\le2x^{2+8\\varepsilon}$, and the sets $T,T_2$ satisfying the coset and density conditions in \\ref{8JVE}. They give the cohomological bound of \\ref{8JU8} and admit chain records with the error exponents $e_D=2$, $e_L=0$ of \\ref{8JV2}. The choice of admissible data with these records is made at each $x$.", "section_id": 106, "position": 1, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

INSERT INTO results (id, tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, state, replaced_by_id, derived_from_proof_id, derived_from_proof_revision, revision, created_at, updated_at, created_by, updated_by, listed)
VALUES (187, 'C4W2', 'lemma', 'Scales and weights from the theta lifts', 'For each $0<\varepsilon<1/52$ there is a uniform threshold $x_{\rm wt}=x_{\rm wt}(\varepsilon)\ge3$. For admissible arithmetic data as in \ref{C4S2} at a point $x\ge x_{\rm wt}$, the construction gives a chain of $m\ge1$ successive theta lifts between spaces of automorphic forms on definite unitary groups of increasing rank. Use the scales and weights of \ref{8JVK}. For each $u\in A_0$ and $1\le j\le m$, the weight at a label $\alpha\in\Phi$ is the archimedean parameter of the $j$th lift,
\[
 w_{u,j}(\alpha)=b_1(\alpha)+(j-\tfrac12)h_0,
 \qquad h_0=2\lceil x^{402}\rceil.
\]
Here $b_1(\alpha)$ depends on $u$ and on the admissible arithmetic choices. With $W$ the number of roots of unity in the auxiliary field, the construction meets \ref{8JVK} with $\rho_w=W+mh_0$.', NULL, 107, 1, 'published', 'active', NULL, NULL, NULL, 1, '2026-11-27 16:00:00', '2026-11-27 16:00:00', 'codex', 'codex', 1);

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '187', 1, '2503743b-4b31-43ea-90a5-e722b4987310', '{"tag": "C4W2", "type": "lemma", "title": "Scales and weights from the theta lifts", "statement_tex": "For each $0<\\varepsilon<1/52$ there is a uniform threshold $x_{\\rm wt}=x_{\\rm wt}(\\varepsilon)\\ge3$. For admissible arithmetic data as in \\ref{C4S2} at a point $x\\ge x_{\\rm wt}$, the construction gives a chain of $m\\ge1$ successive theta lifts between spaces of automorphic forms on definite unitary groups of increasing rank. Use the scales and weights of \\ref{8JVK}. For each $u\\in A_0$ and $1\\le j\\le m$, the weight at a label $\\alpha\\in\\Phi$ is the archimedean parameter of the $j$th lift,\n\\[\n w_{u,j}(\\alpha)=b_1(\\alpha)+(j-\\tfrac12)h_0,\n \\qquad h_0=2\\lceil x^{402}\\rceil.\n\\]\nHere $b_1(\\alpha)$ depends on $u$ and on the admissible arithmetic choices. With $W$ the number of roots of unity in the auxiliary field, the construction meets \\ref{8JVK} with $\\rho_w=W+mh_0$.", "section_id": 107, "position": 1, "visibility": "published", "state": "active", "replaced_by_id": null, "listed": 1}', 'codex', '2026-11-27 16:00:00');

UPDATE proofs
SET body_tex = 'Write $R=Y_{\rm base}$ and $Z=R^{10000J}$. All inequalities in this proof that require a lower bound on $R$ are imposed in $Y_{\rm prime}(\psi,\varepsilon,J)$. We first record the prime-distribution and zero-counting inputs.

\begin{itemize}
\item \cite[Theorem 1]{McCurley1984}, in the form recorded in \cite[Section 1.1]{ThornerZaman2024}, gives the following zero-free region. For any modulus $m\ge2$, the product of the Dirichlet $L$-functions modulo $m$ has no zero in $\Re s\ge1-c_1/\ln(m(|\Im s|+3))$, with $c_1=1/13$, apart from a possible simple real zero $\beta$ of a unique real nonprincipal character $\chi_1$ modulo $m$. This zero lies in $(0,1)$ by the Euler product and nonvanishing at $1$ in \ref{8JUV}, which also gives nonvanishing for imprimitive nonprincipal characters by their Euler factors. For such a zero one has $1-\beta\gg1/m$ by \cite[Proposition 1.11]{BennettEtAl2018}, which gives $1-\beta\ge40/(\sqrt m(\ln m)^2)$ for a real zero $\beta>0$ of a quadratic character modulo $m\ge3$. At $m=2$ the exception is absent.
\item For $m\ge2$, $(b,m)=1$ and $U\ge8$, put
\[
 V_b=\frac1{\varphi(m)}
       \int_{U/2}^U(1-\chi_1(b)t^{\beta-1})\,dt ,
\]
omitting the term with $\chi_1$ if the exception is absent. The case $h=U/2$ of \cite[Theorem 1.1, arXiv version 2]{ThornerZaman2024} says that if $V_b\ge U^{\theta+1/100}$, with $\theta=32/37$ when the exception exists and $\theta=7/12$ otherwise, then
\[
 \sum_{\substack{U/2<p\le U\\p\equiv b\bmod m}}\ln p
  =V_b\left(1+O\left(\exp\!\left[
 -\frac{c\ln U}
 {\ln m+(\ln U)^{2/5}(\ln\ln U)^{1/5}+1}
 \right]\right)\right)
\]
for an absolute $c>0$ and absolute implied constant.
\item Let $N(\sigma,T,\chi)$ count zeros with real part at least $\sigma$ and imaginary part of modulus at most $T$. Montgomery''s density estimate \cite[Theorem 12.2]{Montgomery1971} gives, for $Q,T\ge2$ and $4/5\le\sigma<1$,
\[
 \sum_{m\le Q}\ \sum_{\chi\bmod m}^{*} N(\sigma,T,\chi)
 \ll (Q^2T)^{5(1-\sigma)/2}(\ln(QT))^{14},
\]
where the star restricts to primitive characters. In particular the number of primitive characters of conductor at most $Q$ with a zero in $\Re s>1-1/400$, $|\Im s|\le Q$, is $O(Q^{1/4})$, by taking $T=2Q$ and $\sigma=1-1/400$ and absorbing the logarithm.
\end{itemize}

\emph{Prime averages in the candidate classes.}
Let $P$ be the primes $U/2<p\le U$ in a reduced residue class $a_0\bmod m_0$. We use moduli $8\mid m_0$ with $\ln m_0\le C_0\ln U/(\ln R)^2$, and with every prime divisor either at most $R^{1/4}$ or greater than $Z^2$. Here $C_0$ is an absolute constant specified below, and $R^{\varepsilon/6}\le\ln U\le R^{\varepsilon/4}$. Give each prime mass $\ln p$, with total mass $V=\sum_{p\in P}\ln p$.

For moduli $m=m_0s$ with $1\le s\le Z^2$ and $(s,m_0)=1$, one has $\ln m\ll\ln U/(\ln R)^2$. The bound on $1-\beta$ gives $V_b\gg U/m^2$, since $t\ge U/2$ and $1-t^{\beta-1}\gg 1/m$. Thus $V_b\ge U^{\theta+1/100}$ once $R$ meets the threshold. The prime-distribution error is then relative $O(\exp(-c''(\ln R)^2))$ for an absolute $c''>0$, since the other terms in its denominator are also $O(\ln U/(\ln R)^2)$. With $m=m_0$ this gives $V\ge U^{9/10}$ after raising the threshold.

For each odd squarefree $1<s\le Z^2$ prime to $m_0$, sum the class formula with weights $(b/s)$ over the classes $b\equiv a_0\bmod m_0$. The part from $1$ in the integral cancels by character orthogonality on $(\Z/s\Z)^\times$. The total of the absolute errors is $O(\exp(-c''(\ln R)^2)V)$, since the sum of the positive $V_b$ is at most $2V$. The exceptional part cancels unless the restriction of $\chi_1$ to the $s$ factor is the Jacobi character $(\frac{\cdot}{s})$. If this restriction holds but $1-\beta\ge c_1/(3\ln(m_0Z^2))$, that part has size $O(\exp(-c''''(\ln R)^2)V)$ for an absolute $c''''>0$. In fact $t^{\beta-1}$ is bounded by this exponential throughout $[U/2,U]$, so $V_b$ is within the same relative error of $U/(2\varphi(m))$.

There is at most one $s$ for which the restriction holds and $1-\beta<c_1/(3\ln(m_0Z^2))$. For two such $s$, lift the exceptional characters to the least common multiple of their moduli, at most $m_0Z^4$. Both zeros would be in the zero-free region with its one permitted exception, since $\ln(3m_0Z^4)\le3\ln(m_0Z^2)$. Imprimitive Euler factors have no zeros in this region. The characters therefore have the same primitive conductor, whose part prime to $m_0$ is precisely $s$ in each case. We conclude that
\[
 \left|\sum_{p\in P}(\ln p)\Bigl(\frac p s\Bigr)\right|
 \le R^{-2J-2}V
\]
for all such $s$, with at most one exception, by raising $Y_{\rm prime}$.

\emph{The short sum and its maximum.}
For any function $\nu_0$ with $|\nu_0(n)|\le1$ and $R\le y\le R^J$, put
\[
 S_r(y)=\sum_{n\le Z}\Lambda(n)\nu_0(n)
                 \Bigl(\frac n r\Bigr)\min(1,y/n)\qquad(r\in P).
\]
We show $\sum_{r\in P}(\ln r)|S_r(y)|^2\ll_J y\ln y\, V$, uniformly in $\nu_0$. In the expanded square, $r>Z^2$. Reciprocity and its supplement at $2$ express $(nn''/r)$ as a fixed sign times $(r/s)$, where $s$ is the squarefree part of $nn''$ after removing primes dividing $m_0$. Indeed all the removed odd-prime factors, the sign from reciprocity and the factor at $2$ are constant on the candidate residue class.

Write $c_n=\Lambda(n)\min(1,y/n)$ and $A_p=\sum_{\ell\ge1,\ p^\ell\le Z}c_{p^\ell}$. One has $A_p\ll\ln y$ for $p\le y$, by counting powers at most $y$ and summing the remaining geometric series, and $A_p\le 2y(\ln p)/p$ for $p>y$. By \ref{HPW7}, $\sum_{p\le v}\ln p\le3v$. It follows that $\sum_p A_p^2\ll y\ln y$: for $p\le y$ use $\sum_{p\le y}A_p\ll y$ (the powers above $y$ give at most $2\ln p$ per prime), and for $p>y$ sum over dyadic intervals using the same prime bound.

Call a prime power neutral when its exponent is even or its prime divides $m_0$. Its total $c_n$-mass is $O(\sqrt y)$. For the even powers, $\sum_{p^{2\ell}\le v}\ln p=\sum_{n\le\sqrt v}\Lambda(n)\le3\sqrt v$, and summing the tails dyadically against $y/n$ gives the same bound at $v=y$. The remaining neutral mass is $O(R^{1/4}\ln y)$, since the primes dividing $m_0$ that can occur are at most $R^{1/4}<y$. This is $O_J(\sqrt y)$. Pairs with $s=1$ are powers of the same prime or both neutral. For the one possibly exceptional $s>1$, its support must be one or two primes. The corresponding products have total absolute coefficient $O((\ln y)^2+\sqrt y\ln y)$, since they involve two fixed prime bases or one fixed prime base and one neutral power. For all other pairs use the bound $R^{-2J-2}V$ and $\sum_{n\le Z}c_n\ll y\ln Z$ from \ref{HPW7}. These estimates prove the mean square.

Between its breakpoints, $y S''_r(y)$ is the same sum with $\nu_0(n)$ restricted to $n>y$. Thus $\sum_{r\in P}(\ln r)|S''_r(y)|^2\ll_J V(\ln y)/y$. On a block $I=[W,\min(2W,R^J)]$, continuity and Cauchy--Schwarz give
\[
 \max_{y\in I}|S_r(y)|^2
 \le 2|S_r(W)|^2+2W\int_I|S''_r(y)|^2\,dy .
\]
Sum over $r$ with their masses and use the two mean squares. The mass of candidates with $|S_r(y)|>\tfrac12 y^{1/2+\varepsilon}$ somewhere on the block is $O_J(W^{-2\varepsilon}\ln W\,V)$. Summing over the blocks $W=2^\ell R$ gives $O_{J,\varepsilon}(R^{-\varepsilon}V)$.

\emph{Completing the short sum.}
Let $\chi$ be primitive nonprincipal of conductor at most $Q$ with no zeros for $\Re s>1-1/400$, $|\Im s|\le Q$. For $Q\ge4$, \ref{C3R2} at $a=2$, $H=Q/2$ gives
\[
 |G_\chi(w)|\ll(\ln Q)(w^{1-1/800}+w^2/Q)\qquad(w\ge1).
\]
For $w\ge2$ put $t(w)=-L''(1,\chi)/L(1,\chi)-\sum_{n\le w}\Lambda(n)\chi(n)/n$ and $h=w^{1-1/1600}$. Subtract the two ramp sums at $w+h,w$ and divide by $h$. By \ref{8JF7},
\[
 t(w)=-\frac{G_\chi(w+h)-G_\chi(w)}h
      +\frac1h\sum_{w<n\le w+h}\Lambda(n)\chi(n)
                            \left(\frac{w+h}{n}-1\right).
\]
Each summand in the last expression has modulus at most $(h/w)\ln(2w)$ and there are at most $h+1$ of them. Hence
\[
 |t(w)|\ll (\ln Q)\left(w^{-1/1600}
                 +\frac{w^{1+1/1600}}{Q}\right)
              +w^{-1/1600}\ln(2w).
\]
In both prime selections below $\ln Q\ge R^{\varepsilon/5}$ and $\ln Q\ll_M R^{\varepsilon/5}(\ln R)^2$. At $w=Z$, the first and third terms, even after multiplication by $R^J$, tend uniformly to zero because $10000/1600>6$. The term with $Q$ in the denominator tends to zero as well. Include in $Y_{\rm prime}$ the requirement $R^J|t(Z)|\le1/2$. If $\chi(n)=\nu_0(n)(n/r)$ then, for $y\le Z$, the definition gives the exact identity $G_\chi(y)=-S_r(y)-yt(Z)$. This proves the desired bound whenever the short sum passes its maximum test.

\emph{Selecting the two primes.}
For $q$, take $U=\exp z$, $m_0=8$ and $a_0=3$. Use the maximum test for all primitive $\nu$ of conductor dividing $M$, and the density estimate with $Q=MU$. For $d$, after fixing $q$, take $U=\exp z''$, $m_0=16q\prod_{3\le p\le z}p$ (over primes) and the class $7\bmod16$, $-1$ modulo every odd factor of $m_0$. Here $\ln m_0\le 5z$ once $R$ meets the threshold, by \ref{HPW7}, so $C_0=5$ works in both selections. The prime $q>Z^2$ is the only factor of $m_0$ exceeding $R^{1/4}$. Use the maximum test for $\nu_0=\nu(\frac{\cdot}{q})^i$, $i=0,1$, and the density estimate with $Q=M\exp(z+z'')$.

In either selection the candidate prime exceeds all prime factors of the base character and is the largest prime factor of the twisted conductor. Thus the product is primitive and one bad character from the density estimate identifies at most one candidate. Since $Q\le U^{3/2}$ in both selections, the total mass of candidates excluded by the density bound is $O(U^{3/8}\ln U)=o(V)$. The union of the maximum-test exceptions has mass $O_{M,J,\varepsilon}(R^{-\varepsilon}V)$. Include in $Y_{\rm prime}$ the condition that the two excluded masses together are less than $V$. A surviving prime has all the required estimates. The interval $(U/2,U]$ ensures the lower bounds on $\ln q$ and $\ln d$ once $R$ meets the same threshold. All thresholds use only $M,\varepsilon,J$, with the two selections uniform in the first prime.',
    body_html_cache = NULL,
    revision = 7,
    updated_at = '2026-11-27 16:00:00',
    updated_by = 'codex'
WHERE id = 112;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '112', 7, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 126, "body_tex": "Write $R=Y_{\\rm base}$ and $Z=R^{10000J}$. All inequalities in this proof that require a lower bound on $R$ are imposed in $Y_{\\rm prime}(\\psi,\\varepsilon,J)$. We first record the prime-distribution and zero-counting inputs.\n\n\\begin{itemize}\n\\item \\cite[Theorem 1]{McCurley1984}, in the form recorded in \\cite[Section 1.1]{ThornerZaman2024}, gives the following zero-free region. For any modulus $m\\ge2$, the product of the Dirichlet $L$-functions modulo $m$ has no zero in $\\Re s\\ge1-c_1/\\ln(m(|\\Im s|+3))$, with $c_1=1/13$, apart from a possible simple real zero $\\beta$ of a unique real nonprincipal character $\\chi_1$ modulo $m$. This zero lies in $(0,1)$ by the Euler product and nonvanishing at $1$ in \\ref{8JUV}, which also gives nonvanishing for imprimitive nonprincipal characters by their Euler factors. For such a zero one has $1-\\beta\\gg1/m$ by \\cite[Proposition 1.11]{BennettEtAl2018}, which gives $1-\\beta\\ge40/(\\sqrt m(\\ln m)^2)$ for a real zero $\\beta>0$ of a quadratic character modulo $m\\ge3$. At $m=2$ the exception is absent.\n\\item For $m\\ge2$, $(b,m)=1$ and $U\\ge8$, put\n\\[\n V_b=\\frac1{\\varphi(m)}\n       \\int_{U/2}^U(1-\\chi_1(b)t^{\\beta-1})\\,dt ,\n\\]\nomitting the term with $\\chi_1$ if the exception is absent. The case $h=U/2$ of \\cite[Theorem 1.1, arXiv version 2]{ThornerZaman2024} says that if $V_b\\ge U^{\\theta+1/100}$, with $\\theta=32/37$ when the exception exists and $\\theta=7/12$ otherwise, then\n\\[\n \\sum_{\\substack{U/2<p\\le U\\\\p\\equiv b\\bmod m}}\\ln p\n  =V_b\\left(1+O\\left(\\exp\\!\\left[\n -\\frac{c\\ln U}\n {\\ln m+(\\ln U)^{2/5}(\\ln\\ln U)^{1/5}+1}\n \\right]\\right)\\right)\n\\]\nfor an absolute $c>0$ and absolute implied constant.\n\\item Let $N(\\sigma,T,\\chi)$ count zeros with real part at least $\\sigma$ and imaginary part of modulus at most $T$. Montgomery''s density estimate \\cite[Theorem 12.2]{Montgomery1971} gives, for $Q,T\\ge2$ and $4/5\\le\\sigma<1$,\n\\[\n \\sum_{m\\le Q}\\ \\sum_{\\chi\\bmod m}^{*} N(\\sigma,T,\\chi)\n \\ll (Q^2T)^{5(1-\\sigma)/2}(\\ln(QT))^{14},\n\\]\nwhere the star restricts to primitive characters. In particular the number of primitive characters of conductor at most $Q$ with a zero in $\\Re s>1-1/400$, $|\\Im s|\\le Q$, is $O(Q^{1/4})$, by taking $T=2Q$ and $\\sigma=1-1/400$ and absorbing the logarithm.\n\\end{itemize}\n\n\\emph{Prime averages in the candidate classes.}\nLet $P$ be the primes $U/2<p\\le U$ in a reduced residue class $a_0\\bmod m_0$. We use moduli $8\\mid m_0$ with $\\ln m_0\\le C_0\\ln U/(\\ln R)^2$, and with every prime divisor either at most $R^{1/4}$ or greater than $Z^2$. Here $C_0$ is an absolute constant specified below, and $R^{\\varepsilon/6}\\le\\ln U\\le R^{\\varepsilon/4}$. Give each prime mass $\\ln p$, with total mass $V=\\sum_{p\\in P}\\ln p$.\n\nFor moduli $m=m_0s$ with $1\\le s\\le Z^2$ and $(s,m_0)=1$, one has $\\ln m\\ll\\ln U/(\\ln R)^2$. The bound on $1-\\beta$ gives $V_b\\gg U/m^2$, since $t\\ge U/2$ and $1-t^{\\beta-1}\\gg 1/m$. Thus $V_b\\ge U^{\\theta+1/100}$ once $R$ meets the threshold. The prime-distribution error is then relative $O(\\exp(-c''(\\ln R)^2))$ for an absolute $c''>0$, since the other terms in its denominator are also $O(\\ln U/(\\ln R)^2)$. With $m=m_0$ this gives $V\\ge U^{9/10}$ after raising the threshold.\n\nFor each odd squarefree $1<s\\le Z^2$ prime to $m_0$, sum the class formula with weights $(b/s)$ over the classes $b\\equiv a_0\\bmod m_0$. The part from $1$ in the integral cancels by character orthogonality on $(\\Z/s\\Z)^\\times$. The total of the absolute errors is $O(\\exp(-c''(\\ln R)^2)V)$, since the sum of the positive $V_b$ is at most $2V$. The exceptional part cancels unless the restriction of $\\chi_1$ to the $s$ factor is the Jacobi character $(\\frac{\\cdot}{s})$. If this restriction holds but $1-\\beta\\ge c_1/(3\\ln(m_0Z^2))$, that part has size $O(\\exp(-c''''(\\ln R)^2)V)$ for an absolute $c''''>0$. In fact $t^{\\beta-1}$ is bounded by this exponential throughout $[U/2,U]$, so $V_b$ is within the same relative error of $U/(2\\varphi(m))$.\n\nThere is at most one $s$ for which the restriction holds and $1-\\beta<c_1/(3\\ln(m_0Z^2))$. For two such $s$, lift the exceptional characters to the least common multiple of their moduli, at most $m_0Z^4$. Both zeros would be in the zero-free region with its one permitted exception, since $\\ln(3m_0Z^4)\\le3\\ln(m_0Z^2)$. Imprimitive Euler factors have no zeros in this region. The characters therefore have the same primitive conductor, whose part prime to $m_0$ is precisely $s$ in each case. We conclude that\n\\[\n \\left|\\sum_{p\\in P}(\\ln p)\\Bigl(\\frac p s\\Bigr)\\right|\n \\le R^{-2J-2}V\n\\]\nfor all such $s$, with at most one exception, by raising $Y_{\\rm prime}$.\n\n\\emph{The short sum and its maximum.}\nFor any function $\\nu_0$ with $|\\nu_0(n)|\\le1$ and $R\\le y\\le R^J$, put\n\\[\n S_r(y)=\\sum_{n\\le Z}\\Lambda(n)\\nu_0(n)\n                 \\Bigl(\\frac n r\\Bigr)\\min(1,y/n)\\qquad(r\\in P).\n\\]\nWe show $\\sum_{r\\in P}(\\ln r)|S_r(y)|^2\\ll_J y\\ln y\\, V$, uniformly in $\\nu_0$. In the expanded square, $r>Z^2$. Reciprocity and its supplement at $2$ express $(nn''/r)$ as a fixed sign times $(r/s)$, where $s$ is the squarefree part of $nn''$ after removing primes dividing $m_0$. Indeed all the removed odd-prime factors, the sign from reciprocity and the factor at $2$ are constant on the candidate residue class.\n\nWrite $c_n=\\Lambda(n)\\min(1,y/n)$ and $A_p=\\sum_{\\ell\\ge1,\\ p^\\ell\\le Z}c_{p^\\ell}$. One has $A_p\\ll\\ln y$ for $p\\le y$, by counting powers at most $y$ and summing the remaining geometric series, and $A_p\\le 2y(\\ln p)/p$ for $p>y$. By \\ref{HPW7}, $\\sum_{p\\le v}\\ln p\\le3v$. It follows that $\\sum_p A_p^2\\ll y\\ln y$: for $p\\le y$ use $\\sum_{p\\le y}A_p\\ll y$ (the powers above $y$ give at most $2\\ln p$ per prime), and for $p>y$ sum over dyadic intervals using the same prime bound.\n\nCall a prime power neutral when its exponent is even or its prime divides $m_0$. Its total $c_n$-mass is $O(\\sqrt y)$. For the even powers, $\\sum_{p^{2\\ell}\\le v}\\ln p=\\sum_{n\\le\\sqrt v}\\Lambda(n)\\le3\\sqrt v$, and summing the tails dyadically against $y/n$ gives the same bound at $v=y$. The remaining neutral mass is $O(R^{1/4}\\ln y)$, since the primes dividing $m_0$ that can occur are at most $R^{1/4}<y$. This is $O_J(\\sqrt y)$. Pairs with $s=1$ are powers of the same prime or both neutral. For the one possibly exceptional $s>1$, its support must be one or two primes. The corresponding products have total absolute coefficient $O((\\ln y)^2+\\sqrt y\\ln y)$, since they involve two fixed prime bases or one fixed prime base and one neutral power. For all other pairs use the bound $R^{-2J-2}V$ and $\\sum_{n\\le Z}c_n\\ll y\\ln Z$ from \\ref{HPW7}. These estimates prove the mean square.\n\nBetween its breakpoints, $y S''_r(y)$ is the same sum with $\\nu_0(n)$ restricted to $n>y$. Thus $\\sum_{r\\in P}(\\ln r)|S''_r(y)|^2\\ll_J V(\\ln y)/y$. On a block $I=[W,\\min(2W,R^J)]$, continuity and Cauchy--Schwarz give\n\\[\n \\max_{y\\in I}|S_r(y)|^2\n \\le 2|S_r(W)|^2+2W\\int_I|S''_r(y)|^2\\,dy .\n\\]\nSum over $r$ with their masses and use the two mean squares. The mass of candidates with $|S_r(y)|>\\tfrac12 y^{1/2+\\varepsilon}$ somewhere on the block is $O_J(W^{-2\\varepsilon}\\ln W\\,V)$. Summing over the blocks $W=2^\\ell R$ gives $O_{J,\\varepsilon}(R^{-\\varepsilon}V)$.\n\n\\emph{Completing the short sum.}\nLet $\\chi$ be primitive nonprincipal of conductor at most $Q$ with no zeros for $\\Re s>1-1/400$, $|\\Im s|\\le Q$. For $Q\\ge4$, \\ref{C3R2} at $a=2$, $H=Q/2$ gives\n\\[\n |G_\\chi(w)|\\ll(\\ln Q)(w^{1-1/800}+w^2/Q)\\qquad(w\\ge1).\n\\]\nFor $w\\ge2$ put $t(w)=-L''(1,\\chi)/L(1,\\chi)-\\sum_{n\\le w}\\Lambda(n)\\chi(n)/n$ and $h=w^{1-1/1600}$. Subtract the two ramp sums at $w+h,w$ and divide by $h$. By \\ref{8JF7},\n\\[\n t(w)=-\\frac{G_\\chi(w+h)-G_\\chi(w)}h\n      +\\frac1h\\sum_{w<n\\le w+h}\\Lambda(n)\\chi(n)\n                            \\left(\\frac{w+h}{n}-1\\right).\n\\]\nEach summand in the last expression has modulus at most $(h/w)\\ln(2w)$ and there are at most $h+1$ of them. Hence\n\\[\n |t(w)|\\ll (\\ln Q)\\left(w^{-1/1600}\n                 +\\frac{w^{1+1/1600}}{Q}\\right)\n              +w^{-1/1600}\\ln(2w).\n\\]\nIn both prime selections below $\\ln Q\\ge R^{\\varepsilon/5}$ and $\\ln Q\\ll_M R^{\\varepsilon/5}(\\ln R)^2$. At $w=Z$, the first and third terms, even after multiplication by $R^J$, tend uniformly to zero because $10000/1600>6$. The term with $Q$ in the denominator tends to zero as well. Include in $Y_{\\rm prime}$ the requirement $R^J|t(Z)|\\le1/2$. If $\\chi(n)=\\nu_0(n)(n/r)$ then, for $y\\le Z$, the definition gives the exact identity $G_\\chi(y)=-S_r(y)-yt(Z)$. This proves the desired bound whenever the short sum passes its maximum test.\n\n\\emph{Selecting the two primes.}\nFor $q$, take $U=\\exp z$, $m_0=8$ and $a_0=3$. Use the maximum test for all primitive $\\nu$ of conductor dividing $M$, and the density estimate with $Q=MU$. For $d$, after fixing $q$, take $U=\\exp z''$, $m_0=16q\\prod_{3\\le p\\le z}p$ (over primes) and the class $7\\bmod16$, $-1$ modulo every odd factor of $m_0$. Here $\\ln m_0\\le 5z$ once $R$ meets the threshold, by \\ref{HPW7}, so $C_0=5$ works in both selections. The prime $q>Z^2$ is the only factor of $m_0$ exceeding $R^{1/4}$. Use the maximum test for $\\nu_0=\\nu(\\frac{\\cdot}{q})^i$, $i=0,1$, and the density estimate with $Q=M\\exp(z+z'')$.\n\nIn either selection the candidate prime exceeds all prime factors of the base character and is the largest prime factor of the twisted conductor. Thus the product is primitive and one bad character from the density estimate identifies at most one candidate. Since $Q\\le U^{3/2}$ in both selections, the total mass of candidates excluded by the density bound is $O(U^{3/8}\\ln U)=o(V)$. The union of the maximum-test exceptions has mass $O_{M,J,\\varepsilon}(R^{-\\varepsilon}V)$. Include in $Y_{\\rm prime}$ the condition that the two excluded masses together are less than $V$. A surviving prime has all the required estimates. The interval $(U/2,U]$ ensures the lower bounds on $\\ln q$ and $\\ln d$ once $R$ meets the same threshold. All thresholds use only $M,\\varepsilon,J$, with the two selections uniform in the first prime.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

UPDATE proofs
SET body_tex = 'In the notation of \cite[Definition 18.1(D6) and Proposition 18.3]{Adriazola}, the groups in the statement identify with $X_\ell(E,r)$, with weight $(\ln\ell)\operatorname{length}_{\Z_\ell}X_\ell(E,r)$, by Lemma 17.4. Admissibility directly supplies finiteness and the bound by $\sqrt b$ at the stated cutoff. The theorems outlined in \cite[Sections 3--5 and Appendix A]{Outline} concern the cohomological input used to obtain these admissible windows.',
    body_html_cache = NULL,
    revision = 2,
    updated_at = '2026-11-27 16:00:00'
WHERE id = 113;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '113', 2, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 127, "body_tex": "In the notation of \\cite[Definition 18.1(D6) and Proposition 18.3]{Adriazola}, the groups in the statement identify with $X_\\ell(E,r)$, with weight $(\\ln\\ell)\\operatorname{length}_{\\Z_\\ell}X_\\ell(E,r)$, by Lemma 17.4. Admissibility directly supplies finiteness and the bound by $\\sqrt b$ at the stated cutoff. The theorems outlined in \\cite[Sections 3--5 and Appendix A]{Outline} concern the cohomological input used to obtain these admissible windows.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

UPDATE proofs
SET body_tex = '\emph{(1) Compare periods in a common lattice.} A chain of theta lifts passes between totally definite unitary groups. A seesaw identity compares each period with a Bessel period in a common model. Local vector matching and the common test vectors make the integral comparison compatible with the covolume estimate. The \hyperref[8JUB]{matrix rank estimate} controls the dimension lost when combining the period maps.

\emph{(2) Eliminate the common slope.} Divisibility gives a lower bound for the mean quotient slope after subtracting map heights. A Bost-type inequality gives an upper bound for that slope in terms of the common lattice slope. Subtraction eliminates the slopes. Cohomological lengths bound the loss in divisibility, while the covolume, rank and height estimates bound the other losses.

\emph{(3) Identify the centered count.} The logarithms of the weights $w_{u,j}(\alpha)$ from \ref{C4W2} in the divisibility threshold give the average over $\alpha\in\Phi$. The geometric normalizations cancel as in \ref{8JUC}, leaving the sum of the main terms $M(\upsilon_t,w_{u,j})$ of \ref{8JU9}. The resulting estimate on the centered count is the one in \cite[Section 12, (12.2)]{Outline}. Compare \cite[Corollary 3.4 and Theorem A(ii)]{Adriazola}, where Section 18.6 obtains the stronger power $x^{3\varepsilon}$ under the chain-record hypotheses. In \cite[(3.10)]{Adriazola}, take $\upsilon_t=a_t$, $a_E=xb$ and $S_0=\{p : p\mid N,\ p\ne d\}$. For these $p$ we have $(p/d)=1$ by quadratic reciprocity and its supplement at $2$, so their cosets lie in $\Phi$, and the coset at $d$ gives the single remaining contribution. Thus the excess there is the centered count of \ref{8JVF}. With the fixed exponents here, $x^{3\varepsilon}\le x^{(e_D+e_L+3)\varepsilon}$ for $x\ge1$.

Take $x_{\rm div}$ to be the maximum of $x_{\rm wt}$ and the thresholds used in \cite[Section 18.6, proof of Theorem A]{Adriazola} to apply the comparison to the chain records of \ref{C4S2}. Include the threshold for the scale inequalities in \ref{8JUG}. The record constants and $J$ are fixed by $\psi,\varepsilon$, so $x_{\rm div}$ is uniform in the window.',
    body_html_cache = NULL,
    revision = 6,
    updated_at = '2026-11-27 16:00:00'
WHERE id = 114;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '114', 6, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 129, "body_tex": "\\emph{(1) Compare periods in a common lattice.} A chain of theta lifts passes between totally definite unitary groups. A seesaw identity compares each period with a Bessel period in a common model. Local vector matching and the common test vectors make the integral comparison compatible with the covolume estimate. The \\hyperref[8JUB]{matrix rank estimate} controls the dimension lost when combining the period maps.\n\n\\emph{(2) Eliminate the common slope.} Divisibility gives a lower bound for the mean quotient slope after subtracting map heights. A Bost-type inequality gives an upper bound for that slope in terms of the common lattice slope. Subtraction eliminates the slopes. Cohomological lengths bound the loss in divisibility, while the covolume, rank and height estimates bound the other losses.\n\n\\emph{(3) Identify the centered count.} The logarithms of the weights $w_{u,j}(\\alpha)$ from \\ref{C4W2} in the divisibility threshold give the average over $\\alpha\\in\\Phi$. The geometric normalizations cancel as in \\ref{8JUC}, leaving the sum of the main terms $M(\\upsilon_t,w_{u,j})$ of \\ref{8JU9}. The resulting estimate on the centered count is the one in \\cite[Section 12, (12.2)]{Outline}. Compare \\cite[Corollary 3.4 and Theorem A(ii)]{Adriazola}, where Section 18.6 obtains the stronger power $x^{3\\varepsilon}$ under the chain-record hypotheses. In \\cite[(3.10)]{Adriazola}, take $\\upsilon_t=a_t$, $a_E=xb$ and $S_0=\\{p : p\\mid N,\\ p\\ne d\\}$. For these $p$ we have $(p/d)=1$ by quadratic reciprocity and its supplement at $2$, so their cosets lie in $\\Phi$, and the coset at $d$ gives the single remaining contribution. Thus the excess there is the centered count of \\ref{8JVF}. With the fixed exponents here, $x^{3\\varepsilon}\\le x^{(e_D+e_L+3)\\varepsilon}$ for $x\\ge1$.\n\nTake $x_{\\rm div}$ to be the maximum of $x_{\\rm wt}$ and the thresholds used in \\cite[Section 18.6, proof of Theorem A]{Adriazola} to apply the comparison to the chain records of \\ref{C4S2}. Include the threshold for the scale inequalities in \\ref{8JUG}. The record constants and $J$ are fixed by $\\psi,\\varepsilon$, so $x_{\\rm div}$ is uniform in the window.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

UPDATE proofs
SET body_tex = '\emph{(a) Expand the centered count and control the changes of weight.}
Fix any $u\in A_0$, $t\in T$, and integer $1\le j\le m$. In the complex sum of \ref{8JVD} for $(t,\upsilon_t,w_{u,j})$, keep the positions whose labels lie in $\Phi_u$ of \ref{8JVK}, replace their weights by $b$, and omit terms at all other positions. This defines $P\colon A_0\times T\to\C$ by taking $P(u,t)$ to be the resulting sum before taking real parts. It is independent of $j$.

At a label $\alpha=p_t(g)\in\Phi_u$, write $w=w_{u,j}^t(g)=w_{u,j}(\alpha)$. Then \ref{8JUE} bounds the change in $wG_{\xi^*}(\upsilon_t/w)$ by $3(x+1)\rho_w$, using $\upsilon_t\le(x+1)b$ and $b\le w\le b+\rho_w\le2b\le \upsilon_t$. At each other label $\alpha=p_t(g)\in\Phi\smallsetminus\Phi_u$, the weight $w=w_{u,j}^t(g)$ satisfies $w\le2b''$ and
\[
\frac{\upsilon_t}{w}\ge\frac{(x-1)b}{2b''}
=\frac{x-1}{2x}\,X''\ge X''/3 .
\]
All original cutoffs are at least $1$, as required by \ref{8JVD}, since $2b\le \upsilon_t$ and $X''/3\ge1$. By \ref{8JVH}(i), each omitted term before its Fourier coefficient has absolute value at most $w(\upsilon_t/w)\omega_x\le(x+1)b\omega_x$. There are at most $f$ positions and $2f$ characters, and the coefficient has modulus $1/f$. Thus the error for each $(u,t,j)$ is bounded by
\[
6f(x+1)\rho_w+2f(x+1)b\omega_x\le2b/x .
\]
The first term is at most $b/x$ by \ref{8JVK}. The second is at most $b/x$ by the bound for $2f(x+1)\omega_x$ in \ref{8JVH}(i).

\emph{(b) Average over $u$.}
For each $z\in T_2$, the class assigning the weight at $(0,1,z+u)$ is $g=(1,0,z+u-t)$, by $p_t$ in \ref{8JU9}. For $t\in T$ put $y_t=\upsilon_t/b$. For $\xi\in\widehat B$ put $\sigma_\xi=\xi(1,0,0_A)\in\{1,-1\}$. Identify $A$ with its embedded copy as in \ref{8JVP}. Then
\[
P(u,t)=\frac b f\sum_{\xi\in\widehat B}
 \sigma_\xi\xi(t)G_{\xi^*}(y_t)
 \sum_{z\in T_2}\overline{\xi(z)}\,\overline{\xi(u)} .
\]
By \ref{8JV9}, the mean over $u$ kills all $\xi$ outside $\mathcal H$ of \ref{8JUW}. For $\xi\in\mathcal H$, every $z\in T_2$ gives $\xi(z)=1$. Consequently
\[
\frac1{|A_0|}\sum_{u\in A_0}P(u,t)
=\frac{b\delta_2}{2}\sum_{\xi\in\mathcal H}
       \sigma_\xi\xi(t)G_{\xi^*}(y_t).
\]
The coefficient is $bh_2/f=b\delta_2/2$. After summation over $h$ choices of $t$ and $m$ choices of $j$, it becomes $Q\delta_2/2$. In particular that is the coefficient of $G_{\mathbf1}(x)$ after moving to $x$. Dividing the error $2hmb/x$ from (a) by this factor gives $4/(x\delta_2)$.

\emph{(c) Move the cutoffs to $x$.}
For $\xi\in\mathcal H$, use the complex value $\ell_\xi=L''(1,\xi^*)/L(1,\xi^*)$ when $\xi^*\ne\mathbf1$, and $\ell_\xi=0$ otherwise. Off the integer breakpoints, differentiating $G_{\xi^*}(y)$ gives the sum $\sum_{n\le y}\Lambda(n)\xi^*(n)/n$ plus $\ell_\xi$ for nontrivial $\xi^*$, or plus $-\ln y+\gamma$ for the trivial character. Use $\Theta(v)=\sum_{n\le v}\Lambda(n)$ for real $v\ge1$ as in the proof of \ref{8JUE}. The Chebyshev bound $\Theta(v)\le3v$ and partial summation give
\[
\sum_{n\le y}\frac{\Lambda(n)}n
=\frac{\Theta(y)}y+\int_1^y\frac{\Theta(v)}{v^2}\,dv
\le 3+3\ln y .
\]
Each sum is continuous at its breakpoints, so integration on the pieces between $y_t$ and $x$ gives
\[
|G_{\xi^*}(y_t)-G_{\xi^*}(x)|
\le L_x=3+|\gamma|+4\ln(x+1)+\max_{\xi\in\mathcal H}|\ell_\xi|.
\]
Here $|y_t-x|\le1$ and $x\ge3$. The quotient $B/A_0=\Z/2\Z\times\Z/2\Z\times(A/A_0)$ has $4o$ characters, so this replacement costs at most $4oL_x$ after the division in (b).

\emph{(d) Apply the coset average.}
For $\xi\in\mathcal H$ put $\beta_\xi=h^{-1}\sum_{t\in T}\xi(t)\in\C$. After the replacement in (c), the normalized expression is
\[
\Re\sum_{\xi\in\mathcal H}
       \sigma_\xi\beta_\xi G_{\xi^*}(x).
\]
By the product coordinates in \ref{8JVP} and the subgroup $A_0$ in \ref{8JVC}, the characters in $\mathcal H$ are the $o$ powers of $\psi_A$ on $A/A_0$ with each of the four pairs of quadratic signs on the other two factors. The $o$ choices with both signs trivial give $\mathcal K$ and have $\sigma_\xi=1$. The remaining $3o$ have a quadratic factor at $q$ or $d$: the Chinese remainder factors at those primes are independent of $A$, and a nontrivial factor forces that prime into the primitive conductor. This also shows why no extra character induces a member of $\mathcal C_\psi$.

For $\xi\in\mathcal K$, the $k=3$ target $c_3(\xi|_A)$ is $a_{\xi^*}$ of \ref{8JG8}. Applying \ref{8JVA} with $k=3$ gives $|\beta_\xi-a_{\xi^*}|\le\nu_x=o x^{-1+\varepsilon}$. For every other $\xi$, $|\sigma_\xi\beta_\xi|\le1$. Combining (a)--(d) now gives
\begin{align*}
\mathcal G_\psi(x)
 &\le D_\psi(x)+\frac{4}{x\delta_2}+\Sigma(x)\\
 &\quad+4oL_x+\nu_x\sum_{\xi\in\mathcal K}|G_{\xi^*}(x)|.
\end{align*}
In this inequality $\Sigma(x)\le3o\,x^{1/2+\varepsilon}$ by \ref{8JVH}(ii). That lemma also gives $L_x=O_{\psi,\varepsilon}(\ln(x+1))$, since the other $\ell_\xi$ come from the fixed family $\mathcal C_\psi$. The growth bound in \ref{8JS3} gives
\[
\nu_x\sum_{\xi\in\mathcal K}|G_{\xi^*}(x)|
=O_\psi\bigl(x^\varepsilon(1+\ln x)^2\bigr).
\]
The sum of these two errors is $o(x^{1/2+\varepsilon})$, uniformly over the data, since the constants depend only on $\psi,\varepsilon$. Choose $x_{\rm cmp}\ge x_{\rm aux}$ so that the sum is at most $4x^{1/2+\varepsilon}$ at every $x\ge x_{\rm cmp}$.',
    body_html_cache = NULL,
    revision = 10,
    updated_at = '2026-11-27 16:00:00'
WHERE id = 117;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '117', 10, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 132, "body_tex": "\\emph{(a) Expand the centered count and control the changes of weight.}\nFix any $u\\in A_0$, $t\\in T$, and integer $1\\le j\\le m$. In the complex sum of \\ref{8JVD} for $(t,\\upsilon_t,w_{u,j})$, keep the positions whose labels lie in $\\Phi_u$ of \\ref{8JVK}, replace their weights by $b$, and omit terms at all other positions. This defines $P\\colon A_0\\times T\\to\\C$ by taking $P(u,t)$ to be the resulting sum before taking real parts. It is independent of $j$.\n\nAt a label $\\alpha=p_t(g)\\in\\Phi_u$, write $w=w_{u,j}^t(g)=w_{u,j}(\\alpha)$. Then \\ref{8JUE} bounds the change in $wG_{\\xi^*}(\\upsilon_t/w)$ by $3(x+1)\\rho_w$, using $\\upsilon_t\\le(x+1)b$ and $b\\le w\\le b+\\rho_w\\le2b\\le \\upsilon_t$. At each other label $\\alpha=p_t(g)\\in\\Phi\\smallsetminus\\Phi_u$, the weight $w=w_{u,j}^t(g)$ satisfies $w\\le2b''$ and\n\\[\n\\frac{\\upsilon_t}{w}\\ge\\frac{(x-1)b}{2b''}\n=\\frac{x-1}{2x}\\,X''\\ge X''/3 .\n\\]\nAll original cutoffs are at least $1$, as required by \\ref{8JVD}, since $2b\\le \\upsilon_t$ and $X''/3\\ge1$. By \\ref{8JVH}(i), each omitted term before its Fourier coefficient has absolute value at most $w(\\upsilon_t/w)\\omega_x\\le(x+1)b\\omega_x$. There are at most $f$ positions and $2f$ characters, and the coefficient has modulus $1/f$. Thus the error for each $(u,t,j)$ is bounded by\n\\[\n6f(x+1)\\rho_w+2f(x+1)b\\omega_x\\le2b/x .\n\\]\nThe first term is at most $b/x$ by \\ref{8JVK}. The second is at most $b/x$ by the bound for $2f(x+1)\\omega_x$ in \\ref{8JVH}(i).\n\n\\emph{(b) Average over $u$.}\nFor each $z\\in T_2$, the class assigning the weight at $(0,1,z+u)$ is $g=(1,0,z+u-t)$, by $p_t$ in \\ref{8JU9}. For $t\\in T$ put $y_t=\\upsilon_t/b$. For $\\xi\\in\\widehat B$ put $\\sigma_\\xi=\\xi(1,0,0_A)\\in\\{1,-1\\}$. Identify $A$ with its embedded copy as in \\ref{8JVP}. Then\n\\[\nP(u,t)=\\frac b f\\sum_{\\xi\\in\\widehat B}\n \\sigma_\\xi\\xi(t)G_{\\xi^*}(y_t)\n \\sum_{z\\in T_2}\\overline{\\xi(z)}\\,\\overline{\\xi(u)} .\n\\]\nBy \\ref{8JV9}, the mean over $u$ kills all $\\xi$ outside $\\mathcal H$ of \\ref{8JUW}. For $\\xi\\in\\mathcal H$, every $z\\in T_2$ gives $\\xi(z)=1$. Consequently\n\\[\n\\frac1{|A_0|}\\sum_{u\\in A_0}P(u,t)\n=\\frac{b\\delta_2}{2}\\sum_{\\xi\\in\\mathcal H}\n       \\sigma_\\xi\\xi(t)G_{\\xi^*}(y_t).\n\\]\nThe coefficient is $bh_2/f=b\\delta_2/2$. After summation over $h$ choices of $t$ and $m$ choices of $j$, it becomes $Q\\delta_2/2$. In particular that is the coefficient of $G_{\\mathbf1}(x)$ after moving to $x$. Dividing the error $2hmb/x$ from (a) by this factor gives $4/(x\\delta_2)$.\n\n\\emph{(c) Move the cutoffs to $x$.}\nFor $\\xi\\in\\mathcal H$, use the complex value $\\ell_\\xi=L''(1,\\xi^*)/L(1,\\xi^*)$ when $\\xi^*\\ne\\mathbf1$, and $\\ell_\\xi=0$ otherwise. Off the integer breakpoints, differentiating $G_{\\xi^*}(y)$ gives the sum $\\sum_{n\\le y}\\Lambda(n)\\xi^*(n)/n$ plus $\\ell_\\xi$ for nontrivial $\\xi^*$, or plus $-\\ln y+\\gamma$ for the trivial character. Use $\\Theta(v)=\\sum_{n\\le v}\\Lambda(n)$ for real $v\\ge1$ as in the proof of \\ref{8JUE}. The Chebyshev bound $\\Theta(v)\\le3v$ and partial summation give\n\\[\n\\sum_{n\\le y}\\frac{\\Lambda(n)}n\n=\\frac{\\Theta(y)}y+\\int_1^y\\frac{\\Theta(v)}{v^2}\\,dv\n\\le 3+3\\ln y .\n\\]\nEach sum is continuous at its breakpoints, so integration on the pieces between $y_t$ and $x$ gives\n\\[\n|G_{\\xi^*}(y_t)-G_{\\xi^*}(x)|\n\\le L_x=3+|\\gamma|+4\\ln(x+1)+\\max_{\\xi\\in\\mathcal H}|\\ell_\\xi|.\n\\]\nHere $|y_t-x|\\le1$ and $x\\ge3$. The quotient $B/A_0=\\Z/2\\Z\\times\\Z/2\\Z\\times(A/A_0)$ has $4o$ characters, so this replacement costs at most $4oL_x$ after the division in (b).\n\n\\emph{(d) Apply the coset average.}\nFor $\\xi\\in\\mathcal H$ put $\\beta_\\xi=h^{-1}\\sum_{t\\in T}\\xi(t)\\in\\C$. After the replacement in (c), the normalized expression is\n\\[\n\\Re\\sum_{\\xi\\in\\mathcal H}\n       \\sigma_\\xi\\beta_\\xi G_{\\xi^*}(x).\n\\]\nBy the product coordinates in \\ref{8JVP} and the subgroup $A_0$ in \\ref{8JVC}, the characters in $\\mathcal H$ are the $o$ powers of $\\psi_A$ on $A/A_0$ with each of the four pairs of quadratic signs on the other two factors. The $o$ choices with both signs trivial give $\\mathcal K$ and have $\\sigma_\\xi=1$. The remaining $3o$ have a quadratic factor at $q$ or $d$: the Chinese remainder factors at those primes are independent of $A$, and a nontrivial factor forces that prime into the primitive conductor. This also shows why no extra character induces a member of $\\mathcal C_\\psi$.\n\nFor $\\xi\\in\\mathcal K$, the $k=3$ target $c_3(\\xi|_A)$ is $a_{\\xi^*}$ of \\ref{8JG8}. Applying \\ref{8JVA} with $k=3$ gives $|\\beta_\\xi-a_{\\xi^*}|\\le\\nu_x=o x^{-1+\\varepsilon}$. For every other $\\xi$, $|\\sigma_\\xi\\beta_\\xi|\\le1$. Combining (a)--(d) now gives\n\\begin{align*}\n\\mathcal G_\\psi(x)\n &\\le D_\\psi(x)+\\frac{4}{x\\delta_2}+\\Sigma(x)\\\\\n &\\quad+4oL_x+\\nu_x\\sum_{\\xi\\in\\mathcal K}|G_{\\xi^*}(x)|.\n\\end{align*}\nIn this inequality $\\Sigma(x)\\le3o\\,x^{1/2+\\varepsilon}$ by \\ref{8JVH}(ii). That lemma also gives $L_x=O_{\\psi,\\varepsilon}(\\ln(x+1))$, since the other $\\ell_\\xi$ come from the fixed family $\\mathcal C_\\psi$. The growth bound in \\ref{8JS3} gives\n\\[\n\\nu_x\\sum_{\\xi\\in\\mathcal K}|G_{\\xi^*}(x)|\n=O_\\psi\\bigl(x^\\varepsilon(1+\\ln x)^2\\bigr).\n\\]\nThe sum of these two errors is $o(x^{1/2+\\varepsilon})$, uniformly over the data, since the constants depend only on $\\psi,\\varepsilon$. Choose $x_{\\rm cmp}\\ge x_{\\rm aux}$ so that the sum is at most $4x^{1/2+\\varepsilon}$ at every $x\\ge x_{\\rm cmp}$.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

UPDATE proofs
SET body_tex = 'For $v\in(0,\upsilon]$, put $F(v)=vG_\chi(\upsilon/v)\in\C$. For real $z\ge1$, put $\Theta(z)=\sum_{n\le z}\Lambda(n)\in[0,\infty)$. The Chebyshev bound \ref{HPW7} gives $0\le\Theta(z)\le4z\ln 2\le3z$ for $z\ge1$. The expression for $F$ from \ref{8JF7} is a sum of $\Lambda(n)\chi(n)(\upsilon/n-v)_+$ plus the main-term correction. There are finitely many breakpoints $v=\upsilon/n$ between $w$ and $w''$. The sum is continuous there, since the term crossing the cutoff is zero at its breakpoint.

For nontrivial $\chi$ the correction is the constant $\upsilon L''(1,\chi)/L(1,\chi)$. Off the breakpoints, $F''(v)=-\sum_{n\le \upsilon/v}\Lambda(n)\chi(n)$ and $|F''(v)|\le3\upsilon/v$. For the trivial character the correction is $-\upsilon\ln(\upsilon/v)+(1+\gamma)\upsilon$, giving $F''(v)=\upsilon/v-\Theta(\upsilon/v)$. Since $0\le\Theta(\upsilon/v)\le3\upsilon/v$, its absolute value is at most $2\upsilon/v$. In either case, integrate the derivative on each subinterval and use continuity at its endpoints. The bound $3\upsilon/v\le3\upsilon/\min(w,w'')$ on the whole interval gives the result.',
    body_html_cache = NULL,
    revision = 5,
    updated_at = '2026-11-27 16:00:00'
WHERE id = 118;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '118', 5, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 133, "body_tex": "For $v\\in(0,\\upsilon]$, put $F(v)=vG_\\chi(\\upsilon/v)\\in\\C$. For real $z\\ge1$, put $\\Theta(z)=\\sum_{n\\le z}\\Lambda(n)\\in[0,\\infty)$. The Chebyshev bound \\ref{HPW7} gives $0\\le\\Theta(z)\\le4z\\ln 2\\le3z$ for $z\\ge1$. The expression for $F$ from \\ref{8JF7} is a sum of $\\Lambda(n)\\chi(n)(\\upsilon/n-v)_+$ plus the main-term correction. There are finitely many breakpoints $v=\\upsilon/n$ between $w$ and $w''$. The sum is continuous there, since the term crossing the cutoff is zero at its breakpoint.\n\nFor nontrivial $\\chi$ the correction is the constant $\\upsilon L''(1,\\chi)/L(1,\\chi)$. Off the breakpoints, $F''(v)=-\\sum_{n\\le \\upsilon/v}\\Lambda(n)\\chi(n)$ and $|F''(v)|\\le3\\upsilon/v$. For the trivial character the correction is $-\\upsilon\\ln(\\upsilon/v)+(1+\\gamma)\\upsilon$, giving $F''(v)=\\upsilon/v-\\Theta(\\upsilon/v)$. Since $0\\le\\Theta(\\upsilon/v)\\le3\\upsilon/v$, its absolute value is at most $2\\upsilon/v$. In either case, integrate the derivative on each subinterval and use continuity at its endpoints. The bound $3\\upsilon/v\\le3\\upsilon/\\min(w,w'')$ on the whole interval gives the result.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

UPDATE proofs
SET body_tex = 'Apply \ref{C4S2} with requested lower bound $\max(Y_0,x_{\rm arith})$. At each $x$ on the resulting window the arithmetic data give the stated primes, tower and sets, and \ref{C4W2} yields the admissible scales and weights because $x\ge x_{\rm wt}$. Thus the data meet \ref{8JVE}. For these same data the chain records have $e_D=2$, $e_L=0$. Applying \ref{8JUA} at $x\ge x_{\rm div}$ gives, with its $\mathcal B$ and $E_{\rm err}$,
\begin{align*}
D_\psi(x)
 &\le \frac{2E_{\rm err}}{Q\delta_2} &&\text{(a)}\\
 &\le 2x^{(e_D+e_L+3)\varepsilon}
              \frac{\mathcal B}{Q}\delta_2^{-1} &&\text{(b)}\\
 &\le 20x^{1/2+(e_D+e_L+45/8)\varepsilon} &&\text{(c)}\\
 &=20x^{1/2+61\varepsilon/8}. &&\text{(d)}
\end{align*}
(a) Average $\Delta_u\le E_{\rm err}$ and divide by $Q\delta_2/2>0$.
(b) Apply the per-shift bound of \ref{8JUA}.
(c) Use $\mathcal B/Q\le 10x^{1/2+13\varepsilon/8}$ and $\delta_2^{-1}\le x^\varepsilon$ from \ref{8JUG}; the exponent increment is $3+13/8+1=45/8$.
(d) Insert the chosen exponents.',
    body_html_cache = NULL,
    revision = 6,
    updated_at = '2026-11-27 16:00:00',
    updated_by = 'codex'
WHERE id = 119;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '119', 6, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 134, "body_tex": "Apply \\ref{C4S2} with requested lower bound $\\max(Y_0,x_{\\rm arith})$. At each $x$ on the resulting window the arithmetic data give the stated primes, tower and sets, and \\ref{C4W2} yields the admissible scales and weights because $x\\ge x_{\\rm wt}$. Thus the data meet \\ref{8JVE}. For these same data the chain records have $e_D=2$, $e_L=0$. Applying \\ref{8JUA} at $x\\ge x_{\\rm div}$ gives, with its $\\mathcal B$ and $E_{\\rm err}$,\n\\begin{align*}\nD_\\psi(x)\n &\\le \\frac{2E_{\\rm err}}{Q\\delta_2} &&\\text{(a)}\\\\\n &\\le 2x^{(e_D+e_L+3)\\varepsilon}\n              \\frac{\\mathcal B}{Q}\\delta_2^{-1} &&\\text{(b)}\\\\\n &\\le 20x^{1/2+(e_D+e_L+45/8)\\varepsilon} &&\\text{(c)}\\\\\n &=20x^{1/2+61\\varepsilon/8}. &&\\text{(d)}\n\\end{align*}\n(a) Average $\\Delta_u\\le E_{\\rm err}$ and divide by $Q\\delta_2/2>0$.\n(b) Apply the per-shift bound of \\ref{8JUA}.\n(c) Use $\\mathcal B/Q\\le 10x^{1/2+13\\varepsilon/8}$ and $\\delta_2^{-1}\\le x^\\varepsilon$ from \\ref{8JUG}; the exponent increment is $3+13/8+1=45/8$.\n(d) Insert the chosen exponents.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

UPDATE proofs
SET body_tex = 'For a modulus $D$ and a nonprincipal character $\chi$ modulo $D$, the partial sums of $\chi$ are bounded because a full-period sum is zero. Partial summation continues $L(s,\chi)$ to the holomorphic function
\[
 s\int_1^\infty\left(\sum_{n\le u}\chi(n)\right)u^{-s-1}\,du
 \qquad(\Re s>0).
\]
The principal $L$-function is $\zeta(s)\prod_{p\mid D}(1-p^{-s})$. For $\zeta$ the same integral starts with $\lfloor u\rfloor=u-\{u\}$ and gives
$\zeta(s)=s/(s-1)-s\int_1^\infty\{u\}u^{-s-1}\,du$, so its only pole in this half-plane is simple and at $1$.

If $\chi$ is real and $L(1,\chi)=0$, the product $F(s)=\zeta(s)L(s,\chi)$ is holomorphic in $\Re s>0$. Its Dirichlet series in $\Re s>1$ has coefficients $a_n=\sum_{d\mid n}\chi(d)$. They are nonnegative by multiplicativity and the local sums $1+\chi(p)+\cdots+\chi(p)^j$, and $a_{m^2}\ge1$ for every $m\ge1$. For each $j\ge0$, differentiating the absolutely convergent series at $2$ gives $(-1)^j F^{(j)}(2)=\sum_n a_n(\ln n)^j/n^2$. The Taylor series at $2$ converges at $1/2$ since $F$ is holomorphic on $|s-2|<2$. Substituting those derivatives and interchanging the two nonnegative sums gives
\[
 F(1/2)=\sum_{j\ge0}\frac{(3/2)^j}{j!}
              \sum_{n\ge1}\frac{a_n(\ln n)^j}{n^2}
       =\sum_{n\ge1}\frac{a_n}{\sqrt n}.
\]
The squares already contribute the divergent harmonic series, a contradiction.

If $\chi$ is nonreal and $L(1,\chi)=0$, both $\chi$ and its distinct conjugate have zeros at $1$. The product over all characters modulo $D$ would then tend to zero as real $s\downarrow1$, since only the principal factor has a pole and it is simple. But for real $s>1$ the Euler products and orthogonality give
\[
 \prod_{\nu\bmod D} L(s,\nu)
 =\exp\left(\varphi(D)
       \sum_{\substack{p\ {\rm prime},\ j\ge1\\p^j\equiv1\bmod D}}
       \frac{p^{-js}}j\right)\ge1.
\]
This rules out a zero in the nonreal case as well.',
    body_html_cache = NULL,
    revision = 2,
    updated_at = '2026-11-27 16:00:00'
WHERE id = 130;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '130', 2, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 152, "body_tex": "For a modulus $D$ and a nonprincipal character $\\chi$ modulo $D$, the partial sums of $\\chi$ are bounded because a full-period sum is zero. Partial summation continues $L(s,\\chi)$ to the holomorphic function\n\\[\n s\\int_1^\\infty\\left(\\sum_{n\\le u}\\chi(n)\\right)u^{-s-1}\\,du\n \\qquad(\\Re s>0).\n\\]\nThe principal $L$-function is $\\zeta(s)\\prod_{p\\mid D}(1-p^{-s})$. For $\\zeta$ the same integral starts with $\\lfloor u\\rfloor=u-\\{u\\}$ and gives\n$\\zeta(s)=s/(s-1)-s\\int_1^\\infty\\{u\\}u^{-s-1}\\,du$, so its only pole in this half-plane is simple and at $1$.\n\nIf $\\chi$ is real and $L(1,\\chi)=0$, the product $F(s)=\\zeta(s)L(s,\\chi)$ is holomorphic in $\\Re s>0$. Its Dirichlet series in $\\Re s>1$ has coefficients $a_n=\\sum_{d\\mid n}\\chi(d)$. They are nonnegative by multiplicativity and the local sums $1+\\chi(p)+\\cdots+\\chi(p)^j$, and $a_{m^2}\\ge1$ for every $m\\ge1$. For each $j\\ge0$, differentiating the absolutely convergent series at $2$ gives $(-1)^j F^{(j)}(2)=\\sum_n a_n(\\ln n)^j/n^2$. The Taylor series at $2$ converges at $1/2$ since $F$ is holomorphic on $|s-2|<2$. Substituting those derivatives and interchanging the two nonnegative sums gives\n\\[\n F(1/2)=\\sum_{j\\ge0}\\frac{(3/2)^j}{j!}\n              \\sum_{n\\ge1}\\frac{a_n(\\ln n)^j}{n^2}\n       =\\sum_{n\\ge1}\\frac{a_n}{\\sqrt n}.\n\\]\nThe squares already contribute the divergent harmonic series, a contradiction.\n\nIf $\\chi$ is nonreal and $L(1,\\chi)=0$, both $\\chi$ and its distinct conjugate have zeros at $1$. The product over all characters modulo $D$ would then tend to zero as real $s\\downarrow1$, since only the principal factor has a pole and it is simple. But for real $s>1$ the Euler products and orthogonality give\n\\[\n \\prod_{\\nu\\bmod D} L(s,\\nu)\n =\\exp\\left(\\varphi(D)\n       \\sum_{\\substack{p\\ {\\rm prime},\\ j\\ge1\\\\p^j\\equiv1\\bmod D}}\n       \\frac{p^{-js}}j\\right)\\ge1.\n\\]\nThis rules out a zero in the nonreal case as well.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

UPDATE proofs
SET body_tex = 'The arithmetic argument is outlined in \ref{8JV5} under the inputs of \ref{C4S2}, which also specifies $\varepsilon_0(\psi)$. Apply \ref{8JUF} with requested lower bound $\max(Y_0,x_{\rm aux}(\psi,\varepsilon))$. Its data meet \ref{8JU7} and \ref{8JVE} at each point, and its bound $20x^{1/2+61\varepsilon/8}$ is at most $20x^{1/2+\eta}$ since $x\ge3$.',
    body_html_cache = NULL,
    revision = 3,
    updated_at = '2026-11-27 16:00:00'
WHERE id = 135;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '135', 3, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 164, "body_tex": "The arithmetic argument is outlined in \\ref{8JV5} under the inputs of \\ref{C4S2}, which also specifies $\\varepsilon_0(\\psi)$. Apply \\ref{8JUF} with requested lower bound $\\max(Y_0,x_{\\rm aux}(\\psi,\\varepsilon))$. Its data meet \\ref{8JU7} and \\ref{8JVE} at each point, and its bound $20x^{1/2+61\\varepsilon/8}$ is at most $20x^{1/2+\\eta}$ since $x\\ge3$.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

UPDATE proofs
SET body_tex = '\emph{(i) Conductors and the large cutoffs.}
The projection of $A$ onto the units modulo $2^{e+2}$ up to sign is onto, so $2^e\le n$. Consequently $N_1\le 4N_0n$. Every $\xi^*$ has conductor $D\mid N_1qd$ by \ref{8JVQ}. Using $Y_{\rm base}\le x$, the prime sizes in \ref{8JU7}(a) give
\[
 \ln(3D)\le C_D(\psi)x^{\varepsilon/5}(\ln x)^2
\]
for a constant $C_D(\psi)>0$.

A real character on a $2$-power modulus factors modulo $8$. For any modulus $2^a$ with $a\ge3$, the units that are $1\bmod8$ are exactly the subgroup of squares, generated by $5^2$, using the order computation in \ref{C3T2}. A real character is trivial on these squares. The same conductor bound is immediate for smaller exponents. By the Chinese remainder theorem, a real primitive character of conductor dividing $N_1qd$ is therefore a product of a real primitive character of conductor dividing $8N_0$ and zero, one or two of the Legendre factors at $q,d$. When a Legendre factor occurs, \ref{8JU7}(b) excludes a real zero in $(1-1/400,1)$. Without either factor, the character comes from a fixed finite family. By \ref{8JUV} and isolated zeros there is $\kappa=\kappa(\psi)>0$, which we take at most $1/400$, excluding real zeros in $(1-\kappa,1)$ for the whole family of real nonprincipal characters. For $\mathbf1$ one can apply the region of \ref{8JU7} to the principal character modulo $2$, since its Euler factor $1-2^{-s}$ is nonzero for $\Re s>0$.

Put $v=\ln y$, $H=\exp(\sqrt v)$ and
\[
 a=1+1/v,\qquad
 \lambda=\frac{\min(\kappa,1/13)}{\ln(6D(H+5))}.
\]
The zero-free region and the exclusion of the real exception give the hypothesis of \ref{C3R2}. We may take $x_{\rm aux}$ so that $v\ge \tfrac12 x^{\varepsilon/3}\ge1$ throughout $y\ge X''/3$. Increase it so that the conductor bound gives $\ln(3D)\le v^{61/100}$ uniformly there. This is possible since $v^{61/100}\ge 2^{-61/100}x^{61\varepsilon/300}$ and $61/300>1/5$. The logarithm in $\lambda$ is then $O(v^{61/100})$. Hence $\lambda v\gg_\psi v^{39/100}$, and all the prefactors in \ref{C3R2} are bounded by a fixed power of $v$ with a constant depending only on $\psi$. The estimate gives
\[
 \frac{|G_{\xi^*}(y)|}{y}
 \ll_\psi v^{C}\exp(-c_\psi v^{39/100})
 \le \exp(-x^{\varepsilon/8})
\]
for fixed $C,c_\psi>0$ after increasing $x_{\rm aux}$, since $v^{39/100}\gg x^{13\varepsilon/100}$ and $13/100>1/8$. The bound $f=2n\le4x^{9/4}$ gives $2f(x+1)\exp(-x^{\varepsilon/8})\le1/x$ by one further increase of $x_{\rm aux}$.

\emph{(ii) The twists at scale $x$.}
By \ref{8JUW}, a character indexing $\Sigma(x)$ is trivial on $A_0$. Its part on $A/A_0$ is a power of $\psi_A$, whose inducing primitive character has conductor dividing $N_0$. By the Chinese remainder theorem its primitive representative is the product of that primitive character and the Legendre factors from the two quadratic coordinates in \ref{8JVP}. The condition that it is outside $\mathcal C_\psi$ is equivalent to at least one such factor being present, since that factor forces the corresponding new prime into the conductor. This proves the applicability of \ref{8JU7}(c).

For the logarithmic derivative, let $Q=8N_0\exp(z+jz'')$ be its box height in \ref{8JU7}(b), where $j$ is the exponent of the factor at $d$. Use the estimate for $t(w)$ proved in \ref{8JU7} at $w=(\ln Q)^{6400}$. There is an absolute $Q_0\ge4$ from which $w\ge2$ and the resulting $t(w)$ is bounded by an absolute constant. Indeed $(\ln Q)w^{-1/1600}=(\ln Q)^{-3}$, and the other terms tend to zero. Thus \ref{HPW7} and partial summation give
\[
 \left|\frac{L''(1,\xi^*)}{L(1,\xi^*)}\right|
 \ll 1+\ln w=1+6400\ln\ln Q \qquad(Q\ge Q_0).
\]
For $Q<Q_0$ there are only finitely many primitive characters of conductor at most $Q_0$, with nonzero values at $1$ for the nonprincipal characters under consideration. Their logarithmic derivatives have a finite maximum. Finally $\ln Q\le \ln(8N_0)+x^{\varepsilon/5}(1+(\ln x)^2)$, so both bounds are at most $C_{\rm twist}(\psi,\varepsilon)\ln(x+1)$ with a constant independent of $J$, the base and $x$.',
    body_html_cache = NULL,
    revision = 3,
    updated_at = '2026-11-27 16:00:00'
WHERE id = 136;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '136', 3, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 165, "body_tex": "\\emph{(i) Conductors and the large cutoffs.}\nThe projection of $A$ onto the units modulo $2^{e+2}$ up to sign is onto, so $2^e\\le n$. Consequently $N_1\\le 4N_0n$. Every $\\xi^*$ has conductor $D\\mid N_1qd$ by \\ref{8JVQ}. Using $Y_{\\rm base}\\le x$, the prime sizes in \\ref{8JU7}(a) give\n\\[\n \\ln(3D)\\le C_D(\\psi)x^{\\varepsilon/5}(\\ln x)^2\n\\]\nfor a constant $C_D(\\psi)>0$.\n\nA real character on a $2$-power modulus factors modulo $8$. For any modulus $2^a$ with $a\\ge3$, the units that are $1\\bmod8$ are exactly the subgroup of squares, generated by $5^2$, using the order computation in \\ref{C3T2}. A real character is trivial on these squares. The same conductor bound is immediate for smaller exponents. By the Chinese remainder theorem, a real primitive character of conductor dividing $N_1qd$ is therefore a product of a real primitive character of conductor dividing $8N_0$ and zero, one or two of the Legendre factors at $q,d$. When a Legendre factor occurs, \\ref{8JU7}(b) excludes a real zero in $(1-1/400,1)$. Without either factor, the character comes from a fixed finite family. By \\ref{8JUV} and isolated zeros there is $\\kappa=\\kappa(\\psi)>0$, which we take at most $1/400$, excluding real zeros in $(1-\\kappa,1)$ for the whole family of real nonprincipal characters. For $\\mathbf1$ one can apply the region of \\ref{8JU7} to the principal character modulo $2$, since its Euler factor $1-2^{-s}$ is nonzero for $\\Re s>0$.\n\nPut $v=\\ln y$, $H=\\exp(\\sqrt v)$ and\n\\[\n a=1+1/v,\\qquad\n \\lambda=\\frac{\\min(\\kappa,1/13)}{\\ln(6D(H+5))}.\n\\]\nThe zero-free region and the exclusion of the real exception give the hypothesis of \\ref{C3R2}. We may take $x_{\\rm aux}$ so that $v\\ge \\tfrac12 x^{\\varepsilon/3}\\ge1$ throughout $y\\ge X''/3$. Increase it so that the conductor bound gives $\\ln(3D)\\le v^{61/100}$ uniformly there. This is possible since $v^{61/100}\\ge 2^{-61/100}x^{61\\varepsilon/300}$ and $61/300>1/5$. The logarithm in $\\lambda$ is then $O(v^{61/100})$. Hence $\\lambda v\\gg_\\psi v^{39/100}$, and all the prefactors in \\ref{C3R2} are bounded by a fixed power of $v$ with a constant depending only on $\\psi$. The estimate gives\n\\[\n \\frac{|G_{\\xi^*}(y)|}{y}\n \\ll_\\psi v^{C}\\exp(-c_\\psi v^{39/100})\n \\le \\exp(-x^{\\varepsilon/8})\n\\]\nfor fixed $C,c_\\psi>0$ after increasing $x_{\\rm aux}$, since $v^{39/100}\\gg x^{13\\varepsilon/100}$ and $13/100>1/8$. The bound $f=2n\\le4x^{9/4}$ gives $2f(x+1)\\exp(-x^{\\varepsilon/8})\\le1/x$ by one further increase of $x_{\\rm aux}$.\n\n\\emph{(ii) The twists at scale $x$.}\nBy \\ref{8JUW}, a character indexing $\\Sigma(x)$ is trivial on $A_0$. Its part on $A/A_0$ is a power of $\\psi_A$, whose inducing primitive character has conductor dividing $N_0$. By the Chinese remainder theorem its primitive representative is the product of that primitive character and the Legendre factors from the two quadratic coordinates in \\ref{8JVP}. The condition that it is outside $\\mathcal C_\\psi$ is equivalent to at least one such factor being present, since that factor forces the corresponding new prime into the conductor. This proves the applicability of \\ref{8JU7}(c).\n\nFor the logarithmic derivative, let $Q=8N_0\\exp(z+jz'')$ be its box height in \\ref{8JU7}(b), where $j$ is the exponent of the factor at $d$. Use the estimate for $t(w)$ proved in \\ref{8JU7} at $w=(\\ln Q)^{6400}$. There is an absolute $Q_0\\ge4$ from which $w\\ge2$ and the resulting $t(w)$ is bounded by an absolute constant. Indeed $(\\ln Q)w^{-1/1600}=(\\ln Q)^{-3}$, and the other terms tend to zero. Thus \\ref{HPW7} and partial summation give\n\\[\n \\left|\\frac{L''(1,\\xi^*)}{L(1,\\xi^*)}\\right|\n \\ll 1+\\ln w=1+6400\\ln\\ln Q \\qquad(Q\\ge Q_0).\n\\]\nFor $Q<Q_0$ there are only finitely many primitive characters of conductor at most $Q_0$, with nonzero values at $1$ for the nonprincipal characters under consideration. Their logarithmic derivatives have a finite maximum. Finally $\\ln Q\\le \\ln(8N_0)+x^{\\varepsilon/5}(1+(\\ln x)^2)$, so both bounds are at most $C_{\\rm twist}(\\psi,\\varepsilon)\\ln(x+1)$ with a constant independent of $J$, the base and $x$.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

UPDATE proofs
SET body_tex = 'Fix $\psi$ and $0<\varepsilon<\varepsilon_0(\psi)$ from \ref{8JVG}, and set $\eta=61\varepsilon/8$. Write $o$ for the order of $\psi$. Use $x_{\rm cmp}(\psi,\varepsilon)$ from \ref{8JUD}. For a prescribed $Y_0\ge1$, apply \ref{8JVG} with the requested lower bound for $Y$ equal to
\[
\max\bigl(Y_0,x_{\rm cmp},(3o+28)^{8/(11\varepsilon)}\bigr).
\]
Apply \ref{8JUD} at each $x$ to the data supplied there by \ref{8JVG}. The lower bound $\delta_2\ge x^{-\varepsilon}$ in \ref{8JVE} gives
\[
\frac{4}{x\delta_2}\le4x^{\varepsilon-1}\le4x^{1/2+\varepsilon}.
\]
Thus the error in \ref{8JUD} is at most $(3o+8)x^{1/2+\varepsilon}$. Combining \ref{8JVG} and \ref{8JUD} now gives
\begin{align*}
\mathcal G_\psi(x)
&\le 20x^{1/2+61\varepsilon/8}+(3o+8)x^{1/2+\varepsilon}\\
&\le (3o+28)x^{1/2+61\varepsilon/8}.
\end{align*}
The difference $9\varepsilon-61\varepsilon/8$ is $11\varepsilon/8>0$. Our choice of starting point gives $x^{11\varepsilon/8}\ge3o+28$ throughout the window, so the last bound is at most $x^{1/2+9\varepsilon}$. More generally, choosing $61\varepsilon/8\le\eta$ gives the upper bound $O_{\psi,\eta}(x^{1/2+\eta})$ on arbitrarily distant windows.',
    body_html_cache = NULL,
    revision = 3,
    updated_at = '2026-11-27 16:00:00'
WHERE id = 137;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '137', 3, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 166, "body_tex": "Fix $\\psi$ and $0<\\varepsilon<\\varepsilon_0(\\psi)$ from \\ref{8JVG}, and set $\\eta=61\\varepsilon/8$. Write $o$ for the order of $\\psi$. Use $x_{\\rm cmp}(\\psi,\\varepsilon)$ from \\ref{8JUD}. For a prescribed $Y_0\\ge1$, apply \\ref{8JVG} with the requested lower bound for $Y$ equal to\n\\[\n\\max\\bigl(Y_0,x_{\\rm cmp},(3o+28)^{8/(11\\varepsilon)}\\bigr).\n\\]\nApply \\ref{8JUD} at each $x$ to the data supplied there by \\ref{8JVG}. The lower bound $\\delta_2\\ge x^{-\\varepsilon}$ in \\ref{8JVE} gives\n\\[\n\\frac{4}{x\\delta_2}\\le4x^{\\varepsilon-1}\\le4x^{1/2+\\varepsilon}.\n\\]\nThus the error in \\ref{8JUD} is at most $(3o+8)x^{1/2+\\varepsilon}$. Combining \\ref{8JVG} and \\ref{8JUD} now gives\n\\begin{align*}\n\\mathcal G_\\psi(x)\n&\\le 20x^{1/2+61\\varepsilon/8}+(3o+8)x^{1/2+\\varepsilon}\\\\\n&\\le (3o+28)x^{1/2+61\\varepsilon/8}.\n\\end{align*}\nThe difference $9\\varepsilon-61\\varepsilon/8$ is $11\\varepsilon/8>0$. Our choice of starting point gives $x^{11\\varepsilon/8}\\ge3o+28$ throughout the window, so the last bound is at most $x^{1/2+9\\varepsilon}$. More generally, choosing $61\\varepsilon/8\\le\\eta$ gives the upper bound $O_{\\psi,\\eta}(x^{1/2+\\eta})$ on arbitrarily distant windows.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

UPDATE proofs
SET result_id = 187,
    body_tex = 'The sequence of maps is the one in \cite[Sections 5.8 and 7, p.~54]{Adriazola}. The kernel of each step defines a map on automorphic forms by summation over the lattice classes at that level. The fixed rank increment is the number of copies of the auxiliary hermitian space added at each step, as in Section 18.1.

The scales $\upsilon_t$ are the integers in \cite[Definition 18.5]{Adriazola}. The admissible $T_2$ is the image of the integer set in Proposition 5.17 under multiplication by a generator of $A_0$, as in Section 5.8. Its density is part of the admissible arithmetic data of \ref{C4S2}. Proposition 18.7 gives a base value $b_1(\alpha)$ at each label for each $u$ and sets
\[
w_{u,j}(\alpha)=b_1(\alpha)+(j-\tfrac12)h_0,\qquad h_0=2\lceil x^{402}\rceil .
\]
These are the second family of archimedean parameters in Corollary 18.8, one function of the label per lift. At the labels in $\Phi_u$ the base values lie between $\lceil b\rceil$ and $\lceil b\rceil+W-1$, where $W$ is the number of roots of unity in the auxiliary field. Use $\rho_w=W+mh_0$.

Proposition 5.16 and Corollary 18.8 apply with $|A|\le2x^{9/4}$, $m\le2\sqrt x$ and $W\le32|A|^2$. These bounds follow from admissibility and are uniform in the window, the primes and the character. Since the proposition fixes the exponent of $h_0$ at $402$ here, its threshold depends only on $\varepsilon$. Denote the resulting uniform threshold by $x_{\rm wt}(\varepsilon)$. Increase it, still using only $\varepsilon$, to ensure $X''\ge3$ and the integer intervals in Definition 18.5 are nonempty. For those intervals, $k\le2x^{9/2+10\varepsilon}$ by Proposition 5.15(i), so both $xb/(kx^{13})$ and $b''/x^2$ eventually exceed $1$. Proposition 5.16(iii) gives $|\upsilon_t/b-x|\le1$, and (i)--(ii) with Corollary 18.8 give the weight bounds.',
    body_html_cache = NULL,
    revision = 3,
    updated_at = '2026-11-27 16:00:00'
WHERE id = 138;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '138', 3, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 187, "body_tex": "The sequence of maps is the one in \\cite[Sections 5.8 and 7, p.~54]{Adriazola}. The kernel of each step defines a map on automorphic forms by summation over the lattice classes at that level. The fixed rank increment is the number of copies of the auxiliary hermitian space added at each step, as in Section 18.1.\n\nThe scales $\\upsilon_t$ are the integers in \\cite[Definition 18.5]{Adriazola}. The admissible $T_2$ is the image of the integer set in Proposition 5.17 under multiplication by a generator of $A_0$, as in Section 5.8. Its density is part of the admissible arithmetic data of \\ref{C4S2}. Proposition 18.7 gives a base value $b_1(\\alpha)$ at each label for each $u$ and sets\n\\[\nw_{u,j}(\\alpha)=b_1(\\alpha)+(j-\\tfrac12)h_0,\\qquad h_0=2\\lceil x^{402}\\rceil .\n\\]\nThese are the second family of archimedean parameters in Corollary 18.8, one function of the label per lift. At the labels in $\\Phi_u$ the base values lie between $\\lceil b\\rceil$ and $\\lceil b\\rceil+W-1$, where $W$ is the number of roots of unity in the auxiliary field. Use $\\rho_w=W+mh_0$.\n\nProposition 5.16 and Corollary 18.8 apply with $|A|\\le2x^{9/4}$, $m\\le2\\sqrt x$ and $W\\le32|A|^2$. These bounds follow from admissibility and are uniform in the window, the primes and the character. Since the proposition fixes the exponent of $h_0$ at $402$ here, its threshold depends only on $\\varepsilon$. Denote the resulting uniform threshold by $x_{\\rm wt}(\\varepsilon)$. Increase it, still using only $\\varepsilon$, to ensure $X''\\ge3$ and the integer intervals in Definition 18.5 are nonempty. For those intervals, $k\\le2x^{9/2+10\\varepsilon}$ by Proposition 5.15(i), so both $xb/(kx^{13})$ and $b''/x^2$ eventually exceed $1$. Proposition 5.16(iii) gives $|\\upsilon_t/b-x|\\le1$, and (i)--(ii) with Corollary 18.8 give the weight bounds.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

INSERT INTO proofs (id, result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail, generation_run_id, reviewed_by, review_notes, visibility, revision, created_at, updated_at, created_by, updated_by)
VALUES (149, 184, 1, 'Put $F(s)=L(s,\chi)$ for $\chi\ne\mathbf1$ and $F(s)=(s-1)\zeta(s)$ for $\chi=\mathbf1$. For $|t|\le H$, the disk of center $2+it$ and radius $1+3\lambda/4$ is zero-free for $F$. On this disk $\ln|F(s)|\ll\ln(3D(H+4))$. Indeed, in $\Re s>0$ a nonprincipal character gives $L(s,\chi)=s\int_1^\infty(\sum_{n\le u}\chi(n))u^{-s-1}\,du$, and the inner sum has modulus at most $D$ by periodicity and the vanishing of a full-period sum. The corresponding formula for $\zeta$ follows from $\lfloor u\rfloor=u-\{u\}$ in the same integral and gives $F(s)=s-s(s-1)\int_1^\infty\{u\}u^{-s-1}\,du$. At the center the absolutely convergent Euler product gives $|F(2+it)|\ge\prod_p(1+p^{-2})^{-1}>0$.

On the disk choose the logarithm $g(s)=\ln(F(s)/F(2+it))$ with value zero at the center. If $\Re g\le K$, with $K\ll\ln(3D(H+4))$ chosen positive, then $g/(2K-g)$ maps the disk into the closed unit disk and vanishes at its center. Schwarz''s lemma bounds $|g|$ by $2Kr/(R-r)$ on the disk of radius $r<R=1+3\lambda/4$. Take $r=1+5\lambda/8$ and apply Cauchy''s derivative estimate on circles of radius $\lambda/8$ around points with $1-\lambda/2\le\Re s\le2$ and $\Im s=t$. This gives $|F''/F(s)|\ll\lambda^{-2}\ln(3D(H+4))$ there.

The integral of $z^s/(s(s-1))$ on $\Re s=a$, divided by $2\pi i$, is $(z-1)_+$ for $z>0$. Close to the left for $z>1$ and sum the residues at $0$ and $1$. Close to the right for $z<1$ and use continuity for $z=1$. Expanding $-L''/L$ on this line then gives the ramp sum as
\[
\frac{1}{2\pi i}\int_{\Re s=a}
    -\frac{L''}{L}(s,\chi)\frac{y^s}{s(s-1)}\,ds .
\]
Move the segment of height $H$ to $\Re s=1-\lambda/2$. The residue at $1$ is $-yL''(1,\chi)/L(1,\chi)$ for a nonprincipal character. For $\mathbf1$, the integral for $\zeta$ gives $\zeta(s)=(s-1)^{-1}+\gamma+O(|s-1|)$, since
$\int_1^m\{u\}u^{-2}\,du=1+\ln m-\sum_{n=1}^m 1/n$ for integers $m\ge1$, by integrating on the unit intervals. Hence $-\zeta''/\zeta(s)=(s-1)^{-1}-\gamma+O(|s-1|)$, and the residue is $y(\ln y-1-\gamma)$. Subtracting the residue gives $G_\chi(y)$ in both cases.

On the three moved segments the bound for $F''/F$ also bounds $L''/L$ up to the additional term $1/(s-1)$ for $\mathbf1$. Its modulus there is at most $2/\lambda$. On the left segment the integral of $1/|s(s-1)|$ is $O(\ln(3/\lambda))$, by integrating $(\lambda+|t|)^{-1}$ for $|t|\le1$ and $|t|^{-2}$ for $|t|>1$. The horizontal integrals contribute $O(\lambda^{-2}\ln(3D(H+4))y^a/H^2)$. On the two tails of $\Re s=a$, use $|L''/L|\le\sum_{n\ge1}\Lambda(n)n^{-a}\ll1/(a-1)$ by partial summation and \ref{HPW7}. Their contribution is $O(y^a/((a-1)H))$.', NULL, 'ai_generated', 'gpt', 'Codex (GPT-6)', NULL, NULL, NULL, 'published', 1, '2026-11-27 16:00:00', '2026-11-27 16:00:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '149', 1, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 184, "body_tex": "Put $F(s)=L(s,\\chi)$ for $\\chi\\ne\\mathbf1$ and $F(s)=(s-1)\\zeta(s)$ for $\\chi=\\mathbf1$. For $|t|\\le H$, the disk of center $2+it$ and radius $1+3\\lambda/4$ is zero-free for $F$. On this disk $\\ln|F(s)|\\ll\\ln(3D(H+4))$. Indeed, in $\\Re s>0$ a nonprincipal character gives $L(s,\\chi)=s\\int_1^\\infty(\\sum_{n\\le u}\\chi(n))u^{-s-1}\\,du$, and the inner sum has modulus at most $D$ by periodicity and the vanishing of a full-period sum. The corresponding formula for $\\zeta$ follows from $\\lfloor u\\rfloor=u-\\{u\\}$ in the same integral and gives $F(s)=s-s(s-1)\\int_1^\\infty\\{u\\}u^{-s-1}\\,du$. At the center the absolutely convergent Euler product gives $|F(2+it)|\\ge\\prod_p(1+p^{-2})^{-1}>0$.\n\nOn the disk choose the logarithm $g(s)=\\ln(F(s)/F(2+it))$ with value zero at the center. If $\\Re g\\le K$, with $K\\ll\\ln(3D(H+4))$ chosen positive, then $g/(2K-g)$ maps the disk into the closed unit disk and vanishes at its center. Schwarz''s lemma bounds $|g|$ by $2Kr/(R-r)$ on the disk of radius $r<R=1+3\\lambda/4$. Take $r=1+5\\lambda/8$ and apply Cauchy''s derivative estimate on circles of radius $\\lambda/8$ around points with $1-\\lambda/2\\le\\Re s\\le2$ and $\\Im s=t$. This gives $|F''/F(s)|\\ll\\lambda^{-2}\\ln(3D(H+4))$ there.\n\nThe integral of $z^s/(s(s-1))$ on $\\Re s=a$, divided by $2\\pi i$, is $(z-1)_+$ for $z>0$. Close to the left for $z>1$ and sum the residues at $0$ and $1$. Close to the right for $z<1$ and use continuity for $z=1$. Expanding $-L''/L$ on this line then gives the ramp sum as\n\\[\n\\frac{1}{2\\pi i}\\int_{\\Re s=a}\n    -\\frac{L''}{L}(s,\\chi)\\frac{y^s}{s(s-1)}\\,ds .\n\\]\nMove the segment of height $H$ to $\\Re s=1-\\lambda/2$. The residue at $1$ is $-yL''(1,\\chi)/L(1,\\chi)$ for a nonprincipal character. For $\\mathbf1$, the integral for $\\zeta$ gives $\\zeta(s)=(s-1)^{-1}+\\gamma+O(|s-1|)$, since\n$\\int_1^m\\{u\\}u^{-2}\\,du=1+\\ln m-\\sum_{n=1}^m 1/n$ for integers $m\\ge1$, by integrating on the unit intervals. Hence $-\\zeta''/\\zeta(s)=(s-1)^{-1}-\\gamma+O(|s-1|)$, and the residue is $y(\\ln y-1-\\gamma)$. Subtracting the residue gives $G_\\chi(y)$ in both cases.\n\nOn the three moved segments the bound for $F''/F$ also bounds $L''/L$ up to the additional term $1/(s-1)$ for $\\mathbf1$. Its modulus there is at most $2/\\lambda$. On the left segment the integral of $1/|s(s-1)|$ is $O(\\ln(3/\\lambda))$, by integrating $(\\lambda+|t|)^{-1}$ for $|t|\\le1$ and $|t|^{-2}$ for $|t|>1$. The horizontal integrals contribute $O(\\lambda^{-2}\\ln(3D(H+4))y^a/H^2)$. On the two tails of $\\Re s=a$, use $|L''/L|\\le\\sum_{n\\ge1}\\Lambda(n)n^{-a}\\ll1/(a-1)$ by partial summation and \\ref{HPW7}. Their contribution is $O(y^a/((a-1)H))$.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex (GPT-6)", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

INSERT INTO proofs (id, result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail, generation_run_id, reviewed_by, review_notes, visibility, revision, created_at, updated_at, created_by, updated_by)
VALUES (150, 185, 1, 'In \ref{8JVC}, $A$ identifies with the image of the map from the units modulo $N_1$ to the product of the units modulo $2^{e+2}$ up to sign and $\mu_o$, given by reduction and $\psi$. Its first projection is onto the cyclic group of order $2^e$ generated by the class of $5$. Indeed for $r\ge0$ the exact power of $2$ dividing $5^{2^r}-1$ is $2^{r+2}$, by repeated squaring, and all powers of $5$ are $1\bmod4$. The kernel of this projection is the image under $\psi$ of the units congruent to $\pm1\bmod 2^{e+2}$. For $2^{e+2}$ divisible by the $2$-part of $N_0$, this image is fixed by the Chinese remainder theorem: the $2$-part of a unit in that kernel reduces to a sign at $N_0$, while the odd part is arbitrary. Thus $n=c2^e$ for a fixed divisor $c$ of $o$ once $e$ reaches the least value $e_0=e_0(\psi)$ satisfying that divisibility. Choose the least $e\ge e_0$ with $c2^e\ge x^{2+8\varepsilon}$, taking $x_{\rm col}$ so that $x^{2+8\varepsilon}\ge c2^{e_0}$ there. The projection to the cyclic factor is injective on $A_0$, since the second coordinate on $A_0$ is $1$. Hence $A_0$ is cyclic of order $n/o$.

For (i), put $r=\lfloor n x^{-\varepsilon/8}/(3o+1)\rfloor$. Choose $4r$ points from $A_0$ and $3r$ from each other coset. Every coset has $n/o$ points, and $4r\le n/o$ once $4o x^{-\varepsilon/8}\le 3o+1$. Also $r\ge n x^{-\varepsilon/8}/(2(3o+1))$ once $n x^{-\varepsilon/8}/(3o+1)\ge2$. Both conditions hold from a threshold depending only on $\psi,\varepsilon$ by the lower bound on $n$. The total is $(3o+1)r$, and division gives exactly the proportions of \ref{8JVA}.

For (ii), let $n_0=n/o$, $P=n_0/(4L)$ and $\ell=\ln(8L)$. Use the sphere construction of \cite[pp.~331--332]{Behrend1946} with the digits restricted to handle coefficients up to $L$. Set
\[
 D=\left\lfloor\sqrt{\frac{\ln P}{\ell}}\right\rfloor,\qquad
 B_0=\lfloor P^{1/D}\rfloor,\qquad g=\lfloor B_0/(2L)\rfloor .
\]
For all $x\ge x_{\rm col}$, increasing the threshold in terms of $\psi,\varepsilon,K$ if necessary, $D\ge4$ and $g\ge P^{1/D}/(8L)\ge2$, uniformly for $2\le L\le K\ln x$. These inequalities follow from $\ln P\asymp_{\psi,\varepsilon,K}\ln x$ and $\ell=O_K(\ln\ln x)$, which give $P^{1/D}\ge(8L)^2$ from the threshold. Among the $g^D$ vectors $v=(v_0,\ldots,v_{D-1})$ with $0\le v_j<g$, at most $Dg^2$ squared norms occur. Choose a sphere with at least $g^{D-2}/D$ vectors and encode them by $s(v)=\sum_j v_j B_0^j$. The codes are distinct integers less than $B_0^D\le P$.

If $j(s_2-s_1)=i(s_3-s_1)$, the signed coefficient of each power of $B_0$ in the difference is strictly between $-B_0$ and $B_0$, because $2L(g-1)<B_0$. Reduction modulo $B_0$ and division by $B_0$ show in turn that every signed coefficient is zero. The three vectors would then lie on a line and on a sphere, which has at most two points on that line. The modular claim follows because the absolute value of $j(s_2-s_1)-i(s_3-s_1)$ is less than $2LP=n_0/2$.

Finally,
\[
 \ln(g^{D-2}/D)\ge
 \ln P-\frac{2\ln P}{D}-D\ell-\ln D
 \ge \ln n_0-O\!\left(\sqrt{\ln P\,\ell}+\ln(4L)\right).
\]
The last error is $O_{\psi,\varepsilon,K}(\sqrt{\ln x\,\ln\ln x})=o(\ln x)$ uniformly in $L$. Increase $x_{\rm col}$ so that this error plus $\ln o$ is at most $\varepsilon\ln x$ for every $x\ge x_{\rm col}$. The injection $s\mapsto s a_0$ gives the required density.

For the progression assertions, if three terms with distinct indices in a block of length $L$ lie in a translate, subtract the first term from the other two and eliminate the step. The resulting relation in $A_0$ has coefficients the two index differences of magnitude less than $L$ and is impossible by the modular exclusion. The three points are distinct because the step has order greater than $4L$. For a step of order $r\le4L$, the difference between two points on its orbit is killed by $r$. If both points lie in a translate of $T_2$, this gives $n_0\mid r(s_1-s_2)$, while $|r(s_1-s_2)|< n_0$. Hence $s_1=s_2$.', NULL, 'ai_generated', 'gpt', 'Codex (GPT-6)', NULL, NULL, NULL, 'published', 1, '2026-11-27 16:00:00', '2026-11-27 16:00:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '150', 1, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 185, "body_tex": "In \\ref{8JVC}, $A$ identifies with the image of the map from the units modulo $N_1$ to the product of the units modulo $2^{e+2}$ up to sign and $\\mu_o$, given by reduction and $\\psi$. Its first projection is onto the cyclic group of order $2^e$ generated by the class of $5$. Indeed for $r\\ge0$ the exact power of $2$ dividing $5^{2^r}-1$ is $2^{r+2}$, by repeated squaring, and all powers of $5$ are $1\\bmod4$. The kernel of this projection is the image under $\\psi$ of the units congruent to $\\pm1\\bmod 2^{e+2}$. For $2^{e+2}$ divisible by the $2$-part of $N_0$, this image is fixed by the Chinese remainder theorem: the $2$-part of a unit in that kernel reduces to a sign at $N_0$, while the odd part is arbitrary. Thus $n=c2^e$ for a fixed divisor $c$ of $o$ once $e$ reaches the least value $e_0=e_0(\\psi)$ satisfying that divisibility. Choose the least $e\\ge e_0$ with $c2^e\\ge x^{2+8\\varepsilon}$, taking $x_{\\rm col}$ so that $x^{2+8\\varepsilon}\\ge c2^{e_0}$ there. The projection to the cyclic factor is injective on $A_0$, since the second coordinate on $A_0$ is $1$. Hence $A_0$ is cyclic of order $n/o$.\n\nFor (i), put $r=\\lfloor n x^{-\\varepsilon/8}/(3o+1)\\rfloor$. Choose $4r$ points from $A_0$ and $3r$ from each other coset. Every coset has $n/o$ points, and $4r\\le n/o$ once $4o x^{-\\varepsilon/8}\\le 3o+1$. Also $r\\ge n x^{-\\varepsilon/8}/(2(3o+1))$ once $n x^{-\\varepsilon/8}/(3o+1)\\ge2$. Both conditions hold from a threshold depending only on $\\psi,\\varepsilon$ by the lower bound on $n$. The total is $(3o+1)r$, and division gives exactly the proportions of \\ref{8JVA}.\n\nFor (ii), let $n_0=n/o$, $P=n_0/(4L)$ and $\\ell=\\ln(8L)$. Use the sphere construction of \\cite[pp.~331--332]{Behrend1946} with the digits restricted to handle coefficients up to $L$. Set\n\\[\n D=\\left\\lfloor\\sqrt{\\frac{\\ln P}{\\ell}}\\right\\rfloor,\\qquad\n B_0=\\lfloor P^{1/D}\\rfloor,\\qquad g=\\lfloor B_0/(2L)\\rfloor .\n\\]\nFor all $x\\ge x_{\\rm col}$, increasing the threshold in terms of $\\psi,\\varepsilon,K$ if necessary, $D\\ge4$ and $g\\ge P^{1/D}/(8L)\\ge2$, uniformly for $2\\le L\\le K\\ln x$. These inequalities follow from $\\ln P\\asymp_{\\psi,\\varepsilon,K}\\ln x$ and $\\ell=O_K(\\ln\\ln x)$, which give $P^{1/D}\\ge(8L)^2$ from the threshold. Among the $g^D$ vectors $v=(v_0,\\ldots,v_{D-1})$ with $0\\le v_j<g$, at most $Dg^2$ squared norms occur. Choose a sphere with at least $g^{D-2}/D$ vectors and encode them by $s(v)=\\sum_j v_j B_0^j$. The codes are distinct integers less than $B_0^D\\le P$.\n\nIf $j(s_2-s_1)=i(s_3-s_1)$, the signed coefficient of each power of $B_0$ in the difference is strictly between $-B_0$ and $B_0$, because $2L(g-1)<B_0$. Reduction modulo $B_0$ and division by $B_0$ show in turn that every signed coefficient is zero. The three vectors would then lie on a line and on a sphere, which has at most two points on that line. The modular claim follows because the absolute value of $j(s_2-s_1)-i(s_3-s_1)$ is less than $2LP=n_0/2$.\n\nFinally,\n\\[\n \\ln(g^{D-2}/D)\\ge\n \\ln P-\\frac{2\\ln P}{D}-D\\ell-\\ln D\n \\ge \\ln n_0-O\\!\\left(\\sqrt{\\ln P\\,\\ell}+\\ln(4L)\\right).\n\\]\nThe last error is $O_{\\psi,\\varepsilon,K}(\\sqrt{\\ln x\\,\\ln\\ln x})=o(\\ln x)$ uniformly in $L$. Increase $x_{\\rm col}$ so that this error plus $\\ln o$ is at most $\\varepsilon\\ln x$ for every $x\\ge x_{\\rm col}$. The injection $s\\mapsto s a_0$ gives the required density.\n\nFor the progression assertions, if three terms with distinct indices in a block of length $L$ lie in a translate, subtract the first term from the other two and eliminate the step. The resulting relation in $A_0$ has coefficients the two index differences of magnitude less than $L$ and is impossible by the modular exclusion. The three points are distinct because the step has order greater than $4L$. For a step of order $r\\le4L$, the difference between two points on its orbit is killed by $r$. If both points lie in a translate of $T_2$, this gives $n_0\\mid r(s_1-s_2)$, while $|r(s_1-s_2)|< n_0$. Hence $s_1=s_2$.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex (GPT-6)", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

INSERT INTO proofs (id, result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail, generation_run_id, reviewed_by, review_notes, visibility, revision, created_at, updated_at, created_by, updated_by)
VALUES (151, 186, 1, 'The field-existence and weighted cohomological bounds are the inputs of \cite[Hypothesis 17.11 and Propositions 18.3--18.4]{Adriazola}. Put $J=J(\psi,\varepsilon)$ from Proposition 18.4, and let $x_{\rm chain}$ be the chain-record threshold of Hypothesis 18.10, increased to at least $3$. Proposition 18.4 gives admissibility on windows arbitrarily far out with $Y_{\rm base}\le Y$ and $Y^2\le Y_{\rm base}^J$. In Proposition 18.3 the field input is applied to a tower parameter at $x/\kappa$ for a fixed $\kappa\ge1$. If the cohomological interval starts at $W_0$, choose $Y=\kappa W_0$ and take $W_0\ge\kappa^3$. Then both $x$ and $x/\kappa$ belong to $[W_0,W_0^2]$ for $x\in[Y,Y^{3/2}]$. From the threshold in Proposition 18.3, $(x/\kappa)^{401}\ge x^{400}$, which supplies the required twist range after rescaling.

Above $x_{\rm chain}$, Hypothesis 18.10 supplies admissible data and weights with chain records at each point of this window, using the same $J$ and base. Definition 18.1 uses Theorems 5.10 and 5.12 at $Y_{\rm base}$ with initial conductor modulus $8N_0$ in our notation. Their box and prime-sum conditions are exactly those of \ref{8JU7} used in the Fourier argument. The exponent condition gives $Y_{\rm base}\le x\le Y_{\rm base}^J$, and the tower bound implies $n\le2x^{9/4}$. The admissible sets satisfy the stated bounds by \cite[Definition 6.1(D3)--(D4), Lemma 5.18 and Propositions 5.17 and 5.20]{Adriazola}. Those conditions include the orbit restrictions on $T$ needed in the lattice argument. The chain-record constants depend on $\psi,\varepsilon,J$. Since $J$ is fixed once $\psi,\varepsilon$ are fixed, the threshold and those constants are uniform in the window and its points.', NULL, 'ai_generated', 'gpt', 'Codex (GPT-6)', NULL, NULL, NULL, 'published', 1, '2026-11-27 16:00:00', '2026-11-27 16:00:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '151', 1, '2503743b-4b31-43ea-90a5-e722b4987310', '{"result_id": 186, "body_tex": "The field-existence and weighted cohomological bounds are the inputs of \\cite[Hypothesis 17.11 and Propositions 18.3--18.4]{Adriazola}. Put $J=J(\\psi,\\varepsilon)$ from Proposition 18.4, and let $x_{\\rm chain}$ be the chain-record threshold of Hypothesis 18.10, increased to at least $3$. Proposition 18.4 gives admissibility on windows arbitrarily far out with $Y_{\\rm base}\\le Y$ and $Y^2\\le Y_{\\rm base}^J$. In Proposition 18.3 the field input is applied to a tower parameter at $x/\\kappa$ for a fixed $\\kappa\\ge1$. If the cohomological interval starts at $W_0$, choose $Y=\\kappa W_0$ and take $W_0\\ge\\kappa^3$. Then both $x$ and $x/\\kappa$ belong to $[W_0,W_0^2]$ for $x\\in[Y,Y^{3/2}]$. From the threshold in Proposition 18.3, $(x/\\kappa)^{401}\\ge x^{400}$, which supplies the required twist range after rescaling.\n\nAbove $x_{\\rm chain}$, Hypothesis 18.10 supplies admissible data and weights with chain records at each point of this window, using the same $J$ and base. Definition 18.1 uses Theorems 5.10 and 5.12 at $Y_{\\rm base}$ with initial conductor modulus $8N_0$ in our notation. Their box and prime-sum conditions are exactly those of \\ref{8JU7} used in the Fourier argument. The exponent condition gives $Y_{\\rm base}\\le x\\le Y_{\\rm base}^J$, and the tower bound implies $n\\le2x^{9/4}$. The admissible sets satisfy the stated bounds by \\cite[Definition 6.1(D3)--(D4), Lemma 5.18 and Propositions 5.17 and 5.20]{Adriazola}. Those conditions include the orbit restrictions on $T$ needed in the lattice argument. The chain-record constants depend on $\\psi,\\varepsilon,J$. Since $J$ is fixed once $\\psi,\\varepsilon$ are fixed, the threshold and those constants are uniform in the window and its points.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex (GPT-6)", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 16:00:00');

UPDATE settings
SET value = '\bibitem{Outline} \emph{The Generalized Riemann Hypothesis for Dirichlet $L$-functions: from smoothed prime sums to zeros on the critical line}, AI-generated natural-language outline of the Lean proof, 21 November 2026.
\bibitem{Alpoge} L. Alpöge, \emph{Remark}, \url{https://alpo.ge/remark.pdf}.
\bibitem{Davenport} H. Davenport, \emph{Multiplicative Number Theory}, 3rd ed., Graduate Texts in Mathematics 74, Springer, 2000.
\bibitem{Adriazola} J. Adriazola, \emph{The Alpöge Proof of the Riemann Hypothesis}, Arizona State University, 2026.
\bibitem{Erdos1932} P. Erdős, \emph{Beweis eines Satzes von Tschebyschef}, Acta Sci. Math. (Szeged) 5 (1932), 194–198. \url{https://acta.bibl.u-szeged.hu/13396/}
\bibitem{Honda1968} T. Honda, \emph{Formal groups and zeta-functions}, Osaka J. Math. 5 (1968), 199–213. \url{https://ir.library.osaka-u.ac.jp/repo/ouka/all/8997/}
\bibitem{McCurley1984} K. S. McCurley, \emph{Explicit zero-free regions for Dirichlet $L$-functions}, J. Number Theory 19 (1984), 7–32. \url{https://doi.org/10.1016/0022-314X(84)90089-1}
\bibitem{BennettEtAl2018} M. A. Bennett, G. Martin, K. O''Bryant and A. Rechnitzer, \emph{Explicit bounds for primes in arithmetic progressions}, Illinois J. Math. 62 (2018), 427–532. \url{https://arxiv.org/abs/1802.00085}
\bibitem{ThornerZaman2024} J. Thorner and A. Zaman, \emph{Refinements to the prime number theorem for arithmetic progressions}, Math. Z. 306 (2024), article 54. \url{https://doi.org/10.1007/s00209-023-03414-3} (Theorem numbering as in \url{https://arxiv.org/abs/2108.10878v2}.)
\bibitem{Montgomery1971} H. L. Montgomery, \emph{Topics in Multiplicative Number Theory}, Lecture Notes in Math. 227, Springer, 1971. \url{https://doi.org/10.1007/BFb0060851}
\bibitem{Behrend1946} F. A. Behrend, \emph{On sets of integers which contain no three terms in arithmetical progression}, Proc. Natl. Acad. Sci. USA 32 (1946), 331–332. \url{https://doi.org/10.1073/pnas.32.12.331}
',
    revision = 10
WHERE key = 'bibliography';

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('setting', 'bibliography', 10, '2503743b-4b31-43ea-90a5-e722b4987310', '{"value": "\\bibitem{Outline} \\emph{The Generalized Riemann Hypothesis for Dirichlet $L$-functions: from smoothed prime sums to zeros on the critical line}, AI-generated natural-language outline of the Lean proof, 21 November 2026.\n\\bibitem{Alpoge} L. Alpöge, \\emph{Remark}, \\url{https://alpo.ge/remark.pdf}.\n\\bibitem{Davenport} H. Davenport, \\emph{Multiplicative Number Theory}, 3rd ed., Graduate Texts in Mathematics 74, Springer, 2000.\n\\bibitem{Adriazola} J. Adriazola, \\emph{The Alpöge Proof of the Riemann Hypothesis}, Arizona State University, 2026.\n\\bibitem{Erdos1932} P. Erdős, \\emph{Beweis eines Satzes von Tschebyschef}, Acta Sci. Math. (Szeged) 5 (1932), 194–198. \\url{https://acta.bibl.u-szeged.hu/13396/}\n\\bibitem{Honda1968} T. Honda, \\emph{Formal groups and zeta-functions}, Osaka J. Math. 5 (1968), 199–213. \\url{https://ir.library.osaka-u.ac.jp/repo/ouka/all/8997/}\n\\bibitem{McCurley1984} K. S. McCurley, \\emph{Explicit zero-free regions for Dirichlet $L$-functions}, J. Number Theory 19 (1984), 7–32. \\url{https://doi.org/10.1016/0022-314X(84)90089-1}\n\\bibitem{BennettEtAl2018} M. A. Bennett, G. Martin, K. O''Bryant and A. Rechnitzer, \\emph{Explicit bounds for primes in arithmetic progressions}, Illinois J. Math. 62 (2018), 427–532. \\url{https://arxiv.org/abs/1802.00085}\n\\bibitem{ThornerZaman2024} J. Thorner and A. Zaman, \\emph{Refinements to the prime number theorem for arithmetic progressions}, Math. Z. 306 (2024), article 54. \\url{https://doi.org/10.1007/s00209-023-03414-3} (Theorem numbering as in \\url{https://arxiv.org/abs/2108.10878v2}.)\n\\bibitem{Montgomery1971} H. L. Montgomery, \\emph{Topics in Multiplicative Number Theory}, Lecture Notes in Math. 227, Springer, 1971. \\url{https://doi.org/10.1007/BFb0060851}\n\\bibitem{Behrend1946} F. A. Behrend, \\emph{On sets of integers which contain no three terms in arithmetical progression}, Proc. Natl. Acad. Sci. USA 32 (1946), 331–332. \\url{https://doi.org/10.1073/pnas.32.12.331}\n"}', 'codex', '2026-11-27 16:00:00');

-- Rebuild every changed statement and proof edge. Section intros have no refs slots.

DELETE FROM refs WHERE source_result_id = 126 AND source_proof_id IS NULL;

DELETE FROM refs WHERE source_result_id = 127 AND source_proof_id IS NULL;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (127, NULL, 'C4S2');

DELETE FROM refs WHERE source_result_id = 129 AND source_proof_id IS NULL;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (129, NULL, 'C4S2'),
  (129, NULL, 'C4W2'),
  (129, NULL, '8JVE'),
  (129, NULL, '8JVF'),
  (129, NULL, '8JV2');

DELETE FROM refs WHERE source_result_id = 130 AND source_proof_id IS NULL;

DELETE FROM refs WHERE source_result_id = 131 AND source_proof_id IS NULL;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (131, NULL, '8JVP'),
  (131, NULL, '8JVQ'),
  (131, NULL, 'C4W2'),
  (131, NULL, '8JU9');

DELETE FROM refs WHERE source_result_id = 132 AND source_proof_id IS NULL;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (132, NULL, '8JVH'),
  (132, NULL, '8JVE'),
  (132, NULL, '8JVF');

DELETE FROM refs WHERE source_result_id = 134 AND source_proof_id IS NULL;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (134, NULL, 'C4S2'),
  (134, NULL, 'C4W2'),
  (134, NULL, '8JUA'),
  (134, NULL, '8JU7'),
  (134, NULL, '8JVE');

DELETE FROM refs WHERE source_result_id = 135 AND source_proof_id IS NULL;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (135, NULL, '8JUA'),
  (135, NULL, '8JVE');

DELETE FROM refs WHERE source_result_id = 153 AND source_proof_id IS NULL;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (153, NULL, '8JVE'),
  (153, NULL, '8JVQ'),
  (153, NULL, '8JVP'),
  (153, NULL, '8JG8');

DELETE FROM refs WHERE source_result_id = 154 AND source_proof_id IS NULL;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (154, NULL, '8JVE'),
  (154, NULL, '8JU9'),
  (154, NULL, 'C4W2');

DELETE FROM refs WHERE source_result_id = 162 AND source_proof_id IS NULL;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (162, NULL, '8JVC'),
  (162, NULL, '8JVP'),
  (162, NULL, '8JVA'),
  (162, NULL, '8JVK'),
  (162, NULL, '8JU7');

DELETE FROM refs WHERE source_result_id = 163 AND source_proof_id IS NULL;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (163, NULL, '8JVE'),
  (163, NULL, '8JVK'),
  (163, NULL, '8JU9');

DELETE FROM refs WHERE source_result_id = 164 AND source_proof_id IS NULL;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (164, NULL, '8JVH'),
  (164, NULL, '8JU7'),
  (164, NULL, '8JVE'),
  (164, NULL, '8JVK'),
  (164, NULL, '8JVF');

DELETE FROM refs WHERE source_result_id = 165 AND source_proof_id IS NULL;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (165, NULL, '8JVC'),
  (165, NULL, '8JVP'),
  (165, NULL, '8JU7'),
  (165, NULL, '8JVQ'),
  (165, NULL, '8JF7'),
  (165, NULL, '8JUW');

DELETE FROM refs WHERE source_result_id = 167 AND source_proof_id IS NULL;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (167, NULL, '8JVC'),
  (167, NULL, '8JVP');

DELETE FROM refs WHERE source_result_id = 184 AND source_proof_id IS NULL;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (184, NULL, '8JF7');

DELETE FROM refs WHERE source_result_id = 185 AND source_proof_id IS NULL;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (185, NULL, '8JVC'),
  (185, NULL, '8JVA');

DELETE FROM refs WHERE source_result_id = 186 AND source_proof_id IS NULL;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (186, NULL, '8JU7'),
  (186, NULL, '8JVE'),
  (186, NULL, '8JU8'),
  (186, NULL, '8JV2');

DELETE FROM refs WHERE source_result_id = 187 AND source_proof_id IS NULL;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (187, NULL, 'C4S2'),
  (187, NULL, '8JVK');

DELETE FROM refs WHERE source_proof_id = 112;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (126, 112, '8JUV'),
  (126, 112, 'HPW7'),
  (126, 112, 'C3R2'),
  (126, 112, '8JF7');

DELETE FROM refs WHERE source_proof_id = 113;

DELETE FROM refs WHERE source_proof_id = 114;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (129, 114, '8JUB'),
  (129, 114, 'C4W2'),
  (129, 114, '8JUC'),
  (129, 114, '8JU9'),
  (129, 114, 'C4S2'),
  (129, 114, '8JUG'),
  (129, 114, '8JVF');

DELETE FROM refs WHERE source_proof_id = 117;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (132, 117, '8JVD'),
  (132, 117, '8JVK'),
  (132, 117, '8JUE'),
  (132, 117, '8JVH'),
  (132, 117, '8JU9'),
  (132, 117, '8JVP'),
  (132, 117, '8JV9'),
  (132, 117, '8JUW'),
  (132, 117, '8JVC'),
  (132, 117, '8JG8'),
  (132, 117, '8JVA'),
  (132, 117, '8JS3');

DELETE FROM refs WHERE source_proof_id = 118;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (133, 118, 'HPW7'),
  (133, 118, '8JF7');

DELETE FROM refs WHERE source_proof_id = 119;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (134, 119, 'C4S2'),
  (134, 119, 'C4W2'),
  (134, 119, '8JVE'),
  (134, 119, '8JUA'),
  (134, 119, '8JUG');

DELETE FROM refs WHERE source_proof_id = 130;

DELETE FROM refs WHERE source_proof_id = 135;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (164, 135, '8JV5'),
  (164, 135, 'C4S2'),
  (164, 135, '8JUF'),
  (164, 135, '8JU7'),
  (164, 135, '8JVE');

DELETE FROM refs WHERE source_proof_id = 136;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (165, 136, '8JVQ'),
  (165, 136, '8JU7'),
  (165, 136, 'C3T2'),
  (165, 136, '8JUV'),
  (165, 136, 'C3R2'),
  (165, 136, '8JUW'),
  (165, 136, '8JVP'),
  (165, 136, 'HPW7');

DELETE FROM refs WHERE source_proof_id = 137;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (166, 137, '8JVG'),
  (166, 137, '8JUD'),
  (166, 137, '8JVE');

DELETE FROM refs WHERE source_proof_id = 138;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (187, 138, 'C4S2');

DELETE FROM refs WHERE source_proof_id = 149;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (184, 149, 'HPW7');

DELETE FROM refs WHERE source_proof_id = 150;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (185, 150, '8JVC'),
  (185, 150, '8JVA');

DELETE FROM refs WHERE source_proof_id = 151;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (186, 151, '8JU7');

UPDATE settings SET value = '1' WHERE key = 'needs_rebuild' AND value <> '1';
