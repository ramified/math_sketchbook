-- PLACEHOLDER content for grh-notes. Safe to run only on an EMPTY database.
-- The mathematics below is a sketch used to demonstrate the website, not reviewed notes.

INSERT INTO settings (key, value) VALUES
('book_title', 'Notes towards GRH (placeholder)'),
('macros', '% Shared macros, applied to all math on the site.
\newcommand{\N}{\mathbb{N}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\Q}{\mathbb{Q}}
\newcommand{\R}{\mathbb{R}}
\newcommand{\C}{\mathbb{C}}
\newcommand{\abs}[1]{\left|#1\right|}
\renewcommand{\Re}{\operatorname{Re}}
\DeclareMathOperator{\Li}{Li}
\newcommand{\cond}{\mathfrak{f}}'),
('bibliography', '\bibitem{Davenport} H. Davenport, \emph{Multiplicative Number Theory}, 3rd ed., Graduate Texts in Mathematics 74, Springer, 2000.
\bibitem{IK} H. Iwaniec and E. Kowalski, \emph{Analytic Number Theory}, AMS Colloquium Publications 53, 2004.');

INSERT INTO tags (tag, kind) VALUES
('2AC7', 'section'), ('2AD3', 'section'), ('2AE5', 'section'), ('3BF9', 'section'), ('3BG4', 'section'),
('4CHK', 'result'), ('4CJM', 'result'), ('4CKN', 'result'),
('5DMP', 'result'), ('5DNQ', 'result'), ('5DPR', 'result'),
('6EQS', 'result'), ('6ERT', 'result');

INSERT INTO aliases (alias, tag) VALUES
('dirichlet-character', '4CHK'), ('orthogonality', '4CJM'), ('dirichlet-l-function', '5DMP'),
('nonvanishing-at-one', '5DNQ'), ('dirichlet-theorem', '5DPR'), ('grh', '6EQS');

INSERT INTO sections (id, tag, parent_id, kind, title, intro_tex, position) VALUES
(1, '2AC7', NULL, 'chapter', 'Dirichlet characters and $L$-functions',
 'This chapter collects the basic objects. \emph{All content here is placeholder text.}', 1),
(2, '2AD3', 1, 'section', 'Characters', 'We fix an integer $q \ge 1$ throughout.', 1),
(3, '2AE5', 1, 'section', 'Dirichlet $L$-functions', '', 2),
(4, '3BF9', NULL, 'chapter', 'The generalized Riemann hypothesis', '', 2),
(5, '3BG4', 4, 'section', 'Statement and a first consequence', '', 1);

INSERT INTO results (id, tag, type, title, statement_tex, section_id, position) VALUES
(1, '4CHK', 'definition', 'Dirichlet character',
'A \emph{Dirichlet character modulo $q$} is a function $\chi\colon \Z \to \C$ such that
\begin{enumerate}
\item $\chi(n + q) = \chi(n)$ for all $n$;
\item $\chi(mn) = \chi(m)\chi(n)$ for all $m, n$;
\item $\chi(n) \neq 0$ if and only if $\gcd(n, q) = 1$.
\end{enumerate}
The character with $\chi(n) = 1$ for all $n$ coprime to $q$ is the \emph{principal character} $\chi_0$.', 2, 1),

(2, '4CJM', 'lemma', 'Orthogonality',
'Let $\chi$ be a Dirichlet character modulo $q$ in the sense of \ref{4CHK}. Then
\[ \sum_{n \bmod q} \chi(n) = \begin{cases} \varphi(q) & \text{if } \chi = \chi_0, \\ 0 & \text{otherwise.} \end{cases} \]', 2, 2),

(3, '4CKN', 'remark', '',
'The characters modulo $q$ form a group isomorphic to $(\Z/q\Z)^\times$; together with \ref{4CJM} this gives the
``dual'' orthogonality relation summing over characters. See \cite[Ch.~4]{Davenport}.', 2, 3),

(4, '5DMP', 'definition', 'Dirichlet $L$-function',
'For a Dirichlet character $\chi$ (see \ref{4CHK}) and $\Re s > 1$ put
\[ L(s, \chi) = \sum_{n \ge 1} \frac{\chi(n)}{n^s} = \prod_p \left(1 - \frac{\chi(p)}{p^s}\right)^{-1}. \]', 3, 1),

(5, '5DNQ', 'proposition', 'Non-vanishing at $s = 1$',
'If $\chi \neq \chi_0$, then $L(s, \chi)$ (defined in \ref{5DMP}) extends holomorphically to $\Re s > 0$ and
$L(1, \chi) \neq 0$.', 3, 2),

(6, '5DPR', 'theorem', 'Dirichlet',
'Let $a, q$ be integers with $\gcd(a, q) = 1$. Then there are infinitely many primes $p \equiv a \pmod q$.', 3, 3),

(7, '6EQS', 'conjecture', 'Generalized Riemann Hypothesis',
'For every Dirichlet character $\chi$, every zero $\rho$ of $L(s, \chi)$ (see \ref{5DMP}) with $0 < \Re\rho < 1$
satisfies $\Re \rho = \tfrac12$.', 5, 1),

(8, '6ERT', 'theorem', 'Ankeny',
'Assume \ref{6EQS}. Then for every odd prime $p$ the least quadratic non-residue modulo $p$ is
$O\big((\log p)^2\big)$.', 5, 2);

INSERT INTO proofs (id, result_id, position, body_tex, status, generated_by, generator_detail, reviewed_by, review_notes) VALUES
(1, 2, 1,
'If $\chi = \chi_0$ the sum counts residues coprime to $q$. Otherwise pick $m$ coprime to $q$ with $\chi(m) \neq 1$.
Since $n \mapsto mn$ permutes residues modulo $q$,
\[ \chi(m) \sum_{n} \chi(n) = \sum_n \chi(mn) = \sum_n \chi(n), \]
so the sum vanishes.', 'polished', 'human', NULL, 'editor', NULL),

(2, 5, 1,
'Holomorphy follows from partial summation, since the partial sums of $\chi(n)$ are bounded by \ref{4CJM}.
For non-vanishing, consider $\zeta_q(s) = \prod_{\chi} L(s, \chi)$, which has non-negative Dirichlet coefficients;
a zero at $s = 1$ would cancel the pole of $L(s, \chi_0)$ and contradict Landau''s theorem.', 'polishing', 'claude', 'placeholder', NULL,
'Need to treat real characters separately.'),

(3, 6, 1,
'Using \ref{4CJM} we isolate the progression:
\[ \sum_{p \equiv a \,(q)} \frac{1}{p^s} = \frac{1}{\varphi(q)} \sum_{\chi} \overline{\chi}(a) \log L(s, \chi) + O(1). \]
As $s \to 1^+$ the term with $\chi_0$ tends to $\infty$, while the others stay bounded by \ref{5DNQ}.', 'ai_generated', 'gpt', 'placeholder', NULL, NULL),

(4, 6, 2,
'An alternative route goes through the prime number theorem for arithmetic progressions; see \cite{IK}.', 'ai_generated', 'claude', 'placeholder', NULL, NULL),

(5, 8, 1,
'Under \ref{6EQS} one has an explicit formula for $\sum_{n \le x} \chi(n)\Lambda(n)$ with error
$O(x^{1/2}\log^2 x)$ for the Legendre symbol $\chi$; choosing $x \asymp (\log p)^2$ forces some $n \le x$ with
$\chi(n) = -1$.', 'ai_generated', 'gpt', 'placeholder', NULL, NULL);

-- Reference graph (normally derived on save; "Re-render everything" on the Settings page recomputes it).
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
(2, NULL, '4CHK'), (3, NULL, '4CJM'), (4, NULL, '4CHK'), (5, NULL, '5DMP'), (7, NULL, '5DMP'), (8, NULL, '6EQS'),
(5, 2, '4CJM'), (6, 3, '4CJM'), (6, 3, '5DNQ'), (8, 5, '6EQS');
