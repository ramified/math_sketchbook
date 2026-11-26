import assert from "node:assert/strict";
import { mkdtempSync, readFileSync, rmSync, rmdirSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { DatabaseSync } from "node:sqlite";
import katex from "katex";
import fontMetrics from "../../node_modules/katex/src/fontMetricsData.js";
import { buildMacros, findRefTargets, renderTex } from "../../src/latex.ts";

const timestamp = "2026-11-26 00:30:00";
const operation = "map-notation-2026-11-25";
const paths = process.argv.slice(2);
assert.equal(paths.length, 2, "Usage: node checker.mjs BACKUP.sql PATCH.sql");
const [backup, patch] = paths.map(path => readFileSync(path, "utf8"));
assert.match(patch.replace(/^(?:\s*--[^\r\n]*(?:\r?\n|$))+\s*/, ""), /^INSERT OR ROLLBACK INTO write_guard\b/i);
assert.doesNotMatch(patch, /^\s*(?:BEGIN|COMMIT|END TRANSACTION)\b/im);

const content = {
  sections: {
    entity: "section", tex: "intro_tex", cache: "intro_html_cache",
    ids: [105, 106, 107, 108, 109, 111, 112, 113, 114],
    snapshot: ["tag", "kind", "title", "intro_tex", "parent_id", "position"],
  },
  results: {
    entity: "result", tex: "statement_tex", cache: "statement_html_cache",
    ids: [127, 128, 130, 131, 153, 154, 157, 158, 159, 160, 161, 162, 163, 165, 167, 169, 170, 171],
    snapshot: ["tag", "type", "title", "statement_tex", "section_id", "position", "listed"],
  },
  proofs: {
    entity: "proof", tex: "body_tex", cache: "body_html_cache",
    ids: [112, 114, 117, 118, 132, 133, 134],
    snapshot: ["result_id", "body_tex", "status", "generated_by", "generator_detail",
      "reviewed_by", "review_notes", "position"],
  },
};
const otherTables = {
  tags: "tag", aliases: "alias", settings: "key", users: "email", reviews: "id", d1_migrations: "id",
};
const rows = (db, table, order = "id") => db.prepare("SELECT * FROM " + table + " ORDER BY " + order).all();
const keyed = (entries, key) => new Map(entries.map(row => [key(row), row]));
const revisionKey = row => JSON.stringify([row.entity, row.entity_key, row.revision]);

// Wrap the batch to model transactional application. The patch itself has no transaction commands.
function apply(db) {
  db.exec("BEGIN IMMEDIATE");
  try {
    db.exec(patch);
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
  assert.throws(() => apply(db), /CHECK constraint failed:.*ok\s*=\s*1/i, reason);
  assert.equal(totalChanges(), before, reason + " attempted a write");
  assert.deepEqual(readFileSync(databasePath), bytes, reason + " changed the database file");
  assert.equal(db.prepare("SELECT COUNT(*) AS n FROM write_guard").get().n, 0);
}

function captureBaseline(db) {
  return {
    ...Object.fromEntries(Object.keys(content).map(table => [table, keyed(rows(db, table), row => row.id)])),
    ...Object.fromEntries(Object.entries(otherTables).map(([table, order]) => [table, rows(db, table, order)])),
    refs: rows(db, "refs"),
    revisions: keyed(rows(db, "revisions"), revisionKey),
  };
}

function checkHistoryAndCaches(db, before) {
  const history = keyed(rows(db, "revisions"), revisionKey);
  const expectedHistory = new Set(before.revisions.keys());
  for (const [key, revision] of before.revisions) assert.deepEqual(history.get(key), revision, key);
  for (const [table, order] of Object.entries(otherTables)) assert.deepEqual(rows(db, table, order), before[table], table);
  assert.equal(db.prepare("SELECT value FROM settings WHERE key='needs_rebuild'").get().value, "1");

  for (const [table, { entity, tex, cache, ids, snapshot }] of Object.entries(content)) {
    const current = rows(db, table);
    assert.deepEqual(current.map(row => row.id), [...before[table].keys()], table + " IDs");
    const editable = new Set([tex, cache, "revision", "updated_by", "updated_at"]);
    if (table === "proofs") editable.add("generated_by");

    function checkSnapshot(version, currentVersion) {
      const key = revisionKey({ entity, entity_key: String(version.id), revision: version.revision });
      const revision = history.get(key);
      assert(revision, "Missing revision " + key);
      const expected = Object.fromEntries(snapshot.map(field => [field, version[field]]));
      if (table === "results") {
        expected.aliases = before.aliases.filter(row => row.tag === version.tag).map(row => row.alias).sort();
      }
      assert.deepEqual(JSON.parse(revision.snapshot_json), expected, key);
      if (currentVersion) assert(!before.revisions.has(key), "New revision already exists " + key);
      if (!before.revisions.has(key)) {
        const author = currentVersion ? "codex" : version.updated_by ?? "(before history)";
        assert.deepEqual([revision.operation_id, revision.author, revision.created_at], [operation, author, timestamp], key);
      }
      expectedHistory.add(key);
    }

    for (const row of current) {
      const old = before[table].get(row.id);
      const label = table + " " + row.id;
      if (!ids.includes(row.id)) {
        assert.deepEqual(row, old, label);
        continue;
      }
      assert.notEqual(row[tex], old[tex], label);
      assert.equal(row.revision, old.revision + 1, label);
      assert.equal(row[cache], null, label + " cache");
      assert.deepEqual([row.updated_by, row.updated_at], ["codex", timestamp], label);
      for (const field of Object.keys(old)) {
        if (!editable.has(field)) assert.equal(row[field], old[field], label + "." + field);
      }
      if (table === "proofs") assert.equal(row.generated_by, "gpt", label);
      checkSnapshot(old, false);
      checkSnapshot(row, true);
    }
  }
  assert.deepEqual(new Set(history.keys()), expectedHistory);
  const unaffected = edge => edge.source_proof_id === null
    ? !content.results.ids.includes(edge.source_result_id) : !content.proofs.ids.includes(edge.source_proof_id);
  assert.deepEqual(rows(db, "refs").filter(unaffected), before.refs.filter(unaffected));
  console.log("Verified snapshots, cache invalidation, and unchanged rows outside the patch");
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
  const owners = keyed(rows(db, "results"), row => row.id);
  const expectedEdges = [];
  const sets = [];
  const displays = [];
  let rendered = 0;

  for (const [table, { tex, ids }] of Object.entries(content)) {
    for (const row of rows(db, table)) {
      const owner = table === "proofs" ? owners.get(row.result_id) : row;
      const inScope = scope.has(table === "sections" ? row.id : owner.section_id);
      const suffix = table === "proofs" ? " proof " + row.id : table === "results" ? " statement" : " intro";
      if (!inScope) assert(!ids.includes(row.id), "Unexpected edit outside Chapters 2 and 3");
      for (const field of row.title === undefined ? [tex] : [tex, "title"]) {
        const label = owner.tag + (field === "title" ? " title" : suffix);
        const source = row[field];
        const out = renderTex(source, macros);
        assert.deepEqual(out.warnings, [], label + " render warnings");
        rendered++;
        for (const target of new Set([...out.refs, ...findRefTargets(source).map(ref => ref.target)])) {
          assert(tags.has(aliases.get(target) ?? target), label + " missing reference " + target);
        }
        if (field === tex && table !== "sections") {
          for (const target of out.refs) {
            expectedEdges.push(JSON.stringify([owner.id, table === "proofs" ? row.id : null, target]));
          }
        }
        if (inScope) {
          assert.doesNotMatch(source, /\\(?:tag|log)\b/, label);
          sets.push(...scanSets(source).map(set => ({ ...set, label })));
          displays.push({ label, html: out.html });
        }
      }
    }
  }

  const actualEdges = rows(db, "refs").map(row => JSON.stringify([row.source_result_id, row.source_proof_id, row.target_tag]));
  assert.deepEqual(actualEdges.sort(), expectedEdges.sort(), "Stored statement and proof reference edges");
  assert.deepEqual(sets.filter(set => set.kind === "legacy"), [], "Noncanonical set builders in Chapters 2 and 3");
  assert.deepEqual(sets.filter(set => set.kind === "canonical").map(set => set.label).sort(),
    ["8JUW statement", "8JUW statement", "8JVC statement", "8JVK statement", "8JVP statement"]);
  console.log("Verified all reference targets, stored edges, and the five canonical set builders in Chapters 2 and 3");
  console.log("Rendered " + rendered + " book text fields with 0 warnings");
  return displays;
}

function checkDefinitions(db, before) {
  const result = tag => db.prepare("SELECT statement_tex AS tex FROM results WHERE tag=?").get(tag).tex;
  const count = result("8JU9");
  assert.match(count, /For any \$t\\in A\$[\s\S]*?\\\[\s*p_t\\colon B\\setminus\\Phi\s+\\longrightarrow\s+\\Phi,\s*\\qquad g\\longmapsto g\+\(\(1,1\),t\)\.\s*\\\]/);
  assert.match(count, /For any function \$w\$[\s\S]*?\\\[\s*\\begin\{aligned\}\s*w&\\colon\\Phi\\longrightarrow\(0,\\infty\)[\s\S]*?w_\\alpha&=w\(\\alpha\)\\qquad\(\\alpha\\in\\Phi\)/);
  assert.match(count, /For any real \$a>0\$, define[\s\S]+triples \$\(t,a,w\)\$[\s\S]+pairs \$\(a,w\)\$/);
  assert(count.includes(String.raw`$v_+=\max(v,0)$ for real $v$`));
  const expansion = result("8JVD");
  assert.match(expansion, /For any \$t,a,w\$ as in \\ref\{8JU9\} with \$w_\\alpha\\le a\$ for every \$\\alpha\\in\\Phi\$/);
  assert.match(expansion, /w\\circ p_t\\colon B\\setminus\\Phi\\longrightarrow\(0,\\infty\),\s*\\qquad g\\longmapsto w_g=w_\{p_t\(g\)\}/);
  const mathBlock = /\\begin\{align\*\}[\s\S]+?\\end\{align\*\}/;
  assert.equal(count.match(mathBlock)?.[0], before.results.get(128).statement_tex.match(mathBlock)[0], "Count and main term");
  const fourierIdentity = /\\\[\s*S\(t,a,w\)[\s\S]+?\\\]/;
  assert.equal(expansion.match(fourierIdentity)?.[0], before.results.get(161).statement_tex.match(fourierIdentity)[0], "Fourier identity");
  const intro = db.prepare("SELECT intro_tex AS tex FROM sections WHERE tag='8JV7'").get().tex;
  assert.match(intro, /\\ref\{8JU9\}[\s\S]+bijection from \$B\\setminus\\Phi\$ to \$\\Phi\$/);
  assert.match(intro, /\\ref\{8JU9\} and the Fourier expansion in \\ref\{8JVD\} allow arbitrary positive weight functions[\s\S]+?\\ref\{8JVK\} in §2\.3 supplies/);
  assert.doesNotMatch(result("8JVE"), /\\\][^\S\r\n]+\S/);
  console.log("Verified the displayed 8JU9 maps, the 8JVD weight bound, and the original count and Fourier formulas");
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
  assert(widths[0].width <= 680, "A Chapter 2 or 3 display exceeds the 680 px estimate");
}

const directory = mkdtempSync(join(tmpdir(), "map-notation-"));
const databasePath = join(directory, "baseline.sqlite");
try {
  const db = new DatabaseSync(databasePath, { enableForeignKeyConstraints: false });
  try {
    db.exec("PRAGMA foreign_keys=OFF");
    db.exec(backup);
    db.exec("PRAGMA foreign_keys=ON");
    assert.deepEqual(db.prepare("PRAGMA foreign_key_check").all(), []);
    const before = captureBaseline(db);
    for (const [table, { ids }] of Object.entries(content)) {
      const setRevision = db.prepare("UPDATE " + table + " SET revision=? WHERE id=?");
      for (const id of ids) {
        const { revision } = before[table].get(id);
        setRevision.run(revision + 1, id);
        checkRejection(db, databasePath, "Stale " + table + " " + id);
        setRevision.run(revision, id);
      }
    }
    // Force a rebuild flag transition on the temporary copy.
    db.exec("UPDATE settings SET value = '0' WHERE key = 'needs_rebuild'");
    apply(db);
    checkRejection(db, databasePath, "Repeated application");
    console.log("Guard rejected every stale row revision and reapplication without writes");

    checkHistoryAndCaches(db, before);
    const { macros, error } = buildMacros(db.prepare("SELECT value FROM settings WHERE key='macros'").get().value);
    assert.equal(error, undefined);
    const displays = checkSources(db, before, macros);
    checkDefinitions(db, before);
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
