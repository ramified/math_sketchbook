# 推广 Lemma 2.1.2（陪集比例平均）并加一个 $r>0$ 的例子

## 背景

书的真内容在远程 D1 库 `grh-notes`。上一个任务（`scripts/ch2-fourier-split-2026-11-25.sql`）**已经应用到远程**。
主会话刚把远程库只读导出为仓库根目录的 `backup-before-coset-average-2026-11-25.sql`（被 .gitignore 忽略），这是本任务的基准：
用 `node:sqlite` 载入临时 `.sqlite`（先 `PRAGMA foreign_keys=OFF`），只在副本上测试。

涉及的结果（在 §2.1，section `8JV6`）：
- `8JVA`（Lemma 2.1.2, Averaging with prescribed coset proportions）
- `8JVB`（Example 2.1.3, Ten shifts in a group with three cosets）

## 用户原话

> "I would like to see another example like Example 2.1.3 (Ten shifts in a group with three cosets), while r is bigger.
> For Lemma 2.1.2 I think it can be more general (3o+1 can be replaced by ko+1?), a general statement may make the proof
> clearer to see. The definition of c can be made via cases environment (as displayed formula)."

## 要做的事

1. **推广 `8JVA`**：对任意实数 $k\ge0$（或你认为最自然的范围，例如 $k>0$；说明理由），令
   $$\lambda_C=\frac{k+\mathbf 1_{C=A_0}}{ko+1}.$$
   验证 $\sum_C\lambda_C=1$，并证明对 $A_0$ 上平凡的特征 $\xi$，
   $$\Bigl|\frac1{|T|}\sum_{t\in T}\xi(t)-c_k(\xi)\Bigr|\le o\,r,\qquad
   c_k(\xi)=\begin{cases}1,&\xi=\mathbf 1,\\[2pt] \dfrac1{ko+1},&\xi\ne\mathbf 1,\end{cases}$$
   其中 $c_k$ 用 `cases` **写成行间公式**。证明要让结构一眼可见：$\lambda_C$ = "均匀部分 $k/(ko+1)$" + "在 $A_0$ 处的一个原子 $1/(ko+1)$"，
   均匀部分对非平凡特征平均为 0（\ref{8JV9}），原子贡献 $\xi(A_0)=1$。可以在陈述后或 intro 里加一句：第 2 章用 $k=3$，此时 $c_3$ 给出第 1 章权重 $a_{\mathbf 1}=1$, $a_\chi=1/(3o+1)$（链接 `8JG8`）。
   误差界 $o\,r$ 是否可以改进（例如 $\sum_C|\mu_C-\lambda_C|\le or$ 本来就是逐项求和）不必追求，保持 $or$。
   如有更清楚的做法，也可以把"一般的分布 $\lambda$ 的平均 = 其 Fourier 系数"作为证明的第一步。

2. **所有引用 `8JVA` 的地方改为 $k=3$ 的特例**：用 grep 找出所有文本里的 `8JVA`、$\lambda_C$、$\mu_C$、$c(\xi)$、`3o+1` 的使用
   （至少有 `8JVB`、`8JVE`、`8JUD` 的证明、`8JU7`、§2.1/§2.3 的 intro，可能还有其他），保证记号一致（例如 $\lambda_C$ 现在依赖 $k$，
   第 2 章其余部分明确写 $k=3$，或定义 $\lambda_C=\lambda_C^{(3)}$——选最不累赘的方式并在报告里说明）。数学内容不变。

3. **新例子（unlisted 或 listed 与 `8JVB` 一致，放在 `8JVB` 之后）**："像 Example 2.1.3，但 $r$ 更大"。
   要求：
   - 同样具体：给出群、子群、$T$ 的元素、各陪集比例 $\mu_C$、$\lambda_C$、算出 $r=\max_C|\mu_C-\lambda_C|$（不为 0，且不要太小，让读者看到误差）。
   - 算出每个特征的实际平均值，与目标 $c_k(\xi)$ 比较，给出实际差 $|\text{平均}-c_k(\xi)|$ 的精确值，和界 $or$ 并列，说明界成立（以及它是否接近最优）。
   - 可以用 $k=3$, $o=3$ 继续 $\Z/30\Z$ 的设定，也可以换别的 $k$ 或 $o$ 来展示一般性（例如 $k=1$ 或 $o=4$）——你选更有启发的，
     但至少一个例子要显示 $r>0$。所有数字（含复数的模）亲自计算并用脚本独立核对。
   - 若有必要可同时微调 `8JVB` 的措辞，使两个例子并列时读起来连贯。

## 约束

- 只写：`scripts/coset-average-general-2026-11-25.sql`、`implement_plan/tasks/2026-11-25-coset-average-general.check.mjs`、
  `implement_plan/tasks/2026-11-25-coset-average-general.md.report.md`。不改 `src/`、`public/`、`migrations/`、`seed/`，不 commit。
- **绝不运行任何 `--remote` 或 wrangler 写命令**，不碰 `.wrangler/state`。
- SQL 写法完全照 `scripts/ch2-fourier-split-2026-11-25.sql`：write_guard 在所有修改之前且精确检查基准行（id/tag/section/position/revision）；
  不写 `BEGIN`/`COMMIT`；改动行写 revision 快照（`INSERT OR IGNORE` baseline revision）；html cache 置 NULL；refs 重建；`needs_rebuild`=1。
  新编号：result、proof、tag 都取基准库中当前最大值之后的下一个空闲值（用前确认）。时间戳 `2026-11-25 22:00:00`，
  operation_id `coset-average-general-2026-11-25`，`created_by`/`updated_by`=`'codex'`，proof 的 `generated_by`=`'gpt'`。
- House style：陈述里不放推理；一个结果一个论断；证明短而完整；符号先定义后使用；行间公式在约 680px 宽内放得下；`\ln` 不用 `\log`；不用 `\tag`。
  SQL 字符串里 `'` 写成 `''`。

## 验收

```
node implement_plan/tasks/2026-11-25-coset-average-general.check.mjs backup-before-coset-average-2026-11-25.sql scripts/coset-average-general-2026-11-25.sql
npm test
```
检查脚本打印 `ALL CHECKS PASSED`：再次应用被 write_guard 拒绝且不写；所有 `\ref`/`\hyperref` 目标存在、refs 表一致；改动行有 revision 快照、
cache 为 NULL；所有改动文本用 `src/latex.ts` 渲染 0 警告；列出最宽行间公式的估计宽度；并独立数值核对新例子里的每个平均值和 $r$。

报告：改了哪些结果（tag + 一句话）、新例子的全部数字、$k$ 的取值范围选择的理由、记号处理方式。
