// Editor authentication via Cloudflare Access.
//
// Cloudflare Access sits in front of /edit and /api/edit and asks for an email one-time code. It then forwards a
// signed JWT (header Cf-Access-Jwt-Assertion). We verify that JWT's signature, issuer, audience and expiry here,
// and then look the email up in the `users` table to get the role. Anything unverifiable is rejected (fail closed).

import { createRemoteJWKSet, jwtVerify } from "jose";
import type { Env, User, Role } from "./types.ts";

const jwksCache = new Map<string, ReturnType<typeof createRemoteJWKSet>>();

function isLocalhost(url: URL): boolean {
  return url.hostname === "localhost" || url.hostname === "127.0.0.1" || url.hostname === "[::1]";
}

export type AuthResult = { ok: true; user: User } | { ok: false; status: 401 | 403 | 500; message: string };

export async function authenticate(req: Request, env: Env): Promise<AuthResult> {
  const url = new URL(req.url);
  let email: string | null = null;

  // Local development bypass: only when explicitly enabled by `npm run dev` AND the request is to localhost.
  if (env.ENVIRONMENT === "development" && env.DEV_EDITOR_EMAIL && isLocalhost(url)) {
    email = env.DEV_EDITOR_EMAIL;
  } else {
    const team = (env.ACCESS_TEAM_DOMAIN ?? "").replace(/\/+$/, "");
    const aud = env.ACCESS_AUD ?? "";
    if (!team || !aud) {
      return { ok: false, status: 500, message: "Editor login is not configured (ACCESS_TEAM_DOMAIN / ACCESS_AUD)." };
    }
    const token = req.headers.get("Cf-Access-Jwt-Assertion") ?? readCookie(req, "CF_Authorization");
    if (!token) return { ok: false, status: 401, message: "Not logged in." };
    let jwks = jwksCache.get(team);
    if (!jwks) {
      jwks = createRemoteJWKSet(new URL(`${team}/cdn-cgi/access/certs`));
      jwksCache.set(team, jwks);
    }
    try {
      const { payload } = await jwtVerify(token, jwks, {
        issuer: team,
        audience: aud,
        algorithms: ["RS256"],
        requiredClaims: ["exp", "email"],
      });
      email = typeof payload.email === "string" ? payload.email.toLowerCase() : null;
    } catch {
      return { ok: false, status: 401, message: "Login token is invalid or expired. Reload the page to log in again." };
    }
    if (!email) return { ok: false, status: 401, message: "Login token has no email." };
  }

  const row = await env.DB.prepare("SELECT email, role FROM users WHERE lower(email) = lower(?)")
    .bind(email)
    .first<{ email: string; role: Role }>();
  if (!row) return { ok: false, status: 403, message: `${email} is not registered as an editor.` };
  return { ok: true, user: { email: row.email, role: row.role } };
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
