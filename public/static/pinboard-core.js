const DEFINITION_HEAD = /^\\(?:(?:newcommand|renewcommand|providecommand|DeclareMathOperator)\*?(?![A-Za-z])\s*(?:\{\s*(\\[A-Za-z]+)\s*\}|(\\[A-Za-z]+))?|g?def(?![A-Za-z])\s*(\\[A-Za-z]+)?)/;
const COMMAND = /\\(?:[A-Za-z]+|[^A-Za-z\s])/g;

function withoutComment(line) {
  return line.match(/^(?:\\.|[^\\%]|\\$)*/)[0];
}

export function splitMacroDefs(src) {
  const defs = [];
  let original = [];
  let clean = [];
  let depth = 0;

  function finish() {
    const head = clean.join("\n").trim().match(DEFINITION_HEAD);
    const name = head?.[1] ?? head?.[2] ?? head?.[3];
    if (name) defs.push({ name, text: original.join("\n").trim() });
    original = [];
    clean = [];
    depth = 0;
  }

  for (const raw of src.split(/\r?\n/)) {
    const line = withoutComment(raw);
    if (!original.length && !line.trim()) continue;
    if (original.length && depth === 0 && DEFINITION_HEAD.test(line.trimStart())) finish();
    original.push(raw);
    clean.push(line);
    for (let i = 0; i < line.length; i++) {
      if (line[i] === "\\") i++;
      else if (line[i] === "{") depth++;
      else if (line[i] === "}") depth--;
    }
    if (depth <= 0) {
      const chunk = clean.join("\n").trim();
      const head = chunk.match(DEFINITION_HEAD);
      // The replacement text can start on a later line.
      if (!head || chunk.slice(head[0].length).replace(/^(?:\s*\[[^\]]*\])*/, "").includes("{")) finish();
    }
  }
  if (original.length) finish();
  return defs;
}

export function macrosUsed(text, defs) {
  const byName = new Map();
  for (const def of defs) {
    if (!byName.has(def.name)) byName.set(def.name, []);
    byName.get(def.name).push(def.text);
  }

  const needed = new Set();
  function visit(src) {
    for (const [name] of src.matchAll(COMMAND)) {
      if (byName.has(name)) needed.add(name);
    }
  }

  visit(text);
  // Set iteration also visits dependencies discovered along the way.
  for (const name of needed) {
    for (const def of byName.get(name)) {
      visit(def.split(/\r?\n/).map(withoutComment).join("\n").trimStart().replace(DEFINITION_HEAD, ""));
    }
  }
  return defs.filter((def) => needed.has(def.name));
}

export function buildPrompt({ bookTitle, items, question, macroDefs }) {
  const sections = ["I'm reading \"" + bookTitle + "\". Below are the parts I pinned; math is in LaTeX."];
  const used = macrosUsed([...items.map((item) => item.text), question].join("\n"), macroDefs);
  if (used.length) {
    sections.push("Macros used:\n```latex\n" + used.map((def) => def.text).join("\n") + "\n```");
  }
  for (const item of items) {
    sections.push("## " + item.label + "\nSource: " + item.url + "\n\n" + item.text.trim());
  }
  if (question.trim()) sections.push("## Where I'm stuck\n" + question.trim());
  return sections.join("\n\n").replace(/\r\n/g, "\n").replace(/\n(?:[ \t]*\n){2,}/g, "\n\n").trimEnd() + "\n";
}
