import { test } from "node:test";
import assert from "node:assert/strict";
import { authenticate } from "../src/auth.ts";
import { isTag, isAlias, randomTag } from "../src/tags.ts";

// Fake D1 that knows one editor.
const db = {
  prepare: () => ({
    bind: (email: string) => ({
      first: async () => (email === "editor@localhost" ? { email, role: "admin" } : null),
    }),
  }),
};
const env = (over: Record<string, string>) => ({ DB: db, ENVIRONMENT: "production", ...over }) as never;

test("production without Access config fails closed", async () => {
  const r = await authenticate(new Request("https://notes.example/edit"), env({ DEV_EDITOR_EMAIL: "editor@localhost" }));
  assert.equal(r.ok, false);
  assert.equal(!r.ok && r.status, 500);
});

test("dev bypass only on localhost", async () => {
  const dev = env({ ENVIRONMENT: "development", DEV_EDITOR_EMAIL: "editor@localhost" });
  const local = await authenticate(new Request("http://localhost:8787/edit"), dev);
  assert.equal(local.ok, true);
  const remote = await authenticate(new Request("https://notes.example/edit"), dev);
  assert.equal(remote.ok, false);
});

test("missing or forged token is rejected", async () => {
  const e = env({ ACCESS_TEAM_DOMAIN: "https://team.cloudflareaccess.com", ACCESS_AUD: "aud" });
  const none = await authenticate(new Request("https://notes.example/edit"), e);
  assert.equal(!none.ok && none.status, 401);
  const forged = await authenticate(
    new Request("https://notes.example/edit", { headers: { "Cf-Access-Jwt-Assertion": "eyJhbGciOiJub25lIn0.eyJlbWFpbCI6ImEifQ." } }),
    e,
  );
  assert.equal(!forged.ok && forged.status, 401);
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
