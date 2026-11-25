# Chapter 2 error exponents

Added the listed definition `8JV2` (result 154, alias `error-exponents`) at the start of §2.1. It is Definition 2.1.1. The auxiliary-data lemma `8JU7` becomes Lemma 2.1.2, and the unlisted cohomological length lemma `8JU8` moves to position 3. The definition is linked from `8JU7`, its proof, and Proposition 2.2.2 (`8JUA`). The Adriazola bibliography entry is appended at revision 8, with a baseline snapshot at revision 7.

## Source verification

Adriazola defines the chain record in §18.3, Definition 18.9, pp. 274–275. The transcription below follows the notation of (K1) and (K4) on p. 275, including `\mathcal I` for the index loss. [*The Alpöge Proof of the Riemann Hypothesis*](../../docs/references/main.pdf)

```tex
% (K1)
S-\Gamma \le C_* N_T m b x^{e_L\varepsilon},
\qquad 0 \le \mathcal I \le C_* N_T m b x^{e_L\varepsilon}.

% (K4)
\mu_{\min}(R^\vee)=-\mu_{\max}(R),
\qquad s+\mu_{\max}(R)\le x^{C_H} b,
\qquad\text{and}
\begin{aligned}
\mu(R^\vee)+h_u-\mathcal L
&\le \sum_{t\in T}\bigl(m\operatorname{ph}(a_t)
     -m a_t\log\Omega-a_t\log T_u\bigr)\\
&\quad{}+C_* N_T a\Lambda_a
     +C_*m(B_0+N_c)x^{e_D\varepsilon},
\end{aligned}
% for each u in the word set \mathcal W.
```

Section 18.3, p. 274, defines $S$ by summing the left side of (3.10) with $a=a_t$ and $w=w_{u_0,j}$, over $t\in T$ and $1\le j\le m$, with $u_0\in A_0$ fixed. Equation (3.10), p. 14, counts weighted prime powers at the unramified inert primes and includes a separate ramified term at $d$. Section 12.1, pp. 106–107, writes the aggregate explicitly in (12.3). This is the sum of the counts in `8JU9` before subtracting their main terms. Definition 18.9 identifies $\Gamma$ as the total gain of the lifts at the inert primes and $\mathcal I$ as the index loss there. The book uses $I$ for $\mathcal I$.

The sizes in §5.8, (5.17), p. 35, and §18.3, (18.1), p. 274, give $b=\exp(x^\varepsilon)$, $N_T=|T|$, $N_2=|T_2|$, $B_0=2nmbx^\varepsilon$, and $N_c=N_2 k b x^{2\varepsilon}/n^2$. The book writes $N_T$ as $h$ and $N_2$ as $h_2$, the number of large weights per level. The $e_D$-dependent term in (K4) is the local arithmetic contribution $C_*m(B_0+N_c)x^{e_D\varepsilon}$, alongside the separate term $C_*N_Ta\Lambda_a$. Section 18.3, p. 277, links this bound to Theorem 15.19 and Theorem 17.37 on congruence defects at the twisted places.

Hypothesis 18.10, p. 276, gives the absolute exponents $e_D=2$ and $e_L=0$, with $C_*$ chosen before the scale and the window. Proposition 18.11, pp. 276–277, obtains $e_D=1$ and $e_L=0$ under its listed assumptions and relaxes $e_D$ to 2 using $x^\varepsilon\le x^{2\varepsilon}$. Adriazola records Hypothesis 18.10 as unproved in that text on p. 277. The book cites it for the choice of exponents.

The cross-check uses $C_{\rm abs}=e_D$ for the pairing error and $e_L$ for the losses in §III.11, (H1), (H7), and Lemma M8. [*zeta-paper_v2.pdf*](../../docs/references/zeta-paper_v2.pdf)

## Checks

```text
node implement_plan/tasks/2026-11-25-ch2-error-exponents.check.mjs scripts/ch2-error-exponents-2026-11-25.sql
Source database: C:\Users\bbh8149\xiaoxiang_zhou\structured\github\math_sketchbook\.wrangler\state\v3\d1\miniflare-D1DatabaseObject\feb98e23e8d07ed53c02acad60b7af51cee41722a632c769f200a9b7c2d3ca7f.sqlite
Section 1.2 and the previous Chapter 2 patch are present.
SQL applied to a temporary database copy.
Second application rejected by write_guard before any rows were written.
Rows outside the patch verified.
Revision snapshots, baseline history, metadata, caches and bibliography append verified.
Section 2.1 — A common interval for the auxiliary data (id 106)
position	id	tag	type	listed	label	title
1	154	8JV2	definition	1	Definition 2.1.1	The error exponents $e_D$ and $e_L$
2	126	8JU7	lemma	1	Lemma 2.1.2	Simultaneous choice of auxiliary data
3	127	8JU8	lemma	0	Lemma	The cohomological length bound
Section 2.2 — From theta lifts to a prime-power count (id 107)
position	id	tag	type	listed	label	title
1	128	8JU9	definition	1	Definition 2.2.1	The weighted prime-power count
2	129	8JUA	proposition	1	Proposition 2.2.2	A bound for each translate
3	130	8JUB	lemma	0	Lemma	Rank from the period matrices
4	131	8JUC	lemma	0	Lemma	Matching the main terms
renderTex warnings: 0 across 6 sources.
Reference sets match, all rendered targets exist, and both citations resolve.
Rendered HTML: C:\Users\bbh8149\AppData\Local\Temp\ch2-error-exponents-37KThU\preview.html
ALL CHECKS PASSED
```

- `npm test` passed all 24 tests.
- The round 2 checker printed `ALL CHECKS PASSED` in each historical setup. These were the backup before §1.2, the same backup with §1.2 applied by the checker, and a temporary copy with §1.2 staged before running the checker. With the current database as its default source, the old checker exited at `write_guard` because round 2 was already present.
- The three new displays measured 148.6 pt, 200.8 pt, and 193.4 pt in 10 pt display math with pdfLaTeX. At the preview's configured math font size, the largest converts to approximately 438 px for the 680 px column. Headless Chrome did not return a layout measurement in this environment.

## Scope

Round 3 was implemented as specified. The new definition uses the book's notation and displays only the terms that involve the two exponents. The migration was applied to temporary copies for testing.

## TeX sources

### 8JV2 title and statement

```tex
The error exponents $e_D$ and $e_L$

For a chain of $m$ theta lifts at scale $x$ with parameter $\varepsilon>0$ and translates $t\in T$, put $h=|T|$, $n=|A|$, and $b=\exp(x^\varepsilon)$. Let $h_2$ be the number of large weights per level and $k$ the parameter controlling the rank error. Put
$$
B_0=2nmbx^\varepsilon,\qquad N_c=\frac{h_2 k b x^{2\varepsilon}}{n^2}.
$$
For $u_0\in A_0$, let $S$ be the sum of the \hyperref[8JU9]{weighted prime-power counts} over $t\in T$ and the $m$ levels, with the weights for $u_0$. Let $\Gamma$ be the total divisibility gain of the lifts at the inert primes and $I$ the index loss there.

The nonnegative numbers $e_D,e_L$ are error exponents if there is a constant $C>0$, independent of $x$, such that at every scale of the construction and for every $u_0\in A_0$,
$$
S-\Gamma\leqslant C\,hmb\,x^{e_L\varepsilon},
\qquad 0\leqslant I\leqslant C\,hmb\,x^{e_L\varepsilon},
$$
and the slope and height comparison satisfies
$$
\text{local arithmetic error}\leqslant C\,m(B_0+N_c)\,x^{e_D\varepsilon}.
$$
See \cite[Definition 18.9]{Adriazola}.
```

### 8JU7 statement

```tex
For the fixed $\psi$ there is $\varepsilon_0>0$ such that for every $0<\varepsilon<\varepsilon_0$ and every $Y_0\ge 1$, the construction of \cite[Sections 3 and 9--11]{Outline} gives real $Y\ge Y_0$ and auxiliary primes $q,d$ for all real $x\in[Y,Y^{3/2}]$. At each such $x$, the field, translates, and integral theta-lift data can be chosen with \hyperref[8JV2]{error exponents} $e_D=2$ and $e_L=0$. The translates satisfy, for every $\alpha\in A$,
$$
\left|\frac{|T\cap(\alpha+A_0)|}{|T|}-\lambda_\alpha\right|
\le x^{-1+\varepsilon},
\qquad \lambda_\alpha=\frac{3+\mathbf 1_{\alpha\in A_0}}{3o+1}.
$$
```

### 8JU7 proof (112)

```tex
\emph{Idea.} First choose the two auxiliary primes on a long range of scales. Then find a whole interval inside that range where the cohomological bound and the construction of the lifts can be used together.

\emph{(1)} \textbf{The varying quadratic twists can be made small simultaneously.} Choose $q$ and then $d$ in the prescribed residue classes. For each choice, zero-density and mean-square estimates bound the candidates that fail the zero-free condition or the smoothed-sum estimate. Taking the union over the finitely many characters at the fixed modulus still leaves admissible primes. The same pair works throughout the range of scales used in the field construction. Here the smoothed sums are those of twists involving $q$ or $d$.

\emph{(2)} \textbf{Cohomological lengths are controlled on a whole interval.} Once the primes are chosen, the field-existence theorem gives $[W,W^2]$ on which the \hyperref[8JU8]{weighted sum of cohomological lengths} is at most $\exp(x^\varepsilon/2)$ at each admissible scale $x$. The length bound is the input for the finite-place divisibility estimate. The translates come from a Behrend set in the cyclic direction of the tower. Excluding short three-term relations limits repeated intersections with short progressions. The construction distributes the translates among the cosets in the stated proportions.

\emph{(3)} \textbf{A fixed rescaling preserves a whole interval for all the inputs.} The local correspondence and theta-lift construction give common period data and the \hyperref[8JV2]{error exponents} $e_D,e_L$ of \cite[Hypothesis 18.10]{Adriazola}. To absorb the fixed factor in the tower parameter, the construction evaluates the cohomological data at $x/\kappa$ for a fixed $\kappa\ge 1$. For $Y=\kappa W$ and $W\ge\kappa^3$, the interval $[Y,Y^{3/2}]$ is contained in $[W,W^2]$, and $x/\kappa$ is also in $[W,W^2]$ throughout. The spare power in the cohomological cutoff in \cite[Section 11]{Outline} permits this rescaling. Taking the initial scale large enough gives $Y\ge Y_0$ and makes all the inequalities used below uniform throughout this interval.
```

### 8JUA statement

```tex
In the construction of \ref{8JU7}, let $m$ be the number of lifts, $a_t$ the scale belonging to $t\in T$, and $w_{u,j}$ the weights at the $j$-th level for $u\in A_0$. For every $u\in A_0$, define
$$
\Delta_u=\sum_{t\in T}\sum_{j=1}^m
 \left(S(t,a_t,w_{u,j})-\Re M(a_t,w_{u,j})\right).
$$
Put $n=|A|$, $h=|T|$ and $b=\exp(x^\varepsilon)$. Let $h_2$ be the number of large weights per level, $a_E$ the common size parameter in the level estimates, and $k$ the parameter controlling the rank error. With
$$
\mathcal B=h a_E\left(1+\frac{m^2}{k}\right)
+m\left(2nmbx^\varepsilon+\frac{h_2 k b x^{2\varepsilon}}{n^2}\right),
$$
there is a common error $E_{\rm err}\ge 0$ such that, for the \hyperref[8JV2]{error exponents} $e_D,e_L$ and every $u\in A_0$,
$$
\Delta_u\le E_{\rm err}\le x^{(e_D+e_L+3)\varepsilon}\mathcal B.
$$
```

### Bibliography setting (revision 8)

```tex
\bibitem{Outline} \emph{The Generalized Riemann Hypothesis for Dirichlet $L$-functions: from smoothed prime sums to zeros on the critical line}, AI-generated natural-language outline of the Lean proof, 21 November 2026.
\bibitem{Alpoge} L. Alpöge, \emph{Remark}, \url{https://alpo.ge/remark.pdf}.
\bibitem{Davenport} H. Davenport, \emph{Multiplicative Number Theory}, 3rd ed., Graduate Texts in Mathematics 74, Springer, 2000.
\bibitem{Adriazola} J. Adriazola, \emph{The Alpöge Proof of the Riemann Hypothesis}, Arizona State University, 2026.
```
