-- Appendix B, sections B.4–B.6, and links from the main chapters.
-- Baseline: backup-before-lattice-appendix-2026-11-28.sql with part 1 applied.
-- Apply in one transaction.
INSERT OR ROLLBACK INTO write_guard (ok)
WITH main_fields(entity, id, revision, tex) AS (
  SELECT 'section', id, revision, intro_tex FROM sections
  WHERE (id = 117 AND tag = 'WJQV') OR (id = 107 AND tag = '8JU4')
  UNION ALL
  SELECT 'result', id, revision, statement_tex FROM results
  WHERE (id = 209 AND tag = 'Q7MN') OR (id = 187 AND tag = 'C4W2') OR (id = 154 AND tag = '8JV2')
  UNION ALL
  SELECT 'proof', p.id, p.revision, p.body_tex FROM proofs p JOIN results r ON r.id = p.result_id
  WHERE (p.id = 114 AND r.tag = '8JUA') OR (p.id = 162 AND r.tag = 'Q7MQ')
),
expected_fields(entity, id, revision) AS (VALUES
  ('section', 117, 5), ('section', 107, 8),
  ('result', 209, 1), ('result', 187, 1), ('result', 154, 4),
  ('proof', 114, 6), ('proof', 162, 1)
),
expected_phrases(entity, id, phrase) AS (VALUES
  ('section', 117, 'a lattice whose slope replaces $\ln|N|$'),
  ('section', 107, 'A Bost-type slope inequality bounds'),
  ('section', 107, 'a chain of $m$ theta lifts between unitary groups'),
  ('result', 209, 'Its slope $\mu(R)\in\R$'),
  ('result', 209, 'The period maps take values in the dual $R^\vee$, whose slope is $-\mu(R)$.'),
  ('result', 209, 'Its theta kernel gives the map by a weighted sum over lattice classes.'),
  ('result', 187, 'successive theta lifts between spaces of automorphic forms on definite unitary groups'),
  ('result', 154, 'Here $\mu(R)$ is the slope of the lattice $R$'),
  ('proof', 114, 'A seesaw identity compares'),
  ('proof', 114, 'A Bost-type inequality gives an upper bound')
)
SELECT 0 WHERE
  EXISTS (SELECT 1 FROM tags WHERE tag IN (
    'BSE5', 'BSE6', 'BSE7', 'KC29',
    'KD22', 'KD23', 'KD25', 'KD27', 'KD26', 'KD28', 'KD24', 'KD29',
    'KE22', 'KE26', 'KE23', 'KE24', 'KE25', 'KE27', 'KE28', 'KE2A',
    'KF22', 'KF23', 'KF24', 'KF25', 'KF27', 'KF26', 'KF28', 'KF29'
  ))
  OR EXISTS (SELECT 1 FROM aliases WHERE alias IN (
    'hermitian-lattice', 'poisson-summation', 'theta-series', 'theta-lift'
  ))
  OR (SELECT count(*) FROM tags WHERE tag IN (
    'APXB', 'BSE2', 'BSE3', 'BSE4', 'KA22', 'KA23', 'KA25', 'KA26', 'KA27', 'KA24',
    'KB22', 'KB23', 'KB24', 'KB2B', 'KB25', 'KB26', 'KB28', 'KB29', 'KB27', 'KB2C', 'KB2D', 'KB2E',
    'KC22', 'KC24', 'KC25', 'KC27', 'KC28'
  )) <> 27
  OR NOT EXISTS (SELECT 1 FROM sections WHERE tag = 'APXB' AND kind = 'chapter' AND appendix = 1 AND position = 101)
  OR NOT EXISTS (
    SELECT 1 FROM sections s JOIN sections c ON c.id = s.parent_id
    WHERE s.tag = 'BSE4' AND s.kind = 'section' AND s.position = 3 AND c.tag = 'APXB'
  )
  OR EXISTS (
    SELECT 1 FROM sections s JOIN sections c ON c.id = s.parent_id
    WHERE c.tag = 'APXB' AND s.position IN (4, 5, 6)
  )
  OR EXISTS (
    SELECT 1 FROM results r JOIN sections s ON s.id = r.section_id WHERE s.tag = 'BSE4' AND r.position = 6
  )
  OR EXISTS (
    SELECT 1 FROM expected_fields e LEFT JOIN main_fields f USING (entity, id)
    WHERE f.revision IS NOT e.revision
      OR EXISTS (SELECT 1 FROM revisions WHERE entity = e.entity AND entity_key = CAST(e.id AS TEXT) AND revision > e.revision)
      OR (SELECT author FROM revisions WHERE entity = e.entity AND entity_key = CAST(e.id AS TEXT)
          ORDER BY revision DESC LIMIT 1) = 'admin'
  )
  OR EXISTS (
    SELECT 1 FROM expected_phrases e LEFT JOIN main_fields f USING (entity, id)
    WHERE (length(f.tex) - length(replace(f.tex, e.phrase, ''))) IS NOT length(e.phrase)
  )
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
  ('BSE5', 'section'), ('BSE6', 'section'), ('BSE7', 'section'), ('KC29', 'result'),
  ('KD22', 'result'), ('KD23', 'result'), ('KD25', 'result'), ('KD27', 'result'),
  ('KD26', 'result'), ('KD28', 'result'), ('KD24', 'result'), ('KD29', 'result'),
  ('KE22', 'result'), ('KE26', 'result'), ('KE23', 'result'), ('KE24', 'result'),
  ('KE25', 'result'), ('KE27', 'result'), ('KE28', 'result'), ('KE2A', 'result'),
  ('KF22', 'result'), ('KF23', 'result'), ('KF24', 'result'), ('KF25', 'result'),
  ('KF27', 'result'), ('KF26', 'result'), ('KF28', 'result'), ('KF29', 'result')
)
INSERT INTO tags (tag, kind, created_at)
SELECT tag, kind, '2026-11-28 15:30:00' FROM appendix_tags;

INSERT INTO aliases (alias, tag, created_at) VALUES
  ('hermitian-lattice', 'KD27', '2026-11-28 15:30:00'),
  ('poisson-summation', 'KE23', '2026-11-28 15:30:00'),
  ('theta-series', 'KE25', '2026-11-28 15:30:00'),
  ('theta-lift', 'KF25', '2026-11-28 15:30:00');

WITH appendix_sections(tag, position, title, intro_tex) AS (VALUES
  ('BSE5', 4, 'Hermitian lattices over CM fields',
   'We form the Euclidean lattice underlying a Hermitian lattice and compute the slope normalization used in \ref{8JV2}.'),
  ('BSE6', 5, 'Theta series',
   'We count vectors of each norm and use Poisson summation to compare the theta series of a lattice and its dual. This is the lattice sum underlying the theta kernels of \ref{C4W2}.'),
  ('BSE7', 6, 'Theta lifts in the definite case',
   'We compute a theta lift by summing theta series over a finite set of lattice classes. The unitary chain of \ref{C4W2} uses the same weighted-sum construction.')
)
INSERT INTO sections (tag, parent_id, kind, title, intro_tex, intro_html_cache, position, appendix,
                      created_at, updated_at, updated_by)
SELECT s.tag, c.id, 'section', s.title, s.intro_tex, NULL, s.position, 0,
       '2026-11-28 15:30:00', '2026-11-28 15:30:00', 'codex'
FROM appendix_sections s CROSS JOIN sections c WHERE c.tag = 'APXB';

WITH appendix_results(section_tag, position, tag, type, listed, title, statement_tex) AS (VALUES
  ('BSE4', 6, 'KC29', 'remark', 1, 'How the comparison uses the mean slope bound',
'The period maps of \ref{Q7MN} take the domain lattices (the $N_i$ of \ref{KC28}) to $R^\vee$ (the target $C$), with heights bounded by the $h_u$ of \ref{8JV2}. The control of the span in \ref{KC27} is where the rank estimate of \ref{8JUB} enters.

The lower bound of \ref{KC28} is for the mean slope of the dual. For Euclidean lattices, $\mu(R^\vee)=-\mu(R)$ by \ref{KB24}(iii). Thus a lower bound for the dual gives an upper bound for the original slope, on the size side of \ref{WJQV} recorded in \ref{Q7MQ}. For the Hermitian lattices of the book, use the slope of \ref{KD27} and the duality normalization in \ref{KD29}.'),
  ('BSE5', 1, 'KD22', 'definition', 1, 'CM field',
'A CM field is a totally imaginary number field $E$ with a totally real subfield $E^+$ of index $[E:E^+]=2$. Write $c$ for the nontrivial automorphism of $E/E^+$. For every embedding $\sigma\colon E\longrightarrow\C$, the map $\sigma\circ c$ is \hyperref[KD23]{the conjugate embedding} $\overline\sigma$.

The Gaussian field $\Q(i)$ is an example. See \ref{KD24}. For any integer $m\ge3$, the cyclotomic field $\Q(\zeta_m)$ of a primitive $m$th root of unity is a CM field with $E^+=\Q(\zeta_m+\zeta_m^{-1})$.'),
  ('BSE5', 2, 'KD23', 'lemma', 0, 'Complex conjugation on a CM field',
'Let $E$ be a CM field with automorphism $c$ as in \ref{KD22}. For every embedding $\sigma\colon E\longrightarrow\C$, one has $\sigma\circ c=\overline\sigma$.'),
  ('BSE5', 3, 'KD25', 'definition', 1, 'Hermitian spaces and unitary groups',
'Let $E$ be a CM field with conjugation $c$ as in \ref{KD22}. A Hermitian space over $E$ is a finite-dimensional $E$-vector space $V$ with a nondegenerate form $h\colon V\times V\longrightarrow E$ that is $E$-linear in the first variable and satisfies $h(w,v)=c(h(v,w))$ for all $v,w\in V$.

For every embedding $\sigma\colon E\longrightarrow\C$, let $h_\sigma$ be the Hermitian extension of $\sigma\circ h$ to $V_\sigma=V\otimes_{E,\sigma}\C$. The space is totally definite if every $h_\sigma$ is positive definite. Its unitary group is
$$
U(V)=\left\{g\in\mathrm{GL}_E(V)\;\middle|\;
 h(gv,gw)=h(v,w)\text{ for all }v,w\in V\right\}.
$$'),
  ('BSE5', 4, 'KD27', 'definition', 1, 'Hermitian lattices and their normalized slope',
'Let $E$ be a CM field as in \ref{KD22}, with ring of integers $\mathcal O_E$ and discriminant $\Delta_E$. A Hermitian $\mathcal O_E$-lattice is a finitely generated torsion-free $\mathcal O_E$-module $\Lambda$ equipped, for each embedding $\sigma\colon E\longrightarrow\C$, with a positive definite Hermitian form $h_\sigma$ on $\Lambda_\sigma=\Lambda\otimes_{\mathcal O_E,\sigma}\C$. For all $x,y\in\Lambda$, the forms satisfy
$$
h_{\overline\sigma}(x\otimes1,y\otimes1)
=\overline{h_\sigma(x\otimes1,y\otimes1)}.
$$
The underlying \hyperref[KD26]{Euclidean lattice} $\Lambda_\Z$ is $\Lambda$ with the inner product
$$
\langle x,y\rangle=\frac12\sum_{\sigma:E\hookrightarrow\C}
 h_\sigma(x\otimes1,y\otimes1).
$$
For $\Lambda\ne0$, its normalized slope, using $\mu$ from \ref{KB22}, is
$$
\mu_E(\Lambda)=2\mu(\Lambda_\Z)-\ln 2+\frac{\ln|\Delta_E|}{[E:\Q]}.
$$
See \cite[Section 4.3]{Zhang} for this normalization.'),
  ('BSE5', 5, 'KD26', 'lemma', 1, 'The underlying Euclidean lattice',
'Use the data of \ref{KD22}, \ref{KD25} and \ref{KD27}.
\begin{enumerate}
\item[(i)] For any Hermitian $\mathcal O_E$-lattice $\Lambda$, the inner product of \ref{KD27} makes $\Lambda_\Z$ a Euclidean lattice of rank $[E:\Q]\operatorname{rk}_{\mathcal O_E}\Lambda$.
\item[(ii)] Let $(V,h)$ be any totally definite Hermitian space over $E$. For any finitely generated $\mathcal O_E$-submodule $\Lambda\subset V$ spanning $V$ over $E$, the forms $h_\sigma$ make $\Lambda$ a Hermitian lattice. For all $x,y\in\Lambda$, its Euclidean inner product is
$$
\langle x,y\rangle=\frac12\operatorname{Tr}_{E/\Q} h(x,y).
$$
\item[(iii)] For $(V,h)$ and $\Lambda$ as in (ii), the group $U(\Lambda)=\left\{g\in U(V)\;\middle|\;g\Lambda=\Lambda\right\}$ is finite.
\end{enumerate}
See \ref{KD24} for the Gaussian field.'),
  ('BSE5', 6, 'KD28', 'lemma', 1, 'The standard lattice has slope zero',
'Let $E$ be a CM field and $r\ge1$ an integer. Give $\mathcal O_E^r$ the forms $h_\sigma(z,w)=\sum_{k=1}^r z_k\overline{w_k}$ for $z,w\in\C^r$ at each embedding $\sigma\colon E\longrightarrow\C$. Its normalized slope $\mu_E(\mathcal O_E^r)$ from \ref{KD27} is zero.'),
  ('BSE5', 7, 'KD24', 'example', 0, 'The Gaussian field',
'Take $E=\Q(i)$ with $E^+=\Q$, $\mathcal O_E=\Z[i]$ and $\Delta_E=-4$. For any integer $n\ge1$, the space $V=E^n$ with $h(v,w)=\sum_{k=1}^n v_k\overline{w_k}$ is totally definite. Put $\Lambda=\Z[i]^n$. For all $x,y\in\Lambda$, the trace formula of \ref{KD26}(ii) gives
$$
\langle x,y\rangle=\Re\sum_{k=1}^n x_k\overline{y_k}.
$$
For the standard basis $e_1,\dots,e_n$ of $V$, the vectors $e_k,ie_k$ give an orthonormal $\Z$-basis. Thus $\Lambda_\Z$ is isometric to $\Z^{2n}$ and \ref{KD27} gives $\mu_E(\Lambda)=0-\ln 2+\tfrac12\ln 4=0$.

The norm-one vectors are $\pm e_k$ and $\pm ie_k$ for integers $1\le k\le n$. The image of the standard basis under a unitary automorphism must choose one such vector on each coordinate line, in any order. These choices give the monomial matrices with nonzero entries in $\{\pm1,\pm i\}$ and $|U(\Lambda)|=4^n n!$.'),
  ('BSE5', 8, 'KD29', 'remark', 1, 'Lattices over CM fields in the book',
'The auxiliary field $E$ of \ref{8JV2} and \ref{C4W2} is an abelian CM field. The spaces $X_j$ of the chain are totally definite Hermitian spaces, so their unitary groups are compact at every real place. The lattices $R$ of automorphic forms are Hermitian lattices over $\mathcal O_E$ with Petersson metrics \cite[Section 1.3]{Zhang}. The field term $\ln|\Delta_E|/[E:\Q]=\ln\mathrm{rd}_E$ of \ref{KD27} is the logarithm of the root discriminant appearing in $\Lambda_\upsilon$ of \ref{8JV2}.

Sections B.2–B.3 apply to the underlying Euclidean lattices. Convert bounds for their slopes using $\mu_E=2\mu-\ln 2+\ln\mathrm{rd}_E$. For a nonzero Hermitian lattice $\Lambda$, give $\Lambda^\vee=\operatorname{Hom}_{\mathcal O_E}(\Lambda,\mathcal O_E)$ the dual norms. The integral dual for the pairing $\tfrac12\operatorname{Tr}_{E/\Q}$ applied to evaluation is $2\mathfrak d_E^{-1}\Lambda^\vee$, where $\mathfrak d_E$ is the different of $E/\Q$. Its Euclidean covolume differs from that of $(\Lambda^\vee)_\Z$ by the factor $(2^{[E:\Q]}/|\Delta_E|)^{\operatorname{rk}_{\mathcal O_E}\Lambda}$. Combining this factor with Euclidean duality gives $\mu_E(\Lambda^\vee)=-\mu_E(\Lambda)$. For filtrations by $\mathcal O_E$-submodules see \cite{Grayson1984}.'),
  ('BSE6', 1, 'KE22', 'definition', 1, 'Fourier transform',
'Let $V$ be a real Euclidean space of dimension $n$ with Lebesgue measure from orthonormal coordinates. Write $\mathcal S(V)$ for the Schwartz space of smooth complex functions whose derivatives of all orders, including order zero, decay faster than any inverse power of $1+|x|$. For $f\in\mathcal S(V)$, its Fourier transform is given for $\xi\in V$ by
$$
\widehat f(\xi)=\int_V f(x)e^{-2\pi i\langle x,\xi\rangle}\,dx.
$$'),
  ('BSE6', 2, 'KE26', 'lemma', 0, 'Counting lattice points',
'Let $L$ be a Euclidean lattice of rank $n$ as in \ref{KA22}.
\begin{enumerate}
\item[(i)] There is a real $C>0$ such that for every real $T\ge0$,
$$
\#\left\{x\in L\;\middle|\;|x|\le T\right\}\le C(1+T)^n.
$$
For every real $N>n$, the sum of $(1+|x|)^{-N}$ over $x\in L$ is finite.
\item[(ii)] For every real $y_0>0$, the sum of $e^{-\pi y_0|x|^2}$ over $x\in L$ is finite. The series $\sum_{x\in L}e^{\pi i\tau|x|^2}$ converges absolutely and uniformly for $\Im\tau\ge y_0$.
\end{enumerate}'),
  ('BSE6', 3, 'KE23', 'theorem', 1, 'Poisson summation',
'Let $L$ be a Euclidean lattice, put $V=L_\R$, and take $f\in\mathcal S(V)$ as in \ref{KE22}. The following sums \hyperref[KE26]{converge absolutely} and satisfy
$$
\sum_{x\in L} f(x)=\frac1{\operatorname{covol}(L)}
 \sum_{y\in L^\vee}\widehat f(y),
$$
where $L^\vee$ is the dual of \ref{KA26}. See \cite[Chapter VII]{Serre1973}.'),
  ('BSE6', 4, 'KE24', 'lemma', 1, 'The Fourier transform of a Gaussian',
'Let $V$ be a real Euclidean space of dimension $n$ and write $\mathbb H=\left\{\tau\in\C\;\middle|\;\Im\tau>0\right\}$. For every $\tau\in\mathbb H$, the function $g_\tau(x)=e^{\pi i\tau|x|^2}$ for $x\in V$ belongs to $\mathcal S(V)$ and has Fourier transform in the convention of \ref{KE22}
$$
\widehat{g_\tau}=(\tau/i)^{-n/2}g_{-1/\tau},
$$
with the principal branch of the power.'),
  ('BSE6', 5, 'KE25', 'definition', 1, 'Theta series of a lattice',
'For a Euclidean lattice $L$, its theta series is the holomorphic function on the upper half-plane $\mathbb H$ of \ref{KE24} given by the absolutely and locally uniformly \hyperref[KE26]{convergent} series
$$
\theta_L(\tau)=\sum_{x\in L}e^{\pi i\tau\langle x,x\rangle}.
$$
The lattice is even if $\langle x,x\rangle\in2\Z$ for every $x\in L$. For even $L$, write $q=e^{2\pi i\tau}$ and, for each integer $m\ge0$, put
$$
r_L(m)=\#\left\{x\in L\;\middle|\;\langle x,x\rangle=2m\right\}.
$$
Then $\theta_L(\tau)=\sum_{m\ge0}r_L(m)q^m$. See \ref{KE28}.'),
  ('BSE6', 6, 'KE27', 'theorem', 1, 'The inversion formula',
'Let $L$ be a Euclidean lattice of rank $n$ and use $L^\vee$ from \ref{KA26} and $\theta_L$ from \ref{KE25}. For every $\tau\in\mathbb H$,
$$
\theta_L(-1/\tau)=\frac{(\tau/i)^{n/2}}{\operatorname{covol}(L)}
 \theta_{L^\vee}(\tau),
$$
with the branch of \ref{KE24}. See \ref{KE28} for two examples.'),
  ('BSE6', 7, 'KE28', 'example', 0, 'Theta series of $\Z^n$ and $A_2$',
'For the standard lattice $\Z$, put $\theta(\tau)=\theta_\Z(\tau)=\sum_{k\in\Z}e^{\pi i k^2\tau}$. Its dual is itself and its covolume is one, so \ref{KE27} gives $\theta(-1/\tau)=(\tau/i)^{1/2}\theta(\tau)$. For any integer $n\ge1$, $\theta_{\Z^n}=\theta^n$. The coefficient of $t^m$ for $t=e^{\pi i\tau}$ and integer $m\ge0$ counts representations of $m$ as a sum of $n$ squares. For $n=2$ the coefficients from $m=0$ to $m=9$ are $1,4,4,0,4,8,0,0,4,4$.

For the lattice $A_2$ of \ref{KA24}, the vector $ae_1+be_2$ for integers $a,b$ has squared norm $2(a^2+ab+b^2)$. This gives the even theta series, with $q=e^{2\pi i\tau}$,
$$
\theta_{A_2}(\tau)=1+6q+6q^3+6q^4+12q^7+6q^9+O(q^{10}).
$$
Using the covolume $\sqrt3$ of \ref{KA24} in \ref{KE27} gives
$$
\theta_{A_2}(-1/\tau)=(\tau/i)\,3^{-1/2}\,\theta_{A_2^\vee}(\tau).
$$'),
  ('BSE6', 8, 'KE2A', 'remark', 1, 'Theta series and the Weil representation',
'In the projective Weil action of $\mathrm{SL}_2(\R)$ on $\mathcal S(V)$, a Weyl element acts by Fourier transform up to a scalar. The upper unipotent subgroup acts by multiplication by $e^{\pi i b|x|^2}$ for real $b$. The Fourier operator and the multiplier at $b=1$ give the action of the modular group generators \cite{Weil1964}.

The functional $f\longmapsto\sum_{x\in L}f(x)$ on $\mathcal S(V)$ gives $\theta_L(\tau)$ at $f=g_\tau$ of \ref{KE24}. Its transformation under Fourier transform is \ref{KE23}. The theta kernels of \ref{C4W2} are the adelic version for the tensor product of a Hermitian and a skew-Hermitian space \cite[Section 4.1]{Zhang}.'),
  ('BSE7', 1, 'KF22', 'definition', 1, 'Even lattices and genera',
'A Euclidean lattice $L$ is integral if $\langle x,y\rangle\in\Z$ for all $x,y\in L$. It is even if $\langle x,x\rangle\in2\Z$ for every $x\in L$. An isometry of Euclidean lattices is a group isomorphism preserving the inner products. The group of isometries from $L$ to itself is $O(L)$.

Two even lattices $L,L''$ are in the same genus if they have the same rank and, for every prime $p$, the $\Z_p$-modules $L\otimes_\Z\Z_p$ and $L''\otimes_\Z\Z_p$ are isometric for their extended quadratic forms $x\longmapsto\langle x,x\rangle/2$. The genus of $L$ is the set of isometry classes satisfying these conditions. See \cite{Cassels1978}.'),
  ('BSE7', 2, 'KF23', 'theorem', 1, 'Finiteness',
'Let $L$ be any even Euclidean lattice as in \ref{KF22}.
\begin{enumerate}
\item[(i)] The group $O(L)$ is finite.
\item[(ii)] The genus of $L$ contains finitely many isometry classes.
\end{enumerate}'),
  ('BSE7', 3, 'KF24', 'definition', 1, 'Functions on classes and the mass',
'Let $\mathcal G$ be a genus as in \ref{KF22} with class representatives $L_1,\dots,L_h$ as in \ref{KF23}. Write $M(\mathcal G)$ for the space of complex functions on its classes. This is the space of algebraic modular forms of trivial weight for the corresponding definite orthogonal group \cite{Gross1999}.

For $f,g\in M(\mathcal G)$, put
$$
\langle f,g\rangle_{\mathcal G}
=\sum_{k=1}^h\frac{f(L_k)\overline{g(L_k)}}{|O(L_k)|}.
$$
The mass is $m(\mathcal G)=\sum_{k=1}^h |O(L_k)|^{-1}$. See \ref{KF28}.'),
  ('BSE7', 4, 'KF25', 'definition', 1, 'The theta lift',
'Take $\mathcal G$, its representatives $L_1,\dots,L_h$ and $M(\mathcal G)$ from \ref{KF24}. For any $f\in M(\mathcal G)$, its theta lift is the holomorphic function given for $\tau\in\mathbb H$ by
$$
\Theta(f)(\tau)=\sum_{k=1}^h\frac{f(L_k)}{|O(L_k)|}\theta_{L_k}(\tau),
$$
using the theta series of \ref{KE25}. See \ref{KF28} for a lift of the constant function and a lift of a function orthogonal to it.'),
  ('BSE7', 5, 'KF27', 'lemma', 1, 'Coefficients and products of theta lifts',
'Use the notation of \ref{KE25}, \ref{KF24} and \ref{KF25}.
\begin{enumerate}
\item[(i)] For any genus $\mathcal G$, any $f\in M(\mathcal G)$ and each integer $m\ge0$, put $r_\bullet(m)(L_k)=r_{L_k}(m)$ for the class representatives $L_k$. Then
$$
\Theta(f)=\sum_{m\ge0}\langle f,r_\bullet(m)\rangle_{\mathcal G}\,q^m.
$$
\item[(ii)] For genera $\mathcal G'',\mathcal G''''$ with representatives $L''_k,L''''_l$ and any $f''\in M(\mathcal G'')$, $f''''\in M(\mathcal G'''')$, one has
$$
\sum_{k,l}\frac{f''(L''_k)f''''(L''''_l)}{|O(L''_k)|\,|O(L''''_l)|}
 \theta_{L''_k\oplus L''''_l}
=\Theta(f'')\Theta(f'''').
$$
The sum $L''_k\oplus L''''_l$ is orthogonal.
\end{enumerate}'),
  ('BSE7', 6, 'KF26', 'theorem', 1, 'Siegel''s formula',
'Let $\mathcal G$ be the genus of an even lattice $L$ of rank at least two, with mass $m(\mathcal G)$ from \ref{KF24}. Let $1$ be the constant function of value one on $\mathcal G$. The normalized series $\Theta(1)/m(\mathcal G)$ of \ref{KF25} depends only on $\mathcal G$. For every integer $m\ge1$, its coefficient at $q^m$ is the product of the local representation densities of $m$ by the quadratic form $\langle x,x\rangle/2$ of $L$, including the real density, in Siegel''s normalization \cite{Siegel1935}. The constant coefficient is one. See \ref{KF28}.'),
  ('BSE7', 7, 'KF28', 'example', 0, 'The genus of discriminant $-23$',
'Let $L_1,L_2$ be even lattices on $\Z^2$. For $k=1,2$ and $(x,y)\in\Z^2$, write $Q_k(x,y)=\langle (x,y),(x,y)\rangle_{L_k}/2$. Take the Gram matrices and forms
\begin{align*}
G_1&=\begin{pmatrix}2&1\\1&12\end{pmatrix},
& Q_1(x,y)&=x^2+xy+6y^2,\\
G_2&=\begin{pmatrix}4&1\\1&6\end{pmatrix},
& Q_2(x,y)&=2x^2+xy+3y^2.
\end{align*}
Both have discriminant $-23$. A reduced form $ax^2+bxy+cy^2$ of this discriminant has $|b|\le a\le c$ and $3a^2\le23$ \cite{Cassels1978}. The possibilities are $a=1,2$ with $b=\pm1$, and $(x,y)\longmapsto(x,-y)$ identifies the two signs. The two classes are distinct, with smallest positive values $1$ and $2$.

For odd primes the change of basis $\tfrac12\begin{pmatrix}1&3\\-1&1\end{pmatrix}$ takes $G_2$ to $G_1$. At $2$, the simple roots of $Q_1(x,1)$ and $Q_2(1,y)$ modulo $2$ lift to roots in $\Z_2$. Each lattice therefore has a primitive isotropic vector. Its pairing with some second vector is a unit by unimodularity. Scale the second vector to make the pairing one and subtract its quadratic value times the first vector to make it isotropic too. Both forms at $2$ are thus isometric to $xy$. This gives a single genus $\mathcal G$ with the two classes.

Counting possible images of the basis vectors in each lattice gives $|O(L_1)|=4$ and $|O(L_2)|=2$. Thus $m(\mathcal G)=3/4$. Counting vectors as in \ref{KE25} gives
\begin{align*}
\theta_{L_1}&=1+2q+2q^4+4q^6+4q^8+2q^9+O(q^{10}),\\
\theta_{L_2}&=1+2q^2+2q^3+2q^4+2q^6+2q^8+2q^9+O(q^{10}).
\end{align*}
For the constant function $1$, the normalized average of \ref{KF26} is
\begin{align*}
\frac{\Theta(1)}{m(\mathcal G)}
 &=\frac{\theta_{L_1}+2\theta_{L_2}}3\\
 &=1+\frac23\sum_{m=1}^9\left(\sum_{d\mid m}
     \left(\frac d{23}\right)\right)q^m+O(q^{10}).
\end{align*}
Here $\left(\frac d{23}\right)$ is the quadratic symbol modulo $23$. For $f(L_1)=4$ and $f(L_2)=-2$, one has $\langle f,1\rangle_{\mathcal G}=0$. Its lift is $\theta_{L_1}-\theta_{L_2}$, and through $q^9$ it agrees with the doubled eta product
\begin{align*}
2q\prod_{n\ge1}(1-q^n)(1-q^{23n})
 &=2(q-q^2-q^3+q^6+q^8)+O(q^{10}).
\end{align*}'),
  ('BSE7', 8, 'KF29', 'remark', 1, 'Theta lifts in the book',
'In the chain of \ref{C4W2}, the groups are definite unitary groups $U(X_j)$ as in \ref{KD25}. Automorphic forms on them are functions on finitely many classes of Hermitian lattices, with vector values for nontrivial weight \cite{Gross1999}. Each lift is a weighted sum over lattice classes against a theta kernel, as in \ref{KF25}. See \ref{Q7MN} and \cite[Section 4.1]{Zhang}.

Kudla''s seesaw identities \cite{Kudla1984} exchange the order of two weighted sums, as in the product calculation of \ref{KF27}(ii). Step (1) of \ref{8JUA} uses this exchange to compare two period maps.')
)
INSERT INTO results (tag, type, title, statement_tex, statement_html_cache, section_id, position,
                     visibility, state, listed, created_at, updated_at, created_by, updated_by)
SELECT r.tag, r.type, r.title, r.statement_tex, NULL, s.id, r.position, 'published', 'active', r.listed,
       '2026-11-28 15:30:00', '2026-11-28 15:30:00', 'codex', 'codex'
FROM appendix_results r JOIN sections s ON s.tag = r.section_tag;

WITH appendix_proofs(tag, body_tex) AS (VALUES
  ('KD23',
'Choose $\alpha\in E$ with $E=E^+(\alpha)$, $\alpha^2\in E^+$ and $c(\alpha)=-\alpha$. For any embedding $\sigma\colon E\longrightarrow\C$, the number $\sigma(\alpha)$ has real square and is nonreal by total imaginarity. It is therefore purely imaginary, so $\overline{\sigma(\alpha)}=-\sigma(\alpha)=\sigma(c(\alpha))$. Both maps restrict to $\sigma$ on the totally real field $E^+$.'),
  ('KD26',
'\emph{(i)} The module $\Lambda$ is finitely generated and torsion free over $\Z$. Its rational span is an $E$-vector space of dimension $\operatorname{rk}_{\mathcal O_E}\Lambda$, which gives the stated $\Z$-rank. Let $\Phi$ contain one embedding from each conjugate pair. The real decomposition $E\otimes_\Q\R\cong\prod_{\sigma\in\Phi}\C$ identifies $\Lambda\otimes_\Z\R$ with $\prod_{\sigma\in\Phi}\Lambda_\sigma$. On this product, conjugate pairing gives the sum of the real parts of the $h_\sigma$ for $\sigma\in\Phi$. Each real part is symmetric and positive definite.

\emph{(ii)} The inclusion in $V$ gives torsion freeness and spanning identifies $\Lambda_\sigma$ with $V_\sigma$. Positivity follows from total definiteness. On $x,y\in\Lambda$ the value at $\sigma$ is $\sigma(h(x,y))$, so the conjugacy condition holds and summing over all $\sigma$ gives the trace.

\emph{(iii)} An element of $U(\Lambda)$ is an isometry of $\Lambda_\Z$ by (ii). Each vector of a fixed $\Z$-basis can map only to lattice vectors of the same norm. There are finitely many by \ref{KE26}(i), and the images determine the isometry.'),
  ('KD28',
'Write $d=[E:\Q]$. First take $r=1$ and a $\Z$-basis $\omega_1,\dots,\omega_d$ of $\mathcal O_E$. Set $A=(\sigma(\omega_j))_{j,\sigma}$ with columns indexed by all embeddings. The Euclidean Gram matrix of \ref{KD27} is $\tfrac12 AA^*$. The trace matrix defining $\Delta_E$ is $AA^{\mathsf T}$, so $|\det A|^2=|\Delta_E|$. Hence
$$
\operatorname{covol}(\mathcal O_E)=2^{-d/2}|\Delta_E|^{1/2}.
$$
The $r$ coordinates give orthogonal copies of this lattice. Their Gram matrix is block diagonal, so the covolume is the $r$th power and the $\Z$-rank is $dr$. The slope of \ref{KB22} is therefore $\tfrac12\ln 2-\ln|\Delta_E|/(2d)$. Inserting it into \ref{KD27} gives zero.'),
  ('KE26',
'\emph{(i)} If $n=0$, the only point is $0$. For $n\ge1$, the discreteness of $L$ gives a least nonzero norm $\rho>0$. The open balls of radius $\rho/2$ centered at the lattice points of norm at most $T$ are disjoint inside the ball of radius $T+\rho/2$. Comparing volumes in $L_\R$ gives the bound $(1+2T/\rho)^n$. For each integer $j\ge0$, the shell $2^j\le 1+|x|<2^{j+1}$ contributes at most $C2^{(j+1)n-jN}$ to the inverse-power sum. The resulting geometric series converges for $N>n$.

\emph{(ii)} For any fixed $y_0>0$ and $N>n$, the function $e^{-\pi y_0 t^2}(1+t)^N$ is bounded for real $t\ge0$. Apply (i) with $t=|x|$. The Gaussian majorizes the absolute values of all summands on $\Im\tau\ge y_0$.'),
  ('KE23',
'Let $P\subset V$ be the basis parallelotope of \ref{KA23}(ii) and put $F(v)=\sum_{x\in L}f(v+x)$ for $v\in V$. The inverse-power bound of \ref{KE26}(i) gives uniform convergence on compact sets, also for every derivative, so $F$ is smooth and $L$-periodic. The characters on $V/L$ are $v\longmapsto e^{2\pi i\langle v,y\rangle}$ for $y\in L^\vee$ by \ref{KA26}.

For any $y\in L^\vee$, the Fourier coefficient of $F$ at $y$ is
$$
\frac1{\operatorname{covol}(L)}
\int_P F(v)e^{-2\pi i\langle v,y\rangle}\,dv
=\frac{\widehat f(y)}{\operatorname{covol}(L)}.
$$
To unfold, translate the integral in the $x$th summand to $P+x$ and use $\langle x,y\rangle\in\Z$. These translates tile $V$ up to their boundaries. The Fourier coefficients of the smooth periodic function decay faster than any inverse power by integration by parts. By \ref{KE26}(i) for $L^\vee$, the Fourier series converges absolutely and uniformly, and it equals $F$ by Fourier uniqueness on the torus. Evaluate it at $v=0$.'),
  ('KE24',
'In orthonormal coordinates the Gaussian is a product, so it suffices to compute in dimension one. For real $t>0$, put $F(\xi)=\widehat{g_{it}}(\xi)$ for $\xi\in\R$. Differentiating under the integral and integrating by parts gives $F''(\xi)=-2\pi \xi F(\xi)/t$. The Gaussian integral gives $F(0)=t^{-1/2}$. Thus $F(\xi)=t^{-1/2}e^{-\pi\xi^2/t}$.

For fixed $\xi$, the integral is holomorphic in $\tau$ by domination by Gaussians with polynomial factors on compact subsets of $\mathbb H$. The claimed expression is holomorphic there because $\tau/i$ lies in the right half-plane. The identity theorem gives the formula for all $\tau\in\mathbb H$. All derivatives in $x$ of $g_\tau$ are polynomials times the same decaying Gaussian, so $g_\tau\in\mathcal S(V)$.'),
  ('KE27',
'Apply \ref{KE23} to $g_{-1/\tau}$ of \ref{KE24}. The relation $(-1/\tau)/i=(\tau/i)^{-1}$ gives $\widehat{g_{-1/\tau}}=(\tau/i)^{n/2}g_\tau$ on the stated branch. Substituting into the two sums gives the formula.'),
  ('KF23',
'\emph{(i)} Apply the basis-image argument of \ref{KD26}(iii) to $L$.

\emph{(ii)} The finiteness theorem for integral positive definite quadratic forms of fixed rank and determinant gives this assertion \cite[Chapter 9]{Cassels1978}. The local isometries of \ref{KF22} fix the valuation of the Gram determinant at every prime. The determinant is positive, so these valuations fix it.'),
  ('KF27',
'\emph{(i)} Insert the expansion of \ref{KE25} in \ref{KF25} and collect the coefficients. The representation counts are real, so their conjugates in the inner product of \ref{KF24} are the same counts.

\emph{(ii)} For $x=(x'',x'''')$ in an orthogonal sum, the squared norm is $|x''|^2+|x''''|^2$. Splitting the absolutely convergent sum of \ref{KE25} gives $\theta_{L''_k\oplus L''''_l}=\theta_{L''_k}\theta_{L''''_l}$. The two finite weighted sums then factor as the product of the lifts in \ref{KF25}.'),
  ('KF26',
'By \ref{KF27}(i), the coefficient at positive index is the genus average of the representation number with weights $1/|O(L_k)|$ divided by the mass. Siegel''s representation formula \cite{Siegel1935} identifies this normalized average with the product of densities. At index zero, only the zero vector contributes in each class, and the weights sum to the mass.')
)
INSERT INTO proofs (result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail,
                    visibility, created_at, updated_at, created_by, updated_by)
SELECT r.id, 1, p.body_tex, NULL, 'ai_generated', 'gpt', 'Codex (spec by Claude Opus 5.5)',
       'published', '2026-11-28 15:30:00', '2026-11-28 15:30:00', 'codex', 'codex'
FROM appendix_proofs p JOIN results r ON r.tag = p.tag;

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'section', CAST(id AS TEXT), revision, 'lattice-appendix-part2-2026-11-28',
       json_object('tag', tag, 'kind', kind, 'title', title, 'intro_tex', intro_tex,
                   'parent_id', parent_id, 'position', position, 'appendix', appendix),
       'codex', '2026-11-28 15:30:00'
FROM sections WHERE id IN (117, 107);

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(r.id AS TEXT), r.revision, 'lattice-appendix-part2-2026-11-28',
       json_object('tag', r.tag, 'type', r.type, 'title', r.title, 'statement_tex', r.statement_tex,
                   'section_id', r.section_id, 'position', r.position, 'listed', r.listed,
                   'aliases', json((SELECT json_group_array(alias) FROM aliases WHERE tag = r.tag)),
                   'understanding', r.understanding),
       'codex', '2026-11-28 15:30:00'
FROM results r WHERE r.id IN (209, 187, 154);

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'proof', CAST(p.id AS TEXT), p.revision, 'lattice-appendix-part2-2026-11-28',
       json_object('result_id', p.result_id, 'body_tex', p.body_tex, 'status', p.status, 'generated_by', p.generated_by,
                   'generator_detail', p.generator_detail, 'reviewed_by', p.reviewed_by, 'review_notes', p.review_notes,
                   'position', p.position, 'understanding', p.understanding),
       'codex', '2026-11-28 15:30:00'
FROM proofs p WHERE p.id IN (114, 162);

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'setting', key, revision, 'lattice-appendix-part2-2026-11-28', json_object('key', key, 'value', value),
       'codex', '2026-11-28 15:30:00'
FROM settings WHERE key = 'needs_rebuild' AND value <> '1';

UPDATE sections SET
  intro_tex = replace(intro_tex, 'a lattice whose slope replaces $\ln|N|$',
    'a lattice whose \hyperref[KB22]{slope} replaces $\ln|N|$'),
  intro_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-28 15:30:00', updated_by = 'codex'
WHERE id = 117;

UPDATE sections SET
  intro_tex = replace(replace(intro_tex,
    'A Bost-type slope inequality bounds', 'A \hyperref[KC24]{Bost-type slope inequality} bounds'),
    'a chain of $m$ theta lifts between unitary groups', 'a chain of $m$ \hyperref[KF25]{theta lifts} between unitary groups'),
  intro_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-28 15:30:00', updated_by = 'codex'
WHERE id = 107;

UPDATE results SET
  statement_tex = replace(replace(replace(statement_tex,
    'Its slope $\mu(R)\in\R$', 'Its \hyperref[KB22]{slope} $\mu(R)\in\R$'),
    'The period maps take values in the dual $R^\vee$, whose slope is $-\mu(R)$.',
    'The period maps take values in the \hyperref[KA26]{dual} $R^\vee$, whose slope is \hyperref[KB24]{$-\mu(R)$}.'),
    'Its theta kernel gives the map by a weighted sum over lattice classes.',
    'Its theta kernel gives the map by a \hyperref[KF25]{weighted sum over lattice classes}.'),
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-28 15:30:00', updated_by = 'codex'
WHERE id = 209;

UPDATE results SET
  statement_tex = replace(statement_tex,
    'successive theta lifts between spaces of automorphic forms on definite unitary groups',
    'successive \hyperref[KF25]{theta lifts} between spaces of automorphic forms on \hyperref[KD25]{definite unitary groups}'),
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-28 15:30:00', updated_by = 'codex'
WHERE id = 187;

UPDATE results SET
  statement_tex = replace(statement_tex,
    'Here $\mu(R)$ is the slope of the lattice $R$', 'Here $\mu(R)$ is the \hyperref[KD27]{slope} of the lattice $R$'),
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-28 15:30:00', updated_by = 'codex'
WHERE id = 154;

UPDATE proofs SET
  body_tex = replace(replace(body_tex,
    'A seesaw identity compares', 'A \hyperref[KF27]{seesaw identity} compares'),
    'A Bost-type inequality gives an upper bound', 'A \hyperref[KC24]{Bost-type inequality} gives an upper bound'),
  body_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-28 15:30:00', updated_by = 'codex'
WHERE id = 114;

UPDATE proofs SET
  body_tex = body_tex || char(10) || char(10) ||
    'The appendix result \ref{KC28} shows how a lower bound of this kind for a mean slope is proved.',
  body_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-28 15:30:00', updated_by = 'codex'
WHERE id = 162;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'section', CAST(id AS TEXT), revision, 'lattice-appendix-part2-2026-11-28',
       json_object('tag', tag, 'kind', kind, 'title', title, 'intro_tex', intro_tex,
                   'parent_id', parent_id, 'position', position, 'appendix', appendix),
       'codex', '2026-11-28 15:30:00'
FROM sections WHERE tag IN ('BSE5', 'BSE6', 'BSE7') OR id IN (117, 107);

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(r.id AS TEXT), r.revision, 'lattice-appendix-part2-2026-11-28',
       json_object('tag', r.tag, 'type', r.type, 'title', r.title, 'statement_tex', r.statement_tex,
                   'section_id', r.section_id, 'position', r.position, 'listed', r.listed,
                   'aliases', json((SELECT json_group_array(alias) FROM aliases WHERE tag = r.tag)),
                   'understanding', r.understanding),
       'codex', '2026-11-28 15:30:00'
FROM results r JOIN sections s ON s.id = r.section_id
WHERE s.tag IN ('BSE5', 'BSE6', 'BSE7') OR r.tag = 'KC29' OR r.id IN (209, 187, 154);

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'proof', CAST(p.id AS TEXT), p.revision, 'lattice-appendix-part2-2026-11-28',
       json_object('result_id', p.result_id, 'body_tex', p.body_tex, 'status', p.status, 'generated_by', p.generated_by,
                   'generator_detail', p.generator_detail, 'reviewed_by', p.reviewed_by, 'review_notes', p.review_notes,
                   'position', p.position, 'understanding', p.understanding),
       'codex', '2026-11-28 15:30:00'
FROM proofs p JOIN results r ON r.id = p.result_id JOIN sections s ON s.id = r.section_id
WHERE s.tag IN ('BSE5', 'BSE6', 'BSE7') OR p.id IN (114, 162);

UPDATE settings SET value = '1', revision = revision + 1 WHERE key = 'needs_rebuild' AND value <> '1';

-- changes() here is the row count of the immediately preceding UPDATE.
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'setting', key, revision, 'lattice-appendix-part2-2026-11-28', json_object('key', key, 'value', value),
       'codex', '2026-11-28 15:30:00'
FROM settings WHERE key = 'needs_rebuild' AND changes() = 1;

-- Reference targets extracted by src/latex.ts renderTex with the backup macros.
DELETE FROM refs WHERE source_proof_id IS NULL AND source_result_id IN (209, 187, 154);
DELETE FROM refs WHERE source_proof_id IN (114, 162);

WITH statement_refs(source_tag, target_tag) AS (VALUES
  ('8JV2', '8JVE'), ('8JV2', '8JU9'), ('8JV2', 'C4W2'), ('8JV2', 'KD27'),
  ('C4W2', 'C4S2'), ('C4W2', 'KF25'), ('C4W2', 'KD25'), ('C4W2', '8JVK'),
  ('Q7MN', 'C4S2'), ('Q7MN', 'C4W2'), ('Q7MN', '8JVE'), ('Q7MN', 'KF25'), ('Q7MN', 'KB22'), ('Q7MN', 'WJQV'), ('Q7MN', 'KA26'), ('Q7MN', 'KB24'), ('Q7MN', '8JU9'), ('Q7MN', '8JF7'), ('Q7MN', '8JVK'), ('Q7MN', '8JVF'), ('Q7MN', '8JUD'), ('Q7MN', '8JUC'),
  ('KC29', 'Q7MN'), ('KC29', 'KC28'), ('KC29', '8JV2'), ('KC29', 'KC27'), ('KC29', '8JUB'), ('KC29', 'KB24'), ('KC29', 'WJQV'), ('KC29', 'Q7MQ'), ('KC29', 'KD27'), ('KC29', 'KD29'),
  ('KD22', 'KD23'), ('KD22', 'KD24'),
  ('KD23', 'KD22'),
  ('KD25', 'KD22'),
  ('KD27', 'KD22'), ('KD27', 'KD26'), ('KD27', 'KB22'),
  ('KD26', 'KD22'), ('KD26', 'KD25'), ('KD26', 'KD27'), ('KD26', 'KD24'),
  ('KD28', 'KD27'),
  ('KD24', 'KD26'), ('KD24', 'KD27'),
  ('KD29', '8JV2'), ('KD29', 'C4W2'), ('KD29', 'KD27'),
  ('KE26', 'KA22'),
  ('KE23', 'KE22'), ('KE23', 'KE26'), ('KE23', 'KA26'),
  ('KE24', 'KE22'),
  ('KE25', 'KE24'), ('KE25', 'KE26'), ('KE25', 'KE28'),
  ('KE27', 'KA26'), ('KE27', 'KE25'), ('KE27', 'KE24'), ('KE27', 'KE28'),
  ('KE28', 'KE27'), ('KE28', 'KA24'),
  ('KE2A', 'KE24'), ('KE2A', 'KE23'), ('KE2A', 'C4W2'),
  ('KF23', 'KF22'),
  ('KF24', 'KF22'), ('KF24', 'KF23'), ('KF24', 'KF28'),
  ('KF25', 'KF24'), ('KF25', 'KE25'), ('KF25', 'KF28'),
  ('KF27', 'KE25'), ('KF27', 'KF24'), ('KF27', 'KF25'),
  ('KF26', 'KF24'), ('KF26', 'KF25'), ('KF26', 'KF28'),
  ('KF28', 'KE25'), ('KF28', 'KF26'),
  ('KF29', 'C4W2'), ('KF29', 'KD25'), ('KF29', 'KF25'), ('KF29', 'Q7MN'), ('KF29', 'KF27'), ('KF29', '8JUA')
)
INSERT INTO refs (source_result_id, source_proof_id, target_tag)
SELECT r.id, NULL, f.target_tag FROM statement_refs f JOIN results r ON r.tag = f.source_tag;

WITH proof_refs(source_tag, target_tag) AS (VALUES
  ('KD26', 'KE26'),
  ('KD28', 'KD27'), ('KD28', 'KB22'),
  ('KE23', 'KA23'), ('KE23', 'KE26'), ('KE23', 'KA26'),
  ('KE27', 'KE23'), ('KE27', 'KE24'),
  ('KF23', 'KD26'), ('KF23', 'KF22'),
  ('KF27', 'KE25'), ('KF27', 'KF25'), ('KF27', 'KF24'),
  ('KF26', 'KF27')
)
INSERT INTO refs (source_result_id, source_proof_id, target_tag)
SELECT r.id, p.id, f.target_tag FROM proof_refs f
JOIN results r ON r.tag = f.source_tag JOIN proofs p ON p.result_id = r.id AND p.position = 1;

WITH proof_refs(source_proof_id, target_tag) AS (VALUES
  (114, 'KF27'), (114, '8JUB'), (114, 'KC24'), (114, 'C4W2'), (114, '8JUC'), (114, '8JU9'), (114, '8JVF'), (114, 'C4S2'), (114, '8JUG'),
  (162, '8JV2'), (162, 'C4S2'), (162, '8JUA'), (162, '8JUC'), (162, 'KC28')
)
INSERT INTO refs (source_result_id, source_proof_id, target_tag)
SELECT p.result_id, p.id, f.target_tag FROM proof_refs f JOIN proofs p ON p.id = f.source_proof_id;
