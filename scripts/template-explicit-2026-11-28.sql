-- Make the bounds for ln|N| explicit in WJQV and specialize them to N = n! in GCHB.
-- Use L_div and L_size to avoid a clash with the centred sum Delta_u of 8JVF.

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM sections WHERE id IS 117 AND tag IS 'WJQV' AND revision IS 3)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id IS 208 AND tag IS 'GCHB' AND revision IS 3);

UPDATE sections SET intro_tex =
'At a real cutoff $x$, we want an upper bound for a prime-power count $T(x)$ with main term $M(x)$. Chebyshev''s method uses a nonzero integer $N$ and a scale $B(x)>0$. Later we use a lattice in place of $N$ and its slope in place of $\ln|N|$. The divisibility of $N$ gives a lower bound for $\ln|N|$, and the size of $N$ gives an upper bound. On the common scale $B(x)$ these bounds read
\[
B(x)\,T(x)-L_{\rm div}(x)\;\le\;\ln|N|\;\le\;B(x)\,M(x)+L_{\rm size}(x),
\]
where $L_{\rm div}(x)$ is the loss in the divisibility lower bound and $L_{\rm size}(x)$ is the excess of the size upper bound over $B(x)M(x)$. Comparing the two bounds gives
\[
T(x)-M(x)\le\frac{L_{\rm div}(x)+L_{\rm size}(x)}{B(x)}.
\]
This is the comparison of \ref{8V4M} with three requirements.

\begin{enumerate}
\item[(i)] The divisibility lower bound should have explicit exponents varying smoothly with the prime power, for example $(x/p^h-1)_+$. After summation and division by $B(x)$, the rounding allowance must fit within $O_\eta(x^{1/2+\eta})$.
\item[(ii)] The size upper bound should match the main term of the count through the term linear in $x$. Its normalized error must fit the same budget, which is $O_\eta(x^{-1/2+\eta})$ relative to the linear scale $x$.
\item[(iii)] The counted primes must be all primes or belong to classes whose counts can be combined to give the desired centered sum. For \ref{8JK2} this combination must yield the character weights of $\mathcal G_\psi$ up to errors within the same budget.
\end{enumerate}

For $\psi=\mathbf 1$ and $N=n!$, \ref{GCHB} carries out this comparison and shows how both errors stay of order $n$.

The lemniscate sine illustrates the change in the shape of the exponents. The smooth contributions at inert primes $p\equiv3\bmod 4$ involve odd powers $p^h$. The example can be read directly from the derivative recurrence, and the valuation proof explains the role of the height-two logarithm.',
  intro_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-28 02:00:00', updated_by = 'claude'
WHERE id = 117;

UPDATE results SET statement_tex =
'\textbf{The target.} For $\psi=\mathbf 1$, apply the template of the section introduction with the ramp sum as the count, so that
\[
T(x)=R_{\mathbf 1}(x)=\sum_{p^h\le x}\ln p\,\left(\frac{x}{p^h}-1\right).
\]
Take $M(x)=x\ln x-(1+\gamma)x$ as the main term. Then $T(x)-M(x)=G_{\mathbf 1}(x)$ by the definition of the \hyperref[8JF7]{smoothed prime sum}. An upper bound $G_{\mathbf 1}(x)\le x^{1/2+\varepsilon}$ is an upper bound for the ramp sum that is sharp through the linear term. Requirement (iii) is empty here, as every prime is counted with weight $1$.

\textbf{Chebyshev''s choice $N=n!$, with $B=1$.} At an integer cutoff $x=n$, the template reads
\[
R_{\mathbf 1}(n)-L_{\rm div}(n)\;\le\;\ln(n!)\;\le\;M(n)+L_{\rm size}(n).
\]
By \ref{CQAP}, $\ln(n!)=\sum_{r\le n}\Lambda(r)\lfloor n/r\rfloor$. Each ramp exponent $n/r-1$ is below the exponent $\lfloor n/r\rfloor$ of $n!$, and \ref{JMUK}(ii) accounts for the difference exactly through the fractional-part sum $E(n)=\sum_{r\le n}\Lambda(r)\{n/r\}$, where $\{y\}=y-\lfloor y\rfloor$. The two losses are
\begin{align*}
L_{\rm div}(n)&=\ln(n!)-R_{\mathbf 1}(n)=\sum_{r\le n}\Lambda(r)\bigl(1-\{n/r\}\bigr)=\Psi_{\mathbf 1}(n)-E(n),\\
L_{\rm size}(n)&=\ln(n!)-M(n)=\gamma n+O(\ln n),
\end{align*}
where the second line uses $\ln(n!)=n\ln n-n+O(\ln n)$. Both are nonnegative for large $n$, and their difference gives
\[
G_{\mathbf 1}(n)=L_{\rm size}(n)-L_{\rm div}(n).
\]
Dropping $L_{\rm div}(n)\ge0$ gives Chebyshev''s upper bound $G_{\mathbf 1}(n)\le\gamma n+O(\ln n)$.

\textbf{Where the comparison falls short.} Both losses have order $n$. The size bound misses the main term by $\gamma n$, so (ii) fails. The rounding to integer exponents loses up to one unit at every prime power $r\le n$, weighted by $\Lambda(r)$, so $L_{\rm div}(n)$ is of order $n$ by \ref{HPW7} and \ref{RF2E}, and (i) fails. The prime number theorem in the form $\sum_{r\le n}\Lambda(r)/r=\ln n-\gamma+o(1)$ gives $E(n)=(1-\gamma)n+o(n)$, hence $L_{\rm div}(n)=\gamma n+o(n)$ and $G_{\mathbf 1}(n)=o(n)$. The two losses cancel, but an upper bound for the count can only use $L_{\rm div}\ge0$, so the comparison cannot see the cancellation. The fractional parts $E(n)$ that it discards are the dots in the \hyperref[RF2G]{graph of $R_{\mathbf 1}$, $\Psi_{\mathbf 1}$ and $E$}.

\textbf{What a better object must do.} Both losses must become $O_\eta(x^{1/2+\eta})$ after division by $B(x)$.
\begin{enumerate}
\item[(i)] If $v_p(N)$ is at least $B(x)\sum_h(x/p^h-1)_+$ rounded down, the rounding loses less than $\ln p$ at each prime $p\le x$, so $L_{\rm div}(x)/B(x)<\Psi_{\mathbf 1}(x)/B(x)$. This fits the budget once $B(x)\ge x^{1/2-\eta}$, a scale that a single factorial with $B=1$ cannot provide.
\item[(ii)] The size bound must be $\ln|N|\le B(x)M(x)+B(x)\,O_\eta(x^{1/2+\eta})$, matching $M$ through the linear term $-(1+\gamma)x$, which $\ln(n!)$ misses by $\gamma n$.
\end{enumerate}
The lemniscate example below has the defects of $n!$ and one more: its floors lose order $n$ (D1), its guaranteed exponents see only the inert primes (D2), and its size is twice its divisor sum (D3).',
  statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-28 02:00:00', updated_by = 'claude'
WHERE id = 208;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'template-explicit-2026-11-28',
       json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex, 'section_id', section_id,
                   'position', position, 'visibility', visibility, 'state', state, 'replaced_by_id', replaced_by_id, 'listed', listed),
       'claude', '2026-11-28 02:00:00'
FROM results WHERE id = 208;
