// Draws the ramp sum R_1(x), the Chebyshev function Psi_1(x) and the fractional-part sum
// E(n) = sum_{r<=n} Lambda(r){n/r} on one plane, for 1 <= x <= N (lemma JMUK, example RF2G).
// R_1 is continuous and piecewise linear, Psi_1 is a step function, E(n) is drawn as dots at the integers.
// Output: public/static/figures/ramp-fractional.svg      Run: node scripts/plot-ramp-fractional.mjs
import { writeFileSync, mkdirSync } from "node:fs";

const N = 40;
// von Mangoldt function
const Lambda = new Array(N + 1).fill(0);
for (let p = 2; p <= N; p++) {
  let prime = true;
  for (let d = 2; d * d <= p; d++) if (p % d === 0) { prime = false; break; }
  if (prime) for (let q = p; q <= N; q *= p) Lambda[q] = Math.log(p);
}
const Psi = (x) => { let s = 0; for (let r = 2; r <= x; r++) s += Lambda[r]; return s; };
const R = (x) => { let s = 0; for (let r = 2; r <= x; r++) s += Lambda[r] * (x / r - 1); return s; };
const E = (n) => { let s = 0; for (let r = 2; r <= n; r++) s += Lambda[r] * (n / r - Math.floor(n / r)); return s; };
const lnFact = (n) => { let s = 0; for (let i = 2; i <= n; i++) s += Math.log(i); return s; };

// check the identity R_1(n) = ln(n!) - Psi_1(n) + E(n)
let maxErr = 0;
for (let n = 1; n <= N; n++) maxErr = Math.max(maxErr, Math.abs(R(n) - (lnFact(n) - Psi(n) + E(n))));

const W = 640, PH = 300, TOP = 12, LEFT = 50, RIGHT = 20, H = TOP + PH + 46;
const xmin = 0, xmax = N, ymin = 0, ymax = 100;
const pw = W - LEFT - RIGHT;
const X = (x) => LEFT + ((x - xmin) / (xmax - xmin)) * pw;
const Y = (y) => TOP + PH - ((y - ymin) / (ymax - ymin)) * PH;
const f = (v) => v.toFixed(2);
const out = [];

out.push(`<g class="grid">`);
for (let v = 0; v <= ymax; v += 20) out.push(`<line x1="${LEFT}" x2="${LEFT + pw}" y1="${f(Y(v))}" y2="${f(Y(v))}"/>`);
for (let v = 0; v <= N; v += 5) out.push(`<line y1="${TOP}" y2="${TOP + PH}" x1="${f(X(v))}" x2="${f(X(v))}"/>`);
out.push(`</g><rect class="frame" x="${LEFT}" y="${TOP}" width="${pw}" height="${PH}"/>`);
out.push(`<g class="ticks">`);
for (let v = 0; v <= ymax; v += 20) out.push(`<text x="${LEFT - 6}" y="${f(Y(v) + 4)}" text-anchor="end">${v}</text>`);
for (let v = 0; v <= N; v += 5) out.push(`<text x="${f(X(v))}" y="${TOP + PH + 17}" text-anchor="middle">${v}</text>`);
out.push(`</g><text class="var" x="${LEFT + pw / 2}" y="${TOP + PH + 37}" text-anchor="middle">x</text>`);
out.push(`<clipPath id="clip"><rect x="${LEFT}" y="${TOP}" width="${pw}" height="${PH}"/></clipPath>`);

// R_1: piecewise linear with kinks at prime powers, sampled finely
const rp = [];
for (let i = 0; i <= 1600; i++) { const x = 1 + ((N - 1) * i) / 1600; rp.push(`${f(X(x))},${f(Y(R(x)))}`); }
out.push(`<polyline class="c1" clip-path="url(#clip)" points="${rp.join(" ")}"/>`);

// Psi_1: right-continuous steps at the prime powers
const sp = [`${f(X(1))},${f(Y(0))}`];
let cur = 0;
for (let r = 2; r <= N; r++) if (Lambda[r] > 0) {
  sp.push(`${f(X(r))},${f(Y(cur))}`);
  cur += Lambda[r];
  sp.push(`${f(X(r))},${f(Y(cur))}`);
}
sp.push(`${f(X(N))},${f(Y(cur))}`);
out.push(`<polyline class="c2" clip-path="url(#clip)" points="${sp.join(" ")}"/>`);

// E(n): dots at the integers
for (let n = 1; n <= N; n++) out.push(`<circle class="dot" cx="${f(X(n))}" cy="${f(Y(E(n)))}" r="3"/>`);

// legend (top left)
const lx = LEFT + 16; let ly = TOP + 20;
out.push(`<line class="c1" x1="${lx}" x2="${lx + 26}" y1="${ly}" y2="${ly}"/><text class="legend" x="${lx + 32}" y="${ly + 4}">R₁(x), the ramp sum</text>`); ly += 20;
out.push(`<line class="c2" x1="${lx}" x2="${lx + 26}" y1="${ly}" y2="${ly}"/><text class="legend" x="${lx + 32}" y="${ly + 4}">Ψ₁(x)</text>`); ly += 20;
out.push(`<circle class="dot" cx="${lx + 13}" cy="${ly}" r="3"/><text class="legend" x="${lx + 32}" y="${ly + 4}">E(n) at the integers n</text>`);

const svg = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${W} ${H}" width="${W}" height="${H}" role="img" aria-label="The ramp sum R_1(x), the Chebyshev function Psi_1(x) and the fractional-part sum E(n) for x up to ${N}">
<style>
  text { font-family: system-ui, -apple-system, "Segoe UI", sans-serif; font-size: 13px; fill: #1f2328; }
  .ticks text { fill: #6a6f76; font-size: 12px; }
  .var { font-style: italic; fill: #6a6f76; font-size: 12px; }
  .grid line { stroke: #e3e1da; stroke-width: 1; }
  .frame { fill: none; stroke: #8a8f96; stroke-width: 1; }
  polyline, line.c1, line.c2 { fill: none; stroke-width: 2.2; stroke-linejoin: round; }
  .c1 { stroke: #2b5d9b; } .c2 { stroke: #d9822b; }
  .dot { fill: #c0392b; }
  @media (prefers-color-scheme: dark) {
    text { fill: #e4e6e9; } .ticks text, .var { fill: #9aa0a8; }
    .grid line { stroke: #2a2e35; } .frame { stroke: #6a7078; }
    .c1 { stroke: #7fb0ec; } .c2 { stroke: #f0a35e; } .dot { fill: #ef7f72; }
  }
</style>
${out.join("\n")}
</svg>
`;
mkdirSync(new URL("../public/static/figures/", import.meta.url), { recursive: true });
writeFileSync(new URL("../public/static/figures/ramp-fractional.svg", import.meta.url), svg, "utf8");
console.log(`R_1(${N}) = ${R(N).toFixed(2)}, Psi_1(${N}) = ${Psi(N).toFixed(2)}, E(${N}) = ${E(N).toFixed(2)}, max E/n = ${Math.max(...Array.from({ length: N }, (_, i) => E(i + 1) / (i + 1))).toFixed(3)}`);
console.log(`identity check max |R_1(n) - (ln n! - Psi_1(n) + E(n))| = ${maxErr.toExponential(2)}`);
