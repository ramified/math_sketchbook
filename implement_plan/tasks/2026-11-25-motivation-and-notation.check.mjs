import assert from "node:assert/strict";
import { copyFileSync, existsSync, mkdtempSync, readFileSync, rmdirSync, rmSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { DatabaseSync } from "node:sqlite";
import { parse } from "@unified-latex/unified-latex-util-parse";
import app from "../../src/index.ts";
import { buildMacros, renderTex } from "../../src/latex.ts";

const [sqlPath = new URL("../../scripts/motivation-and-notation-2026-11-25.sql", import.meta.url),
  source = new URL("../../.wrangler/state/v3/d1/miniflare-D1DatabaseObject/feb98e23e8d07ed53c02acad60b7af51cee41722a632c769f200a9b7c2d3ca7f.sqlite", import.meta.url),
  previewPath] = process.argv.slice(2);
const migration = readFileSync(new URL("../../migrations/0003_motivation_type.sql", import.meta.url), "utf8");
const sql = readFileSync(sqlPath, "utf8");
const timestamp = "2026-11-25 20:00:00";
const operation = "motivation-and-notation-2026-11-25";
const author = "codex";
const newResults = [
  { id: 155, tag: "8JV3", alias: "smoothed-sum-motivation", position: 1, type: "motivation", listed: 1 },
  { id: 156, tag: "8JV4", alias: "absolutely-integrable", position: 12, type: "definition", listed: 0 },
];
const groups = [
  { table: "sections", entity: "section", tex: "intro_tex", cache: "intro_html_cache", ids: [102, 107],
    keys: ["tag", "kind", "title", "intro_tex", "parent_id", "position"] },
  { table: "results", entity: "result", tex: "statement_tex", cache: "statement_html_cache",
    ids: [106, 107, 108, 109, 116, 119, 128, 131, 141, 148, 149, 150, 151, 152, 155, 156],
    keys: ["tag", "type", "title", "statement_tex", "section_id", "position", "listed"] },
  { table: "proofs", entity: "proof", tex: "body_tex", cache: "body_html_cache", ids: [101, 106, 117, 124, 128, 129],
    keys: ["result_id", "position", "body_tex", "status", "generated_by", "generator_detail", "reviewed_by", "review_notes"] },
];

const temp = mkdtempSync(join(tmpdir(), "motivation-and-notation-"));
const databasePath = join(temp, "grh-notes.sqlite");
let db;
const all = (query, ...args) => db.prepare(query).all(...args);
const get = (query, ...args) => db.prepare(query).get(...args);
const readRows = (table) => all("SELECT * FROM " + table + " ORDER BY rowid");
const aliases = (tag) => all("SELECT alias FROM aliases WHERE tag = ? ORDER BY alias", tag).map(row => row.alias);
const history = (entity, id) => all(
  "SELECT * FROM revisions WHERE entity = ? AND entity_key = ? ORDER BY revision", entity, String(id),
);
const sorted = (values) => [...values].sort();
const pick = (row, keys) => Object.fromEntries(keys.map(key => [key, row[key]]));

function snapshot(group, row) {
  const value = pick(row, group.keys);
  if (group.entity === "result") value.aliases = aliases(row.tag);
  return value;
}

// Use a transaction to exercise deferred FK enforcement and D1's file-apply semantics.
function transaction(query) {
  db.exec("BEGIN");
  try {
    db.exec(query);
    db.exec("COMMIT");
  } catch (error) {
    if (db.isTransaction) db.exec("ROLLBACK");
    throw error;
  }
}

function checkIntegrity() {
  assert.equal(get("PRAGMA foreign_keys").foreign_keys, 1);
  assert.deepEqual(all("PRAGMA foreign_key_check"), []);
  assert.equal(get("PRAGMA integrity_check").integrity_check, "ok");
}

// Match stacked and slash shorthand, including a point written after the quotient.
// Use the parser to distinguish inline and display TeX.
const fn = String.raw`(?:\bL(?:_\{[^{}]+\}|_[A-Za-z])?|\\zeta(?![A-Za-z]))`;
const shorthandFrac = new RegExp(String.raw`\\[dt]?frac\{-?(${fn})'\}\{\1\}`, "g");
const shorthandSlash = new RegExp(String.raw`(${fn})'/\1(?:[)\]}]*\(|(?=[=<>\\]))`, "g");
const fraction = new RegExp(String.raw`\\([dt]?frac)\{-?(${fn})'\(([^()]*)\)\}\{\2\(([^()]*)\)\}`, "g");
const slash = new RegExp(String.raw`(${fn})'\(([^()]*)\)/\1\(([^()]*)\)`, "g");

function notationViolations(tex) {
  if (!/L|\\zeta/.test(tex) || !/['′]|\\prime/.test(tex)) return [];
  const violations = [];
  function visit(nodes) {
    for (const node of nodes ?? []) {
      if (["inlinemath", "displaymath", "mathenv"].includes(node.type)) {
        const { start, end } = node.position;
        const math = tex.slice(start.offset, end.offset)
          .replace(/\\(?:left|right|big[lr]?|Big[lr]?)(?=[()[\]{}])/g, "")
          .replace(/\\[,!;:]|\s/g, "")
          .replace(/\^\{?\\prime\}?|′/g, "'");
        for (const pattern of [shorthandFrac, shorthandSlash]) {
          violations.push(...Array.from(math.matchAll(pattern), match => match[0]));
        }
        for (const match of math.matchAll(fraction)) {
          const [text, command, , numerator, denominator] = match;
          const before = math.slice(0, match.index);
          const insideArray = /\\begin\{(?:cases|array)\}/.test(before.split(/\\end\{(?:cases|array)\}/).at(-1));
          if (node.type === "inlinemath" || command === "tfrac" || (insideArray && command !== "dfrac") || numerator !== denominator) {
            violations.push(text);
          }
        }
        for (const [text, , numerator, denominator] of math.matchAll(slash)) {
          if (node.type !== "inlinemath" || numerator !== denominator) violations.push(text);
        }
      } else {
        if (Array.isArray(node.content)) visit(node.content);
        for (const arg of node.args ?? []) visit(arg.content);
      }
    }
  }
  visit(parse(tex).content);
  return violations;
}

try {
  copyFileSync(source, databasePath);
  const wal = source instanceof URL ? new URL(source.href + "-wal") : source + "-wal";
  if (existsSync(wal)) copyFileSync(wal, databasePath + "-wal");
  db = new DatabaseSync(databasePath);
  console.log("Source database copied to a temporary directory.");

  const tables = all("SELECT name FROM sqlite_master WHERE type = 'table' AND name NOT LIKE 'sqlite_%' ORDER BY name");
  const before = Object.fromEntries(tables.map(({ name }) => [name, readRows(name)]));
  const schemaQueries = ["table_info(results)", "foreign_key_list(results)", "index_list(results)", "index_info(results_order)"];
  const schema = () => schemaQueries.map(query => all("PRAGMA " + query));
  const oldSchema = schema();
  assert.equal(get("SELECT COUNT(*) AS n FROM tags WHERE tag IN ('8JV3', '8JV4')").n, 0);
  assert(before.proofs.length > 0 && before.refs.length > 0, "Migration must exercise inbound foreign keys");
  transaction(migration);
  assert.deepEqual(schema(), oldSchema);
  for (const { name } of tables) assert.deepEqual(readRows(name), before[name], name + " preserved by migration");
  checkIntegrity();
  db.exec("SAVEPOINT motivation_probe");
  db.exec("INSERT INTO tags (tag, kind) VALUES ('8JV3', 'result');"
    + "INSERT INTO results (id, tag, type, section_id, position) VALUES (155, '8JV3', 'motivation', 102, 11);");
  assert.equal(get("SELECT type FROM results WHERE id = 155").type, "motivation");
  assert.throws(() => db.exec("UPDATE results SET type = 'invalid' WHERE id = 155"), /CHECK constraint failed/);
  db.exec("ROLLBACK TO motivation_probe; RELEASE motivation_probe");
  console.log("0003 preserved all rows, schema columns, foreign keys and indexes.");
  console.log("PRAGMA foreign_key_check: empty. PRAGMA integrity_check: ok. Motivation insert succeeded.");

  const changes = groups.flatMap(group => group.ids.map(id => {
    const row = before[group.table].find(entry => entry.id === id);
    return { group, id, row, baseline: row && snapshot(group, row), history: history(group.entity, id) };
  }));
  transaction(sql);
  console.log("Content SQL applied.");
  const applied = get("SELECT total_changes() AS count").count;
  assert.throws(() => transaction(sql), /CHECK constraint failed:\s*ok\s*=\s*1/);
  assert.equal(get("SELECT total_changes() AS count").count, applied);
  console.log("Second application rejected by write_guard before any writes.");
  checkIntegrity();

  const { macros, error } = buildMacros(get("SELECT value FROM settings WHERE key = 'macros'").value);
  assert.equal(error, undefined);
  const preview = [];
  for (const change of changes) {
    const { group, id, row: old } = change;
    const { entity, tex, cache } = group;
    const label = entity + " " + id;
    const row = get("SELECT * FROM " + group.table + " WHERE id = ?", id);
    assert.equal(row.revision, old ? old.revision + 1 : 1, label);
    assert.equal(row[cache], null, label);
    assert.deepEqual([row.updated_by, row.updated_at], [author, timestamp], label);
    if (entity !== "section") {
      assert.deepEqual([row.created_by, row.created_at], old ? [old.created_by, old.created_at] : [author, timestamp], label);
    }

    const after = history(entity, id);
    const needsBaseline = Boolean(old && !change.history.some(entry => entry.revision === old.revision));
    assert.deepEqual(after.slice(0, change.history.length), change.history, label);
    assert.equal(after.length, change.history.length + Number(needsBaseline) + 1, label);
    if (needsBaseline) {
      assert.equal(after.at(-2).revision, old.revision, label);
      assert.deepEqual(JSON.parse(after.at(-2).snapshot_json), change.baseline, label);
    }
    const latest = after.at(-1);
    assert.deepEqual(pick(latest, ["revision", "operation_id", "author", "created_at"]),
      { revision: row.revision, operation_id: operation, author, created_at: timestamp }, label);
    assert.deepEqual(JSON.parse(latest.snapshot_json), snapshot(group, row), label);

    const rendered = renderTex(row[tex], macros);
    assert.deepEqual(rendered.warnings, [], label);
    for (const tag of rendered.refs) assert(get("SELECT 1 FROM tags WHERE tag = ?", tag), label + " → " + tag);
    if (entity === "section") {
      const expected = id === 102 ? ["8JF7", "8JS2", "8JV3", "7HM3"] : renderTex(old[tex], macros).refs;
      assert.deepEqual(sorted(rendered.refs), sorted(expected), label);
    } else {
      const refs = all("SELECT target_tag FROM refs WHERE source_result_id = ? AND source_proof_id IS ?",
        entity === "result" ? id : row.result_id, entity === "proof" ? id : null);
      assert.deepEqual(sorted(refs.map(ref => ref.target_tag)), sorted(rendered.refs), label);
      if (id === 155 && entity === "result") {
        const oldIntro = before.sections.find(section => section.id === 102).intro_tex;
        assert.deepEqual(sorted(rendered.refs), sorted([...renderTex(oldIntro, macros).refs, "8JV4"]), label);
      }
    }
    if (!old || old[tex] !== row[tex]) {
      const className = { section: "intro", result: "statement", proof: "proof-body" }[entity];
      preview.push('<section><h2>' + label + '</h2><div class="' + className + '">' + rendered.html + "</div></section>");
    }
  }
  console.log("Baseline and new revision snapshots, update metadata, and cache invalidation verified.");
  console.log("renderTex warnings: 0 across " + changes.length + " sources. Rendered reference sets and targets verified.");

  function outsidePatch(name, rows) {
    const group = groups.find(group => group.table === name);
    if (group) return rows.filter(row => !group.ids.includes(row.id));
    if (name === "tags") return rows.filter(row => !newResults.some(result => row.tag === result.tag));
    if (name === "aliases") return rows.filter(row => !newResults.some(result => row.alias === result.alias));
    if (name === "refs") return rows.filter(row => !newResults.some(result => row.source_result_id === result.id));
    if (name === "revisions") return rows.filter(row => row.operation_id !== operation);
    return rows;
  }
  for (const { name } of tables) assert.deepEqual(outsidePatch(name, readRows(name)), outsidePatch(name, before[name]), name);
  for (const { id, tag, alias, position, type, listed } of newResults) {
    assert.deepEqual(pick(get("SELECT * FROM results WHERE id = ?", id), ["tag", "type", "position", "listed", "section_id", "visibility", "state"]),
      { tag, type, position, listed, section_id: 102, visibility: "published", state: "active" });
    assert.deepEqual({ ...get("SELECT * FROM tags WHERE tag = ?", tag) }, { tag, kind: "result", created_at: timestamp });
    assert.deepEqual({ ...get("SELECT * FROM aliases WHERE alias = ?", alias) }, { alias, tag, created_at: timestamp });
    assert.equal(get("SELECT COUNT(*) AS n FROM proofs WHERE result_id = ?", id).n, 0);
  }

  const order = all("SELECT * FROM results WHERE section_id = 102 ORDER BY position, id");
  const oldOrder = before.results.filter(row => row.section_id === 102).sort((a, b) => a.position - b.position);
  const orderFields = ["position", "id", "tag", "type", "listed"];
  assert.deepEqual(order.map(row => pick(row, orderFields)), [
    pick(newResults[0], orderFields),
    ...oldOrder.map(row => pick({ ...row, position: row.position + 1 }, orderFields)),
    pick(newResults[1], orderFields),
  ]);
  console.log("Section 1.2 order");
  console.log("position\tid\ttag\ttype\tlisted\ttitle");
  for (const row of order) console.log([...orderFields.map(field => row[field]), row.title].join("\t"));

  const initialViolations = groups.flatMap(({ table, tex }) => before[table].flatMap(row => notationViolations(row[tex])));
  assert.equal(initialViolations.length, 27, "Pre-patch notation inventory");
  const sources = groups.flatMap(({ table, tex }) => all("SELECT id, " + tex + " AS tex FROM " + table)
    .map(row => ({ ...row, table })));
  const violations = sources.flatMap(({ id, tex, table }) => notationViolations(tex).map(text => ({ table, id, text })));
  assert.deepEqual(violations, []);
  console.log("Full-book scan: " + initialViolations.length + " before, " + violations.length
    + " after across " + sources.length + " sources.");

  // Exercise the real routes in process, with the temporary copy as the D1 binding.
  const bind = (stmt, args = []) => ({
    bind: (...values) => bind(stmt, values),
    all: async () => ({ results: stmt.all(...args) }),
    first: async () => stmt.get(...args) ?? null,
    run: async () => stmt.run(...args),
  });
  const DB = {
    prepare: query => bind(db.prepare(query)),
    batch: stmts => Promise.all(stmts.map(stmt => stmt.all())),
  };
  async function request(path, status = 200) {
    const response = await app.request(path, {}, { DB });
    assert.equal(response.status, status, path);
    return response;
  }
  const sectionPage = await (await request("/tag/7HE6")).text();
  assert.match(sectionPage, /<a class="ref" href="\/tag\/8JV3" data-tag="8JV3">Motivation 1\.2\.1<\/a>/);
  assert.match(sectionPage, /<article class="result type-motivation" id="8JV3"/);
  assert.doesNotMatch(sectionPage, /<article[^>]+id="8JV4"/);
  const motivation = await (await request("/tag/8JV3")).text();
  assert.match(motivation, /<a class="ref" href="\/tag\/8JV4" data-tag="8JV4">absolutely integrable<\/a>/);
  assert.match(await (await request("/tag/8JV4")).text(), /Absolutely integrable on a vertical line/);
  assert.match(await (await request("/api/knowl/8JV4")).text(), /Absolutely integrable on a vertical line/);
  for (const { tag, alias } of newResults) {
    assert.equal((await request("/tag/" + alias, 301)).headers.get("Location"), "/tag/" + tag);
  }
  console.log("Numbered Motivation, section intro reference, unlisted definition, knowl and aliases verified through reader routes.");

  if (previewPath) {
    const katex = new URL("../../node_modules/katex/dist/katex.min.css", import.meta.url);
    const style = new URL("../../public/static/style.css", import.meta.url);
    writeFileSync(previewPath, '<!doctype html><meta charset="utf-8"><title>Notation preview</title>'
      + '<link rel="stylesheet" href="' + katex.href + '"><link rel="stylesheet" href="' + style.href + '">'
      + '<main style="max-width:712px">' + preview.join("\n") + "</main>");
    console.log("Rendered preview: " + previewPath);
  }
} finally {
  db?.close();
  for (const suffix of ["", "-wal", "-shm", "-journal"]) rmSync(databasePath + suffix, { force: true });
  rmdirSync(temp);
}

console.log("ALL CHECKS PASSED");
