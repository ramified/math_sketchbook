-- Local development only: the fake editor account used by `npm run dev`.
INSERT OR IGNORE INTO users (email, role) VALUES ('editor@localhost', 'admin');
