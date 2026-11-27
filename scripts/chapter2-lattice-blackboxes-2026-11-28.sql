-- Add section 2.3 after WJQV. The comparison uses the chain records cited in Chapter 4.

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM sections WHERE id IS 115 AND tag IS 'UTUF' AND kind IS 'chapter')
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id IS 117 AND tag IS 'WJQV' AND revision IS 4
    AND kind IS 'section' AND parent_id IS 115 AND position IS 2)
  OR EXISTS (SELECT 1 FROM sections WHERE parent_id = 115 AND position >= 3)
  OR EXISTS (SELECT 1 FROM tags WHERE tag IN ('Q7MK', 'Q7MN', 'Q7MP', 'Q7MQ', 'Q7MR'))
  OR NOT EXISTS (SELECT 1 FROM settings WHERE key = 'needs_rebuild');

INSERT INTO tags (tag, kind, created_at) VALUES
  ('Q7MK', 'section', '2026-11-28 03:00:00'),
  ('Q7MN', 'result', '2026-11-28 03:00:00'),
  ('Q7MP', 'result', '2026-11-28 03:00:00'),
  ('Q7MQ', 'result', '2026-11-28 03:00:00'),
  ('Q7MR', 'result', '2026-11-28 03:00:00');

INSERT INTO sections (tag, parent_id, kind, title, intro_tex, intro_html_cache, position, appendix,
                      created_at, updated_at, updated_by)
VALUES ('Q7MK', 115, 'section', 'The lattice comparison',
'We apply the comparison of \ref{WJQV} to prime powers counted by a chain of theta lifts. The two bounds below use the chain records of \ref{C4S2}. The estimates and their normalization are developed in \ref{8JU4} and \ref{8JU6}.',
NULL, 3, 0, '2026-11-28 03:00:00', '2026-11-28 03:00:00', 'claude');

INSERT INTO results (tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, state, listed,
                     created_at, updated_at, created_by, updated_by)
VALUES
  ('Q7MN', 'motivation', 'From a factorial to a lattice',
'Fix data at a real cutoff $x$ as in \ref{C4S2} and \ref{C4W2}, and fix any $u_0\in A_0$ from \ref{8JVE}. The chain consists of $m$ successive theta lifts, where $m\ge1$ is an integer. Each lift maps automorphic forms on a definite unitary group to forms on one of larger rank. Its theta kernel gives the map by a weighted sum over lattice classes. At the top, $R$ is the lattice of integral automorphic forms with its Hermitian norms. Its slope $\mu(R)\in\R$ is the arithmetic degree per rank in the chosen normalization, a normalized negative logarithm of covolume with a field-dependent correction. As with $\ln|N|$ in \ref{WJQV}, the logarithm lets finite-place indices and size estimates enter additively. The period maps take values in the dual $R^\vee$, whose slope is $-\mu(R)$. The slopes and period-map heights enter the comparison and cancel, leaving the total logarithmic divisibility gain $\Gamma$ at the inert primes as the common quantity between the two bounds. See \cite[Sections 7, 13.1 and 18.3]{Adriazola}.

Use the \hyperref[8JU9]{weighted count and main term} $S(t,\upsilon,w)$ and $M(\upsilon,w)$. Write $w_j=w_{u_0,j}$ from \ref{C4W2}. For any $t\in T$, integer $1\le j\le m$ and counted class $g\notin\Phi$, put $W=w_j(p_t(g))>0$. For a prime $p$ and an integer $i\ge1$, the summand contains $W$ times the \hyperref[8JF7]{Chapter 1 ramp} at cutoff $\upsilon_t/W$:
\[
\left(\frac{\upsilon_t}{p^i}-W\right)_+
=W\left(\frac{\upsilon_t/W}{p^i}-1\right)_+ .
\]
At the large-weight labels of \ref{8JVK}, $W$ is close to $b=\exp(x^\varepsilon)$ and $\upsilon_t$ is close to $xb$. There are $h=|T|$ translates, $m$ levels and $h_2=|T_2|$ such labels at each level, with $\delta_2=h_2/n$ and $n=|A|$ as in \ref{8JVE}. The factor $2$ in the count compensates for counting only half the class group and gives the Fourier coefficient $1/f$, where $f=|\Phi|=2n$. The large labels therefore occupy a fraction $h_2/f=\delta_2/2$ of that half. The comparison scale in \ref{8JVF} and \ref{8JUD} is
\[
B=Q\delta_2/2>0,\qquad Q=hmb .
\]
Define the real totals for the fixed shift by
\begin{align*}
S_*&=\sum_{t\in T}\sum_{j=1}^m S(t,\upsilon_t,w_j),\\
M_*&=\sum_{t\in T}\sum_{j=1}^m \Re M(\upsilon_t,w_j).
\end{align*}
For the template of \ref{WJQV}, take $T_{\rm cmp}(x)=S_*/B$ and $M_{\rm cmp}(x)=M_*/B$. Thus $S_*$ plays the role of $B\,T_{\rm cmp}$, $\Gamma$ the role of $\ln|N|$ after the slope comparison, and $M_*$ the role of $B\,M_{\rm cmp}$. The main-term identity in \ref{8JUC} accounts for $M_*$ on the size side.',
   NULL, (SELECT id FROM sections WHERE tag = 'Q7MK'), 1, 'published', 'active', 1,
   '2026-11-28 03:00:00', '2026-11-28 03:00:00', 'claude', 'claude'),
  ('Q7MP', 'proposition', 'Black box A. The divisibility lower bound',
'Assume the inputs of \ref{C4S2}, and use the data and notation of \ref{Q7MN} at any point $x\ge x_{\rm div}(\psi,\varepsilon)$ of an admissible window, with $x_{\rm div}$ from \ref{8JUA}. Use the nonnegative error exponent $e_L$ and the index loss $I$ of \ref{8JV2}. The chain record supplies a constant $C>0$, uniform in $x$ and $u_0$ for fixed $\psi,\varepsilon$, with
\[
L_{\rm div}=C Q x^{e_L\varepsilon},\qquad
S_*-L_{\rm div}\le\Gamma,\qquad 0\le I\le L_{\rm div}.
\]',
   NULL, (SELECT id FROM sections WHERE tag = 'Q7MK'), 2, 'published', 'active', 1,
   '2026-11-28 03:00:00', '2026-11-28 03:00:00', 'claude', 'claude'),
  ('Q7MQ', 'proposition', 'Black box B. The size upper bound',
'Use the same hypotheses, data and constant $C$ as in \ref{Q7MP}. Use the nonnegative exponent $e_D$ and $h_u,L,D_u,\upsilon,\Lambda_{\upsilon},B_0,N_c$ from \ref{8JV2}. For every auxiliary prime $T_u$ of the chain record, the size inequality in the dual-lattice convention of \cite[Definition 18.9(K4)]{Adriazola} is
\begin{align*}
\mu(R^\vee)+h_u-L
&\le D_u+C h\upsilon\Lambda_{\upsilon}\\
&\quad+C m(B_0+N_c)x^{e_D\varepsilon}.
\end{align*}

After matching the main term, the upper bound is
\[
\Gamma\le M_*+L_{\rm size}.
\]
Here $L_{\rm size}=e_2+e_3+e_4+e_5+A_*e_6+e_7\ge0$ in the accounting notation of \cite[Sections 3.1 and 18.5--18.6]{Adriazola}, with $A_*=\sum_{t\in T}\upsilon_t$ as in \ref{8JUC}. With $\mathcal B$ from \ref{8JUA},
\[
L_{\rm div}+L_{\rm size}
\le x^{(e_D+e_L+3)\varepsilon}\mathcal B .
\]',
   NULL, (SELECT id FROM sections WHERE tag = 'Q7MK'), 3, 'published', 'active', 1,
   '2026-11-28 03:00:00', '2026-11-28 03:00:00', 'claude', 'claude'),
  ('Q7MR', 'corollary', 'The normalized lattice comparison',
'Under the hypotheses of \ref{Q7MP} and \ref{Q7MQ}, the count and main term of \ref{Q7MN} satisfy
\[
T_{\rm cmp}(x)-M_{\rm cmp}(x)
=\frac{\Delta_{u_0}}{B}
\le\frac{L_{\rm div}+L_{\rm size}}{B},
\]
where $\Delta_{u_0}$ is the centered sum of \ref{8JVF}.',
   NULL, (SELECT id FROM sections WHERE tag = 'Q7MK'), 4, 'published', 'active', 1,
   '2026-11-28 03:00:00', '2026-11-28 03:00:00', 'claude', 'claude');

INSERT INTO proofs (result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail, visibility,
                    created_at, updated_at, created_by, updated_by)
SELECT id, 1,
'These are the two finite-place estimates in \ref{8JV2}, supplied by \cite[Definition 18.9(K1) and Hypotheses 17.11 and 18.10]{Adriazola} through \ref{C4S2}. The cohomological input is recorded in \ref{8JU8}, and \ref{8JUA} uses the estimates in the comparison.',
NULL, 'ai_generated', 'gpt', 'Codex', 'published',
'2026-11-28 03:00:00', '2026-11-28 03:00:00', 'claude', 'claude'
FROM results WHERE tag = 'Q7MP';

INSERT INTO proofs (result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail, visibility,
                    created_at, updated_at, created_by, updated_by)
SELECT id, 1,
'The size input of \ref{8JV2} is \cite[Definition 18.9(K4)]{Adriazola} for the record supplied by \ref{C4S2} under \cite[Hypotheses 17.11 and 18.10]{Adriazola}. The comparison in \ref{8JUA} follows \cite[Section 3.1, (A2)--(A7)]{Adriazola}, with the main-term cancellation written in \ref{8JUC}. The total error is bounded in \cite[Section 18.6, Theorem A(ii)]{Adriazola}.',
NULL, 'ai_generated', 'gpt', 'Codex', 'published',
'2026-11-28 03:00:00', '2026-11-28 03:00:00', 'claude', 'claude'
FROM results WHERE tag = 'Q7MQ';

INSERT INTO proofs (result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail, visibility,
                    created_at, updated_at, created_by, updated_by)
SELECT id, 1,
'\begin{alignat*}{2}
S_*-L_{\rm div}&\le\Gamma &&\qquad\text{(a)}\\
                &\le M_*+L_{\rm size}. &&\qquad\text{(b)}
\end{alignat*}
\begin{enumerate}
\item[(a)] The divisibility estimate of \ref{Q7MP}.
\item[(b)] The matched size estimate of \ref{Q7MQ}.
\end{enumerate}
Subtract $M_*$ and divide by $B>0$, using $\Delta_{u_0}=S_*-M_*$ from \ref{8JVF}.

The lower bound for $\delta_2$ in \ref{8JUG} gives $L_{\rm div}/B\le2C x^{(e_L+1)\varepsilon}$. In the size allowance, the first and third terms of $\mathcal B/Q$ give the scales $x/m$ and $m$, up to factors $x^{O(\varepsilon)}$. The second and fourth terms are bounded by the same allowance by \ref{8JUG}. Thus $L_{\rm size}/B\ll_{\psi,\varepsilon} x^{O(\varepsilon)}(x/m+m)$, which is $x^{1/2+O(\varepsilon)}$ at the scale $m$ in \ref{8JUG}. The uniform estimate of \ref{8JUA} passes to the average in \ref{8JUF}. The Fourier comparison of \ref{8JUD} then gives the Chapter 1 interval estimate in \ref{8JVJ}.',
NULL, 'ai_generated', 'gpt', 'Codex', 'published',
'2026-11-28 03:00:00', '2026-11-28 03:00:00', 'claude', 'claude'
FROM results WHERE tag = 'Q7MR';

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'section', CAST(id AS TEXT), revision, 'chapter2-lattice-blackboxes-2026-11-28',
       json_object('tag', tag, 'parent_id', parent_id, 'kind', kind, 'title', title,
                   'intro_tex', intro_tex, 'position', position, 'appendix', appendix),
       updated_by, '2026-11-28 03:00:00'
FROM sections WHERE id = 117;

UPDATE sections
SET intro_tex = intro_tex || char(10, 10) || 'The lattice comparison in \ref{Q7MK} gives the two bounds for the theta-lift chain.',
    intro_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-28 03:00:00', updated_by = 'claude'
WHERE id = 117;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'section', CAST(id AS TEXT), revision, 'chapter2-lattice-blackboxes-2026-11-28',
       json_object('tag', tag, 'parent_id', parent_id, 'kind', kind, 'title', title,
                   'intro_tex', intro_tex, 'position', position, 'appendix', appendix),
       'claude', '2026-11-28 03:00:00'
FROM sections WHERE tag IN ('WJQV', 'Q7MK');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'chapter2-lattice-blackboxes-2026-11-28',
       json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex, 'section_id', section_id,
                   'position', position, 'visibility', visibility, 'state', state, 'replaced_by_id', replaced_by_id, 'listed', listed),
       'claude', '2026-11-28 03:00:00'
FROM results WHERE tag IN ('Q7MN', 'Q7MP', 'Q7MQ', 'Q7MR');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'proof', CAST(p.id AS TEXT), p.revision, 'chapter2-lattice-blackboxes-2026-11-28',
       json_object('result_id', p.result_id, 'position', p.position, 'body_tex', p.body_tex, 'status', p.status,
                   'generated_by', p.generated_by, 'generator_detail', p.generator_detail, 'visibility', p.visibility),
       'claude', '2026-11-28 03:00:00'
FROM proofs p JOIN results r ON r.id = p.result_id WHERE r.tag IN ('Q7MP', 'Q7MQ', 'Q7MR');

WITH statement_refs(source_tag, target_tag) AS (VALUES
  ('Q7MN', 'C4S2'), ('Q7MN', 'C4W2'), ('Q7MN', 'WJQV'), ('Q7MN', '8JU9'),
  ('Q7MN', '8JF7'), ('Q7MN', '8JVK'), ('Q7MN', '8JVE'), ('Q7MN', '8JVF'),
  ('Q7MN', '8JUD'), ('Q7MN', '8JUC'),
  ('Q7MP', 'C4S2'), ('Q7MP', 'Q7MN'), ('Q7MP', '8JUA'), ('Q7MP', '8JV2'),
  ('Q7MQ', 'Q7MP'), ('Q7MQ', '8JV2'), ('Q7MQ', '8JUC'), ('Q7MQ', '8JUA'),
  ('Q7MR', 'Q7MP'), ('Q7MR', 'Q7MQ'), ('Q7MR', 'Q7MN'), ('Q7MR', '8JVF')
)
INSERT INTO refs (source_result_id, source_proof_id, target_tag)
SELECT r.id, NULL, target_tag FROM statement_refs JOIN results r ON r.tag = source_tag;

WITH proof_refs(source_tag, target_tag) AS (VALUES
  ('Q7MP', '8JV2'), ('Q7MP', 'C4S2'), ('Q7MP', '8JU8'), ('Q7MP', '8JUA'),
  ('Q7MQ', 'C4S2'), ('Q7MQ', '8JV2'), ('Q7MQ', '8JUA'), ('Q7MQ', '8JUC'),
  ('Q7MR', 'Q7MP'), ('Q7MR', 'Q7MQ'), ('Q7MR', '8JVF'), ('Q7MR', '8JUG'),
  ('Q7MR', '8JUA'), ('Q7MR', '8JUF'), ('Q7MR', '8JUD'), ('Q7MR', '8JVJ')
)
INSERT INTO refs (source_result_id, source_proof_id, target_tag)
SELECT r.id, p.id, target_tag FROM proof_refs JOIN results r ON r.tag = source_tag
JOIN proofs p ON p.result_id = r.id AND p.position = 1;

UPDATE settings SET value = '1' WHERE key = 'needs_rebuild' AND value <> '1';
