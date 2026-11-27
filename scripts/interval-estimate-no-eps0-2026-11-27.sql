-- 8JK2 without epsilon_0 and with exponent 1/2+epsilon. The Chapter 3 constants (epsilon_0, the factor 9) move into
-- the explicit statement of 8JVJ, and the proof of 8JK2 converts. 8JR6's proof and 8JTA follow.

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM results WHERE id IS 110 AND tag IS '8JK2' AND revision IS 4
    AND instr(statement_tex, 'For each primitive $\psi$ there is $\varepsilon_0>0$ such that for every $0<\varepsilon<\varepsilon_0$ and every $Y_0\ge1$ some $Y\ge Y_0$ satisfies
\[
\mathcal G_\psi(x)\le x^{1/2+9\varepsilon}') = 1)
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id IS 131 AND revision IS 2
    AND body_tex = 'The corollary in \ref{8JVJ} obtains this estimate from the arithmetic bound of \ref{8JVG} and the Fourier comparison of \ref{8JUD}.')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 166 AND tag IS '8JVJ' AND revision IS 1
    AND statement_tex = 'Under the arithmetic bound of \ref{8JVG}, the \hyperref[8JG8]{weighted sum} satisfies the \hyperref[8JK2]{arithmetic interval estimate}.')
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id IS 103 AND revision IS 1
    AND instr(body_tex, 'Put
\[ \theta = \frac{\beta + \frac12}{2} \in \bigl(\tfrac12, \beta\bigr), \qquad 0 < \varepsilon < \min\Bigl\{\varepsilon_0, \frac{\theta - \frac12}{9}\Bigr\}. \]
Then $x^{1/2 + 9\varepsilon} \le x^\theta$ for $x \ge 1$, so the \hyperref[8JK2]{interval estimate} supplies the hypothesis of the \hyperref[8JP5]{interval criterion} for this $\theta$.') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 141 AND tag IS '8JTA' AND revision IS 7
    AND instr(statement_tex, 'only asks that $G_{\mathbf 1}(x) \le x^{1/2 + 9\varepsilon}$ on sparse intervals') > 0
    AND instr(statement_tex, 'applied with $\theta=1/2+9\varepsilon$ for every sufficiently small $\varepsilon>0$') > 0);

-- 8JK2: no epsilon_0, exponent 1/2+epsilon.
UPDATE results SET statement_tex = replace(statement_tex,
'For each primitive $\psi$ there is $\varepsilon_0>0$ such that for every $0<\varepsilon<\varepsilon_0$ and every $Y_0\ge1$ some $Y\ge Y_0$ satisfies
\[
\mathcal G_\psi(x)\le x^{1/2+9\varepsilon}',
'For every primitive $\psi$, every real $\varepsilon>0$ and every real $Y_0\ge1$ there is a real $Y\ge Y_0$ such that
\[
\mathcal G_\psi(x)\le x^{1/2+\varepsilon}'),
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-27 18:00:00', updated_by = 'claude'
WHERE id = 110;
UPDATE results SET statement_tex = replace(statement_tex, 'This is (W) of \cite{Outline}.', 'This is equivalent to (W) of \cite{Outline}.')
WHERE id = 110;

UPDATE proofs SET body_tex =
'Let $\varepsilon_0(\psi)$ be as in \ref{8JVG} and put $\varepsilon''=\min\bigl(\varepsilon/9,\ \varepsilon_0(\psi)/2\bigr)$. The corollary \ref{8JVJ}, which combines the arithmetic bound of \ref{8JVG} with the Fourier comparison of \ref{8JUD}, gives for $\varepsilon''$ windows on which $\mathcal G_\psi(x)\le x^{1/2+9\varepsilon''}$. On them $\mathcal G_\psi(x)\le x^{1/2+\varepsilon}$, since $9\varepsilon''\le\varepsilon$ and $x\ge1$.',
  body_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-27 18:00:00', updated_by = 'claude'
WHERE id = 131;

-- 8JVJ: the explicit Chapter 3 form.
UPDATE results SET statement_tex =
'Assume the \hyperref[8JVG]{arithmetic bound}, and let $\psi$ be primitive with $\varepsilon_0(\psi)$ from \ref{8JVG}. For every $0<\varepsilon<\varepsilon_0(\psi)$ and every real $Y_0\ge1$ there is a real $Y\ge Y_0$ such that the \hyperref[8JG8]{weighted sum} satisfies
\[
\mathcal G_\psi(x)\le x^{1/2+9\varepsilon}\qquad(Y\le x\le Y^{3/2}).
\]',
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-27 18:00:00', updated_by = 'claude'
WHERE id = 166;

-- 8JR6: no epsilon_0 needed.
UPDATE proofs SET body_tex = replace(body_tex,
'Put
\[ \theta = \frac{\beta + \frac12}{2} \in \bigl(\tfrac12, \beta\bigr), \qquad 0 < \varepsilon < \min\Bigl\{\varepsilon_0, \frac{\theta - \frac12}{9}\Bigr\}. \]
Then $x^{1/2 + 9\varepsilon} \le x^\theta$ for $x \ge 1$, so the \hyperref[8JK2]{interval estimate} supplies the hypothesis of the \hyperref[8JP5]{interval criterion} for this $\theta$.',
'Put
\[ \theta = \frac{\beta + \frac12}{2} \in \bigl(\tfrac12, \beta\bigr). \]
The \hyperref[8JK2]{interval estimate} with $\varepsilon = \theta - \frac12$ is the hypothesis of the \hyperref[8JP5]{interval criterion} for this $\theta$.'),
  body_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-27 18:00:00', updated_by = 'claude'
WHERE id = 103;

-- 8JTA: exponent 1/2+epsilon.
UPDATE results SET statement_tex = replace(replace(statement_tex,
'only asks that $G_{\mathbf 1}(x) \le x^{1/2 + 9\varepsilon}$ on sparse intervals',
'only asks that $G_{\mathbf 1}(x) \le x^{1/2 + \varepsilon}$ on sparse intervals'),
'applied with $\theta=1/2+9\varepsilon$ for every sufficiently small $\varepsilon>0$',
'applied with $\theta=1/2+\varepsilon$ for every $0<\varepsilon<\frac12$'),
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-27 18:00:00', updated_by = 'claude'
WHERE id = 141;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'interval-estimate-no-eps0-2026-11-27',
       json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex, 'section_id', section_id,
                   'position', position, 'visibility', visibility, 'state', state, 'replaced_by_id', replaced_by_id, 'listed', listed),
       'claude', '2026-11-27 18:00:00'
FROM results WHERE id IN (110, 166, 141);

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'proof', CAST(id AS TEXT), revision, 'interval-estimate-no-eps0-2026-11-27',
       json_object('result_id', result_id, 'body_tex', body_tex, 'status', status, 'generated_by', generated_by,
                   'generator_detail', generator_detail, 'reviewed_by', reviewed_by, 'review_notes', review_notes, 'position', position),
       'claude', '2026-11-27 18:00:00'
FROM proofs WHERE id IN (131, 103);

-- 8JVJ no longer cites 8JK2.
DELETE FROM refs WHERE source_result_id = 166 AND source_proof_id IS NULL AND target_tag = '8JK2';

UPDATE settings SET value = '1' WHERE key = 'needs_rebuild' AND value <> '1';
