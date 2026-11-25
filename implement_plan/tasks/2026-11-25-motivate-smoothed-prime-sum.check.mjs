import assert from "node:assert/strict";
import { copyFileSync, mkdtempSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { DatabaseSync } from "node:sqlite";
import { fillRefs, loadBook } from "../../src/book.ts";
import { buildMacros, escapeHtml, renderInlineTex, renderTex } from "../../src/latex.ts";

const order = [
  [1, 148, "8JUR", "definition", 1],
  [2, 149, "8JUS", "lemma", 1],
  [3, 150, "8JUT", "definition", 1],
  [4, 151, "8JUU", "lemma", 1],
  [5, 106, "8JF7", "definition", 1],
  [6, 116, "8JS3", "lemma", 1],
  [7, 107, "8JG8", "definition", 1],
  [8, 108, "8JJ5", "example", 0],
  [9, 109, "8JQ3", "example", 0],
  [10, 152, "8JUV", "lemma", 0],
];
const movedIds = [116, 107, 108, 109];
const editedProofIds = [106, 128, 129, 130];
const resultAliases = new Map([
  [148, "von-mangoldt-function"],
  [149, "log-derivative-l-function"],
  [150, "chebyshev-function"],
  [151, "chebyshev-mellin-transform"],
  [152, "l-at-one-nonzero"],
]);
const operation = "motivate-smoothed-prime-sum-2026-11-25";
const timestamp = "2026-11-25 16:30:00";
const oldPhrase = String.raw`and $\sum_n \Lambda(n) n^{-\sigma} < \infty$ for $\sigma > 1$, we may integrate term by term:`;
const newPhrase = String.raw`and the series of the \hyperref[8JUS]{logarithmic derivative} converges absolutely, we may integrate term by term:`;
const source = process.argv[3] ? process.argv[3] : new URL(
  "../../.wrangler/state/v3/d1/miniflare-D1DatabaseObject/feb98e23e8d07ed53c02acad60b7af51cee41722a632c769f200a9b7c2d3ca7f.sqlite",
  import.meta.url,
);

const sqlPath = process.argv[2];
assert(sqlPath, "Usage: node 2026-11-25-motivate-smoothed-prime-sum.check.mjs <sql-path>");
const sql = readFileSync(sqlPath, "utf8");
const tempDir = mkdtempSync(join(tmpdir(), "smoothed-prime-sum-"));
const databasePath = join(tempDir, "grh-notes.sqlite");
copyFileSync(source, databasePath);
const db = new DatabaseSync(databasePath);

const all = (query, ...params) => db.prepare(query).all(...params);
const get = (query, ...params) => db.prepare(query).get(...params);
const pick = (row, keys) => Object.fromEntries(keys.map((key) => [key, row[key]]));
const history = (entity, id) => all(
  "SELECT * FROM revisions WHERE entity = ? AND entity_key = ? ORDER BY revision",
  entity, String(id),
);

try {
  db.exec("PRAGMA foreign_keys = OFF");
  const oldResults = all("SELECT * FROM results WHERE section_id = 102");
  const movedHistory = new Map(movedIds.map((id) => [id, history("result", id)]));
  const oldProof = get("SELECT * FROM proofs WHERE id = 106");

  db.exec(sql);
  assert.equal(db.isTransaction, false, "The SQL must commit");
  console.log("SQL applied to a temporary database copy.");
  assert.throws(() => db.exec(sql), /CHECK constraint failed:\s*ok\s*=\s*1/, "The write guard must reject a second application");
  assert.equal(db.isTransaction, false, "The write guard must roll back the transaction");
  console.log("Second application rejected and rolled back by write_guard.");

  const { macros, error } = buildMacros(get("SELECT value FROM settings WHERE key = 'macros'").value);
  assert.equal(error, undefined, "The database macros must build");
  const section = get("SELECT * FROM sections WHERE id = 102");
  const results = all("SELECT * FROM results WHERE section_id = 102 ORDER BY position, id");
  const proofs = all(
    "SELECT p.* FROM proofs p JOIN results r ON r.id = p.result_id WHERE r.section_id = 102 OR p.id = 106 ORDER BY p.id",
  );
  const intro = renderTex(section.intro_tex, macros);
  const statements = new Map(results.map((row) => [row.id, renderTex(row.statement_tex, macros)]));
  const bodies = new Map(proofs.map((row) => [row.id, renderTex(row.body_tex, macros)]));
  const rendered = [
    ["Section 102 intro", intro],
    ...results.map((row) => [row.tag + " statement", statements.get(row.id)]),
    ...proofs.map((row) => ["Proof " + row.id, bodies.get(row.id)]),
  ];
  let warningCount = 0;
  for (const [label, item] of rendered) {
    warningCount += item.warnings.length;
    for (const warning of item.warnings) {
      console.log(label + (warning.line === undefined ? "" : " line " + warning.line) + " — " + warning.message);
    }
  }
  console.log("renderTex warnings: " + warningCount + " across " + rendered.length + " sources.");
  assert.equal(warningCount, 0);

  for (const [label, item] of rendered) {
    for (const tag of item.refs) assert(get("SELECT tag FROM tags WHERE tag = ?", tag), label + " references unknown tag " + tag);
  }
  const editedResults = results.filter(({ id }) => !movedIds.includes(id));
  for (const row of editedResults) {
    const refs = all("SELECT target_tag FROM refs WHERE source_result_id = ? AND source_proof_id IS NULL", row.id);
    assert.deepEqual(new Set(refs.map(({ target_tag }) => target_tag)), new Set(statements.get(row.id).refs), row.tag + " statement refs");
  }
  for (const id of editedProofIds) {
    const proof = proofs.find((row) => row.id === id);
    assert(proof, "Missing proof " + id);
    const refs = all("SELECT source_result_id, target_tag FROM refs WHERE source_proof_id = ?", id);
    assert(refs.every(({ source_result_id }) => source_result_id === proof.result_id), "Incorrect result in refs for proof " + id);
    assert.deepEqual(new Set(refs.map(({ target_tag }) => target_tag)), new Set(bodies.get(id).refs), "Proof " + id + " refs");
  }
  console.log("Reference sets match and all rendered reference targets exist.");

  console.log("Section 102 order");
  console.log(["position", "tag", "type", "listed", "title"].join("\t"));
  for (const row of results) console.log([row.position, row.tag, row.type, row.listed, row.title].join("\t"));
  assert.deepEqual(results.map((row) => [row.position, row.id, row.tag, row.type, row.listed]), order);

  const sectionKeys = ["tag", "kind", "title", "intro_tex", "parent_id", "position"];
  const resultKeys = ["tag", "type", "title", "statement_tex", "section_id", "position", "listed"];
  const proofKeys = ["result_id", "position", "body_tex", "status", "generated_by", "generator_detail", "reviewed_by", "review_notes"];
  function checkRevision(entity, row, revision, snapshot) {
    const label = entity + " " + row.id;
    assert.equal(row.revision, revision, label + " row revision");
    const latest = history(entity, row.id).at(-1);
    assert(latest, label + " has no revision snapshot");
    assert.equal(latest.revision, row.revision, label + " latest revision");
    assert.deepEqual(JSON.parse(latest.snapshot_json), snapshot, label + " snapshot");
    assert.deepEqual([latest.operation_id, latest.author, latest.created_at], [operation, "codex", timestamp], label + " revision metadata");
  }
  checkRevision("section", section, 2, pick(section, sectionKeys));
  const baseline = history("section", 102).find(({ revision }) => revision === 1);
  assert(baseline, "Section 102 baseline revision is missing");
  assert.deepEqual(JSON.parse(baseline.snapshot_json), {
    tag: "7HE6", kind: "section", title: "Smoothed prime sums", intro_tex: "", parent_id: 100, position: 2,
  });
  for (const row of editedResults) {
    const aliases = all("SELECT alias FROM aliases WHERE tag = ? ORDER BY alias", row.tag).map(({ alias }) => alias);
    checkRevision("result", row, row.id === 106 ? 3 : 1, { ...pick(row, resultKeys), aliases });
    if (row.id !== 106) {
      assert.deepEqual(aliases, [resultAliases.get(row.id)], row.tag + " aliases");
      assert.equal(get("SELECT kind FROM tags WHERE tag = ?", row.tag)?.kind, "result");
    }
  }
  for (const id of movedIds) {
    const row = results.find((item) => item.id === id);
    assert.deepEqual({ ...row }, { ...oldResults.find((item) => item.id === id), position: row.position }, "Position-only result " + id);
    const revisions = history("result", id);
    assert.deepEqual(revisions, movedHistory.get(id), "Position-only history for result " + id);
    const latest = revisions.at(-1);
    if (latest) {
      assert.equal(latest.revision, row.revision, row.tag + " latest revision");
      assert.equal(JSON.parse(latest.snapshot_json).statement_tex, row.statement_tex, row.tag + " snapshot TeX");
    }
  }
  const proofById = new Map(proofs.map((row) => [row.id, row]));
  for (const id of editedProofIds) {
    const row = proofById.get(id);
    checkRevision("proof", row, id === 106 ? 5 : 1, pick(row, proofKeys));
  }
  assert.equal(oldProof.body_tex.split(oldPhrase).length, 2, "Expected one occurrence of the original proof phrase");
  assert.equal(proofById.get(106).body_tex, oldProof.body_tex.replace(oldPhrase, () => newPhrase), "Proof 106 changed outside the specified replacement");
  console.log("Revision snapshots and position-only histories verified.");

  const book = await loadBook({
    batch: async (queries) => queries.map((query) => ({ results: query.all() })),
    prepare: (query) => db.prepare(query),
  }, false);
  const previewTags = new Set([section.tag, ...editedResults.map(({ tag }) => tag)]);
  function previewRefs(html) {
    return fillRefs(html, book).replace(/<a class="ref" href="\/tag\/([^"]+)" data-tag="[^"]+">([\s\S]*?)<\/a>/g,
      (_, tag, label) => previewTags.has(tag)
        ? '<a class="ref" href="#' + tag + '">' + label + "</a>"
        : '<span class="ref">' + label + "</span>",
    );
  }
  const excerpts = editedResults.map((row) => {
    const { label } = book.byTag.get(row.tag);
    const proof = proofs.filter(({ result_id }) => result_id === row.id)
      .map(({ id }) => "<h3>Proof</h3>\n" + previewRefs(bodies.get(id).html)).join("\n");
    return '<section id="' + row.tag + '"><h2>' + escapeHtml(label) + " — "
      + renderInlineTex(row.title, macros) + "</h2>\n" + previewRefs(statements.get(row.id).html) + proof + "</section>";
  });
  const katexCss = new URL("../../public/katex/katex.min.css", import.meta.url);
  const siteCss = new URL("../../public/static/style.css", import.meta.url);
  const previewPath = join(tempDir, "preview.html");
  writeFileSync(previewPath, `<!doctype html>
<html lang="en">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Smoothed prime sums</title>
<link rel="stylesheet" href="${katexCss.href}">
<link rel="stylesheet" href="${siteCss.href}">
<style>main { max-width: 680px; margin: 2rem auto; padding: 0 1rem; box-sizing: content-box; }</style>
<main>
  <h1 id="${section.tag}">1.2 ${escapeHtml(section.title)}</h1>
  ${previewRefs(intro.html)}
  ${excerpts.join("\n")}
</main>
</html>
`);
  console.log("Rendered HTML: " + previewPath);
} finally {
  db.close();
  for (const suffix of ["", "-wal", "-shm"]) rmSync(databasePath + suffix, { force: true });
}
console.log("ALL CHECKS PASSED");
