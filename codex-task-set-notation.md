In the math notes book of this repo (a Cloudflare Workers app; D1 database "grh-notes", see wrangler.toml), rewrite every set written in set-builder notation into the form
  \left\{ <objects> \;\middle|\; <condition> \right\}
and, where the ambient set is known from context, state it in the left part, e.g. \left\{x \in X \;\middle|\; x \in S\right\} rather than \{x : x \in S\} or \{x \mid ...\}. Convert things like \{x : P(x)\}, \{x \mid P(x)\}, \{n \le N : ...\}, \{\chi : \chi(-1)=1\} -> \left\{\chi \in <the character group the text defines> \;\middle|\; \chi(-1)=1\right\}. Do NOT touch sets given by listing elements (\{1,2,3\}), \{0\}, grouping braces, or braces outside math. Change nothing else (no math, no wording). If the ambient set is unclear, keep the left part as is and list the case.

Edit the DEPLOYED (remote) database directly. The repo's seed/seed.sql and local DB are only a small sample; the real book is only remote (`npx wrangler d1 execute grh-notes --remote ...`; wrangler is logged in).

Procedure:
1. Read src/ (esp. src/book.ts and the code that saves edits to results/proofs/sections) and migrations/ to learn which columns hold TeX, how revisions/history are recorded, and how *_html_cache columns are produced/invalidated. Direct edits must leave the app consistent: bump revision, write history rows if the app does, set updated_at, clear/regenerate HTML caches as the app expects.
2. BEFORE changing anything, export a full backup: `npx wrangler d1 export grh-notes --remote --output backup-before-set-notation-2026-11-24.sql` in the repo root.
3. Pull all TeX fields with --json, compute rewrites in a Node script, write the exact UPDATE statements to scripts/set-notation-2026-11-24.sql (escape quotes for SQLite), review each diff.
4. Apply the file remotely, re-query changed rows to verify text and cache state.

Report: rows/fields changed per table, before->after for every conversion (tag + snippet), ambiguous cases left unchanged, handling of revisions/history/caches, backup path, errors.
