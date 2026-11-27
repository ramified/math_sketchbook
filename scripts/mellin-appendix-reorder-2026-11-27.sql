-- Appendix A: retire the motivation MCV9, make MCV4 an example right after the definition 8JS2.
-- New order in APXS: 8JS2, MCV4, MCV2, MCV3, MCV5, MCV6, MCV7 (then the unlisted 8JS8).

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM results WHERE id IS 188 AND tag IS 'MCV9' AND revision IS 1 AND state IS 'active')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 115 AND tag IS '8JS2' AND revision IS 3 AND position IS 2)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 191 AND tag IS 'MCV4' AND revision IS 1 AND position IS 5 AND type IS 'lemma')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 192 AND tag IS 'MCV5' AND revision IS 1 AND position IS 6)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 193 AND tag IS 'MCV6' AND revision IS 1 AND position IS 7)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 194 AND tag IS 'MCV7' AND revision IS 1 AND position IS 8)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id IS 119 AND tag IS 'APXS' AND revision IS 1
    AND instr(intro_tex, '\ref{MCV9} explains how this is used') > 0);

UPDATE results SET state = 'retired', statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-27 15:00:00', updated_by = 'claude' WHERE id = 188;
UPDATE results SET position = 1, statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-27 15:00:00', updated_by = 'claude' WHERE id = 115;
UPDATE results SET type = 'example', position = 2, statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-27 15:00:00', updated_by = 'claude' WHERE id = 191;
UPDATE results SET position = 5, statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-27 15:00:00', updated_by = 'claude' WHERE id = 192;
UPDATE results SET position = 6, statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-27 15:00:00', updated_by = 'claude' WHERE id = 193;
UPDATE results SET position = 7, statement_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-27 15:00:00', updated_by = 'claude' WHERE id = 194;

UPDATE sections SET intro_tex = 'The \hyperref[8JS2]{Mellin transform} turns \hyperref[MCV2]{multiplicative convolution} into multiplication, by the \hyperref[MCV3]{convolution theorem}. \ref{MCV7} applies this to the Chebyshev function and the smoothed prime sum.',
  intro_html_cache = NULL, revision = revision + 1,
  updated_at = '2026-11-27 15:00:00', updated_by = 'claude' WHERE id = 119;

-- The retired motivation no longer uses anything.
DELETE FROM refs WHERE source_result_id = 188;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'mellin-appendix-reorder-2026-11-27',
       json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex, 'section_id', section_id,
                   'position', position, 'visibility', visibility, 'state', state, 'replaced_by_id', replaced_by_id, 'listed', listed),
       'claude', '2026-11-27 15:00:00'
FROM results WHERE id IN (188, 115, 191, 192, 193, 194);

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'section', CAST(id AS TEXT), revision, 'mellin-appendix-reorder-2026-11-27',
       json_object('tag', tag, 'parent_id', parent_id, 'kind', kind, 'title', title, 'intro_tex', intro_tex, 'position', position),
       'claude', '2026-11-27 15:00:00'
FROM sections WHERE id = 119;

UPDATE settings SET value = '1' WHERE key = 'needs_rebuild' AND value <> '1';
