-- Coset-average lemma (8JVA) and example (8JVN):
--   * write the products of o with r and k as o\cdot r, k\cdot o, o\cdot k
--     (plain "or", "ko" read like one symbol);
--   * keep lambda before mu, the order in which they are defined;
--   * put the definitions of lambda_C and mu_C on one row, parallel to 8JVN.
-- Apply as one D1 batch after exporting the database. The guard aborts unless
-- every old substring is still present.

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (
    SELECT 1 FROM results WHERE id = 158 AND tag = '8JVA'
      AND instr(statement_tex, '\begin{align*}
\lambda_C&=\frac{k+\mathbf 1_{C=A_0}}{ko+1},\\
\mu_C&=\frac{|T\cap C|}{|T|}.
\end{align*}') > 0
      AND instr(statement_tex, '|\mu_C-\lambda_C|\le r') > 0
      AND instr(statement_tex, '-c_k(\xi)\right|\le or.') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM proofs WHERE id = 133 AND result_id = 158
      AND instr(body_tex, '$\sum_C|\mu_C-\lambda_C|\le or$') > 0
      AND instr(body_tex, '$ok/(ko+1)+1/(ko+1)=1$') > 0
      AND instr(body_tex, '\frac{k}{ko+1}\sum_C\xi(C)+\frac{\xi(A_0)}{ko+1}.') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM results WHERE id = 169 AND tag = '8JVN'
      AND instr(statement_tex, '(\mu_C)_C=\frac1{10}(6,0,3,1),\qquad
(\lambda_C)_C=\frac15(2,1,1,1).') > 0
      AND instr(statement_tex, '$r=\max_C|\mu_C-\lambda_C|=1/5$') > 0
      AND instr(statement_tex, 'the bound is $or=4/5$.') > 0
  );

UPDATE results
SET statement_tex = replace(replace(replace(replace(statement_tex,
    '\begin{align*}
\lambda_C&=\frac{k+\mathbf 1_{C=A_0}}{ko+1},\\
\mu_C&=\frac{|T\cap C|}{|T|}.
\end{align*}',
    '\[
\lambda_C=\frac{k+\mathbf 1_{C=A_0}}{ko+1},\qquad
\mu_C=\frac{|T\cap C|}{|T|}.
\]'),
    '|\mu_C-\lambda_C|\le r', '|\lambda_C-\mu_C|\le r'),
    '-c_k(\xi)\right|\le or.', '-c_k(\xi)\right|\le o\cdot r.'),
    '{ko+1}', '{k\cdot o+1}'),
  statement_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 12:00:00',
  updated_by = 'claude'
WHERE id = 158;

UPDATE proofs
SET body_tex = replace(replace(replace(body_tex,
    '$\sum_C|\mu_C-\lambda_C|\le or$', '$\sum_C|\lambda_C-\mu_C|\le o\cdot r$'),
    '$ok/(ko+1)+1/(ko+1)=1$', '$o\cdot k/(k\cdot o+1)+1/(k\cdot o+1)=1$'),
    '{ko+1}', '{k\cdot o+1}'),
  body_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 12:00:00',
  updated_by = 'claude'
WHERE id = 133;

UPDATE results
SET statement_tex = replace(replace(replace(statement_tex,
    '(\mu_C)_C=\frac1{10}(6,0,3,1),\qquad
(\lambda_C)_C=\frac15(2,1,1,1).',
    '(\lambda_C)_C=\frac15(2,1,1,1),\qquad
(\mu_C)_C=\frac1{10}(6,0,3,1).'),
    '$r=\max_C|\mu_C-\lambda_C|=1/5$', '$r=\max_C|\lambda_C-\mu_C|=1/5$'),
    'the bound is $or=4/5$.', 'the bound is $o\cdot r=4/5$.'),
  statement_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 12:00:00',
  updated_by = 'claude'
WHERE id = 169;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'lambda-mu-order-2026-11-26',
  json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex,
    'section_id', section_id, 'position', position, 'listed', listed,
    'aliases', json((SELECT json_group_array(alias) FROM
      (SELECT alias FROM aliases WHERE aliases.tag = results.tag ORDER BY alias)))),
  'claude', '2026-11-26 12:00:00'
FROM results WHERE id IN (158, 169) ORDER BY id;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'proof', CAST(id AS TEXT), revision, 'lambda-mu-order-2026-11-26',
  json_object('result_id', result_id, 'body_tex', body_tex, 'status', status,
    'generated_by', generated_by, 'generator_detail', generator_detail,
    'reviewed_by', reviewed_by, 'review_notes', review_notes, 'position', position),
  'claude', '2026-11-26 12:00:00'
FROM proofs WHERE id = 133;

UPDATE settings SET value = '1' WHERE key = 'needs_rebuild' AND value <> '1';
