import assert from "node:assert/strict";
import { mkdtempSync, readFileSync, rmSync, rmdirSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { DatabaseSync } from "node:sqlite";
import katex from "katex";
import fontMetrics from "../../node_modules/katex/src/fontMetricsData.js";
import { buildMacros, findRefTargets, renderTex } from "../../src/latex.ts";
import { TAG_ALPHABET } from "../../src/tags.ts";

const timestamp = "2026-11-25 23:00:00";
const operation = "prime-classes-definition-2026-11-25";
const paths = process.argv.slice(2);
assert.equal(paths.length, 3, "Usage: node checker.mjs BACKUP.sql COSET.sql PRIME-CLASSES.sql");
const [backup, coset, patch] = paths.map(path => readFileSync(path, "utf8"));
assert.match(patch.replace(/^(?:\s*--[^\r\n]*(?:\r?\n|$))+\s*/, ""), /^INSERT OR ROLLBACK INTO write_guard\b/i);
assert.doesNotMatch(patch, /^\s*(?:BEGIN|COMMIT|END TRANSACTION)\b/im);

const content = {
  sections: {
    entity: "section", tex: "intro_tex", cache: "intro_html_cache", ids: [113],
    snapshot: ["tag", "kind", "title", "intro_tex", "parent_id", "position"],
  },
  results: {
    entity: "result", tex: "statement_tex", cache: "statement_html_cache",
    ids: [126, 128, 131, 153, 160, 161, 162, 167, 168, 170, 171],
    snapshot: ["tag", "type", "title", "statement_tex", "section_id", "position", "listed"],
  },
  proofs: {
    entity: "proof", tex: "body_tex", cache: "body_html_cache", ids: [117],
    snapshot: ["result_id", "body_tex", "status", "generated_by", "generator_detail",
      "reviewed_by", "review_notes", "position"],
  },
};
const resultMetadataEdits = new Map([[128, "position"], [160, "title"], [161, "position"], [168, "position"]]);
const definitionRefs = new Map([
  ["8JV7 intro", ["8JVC", "8JVP", "8JVQ"]],
  ["8JU7 statement", ["8JVC", "8JVP"]],
  ["8JU9 statement", ["8JVC", "8JVP", "8JVQ"]],
  ["8JUC statement", ["8JVP", "8JVQ"]],
  ["8JUW statement", ["8JVQ"]],
  ["8JVP statement", ["8JVC"]],
  ["8JVQ statement", ["8JVC", "8JVP"]],
  ["8JVD statement", ["8JVP", "8JVQ"]],
  ["8JVE statement", ["8JVC", "8JVP"]],
  ["8JVK statement", ["8JVC", "8JVP"]],
  ["8JVM statement", ["8JVC", "8JVP", "8JVQ"]],
  ["8JUD proof 117", ["8JVC", "8JVP"]],
]);
const definitionTags = new Set(["8JVC", "8JVP", "8JVQ"]);
const rows = (db, table, order = "id") => db.prepare("SELECT * FROM " + table + " ORDER BY " + order).all();
const keyed = (entries, key) => new Map(entries.map(row => [key(row), row]));
const revisionKey = row => JSON.stringify([row.entity, row.entity_key, row.revision]);

function apply(db, sql) {
  db.exec("BEGIN IMMEDIATE");
  try {
    db.exec(sql);
    db.exec("COMMIT");
  } catch (error) {
    if (db.isTransaction) db.exec("ROLLBACK");
    throw error;
  }
}

function checkRejection(db, databasePath, reason) {
  const bytes = readFileSync(databasePath);
  const totalChanges = () => db.prepare("SELECT total_changes() AS n").get().n;
  const before = totalChanges();
  assert.throws(() => apply(db, patch), /CHECK constraint failed:.*ok\s*=\s*1/i, reason);
  assert.equal(totalChanges(), before, reason + " attempted a write");
  assert.deepEqual(readFileSync(databasePath), bytes, reason + " changed the database file");
  assert.equal(db.prepare("SELECT COUNT(*) AS n FROM write_guard").get().n, 0);
}

function captureBaseline(db) {
  return {
    ...Object.fromEntries(Object.keys(content).map(table => [table, keyed(rows(db, table), row => row.id)])),
    tags: rows(db, "tags", "tag"),
    aliases: rows(db, "aliases", "alias"),
    settings: rows(db, "settings", "key"),
    refs: rows(db, "refs"),
    revisions: keyed(rows(db, "revisions"), revisionKey),
  };
}

function checkLayout(db, before) {
  const layout = db.prepare("SELECT tag, position, type, listed FROM results WHERE section_id=113 ORDER BY position").all();
  assert.deepEqual(layout.map(row => Object.values(row)), [
    ["8JVC", 1, "definition", 1],
    ["8JVP", 2, "definition", 1],
    ["8JVQ", 3, "definition", 1],
    ["8JU9", 4, "definition", 1],
    ["8JVD", 5, "lemma", 1],
    ["8JVM", 6, "example", 0],
  ]);
  const oldMaxTag = before.tags.at(-1).tag;
  const next = TAG_ALPHABET.indexOf(oldMaxTag.at(-1)) + 1;
  const newTags = ["8JVP", "8JVQ"];
  assert.deepEqual(newTags, [...TAG_ALPHABET.slice(next, next + 2)].map(char => oldMaxTag.slice(0, -1) + char));
  const tags = rows(db, "tags", "tag");
  assert.deepEqual(tags.slice(0, -2), before.tags);
  assert.deepEqual(tags.slice(-2).map(row => ({ ...row })),
    newTags.map(tag => ({ tag, kind: "result", created_at: timestamp })));
  const maxResult = Math.max(...before.results.keys());
  const added = db.prepare("SELECT id, tag, visibility, state FROM results WHERE id>? ORDER BY id").all(maxResult);
  assert.deepEqual(added.map(row => Object.values(row)), newTags.map((tag, i) =>
    [maxResult + i + 1, tag, "published", "active"]));
}

function checkHistoryAndCaches(db, before) {
  const history = keyed(rows(db, "revisions"), revisionKey);
  const expectedNewHistory = new Set();
  for (const [key, revision] of before.revisions) assert.deepEqual(history.get(key), revision, key);
  assert.deepEqual(rows(db, "aliases", "alias"), before.aliases);
  assert.deepEqual(rows(db, "settings", "key"), before.settings);
  assert.equal(db.prepare("SELECT value FROM settings WHERE key='needs_rebuild'").get().value, "1");

  for (const [table, config] of Object.entries(content)) {
    const { entity, tex, cache, ids, snapshot } = config;
    const current = keyed(rows(db, table), row => row.id);
    for (const id of before[table].keys()) assert(current.has(id), table + " lost " + id);
    const changed = [];
    const checkRevision = (version, isNewVersion) => {
      const key = revisionKey({ entity, entity_key: String(version.id), revision: version.revision });
      const revision = history.get(key);
      assert(revision, "Missing revision " + key);
      const expected = Object.fromEntries(snapshot.map(field => [field, version[field]]));
      if (table === "results") {
        expected.aliases = before.aliases.filter(row => row.tag === version.tag).map(row => row.alias).sort();
      }
      assert.deepEqual(JSON.parse(revision.snapshot_json), expected, key);
      if (!before.revisions.has(key)) {
        const author = isNewVersion ? "codex" : version.updated_by ?? "(before history)";
        assert.deepEqual([revision.operation_id, revision.author, revision.created_at], [operation, author, timestamp], key);
        expectedNewHistory.add(key);
      } else {
        assert(!isNewVersion, "New version already in baseline history " + key);
      }
    };
    for (const [id, row] of current) {
      const old = before[table].get(id);
      if (old && JSON.stringify(old) === JSON.stringify(row)) continue;
      changed.push(id);
      const label = table + " " + id;
      assert.notEqual(row[tex], old?.[tex], label);
      assert.equal(row.revision, old ? old.revision + 1 : 1, label);
      assert.equal(row[cache], null, label + " cache");
      assert.deepEqual([row.updated_by, row.updated_at], ["codex", timestamp], label);
      if (old) {
        const editable = new Set([tex, cache, "revision", "updated_by", "updated_at"]);
        if (table === "results") editable.add(resultMetadataEdits.get(id));
        for (const field of Object.keys(old)) {
          if (!editable.has(field)) assert.equal(row[field], old[field], label + "." + field);
        }
        checkRevision(old, false);
      } else {
        assert.deepEqual([row.created_by, row.created_at], ["codex", timestamp], label);
      }
      if (table === "proofs") assert.equal(row.generated_by, "gpt", label);
      checkRevision(row, true);
    }
    assert.deepEqual(changed, ids, table + " changed row IDs");
  }

  assert.deepEqual([...history.keys()].filter(key => !before.revisions.has(key)).sort(), [...expectedNewHistory].sort());
  const unaffected = edge => edge.source_proof_id === null
    ? !content.results.ids.includes(edge.source_result_id) : !content.proofs.ids.includes(edge.source_proof_id);
  assert.deepEqual(rows(db, "refs").filter(unaffected), before.refs.filter(unaffected));
  console.log("Verified revision snapshots, cache invalidation, and 11 updated rows plus 2 new definitions");
}

// Scan balanced escaped set braces. Ordinary TeX groups and nested sets can
// contain colons or bars of their own, so only compare tokens at the set's depth.
function scanSets(tex) {
  const tokens = /\\left\s*\\\{|\\right\s*(?:\\\}|\.)|\\left\s*\||\\right\s*\||\\middle\s*\||\\[A-Za-z]+|\\[^\r\n]|[{}:|]/g;
  const sets = [];
  const open = [];
  let depth = 0;
  for (const match of tex.matchAll(tokens)) {
    const [token] = match;
    const active = open.at(-1);
    if (token.endsWith("\\{")) {
      open.push({ start: match.index, depth, left: token, separators: [] });
    } else if (token === "\\}" || token.startsWith("\\right") && /(?:\\\}|\.)$/.test(token)) {
      if (active && depth === active.depth) {
        open.pop();
        if (token.endsWith("\\}")) {
          const source = tex.slice(active.start, match.index + token.length);
          const kind = active.separators.length === 0 ? "enumerated"
            : active.left === "\\left\\{" && token === "\\right\\}" &&
                active.separators.length === 1 && active.separators[0] === "\\middle|" &&
                source.includes("\\;\\middle|\\;") ? "canonical" : "legacy";
          sets.push({ source, kind });
        }
      }
    } else if (token === "{") {
      depth++;
    } else if (token === "}") {
      depth--;
    } else if (active && depth === active.depth && /^(?::|\||\\(?:colon|mid|middle\s*\|))$/.test(token)) {
      // A subscripted bar denotes restriction, as in \xi|_{A_0}.
      if (token === "|" && /^\s*_/.test(tex.slice(match.index + 1))) continue;
      active.separators.push(token);
    }
  }
  return sets;
}

function checkSources(db, before, macros) {
  const scope = new Set(db.prepare(
    "WITH RECURSIVE chapter(id) AS (SELECT id FROM sections WHERE kind='chapter' AND position IN (2,3) " +
    "UNION ALL SELECT s.id FROM sections s JOIN chapter c ON s.parent_id=c.id) SELECT id FROM chapter"
  ).all().map(row => row.id));
  assert.deepEqual([...scope].sort((a, b) => a - b), [105, 106, 107, 108, 109, 111, 112, 113, 114]);
  const tags = new Set(rows(db, "tags", "tag").map(row => row.tag));
  const aliases = new Map(before.aliases.map(row => [row.alias, row.tag]));
  const ownerResults = keyed(rows(db, "results"), row => row.id);
  const seenDefinitionRefs = new Map();
  const oldSets = [];
  const newSets = [];
  const refs = [];
  const displays = [];
  let rendered = 0;
  for (const [table, { tex, ids }] of Object.entries(content)) {
    for (const row of rows(db, table)) {
      const owner = row.result_id ? ownerResults.get(row.result_id) : row;
      const label = owner.tag + (table === "proofs" ? " proof " + row.id
        : table === "results" ? " statement" : " intro");
      const inScope = scope.has(owner.section_id ?? owner.id);
      const old = before[table].get(row.id);
      const fields = row.title === undefined ? [tex] : [tex, "title"];
      for (const field of fields) {
        const sourceLabel = field === "title" ? owner.tag + " title" : label;
        const source = row[field];
        const out = renderTex(source, macros);
        const targets = new Set([...out.refs, ...findRefTargets(source).map(ref => ref.target)]);
        assert.deepEqual(out.warnings, [], sourceLabel + " render warnings");
        rendered++;
        for (const target of targets) assert(tags.has(aliases.get(target) ?? target), sourceLabel + " missing " + target);
        const definitionLinks = [...targets].filter(target => definitionTags.has(target)).sort();
        if (definitionLinks.length) seenDefinitionRefs.set(sourceLabel, definitionLinks);

        if (inScope) {
          newSets.push(...scanSets(source).map(set => ({ ...set, label: sourceLabel })));
          if (old) oldSets.push(...scanSets(old[field]).map(set => ({ ...set, label: sourceLabel })));
        }
        if (field === tex && table !== "sections") {
          for (const target of out.refs) refs.push(JSON.stringify([owner.id, row.result_id ? row.id : null, target]));
        }
        if (ids.includes(row.id)) {
          assert.doesNotMatch(source, /\\(?:tag|log)\b/, sourceLabel);
          displays.push({ label: sourceLabel, html: out.html });
        }
      }
    }
  }
  assert.deepEqual(seenDefinitionRefs, definitionRefs, "Reference routing for the three definitions");
  const actualRefs = rows(db, "refs").map(row => JSON.stringify([row.source_result_id, row.source_proof_id, row.target_tag]));
  assert.deepEqual(actualRefs.sort(), refs.sort(), "Stored statement and proof edges");

  const labels = (sets, kind) => sets.filter(set => set.kind === kind).map(set => set.label).sort();
  assert.deepEqual(labels(oldSets, "legacy"), ["8JUW statement", "8JUW statement", "8JVC statement", "8JVK statement"]);
  assert.deepEqual(newSets.filter(set => set.kind === "legacy"), [], "Noncanonical set builders in Chapters 2 and 3");
  assert.deepEqual(labels(newSets, "canonical"),
    ["8JUW statement", "8JUW statement", "8JVC statement", "8JVK statement", "8JVP statement"]);
  const enumerations = sets => sets.filter(set => set.kind === "enumerated").map(set => set.source).sort();
  assert.deepEqual(enumerations(newSets), enumerations(oldSets), "Enumerated sets in Chapters 2 and 3");
  console.log("Verified 5 canonical set builders in Chapters 2 and 3, reference targets and stored edges");
  console.log("Rendered " + rendered + " book text fields with 0 warnings");
  return displays;
}

function checkExample(db, before, macros) {
  const old = before.results.get(168);
  const updated = db.prepare("SELECT * FROM results WHERE id=168").get();
  const math = source => [...renderTex(source, macros).html.matchAll(
    /<annotation encoding="application\/x-tex">([\s\S]*?)<\/annotation>/g
  )].map(match => match[1]);
  const numbers = source => source.replace(/\\ref\{[^}]+\}/g, "").match(/\d+/g);
  assert.deepEqual(math(updated.statement_tex), math(old.statement_tex), "8JVM mathematical expressions");
  assert.deepEqual(numbers(updated.statement_tex), numbers(old.statement_tex), "8JVM numbers");
  const residue = db.prepare("SELECT statement_tex FROM results WHERE tag='8JVC'").get().statement_tex;
  assert.match(residue, /\\\[\s*U_1=\\left\\\{[\s\S]*?\\;\\middle\|\\;[\s\S]*?\\right\\\}\.\s*\\\]/);
  console.log("Verified displayed U_1 and all existing numerical and mathematical expressions in 8JVM");
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

const directory = mkdtempSync(join(tmpdir(), "prime-classes-"));
const databasePath = join(directory, "baseline.sqlite");
try {
  const db = new DatabaseSync(databasePath, { enableForeignKeyConstraints: false });
  try {
    db.exec("PRAGMA foreign_keys=OFF");
    db.exec(backup);
    db.exec("PRAGMA foreign_keys=ON");
    assert.deepEqual(db.prepare("PRAGMA foreign_key_check").all(), []);
    checkRejection(db, databasePath, "Pre-coset backup");
    apply(db, coset);
    const before = captureBaseline(db);
    for (const [table, { ids }] of Object.entries(content)) {
      const setRevision = db.prepare("UPDATE " + table + " SET revision=? WHERE id=?");
      for (const id of ids) {
        const row = before[table].get(id);
        if (!row) continue;
        setRevision.run(row.revision + 1, id);
        checkRejection(db, databasePath, "Stale " + table + " " + id);
        setRevision.run(row.revision, id);
      }
    }
    apply(db, patch);
    checkRejection(db, databasePath, "Repeated application");
    console.log("Guard rejected the pre-coset backup, each stale revision, and reapplication without writes");

    checkLayout(db, before);
    checkHistoryAndCaches(db, before);
    const { macros, error } = buildMacros(db.prepare("SELECT value FROM settings WHERE key='macros'").get().value);
    assert.equal(error, undefined);
    const displays = checkSources(db, before, macros);
    checkExample(db, before, macros);
    measureDisplays(displays, macros);
    assert.deepEqual(db.prepare("PRAGMA foreign_key_check").all(), []);
    assert.equal(db.prepare("PRAGMA integrity_check").get().integrity_check, "ok");
  } finally {
    db.close();
  }
} finally {
  rmSync(databasePath, { force: true });
  rmdirSync(directory);
}
console.log("ALL CHECKS PASSED");
