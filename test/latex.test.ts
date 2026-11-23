import { test } from "node:test";
import assert from "node:assert/strict";
import { renderTex, renderInlineTex, buildMacros, rewriteRefTargets, findRefTargets, REF_OPEN, REF_CLOSE, parseBibliography } from "../src/latex.ts";

const { macros, error } = buildMacros(String.raw`\newcommand{\Q}{\mathbb{Q}}
\newcommand{\abs}[1]{\left|#1\right|}
\DeclareMathOperator{\Li}{Li}
\renewcommand{\Re}{\operatorname{Re}}
\newcommand{\pair}[2]{\langle #1,
  #2 \rangle} % multi-line definition`);

test("macros: renewcommand of built-ins, multi-line, errors isolated", () => {
  const r = renderTex(String.raw`$\Re s$ $\pair{a}{b}$`, macros);
  assert.deepEqual(r.warnings, []);
  assert.ok(!r.html.includes("ℜ"));
  const bad = buildMacros(String.raw`\newcommand{\A}{\frac{1}
\newcommand{\B}{b}`);
  assert.ok(bad.error);
});

test("macros build", () => {
  assert.equal(error, undefined);
  const r = renderTex(String.raw`$\Q$ and $\abs{x}$ and $\Li(x)$`, macros);
  assert.deepEqual(r.warnings, []);
  assert.match(r.html, /katex/);
});

test("text mode", () => {
  const r = renderTex(String.raw`Hello \emph{world} -- see \ref{4CHK} and \cite[Thm.~1]{Dav}.

\begin{itemize}
\item one
\item[(b)] two
\end{itemize}
<script>`, macros);
  assert.deepEqual(r.refs, ["4CHK"]);
  assert.ok(r.html.includes("<em>world</em>"));
  assert.ok(r.html.includes(REF_OPEN + "4CHK" + REF_CLOSE));
  assert.ok(r.html.includes("<ul><li>one</li>"));
  assert.ok(r.html.includes('class="item-label">(b)</span>'));
  assert.ok(r.html.includes("&lt;script&gt;"));
  assert.ok(r.html.includes("–"));
  assert.match(r.html, /\[<a class="cite" href="\/bibliography#cite-Dav">Dav<\/a>, Thm. 1\]/);
});

test("display math and environments", () => {
  const r = renderTex(String.raw`\[ \sum_n a_n \]
\begin{align} a &= b \\ c &= d \end{align}
\begin{CD} A @>>> B \end{CD}`, macros);
  assert.deepEqual(r.warnings, []);
  assert.equal((r.html.match(/math-display/g) ?? []).length, 3);
});

test("math errors become warnings", () => {
  const r = renderTex(String.raw`$\frac{1}$ and \foo{x}`, macros);
  assert.equal(r.warnings.length, 2);
  assert.match(r.html, /math-error/);
});

test("alias rewriting", () => {
  const src = String.raw`see \ref{dirichlet-char} and \ref{ 4CHK , grh } and $x$`;
  assert.deepEqual(findRefTargets(src).map((t) => t.target), ["dirichlet-char", "4CHK", "grh"]);
  const out = rewriteRefTargets(src, (t) => ({ "dirichlet-char": "4CHK", grh: "6EQS" } as Record<string, string>)[t] ?? null);
  assert.equal(out, String.raw`see \ref{4CHK} and \ref{ 4CHK , 6EQS } and $x$`);
});

test("bibliography", () => {
  assert.deepEqual(parseBibliography(String.raw`\bibitem{A} One. \bibitem{B} Two.`), [
    { key: "A", tex: "One." },
    { key: "B", tex: "Two." },
  ]);
});

test("commands named like Object.prototype members do not crash", () => {
  const r = renderTex(String.raw`\toString{x} \constructor \hasOwnProperty`, macros);
  assert.equal(r.warnings.length, 3);
  assert.equal(renderInlineTex(String.raw`A \toString title`, macros).includes("tex-unknown"), true);
});

test("placeholder characters in the source are stripped", () => {
  const r = renderTex("\\url{\uE000ABCD\uE001} and \uE000ABCD\uE001", macros);
  assert.deepEqual(r.refs, []);
  assert.ok(!/[\uE000\uE001]/.test(r.html));
});

test("javascript urls are not linked", () => {
  const r = renderTex(String.raw`\href{javascript:alert(1)}{x} \url{https://a.b}`, macros);
  assert.ok(!r.html.includes("javascript:"));
  assert.ok(r.html.includes('href="https://a.b"'));
});
