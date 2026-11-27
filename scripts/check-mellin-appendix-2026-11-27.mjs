import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import { DatabaseSync } from "node:sqlite";
import { loadBook } from "../src/book.ts";
import { buildMacros, renderTex } from "../src/latex.ts";

const read = (path) => readFileSync(new URL(path, import.meta.url), "utf8");
const db = new DatabaseSync(":memory:", { enableForeignKeyConstraints: false });
db.exec(read("../backup-before-mellin-appendix-2026-11-27.sql"));
db.exec("PRAGMA foreign_keys = ON");
db.exec(read("../migrations/0004_appendix_chapters.sql"));

// Use the same SQL and numbering as the reader.
const bookDb = {
  prepare: (sql) => db.prepare(sql),
  batch: async (statements) => statements.map((stmt) => ({ results: stmt.all() })),
};
const before = await loadBook(bookDb, false);
const baselineResults = db.prepare("SELECT * FROM results ORDER BY id").all();
const baselineProofs = db.prepare("SELECT * FROM proofs ORDER BY id").all();
const content = read("./mellin-appendix-2026-11-27.sql");
db.exec("BEGIN");
try {
  db.exec(content);
  db.exec("COMMIT");
} catch (error) {
  if (db.isTransaction) db.exec("ROLLBACK");
  throw error;
}
assert.deepEqual(db.prepare("PRAGMA foreign_key_check").all(), []);

const guardCount = db.prepare("SELECT count(*) AS count FROM write_guard");
const guardRows = guardCount.get().count;
db.exec("BEGIN; INSERT INTO write_guard (ok) VALUES (1)");
assert.throws(() => db.exec(content), /CHECK constraint failed: ok = 1/);
assert.equal(db.isTransaction, false);
assert.equal(guardCount.get().count, guardRows);
console.log("PASS: backup restored, migration and content applied, second run rolled back");

const timestamp = "2026-11-27 14:00:00";
const sectionByTag = db.prepare("SELECT * FROM sections WHERE tag = ?");
const resultByTag = db.prepare("SELECT * FROM results WHERE tag = ?");
const proofsFor = db.prepare("SELECT * FROM proofs WHERE result_id = ? ORDER BY position, id");
const { macros, error } = buildMacros(db.prepare("SELECT value FROM settings WHERE key = 'macros'").get().value);
assert.equal(error, undefined);

const revisions = db.prepare("SELECT * FROM revisions WHERE entity = ? AND entity_key = ? AND revision = ?");
const snapshotKeys = {
  section: ["tag", "parent_id", "kind", "title", "intro_tex", "position"],
  result: ["tag", "type", "title", "statement_tex", "section_id", "position", "visibility", "state", "replaced_by_id", "listed"],
  proof: ["result_id", "body_tex", "status", "generated_by", "generator_detail", "reviewed_by", "review_notes", "position"],
};
const operationIds = new Set();
let snapshotCount = 0;
function checkSnapshot(entity, row) {
  const revision = revisions.get(entity, String(row.id), row.revision);
  assert.ok(revision, `${entity} ${row.id} revision ${row.revision} is missing`);
  assert.equal(revision.author, "claude");
  assert.equal(revision.created_at, timestamp);
  assert.equal(row.updated_by, "claude");
  assert.equal(row.updated_at, timestamp);
  assert.deepEqual(JSON.parse(revision.snapshot_json), Object.fromEntries(snapshotKeys[entity].map((key) => [key, row[key]])));
  operationIds.add(revision.operation_id);
  snapshotCount++;
}

let renderedFields = 0;
const tagByName = db.prepare("SELECT * FROM tags WHERE tag = ?");
function checkTex(label, tex) {
  const { refs, warnings } = renderTex(tex, macros);
  assert.deepEqual(warnings, [], label);
  for (const target of refs) assert.ok(tagByName.get(target), `${label}: missing target ${target}`);
  renderedFields++;
  return [...new Set(refs)].sort();
}

const storedRefs = db.prepare("SELECT target_tag FROM refs WHERE source_result_id = ? AND source_proof_id IS ? ORDER BY target_tag");
let checkedRefSources = 0;
function checkRefs(label, tex, resultId, proofId = null) {
  const parsed = checkTex(label, tex);
  assert.deepEqual(storedRefs.all(resultId, proofId).map(({ target_tag }) => target_tag), parsed, label);
  checkedRefSources++;
}

const chapter = sectionByTag.get("APXA");
const section = sectionByTag.get("APXS");
assert.deepEqual([chapter.kind, chapter.parent_id, chapter.appendix, chapter.position], ["chapter", null, 1, 100]);
assert.deepEqual([section.kind, section.parent_id, section.appendix, section.position], ["section", chapter.id, 0, 1]);
for (const row of [chapter, section]) {
  assert.equal(tagByName.get(row.tag).kind, "section");
  assert.equal(row.revision, 1);
  assert.equal(row.intro_html_cache, null);
  checkSnapshot("section", row);
  checkTex(`${row.tag} title`, row.title);
  checkTex(`${row.tag} introduction`, row.intro_tex);
}

const newResults = [
  ["MCV9", 1, "motivation", false],
  ["MCV2", 3, "definition", false],
  ["MCV3", 4, "theorem", true],
  ["MCV4", 5, "lemma", true],
  ["MCV5", 6, "corollary", true],
  ["MCV6", 7, "lemma", true],
  ["MCV7", 8, "example", false],
];
for (const [tag, position, type, hasProof] of newResults) {
  const row = resultByTag.get(tag);
  assert.equal(tagByName.get(tag).kind, "result");
  assert.deepEqual([row.section_id, row.position, row.type, row.revision], [section.id, position, type, 1], tag);
  assert.deepEqual([row.visibility, row.state, row.listed], ["published", "active", 1], tag);
  const proofs = proofsFor.all(row.id);
  assert.equal(proofs.length, Number(hasProof), tag);
  for (const p of proofs) {
    assert.deepEqual([p.position, p.revision, p.status, p.generated_by, p.generator_detail, p.visibility, p.body_html_cache],
      [1, 1, "ai_generated", "claude", "Claude Opus 5.5", "published", null], tag);
    checkSnapshot("proof", p);
    checkRefs(`${tag} proof`, p.body_tex, row.id, p.id);
  }
}

const changedPositions = new Map([["8JS2", 2], ["8JS8", 9]]);
const oldPhrase = String.raw`For $\Re s>1$, reversing the order of integration gives`;
const replacement = String.raw`Since $R_\chi=\Psi_\chi\star x$, the \hyperref[MCV3]{convolution theorem} and $\mathcal M(x)(s)=1/(s-1)$ from \ref{MCV4} give, for $\Re s>1$,`;
for (const old of baselineResults) {
  const row = resultByTag.get(old.tag);
  const position = changedPositions.get(old.tag);
  if (position !== undefined || old.tag === "8JV3") {
    const expected = position === undefined
      ? { statement_tex: old.statement_tex.replace(oldPhrase, replacement) }
      : { section_id: section.id, position };
    assert.deepEqual({ ...row }, { ...old, ...expected, statement_html_cache: null,
      revision: old.revision + 1, updated_at: timestamp, updated_by: "claude" }, old.tag);
  } else {
    assert.deepEqual(row, old, old.tag);
  }
}
assert.equal(db.prepare("SELECT count(*) AS count FROM results").get().count, baselineResults.length + newResults.length);
assert.equal(db.prepare("SELECT count(*) AS count FROM proofs").get().count, baselineProofs.length + 4);
const proofById = db.prepare("SELECT * FROM proofs WHERE id = ?");
for (const old of baselineProofs) assert.deepEqual(proofById.get(old.id), old);

for (const tag of [...newResults.map(([tag]) => tag), "8JS2", "8JS8", "8JV3"]) {
  const row = resultByTag.get(tag);
  assert.equal(row.statement_html_cache, null, tag);
  checkSnapshot("result", row);
  checkTex(`${tag} title`, row.title);
  checkRefs(`${tag} statement`, row.statement_tex, row.id);
  if (tag === "8JS8") {
    for (const p of proofsFor.all(row.id)) checkRefs(`${tag} existing proof`, p.body_tex, row.id, p.id);
  }
}
assert.equal(snapshotCount, 16);
assert.equal(operationIds.size, 1);
assert.equal(db.prepare("SELECT count(*) AS count FROM revisions WHERE operation_id = ?").get([...operationIds][0]).count, snapshotCount);
assert.equal(db.prepare("SELECT value FROM settings WHERE key = 'needs_rebuild'").get().value, "1");
console.log(`PASS: ${snapshotCount} revision snapshots match their rows and needs_rebuild is set`);
console.log(`PASS: ${renderedFields} TeX fields rendered without warnings and ${checkedRefSources} reference sources match`);

const book = await loadBook(bookDb, false);
assert.deepEqual(before.chapters.map(({ number }) => number), ["1", "2", "3", "4"]);
assert.deepEqual(book.chapters.slice(0, -1), before.chapters);
assert.equal(book.chapters.at(-1).tag, "APXA");
assert.equal(book.byTag.get("APXA").label, "Appendix A");
const expectedNumbers = {
  APXA: "A", APXS: "A.1", MCV9: "A.1.1", "8JS2": "A.1.2", MCV2: "A.1.3", MCV3: "A.1.4",
  MCV4: "A.1.5", MCV5: "A.1.6", MCV6: "A.1.7", MCV7: "A.1.8", "8JS8": "",
};
for (const [tag, number] of Object.entries(expectedNumbers)) assert.equal(book.byTag.get(tag).number, number, tag);
assert.equal(book.byTag.get("8JS8").listed, false);
assert.ok(book.resultsOf.get(section.id).every(({ tag }) => tag !== "8JS8"));
console.log("PASS: chapters 1-4 unchanged, Appendix A numbered through A.1.8, 8JS8 unlisted");
