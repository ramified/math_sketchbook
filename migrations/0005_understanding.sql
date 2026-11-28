-- Understanding is editor-only. It folds content for readers when fold_drafts = '1'.
ALTER TABLE results ADD COLUMN understanding TEXT NOT NULL DEFAULT 'unclear' CHECK (understanding IN ('unclear', 'partial', 'clear'));
ALTER TABLE proofs ADD COLUMN understanding TEXT NOT NULL DEFAULT 'unclear' CHECK (understanding IN ('unclear', 'partial', 'clear'));

UPDATE proofs SET understanding = 'clear' WHERE status = 'polished';
INSERT OR IGNORE INTO settings (key, value) VALUES ('fold_drafts', '0');
