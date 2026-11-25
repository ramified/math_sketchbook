# Motivation 环境、"absolutely integrable" 定义、$L'/L$ 记号统一，以及写作约定文件

工作目录：`C:\Users\bbh8149\xiaoxiang_zhou\structured\github\math_sketchbook`。书的内容在 D1（本地库是远程的完整副本，
`.wrangler/state/v3/d1/miniflare-D1DatabaseObject/feb98e23e8d07ed53c02acad60b7af51cee41722a632c769f200a9b7c2d3ca7f.sqlite`）。
DB 脚本模式照 `scripts/ch2-error-exponents-2026-11-25.sql` 和它的检查脚本 `implement_plan/tasks/2026-11-25-ch2-error-exponents.check.mjs`
（write_guard、baseline/新 revision、`*_html_cache = NULL`、refs 重建、tags/aliases、snapshot 用 `JSON.stringify`、SQL 里不写 BEGIN/COMMIT）。

## 硬约束

- **绝不**运行 `--remote`、`wrangler deploy`、`npm run deploy`；不 commit。
- 不改 `.wrangler/state` 里的真实文件；所有 DB 测试在临时副本上做（本地 dev server 现在可能在跑，别碰它）。
- 新编号：result id 从 155 起，tag 从 `8JV3` 起（用前确认 `tags` 表里没有）。时间戳 `2026-11-25 20:00:00`，author/updated_by `'codex'`。

## 任务 0：写作约定文件 `docs/CONVENTIONS.md`（新建）

把 `C:\Users\bbh8149\.claude\projects\C--Users-bbh8149-xiaoxiang-zhou-structured-github-math-sketchbook\memory\math-writing-style.md`
里的规则整理成这个文件（英文或中文均可，按条目，去掉 frontmatter 和会话 id），再加一节 **Notation**，至少包括：

- **对数导数**：一律带参数写全：显示公式里 `\frac{L'(s,\chi)}{L(s,\chi)}`，在 `cases`/`array`/分式嵌套里用 `\dfrac{L'(s,\chi)}{L(s,\chi)}`，
  行内文字里写 `$L'(s,\chi)/L(s,\chi)$`；负号写在外面：`-\frac{L'(s,\chi)}{L(s,\chi)}`。$\zeta$ 同理：`\frac{\zeta'(s)}{\zeta(s)}`。
  特定点同样：`\frac{L'(1,\chi)}{L(1,\chi)}`。**不要**用 `\frac{L'}{L}(s,\chi)` 或 `(L'/L)(1,\chi)`。
  若只指函数本身而无具体参数（如 "the logarithmic derivative $L'/L$"），行内写 `$L'/L$` 可以。
- 对数用 `\ln`；不等号 `\le`（宏映射为斜体）；$\psi$ 表示特征，广义 Chebyshev 函数记 $\Psi_\chi$；家族对象用花体（$G_\chi\to\mathcal G_\psi$，$H_\chi\to\mathcal H_\psi$）。
- 一句说明：每个新任务的规格都要求遵守本文件。

## 任务 1：新增 result 类型 `motivation`

`results.type` 有 CHECK 约束（`migrations/0001_init.sql`），只允许 definition…example。要加 `'motivation'`：

1. 新迁移 `migrations/0003_motivation_type.sql`：重建 `results` 表（SQLite 不能改 CHECK）。要点：
   `PRAGMA defer_foreign_keys = on;`（D1 支持；不要用 `PRAGMA foreign_keys = off`），建 `results_new`（列、默认值、CHECK、外键与现表**完全一致**，
   包括 `0002` 加的 `listed` 列），`INSERT INTO results_new SELECT * FROM results`（列顺序要对），`DROP TABLE results`，
   `ALTER TABLE results_new RENAME TO results`，重建索引 `results_order`。先用 `sqlite3`/`node:sqlite` 读出现有表的真实 `CREATE TABLE` 语句
   （`SELECT sql FROM sqlite_master WHERE name='results'`）作为模板。
2. `src/types.ts` 的类型列表加 `"motivation"`，显示名 "Motivation"（看 types.ts / views 里怎么从类型得到显示名、编号、样式；
   motivation 和 remark 一样编号、可被 `\ref` 引用、有自己的页面）。编辑器里的类型下拉也要有它（如果有）。
   `public/static/style.css` 若按类型着色，给 motivation 一个和 remark 相近的样式。
3. 测试：在 `test/` 里加一个小测试（或扩展现有测试），保证类型列表含 motivation 且显示名正确。`npm test`、`npm run typecheck` 通过。
4. 在**临时副本**上验证迁移：对副本跑迁移 SQL 后，`PRAGMA foreign_key_check` 为空，行数不变，`PRAGMA integrity_check` = ok，
   且能插入 type='motivation' 的行。报告里写清楚以后远程怎么应用（`npx wrangler d1 migrations apply grh-notes --remote`，以及需要
   `npm run deploy` 才能让代码认识新类型；**你不要执行**）。

## 任务 2：§1.2 的动机放进 Motivation 结果（新脚本 `scripts/motivation-and-notation-2026-11-25.sql`，依赖任务 1 的迁移）

现在 §1.2（section id 102，tag `7HE6`）的 `intro_tex` 有一段开头 + 四段 `\textbf{...}`（von Mangoldt / Chebyshev 与 Mellin / Why smooth / main term）。

- 新建一个 **listed** 的 `motivation` 结果（tag `8JV3`，id 155，标题 "From $L'(s,\chi)/L(s,\chi)$ to the smoothed prime sum"，可以更短），
  放在 §1.2 的 position 1，其余结果 position 依次 +1。它的 statement 就是现在 intro 的四段（保留 `\textbf{...}` 小标题），记号按任务 0 统一。
  这样读者可以 `\ref{8JV3}` 引用。没有 proof 行。alias `smoothed-sum-motivation`。
- intro 只留开头那一两句（指向 \ref{8JV3}），或者留空——选前者，一句话即可。
- 在 Motivation 的 "Why smooth" 段，"absolutely integrable" 链接到任务 3 的定义：`\hyperref[8JV4]{absolutely integrable}`。

## 任务 3：定义 "absolutely integrable on a vertical line"

新建 **unlisted** definition（tag `8JV4`，id 156，§1.2 最后一个 position），标题 "Absolutely integrable on a vertical line"：
Let $c\in\R$ and let $F$ be a complex function defined on the line $\Re s=c$. $F$ is \emph{absolutely integrable on $\Re s=c$} if
$\int_{-\infty}^{\infty}|F(c+i\tau)|\,d\tau<\infty$.（措辞可调，不加任何推理。）alias `absolutely-integrable`。

## 任务 4：全书 $L'/L$、$\zeta'/\zeta$ 记号统一（同一个脚本）

主会话已统计（本地库）：
- `\frac{L'}{L}(...)` 出现在：results 8JS6、8JU9、8JUS、8JUU；proofs 101（2 处）、106、128、129；sections 7HE6（5 处，任务 2 会挪走）、8JU4。
- `(L'/L)(...)` 出现在：result 8JUC、proof 117。
- `\frac{\zeta'}{\zeta}` 出现在：results 8JS6、8JTA；proof 101（2 处）；section 7HE6。
- 已经是约定形式的：8JF7、8JS3（`\dfrac{L'(1,\chi)}{L(1,\chi)}`）、proof 124（`\frac{\zeta'(…)}`）。

请自己再扫一遍**全部** results.statement_tex、proofs.body_tex、sections.intro_tex（用正则，注意 `\dfrac`/`\tfrac`、`-\frac`、带空格的写法、
$\zeta$），把所有非约定写法改成任务 0 的约定。**只改记号，不改数学内容和其它文字**。每个改动的行：write_guard（检查当前 revision）、
新 revision 行、cache NULL；refs 不变则不用重建（但检查脚本要验证 refs 仍一致）。
改完后在报告里列出每处改动（行、旧片段 → 新片段）。注意分式变高后显示公式可能变宽：检查不超过约 680px 栏宽（必要时用 `align*` 断行）。

## 验收

- `npm test`、`npm run typecheck` 通过。
- 检查脚本 `implement_plan/tasks/2026-11-25-motivation-and-notation.check.mjs`：在真实本地库的**临时副本**上先跑迁移 0003，再跑
  `scripts/motivation-and-notation-2026-11-25.sql`；二次应用必须被 write_guard 拒绝；所有改动/新增的 intro/statement/proof 跑
  `renderTex` 0 warning；refs 集合一致、目标都在 tags；revisions 与行一致；打印 §1.2 顺序表；全库再扫一遍，非约定的 $L'/L$、$\zeta'/\zeta$
  写法计数为 0；最后打印 `ALL CHECKS PASSED`。
- 报告 `implement_plan/tasks/2026-11-25-motivation-type-and-notation.md.report.md`：改了哪些文件、`git diff --stat`、检查输出、
  Motivation 和新定义的 TeX 原文、记号改动清单、远程应用步骤（迁移 → deploy → 内容脚本的顺序）、偏离之处。
