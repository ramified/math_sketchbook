-- Add Mellin inversion after MCV4 in Appendix A, following the appendix reorder.
-- Apply as one atomic batch. In SQLite, wrap the whole file in a transaction.

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM sections WHERE id = 119 AND tag = 'APXS')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 115 AND tag = '8JS2' AND revision = 4 AND section_id = 119 AND position = 1)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 191 AND tag = 'MCV4' AND revision = 2 AND section_id = 119 AND position = 2)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 189 AND tag = 'MCV2' AND revision = 1 AND section_id = 119 AND position = 3)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 190 AND tag = 'MCV3' AND revision = 1 AND section_id = 119 AND position = 4)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 192 AND tag = 'MCV5' AND revision = 2 AND section_id = 119 AND position = 5)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 193 AND tag = 'MCV6' AND revision = 2 AND section_id = 119 AND position = 6)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 194 AND tag = 'MCV7' AND revision = 2 AND section_id = 119 AND position = 7)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 121 AND tag = '8JS8' AND revision = 2 AND section_id = 119 AND position = 9 AND listed = 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 155 AND tag = '8JV3' AND revision = 4
    AND instr(statement_tex, 'otherwise Mellin inversion would make') > 0)
  OR EXISTS (SELECT 1 FROM tags WHERE tag = 'MCV8');

UPDATE results
SET position = position + 1, statement_html_cache = NULL, revision = revision + 1,
    updated_at = '2026-11-27 16:00:00', updated_by = 'claude'
WHERE id IN (189, 190, 192, 193, 194);

INSERT INTO tags (tag, kind, created_at) VALUES ('MCV8', 'result', '2026-11-27 16:00:00');

INSERT INTO results (tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, state, listed,
                     created_at, updated_at, created_by, updated_by)
VALUES ('MCV8', 'theorem', 'Mellin inversion', 'Let $f$ be as in the \hyperref[8JS2]{definition of the Mellin transform}, with exponent $c_0$, and let $c>c_0$ be real such that $\mathcal M f$ is \hyperref[8JV4]{absolutely integrable on $\Re s=c$}. Put
\[
I\colon(0,\infty)\longrightarrow\C,\qquad x\longmapsto\frac1{2\pi i}\int_{c-i\infty}^{c+i\infty}(\mathcal Mf)(s)\,x^s\,ds.
\]
Then $I$ is continuous and vanishes on $(0,1)$, and $I(x)=f(x)$ for almost every $x\ge1$ and for every $x>1$ at which $f$ is continuous.',
        NULL, 119, 3, 'published', 'active', 1, '2026-11-27 16:00:00', '2026-11-27 16:00:00', 'claude', 'claude');

INSERT INTO proofs (result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail, visibility,
                    created_at, updated_at, created_by, updated_by)
SELECT id, 1, 'Put $\varphi(u)=f(e^u)\,e^{-cu}$ for $u\ge0$ and $\varphi(u)=0$ for $u<0$. Then $\varphi$ is integrable on $\R$ by \hyperref[8JS8]{absolute convergence}, and the substitution $x=e^u$ gives
\[
(\mathcal Mf)(c+i\tau)=\int_{-\infty}^{\infty}\varphi(u)\,e^{-i\tau u}\,du=\hat\varphi(\tau).
\]
By hypothesis $\hat\varphi$ is integrable, so by the Fourier inversion theorem $\check\varphi(u)=\frac1{2\pi}\int_{-\infty}^{\infty}\hat\varphi(\tau)\,e^{i\tau u}\,d\tau$ is continuous and equals $\varphi$ almost everywhere. With $s=c+i\tau$ we have $ds=i\,d\tau$, hence
\[
I(x)=x^c\,\check\varphi(\ln x).
\]
So $I$ is continuous, $I(x)=f(x)$ for almost every $x\ge1$, and $I=0$ almost everywhere on $(0,1)$, hence everywhere there. If $f$ is continuous at $x>1$, then $I$ and $f$ are continuous at $x$ and agree almost everywhere near $x$, so $I(x)=f(x)$.',
       NULL, 'ai_generated', 'claude', 'Claude Opus 5.5', 'published',
       '2026-11-27 16:00:00', '2026-11-27 16:00:00', 'claude', 'claude'
FROM results WHERE tag = 'MCV8';

-- Limit replace to the prefix ending at the first occurrence of the exact phrase.
WITH phrase(original, linked) AS (VALUES (
  'otherwise Mellin inversion would make',
  'otherwise \hyperref[MCV8]{Mellin inversion} would make'
)), target AS (
  SELECT id, original, linked, instr(statement_tex, original) + length(original) - 1 AS phrase_end
  FROM results CROSS JOIN phrase WHERE id = 155
)
UPDATE results
SET statement_tex = replace(substr(statement_tex, 1, phrase_end), original, linked) || substr(statement_tex, phrase_end + 1),
    statement_html_cache = NULL, revision = revision + 1,
    updated_at = '2026-11-27 16:00:00', updated_by = 'claude'
FROM target WHERE results.id = target.id;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'mellin-inversion-2026-11-27',
       json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex, 'section_id', section_id,
                   'position', position, 'visibility', visibility, 'state', state, 'replaced_by_id', replaced_by_id, 'listed', listed),
       'claude', '2026-11-27 16:00:00'
FROM results WHERE id IN (155, 189, 190, 192, 193, 194) OR tag = 'MCV8';

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'proof', CAST(p.id AS TEXT), p.revision, 'mellin-inversion-2026-11-27',
       json_object('result_id', p.result_id, 'body_tex', p.body_tex, 'status', p.status, 'generated_by', p.generated_by,
                   'generator_detail', p.generator_detail, 'reviewed_by', p.reviewed_by, 'review_notes', p.review_notes, 'position', p.position),
       'claude', '2026-11-27 16:00:00'
FROM proofs AS p JOIN results AS r ON r.id = p.result_id WHERE r.tag = 'MCV8';

WITH edges(source_tag, target_tag) AS (VALUES ('MCV8', '8JS2'), ('MCV8', '8JV4'), ('8JV3', 'MCV8'))
INSERT INTO refs (source_result_id, source_proof_id, target_tag)
SELECT results.id, NULL, edges.target_tag FROM edges JOIN results ON results.tag = edges.source_tag;

INSERT INTO refs (source_result_id, source_proof_id, target_tag)
SELECT r.id, p.id, '8JS8' FROM proofs AS p JOIN results AS r ON r.id = p.result_id WHERE r.tag = 'MCV8';

INSERT INTO settings (key, value) VALUES ('needs_rebuild', '1')
ON CONFLICT (key) DO UPDATE SET value = excluded.value WHERE settings.value <> excluded.value;
