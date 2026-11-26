import assert from "node:assert/strict";
import { mkdtempSync, readFileSync, rmSync, rmdirSync } from "node:fs";
import { tmpdir } from "node:os";
import { join, resolve } from "node:path";
import { DatabaseSync } from "node:sqlite";
import katex from "katex";
import fontMetrics from "../../node_modules/katex/src/fontMetricsData.js";
import { buildMacros, findRefTargets, renderTex } from "../../src/latex.ts";
import { TAG_ALPHABET } from "../../src/tags.ts";

const operation = "ch2-fourier-split-2026-11-25";
const timestamp = "2026-11-25 20:00:00";
const reportPath = new URL("./2026-11-25-ch2-fourier-split.md.report.md", import.meta.url);
const [backupPath, sqlPath] = process.argv.slice(2);
assert(backupPath && sqlPath, "Usage: node checker.mjs BACKUP.sql MIGRATION.sql");
const report = readFileSync(reportPath, "utf8");
const sql = readFileSync(sqlPath, "utf8");
const firstStatement = sql.replace(/^(?:\s*--[^\r\n]*(?:\r?\n|$))+\s*/, "");
assert.match(firstStatement, /^INSERT OR ROLLBACK INTO write_guard\b/i);
assert.doesNotMatch(sql, /^\s*(?:BEGIN|COMMIT|END TRANSACTION)\b/im);

const tables = {
  sections: { entity: "section", tex: "intro_tex", cache: "intro_html_cache" },
  results: { entity: "result", tex: "statement_tex", cache: "statement_html_cache" },
  proofs: { entity: "proof", tex: "body_tex", cache: "body_html_cache" },
};
const records = (db, table) => db.prepare("SELECT * FROM " + table + " ORDER BY id").all();
const keyById = rows => new Map(rows.map(row => [row.id, row]));
const serial = rows => rows.map(row => JSON.stringify(row)).sort();
const totalChanges = db => db.prepare("SELECT total_changes() AS n").get().n;

function apply(db) {
  db.exec("BEGIN IMMEDIATE");
  try {
    db.exec(sql);
    db.exec("COMMIT");
  } catch (error) {
    if (db.isTransaction) db.exec("ROLLBACK");
    throw error;
  }
}

function checkGuard(db, path) {
  const before = readFileSync(path);
  const changes = totalChanges(db);
  assert.throws(() => apply(db), /CHECK constraint failed:.*ok\s*=\s*1/i);
  assert.equal(totalChanges(db), changes, "The rejected batch attempted a write");
  assert.deepEqual(readFileSync(path), before, "The rejected batch changed the SQLite file");
  assert.equal(db.prepare("SELECT COUNT(*) AS n FROM write_guard").get().n, 0);
}

function checkStructure(db) {
  const sectionLayout = [
    ["2", 105, "8JU2", null, 2, "chapter"],
    ["2.1", 112, "8JV6", "8JU2", 1, "section"],
    ["2.2", 113, "8JV7", "8JU2", 2, "section"],
    ["2.3", 114, "8JV8", "8JU2", 3, "section"],
    ["2.4", 108, "8JU5", "8JU2", 4, "section"],
    ["3", 111, "8JV5", null, 3, "chapter"],
    ["3.1", 106, "8JU3", "8JV5", 1, "section"],
    ["3.2", 107, "8JU4", "8JV5", 2, "section"],
    ["3.3", 109, "8JU6", "8JV5", 3, "section"],
  ];
  const reportRows = report.split(/\r?\n/).filter(line => /^\| [123](?:\.[1-4])? \| \d+ \|/.test(line))
    .map(line => line.split("|").slice(1, -1).map(field => field.trim()));
  const reportSections = reportRows.filter(row => row.length === 7);
  const reportResults = reportRows.filter(row => row.length === 8);
  assert.equal(reportSections.length, sectionLayout.length, "Report section count");
  const sections = keyById(records(db, "sections"));
  const sectionNumbers = new Map([[102, "1.2"], [103, "1.3"]]);
  for (const [index, [number, id, tag, parent, position, kind]] of sectionLayout.entries()) {
    const row = sections.get(id);
    assert(row, "Missing section " + tag);
    const parentTag = row.parent_id === null ? null : sections.get(row.parent_id)?.tag;
    assert.deepEqual([row.tag, parentTag, row.position, row.kind], [tag, parent, position, kind]);
    assert.deepEqual(reportSections[index], [number, String(id), tag, parent ?? "—", String(position), kind, row.title]);
    sectionNumbers.set(id, number);
  }
  assert.deepEqual([...sections.values()].filter(row => row.kind === "chapter").map(row => row.id), [100, 105, 111]);
  assert.equal([...sections.values()].filter(row => [105, 111].includes(row.parent_id)).length, 7);

  const external = new Set([110, 155]);
  const relevant = records(db, "results").filter(row =>
    external.has(row.id) || (sectionNumbers.get(row.section_id)?.[0] ?? "1") !== "1");
  const actual = relevant.map(row => [
    sectionNumbers.get(row.section_id), String(row.position), String(row.id), row.tag, row.type,
    String(row.listed), row.title,
  ]);
  assert.deepEqual(serial(actual), serial(reportResults.map(row => row.slice(0, 7))), "Result layout differs from report");
  assert.equal(reportResults.length, 26);
  assert(reportResults.every(row => row[7].length > 0), "Missing result description");
  assert(relevant.every(row => row.state === "active" && row.visibility === "published"));
  for (const id of [...sectionNumbers.keys()].filter(id => id >= 105)) {
    const positions = relevant.filter(row => row.section_id === id).map(row => row.position).sort((a, b) => a - b);
    assert.deepEqual(positions, positions.map((_, index) => index + 1), "Result positions for section " + id);
  }

  const newTags = db.prepare("SELECT tag, created_at FROM tags WHERE tag > '8JV4' ORDER BY tag").all();
  const expectedTags = [...TAG_ALPHABET.slice(TAG_ALPHABET.indexOf("4") + 1, TAG_ALPHABET.indexOf("M") + 1)]
    .map(letter => "8JV" + letter);
  assert.deepEqual(newTags.map(row => row.tag), expectedTags);
  assert(newTags.every(row => row.created_at === timestamp));
}

function snapshotFor(db, table, row) {
  if (table === "sections") {
    const { tag, kind, title, intro_tex, parent_id, position } = row;
    return { tag, kind, title, intro_tex, parent_id, position };
  }
  if (table === "results") {
    const { tag, type, title, statement_tex, section_id, position, listed } = row;
    const aliases = db.prepare("SELECT alias FROM aliases WHERE tag=? ORDER BY alias").all(tag).map(entry => entry.alias);
    return { tag, type, title, statement_tex, section_id, position, listed, aliases };
  }
  const { result_id, body_tex, status, generated_by, generator_detail, reviewed_by, review_notes, position } = row;
  return { result_id, body_tex, status, generated_by, generator_detail, reviewed_by, review_notes, position };
}

function checkContent(db, before) {
  const sections = records(db, "sections");
  const results = records(db, "results");
  const resultsById = keyById(results);
  const tags = new Set(db.prepare("SELECT tag FROM tags").all().map(row => row.tag));
  const chapterBySectionId = new Map(sections.map(row => [row.id, row.parent_id ?? row.id]));
  const chapterByTag = new Map([
    ...sections.map(row => [row.tag, chapterBySectionId.get(row.id)]),
    ...results.map(row => [row.tag, chapterBySectionId.get(row.section_id)]),
  ]);
  const chapterTwoId = 105;
  const chapterThreeId = 111;
  const chapterThreeTag = sections.find(row => row.id === chapterThreeId).tag;
  const proofExceptions = new Map([
    ["8JVG", ["8JU7", "8JUF", "8JUG"]],
    ["8JVK", ["8JU7"]],
  ]);
  const aliases = new Map(db.prepare("SELECT alias, tag FROM aliases").all().map(row => [row.alias, row.tag]));
  const resolveTag = target => aliases.get(target) ?? target;
  const readRevision = db.prepare("SELECT * FROM revisions WHERE entity=? AND entity_key=? AND revision=?");
  const { macros, error } = buildMacros(db.prepare("SELECT value FROM settings WHERE key='macros'").get().value);
  assert.equal(error, undefined);
  const expectedRefs = new Set();
  const changedDisplays = [];
  const changes = { sections: 0, results: 0, proofs: 0 };
  for (const [table, { entity, tex, cache }] of Object.entries(tables)) {
    const rows = records(db, table);
    const oldRows = before[table];
    for (const old of oldRows.values()) {
      const current = rows.find(row => row.id === old.id);
      assert(current, "Missing existing " + entity + " " + old.id);
      for (const column of ["tag", "created_by", "created_at", "result_id", "visibility", "state", "replaced_by_id"]) {
        assert.equal(current[column], old[column], table + "." + column + " at " + old.id);
      }
    }
    for (const row of rows) {
      const old = oldRows.get(row.id);
      const label = row.tag ?? "proof " + row.id + " (" + row.result_id + ")";
      const out = renderTex(row[tex], macros);
      const ownerTag = row.tag ?? resultsById.get(row.result_id).tag;
      const allowedTargets = table === "sections" ? [chapterThreeTag]
        : table === "proofs" ? proofExceptions.get(ownerTag) ?? [] : [];
      const references = new Set([...out.refs, ...findRefTargets(row[tex]).map(ref => ref.target)]);
      const titleReferences = findRefTargets(row.title ?? "").map(ref => ref.target);
      for (const target of new Set([...references, ...titleReferences])) {
        const canonical = resolveTag(target);
        assert(tags.has(canonical) && chapterByTag.has(canonical), label + " has broken reference to " + target);
        if (chapterByTag.get(ownerTag) === chapterTwoId && chapterByTag.get(canonical) === chapterThreeId) {
          assert(allowedTargets.includes(canonical) && !titleReferences.includes(target),
            label + " has a Chapter 3 dependency on " + target);
        }
      }
      if (table !== "sections") {
        for (const target of out.refs) {
          expectedRefs.add(JSON.stringify([row.result_id ?? row.id, table === "proofs" ? row.id : null, target]));
        }
      }
      if (old && JSON.stringify(old) === JSON.stringify(row)) continue;

      changes[table]++;
      assert.equal(row.revision, old ? old.revision + 1 : 1, label);
      assert.equal(row[cache], null, label + " still has cached HTML");
      assert.equal(row.updated_at, timestamp, label);
      assert.equal(row.updated_by, "codex", label);
      if (!old) {
        assert.equal(row.created_at, timestamp, label);
        if (table !== "sections") assert.equal(row.created_by, "codex", label);
      }
      if (table === "proofs") assert.equal(row.generated_by, "gpt", label);
      const revision = readRevision.get(entity, String(row.id), row.revision);
      assert(revision, "Missing revision for " + label);
      assert.equal(revision.operation_id, operation, label);
      assert.equal(revision.author, "codex", label);
      assert.equal(revision.created_at, timestamp, label);
      assert.deepEqual(JSON.parse(revision.snapshot_json), snapshotFor(db, table, row), label);
      if (old) assert(readRevision.get(entity, String(row.id), old.revision), "Missing baseline revision for " + label);

      assert.deepEqual(out.warnings, [], label + " TeX");
      if (row.title) {
        const title = renderTex(row.title, macros);
        assert.deepEqual(title.warnings, [], label + " title TeX");
        for (const target of title.refs) assert(chapterByTag.has(resolveTag(target)), label + " title ref " + target);
      }
      changedDisplays.push({ label, html: out.html });
    }
  }
  const actualRefs = db.prepare("SELECT source_result_id, source_proof_id, target_tag FROM refs").all()
    .map(row => JSON.stringify([row.source_result_id, row.source_proof_id, row.target_tag]));
  assert.deepEqual(actualRefs.sort(), [...expectedRefs].sort(), "refs differs from statement and proof text");
  assert.deepEqual(db.prepare("PRAGMA foreign_key_check").all(), []);
  assert.equal(db.prepare("PRAGMA integrity_check").get().integrity_check, "ok");
  assert.equal(db.prepare("SELECT value FROM settings WHERE key='needs_rebuild'").get().value, "1");
  assert.match(db.prepare("SELECT statement_tex FROM results WHERE tag='8JK2'").get().statement_tex, /\\ref\{8JU2\}/);
  assert.match(db.prepare("SELECT statement_tex FROM results WHERE tag='8JV3'").get().statement_tex, /\\hyperref\[8JU9\]/);
  assert.match(db.prepare("SELECT statement_tex FROM results WHERE tag='8JUW'").get().statement_tex, /\\ref\{8JVE\}/);
  const intervalIntro = db.prepare("SELECT intro_tex FROM sections WHERE tag='7HH9'").get().intro_tex;
  assert.match(intervalIntro, /\\ref\{8JU2\}/);
  assert.match(intervalIntro, /\\ref\{8JV5\}/);
  console.log("Chapter 2 references stay within its inputs and the permitted Chapter 3 proof and overview links");
  console.log("TeX verified with 0 warnings: " + JSON.stringify(changes));
  return { changedDisplays, macros };
}

// Measure the layout tree in em. A vertical stack takes its widest member,
// whereas an aligned array sums its column widths, including the column gaps.
const sizeScale = [0.5, 0.6, 0.7, 0.8, 0.9, 1, 1.2, 1.44, 1.728, 2.074, 2.488];
const bodyPx = 18;
const mathEmPx = bodyPx * 1.21;
const fontForClass = {
  mathnormal: "Math-Italic",
  mathit: "Main-Italic",
  textit: "Main-Italic",
  mathbf: "Main-Bold",
  textbf: "Main-Bold",
  mathbb: "AMS-Regular",
  amsrm: "AMS-Regular",
  mathcal: "Caligraphic-Regular",
  mathfrak: "Fraktur-Regular",
  mathtt: "Typewriter-Regular",
  mathsf: "SansSerif-Regular",
};

function em(length) {
  if (length?.endsWith("em")) return Number.parseFloat(length);
  if (length?.endsWith("px")) return Number.parseFloat(length) / mathEmPx;
  return 0;
}

function mathWidth(node, scale = 1, font = "Main-Regular") {
  const classes = node.classes ?? [];
  const style = node.style ?? {};
  const reset = classes.find(name => /^reset-size\d+$/.test(name));
  const size = classes.find(name => /^size\d+$/.test(name));
  if (reset && size) scale *= sizeScale[Number(size.slice(4)) - 1] / sizeScale[Number(reset.slice(10)) - 1];
  for (const name of classes) font = fontForClass[name] ?? font;
  const spacing = em(style.marginLeft) + em(style.marginRight) + em(style.paddingLeft) + em(style.paddingRight);
  if (typeof node.text === "string") {
    const characters = [...node.text];
    const advance = characters.length <= 1 ? node.width : characters.reduce((sum, char) => {
      const point = char.codePointAt(0);
      const metrics = fontMetrics[font][point] ?? fontMetrics["Main-Regular"][point];
      return sum + (metrics?.[4] ?? (/\s/u.test(char) ? 0.25 : 1));
    }, 0);
    return (advance + Math.max(0, node.italic) + spacing) * scale;
  }
  if (classes.includes("vlist-s") || classes.includes("pstrut") || classes.includes("katex-strut")) return 0;
  const children = (node.children ?? []).map(child => mathWidth(child, scale, font));
  const vertical = classes.some(name => ["vlist", "vlist-t", "katex-vbox"].includes(name));
  const flow = vertical ? Math.max(0, ...children) : children.reduce((sum, width) => sum + width, 0);
  const explicit = classes.includes("nulldelimiter") ? 0.12 : em(style.width);
  return Math.max(flow, explicit * scale, em(style.minWidth) * scale) + scale * spacing;
}

function decodeTex(text) {
  const htmlEntities = { amp: "&", lt: "<", gt: ">", quot: '"', apos: "'" };
  return text.replace(/&(#x[\da-f]+|#\d+|\w+);/gi, (entity, code) => {
    if (code.startsWith("#x")) return String.fromCodePoint(Number.parseInt(code.slice(2), 16));
    if (code.startsWith("#")) return String.fromCodePoint(Number(code.slice(1)));
    return htmlEntities[code] ?? entity;
  });
}

function measureDisplays(entries, macros) {
  const widths = [];
  const displays = /<div class="math-display">[\s\S]*?<annotation encoding="application\/x-tex">([\s\S]*?)<\/annotation>/g;
  for (const { label, html } of entries) {
    const formulas = [...html.matchAll(displays)];
    assert.equal(formulas.length, html.match(/class="math-display"/g)?.length ?? 0, label);
    for (const [, annotation] of formulas) {
      const formula = decodeTex(annotation);
      const tree = katex.__renderToHTMLTree(formula, {
        displayMode: true, throwOnError: true, strict: "ignore", macros: { ...macros },
      });
      const width = mathWidth(tree) * mathEmPx;
      assert(Number.isFinite(width) && width > 0, label + " missing display metrics");
      widths.push({ label, formula, width });
    }
  }
  widths.sort((a, b) => b.width - a.width);
  assert(widths.length > 0);
  console.log("Widest displayed formulas (estimated from KaTeX metrics at 18 px body size):");
  for (const { label, formula, width } of widths.slice(0, 6)) {
    console.log("  " + width.toFixed(1) + " px  " + label + "  " + formula.replace(/\s+/g, " ").trim());
  }
  assert(widths[0].width <= 680, "A changed display exceeds the 680 px estimate");
}

const directory = mkdtempSync(join(tmpdir(), "ch2-fourier-"));
const databasePath = join(directory, "backup.sqlite");
const db = new DatabaseSync(databasePath, { enableForeignKeyConstraints: false });
try {
  db.exec("PRAGMA foreign_keys=OFF");
  db.exec(readFileSync(resolve(backupPath), "utf8"));
  db.exec("PRAGMA foreign_keys=ON");
  assert.deepEqual(db.prepare("PRAGMA foreign_key_check").all(), [], "Invalid backup");

  // Reject a stale proof revision before checking the supplied baseline.
  db.exec("UPDATE proofs SET revision=revision+1 WHERE id=117");
  checkGuard(db, databasePath);
  db.exec("UPDATE proofs SET revision=revision-1 WHERE id=117");
  const before = Object.fromEntries(Object.keys(tables).map(table => [table, keyById(records(db, table))]));
  apply(db);
  checkGuard(db, databasePath);
  console.log("Guard rejected both a stale baseline and a second application without writes");
  checkStructure(db);
  const { changedDisplays, macros } = checkContent(db, before);
  measureDisplays(changedDisplays, macros);
  console.log("ALL CHECKS PASSED");
} finally {
  db.close();
  rmSync(databasePath, { force: true });
  rmdirSync(directory);
}
