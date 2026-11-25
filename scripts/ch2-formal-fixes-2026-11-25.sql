-- Formalize the Chapter 2 estimates and the interval proof (2026-11-25 17:30:00).

INSERT OR ROLLBACK INTO write_guard (ok) SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM sections WHERE id = 103 AND tag = '7HH9' AND revision = 2)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id = 106 AND tag = '8JU3' AND revision = 4)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id = 107 AND tag = '8JU4' AND revision = 4)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id = 108 AND tag = '8JU5' AND revision = 1)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id = 109 AND tag = '8JU6' AND revision = 1)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 110 AND tag = '8JK2' AND section_id = 103 AND position = 1 AND revision = 2)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 126 AND tag = '8JU7' AND section_id = 106 AND position = 1 AND revision = 1)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 128 AND tag = '8JU9' AND section_id = 107 AND position = 1 AND revision = 2)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 129 AND tag = '8JUA' AND section_id = 107 AND position = 2 AND revision = 1)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 132 AND tag = '8JUD' AND section_id = 108 AND position = 1 AND revision = 1)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 133 AND tag = '8JUE' AND section_id = 108 AND position = 2 AND revision = 1)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 134 AND tag = '8JUF' AND section_id = 109 AND position = 1 AND revision = 1)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 135 AND tag = '8JUG' AND section_id = 109 AND position = 2 AND revision = 1)
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id = 117 AND result_id = 132 AND position = 1 AND revision = 1)
  OR NOT EXISTS (SELECT 1 FROM proofs WHERE id = 119 AND result_id = 134 AND position = 1 AND revision = 1)
  OR (SELECT COUNT(*) FROM results WHERE section_id = 108) <> 2
  OR EXISTS (SELECT 1 FROM results WHERE id = 153 OR tag = '8JUW')
  OR EXISTS (SELECT 1 FROM proofs WHERE id = 131 OR result_id = 110)
  OR EXISTS (SELECT 1 FROM tags WHERE tag = '8JUW')
  OR EXISTS (SELECT 1 FROM aliases WHERE alias = 'arithmetic-auxiliary-character-sum')
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'result' AND (entity_key = '153' OR (entity_key IN ('132', '133', '134') AND revision > 1)))
  OR EXISTS (SELECT 1 FROM revisions WHERE entity = 'proof' AND (entity_key = '131' OR (entity_key IN ('117', '119') AND revision > 1)))
  OR (SELECT COUNT(*) FROM tags WHERE tag IN ('8JF7', '8JG8', '8JU4', '8JU7', '8JU9', '8JUA', '8JUD', '8JUE', '8JUF', '8JUG')) <> 10;

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at) VALUES
  ('result', '132', 1, 'ch2-formal-fixes-2026-11-25', '{"tag":"8JUD","type":"lemma","title":"The averaged inequality","statement_tex":"With the data of \\ref{8JUA}, set $Q=hmb$ and $\\delta_2=h_2/n$. Let $\\Sigma(x)$ be the sum of $|G_\\alpha(x)|$ over the auxiliary characters trivial on $A_0$ outside the retained family, counted with their multiplicities as characters of $B$. Here $G_\\alpha$ is evaluated at the primitive representative. Throughout the common interval,\n\\begin{align*}\n\\frac{Q\\delta_2}{2}\\bigl(\\mathcal G_\\psi(x)-\\Sigma(x)\n   -4x^{1/2+\\varepsilon}\\bigr) &\\le E_{\\rm err}+\\frac{2Q}{x},\\\\\n\\Sigma(x)&\\le 4o\\,x^{1/2+\\varepsilon}.\n\\end{align*}","section_id":108,"position":1,"listed":1,"aliases":["arithmetic-fourier-average"]}', 'codex', '2026-11-25 17:30:00'),
  ('result', '133', 1, 'ch2-formal-fixes-2026-11-25', '{"tag":"8JUE","type":"lemma","title":"Replacing weights and returning to the scale $x$","statement_tex":"For every primitive $\\chi$ and all real $a,w,w''>0$,\n$$\n\\left|wG_\\chi(a/w)-w''G_\\chi(a/w'')\\right|\n\\le \\frac{3a}{\\min(w,w'')}|w-w''|,\n$$\nwhen $a/w,a/w''\\ge 1$.","section_id":108,"position":2,"listed":0,"aliases":[]}', 'codex', '2026-11-25 17:30:00'),
  ('result', '134', 1, 'ch2-formal-fixes-2026-11-25', '{"tag":"8JUF","type":"proposition","title":"The interval estimate from the four errors","statement_tex":"There is a constant $C_{\\psi,\\varepsilon}>0$ such that for every real $x$ on any common interval of \\ref{8JU7},\n$$\n\\mathcal G_\\psi(x)\\le C_{\\psi,\\varepsilon}x^{1/2+(e_D+e_L+45/8)\\varepsilon}.\n$$","section_id":109,"position":1,"listed":1,"aliases":["arithmetic-four-error-bound"]}', 'codex', '2026-11-25 17:30:00'),
  ('proof', '117', 1, 'ch2-formal-fixes-2026-11-25', '{"result_id":132,"position":1,"body_tex":"\\emph{Idea.} Expand the local count in characters, use the large weights to read off the sum at scale $x$, and average in two stages.\n\n\\emph{(1)} \\textbf{Inertia averaging gives the Fourier expansion at every prime.} For a character $\\xi$ of $B$ set $c_\\xi(p^i)=|I_p|^{-1}\\sum_{v\\in I_p}\\xi(iF_p+v)$. For $g\\in B$, orthogonality gives\n$$\n\\frac1f\\sum_{\\xi\\in\\widehat B}\\overline{\\xi(g)}c_\\xi(p^i)\n=\\frac2{|I_p|}\\mathbf 1_{g-iF_p\\in I_p}.\n$$\nHere $2=|B|/f$. Substituting this in \\ref{8JU9} and using $(a/p^i-w)_+=w((a/w)/p^i-1)_+$ gives $wG_\\xi(a/w)$ together with the main term $M(a,w)$. The trivial character contributes the logarithmic term. The sign character equals $-1$ off $\\Phi$ and gives the term $a(L''/L)(1,\\xi_c)$.\n\n\\emph{(2)} \\textbf{Averaging over $A_0$ leaves a coefficient $\\delta_2/2$.} The $h_2$ large weights are indexed by a subset of $A_0$. Replace them by $b$, discard the small weights, and later return to $x$ using $|a_t/b-x|\\le 1$. The \\hyperref[8JUE]{weight estimates} control these replacements. For a large-weight index $z\\in A_0$, the Fourier factors depending on $u,z$ are $\\xi(-u)\\xi(-z)$, where $A$ is embedded in $B$. Their average over $u\\in A_0$ vanishes unless $\\xi|_{A_0}=1$. In that case the factor in $z$ is also $1$, giving $b h_2/f=b\\delta_2/2$ at each level and translate.\n\n\\emph{(3)} \\textbf{The coset distribution retains the powers of $\\psi$ with their prescribed weights.} On $A/A_0$ the target distribution is $\\lambda_\\alpha=(3+\\mathbf 1_{\\alpha\\in A_0})/(3o+1)$. Its Fourier coefficient at the trivial character is $1$. For any nontrivial character, the constant part sums to zero and the atom at the identity contributes $1/(3o+1)$. Thus the retained terms have exactly the coefficients of $\\mathcal G_\\psi$ in \\ref{8JG8}. The error from the coset proportions and the return to $x$ is bounded in \\cite[Sections 13--14]{Outline} by $4x^{1/2+\\varepsilon}$ at the normalized scale. Every remaining character has at least one of the two auxiliary quadratic factors. There are at most $4o$ such terms, and the joint choice of $q,d$ bounds their absolute values by $x^{1/2+\\varepsilon}$. Averaging the upper bound for $\\Delta_u$ now gives the two inequalities.","status":"ai_generated","generated_by":"gpt","generator_detail":"Codex","reviewed_by":null,"review_notes":null}', 'codex', '2026-11-25 17:30:00'),
  ('proof', '119', 1, 'ch2-formal-fixes-2026-11-25', '{"result_id":134,"position":1,"body_tex":"The four terms of $\\mathcal B$, divided by $Q=hmb$, are\n$$\n\\frac{a_E}{mb},\\qquad\\frac{a_E m}{bk},\\qquad\n\\frac{2nmx^\\varepsilon}{h},\\qquad\\frac{h_2kx^{2\\varepsilon}}{hn^2}.\n$$\nThe first and third terms have sizes $x/m$ and $m$, up to small powers of $x$. Balancing them explains the choice of a chain of length near $\\sqrt x$. The \\hyperref[8JUG]{scale inequalities} give $\\mathcal B/Q\\ll x^{1/2+13\\varepsilon/8}$ and $\\delta_2^{-1}\\le x^\\varepsilon$. Combining the two bounds for the average gives\n\\begin{alignat*}{2}\n\\mathcal G_\\psi(x)\n&\\le \\frac{2E_{\\rm err}}{Q\\delta_2}\n   +\\frac{4}{x\\delta_2}+(4+4o)x^{1/2+\\varepsilon}\n&&\\quad\\text{(a)}\\\\\n&\\le C_{\\psi,\\varepsilon}x^{1/2+(e_D+e_L+45/8)\\varepsilon}\n&&\\quad\\text{(b)}\n\\end{alignat*}\nIn (a) use \\ref{8JUD} and divide by $Q\\delta_2/2$. In (b) use \\ref{8JUA} and the scale inequalities. The exponent gain is $45/8=3+13/8+1$, with the final $1$ coming from $\\delta_2^{-1}$.\n\nTo obtain \\ref{8JK2}, increase the prescribed lower endpoint $Y_0$ before choosing the interval so that $x^{(7-45/8)\\varepsilon}\\ge C_{\\psi,\\varepsilon}$ throughout it. Then $e_D=2$ and $e_L=0$ give $\\mathcal G_\\psi(x)\\le x^{1/2+9\\varepsilon}$ for every real $x$ in the interval.","status":"ai_generated","generated_by":"gpt","generator_detail":"Codex","reviewed_by":null,"review_notes":null}', 'codex', '2026-11-25 17:30:00');

INSERT INTO tags (tag, kind, created_at) VALUES
  ('8JUW', 'result', '2026-11-25 17:30:00');

INSERT INTO aliases (alias, tag, created_at) VALUES
  ('arithmetic-auxiliary-character-sum', '8JUW', '2026-11-25 17:30:00');

UPDATE results SET position = 3, statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 17:30:00', updated_by = 'codex' WHERE id = 133;

UPDATE results SET statement_tex = 'Let $\psi$ be the fixed primitive character of order $o$. For every real $x$ in a common interval of \ref{8JU7}, use the data of \ref{8JUA}, set $Q=hmb$ and $\delta_2=h_2/n$, and let $\Sigma(x)$ be the \hyperref[8JUW]{auxiliary-character sum}. Then
\begin{align*}
\frac{Q\delta_2}{2}\bigl(\mathcal G_\psi(x)-\Sigma(x)
   -4x^{1/2+\varepsilon}\bigr) &\leqslant E_{\rm err}+\frac{2Q}{x},\\
\Sigma(x)&\leqslant 4o\,x^{1/2+\varepsilon}.
\end{align*}',
  position = 2, statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 17:30:00', updated_by = 'codex' WHERE id = 132;

UPDATE results SET statement_tex = 'Fix a primitive character $\psi$ and let $\varepsilon_0$ be as in \ref{8JU7}. For every $0<\varepsilon<\varepsilon_0$ there is a constant $C_{\psi,\varepsilon}>0$ such that for every common interval $[Y,Y^{3/2}]$ supplied by \ref{8JU7} and every real $x\in[Y,Y^{3/2}]$,
$$
\mathcal G_\psi(x)\leqslant C_{\psi,\varepsilon}x^{1/2+(e_D+e_L+45/8)\varepsilon}.
$$',
  position = 1, statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 17:30:00', updated_by = 'codex' WHERE id = 134;

INSERT INTO results (id, tag, type, title, statement_tex, section_id, position, listed, statement_html_cache, visibility, revision, created_at, updated_at, created_by, updated_by) VALUES
  (153, '8JUW', 'definition', 'The auxiliary-character sum $\Sigma(x)$', 'Fix a primitive character $\psi$. For every real $x$ in a common interval of \ref{8JU7}, take $A$, $A_0$, $q$, and $d$ from that construction and write $B=(\Z/2\Z)^2\times A$ as in \ref{8JU4}. Let $\widehat B$ be the character group of $B$, with restriction to $A_0$ along $u\mapsto ((0,0),u)$. Write $\xi^*$ for the primitive representative of $\xi\in\widehat B$ and $\mathcal C_\psi$ for the \hyperref[8JG8]{retained cyclic family}. Using the \hyperref[8JF7]{smoothed prime sums}, define
$$
\Sigma(x)=\sum_{\substack{\xi\in\widehat B,\ \xi|_{A_0}=1\\
                         \xi^*\notin\mathcal C_\psi}} |G_{\xi^*}(x)|.
$$
The indices are the characters of $B$ trivial on $A_0$ that carry a quadratic factor from $q$ or $d$. Each such character of $B$ contributes one summand.', 108, 1, 1, NULL, 'published', 1, '2026-11-25 17:30:00', '2026-11-25 17:30:00', 'codex', 'codex');

UPDATE proofs SET body_tex = '\emph{Idea.} Expand the local count in characters, use the large weights to read off the sum at scale $x$, and average in two stages.

\emph{(1)} \textbf{Inertia averaging gives the Fourier expansion at every prime.} For a character $\xi$ of $B$ set $c_\xi(p^i)=|I_p|^{-1}\sum_{v\in I_p}\xi(iF_p+v)$. For $g\in B$, orthogonality gives
$$
\frac1f\sum_{\xi\in\widehat B}\overline{\xi(g)}c_\xi(p^i)
=\frac2{|I_p|}\mathbf 1_{g-iF_p\in I_p}.
$$
Here $2=|B|/f$. Substituting this in \ref{8JU9} and using $(a/p^i-w)_+=w((a/w)/p^i-1)_+$ gives $wG_\xi(a/w)$ together with the main term $M(a,w)$. The trivial character contributes the logarithmic term. The sign character equals $-1$ off $\Phi$ and gives the term $a(L''/L)(1,\xi_c)$.

\emph{(2)} \textbf{Averaging over $A_0$ leaves a coefficient $\delta_2/2$.} The $h_2$ large weights are indexed by a subset of $A_0$. Replace them by $b$, discard the small weights, and later return to $x$ using $|a_t/b-x|\le 1$. The \hyperref[8JUE]{weight estimates} control these replacements. For a large-weight index $z\in A_0$, the Fourier factors depending on $u,z$ are $\xi(-u)\xi(-z)$, where $A$ is embedded in $B$. Their average over $u\in A_0$ vanishes unless $\xi|_{A_0}=1$. In that case the factor in $z$ is also $1$, giving $b h_2/f=b\delta_2/2$ at each level and translate.

\emph{(3)} \textbf{The coset distribution retains the powers of $\psi$ with their prescribed weights.} On $A/A_0$ the target distribution is $\lambda_\alpha=(3+\mathbf 1_{\alpha\in A_0})/(3o+1)$. Its Fourier coefficient at the trivial character is $1$. For any nontrivial character, the constant part sums to zero and the atom at the identity contributes $1/(3o+1)$. Thus the retained terms have exactly the coefficients of $\mathcal G_\psi$ in \ref{8JG8}. The error from the coset proportions and the return to $x$ is bounded in \cite[Sections 13--14]{Outline} by $4x^{1/2+\varepsilon}$ at the normalized scale. The sum $\Sigma(x)$ of \ref{8JUW} has at most $4o$ terms, and the joint choice of $q,d$ bounds each term by $x^{1/2+\varepsilon}$. Averaging the upper bound for $\Delta_u$ now gives the two inequalities.',
  body_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 17:30:00', updated_by = 'codex' WHERE id = 117;

UPDATE proofs SET body_tex = 'Fix a common interval of \ref{8JU7} for the given $\psi$ and $\varepsilon$, and a real $x$ in that interval. Let $o$ be the order of $\psi$ and take $e_D=2$, $e_L=0$ from \ref{8JU7}. Use $\mathcal B$, $E_{\rm err}$, and the parameters $h,m,b,a_E,k,n,h_2$ from \ref{8JUA}, and $Q=hmb$ and $\delta_2=h_2/n$ from \ref{8JUD}. Let $\Sigma(x)$ be the sum in \ref{8JUW}.

The four terms of $\mathcal B/Q$ are
$$
\frac{a_E}{mb},\qquad\frac{a_E m}{bk},\qquad
\frac{2nmx^\varepsilon}{h},\qquad\frac{h_2kx^{2\varepsilon}}{hn^2}.
$$
Up to small powers of $x$, the first and third terms have sizes $x/m$ and $m$. Their balance explains the choice of a chain of length near $\sqrt x$.

Set $C_{\psi,\varepsilon}=20+4+4+4o$. The estimate is
\begin{alignat*}{2}
\mathcal G_\psi(x)
&\leqslant \frac{2E_{\rm err}}{Q\delta_2}+\frac{4}{x\delta_2}
   +\Sigma(x)+4x^{1/2+\varepsilon}
&&\quad\text{(a)}\\
&\leqslant \frac{2E_{\rm err}}{Q\delta_2}+\frac{4}{x\delta_2}
   +(4+4o)x^{1/2+\varepsilon}
&&\quad\text{(b)}\\
&\leqslant \frac{2\mathcal B}{Q\delta_2}x^{(e_D+e_L+3)\varepsilon}
   +\frac{4}{x\delta_2}+(4+4o)x^{1/2+\varepsilon}
&&\quad\text{(c)}\\
&\leqslant \frac{20}{\delta_2}x^{1/2+(e_D+e_L+37/8)\varepsilon}
   +\frac{4}{x\delta_2}+(4+4o)x^{1/2+\varepsilon}
&&\quad\text{(d)}\\
&\leqslant 20x^{1/2+(e_D+e_L+45/8)\varepsilon}
   +\frac{4}{x\delta_2}+(4+4o)x^{1/2+\varepsilon}
&&\quad\text{(e)}\\
&\leqslant 20x^{1/2+(e_D+e_L+45/8)\varepsilon}
   +4x^{\varepsilon-1}+(4+4o)x^{1/2+\varepsilon}
&&\quad\text{(f)}\\
&\leqslant C_{\psi,\varepsilon}x^{1/2+(e_D+e_L+45/8)\varepsilon}.
&&\quad\text{(g)}
\end{alignat*}

(a) Solve the averaged inequality of \ref{8JUD} for $\mathcal G_\psi(x)$ by dividing by $Q\delta_2/2>0$.

(b) Use $\Sigma(x)\leqslant 4o\,x^{1/2+\varepsilon}$ from \ref{8JUD}.

(c) Apply the bound for $E_{\rm err}$ from \ref{8JUA}.

(d) Use $\mathcal B/Q\leqslant 10x^{1/2+13\varepsilon/8}$ from \ref{8JUG} and $3+13/8=37/8$.

(e) Use $\delta_2^{-1}\leqslant x^\varepsilon$ from \ref{8JUG} in the first term and $37/8+1=45/8$.

(f) Use the same bound for $\delta_2^{-1}$ in the second term.

(g) For $x\geqslant1$, both $x^{\varepsilon-1}$ and $x^{1/2+\varepsilon}$ are at most $x^{1/2+(e_D+e_L+45/8)\varepsilon}$.',
  body_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-25 17:30:00', updated_by = 'codex' WHERE id = 119;

INSERT INTO proofs (id, result_id, position, body_tex, status, generated_by, generator_detail, reviewed_by, review_notes, body_html_cache, revision, created_at, updated_at, created_by, updated_by) VALUES
  (131, 110, 1, 'Fix a primitive character $\psi$ and take $\varepsilon_0>0$ from \ref{8JU7}. Given $0<\varepsilon<\varepsilon_0$ and real $Y_0\geqslant1$, take the constant $C_{\psi,\varepsilon}$ from \ref{8JUF} and set
$$
Y_0''=\max\bigl(Y_0,C_{\psi,\varepsilon}^{8/(11\varepsilon)}\bigr).
$$
Apply \ref{8JU7} with lower endpoint $Y_0''$ to obtain a common interval $[Y,Y^{3/2}]$ with $Y\geqslant Y_0''$ and exponents $e_D=2$, $e_L=0$. For every real $x\in[Y,Y^{3/2}]$ we have $x^{11\varepsilon/8}\geqslant C_{\psi,\varepsilon}$, so \ref{8JUF} gives
\begin{alignat*}{2}
\mathcal G_\psi(x)&\leqslant C_{\psi,\varepsilon}x^{1/2+(e_D+e_L+45/8)\varepsilon}\\
&=C_{\psi,\varepsilon}x^{1/2+61\varepsilon/8}\\
&\leqslant x^{1/2+9\varepsilon}.
\end{alignat*}', 'ai_generated', 'gpt', 'Codex', NULL, NULL, NULL, 1, '2026-11-25 17:30:00', '2026-11-25 17:30:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at) VALUES
  ('result', '132', 2, 'ch2-formal-fixes-2026-11-25', '{"tag":"8JUD","type":"lemma","title":"The averaged inequality","statement_tex":"Let $\\psi$ be the fixed primitive character of order $o$. For every real $x$ in a common interval of \\ref{8JU7}, use the data of \\ref{8JUA}, set $Q=hmb$ and $\\delta_2=h_2/n$, and let $\\Sigma(x)$ be the \\hyperref[8JUW]{auxiliary-character sum}. Then\n\\begin{align*}\n\\frac{Q\\delta_2}{2}\\bigl(\\mathcal G_\\psi(x)-\\Sigma(x)\n   -4x^{1/2+\\varepsilon}\\bigr) &\\leqslant E_{\\rm err}+\\frac{2Q}{x},\\\\\n\\Sigma(x)&\\leqslant 4o\\,x^{1/2+\\varepsilon}.\n\\end{align*}","section_id":108,"position":2,"listed":1,"aliases":["arithmetic-fourier-average"]}', 'codex', '2026-11-25 17:30:00'),
  ('result', '133', 2, 'ch2-formal-fixes-2026-11-25', '{"tag":"8JUE","type":"lemma","title":"Replacing weights and returning to the scale $x$","statement_tex":"For every primitive $\\chi$ and all real $a,w,w''>0$,\n$$\n\\left|wG_\\chi(a/w)-w''G_\\chi(a/w'')\\right|\n\\le \\frac{3a}{\\min(w,w'')}|w-w''|,\n$$\nwhen $a/w,a/w''\\ge 1$.","section_id":108,"position":3,"listed":0,"aliases":[]}', 'codex', '2026-11-25 17:30:00'),
  ('result', '134', 2, 'ch2-formal-fixes-2026-11-25', '{"tag":"8JUF","type":"proposition","title":"The interval estimate from the four errors","statement_tex":"Fix a primitive character $\\psi$ and let $\\varepsilon_0$ be as in \\ref{8JU7}. For every $0<\\varepsilon<\\varepsilon_0$ there is a constant $C_{\\psi,\\varepsilon}>0$ such that for every common interval $[Y,Y^{3/2}]$ supplied by \\ref{8JU7} and every real $x\\in[Y,Y^{3/2}]$,\n$$\n\\mathcal G_\\psi(x)\\leqslant C_{\\psi,\\varepsilon}x^{1/2+(e_D+e_L+45/8)\\varepsilon}.\n$$","section_id":109,"position":1,"listed":1,"aliases":["arithmetic-four-error-bound"]}', 'codex', '2026-11-25 17:30:00'),
  ('result', '153', 1, 'ch2-formal-fixes-2026-11-25', '{"tag":"8JUW","type":"definition","title":"The auxiliary-character sum $\\Sigma(x)$","statement_tex":"Fix a primitive character $\\psi$. For every real $x$ in a common interval of \\ref{8JU7}, take $A$, $A_0$, $q$, and $d$ from that construction and write $B=(\\Z/2\\Z)^2\\times A$ as in \\ref{8JU4}. Let $\\widehat B$ be the character group of $B$, with restriction to $A_0$ along $u\\mapsto ((0,0),u)$. Write $\\xi^*$ for the primitive representative of $\\xi\\in\\widehat B$ and $\\mathcal C_\\psi$ for the \\hyperref[8JG8]{retained cyclic family}. Using the \\hyperref[8JF7]{smoothed prime sums}, define\n$$\n\\Sigma(x)=\\sum_{\\substack{\\xi\\in\\widehat B,\\ \\xi|_{A_0}=1\\\\\n                         \\xi^*\\notin\\mathcal C_\\psi}} |G_{\\xi^*}(x)|.\n$$\nThe indices are the characters of $B$ trivial on $A_0$ that carry a quadratic factor from $q$ or $d$. Each such character of $B$ contributes one summand.","section_id":108,"position":1,"listed":1,"aliases":["arithmetic-auxiliary-character-sum"]}', 'codex', '2026-11-25 17:30:00'),
  ('proof', '117', 2, 'ch2-formal-fixes-2026-11-25', '{"result_id":132,"position":1,"body_tex":"\\emph{Idea.} Expand the local count in characters, use the large weights to read off the sum at scale $x$, and average in two stages.\n\n\\emph{(1)} \\textbf{Inertia averaging gives the Fourier expansion at every prime.} For a character $\\xi$ of $B$ set $c_\\xi(p^i)=|I_p|^{-1}\\sum_{v\\in I_p}\\xi(iF_p+v)$. For $g\\in B$, orthogonality gives\n$$\n\\frac1f\\sum_{\\xi\\in\\widehat B}\\overline{\\xi(g)}c_\\xi(p^i)\n=\\frac2{|I_p|}\\mathbf 1_{g-iF_p\\in I_p}.\n$$\nHere $2=|B|/f$. Substituting this in \\ref{8JU9} and using $(a/p^i-w)_+=w((a/w)/p^i-1)_+$ gives $wG_\\xi(a/w)$ together with the main term $M(a,w)$. The trivial character contributes the logarithmic term. The sign character equals $-1$ off $\\Phi$ and gives the term $a(L''/L)(1,\\xi_c)$.\n\n\\emph{(2)} \\textbf{Averaging over $A_0$ leaves a coefficient $\\delta_2/2$.} The $h_2$ large weights are indexed by a subset of $A_0$. Replace them by $b$, discard the small weights, and later return to $x$ using $|a_t/b-x|\\le 1$. The \\hyperref[8JUE]{weight estimates} control these replacements. For a large-weight index $z\\in A_0$, the Fourier factors depending on $u,z$ are $\\xi(-u)\\xi(-z)$, where $A$ is embedded in $B$. Their average over $u\\in A_0$ vanishes unless $\\xi|_{A_0}=1$. In that case the factor in $z$ is also $1$, giving $b h_2/f=b\\delta_2/2$ at each level and translate.\n\n\\emph{(3)} \\textbf{The coset distribution retains the powers of $\\psi$ with their prescribed weights.} On $A/A_0$ the target distribution is $\\lambda_\\alpha=(3+\\mathbf 1_{\\alpha\\in A_0})/(3o+1)$. Its Fourier coefficient at the trivial character is $1$. For any nontrivial character, the constant part sums to zero and the atom at the identity contributes $1/(3o+1)$. Thus the retained terms have exactly the coefficients of $\\mathcal G_\\psi$ in \\ref{8JG8}. The error from the coset proportions and the return to $x$ is bounded in \\cite[Sections 13--14]{Outline} by $4x^{1/2+\\varepsilon}$ at the normalized scale. The sum $\\Sigma(x)$ of \\ref{8JUW} has at most $4o$ terms, and the joint choice of $q,d$ bounds each term by $x^{1/2+\\varepsilon}$. Averaging the upper bound for $\\Delta_u$ now gives the two inequalities.","status":"ai_generated","generated_by":"gpt","generator_detail":"Codex","reviewed_by":null,"review_notes":null}', 'codex', '2026-11-25 17:30:00'),
  ('proof', '119', 2, 'ch2-formal-fixes-2026-11-25', '{"result_id":134,"position":1,"body_tex":"Fix a common interval of \\ref{8JU7} for the given $\\psi$ and $\\varepsilon$, and a real $x$ in that interval. Let $o$ be the order of $\\psi$ and take $e_D=2$, $e_L=0$ from \\ref{8JU7}. Use $\\mathcal B$, $E_{\\rm err}$, and the parameters $h,m,b,a_E,k,n,h_2$ from \\ref{8JUA}, and $Q=hmb$ and $\\delta_2=h_2/n$ from \\ref{8JUD}. Let $\\Sigma(x)$ be the sum in \\ref{8JUW}.\n\nThe four terms of $\\mathcal B/Q$ are\n$$\n\\frac{a_E}{mb},\\qquad\\frac{a_E m}{bk},\\qquad\n\\frac{2nmx^\\varepsilon}{h},\\qquad\\frac{h_2kx^{2\\varepsilon}}{hn^2}.\n$$\nUp to small powers of $x$, the first and third terms have sizes $x/m$ and $m$. Their balance explains the choice of a chain of length near $\\sqrt x$.\n\nSet $C_{\\psi,\\varepsilon}=20+4+4+4o$. The estimate is\n\\begin{alignat*}{2}\n\\mathcal G_\\psi(x)\n&\\leqslant \\frac{2E_{\\rm err}}{Q\\delta_2}+\\frac{4}{x\\delta_2}\n   +\\Sigma(x)+4x^{1/2+\\varepsilon}\n&&\\quad\\text{(a)}\\\\\n&\\leqslant \\frac{2E_{\\rm err}}{Q\\delta_2}+\\frac{4}{x\\delta_2}\n   +(4+4o)x^{1/2+\\varepsilon}\n&&\\quad\\text{(b)}\\\\\n&\\leqslant \\frac{2\\mathcal B}{Q\\delta_2}x^{(e_D+e_L+3)\\varepsilon}\n   +\\frac{4}{x\\delta_2}+(4+4o)x^{1/2+\\varepsilon}\n&&\\quad\\text{(c)}\\\\\n&\\leqslant \\frac{20}{\\delta_2}x^{1/2+(e_D+e_L+37/8)\\varepsilon}\n   +\\frac{4}{x\\delta_2}+(4+4o)x^{1/2+\\varepsilon}\n&&\\quad\\text{(d)}\\\\\n&\\leqslant 20x^{1/2+(e_D+e_L+45/8)\\varepsilon}\n   +\\frac{4}{x\\delta_2}+(4+4o)x^{1/2+\\varepsilon}\n&&\\quad\\text{(e)}\\\\\n&\\leqslant 20x^{1/2+(e_D+e_L+45/8)\\varepsilon}\n   +4x^{\\varepsilon-1}+(4+4o)x^{1/2+\\varepsilon}\n&&\\quad\\text{(f)}\\\\\n&\\leqslant C_{\\psi,\\varepsilon}x^{1/2+(e_D+e_L+45/8)\\varepsilon}.\n&&\\quad\\text{(g)}\n\\end{alignat*}\n\n(a) Solve the averaged inequality of \\ref{8JUD} for $\\mathcal G_\\psi(x)$ by dividing by $Q\\delta_2/2>0$.\n\n(b) Use $\\Sigma(x)\\leqslant 4o\\,x^{1/2+\\varepsilon}$ from \\ref{8JUD}.\n\n(c) Apply the bound for $E_{\\rm err}$ from \\ref{8JUA}.\n\n(d) Use $\\mathcal B/Q\\leqslant 10x^{1/2+13\\varepsilon/8}$ from \\ref{8JUG} and $3+13/8=37/8$.\n\n(e) Use $\\delta_2^{-1}\\leqslant x^\\varepsilon$ from \\ref{8JUG} in the first term and $37/8+1=45/8$.\n\n(f) Use the same bound for $\\delta_2^{-1}$ in the second term.\n\n(g) For $x\\geqslant1$, both $x^{\\varepsilon-1}$ and $x^{1/2+\\varepsilon}$ are at most $x^{1/2+(e_D+e_L+45/8)\\varepsilon}$.","status":"ai_generated","generated_by":"gpt","generator_detail":"Codex","reviewed_by":null,"review_notes":null}', 'codex', '2026-11-25 17:30:00'),
  ('proof', '131', 1, 'ch2-formal-fixes-2026-11-25', '{"result_id":110,"position":1,"body_tex":"Fix a primitive character $\\psi$ and take $\\varepsilon_0>0$ from \\ref{8JU7}. Given $0<\\varepsilon<\\varepsilon_0$ and real $Y_0\\geqslant1$, take the constant $C_{\\psi,\\varepsilon}$ from \\ref{8JUF} and set\n$$\nY_0''=\\max\\bigl(Y_0,C_{\\psi,\\varepsilon}^{8/(11\\varepsilon)}\\bigr).\n$$\nApply \\ref{8JU7} with lower endpoint $Y_0''$ to obtain a common interval $[Y,Y^{3/2}]$ with $Y\\geqslant Y_0''$ and exponents $e_D=2$, $e_L=0$. For every real $x\\in[Y,Y^{3/2}]$ we have $x^{11\\varepsilon/8}\\geqslant C_{\\psi,\\varepsilon}$, so \\ref{8JUF} gives\n\\begin{alignat*}{2}\n\\mathcal G_\\psi(x)&\\leqslant C_{\\psi,\\varepsilon}x^{1/2+(e_D+e_L+45/8)\\varepsilon}\\\\\n&=C_{\\psi,\\varepsilon}x^{1/2+61\\varepsilon/8}\\\\\n&\\leqslant x^{1/2+9\\varepsilon}.\n\\end{alignat*}","status":"ai_generated","generated_by":"gpt","generator_detail":"Codex","reviewed_by":null,"review_notes":null}', 'codex', '2026-11-25 17:30:00');

DELETE FROM refs WHERE source_result_id IN (132, 134) AND source_proof_id IS NULL;
DELETE FROM refs WHERE source_proof_id IN (117, 119);

INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES
  (153, NULL, '8JU7'),
  (153, NULL, '8JU4'),
  (153, NULL, '8JG8'),
  (153, NULL, '8JF7'),
  (132, NULL, '8JU7'),
  (132, NULL, '8JUA'),
  (132, NULL, '8JUW'),
  (132, 117, '8JU9'),
  (132, 117, '8JUE'),
  (132, 117, '8JG8'),
  (132, 117, '8JUW'),
  (134, NULL, '8JU7'),
  (134, 119, '8JU7'),
  (134, 119, '8JUA'),
  (134, 119, '8JUD'),
  (134, 119, '8JUW'),
  (134, 119, '8JUG'),
  (110, 131, '8JU7'),
  (110, 131, '8JUF');
