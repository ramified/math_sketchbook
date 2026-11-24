INSERT INTO write_guard (ok) SELECT 0 WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE id = 104 AND revision = 4);
UPDATE proofs SET body_tex = '\emph{(i)}  
Using $$\sum_{n \le x} \frac1n \le 1 + \int_1^x \frac{dt}{t} = 1 + \log x,$$
\[ |R_\chi(x)| \le x \log x \sum_{n \le x} \frac1n \le x \log x\,(1 + \log x). \]

\emph{(ii)}
\begin{align*}
|M_\chi(x)| &= c_\chi\, x \le c_\chi\, x\,(1 + \log x) && (\chi \ne \mathbf 1), \\
|M_{\mathbf 1}(x)| &\le x\log x + (1+\gamma)x \le (1+\gamma)\, x\,(1 + \log x) && (\chi = \mathbf 1).
\end{align*}

\emph{(iii)}  By (i) and (ii),
\[ |G_\chi(x)| \le x\log x\,(1+\log x) + c_\chi\, x\,(1+\log x) \le (1 + c_\chi)\, x\,(1+\log x)^2. \]
', body_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-24 15:10:00', updated_by = 'claude' WHERE id = 104;
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author) VALUES ('proof', '104', 5, 'align-8JS3-ii-2026-11-24', '{"result_id":116,"body_tex":"\\emph{(i)}  \nUsing $$\\sum_{n \\le x} \\frac1n \\le 1 + \\int_1^x \\frac{dt}{t} = 1 + \\log x,$$\n\\[ |R_\\chi(x)| \\le x \\log x \\sum_{n \\le x} \\frac1n \\le x \\log x\\,(1 + \\log x). \\]\n\n\\emph{(ii)}\n\\begin{align*}\n|M_\\chi(x)| &= c_\\chi\\, x \\le c_\\chi\\, x\\,(1 + \\log x) && (\\chi \\ne \\mathbf 1), \\\\\n|M_{\\mathbf 1}(x)| &\\le x\\log x + (1+\\gamma)x \\le (1+\\gamma)\\, x\\,(1 + \\log x) && (\\chi = \\mathbf 1).\n\\end{align*}\n\n\\emph{(iii)}  By (i) and (ii),\n\\[ |G_\\chi(x)| \\le x\\log x\\,(1+\\log x) + c_\\chi\\, x\\,(1+\\log x) \\le (1 + c_\\chi)\\, x\\,(1+\\log x)^2. \\]\n","status":"ai_generated","generated_by":"claude","generator_detail":"claude-opus-5-5","reviewed_by":null,"review_notes":"I want the proof to be short and point out the key points. The previous \"1<1+log x\" things are stupid, and continuous argument is also stupid","position":1}', 'claude');
