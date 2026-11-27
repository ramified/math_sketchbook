import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import { DatabaseSync } from "node:sqlite";
import { buildMacros, renderTex } from "../src/latex.ts";

const read = (path) => readFileSync(new URL(path, import.meta.url), "utf8");
const db = new DatabaseSync(":memory:", { enableForeignKeyConstraints: false });
db.exec(read("../backup-before-mellin-appendix-reorder-2026-11-27.sql"));
db.exec("PRAGMA foreign_keys = ON");

function apply(sql) {
  db.exec("BEGIN");
  try {
    db.exec(sql);
    db.exec("COMMIT");
  } catch (error) {
    if (db.isTransaction) db.exec("ROLLBACK");
    throw error;
  }
}

apply(read("./mellin-appendix-reorder-2026-11-27.sql"));
const baselineResults = db.prepare("SELECT * FROM results ORDER BY id").all();
const baselineProofs = db.prepare("SELECT * FROM proofs ORDER BY id").all();
const resultByTag = db.prepare("SELECT * FROM results WHERE tag = ?");
const content = read("./mellin-inversion-2026-11-27.sql");
const phrase = "otherwise Mellin inversion would make";
const linked = String.raw`otherwise \hyperref[MCV8]{Mellin inversion} would make`;

// Exercise the first-occurrence rule even if the phrase appears twice.
db.exec("BEGIN");
try {
  const repeated = `${resultByTag.get("8JV3").statement_tex}\n\n${phrase}`;
  db.prepare("UPDATE results SET statement_tex = ? WHERE tag = '8JV3'").run(repeated);
  db.exec(content);
  assert.equal(resultByTag.get("8JV3").statement_tex, repeated.replace(phrase, linked));
} finally {
  if (db.isTransaction) db.exec("ROLLBACK");
}

apply(content);
assert.deepEqual(db.prepare("PRAGMA foreign_key_check").all(), []);

const guardCount = db.prepare("SELECT count(*) AS count FROM write_guard");
const guardRows = guardCount.get().count;
db.exec("BEGIN; INSERT INTO write_guard (ok) VALUES (1)");
assert.throws(() => db.exec(content), /CHECK constraint failed: ok = 1/);
assert.equal(db.isTransaction, false);
assert.equal(guardCount.get().count, guardRows);
console.log("PASS: backup restored, reorder and inversion applied, rerun rolled back");

const order = db.prepare(`SELECT tag, position, listed FROM results
  WHERE section_id = 119 AND state = 'active' ORDER BY position`).all();
const expectedTags = ["8JS2", "MCV4", "MCV8", "MCV2", "MCV3", "MCV5", "MCV6", "MCV7", "8JS8"];
assert.deepEqual(order.map(({ tag, position, listed }) => [tag, position, listed]),
  expectedTags.map((tag, index) => [tag, index + 1, Number(tag !== "8JS8")]));

const timestamp = "2026-11-27 16:00:00";
const theorem = resultByTag.get("MCV8");
assert.deepEqual([theorem.type, theorem.title, theorem.visibility, theorem.revision, theorem.statement_html_cache],
  ["theorem", "Mellin inversion", "published", 1, null]);
assert.deepEqual([theorem.created_by, theorem.created_at], ["claude", timestamp]);
const tagByName = db.prepare("SELECT * FROM tags WHERE tag = ?");
assert.deepEqual({ ...tagByName.get("MCV8") }, { tag: "MCV8", kind: "result", created_at: timestamp });

const proofs = db.prepare("SELECT * FROM proofs WHERE result_id = ?").all(theorem.id);
assert.equal(proofs.length, 1);
const [proof] = proofs;
assert.deepEqual([proof.position, proof.status, proof.generated_by, proof.generator_detail, proof.visibility, proof.revision,
  proof.body_html_cache, proof.created_by, proof.created_at],
  [1, "ai_generated", "claude", "Claude Opus 5.5", "published", 1, null, "claude", timestamp]);
assert.deepEqual(db.prepare("SELECT * FROM proofs WHERE id <> ? ORDER BY id").all(proof.id), baselineProofs);

const movedTags = new Set(["MCV2", "MCV3", "MCV5", "MCV6", "MCV7"]);
const changedResults = [theorem];
for (const old of baselineResults) {
  const row = resultByTag.get(old.tag);
  if (movedTags.has(old.tag) || old.tag === "8JV3") {
    const edit = old.tag === "8JV3"
      ? { statement_tex: old.statement_tex.replace(phrase, linked) }
      : { position: old.position + 1 };
    assert.deepEqual({ ...row }, { ...old, ...edit, statement_html_cache: null, revision: old.revision + 1,
      updated_at: timestamp, updated_by: "claude" }, old.tag);
    changedResults.push(row);
  } else {
    assert.deepEqual(row, old, old.tag);
  }
}
assert.equal(db.prepare("SELECT count(*) AS count FROM results").get().count, baselineResults.length + 1);
console.log("PASS: APXS order and row changes match the spec, and only the first exact phrase is linked");

const revisions = db.prepare("SELECT * FROM revisions WHERE entity = ? AND entity_key = ? AND revision = ?");
const snapshotKeys = {
  result: ["tag", "type", "title", "statement_tex", "section_id", "position", "visibility", "state", "replaced_by_id", "listed"],
  proof: ["result_id", "body_tex", "status", "generated_by", "generator_detail", "reviewed_by", "review_notes", "position"],
};
const operationId = "mellin-inversion-2026-11-27";
function checkSnapshot(entity, row) {
  const revision = revisions.get(entity, String(row.id), row.revision);
  assert.ok(revision, `${entity} ${row.id} revision ${row.revision} is missing`);
  assert.deepEqual([revision.author, revision.created_at, revision.operation_id, row.updated_by, row.updated_at],
    ["claude", timestamp, operationId, "claude", timestamp]);
  assert.deepEqual(JSON.parse(revision.snapshot_json), Object.fromEntries(snapshotKeys[entity].map((key) => [key, row[key]])));
}
for (const row of changedResults) checkSnapshot("result", row);
checkSnapshot("proof", proof);
const snapshotCount = db.prepare("SELECT count(*) AS count FROM revisions WHERE operation_id = ?").get(operationId).count;
assert.equal(snapshotCount, changedResults.length + 1);
assert.equal(db.prepare("SELECT value FROM settings WHERE key = 'needs_rebuild'").get().value, "1");
console.log(`PASS: ${snapshotCount} revision snapshots match their rows and needs_rebuild is set`);

const { macros, error } = buildMacros(db.prepare("SELECT value FROM settings WHERE key = 'macros'").get().value);
assert.equal(error, undefined);
const storedRefs = db.prepare("SELECT target_tag FROM refs WHERE source_result_id = ? AND source_proof_id IS ? ORDER BY target_tag");
function checkRefs(label, tex, resultId, proofId = null) {
  const { refs, warnings } = renderTex(tex, macros);
  assert.deepEqual(warnings, [], label);
  const parsed = [...new Set(refs)].sort();
  assert.deepEqual(storedRefs.all(resultId, proofId).map(({ target_tag }) => target_tag), parsed, label);
  return parsed;
}
const motivation = resultByTag.get("8JV3");
assert.deepEqual(checkRefs("MCV8 statement", theorem.statement_tex, theorem.id), ["8JS2", "8JV4"]);
assert.deepEqual(checkRefs("MCV8 proof", proof.body_tex, theorem.id, proof.id), ["8JS8"]);
assert.ok(checkRefs("8JV3 statement", motivation.statement_tex, motivation.id).includes("MCV8"));
console.log("PASS: 3 TeX fields rendered without warnings and their stored refs match");
