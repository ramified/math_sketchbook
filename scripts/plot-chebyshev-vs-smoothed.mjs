// Draws panels (c)–(e) for the smoothed prime sum of the trivial character (8JS9).
// Run: node scripts/plot-chebyshev-vs-smoothed.mjs
import { mkdirSync, writeFileSync } from "node:fs";

const GAMMA = 0.5772156649015329;
const XMIN = 1, XMAX = 20;

// von Mangoldt function up to XMAX, using the sieve from plot-smoothed-prime-sum.mjs.
const LAMBDA = new Float64Array(XMAX + 1);
{
  const composite = new Uint8Array(XMAX + 1);
  for (let p = 2; p <= XMAX; p++) {
    if (composite[p]) continue;
    for (let m = p * p; m <= XMAX; m += p) composite[m] = 1;
    for (let q = p; q <= XMAX; q *= p) LAMBDA[q] = Math.log(p);
  }
}
const primePowers = [...LAMBDA.keys()].filter((n) => LAMBDA[n] > 0);

function R(x) {
  let sum = 0;
  for (const n of primePowers) {
    if (n > x) break;
    sum += LAMBDA[n] * (x / n - 1);
  }
  return sum;
}

function stepPoints(jump) {
  const points = [[XMIN, 0]];
  let value = 0;
  for (const n of primePowers) {
    points.push([n, value]);
    value += jump(n);
    points.push([n, value]);
  }
  points.push([XMAX, value]);
  return points;
}

function smoothPoints(fn) {
  return Array.from({ length: (XMAX - XMIN) * 20 + 1 }, (_, i) => {
    const x = XMIN + i / 20;
    return [x, fn(x)];
  });
}

const W = 640, PH = 200, TOP = 14, LEFT = 62, RIGHT = 20;
const H = TOP + PH + 46;
const PW = W - LEFT - RIGHT;
const xticks = [1, 5, 10, 15, 20];
const X = (x) => LEFT + ((x - XMIN) / (XMAX - XMIN)) * PW;
const f = (v) => v.toFixed(2);
const figures = new URL("../public/static/figures/", import.meta.url);

const style = `<style>
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
  .pp { stroke: #8a8f96; stroke-width: 1; stroke-dasharray: 1 3; }
  .corner { fill: #2b5d9b; }
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
    .pp { stroke: #6a7078; }
    .corner { fill: #7fb0ec; }
  }
</style>`;

function writePanel({ name, ariaLabel, ymin, ymax, yticks, observed, main, corners = [] }) {
  const Y = (y) => TOP + PH - ((y - ymin) / (ymax - ymin)) * PH;
  const clip = `${name}-clip`;
  const out = [
    `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${W} ${H}" width="${W}" height="${H}" role="img" aria-label="${ariaLabel}">`,
    style,
    `<clipPath id="${clip}"><rect x="${LEFT}" y="${TOP}" width="${PW}" height="${PH}"/></clipPath>`,
    '<g class="grid">',
  ];
  for (const t of yticks) {
    const y = f(Y(t));
    out.push(`<line x1="${LEFT}" x2="${W - RIGHT}" y1="${y}" y2="${y}"/>`);
  }
  for (const t of xticks) {
    const x = f(X(t));
    out.push(`<line x1="${x}" x2="${x}" y1="${TOP}" y2="${TOP + PH}"/>`);
  }
  out.push('</g>');
  for (const n of primePowers) {
    const x = f(X(n));
    out.push(`<line class="pp" x1="${x}" x2="${x}" y1="${TOP}" y2="${TOP + PH}"/>`);
  }
  out.push(`<g class="axis"><rect x="${LEFT}" y="${TOP}" width="${PW}" height="${PH}" fill="none"/></g>`);
  out.push('<g class="ticks">');
  for (const t of yticks) {
    out.push(`<text x="${LEFT - 6}" y="${f(Y(t) + 4)}" text-anchor="end">${t}</text>`);
  }
  for (const t of xticks) {
    out.push(`<text x="${f(X(t))}" y="${TOP + PH + 17}" text-anchor="middle">${t}</text>`);
  }
  out.push(`<text x="${LEFT + PW / 2}" y="${TOP + PH + 36}" text-anchor="middle" class="var">x</text>`);
  out.push('</g>');

  const observedCurve = { ...observed, cls: "c-r" };
  const mainCurve = { ...main, cls: "c-m" };
  out.push(`<g clip-path="url(#${clip})">`);
  for (const { points, cls } of [mainCurve, observedCurve]) {
    const coords = points.map(([x, y]) => `${f(X(x))},${f(Y(y))}`).join(" ");
    out.push(`<polyline class="${cls}" points="${coords}"/>`);
  }
  for (const [x, y] of corners) {
    out.push(`<circle class="corner" cx="${f(X(x))}" cy="${f(Y(y))}" r="3"/>`);
  }
  out.push('</g>');

  const ly = TOP + 18;
  let lx = LEFT + 12;
  const legendWidth = 12 + 2 * 32 + 18 + (observed.label.length + main.label.length) * 8;
  out.push(`<rect class="legend-bg" x="${lx - 6}" y="${ly - 11}" width="${legendWidth}" height="22"/>`);
  for (const { label, cls } of [observedCurve, mainCurve]) {
    out.push(`<line class="${cls}" x1="${lx}" x2="${lx + 26}" y1="${ly}" y2="${ly}"/>`);
    out.push(`<text class="legend" x="${lx + 32}" y="${ly + 4}">${label}</text>`);
    lx += 32 + label.length * 8 + 18;
  }

  out.push('</svg>', '');
  writeFileSync(new URL(`${name}.svg`, figures), out.join("\n"), "utf8");
}

const psi = stepPoints((n) => LAMBDA[n]);
const slope = stepPoints((n) => LAMBDA[n] / n);
const smoothed = [XMIN, ...primePowers, XMAX].map((x) => [x, R(x)]);

mkdirSync(figures, { recursive: true });
writePanel({
  name: "chebyshev-psi",
  ariaLabel: "The Chebyshev function Psi_1(x) and the line x for x from 1 to 20",
  ymin: -5, ymax: 35, yticks: [0, 10, 20, 30],
  observed: { label: "Ψ₁(x)", points: psi },
  main: { label: "x", points: [[XMIN, XMIN], [XMAX, XMAX]] },
});
writePanel({
  name: "chebyshev-smoothed",
  ariaLabel: "R_1(x) and M_1(x) for x from 1 to 20, with corners of R_1 at the prime powers",
  ymin: -5, ymax: 35, yticks: [0, 10, 20, 30],
  observed: { label: "R₁(x)", points: smoothed },
  main: { label: "M₁(x)", points: smoothPoints((x) => x * Math.log(x) - (1 + GAMMA) * x) },
  corners: smoothed.slice(1, -1),
});
writePanel({
  name: "chebyshev-slope",
  ariaLabel: "The slope of R_1, a step function with jumps Lambda(n)/n, and ln x minus gamma",
  ymin: -1, ymax: 3, yticks: [-1, 0, 1, 2, 3],
  observed: { label: "slope of R₁", points: slope },
  main: { label: "ln x − γ", points: smoothPoints((x) => Math.log(x) - GAMMA) },
});

console.log(`R_1(20) = ${smoothed.at(-1)[1].toFixed(3)}`);
console.log(`Psi_1(20) = ${psi.at(-1)[1].toFixed(3)}`);
console.log(`S(20) = ${slope.at(-1)[1].toFixed(3)}`);
