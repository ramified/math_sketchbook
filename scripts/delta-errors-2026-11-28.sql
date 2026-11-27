-- Rename the comparison errors E_div, E_size to Delta_div, Delta_size (section 2.2 intro and GCHB), so they no
-- longer clash with the fractional-part sum E(n) of JMUK.

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM sections WHERE id IS 117 AND tag IS 'WJQV' AND revision IS 2)
  OR NOT EXISTS (SELECT 1 FROM results WHERE tag IS 'GCHB' AND revision IS 2);

UPDATE sections SET intro_tex = replace(replace(intro_tex, 'E_{\rm div}', '\Delta_{\rm div}'), 'E_{\rm size}', '\Delta_{\rm size}'),
  intro_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-28 01:00:00', updated_by = 'claude'
WHERE id = 117;

UPDATE results SET statement_tex = replace(replace(statement_tex, 'E_{\rm div}', '\Delta_{\rm div}'), 'E_{\rm size}', '\Delta_{\rm size}'),
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-28 01:00:00', updated_by = 'claude'
WHERE tag = 'GCHB';

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'delta-errors-2026-11-28',
       json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex, 'section_id', section_id,
                   'position', position, 'visibility', visibility, 'state', state, 'replaced_by_id', replaced_by_id, 'listed', listed),
       'claude', '2026-11-28 01:00:00'
FROM results WHERE tag = 'GCHB';
