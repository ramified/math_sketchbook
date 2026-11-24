INSERT INTO write_guard (ok) SELECT 0 WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE id = 109 AND revision = 9);
UPDATE proofs SET body_tex = 'Put $g(u) = \mathcal G_\psi(e^u)$, a real function, and $g_+ = \max(g, 0)$. Let $\sigma_0$ and $U_0$ be as in the \hyperref[8JT4]{concentration of the kernel}, and fix a real $\sigma \ge \sigma_0$. For $Y$ from the hypothesis with $U = \log Y \ge U_0$ put
\[ W = [U, \tfrac32 U], \qquad k = \bigl\lceil \tfrac54 \sigma U \bigr\rceil, \qquad K_k(u) = \frac{u^k e^{-\sigma u}}{k!}. \]
Here $W$ is the window $Y \le x \le Y^{3/2}$ in the variable $u = \log x$, and $k$ puts the peak $u = k/\sigma$ of $K_k$ at the midpoint $\frac54 U$ of $W$, up to rounding. Then for every $\tau \in \R$
\begin{alignat*}{2}
|A_k(\sigma + i\tau)| + \Re A_k(\sigma) &\le \int_0^\infty (|g| + g)\, K_k = 2\int_0^\infty g_+ K_k &\qquad& \text{(a)} \\
&\le 2\int_W e^{\theta u} K_k + 2C_\psi \int_{u \notin W} e^{2u} K_k && \text{(b)} \\
&\le 2(\sigma - \theta)^{-k-1} + 4 C_\psi\, \sigma^{-k} && \text{(c)} \\
&\le (2 + 4C_\psi)\, (\sigma - \theta)^{-k}, && \text{(d)}
\end{alignat*}
where:
\begin{itemize}
\item[(a)] \hyperref[8JT3]{$A_k(\sigma + i\tau) = \int_0^\infty g\, K_k\, e^{-i\tau u}\,du$}, with $K_k \ge 0$ and $|e^{-i\tau u}| = 1$;
\item[(b)] $g_+ \le e^{\theta u}$ on $W$ by the hypothesis, and $g_+ \le C_\psi e^{2u}$ everywhere by \ref{8JS3};
\item[(c)] the \hyperref[8JT4]{concentration of the kernel};
\item[(d)] $\sigma \ge \sigma - \theta \ge 1$.
\end{itemize}
Each such $Y$ gives one $k$, and these $Y$ are unbounded, so the set $K$ of these $k$ is infinite. This proves the claim with $C = 2 + 4C_\psi$.', body_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-24 20:30:00', updated_by = 'claude' WHERE id = 109;
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author) VALUES ('proof', '109', 10, 'chain-labels-8JT2-2026-11-24', '{"result_id":123,"body_tex":"Put $g(u) = \\mathcal G_\\psi(e^u)$, a real function, and $g_+ = \\max(g, 0)$. Let $\\sigma_0$ and $U_0$ be as in the \\hyperref[8JT4]{concentration of the kernel}, and fix a real $\\sigma \\ge \\sigma_0$. For $Y$ from the hypothesis with $U = \\log Y \\ge U_0$ put\n\\[ W = [U, \\tfrac32 U], \\qquad k = \\bigl\\lceil \\tfrac54 \\sigma U \\bigr\\rceil, \\qquad K_k(u) = \\frac{u^k e^{-\\sigma u}}{k!}. \\]\nHere $W$ is the window $Y \\le x \\le Y^{3/2}$ in the variable $u = \\log x$, and $k$ puts the peak $u = k/\\sigma$ of $K_k$ at the midpoint $\\frac54 U$ of $W$, up to rounding. Then for every $\\tau \\in \\R$\n\\begin{alignat*}{2}\n|A_k(\\sigma + i\\tau)| + \\Re A_k(\\sigma) &\\le \\int_0^\\infty (|g| + g)\\, K_k = 2\\int_0^\\infty g_+ K_k &\\qquad& \\text{(a)} \\\\\n&\\le 2\\int_W e^{\\theta u} K_k + 2C_\\psi \\int_{u \\notin W} e^{2u} K_k && \\text{(b)} \\\\\n&\\le 2(\\sigma - \\theta)^{-k-1} + 4 C_\\psi\\, \\sigma^{-k} && \\text{(c)} \\\\\n&\\le (2 + 4C_\\psi)\\, (\\sigma - \\theta)^{-k}, && \\text{(d)}\n\\end{alignat*}\nwhere:\n\\begin{itemize}\n\\item[(a)] \\hyperref[8JT3]{$A_k(\\sigma + i\\tau) = \\int_0^\\infty g\\, K_k\\, e^{-i\\tau u}\\,du$}, with $K_k \\ge 0$ and $|e^{-i\\tau u}| = 1$;\n\\item[(b)] $g_+ \\le e^{\\theta u}$ on $W$ by the hypothesis, and $g_+ \\le C_\\psi e^{2u}$ everywhere by \\ref{8JS3};\n\\item[(c)] the \\hyperref[8JT4]{concentration of the kernel};\n\\item[(d)] $\\sigma \\ge \\sigma - \\theta \\ge 1$.\n\\end{itemize}\nEach such $Y$ gives one $k$, and these $Y$ are unbounded, so the set $K$ of these $k$ is infinite. This proves the claim with $C = 2 + 4C_\\psi$.","status":"ai_generated","generated_by":"claude","generator_detail":"claude-opus-5-5","reviewed_by":null,"review_notes":null,"position":1}', 'claude');
