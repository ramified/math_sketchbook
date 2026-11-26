# Coset averaging with a real parameter

## Book edits

| Tag | Change |
| --- | --- |
| 8JVA | Lemma 2.1.2 now allows real \(k\ge0\) and defines \(c_k\) in displayed cases. The proof checks normalization and computes the contributions of the uniform part and the atom at \(A_0\). |
| 8JVB | Example 2.1.3 explicitly takes \(k=3\). |
| 8JVN | Example 2.1.4 uses \(k=1\) and demonstrates a positive error, including a complex conjugate pair of character averages. |
| 8JVE | The Fourier data specify \(k=3\) before imposing the proportion condition. |
| 8JUD | The proof identifies the \(k=3\) target \(c_3(\xi\vert_A)\) with the Chapter 1 coefficient \(a_{\xi^*}\). |
| 8JU7 | The arithmetic construction explicitly specifies the \(k=3\) proportions. |
| 8JV6 | The §2.1 introduction connects the \(k=3\) case to the Chapter 1 weights at 8JG8. |
| 8JV8 | The §2.3 introduction identifies the coset average used in the prime-power count as the \(k=3\) case. |

The lemma fixes \(k\) before defining \(\lambda_C\), so the notation \(\lambda_C\) can be retained. Each application states its choice of \(k\). Every real \(k\ge0\) gives a positive denominator and nonnegative weights. At \(k=0\), the uniform part vanishes and all of the target mass is at the identity coset \(A_0\), so the same proof covers the endpoint.

The new example has result ID 169, proof ID 139, and tag 8JVN, which follow the backup maxima 168, 138, and 8JVM. It is listed at position 4 in §2.1, immediately after 8JVB. The guard uses revision 2 for 8JVA, as recorded in the designated backup.

## Example 2.1.4

\(A=\mathbb Z/24\mathbb Z\), \(A_0=4\mathbb Z/24\mathbb Z\), \(o=4\), and \(k=1\). The ten shifts are \(T=\{0,4,8,12,16,20,2,6,10,3\}\).

| Coset residue mod 4 | Count in \(T\) | \(\mu_C\) | \(\lambda_C\) | \(\mu_C-\lambda_C\) |
| --- | ---: | ---: | ---: | ---: |
| 0 | 6 | \(6/10\) | \(2/5\) | \(1/5\) |
| 1 | 0 | \(0\) | \(1/5\) | \(-1/5\) |
| 2 | 3 | \(3/10\) | \(1/5\) | \(1/10\) |
| 3 | 1 | \(1/10\) | \(1/5\) | \(-1/10\) |

The maximum deviation is \(r=1/5\), so the lemma gives \(or=4/5\). For the four quotient characters \(\xi_j(t)=i^{jt}\), the direct average is \(M_j=(6+3i^{2j}+i^{3j})/10\).

| \(j\) | \(M_j\) | \(c_1(\xi_j)\) | \(M_j-c_1(\xi_j)\) | Absolute error |
| --- | ---: | ---: | ---: | ---: |
| 0 | \(1\) | \(1\) | \(0\) | \(0\) |
| 1 | \((3-i)/10\) | \(1/5\) | \((1-i)/10\) | \(\sqrt{2}/10\) |
| 2 | \(4/5\) | \(1/5\) | \(3/5\) | \(3/5\) |
| 3 | \((3+i)/10\) | \(1/5\) | \((1+i)/10\) | \(\sqrt{2}/10\) |

The largest error is \(3/5\), three quarters of \(4/5\). Replacing \(3\) with \(14\) gives deviations \((1,-1,1,-1)/5\), keeping \(r=1/5\) and attaining the bound \(4/5\) at \(\xi_2\).

## Verification

The checker loaded the designated backup into a temporary SQLite database. The write guard rejected both a stale revision and a second application with zero row changes and identical database bytes. The checker verified all reference targets and stored edges, the revision snapshots, and zero TeX warnings across the 10 rows added or updated. It independently enumerated the cosets and evaluated all quotient characters at each shift. It used exact rational comparisons for the averages and squared moduli, including the sharpness calculation.

| Widest displays, estimated at the book's 18 px body size | Width |
| --- | ---: |
| 8JVE, normalization parameters | 560.5 px |
| 8JUD proof, bound using \(L_x\) | 544.0 px |
| 8JVN, the two proportion vectors | 451.6 px |
| 8JUD proof, partial summation estimate | 423.3 px |
| 8JUD proof, expansion of \(P(u,t)\) | 401.3 px |
| 8JVA proof, uniform part and atom | 381.1 px |

The checker printed `ALL CHECKS PASSED`. All 25 tests passed with `NODE_OPTIONS=--test-isolation=none` set for `npm test` because the default runner hit the sandbox's child-process spawn restriction.
