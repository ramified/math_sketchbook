-- Appendix B, sections B.1–B.3. Apply in one transaction.
INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  EXISTS (SELECT 1 FROM tags WHERE tag IN (
    'APXB', 'BSE2', 'BSE3', 'BSE4', 'KA22', 'KA23', 'KA25', 'KA26', 'KA27', 'KA24',
    'KB22', 'KB23', 'KB24', 'KB2B', 'KB25', 'KB26', 'KB28', 'KB29', 'KB27', 'KB2C', 'KB2D', 'KB2E',
    'KC22', 'KC24', 'KC25', 'KC27', 'KC28'
  ))
  OR EXISTS (SELECT 1 FROM aliases WHERE alias IN (
    'euclidean-lattice', 'dual-lattice', 'arakelov-degree', 'harder-narasimhan',
    'slope-inequality', 'mean-slope-bound'
  ))
  OR NOT EXISTS (SELECT 1 FROM sections WHERE tag = 'APXA' AND kind = 'chapter' AND appendix = 1 AND position < 101)
  OR EXISTS (SELECT 1 FROM sections WHERE kind = 'chapter' AND (position = 101 OR (appendix = 1 AND tag <> 'APXA')))
  OR NOT EXISTS (SELECT 1 FROM settings WHERE key = 'bibliography' AND revision = 10)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'setting' AND entity_key = 'bibliography' AND revision > 10)
  OR (SELECT author FROM revisions WHERE entity = 'setting' AND entity_key = 'bibliography'
      ORDER BY revision DESC LIMIT 1) = 'admin'
  OR NOT EXISTS (SELECT 1 FROM settings WHERE key = 'needs_rebuild')
  OR EXISTS (
    SELECT 1 FROM settings s WHERE s.key = 'needs_rebuild' AND s.value <> '1'
    AND (
      EXISTS (SELECT 1 FROM revisions WHERE entity = 'setting' AND entity_key = s.key AND revision > s.revision)
      OR (SELECT author FROM revisions WHERE entity = 'setting' AND entity_key = s.key
          ORDER BY revision DESC LIMIT 1) = 'admin'
    )
  );

WITH appendix_tags(tag, kind) AS (VALUES
  ('APXB', 'section'), ('BSE2', 'section'), ('BSE3', 'section'), ('BSE4', 'section'),
  ('KA22', 'result'), ('KA23', 'result'), ('KA25', 'result'), ('KA26', 'result'), ('KA27', 'result'), ('KA24', 'result'),
  ('KB22', 'result'), ('KB23', 'result'), ('KB24', 'result'), ('KB2B', 'result'), ('KB25', 'result'), ('KB26', 'result'),
  ('KB28', 'result'), ('KB29', 'result'), ('KB27', 'result'), ('KB2C', 'result'), ('KB2D', 'result'), ('KB2E', 'result'),
  ('KC22', 'result'), ('KC24', 'result'), ('KC25', 'result'), ('KC27', 'result'), ('KC28', 'result')
)
INSERT INTO tags (tag, kind, created_at)
SELECT tag, kind, '2026-11-28 15:00:00' FROM appendix_tags;

INSERT INTO aliases (alias, tag, created_at) VALUES
  ('euclidean-lattice', 'KA22', '2026-11-28 15:00:00'),
  ('dual-lattice', 'KA26', '2026-11-28 15:00:00'),
  ('arakelov-degree', 'KB22', '2026-11-28 15:00:00'),
  ('harder-narasimhan', 'KB27', '2026-11-28 15:00:00'),
  ('slope-inequality', 'KC24', '2026-11-28 15:00:00'),
  ('mean-slope-bound', 'KC28', '2026-11-28 15:00:00');

INSERT INTO sections (tag, parent_id, kind, title, intro_tex, intro_html_cache, position, appendix,
                      created_at, updated_at, updated_by)
VALUES ('APXB', NULL, 'chapter', 'Lattices, slopes and theta series',
'This appendix collects the facts on lattices and theta series behind the lattice comparison of \ref{Q7MK} and the outline in \ref{8JV5}. Sections B.1–B.3 work over $\Z$ and require only linear algebra. Sections B.4–B.6 introduce CM fields and theta series.',
NULL, 101, 1, '2026-11-28 15:00:00', '2026-11-28 15:00:00', 'codex');

WITH appendix_sections(tag, position, title, intro_tex) AS (VALUES
  ('BSE2', 1, 'Euclidean lattices',
   'We compute covolumes of lattices, their sublattices, their quotients and their duals. Covolume and duality enter the lattice comparison in \ref{Q7MN}.'),
  ('BSE3', 2, 'Degree and slopes',
   'We pass from covolumes to degrees and use sublattices to compute the slopes of a lattice. The mean slope takes the place of $\ln|N|$ in the lattice version of \ref{WJQV}.'),
  ('BSE4', 3, 'The slope inequality',
   'We bound how much a lattice map can lower slopes and use a family of maps to bound the mean slope of its target. This is the kind of bound used in \ref{Q7MQ} and step (2) of \ref{8JUA}.')
)
INSERT INTO sections (tag, parent_id, kind, title, intro_tex, intro_html_cache, position, appendix,
                      created_at, updated_at, updated_by)
SELECT s.tag, c.id, 'section', s.title, s.intro_tex, NULL, s.position, 0,
       '2026-11-28 15:00:00', '2026-11-28 15:00:00', 'codex'
FROM appendix_sections s CROSS JOIN sections c WHERE c.tag = 'APXB';

WITH appendix_results(section_tag, position, tag, type, listed, title, statement_tex) AS (VALUES
  ('BSE2', 1, 'KA22', 'definition', 1, 'Euclidean lattice',
'A Euclidean lattice is a pair $(L,\langle\cdot,\cdot\rangle)$ consisting of a free $\Z$-module $L$ of finite rank $n\ge0$ and a symmetric positive definite bilinear form on $L_\R=L\otimes_\Z\R$. For $x\in L_\R$, write $|x|=\langle x,x\rangle^{1/2}$.

For any $\Z$-basis $e_1,\dots,e_n$ of $L$, put
$$
G=(\langle e_i,e_j\rangle)_{i,j},\qquad
\operatorname{covol}(L)=(\det G)^{1/2}.
$$
The covolume \hyperref[KA23]{does not depend on the basis}. For $n=0$ it is $1$. The standard inner product on $\Z^n$ gives covolume $1$. See \ref{KA24} for another example.'),
  ('BSE2', 2, 'KA23', 'lemma', 0, 'The covolume does not depend on the basis',
'Let $L$ be a Euclidean lattice of rank $n$ as in \ref{KA22}.
\begin{enumerate}
\item[(i)] The covolume is independent of the choice of $\Z$-basis.
\item[(ii)] For any $\Z$-basis $e_1,\dots,e_n$ of $L$, the covolume equals the Lebesgue volume in orthonormal coordinates of the parallelotope
$$
\left\{\sum_{i=1}^n t_ie_i\in L_\R
  \;\middle|\; t_1,\dots,t_n\in[0,1)\right\}.
$$
\end{enumerate}'),
  ('BSE2', 3, 'KA25', 'definition', 1, 'Sublattices and quotient lattices',
'Let $L$ be a Euclidean lattice as in \ref{KA22}. A sublattice is a subgroup $L''\subset L$ with the restricted inner product on $L''_\R\subset L_\R$. It is saturated if $L''=L\cap L''_\R$.

For any saturated sublattice $L''$, the quotient lattice $L/L''$ has the inner product induced by orthogonal projection
$$
\pi\colon L_\R\longrightarrow (L''_\R)^\perp,\qquad x\longmapsto \pi(x).
$$
For any $x\in L$, the quotient norm $|x+L''|=|\pi(x)|$ is the distance from $x$ to $L''_\R$.'),
  ('BSE2', 4, 'KA26', 'definition', 1, 'The dual lattice',
'For a Euclidean lattice $L$ as in \ref{KA22}, the dual lattice, with the restricted inner product, is
$$
L^\vee=\left\{y\in L_\R \;\middle|\;
  \langle y,x\rangle\in\Z\text{ for every }x\in L\right\}.
$$'),
  ('BSE2', 5, 'KA27', 'lemma', 1, 'Covolumes of sublattices, quotients and duals',
'Let $L$ be a Euclidean lattice of rank $n$. Use sublattices and quotients from \ref{KA25} and the dual from \ref{KA26}.
\begin{enumerate}
\item[(i)] For any sublattice $L''$ of rank $n$,
$$
\operatorname{covol}(L'')=[L:L'']\operatorname{covol}(L).
$$
\item[(ii)] For any saturated sublattice $L''\subset L$,
$$
\operatorname{covol}(L)=\operatorname{covol}(L'')\operatorname{covol}(L/L'').
$$
\item[(iii)] The dual has covolume $\operatorname{covol}(L^\vee)=\operatorname{covol}(L)^{-1}$ and $(L^\vee)^\vee=L$.
\end{enumerate}
See \ref{KA24} for these computations in rank two.'),
  ('BSE2', 6, 'KA24', 'example', 0, 'The hexagonal lattice $A_2$',
'In $\R^2$ with the standard inner product, take $A_2=\Z e_1+\Z e_2$ with
$$
e_1=(\sqrt2,0),\qquad e_2=(1/\sqrt2,\sqrt{3/2}).
$$
The basis $e_1,e_2$ and its dual basis have Gram matrices
$$
G=\begin{pmatrix}2&1\\1&2\end{pmatrix},\qquad
G^{-1}=\frac13\begin{pmatrix}2&-1\\-1&2\end{pmatrix}.
$$
Thus the covolumes of $A_2$ and $A_2^\vee$ are $\sqrt3$ and $1/\sqrt3$. The sublattice $2A_2$ has index $4$ and covolume $4\sqrt3$.

The sublattice $\Z e_1$ is saturated and has covolume $\sqrt2$. The class of $e_2$ generates the quotient and its norm is the distance $\sqrt{3/2}$ from $e_2$ to $\R e_1$. The two covolumes multiply to $\sqrt2\cdot\sqrt{3/2}=\sqrt3$, as in \ref{KA27}(ii).'),
  ('BSE3', 1, 'KB22', 'definition', 1, 'Arakelov degree and slope',
'For a Euclidean lattice $L$ of rank $n$ as in \ref{KA22}, the Arakelov degree and, for $n\ge1$, the slope are
$$
\widehat{\deg}(L)=-\ln\operatorname{covol}(L),\qquad
\mu(L)=\frac{\widehat{\deg}(L)}n.
$$
For any nonzero $v\in L_\R$, this gives $\widehat{\deg}(\Z v)=-\ln|v|$. For this normalization see \cite{Stuhler1976} and \cite[Section 4.3]{Zhang}.'),
  ('BSE3', 2, 'KB23', 'motivation', 1, 'An integer as a rank-one lattice',
'For a nonzero integer $N$, \ref{WJQV} compares two bounds for $\ln|N|$. In $\Z\subset\R$ with the standard metric, the sublattice $N\Z$ has index $|N|$ and degree $-\ln|N|$. For any integer $m\ge1$ dividing $N$, one has $N\Z\subset m\Z$ and $\widehat{\deg}(m\Z)=-\ln m$. Divisibility gives an inclusion, and \ref{KB24}(i) turns the bound of \ref{8V4M} into $\widehat{\deg}(N\Z)\le\widehat{\deg}(m\Z)$ when $m$ is the product of the prime powers in that bound.

In \ref{Q7MN}, lattices of large rank take the place of $\Z$. Slope is degree per rank, and \ref{KC24} compares slopes along a lattice map.'),
  ('BSE3', 3, 'KB24', 'lemma', 1, 'Degrees of sublattices, quotients and duals',
'Let $L$ be a Euclidean lattice of rank $n$. Use the degree and slope of \ref{KB22}.
\begin{enumerate}
\item[(i)] For any sublattice $L''$ of rank $n$,
$$
\widehat{\deg}(L'')=\widehat{\deg}(L)-\ln[L:L''].
$$
\item[(ii)] For any saturated sublattice $L''\subset L$,
$$
\widehat{\deg}(L)=\widehat{\deg}(L'')+\widehat{\deg}(L/L'').
$$
When both ranks are positive, $\mu(L)$ is the rank-weighted mean of $\mu(L'')$ and $\mu(L/L'')$.
\item[(iii)] One has $\widehat{\deg}(L^\vee)=-\widehat{\deg}(L)$ and, for $n\ge1$, $\mu(L^\vee)=-\mu(L)$.
\end{enumerate}'),
  ('BSE3', 4, 'KB2B', 'lemma', 0, 'A norm-decreasing isomorphism raises the degree',
'Let $E,F$ be Euclidean lattices of the same rank $n$ and let $\varphi\colon E\longrightarrow F$ be a group isomorphism. For a real $h$ assume $|\varphi_\R(x)|\le e^h|x|$ for all $x\in E_\R$. Then
$$
\widehat{\deg}(F)\ge\widehat{\deg}(E)-nh.
$$'),
  ('BSE3', 5, 'KB25', 'definition', 1, 'Maximal and minimal slopes',
'For a Euclidean lattice $L$ of rank $n\ge1$, use the saturated sublattices of \ref{KA25} and slope of \ref{KB22}. Its maximal and minimal slopes are
\begin{align*}
\mu_{\max}(L)&=\max_{L''}\mu(L'') && (0\ne L''\subset L\text{ saturated}),\\
\mu_{\min}(L)&=\min_{L''}\mu(L/L'') && (L''\subsetneq L\text{ saturated}).
\end{align*}
These extrema \hyperref[KB26]{exist}. The lattice is semistable if $\mu_{\max}(L)=\mu(L)$.'),
  ('BSE3', 6, 'KB26', 'lemma', 0, 'Finiteness of sublattices of large degree',
'Let $L$ be a Euclidean lattice of rank $n\ge1$ and use the degree of \ref{KB22}.
\begin{enumerate}
\item[(i)] For any integer $1\le r\le n$ and real $c$, there are finitely many saturated sublattices $L''$ of rank $r$ with $\widehat{\deg}(L'')\ge c$.
\item[(ii)] The maximum and minimum in \ref{KB25} are attained.
\end{enumerate}'),
  ('BSE3', 7, 'KB28', 'lemma', 0, 'Degrees of sums and intersections',
'Let $A,B$ be any saturated sublattices of a Euclidean lattice $L$.
\begin{enumerate}
\item[(i)] The intersection $A\cap B$ is saturated in $L$.
\item[(ii)] The sum $A+B$ with the metric of $L$ satisfies
$$
\widehat{\deg}(A+B)\ge
\widehat{\deg}(A)+\widehat{\deg}(B)-\widehat{\deg}(A\cap B).
$$
\end{enumerate}'),
  ('BSE3', 8, 'KB29', 'lemma', 1, 'The maximal destabilizing sublattice',
'Let $L$ be a Euclidean lattice of rank $n\ge1$, with maximal slope as in \ref{KB25}. There is a unique saturated sublattice $L_{\rm des}$ of slope $\mu_{\max}(L)$ that contains every saturated sublattice of this slope.'),
  ('BSE3', 9, 'KB27', 'theorem', 1, 'The Harder–Narasimhan filtration',
'Let $L$ be a Euclidean lattice of rank $n\ge1$. Put $L_0=0$. For each integer $i\ge0$ with $L_i\ne L$, let $L_{i+1}$ be the preimage in $L$ of $(L/L_i)_{\rm des}$ from \ref{KB29}. Write $k$ for the terminal index.
\begin{enumerate}
\item[(i)] The chain $0=L_0\subsetneq\cdots\subsetneq L_k=L$ consists of saturated sublattices. The successive quotients are semistable and
$$
\mu(L_1/L_0)>\cdots>\mu(L_k/L_{k-1}).
$$
\item[(ii)] The extremal slopes are $\mu_{\max}(L)=\mu(L_1)$ and $\mu_{\min}(L)=\mu(L/L_{k-1})$.
\item[(iii)] For every integer $1\le i\le k$, the same construction gives $L_0,\dots,L_i$ for $L_i$ and $(L_j/L_i)_{i\le j\le k}$ for $L/L_i$. The filtration of the zero lattice consists of $0$ alone.
\end{enumerate}
This chain is the Harder–Narasimhan filtration \cite{Stuhler1976,Grayson1984}. See \ref{KB2E}.'),
  ('BSE3', 10, 'KB2C', 'definition', 1, 'Harder–Narasimhan slopes',
'For a Euclidean lattice $L$ of rank $n\ge1$, use $L_0,\dots,L_k$ from \ref{KB27}. The Harder–Narasimhan slopes $\mu_1(L)\ge\cdots\ge\mu_n(L)$ list each $\mu(L_i/L_{i-1})$ with multiplicity $\operatorname{rk}(L_i/L_{i-1})$, for integers $1\le i\le k$.

For any real $t$, put $L_{\ge t}=L_i$ for the largest integer $1\le i\le k$ with $\mu(L_i/L_{i-1})\ge t$. If there is no such $i$, put $L_{\ge t}=0$.'),
  ('BSE3', 11, 'KB2D', 'lemma', 1, 'The pieces above a threshold',
'Let $L$ be a Euclidean lattice of rank $n\ge1$. Use the slopes and sublattices of \ref{KB2C}. For any real $t$ the following hold.
\begin{enumerate}
\item[(i)] $\sum_{j=1}^n\mu_j(L)=\widehat{\deg}(L)$.
\item[(ii)] $\operatorname{rk}L_{\ge t}=\#\left\{j\in\{1,\dots,n\}\;\middle|\;\mu_j(L)\ge t\right\}$.
\item[(iii)] If $L_{\ge t}\ne0$, then $\mu_{\min}(L_{\ge t})\ge t$.
\item[(iv)] If $L_{\ge t}\ne L$, then $\mu_{\max}(L/L_{\ge t})<t$.
\end{enumerate}'),
  ('BSE3', 12, 'KB2E', 'example', 0, 'Two orthogonal vectors, and $A_2$',
'Let $L=\Z e_1\oplus\Z e_2$ with $e_1,e_2$ orthogonal and lengths $0<a=|e_1|\le b=|e_2|$. Its slope is $\mu(L)=-\tfrac12\ln(ab)$. Any primitive vector $xe_1+ye_2$ with integers $x,y$ and $y\ne0$ has norm at least $b$. For $a<b$ this makes $\Z e_1$ the first nonzero piece of the filtration in \ref{KB27}. The two slopes are $-\ln a>-\ln b$, with $\mu_{\max}(L)=-\ln a$ and $\mu_{\min}(L)=-\ln b$. For $a=b$, the lattice is semistable.

The lattice $A_2$ of \ref{KA24} has $\mu(A_2)=-\tfrac14\ln3$ and is semistable. For integers $x,y$ with $(x,y)\ne(0,0)$, the squared norm $2(x^2+xy+y^2)$ is a positive even integer. Every nonzero vector thus has norm at least $\sqrt2$, and every rank-one sublattice has slope at most $-\tfrac12\ln2<-\tfrac14\ln3$.'),
  ('BSE4', 1, 'KC22', 'definition', 1, 'Norm and height of a map',
'A morphism $\varphi\colon E\longrightarrow F$ of Euclidean lattices is a $\Z$-linear map. Its image $\varphi(E)$ carries the inner product of $F$. Write $\|\varphi\|$ for the operator norm of the real extension $\varphi_\R$, the least real $c\ge0$ with $|\varphi_\R(x)|\le c|x|$ for all $x\in E_\R$. For $\varphi\ne0$ its height is $h(\varphi)=\ln\|\varphi\|$.'),
  ('BSE4', 2, 'KC24', 'theorem', 1, 'The slope inequality',
'Let $\varphi\colon E\longrightarrow F$ be a nonzero morphism of Euclidean lattices with height from \ref{KC22}. Use the extremal slopes of \ref{KB25}.
\begin{enumerate}
\item[(i)] $\mu_{\min}(\varphi(E))\ge\mu_{\min}(E)-h(\varphi)$.
\item[(ii)] $\mu_{\min}(E)\le\mu_{\max}(F)+h(\varphi)$.
\end{enumerate}
See \cite[Section 4.1]{Bost2001}, \cite[Section 4.3]{Zhang} and the rank-one example \ref{KC25}.'),
  ('BSE4', 3, 'KC25', 'example', 0, 'Divisibility as a slope inequality',
'For an integer $m\ge1$, let $E=\Z$ and $F=m\Z$ with their metrics from $\R$. For any nonzero integer $N$ divisible by $m$, take
$$
\varphi\colon E\longrightarrow F,\qquad x\longmapsto Nx.
$$
Here $h(\varphi)=\ln|N|$, $\mu_{\min}(E)=0$ and $\mu_{\max}(F)=-\ln m$. Then \ref{KC24}(ii) gives $\ln m\le\ln|N|$. For $m=\prod_{p\in P}p^{e_p}$ with $P$ a finite set of primes and the $e_p$ nonnegative integers as in \ref{8V4M}, this recovers the integer-exponent case of that bound.'),
  ('BSE4', 4, 'KC27', 'lemma', 1, 'Restricting many maps loses little of the target',
'Let $H$ be a real inner product space of dimension $D\ge1$. For an integer $k\ge1$ and each integer $1\le i\le k$, let $B_i\colon\R^{r_i}\longrightarrow H$ be linear with $r_i\ge1$, and take a real $\gamma_i>0$. Write $R=\sum_i r_i$ and define
$$
K_i=\gamma_i B_i^*B_i,\qquad Q=\sum_i\gamma_i B_iB_i^*.
$$
Here $B_i^*$ is the adjoint, $I$ is the identity on the space in question, and $\|A\|_{\rm HS}^2=\operatorname{tr}(A^*A)$ is the squared Hilbert–Schmidt norm of any linear map $A$ between finite-dimensional inner product spaces.

Assume that reals $0\le e\le\tfrac14$ and $\eta\ge0$ satisfy
\begin{align*}
\sum_i\|K_i-I\|_{\rm HS}^2 &\le eR,\\
\operatorname{tr}(Q^2)&\le (1+\eta)(\operatorname{tr}Q)^2/D.
\end{align*}
Then for any real $\kappa\ge0$ and subspaces $E_i\subset\R^{r_i}$ with $\sum_i\operatorname{codim} E_i\le\kappa R$,
$$
\operatorname{codim}_H\sum_i B_iE_i
\le(\eta+4\kappa+4\sqrt{\kappa e})D.
$$
This is the real case of the estimate in \cite[Lemma 4.2]{Zhang}.'),
  ('BSE4', 5, 'KC28', 'theorem', 1, 'A lower bound for the mean slope',
'Let $C$ be a Euclidean lattice of rank $D\ge1$. For an integer $k\ge1$ and each integer $1\le i\le k$, let $N_i$ be a Euclidean lattice of rank $r_i\ge1$, $b_i\colon N_i\longrightarrow C$ a morphism, and $h_i$ a real with $h(b_i)\le h_i$ whenever $b_i\ne0$. Use heights from \ref{KC22}, slopes from \ref{KB22} and extremal slopes from \ref{KB25}.

Put $R=\sum_i r_i$. Assume there are reals $s$, $u\ge0$ and $H\ge0$ with
\begin{align*}
Rs &\le \sum_i r_i(\mu(N_i)-h_i),\\
\mu_{\max}(N_i)-h_i &\le s+u && (1\le i\le k),\\
s-\mu_{\min}(C) &\le H.
\end{align*}
Assume there are linear isomorphisms $\alpha_i\colon\R^{r_i}\longrightarrow(N_i)_\R$ for all $i$ and $\beta\colon C_\R\longrightarrow\R^D$ such that $B_i=\beta\circ(b_i)_\R\circ\alpha_i$ satisfy the hypotheses of \ref{KC27} for some $\gamma_i$, $e$, $\eta$. Then
$$
\mu(C)\ge s-4u\ln(1+H/u)-(\eta+4\sqrt e)H,
$$
where $u\ln(1+H/u)$ is taken as $0$ when $u=0$. This is the version over $\Z$ of \cite[Proposition 4.3]{Zhang}.')
)
INSERT INTO results (tag, type, title, statement_tex, statement_html_cache, section_id, position,
                     visibility, state, listed, created_at, updated_at, created_by, updated_by)
SELECT r.tag, r.type, r.title, r.statement_tex, NULL, s.id, r.position, 'published', 'active', r.listed,
       '2026-11-28 15:00:00', '2026-11-28 15:00:00', 'codex', 'codex'
FROM appendix_results r JOIN sections s ON s.tag = r.section_tag;

WITH appendix_proofs(tag, body_tex) AS (VALUES
  ('KA23',
'\emph{(i)} Let $U\in\mathrm{GL}_n(\Z)$ be the matrix of a basis change. The new Gram matrix is $U^{\mathsf T}GU$, with determinant $(\det U)^2\det G=\det G$.

\emph{(ii)} Let $A$ be the matrix with columns the coordinates of $e_1,\dots,e_n$ in an orthonormal basis of $L_\R$. The parallelotope is the image of the unit cube under $A$. Its volume is $|\det A|=(\det G)^{1/2}$ by $G=A^{\mathsf T}A$. In dimension zero the single point has volume $1$.'),
  ('KA27',
'\emph{(i)} The elementary divisor theorem gives a basis $e_1,\dots,e_n$ of $L$ and integers $d_1,\dots,d_n\ge1$ with $d_1e_1,\dots,d_ne_n$ a basis of $L''$. For $D=\operatorname{diag}(d_1,\dots,d_n)$ the new Gram matrix is $DGD$. Its determinant is $(\prod_i d_i)^2\det G$, and the quotient has order $\prod_i d_i$.

\emph{(ii)} Write $r=\operatorname{rk}L''$. The quotient $L/L''$ is torsion free by saturation, so a basis $e_1,\dots,e_r$ of $L''$ extends to a basis $e_1,\dots,e_n$ of $L$. The vectors $\pi(e_{r+1}),\dots,\pi(e_n)$ for the projection in \ref{KA25} give a basis of the quotient. In orthonormal coordinates adapted to $L''_\R$ and its orthogonal complement, the basis matrix of $L$ is block upper triangular, with the basis matrices of $L''$ and $L/L''$ on the diagonal. Take absolute determinants as in \ref{KA23}(ii).

\emph{(iii)} Let $e_1^\vee,\dots,e_n^\vee$ be the real basis characterized by $\langle e_i^\vee,e_j\rangle=\delta_{ij}$, where $\delta_{ij}$ is $1$ for $i=j$ and $0$ otherwise. The integrality conditions in \ref{KA26} say that its coefficients for any element of $L^\vee$ are integers. Its Gram matrix is $G^{-1}$, and the basis dual to it is $e_1,\dots,e_n$.'),
  ('KB24',
'\emph{(i)} Apply $-\ln$ to \ref{KA27}(i).

\emph{(ii)} Apply $-\ln$ to \ref{KA27}(ii). Dividing by $n$ gives the weighted mean when both ranks are positive.

\emph{(iii)} Apply $-\ln$ to \ref{KA27}(iii). The dual has the same rank as $L$.'),
  ('KB2B',
'For $n=0$ both degrees are zero. For $n\ge1$, use orthonormal coordinates and \ref{KA23}(ii) to obtain
$$
\operatorname{covol}(F)=|\det\varphi_\R|\operatorname{covol}(E).
$$
Each singular value of $\varphi_\R$ is at most $e^h$, so their product $|\det\varphi_\R|$ is at most $e^{nh}$. Apply $-\ln$.'),
  ('KB26',
'\emph{(i)} Equip the exterior power $\bigwedge^r L$ with the inner product given, for $x_i,y_j\in L_\R$, by
$$
\langle x_1\wedge\cdots\wedge x_r,y_1\wedge\cdots\wedge y_r\rangle
=\det(\langle x_i,y_j\rangle)_{i,j}.
$$
For a basis $f_1,\dots,f_r$ of $L''$, the wedge $f=f_1\wedge\cdots\wedge f_r$ has norm $\operatorname{covol}(L'')\le\exp(-c)$. The real span of $L''$ consists of the $x\in L_\R$ with $x\wedge f=0$ and determines $L''$ by saturation. A bounded ball contains finitely many vectors of $\bigwedge^r L$, as all their integer coordinates are bounded in any fixed basis.

\emph{(ii)} A candidate $L''$ for the maximum whose slope is at least $\mu(L)$ has degree at least $r\cdot\mu(L)$, where $r=\operatorname{rk}L''$. The set of such candidates is finite by (i) and contains $L$. By \ref{KB24}(ii), a quotient of slope at most $\mu(L)$, with $r=\operatorname{rk}L''<n$, satisfies
$$
\widehat{\deg}(L'')=\widehat{\deg}(L)-(n-r)\mu(L/L'')
\ge r\cdot\mu(L).
$$
For $r>0$ use (i) again. For $r=0$ the only candidate is $L''=0$, whose quotient is $L$.'),
  ('KB28',
'\emph{(i)} Saturation gives $A\cap B=L\cap A_\R\cap B_\R$, and $(A\cap B)_\R\subset A_\R\cap B_\R$.

\emph{(ii)} By (i), $A\cap B$ is saturated in $A$. As $B=L\cap B_\R$, it is also saturated in $A+B$. The natural map
$$
A/(A\cap B)\longrightarrow (A+B)/B,\qquad
x+(A\cap B)\longmapsto x+B
$$
is a group isomorphism. Its norm is at most $1$ by the distance formula in \ref{KA25} and the inclusion $(A\cap B)_\R\subset B_\R$. Apply \ref{KB2B} with $h=0$ and add $\widehat{\deg}(B)$, using \ref{KB24}(ii) for both quotients.'),
  ('KB29',
'Choose a saturated sublattice $A$ of slope $\mu_{\max}(L)$ and of largest rank among those of this slope. For any other saturated sublattice $B$ of this slope, let $S=L\cap(A+B)_\R$. Write $\mu_*=\mu_{\max}(L)$. Then
\begin{align*}
\widehat{\deg}(S)&\ge\widehat{\deg}(A+B) &&\text{(a)}\\
&\ge\widehat{\deg}(A)+\widehat{\deg}(B)
       -\widehat{\deg}(A\cap B) &&\text{(b)}\\
&\ge\mu_*(\operatorname{rk}A+\operatorname{rk}B
          -\operatorname{rk}(A\cap B)) &&\text{(c)}\\
&=\mu_*\operatorname{rk}S.
\end{align*}
Use \ref{KB24}(i) in (a), \ref{KB28} in (b), and \ref{KB25} in (c), with degree zero for a zero intersection.
Saturation gives $\mu(S)\le\mu_*$, so $S$ has slope $\mu_*$. Maximality of the rank of $A$ gives $A_\R=S_\R$. Then $A=S$ by saturation, and $B\subset A$. Any two sublattices with the required containment property contain each other.'),
  ('KB27',
'\emph{Idea.} The largest sublattice of maximal slope determines the first piece. Degree additivity forces the successive slopes to decrease and controls the degree of any quotient.

\emph{(i)} At each stage, \ref{KB29} supplies a nonzero saturated sublattice of $L/L_i$. Its preimage is saturated in $L$ and has strictly larger rank than $L_i$, so the construction ends in at most $n$ steps. A saturated sublattice of $L_{i+1}/L_i$ is saturated in $L/L_i$. Its slope is at most the slope of $L_{i+1}/L_i$ by maximality, which gives semistability.

For an integer $1\le i<k$, suppose $\mu(L_{i+1}/L_i)\ge\mu(L_i/L_{i-1})$. By the weighted mean in \ref{KB24}(ii), the saturated sublattice $L_{i+1}/L_{i-1}$ of $L/L_{i-1}$ has slope at least $\mu(L_i/L_{i-1})$. This is the maximal slope of $L/L_{i-1}$. Equality would force $L_{i+1}/L_{i-1}$ to lie in $L_i/L_{i-1}$ by \ref{KB29}, contradicting the strict rank increase.

\emph{(ii)} The formula for $\mu_{\max}(L)$ is the choice of $L_1$. Write $\nu=\mu(L/L_{k-1})$. This last quotient gives $\mu_{\min}(L)\le\nu$.

\emph{(1)} \textbf{Every nonzero quotient of a semistable lattice has slope at least its slope.} For a semistable lattice $P$ and a proper saturated sublattice $M\subset P$, the claim is immediate for $M=0$. For positive rank $M$, use $\mu(M)\le\mu(P)$ in the weighted mean of \ref{KB24}(ii). This proves the lower bound for $k=1$.

\emph{(2)} \textbf{Split any quotient along the first piece.} For $k>1$ assume the lower bound for filtrations of length $k-1$. Fix any proper saturated sublattice $M\subset L$ and put $S=L\cap(L_1+M)_\R$. The quotient $L/M$ has sublattice $S/M$ and remaining quotient $L/S$. Both the iterated and direct quotient metrics for nested saturated sublattices take the orthogonal component perpendicular to the larger real span. The image $(L_1+M)/M$ is a full-rank sublattice of $S/M$. By \ref{KB24}(i) and the norm-decreasing isomorphism used in \ref{KB28},
\begin{align*}
\widehat{\deg}(S/M)
&\ge\widehat{\deg}((L_1+M)/M)\\
&\ge\widehat{\deg}(L_1/(L_1\cap M)).
\end{align*}
The last quotient has the same rank as $S/M$. By (1) and (i), its degree is at least $\nu\operatorname{rk}(S/M)$, including when the rank is zero. The construction on $L/L_1$ begins with the next piece of the original filtration and has last slope $\nu$. The induction hypothesis applied to its quotient $L/S$ gives $\widehat{\deg}(L/S)\ge \nu\operatorname{rk}(L/S)$, also valid for $S=L$. Add the two degree bounds by \ref{KB24}(ii) to obtain $\mu(L/M)\ge\nu$.

\emph{(iii)} The assertion for $L/L_i$ follows by the construction and compatibility of the quotient metrics. Every saturated sublattice of $L_i$ is saturated in $L$, so its slope is at most $\mu(L_1)$ and, at equality, it lies in $L_1$ by \ref{KB29}. Hence the first piece for $L_i$ is $L_1$. Repeat this argument in $L_i/L_1\subset L/L_1$ until reaching $L_i$.'),
  ('KB2D',
'\emph{(i)} Sum the degrees of the successive quotients using \ref{KB24}(ii); each piece contributes its slope times its rank.

\emph{(ii)} By \ref{KB2C}, the ranks of the pieces of slope at least $t$ count precisely the slopes at least $t$ with multiplicities.

\emph{(iii)} By \ref{KB27}(ii)–(iii), the minimal slope of $L_{\ge t}$ is the last slope of its filtration, which is at least $t$.

\emph{(iv)} By \ref{KB27}(ii)–(iii), the maximal slope of $L/L_{\ge t}$ is the first slope of the remaining filtration, which is below $t$.'),
  ('KC24',
'\emph{(i)} For any saturated $M''\subsetneq\varphi(E)$ set $M=\varphi^{-1}(M'')$. The induced isomorphism of groups
$$
\overline\varphi\colon E/M\longrightarrow\varphi(E)/M'',
\qquad x+M\longmapsto\varphi(x)+M''
$$
has a torsion-free target, so $M$ is saturated. For any $x\in E_\R$, take the representative of $x+M_\R$ perpendicular to $M_\R$. Applying $\varphi_\R$ increases its norm by at most the factor $\|\varphi\|$, and projecting to the orthogonal complement of $M''_\R$ can only reduce the norm. Divide the degree inequality of \ref{KB2B} by the common rank to get
$$
\mu(\varphi(E)/M'')\ge\mu(E/M)-h(\varphi)
\ge\mu_{\min}(E)-h(\varphi).
$$
Take the minimum over $M''$.

\emph{(ii)} Let $S=F\cap\varphi(E)_\R$ be the saturation of the image. Then
\begin{align*}
\mu_{\max}(F)&\ge\mu(S) &&\text{(a)}\\
&\ge\mu(\varphi(E)) &&\text{(b)}\\
&\ge\mu_{\min}(\varphi(E)) &&\text{(c)}\\
&\ge\mu_{\min}(E)-h(\varphi) &&\text{(d)}.
\end{align*}
Use $S$ in the maximum of \ref{KB25} for (a), \ref{KB24}(i) for (b), the zero sublattice in the minimum of \ref{KB25} for (c), and (i) for (d).'),
  ('KC27',
'\emph{Idea.} On the orthogonal complement of the restricted images, the trace of $Q$ comes only from the discarded directions. Compare this trace with that of a scalar operator.

Put $t=\operatorname{tr}Q$, $T=(\sum_i B_iE_i)^\perp$ and $w=\dim T$. For any subspace $U$ of an inner product space, write $P_U$ for orthogonal projection onto $U$.

\emph{(1)} \textbf{The trace controls the total domain dimension.} Cyclicity of trace gives $t=\sum_i\operatorname{tr}K_i$. Cauchy–Schwarz for the Hilbert–Schmidt inner product, summed over the domains, gives
$$
|t-R|\le\sqrt{R}\left(\sum_i\|K_i-I\|_{\rm HS}^2\right)^{1/2}
\le R\sqrt e.
$$
Thus $t\ge R/2>0$.

\emph{(2)} \textbf{The trace on $T$ comes from the discarded directions.} The map $P_TB_i$ vanishes on $E_i$. Its squared Hilbert–Schmidt norm on $E_i^\perp$ is at most that of $B_i$ there, so
$$
\operatorname{tr}(P_TQ)\le\sum_i\operatorname{tr}(P_{E_i^\perp}K_i).
$$
Write $d=\sum_i\operatorname{codim}E_i\le\kappa R$. Splitting $K_i=I+(K_i-I)$ and applying Cauchy–Schwarz gives
$$
\sum_i\operatorname{tr}(P_{E_i^\perp}K_i)
\le d+\sqrt{d\,eR}\le R(\kappa+\sqrt{\kappa e}).
$$

\emph{(3)} \textbf{The same trace controls the dimension of $T$.} The hypothesis on $\operatorname{tr}(Q^2)$ gives
$$
\|Q-(t/D)I\|_{\rm HS}^2=\operatorname{tr}(Q^2)-t^2/D
\le\eta t^2/D.
$$
Pair $Q-(t/D)I$ with $P_T$, of Hilbert–Schmidt norm $\sqrt w$, to obtain
$$
\operatorname{tr}(P_TQ)\ge tw/D-t\sqrt{\eta w/D}.
$$

\emph{(4)} \textbf{Combine the trace bounds.} Divide the bounds of (2) and (3) by $t$ and use (1) to get
$$
w/D-\sqrt{\eta w/D}\le2(\kappa+\sqrt{\kappa e}).
$$
Use $\sqrt{\eta w/D}\le(\eta+w/D)/2$ and solve for $w$. With $E_i=\R^{r_i}$ for all $i$, this gives a rank estimate of the kind used in \ref{8JUB}.'),
  ('KC28',
'\emph{Idea.} Keep the source pieces with high adjusted slope. Their images lie in the high-slope part of $C$. Bound the missing rank and integrate over the slope threshold.

\emph{(1)} \textbf{Few adjusted source slopes are low.} Fix a real $\lambda>0$. By \ref{KB2D}(i) the $R$ adjusted slopes $\mu_j(N_i)-h_i$, with $1\le i\le k$ and $1\le j\le r_i$, have mean at least $s$. Each is at most $s+u$ by \ref{KB27}(ii). If $m$ of them are below $s-\lambda$, then
$$
Rs\le m(s-\lambda)+(R-m)(s+u),
\qquad m\le\frac{Ru}{u+\lambda}.
$$

\emph{(2)} \textbf{Keep the high source pieces.} Put $N_i(\lambda)=(N_i)_{\ge s-\lambda+h_i}$ using \ref{KB2C}. The sum of their codimensions in the $N_i$ counts exactly the $m$ low slopes by \ref{KB2D}(ii).

\emph{(3)} \textbf{The images lie in the high target piece.} Put $C(\lambda)=C_{\ge s-\lambda}$. For any $i$ with $M_i=b_i(N_i(\lambda))\ne0$, the restriction of $b_i$ has height at most $h_i$. By \ref{KB2D}(iii) and \ref{KC24}(i), $\mu_{\min}(M_i)\ge s-\lambda$. If $M_i$ had a nonzero image in $C/C(\lambda)$, the quotient map restricted to $M_i$ would have height at most $0$ by \ref{KA25}. Then \ref{KC24}(ii) and \ref{KB2D}(iv) would give
$$
s-\lambda\le\mu_{\min}(M_i)
\le\mu_{\max}(C/C(\lambda))<s-\lambda.
$$
Thus $M_i\subset C(\lambda)$ for every $i$, including the zero images.

\emph{(4)} \textbf{Few target slopes are low.} In \ref{KC27} take $\kappa=u/(u+\lambda)$ and $E_i=\alpha_i^{-1}(N_i(\lambda)_\R)$. The span of the $B_iE_i$ lies in $\beta(C(\lambda)_\R)$ by (3). Write $F(\lambda)=\#\left\{j\in\{1,\dots,D\}\;\middle|\;\mu_j(C)<s-\lambda\right\}$. The estimate in \ref{KC27}, the bound $\kappa\le1$ and \ref{KB2D}(ii) give
$$
\frac{F(\lambda)}D\le\eta+\frac{4u}{u+\lambda}+4\sqrt e.
$$

\emph{(5)} \textbf{Integrate the bound on the missing rank.} Use $x_+=\max(x,0)$ for real $x$. By \ref{KB27}(ii), each $\mu_j(C)$ is at least $\mu_{\min}(C)\ge s-H$. For each integer $1\le j\le D$, the length of the interval of $\lambda\in(0,H)$ with $\mu_j(C)<s-\lambda$ is $(s-\mu_j(C))_+$. Hence
\begin{align*}
s-\mu(C)&\le\frac1D\sum_{j=1}^D(s-\mu_j(C))_+ &&\text{(a)}\\
&=\int_0^H\frac{F(\lambda)}D\,d\lambda &&\text{(b)}\\
&\le4u\ln(1+H/u)+(\eta+4\sqrt e)H &&\text{(c)}.
\end{align*}
Use \ref{KB2D}(i) in (a), the interval lengths in (b), and (4) in (c). When $u=0$, the term $4u/(u+\lambda)$ vanishes for every $\lambda>0$, as required by the convention in the statement.')
)
INSERT INTO proofs (result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail,
                    visibility, created_at, updated_at, created_by, updated_by)
SELECT r.id, 1, p.body_tex, NULL, 'ai_generated', 'gpt', 'Codex (spec by Claude Opus 5.5)',
       'published', '2026-11-28 15:00:00', '2026-11-28 15:00:00', 'codex', 'codex'
FROM appendix_proofs p JOIN results r ON r.tag = p.tag;

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'setting', key, revision, 'lattice-appendix-part1-2026-11-28', json_object('key', key, 'value', value),
       'codex', '2026-11-28 15:00:00'
FROM settings WHERE key = 'bibliography' OR (key = 'needs_rebuild' AND value <> '1');

UPDATE settings SET
  value = value || CASE WHEN value = '' OR substr(value, -1) = char(10) THEN '' ELSE char(10) END ||
'\bibitem{Zhang} R. Zhang, \emph{A preliminary note on Alpöge''s proposed proof of the generalized Riemann hypothesis}, 22 November 2026.
\bibitem{Bost2001} J.-B. Bost, \emph{Algebraic leaves of algebraic foliations over number fields}, Publ. Math. IHÉS 93 (2001), 161–221.
\bibitem{Stuhler1976} U. Stuhler, \emph{Eine Bemerkung zur Reduktionstheorie quadratischer Formen}, Arch. Math. (Basel) 27 (1976), 604–610.
\bibitem{Grayson1984} D. R. Grayson, \emph{Reduction theory using semistability}, Comment. Math. Helv. 59 (1984), 600–634.
\bibitem{Serre1973} J.-P. Serre, \emph{A Course in Arithmetic}, Graduate Texts in Mathematics 7, Springer, 1973.
\bibitem{Weil1964} A. Weil, \emph{Sur certains groupes d''opérateurs unitaires}, Acta Math. 111 (1964), 143–211.
\bibitem{Cassels1978} J. W. S. Cassels, \emph{Rational Quadratic Forms}, Academic Press, 1978.
\bibitem{Siegel1935} C. L. Siegel, \emph{Über die analytische Theorie der quadratischen Formen}, Ann. of Math. 36 (1935), 527–606.
\bibitem{Gross1999} B. H. Gross, \emph{Algebraic modular forms}, Israel J. Math. 113 (1999), 61–93.
\bibitem{Kudla1984} S. S. Kudla, \emph{Seesaw dual reductive pairs}, in: Automorphic Forms of Several Variables (Katata, 1983), Progr. Math. 46, Birkhäuser, 1984, 244–268.',
  revision = revision + 1
WHERE key = 'bibliography';

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'setting', key, revision, 'lattice-appendix-part1-2026-11-28', json_object('key', key, 'value', value),
       'codex', '2026-11-28 15:00:00'
FROM settings WHERE key = 'bibliography';

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'section', CAST(id AS TEXT), revision, 'lattice-appendix-part1-2026-11-28',
       json_object('tag', tag, 'kind', kind, 'title', title, 'intro_tex', intro_tex,
                   'parent_id', parent_id, 'position', position, 'appendix', appendix),
       'codex', '2026-11-28 15:00:00'
FROM sections WHERE tag IN ('APXB', 'BSE2', 'BSE3', 'BSE4');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(r.id AS TEXT), r.revision, 'lattice-appendix-part1-2026-11-28',
       json_object('tag', r.tag, 'type', r.type, 'title', r.title, 'statement_tex', r.statement_tex,
                   'section_id', r.section_id, 'position', r.position, 'listed', r.listed,
                   'aliases', json((SELECT json_group_array(alias) FROM aliases WHERE tag = r.tag)),
                   'understanding', r.understanding),
       'codex', '2026-11-28 15:00:00'
FROM results r JOIN sections s ON s.id = r.section_id WHERE s.tag IN ('BSE2', 'BSE3', 'BSE4');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'proof', CAST(p.id AS TEXT), p.revision, 'lattice-appendix-part1-2026-11-28',
       json_object('result_id', p.result_id, 'body_tex', p.body_tex, 'status', p.status, 'generated_by', p.generated_by,
                   'generator_detail', p.generator_detail, 'reviewed_by', p.reviewed_by, 'review_notes', p.review_notes,
                   'position', p.position, 'understanding', p.understanding),
       'codex', '2026-11-28 15:00:00'
FROM proofs p JOIN results r ON r.id = p.result_id JOIN sections s ON s.id = r.section_id
WHERE s.tag IN ('BSE2', 'BSE3', 'BSE4');

UPDATE settings SET value = '1', revision = revision + 1 WHERE key = 'needs_rebuild' AND value <> '1';

-- changes() here is the row count of the immediately preceding UPDATE.
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'setting', key, revision, 'lattice-appendix-part1-2026-11-28', json_object('key', key, 'value', value),
       'codex', '2026-11-28 15:00:00'
FROM settings WHERE key = 'needs_rebuild' AND changes() = 1;

-- Reference targets extracted by src/latex.ts renderTex with the backup macros.
WITH statement_refs(source_tag, target_tag) AS (VALUES
  ('KA22', 'KA23'), ('KA22', 'KA24'),
  ('KA23', 'KA22'),
  ('KA25', 'KA22'),
  ('KA26', 'KA22'),
  ('KA27', 'KA25'), ('KA27', 'KA26'), ('KA27', 'KA24'),
  ('KA24', 'KA27'),
  ('KB22', 'KA22'),
  ('KB23', 'WJQV'), ('KB23', 'KB24'), ('KB23', '8V4M'), ('KB23', 'Q7MN'), ('KB23', 'KC24'),
  ('KB24', 'KB22'),
  ('KB25', 'KA25'), ('KB25', 'KB22'), ('KB25', 'KB26'),
  ('KB26', 'KB22'), ('KB26', 'KB25'),
  ('KB29', 'KB25'),
  ('KB27', 'KB29'), ('KB27', 'KB2E'),
  ('KB2C', 'KB27'),
  ('KB2D', 'KB2C'),
  ('KB2E', 'KB27'), ('KB2E', 'KA24'),
  ('KC24', 'KC22'), ('KC24', 'KB25'), ('KC24', 'KC25'),
  ('KC25', 'KC24'), ('KC25', '8V4M'),
  ('KC28', 'KC22'), ('KC28', 'KB22'), ('KC28', 'KB25'), ('KC28', 'KC27')
)
INSERT INTO refs (source_result_id, source_proof_id, target_tag)
SELECT r.id, NULL, f.target_tag FROM statement_refs f JOIN results r ON r.tag = f.source_tag;

WITH proof_refs(source_tag, target_tag) AS (VALUES
  ('KA27', 'KA25'), ('KA27', 'KA23'), ('KA27', 'KA26'),
  ('KB24', 'KA27'),
  ('KB2B', 'KA23'),
  ('KB26', 'KB24'),
  ('KB28', 'KA25'), ('KB28', 'KB2B'), ('KB28', 'KB24'),
  ('KB29', 'KB24'), ('KB29', 'KB28'), ('KB29', 'KB25'),
  ('KB27', 'KB29'), ('KB27', 'KB24'), ('KB27', 'KB28'),
  ('KB2D', 'KB24'), ('KB2D', 'KB2C'), ('KB2D', 'KB27'),
  ('KC24', 'KB2B'), ('KC24', 'KB25'), ('KC24', 'KB24'),
  ('KC27', '8JUB'),
  ('KC28', 'KB2D'), ('KC28', 'KB27'), ('KC28', 'KB2C'), ('KC28', 'KC24'), ('KC28', 'KA25'), ('KC28', 'KC27')
)
INSERT INTO refs (source_result_id, source_proof_id, target_tag)
SELECT r.id, p.id, f.target_tag FROM proof_refs f
JOIN results r ON r.tag = f.source_tag JOIN proofs p ON p.result_id = r.id AND p.position = 1;
