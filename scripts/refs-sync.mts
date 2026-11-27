// Recompute the refs graph exactly as rebuildAll does, and emit SQL for the rows whose refs changed.
import { readFileSync, writeFileSync } from "node:fs";
const root = process.argv[2];
const { renderTex } = await import(`file:///${root}/src/latex.ts`);
const { macrosFor } = await import(`file:///${root}/src/book.ts`);
const load = (f: string) => JSON.parse(readFileSync(f, "utf8"))[0].results;
const rs = load(process.argv[3]), ps = load(process.argv[4]), refs = load(process.argv[5]), mac = load(process.argv[6]);
const { macros } = macrosFor(mac[0]?.value ?? "");
const cur = new Map<string, Set<string>>();
for (const r of refs) {
  const k = r.source_proof_id == null ? `R${r.source_result_id}` : `P${r.source_proof_id}`;
  if (!cur.has(k)) cur.set(k, new Set()); cur.get(k)!.add(r.target_tag);
}
const q = (s: string) => `'${s.replace(/'/g, "''")}'`;
const out: string[] = []; const changed: string[] = [];
const same = (a: Set<string>, b: Set<string>) => a.size === b.size && [...a].every(x => b.has(x));
for (const r of rs) {
  const want = new Set<string>(renderTex(r.statement_tex, macros).refs);
  const have = cur.get(`R${r.id}`) ?? new Set();
  if (same(want, have)) continue;
  changed.push(`${r.tag} statement: -[${[...have].filter(x => !want.has(x))}] +[${[...want].filter(x => !have.has(x))}]`);
  out.push(`DELETE FROM refs WHERE source_result_id = ${r.id} AND source_proof_id IS NULL;`);
  for (const t of want) out.push(`INSERT OR IGNORE INTO refs (source_result_id, source_proof_id, target_tag) VALUES (${r.id}, NULL, ${q(t)});`);
}
for (const p of ps) {
  const want = new Set<string>(renderTex(p.body_tex, macros).refs);
  const have = cur.get(`P${p.id}`) ?? new Set();
  if (same(want, have)) continue;
  changed.push(`${p.tag} proof ${p.id}: -[${[...have].filter(x => !want.has(x))}] +[${[...want].filter(x => !have.has(x))}]`);
  out.push(`DELETE FROM refs WHERE source_proof_id = ${p.id};`);
  for (const t of want) out.push(`INSERT OR IGNORE INTO refs (source_result_id, source_proof_id, target_tag) VALUES (${p.result_id}, ${p.id}, ${q(t)});`);
}
writeFileSync(process.argv[7], out.join("\n") + "\n");
console.log(changed.join("\n") || "no changes");
