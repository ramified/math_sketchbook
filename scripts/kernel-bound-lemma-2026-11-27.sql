-- Hidden lemma KW4N "Kernel bound on and off the window" (section 104, next to 8JT4), cited by the third line of
-- the proof of 8JUP (proof 126). Also: c_0 = 200 made explicit, and the reason for the fourth line added.

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM proofs WHERE id IS 126 AND revision IS 2
    AND instr(body_tex, 'Let $c_0$ be the threshold in the \hyperref[8JT4]{kernel concentration estimate}, and fix $c\ge c_0$.') > 0
    AND instr(body_tex, 'The third line uses both parts of the kernel estimate.') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 125 AND tag IS '8JT4' AND revision IS 3)
  OR EXISTS (SELECT 1 FROM tags WHERE tag = 'KW4N')
  OR EXISTS (SELECT 1 FROM results WHERE section_id = 104 AND position = 20);

INSERT INTO tags (tag, kind, created_at) VALUES ('KW4N', 'result', '2026-11-27 21:00:00');

INSERT INTO results (tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, state, listed,
                     created_at, updated_at, created_by, updated_by)
VALUES ('KW4N', 'lemma', 'Kernel bound on and off the window',
'Let $c\ge200$, $0<\theta<1$ and $U>0$ be real. Put
\[
W=[U,\tfrac32U],\qquad k=\bigl\lceil\tfrac54cU\bigr\rceil,\qquad K_k(u)=\frac{u^ke^{-cu}}{k!}\quad(u\ge0).
\]
\begin{enumerate}
\item[(i)] $\displaystyle\int_W e^{\theta u}K_k(u)\,du\le(c-\theta)^{-k-1}$.
\item[(ii)] $\displaystyle\int_{[0,\infty)\setminus W}e^{2u}K_k(u)\,du\le2c^{-k}$.
\end{enumerate}',
NULL, 104, 20, 'published', 'active', 0,
'2026-11-27 21:00:00', '2026-11-27 21:00:00', 'claude', 'claude');

INSERT INTO proofs (result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail, visibility,
                    created_at, updated_at, created_by, updated_by)
SELECT id, 1,
'\emph{(i)} The integrand is nonnegative, so the integral over $W$ is at most the integral over $[0,\infty)$, which is $(c-\theta)^{-k-1}$ by the \hyperref[8JT4]{Gamma integral} (i) with $a=\theta<c$.

\emph{(ii)} This is part (ii) of the \hyperref[8JT4]{concentration of the kernel}.',
NULL, 'ai_generated', 'claude', 'Claude Opus 5.5', 'published',
'2026-11-27 21:00:00', '2026-11-27 21:00:00', 'claude', 'claude'
FROM results WHERE tag = 'KW4N';

UPDATE proofs SET body_tex = replace(replace(body_tex,
  'Let $c_0$ be the threshold in the \hyperref[8JT4]{kernel concentration estimate}, and fix $c\ge c_0$.',
  'Put $c_0=200$, the threshold in the \hyperref[8JT4]{kernel concentration estimate}, and fix $c\ge c_0$.'),
  'The third line uses both parts of the kernel estimate.',
  'The third line is the \hyperref[KW4N]{kernel bound on and off $W$}, multiplied by $2$ and by $2B$. The last line uses $c-\theta>1$ and $c^{-k}\le(c-\theta)^{-k}$.'),
  body_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-27 21:00:00', updated_by = 'claude'
WHERE id = 126;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'kernel-bound-lemma-2026-11-27',
       json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex, 'section_id', section_id,
                   'position', position, 'visibility', visibility, 'state', state, 'replaced_by_id', replaced_by_id, 'listed', listed),
       'claude', '2026-11-27 21:00:00'
FROM results WHERE tag = 'KW4N';

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'proof', CAST(p.id AS TEXT), p.revision, 'kernel-bound-lemma-2026-11-27',
       json_object('result_id', p.result_id, 'body_tex', p.body_tex, 'status', p.status, 'generated_by', p.generated_by,
                   'generator_detail', p.generator_detail, 'reviewed_by', p.reviewed_by, 'review_notes', p.review_notes, 'position', p.position),
       'claude', '2026-11-27 21:00:00'
FROM proofs AS p JOIN results AS r ON r.id = p.result_id WHERE r.tag = 'KW4N' OR p.id = 126;

INSERT INTO refs (source_result_id, source_proof_id, target_tag)
SELECT r.id, p.id, '8JT4' FROM results r JOIN proofs p ON p.result_id = r.id WHERE r.tag = 'KW4N';
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (146, 126, 'KW4N');

UPDATE settings SET value = '1' WHERE key = 'needs_rebuild' AND value <> '1';
