import { readFileSync } from "node:fs";
import { parse } from "@unified-latex/unified-latex-util-parse";
import { loadBook } from "../src/book.ts";
import { buildMacros, findRefTargets, parseBibliography, renderTex } from "../src/latex.ts";

const { macroSource, bibliography, fields, sections, results } = JSON.parse(readFileSync(0, "utf8"));
const { macros, error } = buildMacros(macroSource);
if (error) throw new Error(error);

function citationKeys(nodes) {
  const keys = [];
  for (const node of nodes) {
    if (node.type === "macro" && /^(cite|citep|citet)$/.test(node.content)) {
      const argument = node.args.findLast((arg) => arg.openMark === "{");
      const key = argument.content.map((part) => part.content ?? " ").join("");
      keys.push(...key.split(",").map((piece) => piece.trim()));
    }
    if (Array.isArray(node.content)) keys.push(...citationKeys(node.content));
    for (const arg of node.args ?? []) keys.push(...citationKeys(arg.content));
  }
  return keys;
}

const outputs = fields.map(({ tex }) => {
  const { refs, warnings } = renderTex(tex, macros);
  return {
    refs,
    parsedRefs: [...new Set(findRefTargets(tex).map(({ target }) => target))],
    citations: citationKeys(parse(tex).content),
    warnings,
  };
});
const entries = parseBibliography(bibliography).map(({ key, tex }) => ({
  key,
  warnings: renderTex(tex, macros).warnings,
}));
const book = await loadBook({
  prepare(query) {
    const rows = query.includes("FROM sections") ? sections : results;
    return { results: [...rows].sort((a, b) => a.position - b.position || a.id - b.id) };
  },
  batch(statements) {
    return statements;
  },
}, false);
const numbering = Object.fromEntries([...book.byTag].map(([tag, entry]) => [tag, entry.number]));

console.log(JSON.stringify({ outputs, entries, numbering }));
