# 拆分第 2 章：第 2 章 = Fourier 步骤（完整、可学），第 3 章 = 算术界（黑箱的证明概要）

## 背景与目标

书的真内容在**远程** D1 库 `grh-notes`。本机 `.wrangler` 里的本地库只是 seed 样例，**不要用**。
主会话已把远程库只读导出到仓库根目录 `backup-before-ch2-split-2026-11-25.sql`（已被 .gitignore 忽略）。
这就是本任务的基准：用 `node:sqlite` 把它载入一个临时 `.sqlite` 文件（先 `PRAGMA foreign_keys=OFF`，否则建表顺序会报错），
所有测试都在这个文件的副本上做。

现在的第 2 章（section id 105，tag `8JU2`，"Proof sketch of the arithmetic interval estimate"）有四节：
`8JU3`（id 106）、`8JU4`（id 107）、`8JU5`（id 108）、`8JU6`（id 109）。用户觉得它对学生太密，要求：

- **第 2 章 = Fourier 步骤**：把"计数在剩余类上的界"如何变成"能探测零点的素数和 $\mathcal G_\psi$ 的界"完整讲清楚、证明出来。
  这是本任务的重点，要写到一个本科生能自己复现推导的程度。
- **第 3 章 = 算术界（Arithmetic bound）**：现在的 theta lift、公共区间、格估计、参数平衡等深层内容，作为第 2 章所用黑箱的证明概要。
  可以再分成几节。第 3 章只需轻度整理（搬家、改 intro、改引用、让它明确是在证明第 2 章的黑箱），不必重写。

用户原话：

> "For the second chapter I think it is a bit too dense for students to learn, so I would like to divide it to two parts
> (Fourier step in chapter 2, and Arithmetic bound in chapter 3, perhaps divided further). … Focus on polishing the chapter 2,
> and I would like everything mentioned to be explained well (like 'After subtracting its main term, averaging over the shifts,
> and dividing by the total weight of the terms at scale $x$' is unclear for me)."

用户采纳的设计建议（另一个模型给的，供参考，具体措辞不必照抄）：

> 在第 2 章开头放**一个**主要黑箱：中心化素数幂计数的单侧界。用 Adriazola §6.2 Theorem A 的简化形式，
> 结合 `8JU7` 的公共窗口保证、`8JUA` 的界和 §2.4 的归一化。
>
> **Arithmetic bound.** Fix a primitive character $\psi$ and $\eta>0$. There are arbitrarily large $Y$ such that, for every
> $x\in[Y,Y^{3/2}]$, the construction supplies a weighted prime-power count. After subtracting its main term, averaging over
> the shifts, and dividing by the total weight of the terms at scale $x$, the resulting quantity $D_\psi(x)$ satisfies
> $D_\psi(x)\le C_{\psi,\eta}x^{1/2+\eta}$. The constant is uniform in $x$ and $Y$.
>
> 然后**在本章证明 Fourier 步骤**：对 $A_0$ 平均去掉大部分特征，陪集平均给幸存特征恰好第 1 章的权重。
> 辅助二次扭的小性和大截断估计放在一个简短的支撑引理里引用。合起来得到
> $\mathcal G_\psi(x)\le D_\psi(x)+O_{\psi,\eta}(x^{1/2+\eta})$。

**用户明确说上面黑箱里那句"After subtracting its main term, averaging over the shifts, and dividing by the total weight of the
terms at scale $x$"看不懂。** 所以第 2 章里 $D_\psi(x)$ 必须是一个**正式定义**，用符号写出来，每个操作都对应公式里的一个具体部分：
"main term" 是哪个量（$\Re M(a,w)$，定义 `8JU9`），"shifts" 是什么（$t\in T$ 的平移，以及 $u\in A_0$），对什么平均、权重是什么，
"total weight of the terms at scale $x$" 是哪个数（目前的 $Q\delta_2/2=hmb\,h_2/(2n)$），**为什么**除以它是对的
（它正是平均之后 $G_\psi(x)$ 前面的系数）。intro 或 motivation 里用文字解释每一步，定义里只放符号。

## 交付物

1. `scripts/ch2-fourier-split-2026-11-25.sql`：把基准库变成新结构的 SQL 脚本。
2. `implement_plan/tasks/2026-11-25-ch2-fourier-split.check.mjs`：检查脚本（见「验收」）。
3. `implement_plan/tasks/2026-11-25-ch2-fourier-split.md.report.md`：报告。写清楚新结构（每节、每个结果的 tag/标题/一句话内容）、
   做了哪些数学判断、**哪些地方你不确定或来源里找不到**（不要编造，列出来让主会话决定）。

## 约束

- **只写上面三个文件**。不改 `src/`、`public/`、`migrations/`、`seed/`，不加依赖，不 commit。
- **绝不运行任何 `--remote` 命令或任何 wrangler 写操作**，不碰 `.wrangler/state`。只在基准库副本上测试。
- 只用 `node:sqlite` 应用 SQL。SQL 脚本里**不要**写 `BEGIN`/`COMMIT`；`write_guard` 检查放在所有修改语句之前，
  检查基准状态（相关行的 id/tag/section/position/revision）完全符合预期，否则整个脚本不写任何东西。
- 先读 `src/book.ts`、`src/store.ts`、`src/tags.ts`、`src/latex.ts` 和最近的脚本，学会：revisions 快照格式、refs 怎么重建、
  html cache 怎么失效（置 NULL）、`settings.needs_rebuild`、section 的 `kind`/`parent_id`/`position`、tag 字母表与分配。模板：
  `scripts/ch2-error-exponents-2026-11-25.sql`、`scripts/ch2-formal-fixes-2026-11-25.sql`、`scripts/motivate-smoothed-prime-sum-2026-11-25.sql`、
  `scripts/intro-8JU4-2026-11-24.sql`。
- 新编号：result 从 157 起，proof 从 132 起，section 从 111 起；新 tag 取 `8JV4` 之后按字母表的下一个空闲 tag（用前确认未占用）。
  时间戳 `2026-11-25 20:00:00`，operation_id `ch2-fourier-split-2026-11-25`，`updated_by`/`created_by` = `'codex'`，proof 的 `generated_by` = `'gpt'`。
- **不要硬删除**任何 result/proof/section。已有 tag 的结果尽量搬家并改写（tag 和 URL 永久不变）。真不需要的结果，按 app 的方式处理
  （看 `state`/`replaced_by_id`/`visibility` 在 src 里的用法），并在报告里说明。
- 章节之外的引用要保持正确：第 1 章里有指向 `8JU2` 的 `\ref`（result 110，`8JK2` 的陈述），`8JUW`/`8JV3` 指向 `8JU4`。
  搬走/改写后用 grep 检查所有 `\ref{…}`、`\hyperref[…]{…}` 仍指向含义正确的东西，必要时更新那些文本（并写 revision 快照）。
- TeX：用书里已有的宏（`settings.macros`），`\ln` 不用 `\log`，`\le`/`\leqslant` 与周围一致，不用 `\tag`。
  每个行间公式要在约 680px 正文栏里放得下，长式用 `align*` 断行。SQL 字符串里 `'` 写成 `''`。

## House style（必须遵守）

1. 定义和陈述里**不放推理**（没有 since/because/by Lemma/括号理由/动机）。动机放 section intro，或用 `motivation` 类型的结果
   （见 `8JV3` 的写法）。
2. 一个结果一个论断。证明短而完整：写关键步骤和得到的式子，不写琐碎记账。
3. 量词写清楚。每个符号**第一次出现前**已定义，或用 `\hyperref[TAG]{词}` 链接到定义。
4. 背景性的小定义/引理可以做成 unlisted（listed=0）结果，读者点词展开。
5. 证明多步时用 `8JUF` 证明那样的"先写定义、逐行估计、每行标 (a)(b)… 并逐条说明"格式。

## 第 2 章：要写成什么样

读者：学过初等数论和有限 Abel 群特征的本科生，读过第 1 章（知道 $G_\chi$、$\mathcal G_\psi$、权重 $a_{\mathbf 1}=1$, $a_\chi=1/(3o+1)$、
`8JS3` 的主项 $M_\chi$）。不懂 Galois 上同调、theta lift。

**目标**：读者读完能自己复现这条推导：
$$\text{(算术界)}\ D_\psi(x)\le Cx^{1/2+\eta}\quad\Longrightarrow\quad \mathcal G_\psi(x)\le D_\psi(x)+O(x^{1/2+\eta})\le C'x^{1/2+\eta},$$
从而得到 `8JK2`（Arithmetic interval estimate）。

建议的节结构（可以调整，但要在报告里说明理由）：

**2.1 有限 Abel 群上的两种平均**（纯初等，可以完全自足）
- 有限 Abel 群特征的正交性（若书里已有可复用的，链接；`8JA9` 等在第 1 章）。
- 对子群 $A_0$ 平均：$\frac1{|A_0|}\sum_{u\in A_0}\xi(u)=\mathbf 1_{\xi|_{A_0}=1}$。正式陈述 + 证明。
- 对一个按陪集分布为 $\lambda_\alpha$ 的集合 $T$ 平均：$\frac1{|T|}\sum_{t\in T}\xi(t)$ 对 $A_0$ 上平凡的 $\xi$ 等于 1（$\xi$ 平凡）或 $1/(3o+1)$（否则）；
  以及分布只是近似（误差 $x^{-1+\varepsilon}$，`8JU7`）时的误差界。正式陈述 + 证明。
- 一个**具体小例子**（unlisted example 也行）：比如 $A=\Z/6\Z$，$A_0=\{0,3\}$ 或类似，$o=3$，写出 $T$ 和平均的数值，让读者看到权重 $1$ 和 $1/(3o+1)$ 是怎么出来的。
- 这些在现在 `8JU3` 的 intro 里只是散文，需要变成正式结果。

**2.2 群 $A$、$B$、素数的类，以及加权素数幂计数**
- 现在 `8JU3`/`8JU4` intro 里关于 $A$、$B=(\Z/2\Z)^2\times A$、$\Phi$、$F_p$、$I_p$、$\xi_c$ 的内容，整理成正式定义（必要时 unlisted）。
  Galois/Frobenius/惯性群的说法只作为可跳过的 remark；正文要能只用"$p \bmod M$ 在商群里的像"读懂。对 $p\mid M$ 的处理要说清楚。
- 把 `8JU9`（加权素数幂计数 $S(t,a,w)$ 和主项 $M(a,w)$）搬到这里，前面用 motivation/intro 解释：为什么只数 $\Phi$ 外的类、因子 2、
  平移 $((1,1),t)$ 在做什么（置换权重）、$(a/p^i-w)_+=w((a/w)/p^i-1)_+$ 为什么说明这是光滑素数和。
- **Fourier 展开引理**（正式陈述 + 完整证明）：$S(t,a,w)-\Re M(a,w)$ 精确地等于 $\sum_\xi(\text{显式系数})\cdot w\,G_{\xi^*}(a/w)$ 的组合
  （注意实部、primitive representative、$p\mid M$ 处的修正、只有平凡特征和 $\xi_c$ 留下主项）。现在 `8JUD` 证明第 (1) 步只是概要，要补全。
  如果精确等式需要额外的小项（例如非本原表示带来的有限个素数），写出来并界住。

**2.3 算术界（本章唯一的主要黑箱）**
- 先列出构造提供的数据及其性质（"接口"）：区间 $[Y,Y^{3/2}]$、$q,d$、$A,A_0,T$ 及其陪集分布、每个 $t$ 的尺度 $a_t$（$|a_t/b-x|\le1$）、
  链长 $m$、每层权重 $w_{u,j}$、大权重的个数 $h_2$ 及其所在的 $A_0$ 子集、大权重落在 $[b,b+\eta+1]$、小权重对应的截断很大、$h,n,b,\delta_2,Q$。
  每一条都说清它来自第 3 章哪个结果。第 2 章的证明**只能**用这些列出的性质 + 引用的支撑引理，不能再偷偷用别的构造细节。
- **正式定义 $D_\psi(x)$**（这是用户卡住的地方）：
  $$D_\psi(x)=\frac{1}{(\text{总权重})}\cdot\frac{1}{|A_0|}\sum_{u\in A_0}\Delta_u,\qquad \Delta_u=\sum_{t\in T}\sum_{j=1}^m\bigl(S(t,a_t,w_{u,j})-\Re M(a_t,w_{u,j})\bigr)$$
  或你核对后认为正确的形式。前面的 intro/motivation 一句一句解释："减去主项"="$S-\Re M$"；"对平移平均"="对 $t\in T$ 求和、对 $u\in A_0$ 平均"；
  "尺度 $x$ 上的总权重"=哪个数，并用一行计算说明：平均之后 $G_\psi(x)$ 的系数恰好是这个数，所以除以它之后 $\mathcal G_\psi(x)$ 以系数 1 出现。
- **定理（Arithmetic bound）**：陈述里给出精确的量词和常数依赖，证明写"见第 3 章 Theorem …"（链接）。与 Adriazola 一致：
  `docs/references/main.pdf` §6.2 Theorem A（以及 Definition 18.9 / Hypothesis 18.10）；Outline 是 `docs/references/GRH-natural-language-outline.pdf`。
  用 `pdftotext` 读。$\eta$ 与 $\varepsilon$、$e_D,e_L$ 的关系要和 `8JUF`、`8JK2` 的陈述一致。

**2.4 Fourier 步骤**
- 支撑引理（引用，不证明或只给出处）：辅助二次扭（含 $q$ 或 $d$ 的 Legendre 符号因子）的光滑素数和 $\le x^{1/2+\varepsilon}$；
  小权重对应的大截断估计 $|G_\xi(y)|\le y\exp(-cx^{\varepsilon/8})$。这是现在 `8JUW`/`8JUD`/`8JUE` 里引用的东西，集中成**一个**清楚的引用引理。
- 换权重引理（现在的 `8JUE`）：给出完整证明（现在的证明很粗）。
- 主要命题：$\mathcal G_\psi(x)\le D_\psi(x)+(\text{显式误差})$，误差 $=O_{\psi,\varepsilon}(x^{1/2+\cdots})$。证明分步：
  Fourier 展开 → 对 $u\in A_0$ 平均去掉非平凡于 $A_0$ 的特征 → 大权重换成 $b$、丢掉小权重、回到尺度 $x$ → 对 $t$ 按陪集平均得到权重 $1$ 和 $1/(3o+1)$ →
  剩下的是 $\mathcal C_\psi$ 之外的 $4o-o$ 个辅助特征（$\Sigma(x)$）和误差。现在 `8JUD` 证明第 (3) 步里"误差 $4x^{1/2+\varepsilon}$ 见 Outline §13–14"
  **要尽量真的推出来**（用 2.1 的近似分布误差界 + 换权重引理 + $|a_t/b-x|\le1$）；实在需要外部输入，就放进支撑引理并说明。
- 最后一个推论：算术界 + Fourier 步骤 ⇒ `8JK2`。现在 `8JUF` 的 (a)–(g) 链里，属于"Fourier 一侧"的部分放到这里，属于"算术一侧"（$\mathcal B/Q$ 的估计）放第 3 章。
- `8JUW`（$\Sigma(x)$ 定义）、`8JUD`、`8JUE` 搬到/改写在本章合适位置。

**整章要求**：
- 每节 intro 先说这一节要证明什么、为什么需要它、和前后怎么接。
- 第 2 章开头（chapter intro，id 105）用几句话 + 一个推导链（像上面那条 ⇒）说明整章的逻辑，并说明黑箱在第 3 章证明。
- 不要出现未定义的行话（"translate"、"level"、"large weights"、"normalized scale"、"common interval" 等首次出现都要定义或链接）。
- 公式全部亲自核对（尤其系数 $2$、$f=2|A|=|B|/2$、$\delta_2/2$、$1/(3o+1)$、$4o$）。核对不了的写进报告。

## 第 3 章：轻度整理

- 新建 chapter section（id 111，新 tag，position 3），标题类似 "The arithmetic bound"，intro 说明：本章概述第 2 章 Theorem（Arithmetic bound）的证明，
  深层输入来自 Adriazola / Lean 开发，初读可当黑箱。
- 把 `8JU3`、`8JU4`、`8JU6`（以及你判断属于算术一侧的结果，如 `8JV2`、`8JU7`、`8JU8`、`8JUA`、`8JUB`、`8JUC`、`8JUG`）放到第 3 章，
  删掉已搬到第 2 章的重复散文（两种平均、计数定义、Fourier 展开），intro 改成引用第 2 章的定义。
- `8JUF` 改为证明第 2 章的 Arithmetic bound（即 $D_\psi(x)\le C x^{1/2+\eta}$），或者新写一个这样的定理，`8JUF` 留下合适部分；你决定并说明。
- 可以细分节（用户说 "perhaps divided further"），但不要重写深层内容的数学。

## 验收

```
node implement_plan/tasks/2026-11-25-ch2-fourier-split.check.mjs backup-before-ch2-split-2026-11-25.sql scripts/ch2-fourier-split-2026-11-25.sql
npm test
```

检查脚本：从导出的 `.sql` 建临时库 → 应用脚本 → 检查：
- 打印 `ALL CHECKS PASSED`；脚本再次应用时被 write_guard 拒绝且不写任何东西；
- 新结构（章/节的 parent/position、每个结果的 section/position/listed/type）与报告一致；
- 所有 `\ref`/`\hyperref` 目标存在；refs 表与文本一致；所有改动行有 revision 快照、html cache 已置 NULL、`needs_rebuild` 已置位；
- 用 `src/latex.ts` 的渲染/校验路径（参照 `test/latex.test.ts` 的用法）对所有改动文本渲染一次，**0 个 TeX 警告/错误**；
- 列出最宽的行间公式及其估计宽度（之前的报告用 pdfLaTeX 估计，或你有更好的办法）。

## 报告里要回答

1. 新的章/节/结果清单（tag、类型、标题、一句话）。
2. $D_\psi(x)$ 的最终定义，以及"总权重"为什么是那个数（给出那一行计算）。
3. Fourier 步骤里哪些是完整证明，哪些仍依赖引用（逐条列出，附来源页码）。
4. 发现的原文错误或不一致（例如系数、指数），以及你怎么处理的。
5. 不确定、需要主会话决定的地方。

## 返工（第 2 轮）

第 1 轮的脚本**没有应用到任何库**（本地和远程都没有），所以本轮**直接修改同一个** `scripts/ch2-fourier-split-2026-11-25.sql`
（基准仍是 `backup-before-ch2-split-2026-11-25.sql`），同步更新检查脚本和报告（报告末尾加「第 2 轮改动」一节）。
编号、时间戳、operation_id 保持不变；如需新结果，从当前脚本用到的最大 id/tag 之后继续。

主会话逐行核对了第 1 轮的数学，系数和误差都对，不要改动已核对的数学内容。要改的是可读性和自足性：

1. **第 2 章必须自足。** 现在 `8JVE` 依赖第 3 章的 `8JVK` 提供 $X',b',\rho_w,\Phi_u,T_2,a_t,w_{u,j}$，`8JVH` 也用 $X'$，
   `8JUD` 证明里也引用 `8JVK`。把 `8JVK`（只是性质陈述，证明是引用）**搬到 §2.3**，放在 `8JVE` 之前（或并入 `8JVE`），
   证明里写明来源（Adriazola 的命题号）以及"构造见第 3 章 \ref{8JU7}"。第 3 章相应处改为引用它。
   搬完后检查：第 2 章正文（intro、陈述、证明）不再需要读者翻到第 3 章才能理解任何符号。

2. **把"尺度 $x$ 上的项"讲清楚（用户最初卡住的地方）。** 在 §2.3 intro（或一个 `motivation` 结果）里明确写：
   - 计数里权重为 $w$ 的项，其截断是 $a_t/w$（由 $(a/p^i-w)_+=w((a/w)/p^i-1)_+$）。
   - 在 $\Phi_u$ 的位置，$w\approx b$，而 $a_t\approx xb$，所以截断 $\approx x$：这些就是"尺度 $x$ 上的项"。
   - 其他位置 $w\le 2b'$，截断 $\ge X'/3$，极大，这些项由 \ref{8JVH}(i) 可忽略。
   - 所以"尺度 $x$ 上的项的总权重" = (每个 $(t,j)$ 的这类位置数 $h_2$) × (它们的权重 $b$) × (Fourier 系数 $1/f$) × (对 $(t,j)$ 的个数 $hm$) $=Q\delta_2/2$。
   - 再说清为什么要两种平移：$t\in T$ 产生第 1 章的权重（陪集平均），$u\in A_0$ 去掉在 $A_0$ 上非平凡的特征（子群平均）。
   用学生能跟上的话，一句一个意思。

3. **`8JVC`（素数类的有限群）太密。** 在 §2.2 intro 或一个 `motivation`/`remark` 里逐个解释每个成分的作用：
   $2^{e+2}$ 和 $v\equiv\pm1$（实分圆塔，让 $A$ 足够大、提供选择平移的自由）、$\psi(v)=1$（使 $\psi$ 在 $A$ 上有定义、$A_0=\ker\psi$ 指数为 $o$）、
   $q,d$ 的两个二次符号（为什么需要、$\Phi$ 与 $\xi_c$ 怎么来）。再给一个**很小的具体例子**（unlisted example 即可），
   例如取一个小的 $\psi$、小的 $e$、小的 $q,d$，写出 $A$ 的阶、$A_0$、$B$、$\Phi$，以及一个具体素数 $p$ 的类 $F_p$。数字要亲自算对。

4. 小修：
   - `8JVJ` 证明里的 $C_{\psi,\varepsilon}$ 没有定义，且与 `8JVH`(ii) 里的 $C_{\psi,\varepsilon}$ 含义不同。改成显式：
     用 $\delta_2\ge x^{-\varepsilon}$ 得 $4/(x\delta_2)\le4x^{\varepsilon-1}\le4x^{1/2+\varepsilon}$，所以常数为 $3o+8$；`8JVH` 里的常数换一个名字。
   - `8JVJ` 选窗口时还要越过 `8JUD` 的"$x$ 充分大"阈值（以及 `8JUF`/`8JVK` 的阈值），写进 max。
   - `8JUF` 的陈述量词写清楚（对哪个 $\psi,\varepsilon$、哪个窗口、哪些 $x$），与 `8JVG` 一致。
   - 第 3 章 `8JU4` intro 的 "a nonzero integer $N$" 与模 $N$ 冲突，换一个字母（不要用 $n$，它是 $|A|$）。
   - 第 2 章 chapter intro 的 "On the same interval" 没有先引入区间；先说构造给出任意远的区间 $[Y,Y^{3/2}]$，再写两个不等式。

验收同前（`ALL CHECKS PASSED`、0 TeX 警告、`npm test`）。检查脚本额外检查：第 2 章所有结果的文本里不出现指向第 3 章结果的
`\ref`/`\hyperref`，**除了** `8JVG` 的证明、`8JVK`（搬来后）的证明，以及 chapter/section intro 里对第 3 章的总体指引。
