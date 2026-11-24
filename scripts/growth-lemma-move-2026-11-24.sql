-- Move lemma 8JS3 after definition 8JF7 (section 102) and split it into parts (2026-11-24 12:00:00).
INSERT INTO write_guard (ok) SELECT 0 WHERE NOT EXISTS (SELECT 1 FROM results WHERE id = 116 AND revision = 1 AND section_id = 104);
INSERT INTO write_guard (ok) SELECT 0 WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE id = 104 AND revision = 1);
UPDATE results SET title = 'Growth of the smoothed prime sums', statement_tex = 'Let $\chi$ be a \hyperref[8JH4]{primitive character}, let $R_\chi$ and $G_\chi$ be as in the \hyperref[8JF7]{definition of the smoothed prime sum}, let
\[ M_\chi(x) = R_\chi(x) - G_\chi(x) = \begin{cases} x\log x - (1+\gamma)x, & \chi = \mathbf 1, \\[4pt] -x\,\dfrac{L''(1,\chi)}{L(1,\chi)}, & \chi \ne \mathbf 1, \end{cases} \]
be the main term, and let $c_{\mathbf 1} = 1+\gamma$ and $c_\chi = \bigl|L''(1,\chi)/L(1,\chi)\bigr|$ for $\chi \ne \mathbf 1$.
\begin{enumerate}
\item[(i)] $R_\chi$ is continuous on $[1,\infty)$, and $|R_\chi(x)| \le x\log x\,(1+\log x)$ for $x \ge 1$.
\item[(ii)] $|M_\chi(x)| \le c_\chi\, x\,(1+\log x)$ for $x \ge 1$.
\item[(iii)] $G_\chi$ is continuous on $[1,\infty)$, and $|G_\chi(x)| \le (1+c_\chi)\, x\,(1+\log x)^2$ for $x \ge 1$. In particular $G_\chi(x) = O_\varepsilon(x^{1+\varepsilon})$ for every $\varepsilon > 0$.
\end{enumerate}', statement_html_cache = NULL, section_id = 102, position = 2, revision = revision + 1, updated_at = '2026-11-24 12:00:00', updated_by = 'claude' WHERE id = 116;
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author) VALUES ('result', '116', 2, 'growth-lemma-move-2026-11-24', '{"tag":"8JS3","type":"lemma","title":"Growth of the smoothed prime sums","statement_tex":"Let $\\chi$ be a \\hyperref[8JH4]{primitive character}, let $R_\\chi$ and $G_\\chi$ be as in the \\hyperref[8JF7]{definition of the smoothed prime sum}, let\n\\[ M_\\chi(x) = R_\\chi(x) - G_\\chi(x) = \\begin{cases} x\\log x - (1+\\gamma)x, & \\chi = \\mathbf 1, \\\\[4pt] -x\\,\\dfrac{L''(1,\\chi)}{L(1,\\chi)}, & \\chi \\ne \\mathbf 1, \\end{cases} \\]\nbe the main term, and let $c_{\\mathbf 1} = 1+\\gamma$ and $c_\\chi = \\bigl|L''(1,\\chi)/L(1,\\chi)\\bigr|$ for $\\chi \\ne \\mathbf 1$.\n\\begin{enumerate}\n\\item[(i)] $R_\\chi$ is continuous on $[1,\\infty)$, and $|R_\\chi(x)| \\le x\\log x\\,(1+\\log x)$ for $x \\ge 1$.\n\\item[(ii)] $|M_\\chi(x)| \\le c_\\chi\\, x\\,(1+\\log x)$ for $x \\ge 1$.\n\\item[(iii)] $G_\\chi$ is continuous on $[1,\\infty)$, and $|G_\\chi(x)| \\le (1+c_\\chi)\\, x\\,(1+\\log x)^2$ for $x \\ge 1$. In particular $G_\\chi(x) = O_\\varepsilon(x^{1+\\varepsilon})$ for every $\\varepsilon > 0$.\n\\end{enumerate}","section_id":102,"position":2,"listed":1,"aliases":["smoothed-sum-growth"]}', 'claude');
UPDATE proofs SET body_tex = '\emph{(i)} Fix $X \ge 1$. For $1 \le x \le X$ only the terms with $n \le X$ contribute to $R_\chi(x)$, so on $[1, X]$ the function $R_\chi$ is a finite sum of the continuous functions $x \mapsto \Lambda(n)\chi(n)\bigl(\frac xn - 1\bigr)_+$. Hence $R_\chi$ is continuous. For the bound, only the terms with $n \le x$ contribute to $R_\chi(x)$, and for them $0 \le \bigl(\frac xn - 1\bigr)_+ \le \frac xn$, $|\chi(n)| \le 1$ and $0 \le \Lambda(n) \le \log n \le \log x$. Using $\sum_{n \le x} \frac1n \le 1 + \int_1^x \frac{dt}{t} = 1 + \log x$,
\[ |R_\chi(x)| \le x \log x \sum_{n \le x} \frac1n \le x \log x\,(1 + \log x). \]

\emph{(ii)} For $\chi \ne \mathbf 1$, $|M_\chi(x)| = c_\chi x \le c_\chi x(1 + \log x)$. For $\chi = \mathbf 1$, since $1 + \gamma \ge 1$,
\[ |M_{\mathbf 1}(x)| \le x\log x + (1+\gamma)x \le (1+\gamma)\, x\,(1 + \log x). \]

\emph{(iii)} We have $G_\chi = R_\chi - M_\chi$, and $M_\chi$ is continuous, so $G_\chi$ is continuous by (i). By (i) and (ii), using $\log x \le 1 + \log x$ and $1 \le 1 + \log x$,
\[ |G_\chi(x)| \le x\log x\,(1+\log x) + c_\chi\, x\,(1+\log x) \le (1 + c_\chi)\, x\,(1+\log x)^2. \]
Finally $(1+\log x)^2 = O_\varepsilon(x^\varepsilon)$ for every $\varepsilon > 0$, which gives the last claim.', body_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-24 12:00:00', updated_by = 'claude' WHERE id = 104;
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author) VALUES ('proof', '104', 2, 'growth-lemma-move-2026-11-24', '{"result_id":116,"body_tex":"\\emph{(i)} Fix $X \\ge 1$. For $1 \\le x \\le X$ only the terms with $n \\le X$ contribute to $R_\\chi(x)$, so on $[1, X]$ the function $R_\\chi$ is a finite sum of the continuous functions $x \\mapsto \\Lambda(n)\\chi(n)\\bigl(\\frac xn - 1\\bigr)_+$. Hence $R_\\chi$ is continuous. For the bound, only the terms with $n \\le x$ contribute to $R_\\chi(x)$, and for them $0 \\le \\bigl(\\frac xn - 1\\bigr)_+ \\le \\frac xn$, $|\\chi(n)| \\le 1$ and $0 \\le \\Lambda(n) \\le \\log n \\le \\log x$. Using $\\sum_{n \\le x} \\frac1n \\le 1 + \\int_1^x \\frac{dt}{t} = 1 + \\log x$,\n\\[ |R_\\chi(x)| \\le x \\log x \\sum_{n \\le x} \\frac1n \\le x \\log x\\,(1 + \\log x). \\]\n\n\\emph{(ii)} For $\\chi \\ne \\mathbf 1$, $|M_\\chi(x)| = c_\\chi x \\le c_\\chi x(1 + \\log x)$. For $\\chi = \\mathbf 1$, since $1 + \\gamma \\ge 1$,\n\\[ |M_{\\mathbf 1}(x)| \\le x\\log x + (1+\\gamma)x \\le (1+\\gamma)\\, x\\,(1 + \\log x). \\]\n\n\\emph{(iii)} We have $G_\\chi = R_\\chi - M_\\chi$, and $M_\\chi$ is continuous, so $G_\\chi$ is continuous by (i). By (i) and (ii), using $\\log x \\le 1 + \\log x$ and $1 \\le 1 + \\log x$,\n\\[ |G_\\chi(x)| \\le x\\log x\\,(1+\\log x) + c_\\chi\\, x\\,(1+\\log x) \\le (1 + c_\\chi)\\, x\\,(1+\\log x)^2. \\]\nFinally $(1+\\log x)^2 = O_\\varepsilon(x^\\varepsilon)$ for every $\\varepsilon > 0$, which gives the last claim.","status":"ai_generated","generated_by":"claude","generator_detail":"claude-opus-5-5","reviewed_by":null,"review_notes":null,"position":1}', 'claude');
DELETE FROM refs WHERE source_result_id = 116;
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (116, NULL, '8JH4');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (116, NULL, '8JF7');
UPDATE results SET position = 3 WHERE id = 107 AND section_id = 102;
UPDATE results SET position = 4 WHERE id = 108 AND section_id = 102;
UPDATE results SET position = 5 WHERE id = 109 AND section_id = 102;
UPDATE results SET position = 2 WHERE id = 117 AND section_id = 104;
UPDATE results SET position = 3 WHERE id = 118 AND section_id = 104;
UPDATE results SET position = 4 WHERE id = 119 AND section_id = 104;
UPDATE results SET position = 5 WHERE id = 111 AND section_id = 104;
UPDATE results SET position = 6 WHERE id = 120 AND section_id = 104;
UPDATE results SET position = 7 WHERE id = 112 AND section_id = 104;
UPDATE results SET position = 8 WHERE id = 113 AND section_id = 104;
UPDATE results SET position = 9 WHERE id = 114 AND section_id = 104;
UPDATE results SET position = 10 WHERE id = 121 AND section_id = 104;
