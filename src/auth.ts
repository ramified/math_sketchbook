// Editor authentication: one password, stored as the Cloudflare secret EDITOR_PASSWORD.
//
// Logging in at /login with the right password sets a session cookie "<expiry>.<signature>", where the signature
// is an HMAC-SHA256 of the expiry keyed by the password. So nothing is stored on the server, and changing the
// password logs out every existing session. Anything unverifiable is rejected (fail closed).

import type { Env, User } from "./types.ts";

export const SESSION_COOKIE = "grh_session";
export const SESSION_SECONDS = 30 * 24 * 3600;
export const MIN_PASSWORD_LENGTH = 16;

const enc = new TextEncoder();

function isLocalhost(url: URL): boolean {
  return url.hostname === "localhost" || url.hostname === "127.0.0.1" || url.hostname === "[::1]";
}

/** The configured password, or null when it is missing or too short to be safe on the open internet. */
function configuredPassword(env: Env): string | null {
  const p = env.EDITOR_PASSWORD ?? "";
  return p.length >= MIN_PASSWORD_LENGTH ? p : null;
}

export function loginConfigured(env: Env): boolean {
  return configuredPassword(env) !== null;
}

export const NOT_CONFIGURED =
  `Editor login is not configured. Set the EDITOR_PASSWORD secret (at least ${MIN_PASSWORD_LENGTH} characters): ` +
  "npx wrangler secret put EDITOR_PASSWORD";

function editorUser(env: Env): User {
  return { email: env.EDITOR_NAME || "admin", role: "admin" };
}

export type AuthResult = { ok: true; user: User } | { ok: false; status: 401 | 403 | 500; message: string };

export async function authenticate(req: Request, env: Env, now = Date.now()): Promise<AuthResult> {
  // Local development bypass: only when explicitly enabled by `npm run dev` AND the request is to localhost.
  if (env.ENVIRONMENT === "development" && env.DEV_EDITOR_EMAIL && isLocalhost(new URL(req.url))) {
    return { ok: true, user: { email: env.DEV_EDITOR_EMAIL, role: "admin" } };
  }
  const password = configuredPassword(env);
  if (!password) return { ok: false, status: 500, message: NOT_CONFIGURED };
  const cookie = readCookie(req, SESSION_COOKIE);
  if (!cookie || !(await verifySession(password, cookie, now))) return { ok: false, status: 401, message: "Not logged in." };
  return { ok: true, user: editorUser(env) };
}

/** Constant-time password check. Returns false when no password is configured. */
export async function checkPassword(env: Env, given: string): Promise<boolean> {
  const password = configuredPassword(env);
  if (!password) return false;
  const [a, b] = await Promise.all([digest(password), digest(given)]);
  let diff = 0;
  for (let i = 0; i < a.length; i++) diff |= a[i] ^ b[i];
  return diff === 0;
}

/** Value for a fresh session cookie. Call only after checkPassword succeeded. */
export async function createSession(env: Env, now = Date.now()): Promise<string> {
  const password = configuredPassword(env);
  if (!password) throw new Error("Editor login is not configured.");
  const expires = Math.floor(now / 1000) + SESSION_SECONDS;
  const sig = new Uint8Array(await crypto.subtle.sign("HMAC", await hmacKey(password), enc.encode(payload(expires))));
  return `${expires}.${base64url(sig)}`;
}

export function sessionCookieHeader(value: string): string {
  return `${SESSION_COOKIE}=${value}; Path=/; HttpOnly; Secure; SameSite=Lax; Max-Age=${SESSION_SECONDS}`;
}

export function clearSessionCookieHeader(): string {
  return `${SESSION_COOKIE}=; Path=/; HttpOnly; Secure; SameSite=Lax; Max-Age=0`;
}

async function verifySession(password: string, value: string, now: number): Promise<boolean> {
  const m = /^(\d{1,12})\.([A-Za-z0-9_-]{43})$/.exec(value);
  if (!m) return false;
  const expires = Number(m[1]);
  if (expires * 1000 <= now) return false;
  const sig = fromBase64url(m[2]);
  if (!sig) return false;
  return crypto.subtle.verify("HMAC", await hmacKey(password), sig, enc.encode(payload(expires)));
}

function payload(expires: number): string {
  return `grh-notes session v1|${expires}`;
}

function hmacKey(password: string): Promise<CryptoKey> {
  return crypto.subtle.importKey("raw", enc.encode(password), { name: "HMAC", hash: "SHA-256" }, false, ["sign", "verify"]);
}

async function digest(s: string): Promise<Uint8Array> {
  return new Uint8Array(await crypto.subtle.digest("SHA-256", enc.encode(s)));
}

function base64url(bytes: Uint8Array): string {
  return btoa(String.fromCharCode(...bytes)).replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/, "");
}

function fromBase64url(s: string): Uint8Array | null {
  try {
    const bin = atob(s.replace(/-/g, "+").replace(/_/g, "/") + "=".repeat((4 - (s.length % 4)) % 4));
    return Uint8Array.from(bin, (ch) => ch.charCodeAt(0));
  } catch {
    return null;
  }
}

export function canEdit(user: User): boolean {
  return user.role === "editor" || user.role === "admin";
}

function readCookie(req: Request, name: string): string | null {
  const header = req.headers.get("Cookie") ?? "";
  for (const part of header.split(";")) {
    const [k, ...v] = part.trim().split("=");
    if (k === name) return v.join("=");
  }
  return null;
}
