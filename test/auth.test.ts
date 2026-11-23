import { test } from "node:test";
import assert from "node:assert/strict";
import { authenticate, checkPassword, createSession, SESSION_COOKIE, SESSION_SECONDS } from "../src/auth.ts";
import { isTag, isAlias, randomTag } from "../src/tags.ts";

const env = (over: Record<string, string>) => ({ ENVIRONMENT: "production", ...over }) as never;
const PW = "correct horse battery staple";
const prod = env({ EDITOR_PASSWORD: PW });
const withCookie = (v: string) => new Request("https://notes.example/edit", { headers: { Cookie: `x=1; ${SESSION_COOKIE}=${v}` } });

test("production without a (long enough) password fails closed", async () => {
  for (const e of [env({ DEV_EDITOR_EMAIL: "editor@localhost" }), env({ EDITOR_PASSWORD: "short" })]) {
    const r = await authenticate(new Request("https://notes.example/edit"), e);
    assert.equal(!r.ok && r.status, 500);
    assert.equal(await checkPassword(e, "short"), false);
  }
});

test("dev bypass only on localhost", async () => {
  const dev = env({ ENVIRONMENT: "development", DEV_EDITOR_EMAIL: "editor@localhost" });
  const local = await authenticate(new Request("http://localhost:8787/edit"), dev);
  assert.equal(local.ok, true);
  const remote = await authenticate(new Request("https://notes.example/edit"), dev);
  assert.equal(remote.ok, false);
});

test("password check", async () => {
  assert.equal(await checkPassword(prod, PW), true);
  assert.equal(await checkPassword(prod, PW + " "), false);
  assert.equal(await checkPassword(prod, ""), false);
});

test("valid session is accepted; missing, forged, expired or old-password sessions are rejected", async () => {
  const now = Date.now();
  const good = await createSession(prod, now);
  assert.equal((await authenticate(withCookie(good), prod, now)).ok, true);

  const none = await authenticate(new Request("https://notes.example/edit"), prod, now);
  assert.equal(!none.ok && none.status, 401);

  const [exp, sig] = good.split(".");
  const tampered = `${Number(exp) + 999999}.${sig}`;
  assert.equal((await authenticate(withCookie(tampered), prod, now)).ok, false);
  assert.equal((await authenticate(withCookie("garbage"), prod, now)).ok, false);

  const later = now + (SESSION_SECONDS + 1) * 1000;
  assert.equal((await authenticate(withCookie(good), prod, later)).ok, false);

  const changed = env({ EDITOR_PASSWORD: PW + "!" });
  assert.equal((await authenticate(withCookie(good), changed, now)).ok, false);
});

test("tags avoid 0 O 1 I L; aliases never look like tags", () => {
  for (let i = 0; i < 2000; i++) {
    const t = randomTag();
    assert.ok(isTag(t), t);
    assert.ok(!/[01OIL]/.test(t), t);
  }
  assert.ok(!isTag("0ABC") && !isTag("1ABC") && !isTag("ABCI") && !isTag("ABCL") && !isTag("ABCO"));
  assert.ok(isAlias("grh") && !isAlias("ABCD") && !isAlias("4chk"));
});
