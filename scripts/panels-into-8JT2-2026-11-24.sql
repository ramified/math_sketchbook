INSERT INTO write_guard (ok) SELECT 0 WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE id = 109 AND revision = 10);
INSERT INTO write_guard (ok) SELECT 0 WHERE NOT EXISTS (SELECT 1 FROM proofs WHERE id = 111 AND revision = 1);
UPDATE proofs SET body_tex = 'Put $g(u) = \mathcal G_\psi(e^u)$, a real function, and $g_+ = \max(g, 0)$. Let $\sigma_0$ and $U_0$ be as in the \hyperref[8JT4]{concentration of the kernel}, and fix a real $\sigma \ge \sigma_0$. For $Y$ from the hypothesis with $U = \log Y \ge U_0$ put
\[ W = [U, \tfrac32 U], \qquad k = \bigl\lceil \tfrac54 \sigma U \bigr\rceil, \qquad K_k(u) = \frac{u^k e^{-\sigma u}}{k!}. \]
Here $W$ is the window $Y \le x \le Y^{3/2}$ in the variable $u = \log x$, and $k$ puts the peak $u = k/\sigma$ of $K_k$ at the midpoint $\frac54 U$ of $W$, up to rounding:
\begin{center}
\textbf{(a)} The kernels $K_1, K_2, K_3$ for $\sigma = 1$, with peaks at $u = k/\sigma$.
\end{center}
\includegraphics[width=1, alt=The kernels K_1, K_2, K_3 for sigma = 1, with dashed lines at their peaks]{/static/figures/gamma-kernel-a.svg}
\begin{center}
\textbf{(b)} The rescaled kernel $\displaystyle\frac{K_k(u)}{K_k(k/\sigma)} = \Bigl(\frac{\sigma u}{k}\Bigr)^{k} e^{k - \sigma u}$ for $k = 3, 30, 300$, with $\frac{k}{\sigma} = \frac54 U$ and $W$ shaded.
\end{center}
\includegraphics[width=1, alt=Rescaled kernels for k = 3, 30, 300 peaking at 5U/4, the midpoint of the shaded interval W]{/static/figures/gamma-kernel-b.svg}
As $k$ grows, almost all of the kernel lies in $W$. Then for every $\tau \in \R$
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
Each such $Y$ gives one $k$, and these $Y$ are unbounded, so the set $K$ of these $k$ is infinite. This proves the claim with $C = 2 + 4C_\psi$.', body_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-24 20:55:00', updated_by = 'claude' WHERE id = 109;
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author) VALUES ('proof', '109', 11, 'panels-into-8JT2-2026-11-24', '{"result_id":123,"body_tex":"Put $g(u) = \\mathcal G_\\psi(e^u)$, a real function, and $g_+ = \\max(g, 0)$. Let $\\sigma_0$ and $U_0$ be as in the \\hyperref[8JT4]{concentration of the kernel}, and fix a real $\\sigma \\ge \\sigma_0$. For $Y$ from the hypothesis with $U = \\log Y \\ge U_0$ put\n\\[ W = [U, \\tfrac32 U], \\qquad k = \\bigl\\lceil \\tfrac54 \\sigma U \\bigr\\rceil, \\qquad K_k(u) = \\frac{u^k e^{-\\sigma u}}{k!}. \\]\nHere $W$ is the window $Y \\le x \\le Y^{3/2}$ in the variable $u = \\log x$, and $k$ puts the peak $u = k/\\sigma$ of $K_k$ at the midpoint $\\frac54 U$ of $W$, up to rounding:\n\\begin{center}\n\\textbf{(a)} The kernels $K_1, K_2, K_3$ for $\\sigma = 1$, with peaks at $u = k/\\sigma$.\n\\end{center}\n\\includegraphics[width=1, alt=The kernels K_1, K_2, K_3 for sigma = 1, with dashed lines at their peaks]{/static/figures/gamma-kernel-a.svg}\n\\begin{center}\n\\textbf{(b)} The rescaled kernel $\\displaystyle\\frac{K_k(u)}{K_k(k/\\sigma)} = \\Bigl(\\frac{\\sigma u}{k}\\Bigr)^{k} e^{k - \\sigma u}$ for $k = 3, 30, 300$, with $\\frac{k}{\\sigma} = \\frac54 U$ and $W$ shaded.\n\\end{center}\n\\includegraphics[width=1, alt=Rescaled kernels for k = 3, 30, 300 peaking at 5U/4, the midpoint of the shaded interval W]{/static/figures/gamma-kernel-b.svg}\nAs $k$ grows, almost all of the kernel lies in $W$. Then for every $\\tau \\in \\R$\n\\begin{alignat*}{2}\n|A_k(\\sigma + i\\tau)| + \\Re A_k(\\sigma) &\\le \\int_0^\\infty (|g| + g)\\, K_k = 2\\int_0^\\infty g_+ K_k &\\qquad& \\text{(a)} \\\\\n&\\le 2\\int_W e^{\\theta u} K_k + 2C_\\psi \\int_{u \\notin W} e^{2u} K_k && \\text{(b)} \\\\\n&\\le 2(\\sigma - \\theta)^{-k-1} + 4 C_\\psi\\, \\sigma^{-k} && \\text{(c)} \\\\\n&\\le (2 + 4C_\\psi)\\, (\\sigma - \\theta)^{-k}, && \\text{(d)}\n\\end{alignat*}\nwhere:\n\\begin{itemize}\n\\item[(a)] \\hyperref[8JT3]{$A_k(\\sigma + i\\tau) = \\int_0^\\infty g\\, K_k\\, e^{-i\\tau u}\\,du$}, with $K_k \\ge 0$ and $|e^{-i\\tau u}| = 1$;\n\\item[(b)] $g_+ \\le e^{\\theta u}$ on $W$ by the hypothesis, and $g_+ \\le C_\\psi e^{2u}$ everywhere by \\ref{8JS3};\n\\item[(c)] the \\hyperref[8JT4]{concentration of the kernel};\n\\item[(d)] $\\sigma \\ge \\sigma - \\theta \\ge 1$.\n\\end{itemize}\nEach such $Y$ gives one $k$, and these $Y$ are unbounded, so the set $K$ of these $k$ is infinite. This proves the claim with $C = 2 + 4C_\\psi$.","status":"ai_generated","generated_by":"claude","generator_detail":"claude-opus-5-5","reviewed_by":null,"review_notes":null,"position":1}', 'claude');
UPDATE proofs SET body_tex = '\emph{(i)} \textbf{This is a Gamma integral.} Substitute $v = (\sigma - a)u$ in $\int_0^\infty u^k e^{-(\sigma - a)u}\,du$ and use $\int_0^\infty v^k e^{-v}\,dv = k!$.

\emph{(ii)} \textbf{Multiplying by $e^{2u}$ turns $K_k$ into a Gamma density with rate $\sigma - 2$, which is concentrated inside $W$.} By (i), $e^{2u} K_k(u) = (\sigma - 2)^{-k-1} p(u)$, where
\[ p(u) = \frac{(\sigma - 2)^{k+1} u^k e^{-(\sigma - 2)u}}{k!} \]
is the density of the Gamma distribution with shape $k+1$ and rate $\sigma - 2$; its mean is $m = (k+1)/(\sigma - 2)$. Chernoff''s bound gives, for $0 < \eta < 1$,
\[ \int_{|u - m| > \eta m} p(u)\,du \le 2 e^{-c(\eta) k}, \qquad c(\eta) = \eta - \log(1+\eta) > 0. \]
Fix $\eta > 0$ with $\frac54 (1+\eta)^2 < \frac32$, and $\sigma_0 > 3$ with $\frac{\sigma_0}{\sigma_0 - 2} < \min\bigl(1+\eta,\ e^{c(\eta)}\bigr)$; this inequality then holds for every $\sigma \ge \sigma_0$. Since $\frac54 U \le m \le \frac54 (1+\eta) U + 2$, there is $U_0$ such that $[(1-\eta)m, (1+\eta)m] \subset W$ for $U \ge U_0$, and then
\begin{alignat*}{2}
\int_{u \notin W} e^{2u} K_k &= (\sigma - 2)^{-k-1} \int_{u \notin W} p(u)\,du \\
&\le 2(\sigma - 2)^{-k-1} e^{-c(\eta) k} &\quad& \text{(Chernoff)} \\
&\le 2\sigma^{-k} && \text{(choice of } \sigma_0),
\end{alignat*}
where the last step uses $\frac{\sigma}{\sigma - 2} < e^{c(\eta)}$ and $\sigma - 2 > 1$.', body_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-24 20:55:00', updated_by = 'claude' WHERE id = 111;
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author) VALUES ('proof', '111', 2, 'panels-into-8JT2-2026-11-24', '{"result_id":125,"body_tex":"\\emph{(i)} \\textbf{This is a Gamma integral.} Substitute $v = (\\sigma - a)u$ in $\\int_0^\\infty u^k e^{-(\\sigma - a)u}\\,du$ and use $\\int_0^\\infty v^k e^{-v}\\,dv = k!$.\n\n\\emph{(ii)} \\textbf{Multiplying by $e^{2u}$ turns $K_k$ into a Gamma density with rate $\\sigma - 2$, which is concentrated inside $W$.} By (i), $e^{2u} K_k(u) = (\\sigma - 2)^{-k-1} p(u)$, where\n\\[ p(u) = \\frac{(\\sigma - 2)^{k+1} u^k e^{-(\\sigma - 2)u}}{k!} \\]\nis the density of the Gamma distribution with shape $k+1$ and rate $\\sigma - 2$; its mean is $m = (k+1)/(\\sigma - 2)$. Chernoff''s bound gives, for $0 < \\eta < 1$,\n\\[ \\int_{|u - m| > \\eta m} p(u)\\,du \\le 2 e^{-c(\\eta) k}, \\qquad c(\\eta) = \\eta - \\log(1+\\eta) > 0. \\]\nFix $\\eta > 0$ with $\\frac54 (1+\\eta)^2 < \\frac32$, and $\\sigma_0 > 3$ with $\\frac{\\sigma_0}{\\sigma_0 - 2} < \\min\\bigl(1+\\eta,\\ e^{c(\\eta)}\\bigr)$; this inequality then holds for every $\\sigma \\ge \\sigma_0$. Since $\\frac54 U \\le m \\le \\frac54 (1+\\eta) U + 2$, there is $U_0$ such that $[(1-\\eta)m, (1+\\eta)m] \\subset W$ for $U \\ge U_0$, and then\n\\begin{alignat*}{2}\n\\int_{u \\notin W} e^{2u} K_k &= (\\sigma - 2)^{-k-1} \\int_{u \\notin W} p(u)\\,du \\\\\n&\\le 2(\\sigma - 2)^{-k-1} e^{-c(\\eta) k} &\\quad& \\text{(Chernoff)} \\\\\n&\\le 2\\sigma^{-k} && \\text{(choice of } \\sigma_0),\n\\end{alignat*}\nwhere the last step uses $\\frac{\\sigma}{\\sigma - 2} < e^{c(\\eta)}$ and $\\sigma - 2 > 1$.","status":"ai_generated","generated_by":"claude","generator_detail":"claude-opus-5-5","reviewed_by":null,"review_notes":null,"position":1}', 'claude');
