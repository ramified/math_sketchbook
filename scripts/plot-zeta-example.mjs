// Figures for the example "The Riemann zeta function" after Proposition 1.4.10 (tag 8JR6). Three panels, no titles
// inside the SVGs (captions are LaTeX in the example):
// (a) G_1(x) for 1 <= x <= 10^7 (log x axis), with the bound log 2pi +- (0.0462 sqrt(x) + 0.307) that RH gives.
// (b) (G_1(x) - log 2pi)/sqrt(x) for 10 <= x <= 10^7, against the explicit formula with the first zero pair and
//     with the first ten zero pairs.
// (c) |A_k(3/2 + i tau)| for k = 0, 1, 2, 3 and 0 <= tau <= 50 (log scale), with the zero ordinates marked.
// Output: public/static/figures/zeta-smoothed-sum.svg, zeta-oscillation.svg, zeta-taylor-coefficients.svg
// Run: node scripts/plot-zeta-example.mjs   (about 15 s; numerics in scripts/zeta-numerics.mjs)
import { writeFileSync } from "node:fs";
import { C, LOG2PI, GAMMA, zerosUpTo, smoothedSumAt, explicitG, A_poles } from "./zeta-numerics.mjs";

const zeros = zerosUpTo(1000);
if (zeros.length !== 649) throw new Error(`expected 649 zeros below height 1000, found ${zeros.length}`);
const SUM_INV_RHO2 = 2 + GAMMA - Math.log(4 * Math.PI); // sum over all zeros of 1/(rho(1-rho)) = sum 1/|rho|^2 under RH
const TRIV = 1 - Math.log(2); // sum_n 1/(2n(2n+1))

const W = 640, PH = 260, TOP = 34, LEFT = 64, RIGHT = 18;
const H = TOP + PH + 46;
const PW = W - LEFT - RIGHT;
const f = (v) => v.toFixed(2);

function frame(out, { X, Y, xticks, yticks, xlabel }) {
  out.push(`<g class="grid">`);
  for (const t of yticks) out.push(`<line x1="${LEFT}" x2="${LEFT + PW}" y1="${f(Y(t.v))}" y2="${f(Y(t.v))}"/>`);
  for (const t of xticks) out.push(`<line y1="${TOP}" y2="${TOP + PH}" x1="${f(X(t.v))}" x2="${f(X(t.v))}"/>`);
  out.push(`</g><rect class="frame" x="${LEFT}" y="${TOP}" width="${PW}" height="${PH}"/>`);
  out.push(`<g class="ticks">`);
  for (const t of yticks) out.push(`<text x="${LEFT - 6}" y="${f(Y(t.v) + 4)}" text-anchor="end">${t.s}</text>`);
  for (const t of xticks) out.push(`<text x="${f(X(t.v))}" y="${TOP + PH + 17}" text-anchor="middle">${t.s}</text>`);
  out.push(`</g><text class="var" x="${LEFT + PW / 2}" y="${TOP + PH + 37}" text-anchor="middle">${xlabel}</text>`);
  out.push(`<clipPath id="clip"><rect x="${LEFT}" y="${TOP}" width="${PW}" height="${PH}"/></clipPath>`);
}
const poly = (cls, pts) => `<polyline class="${cls}" clip-path="url(#clip)" points="${pts.map(([x, y]) => `${f(x)},${f(y)}`).join(" ")}"/>`;
/** One row of legend entries above the plot area, so it never covers the curves. */
function legend(out, items) {
  let x = LEFT;
  const y = TOP - 14;
  for (const it of items) {
    if (it.text) { out.push(`<text class="legend" x="${x}" y="${y + 4}">${it.text}</text>`); x += it.w; continue; }
    if (it.band) out.push(`<rect class="${it.cls}" x="${x}" y="${y - 6}" width="22" height="12"/>`);
    else out.push(`<line class="${it.cls}" x1="${x}" x2="${x + 22}" y1="${y}" y2="${y}"/>`);
    out.push(`<text class="legend" x="${x + 28}" y="${y + 4}">${it.name}</text>`);
    x += 28 + it.w;
  }
}
const I = (t) => `<tspan class="mi">${t}</tspan>`; // italic math letter
const SUB = (t) => `<tspan class="sub" dy="4">${t}</tspan><tspan dy="-4"> </tspan>`;
const G1 = (arg) => `${I("G")}${SUB("1")}(${arg})`;
const SQRTX = `√${I("x")}`;
const pow10 = (e) => (e === 0 ? "1" : e === 1 ? "10" : `10<tspan class="sup" dy="-6">${e}</tspan>`);

// ------------------------------------------------------------------ (a) G_1(x), 1 <= x <= 10^7
const panels = {};
{
  const xs = [];
  for (let n = 1; n <= 2000; n++) xs.push(n);
  for (let i = 0; i <= 12000; i++) { const x = Math.pow(10, 3.3 + (3.7 * i) / 12000); if (x > 2000) xs.push(x); }
  const G = smoothedSumAt(xs);
  const X = (x) => LEFT + (Math.log10(x) / 7) * PW;
  const YMAX = 160;
  const Y = (y) => TOP + PH / 2 - (y / YMAX) * (PH / 2);
  const out = [];
  frame(out, {
    X, Y, xlabel: `${I("x")}  (logarithmic scale)`,
    xticks: [0, 1, 2, 3, 4, 5, 6, 7].map((e) => ({ v: 10 ** e, s: pow10(e) })),
    yticks: [-150, -100, -50, 0, 50, 100, 150].map((v) => ({ v, s: String(v) })),
  });
  // the curve, min/max per pixel column so that fast oscillations are not aliased
  const cols = new Map();
  xs.forEach((x, i) => { const c = Math.round(X(x) * 2); const e = cols.get(c); if (!e) cols.set(c, [G[i], G[i]]); else { e[0] = Math.min(e[0], G[i]); e[1] = Math.max(e[1], G[i]); } });
  const keys = [...cols.keys()].sort((a, b) => a - b);
  const top = keys.map((c) => [c / 2, Y(cols.get(c)[1])]), bot = keys.map((c) => [c / 2, Y(cols.get(c)[0])]).reverse();
  out.push(`<polygon class="gband" clip-path="url(#clip)" points="${[...top, ...bot].map(([x, y]) => `${f(x)},${f(y)}`).join(" ")}"/>`);
  out.push(poly("g", keys.map((c) => [c / 2, Y((cols.get(c)[0] + cols.get(c)[1]) / 2)])));
  const env = (sgn) => { const p = []; for (let i = 0; i <= 600; i++) { const x = 10 ** ((7 * i) / 600); p.push([X(x), Y(LOG2PI + sgn * (SUM_INV_RHO2 * Math.sqrt(x) + TRIV))]); } return p; };
  out.push(poly("env", env(1)), poly("env", env(-1)));
  legend(out, [{ cls: "g", name: G1(I("x")), w: 70 }, { cls: "env", name: `log 2${I("π")} ± (0.0462 ${SQRTX} + 0.307)`, w: 230 }]);
  panels.a = { body: out.join("\n"), aria: "G_1(x) for x from 1 to 10 million on a logarithmic x axis, oscillating with growing amplitude about 45 at 10 million, well inside the dashed curves log 2 pi plus or minus (0.0462 sqrt x + 0.307)" };
  let worst = 0; xs.forEach((x, i) => { worst = Math.max(worst, Math.abs(G[i] - LOG2PI) / (SUM_INV_RHO2 * Math.sqrt(x) + TRIV)); });
  console.log("(a) max |G - log 2pi| / (0.0462 sqrt x + 0.307) =", worst.toFixed(3));
}

// ------------------------------------------------------------------ (b) (G_1(x) - log 2pi)/sqrt x, 10 <= x <= 10^7
{
  const xs = [];
  for (let n = 10; n <= 2000; n++) xs.push(n);
  for (let i = 0; i <= 40000; i++) { const x = Math.pow(10, 3.3 + (3.7 * i) / 40000); if (x > 2000) xs.push(x); }
  const G = smoothedSumAt(xs);
  const X = (x) => LEFT + ((Math.log10(x) - 1) / 6) * PW;
  const YMAX = 0.03;
  const Y = (y) => TOP + PH / 2 - (y / YMAX) * (PH / 2);
  const out = [];
  frame(out, {
    X, Y, xlabel: `${I("x")}  (logarithmic scale)`,
    xticks: [1, 2, 3, 4, 5, 6, 7].map((e) => ({ v: 10 ** e, s: pow10(e) })),
    yticks: [-0.03, -0.02, -0.01, 0, 0.01, 0.02, 0.03].map((v) => ({ v, s: v === 0 ? "0" : v.toFixed(2) })),
  });
  const cols = new Map();
  xs.forEach((x, i) => { const v = (G[i] - LOG2PI) / Math.sqrt(x); const c = Math.round(X(x) * 2); const e = cols.get(c); if (!e) cols.set(c, [v, v]); else { e[0] = Math.min(e[0], v); e[1] = Math.max(e[1], v); } });
  const keys = [...cols.keys()].sort((a, b) => a - b);
  const top = keys.map((c) => [c / 2, Y(cols.get(c)[1])]), bot = keys.map((c) => [c / 2, Y(cols.get(c)[0])]).reverse();
  out.push(`<polygon class="gband" clip-path="url(#clip)" points="${[...top, ...bot].map(([x, y]) => `${f(x)},${f(y)}`).join(" ")}"/>`);
  const approx = (gs) => { const p = []; for (let i = 0; i <= 2400; i++) { const x = 10 ** (1 + (6 * i) / 2400); p.push([X(x), Y((explicitG(x, gs) - LOG2PI) / Math.sqrt(x))]); } return p; };
  out.push(poly("z10", approx(zeros.slice(0, 10))));
  out.push(poly("z1", approx(zeros.slice(0, 1))));
  legend(out, [
    { cls: "gband", band: true, name: `(${G1(I("x"))} − log 2${I("π")}) / ${SQRTX}`, w: 165 },
    { cls: "z1", name: `zeros ${I("ρ")} = ½ ± 14.13${I("i")}`, w: 140 },
    { cls: "z10", name: "first ten zero pairs", w: 150 },
  ]);
  panels.b = { body: out.join("\n"), aria: "(G_1(x) minus log 2 pi) divided by sqrt x for x from 10 to 10 million, an oscillation of size about 0.01 to 0.02, closely followed by the explicit formula with the first ten zero pairs; the first zero pair alone gives a pure wave in log x" };
  let err10 = 0; xs.forEach((x, i) => { if (x >= 1000) err10 = Math.max(err10, Math.abs(G[i] - explicitG(x, zeros.slice(0, 10))) / Math.sqrt(x)); });
  console.log("(b) max |data - 10-pair formula|/sqrt x for x >= 1000:", err10.toFixed(4));
}

// ------------------------------------------------------------------ (c) |A_k(3/2 + i tau)|, 0 <= tau <= 50
{
  const sigma = 1.5, TMAX = 50, LMIN = -5, LMAX = 0.5; // log10 range
  const X = (t) => LEFT + (t / TMAX) * PW;
  const Y = (v) => TOP + PH - ((Math.log10(v) - LMIN) / (LMAX - LMIN)) * PH;
  const out = [];
  frame(out, {
    X, Y, xlabel: I("y"),
    xticks: [0, 10, 20, 30, 40, 50].map((v) => ({ v, s: String(v) })),
    yticks: [-5, -4, -3, -2, -1, 0].map((e) => ({ v: 10 ** e, s: e === 0 ? "1" : `10<tspan class="sup" dy="-6">${e}</tspan>` })),
  });
  for (const g of zeros.filter((g) => g <= TMAX)) out.push(`<line class="zero" x1="${f(X(g))}" x2="${f(X(g))}" y1="${TOP}" y2="${TOP + PH}"/>`);
  const ks = [0, 1, 2, 3], cls = ["c1", "c2", "c3", "c5"];
  const NT = 1500;
  ks.forEach((k, j) => {
    const p = [];
    for (let i = 0; i <= NT; i++) { const t = (TMAX * i) / NT; p.push([X(t), Y(C.abs(A_poles(k, [sigma, t], zeros, 2000)))]); }
    out.push(poly(cls[j], p));
  });
  legend(out, [{ text: `|${I("A")}${SUB(I("k"))}(3/2 + ${I("i")}${I("y")})| for`, w: 130 }, ...ks.map((k, j) => ({ cls: cls[j], name: `${I("k")} = ${k}`, w: 50 }))]);
  panels.c = { body: out.join("\n"), aria: "|A_k(3/2 + iy)| for k = 0, 1, 2, 3 and y from 0 to 50 on a logarithmic scale; dotted vertical lines at the heights of the zeros of zeta; as k grows the curves develop peaks of height about 1/|rho|^2 at those heights" };
  const at = (k, t) => C.abs(A_poles(k, [sigma, t], zeros, 2000));
  console.log("(c) |A_k| at tau = gamma_1:", ks.map((k) => at(k, zeros[0]).toExponential(2)).join(", "), "  1/|rho_1|^2 =", (1 / (0.25 + zeros[0] ** 2)).toExponential(2));
}

const svgOf = (pnl) => `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${W} ${H}" width="${W}" height="${H}" role="img" aria-label="${pnl.aria}">
<style>
  text { font-family: system-ui, -apple-system, "Segoe UI", sans-serif; font-size: 13px; fill: #1f2328; }
  .ticks text { fill: #6a6f76; font-size: 12px; }
  .var { font-style: italic; fill: #6a6f76; font-size: 12px; }
  .sup { font-size: 9px; }
  .legend, .var { font-family: "Cambria Math", "Latin Modern Math", "STIX Two Math", "Times New Roman", serif; font-size: 14px; font-style: normal; }
  .mi { font-style: italic; } .sub { font-size: 10px; }
  .grid line { stroke: #e3e1da; stroke-width: 1; }
  .frame { fill: none; stroke: #8a8f96; stroke-width: 1; }
  polyline, line.g, line.env, line.z1, line.z10, line.c1, line.c2, line.c3, line.c5 { fill: none; stroke-linejoin: round; }
  .g { stroke: #2b5d9b; stroke-width: 1.2; }
  .gband { fill: #2b5d9b; fill-opacity: 0.45; stroke: none; }
  .env { stroke: #c0392b; stroke-width: 1.4; stroke-dasharray: 5 4; }
  .z1 { stroke: #d9822b; stroke-width: 1.6; stroke-dasharray: 5 3; }
  .z10 { stroke: #1f2328; stroke-width: 1.1; }
  .zero { stroke: #8a8f96; stroke-width: 1; stroke-dasharray: 2 3; }
  .c1, .c2, .c3, .c5 { stroke-width: 1.8; }
  .c1 { stroke: #d9822b; } .c2 { stroke: #2f8a57; } .c3 { stroke: #2b5d9b; } .c5 { stroke: #c0392b; }
  @media (prefers-color-scheme: dark) {
    text { fill: #e4e6e9; } .ticks text, .var { fill: #9aa0a8; }
    .grid line { stroke: #2a2e35; } .frame { stroke: #6a7078; } .zero { stroke: #6a7078; }
    .g { stroke: #7fb0ec; } .gband { fill: #7fb0ec; } .env { stroke: #ef7f72; } .z1 { stroke: #f0a35e; } .z10 { stroke: #e4e6e9; }
    .c1 { stroke: #f0a35e; } .c2 { stroke: #6cc58f; } .c3 { stroke: #7fb0ec; } .c5 { stroke: #ef7f72; }
  }
</style>
${pnl.body}
</svg>
`;
const dir = new URL("../public/static/figures/", import.meta.url);
writeFileSync(new URL("zeta-smoothed-sum.svg", dir), svgOf(panels.a), "utf8");
writeFileSync(new URL("zeta-oscillation.svg", dir), svgOf(panels.b), "utf8");
writeFileSync(new URL("zeta-taylor-coefficients.svg", dir), svgOf(panels.c), "utf8");
console.log("wrote zeta-smoothed-sum.svg, zeta-oscillation.svg, zeta-taylor-coefficients.svg");
