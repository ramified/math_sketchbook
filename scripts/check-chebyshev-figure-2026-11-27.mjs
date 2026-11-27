import assert from "node:assert/strict";
import { createHash } from "node:crypto";
import { readFileSync } from "node:fs";
import { DatabaseSync } from "node:sqlite";

const read = (path) => readFileSync(new URL(path, import.meta.url), "utf8");
const chapterSql = read("./chapter3-self-contained-2026-11-27.sql").replaceAll("\r\n", "\n");
const figureSql = read("./chebyshev-figure-2026-11-27.sql").replaceAll("\r\n", "\n");
// SHA-256 of the spec's TeX block, including the two leading line breaks.
const expectedTexHash = "a1edb7144d9652754fe2696e070322e7509399376bda21d66b0ee9707259396c";

// The D1 export inserts rows that reference results before creating that table.
const db = new DatabaseSync(":memory:", { enableForeignKeyConstraints: false });
try {
  db.exec(read("../backup-before-chapter3-self-contained-2026-11-27.sql"));
  db.exec("PRAGMA foreign_keys = ON");

  const example = db.prepare(
    "SELECT revision, statement_tex, statement_html_cache FROM results WHERE id = 122 AND tag = '8JS9'",
  );
  db.exec("BEGIN");
  db.exec(chapterSql);
  const original = example.get();
  db.exec(figureSql);
  db.exec("COMMIT");

  const result = example.get();
  assert.equal(original.revision, 5);
  assert.equal(result.revision, 6);
  assert.equal(result.statement_html_cache, null);
  assert.ok(result.statement_tex.startsWith(original.statement_tex), "Original statement was changed");
  const appendedTex = result.statement_tex.slice(original.statement_tex.length);
  assert.equal(createHash("sha256").update(appendedTex).digest("hex"), expectedTexHash, "Appended TeX differs from the spec");
  console.log("PASS result 122 is revision 6, with the exact appended TeX and cleared HTML cache");

  const snapshot = db.prepare(
    "SELECT json_extract(snapshot_json, '$.statement_tex') AS statement_tex FROM revisions " +
    "WHERE entity = 'result' AND entity_key = '122' AND revision = 6",
  ).all();
  assert.equal(snapshot.length, 1);
  assert.equal(snapshot[0].statement_tex, result.statement_tex);
  console.log("PASS revision-6 snapshot statement_tex matches the result");

  const refs = db.prepare(
    "SELECT target_tag FROM refs WHERE source_result_id = 122 AND source_proof_id IS NULL " +
    "AND target_tag IN ('8JUT', '8JV3') ORDER BY target_tag",
  );
  assert.deepEqual(refs.all().map(({ target_tag }) => target_tag), ["8JUT", "8JV3"]);
  const rebuild = db.prepare("SELECT value FROM settings WHERE key = 'needs_rebuild'");
  assert.equal(rebuild.get().value, "1");
  console.log("PASS both statement refs are present once and needs_rebuild is 1");

  db.exec("BEGIN");
  assert.throws(() => db.exec(figureSql), { message: /^CHECK constraint failed: ok = 1$/ });
  assert.equal(db.isTransaction, false);
  assert.deepEqual(example.get(), result);
  console.log("PASS second run is blocked by write_guard and rolls back");
} finally {
  db.close();
}
