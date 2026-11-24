// Draws R_1, the main term M_1 and G_1 = R_1 - M_1 for the trivial character (example after Lemma 1.2.2).
// Output: public/static/figures/smoothed-prime-sum-trivial.svg
// Run: node scripts/plot-smoothed-prime-sum.mjs
import { writeFileSync, mkdirSync } from "node:fs";

const GAMMA = 0.5772156649015329;
const N = 1000;

// von Mangoldt function up to N
const LAMBDA = new Float64Array(N + 1);
{
  const composite = new Uint8Array(N + 1);
  for (let p = 2; p <= N; p++) {
    if (composite[p]) continue;
    for (let m = p * p; m <= N; m += p) composite[m] = 1;
    for (let q = p; q <= N; q *= p) LAMBDA[q] = Math.log(p);
  }
}
const R = (x) => {
  let s = 0;
  for (let n = 2; n <= x; n++) if (LAMBDA[n]) s += LAMBDA[n] * (x / n - 1);
  return s;
};
const M = (x) => x * Math.log(x) - (1 + GAMMA) * x;
const G = (x) => R(x) - M(x);

/** Sample points: a fine grid plus every prime power (where R_1 has a corner). */
function samples(a, b, step) {
  const xs = new Set();
  for (let x = a; x <= b + 1e-9; x += step) xs.add(+x.toFixed(6));
  for (let n = Math.ceil(a); n <= b; n++) if (LAMBDA[n]) xs.add(n);
  return [...xs].sort((u, v) => u - v);
}

const W = 640, PH = 250, GAP = 70, TOP = 30, LEFT = 62, RIGHT = 20;
const H = TOP + PH + GAP + PH + 46;
const out = [];
const f = (v) => v.toFixed(2);

function panel({ y0, xmin, xmax, ymin, ymax, xticks, yticks, curves, label, hline }) {
  const pw = W - LEFT - RIGHT;
  const X = (x) => LEFT + ((x - xmin) / (xmax - xmin)) * pw;
  const Y = (y) => y0 + PH - ((y - ymin) / (ymax - ymin)) * PH;
  out.push(`<g class="grid">`);
  for (const t of yticks) out.push(`<line x1="${LEFT}" x2="${LEFT + pw}" y1="${f(Y(t))}" y2="${f(Y(t))}"/>`);
  for (const t of xticks) out.push(`<line y1="${y0}" y2="${y0 + PH}" x1="${f(X(t))}" x2="${f(X(t))}"/>`);
  out.push(`</g><g class="axis">`);
  out.push(`<rect x="${LEFT}" y="${y0}" width="${pw}" height="${PH}" fill="none"/>`);
  out.push(`</g><g class="ticks">`);
  for (const t of yticks) out.push(`<text x="${LEFT - 6}" y="${f(Y(t) + 4)}" text-anchor="end">${t}</text>`);
  for (const t of xticks) out.push(`<text x="${f(X(t))}" y="${y0 + PH + 17}" text-anchor="middle">${t}</text>`);
  out.push(`<text x="${LEFT + pw / 2}" y="${y0 + PH + 36}" text-anchor="middle" class="var">x</text>`);
  out.push(`</g>`);
  out.push(`<text x="${LEFT}" y="${y0 - 10}" class="title">${label}</text>`);
  if (hline) {
    out.push(`<line class="ref" x1="${LEFT}" x2="${LEFT + pw}" y1="${f(Y(hline.y))}" y2="${f(Y(hline.y))}"/>`);
  }
  out.push(`<clipPath id="clip${y0}"><rect x="${LEFT}" y="${y0}" width="${pw}" height="${PH}"/></clipPath>`);
  for (const c of curves) {
    const pts = samples(xmin, xmax, c.step).map((x) => `${f(X(x))},${f(Y(c.fn(x)))}`);
    out.push(`<polyline class="${c.cls}" clip-path="url(#clip${y0})" points="${pts.join(" ")}"/>`);
  }
  // legend
  let lx = LEFT + 12;
  const ly = y0 + 18;
  for (const c of curves) {
    out.push(`<line class="${c.cls}" x1="${lx}" x2="${lx + 26}" y1="${ly}" y2="${ly}"/>`);
    out.push(`<text x="${lx + 32}" y="${ly + 4}" class="legend">${c.name}</text>`);
    lx += 32 + c.name.length * 7.2 + 26;
  }
  if (hline) {
    out.push(`<rect class="legend-bg" x="${lx - 6}" y="${ly - 11}" width="${40 + hline.label.length * 7.2}" height="22"/>`);
    out.push(`<line class="ref" x1="${lx}" x2="${lx + 26}" y1="${ly}" y2="${ly}"/>`);
    out.push(`<text x="${lx + 32}" y="${ly + 4}" class="legend">${hline.label}</text>`);
  }
}

panel({
  y0: TOP, xmin: 1, xmax: 50, ymin: -10, ymax: 130,
  xticks: [1, 10, 20, 30, 40, 50], yticks: [0, 25, 50, 75, 100, 125],
  label: "(a)  R₁(x) and the main term M₁(x) = x log x − (1+γ)x",
  curves: [
    { cls: "c-m", fn: M, step: 0.05, name: "M₁(x)" },
    { cls: "c-r", fn: R, step: 0.05, name: "R₁(x)" },
  ],
});
panel({
  y0: TOP + PH + GAP, xmin: 1, xmax: 1000, ymin: 1.2, ymax: 2.4,
  xticks: [1, 200, 400, 600, 800, 1000], yticks: [1.2, 1.4, 1.6, 1.8, 2.0, 2.2, 2.4],
  label: "(b)  G₁(x) = R₁(x) − M₁(x)",
  hline: { y: Math.log(2 * Math.PI), label: "log 2π ≈ 1.838" },
  curves: [{ cls: "c-g", fn: G, step: 0.25, name: "G₁(x)" }],
});

const svg = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${W} ${H}" width="${W}" height="${H}" role="img" aria-label="Graphs of R_1, M_1 and G_1">
<style>
  text { font-family: system-ui, -apple-system, "Segoe UI", sans-serif; font-size: 13px; fill: #1f2328; }
  .ticks text { fill: #6a6f76; font-size: 12px; }
  .var { font-style: italic; }
  .title { font-size: 14px; font-weight: 600; }
  .legend { font-size: 13px; }
  .grid line { stroke: #e3e1da; stroke-width: 1; }
  .axis rect { stroke: #8a8f96; stroke-width: 1; }
  polyline, line.c-r, line.c-m, line.c-g { fill: none; stroke-width: 2.2; stroke-linejoin: round; }
  .c-r { stroke: #2b5d9b; }
  .c-m { stroke: #d9822b; stroke-dasharray: 7 4; }
  .c-g { stroke: #2f8a57; stroke-width: 1.6; }
  .ref { stroke: #9a6fb0; stroke-width: 1.4; stroke-dasharray: 3 3; }
  .legend-bg { fill: #fdfcf8; opacity: 0.85; }
  @media (prefers-color-scheme: dark) {
    text { fill: #e4e6e9; }
    .ticks text { fill: #9aa0a8; }
    .grid line { stroke: #2a2e35; }
    .axis rect { stroke: #6a7078; }
    .c-r { stroke: #7fb0ec; }
    .c-m { stroke: #f0a35e; }
    .c-g { stroke: #6cc58f; }
    .ref { stroke: #c49be0; }
    .legend-bg { fill: #16181c; }
  }
</style>
${out.join("\n")}
</svg>
`;
mkdirSync(new URL("../public/static/figures/", import.meta.url), { recursive: true });
writeFileSync(new URL("../public/static/figures/smoothed-prime-sum-trivial.svg", import.meta.url), svg, "utf8");

// Numbers quoted in the example text.
let gmin = Infinity, gmax = -Infinity, gminAt = 0, gmaxAt = 0;
for (const x of samples(3, 1000, 0.01)) {
  const g = G(x);
  if (g < gmin) [gmin, gminAt] = [g, x];
  if (g > gmax) [gmax, gmaxAt] = [g, x];
}
console.log("R_1(50) =", R(50).toFixed(3), " M_1(50) =", M(50).toFixed(3), " G_1(1) =", G(1).toFixed(4));
console.log(`G_1 on [3,1000]: min ${gmin.toFixed(3)} at ${gminAt}, max ${gmax.toFixed(3)} at ${gmaxAt}`);
