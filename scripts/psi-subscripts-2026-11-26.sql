-- Residue groups (8JVC): distinguish the two characters built from psi.
--   * psi_{N_1}: psi pulled back to (Z/N_1Z)^x by reduction modulo N_0;
--   * psi_A: the induced character on A = (Z/N_1Z)^x / U_1;
--   * A_0 = ker psi_A, with the exact-row diagram and [A:A_0] = o.
-- Follow-ups: the section 2.2 intro (8JV7) and the proof of 8JUD now say psi_A where psi acts on A.
-- Apply as one D1 batch after exporting the database. The guard aborts unless
-- every old substring is still present.

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (
    SELECT 1 FROM results WHERE id = 160 AND tag = '8JVC' AND revision = 4
      AND instr(statement_tex, '\end{align*}
Define the group') > 0
      AND instr(statement_tex, '\right\} \cap \ker \psi.') > 0
      AND instr(statement_tex, 'Use the same symbol $\psi$ for the induced character on $A$, defined by reduction modulo $N_0$:
\[
\psi\colon A\longrightarrow\C^\times,') > 0
      AND instr(statement_tex, 'Put $A_0=\ker\psi$.') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM sections WHERE id = 113 AND tag = '8JV7'
      AND instr(intro_tex, 'Requiring $\psi(v)=1$ in $U_1$ makes $\psi$ independent of the representative of a class in $A$. The uniform average in \ref{8JV9} uses $A_0=\ker\psi$. Since the image of $\psi$ has order $o$,') > 0
  )
  OR NOT EXISTS (
    SELECT 1 FROM proofs WHERE id = 117
      AND instr(body_tex, 'the $o$ powers of $\psi$ on $A/A_0$') > 0
  );

UPDATE results
SET statement_tex = replace(replace(replace(replace(statement_tex,
    '\end{align*}
Define the group',
    '\end{align*}
Let $\psi_{N_1}$ be the character of $(\Z/N_1\Z)^\times$ obtained from $\psi$ by reduction modulo $N_0$, so $\psi_{N_1}(v)=\psi(v)$. Define the group'),
    '\right\} \cap \ker \psi.', '\right\} \cap \ker \psi_{N_1}.'),
    'Use the same symbol $\psi$ for the induced character on $A$, defined by reduction modulo $N_0$:
\[
\psi\colon A\longrightarrow\C^\times,',
    'Since $U_1\subseteq\ker\psi_{N_1}$, the character $\psi_{N_1}$ induces a character
\[
\psi_A\colon A\longrightarrow\C^\times,'),
    'Put $A_0=\ker\psi$.',
    'Put $A_0=\ker\psi_A$. Both characters have image $\mu_o$, and reduction modulo $U_1$ gives the commutative diagram with exact rows
\[
\begin{CD}
1 @>>> \ker\psi_{N_1} @>>> (\Z/N_1\Z)^\times @>{\psi_{N_1}}>> \mu_o @>>> 1\\
@. @VVV @VVV @| \\
1 @>>> A_0 @>>> A @>{\psi_A}>> \mu_o @>>> 1
\end{CD}
\]
In particular $A_0=\ker\psi_{N_1}/U_1$ and $[A:A_0]=o$.'),
  statement_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 18:00:00',
  updated_by = 'claude'
WHERE id = 160;

UPDATE sections
SET intro_tex = replace(intro_tex,
    'Requiring $\psi(v)=1$ in $U_1$ makes $\psi$ independent of the representative of a class in $A$. The uniform average in \ref{8JV9} uses $A_0=\ker\psi$. Since the image of $\psi$ has order $o$,',
    'Requiring $\psi_{N_1}(v)=1$ in $U_1$ makes the induced character $\psi_A$ on $A$ independent of the representative of a class. The uniform average in \ref{8JV9} uses $A_0=\ker\psi_A$. Since the image of $\psi_A$ has order $o$,'),
  intro_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 18:00:00',
  updated_by = 'claude'
WHERE id = 113;

UPDATE proofs
SET body_tex = replace(body_tex,
    'the $o$ powers of $\psi$ on $A/A_0$', 'the $o$ powers of $\psi_A$ on $A/A_0$'),
  body_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-26 18:00:00',
  updated_by = 'claude'
WHERE id = 117;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'psi-subscripts-2026-11-26',
  json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex,
    'section_id', section_id, 'position', position, 'listed', listed,
    'aliases', json((SELECT json_group_array(alias) FROM
      (SELECT alias FROM aliases WHERE aliases.tag = results.tag ORDER BY alias)))),
  'claude', '2026-11-26 18:00:00'
FROM results WHERE id = 160;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'section', CAST(id AS TEXT), revision, 'psi-subscripts-2026-11-26',
  json_object('tag', tag, 'kind', kind, 'title', title, 'intro_tex', intro_tex, 'parent_id', parent_id, 'position', position),
  'claude', '2026-11-26 18:00:00'
FROM sections WHERE id = 113;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'proof', CAST(id AS TEXT), revision, 'psi-subscripts-2026-11-26',
  json_object('result_id', result_id, 'body_tex', body_tex, 'status', status,
    'generated_by', generated_by, 'generator_detail', generator_detail,
    'reviewed_by', reviewed_by, 'review_notes', review_notes, 'position', position),
  'claude', '2026-11-26 18:00:00'
FROM proofs WHERE id = 117;

UPDATE settings SET value = '1' WHERE key = 'needs_rebuild' AND value <> '1';
