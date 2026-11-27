import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import { buildMacros, renderTex } from "../src/latex.ts";
import { restoreBaseline, scope } from "./gen-ck-notation-2026-11-27.mjs";

const db = restoreBaseline();
const migration = readFileSync(new URL("./ck-notation-2026-11-27.sql", import.meta.url), "utf8");
const fields = {
  result: { table: "results", tex: "statement_tex", cache: "statement_html_cache" },
  proof: { table: "proofs", tex: "body_tex", cache: "body_html_cache" },
};
const readRows = (table) => db.prepare("SELECT * FROM " + table + " ORDER BY id").all();
const baseline = { result: readRows("results"), proof: readRows("proofs") };
const refs = readRows("refs");
const baselineRevisions = readRows("revisions");
const guardCount = () => db.prepare("SELECT count(*) AS count FROM write_guard").get().count;
const initialGuardCount = guardCount();

function checkGuard(drift) {
  db.exec("BEGIN; INSERT INTO write_guard (ok) VALUES (1)");
  drift?.();
  assert.throws(() => db.exec(migration), /CHECK constraint failed: ok = 1/);
  assert.equal(db.isTransaction, false);
  assert.equal(guardCount(), initialGuardCount);
}

for (const [, tag, entity, id] of scope) {
  const { table, tex, cache } = fields[entity];
  const get = db.prepare("SELECT * FROM " + table + " WHERE id = ?");
  const old = get.get(id);
  for (const [column, value] of [[tex, old[tex] + "\n"], ["revision", old.revision + 1]]) {
    checkGuard(() => db.prepare("UPDATE " + table + " SET " + column + " = ? WHERE id = ?").run(value, id));
    assert.deepEqual(get.get(id), old, tag + " " + column);
  }
  db.prepare("UPDATE " + table + " SET " + cache + " = 'stale cache' WHERE id = ?").run(id);
}
db.exec("UPDATE settings SET value = '0' WHERE key = 'needs_rebuild'");

db.exec("BEGIN");
try {
  db.exec(migration);
  db.exec("COMMIT");
} catch (error) {
  if (db.isTransaction) db.exec("ROLLBACK");
  throw error;
}
checkGuard();
assert.deepEqual(db.prepare("PRAGMA foreign_key_check").all(), []);
console.log("PASS: restored backup, applied Taylor and notation migrations, and blocked rerun plus text and revision drift in all 18 fields");

const timestamp = "2026-11-27 20:00:00";
const operationId = "ck-notation-2026-11-27";
const snapshotKeys = {
  result: ["tag", "type", "title", "statement_tex", "section_id", "position", "visibility", "state", "replaced_by_id", "listed"],
  proof: ["result_id", "body_tex", "status", "generated_by", "generator_detail", "reviewed_by", "review_notes", "position"],
};
const snapshot = db.prepare("SELECT * FROM revisions WHERE entity = ? AND entity_key = ? AND revision = ?");
const { macros, error } = buildMacros(db.prepare("SELECT value FROM settings WHERE key = 'macros'").get().value);
assert.equal(error, undefined);

const lowerBoundCounts = {
  "8JT5 statement": 2, "8JT5 proof": 2, "8JP5 proof": 3, "8JUM statement": 2, "8JUQ proof": 3,
};
const count = (tex, text) => tex.split(text).length - 1;
const oldResidue = /c_(?:\\rho|\\beta|p|0|\{p_\*\}|\{-2n\})(?![A-Za-z0-9])/g;

function checkTex(label, before, after) {
  assert.notEqual(after, before, label);
  assert.doesNotMatch(after, /\\(?:sigma|tau)(?![A-Za-z])|\b(?:sigma|tau)\b/, label);
  assert.doesNotMatch(after, /c_(?:\\rho|\\beta|p|\{p_\*\}|\{-2n\})(?![A-Za-z0-9])/, label);
  assert.equal(count(after, "c_0"), count(before, String.raw`\sigma_0`), label);
  assert.equal(count(after, "C_1"), lowerBoundCounts[label] ?? 0, label);
  const residues = label === "8JTA statement" ? 2 : [...before.matchAll(oldResidue)].length;
  assert.equal(count(after, String.raw`\operatorname{Res}_`), residues, label);
  for (const stepLabel of [String.raw`\text{(c)}`, String.raw`\item[(c)]`]) {
    assert.equal(count(after, stepLabel), count(before, stepLabel), label);
  }

  const rendered = renderTex(after, macros);
  assert.deepEqual(rendered.warnings, [], label);
  assert.deepEqual(rendered.refs, renderTex(before, macros).refs, label);
}

const updatedRows = { result: new Map(), proof: new Map() };
for (const [section, tag, entity, id, revision] of scope) {
  const label = tag + (entity === "result" ? " statement" : " proof");
  const { table, tex, cache } = fields[entity];
  const before = baseline[entity].find((row) => row.id === id);
  const row = db.prepare("SELECT * FROM " + table + " WHERE id = ?").get(id);
  const result = entity === "result" ? row : db.prepare("SELECT * FROM results WHERE id = ?").get(row.result_id);
  assert.deepEqual([result.tag, result.section_id, before.revision], [tag, section, revision], label);
  checkTex(label, before[tex], row[tex]);
  assert.deepEqual({ ...row }, {
    ...before, [tex]: row[tex], [cache]: null, revision: revision + 1, updated_at: timestamp, updated_by: "claude",
  }, label);
  updatedRows[entity].set(id, row);

  const rev = snapshot.get(entity, String(id), row.revision);
  assert.ok(rev, label);
  assert.deepEqual([rev.operation_id, rev.author, rev.created_at], [operationId, "claude", timestamp], label);
  assert.deepEqual(JSON.parse(rev.snapshot_json), Object.fromEntries(snapshotKeys[entity].map((key) => [key, row[key]])), label);
}

for (const [entity, { table }] of Object.entries(fields)) {
  assert.deepEqual(readRows(table), baseline[entity].map((row) => updatedRows[entity].get(row.id) ?? row));
}
const revisions = readRows("revisions");
assert.deepEqual(revisions.filter((row) => row.operation_id !== operationId), baselineRevisions);
assert.equal(revisions.length - baselineRevisions.length, scope.length);
assert.equal(db.prepare("SELECT value FROM settings WHERE key = 'needs_rebuild'").get().value, "1");
assert.deepEqual(readRows("refs"), refs);

console.log("PASS: notation, step labels, and rendered references checked in 18 TeX fields with no KaTeX warnings");
console.log("PASS: 18 snapshots match their rows, HTML caches cleared, needs_rebuild set, and out-of-scope results and proofs unchanged");
db.close();
