-- Definition TQ4B "Taylor coefficients of H_psi" right before 8JT2 in section 104 (7HM3).
-- 8JT2 and 8JT5 cite it instead of defining A_k inline. 8JT2, 8JT5, 8JR6 move down one position.

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM results WHERE id IS 123 AND tag IS '8JT2' AND revision IS 4 AND position IS 8 AND section_id IS 104
    AND instr(statement_tex, 'For $k \ge 0$ and $\Re s > 1$ let $A_k(s) = \frac{(-1)^k}{k!}\,\mathcal H_\psi^{(k)}(s)$.') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 136 AND tag IS '8JT5' AND revision IS 1 AND position IS 9 AND section_id IS 104
    AND instr(statement_tex, 'For $k \ge 0$ and $\Re s > 1$ let $A_k(s) = \frac{(-1)^k}{k!}\,\mathcal H_\psi^{(k)}(s)$.') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 114 AND tag IS '8JR6' AND revision IS 1 AND position IS 10 AND section_id IS 104)
  OR EXISTS (SELECT 1 FROM results WHERE section_id = 104 AND position = 11)
  OR EXISTS (SELECT 1 FROM tags WHERE tag = 'TQ4B');

UPDATE results SET position = position + 1, statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-27 19:00:00', updated_by = 'claude'
WHERE id IN (123, 136, 114);

UPDATE results SET statement_tex = replace(statement_tex,
  'For $k \ge 0$ and $\Re s > 1$ let $A_k(s) = \frac{(-1)^k}{k!}\,\mathcal H_\psi^{(k)}(s)$.',
  'Let $A_k$ be the \hyperref[TQ4B]{Taylor coefficients} of $\mathcal H_\psi$.')
WHERE id IN (123, 136);

INSERT INTO tags (tag, kind, created_at) VALUES ('TQ4B', 'result', '2026-11-27 19:00:00');

INSERT INTO results (tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, state, listed,
                     created_at, updated_at, created_by, updated_by)
VALUES ('TQ4B', 'definition', 'Taylor coefficients of $\mathcal H_\psi$',
'Let $\psi$ be a \hyperref[8JH4]{primitive character}, and let $\mathcal H_\psi$ be the \hyperref[8JS6]{Mellin transform of the weighted sum}, which is \hyperref[8JN4]{holomorphic on $\Re s>1$}. For $z\in\C$ with $\Re z>1$, the \emph{Taylor coefficients} $A_k(z)\in\C$, $k\ge0$, of $\mathcal H_\psi$ at $z$ are defined by the expansion
\[
\mathcal H_\psi(s)=\sum_{k\ge0}A_k(z)\,(z-s)^k\qquad(|s-z|<\Re z-1).
\]
Explicitly, $A_k(z)$ is $\frac{(-1)^k}{k!}$ times the $k$-th derivative of $\mathcal H_\psi$ at $z$:
\[
A_k(z)=\frac{(-1)^k}{k!}\,\mathcal H_\psi^{(k)}(z).
\]',
NULL, 104, 8, 'published', 'active', 1,
'2026-11-27 19:00:00', '2026-11-27 19:00:00', 'claude', 'claude');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'taylor-coefficients-definition-2026-11-27',
       json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex, 'section_id', section_id,
                   'position', position, 'visibility', visibility, 'state', state, 'replaced_by_id', replaced_by_id, 'listed', listed),
       'claude', '2026-11-27 19:00:00'
FROM results WHERE id IN (123, 136, 114) OR tag = 'TQ4B';

INSERT OR IGNORE INTO refs (source_result_id, source_proof_id, target_tag)
SELECT id, NULL, t.tag FROM results, (SELECT '8JH4' AS tag UNION ALL SELECT '8JS6' UNION ALL SELECT '8JN4') AS t
WHERE results.tag = 'TQ4B';
INSERT OR IGNORE INTO refs (source_result_id, source_proof_id, target_tag) VALUES (123, NULL, 'TQ4B'), (136, NULL, 'TQ4B');

UPDATE settings SET value = '1' WHERE key = 'needs_rebuild' AND value <> '1';
