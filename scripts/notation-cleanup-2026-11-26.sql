-- Define Phi by its product coordinates, rename F_p to \vartheta_p and the
-- positive scale a to \upsilon. Use flat triples in B, name the uniform
-- thresholds, and identify the weights of the successive theta lifts.
-- Use w^t for shifted weights and explain the
-- count and its main term in the definitions 8JU9 and 8JVP.
-- Use \smallsetminus for Chapter 2–3 set complements and give explicit
-- sources for the common window and auxiliary data.
-- Apply as one D1 batch after exporting the database. The guard aborts unless
-- all expected revisions and old TeX substrings match.

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (
    SELECT 1 FROM results WHERE id = 126 AND tag = '8JU7' AND revision = 5
      AND instr(statement_tex, 'For every primitive $\psi$ there is $0<\varepsilon_0\le1/52$ such that for every $0<\varepsilon<\varepsilon_0$ and every $Y_0\ge3$ the construction gives real $Y\ge Y_0$ and auxiliary primes $q,d$ fixed on $[Y,Y^{3/2}]$. At each real $x$ in that window it gives the groups of \ref{8JVC} and \ref{8JVP}, a nonempty set $T\subseteq A$, and integral theta-lift data with \hyperref[8JV2]{error exponents} $e_D=2$ and $e_L=0$.') > 0
      AND instr(statement_tex, '|\mu_C-\lambda_C|\le x^{-1+\varepsilon}.
\]') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM results WHERE id = 128 AND tag = '8JU9' AND revision = 7
      AND instr(statement_tex, 'g\longmapsto g+((1,1),t).') > 0
      AND instr(statement_tex, 'B\setminus\Phi') > 0
      AND instr(statement_tex, '\qquad \alpha\longmapsto w_\alpha=w(\alpha).
\]') > 0
      AND instr(statement_tex, 'For any real $a>0$, define the real-valued count $S$ on triples $(t,a,w)$ and the main term $M$ with values in $\C$ on pairs $(a,w)$ by') > 0
      AND instr(statement_tex, 'S(t,a,w)&=') > 0
      AND instr(statement_tex, '\frac{2\mathbf 1_{g-iF_p\in I_p}}{|I_p|}\ln p\,
\left(\frac{a}{p^i}-w_{p_t(g)}\right)_+,') > 0
      AND instr(statement_tex, 'M(a,w)&=a\left(\ln a-') > 0
      AND instr(statement_tex, 'Here $\gamma$ is Euler''s constant.') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM results WHERE id = 131 AND tag = '8JUC' AND revision = 6
      AND instr(statement_tex, 'a_t') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM results WHERE id = 133 AND tag = '8JUE' AND revision = 3
      AND instr(statement_tex, '$\chi$ and real $a,w,w''>0$') > 0
      AND instr(statement_tex, 'w,w''\le a') > 0
      AND instr(statement_tex, 'a/w') > 0
      AND instr(statement_tex, '\frac{3a}') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM results WHERE id = 153 AND tag = '8JUW' AND revision = 4
      AND instr(statement_tex, '\mathcal H\setminus\mathcal K') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM results WHERE id = 154 AND tag = '8JV2' AND revision = 2
      AND instr(statement_tex, 'The nonnegative numbers $e_D,e_L$ are error exponents if there is a constant $C>0$, independent of $x$, such that at every scale of the construction and for every $u_0\in A_0$,') > 0
      AND instr(statement_tex, '\,a\Lambda_a') > 0
      AND instr(statement_tex, '$a=xb$') > 0
      AND instr(statement_tex, '\Lambda_a=\ln(a\,') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM results WHERE id = 161 AND tag = '8JVD' AND revision = 3
      AND instr(statement_tex, 'For any $t,a,w$ as in \ref{8JU9} with $w_\alpha\le a$ for every $\alpha\in\Phi$, write the weights on the counted classes as
\[
w\circ p_t\colon B\setminus\Phi\longrightarrow(0,\infty),
\qquad g\longmapsto w_g=w_{p_t(g)}.
\]') > 0
      AND instr(statement_tex, 'S(t,a,w)-\Re M(a,w)') > 0
      AND instr(statement_tex, 'w_g G_{\xi^*}(a/w_g)') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM results WHERE id = 162 AND tag = '8JVE' AND revision = 4
      AND instr(statement_tex, 'a_t') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM results WHERE id = 163 AND tag = '8JVF' AND revision = 2
      AND instr(statement_tex, 'a_t') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM results WHERE id = 164 AND tag = '8JVG' AND revision = 1
      AND instr(statement_tex, 'For each primitive $\psi$ there is $0<\varepsilon_0\le1/52$ with the following property. For every $\eta>0$, every $0<\varepsilon<\varepsilon_0$ with $61\varepsilon/8\le\eta$, and every $Y_0\ge3$, there is a window $[Y,Y^{3/2}]$ with $Y\ge Y_0$ and a pair of auxiliary primes $q,d$ fixed on that window. At every real $x$ in the window the construction supplies the data of \ref{8JVE}, satisfying the estimates of \ref{8JVH}, with') > 0
      AND instr(statement_tex, 'At every real $x$ in the window the construction supplies the data of \ref{8JVE}, satisfying the estimates of \ref{8JVH}, with') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM results WHERE id = 165 AND tag = '8JVH' AND revision = 2
      AND instr(statement_tex, 'Fix any primitive $\psi$ and any sufficiently small $\varepsilon>0$. Use the primes $q,d$ and the data of \ref{8JVE} supplied by the arithmetic construction on a window $[Y,Y^{3/2}]$. Use the representative $\xi^*$ from \ref{8JVQ} and the \hyperref[8JF7]{smoothed prime sum} $G_{\xi^*}$. The following estimates hold at every sufficiently large $x$ in the window, with a threshold depending only on $\psi,\varepsilon$.') > 0
      AND instr(statement_tex, 'Use the primes $q,d$ and the data of \ref{8JVE} supplied by the arithmetic construction on a window $[Y,Y^{3/2}]$.') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM results WHERE id = 167 AND tag = '8JVK' AND revision = 3
      AND title = 'Scales and weights in the chain'
      AND instr(statement_tex, 'Fix a primitive $\psi$ and a sufficiently small $\varepsilon>0$. Use the groups of \ref{8JVC} and \ref{8JVP} and the nonempty set $T\subseteq A$ supplied by the arithmetic construction at each point of a window $[Y,Y^{3/2}]$. For all sufficiently large $x$ in this window, with a threshold depending only on $\psi,\varepsilon$, put') > 0
      AND instr(statement_tex, 'The chain length is an integer $m\ge1$.') > 0
      AND instr(statement_tex, '\Phi_u=\left\{((0,1),z+u)\in\Phi \;\middle|\; z\in T_2\right\}.') > 0
      AND instr(statement_tex, 'There is a real $\rho_w$ with $0\le\rho_w\le b$ and $6f(x+1)\rho_w\le b/x$ such that for every $u\in A_0$ and every integer $1\le j\le m$ there is a weight function
\[
w_{u,j}\colon\Phi\longrightarrow(0,\infty)
\]
with') > 0
      AND instr(statement_tex, 'Use the groups of \ref{8JVC} and \ref{8JVP} and the nonempty set $T\subseteq A$ supplied by the arithmetic construction at each point of a window $[Y,Y^{3/2}]$.') > 0
      AND instr(statement_tex, '\Phi\setminus\Phi_u') > 0
      AND instr(statement_tex, 'a_t') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM results WHERE id = 168 AND tag = '8JVM' AND revision = 2
      AND instr(statement_tex, '$B=(\Z/2\Z)^2\times A$ has $16$ elements and $\Phi=\{0\}\times(\Z/2\Z)\times A$ has $8$.') > 0
      AND instr(statement_tex, '$F_{13}=((1,0),(1,1))$. Here $\xi_c(F_{13})=-1$, so the odd powers of $13$ enter the count in \ref{8JU9}.') > 0
      AND instr(statement_tex, 'F_{13}') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM results WHERE id = 170 AND tag = '8JVP' AND revision = 3
      AND instr(statement_tex, 'B=(\Z/2\Z)^2\times A,') > 0
      AND instr(statement_tex, 'v\longmapsto((e_1(v),e_2(v)),[v]_A).') > 0
      AND instr(statement_tex, '((e_1,e_2),v)&\longmapsto(-1)^{e_1}') > 0
      AND instr(statement_tex, '\left\{((0,e_2),v)\in B \;\middle|\; e_2\in\Z/2\Z,\ v\in A\right\}') > 0
      AND instr(statement_tex, 'A&\longrightarrow B, & v&\longmapsto((0,0),v).
\end{align*}') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM results WHERE id = 171 AND tag = '8JVQ' AND revision = 2
      AND instr(statement_tex, 'F_p') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM sections WHERE id = 105 AND tag = '8JU2' AND revision = 3
      AND instr(intro_tex, 'The construction gives intervals $[Y,Y^{3/2}]$ with $Y$ arbitrarily large.') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM sections WHERE id = 106 AND tag = '8JU3' AND revision = 6
      AND instr(intro_tex, 'In Adriazola''s notation the auxiliary field has group $B=(\Z/2\Z)^2\times A$ as in \ref{8JVP}.') > 0
      AND instr(intro_tex, 'The construction uses the freedom along the tower to choose many shifts without too many collisions in short progressions.') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM sections WHERE id = 108 AND tag = '8JU5' AND revision = 3
      AND instr(intro_tex, 'Their prime sums are small because the arithmetic construction chooses the auxiliary primes $q,d$ for this purpose.') > 0
      AND instr(intro_tex, 'a_t') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM sections WHERE id = 113 AND tag = '8JV7' AND revision = 4
      AND instr(intro_tex, 'The map $\pi$ sends a unit modulo $N=N_1qd$ to its class in $A$ and the two quadratic bits.') > 0
      AND instr(intro_tex, 'the map $p_t$ of \ref{8JU9} adds $((1,1),t)$.') > 0
      AND instr(intro_tex, 'The count in \ref{8JU9} and the Fourier expansion in \ref{8JVD} allow arbitrary positive weight functions (with $w_\alpha\le a$ in the Fourier expansion), and \ref{8JVK} in §2.3 supplies the particular weight functions $w_{u,j}$ used in the construction.') > 0
      AND instr(intro_tex, 'B\setminus\Phi') > 0
      AND instr(intro_tex, ' Changing $t$ permutes the assigned weights. The factor $2$ in the count compensates for using half the classes and changes the Fourier factor $1/|B|$ to $1/f$.') > 0
      AND instr(intro_tex, 'F_p') > 0
      AND instr(intro_tex, '

For any scale $a>0$ and any individual weight value $W>0$, the identity
\[
\left(\frac a{p^i}-W\right)_+
=W\left(\frac{a/W}{p^i}-1\right)_+
\]
gives the \hyperref[8JF7]{Chapter 1 smoothing} at cutoff $a/W$. The proof of \ref{8JVD} derives the main term $M(a,w)$ that is subtracted in the next section.') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM sections WHERE id = 114 AND tag = '8JV8' AND revision = 3
      AND instr(intro_tex, 'The arithmetic construction supplies arbitrarily distant windows $[Y,Y^{3/2}]$. The primes $q,d$ are fixed on a window, while the groups and weights can depend on the point $x$ in it. \ref{8JVK} gives the number $a_t$ for each shift $t\in T$ and the weight functions $w_{u,j}$ for each $u\in A_0$. The index $j=1,\dots,m$ runs over the $m$ steps of the construction, one weight function per step.') > 0
      AND instr(intro_tex, 'a_t') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM proofs WHERE id = 114 AND result_id = 129 AND revision = 4
      AND instr(body_tex, 'a_t') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM proofs WHERE id = 116 AND result_id = 131 AND revision = 2
      AND instr(body_tex, 'a_t') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM proofs WHERE id = 117 AND result_id = 132 AND revision = 8
      AND instr(body_tex, 'For each $z\in T_2$, the class assigning the weight at $((0,1),z+u)$ is $g=((1,0),z+u-t)$, by $p_t$ in \ref{8JU9}.') > 0
      AND instr(body_tex, '$\sigma_\xi=\xi((1,0),0)\in\{1,-1\}$') > 0
      AND instr(body_tex, '$B/A_0=(\Z/2\Z)^2\times(A/A_0)$') > 0
      AND instr(body_tex, 'Both logarithmic errors together are $o(x^{1/2+\varepsilon})$ and hence at most $4x^{1/2+\varepsilon}$ once $x$ is large enough. All their constants depend only on $\psi$ and $\varepsilon$, which gives the stated uniform comparison.') > 0
      AND instr(body_tex, 'At a label $\alpha\in\Phi_u$, write $w=w_{u,j}(\alpha)$.') > 0
      AND instr(body_tex, 'At each other label $\alpha\in\Phi\setminus\Phi_u$, the weight $w=w_{u,j}(\alpha)$ satisfies $w\le2b''$') > 0
      AND instr(body_tex, 'a_t') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM proofs WHERE id = 118 AND result_id = 133 AND revision = 3
      AND instr(body_tex, '(0,a]') > 0
      AND instr(body_tex, 'a/v') > 0
      AND instr(body_tex, 'a/n') > 0
      AND instr(body_tex, 'aL''') > 0
      AND instr(body_tex, '-a\ln') > 0
      AND instr(body_tex, '(1+\gamma)a') > 0
      AND instr(body_tex, '3a/') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM proofs WHERE id = 134 AND result_id = 161 AND revision = 2
      AND instr(body_tex, 'F_p') > 0
      AND instr(body_tex, '\emph{(c) Compute the main term.} Write $R_{\xi^*}=G_{\xi^*}+M_{\xi^*}$ as in \ref{8JS3}. Since $p_t$ is the bijection to $\Phi$ described in \ref{8JV7}, the trivial character contributes
\[
\frac1f\sum_{g\notin\Phi} w_g M_{\mathbf1}(a/w_g)
=\frac af\sum_{\alpha\in\Phi}
\bigl(\ln a-\ln w_\alpha-1-\gamma\bigr).
\]
For every nontrivial $\xi$ the term $w_gM_{\xi^*}(a/w_g)$ is the constant $-aL''(1,\xi^*)/L(1,\xi^*)$. Hence its total coefficient is $f^{-1}\sum_{g\notin\Phi}\overline{\xi(g)}$. The summation set is a single coset of $\Phi$, so \ref{8JV9} makes this zero if $\xi|_\Phi\ne1$. The only nontrivial character of $B/\Phi$ is $\xi_c$ and its coefficient is $-1$, giving $+aL''(1,\xi_c^*)/L(1,\xi_c^*)$. These are exactly the terms in $M(a,w)$. Taking real parts proves the identity. There is no residual term at the primes dividing $N$, since (a) already accounts for their local factors.') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM proofs WHERE id = 138 AND result_id = 167 AND revision = 1
      AND instr(body_tex, 'For the construction see Chapter 3, \ref{8JU7}. The scales $a_t$ come from \cite[Definition 18.5]{Adriazola}. The set $T_2$ in $A_0$ is the image of the set constructed in Proposition 5.17 under multiplication by a generator of $A_0$. The chain has $m$ lifts, and $\Phi_u$ is the set of positions called thick in Proposition 18.7 and Corollary 18.8. Those results and Proposition 5.16 give the weight bounds. In the source the width is $\rho_w=W+mh_0$, where $W$ is the number of roots of unity in the auxiliary field and $h_0=2\lceil x^{402}\rceil$. Proposition 5.16 gives the stated inequality for this width and the bound $2b''$ at the other positions.') > 0
      AND instr(body_tex, 'a_t') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM proofs WHERE id = 112 AND result_id = 126 AND revision = 4
      AND instr(body_tex, '\emph{(1)} Choose $q$, then $d$, in the prescribed residue classes. Zero-density and mean-square estimates bound the candidates that fail the zero-free or smoothed-sum tests. Taking the union over the finitely many characters at the fixed modulus still leaves admissible primes. The same pair works throughout the range used in the field construction. See \cite[Theorems 5.10 and 5.12]{Adriazola} and \cite[Section 11]{Outline}.') > 0
      AND instr(body_tex, 'The chain data at these scales use the local and global matching inputs and the exponents of \cite[Hypothesis 18.10]{Adriazola}. We take the initial threshold large enough for the weight estimates of \ref{8JVK} and the analytic estimates of \ref{8JVH}.') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM results WHERE id = 132 AND tag = '8JUD' AND revision = 3
      AND instr(statement_tex, 'Fix a primitive $\psi$ of order $o$ and take the \hyperref[8JVE]{Fourier data} and the estimates of \ref{8JVH}. For all sufficiently large $x$ in the window,') > 0
      AND instr(statement_tex, 'where $D_\psi$ is defined in \ref{8JVF}. The threshold depends only on $\psi$ and $\varepsilon$.') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM results WHERE id = 134 AND tag = '8JUF' AND revision = 3
      AND instr(statement_tex, 'For each primitive $\psi$ there is $0<\varepsilon_0\le1/52$ with the following property. For each $0<\varepsilon<\varepsilon_0$ there is a threshold $x_{\rm arith}\ge3$ depending only on $\psi,\varepsilon$.') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM proofs WHERE id = 119 AND result_id = 134 AND revision = 3
      AND instr(body_tex, 'Choose $x_{\rm arith}$ large enough for the per-shift bound of \ref{8JUA} and the estimates of \ref{8JUG}.') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM proofs WHERE id = 135 AND result_id = 164 AND revision = 1
      AND instr(body_tex, 'Take the window of \ref{8JUF} in Chapter 3, raising the requested lower bound for $Y$ to meet the thresholds in \ref{8JVK} and \ref{8JVH}.') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM proofs WHERE id = 136 AND result_id = 165 AND revision = 1
      AND instr(body_tex, 'These are the analytic inputs in \cite[Section 6.3, pp.~43--44]{Adriazola}. For (i), the conductor bounds and the prime number theorem for characters give the large-cutoff estimate there, using the exclusion of real zeros from the prescribed rectangles for the varying quadratic twists. The fixed-conductor real characters are handled by enlarging the threshold. The factor $2f(x+1)$ is absorbed by the exponential for large $x$, as quantified in Proposition 5.16(iv). For (ii), apply Theorems 5.10(ii)--(iii) and 5.12(ii)--(iii) of the same source on the longer range where the pair $q,d$ was chosen. Every index has a quadratic factor from $q$ or $d$, as explained in \ref{8JU5}. See also \cite[Sections 11 and 13]{Outline}.') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM proofs WHERE id = 137 AND result_id = 166 AND revision = 1
      AND instr(body_tex, 'Fix $\psi$ and $0<\varepsilon<\varepsilon_0$ from \ref{8JVG}, and set $\eta=61\varepsilon/8$. Write $o$ for the order of $\psi$. Let $x_{\rm cmp}$ be the threshold in \ref{8JUD}, $x_{\rm wt}$ the threshold in \ref{8JVK}, and $x_{\rm aux}$ the threshold in \ref{8JVH}. Let $x_{\rm arith}$ be the threshold for the Chapter 3 estimate used in the proof of \ref{8JVG}. For a prescribed $Y_0\ge1$, use \ref{8JVG} with the starting point $Y$ at least') > 0
      AND instr(body_tex, '\max\bigl(3,Y_0,x_{\rm cmp},x_{\rm wt},x_{\rm aux},x_{\rm arith},
          (3o+28)^{8/(11\varepsilon)}\bigr).') > 0
  );

-- 8JU7 result
UPDATE results
SET statement_tex = replace(replace(statement_tex,
    'For every primitive $\psi$ there is $0<\varepsilon_0\le1/52$ such that for every $0<\varepsilon<\varepsilon_0$ and every $Y_0\ge3$ the construction gives real $Y\ge Y_0$ and auxiliary primes $q,d$ fixed on $[Y,Y^{3/2}]$. At each real $x$ in that window it gives the groups of \ref{8JVC} and \ref{8JVP}, a nonempty set $T\subseteq A$, and integral theta-lift data with \hyperref[8JV2]{error exponents} $e_D=2$ and $e_L=0$.',
    'For each primitive $\psi$ there is $0<\varepsilon_0=\varepsilon_0(\psi)\le1/52$. For each $0<\varepsilon<\varepsilon_0$, fix the exponent $J=J(\psi,\varepsilon)\ge2$ of \cite[Proposition 18.4]{Adriazola}. For each $Y_0\ge3$ there exist a base $Y_{\rm base}\ge3$, a real $Y\ge Y_0$ with $Y_{\rm base}\le Y$ and $Y^2\le Y_{\rm base}^J$, and auxiliary primes $q,d$ fixed on $[Y,Y^{3/2}]$. The primes satisfy the conclusions of \cite[Theorems 5.10 and 5.12]{Adriazola} at $Y_{\rm base}$ with $K=J$ and $\tau=\varepsilon$. At each real $x$ in the window, admissible data in the sense of \cite[Definition 18.1]{Adriazola} give the groups of \ref{8JVC} and \ref{8JVP} and a nonempty set $T\subseteq A$. With these choices there are integral theta-lift data with \hyperref[8JV2]{error exponents} $e_D=2$ and $e_L=0$.'),
    '|\mu_C-\lambda_C|\le x^{-1+\varepsilon}.
\]',
    '|\mu_C-\lambda_C|\le x^{-1+\varepsilon}.
\]
For the window argument see \cite[Section 11]{Outline} and \cite[Proposition 18.4]{Adriazola}. For the coset proportions of $T$, see \cite[Lemma 5.18 and Proposition 5.20]{Adriazola}.'),
  statement_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 126;

-- 8JU9 result
UPDATE results
SET statement_tex = replace(replace(replace(replace(replace(replace(replace(replace(statement_tex,
    '\qquad \alpha\longmapsto w_\alpha=w(\alpha).
\]',
    '\qquad \alpha\longmapsto w_\alpha=w(\alpha).
\]
Translation by $(1,1,t)$ changes the first bit from $1$ to $0$, so $p_t$ is a bijection. Write the weights on the counted coset as
\[
w^t=w\circ p_t\colon B\smallsetminus\Phi\longrightarrow(0,\infty),
\qquad w^t(g)=w_{p_t(g)}.
\]'),
    'For any real $a>0$, define the real-valued count $S$ on triples $(t,a,w)$ and the main term $M$ with values in $\C$ on pairs $(a,w)$ by',
    'For any real $\upsilon>0$, define the real-valued count $S$ on triples $(t,\upsilon,w)$ and the main term $M$ with values in $\C$ on pairs $(\upsilon,w)$ by'),
    'S(t,a,w)&=', 'S(t,\upsilon,w)&='),
    '\frac{2\mathbf 1_{g-iF_p\in I_p}}{|I_p|}\ln p\,
\left(\frac{a}{p^i}-w_{p_t(g)}\right)_+,',
    '\frac{2\mathbf 1_{g-i\vartheta_p\in I_p}}{|I_p|}\ln p\,
\left(\frac{\upsilon}{p^i}-w^t(g)\right)_+,'),
    'M(a,w)&=a\left(\ln a-',
    'M(\upsilon,w)&=\upsilon\left(\ln\upsilon-'),
    'Here $\gamma$ is Euler''s constant.',
    'Here $\gamma$ is Euler''s constant.

The count runs over prime powers $p^i$ and the members $g$ of their class coset $i\vartheta_p+I_p$ with $\xi_c(g)=-1$. Each such member contributes its share $1/|I_p|$ with von Mangoldt weight $\ln p$. The factor $2$ accounts for restricting to half of $B$ and turns the Fourier normalization $1/|B|$ into $1/f$ in \ref{8JVD}. At $p\nmid N$, the coset is a singleton, so the class condition selects odd powers of primes with $\xi_c(\vartheta_p)=-1$.

For $W=w^t(g)$, the smoothing identity
\[
\left(\frac{\upsilon}{p^i}-W\right)_+
=W\left(\frac{\upsilon/W}{p^i}-1\right)_+
\]
gives $W$ times the \hyperref[8JF7]{Chapter 1 smoothing} at cutoff $\upsilon/W$. A prime power contributes at that class only when $p^i<\upsilon/W$. At fixed $\upsilon$ and $w$, the count $S(t,\upsilon,w)$ depends on $t$ through the assignment $g\mapsto w^t(g)$. Changing $t$ permutes which counted class receives each weight.

When $w_\alpha\le\upsilon$ for every $\alpha\in\Phi$, the proof of \ref{8JVD} obtains $M(\upsilon,w)$ from the Chapter 1 main terms in the Fourier expansion. The character $\xi_c$ of \ref{8JVP} is $-1$ exactly when the bit $e_1$ at $d$ is $1$. The indicator of the counted coset is $\mathbf 1_{B\smallsetminus\Phi}=(1-\xi_c)/2$, so only the trivial character and $\xi_c$ have nonzero coefficients when averaging characters over $g\notin\Phi$. The trivial character gives the pole term. For $\xi_c$, the weighted Chapter 1 main term at each class is $-\upsilon L''(1,\xi_c^*)/L(1,\xi_c^*)$. The coefficient $-1$ from the coset average gives the plus sign in $M(\upsilon,w)$.

The bijection $p_t$ gives
\[
\sum_{g\notin\Phi}\ln w(p_t(g))=\sum_{\alpha\in\Phi}\ln w_\alpha,
\]
so $M(\upsilon,w)$ is independent of $t$ at fixed $\upsilon$ and $w$. Subtracting $\Re M(\upsilon,w)$ leaves the real Fourier sum of the centered functions $G_{\xi^*}$. With the data of \ref{8JVK}, \ref{8JVF} sums, averages, and normalizes these centered counts to form $D_\psi(x)$.'),
    'B\setminus\Phi',
    'B\smallsetminus\Phi'),
    'g\longmapsto g+((1,1),t).',
    'g\longmapsto g+(1,1,t).'),
  statement_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 128;

-- 8JUC result
UPDATE results
SET statement_tex = replace(statement_tex,
    'a_t', '\upsilon_t'),
  statement_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 131;

-- 8JUD result
UPDATE results
SET statement_tex = replace(replace(statement_tex,
    'Fix a primitive $\psi$ of order $o$ and take the \hyperref[8JVE]{Fourier data} and the estimates of \ref{8JVH}. For all sufficiently large $x$ in the window,',
    'For each primitive $\psi$ of order $o$, take $\varepsilon_0(\psi)$ from \ref{8JU7}. For each $0<\varepsilon<\varepsilon_0(\psi)$ there is $x_{\rm cmp}=x_{\rm cmp}(\psi,\varepsilon)\ge\max(x_{\rm wt},x_{\rm aux})$, with $x_{\rm wt}$ from \ref{8JVK} and $x_{\rm aux}$ from \ref{8JVH}. For every window $[Y,Y^{3/2}]$ and primes $q,d$ as in \ref{8JU7}, and every real $x\in[Y,Y^{3/2}]$ with $x\ge x_{\rm cmp}$, take the \hyperref[8JVE]{Fourier data} and the estimates of \ref{8JVH}. Then'),
    'where $D_\psi$ is defined in \ref{8JVF}. The threshold depends only on $\psi$ and $\varepsilon$.',
    'where $D_\psi$ is defined in \ref{8JVF}.'),
  statement_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 132;

-- 8JUE result
UPDATE results
SET statement_tex = replace(replace(replace(replace(statement_tex,
    '$\chi$ and real $a,w,w''>0$', '$\chi$ and real $\upsilon,w,w''>0$'),
    'w,w''\le a', 'w,w''\le\upsilon'),
    'a/w', '\upsilon/w'),
    '\frac{3a}', '\frac{3\upsilon}'),
  statement_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 133;

-- 8JUF result
UPDATE results
SET statement_tex = replace(statement_tex,
    'For each primitive $\psi$ there is $0<\varepsilon_0\le1/52$ with the following property. For each $0<\varepsilon<\varepsilon_0$ there is a threshold $x_{\rm arith}\ge3$ depending only on $\psi,\varepsilon$.',
    'For each primitive $\psi$, take $\varepsilon_0(\psi)$ from \ref{8JU7}. For each $0<\varepsilon<\varepsilon_0(\psi)$ there is a threshold $x_{\rm arith}=x_{\rm arith}(\psi,\varepsilon)\ge x_{\rm wt}$, with $x_{\rm wt}$ from \ref{8JVK}.'),
  statement_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 134;

-- 8JUW result
UPDATE results
SET statement_tex = replace(statement_tex,
    '\mathcal H\setminus\mathcal K',
    '\mathcal H\smallsetminus\mathcal K'),
  statement_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 153;

-- 8JV2 result
UPDATE results
SET statement_tex = replace(replace(replace(replace(statement_tex,
    '\,a\Lambda_a', '\,\upsilon\Lambda_{\upsilon}'),
    '$a=xb$', '$\upsilon=xb$'),
    '\Lambda_a=\ln(a\,', '\Lambda_{\upsilon}=\ln(\upsilon\,'),
    'The nonnegative numbers $e_D,e_L$ are error exponents if there is a constant $C>0$, independent of $x$, such that at every scale of the construction and for every $u_0\in A_0$,',
    'The nonnegative numbers $e_D,e_L$ are error exponents if there is a constant $C>0$, independent of $x$, such that for the theta-lift chains at all scales $x$ of the construction and for every $u_0\in A_0$,'),
  statement_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 154;

-- 8JVD result
UPDATE results
SET statement_tex = replace(replace(replace(statement_tex,
    'For any $t,a,w$ as in \ref{8JU9} with $w_\alpha\le a$ for every $\alpha\in\Phi$, write the weights on the counted classes as
\[
w\circ p_t\colon B\setminus\Phi\longrightarrow(0,\infty),
\qquad g\longmapsto w_g=w_{p_t(g)}.
\]',
    'For any $t,\upsilon,w$ as in \ref{8JU9} with $w_\alpha\le\upsilon$ for every $\alpha\in\Phi$, write $w^t=w\circ p_t$ for the shifted weights on $B\smallsetminus\Phi$.'),
    'S(t,a,w)-\Re M(a,w)',
    'S(t,\upsilon,w)-\Re M(\upsilon,w)'),
    'w_g G_{\xi^*}(a/w_g)',
    'w^t(g)G_{\xi^*}(\upsilon/w^t(g))'),
  statement_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 161;

-- 8JVE result
UPDATE results
SET statement_tex = replace(statement_tex,
    'a_t', '\upsilon_t'),
  statement_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 162;

-- 8JVF result
UPDATE results
SET statement_tex = replace(statement_tex,
    'a_t', '\upsilon_t'),
  statement_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 163;

-- 8JVG result
UPDATE results
SET statement_tex = replace(statement_tex,
    'For each primitive $\psi$ there is $0<\varepsilon_0\le1/52$ with the following property. For every $\eta>0$, every $0<\varepsilon<\varepsilon_0$ with $61\varepsilon/8\le\eta$, and every $Y_0\ge3$, there is a window $[Y,Y^{3/2}]$ with $Y\ge Y_0$ and a pair of auxiliary primes $q,d$ fixed on that window. At every real $x$ in the window the construction supplies the data of \ref{8JVE}, satisfying the estimates of \ref{8JVH}, with',
    'For each primitive $\psi$, take $\varepsilon_0(\psi)$ from \ref{8JU7}. For every $\eta>0$, every $0<\varepsilon<\varepsilon_0(\psi)$ with $61\varepsilon/8\le\eta$, and every $Y_0\ge3$, there is a window $[Y,Y^{3/2}]$ and a pair of auxiliary primes $q,d$ as in \ref{8JU7}, with $Y\ge\max(Y_0,x_{\rm arith},x_{\rm aux})$. Here $x_{\rm arith}$ is from \ref{8JUF} and $x_{\rm aux}$ is from \ref{8JVH}. At every real $x$ in the window, the choices from \ref{8JU7}, \ref{8JVK}, and \ref{8JUG} give the data of \ref{8JVE}, satisfying the estimates of \ref{8JVH}, with'),
  statement_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 164;

-- 8JVH result
UPDATE results
SET statement_tex = replace(statement_tex,
    'Fix any primitive $\psi$ and any sufficiently small $\varepsilon>0$. Use the primes $q,d$ and the data of \ref{8JVE} supplied by the arithmetic construction on a window $[Y,Y^{3/2}]$. Use the representative $\xi^*$ from \ref{8JVQ} and the \hyperref[8JF7]{smoothed prime sum} $G_{\xi^*}$. The following estimates hold at every sufficiently large $x$ in the window, with a threshold depending only on $\psi,\varepsilon$.',
    'For each primitive $\psi$, take $\varepsilon_0(\psi)$ from \ref{8JU7}. For each $0<\varepsilon<\varepsilon_0(\psi)$ there is $x_{\rm aux}=x_{\rm aux}(\psi,\varepsilon)\ge x_{\rm wt}$, with $x_{\rm wt}$ from \ref{8JVK}, such that the following estimates hold for every window $[Y,Y^{3/2}]$ and primes $q,d$ as in \ref{8JU7} and every real $x\in[Y,Y^{3/2}]$ with $x\ge x_{\rm aux}$. Use the Fourier data of \ref{8JVE}, the representative $\xi^*$ from \ref{8JVQ}, and the \hyperref[8JF7]{smoothed prime sum} $G_{\xi^*}$.'),
  statement_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 165;

-- 8JVK result
UPDATE results
SET statement_tex = replace(replace(replace(replace(replace(replace(statement_tex,
    'a_t', '\upsilon_t'),
    '\Phi\setminus\Phi_u', '\Phi\smallsetminus\Phi_u'),
    'Fix a primitive $\psi$ and a sufficiently small $\varepsilon>0$. Use the groups of \ref{8JVC} and \ref{8JVP} and the nonempty set $T\subseteq A$ supplied by the arithmetic construction at each point of a window $[Y,Y^{3/2}]$. For all sufficiently large $x$ in this window, with a threshold depending only on $\psi,\varepsilon$, put',
    'For each primitive $\psi$, take $\varepsilon_0(\psi)$ from \ref{8JU7}. For each $0<\varepsilon<\varepsilon_0(\psi)$ there is $x_{\rm wt}=x_{\rm wt}(\varepsilon)\ge3$ such that the following holds for every window $[Y,Y^{3/2}]$ and primes $q,d$ as in \ref{8JU7} and every real $x\in[Y,Y^{3/2}]$ with $x\ge x_{\rm wt}$. Use the groups of \ref{8JVC} and \ref{8JVP} and the nonempty $T\subseteq A$ of \ref{8JU7} at $x$. Put'),
    'The chain length is an integer $m\ge1$.',
    'The data at $x$ include a chain of $m\ge1$ successive theta lifts between spaces of automorphic forms on definite unitary groups of increasing rank.'),
    '\Phi_u=\left\{((0,1),z+u)\in\Phi \;\middle|\; z\in T_2\right\}.',
    '\Phi_u=\left\{(0,1,z+u)\in\Phi \;\middle|\; z\in T_2\right\}.'),
    'There is a real $\rho_w$ with $0\le\rho_w\le b$ and $6f(x+1)\rho_w\le b/x$ such that for every $u\in A_0$ and every integer $1\le j\le m$ there is a weight function
\[
w_{u,j}\colon\Phi\longrightarrow(0,\infty)
\]
with',
    'There is a real $\rho_w$ with $0\le\rho_w\le b$ and $6f(x+1)\rho_w\le b/x$. For each $u\in A_0$ and each integer $1\le j\le m$, the weight function $w_{u,j}\colon\Phi\to(0,\infty)$ records the archimedean parameter at each label $\alpha\in\Phi$ for the $j$th lift. It satisfies'),
  title = 'Scales and weights for the theta lifts',
  statement_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 167;

-- 8JVM result
UPDATE results
SET statement_tex = replace(replace(statement_tex,
    '$B=(\Z/2\Z)^2\times A$ has $16$ elements and $\Phi=\{0\}\times(\Z/2\Z)\times A$ has $8$.',
    '$B=\Z/2\Z\times\Z/2\Z\times A$ has $16$ elements and $\Phi=\{0\}\times\Z/2\Z\times A$ has $8$.'),
    '$F_{13}=((1,0),(1,1))$. Here $\xi_c(F_{13})=-1$, so the odd powers of $13$ enter the count in \ref{8JU9}.',
    '$\vartheta_{13}=(1,0,(1,1))$. Here $\xi_c(\vartheta_{13})=-1$, so the class condition in \ref{8JU9} selects the odd powers of $13$.'),
  statement_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 168;

-- 8JVP result
UPDATE results
SET statement_tex = replace(replace(replace(replace(replace(statement_tex,
    '\left\{((0,e_2),v)\in B \;\middle|\; e_2\in\Z/2\Z,\ v\in A\right\}',
    '\{0\}\times\Z/2\Z\times A'),
    'A&\longrightarrow B, & v&\longmapsto((0,0),v).
\end{align*}',
    'A&\longrightarrow B, & v&\longmapsto(0,0,v).
\end{align*}
The character $\xi_c$ reads the first quadratic bit, at $d$. Its kernel is $\Phi$, and the other coset $B\smallsetminus\Phi$ consists of the classes with $e_1=1$, for which $\xi_c=-1$. Thus
\[
\mathbf 1_{B\smallsetminus\Phi}=\frac{1-\xi_c}{2}.
\]'),
    'B=(\Z/2\Z)^2\times A,',
    'B=\Z/2\Z\times\Z/2\Z\times A,'),
    'v\longmapsto((e_1(v),e_2(v)),[v]_A).',
    'v\longmapsto(e_1(v),e_2(v),[v]_A).'),
    '((e_1,e_2),v)&\longmapsto(-1)^{e_1}',
    '(e_1,e_2,v)&\longmapsto(-1)^{e_1}'),
  statement_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 170;

-- 8JVQ result
UPDATE results
SET statement_tex = replace(statement_tex,
    'F_p', '\vartheta_p'),
  statement_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 171;

-- 8JU7 proof
UPDATE proofs
SET body_tex = replace(replace(body_tex,
    '\emph{(1)} Choose $q$, then $d$, in the prescribed residue classes. Zero-density and mean-square estimates bound the candidates that fail the zero-free or smoothed-sum tests. Taking the union over the finitely many characters at the fixed modulus still leaves admissible primes. The same pair works throughout the range used in the field construction. See \cite[Theorems 5.10 and 5.12]{Adriazola} and \cite[Section 11]{Outline}.',
    '\emph{(1)} Fix $J$ as in \cite[Proposition 18.4]{Adriazola} for this $\psi,\varepsilon$. Choose $q$, then $d$, at $Y_{\rm base}$ using \cite[Theorems 5.10 and 5.12]{Adriazola} with $K=J$ and $\tau=\varepsilon$. Zero-density and mean-square estimates bound the candidates that fail the zero-free or smoothed-sum tests. Taking the union over the finitely many characters at the fixed modulus still leaves admissible primes. The pair works on $[Y_{\rm base},Y_{\rm base}^J]$, which contains $[Y,Y^{3/2}]$ by $Y_{\rm base}\le Y$ and $Y^2\le Y_{\rm base}^J$. See also \cite[Section 11]{Outline}.'),
    'The chain data at these scales use the local and global matching inputs and the exponents of \cite[Hypothesis 18.10]{Adriazola}. We take the initial threshold large enough for the weight estimates of \ref{8JVK} and the analytic estimates of \ref{8JVH}.',
    'Take $\varepsilon_0(\psi)$ to be the bound $\varepsilon_1$ in \cite[Hypothesis 18.10]{Adriazola}. For the fixed $J$, the chain data at these scales use the threshold and exponents of that hypothesis, as in the proof of Theorem A in Section 18.6. Take $Y_{\rm base}$ large enough for prime selection and admissibility and $Y$ large enough for the chain-record threshold.'),
  body_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 112;

-- 8JUA proof
UPDATE proofs
SET body_tex = replace(body_tex,
    'a_t', '\upsilon_t'),
  body_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 114;

-- 8JUC proof
UPDATE proofs
SET body_tex = replace(body_tex,
    'a_t', '\upsilon_t'),
  body_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 116;

-- 8JUD proof
UPDATE proofs
SET body_tex = replace(replace(replace(replace(replace(replace(replace(body_tex,
    'At a label $\alpha\in\Phi_u$, write $w=w_{u,j}(\alpha)$.',
    'At a label $\alpha=p_t(g)\in\Phi_u$, write $w=w_{u,j}^t(g)=w_{u,j}(\alpha)$.'),
    'At each other label $\alpha\in\Phi\setminus\Phi_u$, the weight $w=w_{u,j}(\alpha)$ satisfies $w\le2b''$',
    'At each other label $\alpha=p_t(g)\in\Phi\smallsetminus\Phi_u$, the weight $w=w_{u,j}^t(g)$ satisfies $w\le2b''$'),
    'a_t',
    '\upsilon_t'),
    'For each $z\in T_2$, the class assigning the weight at $((0,1),z+u)$ is $g=((1,0),z+u-t)$, by $p_t$ in \ref{8JU9}.',
    'For each $z\in T_2$, the class assigning the weight at $(0,1,z+u)$ is $g=(1,0,z+u-t)$, by $p_t$ in \ref{8JU9}.'),
    '$\sigma_\xi=\xi((1,0),0)\in\{1,-1\}$',
    '$\sigma_\xi=\xi(1,0,0)\in\{1,-1\}$'),
    '$B/A_0=(\Z/2\Z)^2\times(A/A_0)$',
    '$B/A_0=\Z/2\Z\times\Z/2\Z\times(A/A_0)$'),
    'Both logarithmic errors together are $o(x^{1/2+\varepsilon})$ and hence at most $4x^{1/2+\varepsilon}$ once $x$ is large enough. All their constants depend only on $\psi$ and $\varepsilon$, which gives the stated uniform comparison.',
    'The sum of these two errors is $o(x^{1/2+\varepsilon})$, uniformly in the window, since the constants depend only on $\psi,\varepsilon$. Choose $x_{\rm cmp}\ge\max(x_{\rm wt},x_{\rm aux})$ so that the sum is at most $4x^{1/2+\varepsilon}$ at every $x\ge x_{\rm cmp}$.'),
  body_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 117;

-- 8JUE proof
UPDATE proofs
SET body_tex = replace(replace(replace(replace(replace(replace(replace(body_tex,
    '(0,a]', '(0,\upsilon]'),
    'a/v', '\upsilon/v'),
    'a/n', '\upsilon/n'),
    'aL''', '\upsilon L'''),
    '-a\ln', '-\upsilon\ln'),
    '(1+\gamma)a', '(1+\gamma)\upsilon'),
    '3a/', '3\upsilon/'),
  body_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 118;

-- 8JUF proof
UPDATE proofs
SET body_tex = replace(body_tex,
    'Choose $x_{\rm arith}$ large enough for the per-shift bound of \ref{8JUA} and the estimates of \ref{8JUG}.',
    'Choose $x_{\rm arith}\ge x_{\rm wt}$ large enough for the per-shift bound of \ref{8JUA} and the estimates of \ref{8JUG}. The chain-record threshold uses the exponent $J(\psi,\varepsilon)$ fixed in \ref{8JU7}.'),
  body_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 119;

-- 8JVD proof
UPDATE proofs
SET body_tex = replace(replace(body_tex,
    'F_p',
    '\vartheta_p'),
    '\emph{(c) Compute the main term.} Write $R_{\xi^*}=G_{\xi^*}+M_{\xi^*}$ as in \ref{8JS3}. Since $p_t$ is the bijection to $\Phi$ described in \ref{8JV7}, the trivial character contributes
\[
\frac1f\sum_{g\notin\Phi} w_g M_{\mathbf1}(a/w_g)
=\frac af\sum_{\alpha\in\Phi}
\bigl(\ln a-\ln w_\alpha-1-\gamma\bigr).
\]
For every nontrivial $\xi$ the term $w_gM_{\xi^*}(a/w_g)$ is the constant $-aL''(1,\xi^*)/L(1,\xi^*)$. Hence its total coefficient is $f^{-1}\sum_{g\notin\Phi}\overline{\xi(g)}$. The summation set is a single coset of $\Phi$, so \ref{8JV9} makes this zero if $\xi|_\Phi\ne1$. The only nontrivial character of $B/\Phi$ is $\xi_c$ and its coefficient is $-1$, giving $+aL''(1,\xi_c^*)/L(1,\xi_c^*)$. These are exactly the terms in $M(a,w)$. Taking real parts proves the identity. There is no residual term at the primes dividing $N$, since (a) already accounts for their local factors.',
    '\emph{(c) Compute the main term.} Write $R_{\xi^*}=G_{\xi^*}+M_{\xi^*}$ as in \ref{8JS3}. Since $p_t$ is the bijection to $\Phi$ of \ref{8JU9}, the trivial character contributes
\[
\frac1f\sum_{g\notin\Phi} w^t(g)M_{\mathbf1}(\upsilon/w^t(g))
=\frac{\upsilon}{f}\sum_{\alpha\in\Phi}
\bigl(\ln\upsilon-\ln w_\alpha-1-\gamma\bigr).
\]
For every nontrivial $\xi$, the term $w^t(g)M_{\xi^*}(\upsilon/w^t(g))$ is the constant $-\upsilon L''(1,\xi^*)/L(1,\xi^*)$. Its coefficient is $f^{-1}\sum_{g\notin\Phi}\overline{\xi(g)}$. By $\mathbf 1_{B\smallsetminus\Phi}=(1-\xi_c)/2$ from \ref{8JVP} and character orthogonality, among the nontrivial characters only $\xi_c$ has a nonzero coefficient, namely $-1$. The contribution of $\xi_c$ is therefore $+\upsilon L''(1,\xi_c^*)/L(1,\xi_c^*)$. Adding the two contributions gives
\[
M(\upsilon,w)=\frac1f\sum_{g\notin\Phi}w^t(g)
\bigl(M_{\mathbf1}(\upsilon/w^t(g))-M_{\xi_c^*}(\upsilon/w^t(g))\bigr).
\]
Taking real parts proves the identity. Part (a) accounts for all primes dividing $N$.'),
  body_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 134;

-- 8JVG proof
UPDATE proofs
SET body_tex = replace(body_tex,
    'Take the window of \ref{8JUF} in Chapter 3, raising the requested lower bound for $Y$ to meet the thresholds in \ref{8JVK} and \ref{8JVH}.',
    'Apply \ref{8JUF} with requested lower bound $\max(Y_0,x_{\rm aux})$ for $Y$. This gives $Y\ge\max(Y_0,x_{\rm arith},x_{\rm aux})$, with $x_{\rm arith}\ge x_{\rm wt}$.'),
  body_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 135;

-- 8JVH proof
UPDATE proofs
SET body_tex = 'For (i), use the conductor bound $\ln\operatorname{cond}(\xi^*)\le C(\psi)x^{\varepsilon/5}(\ln x)^2$ in \cite[Section 6.3, pp.~43--44]{Adriazola}. It follows from the bounds for $q,d$ at $Y_{\rm base}\le x$ and $N_1\le8N_0|A|$. Real characters involving $q$ or $d$ have the uniform real-zero exclusion in Corollary 5.13. The remaining real characters have conductors dividing a fixed modulus, since real characters of $2$-power conductor have conductor at most $8$. Proposition 5.3 and its trivial-character variant therefore give a uniform large-cutoff bound for $y\ge X''/3$. In the exponential terms of that estimate, the powers $\varepsilon/3-\varepsilon/5$ and $\varepsilon/6$ both exceed $\varepsilon/8$. Increasing $x_{\rm aux}$ gives the stated bound, including $2f(x+1)\omega_x\le1/x$ by Proposition 5.16(iv).

For (ii), every index has a quadratic factor at $q$ or $d$, as explained in \ref{8JU5}. Theorems 5.10(ii)--(iii) and 5.12(ii)--(iii) apply on $[Y_{\rm base},Y_{\rm base}^{J}]$ with the fixed $J=J(\psi,\varepsilon)$ of \ref{8JU7}. The logarithmic derivative is bounded by $401c_0J\ln Y_{\rm base}\le401c_0J\ln(x+1)$, with the absolute $c_0$ of those theorems. These estimates are uniform over the windows of \ref{8JU7}. Choose $x_{\rm aux}\ge x_{\rm wt}$ to meet the requirements of (i).',
  body_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 136;

-- 8JVJ proof
UPDATE proofs
SET body_tex = replace(replace(body_tex,
    'Fix $\psi$ and $0<\varepsilon<\varepsilon_0$ from \ref{8JVG}, and set $\eta=61\varepsilon/8$. Write $o$ for the order of $\psi$. Let $x_{\rm cmp}$ be the threshold in \ref{8JUD}, $x_{\rm wt}$ the threshold in \ref{8JVK}, and $x_{\rm aux}$ the threshold in \ref{8JVH}. Let $x_{\rm arith}$ be the threshold for the Chapter 3 estimate used in the proof of \ref{8JVG}. For a prescribed $Y_0\ge1$, use \ref{8JVG} with the starting point $Y$ at least',
    'Fix $\psi$ and $0<\varepsilon<\varepsilon_0(\psi)$ from \ref{8JU7}, and set $\eta=61\varepsilon/8$. Write $o$ for the order of $\psi$. Use $x_{\rm cmp}$ from \ref{8JUD}, which is at least $x_{\rm wt}$ from \ref{8JVK} and $x_{\rm aux}$ from \ref{8JVH}. For a prescribed $Y_0\ge1$, apply \ref{8JVG} with the requested lower bound for $Y$ equal to'),
    '\max\bigl(3,Y_0,x_{\rm cmp},x_{\rm wt},x_{\rm aux},x_{\rm arith},
          (3o+28)^{8/(11\varepsilon)}\bigr).',
    '\max\bigl(Y_0,x_{\rm cmp},(3o+28)^{8/(11\varepsilon)}\bigr).'),
  body_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 137;

-- 8JVK proof
UPDATE proofs
SET body_tex = 'The sequence of maps is the one in \cite[Sections 5.8 and 7, p.~54]{Adriazola}. The kernel of each step defines a map on automorphic forms by summation over the lattice classes at that level. The fixed rank increment is the number of copies of the auxiliary hermitian space added at each step, as in Section 18.1.

The scales $\upsilon_t$ are the integers in \cite[Definition 18.5]{Adriazola}. The set $T_2$ is the image of the integer set in Proposition 5.17 under multiplication by a generator of $A_0$, as in Section 5.8. Proposition 18.7 gives a base value $b_1(\alpha)$ at each label for each $u$ and sets
\[
w_{u,j}(\alpha)=b_1(\alpha)+(j-\tfrac12)h_0,\qquad h_0=2\lceil x^{402}\rceil .
\]
These are the second family of archimedean parameters in Corollary 18.8, one function of the label per lift. At the labels in $\Phi_u$ the base values lie between $\lceil b\rceil$ and $\lceil b\rceil+W-1$, where $W$ is the number of roots of unity in the auxiliary field. Use $\rho_w=W+mh_0$.

Proposition 5.16 and Corollary 18.8 apply with $|A|\le2x^{9/4}$, $m\le2\sqrt x$ and $W\le32|A|^2$. These bounds follow from admissibility and are uniform in the window, the primes and the character. Since the proposition fixes the exponent of $h_0$ at $402$ here, its threshold depends only on $\varepsilon$. Increase it, still using only $\varepsilon$, to ensure $X''\ge3$ and the integer intervals in Definition 18.5 are nonempty. For those intervals, $k\le2x^{9/2+10\varepsilon}$ by Proposition 5.15(i), so both $xb/(kx^{13})$ and $b''/x^2$ eventually exceed $1$. Proposition 5.16(iii) gives $|\upsilon_t/b-x|\le1$, and (i)--(ii) with Corollary 18.8 give the weight bounds.',
  body_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 138;

-- 8JU2 section
UPDATE sections
SET intro_tex = replace(intro_tex,
    'The construction gives intervals $[Y,Y^{3/2}]$ with $Y$ arbitrarily large.',
    '\ref{8JU7} gives intervals $[Y,Y^{3/2}]$ with $Y$ arbitrarily large.'),
  intro_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 105;

-- 8JU3 section
UPDATE sections
SET intro_tex = replace(replace(intro_tex,
    'The construction uses the freedom along the tower to choose many shifts without too many collisions in short progressions.',
    'The choice of the shift set $T$ in \ref{8JU7} uses the freedom along the tower to obtain many shifts without too many collisions in short progressions.'),
    'In Adriazola''s notation the auxiliary field has group $B=(\Z/2\Z)^2\times A$ as in \ref{8JVP}.',
    'The auxiliary field in Adriazola''s construction has group $B=\Z/2\Z\times\Z/2\Z\times A$ as in \ref{8JVP}.'),
  intro_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 106;

-- 8JU5 section
UPDATE sections
SET intro_tex = replace(replace(intro_tex,
    'a_t', '\upsilon_t'),
    'Their prime sums are small because the arithmetic construction chooses the auxiliary primes $q,d$ for this purpose.',
    'Their prime sums are small by the choice of the auxiliary primes $q,d$ in \ref{8JU7}.'),
  intro_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 108;

-- 8JV7 section
UPDATE sections
SET intro_tex = replace(replace(replace(replace(replace(replace(replace(intro_tex,
    ' Changing $t$ permutes the assigned weights. The factor $2$ in the count compensates for using half the classes and changes the Fourier factor $1/|B|$ to $1/f$.',
    ''),
    'F_p',
    '\vartheta_p'),
    '

For any scale $a>0$ and any individual weight value $W>0$, the identity
\[
\left(\frac a{p^i}-W\right)_+
=W\left(\frac{a/W}{p^i}-1\right)_+
\]
gives the \hyperref[8JF7]{Chapter 1 smoothing} at cutoff $a/W$. The proof of \ref{8JVD} derives the main term $M(a,w)$ that is subtracted in the next section.',
    ''),
    'The count in \ref{8JU9} and the Fourier expansion in \ref{8JVD} allow arbitrary positive weight functions (with $w_\alpha\le a$ in the Fourier expansion), and \ref{8JVK} in §2.3 supplies the particular weight functions $w_{u,j}$ used in the construction.',
    'The count in \ref{8JU9} and the Fourier expansion in \ref{8JVD} allow arbitrary positive weight functions (with $w_\alpha\le\upsilon$ in the Fourier expansion), and \ref{8JVK} in §2.3 supplies the particular weight functions $w_{u,j}$ used in the normalized count of \ref{8JVF}.'),
    'B\setminus\Phi',
    'B\smallsetminus\Phi'),
    'The map $\pi$ sends a unit modulo $N=N_1qd$ to its class in $A$ and the two quadratic bits.',
    'The map $\pi$ sends a unit modulo $N=N_1qd$ to its two quadratic bits followed by its class in $A$.'),
    'the map $p_t$ of \ref{8JU9} adds $((1,1),t)$.',
    'the map $p_t$ of \ref{8JU9} adds $(1,1,t)$.'),
  intro_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 113;

-- 8JV8 section
UPDATE sections
SET intro_tex = replace(replace(intro_tex,
    'The arithmetic construction supplies arbitrarily distant windows $[Y,Y^{3/2}]$. The primes $q,d$ are fixed on a window, while the groups and weights can depend on the point $x$ in it. \ref{8JVK} gives the number $a_t$ for each shift $t\in T$ and the weight functions $w_{u,j}$ for each $u\in A_0$. The index $j=1,\dots,m$ runs over the $m$ steps of the construction, one weight function per step.',
    '\ref{8JU7} gives windows $[Y,Y^{3/2}]$ with $Y$ arbitrarily large. The primes $q,d$ are fixed on each window, while the groups and the shift set $T$ from \ref{8JU7} can depend on the point $x$. At each $x\ge x_{\rm wt}$, \ref{8JVK} gives the scale $\upsilon_t$ for each $t\in T$ and a weight function $w_{u,j}$ for each $u\in A_0$ and each lift $j=1,\dots,m$ in the theta-lift chain.'),
    'a_t', '\upsilon_t'),
  intro_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 20:00:00',
  updated_by = 'codex'
WHERE id = 114;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'notation-cleanup-2026-11-26',
  json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex,
    'section_id', section_id, 'position', position, 'listed', listed,
    'aliases', json((SELECT json_group_array(alias) FROM
      (SELECT alias FROM aliases WHERE aliases.tag = results.tag ORDER BY alias)))),
  'codex', '2026-11-26 20:00:00'
FROM results WHERE id IN (126, 128, 131, 132, 133, 134, 153, 154, 161, 162, 163, 164, 165, 167, 168, 170, 171) ORDER BY id;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'section', CAST(id AS TEXT), revision, 'notation-cleanup-2026-11-26',
  json_object('tag', tag, 'kind', kind, 'title', title, 'intro_tex', intro_tex, 'parent_id', parent_id, 'position', position),
  'codex', '2026-11-26 20:00:00'
FROM sections WHERE id IN (105, 106, 108, 113, 114) ORDER BY id;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'proof', CAST(id AS TEXT), revision, 'notation-cleanup-2026-11-26',
  json_object('result_id', result_id, 'body_tex', body_tex, 'status', status,
    'generated_by', generated_by, 'generator_detail', generator_detail,
    'reviewed_by', reviewed_by, 'review_notes', review_notes, 'position', position),
  'codex', '2026-11-26 20:00:00'
FROM proofs WHERE id IN (112, 114, 116, 117, 118, 119, 134, 135, 136, 137, 138) ORDER BY id;

UPDATE settings SET value = '1' WHERE key = 'needs_rebuild' AND value <> '1';
