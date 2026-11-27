-- Split Proposition JMUK (section 116, 2.1) into two lemmas:
--   JMUK  lemma, the identities (i) x sum Lambda(r)/r = R_1 + Psi_1 and (ii) R_1(n) = ln n! - Psi_1(n) + E(n);
--   RF2E  lemma, cn <= E(n) <= 4n ln 2 (the estimates, with the old lower-bound proof).
-- RF2G is an unlisted example with the graph of R_1, Psi_1 and E(n) (scripts/plot-ramp-fractional.mjs).
-- RF2R is a remark holding the old closing paragraph on G_1(n). ZFM6 and PRBA now cite RF2E.

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM results WHERE id IS 176 AND tag IS 'JMUK' AND revision IS 1 AND section_id IS 116 AND position IS 5)
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id IS 144 AND result_id IS 176 AND revision IS 1)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 201 AND tag IS 'PRBA' AND revision IS 1
    AND instr(statement_tex, 'The absolute constants $c$ and $n_0$ in \ref{JMUK}') > 0)
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id IS 148 AND revision IS 1
    AND instr(body_tex, 'the same linear lower bound as in the proof of \ref{JMUK}.') > 0
    AND instr(body_tex, 'Partial summation with $\vartheta_3(t)$ as in \ref{JMUK}') > 0)
  OR EXISTS (SELECT 1 FROM results WHERE section_id = 116 AND position > 5)
  OR EXISTS (SELECT 1 FROM tags WHERE tag IN ('RF2G', 'RF2E', 'RF2R'));

-- JMUK: the identities.
UPDATE results SET type = 'lemma',
  statement_tex =
'Let $R_{\mathbf 1}$ be the ramp sum of \ref{8JF7}.
\begin{enumerate}
\item[(i)] For every real $x\ge1$,
\[
x\sum_{r\le x}\frac{\Lambda(r)}{r}=R_{\mathbf 1}(x)+\Psi_{\mathbf 1}(x).
\]
\item[(ii)] For integers $n\ge1$, write $\{y\}=y-\lfloor y\rfloor$ and put $E(n)=\sum_{r\le n}\Lambda(r)\{n/r\}$. Then
\[
R_{\mathbf 1}(n)=\ln(n!)-\Psi_{\mathbf 1}(n)+E(n).
\]
\end{enumerate}
See the \hyperref[RF2G]{graph of $R_{\mathbf 1}$, $\Psi_{\mathbf 1}$ and $E$}. The size of $E(n)$ is estimated in \ref{RF2E}.',
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-27 23:30:00', updated_by = 'claude'
WHERE id = 176;

UPDATE proofs SET body_tex =
'\emph{(i)} For $r\le x$ the summand of $R_{\mathbf 1}(x)$ is $\Lambda(r)(x/r-1)$, and the terms with $r>x$ vanish. Summing gives $R_{\mathbf 1}(x)=x\sum_{r\le x}\Lambda(r)/r-\Psi_{\mathbf 1}(x)$.

\emph{(ii)} \textbf{Split each $n/r$ into its integer and fractional parts.}
\begin{alignat*}{2}
R_{\mathbf 1}(n)+\Psi_{\mathbf 1}(n)
&=\sum_{r\le n}\Lambda(r)\,\frac nr &\qquad& \text{(i) at $x=n$}\\
&=\sum_{r\le n}\Lambda(r)\Bigl\lfloor\frac nr\Bigr\rfloor+\sum_{r\le n}\Lambda(r)\Bigl\{\frac nr\Bigr\} && y=\lfloor y\rfloor+\{y\}\\
&=\ln(n!)+E(n) && \text{\ref{CQAP}}
\end{alignat*}',
  body_html_cache = NULL, generated_by = 'claude', generator_detail = 'Claude Opus 5.5',
  revision = revision + 1, updated_at = '2026-11-27 23:30:00', updated_by = 'claude'
WHERE id = 144;

INSERT INTO tags (tag, kind, created_at) VALUES
  ('RF2G', 'result', '2026-11-27 23:30:00'),
  ('RF2E', 'result', '2026-11-27 23:30:00'),
  ('RF2R', 'result', '2026-11-27 23:30:00');

-- RF2G: the graph (unlisted example).
INSERT INTO results (tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, state, listed,
                     created_at, updated_at, created_by, updated_by)
VALUES ('RF2G', 'example', 'The ramp sum, $\Psi_{\mathbf 1}$ and $E$',
'The graph shows, for $1\le x\le40$, the \hyperref[8JF7]{ramp sum} $R_{\mathbf 1}(x)$, the Chebyshev function $\Psi_{\mathbf 1}(x)$, and the values $E(n)$ of \ref{JMUK}(ii) at the integers $n$. The ramp sum is continuous and piecewise linear; its slope $\sum_{r\le x}\Lambda(r)/r$ increases at each prime power $r$, where $\Psi_{\mathbf 1}$ jumps by $\Lambda(r)$. By \ref{JMUK}(ii), at each integer $n$ the height of the ramp plus the height of the step, minus the height of the dot, is $\ln(n!)$. In this range the dots stay below $0.43\,n$; \ref{RF2E} shows that $E(n)$ has exact order $n$.
\includegraphics[width=1, alt=The ramp sum R_1(x) rising like x ln x, the step function Psi_1(x) rising like x, and the dots E(n) of order n, for x from 1 to 40]{/static/figures/ramp-fractional.svg}',
NULL, 116, 6, 'published', 'active', 0,
'2026-11-27 23:30:00', '2026-11-27 23:30:00', 'claude', 'claude');

-- RF2E: the estimates.
INSERT INTO results (tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, state, listed,
                     created_at, updated_at, created_by, updated_by)
VALUES ('RF2E', 'lemma', 'Size of the fractional-part sum',
'Let $E(n)$ be as in \ref{JMUK}(ii). There are absolute constants $c>0$ and $n_0\ge1$ such that for every integer $n\ge n_0$,
\[
cn\le E(n)\le4n\ln 2.
\]',
NULL, 116, 7, 'published', 'active', 1,
'2026-11-27 23:30:00', '2026-11-27 23:30:00', 'claude', 'claude');

INSERT INTO proofs (result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail, visibility, revision,
                    created_at, updated_at, created_by, updated_by)
SELECT id, 1,
'\emph{Upper bound.} Each $\{n/r\}$ is less than $1$, so $E(n)\le\Psi_{\mathbf 1}(n)\le4n\ln2$ by \ref{HPW7}.

\emph{Lower bound.} \textbf{The primes in $(3n/5,2n/3]$ have fractional part $\{n/p\}\ge\frac12$, and there are enough of them.} Put $\vartheta_3(t)=\sum_{p\le t,\ p\equiv3\bmod 4}\ln p$. The prime number theorem for the fixed modulus $4$ gives $\vartheta_3(t)=t/2+O(t/(\ln t)^2)$ for $t\ge2$ \cite[Chapter 20]{Davenport}, so
\[
\vartheta_3(2n/3)-\vartheta_3(3n/5)=\frac n{30}+O\Bigl(\frac n{(\ln n)^2}\Bigr).
\]
For a prime $p$ in $(3n/5,2n/3]$ we have $3/2\le n/p<5/3$, so $\{n/p\}=n/p-1\ge\frac12$. All terms of $E(n)$ are nonnegative, so
\[
E(n)\ge\tfrac12\bigl(\vartheta_3(2n/3)-\vartheta_3(3n/5)\bigr).
\]
Choose $n_0$ so that the error term is at most $n/60$ for $n\ge n_0$. Then $E(n)\ge n/120$, so one can take $c=1/120$.',
NULL, 'ai_generated', 'claude', 'Claude Opus 5.5', 'published', 1,
'2026-11-27 23:30:00', '2026-11-27 23:30:00', 'claude', 'claude'
FROM results WHERE tag = 'RF2E';

-- RF2R: what the fractional parts mean for G_1(n).
INSERT INTO results (tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, state, listed,
                     created_at, updated_at, created_by, updated_by)
VALUES ('RF2R', 'remark', 'The fractional parts at the scale of $G_{\mathbf 1}$',
'For integers $n\ge1$, the function $G_{\mathbf 1}$ of \ref{8JF7} satisfies
\[
G_{\mathbf 1}(n)=\gamma n-\Psi_{\mathbf 1}(n)+E(n)+O(\ln(n+1)).
\]
Here $E(n)$ has order $n$ by \ref{RF2E}, the same order as the other two main terms. Treating the fractional parts only by their size therefore leaves an error of order $n$, the scale of the Chebyshev bounds in \ref{HPW7}, while \ref{8JK2} asks for an upper bound at square-root precision.',
NULL, 116, 8, 'published', 'active', 1,
'2026-11-27 23:30:00', '2026-11-27 23:30:00', 'claude', 'claude');

INSERT INTO proofs (result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail, visibility, revision,
                    created_at, updated_at, created_by, updated_by)
SELECT id, 1,
'Comparing $\ln(n!)$ with $\int_1^n\ln t\,dt$ gives $\ln(n!)=n\ln n-n+O(\ln(n+1))$. Insert \ref{JMUK}(ii) into the definition of $G_{\mathbf 1}$:
\begin{alignat*}{2}
G_{\mathbf 1}(n)
&=R_{\mathbf 1}(n)-n\ln n+(1+\gamma)n &\qquad& \text{\ref{8JF7}}\\
&=\ln(n!)-\Psi_{\mathbf 1}(n)+E(n)-n\ln n+(1+\gamma)n && \text{\ref{JMUK}(ii)}\\
&=\gamma n-\Psi_{\mathbf 1}(n)+E(n)+O(\ln(n+1)). && \text{Stirling bound above}
\end{alignat*}',
NULL, 'ai_generated', 'claude', 'Claude Opus 5.5', 'published', 1,
'2026-11-27 23:30:00', '2026-11-27 23:30:00', 'claude', 'claude'
FROM results WHERE tag = 'RF2R';

-- ZFM6 and PRBA cite the estimate lemma.
UPDATE proofs SET body_tex = replace(replace(body_tex,
  'the same linear lower bound as in the proof of \ref{JMUK}.', 'the same linear lower bound as in the proof of \ref{RF2E}.'),
  'Partial summation with $\vartheta_3(t)$ as in \ref{JMUK}', 'Partial summation with $\vartheta_3(t)$ as in \ref{RF2E}'),
  body_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-27 23:30:00', updated_by = 'claude'
WHERE id = 148;
UPDATE results SET statement_tex = replace(statement_tex,
  'The absolute constants $c$ and $n_0$ in \ref{JMUK}', 'The absolute constants $c$ and $n_0$ in \ref{RF2E}'),
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-27 23:30:00', updated_by = 'claude'
WHERE id = 201;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'split-JMUK-2026-11-27',
       json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex, 'section_id', section_id,
                   'position', position, 'visibility', visibility, 'state', state, 'replaced_by_id', replaced_by_id, 'listed', listed),
       'claude', '2026-11-27 23:30:00'
FROM results WHERE tag IN ('JMUK', 'RF2G', 'RF2E', 'RF2R', 'PRBA');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'proof', CAST(p.id AS TEXT), p.revision, 'split-JMUK-2026-11-27',
       json_object('result_id', p.result_id, 'body_tex', p.body_tex, 'status', p.status, 'generated_by', p.generated_by,
                   'generator_detail', p.generator_detail, 'visibility', p.visibility),
       'claude', '2026-11-27 23:30:00'
FROM proofs p JOIN results r ON r.id = p.result_id WHERE r.tag IN ('JMUK', 'RF2E', 'RF2R', 'ZFM6');

UPDATE settings SET value = '1' WHERE key = 'needs_rebuild' AND value <> '1';
