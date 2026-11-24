-- Restructure section 1.4 (2026-11-24 16:00:00).
INSERT INTO write_guard (ok) SELECT 0 WHERE NOT EXISTS (SELECT 1 FROM results WHERE id = 111 AND revision = 4);
INSERT INTO write_guard (ok) SELECT 0 WHERE NOT EXISTS (SELECT 1 FROM results WHERE id = 117 AND revision = 4);
INSERT INTO write_guard (ok) SELECT 0 WHERE NOT EXISTS (SELECT 1 FROM results WHERE id = 118 AND revision = 2);
INSERT INTO write_guard (ok) SELECT 0 WHERE NOT EXISTS (SELECT 1 FROM results WHERE id = 119 AND revision = 2);
INSERT INTO write_guard (ok) SELECT 0 WHERE NOT EXISTS (SELECT 1 FROM results WHERE id = 120 AND revision = 2);
INSERT INTO write_guard (ok) SELECT 0 WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE id = 101 AND revision = 5);
INSERT INTO write_guard (ok) SELECT 0 WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE id = 106 AND revision = 2);
INSERT INTO write_guard (ok) SELECT 0 WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE id = 107 AND revision = 4);
UPDATE results SET type = 'lemma', title = 'Poles of $H_\chi$ and $\mathcal H_\psi$', statement_tex = 'Let $\chi$ and $\psi$ be primitive characters, let $H_\chi$ and $\mathcal H_\psi$ be the \hyperref[8JS6]{Mellin transforms of the smoothed prime sums}, and let $m_\chi$, $Z$ and $S_\rho$ be as in the \hyperref[8JS4]{definition of the zero set}.
\begin{enumerate}
\item[(i)] $H_\chi$ extends meromorphically to $\Re s > 0$. Its poles there are exactly the zeros $\rho$ of $L(s,\chi)$ with $\Re\rho > 0$; each is simple, with
\[ \operatorname{Res}_{s=\rho} H_\chi = -\frac{m_\chi(\rho)}{\rho(\rho-1)}. \]
\item[(ii)] $\mathcal H_\psi$ extends meromorphically to $\Re s > 0$. Its poles there are exactly the points of $Z$; each is simple, with
\[ \operatorname{Res}_{s=\rho} \mathcal H_\psi = -\frac{S_\rho}{\rho(\rho-1)}. \]
\end{enumerate}', statement_html_cache = NULL, position = 4, listed = 1, revision = revision + 1, updated_at = '2026-11-24 16:00:00', updated_by = 'claude' WHERE id = 111;
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author) VALUES ('result', '111', 5, 'restructure-1.4-2026-11-24', '{"tag":"8JN4","type":"lemma","title":"Poles of $H_\\chi$ and $\\mathcal H_\\psi$","statement_tex":"Let $\\chi$ and $\\psi$ be primitive characters, let $H_\\chi$ and $\\mathcal H_\\psi$ be the \\hyperref[8JS6]{Mellin transforms of the smoothed prime sums}, and let $m_\\chi$, $Z$ and $S_\\rho$ be as in the \\hyperref[8JS4]{definition of the zero set}.\n\\begin{enumerate}\n\\item[(i)] $H_\\chi$ extends meromorphically to $\\Re s > 0$. Its poles there are exactly the zeros $\\rho$ of $L(s,\\chi)$ with $\\Re\\rho > 0$; each is simple, with\n\\[ \\operatorname{Res}_{s=\\rho} H_\\chi = -\\frac{m_\\chi(\\rho)}{\\rho(\\rho-1)}. \\]\n\\item[(ii)] $\\mathcal H_\\psi$ extends meromorphically to $\\Re s > 0$. Its poles there are exactly the points of $Z$; each is simple, with\n\\[ \\operatorname{Res}_{s=\\rho} \\mathcal H_\\psi = -\\frac{S_\\rho}{\\rho(\\rho-1)}. \\]\n\\end{enumerate}","section_id":104,"position":4,"listed":1,"aliases":["mellin-poles"]}', 'claude');
DELETE FROM refs WHERE source_result_id = 111 AND source_proof_id IS NULL;
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (111, NULL, '8JS6');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (111, NULL, '8JS4');
UPDATE results SET type = 'definition', title = 'The zero set of the family', statement_tex = 'Let $\psi$ be a \hyperref[8JH4]{primitive character} with \hyperref[8JG8]{cyclic family} $\mathcal C_\psi$ and weights $a_\chi$. For a primitive character $\chi$ and $\rho \in \C$, let $m_\chi(\rho) \ge 0$ be the multiplicity of $\rho$ as a zero of $L(s,\chi)$, with $m_\chi(\rho) = 0$ if $\rho$ is not a zero. Put
\begin{align*}
Z &= \left\{ \rho \in \C \;\middle|\; \Re\rho > 0,\ L(\rho, \chi) = 0 \text{ for some } \chi \in \mathcal C_\psi \right\}, \\
S_\rho &= \frac12 \sum_{\chi \in \mathcal C_\psi} a_\chi \bigl(m_\chi(\rho) + m_{\bar\chi}(\rho)\bigr) \qquad (\rho \in \C).
\end{align*}', statement_html_cache = NULL, position = 3, listed = 1, revision = revision + 1, updated_at = '2026-11-24 16:00:00', updated_by = 'claude' WHERE id = 117;
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author) VALUES ('result', '117', 5, 'restructure-1.4-2026-11-24', '{"tag":"8JS4","type":"definition","title":"The zero set of the family","statement_tex":"Let $\\psi$ be a \\hyperref[8JH4]{primitive character} with \\hyperref[8JG8]{cyclic family} $\\mathcal C_\\psi$ and weights $a_\\chi$. For a primitive character $\\chi$ and $\\rho \\in \\C$, let $m_\\chi(\\rho) \\ge 0$ be the multiplicity of $\\rho$ as a zero of $L(s,\\chi)$, with $m_\\chi(\\rho) = 0$ if $\\rho$ is not a zero. Put\n\\begin{align*}\nZ &= \\left\\{ \\rho \\in \\C \\;\\middle|\\; \\Re\\rho > 0,\\ L(\\rho, \\chi) = 0 \\text{ for some } \\chi \\in \\mathcal C_\\psi \\right\\}, \\\\\nS_\\rho &= \\frac12 \\sum_{\\chi \\in \\mathcal C_\\psi} a_\\chi \\bigl(m_\\chi(\\rho) + m_{\\bar\\chi}(\\rho)\\bigr) \\qquad (\\rho \\in \\C).\n\\end{align*}","section_id":104,"position":3,"listed":1,"aliases":["family-zero-set"]}', 'claude');
DELETE FROM refs WHERE source_result_id = 117 AND source_proof_id IS NULL;
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (117, NULL, '8JH4');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (117, NULL, '8JG8');
UPDATE results SET type = 'lemma', title = 'Conjugation and the zero set', statement_tex = 'Let $\psi$ be a primitive character, and let $\mathcal C_\psi$, $m_\chi$, $S_\rho$ and $Z$ be as in \hyperref[8JS4]{the definition}.
\begin{enumerate}
\item[(i)] For every primitive character $\chi$, $\overline{L(\bar s, \chi)} = L(s, \bar\chi)$ as meromorphic functions of $s \in \C$, and $m_{\bar\chi}(\bar\rho) = m_\chi(\rho)$ for every $\rho \in \C$.
\item[(ii)] $Z$ is locally finite and closed under complex conjugation.
\item[(iii)] $S_\rho > 0$ for every $\rho \in Z$.
\end{enumerate}', statement_html_cache = NULL, position = 9, listed = 0, revision = revision + 1, updated_at = '2026-11-24 16:00:00', updated_by = 'claude' WHERE id = 118;
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author) VALUES ('result', '118', 3, 'restructure-1.4-2026-11-24', '{"tag":"8JS5","type":"lemma","title":"Conjugation and the zero set","statement_tex":"Let $\\psi$ be a primitive character, and let $\\mathcal C_\\psi$, $m_\\chi$, $S_\\rho$ and $Z$ be as in \\hyperref[8JS4]{the definition}.\n\\begin{enumerate}\n\\item[(i)] For every primitive character $\\chi$, $\\overline{L(\\bar s, \\chi)} = L(s, \\bar\\chi)$ as meromorphic functions of $s \\in \\C$, and $m_{\\bar\\chi}(\\bar\\rho) = m_\\chi(\\rho)$ for every $\\rho \\in \\C$.\n\\item[(ii)] $Z$ is locally finite and closed under complex conjugation.\n\\item[(iii)] $S_\\rho > 0$ for every $\\rho \\in Z$.\n\\end{enumerate}","section_id":104,"position":9,"listed":0,"aliases":["zero-set-properties"]}', 'claude');
DELETE FROM refs WHERE source_result_id = 118 AND source_proof_id IS NULL;
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (118, NULL, '8JS4');
UPDATE results SET type = 'example', title = 'Mellin transforms of the smoothed prime sums', statement_tex = 'Let $\chi$ and $\psi$ be \hyperref[8JH4]{primitive characters}, let $\mathcal C_\psi$, $a_\chi$ and $\mathcal G_\psi$ be as in the \hyperref[8JG8]{definition of the cyclic family}, and let $b_\chi = L''(1,\chi)/L(1,\chi)$ for $\chi \ne \mathbf 1$. The \hyperref[8JS2]{Mellin transforms}
\[ H_\chi = \mathcal M G_\chi, \qquad \mathcal H_\psi = \mathcal M \mathcal G_\psi \]
of the \hyperref[8JF7]{smoothed prime sum} and of the weighted sum are \hyperref[8JS3]{defined for $\Re s > 1$}, and there:
\begin{enumerate}
\item[(i)] \begin{align*}
H_\chi(s) &= -\frac{L''}{L}(s,\chi)\frac{1}{s(s-1)} + \frac{b_\chi}{s-1} && (\chi \ne \mathbf 1), \\
H_{\mathbf 1}(s) &= -\frac{\zeta''}{\zeta}(s)\frac{1}{s(s-1)} - \frac{1}{(s-1)^2} + \frac{1+\gamma}{s-1}.
\end{align*}
\item[(ii)] \[ \mathcal H_\psi(s) = \frac12 \sum_{\chi \in \mathcal C_\psi} a_\chi \bigl(H_\chi(s) + H_{\bar\chi}(s)\bigr). \]
\end{enumerate}', statement_html_cache = NULL, position = 2, listed = 1, revision = revision + 1, updated_at = '2026-11-24 16:00:00', updated_by = 'claude' WHERE id = 119;
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author) VALUES ('result', '119', 3, 'restructure-1.4-2026-11-24', '{"tag":"8JS6","type":"example","title":"Mellin transforms of the smoothed prime sums","statement_tex":"Let $\\chi$ and $\\psi$ be \\hyperref[8JH4]{primitive characters}, let $\\mathcal C_\\psi$, $a_\\chi$ and $\\mathcal G_\\psi$ be as in the \\hyperref[8JG8]{definition of the cyclic family}, and let $b_\\chi = L''(1,\\chi)/L(1,\\chi)$ for $\\chi \\ne \\mathbf 1$. The \\hyperref[8JS2]{Mellin transforms}\n\\[ H_\\chi = \\mathcal M G_\\chi, \\qquad \\mathcal H_\\psi = \\mathcal M \\mathcal G_\\psi \\]\nof the \\hyperref[8JF7]{smoothed prime sum} and of the weighted sum are \\hyperref[8JS3]{defined for $\\Re s > 1$}, and there:\n\\begin{enumerate}\n\\item[(i)] \\begin{align*}\nH_\\chi(s) &= -\\frac{L''}{L}(s,\\chi)\\frac{1}{s(s-1)} + \\frac{b_\\chi}{s-1} && (\\chi \\ne \\mathbf 1), \\\\\nH_{\\mathbf 1}(s) &= -\\frac{\\zeta''}{\\zeta}(s)\\frac{1}{s(s-1)} - \\frac{1}{(s-1)^2} + \\frac{1+\\gamma}{s-1}.\n\\end{align*}\n\\item[(ii)] \\[ \\mathcal H_\\psi(s) = \\frac12 \\sum_{\\chi \\in \\mathcal C_\\psi} a_\\chi \\bigl(H_\\chi(s) + H_{\\bar\\chi}(s)\\bigr). \\]\n\\end{enumerate}","section_id":104,"position":2,"listed":1,"aliases":["mellin-smoothed-sum"]}', 'claude');
DELETE FROM refs WHERE source_result_id = 119 AND source_proof_id IS NULL;
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (119, NULL, '8JH4');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (119, NULL, '8JG8');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (119, NULL, '8JS2');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (119, NULL, '8JF7');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (119, NULL, '8JS3');
UPDATE results SET type = 'corollary', title = 'Real poles have positive residues', statement_tex = 'Let $\psi$ be a primitive character, $\mathcal H_\psi$ the \hyperref[8JS6]{Mellin transform of the weighted sum} and $Z$ the \hyperref[8JS4]{zero set}. Every real $\rho \in Z$ satisfies $0 < \rho < 1$, and
\[ \operatorname{Res}_{s=\rho} \mathcal H_\psi > 0. \]', statement_html_cache = NULL, position = 5, listed = 1, revision = revision + 1, updated_at = '2026-11-24 16:00:00', updated_by = 'claude' WHERE id = 120;
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author) VALUES ('result', '120', 3, 'restructure-1.4-2026-11-24', '{"tag":"8JS7","type":"corollary","title":"Real poles have positive residues","statement_tex":"Let $\\psi$ be a primitive character, $\\mathcal H_\\psi$ the \\hyperref[8JS6]{Mellin transform of the weighted sum} and $Z$ the \\hyperref[8JS4]{zero set}. Every real $\\rho \\in Z$ satisfies $0 < \\rho < 1$, and\n\\[ \\operatorname{Res}_{s=\\rho} \\mathcal H_\\psi > 0. \\]","section_id":104,"position":5,"listed":1,"aliases":["real-poles"]}', 'claude');
DELETE FROM refs WHERE source_result_id = 120 AND source_proof_id IS NULL;
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (120, NULL, '8JS6');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (120, NULL, '8JS4');
UPDATE proofs SET body_tex = '\emph{(i)} The right-hand sides in \ref{8JS6}(i) are meromorphic on $\C$. At $s = 1$ the singular parts cancel: for $\chi \ne \mathbf 1$ because $-\frac{L''}{L}(1,\chi) = -b_\chi$, and for $\chi = \mathbf 1$ because $-\frac{\zeta''}{\zeta}(s) = \frac{1}{s-1} - \gamma + O(s-1)$ gives
\[ -\frac{\zeta''}{\zeta}(s)\,\frac{1}{s(s-1)} = \frac{1}{(s-1)^2} - \frac{1+\gamma}{s-1} + O(1). \]
At a zero $\rho$ of $L(s,\chi)$ with $\Re\rho > 0$ (so $\rho \ne 0, 1$), $-\frac{L''}{L}(s,\chi)$ has a simple pole with residue $-m_\chi(\rho)$, which gives the stated residue.

\emph{(ii)} By (i) and \ref{8JS6}(ii), $\mathcal H_\psi$ extends meromorphically to $\Re s > 0$, its poles are simple and lie in $Z$, and at $\rho \in Z$
\[ \operatorname{Res}_{s=\rho} \mathcal H_\psi = \frac12 \sum_{\chi \in \mathcal C_\psi} a_\chi\, \frac{-m_\chi(\rho) - m_{\bar\chi}(\rho)}{\rho(\rho-1)} = -\frac{S_\rho}{\rho(\rho-1)}, \]
which is nonzero because \hyperref[8JS5]{$S_\rho > 0$}.', body_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-24 16:00:00', updated_by = 'claude' WHERE id = 101;
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author) VALUES ('proof', '101', 6, 'restructure-1.4-2026-11-24', '{"result_id":111,"body_tex":"\\emph{(i)} The right-hand sides in \\ref{8JS6}(i) are meromorphic on $\\C$. At $s = 1$ the singular parts cancel: for $\\chi \\ne \\mathbf 1$ because $-\\frac{L''}{L}(1,\\chi) = -b_\\chi$, and for $\\chi = \\mathbf 1$ because $-\\frac{\\zeta''}{\\zeta}(s) = \\frac{1}{s-1} - \\gamma + O(s-1)$ gives\n\\[ -\\frac{\\zeta''}{\\zeta}(s)\\,\\frac{1}{s(s-1)} = \\frac{1}{(s-1)^2} - \\frac{1+\\gamma}{s-1} + O(1). \\]\nAt a zero $\\rho$ of $L(s,\\chi)$ with $\\Re\\rho > 0$ (so $\\rho \\ne 0, 1$), $-\\frac{L''}{L}(s,\\chi)$ has a simple pole with residue $-m_\\chi(\\rho)$, which gives the stated residue.\n\n\\emph{(ii)} By (i) and \\ref{8JS6}(ii), $\\mathcal H_\\psi$ extends meromorphically to $\\Re s > 0$, its poles are simple and lie in $Z$, and at $\\rho \\in Z$\n\\[ \\operatorname{Res}_{s=\\rho} \\mathcal H_\\psi = \\frac12 \\sum_{\\chi \\in \\mathcal C_\\psi} a_\\chi\\, \\frac{-m_\\chi(\\rho) - m_{\\bar\\chi}(\\rho)}{\\rho(\\rho-1)} = -\\frac{S_\\rho}{\\rho(\\rho-1)}, \\]\nwhich is nonzero because \\hyperref[8JS5]{$S_\\rho > 0$}.","status":"ai_generated","generated_by":"claude","generator_detail":"claude-opus-5-5","reviewed_by":null,"review_notes":null,"position":1}', 'claude');
DELETE FROM refs WHERE source_proof_id = 101;
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (111, 101, '8JS6');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (111, 101, '8JS5');
UPDATE proofs SET body_tex = '\emph{(i)} Since
\[ \int_n^\infty \Bigl(\frac xn - 1\Bigr) x^{-s-1}\,dx = \frac{n^{-s}}{s(s-1)} \]
and $\sum_n \Lambda(n) n^{-\sigma} < \infty$ for $\sigma > 1$, we may integrate term by term:
\[ \int_1^\infty R_\chi(x)\, x^{-s-1}\,dx = \frac{1}{s(s-1)} \sum_{n \ge 1} \Lambda(n)\chi(n)\, n^{-s} = -\frac{L''}{L}(s,\chi)\,\frac{1}{s(s-1)}. \]
The remaining terms come from $\int_1^\infty x \cdot x^{-s-1}\,dx = \frac1{s-1}$ and $\int_1^\infty x\log x \cdot x^{-s-1}\,dx = \frac1{(s-1)^2}$.

\emph{(ii)} Since \hyperref[8JS5]{$\overline{L(\bar s,\chi)} = L(s,\bar\chi)$}, we have $\overline{G_\chi} = G_{\bar\chi}$, so $\Re G_\chi = \frac12(G_\chi + G_{\bar\chi})$. Now use the linearity of $\mathcal M$.', body_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-24 16:00:00', updated_by = 'claude' WHERE id = 106;
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author) VALUES ('proof', '106', 3, 'restructure-1.4-2026-11-24', '{"result_id":119,"body_tex":"\\emph{(i)} Since\n\\[ \\int_n^\\infty \\Bigl(\\frac xn - 1\\Bigr) x^{-s-1}\\,dx = \\frac{n^{-s}}{s(s-1)} \\]\nand $\\sum_n \\Lambda(n) n^{-\\sigma} < \\infty$ for $\\sigma > 1$, we may integrate term by term:\n\\[ \\int_1^\\infty R_\\chi(x)\\, x^{-s-1}\\,dx = \\frac{1}{s(s-1)} \\sum_{n \\ge 1} \\Lambda(n)\\chi(n)\\, n^{-s} = -\\frac{L''}{L}(s,\\chi)\\,\\frac{1}{s(s-1)}. \\]\nThe remaining terms come from $\\int_1^\\infty x \\cdot x^{-s-1}\\,dx = \\frac1{s-1}$ and $\\int_1^\\infty x\\log x \\cdot x^{-s-1}\\,dx = \\frac1{(s-1)^2}$.\n\n\\emph{(ii)} Since \\hyperref[8JS5]{$\\overline{L(\\bar s,\\chi)} = L(s,\\bar\\chi)$}, we have $\\overline{G_\\chi} = G_{\\bar\\chi}$, so $\\Re G_\\chi = \\frac12(G_\\chi + G_{\\bar\\chi})$. Now use the linearity of $\\mathcal M$.","status":"ai_generated","generated_by":"claude","generator_detail":"claude-opus-5-5","reviewed_by":null,"review_notes":null,"position":1}', 'claude');
DELETE FROM refs WHERE source_proof_id = 106;
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (119, 106, '8JS5');
UPDATE proofs SET body_tex = 'Since $L(s,\chi) \ne 0$ for $\Re s \ge 1$ \cite{Davenport}, a real $\rho \in Z$ lies in $(0,1)$. By \ref{8JN4}(ii) and \hyperref[8JS5]{$S_\rho > 0$},
\[ \operatorname{Res}_{s=\rho} \mathcal H_\psi = \frac{S_\rho}{\rho(1-\rho)} > 0. \]', body_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-24 16:00:00', updated_by = 'claude' WHERE id = 107;
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author) VALUES ('proof', '107', 5, 'restructure-1.4-2026-11-24', '{"result_id":120,"body_tex":"Since $L(s,\\chi) \\ne 0$ for $\\Re s \\ge 1$ \\cite{Davenport}, a real $\\rho \\in Z$ lies in $(0,1)$. By \\ref{8JN4}(ii) and \\hyperref[8JS5]{$S_\\rho > 0$},\n\\[ \\operatorname{Res}_{s=\\rho} \\mathcal H_\\psi = \\frac{S_\\rho}{\\rho(1-\\rho)} > 0. \\]","status":"ai_generated","generated_by":"claude","generator_detail":"claude-opus-5-5","reviewed_by":null,"review_notes":null,"position":1}', 'claude');
DELETE FROM refs WHERE source_proof_id = 107;
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (120, 107, '8JN4');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (120, 107, '8JS5');
UPDATE results SET position = 6 WHERE id = 112 AND section_id = 104;
UPDATE results SET position = 7 WHERE id = 113 AND section_id = 104;
UPDATE results SET position = 8 WHERE id = 114 AND section_id = 104;
UPDATE results SET position = 1 WHERE id = 115 AND section_id = 104;
UPDATE results SET position = 10 WHERE id = 121 AND section_id = 104;
