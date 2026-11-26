# 映射一律写清定义域和陪域；任意给定的对象写明"任意"（从 `8JU9` 开始，审查第 2、3 章）

## 背景

书的真内容在远程 D1 库 `grh-notes`。前面的任务（`ch2-fourier-split`、`coset-average-general`、`prime-classes-definition`）**都已上线**。
基准 = 仓库根目录 `backup-before-map-notation-2026-11-25.sql`（刚从远程只读导出）。用 `node:sqlite` 载入临时 `.sqlite`
（先 `PRAGMA foreign_keys=OFF`），只在副本上测试。

## 用户原话

> "Definition 2.2.4 (The weighted prime-power count) [tag `8JU9`] need to polish also. $p_t(g)$ should be defined in displayed
> formula like $p_t: A \longrightarrow B \qquad g \longmapsto g+...$, so that reader can see its domain and codomain easily.
> $w$ should be defined in a similar way (it uses 'the', but I don't know how it is defined, or just arbitrary map).
> You can also check other parts if similar problems are happening."

（用户写的 $A\to B$ 只是格式示意。按 `8JU9` 的内容，$p_t$ 的定义域是 $B\setminus\Phi$，陪域是 $\Phi$（加上 $((1,1),t)$ 把第一个二次坐标从 1 变成 0），
而且是双射。请按正确的定义域/陪域写，并在报告里说明这一点。）

## 要做的事

1. **`8JU9`**：
   - 用行间公式定义 $p_t$，形如
     ```
     p_t\colon B\setminus\Phi \longrightarrow \Phi,\qquad g\longmapsto g+((1,1),t)
     ```
     （排版可用 `\begin{aligned}` 两列，或 `\colon … \longrightarrow …` 一行 + `\longmapsto` 一行；在约 680px 内放得下；
     与 `8JVP` 里 $\pi$ 的写法统一。）若 $p_t$ 是双射这一事实在后面用到，放在 §2.2 intro 或一句陈述里（不要在定义里写理由）。
   - $w$：明确说它是**任意**函数 $w\colon\Phi\to(0,\infty)$（"For any function … "），记号 $w_\alpha=w(\alpha)$ 交代清楚；
     $a>0$、$t\in A$ 同样明确是任意的。去掉让人以为 $w$ 是某个特定对象的 "the"。在 intro 里一句话说明：
     §2.3 的 \ref{8JVK} 会给出实际用到的权重 $w_{u,j}$，`8JU9` 和 `8JVD` 对任意权重成立。
   - $S$、$M$ 作为什么的函数也写清（例如 $S(t,a,w)$ 对 $t\in A$、$a>0$、$w$ 有定义），$v_+$ 的定义保持。

2. **审查第 2 章和第 3 章所有文本**（chapter/section intro、陈述、证明），找出同类问题并修：
   - **映射/函数**在行内被引入而没有一眼可见的定义域和陪域（例如 $\pi$ 已经写好；检查 $r_p$、$\xi^*$ 或 $\xi\mapsto\xi^*$、$w_g$、$\xi_c$、
     $c_k$、$\beta_\xi$、$\sigma_\xi$、$\ell_\xi$、$F(v)$、$\Theta$、$w_{u,j}$、$P(u,t)$、嵌入 $A\to B$、$v\mapsto((0,0),v)$ 等）。
     重要的映射用行间 `X\colon A\longrightarrow B,\ x\longmapsto …` 格式；只在证明里临时用的小记号可以行内写，但要写出定义域
     （例如 "for $v\in(0,a]$ put $F(v)=\dots$"）。不要把每个记号都变成行间公式——判断标准是：读者能否立刻看出它从哪里到哪里、是不是任意给定的。
   - **"the X" 指代不明**：凡是用定冠词引入、但前文没有定义、读者不知道是特定对象还是任意对象的（例如 "the weights"、"the scale"、
     "the parameters"），改为明确的量词（"for any …"/"let … be arbitrary"）或链接到它的定义。
   - 第 3 章的深层黑箱结果（`8JV2`、`8JU8`、`8JUA` 证明、`8JUB`、`8JUC` 等）中引用外部来源的对象（如 slope、period map）不要求补全定义，
     但若是本书前文已有的对象就链接；只改明显的同类问题，不要重写深层内容。
   - 数学内容不变。

3. 报告里列出：每一处改动（tag、原文片段 → 新文片段，一行一个），以及你查过但认为不需要改的地方和理由。

## 约束

- 只写：`scripts/map-notation-2026-11-25.sql`、`implement_plan/tasks/2026-11-25-map-notation.check.mjs`、
  `implement_plan/tasks/2026-11-25-map-notation.md.report.md`。不改 `src/`、`public/`、`migrations/`、`seed/`，不 commit。
- **绝不运行任何 `--remote` 或 wrangler 写命令**，不碰 `.wrangler/state`。
- SQL 写法照 `scripts/prime-classes-definition-2026-11-25.sql`：write_guard 在所有修改之前并精确检查要改的行（id/tag/section/position/revision）；
  不写 `BEGIN`/`COMMIT`；revision 快照；cache 置 NULL；refs 重建；`needs_rebuild`=1。如需新结果，编号取基准最大值之后的空闲值。
  时间戳 `2026-11-26 00:30:00`，operation_id `map-notation-2026-11-25`，`created_by`/`updated_by`=`'codex'`，proof `generated_by`=`'gpt'`。
- House style：陈述里不放推理；集合构造式一律 `\left\{ … \;\middle|\; … \right\}`；依次引入的多个符号用对齐的行间公式；
  `\ln`；不用 `\tag`；行间公式在约 680px 内；SQL 里 `'` 写成 `''`。
- 顺便修掉 `8JVE` 源码里 `\] Take the parameters` 同一行的问题（`\]` 后换行）。

## 验收

```
node implement_plan/tasks/2026-11-25-map-notation.check.mjs backup-before-map-notation-2026-11-25.sql scripts/map-notation-2026-11-25.sql
npm test
```
检查脚本打印 `ALL CHECKS PASSED`：再次应用被拒且不写；`8JU9` 含 $p_t$ 的 `\colon … \longrightarrow` 行间定义且 $w$ 被明确为任意函数；
第 2、3 章无 `\{…:…\}` 集合构造式；所有 `\ref`/`\hyperref` 目标存在、refs 一致；revision 快照、cache NULL；渲染 0 警告；列出最宽公式宽度。
