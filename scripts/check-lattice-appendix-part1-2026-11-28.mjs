import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import { DatabaseSync } from "node:sqlite";
import { fillRefs, loadBook } from "../src/book.ts";
import { buildMacros, parseBibliography, renderTex } from "../src/latex.ts";
import { isTag } from "../src/tags.ts";

const read = (path) => readFileSync(new URL(path, import.meta.url), "utf8");
const baseline = read("../backup-before-lattice-appendix-2026-11-28.sql");
const sql = read("./lattice-appendix-part1-2026-11-28.sql");
const operation = "lattice-appendix-part1-2026-11-28";
const timestamp = "2026-11-28 15:00:00";
const chapterTag = "APXB";
const sections = [
  {
    tag: "BSE2", title: "Euclidean lattices", refs: ["Q7MN"],
    results: [
      ["KA22", "definition", 1, "Euclidean lattice", false, "euclidean-lattice"],
      ["KA23", "lemma", 0, "The covolume does not depend on the basis", true],
      ["KA25", "definition", 1, "Sublattices and quotient lattices", false],
      ["KA26", "definition", 1, "The dual lattice", false, "dual-lattice"],
      ["KA27", "lemma", 1, "Covolumes of sublattices, quotients and duals", true],
      ["KA24", "example", 0, "The hexagonal lattice $A_2$", false],
    ],
  },
  {
    tag: "BSE3", title: "Degree and slopes", refs: ["WJQV"],
    results: [
      ["KB22", "definition", 1, "Arakelov degree and slope", false, "arakelov-degree"],
      ["KB23", "motivation", 1, "An integer as a rank-one lattice", false],
      ["KB24", "lemma", 1, "Degrees of sublattices, quotients and duals", true],
      ["KB2B", "lemma", 0, "A norm-decreasing isomorphism raises the degree", true],
      ["KB25", "definition", 1, "Maximal and minimal slopes", false],
      ["KB26", "lemma", 0, "Finiteness of sublattices of large degree", true],
      ["KB28", "lemma", 0, "Degrees of sums and intersections", true],
      ["KB29", "lemma", 1, "The maximal destabilizing sublattice", true],
      ["KB27", "theorem", 1, "The Harder–Narasimhan filtration", true, "harder-narasimhan"],
      ["KB2C", "definition", 1, "Harder–Narasimhan slopes", false],
      ["KB2D", "lemma", 1, "The pieces above a threshold", true],
      ["KB2E", "example", 0, "Two orthogonal vectors, and $A_2$", false],
    ],
  },
  {
    tag: "BSE4", title: "The slope inequality", refs: ["Q7MQ", "8JUA"],
    results: [
      ["KC22", "definition", 1, "Norm and height of a map", false],
      ["KC24", "theorem", 1, "The slope inequality", true, "slope-inequality"],
      ["KC25", "example", 0, "Divisibility as a slope inequality", false],
      ["KC27", "lemma", 1, "Restricting many maps loses little of the target", true],
      ["KC28", "theorem", 1, "A lower bound for the mean slope", true, "mean-slope-bound"],
    ],
  },
];
const results = sections.flatMap((section) => section.results);
const aliases = results.filter((result) => result[5]);
const proofCount = results.filter((result) => result[4]).length;
const newTags = [chapterTag, ...sections.map(({ tag }) => tag), ...results.map(([tag]) => tag)];

function restore() {
  const db = new DatabaseSync(":memory:", { enableForeignKeyConstraints: false });
  db.exec(baseline);
  db.exec("PRAGMA foreign_keys = ON");
  return db;
}

function apply(db) {
  db.exec("BEGIN");
  try {
    db.exec(sql);
    db.exec("COMMIT");
  } catch (error) {
    if (db.isTransaction) db.exec("ROLLBACK");
    throw error;
  }
}

const guardDb = restore();
function checkGuard(db, setup = () => {}) {
  const count = db.prepare("SELECT count(*) AS n FROM write_guard");
  const before = count.get().n;
  db.exec("BEGIN; INSERT INTO write_guard (ok) VALUES (1)");
  setup(db);
  assert.throws(() => db.exec(sql), /CHECK constraint failed: ok = 1/);
  assert.equal(db.isTransaction, false);
  assert.equal(count.get().n, before);
}

for (const tag of newTags) {
  checkGuard(guardDb, (db) => db.prepare("INSERT INTO tags (tag, kind) VALUES (?, 'result')").run(tag));
}
for (const [, , , , , alias] of aliases) {
  checkGuard(guardDb, (db) => db.prepare("INSERT INTO aliases (alias, tag) VALUES (?, 'APXA')").run(alias));
}
checkGuard(guardDb, (db) => db.exec("UPDATE settings SET revision = 9 WHERE key = 'bibliography'"));
checkGuard(guardDb, (db) => db.exec("UPDATE revisions SET author = 'admin' WHERE entity = 'setting' AND entity_key = 'bibliography' AND revision = 10"));

// Check history creation when a setting changes and the old revision has no snapshot.
const oldBibliographyValue = guardDb.prepare("SELECT value FROM settings WHERE key = 'bibliography'").get().value;
guardDb.exec(`
  DELETE FROM revisions WHERE entity = 'setting' AND entity_key = 'bibliography' AND revision = 10;
  UPDATE settings SET value = '0' WHERE key = 'needs_rebuild';
`);
apply(guardDb);
const savedBibBaseline = guardDb.prepare("SELECT snapshot_json FROM revisions WHERE entity = 'setting' AND entity_key = 'bibliography' AND revision = 10").get();
assert.deepEqual(JSON.parse(savedBibBaseline.snapshot_json), { key: "bibliography", value: oldBibliographyValue });
assert.deepEqual({ ...guardDb.prepare("SELECT value, revision FROM settings WHERE key = 'needs_rebuild'").get() },
  { value: "1", revision: 2 });
const rebuildRevisions = guardDb.prepare("SELECT * FROM revisions WHERE entity = 'setting' AND entity_key = 'needs_rebuild' ORDER BY revision").all();
assert.deepEqual(rebuildRevisions.map((row) => [
  row.revision, row.author, row.operation_id, row.created_at, JSON.parse(row.snapshot_json),
]), [
  [1, "codex", operation, timestamp, { key: "needs_rebuild", value: "0" }],
  [2, "codex", operation, timestamp, { key: "needs_rebuild", value: "1" }],
]);
guardDb.close();

const db = restore();
const bookDb = {
  prepare: (sql) => db.prepare(sql),
  batch: async (statements) => statements.map((statement) => ({ results: statement.all() })),
};
const before = await loadBook(bookDb, false);
const beforeEditor = await loadBook(bookDb, true);
const baselineTables = {
  tags: ["tag", newTags.length], aliases: ["alias", aliases.length],
  sections: ["id", sections.length + 1], results: ["id", results.length],
  proofs: ["id", proofCount], refs: ["id", null], revisions: ["id", null], settings: ["key", 0],
};
const baselineRows = new Map(Object.keys(baselineTables).map((table) => [
  table, db.prepare("SELECT * FROM " + table).all(),
]));
const setting = db.prepare("SELECT * FROM settings WHERE key = ?");
const oldBib = setting.get("bibliography");
assert.equal(oldBib.revision, 10);

apply(db);
assert.deepEqual(db.prepare("PRAGMA foreign_key_check").all(), []);
checkGuard(db);
console.log("PASS: in-memory transaction, rerun rollback, tag and alias collisions, bibliography guards and rebuild flag");

const book = await loadBook(bookDb, false);
const editorBook = await loadBook(bookDb, true);
const { macros, error } = buildMacros(setting.get("macros").value);
assert.equal(error, undefined);
const tagByName = db.prepare("SELECT * FROM tags WHERE tag = ?");
const bySection = db.prepare("SELECT * FROM sections WHERE tag = ?");
const byResult = db.prepare("SELECT * FROM results WHERE tag = ?");
const proofsFor = db.prepare("SELECT * FROM proofs WHERE result_id = ? ORDER BY position, id");
const aliasesFor = db.prepare("SELECT * FROM aliases WHERE tag = ? ORDER BY alias");
const revisions = db.prepare("SELECT * FROM revisions WHERE entity = ? AND entity_key = ? AND revision = ?");
const storedRefs = db.prepare("SELECT target_tag FROM refs WHERE source_result_id = ? AND source_proof_id IS ? ORDER BY target_tag");
const bib = setting.get("bibliography");
const oldEntries = parseBibliography(oldBib.value);
const newEntries = parseBibliography(bib.value.slice(oldBib.value.length));
const entries = parseBibliography(bib.value);
const citationKeys = new Set(entries.map(({ key }) => key));

let snapshotCount = 0;
function checkSnapshot(entity, row, keys, extra = {}) {
  const key = entity === "setting" ? row.key : String(row.id);
  const revision = revisions.get(entity, key, row.revision);
  assert.ok(revision, entity + " " + key);
  assert.deepEqual([revision.operation_id, revision.author, revision.created_at], [operation, "codex", timestamp], key);
  const fields = Object.fromEntries(keys.map((field) => [field, row[field]]));
  assert.deepEqual(JSON.parse(revision.snapshot_json), { ...fields, ...extra }, key);
  snapshotCount++;
}

let renderedFields = 0;
let refSources = 0;
let refCount = 0;
function checkTex(label, tex) {
  const { html, refs, warnings } = renderTex(tex, macros);
  assert.deepEqual(warnings, [], label);
  for (const target of refs) {
    assert.ok(tagByName.get(target) && book.byTag.has(target), label + " targets " + target);
  }
  for (const match of html.matchAll(/href="\/bibliography#cite-([^"]+)"/g)) {
    assert.ok(citationKeys.has(decodeURIComponent(match[1])), label + " cites " + match[1]);
  }
  renderedFields++;
  return { html, refs };
}

function checkRefs(label, tex, resultId, proofId = null) {
  const { refs } = checkTex(label, tex);
  assert.deepEqual(storedRefs.all(resultId, proofId).map(({ target_tag }) => target_tag), [...refs].sort(), label);
  refSources++;
  refCount += refs.length;
}

function checkTag(tag, kind) {
  assert.ok(isTag(tag), tag);
  const row = tagByName.get(tag);
  assert.deepEqual([row.kind, row.created_at], [kind, timestamp], tag);
}

function checkRow(row, cache) {
  assert.deepEqual([row.revision, row[cache], row.created_at, row.updated_at, row.updated_by],
    [1, null, timestamp, timestamp, "codex"], row.tag ?? String(row.id));
}

function checkSection(tag, parentId, kind, position, appendix, title, introRefs, number) {
  const row = bySection.get(tag);
  assert.deepEqual([row.parent_id, row.kind, row.position, row.appendix, row.title],
    [parentId, kind, position, appendix, title], tag);
  checkTag(tag, "section");
  checkRow(row, "intro_html_cache");
  checkSnapshot("section", row, ["tag", "parent_id", "kind", "title", "intro_tex", "position", "appendix"]);
  checkTex(tag + " title", row.title);
  // The refs table has no section source. Check the introduction through the same link resolver as the reader.
  const { html, refs } = checkTex(tag + " introduction", row.intro_tex);
  assert.deepEqual(refs, introRefs, tag);
  const linked = fillRefs(html, book);
  for (const target of introRefs) assert.ok(linked.includes('href="/tag/' + target + '"'), tag + " links to " + target);
  assert.equal(book.byTag.get(tag).number, number, tag);
  return row.id;
}

const chapterId = checkSection(chapterTag, null, "chapter", 101, 1, "Lattices, slopes and theta series", ["Q7MK", "8JV5"], "B");
assert.equal(book.byTag.get(chapterTag).label, "Appendix B");
assert.deepEqual(book.sectionsOf.get(chapterId).map(({ tag }) => tag), sections.map(({ tag }) => tag));
for (const [index, section] of sections.entries()) {
  const number = "B." + (index + 1);
  const sectionId = checkSection(section.tag, chapterId, "section", index + 1, 0, section.title, section.refs, number);
  let listedNumber = 0;
  for (const [index, [tag, type, listed, title, hasProof, alias]] of section.results.entries()) {
    const row = byResult.get(tag);
    assert.deepEqual([row.section_id, row.position, row.type, row.title, row.listed], [sectionId, index + 1, type, title, listed], tag);
    assert.deepEqual([row.visibility, row.state, row.created_by, row.understanding], ["published", "active", "codex", "unclear"], tag);
    checkTag(tag, "result");
    checkRow(row, "statement_html_cache");
    assert.deepEqual(aliasesFor.all(tag).map((entry) => [entry.alias, entry.created_at]), alias ? [[alias, timestamp]] : [], tag);
    checkSnapshot("result", row, ["tag", "type", "title", "statement_tex", "section_id", "position", "listed", "understanding"],
      { aliases: alias ? [alias] : [] });
    checkTex(tag + " title", row.title);
    checkRefs(tag + " statement", row.statement_tex, row.id);
    const proofs = proofsFor.all(row.id);
    assert.equal(proofs.length, Number(hasProof), tag);
    for (const proof of proofs) {
      assert.deepEqual([proof.position, proof.status, proof.generated_by, proof.generator_detail, proof.visibility, proof.created_by, proof.understanding],
        [1, "ai_generated", "gpt", "Codex (spec by Claude Opus 5.5)", "published", "codex", "unclear"], tag);
      checkRow(proof, "body_html_cache");
      checkSnapshot("proof", proof, ["result_id", "body_tex", "status", "generated_by", "generator_detail",
        "reviewed_by", "review_notes", "position", "understanding"]);
      checkRefs(tag + " proof", proof.body_tex, row.id, proof.id);
    }
    const expected = listed ? number + "." + ++listedNumber : "";
    assert.equal(book.byTag.get(tag).number, expected, tag);
    assert.equal(editorBook.byTag.get(tag).number, expected, tag);
  }
  assert.deepEqual(book.resultsOf.get(sectionId).map(({ tag }) => tag),
    section.results.filter(([, , listed]) => listed).map(([tag]) => tag));
}

assert.ok(bib.value.startsWith(oldBib.value));
assert.equal(bib.revision, oldBib.revision + 1);
assert.deepEqual(entries, [...oldEntries, ...newEntries]);
assert.deepEqual(newEntries.map(({ key }) => key), [
  "Zhang", "Bost2001", "Stuhler1976", "Grayson1984", "Serre1973", "Weil1964", "Cassels1978", "Siegel1935", "Gross1999", "Kudla1984",
]);
assert.equal(citationKeys.size, entries.length);
for (const { key, tex } of newEntries) checkTex("Bibliography " + key, tex);
assert.equal(JSON.parse(revisions.get("setting", oldBib.key, oldBib.revision).snapshot_json).value, oldBib.value);
checkSnapshot("setting", bib, ["key", "value"]);
assert.equal(setting.get("needs_rebuild").value, "1");
assert.equal(db.prepare("SELECT count(*) AS n FROM revisions WHERE operation_id = ?").get(operation).n, snapshotCount);
baselineTables.refs[1] = refCount;
baselineTables.revisions[1] = snapshotCount;
for (const [table, [key, added]] of Object.entries(baselineTables)) {
  const rows = baselineRows.get(table);
  const lookup = db.prepare("SELECT * FROM " + table + " WHERE " + key + " = ?");
  assert.equal(db.prepare("SELECT count(*) AS n FROM " + table).get().n, rows.length + added, table);
  for (const row of rows) {
    if (table === "settings" && row.key === "bibliography") continue;
    assert.deepEqual(lookup.get(row[key]), row, table + " " + row[key]);
  }
}
console.log("PASS: " + snapshotCount + " new snapshots, bibliography revision and preservation of existing rows");
console.log("PASS: " + renderedFields + " TeX fields without warnings, " + refCount + " stored targets across "
  + refSources + " statements and proofs, and 4 introductions linked");

assert.deepEqual(book.chapters.slice(0, -1), before.chapters);
assert.equal(book.chapters.at(-1).tag, chapterTag);
for (const [tag, entry] of before.byTag) assert.deepEqual(book.byTag.get(tag), entry, tag);
for (const [tag, entry] of beforeEditor.byTag) assert.deepEqual(editorBook.byTag.get(tag), entry, tag);
console.log("PASS: Appendix B, sections B.1–B.3, 23 listed/unlisted result checks and all existing numbers unchanged");

const epsilon = 1e-10;
function near(actual, expected) {
  assert.ok(Math.abs(actual - expected) < epsilon, actual + " vs " + expected);
}
const dot = ([x, y], [u, v]) => x * u + y * v;
const cross = ([x, y], [u, v]) => x * v - y * u;
const norm = ([x, y]) => Math.hypot(x, y);
const scale = ([x, y], t) => [t * x, t * y];
const add = ([x, y], [u, v]) => [x + u, y + v];
const subtract = ([x, y], [u, v]) => [x - u, y - v];
const perpendicular = ([x, y]) => [-y, x];
const reject = (v, u) => subtract(v, scale(u, dot(v, u) / dot(u, u)));
const covol = ([u, v]) => Math.abs(cross(u, v));
const gram = (basis) => basis.map((u) => basis.map((v) => dot(u, v)));
function dual([u, v]) {
  const det = cross(u, v);
  return [scale(perpendicular(v), -1 / det), scale(perpendicular(u), 1 / det)];
}

// A norm bound implies |x_i| <= radius * |e_i^vee| for each integer coordinate.
function vectorsInBall([u, v], radius) {
  const [xBound, yBound] = dual([u, v]).map((vector) => Math.ceil(radius * norm(vector)));
  const vectors = [];
  for (let x = -xBound; x <= xBound; x++) {
    for (let y = -yBound; y <= yBound; y++) {
      const length = norm(add(scale(u, x), scale(v, y)));
      if (length <= radius + epsilon && (x !== 0 || y !== 0)) vectors.push({ x, y, length });
    }
  }
  return vectors;
}

const a2 = [[Math.sqrt(2), 0], [1 / Math.sqrt(2), Math.sqrt(3 / 2)]];
const [e1, e2] = a2;
const a2Dual = dual(a2);
for (const [basis, expected] of [[a2, [[2, 1], [1, 2]]], [a2Dual, [[2 / 3, -1 / 3], [-1 / 3, 2 / 3]]]]) {
  for (const [i, row] of gram(basis).entries()) {
    for (const [j, value] of row.entries()) near(value, expected[i][j]);
  }
}
for (const [i, e] of a2.entries()) {
  for (const [j, f] of a2Dual.entries()) near(dot(e, f), Number(i === j));
}
near(covol(a2), Math.sqrt(3));
near(covol(a2Dual), 1 / Math.sqrt(3));
const doubled = a2.map((vector) => scale(vector, 2));
near(covol(doubled), 4 * Math.sqrt(3));
const doubledDual = dual(doubled);
const cosets = new Set();
for (let x = -2; x <= 2; x++) {
  for (let y = -2; y <= 2; y++) {
    const v = add(scale(e1, x), scale(e2, y));
    cosets.add(doubledDual.map((f) => Math.round(2 * dot(v, f)) & 1).join(","));
  }
}
assert.equal(cosets.size, 4);
near(norm(e1), Math.sqrt(2));
const projectionLength = norm(reject(e2, e1));
near(projectionLength, Math.sqrt(3 / 2));
near(norm(e1) * projectionLength, Math.sqrt(3));
for (let y = -4; y <= 4; y++) {
  const projected = norm(reject(add(e1, scale(e2, y)), e1));
  near(projected, Math.abs(y) * projectionLength);
  assert.equal(projected < epsilon, y === 0);
}
console.log("PASS: KA24 Gram matrices, covolumes, index, saturation and quotient length");

for (const [a, b] of [[0.5, 3], [2, 5], [1, 1], [3, 3]]) {
  const basis = [[a, 0], [0, b]];
  const area = covol(basis);
  const mean = -Math.log(area) / 2;
  near(mean, -0.5 * Math.log(a * b));
  const candidates = vectorsInBall(basis, b);
  for (const { y, length } of candidates) {
    if (y !== 0) assert.ok(length >= b - epsilon);
  }
  const shortest = Math.min(...candidates.map(({ length }) => length));
  near(shortest, a);
  // A shortest vector is primitive. For a primitive vector v the quotient length is area / |v|.
  const maxSlope = Math.max(mean, -Math.log(shortest));
  const minSlope = Math.min(mean, -Math.log(area / shortest));
  near(maxSlope, -Math.log(a));
  near(minSlope, -Math.log(b));
  if (a < b) {
    const shortestVectors = candidates.filter(({ length }) => Math.abs(length - shortest) < epsilon);
    assert.equal(shortestVectors.length, 2);
    assert.ok(shortestVectors.every(({ x, y }) => Math.abs(x) === 1 && y === 0));
    near(-Math.log(norm(reject(basis[1], basis[0]))), -Math.log(b));
    assert.ok(maxSlope > minSlope);
  } else {
    near(maxSlope, mean);
  }
}
const a2Mean = -Math.log(covol(a2)) / 2;
near(a2Mean, -0.25 * Math.log(3));
const shortestA2 = Math.min(...vectorsInBall(a2, Math.sqrt(2)).map(({ length }) => length));
near(shortestA2, Math.sqrt(2));
near(-Math.log(shortestA2), -0.5 * Math.log(2));
assert.ok(-Math.log(shortestA2) < a2Mean);
near(Math.max(a2Mean, -Math.log(shortestA2)), a2Mean);
console.log("PASS: KB2E shortest vectors, extremal and filtration slopes, and the semistable cases");
db.close();
