INSERT INTO write_guard (ok) SELECT 0 WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key = 'macros' AND revision = 1);
INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author) VALUES ('setting', 'macros', 1, 'leqslant-macros-2026-11-24', '{"key":"macros","value":"% Shared macros, applied to all math on the site.\n\\newcommand{\\N}{\\mathbb{N}}\n\\newcommand{\\Z}{\\mathbb{Z}}\n\\newcommand{\\Q}{\\mathbb{Q}}\n\\newcommand{\\R}{\\mathbb{R}}\n\\newcommand{\\C}{\\mathbb{C}}\n\\newcommand{\\abs}[1]{\\left|#1\\right|}\n\\renewcommand{\\Re}{\\operatorname{Re}}\n\\DeclareMathOperator{\\Li}{Li}\n\\newcommand{\\cond}{\\mathfrak{f}}"}', '(before history)');
UPDATE settings SET value = '% Shared macros, applied to all math on the site.
\newcommand{\N}{\mathbb{N}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\Q}{\mathbb{Q}}
\newcommand{\R}{\mathbb{R}}
\newcommand{\C}{\mathbb{C}}
\newcommand{\abs}[1]{\left|#1\right|}
\renewcommand{\Re}{\operatorname{Re}}
\DeclareMathOperator{\Li}{Li}
\newcommand{\cond}{\mathfrak{f}}

% Author''s preference: slanted inequality signs throughout.
\renewcommand{\le}{\leqslant}
\renewcommand{\leq}{\leqslant}
\renewcommand{\ge}{\geqslant}
\renewcommand{\geq}{\geqslant}
', revision = revision + 1 WHERE key = 'macros';
INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author) VALUES ('setting', 'macros', 2, 'leqslant-macros-2026-11-24', '{"key":"macros","value":"% Shared macros, applied to all math on the site.\n\\newcommand{\\N}{\\mathbb{N}}\n\\newcommand{\\Z}{\\mathbb{Z}}\n\\newcommand{\\Q}{\\mathbb{Q}}\n\\newcommand{\\R}{\\mathbb{R}}\n\\newcommand{\\C}{\\mathbb{C}}\n\\newcommand{\\abs}[1]{\\left|#1\\right|}\n\\renewcommand{\\Re}{\\operatorname{Re}}\n\\DeclareMathOperator{\\Li}{Li}\n\\newcommand{\\cond}{\\mathfrak{f}}\n\n% Author''s preference: slanted inequality signs throughout.\n\\renewcommand{\\le}{\\leqslant}\n\\renewcommand{\\leq}{\\leqslant}\n\\renewcommand{\\ge}{\\geqslant}\n\\renewcommand{\\geq}{\\geqslant}\n"}', 'claude');
UPDATE results SET statement_html_cache = NULL;
UPDATE proofs SET body_html_cache = NULL;
UPDATE sections SET intro_html_cache = NULL;
