-- grh-notes initial schema.
-- Conventions:
--   * Permanent tags (4 chars from 23456789ABCDEFGHJKMNPQRSTUVWXYZ) identify sections and results in URLs and in
--     LaTeX (\ref{TAG}). Tags are never deleted or reused.
--   * Relationships between rows use integer ids.
--   * Numbers like "Lemma 1.2.3" are NEVER stored: they are computed from positions when a page is served.
--   * *_html_cache columns are rebuildable caches (math already rendered, \ref left as placeholders).
--     Setting them to NULL is always safe.

-- One namespace for every tag (sections and results share it).
CREATE TABLE tags (
  tag        TEXT PRIMARY KEY,
  kind       TEXT NOT NULL CHECK (kind IN ('section', 'result')),
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

-- Readable names usable in \ref{...} while typing; rewritten to the tag on save. /tag/<alias> redirects.
-- Aliases always start with a lowercase letter, so they can never look like a tag.
CREATE TABLE aliases (
  alias      TEXT PRIMARY KEY CHECK (alias GLOB '[a-z]*'),
  tag        TEXT NOT NULL REFERENCES tags (tag),
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE INDEX aliases_tag ON aliases (tag);

-- Book structure: chapters contain sections; results live in sections.
CREATE TABLE sections (
  id               INTEGER PRIMARY KEY,
  tag              TEXT NOT NULL UNIQUE REFERENCES tags (tag),
  parent_id        INTEGER REFERENCES sections (id),
  kind             TEXT NOT NULL CHECK (kind IN ('chapter', 'section')),
  title            TEXT NOT NULL,
  intro_tex        TEXT NOT NULL DEFAULT '',
  intro_html_cache TEXT,
  position         INTEGER NOT NULL,
  revision         INTEGER NOT NULL DEFAULT 1,
  created_at       TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at       TEXT NOT NULL DEFAULT (datetime('now')),
  updated_by       TEXT,
  CHECK ((kind = 'chapter' AND parent_id IS NULL) OR (kind = 'section' AND parent_id IS NOT NULL))
);
CREATE INDEX sections_order ON sections (parent_id, position, id);

CREATE TABLE results (
  id                          INTEGER PRIMARY KEY,
  tag                         TEXT NOT NULL UNIQUE REFERENCES tags (tag),
  type                        TEXT NOT NULL CHECK (type IN ('definition', 'lemma', 'proposition', 'theorem',
                                                            'corollary', 'conjecture', 'remark', 'example')),
  title                       TEXT NOT NULL DEFAULT '',
  statement_tex               TEXT NOT NULL DEFAULT '',
  statement_html_cache        TEXT,
  section_id                  INTEGER NOT NULL REFERENCES sections (id),
  position                    INTEGER NOT NULL,
  -- Unused for now (save = publish). Lets future AI-generated drafts stay hidden until approved.
  visibility                  TEXT NOT NULL DEFAULT 'published' CHECK (visibility IN ('published', 'draft')),
  -- Results are never deleted: a retired result keeps its tag/URL and may point to its replacement.
  state                       TEXT NOT NULL DEFAULT 'active' CHECK (state IN ('active', 'retired')),
  replaced_by_id              INTEGER REFERENCES results (id),
  -- Provenance when a lemma is split out of a proof (points at the exact proof revision).
  derived_from_proof_id       INTEGER REFERENCES proofs (id),
  derived_from_proof_revision INTEGER,
  revision                    INTEGER NOT NULL DEFAULT 1,
  created_at                  TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at                  TEXT NOT NULL DEFAULT (datetime('now')),
  created_by                  TEXT,
  updated_by                  TEXT
);
CREATE INDEX results_order ON results (section_id, position, id);

CREATE TABLE proofs (
  id                INTEGER PRIMARY KEY,
  result_id         INTEGER NOT NULL REFERENCES results (id),
  position          INTEGER NOT NULL,
  body_tex          TEXT NOT NULL DEFAULT '',
  body_html_cache   TEXT,
  -- Editorial status (shown as a badge) is separate from origin (generated_by).
  status            TEXT NOT NULL DEFAULT 'polishing' CHECK (status IN ('ai_generated', 'polishing', 'polished')),
  generated_by      TEXT NOT NULL DEFAULT 'human' CHECK (generated_by IN ('gpt', 'claude', 'human')),
  generator_detail  TEXT,            -- free text for now, e.g. model id
  generation_run_id INTEGER,         -- reserved: will reference a future generation_runs table
  reviewed_by       TEXT,
  review_notes      TEXT,
  visibility        TEXT NOT NULL DEFAULT 'published' CHECK (visibility IN ('published', 'draft')),
  revision          INTEGER NOT NULL DEFAULT 1,
  created_at        TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at        TEXT NOT NULL DEFAULT (datetime('now')),
  created_by        TEXT,
  updated_by        TEXT
);
CREATE INDEX proofs_order ON proofs (result_id, position, id);

-- Citation graph, derived from \ref{...} on every save (fully rebuildable).
-- target_tag is text, not a foreign key, so references to results not written yet can be recorded.
CREATE TABLE refs (
  id               INTEGER PRIMARY KEY,
  source_result_id INTEGER NOT NULL REFERENCES results (id),
  source_proof_id  INTEGER REFERENCES proofs (id),   -- NULL = reference from the statement
  target_tag       TEXT NOT NULL
);
CREATE UNIQUE INDEX refs_from_statement ON refs (source_result_id, target_tag) WHERE source_proof_id IS NULL;
CREATE UNIQUE INDEX refs_from_proof ON refs (source_proof_id, target_tag) WHERE source_proof_id IS NOT NULL;
CREATE INDEX refs_target ON refs (target_tag);

-- Append-only history: a full JSON snapshot for every save. Rows saved together share operation_id.
CREATE TABLE revisions (
  id            INTEGER PRIMARY KEY,
  entity        TEXT NOT NULL CHECK (entity IN ('section', 'result', 'proof', 'setting')),
  entity_key    TEXT NOT NULL,      -- row id for section/result/proof, key for setting
  revision      INTEGER NOT NULL,
  operation_id  TEXT NOT NULL,
  snapshot_json TEXT NOT NULL,
  author        TEXT,
  created_at    TEXT NOT NULL DEFAULT (datetime('now')),
  UNIQUE (entity, entity_key, revision)
);
CREATE INDEX revisions_op ON revisions (operation_id);

-- Site-wide settings edited in the browser: book_title, macros, bibliography, needs_rebuild.
CREATE TABLE settings (
  key      TEXT PRIMARY KEY,
  value    TEXT NOT NULL,
  revision INTEGER NOT NULL DEFAULT 1
);

-- People who may log in to the editor. Readers need no row.
CREATE TABLE users (
  email TEXT PRIMARY KEY,
  role  TEXT NOT NULL CHECK (role IN ('editor', 'reviewer', 'admin'))
);

-- Reserved for the future Reviewer workflow: a review is about one specific proof revision.
CREATE TABLE reviews (
  id             INTEGER PRIMARY KEY,
  proof_id       INTEGER NOT NULL REFERENCES proofs (id),
  proof_revision INTEGER NOT NULL,
  reviewer       TEXT NOT NULL,
  verdict        TEXT NOT NULL CHECK (verdict IN ('approve', 'request_changes', 'comment')),
  notes          TEXT,
  created_at     TEXT NOT NULL DEFAULT (datetime('now'))
);

-- Used to abort a multi-statement save atomically when someone else saved first (optimistic locking):
-- inserting ok = 0 violates the CHECK and rolls back the whole batch.
CREATE TABLE write_guard (
  ok INTEGER NOT NULL CHECK (ok = 1)
);
