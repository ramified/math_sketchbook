import assert from "node:assert/strict";
import { mkdtempSync, readFileSync, rmSync, rmdirSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { DatabaseSync } from "node:sqlite";
import katex from "katex";
import fontMetrics from "../../node_modules/katex/src/fontMetricsData.js";
import { buildMacros, findRefTargets, renderTex } from "../../src/latex.ts";
import { TAG_ALPHABET } from "../../src/tags.ts";

const timestamp = "2026-11-25 22:00:00";
const operation = "coset-average-general-2026-11-25";
const [backupPath, sqlPath] = process.argv.slice(2);
assert(backupPath && sqlPath, "Usage: node checker.mjs BACKUP.sql PATCH.sql");
const sql = readFileSync(sqlPath, "utf8");
assert.match(sql.replace(/^(?:\s*--[^\r\n]*(?:\r?\n|$))+\s*/, ""), /^INSERT OR ROLLBACK INTO write_guard\b/i);
assert.doesNotMatch(sql, /^\s*(?:BEGIN|COMMIT|END TRANSACTION)\b/im);

const content = {
  sections: {
    entity: "section", tex: "intro_tex", cache: "intro_html_cache", ids: [112, 114],
    snapshot: ["tag", "kind", "title", "intro_tex", "parent_id", "position"],
  },
  results: {
    entity: "result", tex: "statement_tex", cache: "statement_html_cache", ids: [126, 158, 159, 162, 169],
    snapshot: ["tag", "type", "title", "statement_tex", "section_id", "position", "listed"],
  },
  proofs: {
    entity: "proof", tex: "body_tex", cache: "body_html_cache", ids: [117, 133, 139],
    snapshot: ["result_id", "body_tex", "status", "generated_by", "generator_detail",
      "reviewed_by", "review_notes", "position"],
  },
};
const rows = (db, table) => db.prepare("SELECT * FROM " + table + " ORDER BY id").all();

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

function checkGuard(db, databasePath) {
  const bytes = readFileSync(databasePath);
  const changes = () => db.prepare("SELECT total_changes() AS n").get().n;
  const before = changes();
  assert.throws(() => apply(db), /CHECK constraint failed:.*ok\s*=\s*1/i);
  assert.equal(changes(), before, "Guard rejection attempted a write");
  assert.deepEqual(readFileSync(databasePath), bytes, "Guard rejection changed the database file");
  assert.equal(db.prepare("SELECT COUNT(*) AS n FROM write_guard").get().n, 0);
}

function checkInsertion(db, before, oldTags) {
  const section = db.prepare("SELECT id FROM sections WHERE tag='8JV6'").get().id;
  const layout = db.prepare("SELECT id, tag, position, listed, type, visibility, state FROM results WHERE section_id=? ORDER BY position").all(section);
  assert.deepEqual(layout.map(row => [row.tag, row.position]), [["8JV9", 1], ["8JVA", 2], ["8JVB", 3], ["8JVN", 4]]);
  const [, , original, example] = layout;
  assert.equal(example.id, Math.max(...before.results.keys()) + 1);
  for (const field of ["type", "listed", "visibility", "state"]) assert.equal(example[field], original[field]);
  const proofs = db.prepare("SELECT id, position, visibility FROM proofs WHERE result_id=?").all(example.id);
  assert.deepEqual(proofs.map(row => [row.id, row.position, row.visibility]),
    [[Math.max(...before.proofs.keys()) + 1, 1, "published"]]);

  const maxTag = oldTags.at(-1).tag;
  const nextTag = maxTag.slice(0, -1) + TAG_ALPHABET[TAG_ALPHABET.indexOf(maxTag.at(-1)) + 1];
  assert.equal(example.tag, nextTag);
  const tags = db.prepare("SELECT * FROM tags ORDER BY tag").all();
  assert.deepEqual(tags.slice(0, -1), oldTags);
  assert.deepEqual({ ...tags.at(-1) }, { tag: nextTag, kind: "result", created_at: timestamp });
}

function checkChanges(db, before) {
  const { macros, error } = buildMacros(db.prepare("SELECT value FROM settings WHERE key='macros'").get().value);
  assert.equal(error, undefined);
  const tags = new Set(db.prepare("SELECT tag FROM tags").all().map(row => row.tag));
  const aliases = new Map(db.prepare("SELECT alias, tag FROM aliases").all().map(row => [row.alias, row.tag]));
  const ownerTags = new Map(rows(db, "results").map(row => [row.id, row.tag]));
  const revisionAt = db.prepare("SELECT * FROM revisions WHERE entity=? AND entity_key=? AND revision=?");
  const displays = [];
  const refs = [];
  const specializations = [];
  for (const [table, config] of Object.entries(content)) {
    const { entity, tex, cache, ids, snapshot } = config;
    const current = rows(db, table);
    assert(current.length >= before[table].size);
    const currentIds = new Set(current.map(row => row.id));
    assert([...before[table].keys()].every(id => currentIds.has(id)), table + " lost a row");
    const changed = [];
    for (const row of current) {
      const ownerTag = row.tag ?? ownerTags.get(row.result_id);
      const label = row.tag ?? ownerTag + " proof " + row.id;
      const out = renderTex(row[tex], macros);
      const targets = new Set([...out.refs, ...[row[tex], row.title ?? ""].flatMap(source =>
        findRefTargets(source).map(ref => ref.target))]);
      for (const target of targets) assert(tags.has(aliases.get(target) ?? target), label + " lacks target " + target);
      if (targets.has("8JVA")) {
        specializations.push(label);
        assert(row[tex].includes(ownerTag === "8JVN" ? "$k=1$" : "$k=3$"), label + " does not specify k");
      }
      if (table !== "sections") {
        for (const target of out.refs) refs.push(JSON.stringify([row.result_id ?? row.id, row.result_id ? row.id : null, target]));
      }

      const old = before[table].get(row.id);
      if (old && JSON.stringify(old) === JSON.stringify(row)) continue;
      changed.push(row.id);
      assert.notEqual(row[tex], old?.[tex], label + " text did not change");
      assert.equal(row.revision, old ? old.revision + 1 : 1, label);
      assert.equal(row[cache], null, label + " cache");
      assert.equal(row.updated_at, timestamp, label);
      assert.equal(row.updated_by, "codex", label);
      if (old) {
        const updateFields = new Set([tex, cache, "revision", "updated_at", "updated_by"]);
        for (const key of Object.keys(old)) {
          if (!updateFields.has(key)) assert.equal(row[key], old[key], label + "." + key);
        }
      } else {
        assert.equal(row.created_at, timestamp, label);
        assert.equal(row.created_by, "codex", label);
      }
      if (table === "proofs") assert.equal(row.generated_by, "gpt", label);
      const expectedSnapshot = version => Object.fromEntries([
        ...snapshot.map(key => [key, version[key]]),
        ...(table === "results" ? [["aliases", [...aliases].filter(([, tag]) => tag === version.tag)
          .map(([alias]) => alias).sort()]] : []),
      ]);
      const revision = revisionAt.get(entity, String(row.id), row.revision);
      assert(revision, label + " missing new revision");
      assert.deepEqual([revision.operation_id, revision.author, revision.created_at], [operation, "codex", timestamp], label);
      assert.deepEqual(JSON.parse(revision.snapshot_json), expectedSnapshot(row), label + " new snapshot");
      if (old) {
        const baseline = revisionAt.get(entity, String(row.id), old.revision);
        assert(baseline, label + " missing baseline revision");
        assert.deepEqual(JSON.parse(baseline.snapshot_json), expectedSnapshot(old), label + " baseline snapshot");
      }
      assert.deepEqual(out.warnings, [], label + " TeX warnings");
      if (row.title) assert.deepEqual(renderTex(row.title, macros).warnings, [], label + " title warnings");
      assert.doesNotMatch(row[tex], /\\(?:tag|log)\b/, label);
      displays.push({ label, html: out.html });
    }
    assert.deepEqual(changed, ids, table + " changed rows");
  }
  assert.deepEqual(specializations.sort(), ["8JUD proof 117", "8JU7", "8JV6", "8JV8", "8JVB", "8JVE", "8JVN"].sort());
  const actualRefs = db.prepare("SELECT source_result_id, source_proof_id, target_tag FROM refs").all()
    .map(row => JSON.stringify([row.source_result_id, row.source_proof_id, row.target_tag]));
  assert.deepEqual(actualRefs.sort(), refs.sort(), "refs differs from rendered statements and proofs");
  assert.deepEqual(db.prepare("PRAGMA foreign_key_check").all(), []);
  assert.equal(db.prepare("PRAGMA integrity_check").get().integrity_check, "ok");
  assert.equal(db.prepare("SELECT value FROM settings WHERE key='needs_rebuild'").get().value, "1");
  const lemma = db.prepare("SELECT statement_tex FROM results WHERE tag='8JVA'").get().statement_tex;
  assert.match(lemma, /\\\[\s*c_k\(\\xi\)=\\begin\{cases\}[\s\S]*?\\end\{cases\}\s*\\\]/);
  console.log("Validated all reference targets and stored edges, revision snapshots, and 10 changed rows with 0 TeX warnings");
  return { displays, macros };
}

function capture(source, pattern) {
  const match = source.match(pattern);
  assert(match, "Missing numerical claim: " + pattern.source);
  return match.slice(1);
}

function tuple(source) {
  return source.split(",").map(value => Number(value.trim()));
}

function checkRatio(tex, numerator, denominator, squared = false) {
  const [root, integer, divisor = "1"] = capture(tex, /^(?:\\sqrt\{(\d+)\}|(-?\d+))(?:\/(\d+))?$/);
  const d = Number(divisor);
  assert(d > 0, tex);
  if (squared) {
    if (root === undefined) assert(Number(integer) >= 0, tex);
    const nSquared = root === undefined ? Number(integer) ** 2 : Number(root);
    assert.equal(nSquared * denominator, numerator * d ** 2, tex);
  } else {
    assert.equal(root, undefined, tex);
    assert.equal(Number(integer) * denominator, numerator * d, tex);
  }
}

function checkComplex(tex, real, imaginary, denominator) {
  if (imaginary === 0) {
    checkRatio(tex, real, denominator);
    return;
  }
  const [r, sign, magnitude, d] = capture(tex, /^\((-?\d+)([+-])(\d*)i\)\/(\d+)$/);
  assert.equal(Number(r) * denominator, real * Number(d), tex);
  assert.equal((sign === "-" ? -1 : 1) * Number(magnitude || 1) * denominator, imaginary * Number(d), tex);
}

function checkExample(db) {
  const statement = db.prepare("SELECT statement_tex FROM results WHERE tag='8JVN'").get().statement_tex;
  const proof = db.prepare("SELECT body_tex FROM proofs WHERE result_id=169").get().body_tex;
  const [order, generator, subgroupModulus, k, index] = capture(statement,
    /A=\\Z\/(\d+)\\Z\$.*A_0=(\d+)\\Z\/(\d+)\\Z\$.*\$k=(\d+)\$.*\$o=(\d+)\$/).map(Number);
  const [set] = capture(statement, /T=\\\{([0-9,\\ ]+)\\\}/);
  const shifts = tuple(set.replaceAll("\\", ""));
  assert.equal(shifts.length, 10);
  assert.equal(new Set(shifts).size, shifts.length);
  assert(shifts.every(t => Number.isInteger(t) && t >= 0 && t < order));
  assert.equal(subgroupModulus, order);
  assert.equal(k, 1);

  const group = Array.from({ length: order }, (_, i) => i);
  const subgroup = group.filter(t => t % generator === 0);
  const cosets = [];
  const covered = new Set();
  for (const t of group) {
    if (covered.has(t)) continue;
    const coset = new Set(subgroup.map(u => (t + u) % order));
    cosets.push(coset);
    for (const u of coset) covered.add(u);
  }
  assert.equal(order / subgroup.length, index);
  assert.equal(cosets.length, index);
  const [residues, modulus] = capture(statement, /residues \$([\d,]+)\$ modulo \$(\d+)\$/);
  assert.equal(Number(modulus), index);
  const representatives = cosets.map(coset => Math.min(...coset));
  assert.deepEqual(tuple(residues), representatives);
  const counts = setItems => cosets.map(coset => setItems.filter(t => coset.has(t)).length);
  const targetWeights = cosets.map(coset => k + Number(coset.has(0)));
  const targetTotal = targetWeights.reduce((sum, weight) => sum + weight, 0);
  const size = shifts.length;
  const [actualDen, actualNumerators, targetDen, targetNumerators] = capture(statement,
    /\\mu_C\)_C=\\frac1\{(\d+)\}\(([\d,]+)\),\\qquad\s*\(\\lambda_C\)_C=\\frac1(\d+)\(([\d,]+)\)/);
  assert.deepEqual([Number(actualDen), tuple(actualNumerators)], [size, counts(shifts)]);
  assert.deepEqual([Number(targetDen), tuple(targetNumerators)], [targetTotal, targetWeights]);

  const scale = size * targetTotal;
  const deviations = setItems => counts(setItems).map((count, i) => count * targetTotal - targetWeights[i] * size);
  const r = Math.max(...deviations(shifts).map(Math.abs));
  const [rTex, boundTex] = capture(statement, /r=\\max_C\|\\mu_C-\\lambda_C\|=(\d+\/\d+)\$.*o \\cdot r=(\d+\/\d+)\$/);
  assert(r > 0);
  checkRatio(rTex, r, scale);
  checkRatio(boundTex, index * r, scale);

  // Evaluate characters directly at individual shifts in the cyclic group.
  // Round only the values of fourth roots of unity so the sums stay exact.
  const frequencies = group.filter(f => subgroup.every(t => (f * t) % order === 0));
  const root = (frequency, t) => {
    const angle = 2 * Math.PI * ((frequency * t) % order) / order;
    const components = [Math.cos(angle), Math.sin(angle)];
    const exact = components.map(value => Math.round(value) || 0);
    assert(components.every((value, i) => Math.abs(value - exact[i]) < 1e-12));
    return exact;
  };
  const evaluate = (frequency, elements, weights) => elements.reduce(([real, imaginary], t, i) => {
    const [x, y] = root(frequency, t);
    return [real + x * weights[i], imaginary + y * weights[i]];
  }, [0, 0]);
  const [characterIndices] = capture(statement, /\\xi_j\(t\)=i\^\{jt\}.*j\\in\\\{([\d,]+)\\\}/);
  assert.deepEqual(tuple(characterIndices), frequencies.map(f => f / frequencies[1]));
  assert.deepEqual(root(frequencies[1], 1), [0, 1]);
  const table = [...statement.matchAll(/^(\d+) & (.+?) & (.+?) & (.+?)(?:\\\\)?$/gm)];
  assert.equal(table.length, frequencies.length);
  const [constant, coefficient, exponentTwo, exponentThree, denominator] = capture(proof,
    /M_j=\\frac\{(\d+)\+(\d+)i\^\{(\d+)j\}\+i\^\{(\d+)j\}\}\{(\d+)\}/).map(Number);
  assert.deepEqual([constant, 0, coefficient, 1], counts(shifts));
  assert.deepEqual([exponentTwo, exponentThree, denominator], [representatives[2], representatives[3], size]);
  const rawTex = capture(proof, /gives errors \$([^$]+)\$, \$([^$]+)\$, \$([^$]+)\$, and \$([^$]+)\$/);
  const squaredErrors = [];
  for (const [j, frequency] of frequencies.entries()) {
    const [, label, average, target, errorTex] = table[j];
    assert.equal(Number(label), j);
    const [real, imaginary] = evaluate(frequency, shifts, shifts.map(() => 1));
    const [targetReal, targetImaginary] = evaluate(frequency, representatives, targetWeights);
    checkComplex(average, real, imaginary, size);
    assert.equal(targetImaginary, 0);
    checkRatio(target, targetReal, targetTotal);
    const x = real * targetTotal - targetReal * size;
    const y = imaginary * targetTotal - targetImaginary * size;
    checkComplex(rawTex[j], x, y, scale);
    const squared = x ** 2 + y ** 2;
    checkRatio(errorTex, squared, scale ** 2, true);
    assert(squared <= (index * r) ** 2, "Character " + j + " exceeds the lemma bound");
    squaredErrors.push(squared);
  }
  const maxErrorSquared = Math.max(...squaredErrors);
  const [largestTex, proofBound] = capture(proof, /largest modulus, \$([^$]+)\$, is three quarters of the bound \$([^$]+)\$/);
  checkRatio(largestTex, maxErrorSquared, scale ** 2, true);
  checkRatio(proofBound, index * r, scale);
  assert.equal(16 * maxErrorSquared, 9 * (index * r) ** 2);

  const [removed, added] = capture(proof, /Replace \$(\d+)\$ in \$T\$ by \$(\d+)\$/).map(Number);
  assert(shifts.includes(removed) && group.includes(added) && !shifts.includes(added));
  const adjusted = shifts.map(t => t === removed ? added : t);
  const adjustedDeviations = deviations(adjusted);
  const [adjustedNumerators, adjustedDen] = capture(proof, /deviations in residue order are then \$\(([-\d,]+)\)\/(\d+)\$/);
  assert.deepEqual(tuple(adjustedNumerators).map(n => n * scale), adjustedDeviations.map(n => n * Number(adjustedDen)));
  assert.equal(Math.max(...adjustedDeviations.map(Math.abs)), r);
  const [sharpError, character] = capture(proof, /absolute error of \$([^$]+)\$ at \$\\xi_(\d+)\$/);
  const frequency = frequencies[Number(character)];
  const [real, imaginary] = evaluate(frequency, adjusted, adjusted.map(() => 1));
  const [targetReal, targetImaginary] = evaluate(frequency, representatives, targetWeights);
  const sharpSquared = (real * targetTotal - targetReal * size) ** 2
    + (imaginary * targetTotal - targetImaginary * size) ** 2;
  checkRatio(sharpError, sharpSquared, scale ** 2, true);
  assert.equal(sharpSquared, (index * r) ** 2);
  console.log("Independently verified 8JVN proportions, r, all 4 complex averages and errors, and the sharpness variant");
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

const directory = mkdtempSync(join(tmpdir(), "coset-average-"));
const databasePath = join(directory, "backup.sqlite");
const db = new DatabaseSync(databasePath, { enableForeignKeyConstraints: false });
try {
  db.exec("PRAGMA foreign_keys=OFF");
  db.exec(readFileSync(backupPath, "utf8"));
  db.exec("PRAGMA foreign_keys=ON");
  assert.deepEqual(db.prepare("PRAGMA foreign_key_check").all(), [], "Invalid input backup");

  db.exec("UPDATE results SET revision=revision+1 WHERE id=158");
  checkGuard(db, databasePath);
  db.exec("UPDATE results SET revision=revision-1 WHERE id=158");
  const before = Object.fromEntries(Object.keys(content).map(table =>
    [table, new Map(rows(db, table).map(row => [row.id, row]))]));
  const oldTags = db.prepare("SELECT * FROM tags ORDER BY tag").all();
  apply(db);
  checkGuard(db, databasePath);
  console.log("Guard rejected both a stale baseline and a second application without writes");

  checkInsertion(db, before, oldTags);
  const { displays, macros } = checkChanges(db, before);
  measureDisplays(displays, macros);
  checkExample(db);
} finally {
  db.close();
  rmSync(databasePath, { force: true });
  rmdirSync(directory);
}
console.log("ALL CHECKS PASSED");
