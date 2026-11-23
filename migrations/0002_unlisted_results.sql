-- Unlisted results: published and linkable (own page, click-to-expand), but not numbered and not shown in their
-- section's list on the public site. Useful for small definitions reached through \hyperref[TAG]{text}.
ALTER TABLE results ADD COLUMN listed INTEGER NOT NULL DEFAULT 1 CHECK (listed IN (0, 1));
