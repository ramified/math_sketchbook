# 第 2 章若干修正：8JK2 的正式证明、定义 $e_D,e_L$、8JUF 的估计链、$\Sigma(x)$ 的定义

## 背景

书的真内容在 D1 数据库 `grh-notes`。本地库 `.wrangler/state/v3/d1/miniflare-D1DatabaseObject/feb98e23e8d07ed53c02acad60b7af51cee41722a632c769f200a9b7c2d3ca7f.sqlite`
是远程的完整副本。用户读第 2 章时提了 4 个问题（原话见末尾）。第 2 章是对 \cite{Outline}（`docs/references/GRH-natural-language-outline.pdf`）的证明概要。

**同时有另一个脚本** `scripts/motivate-smoothed-prime-sum-2026-11-25.sql` 在改 §1.2：它占用 result id 148–152、proof id 128–130、
tag `8JUR`–`8JUV`，改 section 102、results 106–109/116、proof 106。**本任务不能碰这些行和编号**，两个脚本要能以任意顺序各自应用。

## 产出

- `scripts/ch2-formal-fixes-2026-11-25.sql`
- 检查脚本 `implement_plan/tasks/2026-11-25-ch2-formal-fixes.check.mjs`（可以照抄 `implement_plan/tasks/2026-11-25-motivate-smoothed-prime-sum.check.mjs`
  的结构改参数；它要在本地库副本上：应用 SQL、二次应用必须失败、对所有改动/新增的 intro/statement/proof 跑 `renderTex` 要 0 warning、
  refs 集合一致且目标都在 tags 里、revisions 与行一致、打印受影响 section 的顺序表、写预览 HTML、最后打印 `ALL CHECKS PASSED`）。
  另外要验证：先应用 §1.2 的脚本再应用本脚本，也全部通过。
- 报告 `implement_plan/tasks/2026-11-25-ch2-formal-fixes.md.report.md`：检查输出、所有新/改 TeX 原文（未转义）、偏离规格之处、
  以及你从 Outline 里查到的 $e_D,e_L$ 的含义（给出 Outline 页码/节号）。

## 约束

- 绝不运行 `--remote`；不改 `.wrangler/state` 里的真实文件（只用临时副本）；不 commit；只用 `node:sqlite` 应用 SQL。
- 新编号：result id 从 153 起，proof id 从 131 起，tag 从 `8JUW` 起（`8JUW`, `8JUX`, `8JUY`, `8JUZ`, …，用前确认不在 `tags` 表里）。
- 时间戳 `2026-11-25 17:30:00`，operation_id `ch2-formal-fixes-2026-11-25`，author/created_by/updated_by `'codex'`，
  新 proof `status 'ai_generated'`, `generated_by 'gpt'`, `generator_detail 'Codex'`。
- DB 模式照 `scripts/motivate-smoothed-prime-sum-2026-11-25.sql`：write_guard（检查你读过的每行的 revision 和要挪的 position）、
  baseline revision 用 `INSERT OR IGNORE`、新 revision、`*_html_cache = NULL`、refs 重建、新结果插 tags/aliases、snapshot 用
  `JSON.stringify` 生成。
- TeX：`\ln`，不用 `\tag`，估计链用 `alignat*{2}`，标签 (a)(b)… 放右列 `&&\quad\text{(a)}`；每个公式在约 680px 宽的栏里放得下
  （行太长就拆行或把理由挪到链下面的列表）。

### House style（必须遵守）

1. 定义/陈述里不放推理（since/because/by Lemma/括号理由/动机评论）。
2. 一个结果一个论断；证明短，只写关键步骤；不写琐碎记账。
3. 量词显式、放在公式前：例如 "there is $\varepsilon_0>0$ such that for every $0<\varepsilon<\varepsilon_0$ and every real $Y_0\ge1$ there is a real $Y\ge Y_0$ such that for every real $x\in[Y,Y^{3/2}]$, …"。
4. 先定义再使用；每个符号第一次出现时说明它是什么。
5. 估计 = 先定义所有对象，再**一条**链；链后用 "(a) …, (b) …" 每行一句理由。

## 任务

### 1. Theorem 1.3.1（`8JK2`, result id 110）加正式证明

8JK2 现在没有 proof 行。把 8JUF 证明（proof id 119）最后一段：

> To obtain \ref{8JK2}, increase the prescribed lower endpoint $Y_0$ before choosing the interval so that $x^{(7-45/8)\varepsilon}\ge C_{\psi,\varepsilon}$ throughout it. Then $e_D=2$ and $e_L=0$ give $\mathcal G_\psi(x)\le x^{1/2+9\varepsilon}$ for every real $x$ in the interval.

从 8JUF 的证明里**删掉**，改写成 8JK2 的正式证明（新 proof id 131，position 1）。要求：
- 量词顺序清楚：给定 $\psi$；取 \ref{8JU7} 的 $\varepsilon_0$；给定 $0<\varepsilon<\varepsilon_0$ 和 $Y_0\ge1$；取 \ref{8JUF} 的常数 $C_{\psi,\varepsilon}$
  （确认它不依赖区间；如果 8JUF 的陈述没说清楚，在 8JUF 陈述里把量词写清楚）；令 $Y_0'=\max\bigl(Y_0, C_{\psi,\varepsilon}^{8/(11\varepsilon)}\bigr)$；
  对 $Y_0'$ 用 \ref{8JU7} 得到 $Y\ge Y_0'$；则对 $x\in[Y,Y^{3/2}]$，$x^{11\varepsilon/8}\ge C_{\psi,\varepsilon}$。
- 关键一条链（$e_D=2$, $e_L=0$ 来自 \ref{8JU7}，$2+0+45/8+11/8=9$）：
  \[ \mathcal G_\psi(x) \le C_{\psi,\varepsilon}\,x^{1/2+(e_D+e_L+45/8)\varepsilon} = C_{\psi,\varepsilon}\,x^{1/2+61\varepsilon/8} \le x^{1/2+9\varepsilon}. \]
- 短。可以有一句 *Idea*。

### 2. 定义 $e_D$, $e_L$

Proposition 2.2.2（`8JUA`）用了 $x^{(e_D+e_L+3)\varepsilon}$，但 $e_D,e_L$ 从没定义；8JU7 只说 "can be chosen together with exponents $e_D=2$ and $e_L=0$"，
8JU7 证明 (3) 说 "the exponents $e_D,e_L$"。去 Outline 里查清楚它们是什么（它们控制的量、出现的不等式）。然后：
- 在 8JUA 之前、第一次用到的地方给出正式定义。首选：在 §2.1（section 106）里 8JU7 之前新增一个 Definition（listed），用符号写出
  $e_D$、$e_L$ 是哪些不等式里的指数（例如 "… $\le x^{e_D\varepsilon}$ …" 这种形式，具体以 Outline 为准）；8JU7 的陈述改成
  "with $e_D = 2$ and $e_L = 0$ in the sense of \hyperref[NEW]{…}"，8JUA 的陈述在用到处链到这个定义。
  如果 Outline 里它们的定义依赖 8JU7 构造出来的对象、放在 8JU7 前面不通，就放在 8JU7 和 8JUA 之间合适的位置，并在报告里说明。
- 只写 Outline 里真有的内容，不要编。查不到就停下，在报告里写清楚查到了什么、缺什么，不要硬写。

### 3. 8JUF 证明里的估计链改成逐步的多行链

用户原话："for this aligned formula I think you can make multiple lines. Usually I would repeat the definition in the first line, and then make step-by-step estimations which is usually slower than what you have done."

现在的链只有 (a)(b) 两行。改成：第一行从 \ref{8JUD} 的平均不等式（用 $\Sigma(x)$ 写出的那一行）解出 $\mathcal G_\psi(x)$ 的上界开始，
然后每行只用一个事实往下估：$\Sigma(x)\le4o\,x^{1/2+\varepsilon}$；$E_{\rm err}\le x^{(e_D+e_L+3)\varepsilon}\mathcal B$（\ref{8JUA}）；
$\mathcal B/Q\le10x^{1/2+13\varepsilon/8}$ 和 $\delta_2^{-1}\le x^\varepsilon$（\ref{8JUG}）；$4/(x\delta_2)\le 4x^{\varepsilon-1}$；最后合并成
$C_{\psi,\varepsilon}x^{1/2+(e_D+e_L+45/8)\varepsilon}$。每行右列一个标签，链下一行一句理由。如果合并后的常数可以写成具体的式子
（例如由 $20$、$4$、$4o$ 组成），就写出来，并在 8JUF 陈述里保留"存在常数"的形式或改成具体常数（二选一，报告里说明）。
注意检查每一步的指数和系数真的对（$x\ge1$ 时 $x^{\varepsilon-1}\le x^{1/2+\dots}$ 之类的放大要正确）。
链前面那段（四项 $\mathcal B/Q$ 的分析、为什么链长接近 $\sqrt x$）保留，可以精简。第 1 项删掉的最后一段不再出现。

### 4. $\Sigma(x)$ 的正式定义

现在 `8JUD`（Lemma 2.3.1，result id 132）的陈述里用一句话描述 $\Sigma(x)$。改成：在 §2.3（section 108）8JUD 之前新增一个 Definition
（listed），用符号写出 $\Sigma(x)$：写清楚求和的特征集合（$B$ 的哪些特征，在 $A_0$ 上平凡、不属于保留族的那些，即带有 $q$ 或 $d$ 的
二次因子的那些，按 $B$ 的特征计重数），每个 $G$ 在本原代表处取值。记号要和 `8JU3`、`8JU4` 的 intro 以及 `8JU9`、`8JUD` 一致
（$B=(\Z/2\Z)^2\times A$、$\Phi$、$A_0$、$\xi^*$ 表示本原代表等）；需要时查 Outline 第 11、13 节。然后 8JUD 的陈述改成引用这个定义
（\hyperref），去掉那句文字描述。8JUD 的证明如有提到 $\Sigma$ 的描述，相应精简。

## 验收

```
node implement_plan/tasks/2026-11-25-ch2-formal-fixes.check.mjs scripts/ch2-formal-fixes-2026-11-25.sql
npm test
```
检查脚本还要有一种模式（例如第二个参数传 §1.2 的 SQL）：先应用 `scripts/motivate-smoothed-prime-sum-2026-11-25.sql` 再应用本脚本，也要 `ALL CHECKS PASSED`。

## 用户原话（供参考）

1. "To obtain \ref{8JK2}, increase the prescribed lower endpoint … This should be written as a formal proof in Theorem 1.3.1."
2. "For Proposition 2.2.2 (A bound for each translate) those e_D and e_L are not even defined (perhaps I'm wrong?) you should define them, otherwise I don't understand what is happening."
3. （8JUF 证明里的 alignat 链）"for this aligned formula I think you can make multiple lines. Usually I would repeat the definition in the first line, and then make step-by-step estimations which is usually slower then what you have done."
4. "For Proposition 2.4.1 (8JUF), I think you should define $\Sigma(x)$ formally by a definition environment, where the $\Sigma(x)$ is formally written as symbols."

## 返工（第 2 轮）

第 1 轮因为 Outline 里查不到 $e_D,e_L$ 控制的是什么而停下（主会话已核实：Outline 只在 §10 p.10 给出 $e_D=2$, $e_L=0$，
§12 (12.2) 用 $C=e_D+e_L+3$，附录 A p.23 指向 Lean 源码 TopShape 第 52 行，本机没有该源码）。

**本轮：任务 2（定义 $e_D,e_L$）暂缓，不做，也不要改 8JU7/8JUA 里关于 $e_D,e_L$ 的文字。只做任务 1、3、4。**
任务 1 和 3 里照常使用 $e_D=2$, $e_L=0$（来自 \ref{8JU7}）和 $x^{(e_D+e_L+3)\varepsilon}$（来自 \ref{8JUA}）。
新编号仍从 result 153、proof 131、tag `8JUW` 起。

检查脚本额外要求：
- 第二个参数可指定源库路径（默认是真实本地库）。注意真实本地库**已经应用了** §1.2 脚本。
- 要跑通三种情况：
  1. 源库 = 真实本地库（已含 §1.2），只应用本脚本；
  2. 源库 = 备份 `C:\Users\bbh8149\AppData\Local\Temp\claude\528e839e331274c3\e7354ef4-4224-41d8-9a62-2c0941234960\scratchpad\local-before-motivate.sqlite`（不含 §1.2），只应用本脚本；
  3. 源库 = 同一备份，先应用 `scripts/motivate-smoothed-prime-sum-2026-11-25.sql` 再应用本脚本。
- SQL 脚本里**不要**写 `BEGIN`/`COMMIT`（远程 D1 不接受显式事务；write_guard 必须放在所有修改语句之前）。

## 第 3 轮：定义 $e_D$, $e_L$（新脚本 `scripts/ch2-error-exponents-2026-11-25.sql`）

第 1、2 轮的脚本已经应用到本地库**和远程库**。本轮写一个新脚本，基准是**当前真实本地库**（已含 §1.2 和第 2 轮）。
检查脚本另写 `implement_plan/tasks/2026-11-25-ch2-error-exponents.check.mjs`（照第 2 轮的改；源库默认真实本地库，只需这一种情况），
报告写 `implement_plan/tasks/2026-11-25-ch2-error-exponents.md.report.md`。新编号：result 154、tag `8JV2`（用前确认未被占用；
若占用就取下一个空闲 tag），时间戳 `2026-11-25 18:30:00`，operation_id `ch2-error-exponents-2026-11-25`。

### 来源（主会话已核实）

- `docs/references/main.pdf`（J. Adriazola, *The Alpöge Proof of the Riemann Hypothesis*）**Definition 18.9, p. 275**（chain record）：
  - (K1) $S-\Gamma\le C\,N_T\,m\,b\,x^{e_L\varepsilon}$ 且 $0\le I\le C\,N_T\,m\,b\,x^{e_L\varepsilon}$；同页："$\Gamma$ is the total gain of the $m$ lifts at the inert primes"，$I$ 是 "index loss at the inert primes"。
  - (K4) 右边误差项 $\dots + C\,N_T\,a\,\Lambda_a + C\,m\,(B_0+N_c)\,x^{e_D\varepsilon}$。
- **Hypothesis 18.10, p. 276**："There are absolute constants $e_D, e_L\ge0$ …"；"One can take $e_D = 2$ and $e_L = 0$"；Proposition 18.11 先得到 $e_D=1$，再用 $x^\varepsilon\le x^{2\varepsilon}$ 放宽成 $2$。
- 书里 \ref{8JUA} 的 $\mathcal B = h a_E(1+m^2/k) + m(B_0+N_c)$，其中 $B_0 = 2nmb x^\varepsilon$、$N_c = h_2 k b x^{2\varepsilon}/n^2$（$N_T$ 对应书里的 $h=|T|$）。
  **请你自己读 main.pdf 第 17–18 章（尤其 pp. 270–281）核对 (K1)、(K4) 的确切形式、$S$ 的含义以及 $B_0$、$N_c$ 与书中记号的对应**；
  `zeta-paper_v2.pdf` §III.11 pp. 199–211、221（$C_{\rm abs}=e_D$，(H1)、(H7)、Lemma M8 的 $+3$）可作交叉核对。

### 要做的

1. **新 Definition「The error exponents $e_D$ and $e_L$」**（listed），放在 §2.1（section 106）里 8JU7 之前（8JU7、8JU8 的 position 顺延）。
   内容要短、读者能看懂，**只引入书里必须的符号**：
   - 一句话说明背景对象（chain of $m$ theta lifts at scale $x$，translates $t\in T$，$h=|T|$，$b$，$B_0$，$N_c$ 用书里已有/上面的式子写出）。
   - 用符号写出两条界：$e_L$：惰性素数处的计数与整除收益之差、以及指标损失，均 $\le C\,h\,m\,b\,x^{e_L\varepsilon}$；
     $e_D$：配对（slope/height）比较里的局部算术误差 $\le C\,m(B_0+N_c)\,x^{e_D\varepsilon}$。$S,\Gamma,I$ 等如果书里没定义，用一句话
     说清是什么量（照 main.pdf 原文），不要引入书里用不到的一大堆符号（不要 $D_{\rm div}$、$\mu_C$、$F_0$、$T_w$、$h_w$ 那一套）。
   - 量词显式："$e_D,e_L\ge0$ are exponents such that there is a constant $C$, independent of $x$, with …"。
   - 定义里不放推理；出处用 `\cite[Definition 18.9]{Adriazola}`。
2. **书目**：在 `settings` 表 key `bibliography`（当前 revision 7）末尾加
   `\bibitem{Adriazola} J. Adriazola, \emph{The Alpöge Proof of the Riemann Hypothesis}, Arizona State University, 2026.`
   （revision +1，并插一条 `revisions` 行，entity `setting`、entity_key `bibliography`，snapshot 格式照现有 setting 修订行；若没有 baseline 就 `INSERT OR IGNORE` 一条 revision 7 的 baseline）。write_guard 检查 revision = 7。
3. **8JU7**（result 126, rev 1）：把 "can be chosen together with exponents $e_D=2$ and $e_L=0$" 改成链接新定义，例如
   "… with \hyperref[8JV2]{error exponents} $e_D=2$ and $e_L=0$"。其余不动。8JU7 的证明 (3)（proof 112, rev 1）里
   "the exponents $e_D,e_L$" 也链到新定义，并加半句出处 `\cite[Hypothesis 18.10]{Adriazola}`。
4. **8JUA**（result 129, rev 1）：陈述里第一次出现 $e_D,e_L$ 的地方链到新定义（\hyperref[8JV2]{...}），其余不动。
5. 照旧：write_guard、baseline/新 revision、caches NULL、refs 重建、tags/aliases（alias `error-exponents`）。SQL 不写 BEGIN/COMMIT。
6. 报告附：检查输出、所有新/改 TeX 原文、你在 main.pdf 里核对到的 (K1)(K4) 原式（页码），以及偏离之处。
