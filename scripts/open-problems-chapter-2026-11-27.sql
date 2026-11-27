-- New Chapter 5 "Open problems" (tag PRB5), after Chapter 4 and before Appendix A.
--   5.1 Inputs of the proof (PRB6): PRB8 conjecture (Adriazola's hypotheses), PRB9 remark (what they give),
--                                   PRBA remark (explicit constants in Chapter 2).
--   5.2 Simple zeros (PRB7): PRBC conjecture, PRBD remark (what is known), PRBE remark (not needed here).

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  EXISTS (SELECT 1 FROM tags WHERE tag IN ('PRB5','PRB6','PRB7','PRB8','PRB9','PRBA','PRBC','PRBD','PRBE'))
  OR EXISTS (SELECT 1 FROM sections WHERE kind = 'chapter' AND appendix = 0 AND position >= 5)
  OR NOT EXISTS (SELECT 1 FROM results WHERE tag = 'JMUK') OR NOT EXISTS (SELECT 1 FROM results WHERE tag = 'ZFM6');

INSERT INTO tags (tag, kind, created_at) VALUES
  ('PRB5', 'section', '2026-11-27 23:00:00'), ('PRB6', 'section', '2026-11-27 23:00:00'), ('PRB7', 'section', '2026-11-27 23:00:00'),
  ('PRB8', 'result', '2026-11-27 23:00:00'), ('PRB9', 'result', '2026-11-27 23:00:00'), ('PRBA', 'result', '2026-11-27 23:00:00'),
  ('PRBC', 'result', '2026-11-27 23:00:00'), ('PRBD', 'result', '2026-11-27 23:00:00'), ('PRBE', 'result', '2026-11-27 23:00:00');

INSERT INTO sections (tag, parent_id, kind, title, intro_tex, intro_html_cache, position, appendix, created_at, updated_at, updated_by)
VALUES ('PRB5', NULL, 'chapter', 'Open problems',
'This chapter collects the problems the notes leave open: the inputs that the \hyperref[8JVG]{arithmetic bound} still assumes, and questions about the zeros that the argument does not need.',
NULL, 5, 0, '2026-11-27 23:00:00', '2026-11-27 23:00:00', 'claude');

INSERT INTO sections (tag, parent_id, kind, title, intro_tex, intro_html_cache, position, appendix, created_at, updated_at, updated_by)
SELECT 'PRB6', id, 'section', 'Inputs of the proof',
'The deduction of GRH in Chapter 1 is complete once the \hyperref[8JK2]{interval estimate} holds. Chapter 3 derives that estimate from the \hyperref[8JVG]{arithmetic bound}, and Chapter 4 outlines the arithmetic bound under two hypotheses of \cite{Adriazola}.',
NULL, 1, 0, '2026-11-27 23:00:00', '2026-11-27 23:00:00', 'claude'
FROM sections WHERE tag = 'PRB5';

INSERT INTO sections (tag, parent_id, kind, title, intro_tex, intro_html_cache, position, appendix, created_at, updated_at, updated_by)
SELECT 'PRB7', id, 'section', 'Simple zeros',
'Whether the zeros of $\zeta$ and of the Dirichlet $L$-functions are simple is open, with or without GRH. The argument of these notes works with \hyperref[8JS4]{multiplicities} throughout and does not need simplicity.',
NULL, 2, 0, '2026-11-27 23:00:00', '2026-11-27 23:00:00', 'claude'
FROM sections WHERE tag = 'PRB5';

INSERT INTO results (tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, state, listed,
                     created_at, updated_at, created_by, updated_by)
SELECT 'PRB8', 'conjecture', 'Field existence and chain records',
'The field-existence hypothesis and the chain-record hypothesis of \cite[Hypotheses 17.11 and 18.10]{Adriazola} hold.',
NULL, id, 1, 'published', 'active', 1, '2026-11-27 23:00:00', '2026-11-27 23:00:00', 'claude', 'claude'
FROM sections WHERE tag = 'PRB6';

INSERT INTO results (tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, state, listed,
                     created_at, updated_at, created_by, updated_by)
SELECT 'PRB9', 'remark', 'What the hypotheses give',
'Assume \ref{PRB8}. Then \ref{C4S2} supplies windows with admissible chains, Chapter 4 outlines the \hyperref[8JVG]{arithmetic bound}, \ref{8JVJ} turns it into the \hyperref[8JK2]{interval estimate}, and \ref{8JR6} gives GRH. Chapter 4 itself is an outline that follows \cite{Outline} and \cite{Adriazola}; a complete written proof of its steps, from \ref{C4S2} to \ref{8JUF}, is also open.',
NULL, id, 2, 'published', 'active', 1, '2026-11-27 23:00:00', '2026-11-27 23:00:00', 'claude', 'claude'
FROM sections WHERE tag = 'PRB6';

INSERT INTO results (tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, state, listed,
                     created_at, updated_at, created_by, updated_by)
SELECT 'PRBA', 'remark', 'Explicit constants in Chapter 2',
'The absolute constants $c$ and $n_0$ in \ref{JMUK}, and $c$, $C$ and $n_1$ in \ref{ZFM6}(D1), are not computed. The argument does not need their values, but explicit values would make the comparison in Chapter 2 effective.',
NULL, id, 3, 'published', 'active', 1, '2026-11-27 23:00:00', '2026-11-27 23:00:00', 'claude', 'claude'
FROM sections WHERE tag = 'PRB6';

INSERT INTO results (tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, state, listed,
                     created_at, updated_at, created_by, updated_by)
SELECT 'PRBC', 'conjecture', 'Simple zeros',
'For every \hyperref[8JH4]{primitive character} $\chi$, every zero $\rho$ of $L(s,\chi)$ with $0<\Re\rho<1$ is simple. For $\chi=\mathbf 1$: every nontrivial zero of $\zeta$ is simple.',
NULL, id, 1, 'published', 'active', 1, '2026-11-27 23:00:00', '2026-11-27 23:00:00', 'claude', 'claude'
FROM sections WHERE tag = 'PRB7';

INSERT INTO results (tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, state, listed,
                     created_at, updated_at, created_by, updated_by)
SELECT 'PRBD', 'remark', 'What is known about simple zeros',
'\begin{enumerate}
\item[(i)] \emph{Numerically.} The first $10^{13}$ nontrivial zeros of $\zeta$ are simple and lie on the critical line (Gourdon, 2004).
\item[(ii)] \emph{Unconditionally.} More than $\frac25$ of the nontrivial zeros of $\zeta$ are simple and on the critical line (Conrey, 1989).
\item[(iii)] \emph{Under the Riemann hypothesis.} At least about $\frac23$ of the zeros are simple, by Montgomery''s pair-correlation method (1973), and the multiplicity of a zero $\frac12+i\gamma$ is $O(\ln|\gamma|/\ln\ln|\gamma|)$. The Riemann hypothesis alone is not known to imply \ref{PRBC}: it says where the zeros are, while simplicity says $\zeta''(\rho)\ne0$.
\item[(iv)] \emph{Stronger hypotheses.} Montgomery''s pair-correlation conjecture implies that almost all zeros are simple. The linear independence of the ordinates $\gamma>0$ over $\mathbb Q$ implies \ref{PRBC} for $\zeta$. A bound $\sum_{n\le x}\mu(n)=O(\sqrt x)$ would imply both the Riemann hypothesis and \ref{PRBC} for $\zeta$.
\end{enumerate}',
NULL, id, 2, 'published', 'active', 1, '2026-11-27 23:00:00', '2026-11-27 23:00:00', 'claude', 'claude'
FROM sections WHERE tag = 'PRB7';

INSERT INTO results (tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, state, listed,
                     created_at, updated_at, created_by, updated_by)
SELECT 'PRBE', 'remark', 'Simplicity is not needed here',
'Near a zero $\rho$ of order $m$, $-L''(s,\chi)/L(s,\chi)$ has a simple pole with residue $-m$. So the poles of $H_\chi$ are simple whatever the multiplicities are (\ref{8JN4}), and the explicit formula counts each zero with its multiplicity (\ref{8JUK}). The \hyperref[8JT5]{lower bound for the Taylor coefficients} needs only that these residues are nonzero.',
NULL, id, 3, 'published', 'active', 1, '2026-11-27 23:00:00', '2026-11-27 23:00:00', 'claude', 'claude'
FROM sections WHERE tag = 'PRB7';

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'section', CAST(id AS TEXT), revision, 'open-problems-chapter-2026-11-27',
       json_object('tag', tag, 'parent_id', parent_id, 'kind', kind, 'title', title, 'intro_tex', intro_tex, 'position', position),
       'claude', '2026-11-27 23:00:00'
FROM sections WHERE tag IN ('PRB5', 'PRB6', 'PRB7');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'open-problems-chapter-2026-11-27',
       json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex, 'section_id', section_id,
                   'position', position, 'visibility', visibility, 'state', state, 'replaced_by_id', replaced_by_id, 'listed', listed),
       'claude', '2026-11-27 23:00:00'
FROM results WHERE tag IN ('PRB8', 'PRB9', 'PRBA', 'PRBC', 'PRBD', 'PRBE');

UPDATE settings SET value = '1' WHERE key = 'needs_rebuild' AND value <> '1';
