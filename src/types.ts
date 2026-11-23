export interface Env {
  DB: D1Database;
  ASSETS: Fetcher;
  ENVIRONMENT: string; // "production" unless overridden by `npm run dev`
  DEV_EDITOR_EMAIL?: string; // local development only
  ACCESS_TEAM_DOMAIN?: string; // e.g. https://myteam.cloudflareaccess.com
  ACCESS_AUD?: string; // Cloudflare Access application audience tag
}

export const RESULT_TYPES = [
  "definition", "lemma", "proposition", "theorem", "corollary", "conjecture", "remark", "example",
] as const;
export type ResultType = (typeof RESULT_TYPES)[number];

export const PROOF_STATUSES = ["ai_generated", "polishing", "polished"] as const;
export type ProofStatus = (typeof PROOF_STATUSES)[number];
export const STATUS_BADGES: Record<ProofStatus, string> = {
  ai_generated: "🤖 AI-generated",
  polishing: "🛠 Under polishing",
  polished: "✅ Polished",
};

export const GENERATORS = ["human", "claude", "gpt"] as const;
export type Generator = (typeof GENERATORS)[number];

export type Role = "editor" | "reviewer" | "admin";
export interface User {
  email: string;
  role: Role;
}

export interface SectionRow {
  id: number;
  tag: string;
  parent_id: number | null;
  kind: "chapter" | "section";
  title: string;
  intro_tex: string;
  intro_html_cache: string | null;
  position: number;
  revision: number;
  updated_at: string;
  updated_by: string | null;
}

export interface ResultRow {
  id: number;
  tag: string;
  type: ResultType;
  title: string;
  statement_tex: string;
  statement_html_cache: string | null;
  section_id: number;
  position: number;
  visibility: "published" | "draft";
  state: "active" | "retired";
  replaced_by_id: number | null;
  revision: number;
  updated_at: string;
  updated_by: string | null;
}

export interface ProofRow {
  id: number;
  result_id: number;
  position: number;
  body_tex: string;
  body_html_cache: string | null;
  status: ProofStatus;
  generated_by: Generator;
  generator_detail: string | null;
  reviewed_by: string | null;
  review_notes: string | null;
  visibility: "published" | "draft";
  revision: number;
  updated_at: string;
}
