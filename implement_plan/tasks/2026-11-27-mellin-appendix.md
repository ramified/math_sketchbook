# Spec: Appendix A "The Mellin transform" (27 Nov 2026)

## Goal

Add an appendix to the book that holds:
- the definition of the Mellin transform (8JS2, moved from Section 1.3 "Why the estimate forces the critical line", tag 7HM3);
- its hidden lemma 8JS8;
- new results on multiplicative convolution, so that a reader can compute a function from a product of Mellin transforms.

The appendix is numbered with letters: chapter "Appendix A", section A.1, results A.1.1, A.1.2, …

Read `docs/CONVENTIONS.md` first and follow it.

## Part 1: code (appendix numbering)

1. **New** `migrations/0004_appendix_chapters.sql`:
   ```sql
   -- Appendix chapters are numbered A, B, ... after the ordinary chapters.
   ALTER TABLE sections ADD COLUMN appendix INTEGER NOT NULL DEFAULT 0 CHECK (appendix IN (0, 1));
   ```
2. **`src/types.ts`:** add `appendix: number` to the section row type.
3. **`src/book.ts`, `loadBook`:**
   - Select `appendix` as well.
   - Ordinary chapters keep 1, 2, 3, … Chapters with `appendix = 1` get the letters A, B, C, … in order of position, and the label `Appendix A`. Their sections are `A.1`, `A.2`, and their results `A.1.1`, … (hidden results `A.1.?`).
   - The two counters are independent, so an appendix placed before an ordinary chapter does not shift the chapter numbers. All appendix chapters should still be listed after all ordinary chapters in `book.chapters`.
4. **`src/views/reader.ts` lines 89–90:** use the entry's `label` instead of the hard-coded `` `Chapter ${e.number}` `` (page title and h1). Grep `src/` for any other hard-coded "Chapter " plus number and use `label` there too.
5. **Editor:** in the section edit form (`src/views/editor.ts` around line 150) add, for chapters only, a checkbox "Appendix (numbered A, B, …)". Save it in the matching handler in `src/store.ts` / `src/index.ts`, following how other section fields are saved. If saving touches revisions or snapshots of sections, include `appendix` the same way.
6. **`test/book.test.ts`:** add a test with two ordinary chapters and one appendix chapter, placed between them by position. It checks that the numbers come out 1, 2, A, the sections 1.1, …, A.1, and a result A.1.1, and that the label is "Appendix A".
7. `npm test` and `npm run typecheck` must pass.

## Part 2: content (`scripts/mellin-appendix-2026-11-27.sql`)

Do NOT run it against the remote DB. Follow the style of `scripts/chapter3-self-contained-2026-11-27.sql`:
- a guard at the top (`INSERT OR ROLLBACK INTO write_guard (ok) SELECT 0 WHERE ...`);
- `revisions` rows for every new or changed row, with snapshot keys exactly as that script uses for sections, results and proofs;
- html caches set to NULL;
- `tags` rows for the new tags;
- `refs` rows for every `\ref` and `\hyperref` target in the new or changed statements and proofs;
- `needs_rebuild` set to '1'.

Build the snapshot JSON with SQLite `json_object(...)` from the rows after the change. Do not hand-escape TeX. Use `updated_by`/`author` = 'claude' and the timestamp '2026-11-27 14:00:00'. Proofs: `status 'ai_generated'`, `generated_by 'claude'`, `generator_detail 'Claude Opus 5.5'`. If the CHECK constraints in the schema refuse these values, use what the schema allows and say so in the report.

**Guard:** the script must abort unless all of the following hold:
- result 115 (8JS2) is at revision 2 in section 104;
- result 121 (8JS8) is at revision 1 in section 104;
- result 8JV3 is at its current revision and contains the exact phrase `For $\Re s>1$, reversing the order of integration gives`;
- none of the tags APXA, APXS, MCV2, MCV3, MCV4, MCV5, MCV6, MCV7, MCV9 exists in `tags`.

Look up 8JV3's id and current revision in the backup.

### New chapter and section

- **Chapter:** tag `APXA`, kind 'chapter', title `The Mellin transform`, `appendix = 1`, `position = 100`. `intro_tex`:
  ```tex
  This appendix collects the facts about the Mellin transform used in the book: the definition, the convolution theorem, and a table of basic transforms.
  ```
- **Section:** tag `APXS`, kind 'section', parent = the new chapter, title `Convolution`, `position = 1`. `intro_tex`:
  ```tex
  The \hyperref[8JS2]{Mellin transform} turns multiplicative convolution into multiplication. \ref{MCV9} explains how this is used to find a function with a prescribed Mellin transform.
  ```

### Moved results

Set `section_id` to the new section, with no text changes:
- 8JS2: position 2;
- 8JS8: position 9 (it stays unlisted).

Bump the revision and write snapshots.

### New results (all `visibility 'published'`, `state 'active'`, `listed 1`)

Positions and types:

| Position | Tag | Type | Title |
|---|---|---|---|
| 1 | MCV9 | motivation | Dividing a Mellin transform |
| 3 | MCV2 | definition | Multiplicative convolution |
| 4 | MCV3 | theorem | Convolution theorem |
| 5 | MCV4 | lemma | Basic Mellin transforms |
| 6 | MCV5 | corollary | Dirichlet series times a Mellin transform |
| 7 | MCV6 | lemma | Multiplying by $s$ |
| 8 | MCV7 | example | From the Chebyshev function to the smoothed prime sum |

Only MCV3, MCV4, MCV5 and MCV6 have proofs (one proof row each, position 1).

#### MCV9 statement
```tex
Suppose $\mathcal M f$ is known and we want a function $g$ with $\mathcal M g=Q\cdot\mathcal M f$ for a simple factor $Q(s)$, such as $Q(s)=1/(s-1)$. The \hyperref[MCV3]{convolution theorem} reduces this to two steps.
\begin{enumerate}
\item[(1)] Find a function $h$ with $\mathcal M h=Q$, for instance in the \hyperref[MCV4]{table of basic transforms}.
\item[(2)] Put $g=f\star h$, the \hyperref[MCV2]{multiplicative convolution}.
\end{enumerate}
For $Q(s)=1/(s-1)$ the kernel is $h(x)=x$, so $g(x)=x\int_1^x f(t)\,t^{-2}\,dt$. When $\mathcal M g$ is a Dirichlet series times $\mathcal M h$, \ref{MCV5} gives $g$ directly as a sum over $n$. The reverse operation, multiplying by $s$, corresponds to $f\mapsto xf'$ by \ref{MCV6}. \ref{MCV7} applies all of this to the Chebyshev function and the smoothed prime sum.
```

#### MCV2 statement
```tex
Let $f,h\colon[1,\infty)\to\C$ be measurable and bounded on every interval $[1,X]$. Their \emph{multiplicative convolution} is the function
\[
f\star h\colon[1,\infty)\longrightarrow\C,\qquad x\longmapsto\int_1^x f(t)\,h\!\left(\frac xt\right)\frac{dt}{t}.
\]
```

#### MCV3 statement
```tex
Let $c\in\R$, and let $f,h\colon[1,\infty)\to\C$ be measurable, bounded on every interval $[1,X]$, and $O_\varepsilon(x^{c+\varepsilon})$ for every $\varepsilon>0$. For every $s\in\C$ with $\Re s>c$, the \hyperref[8JS2]{Mellin integral} of the \hyperref[MCV2]{multiplicative convolution} $f\star h$ converges absolutely, and
\[
\mathcal M(f\star h)(s)=(\mathcal M f)(s)\,(\mathcal M h)(s).
\]
```

#### MCV3 proof
```tex
Put $\sigma=\Re s$. Exchanging the order of integration over $1\le t\le x$ and substituting $x=tu$ gives
\begin{align*}
\int_1^\infty (f\star h)(x)\,x^{-s-1}\,dx
&=\int_1^\infty\!\!\int_1^x f(t)\,h\!\left(\frac xt\right)t^{-1}x^{-s-1}\,dt\,dx\\
&=\int_1^\infty f(t)\,t^{-s-1}\,dt\int_1^\infty h(u)\,u^{-s-1}\,du\\
&=(\mathcal Mf)(s)\,(\mathcal Mh)(s).
\end{align*}
The same computation for $|f|$, $|h|$ and $\sigma$ gives the finite value $(\mathcal M|f|)(\sigma)\,(\mathcal M|h|)(\sigma)$ by \hyperref[8JS8]{absolute convergence}. This justifies the exchange by Fubini's theorem, and it bounds the Mellin integral of $|f\star h|\le|f|\star|h|$.
```

#### MCV4 statement
```tex
Let $f\colon[1,\infty)\to\C$ be as in the \hyperref[8JS2]{definition of the Mellin transform}, with exponent $c_0$.
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
\end{enumerate}
```

#### MCV4 proof
```tex
\emph{(i)} Substitute $x=e^u$ and use the Gamma integral:
\[
\int_1^\infty x^a(\ln x)^k\,x^{-s-1}\,dx=\int_0^\infty u^k e^{-(s-a)u}\,du=\frac{k!}{(s-a)^{k+1}}.
\]

\emph{(ii)} By (i), $\dfrac1{s-1}-\dfrac1s=\dfrac1{s(s-1)}$.

\emph{(iii)} Substitute $x=nu$:
\[
\int_n^\infty f\!\left(\frac xn\right)x^{-s-1}\,dx=n^{-s}\int_1^\infty f(u)\,u^{-s-1}\,du.
\]
```

#### MCV5 statement
```tex
Let $c\in\R$, let $h\colon[1,\infty)\to\C$ be measurable, bounded on every interval $[1,X]$ and $O_\varepsilon(x^{c+\varepsilon})$ for every $\varepsilon>0$, and let $(a_n)_{n\ge1}$ be complex numbers with $\sum_{n\ge1}|a_n|\,n^{-\sigma}<\infty$ for every real $\sigma>c$. Put
\[
g\colon[1,\infty)\longrightarrow\C,\qquad x\longmapsto\sum_{n\le x}a_n\,h\!\left(\frac xn\right).
\]
For every $s\in\C$ with $\Re s>c$, the \hyperref[8JS2]{Mellin integral} of $g$ converges absolutely, and
\[
(\mathcal Mg)(s)=\Bigl(\sum_{n\ge1}a_n\,n^{-s}\Bigr)(\mathcal Mh)(s).
\]
```

#### MCV5 proof
```tex
Put $\sigma=\Re s$. In the notation of \ref{MCV4}(iii), $g=\sum_n a_nh_n$, and the $n$-th term has Mellin transform $a_nn^{-s}(\mathcal Mh)(s)$. Summing over $n$ under the integral is allowed because
\[
\sum_{n\ge1}\int_1^\infty|a_nh_n(x)|\,x^{-\sigma-1}\,dx=\Bigl(\sum_{n\ge1}|a_n|\,n^{-\sigma}\Bigr)(\mathcal M|h|)(\sigma)<\infty.
\]
```

#### MCV6 statement
```tex
Let $c\in\R$, and let $f\colon[1,\infty)\to\C$ be absolutely continuous on every interval $[1,X]$, with $f(1)=0$, $f(x)=O_\varepsilon(x^{c+\varepsilon})$ and $f'(x)=O_\varepsilon(x^{c-1+\varepsilon})$ for almost every $x$, for every $\varepsilon>0$. For every $s\in\C$ with $\Re s>c$,
\[
\mathcal M(xf')(s)=s\,(\mathcal Mf)(s),\qquad\text{and hence}\qquad\mathcal M(xf'-f)(s)=(s-1)\,(\mathcal Mf)(s),
\]
where $xf'$ denotes the function $x\mapsto xf'(x)$.
```

#### MCV6 proof
```tex
Integrate by parts on $[1,X]$, using $f(1)=0$:
\[
\int_1^X f'(x)\,x^{-s}\,dx=f(X)\,X^{-s}+s\int_1^X f(x)\,x^{-s-1}\,dx.
\]
As $X\to\infty$, $f(X)X^{-s}\to0$ because $\Re s>c$, and both integrals converge absolutely by \hyperref[8JS8]{absolute convergence}.
```

#### MCV7 statement
```tex
Let $\Psi_{\mathbf 1}$ be the \hyperref[8JUT]{Chebyshev function} and $R_{\mathbf 1}$ the \hyperref[8JF7]{smoothed prime sum} of the trivial character. By \ref{8JUU}, for $\Re s>1$,
\[
(\mathcal M\Psi_{\mathbf 1})(s)=-\frac{\zeta'(s)}{\zeta(s)}\cdot\frac1s=\Bigl(\sum_{n\ge1}\Lambda(n)\,n^{-s}\Bigr)\mathcal M(1)(s),
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

\emph{Back again.} $R_{\mathbf 1}$ is continuous with $R_{\mathbf 1}(1)=0$, and off the prime powers $R_{\mathbf 1}'(x)=\sum_{n\le x}\Lambda(n)/n$. By \ref{MCV6}, $\mathcal M(xR_{\mathbf 1}'-R_{\mathbf 1})=(s-1)\,\mathcal MR_{\mathbf 1}=\mathcal M\Psi_{\mathbf 1}$, and indeed
\[
xR_{\mathbf 1}'(x)-R_{\mathbf 1}(x)=\sum_{n\le x}\Lambda(n)\frac xn-\sum_{n\le x}\Lambda(n)\Bigl(\frac xn-1\Bigr)=\Psi_{\mathbf 1}(x).
\]
The \hyperref[8JS9]{graphs} compare $\Psi_{\mathbf 1}$, $R_{\mathbf 1}$ and the slope $R_{\mathbf 1}'$ for $1\le x\le20$.
```

### Change to 8JV3

In 8JV3's `statement_tex`, replace the exact phrase
```tex
For $\Re s>1$, reversing the order of integration gives
```
with
```tex
Since $R_\chi=\Psi_\chi\star x$, the \hyperref[MCV3]{convolution theorem} and $\mathcal M(x)(s)=1/(s-1)$ from \ref{MCV4} give, for $\Re s>1$,
```
Use `replace(...)` in SQL. Bump the revision, clear the cache, write the snapshot, and add refs for MCV3 and MCV4.

## Constraints

- No remote DB writes, no `wrangler deploy`, no remote migration. Do not commit.
- Do not change any other result text.

## Acceptance

1. `npm test` and `npm run typecheck` pass. The new book test is included.
2. **`scripts/check-mellin-appendix-2026-11-27.mjs`**, run with Node 26 and `node:sqlite`:
   - Restore `backup-before-mellin-appendix-2026-11-27.sql` (repo root, gitignored) into an in-memory DB, apply `migrations/0004_appendix_chapters.sql`, then the content script in one transaction.
   - **Checks:**
     - the guard blocks a second run;
     - revisions and snapshots match the rows;
     - refs match the targets parsed by the site renderer for every new or changed statement and proof (reuse how `scripts/check-chapter3-self-contained-2026-11-27.mjs` calls `src/latex.ts` renderTex);
     - renderTex/KaTeX gives no warnings on all new or changed TeX fields, using the stored macros;
     - `loadBook`-style numbering (reuse `src/book.ts` logic if practical) gives APXA "A", APXS "A.1", MCV9 "A.1.1", 8JS2 "A.1.2", MCV2 "A.1.3", MCV3 "A.1.4", MCV4 "A.1.5", MCV5 "A.1.6", MCV6 "A.1.7", MCV7 "A.1.8", 8JS8 unnumbered, and chapters 1–4 unchanged.
3. **Report** in `implement_plan/tasks/2026-11-27-mellin-appendix.md.report.md`:
   - the files changed;
   - the test outputs;
   - the order of the remote steps:
     1. remote migration;
     2. content SQL;
     3. deploy.
