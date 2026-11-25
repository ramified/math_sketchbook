# 给 §1.2「Smoothed prime sums」加动机：$-L'/L$、von Mangoldt、Chebyshev 函数及其 Mellin 变换

## 目标

书的真内容在 D1 数据库 `grh-notes` 里。§1.2（section id 102，tag `7HE6`）现在直接从 Definition 8JF7（Smoothed prime sum）开始，
没有任何动机，读者不知道 von Mangoldt 函数是什么、和 $L(s,\chi)$ 什么关系，也不知道为什么要做光滑化、为什么用 Mellin 变换。

要写一个 SQL 脚本 `scripts/motivate-smoothed-prime-sum-2026-11-25.sql`，它：

1. 给 §1.2 写 intro（现在是空串）：Euler 乘积 → $-L'/L$ 的 Dirichlet 级数 → von Mangoldt 函数 → 广义 Chebyshev 函数 $\Psi_\chi$
   → 它的 Mellin 变换 $=-\frac1s\frac{L'}{L}$ → 为什么光滑化（$R_\chi$，Mellin 变换多一个 $\frac1{s-1}$）→ 减去 $s=1$ 的主项得到 $G_\chi$。
2. 在 §1.2 开头新增 4 个编号结果 + 1 个隐藏引理（见下表）。
3. 改写 8JF7 的陈述：链接新定义，去掉定义里的推理/动机（house style）。
4. 在 8JS6 的证明（proof id 106）里加一个指向新引理的链接。

## 约束

- **只写 SQL 脚本和本任务的检查脚本、报告**。不改 `src/`、`public/`、`migrations/`、`seed/`，不加依赖，不 commit。
- **绝不运行任何 `--remote` 命令**，也不要改 `.wrangler/state` 里的本地库：只在本地库的**副本**上测试（见「验收」）。
- 只用 `node:sqlite` 应用 SQL（`wrangler d1 execute --local` 对长语句会 SQLITE_TOOBIG）。
- 数学按 house style 写（见下节），TeX 用书里已有的宏：`\ln`（不要 `\log`）、`\Re`、`\C`、`\Z`、`\le`/`\ge`、`\mathbf 1`。
  不用 `\tag`。多行或过长的行间公式用 `align*` 断行，保证每个公式在约 680px 宽的正文栏里放得下。
- 模板：`scripts/align-HG-2026-11-24.sql`（baseline revision 用 `INSERT OR IGNORE`）、`scripts/zeta-example-2026-11-25.sql`
  （新结果、tags、aliases、refs、挪 position）、`scripts/intro-8JU4-2026-11-24.sql`（section intro + section snapshot 格式）、
  `scripts/growth-lemma-move-2026-11-24.sql`（proof 更新 + refs 重建）。SQL 字符串里的 `'` 写成 `''`（所以 `L'` 写成 `L''`）。

### House style（必须遵守）

1. 定义和陈述里**不放任何推理**：没有 since / because / by Lemma / 括号里的理由 / 动机性评论。
   定义要成立所需的事实（如 $L(1,\chi)\ne0$）只简短陈述，并用 `\hyperref[TAG]{...}` 链到一个隐藏引理。
2. 一个结果一个论断（紧密相关的可以放一起，例如"等式成立且级数绝对收敛"）。
3. 证明短，只写关键一步和得到的式子。不写琐碎记账（不要"using $|\chi(n)|\le1$ and $0\le\Lambda(n)\le\ln n$"这种罗列，
   不要"which gives the claim"收尾句），不写连续性/可测性之类。
4. 量词写清楚："Let $\chi$ be a Dirichlet character. For every $s\in\C$ with $\Re s>1$, …"。
5. 动机和评论只放在 section intro 里。intro 可以有一行的推导（像 `8JU3` 的 intro 那样）。

## 新的 §1.2 结构（position 顺序）

| pos | tag | id | 类型 | listed | 标题 | 状态 |
|---|---|---|---|---|---|---|
| 1 | `8JUR` | 148 | definition | 1 | von Mangoldt function | 新 |
| 2 | `8JUS` | 149 | lemma | 1 | Logarithmic derivative of $L(s,\chi)$ | 新，proof id 128 |
| 3 | `8JUT` | 150 | definition | 1 | Generalized Chebyshev function | 新 |
| 4 | `8JUU` | 151 | lemma | 1 | Mellin transform of the Chebyshev function | 新，proof id 129 |
| 5 | `8JF7` | 106 | definition | 1 | Smoothed prime sum | 改陈述 |
| 6 | `8JS3` | 116 | lemma | 1 | （不变） | 只改 position（2→6） |
| 7 | `8JG8` | 107 | definition | 1 | （不变） | 只改 position（4→7） |
| 8 | `8JJ5` | 108 | example | 0 | （不变） | 只改 position（5→8） |
| 9 | `8JQ3` | 109 | example | 0 | （不变） | 只改 position（6→9） |
| 10 | `8JUV` | 152 | lemma | 0 | Non-vanishing of $L(1,\chi)$ | 新（隐藏），proof id 130 |

Aliases：`von-mangoldt-function`→8JUR，`log-derivative-l-function`→8JUS，`chebyshev-function`→8JUT，
`chebyshev-mellin-transform`→8JUU，`l-at-one-nonzero`→8JUV。

记号说明：书里 $\psi$ 已经表示特征（$\mathcal C_\psi$, $\mathcal G_\psi$, 8JG8 就在本节），所以广义 Chebyshev 函数记作
$\Psi_\chi(x)$，**不要**用 $\psi(x,\chi)$；intro 里说一句经典记号是 $\psi(x,\chi)$。

## 各部分内容

下面给出结构、要出现的公式和每句话的意思；措辞由你写，要短、准确、英文。公式我都核对过，**不要改公式的数学内容**。

### A. §1.2 intro（`sections.intro_tex`，id 102）

开头 1–2 句（不加粗标题）：$L(s,\chi)$ 的零点是其对数导数的极点，而 $L'/L$ 是一个素数幂上的 Dirichlet 级数。
本节把这个级数变成实变量 $x$ 的函数，即 \hyperref[8JF7]{smoothed prime sum} $G_\chi$；它的 \hyperref[8JS2]{Mellin transform}
把零点重新变成极点，这是 \ref{7HM3} 的出发点。

然后四段，每段以 `\textbf{...}` 开头（同 `8JU3`/`8JU4` 的 intro）：

**`\textbf{The von Mangoldt function.}`** 对 $\Re s>1$，\hyperref[8JC4]{Dirichlet $L$-function} 的 Euler 因子
$L_p(s,\chi)=(1-\chi(p)p^{-s})^{-1}$ 的对数导数是
\[ -\frac{L_p'}{L_p}(s,\chi) = \frac{\chi(p)\ln p\; p^{-s}}{1-\chi(p)p^{-s}} = \sum_{k\ge1}\chi(p^k)\,\ln p\; p^{-ks}. \]
意思：素数幂 $p^k$ 带权 $\ln p$，与 $k$ 无关。这个权就是 \hyperref[8JUR]{von Mangoldt function} $\Lambda$；对 $p$ 求和得
$-\frac{L'}{L}(s,\chi)=\sum_{n\ge1}\chi(n)\Lambda(n)n^{-s}$（\ref{8JUS}）。$L(s,\chi)$ 的 $m$ 阶零点是 $-L'/L$ 的单极点，留数 $-m$；
对主特征，$s=1$ 是留数为 $1$ 的单极点。所以零点的信息就在数 $\chi(n)\Lambda(n)$ 里。

**`\textbf{The Chebyshev function and its Mellin transform.}`** 把这些数加到 $x$ 得到
\hyperref[8JUT]{generalized Chebyshev function} $\Psi_\chi(x)=\sum_{n\le x}\chi(n)\Lambda(n)$（$\chi=\mathbf 1$ 时是 Chebyshev 的 $\psi(x)$；
经典记号 $\psi(x,\chi)$，这里不用，因为 $\psi$ 表示特征）。它的 \hyperref[8JS2]{Mellin transform} 是（\ref{8JUU}）
\[ \int_1^\infty \Psi_\chi(x)\,x^{-s-1}\,dx = -\frac1s\,\frac{L'}{L}(s,\chi) \qquad (\Re s>1). \]
意思：Mellin 变换把素数和变回 $L'/L$，$L(s,\chi)$ 的零点成为（延拓后的）变换的极点。\ref{7HM3} 就是这样探测零点的。

**`\textbf{Why smooth.}`** 三点，按顺序：
1. $\Psi_\chi$ 在素数幂处跳跃，所以它的 Mellin 变换在竖直线 $\Re s=c>1$ 上不可能绝对可积（否则 Mellin 反演会让 $\Psi_\chi$ 连续）。
2. 积分一次去掉跳跃：对 $x\ge1$，
   \[ R_\chi(x) = \sum_{n\ge1}\chi(n)\Lambda(n)\Bigl(\frac xn-1\Bigr)_+ = x\int_1^x \Psi_\chi(t)\,\frac{dt}{t^2}, \]
   因为 $n\le x$ 时 $\int_n^x t^{-2}\,dt=\frac1n-\frac1x$。交换积分次序，
   \begin{align*}
   \int_1^\infty R_\chi(x)\,x^{-s-1}\,dx &= \frac{1}{s-1}\int_1^\infty \Psi_\chi(t)\,t^{-s-1}\,dt \\
   &= -\frac{L'}{L}(s,\chi)\,\frac{1}{s(s-1)}.
   \end{align*}
3. 多出的因子 $1/(s-1)$ 让变换在竖直线上是 $O(|s|^{-2})$，Mellin 反演绝对收敛；把积分线左移时，$m$ 阶零点 $\rho$ 贡献
   $-m\,x^\rho/(\rho(\rho-1))$，这些项对 $\rho$ 可和（$\zeta$ 的显式公式见 \ref{8JTA}）。另外，权 $(x/n-1)_+$ 正是第 2 章的算术
   给出的权（\ref{8JU4}）。

**`\textbf{The main term.}`** $s=1$ 处的极点给出 $R_\chi$ 的主项 $M_\chi(x)$（\ref{8JS3} 的 main term），即
$-\frac{L'}{L}(s,\chi)\frac{x^s}{s(s-1)}$ 在 $s=1$ 的留数：
\[ M_{\mathbf 1}(x) = x\ln x-(1+\gamma)x, \qquad M_\chi(x) = -x\,\frac{L'}{L}(1,\chi) \quad (\chi\ne\mathbf 1), \]
前者用 $-\frac{\zeta'}{\zeta}(s)=\frac1{s-1}-\gamma+O(s-1)$。\hyperref[8JF7]{smoothed prime sum} 是 $G_\chi=R_\chi-M_\chi$；
它的 Mellin 变换在 $\Re s>0$ 内的极点恰好是 $L(s,\chi)$ 的零点（\ref{8JN4}），$s=1$ 不再是极点。

intro 总长控制在 8JU4 intro 的一半左右。

### B. 8JUR — Definition「von Mangoldt function」（id 148，无 proof）

对整数 $n\ge1$，
\[ \Lambda(n) = \begin{cases} \ln p, & n = p^k \text{ for a prime } p \text{ and an integer } k\ge1, \\ 0, & \text{otherwise}. \end{cases} \]
只此一句定义（`\emph{von Mangoldt function}`）。

### C. 8JUS — Lemma「Logarithmic derivative of $L(s,\chi)$」（id 149，proof 128）

陈述：Let $\chi$ be a \hyperref[8JA9]{Dirichlet character} and $\Lambda$ the \hyperref[8JUR]{von Mangoldt function}.
For every $s\in\C$ with $\Re s>1$,
\[ -\frac{L'}{L}(s,\chi) = \sum_{n\ge1}\frac{\chi(n)\Lambda(n)}{n^s}, \]
and the series converges absolutely.（$L(s,\chi)$ 链到 \hyperref[8JC4]{...} 也可以。）

证明：对 Euler 乘积逐因子取对数导数（乘积在 $\Re s>1$ 上局部一致收敛，这半句即可），把 $1/(1-\chi(p)p^{-s})$ 展成几何级数：
\[ -\frac{L'}{L}(s,\chi) = \sum_p \frac{\chi(p)\ln p\; p^{-s}}{1-\chi(p)p^{-s}} = \sum_p\sum_{k\ge1}\chi(p^k)\ln p\;p^{-ks} = \sum_{n\ge1}\frac{\chi(n)\Lambda(n)}{n^s}. \]
（太宽就用 `align*` 断成两行。）绝对收敛一句：$\Lambda(n)\le\ln n$。

### D. 8JUT — Definition「Generalized Chebyshev function」（id 150，无 proof）

Let $\chi$ be a \hyperref[8JA9]{Dirichlet character}. The \emph{generalized Chebyshev function} of $\chi$ is
\[ \Psi_\chi(x) = \sum_{n\le x}\chi(n)\Lambda(n) \qquad (x\ge1), \]
where $\Lambda$ is the \hyperref[8JUR]{von Mangoldt function}. 不加别的话。

### E. 8JUU — Lemma「Mellin transform of the Chebyshev function」（id 151，proof 129）

陈述：Let $\chi$ be a \hyperref[8JA9]{Dirichlet character} and $\Psi_\chi$ its \hyperref[8JUT]{generalized Chebyshev function}.
For every $s\in\C$ with $\Re s>1$,
\[ \int_1^\infty \Psi_\chi(x)\,x^{-s-1}\,dx = -\frac1s\,\frac{L'}{L}(s,\chi). \]
（陈述里**不要**写 $\mathcal M$，也不要加收敛性的话。）

证明：$\Psi_\chi(x)=\sum_n\chi(n)\Lambda(n)\mathbf 1_{n\le x}$，逐项积分，用 $\int_n^\infty x^{-s-1}\,dx=n^{-s}/s$：
\[ \int_1^\infty \Psi_\chi(x)\,x^{-s-1}\,dx = \frac1s\sum_{n\ge1}\frac{\chi(n)\Lambda(n)}{n^s} = -\frac1s\,\frac{L'}{L}(s,\chi). \]
逐项积分可行和最后一个等号都来自 \hyperref[8JUS]{...}（级数绝对收敛）。两三句话以内。

### F. 8JF7 — 改写陈述（id 106，revision 2 → 3）

现在的陈述有动机（"Subtracting the contribution of $s = 1$ gives"）、推理（"where the quotient is defined because …"）和
"a finite sum"。改成（公式**完全不变**，只是 $\Lambda(n)\chi(n)$ 改写成 $\chi(n)\Lambda(n)$）：

```
Let $\Lambda$ be the \hyperref[8JUR]{von Mangoldt function} and $\gamma$ Euler's constant. For a \hyperref[8JH4]{primitive character} $\chi$ and real $x \ge 1$ put
\[ R_\chi(x) = \sum_{n \ge 1} \chi(n)\Lambda(n)\Bigl(\frac{x}{n} - 1\Bigr)_+, \qquad v_+ = \max(v, 0), \]
and
\[ G_\chi(x) = \begin{cases} R_{\mathbf 1}(x) - x\ln x + (1+\gamma)x, & \chi = \mathbf 1, \\[4pt] R_\chi(x) + x\,\dfrac{L'(1,\chi)}{L(1,\chi)}, & \chi \ne \mathbf 1. \end{cases} \]
Here \hyperref[8JUV]{$L(1,\chi) \ne 0$} for $\chi \ne \mathbf 1$.
```

标题、type、listed 不变；position 1 → 5。

### G. 8JUV — 隐藏 Lemma「Non-vanishing of $L(1,\chi)$」（id 152，listed = 0，proof 130）

陈述：Let $\chi \ne \mathbf 1$ be a \hyperref[8JH4]{primitive character}. Then $L(1,\chi)\ne0$.

证明：一句：This is Dirichlet's theorem \cite{Davenport}.（只用 `\cite{Davenport}`，不要写章节号。）

### H. 8JS6 的证明（proof id 106，revision 4 → 5）

只替换一处，其它字符不动：

- 旧：`and $\sum_n \Lambda(n) n^{-\sigma} < \infty$ for $\sigma > 1$, we may integrate term by term:`
- 新：`and the series of the \hyperref[8JUS]{logarithmic derivative} converges absolutely, we may integrate term by term:`

## 数据库要求（照旧脚本的模式）

脚本开头一行注释，时间戳统一用 `2026-11-25 16:30:00`，operation_id 统一用 `motivate-smoothed-prime-sum-2026-11-25`。

1. **write_guard**（任何一条不满足就整批回滚）：
   - section 102 的 `revision = 1` 且 `intro_tex = ''`；
   - result 106 `revision = 2`；proof 106 `revision = 4`，且 `body_tex` 含上面 H 的旧句子（用 `instr`）；
   - results 116/107/108/109 都在 section 102，position 分别是 2/4/5/6；
   - tags 8JUR–8JUV、results 148–152、proofs 128–130、上面 5 个 alias、这些新实体的 revisions 都还不存在。
2. **tags / aliases**：插 5 个 tag（kind `result`）和 5 个 alias。
3. **results**：插 148–152（`visibility 'published'`，`state` 默认，`revision 1`，`created_by/updated_by 'codex'`，
   `statement_html_cache NULL`）；更新 106（`statement_tex`、`position = 5`、`statement_html_cache = NULL`、`revision = revision + 1`、
   `updated_at`、`updated_by = 'codex'`）；更新 116/107/108/109 的 position（只 `UPDATE ... SET position = … WHERE id = … AND section_id = 102`）。
4. **proofs**：插 128（result 149）、129（result 151）、130（result 152），`position 1`，`status 'ai_generated'`，`generated_by 'gpt'`，
   `generator_detail 'Codex'`，`created_by/updated_by 'codex'`，`revision 1`，`body_html_cache NULL`；更新 proof 106（`body_tex`、
   `body_html_cache = NULL`、`revision = revision + 1`、`updated_at`、`updated_by = 'codex'`）。
5. **sections**：更新 102（`intro_tex`、`intro_html_cache = NULL`、`revision = revision + 1`、`updated_at`、`updated_by = 'codex'`）。
6. **revisions**（author `'codex'`，snapshot 的 JSON 键和现有行一样，见下）：
   - section 102：baseline revision 1（`INSERT OR IGNORE`，当前状态：`{"tag":"7HE6","kind":"section","title":"Smoothed prime sums","intro_tex":"","parent_id":100,"position":2}`）+ revision 2（新 intro）；
   - result 106：revision 3；新 results 148–152：revision 1。result snapshot 键：`tag,type,title,statement_tex,section_id,position,listed,aliases`；
   - proof 106：revision 5；新 proofs 128–130：revision 1。proof snapshot 键：`result_id,position,body_tex,status,generated_by,generator_detail,reviewed_by,review_notes`。
   - snapshot JSON 用 `JSON.stringify` 生成（建议写一个小的 node 生成器在 scratch 里生成 SQL，**不要**手工转义）。
7. **refs**：新 results 的 statement refs 和新 proofs 的 refs 按 `renderTex(...).refs` 插入；result 106 的 statement refs 先
   `DELETE FROM refs WHERE source_result_id = 106 AND source_proof_id IS NULL` 再重建；proof 106 的 refs 先
   `DELETE FROM refs WHERE source_proof_id = 106` 再重建。section intro 没有 refs 行。

## 验收

写检查脚本 `implement_plan/tasks/2026-11-25-motivate-smoothed-prime-sum.check.mjs`（`node <它> <sql路径>`），它：

1. 把本地库 `.wrangler/state/v3/d1/miniflare-D1DatabaseObject/feb98e23e8d07ed53c02acad60b7af51cee41722a632c769f200a9b7c2d3ca7f.sqlite`
   **复制**到系统临时目录，用 `node:sqlite` 打开副本，`PRAGMA foreign_keys = OFF`，`exec` 整个 SQL。原文件不能被改。
2. 再对副本 `exec` 一次同一个 SQL，**必须失败**（write_guard 生效）。
3. 用 `settings.macros` 经 `buildMacros` 得到宏，对 section 102 的 intro、section 102 所有 results 的 statement、这些 results
   的所有 proofs、proof 106 跑 `src/latex.ts` 的 `renderTex`，打印每条 warning；**要求 0 条**。
4. 对 results 106、148–152 和 proofs 106、128–130：`renderTex(...).refs` 的集合 == 数据库 refs 行的集合；所有 ref 目标（含 intro 的）都在 `tags` 表里。
5. 打印 section 102 的 `position, tag, type, listed, title`，position 不重复，顺序同上表。
6. 每个改动/新增的实体：`max(revisions.revision) == 行的 revision`，最新 snapshot 里的 `intro_tex`/`statement_tex`/`body_tex` 等于当前行。
7. 把 intro 和 5 个新结果、8JF7 的渲染 HTML 写到临时目录的一个 html 文件里，打印路径（方便人看）。
8. 全部通过时最后一行打印 `ALL CHECKS PASSED`，否则非零退出。

需要跑通：

```
node implement_plan/tasks/2026-11-25-motivate-smoothed-prime-sum.check.mjs scripts/motivate-smoothed-prime-sum-2026-11-25.sql
npm test
```

## 报告

写到 `implement_plan/tasks/2026-11-25-motivate-smoothed-prime-sum.md.report.md`：改了/新建了哪些文件；检查脚本的完整输出
（renderTex warnings 数、section 102 的顺序表）；intro 和 5 个新结果、8JF7、proof 106 的**最终 TeX 原文**（方便审阅，不用 SQL 转义）；
有任何偏离本规格的地方要单独列出并说明原因。
