-- GCHB: say what E(n), E_div and E_size are (the fractional-part sum of JMUK(ii); the divisibility and size errors
-- of the section introduction).

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM results WHERE tag IS 'GCHB' AND revision IS 1
    AND instr(statement_tex, 'and the integer parts are recovered exactly by \ref{JMUK}(ii). The two errors of the comparison are') > 0);

UPDATE results SET statement_tex = replace(statement_tex,
'and the integer parts are recovered exactly by \ref{JMUK}(ii). The two errors of the comparison are',
'and \ref{JMUK}(ii) accounts for the difference exactly through the fractional-part sum $E(n)=\sum_{r\le n}\Lambda(r)\{n/r\}$, where $\{y\}=y-\lfloor y\rfloor$. In the comparison of the section introduction, $E_{\rm div}$ is the error in the divisibility lower bound $\ln|N|\ge B\,T-E_{\rm div}$, and $E_{\rm size}$ is the error in the size upper bound $\ln|N|\le B\,M+E_{\rm size}$. Here they are'),
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-28 00:40:00', updated_by = 'claude'
WHERE tag = 'GCHB';

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'GCHB-define-errors-2026-11-28',
       json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex, 'section_id', section_id,
                   'position', position, 'visibility', visibility, 'state', state, 'replaced_by_id', replaced_by_id, 'listed', listed),
       'claude', '2026-11-28 00:40:00'
FROM results WHERE tag = 'GCHB';
