-- Appendix chapters are numbered A, B, ... after the ordinary chapters.
ALTER TABLE sections ADD COLUMN appendix INTEGER NOT NULL DEFAULT 0 CHECK (appendix IN (0, 1));
