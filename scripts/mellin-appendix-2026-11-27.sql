-- Add the Mellin transform appendix and link the smoothing motivation to it.
-- Baseline: backup-before-mellin-appendix-2026-11-27.sql, then migration 0004.
-- Apply as one atomic batch. In SQLite, wrap the whole file in a transaction.
-- Reference edges were computed with src/latex.ts renderTex and the stored macros.

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM results WHERE id = 115 AND tag = '8JS2' AND revision = 2 AND section_id = 104)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 121 AND tag = '8JS8' AND revision = 1 AND section_id = 104)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 155 AND tag = '8JV3' AND revision = 3
      AND instr(statement_tex, 'For $\Re s>1$, reversing the order of integration gives') > 0)
  OR EXISTS (SELECT 1 FROM tags WHERE tag IN ('APXA', 'APXS', 'MCV9', 'MCV2', 'MCV3', 'MCV4', 'MCV5', 'MCV6', 'MCV7'));

INSERT INTO tags (tag, kind, created_at) VALUES
  ('APXA', 'section', '2026-11-27 14:00:00'),
  ('APXS', 'section', '2026-11-27 14:00:00'),
  ('MCV9', 'result', '2026-11-27 14:00:00'),
  ('MCV2', 'result', '2026-11-27 14:00:00'),
  ('MCV3', 'result', '2026-11-27 14:00:00'),
  ('MCV4', 'result', '2026-11-27 14:00:00'),
  ('MCV5', 'result', '2026-11-27 14:00:00'),
  ('MCV6', 'result', '2026-11-27 14:00:00'),
  ('MCV7', 'result', '2026-11-27 14:00:00');

INSERT INTO sections (tag, parent_id, kind, title, intro_tex, intro_html_cache, position, appendix, created_at, updated_at, updated_by)
VALUES ('APXA', NULL, 'chapter', 'The Mellin transform', 'This appendix collects the facts about the Mellin transform used in the book: the definition, the convolution theorem, and a table of basic transforms.',
        NULL, 100, 1, '2026-11-27 14:00:00', '2026-11-27 14:00:00', 'claude');

INSERT INTO sections (tag, parent_id, kind, title, intro_tex, intro_html_cache, position, appendix, created_at, updated_at, updated_by)
SELECT 'APXS', id, 'section', 'Convolution', 'The \hyperref[8JS2]{Mellin transform} turns multiplicative convolution into multiplication. \ref{MCV9} explains how this is used to find a function with a prescribed Mellin transform.',
       NULL, 1, 0, '2026-11-27 14:00:00', '2026-11-27 14:00:00', 'claude'
FROM sections WHERE tag = 'APXA';

UPDATE results
SET section_id = (SELECT id FROM sections WHERE tag = 'APXS'),
    position = CASE tag WHEN '8JS2' THEN 2 WHEN '8JS8' THEN 9 END,
    statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-27 14:00:00', updated_by = 'claude'
WHERE id IN (115, 121);

UPDATE results
SET statement_tex = replace(statement_tex,
    'For $\Re s>1$, reversing the order of integration gives',
    'Since $R_\chi=\Psi_\chi\star x$, the \hyperref[MCV3]{convolution theorem} and $\mathcal M(x)(s)=1/(s-1)$ from \ref{MCV4} give, for $\Re s>1$,'),
    statement_html_cache = NULL, revision = revision + 1, updated_at = '2026-11-27 14:00:00', updated_by = 'claude'
WHERE id = 155;

WITH content(tag, position, type, title, statement_tex) AS (VALUES
  ('MCV9', 1, 'motivation', 'Dividing a Mellin transform', 'Suppose $\mathcal M f$ is known and we want a function $g$ with $\mathcal M g=Q\cdot\mathcal M f$ for a simple factor $Q(s)$, such as $Q(s)=1/(s-1)$. The \hyperref[MCV3]{convolution theorem} reduces this to two steps.
\begin{enumerate}
\item[(1)] Find a function $h$ with $\mathcal M h=Q$, for instance in the \hyperref[MCV4]{table of basic transforms}.
\item[(2)] Put $g=f\star h$, the \hyperref[MCV2]{multiplicative convolution}.
\end{enumerate}
For $Q(s)=1/(s-1)$ the kernel is $h(x)=x$, so $g(x)=x\int_1^x f(t)\,t^{-2}\,dt$. When $\mathcal M g$ is a Dirichlet series times $\mathcal M h$, \ref{MCV5} gives $g$ directly as a sum over $n$. The reverse operation, multiplying by $s$, corresponds to $f\mapsto xf''$ by \ref{MCV6}. \ref{MCV7} applies all of this to the Chebyshev function and the smoothed prime sum.'),
  ('MCV2', 3, 'definition', 'Multiplicative convolution', 'Let $f,h\colon[1,\infty)\to\C$ be measurable and bounded on every interval $[1,X]$. Their \emph{multiplicative convolution} is the function
\[
f\star h\colon[1,\infty)\longrightarrow\C,\qquad x\longmapsto\int_1^x f(t)\,h\!\left(\frac xt\right)\frac{dt}{t}.
\]'),
  ('MCV3', 4, 'theorem', 'Convolution theorem', 'Let $c\in\R$, and let $f,h\colon[1,\infty)\to\C$ be measurable, bounded on every interval $[1,X]$, and $O_\varepsilon(x^{c+\varepsilon})$ for every $\varepsilon>0$. For every $s\in\C$ with $\Re s>c$, the \hyperref[8JS2]{Mellin integral} of the \hyperref[MCV2]{multiplicative convolution} $f\star h$ converges absolutely, and
\[
\mathcal M(f\star h)(s)=(\mathcal M f)(s)\,(\mathcal M h)(s).
\]'),
  ('MCV4', 5, 'lemma', 'Basic Mellin transforms', 'Let $f\colon[1,\infty)\to\C$ be as in the \hyperref[8JS2]{definition of the Mellin transform}, with exponent $c_0$.
\begin{enumerate}
\item[(i)] For $a\in\C$ and an integer $k\ge0$,
\[
\mathcal M\bigl(x^a(\ln x)^k\bigr)(s)=\frac{k!}{(s-a)^{k+1}}\qquad(\Re s>\Re a).
\]
In particular $\mathcal M(1)(s)=1/s$ and $\mathcal M(x)(s)=1/(s-1)$.
\item[(ii)] For $\Re s>1$,
\[
\mathcal M(x-1)(s)=\frac1{s(s-1)}.
\]
\item[(iii)] For a real $n\ge1$, let $f_n\colon[1,\infty)\to\C$ be $f_n(x)=f(x/n)$ for $x\ge n$ and $f_n(x)=0$ for $x<n$. Then
\[
(\mathcal M f_n)(s)=n^{-s}\,(\mathcal M f)(s)\qquad(\Re s>c_0).
\]
\end{enumerate}'),
  ('MCV5', 6, 'corollary', 'Dirichlet series times a Mellin transform', 'Let $c\in\R$, let $h\colon[1,\infty)\to\C$ be measurable, bounded on every interval $[1,X]$ and $O_\varepsilon(x^{c+\varepsilon})$ for every $\varepsilon>0$, and let $(a_n)_{n\ge1}$ be complex numbers with $\sum_{n\ge1}|a_n|\,n^{-\sigma}<\infty$ for every real $\sigma>c$. Put
\[
g\colon[1,\infty)\longrightarrow\C,\qquad x\longmapsto\sum_{n\le x}a_n\,h\!\left(\frac xn\right).
\]
For every $s\in\C$ with $\Re s>c$, the \hyperref[8JS2]{Mellin integral} of $g$ converges absolutely, and
\[
(\mathcal Mg)(s)=\Bigl(\sum_{n\ge1}a_n\,n^{-s}\Bigr)(\mathcal Mh)(s).
\]'),
  ('MCV6', 7, 'lemma', 'Multiplying by $s$', 'Let $c\in\R$, and let $f\colon[1,\infty)\to\C$ be absolutely continuous on every interval $[1,X]$, with $f(1)=0$, $f(x)=O_\varepsilon(x^{c+\varepsilon})$ and $f''(x)=O_\varepsilon(x^{c-1+\varepsilon})$ for almost every $x$, for every $\varepsilon>0$. For every $s\in\C$ with $\Re s>c$,
\[
\mathcal M(xf'')(s)=s\,(\mathcal Mf)(s),\qquad\text{and hence}\qquad\mathcal M(xf''-f)(s)=(s-1)\,(\mathcal Mf)(s),
\]
where $xf''$ denotes the function $x\mapsto xf''(x)$.'),
  ('MCV7', 8, 'example', 'From the Chebyshev function to the smoothed prime sum', 'Let $\Psi_{\mathbf 1}$ be the \hyperref[8JUT]{Chebyshev function} and $R_{\mathbf 1}$ the \hyperref[8JF7]{smoothed prime sum} of the trivial character. By \ref{8JUU}, for $\Re s>1$,
\[
(\mathcal M\Psi_{\mathbf 1})(s)=-\frac{\zeta''(s)}{\zeta(s)}\cdot\frac1s=\Bigl(\sum_{n\ge1}\Lambda(n)\,n^{-s}\Bigr)\mathcal M(1)(s),
\]
and \ref{MCV5} with $c=1$ and $h=1$ recovers $\Psi_{\mathbf 1}(x)=\sum_{n\le x}\Lambda(n)$. We look for a function $R$ with $(\mathcal MR)(s)=(\mathcal M\Psi_{\mathbf 1})(s)/(s-1)$.

\emph{By convolution.} Since $1/(s-1)=\mathcal M(x)(s)$ by \ref{MCV4}(i), \ref{MCV3} gives $R=\Psi_{\mathbf 1}\star x$:
\[
R(x)=\int_1^x\Psi_{\mathbf 1}(t)\,\frac xt\,\frac{dt}{t}=x\int_1^x\Psi_{\mathbf 1}(t)\,\frac{dt}{t^2}.
\]

\emph{By the Dirichlet series.} Since $1/(s(s-1))=\mathcal M(x-1)(s)$ by \ref{MCV4}(ii), \ref{MCV5} with $c=1$ gives
\[
R(x)=\sum_{n\le x}\Lambda(n)\Bigl(\frac xn-1\Bigr)=R_{\mathbf 1}(x).
\]

\emph{Back again.} $R_{\mathbf 1}$ is continuous with $R_{\mathbf 1}(1)=0$, and off the prime powers $R_{\mathbf 1}''(x)=\sum_{n\le x}\Lambda(n)/n$. By \ref{MCV6}, $\mathcal M(xR_{\mathbf 1}''-R_{\mathbf 1})=(s-1)\,\mathcal MR_{\mathbf 1}=\mathcal M\Psi_{\mathbf 1}$, and indeed
\[
xR_{\mathbf 1}''(x)-R_{\mathbf 1}(x)=\sum_{n\le x}\Lambda(n)\frac xn-\sum_{n\le x}\Lambda(n)\Bigl(\frac xn-1\Bigr)=\Psi_{\mathbf 1}(x).
\]
The \hyperref[8JS9]{graphs} compare $\Psi_{\mathbf 1}$, $R_{\mathbf 1}$ and the slope $R_{\mathbf 1}''$ for $1\le x\le20$.')
)
INSERT INTO results (tag, type, title, statement_tex, statement_html_cache, section_id, position, visibility, state, listed,
                     created_at, updated_at, created_by, updated_by)
SELECT content.tag, content.type, content.title, content.statement_tex, NULL, sections.id, content.position, 'published', 'active', 1,
       '2026-11-27 14:00:00', '2026-11-27 14:00:00', 'claude', 'claude'
FROM content CROSS JOIN sections WHERE sections.tag = 'APXS';

WITH content(tag, body_tex) AS (VALUES
  ('MCV3', 'Put $\sigma=\Re s$. Exchanging the order of integration over $1\le t\le x$ and substituting $x=tu$ gives
\begin{align*}
\int_1^\infty (f\star h)(x)\,x^{-s-1}\,dx
&=\int_1^\infty\!\!\int_1^x f(t)\,h\!\left(\frac xt\right)t^{-1}x^{-s-1}\,dt\,dx\\
&=\int_1^\infty f(t)\,t^{-s-1}\,dt\int_1^\infty h(u)\,u^{-s-1}\,du\\
&=(\mathcal Mf)(s)\,(\mathcal Mh)(s).
\end{align*}
The same computation for $|f|$, $|h|$ and $\sigma$ gives the finite value $(\mathcal M|f|)(\sigma)\,(\mathcal M|h|)(\sigma)$ by \hyperref[8JS8]{absolute convergence}. This justifies the exchange by Fubini''s theorem, and it bounds the Mellin integral of $|f\star h|\le|f|\star|h|$.'),
  ('MCV4', '\emph{(i)} Substitute $x=e^u$ and use the Gamma integral:
\[
\int_1^\infty x^a(\ln x)^k\,x^{-s-1}\,dx=\int_0^\infty u^k e^{-(s-a)u}\,du=\frac{k!}{(s-a)^{k+1}}.
\]

\emph{(ii)} By (i), $\dfrac1{s-1}-\dfrac1s=\dfrac1{s(s-1)}$.

\emph{(iii)} Substitute $x=nu$:
\[
\int_n^\infty f\!\left(\frac xn\right)x^{-s-1}\,dx=n^{-s}\int_1^\infty f(u)\,u^{-s-1}\,du.
\]'),
  ('MCV5', 'Put $\sigma=\Re s$. In the notation of \ref{MCV4}(iii), $g=\sum_n a_nh_n$, and the $n$-th term has Mellin transform $a_nn^{-s}(\mathcal Mh)(s)$. Summing over $n$ under the integral is allowed because
\[
\sum_{n\ge1}\int_1^\infty|a_nh_n(x)|\,x^{-\sigma-1}\,dx=\Bigl(\sum_{n\ge1}|a_n|\,n^{-\sigma}\Bigr)(\mathcal M|h|)(\sigma)<\infty.
\]'),
  ('MCV6', 'Integrate by parts on $[1,X]$, using $f(1)=0$:
\[
\int_1^X f''(x)\,x^{-s}\,dx=f(X)\,X^{-s}+s\int_1^X f(x)\,x^{-s-1}\,dx.
\]
As $X\to\infty$, $f(X)X^{-s}\to0$ because $\Re s>c$, and both integrals converge absolutely by \hyperref[8JS8]{absolute convergence}.')
)
INSERT INTO proofs (result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail, visibility,
                    created_at, updated_at, created_by, updated_by)
SELECT results.id, 1, content.body_tex, NULL, 'ai_generated', 'claude', 'Claude Opus 5.5', 'published',
       '2026-11-27 14:00:00', '2026-11-27 14:00:00', 'claude', 'claude'
FROM content JOIN results ON results.tag = content.tag;

-- Snapshot the inserted and updated rows using the existing content-script keys.
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'section', CAST(id AS TEXT), revision, 'fabc8a5d-88cf-45dd-b96a-0ac2d243ad80',
       json_object('tag', tag, 'parent_id', parent_id, 'kind', kind, 'title', title, 'intro_tex', intro_tex, 'position', position),
       'claude', '2026-11-27 14:00:00'
FROM sections WHERE tag IN ('APXA', 'APXS');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'result', CAST(id AS TEXT), revision, 'fabc8a5d-88cf-45dd-b96a-0ac2d243ad80',
       json_object('tag', tag, 'type', type, 'title', title, 'statement_tex', statement_tex, 'section_id', section_id,
                   'position', position, 'visibility', visibility, 'state', state, 'replaced_by_id', replaced_by_id, 'listed', listed),
       'claude', '2026-11-27 14:00:00'
FROM results WHERE tag IN ('MCV9', 'MCV2', 'MCV3', 'MCV4', 'MCV5', 'MCV6', 'MCV7', '8JS2', '8JS8', '8JV3');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
SELECT 'proof', CAST(p.id AS TEXT), p.revision, 'fabc8a5d-88cf-45dd-b96a-0ac2d243ad80',
       json_object('result_id', p.result_id, 'body_tex', p.body_tex, 'status', p.status, 'generated_by', p.generated_by,
                   'generator_detail', p.generator_detail, 'reviewed_by', p.reviewed_by, 'review_notes', p.review_notes, 'position', p.position),
       'claude', '2026-11-27 14:00:00'
FROM proofs AS p JOIN results AS r ON r.id = p.result_id WHERE r.tag IN ('MCV3', 'MCV4', 'MCV5', 'MCV6');

-- Existing statement refs on the moved results and the existing proof of 8JS8 still apply.
WITH edges(source_tag, target_tag) AS (VALUES
  ('MCV9', 'MCV2'),
  ('MCV9', 'MCV3'),
  ('MCV9', 'MCV4'),
  ('MCV9', 'MCV5'),
  ('MCV9', 'MCV6'),
  ('MCV9', 'MCV7'),
  ('MCV3', '8JS2'),
  ('MCV3', 'MCV2'),
  ('MCV4', '8JS2'),
  ('MCV5', '8JS2'),
  ('MCV7', '8JF7'),
  ('MCV7', '8JS9'),
  ('MCV7', '8JUT'),
  ('MCV7', '8JUU'),
  ('MCV7', 'MCV3'),
  ('MCV7', 'MCV4'),
  ('MCV7', 'MCV5'),
  ('MCV7', 'MCV6'),
  ('8JV3', 'MCV3'),
  ('8JV3', 'MCV4')
)
INSERT OR IGNORE INTO refs (source_result_id, source_proof_id, target_tag)
SELECT results.id, NULL, edges.target_tag FROM edges JOIN results ON results.tag = edges.source_tag;

WITH edges(source_tag, target_tag) AS (VALUES
  ('MCV3', '8JS8'),
  ('MCV5', 'MCV4'),
  ('MCV6', '8JS8')
)
INSERT INTO refs (source_result_id, source_proof_id, target_tag)
SELECT results.id, proofs.id, edges.target_tag
FROM edges JOIN results ON results.tag = edges.source_tag JOIN proofs ON proofs.result_id = results.id;

INSERT INTO settings (key, value) VALUES ('needs_rebuild', '1')
ON CONFLICT (key) DO UPDATE SET value = excluded.value WHERE settings.value <> excluded.value;
