-- Split the Fourier step from the arithmetic bound.
-- Apply as a single batch. The guard is the first statement and rejects stale or repeated application.

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM sections WHERE id IS 103 AND tag IS '7HH9' AND kind IS 'section' AND parent_id IS 100 AND position IS 3 AND revision IS 2)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id IS 105 AND tag IS '8JU2' AND kind IS 'chapter' AND parent_id IS NULL AND position IS 2 AND revision IS 1)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id IS 106 AND tag IS '8JU3' AND kind IS 'section' AND parent_id IS 105 AND position IS 1 AND revision IS 4)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id IS 107 AND tag IS '8JU4' AND kind IS 'section' AND parent_id IS 105 AND position IS 2 AND revision IS 5)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id IS 108 AND tag IS '8JU5' AND kind IS 'section' AND parent_id IS 105 AND position IS 3 AND revision IS 1)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id IS 109 AND tag IS '8JU6' AND kind IS 'section' AND parent_id IS 105 AND position IS 4 AND revision IS 1)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 110 AND tag IS '8JK2' AND section_id IS 103 AND position IS 1 AND revision IS 2 AND type IS 'theorem' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 126 AND tag IS '8JU7' AND section_id IS 106 AND position IS 2 AND revision IS 2 AND type IS 'lemma' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 127 AND tag IS '8JU8' AND section_id IS 106 AND position IS 3 AND revision IS 3 AND type IS 'lemma' AND listed IS 0 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 128 AND tag IS '8JU9' AND section_id IS 107 AND position IS 1 AND revision IS 3 AND type IS 'definition' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 129 AND tag IS '8JUA' AND section_id IS 107 AND position IS 2 AND revision IS 2 AND type IS 'proposition' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 130 AND tag IS '8JUB' AND section_id IS 107 AND position IS 3 AND revision IS 1 AND type IS 'lemma' AND listed IS 0 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 131 AND tag IS '8JUC' AND section_id IS 107 AND position IS 4 AND revision IS 3 AND type IS 'lemma' AND listed IS 0 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 132 AND tag IS '8JUD' AND section_id IS 108 AND position IS 2 AND revision IS 2 AND type IS 'lemma' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 133 AND tag IS '8JUE' AND section_id IS 108 AND position IS 3 AND revision IS 2 AND type IS 'lemma' AND listed IS 0 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 134 AND tag IS '8JUF' AND section_id IS 109 AND position IS 1 AND revision IS 2 AND type IS 'proposition' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 135 AND tag IS '8JUG' AND section_id IS 109 AND position IS 2 AND revision IS 1 AND type IS 'lemma' AND listed IS 0 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 153 AND tag IS '8JUW' AND section_id IS 108 AND position IS 1 AND revision IS 1 AND type IS 'definition' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 154 AND tag IS '8JV2' AND section_id IS 106 AND position IS 1 AND revision IS 1 AND type IS 'definition' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 155 AND tag IS '8JV3' AND section_id IS 102 AND position IS 1 AND revision IS 1 AND type IS 'motivation' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id IS 112 AND result_id IS 126 AND position IS 1 AND revision IS 2 AND visibility IS 'published')
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id IS 113 AND result_id IS 127 AND position IS 1 AND revision IS 1 AND visibility IS 'published')
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id IS 114 AND result_id IS 129 AND position IS 1 AND revision IS 2 AND visibility IS 'published')
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id IS 115 AND result_id IS 130 AND position IS 1 AND revision IS 1 AND visibility IS 'published')
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id IS 116 AND result_id IS 131 AND position IS 1 AND revision IS 2 AND visibility IS 'published')
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id IS 117 AND result_id IS 132 AND position IS 1 AND revision IS 3 AND visibility IS 'published')
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id IS 118 AND result_id IS 133 AND position IS 1 AND revision IS 1 AND visibility IS 'published')
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id IS 119 AND result_id IS 134 AND position IS 1 AND revision IS 2 AND visibility IS 'published')
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id IS 120 AND result_id IS 135 AND position IS 1 AND revision IS 1 AND visibility IS 'published')
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id IS 131 AND result_id IS 110 AND position IS 1 AND revision IS 1 AND visibility IS 'published')
  OR (SELECT COUNT(*) FROM sections WHERE parent_id IS NULL) <> 2
  OR (SELECT COUNT(*) FROM sections WHERE parent_id = 105) <> 4
  OR (SELECT COUNT(*) FROM results WHERE section_id BETWEEN 105 AND 109) <> 12
  OR (SELECT COUNT(*) FROM proofs WHERE result_id IN (110, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 153, 154, 155)) <> 10
  OR NOT EXISTS (SELECT 1 FROM settings WHERE key = 'macros' AND revision = 2)
  OR NOT EXISTS (SELECT 1 FROM settings WHERE key = 'needs_rebuild' AND revision = 1 AND value = '1')
  OR EXISTS (SELECT 1 FROM tags WHERE tag IN ('8JV5', '8JV6', '8JV7', '8JV8', '8JV9', '8JVA', '8JVB', '8JVC', '8JVD', '8JVE', '8JVF', '8JVG', '8JVH', '8JVJ', '8JVK', '8JVM'))
  OR EXISTS (SELECT 1 FROM sections WHERE id >= 111)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'section' AND CAST(entity_key AS INTEGER) >= 111)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'section' AND entity_key = '103' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'section' AND entity_key = '105' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'section' AND entity_key = '106' AND revision > 4)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'section' AND entity_key = '107' AND revision > 5)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'section' AND entity_key = '108' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'section' AND entity_key = '109' AND revision > 1)
  OR EXISTS (SELECT 1 FROM results WHERE id >= 157)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND CAST(entity_key AS INTEGER) >= 157)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '110' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '126' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '127' AND revision > 3)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '128' AND revision > 3)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '129' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '130' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '131' AND revision > 3)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '132' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '133' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '134' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '135' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '153' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '154' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '155' AND revision > 1)
  OR EXISTS (SELECT 1 FROM proofs WHERE id >= 132)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'proof' AND CAST(entity_key AS INTEGER) >= 132)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'proof' AND entity_key = '112' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'proof' AND entity_key = '113' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'proof' AND entity_key = '114' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'proof' AND entity_key = '115' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'proof' AND entity_key = '116' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'proof' AND entity_key = '117' AND revision > 3)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'proof' AND entity_key = '118' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'proof' AND entity_key = '119' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'proof' AND entity_key = '120' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'proof' AND entity_key = '131' AND revision > 1);


-- Capture the baseline versions that history does not already contain.

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'section', CAST(id AS TEXT), revision, 'ch2-fourier-split-2026-11-25',
  json_object('tag', tag, 'kind', kind, 'title', title, 'intro_tex', intro_tex, 'parent_id', parent_id, 'position', position),
  COALESCE(updated_by, '(before history)'), '2026-11-25 20:00:00'
FROM sections WHERE id IN (103, 105, 106, 107, 108, 109) ORDER BY id;

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'ch2-fourier-split-2026-11-25',
  json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex, 'section_id', section_id, 'position', position, 'listed', listed, 'aliases', json((SELECT json_group_array(alias) FROM (SELECT alias FROM aliases WHERE aliases.tag = results.tag ORDER BY alias)))),
  COALESCE(updated_by, '(before history)'), '2026-11-25 20:00:00'
FROM results WHERE id IN (110, 126, 128, 129, 130, 131, 132, 133, 134, 135, 153, 155) ORDER BY id;

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'proof', CAST(id AS TEXT), revision, 'ch2-fourier-split-2026-11-25',
  json_object('result_id', result_id, 'body_tex', body_tex, 'status', status, 'generated_by', generated_by, 'generator_detail', generator_detail, 'reviewed_by', reviewed_by, 'review_notes', review_notes, 'position', position),
  COALESCE(updated_by, '(before history)'), '2026-11-25 20:00:00'
FROM proofs WHERE id IN (131, 112, 114, 119, 118, 117) ORDER BY id;


-- Chapter and section placement.

INSERT INTO tags (tag, kind, created_at) VALUES
  ('8JV5', 'section', '2026-11-25 20:00:00'),
  ('8JV6', 'section', '2026-11-25 20:00:00'),
  ('8JV7', 'section', '2026-11-25 20:00:00'),
  ('8JV8', 'section', '2026-11-25 20:00:00'),
  ('8JV9', 'result', '2026-11-25 20:00:00'),
  ('8JVA', 'result', '2026-11-25 20:00:00'),
  ('8JVB', 'result', '2026-11-25 20:00:00'),
  ('8JVC', 'result', '2026-11-25 20:00:00'),
  ('8JVD', 'result', '2026-11-25 20:00:00'),
  ('8JVE', 'result', '2026-11-25 20:00:00'),
  ('8JVF', 'result', '2026-11-25 20:00:00'),
  ('8JVG', 'result', '2026-11-25 20:00:00'),
  ('8JVH', 'result', '2026-11-25 20:00:00'),
  ('8JVJ', 'result', '2026-11-25 20:00:00'),
  ('8JVK', 'result', '2026-11-25 20:00:00'),
  ('8JVM', 'result', '2026-11-25 20:00:00');

INSERT INTO sections (id, tag, parent_id, kind, position, title, intro_tex, intro_html_cache, created_at, updated_at, updated_by)
VALUES (111, '8JV5', NULL, 'chapter', 3, 'The arithmetic bound', 'This chapter outlines the proof of the \hyperref[8JVG]{arithmetic bound} used in Chapter 2. We first arrange that all the arithmetic data exist on one interval, then outline how the theta lifts bound the centered counts separately for each subgroup shift $u$, and finally normalize that bound.

The deep inputs come from the Lean development and the chain-record hypotheses in \cite[Sections 6.2 and 18]{Adriazola}. A first reading can take the Chapter 2 theorem as a black box and return here to see where its hypotheses and error sizes come from.', NULL, '2026-11-25 20:00:00', '2026-11-25 20:00:00', 'codex');

INSERT INTO sections (id, tag, parent_id, kind, position, title, intro_tex, intro_html_cache, created_at, updated_at, updated_by)
VALUES (112, '8JV6', 105, 'section', 1, 'Two finite-group averages', 'A character $\xi$ of a finite abelian group $A$ is a homomorphism $A\to\C^\times$, as in the \hyperref[8JA9]{Dirichlet-character definition}. If $v\in A$ has order $r$, then $\xi(v)^r=1$, so character values have absolute value one. We write group elements additively and character values multiplicatively.

We will use two different averages. The uniform average over a subgroup $A_0$ selects characters that are constant on its cosets. A second average over a chosen set $T$ assigns different weights to the selected characters. The calculation also quantifies what happens when the proportions of $T$ in the cosets are only approximately the desired ones. These are the two averages used on the prime-power count in \ref{8JU5}.', NULL, '2026-11-25 20:00:00', '2026-11-25 20:00:00', 'codex');

INSERT INTO sections (id, tag, parent_id, kind, position, title, intro_tex, intro_html_cache, created_at, updated_at, updated_by)
VALUES (113, '8JV7', 105, 'section', 2, 'Prime classes and weighted counts', 'We now assign a class to each prime power and attach a weight to its class. The \hyperref[8JVC]{definition of the prime classes} starts with a primitive character $\psi$ of conductor $N_0$ and builds two groups, $A$ and $B$. Here is what each part of the definition does.

The group $A$ records two pieces of information about a unit $v$ modulo $N_1=\operatorname{lcm}(2^{e+2},N_0)$. The first is its residue modulo $2^{e+2}$, with residues that differ by a sign identified. In particular $v\equiv\pm1\pmod{2^{e+2}}$ gives the identity in this part. These residue groups grow with $e$ and are the groups of the real cyclotomic tower. This growth gives the construction room to choose the shifts used in the coset average.

The second piece is the value $\psi(v)$. The subgroup $U_1$ used to form $A$ consists of units for which both pieces are trivial, so $\psi$ has the same value on every representative of a class in $A$. The subgroup $A_0$ consists of classes on which that value is $1$. The image of a character of order $o$ has $o$ elements, so $A_0$ has index $o$ in $A$.

To form $B$, we also record whether the unit is a square modulo each of two auxiliary primes, $d$ first and $q$ second. The Chinese remainder theorem lets these two bits vary independently of the class in $A$. Among the characters that survive the subgroup average, those that use either quadratic sign are the auxiliary twists. The construction chooses $q,d$ so their smoothed prime sums are small at the target cutoff $x$, as in \ref{8JVH}.

The character $\xi_c$ reads the bit modulo $d$ as a sign. Its $-1$ classes are the ones counted, because they give extra divisibility in the arithmetic argument. For a prime away from the modulus, the sign of $p^i$ is the $i$-th power of the sign of $p$. Thus a prime of sign $-1$ contributes its odd powers, and a prime of sign $1$ contributes none. The \hyperref[8JVM]{example modulo $840$} computes these coordinates for one prime.

The $+1$ classes of $\xi_c$ form $\Phi$ and label the weights. In \ref{8JVK} the positions with weights near the reference value all have bit $1$ modulo $q$. For a shift $t\in A$, adding $((1,1),t)$ takes the counted classes bijectively to $\Phi$. Changing $t$ permutes the weight attached to each class. The factor $2$ accounts for using half the classes. Fourier inversion would have denominator $|B|$, and doubling gives $2/|B|=1/|\Phi|$. If $p$ divides the modulus, its mass is shared uniformly over the coset in \ref{8JVC}, with only the part outside $\Phi$ entering the count.

At a scale $a>0$, for a prime power $p^i$ and a weight $w>0$, the identity
\[
\left(\frac a{p^i}-w\right)_+
=w\left(\frac{a/w}{p^i}-1\right)_+
\]
gives the \hyperref[8JF7]{Chapter 1 smoothing} at cutoff $a/w$. Fourier expansion replaces class membership by character values. We derive the main term $M(a,w)$ in the proof of \ref{8JVD}, so the subtraction used in the next section has an explicit meaning.', NULL, '2026-11-25 20:00:00', '2026-11-25 20:00:00', 'codex');

INSERT INTO sections (id, tag, parent_id, kind, position, title, intro_tex, intro_html_cache, created_at, updated_at, updated_by)
VALUES (114, '8JV8', 105, 'section', 3, 'The normalized count and its arithmetic bound', 'We now specify the data needed to normalize the counting formula of \ref{8JU9}. The arithmetic construction supplies arbitrarily distant windows $[Y,Y^{3/2}]$. The primes $q,d$ are fixed on a window, while the groups and weights can depend on the point $x$ in it. \ref{8JVK} gives the number $a_t$ for each shift $t\in T$ and the weight functions $w_{u,j}$ for each $u\in A_0$. The index $j=1,\dots,m$ runs over the $m$ steps of the construction, one weight function per step. \ref{8JVE} collects the data, including the coset proportions of $T$.

Fix a point $x$ and one choice of data there. For each $(t,j)$ and $u$, use \ref{8JU9} to compute the count $S(t,a_t,w_{u,j})$ and subtract its main term $\Re M(a_t,w_{u,j})$. Add these differences over all $t$ and $j$ to get $\Delta_u$. Then average $\Delta_u$ over $u$, giving each $u$ weight $1/|A_0|$.

A term of weight $w$ has cutoff $a_t/w$. This comes from writing $(a_t/p^i-w)_+=w((a_t/w)/p^i-1)_+$, so the summand vanishes for $p^i\ge a_t/w$. In the positions $\Phi_u$ of \ref{8JVK}, $w$ is close to $b=\exp(x^\varepsilon)$, where $\varepsilon>0$ is a small parameter. The number $a_t$ is close to $xb$. Thus $a_t/w$ is near $x$, and we call these the terms at scale $x$. The comparison in \ref{8JUD} replaces their weights by $b$ and uses $|a_t/b-x|\le1$ to return to cutoff $x$.

At every other position, $w\le2b''$ with $b''=xb/X''$ and $X''=\exp(x^{\varepsilon/3})$. Since $a_t\ge (x-1)b$ and $x\ge3$, the cutoff is at least $(x-1)X''/(2x)\ge X''/3$. These cutoffs are much larger than $x$ for large $x$. The decay estimate in \ref{8JVH}(i) bounds their contribution.

The two kinds of shifts have different jobs. Changing $u\in A_0$ moves the positions in $\Phi_u$ along $A_0$. The average over $u$ removes characters that are nontrivial on $A_0$, by \ref{8JV9}. The shift $t\in T$ permutes the weight labels as in \ref{8JU9}. The coset proportions of $T$ give the surviving characters the Chapter 1 weights, as in \ref{8JVA}. Each $t$ enters the sum once, so the final division accounts for the factor $h=|T|$.

Each $(t,j)$ has $h_2=|T_2|$ positions at scale $x$. After replacement each supplies weight $b$ and has Fourier coefficient $1/f$ at the trivial character, where $f=2n$ and $n=|A|$. There are $hm$ pairs $(t,j)$, and the average over $u$ preserves this coefficient. With $\delta_2=h_2/n$ and $Q=hmb$, the total weight at scale $x$ is
\[
hm\cdot\frac{bh_2}{f}
=(hmb)\frac{h_2}{2n}=\frac{Q\delta_2}{2}.
\]
This is the denominator in the \hyperref[8JVF]{definition of $D_\psi(x)$}. The next section derives the common factor for the surviving characters and then applies the coset weights. After division, the weighted sum $\mathcal G_\psi(x)$ has coefficient one, with the replacements and the coset discrepancy contributing the errors estimated there. Chapter 3 supplies the one-sided bound on $D_\psi(x)$.', NULL, '2026-11-25 20:00:00', '2026-11-25 20:00:00', 'codex');

UPDATE sections SET parent_id = NULL, position = 2, title = 'The Fourier step',
  intro_tex = 'Chapter 1 reduces the problem to an upper bound for the \hyperref[8JG8]{weighted prime sum} $\mathcal G_\psi$. Here we recover that sum from counts of prime powers sorted by residue class. Fix a primitive character $\psi$, and let $\eta>0$ be the desired margin above the square-root exponent. The construction gives intervals $[Y,Y^{3/2}]$ with $Y$ arbitrarily large. For every $x$ in a chosen interval we have the arithmetic bound on the \hyperref[8JVF]{normalized count} $D_\psi(x)$ and the Fourier comparison:
\[
\begin{aligned}
D_\psi(x)&\le Cx^{1/2+\eta},\\
\mathcal G_\psi(x)&\le D_\psi(x)+O_{\psi,\eta}(x^{1/2+\eta}).
\end{aligned}
\]
Together they give $\mathcal G_\psi(x)\le C''x^{1/2+\eta}$. The constants are independent of the interval and of $x$ in it. Chapter 3 (\ref{8JV5}) gives the proof outline for the first inequality.

This chapter proves the second inequality. We learn two finite-group averages, expand the prime-power count in characters, and specify the data supplied by the arithmetic bound. Finally we apply the two averages to the expansion and track the errors. The only analytic estimates the averaging uses are collected in \ref{8JVH}.',
  intro_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 20:00:00', updated_by = 'codex'
WHERE id = 105;

UPDATE sections SET
  intro_tex = 'This is the arithmetic input for Chapter~1. The Fourier deduction is in \ref{8JU2}, and the proof outline for its arithmetic input is in \ref{8JV5}. The deduction in \ref{7HM3} uses classical properties of Dirichlet $L$-functions.',
  intro_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 20:00:00', updated_by = 'codex'
WHERE id = 103;

UPDATE sections SET parent_id = 105, position = 4, title = 'Recovering the weighted prime sum',
  intro_tex = 'We now compare the \hyperref[8JVF]{normalized count} with $\mathcal G_\psi(x)$. The Fourier expansion puts a copy of $G_\chi$ at each cutoff $a_t/w_{u,j}(\alpha)$. We replace the weights near $b$ by $b$ and bound the contribution of the other weights at their much larger cutoffs. The two averages then keep the desired characters with the Chapter 1 weights. We estimate separately the changes in the cutoffs and in the coset proportions.

Some extra characters pass the subgroup average. Their prime sums are small because the arithmetic construction chooses the auxiliary primes $q,d$ for this purpose. \ref{8JVH} records the analytic estimates, and \ref{8JUD} proves the comparison. The final corollary combines it with the arithmetic bound.',
  intro_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 20:00:00', updated_by = 'codex'
WHERE id = 108;

UPDATE sections SET parent_id = 111, position = 1, title = 'A common interval for the auxiliary data',
  intro_tex = 'The \hyperref[8JVE]{Fourier data} and the lattice estimates must work at each $x$ in the same interval. First choose the two auxiliary primes on a long range. Then use the field-existence and cohomological estimates to find a whole window inside that range and to choose the groups $A,A_0$ and the set of shifts $T$ at each scale. The \hyperref[8JU8]{cohomological bound} is subsequently used in the finite-place divisibility estimate.

In Adriazola''s notation the auxiliary field has group $B=(\Z/2\Z)^2\times A$. The two signs are cut out by the quadratic fields associated with $d$ and $q$, and $A$ comes from the fixed conductor and a cyclotomic tower. The subgroup $A_0$ is the kernel of the target character on $A$. The construction uses the freedom along the tower to choose many shifts without too many collisions in short progressions. The estimates for the coset proportions are stated in \ref{8JU7}. See \cite[Sections 5.7--5.8 and 18.1]{Adriazola} and \cite[Sections 3 and 9--11]{Outline}.',
  intro_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 20:00:00', updated_by = 'codex'
WHERE id = 106;

UPDATE sections SET parent_id = 111, position = 2, title = 'Bounding the centered count by theta lifts',
  intro_tex = 'This section uses the scales and weights of \ref{8JVK} and explains the bound for each shift $u$ in \ref{8JUA}. The count and its main term are defined in \ref{8JU9}, and the centered sum over $t$ and $j$ is defined in \ref{8JVF}.

For a model, if a nonzero integer $K$ is divisible by all primes in a set $P$, then $\sum_{p\in P}\ln p\le\ln|K|$. Here the integer is replaced by lattices built from a chain of $m$ theta lifts between unitary groups. Prime powers in the relevant classes force extra divisibility. A Bost-type slope inequality bounds the same lattice quantities from above. Comparing the bounds gives the estimate on the count. The \hyperref[8JUB]{matrix rank lemma} and \hyperref[8JUC]{main-term identity} give two elementary pieces of this comparison.',
  intro_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 20:00:00', updated_by = 'codex'
WHERE id = 107;

UPDATE sections SET parent_id = 111, position = 3, title = 'Balancing and normalizing the errors',
  intro_tex = 'The bound in \ref{8JUA} holds for each $u$, so it also bounds the average of the centered counts. We divide it by the \hyperref[8JVF]{Chapter 2 normalization} to prove the arithmetic bound. The two largest terms in the error balance when the number of lifts $m$ is near $\sqrt x$. \ref{8JUG} gives the four estimates and \ref{8JUF} combines them.',
  intro_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 20:00:00', updated_by = 'codex'
WHERE id = 109;


-- Results and proofs. Existing result and proof IDs are retained.

INSERT INTO results (id, tag, section_id, position, listed, type, title, statement_tex, statement_html_cache, created_at, updated_at, created_by, updated_by)
VALUES (157, '8JV9', 112, 1, 1, 'lemma', 'Averaging over a subgroup', 'Let $A_0$ be a subgroup of a finite abelian group $A$, and let $\xi$ be a character of $A$. Then
\[
\frac1{|A_0|}\sum_{u\in A_0}\xi(u)
=\mathbf 1_{\xi|_{A_0}=1}.
\]
Here $\xi|_{A_0}=1$ means that $\xi(u)=1$ for every $u\in A_0$, and $\mathbf 1_P$ is $1$ when $P$ holds and $0$ otherwise.', NULL, '2026-11-25 20:00:00', '2026-11-25 20:00:00', 'codex', 'codex');

INSERT INTO results (id, tag, section_id, position, listed, type, title, statement_tex, statement_html_cache, created_at, updated_at, created_by, updated_by)
VALUES (158, '8JVA', 112, 2, 1, 'lemma', 'Averaging with prescribed coset proportions', 'Let $A$ be a finite abelian group, $A_0$ a subgroup of index $o$, and $T\subseteq A$ nonempty. For a coset $C\in A/A_0$ put
\[
\lambda_C=\frac{3+\mathbf 1_{C=A_0}}{3o+1},
\qquad \mu_C=\frac{|T\cap C|}{|T|}.
\]
If $|\mu_C-\lambda_C|\le r$ for every coset and some real $r\ge0$, then every character $\xi$ of $A$ trivial on $A_0$ satisfies
\[
\left|\frac1{|T|}\sum_{t\in T}\xi(t)-c(\xi)\right|\le o \cdot r,
\]
where $c(\mathbf1)=1$ and $c(\xi)=1/(3o+1)$ for $\xi\ne\mathbf1$. At $\xi=\mathbf1$ the difference is zero.', NULL, '2026-11-25 20:00:00', '2026-11-25 20:00:00', 'codex', 'codex');

INSERT INTO results (id, tag, section_id, position, listed, type, title, statement_tex, statement_html_cache, created_at, updated_at, created_by, updated_by)
VALUES (159, '8JVB', 112, 3, 1, 'example', 'Ten shifts in a group with three cosets', 'Take $A=\Z/30\Z$, $A_0=3\Z/30\Z$ and
\[
T=\{0,3,6,9,\ 1,4,7,\ 2,5,8\}.
\]
The three cosets are the classes modulo $3$. Their proportions in $T$ are $4/10,3/10,3/10$, so \ref{8JVA} applies with $o=3$ and $r=0$. The trivial character has average $1$. For $\omega=\exp(2\pi i/3)$, the character $\xi(t)=\omega^t$ has average
\[
\frac{4+3\omega+3\omega^2}{10}=\frac1{10},
\]
because $1+\omega+\omega^2=0$. The other nontrivial quotient character has the conjugate average, also $1/10$.', NULL, '2026-11-25 20:00:00', '2026-11-25 20:00:00', 'codex', 'codex');

INSERT INTO results (id, tag, section_id, position, listed, type, title, statement_tex, statement_html_cache, created_at, updated_at, created_by, updated_by)
VALUES (160, '8JVC', 113, 1, 1, 'definition', 'The finite group of prime classes', 'Let $\psi$ be a \hyperref[8JH4]{primitive character} of conductor $N_0$ and order $o$. Take an integer $e\ge0$ and distinct primes $q,d\equiv3\pmod4$ with $qd$ coprime to $2N_0$. Put $N_1=\operatorname{lcm}(2^{e+2},N_0)$ and $N=N_1qd$. Let $U_1$ be the subgroup of $(\Z/N_1\Z)^\times$ defined by $v\equiv\pm1\pmod{2^{e+2}}$ and $\psi(v)=1$. Put
\[
A=(\Z/N_1\Z)^\times/U_1,\qquad B=(\Z/2\Z)^2\times A.
\]
View $\psi$ as a character of $A$ via reduction modulo $N_0$, and put $A_0=\ker(\psi:A\to\C^\times)$. Let $\pi:(\Z/N\Z)^\times\to B$ send a unit to its quadratic sign modulo $d$, its sign modulo $q$, and its class in $A$. A sign is recorded as $0$ for a square and $1$ otherwise. Put $\Phi=\{((0,e_2),v): e_2\in\Z/2\Z,\ v\in A\}$, $f=|\Phi|=2|A|=|B|/2$, and $\xi_c((e_1,e_2),v)=(-1)^{e_1}$.

For each prime $p$ write $N=p^\nu N^{(p)}$ with $p\nmid N^{(p)}$. Let $I_p$ be the image under $\pi$ of the kernel of reduction to $(\Z/N^{(p)}\Z)^\times$. Let $F_p$ be the image of a unit modulo $N$ reducing to $p$ modulo $N^{(p)}$ and to $1$ modulo $p^\nu$. Use the coset $iF_p+I_p$ for the class of $p^i$. In particular if $p\nmid N$ then $I_p=\{0\}$ and $F_p=\pi(p\bmod N)$.

Write $\widehat B$ for the group of characters of $B$. For $\xi\in\widehat B$ write $\xi^*$ for the \hyperref[8JB2]{primitive character inducing} the Dirichlet character $\xi\circ\pi$ modulo $N$.', NULL, '2026-11-25 20:00:00', '2026-11-25 20:00:00', 'codex', 'codex');

INSERT INTO results (id, tag, section_id, position, listed, type, title, statement_tex, statement_html_cache, created_at, updated_at, created_by, updated_by)
VALUES (161, '8JVD', 113, 3, 1, 'lemma', 'Exact Fourier expansion of the centered count', 'Use the data of \ref{8JVC}. Let $t,a,w$ be as in \ref{8JU9} with $w_\alpha\le a$ for every $\alpha\in\Phi$. Put $w_g=w_{p_t(g)}$ for $g\notin\Phi$. Then
\[
S(t,a,w)-\Re M(a,w)
=\Re\left(\frac1f\sum_{g\notin\Phi}\sum_{\xi\in\widehat B}
\overline{\xi(g)}\, w_g G_{\xi^*}(a/w_g)\right),
\]
where $G_{\xi^*}$ is the \hyperref[8JF7]{smoothed prime sum}.', NULL, '2026-11-25 20:00:00', '2026-11-25 20:00:00', 'codex', 'codex');

INSERT INTO results (id, tag, section_id, position, listed, type, title, statement_tex, statement_html_cache, created_at, updated_at, created_by, updated_by)
VALUES (168, '8JVM', 113, 4, 0, 'example', 'Prime classes modulo $840$', 'In \ref{8JVC} take $\psi(v)=(v/5)$, the quadratic character modulo $5$, and set $e=1$, $q=3$, and $d=7$. Thus $o=2$, $N_1=40$, and $N=840$.

A unit belongs to $U_1$ when it is $1$ or $7$ modulo $8$ and $1$ or $4$ modulo $5$. The four combinations give $U_1=\{1,9,31,39\}$ modulo $40$. There are $4\cdot4=16$ units modulo $40$, so $|A|=4$. Label a class in $A$ by two bits. The first distinguishes $\{\pm1\}$ (bit $0$) from $\{\pm3\}$ (bit $1$) modulo $8$. The second distinguishes the squares $\{1,4\}$ (bit $0$) from the nonsquares $\{2,3\}$ (bit $1$) modulo $5$. This gives $A\cong(\Z/2\Z)^2$ and $A_0=\{(0,0),(1,0)\}$. Consequently $B=(\Z/2\Z)^2\times A$ has $16$ elements and $\Phi=\{0\}\times(\Z/2\Z)\times A$ has $8$.

Take $p=13$. It is $6$ modulo $7$, a nonsquare since the nonzero squares modulo $7$ are $1,2,4$. It is $1$ modulo $3$, a square. Its residues modulo $8$ and $5$ are $5$ and $3$, giving the two bits $(1,1)$ in $A$. Since $13\nmid840$, we have $I_{13}=\{0\}$ and $F_{13}=((1,0),(1,1))$. Here $\xi_c(F_{13})=-1$, so the odd powers of $13$ enter the count in \ref{8JU9}.', NULL, '2026-11-25 20:00:00', '2026-11-25 20:00:00', 'codex', 'codex');

INSERT INTO results (id, tag, section_id, position, listed, type, title, statement_tex, statement_html_cache, created_at, updated_at, created_by, updated_by)
VALUES (167, '8JVK', 114, 1, 1, 'lemma', 'Scales and weights in the chain', 'Fix a primitive $\psi$ and a sufficiently small $\varepsilon>0$. Use the groups of \ref{8JVC} and the nonempty set $T\subseteq A$ supplied by the arithmetic construction at each point of a window $[Y,Y^{3/2}]$. For all sufficiently large $x$ in this window, with a threshold depending only on $\psi,\varepsilon$, put
\[
b=\exp(x^\varepsilon),\qquad
X''=\exp(x^{\varepsilon/3})\ge3,\qquad b''=\frac{xb}{X''}.
\]
The chain length is an integer $m\ge1$. There is a nonempty subset $T_2\subseteq A_0$ and, for each $t\in T$, a positive scale $a_t$ with $|a_t/b-x|\le1$. For each $u\in A_0$, put
\[
\Phi_u=\{((0,1),z+u):z\in T_2\}\subseteq\Phi .
\]
For every $1\le j\le m$ there is a weight function $w_{u,j}:\Phi\to(0,\infty)$ with
\[
\begin{aligned}
 b\le w_{u,j}(\alpha)\le b+\rho_w &\qquad(\alpha\in\Phi_u),\\
 0<w_{u,j}(\alpha)\le2b'' &\qquad(\alpha\in\Phi\setminus\Phi_u),
\end{aligned}
\]
where $0\le\rho_w\le b$ and $6f(x+1)\rho_w\le b/x$.', NULL, '2026-11-25 20:00:00', '2026-11-25 20:00:00', 'codex', 'codex');

INSERT INTO results (id, tag, section_id, position, listed, type, title, statement_tex, statement_html_cache, created_at, updated_at, created_by, updated_by)
VALUES (162, '8JVE', 114, 2, 1, 'definition', 'Data for the Fourier step', 'Fix a primitive $\psi$ of order $o$, a real $\varepsilon>0$, and a point $x\ge3$ in a window $[Y,Y^{3/2}]$. Use the groups and primes of \ref{8JVC}. Take a nonempty $T\subseteq A$ with
\[
|\mu_C-\lambda_C|\le x^{-1+\varepsilon}\qquad(C\in A/A_0),
\]
with $\mu_C,\lambda_C$ as in \ref{8JVA}. Take the parameters $b,X'',b'',\rho_w,m$, the nonempty set $T_2\subseteq A_0$, and the positive numbers $a_t$ and $w_{u,j}(\alpha)$ with the properties of \ref{8JVK}, indexed by $t\in T$, $u\in A_0$, $1\le j\le m$ and $\alpha\in\Phi$. Put
\[
n=|A|,\quad h=|T|,\quad h_2=|T_2|,
\qquad \delta_2=\frac{h_2}{n},\qquad Q=hmb.
\]
Require $x^{-\varepsilon}\le\delta_2\le1$.', NULL, '2026-11-25 20:00:00', '2026-11-25 20:00:00', 'codex', 'codex');

INSERT INTO results (id, tag, section_id, position, listed, type, title, statement_tex, statement_html_cache, created_at, updated_at, created_by, updated_by)
VALUES (163, '8JVF', 114, 3, 1, 'definition', 'The normalized centered count $D_\psi(x)$', 'For data as in \ref{8JVE}, use $S$ and $M$ from \ref{8JU9} and put
\begin{align*}
\Delta_u
 &=\sum_{t\in T}\sum_{j=1}^{m}
 \bigl(S(t,a_t,w_{u,j})-\Re M(a_t,w_{u,j})\bigr)
 &&(u\in A_0),\\
D_\psi(x)
 &=\frac{2}{Q\delta_2}\cdot\frac1{|A_0|}
       \sum_{u\in A_0}\Delta_u .
\end{align*}', NULL, '2026-11-25 20:00:00', '2026-11-25 20:00:00', 'codex', 'codex');

INSERT INTO results (id, tag, section_id, position, listed, type, title, statement_tex, statement_html_cache, created_at, updated_at, created_by, updated_by)
VALUES (164, '8JVG', 114, 4, 1, 'theorem', 'Arithmetic bound', 'For each primitive $\psi$ there is $0<\varepsilon_0\le1/52$ with the following property. For every $\eta>0$, every $0<\varepsilon<\varepsilon_0$ with $61\varepsilon/8\le\eta$, and every $Y_0\ge3$, there is a window $[Y,Y^{3/2}]$ with $Y\ge Y_0$ and a pair of auxiliary primes $q,d$ fixed on that window. At every real $x$ in the window the construction supplies the data of \ref{8JVE}, satisfying the estimates of \ref{8JVH}, with
\[
D_\psi(x)\le 20x^{1/2+\eta}.
\]', NULL, '2026-11-25 20:00:00', '2026-11-25 20:00:00', 'codex', 'codex');

INSERT INTO results (id, tag, section_id, position, listed, type, title, statement_tex, statement_html_cache, created_at, updated_at, created_by, updated_by)
VALUES (165, '8JVH', 108, 1, 1, 'lemma', 'Analytic estimates for the auxiliary characters', 'Fix a primitive $\psi$ and a sufficiently small $\varepsilon>0$. Use the primes $q,d$ and the data of \ref{8JVE} supplied by the arithmetic construction on a window $[Y,Y^{3/2}]$. The following estimates hold at every sufficiently large $x$ in the window, with a threshold depending only on $\psi,\varepsilon$.

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
\end{enumerate}', NULL, '2026-11-25 20:00:00', '2026-11-25 20:00:00', 'codex', 'codex');

INSERT INTO results (id, tag, section_id, position, listed, type, title, statement_tex, statement_html_cache, created_at, updated_at, created_by, updated_by)
VALUES (166, '8JVJ', 108, 5, 1, 'corollary', 'The Chapter 1 interval estimate', 'Under the arithmetic bound of \ref{8JVG}, the \hyperref[8JG8]{weighted sum} satisfies the \hyperref[8JK2]{arithmetic interval estimate}.', NULL, '2026-11-25 20:00:00', '2026-11-25 20:00:00', 'codex', 'codex');

UPDATE results SET section_id = 103, position = 1, title = 'Arithmetic interval estimate',
  statement_tex = 'For each primitive $\psi$ there is $\varepsilon_0>0$ such that for every $0<\varepsilon<\varepsilon_0$ and every $Y_0\ge1$ some $Y\ge Y_0$ satisfies
\[
\mathcal G_\psi(x)\le x^{1/2+9\varepsilon}
\qquad(Y\le x\le Y^{3/2}),
\]
where $\mathcal G_\psi$ is the \hyperref[8JG8]{weighted sum}. This is (W) of \cite{Outline}. See \ref{8JU2} for the Fourier step.',
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 20:00:00', updated_by = 'codex'
WHERE id = 110;

UPDATE results SET section_id = 106, position = 2, title = 'Simultaneous choice of auxiliary data',
  statement_tex = 'For every primitive $\psi$ there is $0<\varepsilon_0\le1/52$ such that for every $0<\varepsilon<\varepsilon_0$ and every $Y_0\ge3$ the construction gives real $Y\ge Y_0$ and auxiliary primes $q,d$ fixed on $[Y,Y^{3/2}]$. At each real $x$ in that window it gives the groups of \ref{8JVC}, a nonempty set $T\subseteq A$, and integral theta-lift data with \hyperref[8JV2]{error exponents} $e_D=2$ and $e_L=0$. For each coset $C\in A/A_0$ the proportions of \ref{8JVA} satisfy
\[
|\mu_C-\lambda_C|\le x^{-1+\varepsilon}.
\]',
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 20:00:00', updated_by = 'codex'
WHERE id = 126;

UPDATE results SET section_id = 113, position = 2, title = 'The weighted prime-power count',
  statement_tex = 'Use the groups and prime classes of \ref{8JVC}. Write $v_+=\max(v,0)$ for real $v$. For $t\in A$ define $p_t(g)=g+((1,1),t)$ for $g\in B\setminus\Phi$. For $a>0$ and $w:\Phi\to(0,\infty)$ the weighted prime-power count and its main term are
\begin{align*}
S(t,a,w)&=\sum_{p\ {\rm prime},\ i\ge1}\ \sum_{g\notin\Phi}
\frac{2\mathbf 1_{g-iF_p\in I_p}}{|I_p|}\ln p\,
\left(\frac{a}{p^i}-w_{p_t(g)}\right)_+,\\
M(a,w)&=a\left(\ln a-1-\gamma
 +\frac{L''(1,\xi_c^*)}{L(1,\xi_c^*)}
 -\frac1f\sum_{\alpha\in\Phi}\ln w_\alpha\right).
\end{align*}
Here $\gamma$ is Euler''s constant.',
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 20:00:00', updated_by = 'codex'
WHERE id = 128;

UPDATE results SET section_id = 107, position = 1, title = 'A bound for each translate',
  statement_tex = 'Use the \hyperref[8JVE]{Fourier data} and the \hyperref[8JVF]{centered sums} $\Delta_u$ on a window of \ref{8JU7}. Let $a_E$ be the common size parameter in the estimates at each step and let $k$ be the parameter controlling the rank error. Set
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
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 20:00:00', updated_by = 'codex'
WHERE id = 129;

UPDATE results SET position = 2,
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 20:00:00', updated_by = 'codex'
WHERE id = 130;

UPDATE results SET section_id = 107, position = 3, title = 'Matching the main terms',
  statement_tex = 'In the normalization of \cite[Section 8]{Outline}, write $A_*=\sum_t a_t$, $\ell=\Re(L''(1,\xi_c^*)/L(1,\xi_c^*))$ with $\xi_c$ as in \ref{8JVC}, and let $v_0$ be the geometric normalization parameter. The divisibility main term is
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
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 20:00:00', updated_by = 'codex'
WHERE id = 131;

UPDATE results SET section_id = 109, position = 1, title = 'The arithmetic bound from the four errors',
  statement_tex = 'For each primitive $\psi$ there is $0<\varepsilon_0\le1/52$ with the following property. For each $0<\varepsilon<\varepsilon_0$ there is a threshold $x_{\rm arith}\ge3$ depending only on $\psi,\varepsilon$. For every $Y_0\ge3$, there is a window $[Y,Y^{3/2}]$ of \ref{8JU7} with $Y\ge\max(Y_0,x_{\rm arith})$, a pair of auxiliary primes $q,d$ fixed on the window, and error exponents $e_D=2$, $e_L=0$. For every real $x$ in that window the normalized count of \ref{8JVF} satisfies
\[
D_\psi(x)\le 20x^{1/2+61\varepsilon/8}.
\]',
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 20:00:00', updated_by = 'codex'
WHERE id = 134;

UPDATE results SET section_id = 109, position = 2, title = 'Sizes of the four normalized errors',
  statement_tex = 'For the parameters of \ref{8JUA}, with $Q,\delta_2$ as in \ref{8JVE}, one has
\begin{align*}
0\le a_E&\le 2xb, & h&\ge\tfrac12 n x^{-\varepsilon/8},\\
x^{1/2-\varepsilon}\le m&\le x^{1/2+\varepsilon/2},&
xm&\le k\le n^2x^{1/2-\varepsilon},\\
x^{-\varepsilon}\le\delta_2&\le1.
\end{align*}
In particular $\mathcal B/Q\le 10x^{1/2+13\varepsilon/8}$.',
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 20:00:00', updated_by = 'codex'
WHERE id = 135;

UPDATE results SET section_id = 108, position = 3, title = 'The auxiliary-character sum $\Sigma(x)$',
  statement_tex = 'Use the data of \ref{8JVE}. Embed $A$ in $B$ by $v\mapsto ((0,0),v)$ and put
\[
\mathcal H=\{\xi\in\widehat B:\xi|_{A_0}=1\},\qquad
\mathcal K=\{\xi\in\mathcal H:\xi^*\in\mathcal C_\psi\},
\]
where $\mathcal C_\psi$ is the \hyperref[8JG8]{cyclic family}. Define
\[
\Sigma(x)=\sum_{\xi\in\mathcal H\setminus\mathcal K}
                 |G_{\xi^*}(x)|.
\]',
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 20:00:00', updated_by = 'codex'
WHERE id = 153;

UPDATE results SET section_id = 102, position = 1, title = 'From $L''(s,\chi)/L(s,\chi)$ to the smoothed prime sum',
  statement_tex = '\textbf{The von Mangoldt function.} For $\Re s>1$, the Euler factor $L_p(s,\chi)=(1-\chi(p)p^{-s})^{-1}$ of the \hyperref[8JC4]{Dirichlet $L$-function} satisfies
\begin{align*}
-\frac{L_p''(s,\chi)}{L_p(s,\chi)}
  &= \frac{\chi(p)\ln p\;p^{-s}}{1-\chi(p)p^{-s}} \\
  &= \sum_{k\ge1}\chi(p^k)\ln p\;p^{-ks}.
\end{align*}
The \hyperref[8JUR]{von Mangoldt function} assigns weight $\Lambda(p^k)=\ln p$ to every $p^k$. Summing over $p$ gives $-L''(s,\chi)/L(s,\chi)=\sum_{n\ge1}\chi(n)\Lambda(n)n^{-s}$ (\ref{8JUS}). An order-$m$ zero gives a simple pole of residue $-m$, and a principal character gives one of residue $1$ at $s=1$. Thus the coefficients encode the zeros.

\textbf{The Chebyshev function and its Mellin transform.} The \hyperref[8JUT]{generalized Chebyshev function} $\Psi_\chi(x)=\sum_{n\le x}\chi(n)\Lambda(n)$ reduces to Chebyshev''s $\psi(x)$ for $\chi=\mathbf 1$. We write $\Psi_\chi$ for the classical $\psi(x,\chi)$ to reserve $\psi$ for characters. Its \hyperref[8JS2]{Mellin transform} is (\ref{8JUU})
\[ \int_1^\infty \Psi_\chi(x)\,x^{-s-1}\,dx = -\frac1s\,\frac{L''(s,\chi)}{L(s,\chi)} \qquad (\Re s>1). \]
The continuation has poles at the zeros of $L(s,\chi)$, as used in \ref{7HM3}.

\textbf{Why smooth.} $\Psi_\chi$ jumps at prime powers, so its transform is not \hyperref[8JV4]{absolutely integrable} on $\Re s=c>1$: otherwise Mellin inversion would make $\Psi_\chi$ continuous. Integrating once removes the jumps. For $x\ge1$,
\[ R_\chi(x) = \sum_{n\ge1}\chi(n)\Lambda(n)\Bigl(\frac xn-1\Bigr)_+ = x\int_1^x \Psi_\chi(t)\,\frac{dt}{t^2}, \]
since $\int_n^x t^{-2}\,dt=1/n-1/x$ for $n\le x$. For $\Re s>1$, reversing the order of integration gives
\begin{align*}
\int_1^\infty R_\chi(x)\,x^{-s-1}\,dx
  &= \frac{1}{s-1}\int_1^\infty \Psi_\chi(t)\,t^{-s-1}\,dt \\
  &= -\frac{L''(s,\chi)}{L(s,\chi)}\,\frac{1}{s(s-1)}.
\end{align*}
The extra factor $1/(s-1)$ gives $O(|s|^{-2})$ decay on $\Re s=c>1$ and absolute convergence in Mellin inversion. Shifting left gives summable terms $-m\,x^\rho/(\rho(\rho-1))$ from order-$m$ nontrivial zeros $\rho$ (the explicit formula for $\zeta$ is in \ref{8JTA}). The same weight appears in the \hyperref[8JU9]{prime-power count} of Chapter 2.

\textbf{The main term.} For primitive $\chi$, the residue of $-(L''(s,\chi)/L(s,\chi))\frac{x^s}{s(s-1)}$ at $s=1$ gives the main term of \ref{8JS3},
\begin{align*}
M_{\mathbf 1}(x) &= x\ln x-(1+\gamma)x, \\
M_\chi(x) &= -x\,\frac{L''(1,\chi)}{L(1,\chi)} \qquad (\chi\ne\mathbf 1).
\end{align*}
The first formula uses $-\zeta''(s)/\zeta(s)=\frac1{s-1}-\gamma+O(s-1)$. The \hyperref[8JF7]{smoothed prime sum} $G_\chi=R_\chi-M_\chi$ has Mellin transform regular at $s=1$, with poles exactly at the zeros of $L(s,\chi)$ in $\Re s>0$ (\ref{8JN4}).',
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 20:00:00', updated_by = 'codex'
WHERE id = 155;

UPDATE results SET section_id = 108, position = 2, title = 'Changing a weight at fixed scale',
  statement_tex = 'For every primitive character $\chi$ and real $a,w,w''>0$ with $w,w''\le a$,
\[
\left|wG_\chi(a/w)-w''G_\chi(a/w'')\right|
\le\frac{3a}{\min(w,w'')}\,|w-w''|.
\]',
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 20:00:00', updated_by = 'codex'
WHERE id = 133;

UPDATE results SET section_id = 108, position = 4, title = 'The Fourier comparison',
  statement_tex = 'Fix a primitive $\psi$ of order $o$ and take the \hyperref[8JVE]{Fourier data} and the estimates of \ref{8JVH}. For all sufficiently large $x$ in the window,
\[
\mathcal G_\psi(x)
\le D_\psi(x)+\frac{4}{x\delta_2}
        +(3o+4)x^{1/2+\varepsilon},
\]
where $D_\psi$ is defined in \ref{8JVF}. The threshold depends only on $\psi$ and $\varepsilon$.',
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 20:00:00', updated_by = 'codex'
WHERE id = 132;

INSERT INTO proofs (id, result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail, created_at, updated_at, created_by, updated_by)
VALUES (132, 157, 1, 'If $\xi|_{A_0}=1$, every summand is $1$. Otherwise choose $v\in A_0$ with $\xi(v)\ne1$. Write $H=\sum_{u\in A_0}\xi(u)$. The map $u\mapsto u+v$ permutes $A_0$, so
\[
H=\sum_{u\in A_0}\xi(u+v)=\xi(v)H.
\]
Since $1-\xi(v)\ne0$, we get $H=0$. In particular a character trivial on $A_0$ has the same value at $t$ and $t+u$ whenever $u\in A_0$.', NULL, 'ai_generated', 'gpt', 'Codex', '2026-11-25 20:00:00', '2026-11-25 20:00:00', 'codex', 'codex');

INSERT INTO proofs (id, result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail, created_at, updated_at, created_by, updated_by)
VALUES (133, 158, 1, 'Write $\xi(C)$ for the common value of $\xi$ on $C$. Grouping terms by coset gives the actual average $\sum_C\mu_C\xi(C)$. The target average is
\[
\sum_C\lambda_C\xi(C)=\frac{3}{3o+1}\sum_C\xi(C)+\frac1{3o+1}.
\]
By \ref{8JV9} on the entire quotient $A/A_0$, the sum on the right is $o$ at the trivial character and $0$ otherwise. Thus the target average is $c(\xi)$. Subtract the averages and use $|\xi(C)|=1$ to bound the difference by $\sum_C|\mu_C-\lambda_C|\le o \cdot r$. The trivial character has actual average $1$ for every nonempty $T$.', NULL, 'ai_generated', 'gpt', 'Codex', '2026-11-25 20:00:00', '2026-11-25 20:00:00', 'codex', 'codex');

INSERT INTO proofs (id, result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail, created_at, updated_at, created_by, updated_by)
VALUES (134, 161, 1, '\emph{(a) The local character value.} Fix $\xi\in\widehat B$. The uniform mean of $\xi$ on $iF_p+I_p$ is $\xi(iF_p)$ if $\xi|_{I_p}=1$ and $0$ otherwise, by \ref{8JV9}. The Chinese remainder theorem identifies the kernel defining $I_p$ with the full local factor $(\Z/p^\nu\Z)^\times$. Thus if $\xi|_{I_p}=1$, the character $\xi\circ\pi$ factors through $(\Z/N^{(p)}\Z)^\times$. Its primitive conductor is prime to $p$, and evaluation at the chosen lift gives $\xi^*(p^i)=\xi(iF_p)$. If $\xi|_{I_p}\ne1$, that factorization is impossible, so the primitive conductor is divisible by $p$ and $\xi^*(p^i)=0$. This proves
\[
\xi^*(p^i)=\frac1{|I_p|}\sum_{v\in I_p}\xi(iF_p+v)
\]
also at primes dividing $N$. Using the primitive representative is essential for this identity.

\emph{(b) Detect the class.} For any $z\in B$, the sum $\sum_{\xi\in\widehat B}\xi(z)$ is $|B|$ when $z=0$ and zero otherwise. Indeed the finite abelian group decomposition into cyclic groups gives $|B|$ characters and, when $z\ne0$, a character $\lambda$ with $\lambda(z)\ne1$ by projecting to a nonzero cyclic coordinate. Multiplication by $\lambda$ permutes the character group, so the sum must vanish. Apply this identity to $z=iF_p+v-g$ and sum over $v$ to obtain
\[
\frac1f\sum_{\xi\in\widehat B}\overline{\xi(g)}\,\xi^*(p^i)
=\frac{2}{|I_p|}\mathbf 1_{g-iF_p\in I_p}.
\]
For example, at $p=d$ the CRT factor defining $I_p$ varies only the first sign. Each coset at $d^i$ has two elements, one outside $\Phi$, which contributes with coefficient $2/|I_d|=1$. Each sum over prime powers is finite at the given cutoff. Substitution in $S$ gives the right-hand Fourier sum in the statement with $R_{\xi^*}$ in place of $G_{\xi^*}$, before taking real parts.

\emph{(c) Compute the main term.} Write $R_{\xi^*}=G_{\xi^*}+M_{\xi^*}$ as in \ref{8JS3}. The trivial character contributes
\[
\frac1f\sum_{g\notin\Phi} w_g M_{\mathbf1}(a/w_g)
=\frac af\sum_{\alpha\in\Phi}
\bigl(\ln a-\ln w_\alpha-1-\gamma\bigr).
\]
For every nontrivial $\xi$ the term $w_gM_{\xi^*}(a/w_g)$ is the constant $-aL''(1,\xi^*)/L(1,\xi^*)$. Hence its total coefficient is $f^{-1}\sum_{g\notin\Phi}\overline{\xi(g)}$. The summation set is a single coset of $\Phi$, so \ref{8JV9} makes this zero if $\xi|_\Phi\ne1$. The only nontrivial character of $B/\Phi$ is $\xi_c$ and its coefficient is $-1$, giving $+aL''(1,\xi_c^*)/L(1,\xi_c^*)$. These are exactly the terms in $M(a,w)$. Taking real parts proves the identity. There is no residual term at the primes dividing $N$, since (a) already accounts for their local factors.', NULL, 'ai_generated', 'gpt', 'Codex', '2026-11-25 20:00:00', '2026-11-25 20:00:00', 'codex', 'codex');

INSERT INTO proofs (id, result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail, created_at, updated_at, created_by, updated_by)
VALUES (135, 164, 1, 'Take the window of \ref{8JUF} in Chapter 3, raising the requested lower bound for $Y$ to meet the thresholds in \ref{8JVK} and \ref{8JVH}. On this window, \ref{8JU7} supplies the groups, primes and coset proportions. \ref{8JVK} gives the weight properties, and \ref{8JUG} gives the lower bound on $\delta_2$. The bound of \ref{8JUF} applies at every $x$ in the window. Since $x\ge3$ and $61\varepsilon/8\le\eta$, it gives $D_\psi(x)\le20x^{1/2+61\varepsilon/8}\le20x^{1/2+\eta}$.', NULL, 'ai_generated', 'gpt', 'Codex', '2026-11-25 20:00:00', '2026-11-25 20:00:00', 'codex', 'codex');

INSERT INTO proofs (id, result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail, created_at, updated_at, created_by, updated_by)
VALUES (136, 165, 1, 'These are the analytic inputs in \cite[Section 6.3, pp.~43--44]{Adriazola}. For (i), the conductor bounds and the prime number theorem for characters give the large-cutoff estimate there, using the exclusion of real zeros from the prescribed rectangles for the varying quadratic twists. The fixed-conductor real characters are handled by enlarging the threshold. The factor $2f(x+1)$ is absorbed by the exponential for large $x$, as quantified in Proposition 5.16(iv). For (ii), apply Theorems 5.10(ii)--(iii) and 5.12(ii)--(iii) of the same source on the longer range where the pair $q,d$ was chosen. Every index has a quadratic factor from $q$ or $d$, as explained in \ref{8JU5}. See also \cite[Sections 11 and 13]{Outline}.', NULL, 'ai_generated', 'gpt', 'Codex', '2026-11-25 20:00:00', '2026-11-25 20:00:00', 'codex', 'codex');

INSERT INTO proofs (id, result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail, created_at, updated_at, created_by, updated_by)
VALUES (137, 166, 1, 'Fix $\psi$ and $0<\varepsilon<\varepsilon_0$ from \ref{8JVG}, and set $\eta=61\varepsilon/8$. Write $o$ for the order of $\psi$. Let $x_{\rm cmp}$ be the threshold in \ref{8JUD}, $x_{\rm wt}$ the threshold in \ref{8JVK}, and $x_{\rm aux}$ the threshold in \ref{8JVH}. Let $x_{\rm arith}$ be the threshold for the Chapter 3 estimate used in the proof of \ref{8JVG}. For a prescribed $Y_0\ge1$, use \ref{8JVG} with the starting point $Y$ at least
\[
\max\bigl(3,Y_0,x_{\rm cmp},x_{\rm wt},x_{\rm aux},x_{\rm arith},
          (3o+28)^{8/(11\varepsilon)}\bigr).
\]
At every $x$ on that window, the lower bound $\delta_2\ge x^{-\varepsilon}$ in \ref{8JVE} gives
\[
\frac{4}{x\delta_2}\le4x^{\varepsilon-1}\le4x^{1/2+\varepsilon}.
\]
Thus the error in \ref{8JUD} is at most $(3o+8)x^{1/2+\varepsilon}$. Combining \ref{8JVG} and \ref{8JUD} now gives
\begin{align*}
\mathcal G_\psi(x)
&\le 20x^{1/2+61\varepsilon/8}+(3o+8)x^{1/2+\varepsilon}\\
&\le (3o+28)x^{1/2+61\varepsilon/8}.
\end{align*}
The difference $9\varepsilon-61\varepsilon/8$ is $11\varepsilon/8>0$. Our choice of starting point gives $x^{11\varepsilon/8}\ge3o+28$ throughout the window, so the last bound is at most $x^{1/2+9\varepsilon}$. More generally, choosing $61\varepsilon/8\le\eta$ gives the upper bound $O_{\psi,\eta}(x^{1/2+\eta})$ on arbitrarily distant windows.', NULL, 'ai_generated', 'gpt', 'Codex', '2026-11-25 20:00:00', '2026-11-25 20:00:00', 'codex', 'codex');

INSERT INTO proofs (id, result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail, created_at, updated_at, created_by, updated_by)
VALUES (138, 167, 1, 'For the construction see Chapter 3, \ref{8JU7}. The scales $a_t$ come from \cite[Definition 18.5]{Adriazola}. The set $T_2$ in $A_0$ is the image of the set constructed in Proposition 5.17 under multiplication by a generator of $A_0$. The chain has $m$ lifts, and $\Phi_u$ is the set of positions called thick in Proposition 18.7 and Corollary 18.8. Those results and Proposition 5.16 give the weight bounds. In the source the width is $\rho_w=W+mh_0$, where $W$ is the number of roots of unity in the auxiliary field and $h_0=2\lceil x^{402}\rceil$. Proposition 5.16 gives the stated inequality for this width and the bound $2b''$ at the other positions.', NULL, 'ai_generated', 'gpt', 'Codex', '2026-11-25 20:00:00', '2026-11-25 20:00:00', 'codex', 'codex');

UPDATE proofs SET body_tex = 'The corollary in \ref{8JVJ} obtains this estimate from the arithmetic bound of \ref{8JVG} and the Fourier comparison of \ref{8JUD}.',
  body_html_cache = NULL, status = 'ai_generated', generated_by = 'gpt', generator_detail = 'Codex',
  reviewed_by = NULL, review_notes = NULL, revision = revision + 1,
  updated_at = '2026-11-25 20:00:00', updated_by = 'codex'
WHERE id = 131;

UPDATE proofs SET body_tex = '\emph{(1)} Choose $q$, then $d$, in the prescribed residue classes. Zero-density and mean-square estimates bound the candidates that fail the zero-free or smoothed-sum tests. Taking the union over the finitely many characters at the fixed modulus still leaves admissible primes. The same pair works throughout the range used in the field construction. See \cite[Theorems 5.10 and 5.12]{Adriazola} and \cite[Section 11]{Outline}.

\emph{(2)} The field-existence input gives a window $[W,W^2]$ with control of the \hyperref[8JU8]{weighted sum of cohomological lengths}. The set $T$ is chosen with the coset proportions of \cite[Lemma 5.18 and Proposition 5.20]{Adriazola}. The related subset used for the large weights is constructed separately in Proposition 5.17.

\emph{(3)} To account for a fixed factor in the tower parameter, use the cohomological data at $x/\kappa$ for a fixed $\kappa\ge1$. For $Y=\kappa W$ and $W\ge\kappa^3$, both $x$ and $x/\kappa$ stay in $[W,W^2]$ throughout $[Y,Y^{3/2}]$. The spare power in the cohomological cutoff permits this rescaling. See \cite[Section 11]{Outline} and \cite[Proposition 18.4]{Adriazola}. The chain data at these scales use the local and global matching inputs and the exponents of \cite[Hypothesis 18.10]{Adriazola}. We take the initial threshold large enough for the weight and analytic estimates used in Chapter 2.',
  body_html_cache = NULL, status = 'ai_generated', generated_by = 'gpt', generator_detail = 'Codex',
  reviewed_by = NULL, review_notes = NULL, revision = revision + 1,
  updated_at = '2026-11-25 20:00:00', updated_by = 'codex'
WHERE id = 112;

UPDATE proofs SET body_tex = '\emph{(1) Compare periods in a common lattice.} A chain of theta lifts passes between totally definite unitary groups. A seesaw identity compares each period with a Bessel period in a common model. Local vector matching and the common test vectors make the integral comparison compatible with the covolume estimate. The \hyperref[8JUB]{matrix rank estimate} controls the dimension lost when combining the period maps.

\emph{(2) Eliminate the common slope.} Divisibility gives a lower bound for the mean quotient slope after subtracting map heights. A Bost-type inequality gives an upper bound for that slope in terms of the common lattice slope. Subtraction eliminates the slopes. Cohomological lengths bound the loss in divisibility, while the covolume, rank and height estimates bound the other losses.

\emph{(3) Identify the centered count.} The logarithms of the weights in the divisibility threshold give the average of $\ln w_\alpha$. The geometric normalizations cancel as in \ref{8JUC}, leaving the sum of the main terms $M(a_t,w_{u,j})$. The resulting estimate on the centered count is the one in \cite[Section 12, (12.2)]{Outline}. Compare \cite[Corollary 3.4 and Theorem A(ii)]{Adriazola}, where Section 18.6 obtains the stronger power $x^{3\varepsilon}$ under the chain-record hypotheses. With the fixed exponents here, $x^{3\varepsilon}\le x^{(e_D+e_L+3)\varepsilon}$ for $x\ge1$.',
  body_html_cache = NULL, status = 'ai_generated', generated_by = 'gpt', generator_detail = 'Codex',
  reviewed_by = NULL, review_notes = NULL, revision = revision + 1,
  updated_at = '2026-11-25 20:00:00', updated_by = 'codex'
WHERE id = 114;

UPDATE proofs SET body_tex = 'Choose $x_{\rm arith}$ large enough for the per-shift bound of \ref{8JUA} and the estimates of \ref{8JUG}. Apply \ref{8JU7} with starting bound $\max(Y_0,x_{\rm arith})$. At every $x$ in the resulting window, using $\mathcal B$ and $E_{\rm err}$ of \ref{8JUA}, we have
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
  body_html_cache = NULL, status = 'ai_generated', generated_by = 'gpt', generator_detail = 'Codex',
  reviewed_by = NULL, review_notes = NULL, revision = revision + 1,
  updated_at = '2026-11-25 20:00:00', updated_by = 'codex'
WHERE id = 119;

UPDATE proofs SET body_tex = 'Write $F(v)=vG_\chi(a/v)$ for $0<v\le a$ and $\Theta(z)=\sum_{n\le z}\Lambda(n)$. We use the Chebyshev bound $0\le\Theta(z)\le3z$ for $z\ge1$ (see \cite[Lemma 4.1]{Adriazola}). The expression for $F$ from \ref{8JF7} is a sum of $\Lambda(n)\chi(n)(a/n-v)_+$ plus the main-term correction. There are finitely many breakpoints $v=a/n$ between $w$ and $w''$. The sum is continuous there, since the term crossing the cutoff is zero at its breakpoint.

For nontrivial $\chi$ the correction is the constant $aL''(1,\chi)/L(1,\chi)$. Off the breakpoints, $F''(v)=-\sum_{n\le a/v}\Lambda(n)\chi(n)$ and $|F''(v)|\le3a/v$. For the trivial character the correction is $-a\ln(a/v)+(1+\gamma)a$, giving $F''(v)=a/v-\Theta(a/v)$. Since $0\le\Theta(a/v)\le3a/v$, its absolute value is at most $2a/v$. In either case, integrate the derivative on each subinterval and use continuity at its endpoints. The bound $3a/v\le3a/\min(w,w'')$ on the whole interval gives the result.',
  body_html_cache = NULL, status = 'ai_generated', generated_by = 'gpt', generator_detail = 'Codex',
  reviewed_by = NULL, review_notes = NULL, revision = revision + 1,
  updated_at = '2026-11-25 20:00:00', updated_by = 'codex'
WHERE id = 118;

UPDATE proofs SET body_tex = '\emph{(a) Expand the centered count and control the changes of weight.}
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
By the product coordinates in \ref{8JVC}, the characters in $\mathcal H$ are the $o$ powers of $\psi$ on $A/A_0$ with each of the four pairs of quadratic signs on the other two factors. The $o$ choices with both signs trivial give $\mathcal K$ and have $\sigma_\xi=1$. The remaining $3o$ have a quadratic factor at $q$ or $d$: the Chinese remainder factors at those primes are independent of $A$, and a nontrivial factor forces that prime into the primitive conductor. This also shows why no extra character induces a member of $\mathcal C_\psi$.

For $\xi\in\mathcal K$ the target coefficient is $a_{\xi^*}$ of \ref{8JG8}, and \ref{8JVA} gives $|\beta_\xi-a_{\xi^*}|\le\nu_x=o x^{-1+\varepsilon}$. For every other $\xi$, $|\sigma_\xi\beta_\xi|\le1$. Combining (a)--(d) now gives
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
  body_html_cache = NULL, status = 'ai_generated', generated_by = 'gpt', generator_detail = 'Codex',
  reviewed_by = NULL, review_notes = NULL, revision = revision + 1,
  updated_at = '2026-11-25 20:00:00', updated_by = 'codex'
WHERE id = 117;


-- Rebuild affected statement and proof edges with the application parser.

DELETE FROM refs WHERE source_proof_id IS NULL AND source_result_id IN (110, 126, 128, 129, 131, 134, 135, 153, 155, 133, 132);

DELETE FROM refs WHERE source_proof_id IN (131, 112, 114, 119, 118, 117);

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (110, NULL, '8JG8'),
  (110, NULL, '8JU2'),
  (110, 131, '8JUD'),
  (110, 131, '8JVG'),
  (110, 131, '8JVJ'),
  (126, NULL, '8JV2'),
  (126, NULL, '8JVA'),
  (126, NULL, '8JVC'),
  (126, 112, '8JU8'),
  (128, NULL, '8JVC'),
  (129, NULL, '8JU7'),
  (129, NULL, '8JV2'),
  (129, NULL, '8JVE'),
  (129, NULL, '8JVF'),
  (129, 114, '8JUB'),
  (129, 114, '8JUC'),
  (131, NULL, '8JU9'),
  (131, NULL, '8JVC'),
  (132, NULL, '8JVE'),
  (132, NULL, '8JVF'),
  (132, NULL, '8JVH'),
  (132, 117, '8JG8'),
  (132, 117, '8JS3'),
  (132, 117, '8JUE'),
  (132, 117, '8JUW'),
  (132, 117, '8JV9'),
  (132, 117, '8JVA'),
  (132, 117, '8JVC'),
  (132, 117, '8JVD'),
  (132, 117, '8JVH'),
  (132, 117, '8JVK'),
  (133, 118, '8JF7'),
  (134, NULL, '8JU7'),
  (134, NULL, '8JVF'),
  (134, 119, '8JU7'),
  (134, 119, '8JUA'),
  (134, 119, '8JUG'),
  (135, NULL, '8JUA'),
  (135, NULL, '8JVE'),
  (153, NULL, '8JG8'),
  (153, NULL, '8JVE'),
  (155, NULL, '7HM3'),
  (155, NULL, '8JC4'),
  (155, NULL, '8JF7'),
  (155, NULL, '8JN4'),
  (155, NULL, '8JS2'),
  (155, NULL, '8JS3'),
  (155, NULL, '8JTA'),
  (155, NULL, '8JU9'),
  (155, NULL, '8JUR'),
  (155, NULL, '8JUS'),
  (155, NULL, '8JUT'),
  (155, NULL, '8JUU'),
  (155, NULL, '8JV4'),
  (158, 133, '8JV9'),
  (159, NULL, '8JVA'),
  (160, NULL, '8JB2'),
  (160, NULL, '8JH4'),
  (161, NULL, '8JF7'),
  (161, NULL, '8JU9'),
  (161, NULL, '8JVC'),
  (161, 134, '8JS3'),
  (161, 134, '8JV9'),
  (162, NULL, '8JVA'),
  (162, NULL, '8JVC'),
  (162, NULL, '8JVK'),
  (163, NULL, '8JU9'),
  (163, NULL, '8JVE'),
  (164, NULL, '8JVE'),
  (164, NULL, '8JVH'),
  (164, 135, '8JU7'),
  (164, 135, '8JUF'),
  (164, 135, '8JUG'),
  (164, 135, '8JVH'),
  (164, 135, '8JVK'),
  (165, NULL, '8JUW'),
  (165, NULL, '8JVE'),
  (165, 136, '8JU5'),
  (166, NULL, '8JG8'),
  (166, NULL, '8JK2'),
  (166, NULL, '8JVG'),
  (166, 137, '8JUD'),
  (166, 137, '8JVE'),
  (166, 137, '8JVG'),
  (166, 137, '8JVH'),
  (166, 137, '8JVK'),
  (167, NULL, '8JVC'),
  (167, 138, '8JU7'),
  (168, NULL, '8JU9'),
  (168, NULL, '8JVC');


-- Record the new versions and mark the book cache for rebuild.

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'section', CAST(id AS TEXT), revision, 'ch2-fourier-split-2026-11-25',
  json_object('tag', tag, 'kind', kind, 'title', title, 'intro_tex', intro_tex, 'parent_id', parent_id, 'position', position),
  'codex', '2026-11-25 20:00:00'
FROM sections WHERE id IN (103, 105, 106, 107, 108, 109, 111, 112, 113, 114) ORDER BY id;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'ch2-fourier-split-2026-11-25',
  json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex, 'section_id', section_id, 'position', position, 'listed', listed, 'aliases', json((SELECT json_group_array(alias) FROM (SELECT alias FROM aliases WHERE aliases.tag = results.tag ORDER BY alias)))),
  'codex', '2026-11-25 20:00:00'
FROM results WHERE id IN (110, 126, 128, 129, 130, 131, 132, 133, 134, 135, 153, 155, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168) ORDER BY id;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'proof', CAST(id AS TEXT), revision, 'ch2-fourier-split-2026-11-25',
  json_object('result_id', result_id, 'body_tex', body_tex, 'status', status, 'generated_by', generated_by, 'generator_detail', generator_detail, 'reviewed_by', reviewed_by, 'review_notes', review_notes, 'position', position),
  'codex', '2026-11-25 20:00:00'
FROM proofs WHERE id IN (131, 112, 114, 119, 118, 117, 132, 133, 134, 135, 136, 137, 138) ORDER BY id;

UPDATE settings SET value = '1' WHERE key = 'needs_rebuild' AND value <> '1';
