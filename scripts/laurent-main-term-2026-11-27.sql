-- Hidden lemma KQ7T: the Laurent expansion at s=1 behind the main term in 8JUK, linked from 8JUK's proof (id 124).

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM proofs WHERE id IS 124 AND revision IS 2
    AND instr(body_tex, 'The factor $1/(s-1)$ in the kernel makes this a double pole. Using $x^s/s=x+x(\ln x-1)(s-1)+O_x((s-1)^2)$ gives the main term in the first row.') > 0)
  OR EXISTS (SELECT 1 FROM tags WHERE tag = 'KQ7T')
  OR EXISTS (SELECT 1 FROM results WHERE section_id = 110 AND position = 9);

INSERT INTO tags (tag, kind, created_at) VALUES ('KQ7T', 'result', '2026-11-27 17:00:00');

INSERT INTO results (tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, state, listed,
                     created_at, updated_at, created_by, updated_by)
VALUES ('KQ7T', 'lemma', 'Laurent expansion at $s=1$ in the explicit formula',
'For every real $x\ge1$, the Laurent expansion at $s=1$ of the integrand in \ref{8JUK} is
\[
-\frac{\zeta''(s)}{\zeta(s)}\,\frac{x^s}{s(s-1)}=\frac{x}{(s-1)^2}+\frac{x\ln x-(1+\gamma)x}{s-1}+O(1).
\]
In particular its residue at $s=1$ is $x\ln x-(1+\gamma)x$.',
NULL, 110, 9, 'published', 'active', 0,
'2026-11-27 17:00:00', '2026-11-27 17:00:00', 'claude', 'claude');

INSERT INTO proofs (result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail, visibility,
                    created_at, updated_at, created_by, updated_by)
SELECT id, 1,
'Near $s=1$ the three factors expand as
\begin{alignat*}{2}
\frac{1}{s(s-1)}&=\frac{1}{s-1}-1+O(s-1) &\quad& \text{since } \tfrac1s=1-(s-1)+\dots,\\
-\frac{\zeta''(s)}{\zeta(s)}&=\frac{1}{s-1}-\gamma+O(s-1) && \text{since } \zeta(s)=\tfrac{1}{s-1}+\gamma+\dots,\\
x^s&=x+x\ln x\,(s-1)+O\bigl((s-1)^2\bigr) && \text{since } x^s=x\,e^{(s-1)\ln x}.
\end{alignat*}
The product of the first two is $\frac{1}{(s-1)^2}-\frac{1+\gamma}{s-1}+O(1)$. Multiplying by $x^s$ gives the expansion, and the residue is the coefficient of $\frac{1}{s-1}$.',
NULL, 'ai_generated', 'claude', 'Claude Opus 5.5', 'published',
'2026-11-27 17:00:00', '2026-11-27 17:00:00', 'claude', 'claude'
FROM results WHERE tag = 'KQ7T';

UPDATE proofs SET body_tex = replace(body_tex,
  'The factor $1/(s-1)$ in the kernel makes this a double pole. Using $x^s/s=x+x(\ln x-1)(s-1)+O_x((s-1)^2)$ gives the main term in the first row.',
  'The factor $1/(s-1)$ in the kernel makes this a double pole, and its \hyperref[KQ7T]{Laurent expansion} gives the main term in the first row.'),
  body_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-27 17:00:00', updated_by = 'claude'
WHERE id = 124;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'laurent-main-term-2026-11-27',
       json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex, 'section_id', section_id,
                   'position', position, 'visibility', visibility, 'state', state, 'replaced_by_id', replaced_by_id, 'listed', listed),
       'claude', '2026-11-27 17:00:00'
FROM results WHERE tag = 'KQ7T';

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'proof', CAST(p.id AS TEXT), p.revision, 'laurent-main-term-2026-11-27',
       json_object('result_id', p.result_id, 'body_tex', p.body_tex, 'status', p.status, 'generated_by', p.generated_by,
                   'generator_detail', p.generator_detail, 'reviewed_by', p.reviewed_by, 'review_notes', p.review_notes, 'position', p.position),
       'claude', '2026-11-27 17:00:00'
FROM proofs AS p JOIN results AS r ON r.id = p.result_id WHERE r.tag = 'KQ7T' OR p.id = 124;

INSERT OR IGNORE INTO refs (source_result_id, source_proof_id, target_tag)
SELECT id, NULL, '8JUK' FROM results WHERE tag = 'KQ7T';
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (144, 124, 'KQ7T');

UPDATE settings SET value = '1' WHERE key = 'needs_rebuild' AND value <> '1';
