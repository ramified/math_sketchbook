-- Rebuild results to extend its type constraint. D1 applies the migration in a transaction.
PRAGMA defer_foreign_keys = on;

CREATE TABLE results_new (
  id                          INTEGER PRIMARY KEY,
  tag                         TEXT NOT NULL UNIQUE REFERENCES tags (tag),
  type                        TEXT NOT NULL CHECK (type IN ('definition', 'lemma', 'proposition', 'theorem',
                                                            'corollary', 'conjecture', 'remark', 'example', 'motivation')),
  title                       TEXT NOT NULL DEFAULT '',
  statement_tex               TEXT NOT NULL DEFAULT '',
  statement_html_cache        TEXT,
  section_id                  INTEGER NOT NULL REFERENCES sections (id),
  position                    INTEGER NOT NULL,
  visibility                  TEXT NOT NULL DEFAULT 'published' CHECK (visibility IN ('published', 'draft')),
  state                       TEXT NOT NULL DEFAULT 'active' CHECK (state IN ('active', 'retired')),
  replaced_by_id              INTEGER REFERENCES results (id),
  derived_from_proof_id       INTEGER REFERENCES proofs (id),
  derived_from_proof_revision INTEGER,
  revision                    INTEGER NOT NULL DEFAULT 1,
  created_at                  TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at                  TEXT NOT NULL DEFAULT (datetime('now')),
  created_by                  TEXT,
  updated_by                  TEXT,
  listed                      INTEGER NOT NULL DEFAULT 1 CHECK (listed IN (0, 1))
);

INSERT INTO results_new SELECT * FROM results;
DROP TABLE results;
ALTER TABLE results_new RENAME TO results;
CREATE INDEX results_order ON results (section_id, position, id);

-- SQLite retains deferred violations from DROP TABLE even after the replacement restores
-- the referenced keys. Verify the rebuilt schema before clearing that deferred state.
INSERT OR ROLLBACK INTO write_guard (ok) SELECT 0 FROM pragma_foreign_key_check LIMIT 1;
PRAGMA defer_foreign_keys = off;
