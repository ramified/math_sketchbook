import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import { DatabaseSync } from "node:sqlite";
import { fillRefs, loadBook } from "../src/book.ts";
import { buildMacros, parseBibliography, renderTex } from "../src/latex.ts";
import { isTag } from "../src/tags.ts";

const read = (path) => readFileSync(new URL(path, import.meta.url), "utf8");
const baseline = read("../backup-before-lattice-appendix-2026-11-28.sql");
const part1 = read("./lattice-appendix-part1-2026-11-28.sql");
const sql = read("./lattice-appendix-part2-2026-11-28.sql");
const operation = "lattice-appendix-part2-2026-11-28";
const timestamp = "2026-11-28 15:30:00";
const sections = [
  {
    tag: "BSE5", position: 4, title: "Hermitian lattices over CM fields", refs: ["8JV2"],
    results: [
      ["KD22", "definition", 1, "CM field", false],
      ["KD23", "lemma", 0, "Complex conjugation on a CM field", true],
      ["KD25", "definition", 1, "Hermitian spaces and unitary groups", false],
      ["KD27", "definition", 1, "Hermitian lattices and their normalized slope", false, "hermitian-lattice"],
      ["KD26", "lemma", 1, "The underlying Euclidean lattice", true],
      ["KD28", "lemma", 1, "The standard lattice has slope zero", true],
      ["KD24", "example", 0, "The Gaussian field", false],
      ["KD29", "remark", 1, "Lattices over CM fields in the book", false],
    ],
  },
  {
    tag: "BSE6", position: 5, title: "Theta series", refs: ["C4W2"],
    results: [
      ["KE22", "definition", 1, "Fourier transform", false],
      ["KE26", "lemma", 0, "Counting lattice points", true],
      ["KE23", "theorem", 1, "Poisson summation", true, "poisson-summation"],
      ["KE24", "lemma", 1, "The Fourier transform of a Gaussian", true],
      ["KE25", "definition", 1, "Theta series of a lattice", false, "theta-series"],
      ["KE27", "theorem", 1, "The inversion formula", true],
      ["KE28", "example", 0, "Theta series of $\\Z^n$ and $A_2$", false],
      ["KE2A", "remark", 1, "Theta series and the Weil representation", false],
    ],
  },
  {
    tag: "BSE7", position: 6, title: "Theta lifts in the definite case", refs: ["C4W2"],
    results: [
      ["KF22", "definition", 1, "Even lattices and genera", false],
      ["KF23", "theorem", 1, "Finiteness", true],
      ["KF24", "definition", 1, "Functions on classes and the mass", false],
      ["KF25", "definition", 1, "The theta lift", false, "theta-lift"],
      ["KF27", "lemma", 1, "Coefficients and products of theta lifts", true],
      ["KF26", "theorem", 1, "Siegel's formula", true],
      ["KF28", "example", 0, "The genus of discriminant $-23$", false],
      ["KF29", "remark", 1, "Theta lifts in the book", false],
    ],
  },
];
const kc29 = ["KC29", "remark", 1, "How the comparison uses the mean slope bound", false];
const results = [kc29, ...sections.flatMap((section) => section.results)];
const aliases = results.filter((result) => result[5]);
const proofCount = results.filter((result) => result[4]).length;
const newTags = [...sections.map(({ tag }) => tag), ...results.map(([tag]) => tag)];
const mainFields = [
  { entity: "section", id: 117, tag: "WJQV", revision: 5, links: ["KB22"], replacements: [
    ["a lattice whose slope replaces $\\ln|N|$", "a lattice whose \\hyperref[KB22]{slope} replaces $\\ln|N|$"],
  ] },
  { entity: "section", id: 107, tag: "8JU4", revision: 8, links: ["KC24", "KF25"], replacements: [
    ["A Bost-type slope inequality bounds", "A \\hyperref[KC24]{Bost-type slope inequality} bounds"],
    ["a chain of $m$ theta lifts between unitary groups", "a chain of $m$ \\hyperref[KF25]{theta lifts} between unitary groups"],
  ] },
  { entity: "result", id: 209, tag: "Q7MN", revision: 1, links: ["KB22", "KA26", "KB24", "KF25"], replacements: [
    ["Its slope $\\mu(R)\\in\\R$", "Its \\hyperref[KB22]{slope} $\\mu(R)\\in\\R$"],
    ["The period maps take values in the dual $R^\\vee$, whose slope is $-\\mu(R)$.",
      "The period maps take values in the \\hyperref[KA26]{dual} $R^\\vee$, whose slope is \\hyperref[KB24]{$-\\mu(R)$}."],
    ["Its theta kernel gives the map by a weighted sum over lattice classes.",
      "Its theta kernel gives the map by a \\hyperref[KF25]{weighted sum over lattice classes}."],
  ] },
  { entity: "result", id: 187, tag: "C4W2", revision: 1, links: ["KF25", "KD25"], replacements: [
    ["successive theta lifts between spaces of automorphic forms on definite unitary groups",
      "successive \\hyperref[KF25]{theta lifts} between spaces of automorphic forms on \\hyperref[KD25]{definite unitary groups}"],
  ] },
  { entity: "result", id: 154, tag: "8JV2", revision: 4, links: ["KD27"], replacements: [
    ["Here $\\mu(R)$ is the slope of the lattice $R$",
      "Here $\\mu(R)$ is the \\hyperref[KD27]{slope} of the lattice $R$"],
  ] },
  { entity: "proof", id: 114, tag: "8JUA", revision: 6, links: ["KF27", "KC24"], replacements: [
    ["A seesaw identity compares", "A \\hyperref[KF27]{seesaw identity} compares"],
    ["A Bost-type inequality gives an upper bound", "A \\hyperref[KC24]{Bost-type inequality} gives an upper bound"],
  ] },
  { entity: "proof", id: 162, tag: "Q7MQ", revision: 1, links: ["KC28"], replacements: [],
    append: "The appendix result \\ref{KC28} shows how a lower bound of this kind for a mean slope is proved." },
];
const fields = { section: "intro_tex", result: "statement_tex", proof: "body_tex" };
const caches = { section: "intro_html_cache", result: "statement_html_cache", proof: "body_html_cache" };
const snapshotKeys = {
  section: ["tag", "kind", "title", "intro_tex", "parent_id", "position", "appendix"],
  result: ["tag", "type", "title", "statement_tex", "section_id", "position", "listed", "understanding"],
  proof: ["result_id", "body_tex", "status", "generated_by", "generator_detail", "reviewed_by", "review_notes", "position", "understanding"],
  setting: ["key", "value"],
};

function apply(db, migration) {
  db.exec("BEGIN");
  try {
    db.exec(migration);
    db.exec("COMMIT");
  } catch (error) {
    if (db.isTransaction) db.exec("ROLLBACK");
    throw error;
  }
}

function restore() {
  const db = new DatabaseSync(":memory:", { enableForeignKeyConstraints: false });
  db.exec(baseline);
  db.exec("PRAGMA foreign_keys = ON");
  return db;
}

function checkGuard(db, label, setup = () => {}) {
  const count = db.prepare("SELECT count(*) AS n FROM write_guard");
  const before = count.get().n;
  db.exec("BEGIN; INSERT INTO write_guard (ok) VALUES (1)");
  setup(db);
  assert.throws(() => db.exec(sql), /CHECK constraint failed: ok = 1/, label);
  assert.equal(db.isTransaction, false, label);
  assert.equal(count.get().n, before, label);
}

function history(db, entity, row) {
  const key = entity === "setting" ? row.key : String(row.id);
  return db.prepare("SELECT * FROM revisions WHERE entity = ? AND entity_key = ? AND revision = ?")
    .get(entity, key, row.revision);
}

function checkSnapshot(db, entity, row) {
  const key = entity === "setting" ? row.key : String(row.id);
  const revision = history(db, entity, row);
  assert.ok(revision, entity + " " + key);
  assert.deepEqual([revision.operation_id, revision.author, revision.created_at], [operation, "codex", timestamp], key);
  const snapshot = Object.fromEntries(snapshotKeys[entity].map((field) => [field, row[field]]));
  if (entity === "result") {
    snapshot.aliases = db.prepare("SELECT alias FROM aliases WHERE tag = ?").all(row.tag).map(({ alias }) => alias);
  }
  assert.deepEqual(JSON.parse(revision.snapshot_json), snapshot, key);
}

const guardDb = restore();
checkGuard(guardDb, "part 1 missing");
apply(guardDb, part1);
checkGuard(guardDb, "a part 1 tag missing", (db) => db.exec("PRAGMA defer_foreign_keys = ON; DELETE FROM tags WHERE tag = 'KC28'"));
for (const tag of newTags) {
  checkGuard(guardDb, "tag collision " + tag, (db) => db.prepare("INSERT INTO tags (tag, kind) VALUES (?, 'result')").run(tag));
}
for (const [, , , , , alias] of aliases) {
  checkGuard(guardDb, "alias collision " + alias, (db) => db.prepare("INSERT INTO aliases (alias, tag) VALUES (?, 'APXB')").run(alias));
}
for (const { entity, id, tag, revision, replacements } of mainFields) {
  const field = fields[entity];
  checkGuard(guardDb, tag + " wrong revision", (db) => db.prepare("UPDATE " + entity + "s SET revision = revision + 1 WHERE id = ?").run(id));
  checkGuard(guardDb, tag + " admin revision", (db) => db.prepare(
    "UPDATE revisions SET author = 'admin' WHERE entity = ? AND entity_key = ? AND revision = ?",
  ).run(entity, String(id), revision));
  checkGuard(guardDb, tag + " newer history", (db) => db.prepare(
    "INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author) VALUES (?, ?, ?, 'guard-test', '{}', 'codex')",
  ).run(entity, String(id), revision + 1));
  for (const [phrase] of replacements) {
    const replace = "UPDATE " + entity + "s SET " + field + " = replace(" + field + ", ?, ?) WHERE id = ?";
    checkGuard(guardDb, tag + " absent phrase " + phrase, (db) => db.prepare(replace).run(phrase, "", id));
    checkGuard(guardDb, tag + " repeated phrase " + phrase, (db) => db.prepare(replace).run(phrase, phrase + "\n" + phrase, id));
  }
}

// Exercise baseline snapshot insertion independently of the backup's existing history.
const dropHistory = guardDb.prepare("DELETE FROM revisions WHERE entity = ? AND entity_key = ?");
const oldRows = mainFields.map(({ entity, id }) => {
  const row = guardDb.prepare("SELECT * FROM " + entity + "s WHERE id = ?").get(id);
  dropHistory.run(entity, String(id));
  return [entity, row];
});
const rebuild = (db) => db.prepare("SELECT * FROM settings WHERE key = 'needs_rebuild'").get();
dropHistory.run("setting", "needs_rebuild");
guardDb.exec("UPDATE settings SET value = '0' WHERE key = 'needs_rebuild'");
const oldRebuild = rebuild(guardDb);
checkGuard(guardDb, "admin rebuild setting", (db) => db.prepare(
  "INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author) VALUES ('setting', 'needs_rebuild', ?, 'guard-test', '{}', 'admin')",
).run(oldRebuild.revision));
apply(guardDb, sql);
for (const [entity, row] of oldRows) checkSnapshot(guardDb, entity, row);
checkSnapshot(guardDb, "setting", oldRebuild);
const rebuilt = rebuild(guardDb);
assert.deepEqual({ ...rebuilt }, { key: "needs_rebuild", value: "1", revision: oldRebuild.revision + 1 });
checkSnapshot(guardDb, "setting", rebuilt);
guardDb.close();

const db = restore();
apply(db, part1);
const bookDb = {
  prepare: (statement) => db.prepare(statement),
  batch: async (statements) => statements.map((statement) => ({ results: statement.all() })),
};
const before = await loadBook(bookDb, false);
const beforeEditor = await loadBook(bookDb, true);
const rowCounts = {
  tags: ["tag", newTags.length], aliases: ["alias", aliases.length],
  sections: ["id", sections.length], results: ["id", results.length], proofs: ["id", proofCount],
  refs: ["id", null], revisions: ["id", null],
  settings: ["key", 0], users: ["email", 0], reviews: ["id", 0],
};
const baselineRows = new Map(Object.keys(rowCounts).map((table) => [
  table, db.prepare("SELECT * FROM " + table).all(),
]));
const oldGuard = db.prepare("SELECT * FROM write_guard").all();

apply(db, sql);
assert.deepEqual(db.prepare("PRAGMA foreign_key_check").all(), []);
assert.deepEqual(db.prepare("PRAGMA integrity_check").all().map(({ integrity_check }) => integrity_check), ["ok"]);
assert.deepEqual(db.prepare("SELECT * FROM write_guard").all(), oldGuard);
checkGuard(db, "rerun");
console.log("PASS: in-memory migration, rollback, prerequisite tags, collisions, exact phrases, revisions and rebuild fallback");

const book = await loadBook(bookDb, false);
const editorBook = await loadBook(bookDb, true);
const setting = db.prepare("SELECT * FROM settings WHERE key = ?");
const { macros, error } = buildMacros(setting.get("macros").value);
assert.equal(error, undefined);
const citationKeys = new Set(parseBibliography(setting.get("bibliography").value).map(({ key }) => key));
const tagByName = db.prepare("SELECT * FROM tags WHERE tag = ?");
const bySection = db.prepare("SELECT * FROM sections WHERE tag = ?");
const byResult = db.prepare("SELECT * FROM results WHERE tag = ?");
const proofsFor = db.prepare("SELECT * FROM proofs WHERE result_id = ? ORDER BY position, id");
const aliasesFor = db.prepare("SELECT * FROM aliases WHERE tag = ? ORDER BY alias");
const storedRefs = db.prepare("SELECT target_tag FROM refs WHERE source_result_id = ? AND source_proof_id IS ? ORDER BY target_tag");
let snapshotCount = 0;
let renderedFields = 0;
let refCount = 0;

function checkTex(label, tex) {
  const { html, refs, warnings } = renderTex(tex, macros);
  assert.deepEqual(warnings, [], label);
  for (const target of refs) assert.ok(tagByName.get(target) && book.byTag.has(target), label + " targets " + target);
  for (const match of html.matchAll(/href="\/bibliography#cite-([^"]+)"/g)) {
    assert.ok(citationKeys.has(decodeURIComponent(match[1])), label + " cites " + match[1]);
  }
  renderedFields++;
  return { html, refs };
}

function checkLinks(label, html, targets) {
  const linked = fillRefs(html, book);
  for (const target of targets) assert.ok(linked.includes('href="/tag/' + target + '"'), label + " links to " + target);
}

function checkRefs(label, tex, resultId, proofId = null) {
  const { html, refs } = checkTex(label, tex);
  assert.deepEqual(storedRefs.all(resultId, proofId).map(({ target_tag }) => target_tag), [...refs].sort(), label);
  checkLinks(label, html, refs);
  refCount += refs.length;
  return refs;
}

function checkNewRow(entity, row) {
  const label = row.tag ?? String(row.id);
  assert.deepEqual([row.revision, row[caches[entity]], row.created_at, row.updated_at, row.updated_by],
    [1, null, timestamp, timestamp, "codex"], label);
  if (entity !== "proof") {
    assert.ok(isTag(row.tag), row.tag);
    const tag = tagByName.get(row.tag);
    assert.deepEqual([tag.kind, tag.created_at], [entity, timestamp], row.tag);
  }
  checkSnapshot(db, entity, row);
  snapshotCount++;
}

function checkResult(spec, sectionId, position, number) {
  const [tag, type, listed, title, hasProof, alias] = spec;
  const row = byResult.get(tag);
  assert.deepEqual([row.section_id, row.position, row.type, row.title, row.listed], [sectionId, position, type, title, listed], tag);
  assert.deepEqual([row.visibility, row.state, row.created_by, row.understanding], ["published", "active", "codex", "unclear"], tag);
  assert.deepEqual(aliasesFor.all(tag).map((entry) => [entry.alias, entry.created_at]), alias ? [[alias, timestamp]] : [], tag);
  checkNewRow("result", row);
  checkTex(tag + " title", row.title);
  checkRefs(tag + " statement", row.statement_tex, row.id);
  const proofs = proofsFor.all(row.id);
  assert.equal(proofs.length, Number(hasProof), tag);
  for (const proof of proofs) {
    assert.deepEqual([proof.position, proof.status, proof.generated_by, proof.generator_detail, proof.visibility, proof.created_by, proof.understanding],
      [1, "ai_generated", "gpt", "Codex (spec by Claude Opus 5.5)", "published", "codex", "unclear"], tag);
    checkNewRow("proof", proof);
    checkRefs(tag + " proof", proof.body_tex, row.id, proof.id);
  }
  assert.equal(book.byTag.get(tag).number, number, tag);
  assert.equal(editorBook.byTag.get(tag).number, number, tag);
}

const chapterId = bySection.get("APXB").id;
assert.equal(book.byTag.get("APXB").number, "B");
assert.deepEqual(book.sectionsOf.get(chapterId).map(({ tag }) => tag), ["BSE2", "BSE3", "BSE4", "BSE5", "BSE6", "BSE7"]);
const slopeSection = bySection.get("BSE4");
checkResult(kc29, slopeSection.id, 6, "B.3.5");
assert.equal(book.resultsOf.get(slopeSection.id).at(-1).tag, "KC29");
for (const { tag, position, title, results, refs: expectedRefs } of sections) {
  const row = bySection.get(tag);
  assert.deepEqual([row.parent_id, row.kind, row.position, row.appendix, row.title], [chapterId, "section", position, 0, title], tag);
  checkNewRow("section", row);
  checkTex(tag + " title", row.title);
  // Section introductions have no refs-table source. Check the reader's link resolver.
  const { html, refs } = checkTex(tag + " introduction", row.intro_tex);
  assert.deepEqual(refs, expectedRefs, tag);
  checkLinks(tag, html, refs);
  const number = "B." + position;
  assert.equal(book.byTag.get(tag).number, number, tag);
  assert.equal(editorBook.byTag.get(tag).number, number, tag);
  let listedNumber = 0;
  for (const [index, result] of results.entries()) {
    checkResult(result, row.id, index + 1, result[2] ? number + "." + ++listedNumber : "");
  }
  assert.deepEqual(book.resultsOf.get(row.id).map(({ tag }) => tag), results.filter(([, , listed]) => listed).map(([tag]) => tag));
}

for (const { entity, id, tag, revision, replacements, append, links } of mainFields) {
  const table = entity + "s";
  const field = fields[entity];
  const old = baselineRows.get(table).find((row) => row.id === id);
  const row = db.prepare("SELECT * FROM " + table + " WHERE id = ?").get(id);
  assert.equal(old.revision, revision, tag);
  assert.equal(entity === "proof" ? db.prepare("SELECT tag FROM results WHERE id = ?").get(old.result_id).tag : old.tag, tag);
  let expected = old[field];
  for (const [phrase, replacement] of replacements) {
    assert.equal(expected.split(phrase).length - 1, 1, tag + " baseline phrase " + phrase);
    expected = expected.replace(phrase, () => replacement);
  }
  if (append) expected += "\n\n" + append;
  assert.deepEqual({ ...row }, {
    ...old, [field]: expected, [caches[entity]]: null, revision: revision + 1, updated_at: timestamp, updated_by: "codex",
  }, tag);
  const savedBaseline = history(db, entity, old);
  assert.ok(savedBaseline, tag + " baseline snapshot");
  assert.equal(JSON.parse(savedBaseline.snapshot_json)[field], old[field], tag);
  checkSnapshot(db, entity, row);
  snapshotCount++;
  if (entity === "section") {
    const { html, refs } = checkTex(tag + " introduction", row[field]);
    for (const target of links) assert.ok(refs.includes(target), tag);
    checkLinks(tag, html, refs);
  } else {
    const refs = entity === "result"
      ? checkRefs(tag + " statement", row[field], id)
      : checkRefs(tag + " proof", row[field], row.result_id, id);
    for (const target of links) assert.ok(refs.includes(target), tag);
  }
}

assert.equal(rebuild(db).value, "1");
assert.equal(db.prepare("SELECT count(*) AS n FROM revisions WHERE operation_id = ?").get(operation).n, snapshotCount);
const changedStatements = new Set(mainFields.filter(({ entity }) => entity === "result").map(({ id }) => id));
const changedProofs = new Set(mainFields.filter(({ entity }) => entity === "proof").map(({ id }) => id));
const replacedRefs = (row) => row.source_proof_id === null
  ? changedStatements.has(row.source_result_id)
  : changedProofs.has(row.source_proof_id);
rowCounts.refs[1] = refCount - baselineRows.get("refs").filter(replacedRefs).length;
rowCounts.revisions[1] = snapshotCount;
for (const [table, [key, added]] of Object.entries(rowCounts)) {
  const rows = baselineRows.get(table);
  const lookup = db.prepare("SELECT * FROM " + table + " WHERE " + key + " = ?");
  assert.equal(db.prepare("SELECT count(*) AS n FROM " + table).get().n, rows.length + added, table);
  for (const row of rows) {
    if (mainFields.some(({ entity, id }) => entity + "s" === table && id === row.id)) continue;
    if (table === "refs" && replacedRefs(row)) continue;
    assert.deepEqual(lookup.get(row[key]), row, table + " " + row[key]);
  }
}
console.log("PASS: " + snapshotCount + " revision snapshots, " + mainFields.length + " main-chapter edits, and preservation of other rows");
console.log("PASS: " + renderedFields + " TeX fields without warnings and " + refCount + " stored reference targets");

assert.deepEqual(book.chapters, before.chapters);
for (const [tag, entry] of before.byTag) assert.deepEqual(book.byTag.get(tag), entry, tag);
for (const [tag, entry] of beforeEditor.byTag) assert.deepEqual(editorBook.byTag.get(tag), entry, tag);
console.log("PASS: B.4–B.6, KC29 at B.3.5, listed and unlisted results, and existing numbering");

function cartesian(values, length) {
  let tuples = [[]];
  for (let i = 0; i < length; i++) tuples = tuples.flatMap((tuple) => values.map((value) => [...tuple, value]));
  return tuples;
}

function near(actual, expected) {
  assert.ok(Math.abs(actual - expected) < 1e-10, actual + " vs " + expected);
}

function checkExampleTex(tag, ...snippets) {
  const tex = byResult.get(tag).statement_tex;
  for (const snippet of snippets) assert.ok(tex.includes(snippet), tag + " should contain " + snippet);
}

const gaussianTrace = ([real]) => 2 * real;
const gaussianProduct = ([x, y], [u, v]) => [x * u - y * v, x * v + y * u];
const gaussianBasis = [[1, 0], [0, 1]];
const traceGram = gaussianBasis.map((x) => gaussianBasis.map((y) => gaussianTrace(gaussianProduct(x, y))));
const determinant = ([[a, b], [c, d]]) => a * d - b * c;
const fieldDegree = gaussianBasis.length;
const discriminant = determinant(traceGram);
assert.equal(fieldDegree, 2);
assert.equal(discriminant, -4);

function hermitian(x, y) {
  let real = 0;
  let imag = 0;
  for (let i = 0; i < x.length; i += 2) {
    real += x[i] * y[i] + x[i + 1] * y[i + 1];
    imag += x[i + 1] * y[i] - x[i] * y[i + 1];
  }
  return [real, imag];
}

for (const n of [1, 2]) {
  const basis = Array.from({ length: 2 * n }, (_, i) => Array.from({ length: 2 * n }, (_, j) => Number(i === j)));
  for (const [i, x] of basis.entries()) {
    for (const [j, y] of basis.entries()) {
      assert.equal(gaussianTrace(hermitian(x, y)) / 2, Number(i === j));
    }
  }
  const covolume = 1; // The computed Gram matrix is the identity.
  const euclideanSlope = -Math.log(covolume) / basis.length;
  near(2 * euclideanSlope - Math.log(2) + Math.log(Math.abs(discriminant)) / fieldDegree, 0);

  // Every entry of a norm-one column has real and imaginary parts in {-1, 0, 1}.
  const units = cartesian([-1, 0, 1], 2 * n).filter((vector) => hermitian(vector, vector)[0] === 1);
  assert.equal(units.length, 4 * n);
  assert.deepEqual(new Set(units.map((vector) => vector.join(","))),
    new Set(basis.flatMap((vector) => [vector.join(","), vector.map((x) => -x).join(",")])));
  const matrices = cartesian(units, n).filter((columns) => columns.every((v, i) => columns.every((w, j) => {
    const [real, imag] = hermitian(v, w);
    return real === Number(i === j) && imag === 0;
  })));
  assert.equal(matrices.length, 4 ** n * (n === 1 ? 1 : 2));
  assert.equal(matrices.length, n === 1 ? 4 : 32);
  for (const columns of matrices) {
    const rows = columns.map((vector) => Math.floor(vector.findIndex((x) => x !== 0) / 2));
    assert.equal(new Set(rows).size, n);
  }
}
checkExampleTex("KD24", "\\Delta_E=" + discriminant, "\\Z^{2n}", "\\tfrac12\\ln 4=0", "|U(\\Lambda)|=4^n n!");
console.log("PASS: KD24 Gaussian discriminant, metric, slope, norm-one vectors and unitary orders 4 and 32");

function quadratic([a, b, c], x, y) {
  return a * x * x + b * x * y + c * y * y;
}

function vectorsForForm(form, limit) {
  const [a, b, c] = form;
  const det = a * c - (b / 2) ** 2;
  // Complete the square in each coordinate to bound the other one.
  const xBound = Math.ceil(Math.sqrt(limit * c / det));
  const yBound = Math.ceil(Math.sqrt(limit * a / det));
  const vectors = [];
  for (let x = -xBound; x <= xBound; x++) {
    for (let y = -yBound; y <= yBound; y++) {
      const value = quadratic(form, x, y);
      if (value <= limit) vectors.push({ x, y, value });
    }
  }
  return vectors;
}

const degree = 9;
function thetaCoefficients(form) {
  const coefficients = Array(degree + 1).fill(0);
  for (const { value } of vectorsForForm(form, degree)) coefficients[value]++;
  return coefficients;
}

function polynomial(coefficients) {
  return coefficients.flatMap((value, i) => {
    if (value === 0) return [];
    const monomial = (i === 0 || Math.abs(value) !== 1 ? Math.abs(value) : "")
      + (i === 0 ? "" : "q") + (i >= 2 ? "^" + i : "");
    return [(value < 0 ? "-" : "+") + monomial];
  }).join("").replace(/^\+/, "");
}

function gaussianSum(lengthSquared, t) {
  // On the lattices considered here the omitted directions have Gaussian tails below 1e-10.
  let sum = 0;
  for (let k = -16; k <= 16; k++) sum += Math.exp(-Math.PI * t * lengthSquared(k));
  return sum;
}

const z2 = thetaCoefficients([1, 0, 1]);
assert.deepEqual(z2, [1, 4, 4, 0, 4, 8, 0, 0, 4, 4]);
const z = Array.from({ length: degree + 1 }, (_, m) => Number.isInteger(Math.sqrt(m)) ? (m === 0 ? 1 : 2) : 0);
let power = [1, ...Array(degree).fill(0)];
for (const n of [1, 2, 3]) {
  power = power.map((_, m) => z.slice(0, m + 1).reduce((sum, coefficient, i) => sum + coefficient * power[m - i], 0));
  const counted = Array(degree + 1).fill(0);
  const coordinates = [-3, -2, -1, 0, 1, 2, 3];
  for (const vector of cartesian(coordinates, n)) {
    const squaredNorm = vector.reduce((sum, x) => sum + x * x, 0);
    if (squaredNorm <= degree) counted[squaredNorm]++;
  }
  assert.deepEqual(power, counted);
}
const a2 = thetaCoefficients([1, 1, 1]);
assert.deepEqual(a2, [1, 6, 0, 6, 6, 0, 0, 12, 0, 6]);
checkExampleTex("KE28", z2.join(","), polynomial(a2) + "+O(q^{10})");
const a2Covolume = Math.sqrt(determinant([[2, 1], [1, 2]]));
for (const t of [0.6, 1.25, 2]) {
  near(gaussianSum((x) => x * x, 1 / t), Math.sqrt(t) * gaussianSum((x) => x * x, t));
  let theta = 0;
  let thetaDual = 0;
  for (let x = -16; x <= 16; x++) {
    theta += gaussianSum((y) => 2 * quadratic([1, 1, 1], x, y), 1 / t);
    thetaDual += gaussianSum((y) => 2 / 3 * quadratic([1, -1, 1], x, y), t);
  }
  near(theta, t / a2Covolume * thetaDual);
}
console.log("PASS: KE28 square and hexagonal theta coefficients through index 9 and both inversions");

const forms = [[1, 1, 6], [2, 1, 3]];
function pairing([a, b, c], v, w) {
  return 2 * a * v.x * w.x + b * (v.x * w.y + v.y * w.x) + 2 * c * v.y * w.y;
}

function automorphisms(form) {
  const [a, b, c] = form;
  const vectors = vectorsForForm(form, Math.max(a, c));
  const first = vectors.filter(({ value }) => value === a);
  const second = vectors.filter(({ value }) => value === c);
  return first.flatMap((v) => second.filter((w) => pairing(form, v, w) === b && Math.abs(v.x * w.y - v.y * w.x) === 1));
}

const formDiscriminant = ([a, b, c]) => b * b - 4 * a * c;
const delta = formDiscriminant(forms[0]);
assert.equal(delta, -23);
assert.equal(formDiscriminant(forms[1]), delta);
const reduced = [];
for (let a = 1; 3 * a * a <= -delta; a++) {
  for (let b = -a; b <= a; b++) {
    const c = (b * b - delta) / (4 * a);
    if (Number.isInteger(c) && c >= a) reduced.push([a, b, c]);
  }
}
assert.deepEqual(reduced, [[1, -1, 6], [1, 1, 6], [2, -1, 3], [2, 1, 3]]);
assert.deepEqual(forms.map((form) => thetaCoefficients(form).findIndex((count, i) => i > 0 && count > 0)), [1, 2]);
// This determinant-one basis change lies in GL_2(Z_p) at every odd prime.
const u = { x: 1 / 2, y: -1 / 2 };
const v = { x: 3 / 2, y: 1 / 2 };
assert.equal(u.x * v.y - u.y * v.x, 1);
assert.deepEqual([pairing(forms[1], u, u) / 2, pairing(forms[1], u, v), pairing(forms[1], v, v) / 2], forms[0]);
// An isotropic vector with a unit derivative lifts at 2. Both Gram determinants are odd.
assert.ok([0, 1].some((x) => quadratic(forms[0], x, 1) % 2 === 0 && (2 * forms[0][0] * x + forms[0][1]) % 2 === 1));
assert.ok([0, 1].some((y) => quadratic(forms[1], 1, y) % 2 === 0 && (forms[1][1] + 2 * forms[1][2] * y) % 2 === 1));

const [order1, order2] = forms.map((form) => automorphisms(form).length);
assert.deepEqual([order1, order2], [4, 2]);
const mass = 1 / order1 + 1 / order2;
assert.equal(mass, 3 / 4);
const [theta1, theta2] = forms.map(thetaCoefficients);
assert.deepEqual(theta1, [1, 2, 0, 0, 2, 0, 4, 0, 4, 2]);
assert.deepEqual(theta2, [1, 0, 2, 2, 2, 0, 2, 0, 2, 2]);

// With an odd prime denominator the Kronecker symbol is the Legendre symbol.
const prime = Math.abs(delta);
const residues = new Set(Array.from({ length: prime - 1 }, (_, i) => (i + 1) ** 2 % prime));
const kronecker = (d) => d % prime === 0 ? 0 : residues.has(d % prime) ? 1 : -1;
for (let m = 0; m <= degree; m++) {
  let divisors = 0;
  for (let d = 1; d <= m; d++) {
    if (m % d === 0) divisors += kronecker(d);
  }
  const weighted = (theta1[m] / order1 + theta2[m] / order2) / mass;
  near(weighted, (theta1[m] + 2 * theta2[m]) / 3);
  near(weighted, m === 0 ? 1 : 2 * divisors / 3);
}

const f1 = 4;
const f2 = -2;
assert.equal(f1 / order1 + f2 / order2, 0);
const lift = theta1.map((count, m) => f1 / order1 * count + f2 / order2 * theta2[m]);
assert.deepEqual(lift, theta1.map((count, m) => count - theta2[m]));
const eta = Array(degree + 1).fill(0);
eta[1] = 2;
for (let n = 1; n < degree; n++) {
  for (const power of [n, prime * n]) {
    for (let m = degree; m >= power; m--) eta[m] -= eta[m - power];
  }
}
assert.deepEqual(lift, eta);
assert.deepEqual(eta, [0, 2, -2, -2, 0, 0, 2, 0, 2, 0]);
checkExampleTex("KF28", "discriminant $" + delta + "$", "|O(L_1)|=" + order1, "|O(L_2)|=" + order2,
  "m(\\mathcal G)=3/4", polynomial(theta1) + "+O(q^{10})", polynomial(theta2) + "+O(q^{10})",
  "f(L_1)=" + f1, "f(L_2)=" + f2, "2(" + polynomial(eta.map((count) => count / 2)) + ")+O(q^{10})");
console.log("PASS: KF28 discriminant, reduced forms, local equivalence, orthogonal orders, mass, theta coefficients, divisor sum and eta product through q^9");
db.close();
