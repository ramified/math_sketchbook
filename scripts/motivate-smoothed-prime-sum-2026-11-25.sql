-- Motivate the smoothed prime sum in section 7HE6 (2026-11-25 16:30:00).

INSERT OR ROLLBACK INTO write_guard (ok) SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM sections WHERE id = 102 AND revision = 1 AND intro_tex = '')
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 106 AND section_id = 102 AND position = 1 AND revision = 2)
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id = 106 AND revision = 4 AND instr(body_tex, 'and $\sum_n \Lambda(n) n^{-\sigma} < \infty$ for $\sigma > 1$, we may integrate term by term:') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 116 AND section_id = 102 AND position = 2)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 107 AND section_id = 102 AND position = 4)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 108 AND section_id = 102 AND position = 5)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 109 AND section_id = 102 AND position = 6)
  OR EXISTS (SELECT 1 FROM tags WHERE tag IN ('8JUR', '8JUS', '8JUT', '8JUU', '8JUV'))
  OR EXISTS (SELECT 1 FROM results WHERE id IN (148, 149, 150, 151, 152))
  OR EXISTS (SELECT 1 FROM proofs WHERE id IN (128, 129, 130))
  OR EXISTS (SELECT 1 FROM aliases WHERE alias IN ('von-mangoldt-function', 'log-derivative-l-function', 'chebyshev-function', 'chebyshev-mellin-transform', 'l-at-one-nonzero'))
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND entity_key IN ('148', '149', '150', '151', '152'))
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'proof' AND entity_key IN ('128', '129', '130'));

INSERT INTO tags (tag, kind, created_at) VALUES
  ('8JUR', 'result', '2026-11-25 16:30:00');
INSERT INTO tags (tag, kind, created_at) VALUES
  ('8JUS', 'result', '2026-11-25 16:30:00');
INSERT INTO tags (tag, kind, created_at) VALUES
  ('8JUT', 'result', '2026-11-25 16:30:00');
INSERT INTO tags (tag, kind, created_at) VALUES
  ('8JUU', 'result', '2026-11-25 16:30:00');
INSERT INTO tags (tag, kind, created_at) VALUES
  ('8JUV', 'result', '2026-11-25 16:30:00');
INSERT INTO aliases (alias, tag, created_at) VALUES
  ('von-mangoldt-function', '8JUR', '2026-11-25 16:30:00');
INSERT INTO aliases (alias, tag, created_at) VALUES
  ('log-derivative-l-function', '8JUS', '2026-11-25 16:30:00');
INSERT INTO aliases (alias, tag, created_at) VALUES
  ('chebyshev-function', '8JUT', '2026-11-25 16:30:00');
INSERT INTO aliases (alias, tag, created_at) VALUES
  ('chebyshev-mellin-transform', '8JUU', '2026-11-25 16:30:00');
INSERT INTO aliases (alias, tag, created_at) VALUES
  ('l-at-one-nonzero', '8JUV', '2026-11-25 16:30:00');

UPDATE results SET position = 9 WHERE id = 109 AND section_id = 102;
UPDATE results SET position = 8 WHERE id = 108 AND section_id = 102;
UPDATE results SET position = 7 WHERE id = 107 AND section_id = 102;
UPDATE results SET position = 6 WHERE id = 116 AND section_id = 102;
UPDATE results SET statement_tex = 'Let $\Lambda$ be the \hyperref[8JUR]{von Mangoldt function} and $\gamma$ Euler''s constant. For a \hyperref[8JH4]{primitive character} $\chi$ and real $x \ge 1$ put
\[ R_\chi(x) = \sum_{n \ge 1} \chi(n)\Lambda(n)\Bigl(\frac{x}{n} - 1\Bigr)_+, \qquad v_+ = \max(v, 0), \]
and
\[ G_\chi(x) = \begin{cases} R_{\mathbf 1}(x) - x\ln x + (1+\gamma)x, & \chi = \mathbf 1, \\[4pt] R_\chi(x) + x\,\dfrac{L''(1,\chi)}{L(1,\chi)}, & \chi \ne \mathbf 1. \end{cases} \]
Here \hyperref[8JUV]{$L(1,\chi) \ne 0$} for $\chi \ne \mathbf 1$.',
  position = 5, statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 16:30:00', updated_by = 'codex' WHERE id = 106;
INSERT INTO results (id, tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, listed, revision, created_at, updated_at, created_by, updated_by) VALUES
  (148, '8JUR', 'definition', 'von Mangoldt function', 'For integers $n\ge1$, the \emph{von Mangoldt function} is
\[ \Lambda(n) = \begin{cases}
\ln p, & n = p^k \text{ for a prime } p \text{ and an integer } k\ge1, \\
0, & \text{otherwise}.
\end{cases} \]', NULL, 102, 1, 'published', 1, 1, '2026-11-25 16:30:00', '2026-11-25 16:30:00', 'codex', 'codex');
INSERT INTO results (id, tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, listed, revision, created_at, updated_at, created_by, updated_by) VALUES
  (149, '8JUS', 'lemma', 'Logarithmic derivative of $L(s,\chi)$', 'Let $\chi$ be a \hyperref[8JA9]{Dirichlet character} and $\Lambda$ the \hyperref[8JUR]{von Mangoldt function}. For every $s\in\C$ with $\Re s>1$,
\[ -\frac{L''}{L}(s,\chi) = \sum_{n\ge1}\frac{\chi(n)\Lambda(n)}{n^s}, \]
and the series converges absolutely.', NULL, 102, 2, 'published', 1, 1, '2026-11-25 16:30:00', '2026-11-25 16:30:00', 'codex', 'codex');
INSERT INTO results (id, tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, listed, revision, created_at, updated_at, created_by, updated_by) VALUES
  (150, '8JUT', 'definition', 'Generalized Chebyshev function', 'Let $\chi$ be a \hyperref[8JA9]{Dirichlet character}. The \emph{generalized Chebyshev function} of $\chi$ is
\[ \Psi_\chi(x) = \sum_{n\le x}\chi(n)\Lambda(n) \qquad (x\ge1), \]
where $\Lambda$ is the \hyperref[8JUR]{von Mangoldt function}.', NULL, 102, 3, 'published', 1, 1, '2026-11-25 16:30:00', '2026-11-25 16:30:00', 'codex', 'codex');
INSERT INTO results (id, tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, listed, revision, created_at, updated_at, created_by, updated_by) VALUES
  (151, '8JUU', 'lemma', 'Mellin transform of the Chebyshev function', 'Let $\chi$ be a \hyperref[8JA9]{Dirichlet character} and $\Psi_\chi$ its \hyperref[8JUT]{generalized Chebyshev function}. For every $s\in\C$ with $\Re s>1$,
\[ \int_1^\infty \Psi_\chi(x)\,x^{-s-1}\,dx = -\frac1s\,\frac{L''}{L}(s,\chi). \]', NULL, 102, 4, 'published', 1, 1, '2026-11-25 16:30:00', '2026-11-25 16:30:00', 'codex', 'codex');
INSERT INTO results (id, tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, listed, revision, created_at, updated_at, created_by, updated_by) VALUES
  (152, '8JUV', 'lemma', 'Non-vanishing of $L(1,\chi)$', 'Let $\chi \ne \mathbf 1$ be a \hyperref[8JH4]{primitive character}. Then $L(1,\chi)\ne0$.', NULL, 102, 10, 'published', 0, 1, '2026-11-25 16:30:00', '2026-11-25 16:30:00', 'codex', 'codex');

UPDATE proofs SET body_tex = replace(body_tex,
  'and $\sum_n \Lambda(n) n^{-\sigma} < \infty$ for $\sigma > 1$, we may integrate term by term:',
  'and the series of the \hyperref[8JUS]{logarithmic derivative} converges absolutely, we may integrate term by term:'),
  body_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 16:30:00', updated_by = 'codex' WHERE id = 106;
INSERT INTO proofs (id, result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail, revision, created_at, updated_at, created_by, updated_by) VALUES
  (128, 149, 1, 'Take logarithmic derivatives of the Euler factors, using local uniform convergence of the product on $\Re s>1$, and expand by geometric series to obtain
\begin{align*}
-\frac{L''}{L}(s,\chi)
  &= \sum_p \frac{\chi(p)\ln p\;p^{-s}}{1-\chi(p)p^{-s}} \\
  &= \sum_p\sum_{k\ge1}\chi(p^k)\ln p\;p^{-ks}
   = \sum_{n\ge1}\frac{\chi(n)\Lambda(n)}{n^s}.
\end{align*}
Absolute convergence follows from $\Lambda(n)\le\ln n$.', NULL, 'ai_generated', 'gpt', 'Codex', 1, '2026-11-25 16:30:00', '2026-11-25 16:30:00', 'codex', 'codex');
INSERT INTO proofs (id, result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail, revision, created_at, updated_at, created_by, updated_by) VALUES
  (129, 151, 1, 'By absolute convergence of the \hyperref[8JUS]{logarithmic derivative series}, we may integrate $\Psi_\chi(x)=\sum_n\chi(n)\Lambda(n)\mathbf 1_{n\le x}$ term by term. Using $\int_n^\infty x^{-s-1}\,dx=n^{-s}/s$ and \ref{8JUS} gives
\[ \int_1^\infty \Psi_\chi(x)\,x^{-s-1}\,dx = \frac1s\sum_{n\ge1}\frac{\chi(n)\Lambda(n)}{n^s} = -\frac1s\,\frac{L''}{L}(s,\chi). \]', NULL, 'ai_generated', 'gpt', 'Codex', 1, '2026-11-25 16:30:00', '2026-11-25 16:30:00', 'codex', 'codex');
INSERT INTO proofs (id, result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail, revision, created_at, updated_at, created_by, updated_by) VALUES
  (130, 152, 1, 'This is Dirichlet''s theorem \cite{Davenport}.', NULL, 'ai_generated', 'gpt', 'Codex', 1, '2026-11-25 16:30:00', '2026-11-25 16:30:00', 'codex', 'codex');

UPDATE sections SET intro_tex = 'The zeros of $L(s,\chi)$ are poles of its logarithmic derivative, a Dirichlet series over prime powers. The \hyperref[8JF7]{smoothed prime sum} $G_\chi$ turns this series into a function of $x$ whose \hyperref[8JS2]{Mellin transform} recovers these poles, the starting point of \ref{7HM3}.

\textbf{The von Mangoldt function.} For $\Re s>1$, the Euler factor $L_p(s,\chi)=(1-\chi(p)p^{-s})^{-1}$ of the \hyperref[8JC4]{Dirichlet $L$-function} satisfies
\begin{align*}
-\frac{L_p''}{L_p}(s,\chi)
  &= \frac{\chi(p)\ln p\;p^{-s}}{1-\chi(p)p^{-s}} \\
  &= \sum_{k\ge1}\chi(p^k)\ln p\;p^{-ks}.
\end{align*}
The \hyperref[8JUR]{von Mangoldt function} assigns weight $\Lambda(p^k)=\ln p$ to every $p^k$. Summing over $p$ gives $-\frac{L''}{L}(s,\chi)=\sum_{n\ge1}\chi(n)\Lambda(n)n^{-s}$ (\ref{8JUS}). An order-$m$ zero gives a simple pole of residue $-m$, and a principal character gives one of residue $1$ at $s=1$. Thus the coefficients encode the zeros.

\textbf{The Chebyshev function and its Mellin transform.} The \hyperref[8JUT]{generalized Chebyshev function} $\Psi_\chi(x)=\sum_{n\le x}\chi(n)\Lambda(n)$ reduces to Chebyshev''s $\psi(x)$ for $\chi=\mathbf 1$. We write $\Psi_\chi$ for the classical $\psi(x,\chi)$ to reserve $\psi$ for characters. Its \hyperref[8JS2]{Mellin transform} is (\ref{8JUU})
\[ \int_1^\infty \Psi_\chi(x)\,x^{-s-1}\,dx = -\frac1s\,\frac{L''}{L}(s,\chi) \qquad (\Re s>1). \]
The continuation has poles at the zeros of $L(s,\chi)$, as used in \ref{7HM3}.

\textbf{Why smooth.} $\Psi_\chi$ jumps at prime powers, so its transform is not absolutely integrable on $\Re s=c>1$: otherwise Mellin inversion would make $\Psi_\chi$ continuous. Integrating once removes the jumps. For $x\ge1$,
\[ R_\chi(x) = \sum_{n\ge1}\chi(n)\Lambda(n)\Bigl(\frac xn-1\Bigr)_+ = x\int_1^x \Psi_\chi(t)\,\frac{dt}{t^2}, \]
since $\int_n^x t^{-2}\,dt=1/n-1/x$ for $n\le x$. For $\Re s>1$, reversing the order of integration gives
\begin{align*}
\int_1^\infty R_\chi(x)\,x^{-s-1}\,dx
  &= \frac{1}{s-1}\int_1^\infty \Psi_\chi(t)\,t^{-s-1}\,dt \\
  &= -\frac{L''}{L}(s,\chi)\,\frac{1}{s(s-1)}.
\end{align*}
The extra factor $1/(s-1)$ gives $O(|s|^{-2})$ decay on $\Re s=c>1$ and absolute convergence in Mellin inversion. Shifting left gives summable terms $-m\,x^\rho/(\rho(\rho-1))$ from order-$m$ nontrivial zeros $\rho$ (the explicit formula for $\zeta$ is in \ref{8JTA}). The weight $(x/n-1)_+$ also arises from the arithmetic of Chapter 2 (\ref{8JU4}).

\textbf{The main term.} For primitive $\chi$, the residue of $-\frac{L''}{L}(s,\chi)\frac{x^s}{s(s-1)}$ at $s=1$ gives the main term of \ref{8JS3},
\begin{align*}
M_{\mathbf 1}(x) &= x\ln x-(1+\gamma)x, \\
M_\chi(x) &= -x\,\frac{L''}{L}(1,\chi) \qquad (\chi\ne\mathbf 1).
\end{align*}
The first formula uses $-\frac{\zeta''}{\zeta}(s)=\frac1{s-1}-\gamma+O(s-1)$. The \hyperref[8JF7]{smoothed prime sum} $G_\chi=R_\chi-M_\chi$ has Mellin transform regular at $s=1$, with poles exactly at the zeros of $L(s,\chi)$ in $\Re s>0$ (\ref{8JN4}).',
  intro_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 16:30:00', updated_by = 'codex' WHERE id = 102;

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at) VALUES
  ('section', '102', 1, 'motivate-smoothed-prime-sum-2026-11-25', '{"tag":"7HE6","kind":"section","title":"Smoothed prime sums","intro_tex":"","parent_id":100,"position":2}', 'codex', '2026-11-25 16:30:00');
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at) VALUES
  ('section', '102', 2, 'motivate-smoothed-prime-sum-2026-11-25', '{"tag":"7HE6","kind":"section","title":"Smoothed prime sums","intro_tex":"The zeros of $L(s,\\chi)$ are poles of its logarithmic derivative, a Dirichlet series over prime powers. The \\hyperref[8JF7]{smoothed prime sum} $G_\\chi$ turns this series into a function of $x$ whose \\hyperref[8JS2]{Mellin transform} recovers these poles, the starting point of \\ref{7HM3}.\n\n\\textbf{The von Mangoldt function.} For $\\Re s>1$, the Euler factor $L_p(s,\\chi)=(1-\\chi(p)p^{-s})^{-1}$ of the \\hyperref[8JC4]{Dirichlet $L$-function} satisfies\n\\begin{align*}\n-\\frac{L_p''}{L_p}(s,\\chi)\n  &= \\frac{\\chi(p)\\ln p\\;p^{-s}}{1-\\chi(p)p^{-s}} \\\\\n  &= \\sum_{k\\ge1}\\chi(p^k)\\ln p\\;p^{-ks}.\n\\end{align*}\nThe \\hyperref[8JUR]{von Mangoldt function} assigns weight $\\Lambda(p^k)=\\ln p$ to every $p^k$. Summing over $p$ gives $-\\frac{L''}{L}(s,\\chi)=\\sum_{n\\ge1}\\chi(n)\\Lambda(n)n^{-s}$ (\\ref{8JUS}). An order-$m$ zero gives a simple pole of residue $-m$, and a principal character gives one of residue $1$ at $s=1$. Thus the coefficients encode the zeros.\n\n\\textbf{The Chebyshev function and its Mellin transform.} The \\hyperref[8JUT]{generalized Chebyshev function} $\\Psi_\\chi(x)=\\sum_{n\\le x}\\chi(n)\\Lambda(n)$ reduces to Chebyshev''s $\\psi(x)$ for $\\chi=\\mathbf 1$. We write $\\Psi_\\chi$ for the classical $\\psi(x,\\chi)$ to reserve $\\psi$ for characters. Its \\hyperref[8JS2]{Mellin transform} is (\\ref{8JUU})\n\\[ \\int_1^\\infty \\Psi_\\chi(x)\\,x^{-s-1}\\,dx = -\\frac1s\\,\\frac{L''}{L}(s,\\chi) \\qquad (\\Re s>1). \\]\nThe continuation has poles at the zeros of $L(s,\\chi)$, as used in \\ref{7HM3}.\n\n\\textbf{Why smooth.} $\\Psi_\\chi$ jumps at prime powers, so its transform is not absolutely integrable on $\\Re s=c>1$: otherwise Mellin inversion would make $\\Psi_\\chi$ continuous. Integrating once removes the jumps. For $x\\ge1$,\n\\[ R_\\chi(x) = \\sum_{n\\ge1}\\chi(n)\\Lambda(n)\\Bigl(\\frac xn-1\\Bigr)_+ = x\\int_1^x \\Psi_\\chi(t)\\,\\frac{dt}{t^2}, \\]\nsince $\\int_n^x t^{-2}\\,dt=1/n-1/x$ for $n\\le x$. For $\\Re s>1$, reversing the order of integration gives\n\\begin{align*}\n\\int_1^\\infty R_\\chi(x)\\,x^{-s-1}\\,dx\n  &= \\frac{1}{s-1}\\int_1^\\infty \\Psi_\\chi(t)\\,t^{-s-1}\\,dt \\\\\n  &= -\\frac{L''}{L}(s,\\chi)\\,\\frac{1}{s(s-1)}.\n\\end{align*}\nThe extra factor $1/(s-1)$ gives $O(|s|^{-2})$ decay on $\\Re s=c>1$ and absolute convergence in Mellin inversion. Shifting left gives summable terms $-m\\,x^\\rho/(\\rho(\\rho-1))$ from order-$m$ nontrivial zeros $\\rho$ (the explicit formula for $\\zeta$ is in \\ref{8JTA}). The weight $(x/n-1)_+$ also arises from the arithmetic of Chapter 2 (\\ref{8JU4}).\n\n\\textbf{The main term.} For primitive $\\chi$, the residue of $-\\frac{L''}{L}(s,\\chi)\\frac{x^s}{s(s-1)}$ at $s=1$ gives the main term of \\ref{8JS3},\n\\begin{align*}\nM_{\\mathbf 1}(x) &= x\\ln x-(1+\\gamma)x, \\\\\nM_\\chi(x) &= -x\\,\\frac{L''}{L}(1,\\chi) \\qquad (\\chi\\ne\\mathbf 1).\n\\end{align*}\nThe first formula uses $-\\frac{\\zeta''}{\\zeta}(s)=\\frac1{s-1}-\\gamma+O(s-1)$. The \\hyperref[8JF7]{smoothed prime sum} $G_\\chi=R_\\chi-M_\\chi$ has Mellin transform regular at $s=1$, with poles exactly at the zeros of $L(s,\\chi)$ in $\\Re s>0$ (\\ref{8JN4}).","parent_id":100,"position":2}', 'codex', '2026-11-25 16:30:00');
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at) VALUES
  ('result', '106', 3, 'motivate-smoothed-prime-sum-2026-11-25', '{"tag":"8JF7","type":"definition","title":"Smoothed prime sum","statement_tex":"Let $\\Lambda$ be the \\hyperref[8JUR]{von Mangoldt function} and $\\gamma$ Euler''s constant. For a \\hyperref[8JH4]{primitive character} $\\chi$ and real $x \\ge 1$ put\n\\[ R_\\chi(x) = \\sum_{n \\ge 1} \\chi(n)\\Lambda(n)\\Bigl(\\frac{x}{n} - 1\\Bigr)_+, \\qquad v_+ = \\max(v, 0), \\]\nand\n\\[ G_\\chi(x) = \\begin{cases} R_{\\mathbf 1}(x) - x\\ln x + (1+\\gamma)x, & \\chi = \\mathbf 1, \\\\[4pt] R_\\chi(x) + x\\,\\dfrac{L''(1,\\chi)}{L(1,\\chi)}, & \\chi \\ne \\mathbf 1. \\end{cases} \\]\nHere \\hyperref[8JUV]{$L(1,\\chi) \\ne 0$} for $\\chi \\ne \\mathbf 1$.","section_id":102,"position":5,"listed":1,"aliases":["smoothed-prime-sum"]}', 'codex', '2026-11-25 16:30:00');
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at) VALUES
  ('result', '148', 1, 'motivate-smoothed-prime-sum-2026-11-25', '{"tag":"8JUR","type":"definition","title":"von Mangoldt function","statement_tex":"For integers $n\\ge1$, the \\emph{von Mangoldt function} is\n\\[ \\Lambda(n) = \\begin{cases}\n\\ln p, & n = p^k \\text{ for a prime } p \\text{ and an integer } k\\ge1, \\\\\n0, & \\text{otherwise}.\n\\end{cases} \\]","section_id":102,"position":1,"listed":1,"aliases":["von-mangoldt-function"]}', 'codex', '2026-11-25 16:30:00');
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at) VALUES
  ('result', '149', 1, 'motivate-smoothed-prime-sum-2026-11-25', '{"tag":"8JUS","type":"lemma","title":"Logarithmic derivative of $L(s,\\chi)$","statement_tex":"Let $\\chi$ be a \\hyperref[8JA9]{Dirichlet character} and $\\Lambda$ the \\hyperref[8JUR]{von Mangoldt function}. For every $s\\in\\C$ with $\\Re s>1$,\n\\[ -\\frac{L''}{L}(s,\\chi) = \\sum_{n\\ge1}\\frac{\\chi(n)\\Lambda(n)}{n^s}, \\]\nand the series converges absolutely.","section_id":102,"position":2,"listed":1,"aliases":["log-derivative-l-function"]}', 'codex', '2026-11-25 16:30:00');
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at) VALUES
  ('result', '150', 1, 'motivate-smoothed-prime-sum-2026-11-25', '{"tag":"8JUT","type":"definition","title":"Generalized Chebyshev function","statement_tex":"Let $\\chi$ be a \\hyperref[8JA9]{Dirichlet character}. The \\emph{generalized Chebyshev function} of $\\chi$ is\n\\[ \\Psi_\\chi(x) = \\sum_{n\\le x}\\chi(n)\\Lambda(n) \\qquad (x\\ge1), \\]\nwhere $\\Lambda$ is the \\hyperref[8JUR]{von Mangoldt function}.","section_id":102,"position":3,"listed":1,"aliases":["chebyshev-function"]}', 'codex', '2026-11-25 16:30:00');
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at) VALUES
  ('result', '151', 1, 'motivate-smoothed-prime-sum-2026-11-25', '{"tag":"8JUU","type":"lemma","title":"Mellin transform of the Chebyshev function","statement_tex":"Let $\\chi$ be a \\hyperref[8JA9]{Dirichlet character} and $\\Psi_\\chi$ its \\hyperref[8JUT]{generalized Chebyshev function}. For every $s\\in\\C$ with $\\Re s>1$,\n\\[ \\int_1^\\infty \\Psi_\\chi(x)\\,x^{-s-1}\\,dx = -\\frac1s\\,\\frac{L''}{L}(s,\\chi). \\]","section_id":102,"position":4,"listed":1,"aliases":["chebyshev-mellin-transform"]}', 'codex', '2026-11-25 16:30:00');
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at) VALUES
  ('result', '152', 1, 'motivate-smoothed-prime-sum-2026-11-25', '{"tag":"8JUV","type":"lemma","title":"Non-vanishing of $L(1,\\chi)$","statement_tex":"Let $\\chi \\ne \\mathbf 1$ be a \\hyperref[8JH4]{primitive character}. Then $L(1,\\chi)\\ne0$.","section_id":102,"position":10,"listed":0,"aliases":["l-at-one-nonzero"]}', 'codex', '2026-11-25 16:30:00');
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at) VALUES
  ('proof', '106', 5, 'motivate-smoothed-prime-sum-2026-11-25', '{"result_id":119,"position":1,"body_tex":"\\emph{(i)} Since\n\\[ \\int_n^\\infty \\Bigl(\\frac xn - 1\\Bigr) x^{-s-1}\\,dx = \\frac{n^{-s}}{s(s-1)} \\]\nand the series of the \\hyperref[8JUS]{logarithmic derivative} converges absolutely, we may integrate term by term:\n\\[ \\int_1^\\infty R_\\chi(x)\\, x^{-s-1}\\,dx = \\frac{1}{s(s-1)} \\sum_{n \\ge 1} \\Lambda(n)\\chi(n)\\, n^{-s} = -\\frac{L''}{L}(s,\\chi)\\,\\frac{1}{s(s-1)}. \\]\nThe remaining terms come from $\\int_1^\\infty x \\cdot x^{-s-1}\\,dx = \\frac1{s-1}$ and $\\int_1^\\infty x\\ln x \\cdot x^{-s-1}\\,dx = \\frac1{(s-1)^2}$.\n\n\\emph{(ii)} Since \\hyperref[8JS5]{$\\overline{L(\\bar s,\\chi)} = L(s,\\bar\\chi)$}, we have $\\overline{G_\\chi} = G_{\\bar\\chi}$, so $\\Re G_\\chi = \\frac12(G_\\chi + G_{\\bar\\chi})$. Now use the linearity of $\\mathcal M$.","status":"ai_generated","generated_by":"claude","generator_detail":"claude-opus-5-5","reviewed_by":null,"review_notes":null}', 'codex', '2026-11-25 16:30:00');
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at) VALUES
  ('proof', '128', 1, 'motivate-smoothed-prime-sum-2026-11-25', '{"result_id":149,"position":1,"body_tex":"Take logarithmic derivatives of the Euler factors, using local uniform convergence of the product on $\\Re s>1$, and expand by geometric series to obtain\n\\begin{align*}\n-\\frac{L''}{L}(s,\\chi)\n  &= \\sum_p \\frac{\\chi(p)\\ln p\\;p^{-s}}{1-\\chi(p)p^{-s}} \\\\\n  &= \\sum_p\\sum_{k\\ge1}\\chi(p^k)\\ln p\\;p^{-ks}\n   = \\sum_{n\\ge1}\\frac{\\chi(n)\\Lambda(n)}{n^s}.\n\\end{align*}\nAbsolute convergence follows from $\\Lambda(n)\\le\\ln n$.","status":"ai_generated","generated_by":"gpt","generator_detail":"Codex","reviewed_by":null,"review_notes":null}', 'codex', '2026-11-25 16:30:00');
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at) VALUES
  ('proof', '129', 1, 'motivate-smoothed-prime-sum-2026-11-25', '{"result_id":151,"position":1,"body_tex":"By absolute convergence of the \\hyperref[8JUS]{logarithmic derivative series}, we may integrate $\\Psi_\\chi(x)=\\sum_n\\chi(n)\\Lambda(n)\\mathbf 1_{n\\le x}$ term by term. Using $\\int_n^\\infty x^{-s-1}\\,dx=n^{-s}/s$ and \\ref{8JUS} gives\n\\[ \\int_1^\\infty \\Psi_\\chi(x)\\,x^{-s-1}\\,dx = \\frac1s\\sum_{n\\ge1}\\frac{\\chi(n)\\Lambda(n)}{n^s} = -\\frac1s\\,\\frac{L''}{L}(s,\\chi). \\]","status":"ai_generated","generated_by":"gpt","generator_detail":"Codex","reviewed_by":null,"review_notes":null}', 'codex', '2026-11-25 16:30:00');
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at) VALUES
  ('proof', '130', 1, 'motivate-smoothed-prime-sum-2026-11-25', '{"result_id":152,"position":1,"body_tex":"This is Dirichlet''s theorem \\cite{Davenport}.","status":"ai_generated","generated_by":"gpt","generator_detail":"Codex","reviewed_by":null,"review_notes":null}', 'codex', '2026-11-25 16:30:00');

DELETE FROM refs WHERE source_result_id = 106 AND source_proof_id IS NULL;
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (106, NULL, '8JUR');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (106, NULL, '8JH4');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (106, NULL, '8JUV');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (149, NULL, '8JA9');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (149, NULL, '8JUR');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (150, NULL, '8JA9');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (150, NULL, '8JUR');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (151, NULL, '8JA9');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (151, NULL, '8JUT');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (152, NULL, '8JH4');
DELETE FROM refs WHERE source_proof_id = 106;
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (119, 106, '8JUS');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (119, 106, '8JS5');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (151, 129, '8JUS');

