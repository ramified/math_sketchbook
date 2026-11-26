-- Write the map definitions of w (8JU9), pi (8JVP) and c_k (8JVA) on one row with \qquad.
-- The first statement guards every edited row.

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM results WHERE id IS 128 AND tag IS '8JU9' AND revision IS 6
    AND instr(statement_tex, 'w&\colon\Phi\longrightarrow(0,\infty),\\
w_\alpha&=w(\alpha)\qquad(\alpha\in\Phi).') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 170 AND tag IS '8JVP' AND revision IS 2
    AND instr(statement_tex, '\pi &\colon(\Z/N\Z)^\times\longrightarrow B,\\
\pi(v) &= ((e_1(v),e_2(v)),[v]_A).') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 158 AND tag IS '8JVA' AND revision IS 4
    AND instr(statement_tex, 'c_k&\colon\widehat{A/A_0}\longrightarrow(0,1],\\
\xi&\longmapsto') > 0
    AND instr(statement_tex, '\end{cases}
\end{aligned}') > 0);

UPDATE results SET statement_tex = replace(statement_tex,
'use the notation
\[
\begin{aligned}
w&\colon\Phi\longrightarrow(0,\infty),\\
w_\alpha&=w(\alpha)\qquad(\alpha\in\Phi).
\end{aligned}
\]',
'use the notation
\[
w\colon\Phi\longrightarrow(0,\infty),\qquad \alpha\longmapsto w_\alpha=w(\alpha).
\]'),
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 01:30:00', updated_by = 'claude'
WHERE id = 128;

UPDATE results SET statement_tex = replace(statement_tex,
'\begin{align*}
B &= (\Z/2\Z)^2\times A,\\
\pi &\colon(\Z/N\Z)^\times\longrightarrow B,\\
\pi(v) &= ((e_1(v),e_2(v)),[v]_A).
\end{align*}',
'\[
B=(\Z/2\Z)^2\times A,
\]
and define
\[
\pi\colon(\Z/N\Z)^\times\longrightarrow B,\qquad v\longmapsto((e_1(v),e_2(v)),[v]_A).
\]'),
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 01:30:00', updated_by = 'claude'
WHERE id = 170;

UPDATE results SET statement_tex = replace(replace(statement_tex,
'\begin{aligned}
c_k&\colon\widehat{A/A_0}\longrightarrow(0,1],\\
\xi&\longmapsto',
'c_k\colon\widehat{A/A_0}\longrightarrow(0,1],\qquad
\xi\longmapsto'),
'\end{cases}
\end{aligned}',
'\end{cases}'),
  statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-26 01:30:00', updated_by = 'claude'
WHERE id = 158;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'one-row-maps-2026-11-26',
  json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex, 'section_id', section_id, 'position', position, 'listed', listed, 'aliases', json((SELECT json_group_array(alias) FROM (SELECT alias FROM aliases WHERE aliases.tag = results.tag ORDER BY alias)))),
  'claude', '2026-11-26 01:30:00'
FROM results WHERE id IN (128, 158, 170) ORDER BY id;

UPDATE settings SET value = '1' WHERE key = 'needs_rebuild' AND value <> '1';
