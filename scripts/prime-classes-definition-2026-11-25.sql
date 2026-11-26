-- Split the prime-class definition and standardize set-builder notation.
-- Apply as a single batch. The first statement guards the post-coset revisions.

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM sections WHERE id IS 113 AND tag IS '8JV7' AND kind IS 'section' AND parent_id IS 105 AND position IS 2 AND revision IS 1)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 126 AND tag IS '8JU7' AND section_id IS 106 AND position IS 2 AND revision IS 4 AND type IS 'lemma' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 128 AND tag IS '8JU9' AND section_id IS 113 AND position IS 2 AND revision IS 4 AND type IS 'definition' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 131 AND tag IS '8JUC' AND section_id IS 107 AND position IS 3 AND revision IS 4 AND type IS 'lemma' AND listed IS 0 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 153 AND tag IS '8JUW' AND section_id IS 108 AND position IS 3 AND revision IS 2 AND type IS 'definition' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 160 AND tag IS '8JVC' AND section_id IS 113 AND position IS 1 AND revision IS 1 AND type IS 'definition' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 161 AND tag IS '8JVD' AND section_id IS 113 AND position IS 3 AND revision IS 1 AND type IS 'lemma' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 162 AND tag IS '8JVE' AND section_id IS 114 AND position IS 2 AND revision IS 2 AND type IS 'definition' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 167 AND tag IS '8JVK' AND section_id IS 114 AND position IS 1 AND revision IS 1 AND type IS 'lemma' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 168 AND tag IS '8JVM' AND section_id IS 113 AND position IS 4 AND revision IS 1 AND type IS 'example' AND listed IS 0 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id IS 117 AND result_id IS 132 AND position IS 1 AND revision IS 5 AND visibility IS 'published' AND generated_by IS 'gpt')
  OR (SELECT COUNT(*) FROM results WHERE section_id = 113) <> 4
  OR (SELECT MAX(id) FROM results) IS NOT 169
  OR (SELECT MAX(id) FROM proofs) IS NOT 139
  OR (SELECT MAX(tag) FROM tags) IS NOT '8JVN'
  OR EXISTS (SELECT 1 FROM aliases WHERE alias IN ('8JVP', '8JVQ'))
  OR NOT EXISTS (SELECT 1 FROM settings WHERE key = 'macros' AND revision = 2)
  OR NOT EXISTS (SELECT 1 FROM settings WHERE key = 'needs_rebuild' AND revision = 1 AND value = '1')
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'section' AND entity_key = '113' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '126' AND revision > 4)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '128' AND revision > 4)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '131' AND revision > 4)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '153' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '160' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '161' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '162' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '167' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '168' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'proof' AND entity_key = '117' AND revision > 5)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND CAST(entity_key AS INTEGER) >= 170);

-- Preserve baseline snapshots that are missing from history.

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'section', CAST(id AS TEXT), revision, 'prime-classes-definition-2026-11-25',
  json_object('tag', tag, 'kind', kind, 'title', title, 'intro_tex', intro_tex, 'parent_id', parent_id, 'position', position),
  COALESCE(updated_by, '(before history)'), '2026-11-25 23:00:00'
FROM sections WHERE id IN (113) ORDER BY id;

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'prime-classes-definition-2026-11-25',
  json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex, 'section_id', section_id, 'position', position, 'listed', listed, 'aliases', json((SELECT json_group_array(alias) FROM (SELECT alias FROM aliases WHERE aliases.tag = results.tag ORDER BY alias)))),
  COALESCE(updated_by, '(before history)'), '2026-11-25 23:00:00'
FROM results WHERE id IN (126, 128, 131, 153, 160, 161, 162, 167, 168) ORDER BY id;

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'proof', CAST(id AS TEXT), revision, 'prime-classes-definition-2026-11-25',
  json_object('result_id', result_id, 'body_tex', body_tex, 'status', status, 'generated_by', generated_by, 'generator_detail', generator_detail, 'reviewed_by', reviewed_by, 'review_notes', review_notes, 'position', position),
  COALESCE(updated_by, '(before history)'), '2026-11-25 23:00:00'
FROM proofs WHERE id IN (117) ORDER BY id;

-- Introduce the three definitions before the count and its Fourier expansion.

UPDATE sections SET
  intro_tex = 'The weighted prime-power count in \ref{8JU9} assigns classes to prime powers and attaches weights to those classes. Three definitions supply the groups, the labels, and the local character values.

The \hyperref[8JVC]{residue groups for the averages} give the two averages of \ref{8JV6} their inputs. The modulus $N_1$ lets $A$ record both the residue modulo $2^{e+2}$ up to sign and the value of $\psi$. The groups of residues up to sign form the real cyclotomic tower, so increasing $e$ gives room to choose the shift set $T$ for the coset average in \ref{8JVA}. Requiring $\psi(v)=1$ in $U_1$ makes $\psi$ independent of the representative of a class in $A$. The uniform average in \ref{8JV9} uses $A_0=\ker\psi$. Since the image of $\psi$ has order $o$, the cosets indexed by $A/A_0$ are the $o$ character-value classes for the second average.

The \hyperref[8JVP]{quadratic coordinates} enlarge $A$ to $B$. The map $\pi$ sends a unit modulo $N=N_1qd$ to its class in $A$ and the two quadratic bits. The Chinese remainder theorem lets the bits vary independently of the class in $A$. The bit at $d$ distinguishes the half with $\xi_c=-1$, which gives the extra divisibility in the arithmetic argument. The complementary half $\Phi$ labels the weights. The bit at $q$ distinguishes the positions with weights near the reference value in \ref{8JVK}. For a shift $t\in A$, adding $((1,1),t)$ takes the counted classes bijectively to $\Phi$, and changing $t$ permutes the assigned weights. The factor $2$ in the count compensates for using half the classes and changes the Fourier factor $1/|B|$ to $1/f$. Among the characters that survive the subgroup average, those using either quadratic bit are the auxiliary twists. Their smoothed prime sums are small at the target cutoff $x$, as in \ref{8JVH}.

The \hyperref[8JVQ]{prime-power classes and primitive characters} give the inputs to the Fourier expansion in \ref{8JVD}. Away from $N$, the class of $p^i$ is a single element, and only odd powers of a prime with $\xi_c(F_p)=-1$ enter the count. The \hyperref[8JVM]{example modulo $840$} computes such a class. At $p\mid N$, the prime power has no unit class modulo $N$. The coset $iF_p+I_p$ uses its residue away from $p$ and shares its mass uniformly across the corresponding classes. The portion outside $\Phi$ enters the count. For each $\xi\in\widehat B$, the value $\xi^*(p^i)$ gives the coset average in the Fourier expansion, including when $p\mid N$.

At scale $a>0$ with weight $w>0$, the identity
\[
\left(\frac a{p^i}-w\right)_+
=w\left(\frac{a/w}{p^i}-1\right)_+
\]
gives the \hyperref[8JF7]{Chapter 1 smoothing} at cutoff $a/w$. The proof of \ref{8JVD} derives the main term $M(a,w)$ that is subtracted in the next section.',
  intro_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-25 23:00:00', updated_by = 'codex'
WHERE id = 113;

UPDATE results SET
  title = 'Residue groups for the two averages',
  statement_tex = 'Let $\psi$ be a \hyperref[8JH4]{primitive character} of conductor $N_0$ and order $o$. Take an integer $e\ge0$ and distinct primes $q,d\equiv3\pmod4$ with $qd$ coprime to $2N_0$. Put
\begin{align*}
N_1 &= \operatorname{lcm}(2^{e+2},N_0),\\
N &= N_1qd.
\end{align*}
Define the subgroup
\[
U_1=\left\{v\in(\Z/N_1\Z)^\times \;\middle|\; v\equiv\pm1\pmod{2^{e+2}},\ \psi(v)=1\right\}.
\]
With $\psi$ viewed as the induced character on the quotient via reduction modulo $N_0$, put
\begin{align*}
A &= (\Z/N_1\Z)^\times/U_1,\\
A_0 &= \ker(\psi:A\to\C^\times).
\end{align*}',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-25 23:00:00', updated_by = 'codex'
WHERE id = 160;

INSERT INTO tags (tag, kind, created_at) VALUES
  ('8JVP', 'result', '2026-11-25 23:00:00'),
  ('8JVQ', 'result', '2026-11-25 23:00:00');

INSERT INTO results (id, tag, section_id, position, listed, type, title, statement_tex, statement_html_cache, created_at, updated_at, created_by, updated_by)
VALUES (170, '8JVP', 113, 2, 1, 'definition', 'Quadratic coordinates for counting and weights', 'Use the moduli and group $A$ of \ref{8JVC}. For a unit $v$ modulo $N$, let $e_1(v)$ and $e_2(v)$ be its quadratic bits modulo $d$ and $q$, respectively, recorded as $0$ for a square and $1$ for a nonsquare. Write $[v]_A$ for the class in $A$ of its reduction modulo $N_1$. Put
\begin{align*}
B &= (\Z/2\Z)^2\times A,\\
\pi &\colon(\Z/N\Z)^\times\longrightarrow B,\\
\pi(v) &= ((e_1(v),e_2(v)),[v]_A).
\end{align*}
Define
\begin{align*}
\Phi &= \left\{((0,e_2),v)\in B \;\middle|\; e_2\in\Z/2\Z,\ v\in A\right\},\\
f &= |\Phi|=2|A|=|B|/2,\\
\xi_c((e_1,e_2),v) &= (-1)^{e_1}.
\end{align*}', NULL, '2026-11-25 23:00:00', '2026-11-25 23:00:00', 'codex', 'codex');

INSERT INTO results (id, tag, section_id, position, listed, type, title, statement_tex, statement_html_cache, created_at, updated_at, created_by, updated_by)
VALUES (171, '8JVQ', 113, 3, 1, 'definition', 'Prime-power classes and primitive characters', 'Use $N$ from \ref{8JVC} and $B,\pi$ from \ref{8JVP}. For each prime $p$, write $N=p^\nu N^{(p)}$ with $p\nmid N^{(p)}$. Let $r_p$ be the reduction map from $(\Z/N\Z)^\times$ to $(\Z/N^{(p)}\Z)^\times$. Let $u_p$ be the unit modulo $N$ congruent to $p$ modulo $N^{(p)}$ and to $1$ modulo $p^\nu$. Put
\begin{align*}
I_p &= \pi(\ker r_p),\\
F_p &= \pi(u_p).
\end{align*}
The class of $p^i$ is the coset $iF_p+I_p$. For $p\nmid N$ one has $I_p=\{0\}$ and $F_p=\pi(p\bmod N)$.

Write $\widehat B$ for the group of characters of $B$. For $\xi\in\widehat B$, write $\xi^*$ for the \hyperref[8JB2]{primitive character inducing} the Dirichlet character $\xi\circ\pi$ modulo $N$.', NULL, '2026-11-25 23:00:00', '2026-11-25 23:00:00', 'codex', 'codex');

-- Update the dependent references and the two other statements with set builders.

UPDATE results SET
  statement_tex = 'For every primitive $\psi$ there is $0<\varepsilon_0\le1/52$ such that for every $0<\varepsilon<\varepsilon_0$ and every $Y_0\ge3$ the construction gives real $Y\ge Y_0$ and auxiliary primes $q,d$ fixed on $[Y,Y^{3/2}]$. At each real $x$ in that window it gives the groups of \ref{8JVC} and \ref{8JVP}, a nonempty set $T\subseteq A$, and integral theta-lift data with \hyperref[8JV2]{error exponents} $e_D=2$ and $e_L=0$. For each coset $C\in A/A_0$ the proportions $\mu_C,\lambda_C$ of \ref{8JVA} with $k=3$ satisfy
\[
|\mu_C-\lambda_C|\le x^{-1+\varepsilon}.
\]',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-25 23:00:00', updated_by = 'codex'
WHERE id = 126;

UPDATE results SET
  position = 4,
  statement_tex = 'Use $A$ from \ref{8JVC}, the class group and weight labels of \ref{8JVP}, and the prime-power data of \ref{8JVQ}. Write $v_+=\max(v,0)$ for real $v$. For $t\in A$ define $p_t(g)=g+((1,1),t)$ for $g\in B\setminus\Phi$. For $a>0$ and $w:\Phi\to(0,\infty)$ the weighted prime-power count and its main term are
\begin{align*}
S(t,a,w)&=\sum_{p\ {\rm prime},\ i\ge1}\ \sum_{g\notin\Phi}
\frac{2\mathbf 1_{g-iF_p\in I_p}}{|I_p|}\ln p\,
\left(\frac{a}{p^i}-w_{p_t(g)}\right)_+,\\
M(a,w)&=a\left(\ln a-1-\gamma
 +\frac{L''(1,\xi_c^*)}{L(1,\xi_c^*)}
 -\frac1f\sum_{\alpha\in\Phi}\ln w_\alpha\right).
\end{align*}
Here $\gamma$ is Euler''s constant.',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-25 23:00:00', updated_by = 'codex'
WHERE id = 128;

UPDATE results SET
  statement_tex = 'Use $\xi_c$ from \ref{8JVP} and its primitive representative $\xi_c^*$ as in \ref{8JVQ}. In the normalization of \cite[Section 8]{Outline}, write $A_*=\sum_t a_t$, $\ell=\Re(L''(1,\xi_c^*)/L(1,\xi_c^*))$, and let $v_0$ be the geometric normalization parameter. The divisibility main term is
\[
D_{\rm div}=m\sum_t a_t\bigl(\ln a_t-1-\gamma-\ln(\pi/v_0)+\ell\bigr).
\]
For the weights indexed by $j,\alpha$, let $g_0$ be the common logarithmic index term and $E_{\rm count}$ the error in the counting lower bound. With
\[
\lambda=\sum_j\frac1f\sum_{\alpha\in\Phi}\ln(w_{j,\alpha}v_0/\pi)
      +mg_0-E_{\rm count},
\]
one has
\[
D_{\rm div}-A_*\lambda+mA_*g_0
=\sum_{t,j}\Re M(a_t,w_j)+A_*E_{\rm count},
\]
where $M$ is as in \ref{8JU9}.',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-25 23:00:00', updated_by = 'codex'
WHERE id = 131;

UPDATE results SET
  statement_tex = 'Use the data of \ref{8JVE} and the character notation of \ref{8JVQ}. Embed $A$ in $B$ by $v\mapsto ((0,0),v)$. With $\mathcal C_\psi$ the \hyperref[8JG8]{cyclic family}, put
\[
\begin{aligned}
\mathcal H &= \left\{\xi\in\widehat B \;\middle|\; \xi|_{A_0}=1\right\},\\
\mathcal K &= \left\{\xi\in\mathcal H \;\middle|\; \xi^*\in\mathcal C_\psi\right\}.
\end{aligned}
\]
Define
\[
\Sigma(x)=\sum_{\xi\in\mathcal H\setminus\mathcal K}
                 |G_{\xi^*}(x)|.
\]',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-25 23:00:00', updated_by = 'codex'
WHERE id = 153;

UPDATE results SET
  position = 5,
  statement_tex = 'Use $B,\Phi,f$ from \ref{8JVP} and the prime-power and character data of \ref{8JVQ}. Let $t,a,w$ be as in \ref{8JU9} with $w_\alpha\le a$ for every $\alpha\in\Phi$. Put $w_g=w_{p_t(g)}$ for $g\notin\Phi$. Then
\[
S(t,a,w)-\Re M(a,w)
=\Re\left(\frac1f\sum_{g\notin\Phi}\sum_{\xi\in\widehat B}
\overline{\xi(g)}\, w_g G_{\xi^*}(a/w_g)\right),
\]
where $G_{\xi^*}$ is the \hyperref[8JF7]{smoothed prime sum}.',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-25 23:00:00', updated_by = 'codex'
WHERE id = 161;

UPDATE results SET
  statement_tex = 'Fix a primitive $\psi$ of order $o$, a real $\varepsilon>0$, and a point $x\ge3$ in a window $[Y,Y^{3/2}]$. Use the residue groups and primes of \ref{8JVC} and the quadratic coordinates of \ref{8JVP}. Take a nonempty $T\subseteq A$. For the proportions $\mu_C,\lambda_C$ of \ref{8JVA} with $k=3$, require
\[
|\mu_C-\lambda_C|\le x^{-1+\varepsilon}\qquad(C\in A/A_0).
\] Take the parameters $b,X'',b'',\rho_w,m$, the nonempty set $T_2\subseteq A_0$, and the positive numbers $a_t$ and $w_{u,j}(\alpha)$ with the properties of \ref{8JVK}, indexed by $t\in T$, $u\in A_0$, $1\le j\le m$ and $\alpha\in\Phi$. Put
\[
n=|A|,\quad h=|T|,\quad h_2=|T_2|,
\qquad \delta_2=\frac{h_2}{n},\qquad Q=hmb.
\]
Require $x^{-\varepsilon}\le\delta_2\le1$.',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-25 23:00:00', updated_by = 'codex'
WHERE id = 162;

UPDATE results SET
  statement_tex = 'Fix a primitive $\psi$ and a sufficiently small $\varepsilon>0$. Use the groups of \ref{8JVC} and \ref{8JVP} and the nonempty set $T\subseteq A$ supplied by the arithmetic construction at each point of a window $[Y,Y^{3/2}]$. For all sufficiently large $x$ in this window, with a threshold depending only on $\psi,\varepsilon$, put
\[
b=\exp(x^\varepsilon),\qquad
X''=\exp(x^{\varepsilon/3})\ge3,\qquad b''=\frac{xb}{X''}.
\]
The chain length is an integer $m\ge1$. There is a nonempty subset $T_2\subseteq A_0$ and, for each $t\in T$, a positive scale $a_t$ with $|a_t/b-x|\le1$. For each $u\in A_0$, put
\[
\Phi_u=\left\{((0,1),z+u)\in\Phi \;\middle|\; z\in T_2\right\}.
\]
For every $1\le j\le m$ there is a weight function $w_{u,j}:\Phi\to(0,\infty)$ with
\[
\begin{aligned}
 b\le w_{u,j}(\alpha)\le b+\rho_w &\qquad(\alpha\in\Phi_u),\\
 0<w_{u,j}(\alpha)\le2b'' &\qquad(\alpha\in\Phi\setminus\Phi_u),
\end{aligned}
\]
where $0\le\rho_w\le b$ and $6f(x+1)\rho_w\le b/x$.',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-25 23:00:00', updated_by = 'codex'
WHERE id = 167;

UPDATE results SET
  position = 6,
  statement_tex = 'In \ref{8JVC}, take $\psi(v)=(v/5)$, the quadratic character modulo $5$, and set $e=1$, $q=3$, and $d=7$. Thus $o=2$, $N_1=40$, and $N=840$.

A unit belongs to $U_1$ when it is $1$ or $7$ modulo $8$ and $1$ or $4$ modulo $5$. The four combinations give $U_1=\{1,9,31,39\}$ modulo $40$. There are $4\cdot4=16$ units modulo $40$, so $|A|=4$. Label a class in $A$ by two bits. The first distinguishes $\{\pm1\}$ (bit $0$) from $\{\pm3\}$ (bit $1$) modulo $8$. The second distinguishes the squares $\{1,4\}$ (bit $0$) from the nonsquares $\{2,3\}$ (bit $1$) modulo $5$. This gives $A\cong(\Z/2\Z)^2$ and $A_0=\{(0,0),(1,0)\}$. For the quadratic coordinates of \ref{8JVP}, $B=(\Z/2\Z)^2\times A$ has $16$ elements and $\Phi=\{0\}\times(\Z/2\Z)\times A$ has $8$.

Take $p=13$. It is $6$ modulo $7$, a nonsquare since the nonzero squares modulo $7$ are $1,2,4$. It is $1$ modulo $3$, a square. Its residues modulo $8$ and $5$ are $5$ and $3$, giving the two bits $(1,1)$ in $A$. Since $13\nmid840$, \ref{8JVQ} gives $I_{13}=\{0\}$ and $F_{13}=((1,0),(1,1))$. Here $\xi_c(F_{13})=-1$, so the odd powers of $13$ enter the count in \ref{8JU9}.',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-25 23:00:00', updated_by = 'codex'
WHERE id = 168;

UPDATE proofs SET
  body_tex = '\emph{(a) Expand the centered count and control the changes of weight.}
Fix $u,t,j$. In the complex sum of \ref{8JVD}, keep the positions $\Phi_u$ of \ref{8JVK}, replace their weights by $b$, and omit the terms at all other positions. Write $P(u,t)$ for the resulting sum before taking real parts. It is independent of $j$.

At a position in $\Phi_u$, \ref{8JUE} bounds the change in $wG_{\xi^*}(a_t/w)$ by $3(x+1)\rho_w$, using $a_t\le(x+1)b$ and $b\le w\le b+\rho_w\le2b\le a_t$. Elsewhere $w\le2b''$ and
\[
\frac{a_t}{w}\ge\frac{(x-1)b}{2b''}
=\frac{x-1}{2x}\,X''\ge X''/3 .
\]
All original cutoffs are at least $1$, as required by \ref{8JVD}, since $2b\le a_t$ and $X''/3\ge1$. By \ref{8JVH}(i), each omitted term before its Fourier coefficient has absolute value at most $w(a_t/w)\omega_x\le(x+1)b\omega_x$. There are at most $f$ positions and $2f$ characters, and the coefficient has modulus $1/f$. Thus the error for each $(u,t,j)$ is bounded by
\[
6f(x+1)\rho_w+2f(x+1)b\omega_x\le2b/x .
\]
The first term is at most $b/x$ by \ref{8JVK}. The second is at most $b/x$ by the bound for $2f(x+1)\omega_x$ in \ref{8JVH}(i).

\emph{(b) Average over $u$.}
The class assigning the weight at $((0,1),z+u)$ is $g=((1,0),z+u-t)$, since $p_t(g)=g+((1,1),t)$. Set $y_t=a_t/b$ and $\sigma_\xi=\xi((1,0),0)\in\{1,-1\}$. Identify $A$ with its embedded copy as in \ref{8JUW}. Then
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
For the surviving characters define $\ell_\xi=L''(1,\xi^*)/L(1,\xi^*)$ for $\xi^*\ne\mathbf1$ and $\ell_\xi=0$ otherwise. Off the integer breakpoints, differentiating $G_{\xi^*}(y)$ gives the sum $\sum_{n\le y}\Lambda(n)\xi^*(n)/n$ plus $\ell_\xi$ for nontrivial $\xi^*$, or plus $-\ln y+\gamma$ for the trivial character. For $\Theta(v)=\sum_{n\le v}\Lambda(n)$, the Chebyshev bound $\Theta(v)\le 3v$ and partial summation give
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
Here $|y_t-x|\le1$ and $x\ge3$. The quotient $B/A_0=(\Z/2\Z)^2\times(A/A_0)$ has $4o$ characters, so this replacement costs at most $4oL_x$ after the division in (b).

\emph{(d) Apply the coset average.}
Put $\beta_\xi=h^{-1}\sum_{t\in T}\xi(t)$. After the replacement in (c), the normalized expression is
\[
\Re\sum_{\xi\in\mathcal H}
       \sigma_\xi\beta_\xi G_{\xi^*}(x).
\]
By the product coordinates in \ref{8JVP} and the subgroup $A_0$ in \ref{8JVC}, the characters in $\mathcal H$ are the $o$ powers of $\psi$ on $A/A_0$ with each of the four pairs of quadratic signs on the other two factors. The $o$ choices with both signs trivial give $\mathcal K$ and have $\sigma_\xi=1$. The remaining $3o$ have a quadratic factor at $q$ or $d$: the Chinese remainder factors at those primes are independent of $A$, and a nontrivial factor forces that prime into the primitive conductor. This also shows why no extra character induces a member of $\mathcal C_\psi$.

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
Both logarithmic errors together are $o(x^{1/2+\varepsilon})$ and hence at most $4x^{1/2+\varepsilon}$ once $x$ is large enough. All their constants depend only on $\psi$ and $\varepsilon$, which gives the stated uniform comparison.',
  generated_by = 'gpt',
  body_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-25 23:00:00', updated_by = 'codex'
WHERE id = 117;

-- Rebuild edges from the affected statements and proof.

DELETE FROM refs WHERE source_proof_id IS NULL AND source_result_id IN (126, 128, 131, 153, 160, 161, 162, 167, 168);
DELETE FROM refs WHERE source_proof_id = 117;

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (126, NULL, '8JVC'),
  (126, NULL, '8JVP'),
  (126, NULL, '8JV2'),
  (126, NULL, '8JVA'),
  (128, NULL, '8JVC'),
  (128, NULL, '8JVP'),
  (128, NULL, '8JVQ'),
  (131, NULL, '8JVP'),
  (131, NULL, '8JVQ'),
  (131, NULL, '8JU9'),
  (153, NULL, '8JVE'),
  (153, NULL, '8JVQ'),
  (153, NULL, '8JG8'),
  (160, NULL, '8JH4'),
  (161, NULL, '8JVP'),
  (161, NULL, '8JVQ'),
  (161, NULL, '8JU9'),
  (161, NULL, '8JF7'),
  (162, NULL, '8JVC'),
  (162, NULL, '8JVP'),
  (162, NULL, '8JVA'),
  (162, NULL, '8JVK'),
  (167, NULL, '8JVC'),
  (167, NULL, '8JVP'),
  (168, NULL, '8JVC'),
  (168, NULL, '8JVP'),
  (168, NULL, '8JVQ'),
  (168, NULL, '8JU9'),
  (170, NULL, '8JVC'),
  (171, NULL, '8JVC'),
  (171, NULL, '8JVP'),
  (171, NULL, '8JB2'),
  (132, 117, '8JVD'),
  (132, 117, '8JVK'),
  (132, 117, '8JUE'),
  (132, 117, '8JVH'),
  (132, 117, '8JUW'),
  (132, 117, '8JV9'),
  (132, 117, '8JVP'),
  (132, 117, '8JVC'),
  (132, 117, '8JG8'),
  (132, 117, '8JVA'),
  (132, 117, '8JS3');

-- Record new revisions and invalidate the book cache.

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'section', CAST(id AS TEXT), revision, 'prime-classes-definition-2026-11-25',
  json_object('tag', tag, 'kind', kind, 'title', title, 'intro_tex', intro_tex, 'parent_id', parent_id, 'position', position),
  'codex', '2026-11-25 23:00:00'
FROM sections WHERE id IN (113) ORDER BY id;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'prime-classes-definition-2026-11-25',
  json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex, 'section_id', section_id, 'position', position, 'listed', listed, 'aliases', json((SELECT json_group_array(alias) FROM (SELECT alias FROM aliases WHERE aliases.tag = results.tag ORDER BY alias)))),
  'codex', '2026-11-25 23:00:00'
FROM results WHERE id IN (126, 128, 131, 153, 160, 161, 162, 167, 168, 170, 171) ORDER BY id;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'proof', CAST(id AS TEXT), revision, 'prime-classes-definition-2026-11-25',
  json_object('result_id', result_id, 'body_tex', body_tex, 'status', status, 'generated_by', generated_by, 'generator_detail', generator_detail, 'reviewed_by', reviewed_by, 'review_notes', review_notes, 'position', position),
  'codex', '2026-11-25 23:00:00'
FROM proofs WHERE id IN (117) ORDER BY id;

UPDATE settings SET value = '1' WHERE key = 'needs_rebuild' AND value <> '1';
