import assert from "node:assert/strict";
import { copyFileSync, mkdtempSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { DatabaseSync } from "node:sqlite";
import { fillRefs, loadBook } from "../../src/book.ts";
import { buildMacros, escapeHtml, renderInlineTex, renderTex } from "../../src/latex.ts";

const [sqlPath, sourcePath, prerequisitePath] = process.argv.slice(2);
assert(sqlPath, "Usage: node 2026-11-25-ch2-formal-fixes.check.mjs <sql> [source-db] [prerequisite-sql]");
const source = sourcePath ?? new URL(
  "../../.wrangler/state/v3/d1/miniflare-D1DatabaseObject/feb98e23e8d07ed53c02acad60b7af51cee41722a632c769f200a9b7c2d3ca7f.sqlite",
  import.meta.url,
);
const sql = readFileSync(sqlPath, "utf8");
const prerequisite = prerequisitePath && readFileSync(prerequisitePath, "utf8");
const operation = "ch2-formal-fixes-2026-11-25";
const timestamp = "2026-11-25 17:30:00";
const newAlias = "arithmetic-auxiliary-character-sum";
const resultKeys = ["tag", "type", "title", "statement_tex", "section_id", "position", "listed"];
const proofKeys = ["result_id", "position", "body_tex", "status", "generated_by", "generator_detail", "reviewed_by", "review_notes"];
const sectionOrder = new Map([
  [103, [[1, 110, "8JK2", "theorem", 1]]],
  [108, [[1, 153, "8JUW", "definition", 1], [2, 132, "8JUD", "lemma", 1], [3, 133, "8JUE", "lemma", 0]]],
  [109, [[1, 134, "8JUF", "proposition", 1], [2, 135, "8JUG", "lemma", 0]]],
]);
const resultVersions = new Map([[132, 2], [133, 2], [134, 2], [153, 1]]);
const proofVersions = new Map([[117, 2], [119, 2], [131, 1]]);

const tempDir = mkdtempSync(join(tmpdir(), "ch2-formal-fixes-"));
const databasePath = join(tempDir, "grh-notes.sqlite");
copyFileSync(source, databasePath);
const db = new DatabaseSync(databasePath);
const all = (query, ...params) => db.prepare(query).all(...params);
const get = (query, ...params) => db.prepare(query).get(...params);
const byId = (table, id) => get(`SELECT * FROM ${table} WHERE id = ?`, id);
const pick = (row, keys) => Object.fromEntries(keys.map((key) => [key, row[key]]));
const history = (entity, id) => all(
  "SELECT * FROM revisions WHERE entity = ? AND entity_key = ? ORDER BY revision",
  entity, String(id),
);
const snapshot = (entity, row) => entity === "result" ? {
  ...pick(row, resultKeys),
  aliases: all("SELECT alias FROM aliases WHERE tag = ? ORDER BY alias", row.tag).map(({ alias }) => alias),
} : pick(row, proofKeys);

function protectedRows() {
  return {
    section: byId("sections", 102),
    results: all("SELECT * FROM results WHERE section_id = 102 ORDER BY id"),
    proofs: all("SELECT * FROM proofs WHERE id IN (106, 128, 129, 130) ORDER BY id"),
    tags: all("SELECT * FROM tags WHERE tag IN ('8JUR', '8JUS', '8JUT', '8JUU', '8JUV') ORDER BY tag"),
    aliases: all("SELECT * FROM aliases WHERE tag IN (SELECT tag FROM results WHERE section_id = 102) ORDER BY alias"),
    refs: all("SELECT * FROM refs WHERE source_result_id IN (SELECT id FROM results WHERE section_id = 102) OR source_proof_id = 106 ORDER BY id"),
    revisions: all(`SELECT * FROM revisions WHERE (entity = 'section' AND entity_key = '102')
      OR (entity = 'result' AND entity_key IN ('106', '107', '108', '109', '116', '148', '149', '150', '151', '152'))
      OR (entity = 'proof' AND entity_key IN ('106', '128', '129', '130')) ORDER BY id`),
  };
}

function rowsOutsidePatch() {
  return {
    sections: all("SELECT * FROM sections ORDER BY id"),
    results: all("SELECT * FROM results WHERE id NOT IN (132, 133, 134, 153) ORDER BY id"),
    proofs: all("SELECT * FROM proofs WHERE id NOT IN (117, 119, 131) ORDER BY id"),
  };
}

try {
  console.log("Source database: " + (source instanceof URL ? source.href : source));
  if (prerequisite) {
    assert.equal(get("SELECT tag FROM tags WHERE tag = '8JUR'"), undefined, "Prerequisite is already present");
    db.exec(prerequisite);
    assert.equal(db.isTransaction, false);
    assert.equal(get("SELECT tag FROM tags WHERE tag = '8JUR'")?.tag, "8JUR");
    console.log("Applied prerequisite to the copy: " + prerequisitePath);
  }
  console.log("Section 1.2 patch present before Chapter 2 patch: " + Boolean(byId("results", 148)));
  const protectedBefore = protectedRows();
  const outsideBefore = rowsOutsidePatch();
  const changes = [
    ...[...resultVersions].map(([id, version]) => ({ entity: "result", table: "results", id, version, cache: "statement_html_cache" })),
    ...[...proofVersions].map(([id, version]) => ({ entity: "proof", table: "proofs", id, version, cache: "body_html_cache" })),
  ].map((change) => {
    const { entity, table, id } = change;
    const oldRow = byId(table, id);
    return { ...change, oldRow, oldSnapshot: oldRow && snapshot(entity, oldRow), oldHistory: history(entity, id) };
  });

  db.exec(sql);
  assert.equal(db.isTransaction, false);
  console.log("SQL applied to a temporary database copy.");
  const appliedChanges = db.prepare("SELECT total_changes() AS count").get().count;
  assert.throws(() => db.exec(sql), /CHECK constraint failed:\s*ok\s*=\s*1/, "The write guard must reject a second application");
  assert.equal(db.isTransaction, false);
  assert.equal(db.prepare("SELECT total_changes() AS count").get().count, appliedChanges, "Second application wrote rows");
  console.log("Second application rejected by write_guard before any rows were written.");
  assert.deepEqual(protectedRows(), protectedBefore, "Section 1.2 rows changed");
  assert.deepEqual(rowsOutsidePatch(), outsideBefore, "A section, result or proof outside the patch changed");
  console.log("Section 1.2 data and all rows outside the chapter edits verified.");

  for (const { entity, table, id, version, cache, oldRow, oldSnapshot, oldHistory } of changes) {
    const label = `${entity} ${id}`;
    const row = byId(table, id);
    assert(row, label + " is missing");
    assert.equal(row.revision, version, label + " row revision");
    assert.equal(row[cache], null, label + " cache");
    assert.deepEqual([row.updated_by, row.updated_at], ["codex", timestamp], label + " update metadata");
    assert.deepEqual([row.created_by, row.created_at], oldRow ? [oldRow.created_by, oldRow.created_at] : ["codex", timestamp], label + " creation metadata");

    const revisions = history(entity, id);
    assert.deepEqual(revisions.slice(0, oldHistory.length), oldHistory, label + " existing history");
    if (oldRow && !oldHistory.some(({ revision }) => revision === oldRow.revision)) {
      const baseline = revisions.find(({ revision }) => revision === oldRow.revision);
      assert(baseline, label + " baseline revision is missing");
      assert.deepEqual(JSON.parse(baseline.snapshot_json), oldSnapshot, label + " baseline snapshot");
    }
    const latest = revisions.at(-1);
    assert.deepEqual([latest.revision, latest.operation_id, latest.author, latest.created_at], [version, operation, "codex", timestamp], label + " revision metadata");
    assert.deepEqual(JSON.parse(latest.snapshot_json), snapshot(entity, row), label + " latest snapshot");
  }
  const definition = byId("results", 153);
  assert.equal(definition.visibility, "published");
  assert.deepEqual(snapshot("result", definition).aliases, [newAlias]);
  assert.equal(get("SELECT kind FROM tags WHERE tag = '8JUW'")?.kind, "result");
  const theoremProof = byId("proofs", 131);
  assert.deepEqual(pick(theoremProof, ["result_id", "position", "status", "generated_by", "generator_detail"]), {
    result_id: 110, position: 1, status: "ai_generated", generated_by: "gpt", generator_detail: "Codex",
  });
  const moved = changes.find(({ entity, id }) => entity === "result" && id === 133).oldRow;
  assert.equal(byId("results", 133).statement_tex, moved.statement_tex);
  console.log("Revision snapshots, baseline history, metadata and invalidated caches verified.");

  const book = await loadBook({
    batch: async (queries) => queries.map((query) => ({ results: query.all() })),
    prepare: (query) => db.prepare(query),
  }, false);
  const { macros, error } = buildMacros(get("SELECT value FROM settings WHERE key = 'macros'").value);
  assert.equal(error, undefined, "The database macros must build");
  const previewTags = new Set(["8JK2", "8JUW", "8JUD", "8JUF"]);
  const preview = [];
  let warningCount = 0;
  let sourceCount = 0;
  function render(label, tex, sourceResult, sourceProof = null) {
    const result = renderTex(tex, macros);
    sourceCount++;
    warningCount += result.warnings.length;
    for (const warning of result.warnings) console.log(`${label}: ${warning.message}`);
    for (const tag of result.refs) {
      assert(get("SELECT tag FROM tags WHERE tag = ?", tag), `${label} references unknown tag ${tag}`);
      assert(book.byTag.has(tag), `${label} references a tag missing from the published book: ${tag}`);
    }
    if (sourceResult !== undefined) {
      const refs = sourceProof === null
        ? all("SELECT * FROM refs WHERE source_result_id = ? AND source_proof_id IS NULL", sourceResult)
        : all("SELECT * FROM refs WHERE source_proof_id = ?", sourceProof);
      assert(refs.every(({ source_result_id }) => source_result_id === sourceResult), `${label} has a reference with the wrong parent result`);
      assert.deepEqual(new Set(refs.map(({ target_tag }) => target_tag)), new Set(result.refs), `${label} reference set`);
    }
    return fillRefs(result.html, book).replace(/<a class="ref" href="\/tag\/([^"]+)" data-tag="[^"]+">([\s\S]*?)<\/a>/g,
      (_, tag, text) => previewTags.has(tag) ? `<a class="ref" href="#${tag}">${text}</a>` : `<span class="ref">${text}</span>`);
  }

  for (const [sectionId, expected] of sectionOrder) {
    const section = book.sectionById.get(sectionId);
    const results = all("SELECT * FROM results WHERE section_id = ? ORDER BY position, id", sectionId);
    assert.deepEqual(results.map(({ position, id, tag, type, listed }) => [position, id, tag, type, listed]), expected);
    console.log(`${section.label} — ${section.title} (id ${sectionId})`);
    console.log("position\tid\ttag\ttype\tlisted\tlabel\ttitle");
    for (const row of results) console.log([row.position, row.id, row.tag, row.type, row.listed, book.byTag.get(row.tag).label, row.title].join("\t"));

    const chapterIntro = byId("sections", sectionId).intro_tex;
    preview.push(`<h2>${escapeHtml(section.label)} — ${escapeHtml(section.title)}</h2>`, render(section.label, chapterIntro));
    for (const row of results) {
      if (!previewTags.has(row.tag)) continue;
      const label = book.byTag.get(row.tag).label;
      const title = renderInlineTex(row.title, macros);
      const statement = render(label, row.statement_tex, row.id);
      const proofs = all("SELECT * FROM proofs WHERE result_id = ? ORDER BY position, id", row.id);
      preview.push(`<article class="result type-${row.type}" id="${row.tag}">
  <h3 class="result-head"><span class="result-label">${escapeHtml(label)}</span> ${title}</h3>
  <div class="statement">${statement}</div>
  ${proofs.map((proof) => `<div class="proof"><div class="proof-label">Proof</div>
    <div class="proof-body">${render("Proof " + proof.id, proof.body_tex, row.id, proof.id)}</div></div>`).join("\n")}
</article>`);
    }
  }
  const movedRow = byId("results", 133);
  render(movedRow.tag, movedRow.statement_tex, movedRow.id);
  console.log(`renderTex warnings: ${warningCount} across ${sourceCount} sources.`);
  assert.equal(warningCount, 0);
  console.log("Reference sets match and all rendered reference targets exist.");

  const katexCss = new URL("../../public/katex/katex.min.css", import.meta.url);
  const siteCss = new URL("../../public/static/style.css", import.meta.url);
  const previewPath = join(tempDir, "preview.html");
  writeFileSync(previewPath, `<!doctype html>
<html lang="en">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Chapter 2 formal fixes</title>
<link rel="stylesheet" href="${katexCss.href}">
<link rel="stylesheet" href="${siteCss.href}">
<style>main { max-width: 712px; }</style>
<main>
  <h1>Chapter 2 formal fixes</h1>
  ${preview.join("\n")}
</main>
</html>
`);
  console.log("Rendered HTML: " + previewPath);
} finally {
  db.close();
  for (const suffix of ["", "-wal", "-shm"]) rmSync(databasePath + suffix, { force: true });
}
console.log("ALL CHECKS PASSED");
