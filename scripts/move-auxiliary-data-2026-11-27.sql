-- Keep Chapter 2 independent of Chapter 3 except for the black-box arithmetic bound.
--   * Move 8JU7 (simultaneous choice of auxiliary data) from 3.1 to the start of 2.3, where 8JVK first uses it.
--     Its statement no longer asserts the Chapter 3 error exponents; 8JUF's proof now cites that input.
--   * 8JVG states the arithmetic bound in Chapter 2 terms (no Chapter 3 thresholds or lemmas).
--   * Section 3.1 (8JU3) and the Chapter 3 intro (8JV5) describe what is left there.
-- Apply as one D1 batch after exporting the database. The guard aborts unless
-- every expected placement and old substring is still present.

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM results WHERE id = 126 AND tag = '8JU7' AND section_id = 106 AND position = 2 AND revision = 6
      AND instr(statement_tex, ' With these choices there are integral theta-lift data with \hyperref[8JV2]{error exponents} $e_D=2$ and $e_L=0$.') > 0)
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id = 112 AND result_id = 126 AND revision = 5
      AND instr(body_tex, 'with control of the \hyperref[8JU8]{weighted sum of cohomological lengths}.') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 127 AND tag = '8JU8' AND section_id = 106 AND position = 3)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 167 AND tag = '8JVK' AND section_id = 114 AND position = 1)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 162 AND tag = '8JVE' AND section_id = 114 AND position = 2)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 163 AND tag = '8JVF' AND section_id = 114 AND position = 3)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 164 AND tag = '8JVG' AND section_id = 114 AND position = 4 AND revision = 2
      AND instr(statement_tex, 'there is a window $[Y,Y^{3/2}]$ and a pair of auxiliary primes $q,d$ as in \ref{8JU7}, with $Y\ge\max(Y_0,x_{\rm arith},x_{\rm aux})$. Here $x_{\rm arith}$ is from \ref{8JUF} and $x_{\rm aux}$ is from \ref{8JVH}. At every real $x$ in the window, the choices from \ref{8JU7}, \ref{8JVK}, and \ref{8JUG} give the data of \ref{8JVE}, satisfying the estimates of \ref{8JVH}, with') > 0)
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id = 119 AND revision = 4
      AND instr(body_tex, 'Apply \ref{8JU7} with starting bound $\max(Y_0,x_{\rm arith})$.') > 0)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id = 106 AND tag = '8JU3' AND revision = 7
      AND title = 'A common interval for the auxiliary data'
      AND instr(intro_tex, 'The \hyperref[8JVE]{Fourier data} and the lattice estimates must work at each $x$ in the same interval. First choose the two auxiliary primes on a long range. Then use the field-existence and cohomological estimates to find a whole window inside that range and to choose the groups $A,A_0$ of \ref{8JVC} and the shift set $T$ of \ref{8JVE} at each scale. The \hyperref[8JU8]{cohomological bound} is subsequently used in the finite-place divisibility estimate.') > 0)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id = 111 AND tag = '8JV5' AND revision = 2
      AND instr(intro_tex, 'We first arrange that all the arithmetic data exist on one interval, then outline') > 0);

-- Move 8JU7 to the front of 2.3 and close the gap in 3.1.
UPDATE results SET position = position + 1 WHERE section_id = 114 AND id IN (167, 162, 163, 164);
UPDATE results SET position = 2 WHERE id = 127;

UPDATE results
SET section_id = 114, position = 1,
  statement_tex = replace(statement_tex,
    ' With these choices there are integral theta-lift data with \hyperref[8JV2]{error exponents} $e_D=2$ and $e_L=0$.', ''),
  statement_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-27 12:00:00',
  updated_by = 'claude'
WHERE id = 126;

UPDATE proofs
SET body_tex = replace(body_tex,
    'with control of the \hyperref[8JU8]{weighted sum of cohomological lengths}.',
    'with control of a weighted sum of cohomological lengths, which the lattice estimates use later.'),
  body_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-27 12:00:00',
  updated_by = 'claude'
WHERE id = 112;

UPDATE results
SET statement_tex = replace(statement_tex,
    'there is a window $[Y,Y^{3/2}]$ and a pair of auxiliary primes $q,d$ as in \ref{8JU7}, with $Y\ge\max(Y_0,x_{\rm arith},x_{\rm aux})$. Here $x_{\rm arith}$ is from \ref{8JUF} and $x_{\rm aux}$ is from \ref{8JVH}. At every real $x$ in the window, the choices from \ref{8JU7}, \ref{8JVK}, and \ref{8JUG} give the data of \ref{8JVE}, satisfying the estimates of \ref{8JVH}, with',
    'there is a window $[Y,Y^{3/2}]$ and a pair of auxiliary primes $q,d$ as in \ref{8JU7}, with $Y\ge\max(Y_0,x_{\rm aux})$ for $x_{\rm aux}$ from \ref{8JVH}, with the following property. At every real $x$ in the window there are data as in \ref{8JVE}, built from the choices of \ref{8JU7} and \ref{8JVK}, satisfying the estimates of \ref{8JVH}, with'),
  statement_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-27 12:00:00',
  updated_by = 'claude'
WHERE id = 164;

UPDATE proofs
SET body_tex = replace(body_tex,
    'Apply \ref{8JU7} with starting bound $\max(Y_0,x_{\rm arith})$.',
    'Apply \ref{8JU7} with starting bound $\max(Y_0,x_{\rm arith})$. On the resulting window, the integral theta-lift data with error exponents $e_D=2$ and $e_L=0$ come from \cite[Hypothesis 18.10]{Adriazola} at the fixed $J$, as in the proof of Theorem A in Section 18.6.'),
  body_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-27 12:00:00',
  updated_by = 'claude'
WHERE id = 119;

UPDATE sections
SET title = 'Error exponents and cohomological lengths',
  intro_tex = replace(intro_tex,
    'The \hyperref[8JVE]{Fourier data} and the lattice estimates must work at each $x$ in the same interval. First choose the two auxiliary primes on a long range. Then use the field-existence and cohomological estimates to find a whole window inside that range and to choose the groups $A,A_0$ of \ref{8JVC} and the shift set $T$ of \ref{8JVE} at each scale. The \hyperref[8JU8]{cohomological bound} is subsequently used in the finite-place divisibility estimate.',
    'In Chapter 2, \ref{8JU7} chooses the window $[Y,Y^{3/2}]$, the auxiliary primes $q,d$, the groups $A,A_0$ of \ref{8JVC}, and the shift set $T$ at each scale. The lattice estimates must work at each $x$ in that window. This section records what they need there: the \hyperref[8JV2]{error exponents} of the theta-lift chain and the \hyperref[8JU8]{cohomological bound}, which is used in the finite-place divisibility estimate.'),
  intro_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-27 12:00:00',
  updated_by = 'claude'
WHERE id = 106;

UPDATE sections
SET intro_tex = replace(intro_tex,
    'We first arrange that all the arithmetic data exist on one interval, then outline',
    'We start from the window and auxiliary data of \ref{8JU7}, record the error exponents and the cohomological bound on it, then outline'),
  intro_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-27 12:00:00',
  updated_by = 'claude'
WHERE id = 111;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'move-auxiliary-data-2026-11-27',
  json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex,
    'section_id', section_id, 'position', position, 'listed', listed,
    'aliases', json((SELECT json_group_array(alias) FROM
      (SELECT alias FROM aliases WHERE aliases.tag = results.tag ORDER BY alias)))),
  'claude', '2026-11-27 12:00:00'
FROM results WHERE id IN (126, 164) ORDER BY id;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'section', CAST(id AS TEXT), revision, 'move-auxiliary-data-2026-11-27',
  json_object('tag', tag, 'kind', kind, 'title', title, 'intro_tex', intro_tex, 'parent_id', parent_id, 'position', position),
  'claude', '2026-11-27 12:00:00'
FROM sections WHERE id IN (106, 111) ORDER BY id;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'proof', CAST(id AS TEXT), revision, 'move-auxiliary-data-2026-11-27',
  json_object('result_id', result_id, 'body_tex', body_tex, 'status', status,
    'generated_by', generated_by, 'generator_detail', generator_detail,
    'reviewed_by', reviewed_by, 'review_notes', review_notes, 'position', position),
  'claude', '2026-11-27 12:00:00'
FROM proofs WHERE id IN (112, 119) ORDER BY id;

UPDATE settings SET value = '1' WHERE key = 'needs_rebuild' AND value <> '1';
