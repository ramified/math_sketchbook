-- Follow-up to split-JMUK: \ref inside \text{} in alignat does not render. Use (a), (b), (c) labels and a list below.

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM proofs WHERE id IS 144 AND revision IS 2 AND instr(body_tex, '\text{\ref{CQAP}}') > 0)
  OR NOT EXISTS (SELECT 1 FROM proofs p JOIN results r ON r.id = p.result_id
    WHERE r.tag IS 'RF2R' AND p.revision IS 1 AND instr(p.body_tex, '\text{\ref{JMUK}(ii)}') > 0);

UPDATE proofs SET body_tex =
'\emph{(i)} For $r\le x$ the summand of $R_{\mathbf 1}(x)$ is $\Lambda(r)(x/r-1)$, and the terms with $r>x$ vanish. Summing gives $R_{\mathbf 1}(x)=x\sum_{r\le x}\Lambda(r)/r-\Psi_{\mathbf 1}(x)$.

\emph{(ii)} \textbf{Split each $n/r$ into its integer and fractional parts.}
\begin{alignat*}{2}
R_{\mathbf 1}(n)+\Psi_{\mathbf 1}(n)
&=\sum_{r\le n}\Lambda(r)\,\frac nr &\qquad& \text{(a)}\\
&=\sum_{r\le n}\Lambda(r)\Bigl\lfloor\frac nr\Bigr\rfloor+\sum_{r\le n}\Lambda(r)\Bigl\{\frac nr\Bigr\} && \text{(b)}\\
&=\ln(n!)+E(n), && \text{(c)}
\end{alignat*}
where:
\begin{itemize}
\item[(a)] (i) at $x=n$;
\item[(b)] $y=\lfloor y\rfloor+\{y\}$ with $y=n/r$;
\item[(c)] the factorial identity in \ref{CQAP}, and the definition of $E(n)$.
\end{itemize}',
  body_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-27 23:45:00', updated_by = 'claude'
WHERE id = 144;

UPDATE proofs SET body_tex =
'Comparing $\ln(n!)$ with $\int_1^n\ln t\,dt$ gives $\ln(n!)=n\ln n-n+O(\ln(n+1))$. Then
\begin{alignat*}{2}
G_{\mathbf 1}(n)
&=R_{\mathbf 1}(n)-n\ln n+(1+\gamma)n &\qquad& \text{(a)}\\
&=\ln(n!)-\Psi_{\mathbf 1}(n)+E(n)-n\ln n+(1+\gamma)n && \text{(b)}\\
&=\gamma n-\Psi_{\mathbf 1}(n)+E(n)+O(\ln(n+1)), && \text{(c)}
\end{alignat*}
where:
\begin{itemize}
\item[(a)] the definition of $G_{\mathbf 1}$ in \ref{8JF7};
\item[(b)] \ref{JMUK}(ii);
\item[(c)] the formula for $\ln(n!)$ above.
\end{itemize}',
  body_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-27 23:45:00', updated_by = 'claude'
WHERE result_id = (SELECT id FROM results WHERE tag = 'RF2R');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'proof', CAST(p.id AS TEXT), p.revision, 'split-JMUK-labels-2026-11-27',
       json_object('result_id', p.result_id, 'body_tex', p.body_tex, 'status', p.status, 'generated_by', p.generated_by,
                   'generator_detail', p.generator_detail, 'visibility', p.visibility),
       'claude', '2026-11-27 23:45:00'
FROM proofs p JOIN results r ON r.id = p.result_id WHERE r.tag IN ('JMUK', 'RF2R');
