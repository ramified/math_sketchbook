import assert from "node:assert/strict";
import { spawnSync } from "node:child_process";
import { mkdtempSync, readFileSync, rmdirSync, unlinkSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { DatabaseSync } from "node:sqlite";

export const scope = [
  [104, "8JT2", "result", 123, 5],
  [104, "8JT2", "proof", 109, 14],
  [104, "8JT3", "proof", 110, 1],
  [104, "8JT4", "result", 125, 2],
  [104, "8JT4", "proof", 111, 3],
  [104, "8JT5", "result", 136, 2],
  [104, "8JT5", "proof", 121, 2],
  [104, "8JT6", "result", 137, 2],
  [104, "8JT7", "result", 138, 1],
  [104, "8JT8", "result", 139, 1],
  [104, "8JT9", "result", 140, 1],
  [104, "8JP5", "proof", 102, 10],
  [110, "8JTA", "result", 141, 8],
  [110, "8JUM", "result", 145, 2],
  [110, "8JUM", "proof", 125, 2],
  [110, "8JUP", "result", 146, 1],
  [110, "8JUP", "proof", 126, 1],
  [110, "8JUQ", "proof", 127, 1],
];

const snapshotKeys = {
  result: ["tag", "type", "title", "statement_tex", "section_id", "position", "visibility", "state", "replaced_by_id", "listed"],
  proof: ["result_id", "body_tex", "status", "generated_by", "generator_detail", "reviewed_by", "review_notes", "position"],
};

export function restoreBaseline() {
  const read = (path) => readFileSync(new URL(path, import.meta.url), "utf8");
  const db = new DatabaseSync(":memory:", { enableForeignKeyConstraints: false });
  db.exec(read("../backup-before-taylor-coefficients-2026-11-27.sql"));
  db.exec("PRAGMA foreign_keys = ON");
  db.exec(read("./taylor-coefficients-definition-2026-11-27.sql"));
  return db;
}

const raw = String.raw;
const lowerBoundConstants = {
  "8JT5 statement": [["$c > 0$", "$C_1 > 0$"], [raw`c\, d^{-k}`, raw`C_1\, d^{-k}`]],
  "8JT5 proof": [["$c = ", "$C_1 = "]],
  "8JP5 proof": [["$c$", "$C_1$"], [raw`c\, d^{-k}`, raw`C_1\, d^{-k}`], ["C/c", "C/C_1"]],
  "8JUM statement": [["$c>0$", "$C_1>0$"], [raw`c\,d^{-k}`, raw`C_1\,d^{-k}`]],
  "8JUQ proof": [["$c>0$", "$C_1>0$"], [raw`c\,d^{-k}`, raw`C_1\,d^{-k}`], ["C/c", "C/C_1"]],
};

function renamePoint(tex) {
  return tex
    .replace(/\\sigma *\+ *i\\tau\b/g, "c+iy")
    .replace(/\\Re ([sz]) *= *\\sigma\b/g, raw`\Re $1=c`)
    .replace(/\\sigma *- *\\theta\b/g, raw`c-\theta`)
    .replaceAll(raw`\sigma u`, "cu")
    .replaceAll(raw`i\tau u`, "iyu")
    .replace(/(\\[A-Za-z]+)(?=\\(?:sigma|tau)(?![A-Za-z]))/g, "$1 ")
    .replace(/\\sigma(?![A-Za-z])/g, "c")
    .replace(/\\tau(?![A-Za-z])/g, "y")
    .replace(/\bsigma\b/g, "c")
    .replace(/\btau\b/g, "y");
}

function renameNotation(label, tex) {
  if (label === "8JTA statement") {
    const panel = tex.indexOf("\nPanel (c) shows ");
    assert.notEqual(panel, -1, label);
    const oldResidue = "with residue $c$, contributes $c/(z - p)^{k+1}$";
    const newResidue = raw`with residue $\operatorname{Res}_p$, contributes $\operatorname{Res}_p/(z - p)^{k+1}$`;
    assert.ok(tex.slice(0, panel).includes(oldResidue), label);
    return tex.slice(0, panel).replace(oldResidue, newResidue) + renamePoint(tex.slice(panel));
  }

  for (const [before, after] of lowerBoundConstants[label] ?? []) {
    assert.ok(tex.includes(before), "Missing " + before + " in " + label);
    tex = tex.replaceAll(before, after);
  }

  // Resolve the old c_0 residue before introducing the c_0 threshold.
  tex = tex.replace(/c_(\\rho|\\beta|p|0|\{p_\*\}|\{-2n\})(?![A-Za-z0-9])/g, raw`\operatorname{Res}_$1`);
  tex = tex.replaceAll(raw`\operatorname{Res}_0\sigma`, raw`\operatorname{Res}_0 \sigma`);
  return renamePoint(tex);
}

const sqlLiteral = (value) => "'" + value.replaceAll("'", "''") + "'";
const operationId = sqlLiteral("ck-notation-2026-11-27");
const author = sqlLiteral("claude");
const timestamp = sqlLiteral("2026-11-27 20:00:00");

function buildSql(fields) {
  const guards = fields.map(({ table, id, revision, field, before }) =>
    "NOT EXISTS (SELECT 1 FROM " + table + " WHERE id = " + id + " AND revision = " + revision +
    "\n    AND " + field + " IS " + sqlLiteral(before) + ")");
  const updates = fields.map(({ label, table, id, field, cache, after }) => [
    "-- " + label,
    "UPDATE " + table + " SET " + field + " = " + sqlLiteral(after) + ",",
    "  " + cache + " = NULL, revision = revision + 1, updated_at = " + timestamp + ", updated_by = " + author,
    "WHERE id = " + id + ";",
  ].join("\n"));
  const snapshots = Object.entries(snapshotKeys).map(([entity, keys]) => {
    const ids = fields.filter((field) => field.entity === entity).map(({ id }) => id);
    const pairs = keys.map((key) => sqlLiteral(key) + ", " + key).join(", ");
    return [
      "INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)",
      "SELECT " + sqlLiteral(entity) + ", CAST(id AS TEXT), revision, " + operationId + ",",
      "       json_object(" + pairs + "),",
      "       " + author + ", " + timestamp,
      "FROM " + entity + "s WHERE id IN (" + ids.join(", ") + ");",
    ].join("\n");
  });
  return [
    "-- Generated by scripts/gen-ck-notation-2026-11-27.mjs.",
    "INSERT OR ROLLBACK INTO write_guard (ok)\nSELECT 0 WHERE\n  " + guards.join("\n  OR ") + ";",
    ...updates,
    ...snapshots,
    "UPDATE settings SET value = '1' WHERE key = 'needs_rebuild' AND value IS NOT '1';",
  ].join("\n\n") + "\n";
}

function buildReview(fields) {
  const dir = mkdtempSync(join(tmpdir(), "ck-notation-"));
  const beforePath = join(dir, "before.tex");
  const afterPath = join(dir, "after.tex");
  writeFileSync(beforePath, "", "utf8");
  writeFileSync(afterPath, "", "utf8");
  try {
    const sections = fields.map(({ label, section, id, revision, before, after }) => {
      writeFileSync(beforePath, before + "\n", "utf8");
      writeFileSync(afterPath, after + "\n", "utf8");
      const diff = spawnSync("git", [
        "--no-pager", "diff", "--no-index", "--no-ext-diff", "--no-color", "--word-diff=plain", "-U1",
        "--", beforePath, afterPath,
      ], { encoding: "utf8" });
      assert.ifError(diff.error);
      assert.equal(diff.status, 1, diff.stderr);
      const start = diff.stdout.indexOf("\n@@ ");
      assert.notEqual(start, -1, label);
      return [
        "## " + label,
        "Section " + section + ", ID " + id + ", revision " + revision + " → " + (revision + 1) + ".",
        "~~~text\n" + diff.stdout.slice(start + 1).trimEnd() + "\n~~~",
      ].join("\n\n");
    });
    return ["# Taylor coefficient notation review", "Deletions appear as `[-…-]` and insertions as `{+…+}`.", ...sections].join("\n\n") + "\n";
  } finally {
    unlinkSync(beforePath);
    unlinkSync(afterPath);
    rmdirSync(dir);
  }
}

if (import.meta.main) {
  const db = restoreBaseline();
  const statements = db.prepare("SELECT tag, section_id, revision, statement_tex FROM results WHERE id = ?");
  const proofs = db.prepare("SELECT r.tag, r.section_id, p.revision, p.body_tex FROM proofs p JOIN results r ON r.id = p.result_id WHERE p.id = ?");
  const fields = scope.map(([section, tag, entity, id, revision]) => {
    const isResult = entity === "result";
    const label = tag + (isResult ? " statement" : " proof");
    const field = isResult ? "statement_tex" : "body_tex";
    const cache = isResult ? "statement_html_cache" : "body_html_cache";
    const row = (isResult ? statements : proofs).get(id);
    assert.ok(row, label);
    assert.deepEqual([row.tag, row.section_id, row.revision], [tag, section, revision], label);
    const before = row[field];
    const after = renameNotation(label, before);
    assert.notEqual(after, before, label);
    return { section, entity, table: entity + "s", label, id, revision, field, cache, before, after };
  });
  db.close();

  const sql = buildSql(fields);
  const review = buildReview(fields);
  writeFileSync(new URL("./ck-notation-2026-11-27.sql", import.meta.url), sql, "utf8");
  writeFileSync(new URL("../implement_plan/tasks/2026-11-27-ck-notation.review.md", import.meta.url), review, "utf8");
  console.log("Generated migration and review for " + fields.length + " fields.");
}
