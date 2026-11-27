# Notation cleanup

The guarded batch updates 33 TeX rows across Chapters 2–3 and renames 8JVK in the same result update. It uses flat triples in $B$, names the uniform thresholds used in the weight, analytic and comparison lemmas, and identifies the theta lifts that index the weights.

## Notation changes

| Old | New |
|---|---|
| `\setminus` | `\smallsetminus` for set complements |
| Nested pairs in $B$ | $(e_1,e_2,v)$ with $v\in A$ |
| $F_p$, $F_{13}$ | $\vartheta_p$, $\vartheta_{13}$ |
| Positive scale $a=xb$, shifted scale $a_t$, logarithm $\Lambda_a$ | $\upsilon=xb$, $\upsilon_t$, $\Lambda_{\upsilon}$ |
| $w_g=w_{p_t(g)}$ | $w^t=w\circ p_t$, evaluated as $w^t(g)=w_{p_t(g)}$ |
| Weight $w_{u,j}(\alpha)$ at the label of $g$ in 8JUD | $w_{u,j}^t(g)=w_{u,j}(\alpha)$ with $\alpha=p_t(g)$ |

The count uses $S$, and the main-term symbol $M$ follows Chapter 1’s $M_\chi$.

## Rows touched

| Tag | Field | Row ID | Change |
|---|---|---:|---|
| 8JU7 | statement_tex | 126 | Common parameter cap, window and base, fixed primes, and admissibility |
| 8JU9 | statement_tex | 128 | Flat shift, renamed symbols, shifted weights, and explanations of the count and its main term |
| 8JUC | statement_tex | 131 | Shifted scale in the divisibility identity |
| 8JUD | statement_tex | 132 | Named comparison threshold |
| 8JUE | statement_tex | 133 | Scale in the smoothing bound |
| 8JUF | statement_tex | 134 | Common parameter cap and arithmetic threshold |
| 8JUW | statement_tex | 153 | Complement notation in the auxiliary-character sum |
| 8JV2 | statement_tex | 154 | Reference scale and logarithm subscript at each scale of the construction |
| 8JVD | statement_tex | 161 | Scale, shifted weights, and complement notation in the Fourier expansion |
| 8JVE | statement_tex | 162 | Shifted scale in the Fourier data |
| 8JVF | statement_tex | 163 | Shifted scale in the centered sum |
| 8JVG | statement_tex | 164 | Common cap and lower bound for the window |
| 8JVH | statement_tex | 165 | Named analytic threshold and fixed prime-selection range |
| 8JVK | statement_tex | 167 | Named weight threshold, theta lifts, flat weight labels, scale, and complement |
| 8JVK | title | 167 | Scales and weights for the theta lifts |
| 8JVM | statement_tex | 168 | Flat class and product coordinates in the modulo-840 example |
| 8JVP | statement_tex | 170 | Flat coordinates, counted coset, character, and indicator |
| 8JVQ | statement_tex | 171 | Prime class in the prime-power cosets |
| 8JU2 | intro_tex | 105 | Source of arbitrarily distant windows |
| 8JU3 | intro_tex | 106 | Flat product and source of the shift set |
| 8JU5 | intro_tex | 108 | Shifted scale and the source of the auxiliary prime choice |
| 8JV7 | intro_tex | 113 | Flat shift and coordinate order, prime class, scale, complements, and weight reference |
| 8JV8 | intro_tex | 114 | Window and weight sources, shifted scale, threshold, and lift index |
| 8JU7 | body_tex | 112 | Prime-selection range and source of the common parameter cap |
| 8JUA | body_tex | 114 | Shifted scale in the centered-count bound |
| 8JUC | body_tex | 116 | Shifted scale in the main-term identity |
| 8JUD | body_tex | 117 | Flat labels and quotient, shifted weights and scale, and comparison threshold |
| 8JUE | body_tex | 118 | Scale in the smoothing estimate |
| 8JUF | body_tex | 119 | Weight and arithmetic thresholds |
| 8JVD | body_tex | 134 | Prime class, scale, shifted weights, and exact main-term identity |
| 8JVG | body_tex | 135 | Lower bound for the window |
| 8JVH | body_tex | 136 | Uniform conductor and twist estimates |
| 8JVJ | body_tex | 137 | Named thresholds in the interval argument |
| 8JVK | body_tex | 138 | Source of the lifts and weights and uniform estimates |

## Flat triples by row

The translation explanation in 8JU9 also changes from the previous draft of the batch.

| Tag | Field | Old | New |
|---|---|---|---|
| 8JVP | `statement_tex` | `B=(\Z/2\Z)^2\times A` | `B=\Z/2\Z\times\Z/2\Z\times A` |
| 8JVP | `statement_tex` | `v\longmapsto((e_1(v),e_2(v)),[v]_A)` | `v\longmapsto(e_1(v),e_2(v),[v]_A)` |
| 8JVP | `statement_tex` | `\left\{((0,e_2),v)\in B \;\middle\|\; e_2\in\Z/2\Z,\ v\in A\right\}` | `\{0\}\times\Z/2\Z\times A` |
| 8JVP | `statement_tex` | `((e_1,e_2),v)&\longmapsto(-1)^{e_1}` | `(e_1,e_2,v)&\longmapsto(-1)^{e_1}` |
| 8JVP | `statement_tex` | `v&\longmapsto((0,0),v)` | `v&\longmapsto(0,0,v)` |
| 8JU9 | `statement_tex` | `g+((1,1),t)` | `g+(1,1,t)` |
| 8JU9 | `statement_tex` | `Translation by $((1,1),t)$ flips the first bit, so $p_t$ is a bijection.` | `Translation by $(1,1,t)$ changes the first bit from $1$ to $0$, so $p_t$ is a bijection.` |
| 8JVK | `statement_tex` | `\Phi_u=\left\{((0,1),z+u)\in\Phi \;\middle\|\; z\in T_2\right\}.` | `\Phi_u=\{(0,1,z+u):z\in T_2\}\subseteq\Phi.` |
| 8JUD | `body_tex` | `((0,1),z+u)` | `(0,1,z+u)` |
| 8JUD | `body_tex` | `g=((1,0),z+u-t)` | `g=(1,0,z+u-t)` |
| 8JUD | `body_tex` | `\xi((1,0),0)` | `\xi(1,0,0)` |
| 8JUD | `body_tex` | `B/A_0=(\Z/2\Z)^2\times(A/A_0)` | `B/A_0=\Z/2\Z\times\Z/2\Z\times(A/A_0)` |
| 8JVM | `statement_tex` | `B=(\Z/2\Z)^2\times A` | `B=\Z/2\Z\times\Z/2\Z\times A` |
| 8JVM | `statement_tex` | `\Phi=\{0\}\times(\Z/2\Z)\times A` | `\Phi=\{0\}\times\Z/2\Z\times A` |
| 8JVM | `statement_tex` | `F_{13}=((1,0),(1,1))` | `\vartheta_{13}=(1,0,(1,1))` |
| 8JU3 | `intro_tex` | `B=(\Z/2\Z)^2\times A` | `B=\Z/2\Z\times\Z/2\Z\times A` |
| 8JV7 | `intro_tex` | `sends a unit modulo $N=N_1qd$ to its class in $A$ and the two quadratic bits.` | `sends a unit modulo $N=N_1qd$ to its two quadratic bits followed by its class in $A$.` |
| 8JV7 | `intro_tex` | `adds $((1,1),t)$.` | `adds $(1,1,t)$.` |

The modulo-840 check gives $N_1=40$, $N=840$, $U_1=\{1,9,31,39\}$, $|A|=4$, $|B|=16$, and $|\Phi|=8$. The residues of $13$ modulo $7,3,8,5$ are $6,1,5,3$. They give the two quadratic bits $1,0$ and the class $(1,1)$ in $A$. Since $13\nmid840$, $I_{13}=\{0\}$ and $\xi_c(\vartheta_{13})=-1$, so the class condition selects odd powers.

## Set complement rows

The Chapter 2–3 scan found six fields with `\setminus`. The counted-coset definition and the Fourier proof introduce complements in two additional fields. The table counts the occurrences in the resulting TeX.

| Tag | Field | Complement | Replaced | Introduced |
|---|---|---|---:|---:|
| 8JU9 | statement_tex | `B\smallsetminus\Phi` | 1 | 2 |
| 8JUD | body_tex | `\Phi\smallsetminus\Phi_u` | 1 | 0 |
| 8JUW | statement_tex | `\mathcal H\smallsetminus\mathcal K` | 1 | 0 |
| 8JV7 | intro_tex | `B\smallsetminus\Phi` | 1 | 0 |
| 8JVD | statement_tex | `B\smallsetminus\Phi` | 1 | 0 |
| 8JVD | body_tex | `B\smallsetminus\Phi` | 0 | 1 |
| 8JVK | statement_tex | `\Phi\smallsetminus\Phi_u` | 1 | 0 |
| 8JVP | statement_tex | `B\smallsetminus\Phi` | 0 | 2 |

## Uniform thresholds and the theta lifts

### Reference checks and dependencies

- The database bibliography identifies `Adriazola` as Jimmie Adriazola’s *The Alpöge Proof of the Riemann Hypothesis*, in `docs/references/main.pdf`. The common $\varepsilon_0(\psi)$ is the $\varepsilon_1$ of Hypothesis 18.10 (p. 276), with $\varepsilon_1\le1/52$. Theorem A and its proof (pp. 42, 281) use that cap and fix $J$ from Proposition 18.4 for each $\psi,\varepsilon$. 8JU7 now records the scale $Y_{\rm base}$ at which the primes are chosen and the condition $Y^2\le Y_{\rm base}^J$ from Definition 18.1 and Proposition 18.4 (pp. 270–272). This gives a common prime-selection range for every $x$ in the window. The window and chain-record inputs in the source are Hypotheses 17.11 and 18.10. The companion outline in `docs/references/GRH-natural-language-outline.pdf`, §§11–14, gives the prime-selection range, the Fourier recovery and the four-error normalization used in the sketchbook.
- 8JVK uses the common $\varepsilon_0(\psi)$. The weight estimates themselves hold throughout $0<\varepsilon<1/52$. Proposition 5.16 (pp. 36–37) and Corollary 18.8 (pp. 273–274) bound $n$, $m$, and the number $W$ of roots of unity by fixed powers of $x$ and fix $h_0=2\lceil x^{402}\rceil$. The proof compares these polynomial bounds with $b$ and $b'$. Proposition 5.15 and Definition 18.5 (pp. 36, 272) also give a uniform polynomial bound for $k$ and the intervals for the integer scales. These estimates give the stronger dependence $x_{\rm wt}(\varepsilon)$.
- 8JVH uses $x_{\rm aux}(\psi,\varepsilon)$. Section 6.3 (pp. 43–44) bounds the conductors using $Y_{\rm base}\le x$ and treats the remaining real characters as a fixed-conductor family. The derivative bound in Theorems 5.10(ii) and 5.12(ii) uses the fixed $J(\psi,\varepsilon)$, which also sets the range for the bounds in part (iii). Proposition 5.16(iv) supplies the exponential absorption. 8JUD chooses $x_{\rm cmp}(\psi,\varepsilon)$ above both thresholds and absorbs its two logarithmic errors. 8JUF takes $x_{\rm arith}\ge x_{\rm wt}$. 8JVG raises its lower bound to include $x_{\rm aux}$, and 8JVJ uses the named $x_{\rm cmp}$, which already includes $x_{\rm wt}$ and $x_{\rm aux}$.
- Section 7 (p. 54) constructs each theta lift on automorphic forms for definite unitary groups by summing the step kernels over lattice classes. Sections 5.8 and 18.1 (pp. 36, 270) give the successive ranks and their fixed increment. Proposition 5.17 (pp. 37–38) supplies the integer set used to form $T_2$. Proposition 18.7 and Corollary 18.8 (pp. 273–274) identify $w_{u,j}(\alpha)=b_1(\alpha)+(j-\tfrac12)h_0$ as the second family of archimedean parameters, one function of the label for each lift and each $u$. This gives the description in 8JVK and the indexing in 8JV8.

### 8JU7 · `statement_tex`

Old

```latex
For every primitive $\psi$ there is $0<\varepsilon_0\le1/52$ such that for every $0<\varepsilon<\varepsilon_0$ and every $Y_0\ge3$ the construction gives real $Y\ge Y_0$ and auxiliary primes $q,d$ fixed on $[Y,Y^{3/2}]$. At each real $x$ in that window it gives the groups of \ref{8JVC} and \ref{8JVP}, a nonempty set $T\subseteq A$, and integral theta-lift data with \hyperref[8JV2]{error exponents} $e_D=2$ and $e_L=0$.
```

New

```latex
For each primitive $\psi$ there is $0<\varepsilon_0=\varepsilon_0(\psi)\le1/52$. For each $0<\varepsilon<\varepsilon_0$, fix the exponent $J=J(\psi,\varepsilon)\ge2$ of \cite[Proposition 18.4]{Adriazola}. For each $Y_0\ge3$ there exist a base $Y_{\rm base}\ge3$, a real $Y\ge Y_0$ with $Y_{\rm base}\le Y$ and $Y^2\le Y_{\rm base}^J$, and auxiliary primes $q,d$ fixed on $[Y,Y^{3/2}]$. The primes satisfy the conclusions of \cite[Theorems 5.10 and 5.12]{Adriazola} at $Y_{\rm base}$ with $K=J$ and $\tau=\varepsilon$. At each real $x$ in the window, admissible data in the sense of \cite[Definition 18.1]{Adriazola} give the groups of \ref{8JVC} and \ref{8JVP} and a nonempty set $T\subseteq A$. With these choices there are integral theta-lift data with \hyperref[8JV2]{error exponents} $e_D=2$ and $e_L=0$.
```

The statement also adds the source citations after the coset inequality.

```latex
For the window argument see \cite[Section 11]{Outline} and \cite[Proposition 18.4]{Adriazola}. For the coset proportions of $T$, see \cite[Lemma 5.18 and Proposition 5.20]{Adriazola}.
```

### 8JU7 · `body_tex`

Old

```latex
\emph{(1)} Choose $q$, then $d$, in the prescribed residue classes. Zero-density and mean-square estimates bound the candidates that fail the zero-free or smoothed-sum tests. Taking the union over the finitely many characters at the fixed modulus still leaves admissible primes. The same pair works throughout the range used in the field construction. See \cite[Theorems 5.10 and 5.12]{Adriazola} and \cite[Section 11]{Outline}.
```

New

```latex
\emph{(1)} Fix $J$ as in \cite[Proposition 18.4]{Adriazola} for this $\psi,\varepsilon$. Choose $q$, then $d$, at $Y_{\rm base}$ using \cite[Theorems 5.10 and 5.12]{Adriazola} with $K=J$ and $\tau=\varepsilon$. Zero-density and mean-square estimates bound the candidates that fail the zero-free or smoothed-sum tests. Taking the union over the finitely many characters at the fixed modulus still leaves admissible primes. The pair works on $[Y_{\rm base},Y_{\rm base}^J]$, which contains $[Y,Y^{3/2}]$ by $Y_{\rm base}\le Y$ and $Y^2\le Y_{\rm base}^J$. See also \cite[Section 11]{Outline}.
```

Old

```latex
The chain data at these scales use the local and global matching inputs and the exponents of \cite[Hypothesis 18.10]{Adriazola}. We take the initial threshold large enough for the weight estimates of \ref{8JVK} and the analytic estimates of \ref{8JVH}.
```

New

```latex
Take $\varepsilon_0(\psi)$ to be the bound $\varepsilon_1$ in \cite[Hypothesis 18.10]{Adriazola}. For the fixed $J$, the chain data at these scales use the threshold and exponents of that hypothesis, as in the proof of Theorem A in Section 18.6. Take $Y_{\rm base}$ large enough for prime selection and admissibility and $Y$ large enough for the chain-record threshold.
```

### 8JVK · `statement_tex`

Old

```latex
Fix a primitive $\psi$ and a sufficiently small $\varepsilon>0$. Use the groups of \ref{8JVC} and \ref{8JVP} and the nonempty set $T\subseteq A$ supplied by the arithmetic construction at each point of a window $[Y,Y^{3/2}]$. For all sufficiently large $x$ in this window, with a threshold depending only on $\psi,\varepsilon$, put
\[
\begin{aligned}
b&=\exp(x^\varepsilon),\\
X'&=\exp(x^{\varepsilon/3})\ge3,\\
b'&=\frac{xb}{X'}.
\end{aligned}
\]
The chain length is an integer $m\ge1$. There is a nonempty subset $T_2\subseteq A_0$ and, for each $t\in T$, a positive scale $a_t$ with $|a_t/b-x|\le1$. For each $u\in A_0$, put
\[
\Phi_u=\left\{((0,1),z+u)\in\Phi \;\middle|\; z\in T_2\right\}.
\]
There is a real $\rho_w$ with $0\le\rho_w\le b$ and $6f(x+1)\rho_w\le b/x$ such that for every $u\in A_0$ and every integer $1\le j\le m$ there is a weight function
\[
w_{u,j}\colon\Phi\longrightarrow(0,\infty)
\]
with
\[
\begin{aligned}
 b\le w_{u,j}(\alpha)\le b+\rho_w &\qquad(\alpha\in\Phi_u),\\
 0<w_{u,j}(\alpha)\le2b' &\qquad(\alpha\in\Phi\setminus\Phi_u).
\end{aligned}
\]
```

New

```latex
For each primitive $\psi$, take $\varepsilon_0(\psi)$ from \ref{8JU7}. For each $0<\varepsilon<\varepsilon_0(\psi)$ there is $x_{\rm wt}=x_{\rm wt}(\varepsilon)\ge3$ such that the following holds for every window $[Y,Y^{3/2}]$ and primes $q,d$ as in \ref{8JU7} and every real $x\in[Y,Y^{3/2}]$ with $x\ge x_{\rm wt}$. Use the groups of \ref{8JVC} and \ref{8JVP} and the nonempty $T\subseteq A$ of \ref{8JU7} at $x$. Put
\[
\begin{aligned}
b&=\exp(x^\varepsilon),\\
X'&=\exp(x^{\varepsilon/3})\ge3,\\
b'&=\frac{xb}{X'}.
\end{aligned}
\]
The data at $x$ include a chain of $m\ge1$ successive theta lifts between spaces of automorphic forms on definite unitary groups of increasing rank. There is a nonempty subset $T_2\subseteq A_0$ and, for each $t\in T$, a positive scale $\upsilon_t$ with $|\upsilon_t/b-x|\le1$. For each $u\in A_0$, put
\[
\Phi_u=\{(0,1,z+u):z\in T_2\}\subseteq\Phi.
\]
There is a real $\rho_w$ with $0\le\rho_w\le b$ and $6f(x+1)\rho_w\le b/x$. For each $u\in A_0$ and each integer $1\le j\le m$, the weight function $w_{u,j}\colon\Phi\to(0,\infty)$ records the archimedean parameter at each label $\alpha\in\Phi$ for the $j$th lift. It satisfies
\[
\begin{aligned}
 b\le w_{u,j}(\alpha)\le b+\rho_w &\qquad(\alpha\in\Phi_u),\\
 0<w_{u,j}(\alpha)\le2b' &\qquad(\alpha\in\Phi\smallsetminus\Phi_u).
\end{aligned}
\]
```

### 8JVK · `title`

`Scales and weights in the chain` → `Scales and weights for the theta lifts`

### 8JVK · `body_tex`

Old

```latex
For the construction see Chapter 3, \ref{8JU7}. The scales $a_t$ come from \cite[Definition 18.5]{Adriazola}. The set $T_2$ in $A_0$ is the image of the set constructed in Proposition 5.17 under multiplication by a generator of $A_0$. The chain has $m$ lifts, and $\Phi_u$ is the set of positions called thick in Proposition 18.7 and Corollary 18.8. Those results and Proposition 5.16 give the weight bounds. In the source the width is $\rho_w=W+mh_0$, where $W$ is the number of roots of unity in the auxiliary field and $h_0=2\lceil x^{402}\rceil$. Proposition 5.16 gives the stated inequality for this width and the bound $2b'$ at the other positions.
```

New

```latex
The sequence of maps is the one in \cite[Sections 5.8 and 7, p.~54]{Adriazola}. The kernel of each step defines a map on automorphic forms by summation over the lattice classes at that level. The fixed rank increment is the number of copies of the auxiliary hermitian space added at each step, as in Section 18.1.

The scales $\upsilon_t$ are the integers in \cite[Definition 18.5]{Adriazola}. The set $T_2$ is the image of the integer set in Proposition 5.17 under multiplication by a generator of $A_0$, as in Section 5.8. Proposition 18.7 gives a base value $b_1(\alpha)$ at each label for each $u$ and sets
\[
w_{u,j}(\alpha)=b_1(\alpha)+(j-\tfrac12)h_0,\qquad h_0=2\lceil x^{402}\rceil .
\]
These are the second family of archimedean parameters in Corollary 18.8, one function of the label per lift. At the labels in $\Phi_u$ the base values lie between $\lceil b\rceil$ and $\lceil b\rceil+W-1$, where $W$ is the number of roots of unity in the auxiliary field. Use $\rho_w=W+mh_0$.

Proposition 5.16 and Corollary 18.8 apply with $|A|\le2x^{9/4}$, $m\le2\sqrt x$ and $W\le32|A|^2$. These bounds follow from admissibility and are uniform in the window, the primes and the character. Since the proposition fixes the exponent of $h_0$ at $402$ here, its threshold depends only on $\varepsilon$. Increase it, still using only $\varepsilon$, to ensure $X'\ge3$ and the integer intervals in Definition 18.5 are nonempty. For those intervals, $k\le2x^{9/2+10\varepsilon}$ by Proposition 5.15(i), so both $xb/(kx^{13})$ and $b'/x^2$ eventually exceed $1$. Proposition 5.16(iii) gives $|\upsilon_t/b-x|\le1$, and (i)--(ii) with Corollary 18.8 give the weight bounds.
```

### 8JVH · `statement_tex`

Old

```latex
Fix any primitive $\psi$ and any sufficiently small $\varepsilon>0$. Use the primes $q,d$ and the data of \ref{8JVE} supplied by the arithmetic construction on a window $[Y,Y^{3/2}]$. Use the representative $\xi^*$ from \ref{8JVQ} and the \hyperref[8JF7]{smoothed prime sum} $G_{\xi^*}$. The following estimates hold at every sufficiently large $x$ in the window, with a threshold depending only on $\psi,\varepsilon$.
```

New

```latex
For each primitive $\psi$, take $\varepsilon_0(\psi)$ from \ref{8JU7}. For each $0<\varepsilon<\varepsilon_0(\psi)$ there is $x_{\rm aux}=x_{\rm aux}(\psi,\varepsilon)\ge x_{\rm wt}$, with $x_{\rm wt}$ from \ref{8JVK}, such that the following estimates hold for every window $[Y,Y^{3/2}]$ and primes $q,d$ as in \ref{8JU7} and every real $x\in[Y,Y^{3/2}]$ with $x\ge x_{\rm aux}$. Use the Fourier data of \ref{8JVE}, the representative $\xi^*$ from \ref{8JVQ}, and the \hyperref[8JF7]{smoothed prime sum} $G_{\xi^*}$.
```

### 8JVH · `body_tex`

Old

```latex
These are the analytic inputs in \cite[Section 6.3, pp.~43--44]{Adriazola}. For (i), the conductor bounds and the prime number theorem for characters give the large-cutoff estimate there, using the exclusion of real zeros from the prescribed rectangles for the varying quadratic twists. The fixed-conductor real characters are handled by enlarging the threshold. The factor $2f(x+1)$ is absorbed by the exponential for large $x$, as quantified in Proposition 5.16(iv). For (ii), apply Theorems 5.10(ii)--(iii) and 5.12(ii)--(iii) of the same source on the longer range where the pair $q,d$ was chosen. Every index has a quadratic factor from $q$ or $d$, as explained in \ref{8JU5}. See also \cite[Sections 11 and 13]{Outline}.
```

New

```latex
For (i), use the conductor bound $\ln\operatorname{cond}(\xi^*)\le C(\psi)x^{\varepsilon/5}(\ln x)^2$ in \cite[Section 6.3, pp.~43--44]{Adriazola}. It follows from the bounds for $q,d$ at $Y_{\rm base}\le x$ and $N_1\le8N_0|A|$. Real characters involving $q$ or $d$ have the uniform real-zero exclusion in Corollary 5.13. The remaining real characters have conductors dividing a fixed modulus, since real characters of $2$-power conductor have conductor at most $8$. Proposition 5.3 and its trivial-character variant therefore give a uniform large-cutoff bound for $y\ge X'/3$. In the exponential terms of that estimate, the powers $\varepsilon/3-\varepsilon/5$ and $\varepsilon/6$ both exceed $\varepsilon/8$. Increasing $x_{\rm aux}$ gives the stated bound, including $2f(x+1)\omega_x\le1/x$ by Proposition 5.16(iv).

For (ii), every index has a quadratic factor at $q$ or $d$, as explained in \ref{8JU5}. Theorems 5.10(ii)--(iii) and 5.12(ii)--(iii) apply on $[Y_{\rm base},Y_{\rm base}^{J}]$ with the fixed $J=J(\psi,\varepsilon)$ of \ref{8JU7}. The logarithmic derivative is bounded by $401c_0J\ln Y_{\rm base}\le401c_0J\ln(x+1)$, with the absolute $c_0$ of those theorems. These estimates are uniform over the windows of \ref{8JU7}. Choose $x_{\rm aux}\ge x_{\rm wt}$ to meet the requirements of (i).
```

### 8JUD · `statement_tex`

Old

```latex
Fix a primitive $\psi$ of order $o$ and take the \hyperref[8JVE]{Fourier data} and the estimates of \ref{8JVH}. For all sufficiently large $x$ in the window,
\[
\mathcal G_\psi(x)
\le D_\psi(x)+\frac{4}{x\delta_2}
        +(3o+4)x^{1/2+\varepsilon},
\]
where $D_\psi$ is defined in \ref{8JVF}. The threshold depends only on $\psi$ and $\varepsilon$.
```

New

```latex
For each primitive $\psi$ of order $o$, take $\varepsilon_0(\psi)$ from \ref{8JU7}. For each $0<\varepsilon<\varepsilon_0(\psi)$ there is $x_{\rm cmp}=x_{\rm cmp}(\psi,\varepsilon)\ge\max(x_{\rm wt},x_{\rm aux})$, with $x_{\rm wt}$ from \ref{8JVK} and $x_{\rm aux}$ from \ref{8JVH}. For every window $[Y,Y^{3/2}]$ and primes $q,d$ as in \ref{8JU7}, and every real $x\in[Y,Y^{3/2}]$ with $x\ge x_{\rm cmp}$, take the \hyperref[8JVE]{Fourier data} and the estimates of \ref{8JVH}. Then
\[
\mathcal G_\psi(x)
\le D_\psi(x)+\frac{4}{x\delta_2}
        +(3o+4)x^{1/2+\varepsilon},
\]
where $D_\psi$ is defined in \ref{8JVF}.
```

### 8JUD · `body_tex`

Old

```latex
Both logarithmic errors together are $o(x^{1/2+\varepsilon})$ and hence at most $4x^{1/2+\varepsilon}$ once $x$ is large enough. All their constants depend only on $\psi$ and $\varepsilon$, which gives the stated uniform comparison.
```

New

```latex
The sum of these two errors is $o(x^{1/2+\varepsilon})$, uniformly in the window, since the constants depend only on $\psi,\varepsilon$. Choose $x_{\rm cmp}\ge\max(x_{\rm wt},x_{\rm aux})$ so that the sum is at most $4x^{1/2+\varepsilon}$ at every $x\ge x_{\rm cmp}$.
```

### 8JUF · `statement_tex`

Old

```latex
For each primitive $\psi$ there is $0<\varepsilon_0\le1/52$ with the following property. For each $0<\varepsilon<\varepsilon_0$ there is a threshold $x_{\rm arith}\ge3$ depending only on $\psi,\varepsilon$.
```

New

```latex
For each primitive $\psi$, take $\varepsilon_0(\psi)$ from \ref{8JU7}. For each $0<\varepsilon<\varepsilon_0(\psi)$ there is a threshold $x_{\rm arith}=x_{\rm arith}(\psi,\varepsilon)\ge x_{\rm wt}$, with $x_{\rm wt}$ from \ref{8JVK}.
```

### 8JUF · `body_tex`

Old

```latex
Choose $x_{\rm arith}$ large enough for the per-shift bound of \ref{8JUA} and the estimates of \ref{8JUG}.
```

New

```latex
Choose $x_{\rm arith}\ge x_{\rm wt}$ large enough for the per-shift bound of \ref{8JUA} and the estimates of \ref{8JUG}. The chain-record threshold uses the exponent $J(\psi,\varepsilon)$ fixed in \ref{8JU7}.
```

### 8JVG · `statement_tex`

Old

```latex
For each primitive $\psi$ there is $0<\varepsilon_0\le1/52$ with the following property. For every $\eta>0$, every $0<\varepsilon<\varepsilon_0$ with $61\varepsilon/8\le\eta$, and every $Y_0\ge3$, there is a window $[Y,Y^{3/2}]$ with $Y\ge Y_0$ and a pair of auxiliary primes $q,d$ fixed on that window. At every real $x$ in the window the construction supplies the data of \ref{8JVE}, satisfying the estimates of \ref{8JVH}, with
```

New

```latex
For each primitive $\psi$, take $\varepsilon_0(\psi)$ from \ref{8JU7}. For every $\eta>0$, every $0<\varepsilon<\varepsilon_0(\psi)$ with $61\varepsilon/8\le\eta$, and every $Y_0\ge3$, there is a window $[Y,Y^{3/2}]$ and a pair of auxiliary primes $q,d$ as in \ref{8JU7}, with $Y\ge\max(Y_0,x_{\rm arith},x_{\rm aux})$. Here $x_{\rm arith}$ is from \ref{8JUF} and $x_{\rm aux}$ is from \ref{8JVH}. At every real $x$ in the window, the choices from \ref{8JU7}, \ref{8JVK}, and \ref{8JUG} give the data of \ref{8JVE}, satisfying the estimates of \ref{8JVH}, with
```

### 8JVG · `body_tex`

Old

```latex
Take the window of \ref{8JUF} in Chapter 3, raising the requested lower bound for $Y$ to meet the thresholds in \ref{8JVK} and \ref{8JVH}.
```

New

```latex
Apply \ref{8JUF} with requested lower bound $\max(Y_0,x_{\rm aux})$ for $Y$. This gives $Y\ge\max(Y_0,x_{\rm arith},x_{\rm aux})$, with $x_{\rm arith}\ge x_{\rm wt}$.
```

### 8JVJ · `body_tex`

Old

```latex
Fix $\psi$ and $0<\varepsilon<\varepsilon_0$ from \ref{8JVG}, and set $\eta=61\varepsilon/8$. Write $o$ for the order of $\psi$. Let $x_{\rm cmp}$ be the threshold in \ref{8JUD}, $x_{\rm wt}$ the threshold in \ref{8JVK}, and $x_{\rm aux}$ the threshold in \ref{8JVH}. Let $x_{\rm arith}$ be the threshold for the Chapter 3 estimate used in the proof of \ref{8JVG}. For a prescribed $Y_0\ge1$, use \ref{8JVG} with the starting point $Y$ at least
\[
\max\bigl(3,Y_0,x_{\rm cmp},x_{\rm wt},x_{\rm aux},x_{\rm arith},
          (3o+28)^{8/(11\varepsilon)}\bigr).
\]
```

New

```latex
Fix $\psi$ and $0<\varepsilon<\varepsilon_0(\psi)$ from \ref{8JU7}, and set $\eta=61\varepsilon/8$. Write $o$ for the order of $\psi$. Use $x_{\rm cmp}$ from \ref{8JUD}, which is at least $x_{\rm wt}$ from \ref{8JVK} and $x_{\rm aux}$ from \ref{8JVH}. For a prescribed $Y_0\ge1$, apply \ref{8JVG} with the requested lower bound for $Y$ equal to
\[
\max\bigl(Y_0,x_{\rm cmp},(3o+28)^{8/(11\varepsilon)}\bigr).
\]
```

### 8JV8 · `intro_tex`

Old

```latex
We now specify the data needed to normalize the counting formula of \ref{8JU9}. The arithmetic construction supplies arbitrarily distant windows $[Y,Y^{3/2}]$. The primes $q,d$ are fixed on a window, while the groups and weights can depend on the point $x$ in it. \ref{8JVK} gives the number $a_t$ for each shift $t\in T$ and the weight functions $w_{u,j}$ for each $u\in A_0$. The index $j=1,\dots,m$ runs over the $m$ steps of the construction, one weight function per step. \ref{8JVE} collects the data, including the coset proportions of $T$.
```

New

```latex
We now specify the data needed to normalize the counting formula of \ref{8JU9}. \ref{8JU7} gives windows $[Y,Y^{3/2}]$ with $Y$ arbitrarily large. The primes $q,d$ are fixed on each window, while the groups and the shift set $T$ from \ref{8JU7} can depend on the point $x$. At each $x\ge x_{\rm wt}$, \ref{8JVK} gives the scale $\upsilon_t$ for each $t\in T$ and a weight function $w_{u,j}$ for each $u\in A_0$ and each lift $j=1,\dots,m$ in the theta-lift chain. \ref{8JVE} collects the data, including the coset proportions of $T$.
```

## Other window and auxiliary data wording

### 8JV2 · `statement_tex`

Old

```latex
The nonnegative numbers $e_D,e_L$ are error exponents if there is a constant $C>0$, independent of $x$, such that at every scale of the construction and for every $u_0\in A_0$,
$$
S-\Gamma\leqslant C\,hmb\,x^{e_L\varepsilon},
\qquad 0\leqslant I\leqslant C\,hmb\,x^{e_L\varepsilon},
$$
and, for every auxiliary prime $T_u$ of the chain,
$$
\mu(R)+h_u-L\leqslant D_u+C\,h\,a\Lambda_a+C\,m(B_0+N_c)\,x^{e_D\varepsilon}.
$$
```

New

```latex
The nonnegative numbers $e_D,e_L$ are error exponents if there is a constant $C>0$, independent of $x$, such that for the theta-lift chains at all scales $x$ of the construction and for every $u_0\in A_0$,
$$
S-\Gamma\leqslant C\,hmb\,x^{e_L\varepsilon},
\qquad 0\leqslant I\leqslant C\,hmb\,x^{e_L\varepsilon},
$$
and, for every auxiliary prime $T_u$ of the chain,
$$
\mu(R)+h_u-L\leqslant D_u+C\,h\,\upsilon\Lambda_{\upsilon}+C\,m(B_0+N_c)\,x^{e_D\varepsilon}.
$$
```

### 8JU2 · `intro_tex`

Old

```latex
The construction gives intervals $[Y,Y^{3/2}]$ with $Y$ arbitrarily large.
```

New

```latex
\ref{8JU7} gives intervals $[Y,Y^{3/2}]$ with $Y$ arbitrarily large.
```

### 8JU3 · `intro_tex`

Old

```latex
The construction uses the freedom along the tower to choose many shifts without too many collisions in short progressions.
```

New

```latex
The choice of the shift set $T$ in \ref{8JU7} uses the freedom along the tower to obtain many shifts without too many collisions in short progressions.
```

### 8JU5 · `intro_tex`

Old

```latex
Their prime sums are small because the arithmetic construction chooses the auxiliary primes $q,d$ for this purpose.
```

New

```latex
Their prime sums are small by the choice of the auxiliary primes $q,d$ in \ref{8JU7}.
```

### 8JV7 · `intro_tex`

Old

```latex
The count in \ref{8JU9} and the Fourier expansion in \ref{8JVD} allow arbitrary positive weight functions (with $w_\alpha\le a$ in the Fourier expansion), and \ref{8JVK} in §2.3 supplies the particular weight functions $w_{u,j}$ used in the construction.
```

New

```latex
The count in \ref{8JU9} and the Fourier expansion in \ref{8JVD} allow arbitrary positive weight functions (with $w_\alpha\le\upsilon$ in the Fourier expansion), and \ref{8JVK} in §2.3 supplies the particular weight functions $w_{u,j}$ used in the normalized count of \ref{8JVF}.
```

## Main-term check against Chapter 1

The Chapter 1 check used 8JF7, 8JV3, 8JS3, 8JS6, and 8JN4, together with the proof of 8JVD. For a cutoff $x\ge1$, 8JF7 and 8JS3 give $M_\chi(x)=R_\chi(x)-G_\chi(x)$. The two relevant terms are

$$
M_{\mathbf 1}(x)=x(\ln x-1-\gamma),
\qquad
M_{\xi_c^*}(x)=-x\frac{L'(1,\xi_c^*)}{L(1,\xi_c^*)}.
$$

For every nontrivial $\xi$, multiplying $M_{\xi^*}(\upsilon/w^t(g))$ by $w^t(g)$ makes it constant in $g$. The indicator $(1-\xi_c)/2$ gives the trivial character coefficient $1$ and the $\xi_c$ coefficient $-1$ in the average over the counted coset. All other character coefficients in that average vanish. Thus, for $w_\alpha\le\upsilon$ for every $\alpha\in\Phi$, the proof of 8JVD gives the exact identity

$$
\begin{aligned}
&\frac1f\sum_{g\notin\Phi} w^t(g)
\left[
M_{\mathbf 1}\!\left(\frac{\upsilon}{w^t(g)}\right)
-M_{\xi_c^*}\!\left(\frac{\upsilon}{w^t(g)}\right)
\right]\\
&\quad=
\upsilon\left(
\ln\upsilon-1-\gamma+\frac{L'(1,\xi_c^*)}{L(1,\xi_c^*)}
-\frac1f\sum_{\alpha\in\Phi}\ln w_\alpha
\right)
=M(\upsilon,w).
\end{aligned}
$$

The log sum uses the bijection $p_t$ and is independent of $t$ at fixed $\upsilon$ and $w$. The later evaluation $M(\upsilon_t,w)$ can vary through its scale input.

Chapter 1 defines each $G_\chi$ with the $s=1$ terms already subtracted, as 8JS6 and 8JN4 show. The displayed identity takes the main terms of the corresponding weighted **$R_{\mathbf 1}-R_{\xi_c^*}$** difference. The centered Fourier expansion in 8JVD still sums over all characters at class-dependent cutoffs.

## Local verification

- Loaded `backup-before-psi-subscripts-2026-11-26.sql` into SQLite 3.51.3 in a temporary directory outside the repository. Applied `scripts/psi-subscripts-2026-11-26.sql` and then the extended notation batch in that order. This follow-up used the backup for all database queries and made no remote calls.
- All 33 changed rows advanced one revision, received timestamp `2026-11-26 20:00:00` and author `codex`, had their HTML caches cleared, and received matching snapshots. The 8JVK snapshot includes its new title. The rebuild flag advanced from `0` to `1`, and the integrity and foreign-key checks passed.
- The rerun and 123 independently tested guard failures rolled back. The failure cases covered 33 revision mismatches, 89 old-substring mismatches, and one title mismatch. An existing `\smallsetminus` survived an additional test.
- The SQLite `LIKE` scans covered all 53 Chapter 2–3 TeX fields. The sole remaining `((` is in 8JV8’s smoothing formula. The sole remaining `(\Z/2\Z)^2` describes $A$ in 8JVM. The scans found zero matches for `\setminus`, the old product and quotient of $B$, or the unnamed smallness and threshold wording.
- The project renderer in `src/latex.ts` used the database macros and KaTeX 0.19.1. All 846 math expressions across the 33 changed fields rendered without errors or warnings. The revised title and a standalone `B\smallsetminus\Phi` check also rendered. All 141 reference targets and 23 bibliography key occurrences resolved. All 25 project tests passed.

## 8JVP · Quadratic coordinates for counting and weights

```latex
Use the moduli and group $A$ of \ref{8JVC}. For a unit $v$ modulo $N$, let $e_1(v)$ and $e_2(v)$ in $\Z/2\Z$ be its quadratic bits modulo $d$ and $q$, respectively, recorded as $0$ for a square and $1$ for a nonsquare. Write $[v]_A$ for the class in $A$ of its reduction modulo $N_1$. Put
\[
B=\Z/2\Z\times\Z/2\Z\times A,
\]
and define
\[
\pi\colon(\Z/N\Z)^\times\longrightarrow B,\qquad v\longmapsto(e_1(v),e_2(v),[v]_A).
\]
Define
\begin{align*}
\Phi &= \{0\}\times\Z/2\Z\times A,\\
f &= |\Phi|=2|A|=|B|/2.
\end{align*}
The character at $d$ and the embedding of $A$ into $B$ are
\begin{align*}
\xi_c\colon B&\longrightarrow\{1,-1\}, & (e_1,e_2,v)&\longmapsto(-1)^{e_1},\\
A&\longrightarrow B, & v&\longmapsto(0,0,v).
\end{align*}
The character $\xi_c$ reads the first quadratic bit, at $d$. Its kernel is $\Phi$, and the other coset $B\smallsetminus\Phi$ consists of the classes with $e_1=1$, for which $\xi_c=-1$. Thus
\[
\mathbf 1_{B\smallsetminus\Phi}=\frac{1-\xi_c}{2}.
\]
```

## 8JVQ · Prime-power classes and primitive characters

```latex
Use $N$ from \ref{8JVC} and $B,\pi$ from \ref{8JVP}. For each prime $p$, write $N=p^\nu N^{(p)}$ with $p\nmid N^{(p)}$. Define reduction modulo $N^{(p)}$ by
\[
r_p\colon(\Z/N\Z)^\times\longrightarrow(\Z/N^{(p)}\Z)^\times,
\qquad v\longmapsto v\bmod N^{(p)}.
\]
Let $u_p$ be the unit modulo $N$ congruent to $p$ modulo $N^{(p)}$ and to $1$ modulo $p^\nu$. Put
\begin{align*}
I_p &= \pi(\ker r_p),\\
\vartheta_p &= \pi(u_p).
\end{align*}
For each integer $i\ge1$, the class of $p^i$ is the coset $i\vartheta_p+I_p$. For $p\nmid N$ one has $I_p=\{0\}$ and $\vartheta_p=\pi(p\bmod N)$.

Write $\widehat B$ for the group of characters $B\to\C^\times$, and $\mathcal P_N$ for the set of \hyperref[8JH4]{primitive Dirichlet characters} whose conductors divide $N$. Define
\[
\widehat B\longrightarrow\mathcal P_N,\qquad \xi\longmapsto\xi^*,
\]
where $\xi^*$ is the primitive character \hyperref[8JB2]{inducing} the Dirichlet character $\xi\circ\pi$ modulo $N$.
```

## 8JU9 · The weighted prime-power count

```latex
Use $A$ from \ref{8JVC}, the class group and weight labels of \ref{8JVP}, and the prime-power data of \ref{8JVQ}. Write $v_+=\max(v,0)$ for real $v$. For any $t\in A$, define
\[
p_t\colon B\smallsetminus\Phi \longrightarrow \Phi,
\qquad g\longmapsto g+(1,1,t).
\]
For any function $w$ with positive values, use the notation
\[
w\colon\Phi\longrightarrow(0,\infty),\qquad \alpha\longmapsto w_\alpha=w(\alpha).
\]
Translation by $(1,1,t)$ changes the first bit from $1$ to $0$, so $p_t$ is a bijection. Write the weights on the counted coset as
\[
w^t=w\circ p_t\colon B\smallsetminus\Phi\longrightarrow(0,\infty),
\qquad w^t(g)=w_{p_t(g)}.
\]
For any real $\upsilon>0$, define the real-valued count $S$ on triples $(t,\upsilon,w)$ and the main term $M$ with values in $\C$ on pairs $(\upsilon,w)$ by
\begin{align*}
S(t,\upsilon,w)&=\sum_{p\ {\rm prime},\ i\ge1}\ \sum_{g\notin\Phi}
\frac{2\mathbf 1_{g-i\vartheta_p\in I_p}}{|I_p|}\ln p\,
\left(\frac{\upsilon}{p^i}-w^t(g)\right)_+,\\
M(\upsilon,w)&=\upsilon\left(\ln\upsilon-1-\gamma
 +\frac{L'(1,\xi_c^*)}{L(1,\xi_c^*)}
 -\frac1f\sum_{\alpha\in\Phi}\ln w_\alpha\right).
\end{align*}
Here $\gamma$ is Euler's constant.

The count runs over prime powers $p^i$ and the members $g$ of their class coset $i\vartheta_p+I_p$ with $\xi_c(g)=-1$. Each such member contributes its share $1/|I_p|$ with von Mangoldt weight $\ln p$. The factor $2$ accounts for restricting to half of $B$ and turns the Fourier normalization $1/|B|$ into $1/f$ in \ref{8JVD}. At $p\nmid N$, the coset is a singleton, so the class condition selects odd powers of primes with $\xi_c(\vartheta_p)=-1$.

For $W=w^t(g)$, the smoothing identity
\[
\left(\frac{\upsilon}{p^i}-W\right)_+
=W\left(\frac{\upsilon/W}{p^i}-1\right)_+
\]
gives $W$ times the \hyperref[8JF7]{Chapter 1 smoothing} at cutoff $\upsilon/W$. A prime power contributes at that class only when $p^i<\upsilon/W$. At fixed $\upsilon$ and $w$, the count $S(t,\upsilon,w)$ depends on $t$ through the assignment $g\mapsto w^t(g)$. Changing $t$ permutes which counted class receives each weight.

When $w_\alpha\le\upsilon$ for every $\alpha\in\Phi$, the proof of \ref{8JVD} obtains $M(\upsilon,w)$ from the Chapter 1 main terms in the Fourier expansion. The character $\xi_c$ of \ref{8JVP} is $-1$ exactly when the bit $e_1$ at $d$ is $1$. The indicator of the counted coset is $\mathbf 1_{B\smallsetminus\Phi}=(1-\xi_c)/2$, so only the trivial character and $\xi_c$ have nonzero coefficients when averaging characters over $g\notin\Phi$. The trivial character gives the pole term. For $\xi_c$, the weighted Chapter 1 main term at each class is $-\upsilon L'(1,\xi_c^*)/L(1,\xi_c^*)$. The coefficient $-1$ from the coset average gives the plus sign in $M(\upsilon,w)$.

The bijection $p_t$ gives
\[
\sum_{g\notin\Phi}\ln w(p_t(g))=\sum_{\alpha\in\Phi}\ln w_\alpha,
\]
so $M(\upsilon,w)$ is independent of $t$ at fixed $\upsilon$ and $w$. Subtracting $\Re M(\upsilon,w)$ leaves the real Fourier sum of the centered functions $G_{\xi^*}$. With the data of \ref{8JVK}, \ref{8JVF} sums, averages, and normalizes these centered counts to form $D_\psi(x)$.
```

## 8JVD · Fourier expansion statement and revised main-term proof

```latex
Use $B,\Phi,f$ from \ref{8JVP} and the prime-power and character data of \ref{8JVQ}. For any $t,\upsilon,w$ as in \ref{8JU9} with $w_\alpha\le\upsilon$ for every $\alpha\in\Phi$, write $w^t=w\circ p_t$ for the shifted weights on $B\smallsetminus\Phi$.
Then
\[
S(t,\upsilon,w)-\Re M(\upsilon,w)
=\Re\left(\frac1f\sum_{g\notin\Phi}\sum_{\xi\in\widehat B}
\overline{\xi(g)}\, w^t(g)G_{\xi^*}(\upsilon/w^t(g))\right),
\]
where $G_{\xi^*}$ is the \hyperref[8JF7]{smoothed prime sum}.
```

```latex
\emph{(c) Compute the main term.} Write $R_{\xi^*}=G_{\xi^*}+M_{\xi^*}$ as in \ref{8JS3}. Since $p_t$ is the bijection to $\Phi$ of \ref{8JU9}, the trivial character contributes
\[
\frac1f\sum_{g\notin\Phi} w^t(g)M_{\mathbf1}(\upsilon/w^t(g))
=\frac{\upsilon}{f}\sum_{\alpha\in\Phi}
\bigl(\ln\upsilon-\ln w_\alpha-1-\gamma\bigr).
\]
For every nontrivial $\xi$, the term $w^t(g)M_{\xi^*}(\upsilon/w^t(g))$ is the constant $-\upsilon L'(1,\xi^*)/L(1,\xi^*)$. Its coefficient is $f^{-1}\sum_{g\notin\Phi}\overline{\xi(g)}$. By $\mathbf 1_{B\smallsetminus\Phi}=(1-\xi_c)/2$ from \ref{8JVP} and character orthogonality, among the nontrivial characters only $\xi_c$ has a nonzero coefficient, namely $-1$. The contribution of $\xi_c$ is therefore $+\upsilon L'(1,\xi_c^*)/L(1,\xi_c^*)$. Adding the two contributions gives
\[
M(\upsilon,w)=\frac1f\sum_{g\notin\Phi}w^t(g)
\bigl(M_{\mathbf1}(\upsilon/w^t(g))-M_{\xi_c^*}(\upsilon/w^t(g))\bigr).
\]
Taking real parts proves the identity. Part (a) accounts for all primes dividing $N$.
```

## 8JUD · Shifted weights in the recovery proof

```latex
At a label $\alpha=p_t(g)\in\Phi_u$, write $w=w_{u,j}^t(g)=w_{u,j}(\alpha)$. Then \ref{8JUE} bounds the change in $wG_{\xi^*}(\upsilon_t/w)$ by $3(x+1)\rho_w$, using $\upsilon_t\le(x+1)b$ and $b\le w\le b+\rho_w\le2b\le \upsilon_t$. At each other label $\alpha=p_t(g)\in\Phi\smallsetminus\Phi_u$, the weight $w=w_{u,j}^t(g)$ satisfies $w\le2b'$ and
\[
\frac{\upsilon_t}{w}\ge\frac{(x-1)b}{2b'}
=\frac{x-1}{2x}\,X'\ge X'/3 .
\]
```

## 8JV7 · Closing paragraph of the §2.2 intro

```latex
The count in \ref{8JU9} and the Fourier expansion in \ref{8JVD} allow arbitrary positive weight functions (with $w_\alpha\le\upsilon$ in the Fourier expansion), and \ref{8JVK} in §2.3 supplies the particular weight functions $w_{u,j}$ used in the normalized count of \ref{8JVF}.
```
