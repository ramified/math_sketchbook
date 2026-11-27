-- Append the Chebyshev comparison and panels (c)–(e) to Example 8JS9.
-- Apply as one batch. The guard aborts if the example has changed.

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE NOT EXISTS (
  SELECT 1 FROM results WHERE id IS 122 AND tag IS '8JS9' AND revision IS 5
    AND instr(statement_tex, 'while $1.41 < G_{\mathbf 1}(x) < 2.21$ for $1 \le x \le 1000$.') > 0
);

UPDATE results
SET statement_tex = statement_tex || '

\emph{Comparison with the Chebyshev function.} Let $\Psi_{\mathbf 1}(x)=\sum_{n\le x}\Lambda(n)$ be the \hyperref[8JUT]{Chebyshev function}. By \ref{8JV3}, $R_{\mathbf 1}(x)=x\int_1^x\Psi_{\mathbf 1}(t)\,t^{-2}\,dt$. Both functions have their breakpoints at the prime powers $n$. At $n$ the step function $\Psi_{\mathbf 1}$ jumps by $\Lambda(n)$, while $R_{\mathbf 1}$ stays continuous and its slope jumps by $\Lambda(n)/n$. Between consecutive prime powers $R_{\mathbf 1}$ is linear with slope
\[ R_{\mathbf 1}''(x)=\sum_{n\le x}\frac{\Lambda(n)}{n}. \]
Panels (c)--(e) show this for $1\le x\le 20$. The dotted vertical lines mark the prime powers $2,3,4,5,7,8,9,11,13,16,17,19$, and the dashed curves are the smooth approximations $x$, $M_{\mathbf 1}(x)$ and $M_{\mathbf 1}''(x)=\ln x-\gamma$.
\begin{center}
\textbf{(c)} $\Psi_{\mathbf 1}(x)$ and $x$, for $1\le x\le 20$
\end{center}
\includegraphics[width=1, alt=The Chebyshev function Psi_1(x) as a step function jumping by log p at each prime power p^k against the line x for x from 1 to 20]{/static/figures/chebyshev-psi.svg}
\begin{center}
\textbf{(d)} $R_{\mathbf 1}(x)$ and $M_{\mathbf 1}(x)$, for $1\le x\le 20$
\end{center}
\includegraphics[width=1, alt=R_1(x) continuous and piecewise linear with corners at the prime powers against M_1(x) for x from 1 to 20]{/static/figures/chebyshev-smoothed.svg}
\begin{center}
\textbf{(e)} The slope $R_{\mathbf 1}''(x)=\sum_{n\le x}\Lambda(n)/n$ and $\ln x-\gamma$, for $1\le x\le 20$
\end{center}
\includegraphics[width=1, alt=The slope of R_1 as a step function jumping by Lambda(n)/n at each prime power n against ln x minus gamma for x from 1 to 20]{/static/figures/chebyshev-slope.svg}',
  statement_html_cache = NULL,
  revision = 6,
  updated_at = '2026-11-27 12:00:00',
  updated_by = 'claude'
WHERE id = 122;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'chebyshev-figure-2026-11-27',
  json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex,
    'section_id', section_id, 'position', position, 'listed', listed,
    'aliases', json((SELECT json_group_array(alias) FROM
      (SELECT alias FROM aliases WHERE aliases.tag = results.tag ORDER BY alias)))),
  updated_by, updated_at
FROM results WHERE id = 122;

INSERT OR IGNORE INTO refs (source_result_id, source_proof_id, target_tag)
VALUES (122, NULL, '8JV3'), (122, NULL, '8JUT');

UPDATE settings SET value = '1' WHERE key = 'needs_rebuild' AND value <> '1';
