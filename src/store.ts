// Writing side: every save is ONE atomic D1 batch (content + positions + reference graph + history).
// Optimistic locking: each save sends the revision it started from; if the row changed meanwhile, the
// write_guard insert fails and the whole batch is rolled back.

import { renderTex, rewriteRefTargets, findRefTargets, type Warning } from "./latex.ts";
import { isAlias, isTag, randomTag } from "./tags.ts";
import { macrosFor, refInserts, loadSettings } from "./book.ts";
import {
  RESULT_TYPES, PROOF_STATUSES, GENERATORS, type ProofRow, type ResultRow, type SectionRow, type ResultType,
  type ProofStatus, type Generator,
} from "./types.ts";

export class UserError extends Error {
  status: number;
  constructor(message: string, status = 400) {
    super(message);
    this.status = status;
  }
}

const MAX_TEX = 200_000;
const now = () => new Date().toISOString().replace("T", " ").slice(0, 19);

function guard(db: D1Database, table: "results" | "proofs" | "sections" | "settings", key: string | number, revision: number) {
  const col = table === "settings" ? "key" : "id";
  return db
    .prepare(`INSERT INTO write_guard (ok) SELECT 0 WHERE NOT EXISTS (SELECT 1 FROM ${table} WHERE ${col} = ? AND revision = ?)`)
    .bind(key, revision);
}

function revisionRow(db: D1Database, entity: string, key: string | number, revision: number, op: string, snapshot: unknown, author: string) {
  return db
    .prepare("INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author) VALUES (?, ?, ?, ?, ?, ?)")
    .bind(entity, String(key), revision, op, JSON.stringify(snapshot), author);
}

/**
 * Snapshot of the state BEFORE a save, recorded only if history does not have it yet (e.g. content that came from
 * the seed file or was created outside the editor), so the original version can always be restored.
 */
function baselineRow(db: D1Database, entity: string, key: string | number, revision: number, op: string, snapshot: unknown, author: string | null) {
  return db
    .prepare("INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author) VALUES (?, ?, ?, ?, ?, ?)")
    .bind(entity, String(key), revision, op, JSON.stringify(snapshot), author ?? "(before history)");
}
/** Next id, never reusing an id that still appears in the history (deleted rows keep their history). */
async function nextId(db: D1Database, table: "proofs" | "results" | "sections", entity: string): Promise<number> {
  const row = await db
    .prepare(`SELECT MAX(m) AS m FROM (SELECT COALESCE(MAX(id), 0) AS m FROM ${table}
              UNION ALL SELECT COALESCE(MAX(CAST(entity_key AS INTEGER)), 0) FROM revisions WHERE entity = ?)`)
    .bind(entity)
    .first<{ m: number }>();
  return (row?.m ?? 0) + 1;
}

function proofSnapshot(p: ProofRow) {
  return {
    result_id: p.result_id, body_tex: p.body_tex, status: p.status, generated_by: p.generated_by, generator_detail: p.generator_detail,
    reviewed_by: p.reviewed_by, review_notes: p.review_notes, position: p.position,
  };
}

async function runBatch(db: D1Database, stmts: D1PreparedStatement[]) {
  try {
    await db.batch(stmts);
  } catch (e) {
    const msg = e instanceof Error ? e.message : String(e);
    if (/CHECK constraint failed/.test(msg) && /ok = 1|write_guard/.test(msg)) {
      throw new UserError("This was changed (in another tab?) after you opened it. Reload the page and redo your edit.", 409);
    }
    if (/UNIQUE constraint failed: (proofs|tags|sections|results)\.id/.test(msg)) {
      throw new UserError("Someone saved at the same moment. Please press Save again.", 409);
    }
    if (/FOREIGN KEY/.test(msg)) throw new UserError("This change would break a link between records (foreign key).", 409);
    throw e;
  }
}

function str(v: unknown, max: number, field: string): string {
  if (v === undefined || v === null) return "";
  if (typeof v !== "string") throw new UserError(`${field} must be text.`);
  if (v.length > max) throw new UserError(`${field} is too long.`);
  return v;
}
function oneOf<T extends string>(v: unknown, allowed: readonly T[], field: string): T {
  if (typeof v !== "string" || !allowed.includes(v as T)) throw new UserError(`Invalid ${field}.`);
  return v as T;
}
function int(v: unknown, field: string): number {
  if (typeof v !== "number" || !Number.isInteger(v)) throw new UserError(`Invalid ${field}.`);
  return v;
}

/** New order of ids in a container after placing `id` according to `placeAfter`. */
function placeInOrder(siblings: number[], id: number, placeAfter: "keep" | "start" | number): number[] | null {
  if (placeAfter === "keep") return null;
  const rest = siblings.filter((x) => x !== id);
  if (placeAfter === "start") return [id, ...rest];
  const i = rest.indexOf(placeAfter);
  if (i < 0) throw new UserError("The result to place this after is not in the chosen section.");
  return [...rest.slice(0, i + 1), id, ...rest.slice(i + 1)];
}
function parsePlaceAfter(v: unknown): "keep" | "start" | number {
  if (v === undefined || v === null || v === "keep") return "keep";
  if (v === "start") return "start";
  return int(v, "position");
}

// ---------------------------------------------------------------------------------------------- refs & aliases

export interface AliasContext {
  aliasToTag: Map<string, string>;
  tags: Set<string>;
}
export async function loadAliasContext(db: D1Database): Promise<AliasContext> {
  const [a, t] = await db.batch([db.prepare("SELECT alias, tag FROM aliases"), db.prepare("SELECT tag FROM tags")]);
  return {
    aliasToTag: new Map((a.results as { alias: string; tag: string }[]).map((r) => [r.alias, r.tag])),
    tags: new Set((t.results as { tag: string }[]).map((r) => r.tag)),
  };
}

/** Rewrite \ref{alias} to \ref{TAG}; `extra` holds aliases being added in this same save. */
export function canonicalizeRefs(tex: string, ac: AliasContext, extra?: Map<string, string>): string {
  return rewriteRefTargets(tex, (t) => (isTag(t) ? null : extra?.get(t) ?? ac.aliasToTag.get(t) ?? null));
}

export function unresolvedWarnings(refs: string[], ac: AliasContext, label: string): Warning[] {
  return refs
    .filter((t) => !ac.tags.has(t))
    .map((t) => ({ message: `${label}: \\ref{${t}} does not match any tag or alias yet.` }));
}

/** Render a snippet for the editor's live preview (aliases resolved, warnings included). */
export function previewTex(tex: string, ac: AliasContext, macroSrc: string) {
  const canonical = canonicalizeRefs(tex, ac);
  const { macros, error } = macrosFor(macroSrc);
  const out = renderTex(canonical, macros);
  const warnings = [...out.warnings, ...unresolvedWarnings(out.refs, ac, "Reference")];
  if (error) warnings.unshift({ message: `Macro file error: ${error}` });
  return { html: out.html, warnings };
}

// ---------------------------------------------------------------------------------------------- results

export interface ProofInput {
  id?: number;
  revision?: number;
  body_tex: string;
  status: ProofStatus;
  generated_by: Generator;
  generator_detail: string;
  reviewed_by: string;
  review_notes: string;
}

export async function saveResult(db: D1Database, author: string, tag: string, body: Record<string, unknown>): Promise<{ warnings: Warning[] }> {
  const existing = await db.prepare("SELECT * FROM results WHERE tag = ?").bind(tag).first<ResultRow>();
  if (!existing) throw new UserError("No such result.", 404);

  const revision = int(body.revision, "revision");
  const type = oneOf<ResultType>(body.type, RESULT_TYPES, "type");
  const title = str(body.title, 300, "Title").trim();
  const sectionId = int(body.section_id, "section");
  // Unlisted results are reachable only through links; omitted = keep the current setting.
  const listed = body.listed === undefined ? existing.listed : body.listed ? 1 : 0;
  const placeAfter = parsePlaceAfter(body.place_after);
  let statement = str(body.statement_tex, MAX_TEX, "Statement");
  const aliasesIn = Array.isArray(body.aliases) ? body.aliases.map((a) => str(a, 64, "Alias").trim().toLowerCase()).filter(Boolean) : [];
  const proofsIn: ProofInput[] = (Array.isArray(body.proofs) ? body.proofs : []).map((p: Record<string, unknown>) => ({
    id: p.id === undefined || p.id === null ? undefined : int(p.id, "proof id"),
    revision: p.revision === undefined || p.revision === null ? undefined : int(p.revision, "proof revision"),
    body_tex: str(p.body_tex, MAX_TEX, "Proof"),
    status: oneOf<ProofStatus>(p.status, PROOF_STATUSES, "proof status"),
    generated_by: oneOf<Generator>(p.generated_by, GENERATORS, "generated_by"),
    generator_detail: str(p.generator_detail, 300, "Generator detail").trim(),
    reviewed_by: str(p.reviewed_by, 200, "Reviewed by").trim(),
    review_notes: str(p.review_notes, 20_000, "Review notes"),
  }));
  if (proofsIn.length > 30) throw new UserError("Too many proofs.");

  const section = await db.prepare("SELECT id, kind FROM sections WHERE id = ?").bind(sectionId).first<{ id: number; kind: string }>();
  if (!section || section.kind !== "section") throw new UserError("Results must belong to a section (not a chapter).");

  // Aliases: validate and check they are not used by another tag.
  const ac = await loadAliasContext(db);
  const newAliases = new Map<string, string>();
  for (const a of new Set(aliasesIn)) {
    if (!isAlias(a)) throw new UserError(`Alias "${a}" must start with a lowercase letter and use only a-z, 0-9 and "-".`);
    const owner = ac.aliasToTag.get(a);
    if (owner && owner !== tag) throw new UserError(`Alias "${a}" already belongs to ${owner}.`);
    newAliases.set(a, tag);
  }

  const settings = await loadSettings(db);
  const { macros } = macrosFor(settings.macros ?? "");
  const warnings: Warning[] = [];

  statement = canonicalizeRefs(statement, ac, newAliases);
  const stmtOut = renderTex(statement, macros);
  warnings.push(...stmtOut.warnings.map((w) => ({ ...w, message: `Statement: ${w.message}` })));
  warnings.push(...unresolvedWarnings(stmtOut.refs, ac, "Statement"));
  if (stmtOut.refs.includes(tag)) warnings.push({ message: "The statement refers to itself." });

  const existingProofs = (await db.prepare("SELECT * FROM proofs WHERE result_id = ?").bind(existing.id).all<ProofRow>()).results;
  const byId = new Map(existingProofs.map((p) => [p.id, p]));
  const keptIds = new Set<number>();
  let nextProofId = await nextId(db, "proofs", "proof");

  const op = crypto.randomUUID();
  const ts = now();
  const oldAliases = [...ac.aliasToTag].filter(([, t]) => t === tag).map(([a]) => a);
  const stmts: D1PreparedStatement[] = [
    guard(db, "results", existing.id, revision),
    baselineRow(db, "result", existing.id, existing.revision, op, {
      tag, type: existing.type, title: existing.title, statement_tex: existing.statement_tex, section_id: existing.section_id,
      position: existing.position, listed: existing.listed, aliases: oldAliases,
    }, existing.updated_by),
    ...existingProofs.map((p) => baselineRow(db, "proof", p.id, p.revision, op, proofSnapshot(p), null)),
  ];
  const proofRefs: { proofId: number; refs: string[] }[] = [];
  const proofWrites: D1PreparedStatement[] = [];

  proofsIn.forEach((p, idx) => {
    const position = idx + 1;
    const bodyTex = canonicalizeRefs(p.body_tex, ac, newAliases);
    const out = renderTex(bodyTex, macros);
    warnings.push(...out.warnings.map((w) => ({ ...w, message: `Proof ${position}: ${w.message}` })));
    warnings.push(...unresolvedWarnings(out.refs, ac, `Proof ${position}`));
    const fields = {
      body_tex: bodyTex, status: p.status, generated_by: p.generated_by, generator_detail: p.generator_detail || null,
      reviewed_by: p.reviewed_by || null, review_notes: p.review_notes || null, position,
    };
    if (p.id !== undefined) {
      const old = byId.get(p.id);
      if (!old) throw new UserError("A proof in this form no longer exists. Reload the page.", 409);
      if (p.revision === undefined) throw new UserError("Missing proof revision.");
      keptIds.add(p.id);
      proofRefs.push({ proofId: p.id, refs: out.refs });
      const changed = (Object.keys(fields) as (keyof typeof fields)[]).some((k) => (old as unknown as Record<string, unknown>)[k] !== fields[k]);
      stmts.push(guard(db, "proofs", p.id, p.revision));
      if (changed) {
        proofWrites.push(
          db.prepare(`UPDATE proofs SET body_tex=?, body_html_cache=?, status=?, generated_by=?, generator_detail=?, reviewed_by=?,
                      review_notes=?, position=?, revision=revision+1, updated_at=?, updated_by=? WHERE id=?`)
            .bind(fields.body_tex, out.html, fields.status, fields.generated_by, fields.generator_detail, fields.reviewed_by,
              fields.review_notes, position, ts, author, p.id),
          revisionRow(db, "proof", p.id, p.revision + 1, op, { result_id: existing.id, ...fields }, author),
        );
      }
    } else {
      const id = nextProofId++;
      proofRefs.push({ proofId: id, refs: out.refs });
      proofWrites.push(
        db.prepare(`INSERT INTO proofs (id, result_id, position, body_tex, body_html_cache, status, generated_by, generator_detail,
                    reviewed_by, review_notes, created_at, updated_at, created_by, updated_by) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)`)
          .bind(id, existing.id, position, fields.body_tex, out.html, fields.status, fields.generated_by, fields.generator_detail,
            fields.reviewed_by, fields.review_notes, ts, ts, author, author),
        revisionRow(db, "proof", id, 1, op, { result_id: existing.id, ...fields }, author),
      );
    }
  });

  // Ordering within the (possibly new) section.
  const siblings = (await db.prepare("SELECT id FROM results WHERE section_id = ? ORDER BY position, id").bind(sectionId).all<{ id: number }>()).results.map((r) => r.id);
  let order = placeInOrder(siblings, existing.id, placeAfter);
  if (!order && sectionId !== existing.section_id) order = [...siblings.filter((x) => x !== existing.id), existing.id];
  let newPosition = existing.position;
  if (order) {
    order.forEach((id, i) => {
      if (id === existing.id) newPosition = i + 1;
      // `AND section_id = ?`: never touch a result that another tab moved away meanwhile
      else stmts.push(db.prepare("UPDATE results SET position = ? WHERE id = ? AND section_id = ?").bind(i + 1, id, sectionId));
    });
  }

  // Deleted proofs (removed from the form).
  for (const old of existingProofs) {
    if (keptIds.has(old.id)) continue;
    stmts.push(guard(db, "proofs", old.id, old.revision));
    stmts.push(revisionRow(db, "proof", old.id, old.revision + 1, op, { ...proofSnapshot(old), deleted: true }, author));
  }

  stmts.push(db.prepare("DELETE FROM refs WHERE source_result_id = ?").bind(existing.id));
  for (const old of existingProofs) if (!keptIds.has(old.id)) stmts.push(db.prepare("DELETE FROM proofs WHERE id = ?").bind(old.id));
  stmts.push(
    db.prepare(`UPDATE results SET type=?, title=?, statement_tex=?, statement_html_cache=?, section_id=?, position=?, listed=?,
                visibility='published', revision=revision+1, updated_at=?, updated_by=? WHERE id=?`)
      .bind(type, title, statement, stmtOut.html, sectionId, newPosition, listed, ts, author, existing.id),
    revisionRow(db, "result", existing.id, revision + 1, op, { tag, type, title, statement_tex: statement, section_id: sectionId, position: newPosition, listed, aliases: [...newAliases.keys()] }, author),
  );
  stmts.push(...proofWrites);
  stmts.push(...refInserts(db, existing.id, stmtOut.refs, proofRefs));

  // Aliases: replace this tag's set.
  stmts.push(db.prepare("DELETE FROM aliases WHERE tag = ?").bind(tag));
  for (const a of newAliases.keys()) stmts.push(db.prepare("INSERT INTO aliases (alias, tag) VALUES (?, ?)").bind(a, tag));

  await runBatch(db, stmts);
  return { warnings };
}

async function freshTag(db: D1Database): Promise<string> {
  for (let i = 0; i < 20; i++) {
    const t = randomTag();
    const hit = await db.prepare("SELECT 1 FROM tags WHERE tag = ?").bind(t).first();
    if (!hit) return t;
  }
  throw new Error("Could not allocate a fresh tag.");
}

export async function createResult(db: D1Database, author: string, body: Record<string, unknown>): Promise<string> {
  const sectionId = int(body.section_id, "section");
  const type = oneOf<ResultType>(body.type, RESULT_TYPES, "type");
  const section = await db.prepare("SELECT id, kind FROM sections WHERE id = ?").bind(sectionId).first<{ kind: string }>();
  if (!section || section.kind !== "section") throw new UserError("Choose a section (not a chapter).");
  const tag = await freshTag(db);
  const pos = ((await db.prepare("SELECT COALESCE(MAX(position), 0) AS m FROM results WHERE section_id = ?").bind(sectionId).first<{ m: number }>())?.m ?? 0) + 1;
  const id = await nextId(db, "results", "result");
  const ts = now();
  await runBatch(db, [
    db.prepare("INSERT INTO tags (tag, kind) VALUES (?, 'result')").bind(tag),
    // Created as a hidden draft; the first "Save & publish" makes it public.
    db.prepare(`INSERT INTO results (id, tag, type, title, statement_tex, section_id, position, visibility, created_at, updated_at, created_by, updated_by)
                VALUES (?, ?, ?, '', '', ?, ?, 'draft', ?, ?, ?, ?)`).bind(id, tag, type, sectionId, pos, ts, ts, author, author),
    revisionRow(db, "result", id, 1, crypto.randomUUID(), { tag, type, title: "", statement_tex: "", section_id: sectionId, position: pos }, author),
  ]);
  return tag;
}

// ---------------------------------------------------------------------------------------------- sections

export async function createSection(db: D1Database, author: string, body: Record<string, unknown>): Promise<string> {
  const kind = oneOf(body.kind, ["chapter", "section"] as const, "kind");
  const title = str(body.title, 300, "Title").trim() || "Untitled";
  let parentId: number | null = null;
  if (kind === "section") {
    parentId = int(body.parent_id, "chapter");
    const p = await db.prepare("SELECT kind FROM sections WHERE id = ?").bind(parentId).first<{ kind: string }>();
    if (!p || p.kind !== "chapter") throw new UserError("A section must belong to a chapter.");
  }
  const tag = await freshTag(db);
  const pos = ((await db.prepare("SELECT COALESCE(MAX(position), 0) AS m FROM sections WHERE parent_id IS ?").bind(parentId).first<{ m: number }>())?.m ?? 0) + 1;
  const id = await nextId(db, "sections", "section");
  const ts = now();
  await runBatch(db, [
    db.prepare("INSERT INTO tags (tag, kind) VALUES (?, 'section')").bind(tag),
    db.prepare(`INSERT INTO sections (id, tag, parent_id, kind, title, intro_tex, position, created_at, updated_at, updated_by)
                VALUES (?, ?, ?, ?, ?, '', ?, ?, ?, ?)`).bind(id, tag, parentId, kind, title, pos, ts, ts, author),
    revisionRow(db, "section", id, 1, crypto.randomUUID(), { tag, kind, title, intro_tex: "", parent_id: parentId, position: pos }, author),
  ]);
  return tag;
}

export async function saveSection(db: D1Database, author: string, tag: string, body: Record<string, unknown>): Promise<{ warnings: Warning[] }> {
  const s = await db.prepare("SELECT * FROM sections WHERE tag = ?").bind(tag).first<SectionRow>();
  if (!s) throw new UserError("No such section.", 404);
  const revision = int(body.revision, "revision");
  const title = str(body.title, 300, "Title").trim() || "Untitled";
  const placeAfter = parsePlaceAfter(body.place_after);
  let parentId = s.parent_id;
  if (s.kind === "section") {
    parentId = int(body.parent_id, "chapter");
    const p = await db.prepare("SELECT kind FROM sections WHERE id = ?").bind(parentId).first<{ kind: string }>();
    if (!p || p.kind !== "chapter") throw new UserError("A section must belong to a chapter.");
  }
  const ac = await loadAliasContext(db);
  const intro = canonicalizeRefs(str(body.intro_tex, MAX_TEX, "Introduction"), ac);
  const { macros } = macrosFor((await loadSettings(db)).macros ?? "");
  const out = renderTex(intro, macros);
  const warnings = [...out.warnings, ...unresolvedWarnings(out.refs, ac, "Introduction")];

  const op = crypto.randomUUID();
  const stmts: D1PreparedStatement[] = [
    guard(db, "sections", s.id, revision),
    baselineRow(db, "section", s.id, s.revision, op, { tag, kind: s.kind, title: s.title, intro_tex: s.intro_tex, parent_id: s.parent_id, position: s.position }, s.updated_by),
  ];
  const siblings = (await db.prepare("SELECT id FROM sections WHERE parent_id IS ? ORDER BY position, id").bind(parentId).all<{ id: number }>()).results.map((r) => r.id);
  let order = placeInOrder(siblings, s.id, placeAfter);
  if (!order && parentId !== s.parent_id) order = [...siblings.filter((x) => x !== s.id), s.id];
  let newPosition = s.position;
  if (order) {
    order.forEach((id, i) => {
      if (id === s.id) newPosition = i + 1;
      else stmts.push(db.prepare("UPDATE sections SET position = ? WHERE id = ? AND parent_id IS ?").bind(i + 1, id, parentId));
    });
  }
  const ts = now();
  stmts.push(
    db.prepare(`UPDATE sections SET title=?, intro_tex=?, intro_html_cache=?, parent_id=?, position=?, revision=revision+1,
                updated_at=?, updated_by=? WHERE id=?`).bind(title, intro, out.html, parentId, newPosition, ts, author, s.id),
    revisionRow(db, "section", s.id, revision + 1, op, { tag, kind: s.kind, title, intro_tex: intro, parent_id: parentId, position: newPosition }, author),
  );
  await runBatch(db, stmts);
  return { warnings };
}

// ---------------------------------------------------------------------------------------------- settings

export const EDITABLE_SETTINGS = ["book_title", "macros", "bibliography"] as const;

export async function saveSetting(db: D1Database, author: string, body: Record<string, unknown>): Promise<{ warnings: Warning[] }> {
  const key = oneOf(body.key, EDITABLE_SETTINGS, "setting");
  const value = str(body.value, MAX_TEX, key);
  const revision = int(body.revision, "revision");
  if (key === "macros") {
    const { error } = macrosFor(value);
    if (error) throw new UserError(`The macro file has an error, nothing was saved: ${error}`);
  }
  const old = await db.prepare("SELECT value, revision FROM settings WHERE key = ?").bind(key).first<{ value: string; revision: number }>();
  if (!old) throw new UserError(`Setting ${key} is missing; run the seed file first.`, 500);
  const op = crypto.randomUUID();
  const stmts: D1PreparedStatement[] = [
    guard(db, "settings", key, revision),
    baselineRow(db, "setting", key, old.revision, op, { key, value: old.value }, null),
    db.prepare("UPDATE settings SET value = ?, revision = revision + 1 WHERE key = ?").bind(value, key),
    revisionRow(db, "setting", key, revision + 1, op, { key, value }, author),
  ];
  if (key === "macros") {
    // Cached HTML has math rendered with the old macros: drop it; pages re-render lazily.
    stmts.push(
      db.prepare("UPDATE results SET statement_html_cache = NULL"),
      db.prepare("UPDATE proofs SET body_html_cache = NULL"),
      db.prepare("UPDATE sections SET intro_html_cache = NULL"),
    );
  }
  await runBatch(db, stmts);
  return { warnings: [] };
}

export { findRefTargets };
