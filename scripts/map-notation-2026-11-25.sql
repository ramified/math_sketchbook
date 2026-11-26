-- Clarify mapping notation and quantifiers in Chapters 2 and 3.
-- Apply as a single batch. The first statement guards every edited row.

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM sections WHERE id IS 105 AND tag IS '8JU2' AND kind IS 'chapter' AND parent_id IS NULL AND position IS 2 AND revision IS 2)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id IS 106 AND tag IS '8JU3' AND kind IS 'section' AND parent_id IS 111 AND position IS 1 AND revision IS 5)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id IS 107 AND tag IS '8JU4' AND kind IS 'section' AND parent_id IS 111 AND position IS 2 AND revision IS 6)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id IS 108 AND tag IS '8JU5' AND kind IS 'section' AND parent_id IS 105 AND position IS 4 AND revision IS 2)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id IS 109 AND tag IS '8JU6' AND kind IS 'section' AND parent_id IS 111 AND position IS 3 AND revision IS 2)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id IS 111 AND tag IS '8JV5' AND kind IS 'chapter' AND parent_id IS NULL AND position IS 3 AND revision IS 1)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id IS 112 AND tag IS '8JV6' AND kind IS 'section' AND parent_id IS 105 AND position IS 1 AND revision IS 2)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id IS 113 AND tag IS '8JV7' AND kind IS 'section' AND parent_id IS 105 AND position IS 2 AND revision IS 2)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id IS 114 AND tag IS '8JV8' AND kind IS 'section' AND parent_id IS 105 AND position IS 3 AND revision IS 2)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 127 AND tag IS '8JU8' AND section_id IS 106 AND position IS 3 AND revision IS 3 AND type IS 'lemma' AND listed IS 0 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 128 AND tag IS '8JU9' AND section_id IS 113 AND position IS 4 AND revision IS 5 AND type IS 'definition' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 130 AND tag IS '8JUB' AND section_id IS 107 AND position IS 2 AND revision IS 2 AND type IS 'lemma' AND listed IS 0 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 131 AND tag IS '8JUC' AND section_id IS 107 AND position IS 3 AND revision IS 5 AND type IS 'lemma' AND listed IS 0 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 153 AND tag IS '8JUW' AND section_id IS 108 AND position IS 3 AND revision IS 3 AND type IS 'definition' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 154 AND tag IS '8JV2' AND section_id IS 106 AND position IS 1 AND revision IS 1 AND type IS 'definition' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 157 AND tag IS '8JV9' AND section_id IS 112 AND position IS 1 AND revision IS 1 AND type IS 'lemma' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 158 AND tag IS '8JVA' AND section_id IS 112 AND position IS 2 AND revision IS 3 AND type IS 'lemma' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 159 AND tag IS '8JVB' AND section_id IS 112 AND position IS 3 AND revision IS 2 AND type IS 'example' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 160 AND tag IS '8JVC' AND section_id IS 113 AND position IS 1 AND revision IS 2 AND type IS 'definition' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 161 AND tag IS '8JVD' AND section_id IS 113 AND position IS 5 AND revision IS 2 AND type IS 'lemma' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 162 AND tag IS '8JVE' AND section_id IS 114 AND position IS 2 AND revision IS 3 AND type IS 'definition' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 163 AND tag IS '8JVF' AND section_id IS 114 AND position IS 3 AND revision IS 1 AND type IS 'definition' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 165 AND tag IS '8JVH' AND section_id IS 108 AND position IS 1 AND revision IS 1 AND type IS 'lemma' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 167 AND tag IS '8JVK' AND section_id IS 114 AND position IS 1 AND revision IS 2 AND type IS 'lemma' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 169 AND tag IS '8JVN' AND section_id IS 112 AND position IS 4 AND revision IS 1 AND type IS 'example' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 170 AND tag IS '8JVP' AND section_id IS 113 AND position IS 2 AND revision IS 1 AND type IS 'definition' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 171 AND tag IS '8JVQ' AND section_id IS 113 AND position IS 3 AND revision IS 1 AND type IS 'definition' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM proofs p JOIN results r ON r.id = p.result_id WHERE
    p.id IS 112 AND p.result_id IS 126 AND p.position IS 1 AND p.revision IS 3 AND p.visibility IS 'published' AND p.generated_by IS 'gpt'
    AND r.tag IS '8JU7' AND r.section_id IS 106 AND r.position IS 2)
  OR NOT EXISTS (SELECT 1 FROM proofs p JOIN results r ON r.id = p.result_id WHERE
    p.id IS 114 AND p.result_id IS 129 AND p.position IS 1 AND p.revision IS 3 AND p.visibility IS 'published' AND p.generated_by IS 'gpt'
    AND r.tag IS '8JUA' AND r.section_id IS 107 AND r.position IS 1)
  OR NOT EXISTS (SELECT 1 FROM proofs p JOIN results r ON r.id = p.result_id WHERE
    p.id IS 117 AND p.result_id IS 132 AND p.position IS 1 AND p.revision IS 6 AND p.visibility IS 'published' AND p.generated_by IS 'gpt'
    AND r.tag IS '8JUD' AND r.section_id IS 108 AND r.position IS 4)
  OR NOT EXISTS (SELECT 1 FROM proofs p JOIN results r ON r.id = p.result_id WHERE
    p.id IS 118 AND p.result_id IS 133 AND p.position IS 1 AND p.revision IS 2 AND p.visibility IS 'published' AND p.generated_by IS 'gpt'
    AND r.tag IS '8JUE' AND r.section_id IS 108 AND r.position IS 2)
  OR NOT EXISTS (SELECT 1 FROM proofs p JOIN results r ON r.id = p.result_id WHERE
    p.id IS 132 AND p.result_id IS 157 AND p.position IS 1 AND p.revision IS 1 AND p.visibility IS 'published' AND p.generated_by IS 'gpt'
    AND r.tag IS '8JV9' AND r.section_id IS 112 AND r.position IS 1)
  OR NOT EXISTS (SELECT 1 FROM proofs p JOIN results r ON r.id = p.result_id WHERE
    p.id IS 133 AND p.result_id IS 158 AND p.position IS 1 AND p.revision IS 2 AND p.visibility IS 'published' AND p.generated_by IS 'gpt'
    AND r.tag IS '8JVA' AND r.section_id IS 112 AND r.position IS 2)
  OR NOT EXISTS (SELECT 1 FROM proofs p JOIN results r ON r.id = p.result_id WHERE
    p.id IS 134 AND p.result_id IS 161 AND p.position IS 1 AND p.revision IS 1 AND p.visibility IS 'published' AND p.generated_by IS 'gpt'
    AND r.tag IS '8JVD' AND r.section_id IS 113 AND r.position IS 5)
  OR NOT EXISTS (SELECT 1 FROM settings WHERE key = 'needs_rebuild' AND revision = 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'section' AND entity_key = '105' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'section' AND entity_key = '106' AND revision > 5)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'section' AND entity_key = '107' AND revision > 6)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'section' AND entity_key = '108' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'section' AND entity_key = '109' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'section' AND entity_key = '111' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'section' AND entity_key = '112' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'section' AND entity_key = '113' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'section' AND entity_key = '114' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '127' AND revision > 3)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '128' AND revision > 5)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '130' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '131' AND revision > 5)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '153' AND revision > 3)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '154' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '157' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '158' AND revision > 3)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '159' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '160' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '161' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '162' AND revision > 3)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '163' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '165' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '167' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '169' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '170' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '171' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'proof' AND entity_key = '112' AND revision > 3)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'proof' AND entity_key = '114' AND revision > 3)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'proof' AND entity_key = '117' AND revision > 6)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'proof' AND entity_key = '118' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'proof' AND entity_key = '132' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'proof' AND entity_key = '133' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'proof' AND entity_key = '134' AND revision > 1);

-- Preserve the pre-edit revisions where history has no snapshot.

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'section', CAST(id AS TEXT), revision, 'map-notation-2026-11-25',
  json_object('tag', tag, 'kind', kind, 'title', title, 'intro_tex', intro_tex, 'parent_id', parent_id, 'position', position),
  COALESCE(updated_by, '(before history)'), '2026-11-26 00:30:00'
FROM sections WHERE id IN (105, 106, 107, 108, 109, 111, 112, 113, 114) ORDER BY id;

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'map-notation-2026-11-25',
  json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex, 'section_id', section_id, 'position', position, 'listed', listed, 'aliases', json((SELECT json_group_array(alias) FROM (SELECT alias FROM aliases WHERE aliases.tag = results.tag ORDER BY alias)))),
  COALESCE(updated_by, '(before history)'), '2026-11-26 00:30:00'
FROM results WHERE id IN (127, 128, 130, 131, 153, 154, 157, 158, 159, 160, 161, 162, 163, 165, 167, 169, 170, 171) ORDER BY id;

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'proof', CAST(id AS TEXT), revision, 'map-notation-2026-11-25',
  json_object('result_id', result_id, 'body_tex', body_tex, 'status', status, 'generated_by', generated_by, 'generator_detail', generator_detail, 'reviewed_by', reviewed_by, 'review_notes', review_notes, 'position', position),
  COALESCE(updated_by, '(before history)'), '2026-11-26 00:30:00'
FROM proofs WHERE id IN (112, 114, 117, 118, 132, 133, 134) ORDER BY id;

-- 8JU2 section
UPDATE sections SET
  intro_tex = 'Chapter 1 reduces the problem to an upper bound for the \hyperref[8JG8]{weighted prime sum} $\mathcal G_\psi$. Here we recover that sum from counts of prime powers sorted by residue class. Fix any \hyperref[8JH4]{primitive character} $\psi$ and any real $\eta>0$ as the margin above the square-root exponent. The construction gives intervals $[Y,Y^{3/2}]$ with $Y$ arbitrarily large. For every $x$ in a chosen interval we have the arithmetic bound on the \hyperref[8JVF]{normalized count} $D_\psi(x)$ and the Fourier comparison:
\[
\begin{aligned}
D_\psi(x)&\le Cx^{1/2+\eta},\\
\mathcal G_\psi(x)&\le D_\psi(x)+O_{\psi,\eta}(x^{1/2+\eta}).
\end{aligned}
\]
Together they give $\mathcal G_\psi(x)\le C''x^{1/2+\eta}$. The constants are independent of the interval and of $x$ in it. Chapter 3 (\ref{8JV5}) gives the proof outline for the first inequality.

This chapter proves the second inequality. We learn two finite-group averages, expand the prime-power count in characters, and specify the data supplied by the arithmetic bound. Finally we apply the two averages to the expansion and track the errors. The only analytic estimates the averaging uses are collected in \ref{8JVH}.',
  intro_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 105;

-- 8JU3 section
UPDATE sections SET
  intro_tex = 'The \hyperref[8JVE]{Fourier data} and the lattice estimates must work at each $x$ in the same interval. First choose the two auxiliary primes on a long range. Then use the field-existence and cohomological estimates to find a whole window inside that range and to choose the groups $A,A_0$ of \ref{8JVC} and the shift set $T$ of \ref{8JVE} at each scale. The \hyperref[8JU8]{cohomological bound} is subsequently used in the finite-place divisibility estimate.

In Adriazola''s notation the auxiliary field has group $B=(\Z/2\Z)^2\times A$ as in \ref{8JVP}. The two signs are cut out by the quadratic fields associated with $d$ and $q$, and $A$ comes from the fixed conductor and a cyclotomic tower. The subgroup $A_0$ is the kernel of the target character on $A$. The construction uses the freedom along the tower to choose many shifts without too many collisions in short progressions. The estimates for the coset proportions are stated in \ref{8JU7}. See \cite[Sections 5.7--5.8 and 18.1]{Adriazola} and \cite[Sections 3 and 9--11]{Outline}.',
  intro_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 106;

-- 8JU4 section
UPDATE sections SET
  intro_tex = 'This section uses the scales and weights of \ref{8JVK} and explains the bound in \ref{8JUA} for every shift $u\in A_0$. The count and its main term are defined in \ref{8JU9}, and the centered sum over $t$ and $j$ is defined in \ref{8JVF}.

For a model, if a nonzero integer $K$ is divisible by all primes in a set $P$, then $\sum_{p\in P}\ln p\le\ln|K|$. Here the integer is replaced by lattices built from a chain of $m$ theta lifts between unitary groups. Prime powers in the relevant classes force extra divisibility. A Bost-type slope inequality bounds the same lattice quantities from above. Comparing the bounds gives the estimate on the count. The \hyperref[8JUB]{matrix rank lemma} and \hyperref[8JUC]{main-term identity} give two elementary pieces of this comparison.',
  intro_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 107;

-- 8JU5 section
UPDATE sections SET
  intro_tex = 'We now compare the \hyperref[8JVF]{normalized count} with $\mathcal G_\psi(x)$. The Fourier expansion in \ref{8JVD} puts a copy of $G_\chi$ at each cutoff $a_t/w_{u,j}(\alpha)$, using the scales and weight functions of \ref{8JVK}. We replace the weights near $b$ by $b$ and bound the contribution of the other weights at their much larger cutoffs. The two averages then keep the desired characters with the Chapter 1 weights. We estimate separately the changes in the cutoffs and in the coset proportions.

Some extra characters pass the subgroup average. Their prime sums are small because the arithmetic construction chooses the auxiliary primes $q,d$ for this purpose. \ref{8JVH} records the analytic estimates, and \ref{8JUD} proves the comparison. The final corollary combines it with the arithmetic bound.',
  intro_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 108;

-- 8JU6 section
UPDATE sections SET
  intro_tex = 'The bound in \ref{8JUA} holds for each $u\in A_0$, so it also bounds the average of the centered counts. We divide it by the \hyperref[8JVF]{Chapter 2 normalization} to prove the arithmetic bound. The two largest terms in the error balance when the number of lifts $m$ is near $\sqrt x$. \ref{8JUG} gives the four estimates and \ref{8JUF} combines them.',
  intro_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 109;

-- 8JV5 section
UPDATE sections SET
  intro_tex = 'This chapter outlines the proof of the \hyperref[8JVG]{arithmetic bound} used in Chapter 2. We first arrange that all the arithmetic data exist on one interval, then outline how the theta lifts bound the centered counts separately for each subgroup shift $u\in A_0$, and finally normalize that bound.

The deep inputs come from the Lean development and the chain-record hypotheses in \cite[Sections 6.2 and 18]{Adriazola}. A first reading can take the Chapter 2 theorem as a black box and return here to see where its hypotheses and error sizes come from.',
  intro_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 111;

-- 8JV6 section
UPDATE sections SET
  intro_tex = 'A character of a finite abelian group $A$ is a homomorphism
\[
\xi\colon A\longrightarrow\C^\times,
\]
as in the \hyperref[8JA9]{Dirichlet-character definition}. If $v\in A$ has order $r$, then $\xi(v)^r=1$, so character values have absolute value one. We write group elements additively and character values multiplicatively.

We will use two different averages. The uniform average over a subgroup $A_0$ selects characters that are constant on its cosets. A second average over a chosen set $T$ assigns different weights to the selected characters. The calculation also quantifies what happens when the proportions of $T$ in the cosets are only approximately the desired ones. For the prime-power count in \ref{8JU5}, we use the coset average of \ref{8JVA} with $k=3$. Its targets $c_3$ are the \hyperref[8JG8]{Chapter 1 weights} $a_{\mathbf 1}=1$ and $a_\chi=1/(3o+1)$ for $\chi\ne\mathbf 1$.',
  intro_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 112;

-- 8JV7 section
UPDATE sections SET
  intro_tex = 'The weighted prime-power count in \ref{8JU9} assigns classes to prime powers and attaches weights to those classes. Three definitions supply the groups, the labels, and the local character values.

The \hyperref[8JVC]{residue groups for the averages} give the two averages of \ref{8JV6} their inputs. The modulus $N_1$ lets $A$ record both the residue modulo $2^{e+2}$ up to sign and the value of $\psi$. The groups of residues up to sign form the real cyclotomic tower, so increasing $e$ gives room to choose the shift set $T$ for the coset average in \ref{8JVA}. Requiring $\psi(v)=1$ in $U_1$ makes $\psi$ independent of the representative of a class in $A$. The uniform average in \ref{8JV9} uses $A_0=\ker\psi$. Since the image of $\psi$ has order $o$, the cosets indexed by $A/A_0$ are the $o$ character-value classes for the second average.

The \hyperref[8JVP]{quadratic coordinates} enlarge $A$ to $B$. The map $\pi$ sends a unit modulo $N=N_1qd$ to its class in $A$ and the two quadratic bits. The Chinese remainder theorem lets the bits vary independently of the class in $A$. The bit at $d$ distinguishes the half with $\xi_c=-1$, which gives the extra divisibility in the arithmetic argument. The complementary half $\Phi$ labels the weights. The bit at $q$ distinguishes the positions with weights near the reference value in \ref{8JVK}. For any shift $t\in A$, the map $p_t$ of \ref{8JU9} adds $((1,1),t)$. This translation flips the first quadratic bit and gives a bijection from $B\setminus\Phi$ to $\Phi$. Changing $t$ permutes the assigned weights. The factor $2$ in the count compensates for using half the classes and changes the Fourier factor $1/|B|$ to $1/f$. Among the characters that survive the subgroup average, those using either quadratic bit are the auxiliary twists. Their smoothed prime sums are small at the target cutoff $x$, as in \ref{8JVH}.

The \hyperref[8JVQ]{prime-power classes and primitive characters} give the inputs to the Fourier expansion in \ref{8JVD}. Away from $N$, the class of $p^i$ is a single element, and only odd powers of a prime with $\xi_c(F_p)=-1$ enter the count. The \hyperref[8JVM]{example modulo $840$} computes such a class. At $p\mid N$, the prime power has no unit class modulo $N$. The coset $iF_p+I_p$ uses its residue away from $p$ and shares its mass uniformly across the corresponding classes. The portion outside $\Phi$ enters the count. For each $\xi\in\widehat B$, the value $\xi^*(p^i)$ gives the coset average in the Fourier expansion, including when $p\mid N$.

The count in \ref{8JU9} and the Fourier expansion in \ref{8JVD} allow arbitrary positive weight functions (with $w_\alpha\le a$ in the Fourier expansion), and \ref{8JVK} in §2.3 supplies the particular weight functions $w_{u,j}$ used in the construction.

For any scale $a>0$ and any individual weight value $W>0$, the identity
\[
\left(\frac a{p^i}-W\right)_+
=W\left(\frac{a/W}{p^i}-1\right)_+
\]
gives the \hyperref[8JF7]{Chapter 1 smoothing} at cutoff $a/W$. The proof of \ref{8JVD} derives the main term $M(a,w)$ that is subtracted in the next section.',
  intro_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 113;

-- 8JV8 section
UPDATE sections SET
  intro_tex = 'We now specify the data needed to normalize the counting formula of \ref{8JU9}. The arithmetic construction supplies arbitrarily distant windows $[Y,Y^{3/2}]$. The primes $q,d$ are fixed on a window, while the groups and weights can depend on the point $x$ in it. \ref{8JVK} gives the number $a_t$ for each shift $t\in T$ and the weight functions $w_{u,j}$ for each $u\in A_0$. The index $j=1,\dots,m$ runs over the $m$ steps of the construction, one weight function per step. \ref{8JVE} collects the data, including the coset proportions of $T$.

Fix any point $x$ and any choice of data as in \ref{8JVE} there. For each $t\in T$, $1\le j\le m$, and $u\in A_0$, use \ref{8JU9} to compute the count $S(t,a_t,w_{u,j})$ and subtract its main term $\Re M(a_t,w_{u,j})$. Add these differences over all $t$ and $j$ to get $\Delta_u$. Then average $\Delta_u$ over $u$, giving each $u$ weight $1/|A_0|$.

A term of weight $w$ has cutoff $a_t/w$. This comes from writing $(a_t/p^i-w)_+=w((a_t/w)/p^i-1)_+$, so the summand vanishes for $p^i\ge a_t/w$. In the positions $\Phi_u$ of \ref{8JVK}, $w$ is close to $b=\exp(x^\varepsilon)$, where $\varepsilon>0$ is a small parameter. The number $a_t$ is close to $xb$. Thus $a_t/w$ is near $x$, and we call these the terms at scale $x$. The comparison in \ref{8JUD} replaces their weights by $b$ and uses $|a_t/b-x|\le1$ to return to cutoff $x$.

At every other position, $w\le2b''$ with $b''=xb/X''$ and $X''=\exp(x^{\varepsilon/3})$. Since $a_t\ge (x-1)b$ and $x\ge3$, the cutoff is at least $(x-1)X''/(2x)\ge X''/3$. These cutoffs are much larger than $x$ for large $x$. The decay estimate in \ref{8JVH}(i) bounds their contribution.

The two kinds of shifts have different jobs. Changing $u\in A_0$ moves the positions in $\Phi_u$ along $A_0$. The average over $u$ removes characters that are nontrivial on $A_0$, by \ref{8JV9}. The shift $t\in T$ permutes the weight labels as in \ref{8JU9}. The coset proportions of $T$ give the surviving characters the Chapter 1 weights by \ref{8JVA} with $k=3$. Each $t$ enters the sum once, so the final division accounts for the factor $h=|T|$.

Each $(t,j)$ has $h_2=|T_2|$ positions at scale $x$. After replacement each supplies weight $b$ and has Fourier coefficient $1/f$ at the trivial character, where $f=2n$ and $n=|A|$. There are $hm$ pairs $(t,j)$, and the average over $u$ preserves this coefficient. With $\delta_2=h_2/n$ and $Q=hmb$, the total weight at scale $x$ is
\[
hm\cdot\frac{bh_2}{f}
=(hmb)\frac{h_2}{2n}=\frac{Q\delta_2}{2}.
\]
This is the denominator in the \hyperref[8JVF]{definition of $D_\psi(x)$}. The next section derives the common factor for the surviving characters and then applies the coset weights. After division, the weighted sum $\mathcal G_\psi(x)$ has coefficient one, with the replacements and the coset discrepancy contributing the errors estimated there. Chapter 3 supplies the one-sided bound on $D_\psi(x)$.',
  intro_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 114;

-- 8JU8 result
UPDATE results SET
  statement_tex = 'Let $E$ be an auxiliary field, $S_\ell$ its set of places above the prime $\ell$, and $G_{E,S_\ell}$ the Galois group of the maximal extension of $E$ unramified at finite places outside $S_\ell$. For a positive integer $r$ set
$$
S_{\ell,r}(E)=\ker\left(
 H^1(G_{E,S_\ell},\Q_\ell/\Z_\ell(-r))
 \longrightarrow \prod_{v\mid\ell}H^1(E_v,\Q_\ell/\Z_\ell(-r))
\right).
$$
On the interval supplied by the field-existence input in the proof of \ref{8JU7}, let $s=\lfloor x^{401}\rfloor$ and $b=\exp(x^\varepsilon)$. For every finite set $S$ of primes the groups in the sum are finite and satisfy
$$
\sum_{\ell\in S}(\ln\ell)\sum_{1\le r<s}
 \operatorname{length}_{\Z_\ell} S_{\ell,r}(E)\le\sqrt b.
$$',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 127;

-- 8JU9 result
UPDATE results SET
  statement_tex = 'Use $A$ from \ref{8JVC}, the class group and weight labels of \ref{8JVP}, and the prime-power data of \ref{8JVQ}. Write $v_+=\max(v,0)$ for real $v$. For any $t\in A$, define
\[
p_t\colon B\setminus\Phi \longrightarrow \Phi,
\qquad g\longmapsto g+((1,1),t).
\]
For any function $w$ with positive values, use the notation
\[
\begin{aligned}
w&\colon\Phi\longrightarrow(0,\infty),\\
w_\alpha&=w(\alpha)\qquad(\alpha\in\Phi).
\end{aligned}
\]
For any real $a>0$, define the real-valued count $S$ on triples $(t,a,w)$ and the main term $M$ with values in $\C$ on pairs $(a,w)$ by
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
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 128;

-- 8JUB result
UPDATE results SET
  statement_tex = 'Let $B_i$ be the matrices for the period maps into a common $D$-dimensional Hermitian space. For any positive real normalizing weights $\gamma_i$ indexed by these matrices, put
\begin{align*}
K_{ij}&=\sqrt{\gamma_i\gamma_j}\,B_i^*B_j,\\
P&=\sum_i\gamma_i B_iB_i^*.
\end{align*}
If $P\ne 0$ and $\operatorname{tr}(P^2)\le(1+\eta)(\operatorname{tr}P)^2/D$, then $\operatorname{rank}P\ge D/(1+\eta)$.',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 130;

-- 8JUC result
UPDATE results SET
  statement_tex = 'Use $\Phi,f$ and $\xi_c$ from \ref{8JVP} and the primitive representative $\xi_c^*$ from \ref{8JVQ}. In the normalization of \cite[Section 8]{Outline}, let $v_0$ be the geometric normalization parameter. For the scales $a_t$ of \ref{8JVK}, put
\begin{align*}
A_*&=\sum_{t\in T}a_t,\\
\ell&=\Re\left(\frac{L''(1,\xi_c^*)}{L(1,\xi_c^*)}\right).
\end{align*}
The divisibility main term is
\[
D_{\rm div}=m\sum_t a_t\bigl(\ln a_t-1-\gamma-\ln(\pi/v_0)+\ell\bigr).
\]
At each level $1\le j\le m$, write $w_j\colon\Phi\to(0,\infty)$ for its weight function and $w_{j,\alpha}=w_j(\alpha)$ for $\alpha\in\Phi$. The chain uses $w_j=w_{u,j}$ of \ref{8JVK} for a fixed $u\in A_0$. Let $g_0$ be the common logarithmic index term and $E_{\rm count}$ the error in the counting lower bound. With
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
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 131;

-- 8JUW result
UPDATE results SET
  statement_tex = 'Use the data of \ref{8JVE} and the character notation of \ref{8JVQ}. Identify $A$ with its image under the embedding $A\to B$ of \ref{8JVP}. With $\mathcal C_\psi$ the \hyperref[8JG8]{cyclic family}, put
\[
\begin{aligned}
\mathcal H &= \left\{\xi\in\widehat B \;\middle|\; \xi|_{A_0}=1\right\},\\
\mathcal K &= \left\{\xi\in\mathcal H \;\middle|\; \xi^*\in\mathcal C_\psi\right\}.
\end{aligned}
\]
At each $x$ in the window of \ref{8JVE}, define the nonnegative real sum
\[
\Sigma(x)=\sum_{\xi\in\mathcal H\setminus\mathcal K}
                 |G_{\xi^*}(x)|.
\]',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 153;

-- 8JV2 result
UPDATE results SET
  statement_tex = 'For a chain of $m$ theta lifts at scale $x$ with parameter $\varepsilon>0$ and translates $t\in T$, write $h=|T|$, $n=|A|$, and $b=\exp(x^\varepsilon)$ as in \ref{8JVE}. The number of large weights per level is $h_2=|T_2|$ in that notation. Write $k$ for the rank-error parameter of the chain. Put
$$
B_0=2nmbx^\varepsilon,\qquad N_c=\frac{h_2 k b x^{2\varepsilon}}{n^2}.
$$
For $u_0\in A_0$, let $S$ be the sum of the \hyperref[8JU9]{weighted prime-power counts} over $t\in T$ and the $m$ levels, with the weight functions $w_{u_0,j}$ of \ref{8JVK}. Let $\Gamma$ be the total divisibility gain of the lifts at the inert primes and $I$ the index loss there.

The nonnegative numbers $e_D,e_L$ are error exponents if there is a constant $C>0$, independent of $x$, such that at every scale of the construction and for every $u_0\in A_0$,
$$
S-\Gamma\leqslant C\,hmb\,x^{e_L\varepsilon},
\qquad 0\leqslant I\leqslant C\,hmb\,x^{e_L\varepsilon},
$$
and, for every auxiliary prime $T_u$ of the chain,
$$
\mu(R)+h_u-L\leqslant D_u+C\,h\,a\Lambda_a+C\,m(B_0+N_c)\,x^{e_D\varepsilon}.
$$
Here $\mu(R)$ is the slope of the lattice $R$ of automorphic forms at the top of the chain, $h_u$ bounds the height of the period map at $T_u$, $L$ is the sum of the local terms of the lifts, $D_u$ is the divisibility main term at $T_u$, $a=xb$, and $\Lambda_a=\ln(a\,\mathrm{rd}_E)$ with $\mathrm{rd}_E$ the root discriminant of the auxiliary field $E$.
See \cite[Definition 18.9]{Adriazola}.',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 154;

-- 8JV9 result
UPDATE results SET
  statement_tex = 'Let $A$ be a finite abelian group, $A_0$ any subgroup of $A$, and $\xi\colon A\to\C^\times$ any character of $A$. Then
\[
\frac1{|A_0|}\sum_{u\in A_0}\xi(u)
=\mathbf 1_{\xi|_{A_0}=1}.
\]
Here $\xi|_{A_0}=1$ means that $\xi(u)=1$ for every $u\in A_0$, and $\mathbf 1_P$ is $1$ when $P$ holds and $0$ otherwise.',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 157;

-- 8JVA result
UPDATE results SET
  statement_tex = 'Let $A$ be a finite abelian group, $A_0$ any subgroup of index $o$, and $T$ any nonempty subset of $A$. Fix any real $k\ge0$. Define the target and actual proportions $\lambda,\mu\colon A/A_0\to[0,1]$ by
\begin{align*}
\lambda_C&=\frac{k+\mathbf 1_{C=A_0}}{k \cdot o+1},\\
\mu_C&=\frac{|T\cap C|}{|T|}.
\end{align*}
View each character of $A/A_0$ as a character of $A$ by composing with the quotient map $A\to A/A_0$. With this identification, define
\[
\begin{aligned}
c_k&\colon\widehat{A/A_0}\longrightarrow(0,1],\\
\xi&\longmapsto
\begin{cases}
1,&\xi=\mathbf 1,\\[2pt]
\dfrac1{k \cdot o+1},&\xi\ne\mathbf 1.
\end{cases}
\end{aligned}
\]
If $|\mu_C-\lambda_C|\le r$ for all $C\in A/A_0$ and some real $r\ge0$, then every such $\xi$ satisfies
\[
\left|\frac1{|T|}\sum_{t\in T}\xi(t)-c_k(\xi)\right|\le o \cdot r.
\]',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 158;

-- 8JVB result
UPDATE results SET
  statement_tex = 'Take $A=\Z/30\Z$, $A_0=3\Z/30\Z$ and
\[
T=\{0,3,6,9,\ 1,4,7,\ 2,5,8\}.
\]
The three cosets are the classes modulo $3$. Their proportions in $T$ are $4/10,3/10,3/10$, so \ref{8JVA} applies with $k=3$, $o=3$, and $r=0$. The trivial character has average $1$. Put $\omega=\exp(2\pi i/3)$. The character of $A$ given by
\[
\xi\colon A\longrightarrow\C^\times,\qquad t\longmapsto\omega^t
\]
has average
\[
\frac{4+3\omega+3\omega^2}{10}=\frac1{10},
\]
because $1+\omega+\omega^2=0$. The other nontrivial quotient character has the conjugate average, also $1/10$.',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 159;

-- 8JVC result
UPDATE results SET
  statement_tex = 'Let $\psi$ be any \hyperref[8JH4]{primitive character} of conductor $N_0$ and order $o$. Choose any integer $e\ge0$ and any distinct primes $q,d\equiv3\pmod4$ with $qd$ coprime to $2N_0$. Put
\begin{align*}
N_1 &= \operatorname{lcm}(2^{e+2},N_0),\\
N &= N_1qd.
\end{align*}
Define the subgroup
\[
U_1=\left\{v\in(\Z/N_1\Z)^\times \;\middle|\; v\equiv\pm1\pmod{2^{e+2}},\ \psi(v)=1\right\}.
\]
Put $A=(\Z/N_1\Z)^\times/U_1$ and write $[v]_A$ for the class of a unit $v$ modulo $N_1$. Use the same symbol $\psi$ for the induced character on $A$, defined by reduction modulo $N_0$:
\[
\psi\colon A\longrightarrow\C^\times,\qquad
[v]_A\longmapsto\psi(v\bmod N_0).
\]
Put $A_0=\ker\psi$.',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 160;

-- 8JVD result
UPDATE results SET
  statement_tex = 'Use $B,\Phi,f$ from \ref{8JVP} and the prime-power and character data of \ref{8JVQ}. For any $t,a,w$ as in \ref{8JU9} with $w_\alpha\le a$ for every $\alpha\in\Phi$, write the weights on the counted classes as
\[
w\circ p_t\colon B\setminus\Phi\longrightarrow(0,\infty),
\qquad g\longmapsto w_g=w_{p_t(g)}.
\]
Then
\[
S(t,a,w)-\Re M(a,w)
=\Re\left(\frac1f\sum_{g\notin\Phi}\sum_{\xi\in\widehat B}
\overline{\xi(g)}\, w_g G_{\xi^*}(a/w_g)\right),
\]
where $G_{\xi^*}$ is the \hyperref[8JF7]{smoothed prime sum}.',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 161;

-- 8JVE result
UPDATE results SET
  statement_tex = 'Fix a primitive $\psi$ of order $o$, a real $\varepsilon>0$, and a point $x\ge3$ in a window $[Y,Y^{3/2}]$. Use the residue groups and primes of \ref{8JVC} and the quadratic coordinates of \ref{8JVP}. Take a nonempty $T\subseteq A$. For the proportions $\mu_C,\lambda_C$ of \ref{8JVA} with $k=3$, require
\[
|\mu_C-\lambda_C|\le x^{-1+\varepsilon}\qquad(C\in A/A_0).
\]
Choose $b,X'',b'',\rho_w,m$ and a nonempty $T_2\subseteq A_0$ with the properties in \ref{8JVK}, together with the positive scales $a_t$ for $t\in T$ and the weight functions $w_{u,j}\colon\Phi\to(0,\infty)$ for $u\in A_0$ and $1\le j\le m$ specified there. Put
\begin{align*}
n&=|A|,\quad h=|T|,\quad h_2=|T_2|,\\
\delta_2&=\frac{h_2}{n},\\
Q&=hmb.
\end{align*}
Require $x^{-\varepsilon}\le\delta_2\le1$.',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 162;

-- 8JVF result
UPDATE results SET
  statement_tex = 'At any point $x$ with data as in \ref{8JVE}, use $S$ and $M$ from \ref{8JU9}. The centered sum $\Delta\colon A_0\to\R$ and the real normalized value $D_\psi(x)$ for those data are
\begin{align*}
\Delta_u
 &=\sum_{t\in T}\sum_{j=1}^{m}
 \bigl(S(t,a_t,w_{u,j})-\Re M(a_t,w_{u,j})\bigr)
 &&(u\in A_0),\\
D_\psi(x)
 &=\frac{2}{Q\delta_2}\cdot\frac1{|A_0|}
       \sum_{u\in A_0}\Delta_u .
\end{align*}',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 163;

-- 8JVH result
UPDATE results SET
  statement_tex = 'Fix any primitive $\psi$ and any sufficiently small $\varepsilon>0$. Use the primes $q,d$ and the data of \ref{8JVE} supplied by the arithmetic construction on a window $[Y,Y^{3/2}]$. Use the representative $\xi^*$ from \ref{8JVQ} and the \hyperref[8JF7]{smoothed prime sum} $G_{\xi^*}$. The following estimates hold at every sufficiently large $x$ in the window, with a threshold depending only on $\psi,\varepsilon$.

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
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 165;

-- 8JVK result
UPDATE results SET
  statement_tex = 'Fix a primitive $\psi$ and a sufficiently small $\varepsilon>0$. Use the groups of \ref{8JVC} and \ref{8JVP} and the nonempty set $T\subseteq A$ supplied by the arithmetic construction at each point of a window $[Y,Y^{3/2}]$. For all sufficiently large $x$ in this window, with a threshold depending only on $\psi,\varepsilon$, put
\[
\begin{aligned}
b&=\exp(x^\varepsilon),\\
X''&=\exp(x^{\varepsilon/3})\ge3,\\
b''&=\frac{xb}{X''}.
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
 0<w_{u,j}(\alpha)\le2b'' &\qquad(\alpha\in\Phi\setminus\Phi_u).
\end{aligned}
\]',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 167;

-- 8JVN result
UPDATE results SET
  statement_tex = 'Take $A=\Z/24\Z$, $A_0=4\Z/24\Z$, and $k=1$. The index is $o=4$. Let
\[
T=\{0,4,8,12,16,20,\ 2,6,10,\ 3\}.
\]
In order of residues $0,1,2,3$ modulo $4$, the proportions of \ref{8JVA} are
\[
(\mu_C)_C=\frac1{10}(6,0,3,1),\qquad
(\lambda_C)_C=\frac15(2,1,1,1).
\]
The maximum deviation is $r=\max_C|\mu_C-\lambda_C|=1/5$ and the bound is $o \cdot r=4/5$.

For $j\in\{0,1,2,3\}$, the quotient characters, viewed on $A$, are
\[
\xi_j\colon A\longrightarrow\C^\times,\qquad t\longmapsto i^{jt}.
\]
Write $M_j=|T|^{-1}\sum_{t\in T}\xi_j(t)$. Their averages, targets, and absolute errors are
\[
\begin{array}{c|c|c|c}
j & M_j & c_1(\xi_j) & |M_j-c_1(\xi_j)|\\
\hline
0 & 1 & 1 & 0\\
1 & (3-i)/10 & 1/5 & \sqrt{2}/10\\
2 & 4/5 & 1/5 & 3/5\\
3 & (3+i)/10 & 1/5 & \sqrt{2}/10
\end{array}
\]',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 169;

-- 8JVP result
UPDATE results SET
  statement_tex = 'Use the moduli and group $A$ of \ref{8JVC}. For a unit $v$ modulo $N$, let $e_1(v)$ and $e_2(v)$ in $\Z/2\Z$ be its quadratic bits modulo $d$ and $q$, respectively, recorded as $0$ for a square and $1$ for a nonsquare. Write $[v]_A$ for the class in $A$ of its reduction modulo $N_1$. Put
\begin{align*}
B &= (\Z/2\Z)^2\times A,\\
\pi &\colon(\Z/N\Z)^\times\longrightarrow B,\\
\pi(v) &= ((e_1(v),e_2(v)),[v]_A).
\end{align*}
Define
\begin{align*}
\Phi &= \left\{((0,e_2),v)\in B \;\middle|\; e_2\in\Z/2\Z,\ v\in A\right\},\\
f &= |\Phi|=2|A|=|B|/2.
\end{align*}
The character at $d$ and the embedding of $A$ into $B$ are
\begin{align*}
\xi_c\colon B&\longrightarrow\{1,-1\}, & ((e_1,e_2),v)&\longmapsto(-1)^{e_1},\\
A&\longrightarrow B, & v&\longmapsto((0,0),v).
\end{align*}',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 170;

-- 8JVQ result
UPDATE results SET
  statement_tex = 'Use $N$ from \ref{8JVC} and $B,\pi$ from \ref{8JVP}. For each prime $p$, write $N=p^\nu N^{(p)}$ with $p\nmid N^{(p)}$. Define reduction modulo $N^{(p)}$ by
\[
r_p\colon(\Z/N\Z)^\times\longrightarrow(\Z/N^{(p)}\Z)^\times,
\qquad v\longmapsto v\bmod N^{(p)}.
\]
Let $u_p$ be the unit modulo $N$ congruent to $p$ modulo $N^{(p)}$ and to $1$ modulo $p^\nu$. Put
\begin{align*}
I_p &= \pi(\ker r_p),\\
F_p &= \pi(u_p).
\end{align*}
For each integer $i\ge1$, the class of $p^i$ is the coset $iF_p+I_p$. For $p\nmid N$ one has $I_p=\{0\}$ and $F_p=\pi(p\bmod N)$.

Write $\widehat B$ for the group of characters $B\to\C^\times$, and $\mathcal P_N$ for the set of \hyperref[8JH4]{primitive Dirichlet characters} whose conductors divide $N$. Define
\[
\widehat B\longrightarrow\mathcal P_N,\qquad \xi\longmapsto\xi^*,
\]
where $\xi^*$ is the primitive character \hyperref[8JB2]{inducing} the Dirichlet character $\xi\circ\pi$ modulo $N$.',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 171;

-- 8JU7 proof 112
UPDATE proofs SET
  body_tex = '\emph{(1)} Choose $q$, then $d$, in the prescribed residue classes. Zero-density and mean-square estimates bound the candidates that fail the zero-free or smoothed-sum tests. Taking the union over the finitely many characters at the fixed modulus still leaves admissible primes. The same pair works throughout the range used in the field construction. See \cite[Theorems 5.10 and 5.12]{Adriazola} and \cite[Section 11]{Outline}.

\emph{(2)} The field-existence input gives a window $[W,W^2]$ with control of the \hyperref[8JU8]{weighted sum of cohomological lengths}. The set $T$ is chosen with the coset proportions of \cite[Lemma 5.18 and Proposition 5.20]{Adriazola}. The subset $T_2$ used for the large weights in \ref{8JVK} comes from the separate construction in Proposition 5.17.

\emph{(3)} To account for a fixed factor in the tower parameter, use the cohomological data at $x/\kappa$ for a fixed $\kappa\ge1$. For $Y=\kappa W$ and $W\ge\kappa^3$, both $x$ and $x/\kappa$ stay in $[W,W^2]$ throughout $[Y,Y^{3/2}]$. The spare power in the cohomological cutoff permits this rescaling. See \cite[Section 11]{Outline} and \cite[Proposition 18.4]{Adriazola}. The chain data at these scales use the local and global matching inputs and the exponents of \cite[Hypothesis 18.10]{Adriazola}. We take the initial threshold large enough for the weight estimates of \ref{8JVK} and the analytic estimates of \ref{8JVH}.',
  generated_by = 'gpt',
  body_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 112;

-- 8JUA proof 114
UPDATE proofs SET
  body_tex = '\emph{(1) Compare periods in a common lattice.} A chain of theta lifts passes between totally definite unitary groups. A seesaw identity compares each period with a Bessel period in a common model. Local vector matching and the common test vectors make the integral comparison compatible with the covolume estimate. The \hyperref[8JUB]{matrix rank estimate} controls the dimension lost when combining the period maps.

\emph{(2) Eliminate the common slope.} Divisibility gives a lower bound for the mean quotient slope after subtracting map heights. A Bost-type inequality gives an upper bound for that slope in terms of the common lattice slope. Subtraction eliminates the slopes. Cohomological lengths bound the loss in divisibility, while the covolume, rank and height estimates bound the other losses.

\emph{(3) Identify the centered count.} The logarithms of the weights $w_{u,j}(\alpha)$ from \ref{8JVK} in the divisibility threshold give the average over $\alpha\in\Phi$. The geometric normalizations cancel as in \ref{8JUC}, leaving the sum of the main terms $M(a_t,w_{u,j})$ of \ref{8JU9}. The resulting estimate on the centered count is the one in \cite[Section 12, (12.2)]{Outline}. Compare \cite[Corollary 3.4 and Theorem A(ii)]{Adriazola}, where Section 18.6 obtains the stronger power $x^{3\varepsilon}$ under the chain-record hypotheses. With the fixed exponents here, $x^{3\varepsilon}\le x^{(e_D+e_L+3)\varepsilon}$ for $x\ge1$.',
  generated_by = 'gpt',
  body_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 114;

-- 8JUD proof 117
UPDATE proofs SET
  body_tex = '\emph{(a) Expand the centered count and control the changes of weight.}
Fix any $u\in A_0$, $t\in T$, and integer $1\le j\le m$. In the complex sum of \ref{8JVD} for $(t,a_t,w_{u,j})$, keep the positions whose labels lie in $\Phi_u$ of \ref{8JVK}, replace their weights by $b$, and omit terms at all other positions. This defines $P\colon A_0\times T\to\C$ by taking $P(u,t)$ to be the resulting sum before taking real parts. It is independent of $j$.

At a label $\alpha\in\Phi_u$, write $w=w_{u,j}(\alpha)$. Then \ref{8JUE} bounds the change in $wG_{\xi^*}(a_t/w)$ by $3(x+1)\rho_w$, using $a_t\le(x+1)b$ and $b\le w\le b+\rho_w\le2b\le a_t$. At each other label $\alpha\in\Phi\setminus\Phi_u$, the weight $w=w_{u,j}(\alpha)$ satisfies $w\le2b''$ and
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
For each $z\in T_2$, the class assigning the weight at $((0,1),z+u)$ is $g=((1,0),z+u-t)$, by $p_t$ in \ref{8JU9}. For $t\in T$ put $y_t=a_t/b$. For $\xi\in\widehat B$ put $\sigma_\xi=\xi((1,0),0)\in\{1,-1\}$. Identify $A$ with its embedded copy as in \ref{8JVP}. Then
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
Here $|y_t-x|\le1$ and $x\ge3$. The quotient $B/A_0=(\Z/2\Z)^2\times(A/A_0)$ has $4o$ characters, so this replacement costs at most $4oL_x$ after the division in (b).

\emph{(d) Apply the coset average.}
For $\xi\in\mathcal H$ put $\beta_\xi=h^{-1}\sum_{t\in T}\xi(t)\in\C$. After the replacement in (c), the normalized expression is
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
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 117;

-- 8JUE proof 118
UPDATE proofs SET
  body_tex = 'For $v\in(0,a]$, put $F(v)=vG_\chi(a/v)\in\C$. For real $z\ge1$, put $\Theta(z)=\sum_{n\le z}\Lambda(n)\in[0,\infty)$. We use the Chebyshev bound $0\le\Theta(z)\le3z$ for $z\ge1$ (see \cite[Lemma 4.1]{Adriazola}). The expression for $F$ from \ref{8JF7} is a sum of $\Lambda(n)\chi(n)(a/n-v)_+$ plus the main-term correction. There are finitely many breakpoints $v=a/n$ between $w$ and $w''$. The sum is continuous there, since the term crossing the cutoff is zero at its breakpoint.

For nontrivial $\chi$ the correction is the constant $aL''(1,\chi)/L(1,\chi)$. Off the breakpoints, $F''(v)=-\sum_{n\le a/v}\Lambda(n)\chi(n)$ and $|F''(v)|\le3a/v$. For the trivial character the correction is $-a\ln(a/v)+(1+\gamma)a$, giving $F''(v)=a/v-\Theta(a/v)$. Since $0\le\Theta(a/v)\le3a/v$, its absolute value is at most $2a/v$. In either case, integrate the derivative on each subinterval and use continuity at its endpoints. The bound $3a/v\le3a/\min(w,w'')$ on the whole interval gives the result.',
  generated_by = 'gpt',
  body_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 118;

-- 8JV9 proof 132
UPDATE proofs SET
  body_tex = 'If $\xi|_{A_0}=1$, every summand is $1$. Otherwise choose $v\in A_0$ with $\xi(v)\ne1$. Write $H=\sum_{u\in A_0}\xi(u)$. Translation $u\mapsto u+v$ is a permutation $A_0\to A_0$, so
\[
H=\sum_{u\in A_0}\xi(u+v)=\xi(v)H.
\]
Since $1-\xi(v)\ne0$, we get $H=0$. In particular a character trivial on $A_0$ has the same value at $t$ and $t+u$ whenever $u\in A_0$.',
  generated_by = 'gpt',
  body_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 132;

-- 8JVA proof 133
UPDATE proofs SET
  body_tex = 'The weights $\lambda_C$ are nonnegative and sum to $o \cdot k/(k \cdot o+1)+1/(k \cdot o+1)=1$. For $C\in A/A_0$ write $\xi(C)$ for the common value of $\xi$ on the coset. Grouping terms by coset gives the actual average $\sum_C\mu_C\xi(C)$. The target has a uniform part and an atom at $A_0$:
\[
\sum_C\lambda_C\xi(C)
=\frac{k}{k \cdot o+1}\sum_C\xi(C)+\frac{\xi(A_0)}{k \cdot o+1}.
\]
By \ref{8JV9}, taking the whole quotient $A/A_0$ as the averaging subgroup, the sum on the right is $o$ for the trivial character and $0$ otherwise. The atom has $\xi(A_0)=1$, so the target average is $c_k(\xi)$. Subtract the two averages and use $|\xi(C)|=1$ to bound the absolute difference by $\sum_C|\mu_C-\lambda_C|\le o \cdot r$.',
  generated_by = 'gpt',
  body_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 133;

-- 8JVD proof 134
UPDATE proofs SET
  body_tex = '\emph{(a) The local character value.} Fix $\xi\in\widehat B$. The uniform mean of $\xi$ on $iF_p+I_p$ is $\xi(iF_p)$ if $\xi|_{I_p}=1$ and $0$ otherwise, by \ref{8JV9}. The Chinese remainder theorem identifies the kernel defining $I_p$ with the full local factor $(\Z/p^\nu\Z)^\times$. Thus if $\xi|_{I_p}=1$, the character $\xi\circ\pi$ factors through $(\Z/N^{(p)}\Z)^\times$. Its primitive conductor is prime to $p$, and evaluation at the chosen lift gives $\xi^*(p^i)=\xi(iF_p)$. If $\xi|_{I_p}\ne1$, that factorization is impossible, so the primitive conductor is divisible by $p$ and $\xi^*(p^i)=0$. This proves
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

\emph{(c) Compute the main term.} Write $R_{\xi^*}=G_{\xi^*}+M_{\xi^*}$ as in \ref{8JS3}. Since $p_t$ is the bijection to $\Phi$ described in \ref{8JV7}, the trivial character contributes
\[
\frac1f\sum_{g\notin\Phi} w_g M_{\mathbf1}(a/w_g)
=\frac af\sum_{\alpha\in\Phi}
\bigl(\ln a-\ln w_\alpha-1-\gamma\bigr).
\]
For every nontrivial $\xi$ the term $w_gM_{\xi^*}(a/w_g)$ is the constant $-aL''(1,\xi^*)/L(1,\xi^*)$. Hence its total coefficient is $f^{-1}\sum_{g\notin\Phi}\overline{\xi(g)}$. The summation set is a single coset of $\Phi$, so \ref{8JV9} makes this zero if $\xi|_\Phi\ne1$. The only nontrivial character of $B/\Phi$ is $\xi_c$ and its coefficient is $-1$, giving $+aL''(1,\xi_c^*)/L(1,\xi_c^*)$. These are exactly the terms in $M(a,w)$. Taking real parts proves the identity. There is no residual term at the primes dividing $N$, since (a) already accounts for their local factors.',
  generated_by = 'gpt',
  body_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 00:30:00', updated_by = 'codex'
WHERE id = 134;

-- Rebuild reference edges from the edited statements and proofs.

DELETE FROM refs WHERE source_proof_id IS NULL AND source_result_id IN (127, 128, 130, 131, 153, 154, 157, 158, 159, 160, 161, 162, 163, 165, 167, 169, 170, 171);
DELETE FROM refs WHERE source_proof_id IN (112, 114, 117, 118, 132, 133, 134);

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (127, NULL, '8JU7'),
  (128, NULL, '8JVC'),
  (128, NULL, '8JVP'),
  (128, NULL, '8JVQ'),
  (131, NULL, '8JVP'),
  (131, NULL, '8JVQ'),
  (131, NULL, '8JVK'),
  (131, NULL, '8JU9'),
  (153, NULL, '8JVE'),
  (153, NULL, '8JVQ'),
  (153, NULL, '8JVP'),
  (153, NULL, '8JG8'),
  (154, NULL, '8JVE'),
  (154, NULL, '8JU9'),
  (154, NULL, '8JVK'),
  (159, NULL, '8JVA'),
  (160, NULL, '8JH4'),
  (161, NULL, '8JVP'),
  (161, NULL, '8JVQ'),
  (161, NULL, '8JU9'),
  (161, NULL, '8JF7'),
  (162, NULL, '8JVC'),
  (162, NULL, '8JVP'),
  (162, NULL, '8JVA'),
  (162, NULL, '8JVK'),
  (163, NULL, '8JVE'),
  (163, NULL, '8JU9'),
  (165, NULL, '8JVE'),
  (165, NULL, '8JVQ'),
  (165, NULL, '8JF7'),
  (165, NULL, '8JUW'),
  (167, NULL, '8JVC'),
  (167, NULL, '8JVP'),
  (169, NULL, '8JVA'),
  (170, NULL, '8JVC'),
  (171, NULL, '8JVC'),
  (171, NULL, '8JVP'),
  (171, NULL, '8JH4'),
  (171, NULL, '8JB2'),
  (126, 112, '8JU8'),
  (126, 112, '8JVK'),
  (126, 112, '8JVH'),
  (129, 114, '8JUB'),
  (129, 114, '8JVK'),
  (129, 114, '8JUC'),
  (129, 114, '8JU9'),
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
  (132, 117, '8JS3'),
  (133, 118, '8JF7'),
  (158, 133, '8JV9'),
  (161, 134, '8JV9'),
  (161, 134, '8JS3'),
  (161, 134, '8JV7');

-- Snapshot the edited revisions and mark the book for rebuild.

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'section', CAST(id AS TEXT), revision, 'map-notation-2026-11-25',
  json_object('tag', tag, 'kind', kind, 'title', title, 'intro_tex', intro_tex, 'parent_id', parent_id, 'position', position),
  'codex', '2026-11-26 00:30:00'
FROM sections WHERE id IN (105, 106, 107, 108, 109, 111, 112, 113, 114) ORDER BY id;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'map-notation-2026-11-25',
  json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex, 'section_id', section_id, 'position', position, 'listed', listed, 'aliases', json((SELECT json_group_array(alias) FROM (SELECT alias FROM aliases WHERE aliases.tag = results.tag ORDER BY alias)))),
  'codex', '2026-11-26 00:30:00'
FROM results WHERE id IN (127, 128, 130, 131, 153, 154, 157, 158, 159, 160, 161, 162, 163, 165, 167, 169, 170, 171) ORDER BY id;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'proof', CAST(id AS TEXT), revision, 'map-notation-2026-11-25',
  json_object('result_id', result_id, 'body_tex', body_tex, 'status', status, 'generated_by', generated_by, 'generator_detail', generator_detail, 'reviewed_by', reviewed_by, 'review_notes', review_notes, 'position', position),
  'codex', '2026-11-26 00:30:00'
FROM proofs WHERE id IN (112, 114, 117, 118, 132, 133, 134) ORDER BY id;

UPDATE settings SET value = '1' WHERE key = 'needs_rebuild' AND value <> '1';
