import { test } from "node:test";
import assert from "node:assert/strict";
import { splitMacroDefs, macrosUsed, buildPrompt } from "../public/static/pinboard-core.js";

test("splitMacroDefs preserves supported definitions and their original comments", () => {
  const abs = String.raw`\newcommand{\abs}[1]{\left|#1\right|}`;
  const rationals = String.raw`\newcommand\Q{\mathbb{Q}}`;
  const pair = String.raw`\newcommand{\pair}[2]
  {\langle #1, % ignore this }
  % This comment is inside the definition.
  #2 \rangle} % keep this comment`;
  const residue = String.raw`\DeclareMathOperator*{\Res}{Res}`;
  const epsilon = String.raw`\def\eps{\varepsilon}`;
  const percent = String.raw`\providecommand*{\pct}{\%\{}`;
  const real = String.raw`\renewcommand\Re{\operatorname{Re}} % }`;
  const identity = String.raw`\gdef\id#1{#1}`;
  const rank = String.raw`\DeclareMathOperator\rk{rk}`;
  const src = ["  % comment {", abs, rationals, pair, "\\unrecognized{ignored}", residue,
    epsilon, percent, real, identity, rank, "% trailing comment"].join("\n");

  assert.deepEqual(splitMacroDefs(src), [
    { name: "\\abs", text: abs },
    { name: "\\Q", text: rationals },
    { name: "\\pair", text: pair },
    { name: "\\Res", text: residue },
    { name: "\\eps", text: epsilon },
    { name: "\\pct", text: percent },
    { name: "\\Re", text: real },
    { name: "\\id", text: identity },
    { name: "\\rk", text: rank },
  ]);
});

test("splitMacroDefs splits same-line definitions only at the top level", () => {
  const first = String.raw`\newcommand{\A}{\def\nested{a}}`;
  const second = String.raw`\newcommand\B{b} % \newcommand{\C}{c}`;

  assert.deepEqual(splitMacroDefs(first + second), [
    { name: "\\A", text: first },
    { name: "\\B", text: second },
  ]);
});

test("macrosUsed follows transitive dependencies in source order", () => {
  const defs = splitMacroDefs(String.raw`\newcommand{\A}{\C}
\newcommand{\Q}{\mathbb{Q}}
\newcommand{\B}{\A} % \Q
\newcommand{\C}{\B}`);

  assert.deepEqual(macrosUsed(String.raw`$\B$ and $\Qbar$`, defs), [defs[0], defs[2], defs[3]]);
  assert.deepEqual(macrosUsed(String.raw`$\Qbar$`, defs), []);
});

test("macrosUsed ignores TeX comments and keeps commands after an escaped percent", () => {
  const defs = splitMacroDefs(String.raw`\newcommand{\A}{a}
\newcommand{\B}{% \A
  b}`);

  assert.deepEqual(macrosUsed(String.raw`\B % \A`, defs), [defs[1]]);
  assert.deepEqual(macrosUsed(String.raw`\% \A`, defs), [defs[0]]);
  assert.deepEqual(macrosUsed(String.raw`\\% \A`, defs), []);
});

const bookTitle = "Example notes";
const item = { label: "Lemma 1", url: "https://notes.example/tag/ABCD", text: "The statement." };
const macroDefs = splitMacroDefs(String.raw`\newcommand{\A}{a}
\newcommand{\B}{\A}
\newcommand{\Q}{\mathbb{Q}}`);

test("buildPrompt omits a blank question and unused macro definitions", () => {
  const prompt = buildPrompt({ bookTitle, items: [item], question: " \n ", macroDefs });
  assert.equal(prompt, `I'm reading "Example notes". Below are the parts I pinned; math is in LaTeX.

## Lemma 1
Source: https://notes.example/tag/ABCD

The statement.
`);
});

test("buildPrompt includes citations, used macros, and the trimmed question", () => {
  const text = String.raw`$$
\B = 1
$$`;
  const prompt = buildPrompt({
    bookTitle,
    items: [item, { label: "Formula in Lemma 1", url: item.url, text }],
    question: "  Why is $\\Q$ relevant?\n\n\nWhat can I use? \n",
    macroDefs,
  });
  assert.equal(prompt, [
    'I\'m reading "Example notes". Below are the parts I pinned; math is in LaTeX.',
    "",
    "Macros used:",
    "```latex",
    "\\newcommand{\\A}{a}",
    "\\newcommand{\\B}{\\A}",
    "\\newcommand{\\Q}{\\mathbb{Q}}",
    "```",
    "",
    "## Lemma 1",
    "Source: https://notes.example/tag/ABCD",
    "",
    "The statement.",
    "",
    "## Formula in Lemma 1",
    "Source: https://notes.example/tag/ABCD",
    "",
    text,
    "",
    "## Where I'm stuck",
    "Why is $\\Q$ relevant?",
    "",
    "What can I use?",
    "",
  ].join("\n"));
});
