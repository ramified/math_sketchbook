import { Hono, type Context } from "hono";
import type { Env, ProofRow, ResultRow, SectionRow, User } from "./types.ts";
import { loadCtx, rebuildAll, fillRefs, type Ctx } from "./book.ts";
import {
  authenticate, canEdit, checkPassword, createSession, sessionCookieHeader, clearSessionCookieHeader, loginConfigured,
  NOT_CONFIGURED,
} from "./auth.ts";
import { isTag } from "./tags.ts";
import * as reader from "./views/reader.ts";
import * as editor from "./views/editor.ts";
import {
  UserError, saveResult, createResult, createSection, saveSection, saveSetting, loadAliasContext, previewTex,
} from "./store.ts";

type AppEnv = { Bindings: Env; Variables: { user: User } };
const app = new Hono<AppEnv>();

const htmlHeaders = { "Content-Type": "text/html; charset=utf-8", "Cache-Control": "no-cache" };

// ------------------------------------------------------------------------------------------- public pages

app.get("/", async (c) => {
  const ctx = await loadCtx(c.env, false);
  return c.body(reader.homePage(ctx), 200, htmlHeaders);
});

app.get("/bibliography", async (c) => {
  const ctx = await loadCtx(c.env, false);
  return c.body(reader.bibliographyPage(ctx), 200, htmlHeaders);
});

/** Resolve a tag or alias. Returns a redirect target for aliases. */
async function resolveTag(db: D1Database, key: string): Promise<{ tag?: string; redirect?: string }> {
  if (isTag(key)) return { tag: key };
  const a = await db.prepare("SELECT tag FROM aliases WHERE alias = ?").bind(key.toLowerCase()).first<{ tag: string }>();
  return a ? { redirect: a.tag } : {};
}

/** Proofs of one result, or of every result in one section (fixed number of SQL parameters). */
async function proofsFor(db: D1Database, by: { resultId: number } | { sectionId: number }, includeHidden: boolean): Promise<Map<number, ProofRow[]>> {
  const map = new Map<number, ProofRow[]>();
  const vis = includeHidden ? "" : "AND p.visibility = 'published'";
  const stmt = "resultId" in by
    ? db.prepare(`SELECT p.* FROM proofs p WHERE p.result_id = ? ${vis} ORDER BY p.position, p.id`).bind(by.resultId)
    : db.prepare(`SELECT p.* FROM proofs p JOIN results r ON r.id = p.result_id WHERE r.section_id = ? ${vis} ORDER BY p.position, p.id`).bind(by.sectionId);
  const { results } = await stmt.all<ProofRow>();
  for (const p of results) {
    if (!map.has(p.result_id)) map.set(p.result_id, []);
    map.get(p.result_id)!.push(p);
  }
  return map;
}

app.get("/tag/:key", async (c) => {
  const key = c.req.param("key");
  const { tag, redirect } = await resolveTag(c.env.DB, key);
  if (redirect) return c.redirect(`/tag/${redirect}`, 301);
  const ctx = await loadCtx(c.env, false);
  if (!tag) return c.body(reader.notFoundPage(ctx, `There is no result with tag “${key}”.`), 404, htmlHeaders);

  const section = await c.env.DB.prepare("SELECT * FROM sections WHERE tag = ?").bind(tag).first<SectionRow>();
  if (section) {
    if (section.kind === "chapter") return c.body(await reader.chapterPage(ctx, section), 200, htmlHeaders);
    const { results } = await c.env.DB.prepare(
      "SELECT * FROM results WHERE section_id = ? AND visibility = 'published' AND state = 'active' ORDER BY position, id",
    ).bind(section.id).all<ResultRow>();
    const proofs = await proofsFor(c.env.DB, { sectionId: section.id }, false);
    return c.body(await reader.sectionPage(ctx, section, results, proofs), 200, htmlHeaders);
  }

  const r = await c.env.DB.prepare("SELECT * FROM results WHERE tag = ?").bind(tag).first<ResultRow>();
  if (!r || r.visibility !== "published") return c.body(reader.notFoundPage(ctx, `There is no result with tag “${key}”.`), 404, htmlHeaders);
  if (r.state === "retired") {
    const rep = r.replaced_by_id ? await c.env.DB.prepare("SELECT tag FROM results WHERE id = ?").bind(r.replaced_by_id).first<{ tag: string }>() : null;
    return c.body(reader.retiredPage(ctx, r, rep?.tag ?? null), 410, htmlHeaders);
  }
  const [proofs, uses, usedBy, aliases] = await Promise.all([
    proofsFor(c.env.DB, { resultId: r.id }, false),
    c.env.DB.prepare("SELECT DISTINCT target_tag AS t FROM refs WHERE source_result_id = ?").bind(r.id).all<{ t: string }>(),
    c.env.DB.prepare("SELECT DISTINCT r.tag AS t FROM refs JOIN results r ON r.id = refs.source_result_id WHERE refs.target_tag = ? AND r.id != ?").bind(tag, r.id).all<{ t: string }>(),
    c.env.DB.prepare("SELECT alias FROM aliases WHERE tag = ? ORDER BY alias").bind(tag).all<{ alias: string }>(),
  ]);
  const order = (ts: string[]) => ts.filter((t) => t !== tag).sort((a, b) => sortKey(ctx, a).localeCompare(sortKey(ctx, b), undefined, { numeric: true }));
  return c.body(
    await reader.resultPage(ctx, r, proofs.get(r.id) ?? [], order(uses.results.map((x) => x.t)),
      order(usedBy.results.map((x) => x.t)).filter((t) => ctx.book.byTag.has(t)), aliases.results.map((a) => a.alias)),
    200, htmlHeaders,
  );
});

function sortKey(ctx: Ctx, tag: string): string {
  return ctx.book.byTag.get(tag)?.number ?? "~" + tag;
}

/** HTML fragment for click-to-expand references. */
app.get("/api/knowl/:tag", async (c) => {
  const tag = c.req.param("tag");
  if (!isTag(tag)) return c.text("Unknown reference", 404);
  const ctx = await loadCtx(c.env, false);
  const section = await c.env.DB.prepare("SELECT * FROM sections WHERE tag = ?").bind(tag).first<SectionRow>();
  if (section) return c.body(await reader.knowlSection(ctx, section), 200, htmlHeaders);
  const r = await c.env.DB.prepare("SELECT * FROM results WHERE tag = ? AND visibility = 'published' AND state = 'active'").bind(tag).first<ResultRow>();
  if (!r) return c.text("Unknown reference", 404);
  const proofs = await proofsFor(c.env.DB, { resultId: r.id }, false);
  return c.body(await reader.knowlResult(ctx, r, proofs.get(r.id) ?? []), 200, htmlHeaders);
});

// ------------------------------------------------------------------------------------------- login / logout

/** Only same-site paths, so /login?next=… cannot send you to another website. */
function safeNext(v: unknown): string {
  return typeof v === "string" && v.startsWith("/") && !v.startsWith("//") && !v.startsWith("/\\") ? v : "/edit";
}

function sameOrigin(c: Context<AppEnv>): boolean {
  return c.req.header("Origin") === new URL(c.req.url).origin;
}

app.get("/login", async (c) => {
  const next = safeNext(c.req.query("next"));
  if ((await authenticate(c.req.raw, c.env)).ok) return c.redirect(next, 303);
  const ctx = await loadCtx(c.env, false);
  if (!loginConfigured(c.env)) return c.body(editor.errorPage(ctx, 500, NOT_CONFIGURED), 500, htmlHeaders);
  return c.body(editor.loginPage(ctx, next, null), 200, htmlHeaders);
});

app.post("/login", async (c) => {
  if (!sameOrigin(c)) return c.text("Cross-site request refused.", 403);
  const ctx = await loadCtx(c.env, false);
  if (!loginConfigured(c.env)) return c.body(editor.errorPage(ctx, 500, NOT_CONFIGURED), 500, htmlHeaders);
  const form = await c.req.parseBody();
  const next = safeNext(form.next);
  const password = typeof form.password === "string" ? form.password : "";
  if (!(await checkPassword(c.env, password))) {
    await new Promise((r) => setTimeout(r, 1000)); // slow down guessing
    return c.body(editor.loginPage(ctx, next, "Wrong password."), 401, htmlHeaders);
  }
  c.header("Set-Cookie", sessionCookieHeader(await createSession(c.env)));
  return c.redirect(next, 303);
});

app.post("/logout", async (c) => {
  if (!sameOrigin(c)) return c.text("Cross-site request refused.", 403);
  c.header("Set-Cookie", clearSessionCookieHeader());
  return c.redirect("/", 303);
});

// ------------------------------------------------------------------------------------------- editor (login required)

async function requireEditor(c: Context<AppEnv>, next: () => Promise<void>) {
  const auth = await authenticate(c.req.raw, c.env);
  const isApi = c.req.path.startsWith("/api/");
  if (!auth.ok && auth.status === 401 && !isApi && c.req.method === "GET") {
    const u = new URL(c.req.url);
    return c.redirect(`/login?next=${encodeURIComponent(u.pathname + u.search)}`, 303);
  }
  if (!auth.ok) {
    return isApi ? c.json({ error: auth.message }, auth.status) : c.body(editor.errorPage(null, auth.status, auth.message), auth.status, htmlHeaders);
  }
  if (!canEdit(auth.user)) {
    const msg = "Your account can read the editor pages but not change content.";
    return isApi ? c.json({ error: msg }, 403) : c.body(editor.errorPage(null, 403, msg), 403, htmlHeaders);
  }
  if (c.req.method !== "GET" && c.req.method !== "HEAD") {
    // CSRF protection: same-origin JSON requests only.
    const origin = c.req.header("Origin");
    if (!origin || origin !== new URL(c.req.url).origin) return c.json({ error: "Cross-site request refused." }, 403);
    if (!(c.req.header("Content-Type") ?? "").startsWith("application/json")) return c.json({ error: "Expected JSON." }, 415);
  }
  c.set("user", auth.user);
  await next();
}
app.use("/edit", requireEditor);
app.use("/edit/*", requireEditor);
app.use("/api/edit/*", requireEditor);

app.get("/edit", async (c) => {
  const ctx = await loadCtx(c.env, true);
  return c.body(editor.dashboardPage(ctx, c.get("user")), 200, htmlHeaders);
});

app.get("/edit/result/:tag", async (c) => {
  const tag = c.req.param("tag");
  const ctx = await loadCtx(c.env, true);
  const r = await c.env.DB.prepare("SELECT * FROM results WHERE tag = ?").bind(tag).first<ResultRow>();
  if (!r) return c.body(editor.errorPage(ctx, 404, "No such result."), 404, htmlHeaders);
  const proofs = (await proofsFor(c.env.DB, { resultId: r.id }, true)).get(r.id) ?? [];
  const aliases = (await c.env.DB.prepare("SELECT alias FROM aliases WHERE tag = ? ORDER BY alias").bind(tag).all<{ alias: string }>()).results.map((a) => a.alias);
  let restore: editor.RestoreInfo | null = null;
  const restoreId = Number(c.req.query("restore"));
  if (Number.isInteger(restoreId) && restoreId > 0) {
    const rev = await c.env.DB.prepare("SELECT * FROM revisions WHERE id = ?").bind(restoreId).first<editor.HistoryItem>();
    if (rev) {
      const snap = JSON.parse(rev.snapshot_json) as Record<string, unknown>;
      if (rev.entity === "result" && rev.entity_key === String(r.id)) {
        restore = { revisionId: rev.id, revision: rev.revision, entity: "result", snapshot: snap };
      } else if (rev.entity === "proof" && snap.result_id === r.id) {
        restore = { revisionId: rev.id, revision: rev.revision, entity: "proof", snapshot: snap, proofId: Number(rev.entity_key) };
      }
    }
  }
  return c.body(editor.resultEditPage(ctx, r, proofs, aliases, restore), 200, htmlHeaders);
});

app.get("/edit/section/:tag", async (c) => {
  const ctx = await loadCtx(c.env, true);
  const s = await c.env.DB.prepare("SELECT * FROM sections WHERE tag = ?").bind(c.req.param("tag")).first<SectionRow>();
  if (!s) return c.body(editor.errorPage(ctx, 404, "No such section."), 404, htmlHeaders);
  return c.body(editor.sectionEditPage(ctx, s), 200, htmlHeaders);
});

app.get("/edit/settings", async (c) => {
  const ctx = await loadCtx(c.env, true);
  const { results } = await c.env.DB.prepare("SELECT key, value, revision FROM settings").all<{ key: string; value: string; revision: number }>();
  return c.body(editor.settingsPage(ctx, results), 200, htmlHeaders);
});

app.get("/edit/history/:key", async (c) => {
  const key = c.req.param("key");
  const ctx = await loadCtx(c.env, true);
  const db = c.env.DB;
  if (key.startsWith("setting:")) {
    const k = key.slice("setting:".length);
    const { results } = await db.prepare("SELECT * FROM revisions WHERE entity = 'setting' AND entity_key = ? ORDER BY id DESC LIMIT 200").bind(k).all<editor.HistoryItem>();
    return c.body(editor.historyPage(ctx, `setting “${k}”`, results, null, "/edit/settings"), 200, htmlHeaders);
  }
  const r = await db.prepare("SELECT id, tag FROM results WHERE tag = ?").bind(key).first<{ id: number; tag: string }>();
  if (r) {
    const { results } = await db.prepare(
      `SELECT * FROM revisions WHERE (entity = 'result' AND entity_key = ?)
         OR (entity = 'proof' AND json_extract(snapshot_json, '$.result_id') = ?) ORDER BY id DESC LIMIT 300`,
    ).bind(String(r.id), r.id).all<editor.HistoryItem>();
    const label = ctx.book.byTag.get(r.tag)?.label ?? r.tag;
    return c.body(editor.historyPage(ctx, `${label} (${r.tag})`, results, `/edit/result/${r.tag}`, `/edit/result/${r.tag}`), 200, htmlHeaders);
  }
  const s = await db.prepare("SELECT id, tag FROM sections WHERE tag = ?").bind(key).first<{ id: number; tag: string }>();
  if (s) {
    const { results } = await db.prepare("SELECT * FROM revisions WHERE entity = 'section' AND entity_key = ? ORDER BY id DESC LIMIT 200").bind(String(s.id)).all<editor.HistoryItem>();
    return c.body(editor.historyPage(ctx, s.tag, results, null, `/edit/section/${s.tag}`), 200, htmlHeaders);
  }
  return c.body(editor.errorPage(ctx, 404, "Nothing found."), 404, htmlHeaders);
});

// ---- editor JSON API

async function jsonBody(c: Context<AppEnv>): Promise<Record<string, unknown>> {
  try {
    const b = await c.req.json();
    if (b && typeof b === "object" && !Array.isArray(b)) return b as Record<string, unknown>;
  } catch {
    /* fall through */
  }
  throw new UserError("Invalid JSON body.");
}

app.post("/api/edit/preview", async (c) => {
  const body = await jsonBody(c);
  const tex = typeof body.tex === "string" ? body.tex.slice(0, 200_000) : "";
  const ctx = await loadCtx(c.env, true);
  const ac = await loadAliasContext(c.env.DB);
  const { html, warnings } = previewTex(tex, ac, ctx.settings.macros ?? "");
  return c.json({ html: fillRefs(html, ctx.book), warnings });
});

app.post("/api/edit/result/:tag", async (c) => {
  const out = await saveResult(c.env.DB, c.get("user").email, c.req.param("tag"), await jsonBody(c));
  return c.json({ ok: true, ...out });
});
app.post("/api/edit/section/:tag", async (c) => {
  const out = await saveSection(c.env.DB, c.get("user").email, c.req.param("tag"), await jsonBody(c));
  return c.json({ ok: true, ...out });
});
app.post("/api/edit/new-result", async (c) => {
  const tag = await createResult(c.env.DB, c.get("user").email, await jsonBody(c));
  return c.json({ ok: true, tag, url: `/edit/result/${tag}` });
});
app.post("/api/edit/new-section", async (c) => {
  const tag = await createSection(c.env.DB, c.get("user").email, await jsonBody(c));
  return c.json({ ok: true, tag, url: `/edit/section/${tag}` });
});
app.post("/api/edit/setting", async (c) => {
  const out = await saveSetting(c.env.DB, c.get("user").email, await jsonBody(c));
  return c.json({ ok: true, ...out });
});
app.post("/api/edit/rebuild", async (c) => {
  await jsonBody(c);
  const out = await rebuildAll(c.env);
  return c.json({ ok: true, ...out });
});

// ------------------------------------------------------------------------------------------- errors

app.notFound(async (c) => {
  const ctx = await loadCtx(c.env, false).catch(() => null);
  return c.body(ctx ? reader.notFoundPage(ctx, "This page does not exist.") : "Not found", 404, htmlHeaders);
});

app.onError((err, c) => {
  if (err instanceof UserError) {
    return c.req.path.startsWith("/api/") ? c.json({ error: err.message }, err.status as 400) : c.text(err.message, err.status as 400);
  }
  console.error(err);
  return c.req.path.startsWith("/api/") ? c.json({ error: "Server error. Nothing was saved." }, 500) : c.text("Server error", 500);
});

export default app;
