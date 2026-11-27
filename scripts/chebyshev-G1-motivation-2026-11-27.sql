-- Motivation GCHB at the top of section 2.2 (WJQV, id 117): the comparison of the section intro carried out for
-- psi = 1 with N = n!. Both errors are of order n: E_size = ln n! - M(n) = gamma n + O(ln n) and
-- E_div = Psi_1(n) - E(n); G_1(n) = E_size - E_div exactly. The intro links to it. Results 177-183 move down one.

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM sections WHERE id IS 117 AND tag IS 'WJQV' AND revision IS 1
    AND instr(intro_tex, '

The lemniscate sine illustrates the change in the shape of the exponents.') > 0)
  OR (SELECT count(*) FROM results WHERE section_id = 117) IS NOT 7
  OR EXISTS (SELECT 1 FROM results WHERE section_id = 117 AND position = 8)
  OR EXISTS (SELECT 1 FROM tags WHERE tag = 'GCHB');

UPDATE results SET position = position + 1, updated_at = '2026-11-28 00:10:00', updated_by = 'claude'
WHERE section_id = 117;

INSERT INTO tags (tag, kind, created_at) VALUES ('GCHB', 'result', '2026-11-28 00:10:00');

INSERT INTO results (tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, state, listed,
                     created_at, updated_at, created_by, updated_by)
VALUES ('GCHB', 'motivation', 'Chebyshev''s comparison for $G_{\mathbf 1}$',
'\textbf{The target.} For $\psi=\mathbf 1$ the \hyperref[8JF7]{smoothed prime sum} is
\[
G_{\mathbf 1}(x)=R_{\mathbf 1}(x)-M(x),\qquad M(x)=x\ln x-(1+\gamma)x,
\]
with the ramp sum $R_{\mathbf 1}(x)=\sum_{p^h\le x}\ln p\,(x/p^h-1)$. In the comparison of this section the count is $T=R_{\mathbf 1}$ and the main term is $M$, so $T-M=G_{\mathbf 1}$. An upper bound $G_{\mathbf 1}(x)\le x^{1/2+\varepsilon}$ is an upper bound for the ramp sum that is sharp through the linear term. Requirement (iii) is empty here, as every prime is counted with weight $1$.

\textbf{Chebyshev''s choice $N=n!$, with $B=1$.} By \ref{CQAP}, $\ln(n!)=\sum_{r\le n}\Lambda(r)\lfloor n/r\rfloor$. Each ramp exponent $n/r-1$ is below the exponent $\lfloor n/r\rfloor$ of $n!$, and the integer parts are recovered exactly by \ref{JMUK}(ii). The two errors of the comparison are
\begin{align*}
E_{\rm div}(n)&=\ln(n!)-R_{\mathbf 1}(n)=\sum_{r\le n}\Lambda(r)\bigl(1-\{n/r\}\bigr)=\Psi_{\mathbf 1}(n)-E(n),\\
E_{\rm size}(n)&=\ln(n!)-M(n)=\gamma n+O(\ln n),
\end{align*}
where the second line uses $\ln(n!)=n\ln n-n+O(\ln n)$. Both are nonnegative for large $n$, and exactly
\[
G_{\mathbf 1}(n)=E_{\rm size}(n)-E_{\rm div}(n).
\]
Dropping $E_{\rm div}(n)\ge0$ gives Chebyshev''s upper bound $G_{\mathbf 1}(n)\le\gamma n+O(\ln n)$.

\textbf{Where the comparison falls short.} Both errors have order $n$. The size bound misses the main term by $\gamma n$, so (ii) fails. The rounding to integer exponents loses up to one unit at every prime power $r\le n$, weighted by $\Lambda(r)$, so $E_{\rm div}(n)$ is of order $n$ by \ref{HPW7} and \ref{RF2E}, and (i) fails. The prime number theorem in the form $\sum_{r\le n}\Lambda(r)/r=\ln n-\gamma+o(1)$ gives $E(n)=(1-\gamma)n+o(n)$, hence $E_{\rm div}(n)=\gamma n+o(n)$ and $G_{\mathbf 1}(n)=o(n)$. The two errors cancel, but an upper bound for the count can only use $E_{\rm div}\ge0$, so the comparison cannot see the cancellation. The fractional parts $E(n)$ that it discards are the dots in the \hyperref[RF2G]{graph of $R_{\mathbf 1}$, $\Psi_{\mathbf 1}$ and $E$}.

\textbf{What a better object must do.} Both errors must become $O_\eta(x^{1/2+\eta})$ after division by $B(x)$.
\begin{enumerate}
\item[(i)] If $v_p(N)$ is at least $B(x)\sum_h(x/p^h-1)_+$ rounded down, the rounding loses less than $\ln p$ at each prime $p\le x$, so $E_{\rm div}(x)/B(x)<\Psi_{\mathbf 1}(x)/B(x)$. This fits the budget once $B(x)\ge x^{1/2-\eta}$, a scale that a single factorial with $B=1$ cannot provide.
\item[(ii)] The size bound must be $\ln|N|\le B(x)M(x)+B(x)\,O_\eta(x^{1/2+\eta})$, matching $M$ through the linear term $-(1+\gamma)x$, which $\ln(n!)$ misses by $\gamma n$.
\end{enumerate}
The lemniscate example below has the defects of $n!$ and one more: its floors lose order $n$ (D1), its guaranteed exponents see only the inert primes (D2), and its size is twice its divisor sum (D3).',
NULL, 117, 1, 'published', 'active', 1,
'2026-11-28 00:10:00', '2026-11-28 00:10:00', 'claude', 'claude');

UPDATE sections SET intro_tex = replace(intro_tex,
'

The lemniscate sine illustrates the change in the shape of the exponents.',
'

For $\psi=\mathbf 1$ and $N=n!$, \ref{GCHB} carries out this comparison and shows how both errors stay of order $n$.

The lemniscate sine illustrates the change in the shape of the exponents.'),
  intro_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-28 00:10:00', updated_by = 'claude'
WHERE id = 117;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'chebyshev-G1-motivation-2026-11-27',
       json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex, 'section_id', section_id,
                   'position', position, 'visibility', visibility, 'state', state, 'replaced_by_id', replaced_by_id, 'listed', listed),
       'claude', '2026-11-28 00:10:00'
FROM results WHERE tag = 'GCHB';

UPDATE settings SET value = '1' WHERE key = 'needs_rebuild' AND value <> '1';
