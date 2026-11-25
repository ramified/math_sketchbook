import assert from "node:assert/strict";
import { copyFileSync, existsSync, mkdtempSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { fileURLToPath } from "node:url";
import { DatabaseSync } from "node:sqlite";
import { fillRefs, loadBook } from "../../src/book.ts";
import { buildMacros, escapeHtml, parseBibliography, renderInlineTex, renderTex } from "../../src/latex.ts";

const [sqlPath, sourcePath] = process.argv.slice(2);
assert(sqlPath, "Usage: node 2026-11-25-ch2-error-exponents.check.mjs <sql> [source-db]");
const source = sourcePath ?? fileURLToPath(new URL(
  "../../.wrangler/state/v3/d1/miniflare-D1DatabaseObject/feb98e23e8d07ed53c02acad60b7af51cee41722a632c769f200a9b7c2d3ca7f.sqlite",
  import.meta.url,
));
const sql = readFileSync(sqlPath, "utf8");
const operation = "ch2-error-exponents-2026-11-25";
const timestamp = "2026-11-25 18:30:00";
const changes = [
  { entity: "result", table: "results", id: 154, version: 1, cache: "statement_html_cache" },
  { entity: "result", table: "results", id: 126, version: 2, cache: "statement_html_cache" },
  { entity: "result", table: "results", id: 127, version: 3, cache: "statement_html_cache" },
  { entity: "result", table: "results", id: 129, version: 2, cache: "statement_html_cache" },
  { entity: "proof", table: "proofs", id: 112, version: 2, cache: "body_html_cache" },
  { entity: "setting", table: "settings", id: "bibliography", version: 8 },
];
const sectionOrder = new Map([
  [106, [[1, 154, "8JV2", "definition", 1], [2, 126, "8JU7", "lemma", 1], [3, 127, "8JU8", "lemma", 0]]],
  [107, [[1, 128, "8JU9", "definition", 1], [2, 129, "8JUA", "proposition", 1], [3, 130, "8JUB", "lemma", 0], [4, 131, "8JUC", "lemma", 0]]],
]);

const tempDir = mkdtempSync(join(tmpdir(), "ch2-error-exponents-"));
const databasePath = join(tempDir, "grh-notes.sqlite");
copyFileSync(source, databasePath);
if (existsSync(source + "-wal")) copyFileSync(source + "-wal", databasePath + "-wal");
const db = new DatabaseSync(databasePath);
const all = (query, ...params) => db.prepare(query).all(...params);
const get = (query, ...params) => db.prepare(query).get(...params);
const readRow = ({ entity, table, id }) => get(`SELECT * FROM ${table} WHERE ${entity === "setting" ? "key" : "id"} = ?`, id);
const pick = (row, keys) => Object.fromEntries(keys.map((key) => [key, row[key]]));
const history = (entity, id) => all(
  "SELECT * FROM revisions WHERE entity = ? AND entity_key = ? ORDER BY revision",
  entity, String(id),
);

function snapshot(entity, row) {
  switch (entity) {
    case "result":
      return {
        ...pick(row, ["tag", "type", "title", "statement_tex", "section_id", "position", "listed"]),
        aliases: all("SELECT alias FROM aliases WHERE tag = ? ORDER BY alias", row.tag).map(({ alias }) => alias),
      };
    case "proof":
      return pick(row, ["result_id", "position", "body_tex", "status", "generated_by", "generator_detail", "reviewed_by", "review_notes"]);
    case "setting":
      return pick(row, ["key", "value"]);
  }
}

function rowsOutsidePatch() {
  return {
    sections: all("SELECT * FROM sections ORDER BY id"),
    results: all("SELECT * FROM results WHERE id NOT IN (126, 127, 129, 154) ORDER BY id"),
    proofs: all("SELECT * FROM proofs WHERE id <> 112 ORDER BY id"),
    settings: all("SELECT * FROM settings WHERE key <> 'bibliography' ORDER BY key"),
    tags: all("SELECT * FROM tags WHERE tag <> '8JV2' ORDER BY tag"),
    aliases: all("SELECT * FROM aliases WHERE alias <> 'error-exponents' ORDER BY alias"),
    refs: all(`SELECT * FROM refs WHERE (source_proof_id IS NULL AND source_result_id NOT IN (126, 127, 129, 154))
      OR (source_proof_id IS NOT NULL AND source_proof_id <> 112) ORDER BY id`),
    revisions: all(`SELECT * FROM revisions WHERE NOT (
      (entity = 'result' AND entity_key IN ('126', '127', '129', '154'))
      OR (entity = 'proof' AND entity_key = '112')
      OR (entity = 'setting' AND entity_key = 'bibliography')) ORDER BY id`),
  };
}

try {
  console.log(`Source database: ${source}`);
  assert.equal(get("SELECT id FROM results WHERE tag = '8JUR'")?.id, 148);
  assert.equal(get("SELECT id FROM results WHERE tag = '8JUW'")?.id, 153);
  console.log("Section 1.2 and the previous Chapter 2 patch are present.");
  const outsideBefore = rowsOutsidePatch();
  const before = changes.map((change) => {
    const row = readRow(change);
    return { change, row, snapshot: row && snapshot(change.entity, row), history: history(change.entity, change.id) };
  });

  db.exec(sql);
  assert.equal(db.isTransaction, false);
  console.log("SQL applied to a temporary database copy.");
  const appliedChanges = get("SELECT total_changes() AS count").count;
  assert.throws(() => db.exec(sql), /CHECK constraint failed:\s*ok\s*=\s*1/);
  assert.equal(db.isTransaction, false);
  assert.equal(get("SELECT total_changes() AS count").count, appliedChanges);
  console.log("Second application rejected by write_guard before any rows were written.");
  assert.deepEqual(rowsOutsidePatch(), outsideBefore);
  console.log("Rows outside the patch verified.");

  for (const { change, row: oldRow, snapshot: oldSnapshot, history: oldHistory } of before) {
    const { entity, id, version, cache } = change;
    const label = `${entity} ${id}`;
    const row = readRow(change);
    assert.equal(row.revision, version, label + " row revision");
    if (cache) {
      assert.equal(row[cache], null, label + " cache");
      assert.deepEqual([row.updated_by, row.updated_at], ["codex", timestamp], label + " update metadata");
      assert.deepEqual([row.created_by, row.created_at], oldRow ? [oldRow.created_by, oldRow.created_at] : ["codex", timestamp]);
    }
    const revisions = history(entity, id);
    assert.deepEqual(revisions.slice(0, oldHistory.length), oldHistory, label + " existing history");
    const needsBaseline = Boolean(oldRow && !oldHistory.some(({ revision }) => revision === oldRow.revision));
    assert.equal(revisions.length, oldHistory.length + 1 + Number(needsBaseline), label + " history length");
    if (needsBaseline) {
      const baseline = revisions.at(-2);
      assert.equal(baseline.revision, oldRow.revision, label + " baseline revision");
      assert.deepEqual(JSON.parse(baseline.snapshot_json), oldSnapshot, label + " baseline snapshot");
    }
    const latest = revisions.at(-1);
    assert.deepEqual([latest.revision, latest.operation_id, latest.author, latest.created_at], [version, operation, "codex", timestamp], label + " latest metadata");
    assert.deepEqual(JSON.parse(latest.snapshot_json), snapshot(entity, row), label + " latest snapshot");
  }
  assert.deepEqual({ ...get("SELECT * FROM tags WHERE tag = '8JV2'") }, { tag: "8JV2", kind: "result", created_at: timestamp });
  assert.deepEqual({ ...get("SELECT * FROM aliases WHERE alias = 'error-exponents'") }, { alias: "error-exponents", tag: "8JV2", created_at: timestamp });
  assert.equal(get("SELECT visibility FROM results WHERE id = 154").visibility, "published");
  assert.equal(get("SELECT statement_tex FROM results WHERE id = 127").statement_tex, before.find(({ change }) => change.id === 127).row.statement_tex);
  const oldBibliography = before.find(({ change }) => change.entity === "setting").row.value;
  const newBibliography = get("SELECT value FROM settings WHERE key = 'bibliography'").value;
  assert(newBibliography.startsWith(oldBibliography + "\n"));
  const items = parseBibliography(newBibliography);
  assert.deepEqual(items.slice(0, -1), parseBibliography(oldBibliography));
  const entry = items.at(-1);
  assert.equal(entry.key, "Adriazola");
  console.log("Revision snapshots, baseline history, metadata, caches and bibliography append verified.");

  const book = await loadBook({
    batch: async (queries) => queries.map((query) => ({ results: query.all() })),
    prepare: (query) => db.prepare(query),
  }, false);
  const { macros, error } = buildMacros(get("SELECT value FROM settings WHERE key = 'macros'").value);
  assert.equal(error, undefined);
  const previewTags = new Set(["8JV2", "8JU7", "8JU8", "8JUA"]);
  const preview = [];
  let sourceCount = 0;
  function render(label, tex, sourceResult, sourceProof = null) {
    const result = renderTex(tex, macros);
    sourceCount++;
    assert.deepEqual(result.warnings, [], label + " renderTex warnings");
    for (const tag of result.refs) {
      assert(get("SELECT tag FROM tags WHERE tag = ?", tag), `${label} references unknown tag ${tag}`);
      assert(book.byTag.has(tag), `${label} references a tag missing from the published book: ${tag}`);
    }
    if (sourceResult !== undefined) {
      const refs = all("SELECT * FROM refs WHERE source_result_id = ? AND source_proof_id IS ?", sourceResult, sourceProof);
      assert.deepEqual(refs.map(({ target_tag }) => target_tag).sort(), [...result.refs].sort(), label + " reference set");
      if (sourceProof !== null) assert.equal(get("SELECT COUNT(*) AS count FROM refs WHERE source_proof_id = ?", sourceProof).count, refs.length);
    }
    return fillRefs(result.html, book)
      .replace(/<a class="ref" href="\/tag\/([^"]+)" data-tag="[^"]+">([\s\S]*?)<\/a>/g,
        (_, tag, text) => previewTags.has(tag) ? `<a class="ref" href="#${tag}">${text}</a>` : `<span class="ref">${text}</span>`)
      .replaceAll('/bibliography#cite-Adriazola', '#cite-Adriazola');
  }

  for (const [sectionId, expected] of sectionOrder) {
    const section = book.sectionById.get(sectionId);
    const results = all("SELECT * FROM results WHERE section_id = ? ORDER BY position, id", sectionId);
    assert.deepEqual(results.map(({ position, id, tag, type, listed }) => [position, id, tag, type, listed]), expected);
    console.log(`${section.label} — ${section.title} (id ${sectionId})`);
    console.log("position\tid\ttag\ttype\tlisted\tlabel\ttitle");
    preview.push(`<h2>${escapeHtml(section.label)} — ${escapeHtml(section.title)}</h2>`);
    for (const row of results) {
      const label = book.byTag.get(row.tag).label;
      console.log([row.position, row.id, row.tag, row.type, row.listed, label, row.title].join("\t"));
      if (!previewTags.has(row.tag)) continue;
      const statement = render(row.tag, row.statement_tex, row.id);
      const proof = row.id === 126 ? `<div class="proof"><div class="proof-label">Proof</div><div class="proof-body">${
        render("Proof 112", get("SELECT body_tex FROM proofs WHERE id = 112").body_tex, row.id, 112)}</div></div>` : "";
      preview.push(`<article class="result type-${row.type}" id="${row.tag}">
  <h3 class="result-head"><span class="result-label">${escapeHtml(label)}</span> ${renderInlineTex(row.title, macros)}</h3>
  <div class="statement">${statement}</div>
  ${proof}
</article>`);
    }
  }
  preview.push(`<h2>Bibliography</h2><dl class="bibliography"><dt id="cite-Adriazola">[Adriazola]</dt><dd>${render("Adriazola bibliography entry", entry.tex)}</dd></dl>`);
  assert.equal(preview.join("\n").split('href="#cite-Adriazola"').length - 1, 2);
  console.log(`renderTex warnings: 0 across ${sourceCount} sources.`);
  console.log("Reference sets match, all rendered targets exist, and both citations resolve.");

  const katexCss = new URL("../../node_modules/katex/dist/katex.min.css", import.meta.url);
  const siteCss = new URL("../../public/static/style.css", import.meta.url);
  const previewPath = join(tempDir, "preview.html");
  writeFileSync(previewPath, `<!doctype html>
<html lang="en">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Chapter 2 error exponents</title>
<link rel="stylesheet" href="${katexCss.href}">
<link rel="stylesheet" href="${siteCss.href}">
<style>main { max-width: 680px; }</style>
<main>
  <h1>Chapter 2 error exponents</h1>
  ${preview.join("\n")}
</main>
</html>
`);
  console.log(`Rendered HTML: ${previewPath}`);
} finally {
  db.close();
  for (const suffix of ["", "-wal", "-shm"]) rmSync(databasePath + suffix, { force: true });
}

console.log("ALL CHECKS PASSED");
