INSERT INTO write_guard (ok) SELECT 0 WHERE NOT EXISTS (SELECT 1 FROM results WHERE id = 119 AND revision = 1);
UPDATE results SET statement_tex = 'Let $\chi$ be a primitive character, $H_\chi$ as in \hyperref[8JS4]{the definition}, and $b_\chi = L''(1,\chi)/L(1,\chi)$ for $\chi \ne \mathbf 1$.
\begin{enumerate}
\item[(i)] For $\Re s > 1$,
\begin{align*}
H_\chi(s) &= -\frac{L''}{L}(s,\chi)\frac{1}{s(s-1)} + \frac{b_\chi}{s-1} \qquad (\chi \ne \mathbf 1), \\
H_{\mathbf 1}(s) &= -\frac{\zeta''}{\zeta}(s)\frac{1}{s(s-1)} - \frac{1}{(s-1)^2} + \frac{1+\gamma}{s-1}.
\end{align*}
\item[(ii)] $H_\chi$ extends meromorphically to $\Re s > 0$. Its poles there are exactly the zeros $\rho$ of $L(s,\chi)$ with $\Re\rho > 0$; each is simple, with
\[ \operatorname{Res}_{s=\rho} H_\chi = -\frac{m_\chi(\rho)}{\rho(\rho-1)}. \]
\end{enumerate}', statement_html_cache = NULL, revision = 2, updated_at = '2026-11-24 14:25:00', updated_by = 'claude' WHERE id = 119;
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author) VALUES ('result', '119', 2, 'stack-8JS6-2026-11-24', '{"tag":"8JS6","type":"lemma","title":"Mellin transform of a smoothed prime sum","statement_tex":"Let $\\chi$ be a primitive character, $H_\\chi$ as in \\hyperref[8JS4]{the definition}, and $b_\\chi = L''(1,\\chi)/L(1,\\chi)$ for $\\chi \\ne \\mathbf 1$.\n\\begin{enumerate}\n\\item[(i)] For $\\Re s > 1$,\n\\begin{align*}\nH_\\chi(s) &= -\\frac{L''}{L}(s,\\chi)\\frac{1}{s(s-1)} + \\frac{b_\\chi}{s-1} \\qquad (\\chi \\ne \\mathbf 1), \\\\\nH_{\\mathbf 1}(s) &= -\\frac{\\zeta''}{\\zeta}(s)\\frac{1}{s(s-1)} - \\frac{1}{(s-1)^2} + \\frac{1+\\gamma}{s-1}.\n\\end{align*}\n\\item[(ii)] $H_\\chi$ extends meromorphically to $\\Re s > 0$. Its poles there are exactly the zeros $\\rho$ of $L(s,\\chi)$ with $\\Re\\rho > 0$; each is simple, with\n\\[ \\operatorname{Res}_{s=\\rho} H_\\chi = -\\frac{m_\\chi(\\rho)}{\\rho(\\rho-1)}. \\]\n\\end{enumerate}","section_id":104,"position":4,"listed":1,"aliases":["mellin-smoothed-sum"]}', 'claude');
