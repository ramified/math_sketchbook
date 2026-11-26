# 改写 Definition 2.2.1（The finite group of prime classes, `8JVC`）并统一集合记号

## 背景

书的真内容在远程 D1 库 `grh-notes`。基准 = `backup-before-coset-average-2026-11-25.sql`（远程只读导出，仓库根目录）
**再应用** `scripts/coset-average-general-2026-11-25.sql`（另一个刚完成、尚未上线的任务；它改 §2.1 的 `8JVA`/`8JVB` 等）。
本任务的脚本必须在这个"先应用 coset 脚本"的状态上运行；write_guard 检查本脚本要改的行的当前 revision。
检查脚本要跑通：基准导出 → coset 脚本 → 本脚本。只在 `node:sqlite` 临时副本上测试（先 `PRAGMA foreign_keys=OFF`）。

## 用户原话

> "Definition 2.2.1 (The finite group of prime classes) has something to be fixed also. $U_1$ should be defined via displayed formula,
> and $\Phi$ uses $\{...: ...\}$ which I don't like (always use \middle| version in my book). Whenever there are several symbols
> introduced via sequence, you can introduce them via aligned equations, like here for $\Phi$, $f$ and $\xi_c$. This definition is
> also too long and reader cannot see why we need these definitions."

## 要做的事

1. **集合记号**（全书规则）：集合构造式一律写成
   `\left\{ <对象> \;\middle|\; <条件> \right\}`，能写明全集时写在左边（例如 `\left\{ v\in(\Z/N_1\Z)^\times \;\middle|\; \dots \right\}`）。
   不要 `\{\dots:\dots\}` 或 `\{\dots\mid\dots\}`。列举元素的集合（`\{1,9,31,39\}`）不变。
   **范围**：`8JVC`，以及上一次拆分（`scripts/ch2-fourier-split-2026-11-25.sql`）和 coset 脚本新写或改写的所有文本
   （第 2、3 章的 intro、陈述、证明；已知至少 `8JVK` 的 $\Phi_u$、`8JUW` 的 $\mathcal H,\mathcal K$）。用 grep 找全，报告里列出每一处。

2. **`8JVC` 的排版**：
   - $U_1$ 用行间公式定义（集合构造式，`\middle|`）。
   - 依次引入的多个符号用一个对齐的行间公式一起引入，例如
     ```
     \begin{align*}
     \Phi &= \left\{ ((0,e_2),v)\in B \;\middle|\; e_2\in\Z/2\Z,\ v\in A \right\},\\
     f &= |\Phi| = 2|A| = |B|/2,\\
     \xi_c((e_1,e_2),v) &= (-1)^{e_1}.
     \end{align*}
     ```
     （$\Phi$ 也可以写成 $\{0\}\times\Z/2\Z\times A$ 或 $\ker\xi_c$，选最清楚的；若用 $\ker\xi_c$ 就先定义 $\xi_c$。）
     同样处理 $N_1,N$；$A,B,A_0$；$I_p,F_p$ 等成组引入的符号。
   - 每个行间公式在约 680px 正文栏里放得下。

3. **太长、读者看不出为什么需要**：
   - 把 `8JVC` 拆成两到三个短定义，每个一个用途，例如：
     (a) 群 $A$、$A_0$（以及 $U_1$）——用于两种平均（§2.1）；
     (b) 群 $B$、$\Phi$、$\xi_c$、映射 $\pi$ ——加上两个二次符号，用于计数只数一半的类、给权重贴标签；
     (c) 素数幂的类 $F_p$、$I_p$，以及 $\xi^*$ ——用于 Fourier 展开（\ref{8JVD}）。
     具体切法你定，原 tag `8JVC` 留给其中第一个（或最主要的）定义，其它取新 tag；更新所有指向 `8JVC` 的引用，使其指向含义正确的那个。
   - **定义里不放理由**（house style），"为什么"放在 §2.2 intro 或紧挨每个定义前的一个 `motivation` 结果里：
     每个对象后面要用在哪里、去掉它会怎样（例如：没有 $\psi(v)=1$ 这个条件，$\psi$ 在 $A$ 上就没有定义；
     没有两个二次符号，就不能只数一半的类/放权重；$2^{e+2}$ 让 $A$ 足够大以选择平移集合 $T$）。
     现在 §2.2 intro 已经有一部分这样的解释，整理后与新定义一一对应，避免重复。
   - mod 840 的例子（`8JVM`）随之调整引用；数字已核对，不要改数字。

4. 数学内容不变（只是重排、拆分和记号）。如发现原定义有数学问题，写进报告，不要擅自改。

## 约束

- 只写：`scripts/prime-classes-definition-2026-11-25.sql`、`implement_plan/tasks/2026-11-25-prime-classes-definition.check.mjs`、
  `implement_plan/tasks/2026-11-25-prime-classes-definition.md.report.md`。不改 `src/`、`public/`、`migrations/`、`seed/`，
  不改 coset 任务的文件，不 commit。
- **绝不运行任何 `--remote` 或 wrangler 写命令**，不碰 `.wrangler/state`。
- SQL 写法照 `scripts/ch2-fourier-split-2026-11-25.sql` 与 `scripts/coset-average-general-2026-11-25.sql`：write_guard 在前；不写 `BEGIN`/`COMMIT`；
  revision 快照；cache 置 NULL；refs 重建；`needs_rebuild`=1。新 result/proof/tag 编号取 coset 脚本应用后的最大值之后的空闲值。
  时间戳 `2026-11-25 23:00:00`，operation_id `prime-classes-definition-2026-11-25`，`created_by`/`updated_by`=`'codex'`，proof `generated_by`=`'gpt'`。
- House style：陈述里不放推理；一个结果一个论断；符号先定义后使用；`\ln`；不用 `\tag`；SQL 里 `'` 写成 `''`。

## 验收

```
node implement_plan/tasks/2026-11-25-prime-classes-definition.check.mjs backup-before-coset-average-2026-11-25.sql scripts/coset-average-general-2026-11-25.sql scripts/prime-classes-definition-2026-11-25.sql
npm test
```
检查脚本打印 `ALL CHECKS PASSED`：再次应用被拒且不写；第 2、3 章所有文本里不再出现 `\{…:…\}` 或 `\{…\mid…\}` 形式的集合构造式
（用正则检查，列表集合除外）；所有 `\ref`/`\hyperref` 目标存在且 refs 一致；revision 快照、cache NULL；渲染 0 警告；列出最宽公式宽度。

报告：新的 §2.2 结构（tag、标题、一句话）、每个定义对应的"为什么"放在哪里、所有集合记号改动的位置清单。
