-- Generalize the coset average and add an example with positive error.
-- Apply as a single batch. The guard rejects a stale or repeated application.

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM sections WHERE id IS 112 AND tag IS '8JV6' AND kind IS 'section' AND parent_id IS 105 AND position IS 1 AND revision IS 1)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id IS 114 AND tag IS '8JV8' AND kind IS 'section' AND parent_id IS 105 AND position IS 3 AND revision IS 1)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 126 AND tag IS '8JU7' AND section_id IS 106 AND position IS 2 AND revision IS 3 AND type IS 'lemma' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 132 AND tag IS '8JUD' AND section_id IS 108 AND position IS 4 AND revision IS 3 AND type IS 'lemma' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 157 AND tag IS '8JV9' AND section_id IS 112 AND position IS 1 AND revision IS 1 AND type IS 'lemma' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 158 AND tag IS '8JVA' AND section_id IS 112 AND position IS 2 AND revision IS 2 AND type IS 'lemma' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 159 AND tag IS '8JVB' AND section_id IS 112 AND position IS 3 AND revision IS 1 AND type IS 'example' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 162 AND tag IS '8JVE' AND section_id IS 114 AND position IS 2 AND revision IS 1 AND type IS 'definition' AND listed IS 1 AND visibility IS 'published' AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id IS 117 AND result_id IS 132 AND position IS 1 AND revision IS 4 AND visibility IS 'published')
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id IS 133 AND result_id IS 158 AND position IS 1 AND revision IS 1 AND visibility IS 'published')
  OR (SELECT COUNT(*) FROM results WHERE section_id = 112) <> 3
  OR NOT EXISTS (SELECT 1 FROM settings WHERE key = 'macros' AND revision = 2)
  OR NOT EXISTS (SELECT 1 FROM settings WHERE key = 'needs_rebuild' AND revision = 1 AND value = '1')
  OR (SELECT MAX(id) FROM results) IS NOT 168
  OR (SELECT MAX(id) FROM proofs) IS NOT 138
  OR (SELECT MAX(tag) FROM tags) IS NOT '8JVM'
  OR EXISTS (SELECT 1 FROM aliases WHERE alias = '8JVN')
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'section' AND entity_key IN ('112', '114') AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '126' AND revision > 3)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key = '158' AND revision > 2)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key IN ('159', '162') AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND CAST(entity_key AS INTEGER) >= 169)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'proof' AND entity_key = '117' AND revision > 4)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'proof' AND entity_key = '133' AND revision > 1)
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'proof' AND CAST(entity_key AS INTEGER) >= 139);


-- Capture the baseline versions that history does not already contain.

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'section', CAST(id AS TEXT), revision, 'coset-average-general-2026-11-25',
  json_object('tag', tag, 'kind', kind, 'title', title, 'intro_tex', intro_tex, 'parent_id', parent_id, 'position', position),
  COALESCE(updated_by, '(before history)'), '2026-11-25 22:00:00'
FROM sections WHERE id IN (112, 114) ORDER BY id;

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'coset-average-general-2026-11-25',
  json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex, 'section_id', section_id, 'position', position, 'listed', listed, 'aliases', json((SELECT json_group_array(alias) FROM (SELECT alias FROM aliases WHERE aliases.tag = results.tag ORDER BY alias)))),
  COALESCE(updated_by, '(before history)'), '2026-11-25 22:00:00'
FROM results WHERE id IN (126, 158, 159, 162) ORDER BY id;

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'proof', CAST(id AS TEXT), revision, 'coset-average-general-2026-11-25',
  json_object('result_id', result_id, 'body_tex', body_tex, 'status', status, 'generated_by', generated_by, 'generator_detail', generator_detail, 'reviewed_by', reviewed_by, 'review_notes', review_notes, 'position', position),
  COALESCE(updated_by, '(before history)'), '2026-11-25 22:00:00'
FROM proofs WHERE id IN (117, 133) ORDER BY id;


-- Section introductions explain the specialization used for the prime-power count.

UPDATE sections SET
  intro_tex = 'A character $\xi$ of a finite abelian group $A$ is a homomorphism $A\to\C^\times$, as in the \hyperref[8JA9]{Dirichlet-character definition}. If $v\in A$ has order $r$, then $\xi(v)^r=1$, so character values have absolute value one. We write group elements additively and character values multiplicatively.

We will use two different averages. The uniform average over a subgroup $A_0$ selects characters that are constant on its cosets. A second average over a chosen set $T$ assigns different weights to the selected characters. The calculation also quantifies what happens when the proportions of $T$ in the cosets are only approximately the desired ones. For the prime-power count in \ref{8JU5}, we use the coset average of \ref{8JVA} with $k=3$. Its targets $c_3$ are the \hyperref[8JG8]{Chapter 1 weights} $a_{\mathbf 1}=1$ and $a_\chi=1/(3o+1)$ for $\chi\ne\mathbf 1$.',
  intro_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-25 22:00:00', updated_by = 'codex'
WHERE id = 112;

UPDATE sections SET
  intro_tex = replace(intro_tex,
    'The coset proportions of $T$ give the surviving characters the Chapter 1 weights, as in \ref{8JVA}.',
    'The coset proportions of $T$ give the surviving characters the Chapter 1 weights by \ref{8JVA} with $k=3$.'),
  intro_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-25 22:00:00', updated_by = 'codex'
WHERE id = 114;


-- General lemma and its uses.

UPDATE results SET
  statement_tex = 'Let $A$ be a finite abelian group, $A_0$ a subgroup of index $o$, and $T\subseteq A$ nonempty. Fix a real $k\ge0$. For each coset $C\in A/A_0$, put
\[
\lambda_C=\frac{k+\mathbf 1_{C=A_0}}{k \cdot o+1},
\qquad \mu_C=\frac{|T\cap C|}{|T|}.
\]
For a character $\xi$ of $A$ trivial on $A_0$, define
\[
c_k(\xi)=\begin{cases}
1,&\xi=\mathbf 1,\\[2pt]
\dfrac1{k \cdot o+1},&\xi\ne\mathbf 1.
\end{cases}
\]
If $|\mu_C-\lambda_C|\le r$ for all $C\in A/A_0$ and some real $r\ge0$, then every such $\xi$ satisfies
\[
\left|\frac1{|T|}\sum_{t\in T}\xi(t)-c_k(\xi)\right|\le o \cdot r.
\]',
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-25 22:00:00', updated_by = 'codex'
WHERE id = 158;

UPDATE proofs SET
  body_tex = 'The weights $\lambda_C$ are nonnegative and sum to $o \cdot k/(k \cdot o+1)+1/(k \cdot o+1)=1$. Write $\xi(C)$ for the common value of $\xi$ on $C$. Grouping terms by coset gives the actual average $\sum_C\mu_C\xi(C)$. The target has a uniform part and an atom at $A_0$:
\[
\sum_C\lambda_C\xi(C)
=\frac{k}{k \cdot o+1}\sum_C\xi(C)+\frac{\xi(A_0)}{k \cdot o+1}.
\]
By \ref{8JV9}, taking the whole quotient $A/A_0$ as the averaging subgroup, the sum on the right is $o$ for the trivial character and $0$ otherwise. The atom has $\xi(A_0)=1$, so the target average is $c_k(\xi)$. Subtract the two averages and use $|\xi(C)|=1$ to bound the absolute difference by $\sum_C|\mu_C-\lambda_C|\le o \cdot r$.',
  body_html_cache = NULL, status = 'ai_generated', generated_by = 'gpt', generator_detail = 'Codex',
  reviewed_by = NULL, review_notes = NULL, revision = revision + 1,
  updated_at = '2026-11-25 22:00:00', updated_by = 'codex'
WHERE id = 133;

UPDATE results SET
  statement_tex = replace(statement_tex,
    'so \ref{8JVA} applies with $o=3$ and $r=0$.',
    'so \ref{8JVA} applies with $k=3$, $o=3$, and $r=0$.'),
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-25 22:00:00', updated_by = 'codex'
WHERE id = 159;

UPDATE results SET
  statement_tex = replace(statement_tex,
    'Take a nonempty $T\subseteq A$ with
\[
|\mu_C-\lambda_C|\le x^{-1+\varepsilon}\qquad(C\in A/A_0),
\]
with $\mu_C,\lambda_C$ as in \ref{8JVA}.',
    'Take a nonempty $T\subseteq A$. For the proportions $\mu_C,\lambda_C$ of \ref{8JVA} with $k=3$, require
\[
|\mu_C-\lambda_C|\le x^{-1+\varepsilon}\qquad(C\in A/A_0).
\]'),
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-25 22:00:00', updated_by = 'codex'
WHERE id = 162;

UPDATE results SET
  statement_tex = replace(statement_tex,
    'For each coset $C\in A/A_0$ the proportions of \ref{8JVA} satisfy',
    'For each coset $C\in A/A_0$ the proportions $\mu_C,\lambda_C$ of \ref{8JVA} with $k=3$ satisfy'),
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-25 22:00:00', updated_by = 'codex'
WHERE id = 126;

UPDATE proofs SET
  body_tex = replace(body_tex,
    'For $\xi\in\mathcal K$ the target coefficient is $a_{\xi^*}$ of \ref{8JG8}, and \ref{8JVA} gives $|\beta_\xi-a_{\xi^*}|\le\nu_x=o x^{-1+\varepsilon}$.',
    'For $\xi\in\mathcal K$, the $k=3$ target $c_3(\xi|_A)$ is $a_{\xi^*}$ of \ref{8JG8}. Applying \ref{8JVA} with $k=3$ gives $|\beta_\xi-a_{\xi^*}|\le\nu_x=o x^{-1+\varepsilon}$.'),
  body_html_cache = NULL, status = 'ai_generated', generated_by = 'gpt', generator_detail = 'Codex',
  reviewed_by = NULL, review_notes = NULL, revision = revision + 1,
  updated_at = '2026-11-25 22:00:00', updated_by = 'codex'
WHERE id = 117;


-- A listed example immediately after 8JVB.

INSERT INTO tags (tag, kind, created_at)
VALUES ('8JVN', 'result', '2026-11-25 22:00:00');

INSERT INTO results (id, tag, section_id, position, listed, type, title, statement_tex, statement_html_cache, created_at, updated_at, created_by, updated_by)
VALUES (169, '8JVN', 112, 4, 1, 'example', 'Ten shifts with uneven coset proportions', 'Take $A=\Z/24\Z$, $A_0=4\Z/24\Z$, and $k=1$. The index is $o=4$. Let
\[
T=\{0,4,8,12,16,20,\ 2,6,10,\ 3\}.
\]
In order of residues $0,1,2,3$ modulo $4$, the proportions of \ref{8JVA} are
\[
(\mu_C)_C=\frac1{10}(6,0,3,1),\qquad
(\lambda_C)_C=\frac15(2,1,1,1).
\]
The maximum deviation is $r=\max_C|\mu_C-\lambda_C|=1/5$ and the bound is $o \cdot r=4/5$.

The quotient characters are $\xi_j(t)=i^{jt}$ for $j\in\{0,1,2,3\}$. Write $M_j=|T|^{-1}\sum_{t\in T}\xi_j(t)$. Their averages, targets, and absolute errors are
\[
\begin{array}{c|c|c|c}
j & M_j & c_1(\xi_j) & |M_j-c_1(\xi_j)|\\
\hline
0 & 1 & 1 & 0\\
1 & (3-i)/10 & 1/5 & \sqrt{2}/10\\
2 & 4/5 & 1/5 & 3/5\\
3 & (3+i)/10 & 1/5 & \sqrt{2}/10
\end{array}
\]', NULL, '2026-11-25 22:00:00', '2026-11-25 22:00:00', 'codex', 'codex');

INSERT INTO proofs (id, result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail, created_at, updated_at, created_by, updated_by)
VALUES (139, 169, 1, 'Counting $T$ by residue modulo $4$ and grouping the character values gives
\[
M_j=\frac{6+3i^{2j}+i^{3j}}{10}.
\]
Subtracting the targets gives errors $0$, $(1-i)/10$, $3/5$, and $(1+i)/10$ before taking absolute values. The largest modulus, $3/5$, is three quarters of the bound $4/5$.

The bound can be attained with the same $r$. Replace $3$ in $T$ by $14$. The deviations in residue order are then $(1,-1,1,-1)/5$. They have the same signs as $\xi_2$ on the cosets, giving an absolute error of $4/5$ at $\xi_2$.', NULL, 'ai_generated', 'gpt', 'Codex', '2026-11-25 22:00:00', '2026-11-25 22:00:00', 'codex', 'codex');


-- Rebuild affected statement and proof edges with the application parser.

DELETE FROM refs WHERE source_proof_id IS NULL AND source_result_id IN (126, 158, 159, 162);
DELETE FROM refs WHERE source_proof_id IN (117, 133);

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (126, NULL, '8JV2'),
  (126, NULL, '8JVA'),
  (126, NULL, '8JVC'),
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
  (158, 133, '8JV9'),
  (159, NULL, '8JVA'),
  (162, NULL, '8JVA'),
  (162, NULL, '8JVC'),
  (162, NULL, '8JVK'),
  (169, NULL, '8JVA');


-- Record the new versions and mark the book cache for rebuild.

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'section', CAST(id AS TEXT), revision, 'coset-average-general-2026-11-25',
  json_object('tag', tag, 'kind', kind, 'title', title, 'intro_tex', intro_tex, 'parent_id', parent_id, 'position', position),
  'codex', '2026-11-25 22:00:00'
FROM sections WHERE id IN (112, 114) ORDER BY id;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'coset-average-general-2026-11-25',
  json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex, 'section_id', section_id, 'position', position, 'listed', listed, 'aliases', json((SELECT json_group_array(alias) FROM (SELECT alias FROM aliases WHERE aliases.tag = results.tag ORDER BY alias)))),
  'codex', '2026-11-25 22:00:00'
FROM results WHERE id IN (126, 158, 159, 162, 169) ORDER BY id;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'proof', CAST(id AS TEXT), revision, 'coset-average-general-2026-11-25',
  json_object('result_id', result_id, 'body_tex', body_tex, 'status', status, 'generated_by', generated_by, 'generator_detail', generator_detail, 'reviewed_by', reviewed_by, 'review_notes', review_notes, 'position', position),
  'codex', '2026-11-25 22:00:00'
FROM proofs WHERE id IN (117, 133, 139) ORDER BY id;

UPDATE settings SET value = '1' WHERE key = 'needs_rebuild' AND value <> '1';
