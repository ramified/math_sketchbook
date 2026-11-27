# Chapter 2 — From Chebyshev's method to smooth divisibility

## Chapter text

The blocks below give the TeX stored by the migration. Each block follows the heading for its database row.

### UTUF — From Chebyshev's method to smooth divisibility

~~~tex
\ref{7HA2} reduces GRH to the \hyperref[8JK2]{one-sided interval estimate} for the \hyperref[8JG8]{weighted smoothed prime sum} $\mathcal G_\psi$. The precision to aim for is $x^{1/2+\eta}$ for every real $\eta>0$. Chebyshev's method gives an upper bound in the required direction. If prime powers divide a nonzero integer, their logarithmic contribution is bounded above by the logarithm of its absolute value.

The factorial calculation explains why the ramp in \ref{8JF7} is natural and where the loss of precision occurs. The lemniscate gives a first example of divisibility governed by smooth exponents. Its defects explain the roles of \ref{8JU2} and \ref{8JV5}.
~~~

### 4M8T — Chebyshev's method

~~~tex
For a prime $p$, write $v_p$ for the exponent of $p$ in a nonzero rational number, counting exponents in the denominator with a minus sign, and put $v_p(0)=+\infty$. Use $\Lambda$ for the \hyperref[8JUR]{von Mangoldt function} and write $\Psi_{\mathbf 1}(x)=\sum_{r\le x}\Lambda(r)$ for real $x\ge1$. The central binomial coefficient gives a direct example of the comparison used in Erdős's proof of Bertrand's postulate \cite{Erdos1932}.
~~~

#### 8V4M — Lemma — Divisibility versus size

~~~tex
Let $N\in\Z\smallsetminus\{0\}$ and let $P$ be a finite set of primes. For each $p\in P$ let $e_p$ be a real number with $0\le e_p\le v_p(N)$. Then
\[
\sum_{p\in P}e_p\ln p\le\ln|N|.
\]
~~~

Proof

~~~tex
By unique factorization, $\ln|N|=\sum_p v_p(N)\ln p$. Keep the terms indexed by $P$ and bound each of them below by $e_p\ln p$.
~~~

#### ZEA3 — Example — Primes between $n$ and $2n$

~~~tex
For every integer $n\ge1$,
\[
\sum_{n<p\le2n}\ln p\le2n\ln 2,
\]
where the sum runs over primes.
~~~

Proof

~~~tex
For $n<p\le2n$, the prime $p$ divides $(2n)!$ and is coprime to $n!$, so it divides $\binom{2n}{n}$. Apply \ref{8V4M} with $e_p=1$ and use $\binom{2n}{n}\le\sum_{k=0}^{2n}\binom{2n}{k}=2^{2n}$.
~~~

#### CQAP — Lemma — Legendre's formula and the factorial identity

~~~tex
For every integer $n\ge1$ and every prime $p$,
\[
v_p(n!)=\sum_{h\ge1}\left\lfloor\frac{n}{p^h}\right\rfloor,
\qquad
\ln(n!)=\sum_{r\le n}\Lambda(r)\left\lfloor\frac{n}{r}\right\rfloor.
\]
~~~

Proof

~~~tex
Each multiple of $p^h$ contributes one to the count at level $h$, so an integer with valuation $j$ contributes at precisely $j$ levels. There are $\lfloor n/p^h\rfloor$ such multiples at level $h$. Multiply by $\ln p$ and sum over $p$, using $\Lambda(p^h)=\ln p$.
~~~

#### HPW7 — Lemma — Chebyshev bounds

~~~tex
For every real $x\ge1$, $\Psi_{\mathbf 1}(x)\le 4x\ln 2$. For every real $x\ge6$,
\[
\Psi_{\mathbf 1}(x)\ge\frac{\ln 2}{3}\,x.
\]
~~~

Proof

~~~tex
By \ref{CQAP}, the coefficient of $\Lambda(r)$ in $\ln\binom{2n}{n}$ is $\lfloor2n/r\rfloor-2\lfloor n/r\rfloor$. It is $0$ or $1$, and it is $1$ for $n<r\le2n$. Thus
\[
\Psi_{\mathbf 1}(2n)-\Psi_{\mathbf 1}(n)
\le \ln\binom{2n}{n}\le \Psi_{\mathbf 1}(2n).
\]
The binomial sum bounds the middle expression above by $2n\ln 2$. Sum the resulting difference bound over consecutive powers of $2$ and use $\Psi_{\mathbf 1}(1)=0$. At the least power of $2$ greater than or equal to $x$, this gives $\Psi_{\mathbf 1}(x)\le 4x\ln 2$ by monotonicity.

The central coefficient is the largest of the $2n+1$ coefficients, as the ratio of consecutive coefficients is $(2n-k)/(k+1)$ at index $k$. Hence $\binom{2n}{n}\ge 2^{2n}/(2n+1)$. For $n\ge3$, $2n+1\le2^n$ by induction, starting at $n=3$. Taking $n=\lfloor x/2\rfloor\ge x/3$ for $x\ge6$ proves the lower bound.
~~~

#### JMUK — Proposition — The ramp and the fractional parts

~~~tex
For every real $x\ge1$, the ramp sum $R_{\mathbf 1}$ of \ref{8JF7} satisfies
\[
x\sum_{r\le x}\frac{\Lambda(r)}{r}
=R_{\mathbf 1}(x)+\Psi_{\mathbf 1}(x).
\]
For integers $n\ge1$, write $\{y\}=y-\lfloor y\rfloor$ and put $E(n)=\sum_{r\le n}\Lambda(r)\{n/r\}$. Then
\[
R_{\mathbf 1}(n)=\ln(n!)-\Psi_{\mathbf 1}(n)+E(n).
\]
There are absolute constants $c>0$ and $n_0\ge1$ such that
$cn\le E(n)\le4n\ln 2$ for every integer $n\ge n_0$.
~~~

Proof

~~~tex
For $r\le x$, the summand in $R_{\mathbf 1}(x)$ is $\Lambda(r)(x/r-1)$, and all terms with $r>x$ vanish. Add $\Psi_{\mathbf 1}(x)$ and apply \ref{CQAP} at $x=n$. The upper bound follows from $0\le\{n/r\}<1$ and \ref{HPW7}.

For the lower bound, put $\vartheta_3(t)=\sum_{p\le t,\ p\equiv3\bmod 4}\ln p$. The prime number theorem for the fixed modulus $4$ gives $\vartheta_3(t)=t/2+O(t/(\ln t)^2)$ for $t\ge2$ \cite[Chapter 20]{Davenport}. Consequently $\vartheta_3(2n/3)-\vartheta_3(3n/5)=n/30+O(n/(\ln n)^2)$. Every prime in this interval contributes $\{n/p\}=n/p-1\ge1/2$. For example, one can take $c=1/120$ and choose $n_0$ so that the absolute error in the difference is at most $n/60$ for $n\ge n_0$.

Comparing $\ln(n!)$ with $\int_1^n\ln t\,dt$ gives $\ln(n!)=n\ln n-n+O(\ln(n+1))$. The floor correction is of the same order as the linear term. In $G_{\mathbf 1}(n)$ the term $n\ln n$ cancels, leaving $\gamma n-\Psi_{\mathbf 1}(n)+E(n)+O(\ln(n+1))$. Treating the fractional parts only by their size gives an error of order $n$. The Chebyshev bounds in \ref{HPW7} illustrate this scale, while \ref{8JK2} asks for an upper bound at square-root precision.
~~~

### WJQV — What a better object must do

~~~tex
Suppose that at cutoff $x$ the desired prime-power count is $T(x)$, with main term $M(x)$, and that the divisibility and size are measured on a common scale $B(x)>0$. A lower bound $B(x)T(x)-E_{\rm div}(x)$ for the divisibility and an upper bound $B(x)M(x)+E_{\rm size}(x)$ for the size would give
\[
T(x)-M(x)\le\frac{E_{\rm div}(x)+E_{\rm size}(x)}{B(x)}.
\]
This is the comparison of \ref{8V4M} with three requirements.

\begin{enumerate}
\item[(i)] The divisibility lower bound should have explicit exponents varying smoothly with the prime power, for example $(x/p^h-1)_+$. After summation and division by $B(x)$, the rounding allowance must fit within $O_\eta(x^{1/2+\eta})$.
\item[(ii)] The size upper bound should match the main term of the count through the term linear in $x$. Its normalized error must fit the same budget, which is $O_\eta(x^{-1/2+\eta})$ relative to the linear scale $x$.
\item[(iii)] The counted primes must be all primes or belong to classes whose counts can be combined to give the desired centered sum. For \ref{8JK2} this combination must yield the character weights of $\mathcal G_\psi$ up to errors within the same budget.
\end{enumerate}

The lemniscate sine illustrates the change in the shape of the exponents. The smooth contributions at inert primes $p\equiv3\bmod 4$ involve odd powers $p^h$. The example can be read directly from the derivative recurrence, and the valuation proof explains the role of the height-two logarithm.
~~~

#### 9DWZ — Definition — Lemniscate derivatives

~~~tex
Let $\operatorname{sl}$ be the local inverse at $0$ of the holomorphic function
\[
\ell(t)=\int_0^t\frac{du}{\sqrt{1-u^4}},
\]
for $t\in\C$ near $0$, where the branch of the square root equals $1$ at $0$. For every integer $n\ge0$, put $A_n=\operatorname{sl}^{(n)}(0)$.
~~~

#### 6HEC — Lemma — The derivative recurrence

~~~tex
The coefficients $A_n$ of \ref{9DWZ} are integers. They satisfy $A_0=0$, $A_1=1$ and, for every integer $m\ge0$,
\[
A_{m+2}=-2\sum_{i+j+k=m}\binom{m}{i,j,k}A_iA_jA_k,
\]
where $i,j,k$ range over nonnegative integers. Also $A_n=0$ unless $n\equiv1\bmod 4$.
~~~

Proof

~~~tex
Differentiating $\ell(\operatorname{sl}(z))=z$ gives $(\operatorname{sl}')^2=1-\operatorname{sl}^4$ and $\operatorname{sl}'(0)=1$. Differentiate once more and divide by $2\operatorname{sl}'$, which is nonzero near $0$, to get $\operatorname{sl}''=-2\operatorname{sl}^3$. The product rule gives the recurrence and hence integrality by induction. A term in the sum can be nonzero only if each index is $1$ modulo $4$. Their sum is then $3$ modulo $4$, so $m+2$ is $1$ modulo $4$.
~~~

#### 9QGA — Unlisted lemma — Inverting the height-two logarithm

~~~tex
For an odd prime $p$, let $q=p^2$, $c_p=p/(q-1)$, and let $g$ be the formal inverse of
\[
\ell_p(X)=\sum_{d\ge0}\frac{(-1)^d X^{q^d}}{p^d}.
\]
For positive integers $n,j$, the coefficient $[z^n]g(z)^j$ vanishes unless $n\ge j$ and $n\equiv j\bmod(q-1)$. In those degrees,
\[
v_p\bigl(n![z^n]g(z)^j\bigr)\ge c_p(n-j)+v_p(j!).
\]
~~~

Proof

~~~tex
The equation $\ell_p(g(z))=z$ gives $g=z-\sum_{d\ge1}(-1)^d g^{q^d}/p^d$. Induction on degree shows that $g$ is supported in degrees $1$ modulo $q-1$, since each $q^d$ is $1$ modulo $q-1$.

Put $r=p^{c_p}$ and $H(z)=r g(z/r)$. The support condition makes the coefficients of $H$ rational. In its recursion the term $H^{q^d}$ has coefficient $-(-1)^d/p^{D_d}$, where $D_d=d+c_p(q^d-1)$ is an integer. By \ref{CQAP},
\[
v_p((q^d)!)=\frac{q^d-1}{p-1}
=D_d+\frac{q^d-1}{q-1}-d\ge D_d.
\]
For any series $F$ with zero constant term and integral derivatives at $0$, the derivatives of $F^a/a!$ for positive integers $a$ are integral. Its $n$th derivative is a sum over partitions of an $n$-element set into $a$ nonempty blocks, with the product of $F^{(|B|)}(0)$ over blocks $B$. The recursion for $H$ involves integral multiples of $H^{q^d}/(q^d)!$, and the coefficient of degree $n$ in each such power uses only lower degrees of $H$. Induction gives integral derivatives for $H$ and therefore for $H^j/j!$. Now $g(z)^j=r^{-j}H(rz)^j$, which multiplies the coefficient of degree $n$ by $p^{c_p(n-j)}$ in the stated degrees.
~~~

#### 3QUC — Proposition — Divisibility of the lemniscate derivatives

~~~tex
\begin{enumerate}
\item[(i)] For every prime $p\equiv3\bmod 4$ and integer $n\ge1$,
\[
v_p(A_n)\ge\left\lfloor\frac{np}{p^2-1}\right\rfloor
>n\sum_{\substack{h\ge1\\h\ {\rm odd}}}\frac{1}{p^h}-1.
\]
\item[(ii)] For every prime $p\equiv1\bmod 4$, $v_p(A_p)=0$.
\end{enumerate}
~~~

Proof

~~~tex
\emph{(i)} Use the elliptic curve $E$ with equation $Y^2=X^3-X$. Its formal group is the power series for addition near the identity in a local parameter. If $u=\operatorname{sl}(z)$, set $X=u^{-2}$ and $Y=-\operatorname{sl}'(z)u^{-3}$. These satisfy the equation and give $dX/(2Y)=dz$. The usual parameter $-X/Y$ is $u/\sqrt{1-u^4}$, an integral change of coordinate at every odd prime. Its inverse is integral by solving for successive coefficients, since its linear coefficient is $1$. Thus $u$ is also an integral parameter, and its formal logarithm, the integral of the invariant differential with zero constant term, is $\ell(u)$ of \ref{9DWZ}.

The curve has good reduction at odd $p$, since $X^3-X$ has three distinct roots there. For $p\equiv3\bmod4$, the terms in the point count at $X$ and $-X$ cancel in the quadratic-character sum: their right sides are negatives and $-1$ is a nonsquare. Thus $\#E(\mathbb F_p)=p+1$ and the local Euler factor is $(1+p^{1-2s})^{-1}$. Apply \cite[Theorem 5 with the prime set $\{p\}$]{Honda1968}. The Dirichlet coefficient at $p^{2d}$ is $(-p)^d$, so Honda's logarithm is precisely $\ell_p$ of \ref{9QGA}. The theorem gives an integral change of coordinate between the two formal groups over $\Z_{(p)}$, the rationals with denominator prime to $p$. With linear coefficient $1$ this change, from the model to $E$ in parameter $u$, is $U=\operatorname{sl}\circ\ell_p$. Indeed both logarithms are normalized to have linear coefficient $1$. The series $U$ is odd since both factors are odd. This is the height-two model, in which the successive degrees of the logarithm are powers of $p^2$.

Write $\operatorname{sl}(z)=U(g(z))$. Only odd $j\ge1$ occur in $U$, with $p$-integral coefficients. For such $j$, write $j=\sum_{i\ge0}d_i p^i$ in base $p$. Applying \ref{CQAP} gives
\[
(p^2-1)v_p(j!)-pj
=-p d_0-d_1+\sum_{i\ge2}(p^i-p-1)d_i>-(p^2-1).
\]
Equality in the lower bound would require $d_0=d_1=p-1$ and all other digits zero, which would make $j=p^2-1$ even. Thus each derivative term from $U_jg^j$ has valuation greater than $c_p n-1$ by \ref{9QGA}. The sum has the same lower bound. Since $n$ with $A_n\ne0$ is odd, $c_p n$ is nonintegral, so the integer valuation is at least $\lfloor c_p n\rfloor$. Finally $p/(p^2-1)=\sum_{h\ge1,\ h\ {\rm odd}}p^{-h}$ by the geometric series.

\emph{(ii)} The coefficient of $t^{4k+1}$ in $\ell(t)$ is $4^{-k}\binom{2k}{k}/(4k+1)$, by the binomial series. The coefficients of degrees below $p$ are $p$-integral. In degree $p$, $k=(p-1)/4$ gives $2k<p$, so the coefficient has valuation $-1$. Inverting the series degree by degree shows that the coefficient of degree $p$ in $\operatorname{sl}$ is the negative of this coefficient plus a $p$-integral number. Multiplication by $p!$ gives valuation $0$.
~~~

#### 9KTS — Example — A table of lemniscate valuations

~~~tex
For inert $p=3,7,11$, each pair gives $v_p(A_n)$ and the lower bound $\lfloor np/(p^2-1)\rfloor$. The split-prime columns give $v_p(A_n)$.
\[
\begin{array}{c|ccc|cc}
n & p=3 & p=7 & p=11 & p=5 & p=13\\ \hline
13  &(4,4)&(1,1)&(2,1)&0&0\\
29  &(10,10)&(4,4)&(2,2)&0&0\\
53  &(19,19)&(7,7)&(4,4)&0&0\\
105 &(39,39)&(15,15)&(9,9)&0&0
\end{array}
\]
The table uses the integer recurrence of \ref{6HEC}, followed by repeated division by each prime.
~~~

#### ZFM6 — Proposition — Three defects of the integer comparison

~~~tex
For integers $n\ge1$ with $n\equiv1\bmod 4$, put
\[
B(n)=\sum_{\substack{p\le n\\p\equiv3\bmod4}}
          \left\lfloor\frac{np}{p^2-1}\right\rfloor\ln p.
\]
Then $A_n\ne0$ and $B(n)\le\ln|A_n|$. The comparison has three defects.

\begin{enumerate}
\item[(D1)] Removing the floors in $B(n)$ increases the sum by an amount between $c n$ and $C n$ for some absolute $c,C>0$ and all such $n\ge n_1$, for some absolute $n_1$.
\item[(D2)] The guaranteed exponents use only inert primes. On odd prime powers $p^h$, the corresponding selection with weight two is $1-\chi_4(p^h)$, where $\chi_4$ is the nontrivial character modulo $4$.
\item[(D3)] As $n$ tends to infinity through $n\equiv1\bmod4$,
\[
B(n)=\tfrac12 n\ln n+O(n),
\qquad
\ln|A_n|=n\ln n+O(n).
\]
\end{enumerate}
~~~

Proof

~~~tex
\emph{(D1)} The increase is at most $\sum_{p\le n}\ln p\le4n\ln 2$ by \ref{HPW7}. For $3n/5<p\le2n/3$ and $p\ge3$, $np/(p^2-1)$ lies between $3/2$ and $15/8$. Its fractional part is at least $1/2$. The inert primes in this interval give the same linear lower bound as in the proof of \ref{JMUK}.

\emph{(D2)} For odd $p$, $\chi_4(p)=(-1)^{(p-1)/2}$. The primes $p\equiv3\bmod4$ are inert in $\Z[i]$ and the primes $p\equiv1\bmod4$ split, since $\Z[i]/p\Z[i]\cong\mathbb F_p[X]/(X^2+1)$. By cyclicity of $\mathbb F_p^\times$, $-1$ is a square precisely when $4\mid p-1$. Thus $1-\chi_4(p^h)$ is $2$ exactly for the odd powers at inert primes and $0$ otherwise. The split-prime calculation in \ref{3QUC} illustrates the absence of a corresponding forced exponent there.

\emph{(D3)} Partial summation with $\vartheta_3(t)$ as in \ref{JMUK} gives
$\sum_{p\le n,\ p\equiv3\bmod 4}(\ln p)/p=\tfrac12\ln n+O(1)$, since the integral of the error is bounded by a constant times $\int_2^\infty dt/(t(\ln t)^2)$. The difference $p/(p^2-1)-1/p=1/(p(p^2-1))$ gives a convergent sum against $\ln p$. This proves the formula for $B(n)$ using (D1).

Write the coefficient of $z^{4k+1}$ in $\operatorname{sl}(z)$ as $(-1)^k b_k$. The differential equation in \ref{6HEC} gives
\[
b_0=1,\qquad
b_k=\frac{2}{4k(4k+1)}\sum_{i+j+l=k-1} b_i b_j b_l
\quad(k\ge1).
\]
There are $k(k+1)/2$ ordered triples in this sum. The factor $(k+1)/(4(4k+1))$ is between $1/16$ and $1/10$, so induction gives $16^{-k}\le b_k\le10^{-k}$. In particular $A_n\ne0$ for $n=4k+1$ and $\ln|A_n|=\ln(n!)+O(n)=n\ln n+O(n)$. Now \ref{3QUC} and \ref{8V4M} give $B(n)\le\ln|A_n|$. The size bound has twice the leading coefficient of the guaranteed divisor sum, so the comparison has a gap of order $n\ln n$ before one compares the linear terms.
~~~

#### 4Y6Q — Remark — From the integer to the lattice comparison

~~~tex
For $a,w\in\R$ with $a,w>0$, put $x=a/w$. Subtracting the weight and taking the positive part gives
\[
\left(\frac{a}{p^h}-w\right)_+
=w\left(\frac{x}{p^h}-1\right)_+.
\]
The identity follows by factoring out $w>0$. This is the smoothing in \ref{8JU9}, with $a=\upsilon$ there.

For (D2), \ref{8JU2} organizes the prime powers into a table of residue classes as in \ref{8JV7}. The \hyperref[8JV6]{finite-group averages} and the \hyperref[8JU5]{Fourier comparison} there transfer an upper bound for the normalized centered count to $\mathcal G_\psi$.

For (D1) and (D3), \ref{8JV5} outlines the comparison for maps between lattices built from chains of theta lifts. In \ref{8JU4} the slope inequality compares the finite-place divisibility with bounds from norms and lattice sizes. The weights of \ref{8JVK} magnify the prime-power contributions, with the normalized losses tracked in \ref{8JV2}. The size calculation must match the prime-power main term through the linear term, using the cancellation in \ref{8JUC}.

The error analysis in \ref{8JU6} balances a cost $x/m$ from the ends of the chain against a cost $m$ from its steps. At $m$ near $\sqrt{x}$ both have square-root size, as reflected in the parameters of \ref{8JUG}.
~~~

## Migration and verification

[Guarded SQL migration](../../scripts/chebyshev-chapter-2026-11-27.sql) · [Exact valuation script](../../scripts/chebyshev-lemniscate.py)

| Chapter | Tag | Title |
| --- | --- | --- |
| 1 | `7HA2` | From an interval estimate to GRH |
| 2 | `UTUF` | From Chebyshev's method to smooth divisibility |
| 3 | `8JU2` | The Fourier step |
| 4 | `8JV5` | The arithmetic bound |

The chapter and section IDs are `115–117` in the order `UTUF`, `4M8T`, `WJQV`. The 12 result tags in order are `8V4M`, `ZEA3`, `CQAP`, `HPW7`, `JMUK`, `9DWZ`, `6HEC`, `9QGA`, `3QUC`, `9KTS`, `ZFM6`, and `4Y6Q`, with IDs `172–183`. The nine proofs use IDs `140–148`. The height-two model computation is available through its reference as an unlisted lemma. The other results are listed. The tag and ID checks used the live registry and revision maxima from read-only D1 queries.

### Renumbered references

| Field | Before | After |
| --- | --- | --- |
| `8JU2` intro | `Chapter 3 (\ref{8JV5})` | `Chapter 4 (\ref{8JV5})` |
| `8JU3` intro | `In Chapter 2, \ref{8JU7}` | `In Chapter 3, \ref{8JU7}` |
| `8JU6` intro | `Chapter 2 normalization` | `Chapter 3 normalization` |
| `8JV5` intro | `used in Chapter 2` | `used in Chapter 3` |
| `8JV5` intro | `the Chapter 2 theorem` | `the Chapter 3 theorem` |
| `8JV8` intro | `Chapter 3 supplies` | `Chapter 4 supplies` |
| `8JV3` statement | `prime-power count of Chapter 2` | `prime-power count of Chapter 3` |
| `8JV7` intro | `§2.3` | `§3.3` |

The Chapter 1 intro `7HA2`, the interval-estimate section intro `7HH9`, and the statement of `8JK2` now also link to `UTUF`.

### Recomputed table

Run `python -I scripts/chebyshev-lemniscate.py`. For inert primes the entries are the valuation and the floor of the model exponent. The split-prime entries are valuations.

| $n$ | $p=3$ | $p=7$ | $p=11$ | $p=5$ | $p=13$ |
| --- | --- | --- | --- | --- | --- |
| 13 | 4, 4 | 1, 1 | 2, 1 | 0 | 0 |
| 29 | 10, 10 | 4, 4 | 2, 2 | 0 | 0 |
| 53 | 19, 19 | 7, 7 | 4, 4 | 0 | 0 |
| 105 | 39, 39 | 15, 15 | 9, 9 | 0 | 0 |

As a separate check, the polynomial derivation \(D(u)=y\), \(D(y)=-2u^3\) on \(y^2=1-u^4\), evaluated at \((u,y)=(0,1)\), agreed with the recurrence through order 105.

### Validation and scope

- Ran isolated Python with SQLite 3.50.4 from `C:\tmp`. The on-disk temp-file attempt was blocked by the sandbox, so the SQLite copy was in memory. Loaded the full export, then applied `move-auxiliary-data`, `refs-sync`, and the chapter migration in that order.
- The guard passed once. A rerun, a missing old substring, and a tag collision each failed the guard and rolled back without changes. Verified foreign keys, integrity, revision snapshots, cleared caches, and the `needs_rebuild` flag, including a separate run from `0`.
- The project's `loadBook` produced the chapter order shown above and numbered the new sections `2.1` and `2.2`. Scans of all existing intro, statement, and proof TeX found no stale chapter or section numbers.
- The project renderer and stored macros rendered 65 TeX fields, titles, and bibliography entries without warnings. The 45 stored statement and proof edges for inserted or edited rows matched the parser output. All 25 repository tests passed with Node test isolation disabled because the sandbox blocks spawning test subprocesses.
- The chapter proves its integer comparisons and valuation calculation. Its external mathematical inputs are Honda's change of formal-group coordinate and the classical prime number theorem for the fixed modulus \(4\). The bibliography adds `Honda1968` and `Erdos1932` and reuses `Davenport`. The supplied PDF informed the strategy, while the theta-lift and slope comparison appears as a roadmap to Chapter 4. [Honda, Theorem 5](https://ir.library.osaka-u.ac.jp/repo/ouka/all/8997/ojm05_02_05.pdf) · [Erdős's original paper](https://acta.bibl.u-szeged.hu/13396/) · [Davenport, third edition](https://link.springer.com/book/9780387950976)
- Remote D1 queries were read-only. The deliverables are local workspace files.
