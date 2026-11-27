-- 8JT4 (ii): conceptual Chernoff-type proof with a small fixed lambda and c large; the threshold 200 becomes an
-- absolute c_*. Cascade: KW4N, the thresholds in the proofs of 8JT2 and 8JUP, and the pole pictures 8JT8, 8JT9.

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM results WHERE id IS 125 AND tag IS '8JT4' AND revision IS 3
    AND instr(statement_tex, '\item[(ii)] Let $c \ge 200$ and $U > 0$, and put') > 0)
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id IS 111 AND revision IS 4
    AND instr(body_tex, '\emph{(ii)} \textbf{Outside $W$, bound $1$ by an exponential') > 0
    AND instr(body_tex, 'Adding the two bounds gives (ii).') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 139 AND tag IS '8JT8' AND revision IS 2 AND instr(statement_tex, '$c \ge 200$, and') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 140 AND tag IS '8JT9' AND revision IS 2 AND instr(statement_tex, '$c \ge 200$, and') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE tag IS 'KW4N' AND revision IS 1 AND instr(statement_tex, 'Let $c\ge200$, $0<\theta<1$ and $U>0$ be real.') > 0)
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id IS 109 AND revision IS 15 AND instr(body_tex, 'Let $c_0 = 200$, as in the') > 0)
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id IS 126 AND revision IS 3 AND instr(body_tex, 'Put $c_0=200$, the threshold') > 0);

UPDATE results SET statement_tex = replace(statement_tex,
  '\item[(ii)] Let $c \ge 200$ and $U > 0$, and put',
  '\item[(ii)] There is a real $c_* > 2$ such that the following holds for every real $c \ge c_*$ and every real $U > 0$. Put'),
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-27 22:00:00', updated_by = 'claude'
WHERE id = 125;

UPDATE proofs SET body_tex = substr(body_tex, 1, instr(body_tex, '\emph{(ii)}') - 1) ||
'\emph{(ii)} \textbf{$W$ reaches a fixed fraction beyond the peak of $K_k$ on each side; outside $W$, bound $1$ by an exponential and integrate over all $u$ with (i).} The kernel $K_k$ peaks at $u=k/c$, and the choice of $k$ gives $\frac45(k-1)<cU\le\frac45k$. So $W$ runs from about $\frac45$ to about $\frac65$ times the peak. Fix a real $0<\lambda<1$ with
\[
\ln(1+\lambda)>\tfrac45\lambda\qquad\text{and}\qquad-\ln(1-\lambda)<\tfrac65\lambda,
\]
which every small $\lambda$ satisfies because $\ln(1\pm\lambda)=\pm\lambda+O(\lambda^2)$, and put $t=\lambda c$.

\emph{Right of $W$.} For $u>\frac32U$ we have $1\le e^{t(u-3U/2)}$. Use (i) with $a=2+t<c$ and $\frac32tU\ge\frac65\lambda(k-1)$:
\begin{align*}
\int_{u>3U/2}e^{2u}K_k(u)\,du
&\le e^{-3tU/2}\,(c-2-t)^{-k-1}\\
&\le c^{-k}\cdot\frac{e^{6\lambda/5}}{c\,(1-\lambda-2/c)}\cdot\biggl(\frac{e^{-6\lambda/5}}{1-\lambda-2/c}\biggr)^{k}.
\end{align*}

\emph{Left of $W$.} For $u<U$ we have $1\le e^{t(U-u)}$. Use (i) with $a=2-t$ and $tU\le\frac45\lambda k$:
\begin{align*}
\int_{u<U}e^{2u}K_k(u)\,du
&\le e^{tU}\,(c-2+t)^{-k-1}\\
&\le c^{-k}\cdot\frac{1}{c\,(1+\lambda-2/c)}\cdot\biggl(\frac{e^{4\lambda/5}}{1+\lambda-2/c}\biggr)^{k}.
\end{align*}

\emph{Choice of $c_*$.} As $c\to\infty$, the two bases of the $k$-th powers tend to $e^{-6\lambda/5}/(1-\lambda)$ and $e^{4\lambda/5}/(1+\lambda)$, which are less than $1$ by the choice of $\lambda$, and the middle factors tend to $0$. Take $c_*$ so large that for every $c\ge c_*$ we have $2+t<c$ and both bases and both middle factors are at most $1$. Then each tail is at most $c^{-k}$, which gives (ii).',
  body_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-27 22:00:00', updated_by = 'claude'
WHERE id = 111;

UPDATE results SET statement_tex = replace(statement_tex, '$c \ge 200$, and', '$c$ is large, and'),
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-27 22:00:00', updated_by = 'claude'
WHERE id IN (139, 140);

UPDATE results SET statement_tex = replace(statement_tex,
  'Let $c\ge200$, $0<\theta<1$ and $U>0$ be real.',
  'Let $c_*$ be as in the \hyperref[8JT4]{concentration of the kernel}, and let $c\ge c_*$, $0<\theta<1$ and $U>0$ be real.'),
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-27 22:00:00', updated_by = 'claude'
WHERE tag = 'KW4N';

UPDATE proofs SET body_tex = replace(body_tex, 'Let $c_0 = 200$, as in the', 'Let $c_0 = c_*$, as in the'),
  body_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-27 22:00:00', updated_by = 'claude'
WHERE id = 109;
UPDATE proofs SET body_tex = replace(body_tex, 'Put $c_0=200$, the threshold', 'Put $c_0=c_*$, the threshold'),
  body_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-27 22:00:00', updated_by = 'claude'
WHERE id = 126;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'kernel-concentration-proof-2026-11-27',
       json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex, 'section_id', section_id,
                   'position', position, 'visibility', visibility, 'state', state, 'replaced_by_id', replaced_by_id, 'listed', listed),
       'claude', '2026-11-27 22:00:00'
FROM results WHERE id IN (125, 139, 140) OR tag = 'KW4N';

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'proof', CAST(id AS TEXT), revision, 'kernel-concentration-proof-2026-11-27',
       json_object('result_id', result_id, 'body_tex', body_tex, 'status', status, 'generated_by', generated_by,
                   'generator_detail', generator_detail, 'reviewed_by', reviewed_by, 'review_notes', review_notes, 'position', position),
       'claude', '2026-11-27 22:00:00'
FROM proofs WHERE id IN (111, 109, 126);

INSERT OR IGNORE INTO refs (source_result_id, source_proof_id, target_tag)
SELECT id, NULL, '8JT4' FROM results WHERE tag = 'KW4N';

UPDATE settings SET value = '1' WHERE key = 'needs_rebuild' AND value <> '1';
