-- G1CM is not a valid tag (TAG_RE excludes 1); rename it to GCHB.
INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM results WHERE tag IS 'G1CM')
  OR EXISTS (SELECT 1 FROM tags WHERE tag = 'GCHB')
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id IS 117 AND instr(intro_tex, '\ref{G1CM}') > 0);
INSERT INTO tags (tag, kind, created_at) VALUES ('GCHB', 'result', '2026-11-28 00:20:00');
UPDATE results SET tag = 'GCHB', statement_html_cache = NULL WHERE tag = 'G1CM';
UPDATE refs SET target_tag = 'GCHB' WHERE target_tag = 'G1CM';
UPDATE revisions SET snapshot_json = json_set(snapshot_json, '$.tag', 'GCHB')
  WHERE operation_id = 'chebyshev-G1-motivation-2026-11-27' AND entity = 'result';
UPDATE sections SET intro_tex = replace(intro_tex, '\ref{G1CM}', '\ref{GCHB}'), intro_html_cache = NULL WHERE id = 117;
DELETE FROM tags WHERE tag = 'G1CM';
UPDATE settings SET value = '1' WHERE key = 'needs_rebuild' AND value <> '1';
