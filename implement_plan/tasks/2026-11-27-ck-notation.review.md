# Taylor coefficient notation review

Deletions appear as `[-…-]` and insertions as `{+…+}`.

## 8JT2 statement

Section 104, ID 123, revision 5 → 6.

~~~text
@@ -2,3 +2,3 @@ Let $\psi$ be a primitive character and $0 < \theta < 1$. Suppose that for every
\[ \mathcal G_\psi(x) \le x^\theta \qquad \text{for all } x \in [Y, Y^{3/2}]. \]
Let $A_k$ be the \hyperref[TQ4B]{Taylor coefficients} of $\mathcal H_\psi$. Then there is [-$\sigma_0-]{+$c_0+} > 2$ such that for every real [-$\sigma-]{+$c+} \ge [-\sigma_0$-]{+c_0$+} there are a constant $C > 0$ and an infinite set $K$ of positive integers with
\[ \text{for all } k \in K \text{ and all } [-\tau-]{+y+} \in \R: \qquad [-|A_k(\sigma + i\tau)|-]{+|A_k(c+iy)|+} + \Re [-A_k(\sigma)-]{+A_k(c)+} \le [-C\,(\sigma - \theta)^{-k}.-]{+C\,(c-\theta)^{-k}.+} \]
~~~

## 8JT2 proof

Section 104, ID 109, revision 14 → 15.

~~~text
@@ -1,9 +1,9 @@
Put $g(u) = \mathcal G_\psi(e^u)$, a real function, and $g_+ = \max(g, 0)$. Let [-$\sigma_0-]{+$c_0+} = 200$, as in the \hyperref[8JT4]{concentration of the kernel}, and fix a real [-$\sigma-]{+$c+} \ge [-\sigma_0$.-]{+c_0$.+} For each $Y \ge 2$ given by the hypothesis put $U = \ln Y$ and
\[ W = [U, \tfrac32 U], \qquad k = \bigl\lceil \tfrac54 [-\sigma-]{+c+} U \bigr\rceil, \qquad K_k(u) = \frac{u^k [-e^{-\sigma u}}{k!}.-]{+e^{-cu}}{k!}.+} \]
Here $W$ is the window $Y \le x \le Y^{3/2}$ in the variable $u = \ln x$, and $k$ puts the peak $u = [-k/\sigma$-]{+k/c$+} of $K_k$ (see the \hyperref[8JT6]{graphs of $K_k$}) at the midpoint $\frac54 U$ of $W$, up to rounding. As $k$ grows, almost all of the kernel lies in $W$ (see \hyperref[8JT7]{how $K_k$ concentrates in $W$}). Then for every [-$\tau-]{+$y+} \in \R$
\begin{alignat*}{2}
[-|A_k(\sigma + i\tau)|-]{+|A_k(c+iy)|+} + \Re [-A_k(\sigma)-]{+A_k(c)+} &\le \int_0^\infty (|g| + g)\, K_k = 2\int_0^\infty g_+ K_k &\qquad& \text{(a)} \\
&\le 2\int_W e^{\theta u} K_k + 2C_\psi \int_{u \notin W} e^{2u} K_k && \text{(b)} \\
&\le [-2(\sigma - \theta)^{-k-1}-]{+2(c-\theta)^{-k-1}+} + 4 C_\psi\, [-\sigma^{-k}-]{+c^{-k}+} && \text{(c)} \\
&\le (2 + 4C_\psi)\, [-(\sigma - \theta)^{-k},-]{+(c-\theta)^{-k},+} && \text{(d)}
\end{alignat*}
@@ -11,6 +11,6 @@ where:
\begin{itemize}
\item[(a)] [-\hyperref[8JT3]{$A_k(\sigma + i\tau)-]{+\hyperref[8JT3]{$A_k(c+iy)+} = \int_0^\infty g\, K_k\, [-e^{-i\tau u}\,du$},-]{+e^{-iyu}\,du$},+} with $K_k \ge 0$ and [-$|e^{-i\tau u}|-]{+$|e^{-iyu}|+} = 1$;
\item[(b)] $g_+ \le e^{\theta u}$ on $W$ by the hypothesis, and $g_+ \le C_\psi e^{2u}$ everywhere by \ref{8JS3};
\item[(c)] the \hyperref[8JT4]{concentration of the kernel};
\item[(d)] [-$\sigma-]{+$c+} \ge [-\sigma - \theta-]{+c-\theta+} \ge 1$.
\end{itemize}
~~~

## 8JT3 proof

Section 104, ID 110, revision 1 → 2.

~~~text
@@ -1,3 +1,3 @@
\emph{(1)} \textbf{The derivative may be taken under the integral sign.} By \ref{8JS3}, $|g(u)| \le C_\psi e^{2u}$. Hence for $\Re s \ge [-\sigma_1-]{+c_1+} > 2$,
\[ \bigl|g(u)\, u^k e^{-su}\bigr| \le C_\psi\, u^k [-e^{-(\sigma_1-]{+e^{-(c_1+} - 2)u}, \]
which is integrable in $u$ and independent of $s$, so dominated convergence applies.
~~~

## 8JT4 statement

Section 104, ID 125, revision 2 → 3.

~~~text
@@ -1,6 +1,6 @@
For real [-$\sigma-]{+$c+} > 2$ and integers $k \ge 0$ let $K_k(u) = u^k [-e^{-\sigma u}/k!$-]{+e^{-cu}/k!$+} for $u \ge 0$.
\begin{enumerate}
\item[(i)] For every real $a < [-\sigma$,-]{+c$,+} $\displaystyle\int_0^\infty e^{au} K_k(u)\,du = [-(\sigma-]{+(c+} - a)^{-k-1}$.
\item[(ii)] Let [-$\sigma-]{+$c+} \ge 200$ and $U > 0$, and put $W = [U, \frac32 U]$ and $k = \lceil \frac54 [-\sigma-]{+c+} U \rceil$. Then
\[ \int_{u \notin W} e^{2u} K_k(u)\,du \le [-2\sigma^{-k}.-]{+2c^{-k}.+} \]
\end{enumerate}
~~~

## 8JT4 proof

Section 104, ID 111, revision 3 → 4.

~~~text
@@ -1,14 +1,14 @@
\emph{(i)} \textbf{This is a Gamma integral.} Substitute $v = [-(\sigma-]{+(c+} - a)u$ in $\int_0^\infty u^k [-e^{-(\sigma-]{+e^{-(c+} - a)u}\,du$ and use $\int_0^\infty v^k e^{-v}\,dv = k!$.

\emph{(ii)} \textbf{Outside $W$, bound $1$ by an exponential and integrate over all $u$ with (i).} Put $t = [-\sigma/5$.-]{+c/5$.+} We use $\frac54 [-\sigma-]{+c+} U \le k < \frac54 [-\sigma-]{+c+} U + 1$ and, since [-$\sigma-]{+$c+} \ge 200$,
\[ \frac45 - [-\frac2\sigma-]{+\frac2c+} \ge 0.79 > e^{-6/25} \approx 0.787, \qquad \frac65 - [-\frac2\sigma-]{+\frac2c+} \ge 1.19 > e^{4/25} \approx 1.174. \]

\emph{Right of $W$.} For $u > \frac32 U$ we have $1 \le e^{t(u - 3U/2)}$. Hence, by (i) with $a = 2 + t < [-\sigma$,-]{+c$,+}
\begin{align*}
\int_{u > 3U/2} e^{2u} K_k(u)\,du &\le e^{-3tU/2} \int_0^\infty e^{(2+t)u} K_k(u)\,du \\
&= [-e^{-3\sigma-]{+e^{-3c+} U/10} \Bigl(\frac45 [-\sigma-]{+c+} - 2\Bigr)^{-k-1} \\
&\le e^{6/25}\, e^{-6k/25}\, [-\sigma^{-k-1}-]{+c^{-k-1}+} \Bigl(\frac45 - [-\frac2\sigma\Bigr)^{-k-1}-]{+\frac2c\Bigr)^{-k-1}+} \\
&= [-\sigma^{-k}-]{+c^{-k}+} \cdot \frac{e^{6/25}}{\frac45 [-\sigma-]{+c+} - 2} \cdot \biggl(\frac{e^{-6/25}}{\frac45 - [-\frac2\sigma}\biggr)^{k}.-]{+\frac2c}\biggr)^{k}.+}
\end{align*}
The third line uses [-$\frac{3}{10}\sigma-]{+$\frac{3}{10}c+} U > \frac{6}{25}(k - 1)$. In the last line the middle factor is less than $1$ and the last factor is at most $1$, so the integral is at most [-$\sigma^{-k}$.-]{+$c^{-k}$.+}

@@ -17,6 +17,6 @@ The third line uses $\frac{3}{10}\sigma U > \frac{6}{25}(k - 1)$. In the last li
\int_{u < U} e^{2u} K_k(u)\,du &\le e^{tU} \int_0^\infty e^{(2-t)u} K_k(u)\,du \\
&= [-e^{\sigma-]{+e^{c+} U/5} \Bigl(\frac65 [-\sigma-]{+c+} - 2\Bigr)^{-k-1} \\
&\le [-\sigma^{-k}-]{+c^{-k}+} \cdot \frac{1}{\frac65 [-\sigma-]{+c+} - 2} \cdot \biggl(\frac{e^{4/25}}{\frac65 - [-\frac2\sigma}\biggr)^{k},-]{+\frac2c}\biggr)^{k},+}
\end{align*}
using $\frac15 [-\sigma-]{+c+} U \le \frac{4}{25} k$. Again both factors after [-$\sigma^{-k}$-]{+$c^{-k}$+} are at most $1$.
~~~

## 8JT5 statement

Section 104, ID 136, revision 2 → 3.

~~~text
@@ -1,2 +1,2 @@
Let $\psi$ be a primitive character and $0 < \theta < 1$. Suppose that some pole $\rho$ of $\mathcal H_\psi$, that is, some $\rho$ in the \hyperref[8JN4]{set of poles} $Z$, satisfies $\Re\rho > \theta$. Let $A_k$ be the \hyperref[TQ4B]{Taylor coefficients} of $\mathcal H_\psi$. Then for every real [-$\sigma-]{+$c+} > 1$ there are [-$\tau-]{+$y+} \in \R$, [-$c-]{+$C_1+} > 0$, $0 < d < [-\sigma - \theta$-]{+c-\theta$+} and $k_0 \ge 0$ with
\[ \text{for all } k \ge k_0: \qquad [-|A_k(\sigma + i\tau)|-]{+|A_k(c+iy)|+} + \Re [-A_k(\sigma)-]{+A_k(c)+} \ge [-c\,-]{+C_1\,+} d^{-k}. \]
~~~

## 8JT5 proof

Section 104, ID 121, revision 2 → 3.

~~~text
@@ -1,21 +1,21 @@
\emph{Idea.} $A_k(z)$ is the $k$-th Taylor coefficient of $w \mapsto \mathcal H_\psi(z - w)$. If $z$ has a unique nearest pole, at distance $d$, then $|A_k(z)|$ grows like $d^{-k}$ (Step 1). A pole with $\Re\rho > \theta$ is closer than [-$\sigma - \theta$-]{+$c-\theta$+} to the line $\Re [-s = \sigma$;-]{+s=c$;+} we find a point of that line where it shows up in $A_k$.

\emph{Step 1: Taylor coefficients near a pole.} Let $\Re z > 1$, and let $\overline B(z, r)$ be a closed disc in $\Re s > 0$ that contains exactly one pole $\rho$ of $\mathcal H_\psi$, with residue [-$c_\rho$.-]{+$\operatorname{Res}_\rho$.+} Then
\[ A_k(z) = [-\frac{c_\rho}{(z-]{+\frac{\operatorname{Res}_\rho}{(z+} - \rho)^{k+1}} + O(r^{-k}) \qquad (k \to \infty). \]
Indeed, write $\mathcal H_\psi(s) = [-\frac{c_\rho}{s-]{+\frac{\operatorname{Res}_\rho}{s+} - \rho} + h(s)$ with $h$ holomorphic on a neighbourhood of $\overline B(z, r)$. Since $\frac{d^k}{ds^k}\frac{1}{s - \rho} = \frac{(-1)^k k!}{(s - \rho)^{k+1}}$, the first term contributes [-$\frac{c_\rho}{(z-]{+$\frac{\operatorname{Res}_\rho}{(z+} - \rho)^{k+1}}$ to $A_k(z)$, and Cauchy's estimate gives $\frac{|h^{(k)}(z)|}{k!} \le r^{-k} \max_{|s - z| = r} |h(s)|$. In the same way $A_k(z) = O(r^{-k})$ if $\overline B(z, r)$ contains no pole.

\emph{Step 2: two distances.} Fix [-$\sigma-]{+$c+} > 1$, and put $D_* = [-\sigma - \theta$-]{+c-\theta$+} and $D = \min_{\rho \in Z} [-|\sigma-]{+|c+} - \rho|$, the distance from [-$\sigma$-]{+$c$+} to the nearest pole; the minimum exists because $Z$ is nonempty and \hyperref[8JS5]{locally finite}. Every pole is \hyperref[8JN4]{simple with nonzero residue}, and every pole has $\Re\rho < 1 < [-\sigma$,-]{+c$,+} since $L(s,\chi) \ne 0$ for $\Re s \ge 1$ \cite{Davenport}. By hypothesis some $\rho_0 \in Z$ has [-$\sigma-]{+$c+} - \Re\rho_0 < D_*$. All discs below are centred on the line $\Re [-s = \sigma$-]{+s=c$+} and have radius less than $D_* < [-\sigma$,-]{+c$,+} so they lie in $\Re s > 0$.

\emph{Case (a): some pole $\rho_1$ has [-$\sigma-]{+$c+} - \Re\rho_1 < \min(D, D_*)$.} Choose a closed interval $J$ around $\Im\rho_1$ such that [-$|\sigma + i\tau-]{+$|c+iy+} - \rho_1| < \min(D, D_*)$ for all [-$\tau-]{+$y+} \in J$. Only finitely many poles lie within distance $\min(D, D_*)$ of the compact segment [-$\{\sigma + i\tau-]{+$\{c+iy+} \mid [-\tau-]{+y+} \in J\}$. Two of them are equidistant from [-$\sigma + i\tau$-]{+$c+iy$+} for at most one [-$\tau$:-]{+$y$:+} if their imaginary parts differ, equality of the squared distances is a linear equation in [-$\tau$-]{+$y$+} with nonzero slope; if their imaginary parts agree, their real parts differ, and since both lie left of the line their distances to it differ. Choose [-$\tau-]{+$y+} \in J$ avoiding these finitely many values and put $z = [-\sigma + i\tau$.-]{+c+iy$.+} Then $z$ has a unique nearest pole $\rho$, at distance $d \le |z - \rho_1| < \min(D, D_*)$. Choose $r$ with $d < r < \min(D, D_*)$ such that $\rho$ is the only pole in $\overline B(z, r)$. The disc $\overline [-B(\sigma,-]{+B(c,+} r)$ contains no pole, as $r < D$. By Step 1,
\begin{align*}
|A_k(z)| + \Re [-A_k(\sigma)-]{+A_k(c)+} &\ge |A_k(z)| - [-|A_k(\sigma)|-]{+|A_k(c)|+} \\
&\ge [-|c_\rho|\,-]{+|\operatorname{Res}_\rho|\,+} d^{-k-1} - O(r^{-k}) \ge [-\frac{|c_\rho|}{2d}\,-]{+\frac{|\operatorname{Res}_\rho|}{2d}\,+} d^{-k}
\end{align*}
for all large $k$, because $d < r$. This is the claim with [-$c-]{+$C_1+} = [-|c_\rho|/(2d)$.-]{+|\operatorname{Res}_\rho|/(2d)$.+} We cannot simply take $z = [-\sigma$:-]{+c$:+} there the conjugate poles $\rho_1$ and $\bar\rho_1$ are equally close, and their contributions to [-$A_k(\sigma)$-]{+$A_k(c)$+} may cancel. See the \hyperref[8JT8]{picture of case (a)}.

\emph{Case (b): every pole has [-$\sigma-]{+$c+} - \Re\rho \ge \min(D, D_*)$.} For $\rho_0$ this gives $\min(D, D_*) \le [-\sigma-]{+c+} - \Re\rho_0 < D_*$, so $D < D_*$. A pole $\rho$ nearest to [-$\sigma$-]{+$c$+} satisfies $D = [-|\sigma-]{+|c+} - \rho| \ge [-\sigma-]{+c+} - \Re\rho \ge D$. So equality holds, $\rho$ is real, and $\rho = \beta = [-\sigma-]{+c+} - D$; in particular $\beta$ is the only pole at distance $D$ from [-$\sigma$.-]{+$c$.+} Its residue [-$c_\beta$-]{+$\operatorname{Res}_\beta$+} is positive by the \hyperref[8JS7]{corollary on real poles}. Choose $r$ with $D < r < D_*$ such that $\beta$ is the only pole in $\overline [-B(\sigma,-]{+B(c,+} r)$. By Step 1, [-$A_k(\sigma)-]{+$A_k(c)+} = [-c_\beta-]{+\operatorname{Res}_\beta+} D^{-k-1} + O(r^{-k})$, so with [-$\tau-]{+$y+} = 0$
\begin{align*}
[-|A_k(\sigma)|-]{+|A_k(c)|+} + \Re [-A_k(\sigma)-]{+A_k(c)+} &\ge 2\Re [-A_k(\sigma)-]{+A_k(c)+} \\
&\ge [-2c_\beta-]{+2\operatorname{Res}_\beta+} D^{-k-1} - O(r^{-k}) \ge [-\frac{c_\beta}{D}\,-]{+\frac{\operatorname{Res}_\beta}{D}\,+} D^{-k}
\end{align*}
for all large $k$. This is the claim with $d = D$ and [-$c-]{+$C_1+} = [-c_\beta/D$.-]{+\operatorname{Res}_\beta/D$.+} Here the sign of [-$c_\beta$-]{+$\operatorname{Res}_\beta$+} is essential: if [-$c_\beta$-]{+$\operatorname{Res}_\beta$+} were negative, [-$|A_k(\sigma)|-]{+$|A_k(c)|+} + \Re [-A_k(\sigma)$-]{+A_k(c)$+} could be small. See the \hyperref[8JT9]{picture of case (b)}.
~~~

## 8JT6 statement

Section 104, ID 137, revision 2 → 3.

~~~text
@@ -1,2 +1,2 @@
For [-$\sigma-]{+$c+} > 0$ and $k \ge 1$ let $K_k(u) = u^k [-e^{-\sigma u}/k!$-]{+e^{-cu}/k!$+} for $u \ge 0$, as in the \hyperref[8JT4]{concentration of the kernel}. Since $K_k(0) = 0$ and $\frac{d}{du} \ln K_k(u) = \frac ku - [-\sigma$-]{+c$+} for $u > 0$, the kernel increases up to $u = [-k/\sigma$-]{+k/c$+} and decreases after it. The graphs show $K_1$, $K_2$, $K_3$ for [-$\sigma-]{+$c+} = 1$, with dashed lines at the peaks $u = 1, 2, 3$.
\includegraphics[width=1, alt=The kernels K_1, K_2, K_3 for [-sigma-]{+c+} = 1, with dashed lines at their peaks]{/static/figures/gamma-kernel-a.svg}
~~~

## 8JT7 statement

Section 104, ID 138, revision 1 → 2.

~~~text
@@ -1,3 +1,3 @@
Let $U > 0$ and $W = [U, \frac32 U]$, and let [-$\sigma-]{+$c+} > 0$ and a positive integer $k$ satisfy [-$k/\sigma-]{+$k/c+} = \frac54 U$, so that the kernel $K_k(u) = u^k [-e^{-\sigma u}/k!$-]{+e^{-cu}/k!$+} peaks at the midpoint of $W$, as in the \hyperref[8JT2]{one-sided bound} up to rounding. Rescaled to peak value $1$, the kernel is
\[ [-\frac{K_k(u)}{K_k(k/\sigma)}-]{+\frac{K_k(u)}{K_k(k/c)}+} = [-\Bigl(\frac{\sigma u}{k}\Bigr)^{k}-]{+\Bigl(\frac{cu}{k}\Bigr)^{k}+} e^{k - [-\sigma u},-]{+cu},+} \]
which depends only on $k$ and $u/U$. The graphs show it for $k = 3, 30, 300$, with $W$ shaded. As $k$ grows, the kernel concentrates in $W$; part (ii) of the \hyperref[8JT4]{concentration of the kernel} is a quantitative version of this.
~~~

## 8JT8 statement

Section 104, ID 139, revision 1 → 2.

~~~text
@@ -1,2 +1,2 @@
This picture shows an illustrative configuration for case (a) in the proof of the \hyperref[8JT5]{lower bound for the Taylor coefficients}. The solid line is $\Re [-s = \sigma$,-]{+s=c$,+} the dashed line is $\Re s = \theta$, the strip between them is shaded, and $D_* = [-\sigma - \theta$.-]{+c-\theta$.+} Here the poles nearest to [-$\sigma$-]{+$c$+} are $\rho_1$ and $\bar\rho_1$ (red), at the same distance $D$ (dashed circle), so their contributions to [-$A_k(\sigma)$-]{+$A_k(c)$+} may cancel. The point $z = [-\sigma + i\tau$-]{+c+iy$+} is closer to $\rho_1$ (blue circle, radius $d$) than [-$\sigma$-]{+$c$+} is to any pole, and $\rho_1$ is the only pole at distance $d$ from $z$. The picture is not to scale: in the application to the \hyperref[8JP5]{interval criterion}, [-$\sigma-]{+$c+} \ge 200$, and all poles lie in $0 < \Re s < 1$.
\includegraphics[width=0.7, alt=Case a: the line Re s = [-sigma,-]{+c,+} the strip Re s greater than theta shaded, a blue circle around z touching the pole rho_1, and a dashed circle around [-sigma-]{+c+} through rho_1 and its conjugate]{/static/figures/interval-criterion-a.svg}
~~~

## 8JT9 statement

Section 104, ID 140, revision 1 → 2.

~~~text
@@ -1,2 +1,2 @@
This picture shows an illustrative configuration for case (b) in the proof of the \hyperref[8JT5]{lower bound for the Taylor coefficients}. Here $D$ is the distance from [-$\sigma$-]{+$c$+} to the nearest pole (dashed circle), and every pole lies in $\Re s \le [-\sigma-]{+c+} - D$, left of the dotted line. The nearest pole is then the real pole $\beta = [-\sigma-]{+c+} - D$ (red), whose residue is positive. The picture is not to scale: in the application to the \hyperref[8JP5]{interval criterion}, [-$\sigma-]{+$c+} \ge 200$, and all poles lie in $0 < \Re s < 1$.
\includegraphics[width=0.7, alt=Case b: the dashed circle around [-sigma-]{+c+} touches the real pole beta, and all poles lie left of the dotted line Re s = [-sigma-]{+c+} minus D]{/static/figures/interval-criterion-b.svg}
~~~

## 8JP5 proof

Section 104, ID 102, revision 10 → 11.

~~~text
@@ -1,2 +1,2 @@
\emph{Idea.} The numbers $A_k(z) = \frac{(-1)^k}{k!}\mathcal H_\psi^{(k)}(z)$ are the Taylor coefficients of $w \mapsto \mathcal H_\psi(z - w)$. If $z$ has a unique nearest pole, at distance $d$, they grow like $d^{-k}$. Two parallel lemmas compare this growth on the line $\Re [-z = \sigma$-]{+z=c$+} with [-$(\sigma - \theta)^{-k}$:-]{+$(c-\theta)^{-k}$:+}
\begin{itemize}
@@ -5,6 +5,6 @@
\end{itemize}
Both lemmas bound the same quantity [-$|A_k(\sigma + i\tau)|-]{+$|A_k(c+iy)|+} + \Re [-A_k(\sigma)$,-]{+A_k(c)$,+} one from above and one from below. The upper bound works for this combination because it is at most $2\int_0^\infty g_+ K_k$, with $g(u) = \mathcal G_\psi(e^u)$, which involves only the positive part of $\mathcal G_\psi$: the hypothesis bounds $\mathcal G_\psi$ only from above.

\emph{The contradiction.} Suppose that some $\rho \in Z$ has $\Re\rho > \theta$. The hypothesis of the proposition is that of \ref{8JT2}; let [-$\sigma_0$-]{+$c_0$+} be as there, fix a real [-$\sigma-]{+$c+} \ge [-\sigma_0$,-]{+c_0$,+} and let $C$ and $K$ be as there. Since [-$\sigma-]{+$c+} > 1$, \ref{8JT5} gives [-$\tau$, $c$,-]{+$y$, $C_1$,+} $d < [-\sigma - \theta$-]{+c-\theta$+} and $k_0$. For every $k \in K$ with $k \ge k_0$,
\[ [-c\,-]{+C_1\,+} d^{-k} \le [-|A_k(\sigma + i\tau)|-]{+|A_k(c+iy)|+} + \Re [-A_k(\sigma)-]{+A_k(c)+} \le C\, [-(\sigma - \theta)^{-k},-]{+(c-\theta)^{-k},+} \]
so [-$\bigl((\sigma - \theta)/d\bigr)^{k}-]{+$\bigl((c-\theta)/d\bigr)^{k}+} \le [-C/c$.-]{+C/C_1$.+} Since $K$ is infinite and [-$(\sigma - \theta)/d-]{+$(c-\theta)/d+} > 1$, this fails for large $k \in K$. Hence $\Re\rho \le \theta$ for every $\rho \in Z$.
~~~

## 8JTA statement

Section 110, ID 141, revision 8 → 9.

~~~text
@@ -21,3 +21,3 @@ A_k(z) = \frac{\ln 2\pi}{z^{k+1}} &- \sum_\rho \frac{1}{\rho(\rho-1)(z - \rho)^{
\end{align*}
Each pole $p$ of $H_{\mathbf 1}$, with residue [-$c$,-]{+$\operatorname{Res}_p$,+} contributes [-$c/(z-]{+$\operatorname{Res}_p/(z+} - p)^{k+1}$, so for large $k$ the poles nearest to $z$ dominate. The \hyperref[8JUP]{one-sided bound} uses the integral for $A_k$, and the \hyperref[8JUM]{lower bound} uses this series directly.

@@ -36,6 +36,6 @@ Panel (b) shows $(G_{\mathbf 1}(x) - \ln 2\pi)/\sqrt x$ for $10 \le x \le 10^7$,
\includegraphics[width=1, alt=The normalized smoothed sum oscillating with size about 0.01 to 0.02, the first zero pair giving a pure wave and the first ten zero pairs following the data closely]{/static/figures/zeta-oscillation.svg}
Panel (c) shows $|A_k(\frac32 + [-i\tau)|$-]{+iy)|$+} for $k = 0, 1, 2, 3$ and $0 \le [-\tau-]{+y+} \le 50$, on a logarithmic scale; the dotted lines mark the heights $\gamma$ of the zeros $\frac12 + i\gamma$. Here [-$\sigma-]{+$c+} - \frac12 = 1$, so at [-$\tau-]{+$y+} = \gamma$ the zero $\rho = \frac12 + i\gamma$ contributes a term of size $1/|\rho|^2$ for every $k$, while the terms of the farther poles shrink as $k$ grows. For $k = 0$ and $1$ the pole at $s = 0$, with its comparatively large residue $\ln 2\pi \approx 1.84$, still dominates, and the zeros only make small dents. From $k = 2$ on, peaks of height about $1/|\rho|^2$ appear at the zeros. A zero $\beta + i\gamma$ with $\beta > \frac12$ would instead give peaks growing like $(\frac32 - \beta)^{-k}$, which is what the \hyperref[8JT5]{lower bound} detects.
\begin{center}
\textbf{(c)} $|A_k(\frac32 + [-i\tau)|$-]{+iy)|$+} for $k = 0, 1, 2, 3$ and $0 \le [-\tau-]{+y+} \le 50$; dotted lines at the zero heights $\gamma$
\end{center}
\includegraphics[width=1, alt=The absolute values of A_0 to A_3 on the line Re s = 3/2 for [-tau-]{+y+} from 0 to 50 on a logarithmic scale, with peaks at the heights of the zeros of zeta appearing from k = 2 on]{/static/figures/zeta-taylor-coefficients.svg}
~~~

## 8JUM statement

Section 110, ID 145, revision 2 → 3.

~~~text
@@ -1,4 +1,4 @@
Let $0<\theta<1$, and suppose a nontrivial zero $\rho_0$ of $\zeta$ satisfies $\Re\rho_0>\theta$. Let $A_k$ be the Taylor coefficients of $H_{\mathbf 1}$ in the \hyperref[8JTA]{zeta example}. For every real [-$\sigma>1$-]{+$c>1$+} there are a real [-$\tau$,-]{+$y$,+} a constant [-$c>0$,-]{+$C_1>0$,+} a real $d$ with [-$0<d<\sigma-\theta$,-]{+$0<d<c-\theta$,+} and a nonnegative integer $k_0$ such that for every integer $k\ge k_0$,
$$
[-|A_k(\sigma+i\tau)|+\Re A_k(\sigma)\ge c\,d^{-k}.-]{+|A_k(c+iy)|+\Re A_k(c)\ge C_1\,d^{-k}.+}
$$
~~~

## 8JUM proof

Section 110, ID 125, revision 2 → 3.

~~~text
@@ -1,2 +1,2 @@
\emph{Idea.} Choose [-$z=\sigma+i\tau$-]{+$z=c+iy$+} whose nearest pole is closer to $z$ than any pole is to [-$\sigma$.-]{+$c$.+} The corresponding term of the explicit series dominates both the rest of $A_k(z)$ and the whole of [-$A_k(\sigma)$.-]{+$A_k(c)$.+}

@@ -4,12 +4,12 @@
$$
A_k(z)=\sum_{p\in [-P}\frac{c_p}{(z-p)^{k+1}},-]{+P}\frac{\operatorname{Res}_p}{(z-p)^{k+1}},+}
$$
where [-$c_p$-]{+$\operatorname{Res}_p$+} is the residue of $H_{\mathbf 1}$ at $p$. In particular [-$c_0=\ln-]{+$\operatorname{Res}_0=\ln+} 2\pi$, [-$c_{-2n}=-1/(2n(2n+1))$,-]{+$\operatorname{Res}_{-2n}=-1/(2n(2n+1))$,+} and [-$c_\rho=-m(\rho)/(\rho(\rho-1))$-]{+$\operatorname{Res}_\rho=-m(\rho)/(\rho(\rho-1))$+} for a nontrivial zero of multiplicity $m(\rho)$. Thus $B=\sum_{p\in [-P}|c_p|<\infty$-]{+P}|\operatorname{Res}_p|<\infty$+} by absolute convergence of the \hyperref[8JUK]{explicit formula} at $x=1$.

\emph{(2)} \textbf{A point on $\Re [-z=\sigma$-]{+z=c$+} can get closer to a single pole than [-$\sigma$-]{+$c$+} is to any pole.} Fix [-$\sigma>1$-]{+$c>1$+} and let $D=\min_{p\in [-P}|\sigma-p|$.-]{+P}|c-p|$.+} This minimum exists by local finiteness. Put [-$a_0=\sigma-\Re\rho_0<\sigma-\theta$.-]{+$a_0=c-\Re\rho_0<c-\theta$.+} If $a_0<D$, take $p=\rho_0$. If $D\le a_0$, take a pole $p$ at distance $D$ from [-$\sigma$.-]{+$c$.+} Since [-$D<\sigma$,-]{+$D<c$,+} this $p$ cannot be a nonpositive real pole. It is a nontrivial zero and hence \hyperref[8JUH]{nonreal}, so [-$\sigma-\Re p<|\sigma-p|=D$.-]{+$c-\Re p<|c-p|=D$.+} In both cases,
$$
[-\sigma-\Re p<\min(D,\sigma-\theta).-]{+c-\Re p<\min(D,c-\theta).+}
$$

For [-$\tau$-]{+$y$+} in a sufficiently small closed interval of positive length around $\operatorname{Im}p$, we still have [-$|\sigma+i\tau-p|<\min(D,\sigma-\theta)$.-]{+$|c+iy-p|<\min(D,c-\theta)$.+} Only finitely many poles can be this close to the resulting compact segment. Two poles with different imaginary parts tie in distance for at most one [-$\tau$,-]{+$y$,+} since the difference of their squared distances is affine with nonzero slope. Two poles with the same imaginary part have different horizontal distances because both lie to the left of the line. Choose [-$\tau$-]{+$y$+} in the interval away from the finitely many ties. Then [-$z=\sigma+i\tau$-]{+$z=c+iy$+} has a unique nearest pole $p_*$, at distance [-$d<\min(D,\sigma-\theta)$.-]{+$d<\min(D,c-\theta)$.+}

@@ -19,3 +19,3 @@ $$
r=\min_{p\in P\setminus\{p_*\}}|z-p|,
\qquad D_1=\min_{p\in [-P\setminus\{0\}}|\sigma-p|.-]{+P\setminus\{0\}}|c-p|.+}
$$
@@ -26,4 +26,4 @@ The nearest pole to $z$ is unique, so $r>d$. Also $D_1\ge D>d$.
$$
[-\left|\frac{c_{p_*}}{(z-p_*)^{k+1}}\right|-]{+\left|\frac{\operatorname{Res}_{p_*}}{(z-p_*)^{k+1}}\right|+}
= [-|c_{p_*}|\,d^{-k-1}.-]{+|\operatorname{Res}_{p_*}|\,d^{-k-1}.+}
$$
@@ -32,13 +32,13 @@ $$
\begin{align*}
\left|\sum_{p\ne [-p_*}\frac{c_p}{(z-p)^{k+1}}\right|-]{+p_*}\frac{\operatorname{Res}_p}{(z-p)^{k+1}}\right|+}
&\le \sum_{p\ne [-p_*}\frac{|c_p|}{|z-p|^{k+1}}\\-]{+p_*}\frac{|\operatorname{Res}_p|}{|z-p|^{k+1}}\\+}
&\le [-(B-|c_{p_*}|)\,r^{-k-1}.-]{+(B-|\operatorname{Res}_{p_*}|)\,r^{-k-1}.+}
\end{align*}

\item[(c)] \textbf{The real-axis contribution.} The pole at $0$ contributes [-$c_0\sigma^{-k-1}>0$.-]{+$\operatorname{Res}_0 c^{-k-1}>0$.+} For every other pole, use $\Re w\ge -|w|$ and [-$|\sigma-p|\ge-]{+$|c-p|\ge+} D_1$:
\begin{align*}
\Re [-A_k(\sigma)-]{+A_k(c)+}
&\ge [-c_0\sigma^{-k-1}-]{+\operatorname{Res}_0 c^{-k-1}+}
 -\sum_{p\ne [-0}\frac{|c_p|}{|\sigma-p|^{k+1}}\\-]{+0}\frac{|\operatorname{Res}_p|}{|c-p|^{k+1}}\\+}
&\ge [-c_0\sigma^{-k-1}-(B-c_0)\,D_1^{-k-1}.-]{+\operatorname{Res}_0 c^{-k-1}-(B-\operatorname{Res}_0)\,D_1^{-k-1}.+}
\end{align*}
@@ -48,5 +48,5 @@ Relative to the term in (a), the two possible losses are bounded by
$$
[-\frac{B-|c_{p_*}|}{|c_{p_*}|}\left(\frac{d}{r}\right)^{k+1},-]{+\frac{B-|\operatorname{Res}_{p_*}|}{|\operatorname{Res}_{p_*}|}\left(\frac{d}{r}\right)^{k+1},+}
\qquad
[-\frac{B-c_0}{|c_{p_*}|}\left(\frac{d}{D_1}\right)^{k+1}.-]{+\frac{B-\operatorname{Res}_0}{|\operatorname{Res}_{p_*}|}\left(\frac{d}{D_1}\right)^{k+1}.+}
$$
@@ -54,6 +54,6 @@ Both ratios tend to zero. Choose a nonnegative integer $k_0$ so that each is at
\begin{align*}
|A_k(z)|+\Re [-A_k(\sigma)-]{+A_k(c)+}
&\ge [-|c_{p_*}|\,d^{-k-1}-(B-|c_{p_*}|)\,r^{-k-1}\\-]{+|\operatorname{Res}_{p_*}|\,d^{-k-1}-(B-|\operatorname{Res}_{p_*}|)\,r^{-k-1}\\+}
&\quad [-+c_0\sigma^{-k-1}-(B-c_0)\,D_1^{-k-1}\\-]{++\operatorname{Res}_0 c^{-k-1}-(B-\operatorname{Res}_0)\,D_1^{-k-1}\\+}
&\ge [-\frac{|c_{p_*}|}{2d}\,d^{-k}+c_0\sigma^{-k-1}.-]{+\frac{|\operatorname{Res}_{p_*}|}{2d}\,d^{-k}+\operatorname{Res}_0 c^{-k-1}.+}
\end{align*}
~~~

## 8JUP statement

Section 110, ID 146, revision 1 → 2.

~~~text
@@ -5,5 +5,5 @@ G_{\mathbf 1}(x)\le x^\theta
$$
Let $A_k$ be the Taylor coefficients of $H_{\mathbf 1}$ in the \hyperref[8JTA]{zeta example}. There is a real [-$\sigma_0>2$-]{+$c_0>2$+} such that for every real [-$\sigma\ge\sigma_0$-]{+$c\ge c_0$+} there are a constant $C>0$ and an infinite set $K$ of positive integers with the following property. For every $k\in K$ and every real [-$\tau$,-]{+$y$,+}
$$
[-|A_k(\sigma+i\tau)|+\Re A_k(\sigma)\le C(\sigma-\theta)^{-k}.-]{+|A_k(c+iy)|+\Re A_k(c)\le C(c-\theta)^{-k}.+}
$$
~~~

## 8JUP proof

Section 110, ID 126, revision 1 → 2.

~~~text
@@ -2,12 +2,12 @@ The \hyperref[8JTA]{explicit formula} gives $|G_{\mathbf 1}(x)|\le Bx$ for some

Put $g(u)=G_{\mathbf 1}(e^u)$ and $g_+(u)=\max(g(u),0)$. Let [-$\sigma_0$-]{+$c_0$+} be the threshold in the \hyperref[8JT4]{kernel concentration estimate}, and fix [-$\sigma\ge\sigma_0$.-]{+$c\ge c_0$.+} For each $Y>1$ in the hypothesis put $U=\ln Y$ and choose
$$
W=[U,\tfrac32 U],\qquad [-k=\bigl\lceil\tfrac54\sigma-]{+k=\bigl\lceil\tfrac54c+} U\bigr\rceil,
\qquad K_k(u)=\frac{u^k [-e^{-\sigma u}}{k!}.-]{+e^{-cu}}{k!}.+}
$$
This puts the peak of $K_k$ at the midpoint of $W$, up to rounding. By the \hyperref[8JT3]{Laplace integral for the Taylor coefficients},
[-$A_k(\sigma+i\tau)=\int_0^\infty g(u)K_k(u)e^{-i\tau u}\,du$.-]{+$A_k(c+iy)=\int_0^\infty g(u)K_k(u)e^{-iyu}\,du$.+}
Since $g$ is real, the following holds for every real [-$\tau$:-]{+$y$:+}
\begin{align*}
[-|A_k(\sigma+i\tau)|+\Re A_k(\sigma)-]{+|A_k(c+iy)|+\Re A_k(c)+}
&\le 2\int_0^\infty g_+(u) K_k(u)\,du \\
@@ -15,4 +15,4 @@ Since $g$ is real, the following holds for every real $\tau$:
  +2B\int_{[0,\infty)\setminus W} e^{2u}K_k(u)\,du \\
&\le [-2(\sigma-\theta)^{-k-1}+4B\sigma^{-k}-]{+2(c-\theta)^{-k-1}+4Bc^{-k}+} \\
&\le [-(2+4B)(\sigma-\theta)^{-k}.-]{+(2+4B)(c-\theta)^{-k}.+}
\end{align*}
~~~

## 8JUQ proof

Section 110, ID 127, revision 1 → 2.

~~~text
@@ -1,6 +1,6 @@
Suppose a nontrivial zero has real part greater than $\theta$. Fix a real [-$\sigma\ge\sigma_0$-]{+$c\ge c_0$+} as in the \hyperref[8JUP]{one-sided bound}, with constant $C$ and infinite set $K$. The \hyperref[8JUM]{lower bound} gives [-$\tau$, $c>0$, $0<d<\sigma-\theta$,-]{+$y$, $C_1>0$, $0<d<c-\theta$,+} and $k_0$. For each $k\in K$ with $k\ge k_0$,
$$
[-c\,d^{-k}\le |A_k(\sigma+i\tau)|+\Re A_k(\sigma)-]{+C_1\,d^{-k}\le |A_k(c+iy)|+\Re A_k(c)+}
\le [-C(\sigma-\theta)^{-k}.-]{+C(c-\theta)^{-k}.+}
$$
This would bound [-$\bigl((\sigma-\theta)/d\bigr)^k$-]{+$\bigl((c-\theta)/d\bigr)^k$+} by [-$C/c$-]{+$C/C_1$+} on an unbounded set of $k$, even though [-$(\sigma-\theta)/d>1$.-]{+$(c-\theta)/d>1$.+}
~~~
