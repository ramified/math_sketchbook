// Numerics for the Riemann zeta example (section 1.4): zeta and zeta' by Euler-Maclaurin, zeros on the critical line
// from sign changes of Hardy's Z function, the smoothed prime sum G_1 by a sieve, and the Taylor coefficients
// A_k(z) = (-1)^k H^{(k)}(z)/k! of the Mellin transform H = H_1, both from the partial-fraction formula over the
// poles and (as a check) from a Cauchy integral of H itself. No dependencies. Used by scripts/plot-zeta-example.mjs;
// run directly (node scripts/zeta-numerics.mjs) to print the checks.

export const GAMMA = 0.5772156649015329;
export const LOG2PI = Math.log(2 * Math.PI);

// ------------------------------------------------------------------ complex arithmetic on [re, im]
export const C = {
  add: (a, b) => [a[0] + b[0], a[1] + b[1]],
  sub: (a, b) => [a[0] - b[0], a[1] - b[1]],
  mul: (a, b) => [a[0] * b[0] - a[1] * b[1], a[0] * b[1] + a[1] * b[0]],
  div: (a, b) => { const d = b[0] * b[0] + b[1] * b[1]; return [(a[0] * b[0] + a[1] * b[1]) / d, (a[1] * b[0] - a[0] * b[1]) / d]; },
  scale: (a, r) => [a[0] * r, a[1] * r],
  abs: (a) => Math.hypot(a[0], a[1]),
  exp: (a) => { const e = Math.exp(a[0]); return [e * Math.cos(a[1]), e * Math.sin(a[1])]; },
  pow: (a, n) => { let r = [1, 0]; for (let i = 0; i < n; i++) r = C.mul(r, a); return r; }, // integer n >= 0
  inv: (a) => C.div([1, 0], a),
};

// ------------------------------------------------------------------ zeta and zeta' by Euler-Maclaurin
const M_TERMS = 24;
// B_{2j}/(2j)! = (-1)^{j+1} 2 zeta(2j) / (2 pi)^{2j}
const BCOEF = [];
for (let j = 1; j <= M_TERMS; j++) {
  let z = 0;
  for (let n = 1; n <= 2000; n++) z += Math.pow(n, -2 * j);
  if (j === 1) z = Math.PI * Math.PI / 6;
  BCOEF.push(((j % 2 === 1) ? 1 : -1) * 2 * z / Math.pow(2 * Math.PI, 2 * j));
}

/** [zeta(s), zeta'(s)] for s != 1. */
export function zeta2(s) {
  const t = Math.abs(s[1]);
  const N = Math.max(20, Math.ceil(t / 4) + 20);
  let z = [0, 0], dz = [0, 0];
  for (let n = 1; n < N; n++) {
    const ln = Math.log(n);
    const term = C.exp(C.scale(s, -ln)); // n^{-s}
    z = C.add(z, term);
    dz = C.sub(dz, C.scale(term, ln));
  }
  const lN = Math.log(N);
  const Ns = C.exp(C.scale(s, -lN)); // N^{-s}
  const s1 = C.sub(s, [1, 0]);
  // N^{1-s}/(s-1) and its derivative  N^{1-s} * ( -log N/(s-1) - 1/(s-1)^2 )
  const a = C.scale(C.div(Ns, s1), N);
  z = C.add(z, a);
  dz = C.add(dz, C.mul(a, C.sub(C.scale([1, 0], -lN), C.inv(s1))));
  // N^{-s}/2, derivative -log N N^{-s}/2
  z = C.add(z, C.scale(Ns, 0.5));
  dz = C.add(dz, C.scale(Ns, -0.5 * lN));
  // sum_j c_j P_j(s) N^{-s-2j+1}, P_j(s) = s(s+1)...(s+2j-2)
  let P = [...s], dlogP = C.inv(s); // P_1 = s
  let Npow = C.scale(Ns, 1 / N); // N^{-s-1}
  for (let j = 1; j <= M_TERMS; j++) {
    const term = C.scale(C.mul(P, Npow), BCOEF[j - 1]);
    z = C.add(z, term);
    dz = C.add(dz, C.mul(term, C.sub(dlogP, [lN, 0])));
    // next: P_{j+1} = P_j (s+2j-1)(s+2j), N^{-s-2j-1}
    const f1 = C.add(s, [2 * j - 1, 0]), f2 = C.add(s, [2 * j, 0]);
    P = C.mul(P, C.mul(f1, f2));
    dlogP = C.add(dlogP, C.add(C.inv(f1), C.inv(f2)));
    Npow = C.scale(Npow, 1 / (N * N));
  }
  return [z, dz];
}

/** H_1(s) = -zeta'/zeta(s)/(s(s-1)) - 1/(s-1)^2 + (1+gamma)/(s-1). */
export function H(s) {
  const [z, dz] = zeta2(s);
  const s1 = C.sub(s, [1, 0]);
  const a = C.scale(C.div(dz, C.mul(z, C.mul(s, s1))), -1);
  return C.add(C.sub(a, C.inv(C.mul(s1, s1))), C.scale(C.inv(s1), 1 + GAMMA));
}

// ------------------------------------------------------------------ zeros: sign changes of Hardy's Z(t)
export function theta(t) {
  return (t / 2) * Math.log(t / (2 * Math.PI)) - t / 2 - Math.PI / 8 + 1 / (48 * t) + 7 / (5760 * t ** 3) + 31 / (80640 * t ** 5);
}
export function Z(t) {
  const [z] = zeta2([0.5, t]);
  const th = theta(t);
  return z[0] * Math.cos(th) - z[1] * Math.sin(th); // Re(e^{i theta} zeta(1/2+it))
}
export function zerosUpTo(T, step = 0.02) {
  const out = [];
  let t0 = 10, z0 = Z(t0);
  for (let t1 = t0 + step; t1 <= T; t1 += step) {
    const z1 = Z(t1);
    if (z0 === 0 || z0 * z1 < 0) {
      let a = t0, b = t1, fa = z0;
      for (let i = 0; i < 60; i++) { const m = (a + b) / 2, fm = Z(m); if (fa * fm <= 0) b = m; else { a = m; fa = fm; } }
      out.push((a + b) / 2);
    }
    t0 = t1; z0 = z1;
  }
  return out;
}
/** Riemann-von Mangoldt count N(T) ~ theta(T)/pi + 1 (the S(T) term is small and averages to 0). */
export const countApprox = (T) => theta(T) / Math.PI + 1;

// ------------------------------------------------------------------ A_k from the poles, and from a Cauchy integral
/** A_k(z) = log(2pi)/z^{k+1} - sum_rho 1/(rho(rho-1)(z-rho)^{k+1}) - sum_n 1/(2n(2n+1)(z+2n)^{k+1}). */
export function A_poles(k, z, gammas, nTriv = 20000) {
  let r = C.scale(C.inv(C.pow(z, k + 1)), LOG2PI);
  for (const g of gammas) for (const rho of [[0.5, g], [0.5, -g]]) {
    const den = C.mul(C.mul(rho, C.sub(rho, [1, 0])), C.pow(C.sub(z, rho), k + 1));
    r = C.sub(r, C.inv(den));
  }
  for (let n = 1; n <= nTriv; n++) {
    const den = C.scale(C.pow(C.add(z, [2 * n, 0]), k + 1), 2 * n * (2 * n + 1));
    r = C.sub(r, C.inv(den));
  }
  return r;
}
/** A_k(z) = (1/2 pi i) \oint H(z - w) w^{-k-1} dw over |w| = rad, by the trapezoid rule (exact up to rounding). */
export function A_cauchy(k, z, rad = 0.4, M = 64) {
  let r = [0, 0];
  for (let m = 0; m < M; m++) {
    const phi = (2 * Math.PI * m) / M;
    const w = [rad * Math.cos(phi), rad * Math.sin(phi)];
    r = C.add(r, C.mul(H(C.sub(z, w)), C.inv(C.pow(w, k))));
  }
  return C.scale(r, 1 / M);
}

// ------------------------------------------------------------------ the smoothed prime sum G_1 by a sieve
/** Returns G(x) for 1 <= x <= N: G_1(x) = sum_{n<=x} Lambda(n)(x/n - 1) - x log x + (1+gamma) x. */
export function smoothedSum(N) {
  const comp = new Uint8Array(N + 1);
  const lam = new Float64Array(N + 1);
  for (let p = 2; p <= N; p++) {
    if (comp[p]) continue;
    for (let m = p * p; m <= N; m += p) comp[m] = 1;
    const lp = Math.log(p);
    for (let q = p; q <= N; q *= p) lam[q] = lp;
  }
  // prefix sums S1(n) = sum_{m<=n} Lambda(m)/m and psi(n) = sum_{m<=n} Lambda(m), with compensated summation
  const S1 = new Float64Array(N + 1), PSI = new Float64Array(N + 1);
  let s1 = 0, c1 = 0, ps = 0, c2 = 0;
  for (let n = 1; n <= N; n++) {
    if (lam[n]) {
      let y = lam[n] / n - c1, t = s1 + y; c1 = (t - s1) - y; s1 = t;
      y = lam[n] - c2; t = ps + y; c2 = (t - ps) - y; ps = t;
    }
    S1[n] = s1; PSI[n] = ps;
  }
  const G = (x) => { const n = Math.floor(x); return x * S1[n] - PSI[n] - x * Math.log(x) + (1 + GAMMA) * x; };
  return { G, isPrimePower: (n) => lam[n] > 0 };
}
/** G_1 at the sorted points xs (all >= 1), in one pass over n <= max(xs); memory: one Float64Array of size N. */
export function smoothedSumAt(xs) {
  const N = Math.floor(xs[xs.length - 1]);
  const lam = new Float64Array(N + 1);
  {
    const comp = new Uint8Array(N + 1);
    for (let p = 2; p <= N; p++) {
      if (comp[p]) continue;
      if (p * p <= N) for (let m = p * p; m <= N; m += p) comp[m] = 1;
      const lp = Math.log(p);
      for (let q = p; q <= N; q *= p) lam[q] = lp;
    }
  }
  const out = new Float64Array(xs.length);
  let s1 = 0, c1 = 0, ps = 0, c2 = 0, n = 0;
  for (let i = 0; i < xs.length; i++) {
    const x = xs[i];
    while (n + 1 <= x) {
      n++;
      if (lam[n]) {
        let y = lam[n] / n - c1, t = s1 + y; c1 = (t - s1) - y; s1 = t;
        y = lam[n] - c2; t = ps + y; c2 = (t - ps) - y; ps = t;
      }
    }
    out[i] = x * s1 - ps - x * Math.log(x) + (1 + GAMMA) * x;
  }
  return out;
}
/** Explicit formula: log 2pi - sum over zeros (pairs) of 2 Re(x^rho/(rho(rho-1))) - sum_n x^{-2n}/(2n(2n+1)). */
export function explicitG(x, gammas) {
  let s = LOG2PI;
  const lx = Math.log(x), sx = Math.sqrt(x);
  for (const g of gammas) {
    const xr = [sx * Math.cos(g * lx), sx * Math.sin(g * lx)];
    const rho = [0.5, g];
    s -= 2 * C.div(xr, C.mul(rho, C.sub(rho, [1, 0])))[0];
  }
  // sum_n x^{-2n}/(2n(2n+1)) = -1/2 log(1 - y^2) - artanh(y)/y + 1, y = 1/x (x > 1)
  if (x > 1) { const y = 1 / x; s -= -0.5 * Math.log(1 - y * y) - Math.atanh(y) / y + 1; } else s -= 1 - Math.log(2);
  return s;
}

// ------------------------------------------------------------------ checks
if (import.meta.url === `file://${process.argv[1].replace(/\\/g, "/").replace(/^([A-Za-z]):/, "/$1:")}` || process.argv[1]?.endsWith("zeta-numerics.mjs")) {
  const t0 = Date.now();
  const zs = zerosUpTo(1000);
  console.log(`zeros up to 1000: ${zs.length} (Riemann-von Mangoldt ~ ${countApprox(1000).toFixed(2)}; known: 649) in ${Date.now() - t0} ms`);
  const known = [[1, 14.134725141734693], [2, 21.022039638771555], [3, 25.010857580145688], [10, 49.773832477672302], [100, 236.524229665816205]];
  for (const [n, g] of known) console.log(`gamma_${n} = ${zs[n - 1].toFixed(12)} (known ${g}) diff ${(zs[n - 1] - g).toExponential(2)}`);
  console.log("sum 1/|rho|^2 over these zeros:", zs.reduce((a, g) => a + 2 / (0.25 + g * g), 0).toFixed(6), " (all zeros: 2+gamma-log(4pi) =", (2 + GAMMA - Math.log(4 * Math.PI)).toFixed(6), ")");
  const { G } = smoothedSum(100000);
  for (const x of [1, 10, 100, 1000, 10000, 100000]) console.log(`G(${x}) = ${G(x).toFixed(4)}   explicit formula with ${zs.length} zeros: ${explicitG(x, zs).toFixed(4)}`);
  for (const k of [0, 1, 2, 3]) for (const tau of [0, 14.134725, 20, 40]) {
    const z = [1.5, tau];
    const a = A_poles(k, z, zs), b = A_cauchy(k, z);
    console.log(`A_${k}(1.5+${tau}i): poles ${a[0].toExponential(5)} ${a[1].toExponential(5)}i  cauchy ${b[0].toExponential(5)} ${b[1].toExponential(5)}i  rel.diff ${(C.abs(C.sub(a, b)) / C.abs(b)).toExponential(1)}`);
  }
}
