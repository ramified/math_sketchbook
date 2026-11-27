// Draws the kernel K_k(u) = u^k e^{-σu}/k! used in the one-sided bound (lemma 8JT2), as two separate panels without
// titles (the titles are written in LaTeX in the proof, so KaTeX renders the formulas):
// (a) K_1, K_2, K_3 with σ = 1: the peak sits at u = k/σ.
// (b) K_k for k = 3, 30, 300, rescaled to peak height 1 and plotted against u/U where k = σU:
//     the peak is at the centre 1 of the window W = [1-a, 1+a] with a = 1/5 (i.e. Y^{4/5} <= x <= Y^{6/5}), and it gets sharper as k grows.
// Output: public/static/figures/gamma-kernel-a.svg, gamma-kernel-b.svg      Run: node scripts/plot-gamma-kernel.mjs
import { writeFileSync, mkdirSync, rmSync } from "node:fs";

function lfact(k) { let s = 0; for (let i = 2; i <= k; i++) s += Math.log(i); return s; }
const K = (k, sigma) => (u) => (u <= 0 ? 0 : Math.exp(k * Math.log(u) - sigma * u - lfact(k)));

const W = 640, PH = 230, TOP = 12, LEFT = 58, RIGHT = 20;
const H = TOP + PH + 46;
let out = [];
const f = (v) => v.toFixed(2);

function panel({ y0, xmin, xmax, ymin, ymax, xticks, yticks, xlabel, label, curves, band, vlines = [] }) {
  const pw = W - LEFT - RIGHT;
  const X = (x) => LEFT + ((x - xmin) / (xmax - xmin)) * pw;
  const Y = (y) => y0 + PH - ((y - ymin) / (ymax - ymin)) * PH;
  if (band) {
    out.push(`<rect class="band" x="${f(X(band.a))}" y="${y0}" width="${f(X(band.b) - X(band.a))}" height="${PH}"/>`);
  }
  out.push(`<g class="grid">`);
  for (const t of yticks) out.push(`<line x1="${LEFT}" x2="${LEFT + pw}" y1="${f(Y(t.v))}" y2="${f(Y(t.v))}"/>`);
  for (const t of xticks) out.push(`<line y1="${y0}" y2="${y0 + PH}" x1="${f(X(t.v))}" x2="${f(X(t.v))}"/>`);
  out.push(`</g><rect class="frame" x="${LEFT}" y="${y0}" width="${pw}" height="${PH}"/>`);
  for (const v of vlines) {
    out.push(`<line class="${v.cls}" x1="${f(X(v.x))}" x2="${f(X(v.x))}" y1="${y0}" y2="${y0 + PH}"/>`);
    if (v.label) out.push(`<text class="vlabel" x="${f(X(v.x) + 4)}" y="${y0 + 14}">${v.label}</text>`);
  }
  out.push(`<g class="ticks">`);
  for (const t of yticks) out.push(`<text x="${LEFT - 6}" y="${f(Y(t.v) + 4)}" text-anchor="end">${t.s}</text>`);
  for (const t of xticks) out.push(`<text x="${f(X(t.v))}" y="${y0 + PH + 17}" text-anchor="middle">${t.s}</text>`);
  out.push(`</g><text class="var" x="${LEFT + pw / 2}" y="${y0 + PH + 37}" text-anchor="middle">${xlabel}</text>`);
  if (label) out.push(`<text class="title" x="${LEFT}" y="${y0 - 10}">${label}</text>`);
  out.push(`<clipPath id="c${y0}"><rect x="${LEFT}" y="${y0}" width="${pw}" height="${PH}"/></clipPath>`);
  for (const c of curves) {
    const pts = [];
    for (let i = 0; i <= 800; i++) { const x = xmin + ((xmax - xmin) * i) / 800; pts.push(`${f(X(x))},${f(Y(c.fn(x)))}`); }
    out.push(`<polyline class="${c.cls}" clip-path="url(#c${y0})" points="${pts.join(" ")}"/>`);
  }
  // legend (top right)
  let ly = y0 + 18;
  for (const c of curves) {
    const lx = LEFT + pw - 150;
    out.push(`<line class="${c.cls}" x1="${lx}" x2="${lx + 26}" y1="${ly}" y2="${ly}"/><text class="legend" x="${lx + 32}" y="${ly + 4}">${c.name}</text>`);
    ly += 20;
  }
  if (band) {
    const lx = LEFT + pw - 150;
    out.push(`<rect class="band" x="${lx}" y="${ly - 7}" width="26" height="14"/><text class="legend" x="${lx + 32}" y="${ly + 4}">${band.label}</text>`);
  }
}

const panels = {};
// (a) σ = 1, k = 1, 2, 3
out = [];
panel({
  y0: TOP, xmin: 0, xmax: 10, ymin: 0, ymax: 0.4,
  xticks: [0, 2, 4, 6, 8, 10].map((v) => ({ v, s: String(v) })),
  yticks: [0, 0.1, 0.2, 0.3, 0.4].map((v) => ({ v, s: v.toFixed(1) })),
  xlabel: "u", label: "",
  curves: [
    { cls: "c1", fn: K(1, 1), name: "k = 1" },
    { cls: "c2", fn: K(2, 1), name: "k = 2" },
    { cls: "c3", fn: K(3, 1), name: "k = 3" },
  ],
  vlines: [1, 2, 3].map((x) => ({ x, cls: "peak" })),
});
panels.a = { body: out.join("\n"), aria: "The kernels K_1, K_2, K_3 for sigma = 1, with dashed lines at their peaks u = 1, 2, 3" };

// (b) rescaled kernels against u/U, with k = σU; peak height normalised to 1.
const norm = (k) => (t) => { // t = u/U, u = t·U, k/σ = U  =>  K_k(u)/K_k(k/σ) = t^k e^{-k(t - 1)}
  const r = t; return r <= 0 ? 0 : Math.exp(k * (Math.log(r) - r + 1));
};
out = [];
panel({
  y0: TOP, xmin: 0, xmax: 2, ymin: 0, ymax: 1.1,
  xticks: [{ v: 0, s: "0" }, { v: 0.5, s: "U/2" }, { v: 0.8, s: "4U/5" }, { v: 1, s: "U" }, { v: 1.2, s: "6U/5" }, { v: 1.5, s: "3U/2" }, { v: 2, s: "2U" }],
  yticks: [0, 0.25, 0.5, 0.75, 1].map((v) => ({ v, s: v === 0 || v === 1 ? String(v) : v.toFixed(2) })),
  xlabel: "u", label: "",
  band: { a: 0.8, b: 1.2, label: "W" },
  curves: [
    { cls: "c3", fn: norm(3), name: "k = 3" },
    { cls: "c4", fn: norm(30), name: "k = 30" },
    { cls: "c5", fn: norm(300), name: "k = 300" },
  ],
  vlines: [{ x: 1, cls: "mid", label: "centre" }],
});
panels.b = { body: out.join("\n"), aria: "Rescaled kernels for k = 3, 30, 300 with their peak at U, the centre of the shaded interval W = [4U/5, 6U/5]" };

const svgOf = (pnl) => `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${W} ${H}" width="${W}" height="${H}" role="img" aria-label="${pnl.aria}">
<style>
  text { font-family: system-ui, -apple-system, "Segoe UI", sans-serif; font-size: 13px; fill: #1f2328; }
  .ticks text { fill: #6a6f76; font-size: 12px; }
  .var { font-style: italic; fill: #6a6f76; font-size: 12px; }
  .title { font-size: 14px; font-weight: 600; }
  .sup, .sub { font-size: 10px; }
  .grid line { stroke: #e3e1da; stroke-width: 1; }
  .frame { fill: none; stroke: #8a8f96; stroke-width: 1; }
  .band { fill: #e8eff8; }
  .bandlabel { fill: #2b5d9b; font-size: 12px; }
  .peak { stroke: #8a8f96; stroke-width: 1; stroke-dasharray: 3 3; }
  .mid { stroke: #2b5d9b; stroke-width: 1.4; stroke-dasharray: 5 3; }
  .vlabel { fill: #2b5d9b; font-size: 12px; }
  polyline, line.c1, line.c2, line.c3, line.c4, line.c5 { fill: none; stroke-width: 2.2; stroke-linejoin: round; }
  .c1 { stroke: #d9822b; } .c2 { stroke: #2f8a57; } .c3 { stroke: #2b5d9b; }
  .c4 { stroke: #9a6fb0; } .c5 { stroke: #c0392b; }
  @media (prefers-color-scheme: dark) {
    text { fill: #e4e6e9; } .ticks text, .var { fill: #9aa0a8; }
    .grid line { stroke: #2a2e35; } .frame { stroke: #6a7078; }
    .band { fill: #1f2a38; } .bandlabel, .vlabel { fill: #7fb0ec; } .mid { stroke: #7fb0ec; } .peak { stroke: #6a7078; }
    .c1 { stroke: #f0a35e; } .c2 { stroke: #6cc58f; } .c3 { stroke: #7fb0ec; } .c4 { stroke: #c49be0; } .c5 { stroke: #ef7f72; }
  }
</style>
${pnl.body}
</svg>
`;
mkdirSync(new URL("../public/static/figures/", import.meta.url), { recursive: true });
writeFileSync(new URL("../public/static/figures/gamma-kernel-a.svg", import.meta.url), svgOf(panels.a), "utf8");
writeFileSync(new URL("../public/static/figures/gamma-kernel-b.svg", import.meta.url), svgOf(panels.b), "utf8");
rmSync(new URL("../public/static/figures/gamma-kernel.svg", import.meta.url), { force: true }); // old combined figure
console.log("peaks of K_1..K_3 (σ=1):", [1, 2, 3].map((k) => K(k, 1)(k).toFixed(4)).join(", "));
