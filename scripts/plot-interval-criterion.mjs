// Draws the two cases of the interval criterion (Proposition 1.4.7, tag 8JP5).
// Design: docs/figures/interval-criterion-design.md. Script written by GPT from that design.
// Run: node scripts/plot-interval-criterion.mjs
import { writeFileSync, mkdirSync } from "node:fs";

const H = 340, TOP = 24;
const XMIN = -0.4, XMAX = 7.0, YMIN = -3.3, YMAX = 3.3;
const PH = H - 2 * TOP;
const SCALE = PH / (YMAX - YMIN);
const PW = (XMAX - XMIN) * SCALE;
// Canvas fitted to the drawing (equal axis scales), with room on the right for the label "z = σ + iτ".
const LEFT = 18;
const W = Math.ceil(LEFT + PW + 96);

const f = (v) => v.toFixed(2);
const X = (x) => LEFT + (x - XMIN) * SCALE;
const Y = (y) => TOP + (YMAX - y) * SCALE;
const distance = ([x1, y1], [x2, y2]) => Math.hypot(x1 - x2, y1 - y2);

const theta = 2;
const sigma = [6, 0];
const rho = [3, 1.8];
const rhoBar = [3, -1.8];
const z = [sigma[0], rho[1]];
const beta = [3.2, 0];
const otherPolesA = [[1.5, 0.9], [1.5, -0.9], [1, 2.6], [1, -2.6]];
const otherPolesB = [[2.6, 2.2], [2.6, -2.2], [1.2, 1.2], [1.2, -1.2], [0.8, 2.8], [0.8, -2.8]];
const Dstar = sigma[0] - theta;
const DA = distance(sigma, rho);
const d = distance(z, rho);
const DB = sigma[0] - beta[0];

const line = (cls, [x1, y1], [x2, y2]) =>
  `<line class="${cls}" x1="${f(X(x1))}" x2="${f(X(x2))}" y1="${f(Y(y1))}" y2="${f(Y(y2))}"/>`;
const polyline = (cls, points) =>
  `<polyline class="${cls}" points="${points.map(([x, y]) => `${f(x)},${f(y)}`).join(" ")}"/>`;
const circle = (cls, [x, y], r) =>
  `<circle class="${cls}" cx="${f(X(x))}" cy="${f(Y(y))}" r="${f(r)}"/>`;
const label = (content, [x, y], dx, dy, anchor = "start", cls = "var") =>
  `<text class="${cls}" x="${f(X(x) + dx)}" y="${f(Y(y) + dy)}" text-anchor="${anchor}">${content}</text>`;
const sub = (content) => `<tspan class="sub" baseline-shift="sub">${content}</tspan>`;
const midpoint = ([x1, y1], [x2, y2]) => [(x1 + x2) / 2, (y1 + y2) / 2];

const axisX = X(0);
const axisY = Y(0);
const axisRight = X(XMAX);
const bracketY = Y(-3.0);

const common = [
  `<defs><clipPath id="plot"><rect x="${f(LEFT)}" y="${f(TOP)}" width="${f(PW)}" height="${f(PH)}"/></clipPath></defs>`,
  `<rect class="band" x="${f(X(theta))}" y="${f(TOP)}" width="${f(Dstar * SCALE)}" height="${f(PH)}"/>`,
  line("axis", [XMIN, 0], [XMAX, 0]),
  line("axis", [0, YMIN], [0, YMAX]),
  polyline("axis", [[axisRight - 6, axisY - 3], [axisRight, axisY], [axisRight - 6, axisY + 3]]),
  polyline("axis", [[axisX - 3, TOP + 6], [axisX, TOP], [axisX + 3, TOP + 6]]),
  line("theta", [theta, YMIN], [theta, YMAX]),
  line("sigma", [sigma[0], YMIN], [sigma[0], YMAX]),
];

const commonForeground = [
  polyline("bracket", [
    [X(theta), bracketY - 4], [X(theta), bracketY],
    [X(sigma[0]), bracketY], [X(sigma[0]), bracketY - 4],
  ]),
  circle("pole", sigma, 3),
  label("Re s = θ", [theta, YMAX], 4, -8),
  label("Re s = σ", [sigma[0], YMAX], 4, -8),
  label("Re s &gt; θ", [theta, -2.65], 7, 0, "start", "var bandlabel"),
  label(`D${sub("*")}`, [(theta + sigma[0]) / 2, -3.0], 0, 17, "middle"),
  label("σ", sigma, 8, 16),
];

const panels = {
  a: {
    aria: "Case (a). The dashed circle centered at sigma passes through both highlighted conjugate poles. The smaller blue circle centered at z reaches only the upper highlighted pole.",
    body: [
      ...common,
      `<g clip-path="url(#plot)">`,
      circle("distance", sigma, DA * SCALE),
      circle("blue-circle", z, d * SCALE),
      `</g>`,
      line("radius", sigma, rhoBar),
      line("blue-radius", z, rho),
      ...commonForeground,
      ...otherPolesA.map((pole) => circle("pole", pole, 4)),
      circle("highlight", rho, 5),
      circle("highlight", rhoBar, 5),
      circle("blue-point", z, 4),
      label(`ρ${sub("1")}`, rho, -9, -4, "end"),
      label(`<tspan text-decoration="overline" style="text-decoration: overline">ρ</tspan>${sub("1")}`, rhoBar, -9, 10, "end"),
      label("z = σ + iτ", z, 9, 4, "start", "var blue-label"),
      label("D", midpoint(sigma, rhoBar), 0, 16, "middle"),
      label("d", midpoint(z, rho), 0, -6, "middle", "var blue-label"),
    ].join("\n"),
  },
  b: {
    aria: "Case (b). The dashed circle centered at sigma reaches the real pole beta. Every other pole lies left of the dotted vertical line through beta.",
    body: [
      ...common,
      line("limit", [beta[0], -3.1], [beta[0], 3.1]),
      `<g clip-path="url(#plot)">`,
      circle("distance", sigma, DB * SCALE),
      `</g>`,
      line("radius", sigma, beta),
      ...commonForeground,
      ...otherPolesB.map((pole) => circle("pole", pole, 4)),
      circle("highlight", beta, 5),
      label("β = σ − D", beta, 8, 18),
      label("D", midpoint(sigma, beta), 0, -7, "middle"),
      label("Re s = σ − D", [beta[0], 3.0], 6, 5),
    ].join("\n"),
  },
};

const svgOf = (pnl) => `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${W} ${H}" width="${W}" height="${H}" role="img" aria-label="${pnl.aria}">
<style>
  text { font-family: system-ui, -apple-system, "Segoe UI", sans-serif; font-size: 13px; fill: #1f2328; }
  .var { font-family: "Latin Modern Math", "Cambria Math", "Times New Roman", serif; font-style: italic; fill: #3d4248; font-size: 16px; }
  .sub { font-size: 12px; }
  .axis, .theta, .sigma, .limit, .bracket, .distance { fill: none; stroke: #8a8f96; stroke-width: 1; }
  .radius { stroke: #6a6f76; stroke-width: 1.4; }
  polyline { fill: none; stroke-linejoin: round; }
  .theta, .distance { stroke-dasharray: 3 3; }
  .limit { stroke-dasharray: 1 3; stroke-linecap: round; }
  .band { fill: #c0392b; fill-opacity: 0.10; }
  .bandlabel { fill: #c0392b; font-size: 14px; }
  .pole { fill: #1f2328; }
  .highlight { fill: #c0392b; }
  .blue-point, .blue-label { fill: #2b5d9b; }
  .blue-circle, .blue-radius { fill: none; stroke: #2b5d9b; }
  .blue-circle { stroke-width: 2.2; }
  .blue-radius { stroke-width: 1.4; }
  @media (prefers-color-scheme: dark) {
    text { fill: #e4e6e9; } .var { fill: #c9cdd2; }
    .axis, .theta, .sigma, .limit, .bracket, .distance { stroke: #6a7078; }
    .radius { stroke: #9aa0a8; }
    .band { fill: #ef7f72; fill-opacity: 0.13; }
    .bandlabel, .highlight { fill: #ef7f72; }
    .pole { fill: #e4e6e9; }
    .blue-point, .blue-label { fill: #7fb0ec; }
    .blue-circle, .blue-radius { stroke: #7fb0ec; }
  }
</style>
${pnl.body}
</svg>
`;

mkdirSync(new URL("../public/static/figures/", import.meta.url), { recursive: true });
writeFileSync(new URL("../public/static/figures/interval-criterion-a.svg", import.meta.url), svgOf(panels.a), "utf8");
writeFileSync(new URL("../public/static/figures/interval-criterion-b.svg", import.meta.url), svgOf(panels.b), "utf8");

const poleName = ([x, y]) => `${x} ${y < 0 ? "−" : "+"} ${Math.abs(y)}i`;

console.log(`(a) d = ${f(d)} < D = ${f(DA)} < D* = ${f(Dstar)}`);
for (const pole of [rhoBar, ...otherPolesA]) {
  console.log(`    |z − (${poleName(pole)})| = ${f(distance(z, pole))}`);
}

console.log(`(b) D = ${f(DB)} < D* = ${f(Dstar)}`);
for (const pole of otherPolesB) {
  console.log(`    ${poleName(pole)}: horizontal distance = ${f(sigma[0] - pole[0])}, distance to σ = ${f(distance(sigma, pole))}`);
}
