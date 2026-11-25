# Writing conventions for the GRH notes

Every new task spec must require following this file.

## Definitions and statements

- State definitions and claims directly. Put explanations, motivation, and proofs in their own results. If a definition needs a claim such as convergence or well-definedness, state it briefly and link the relevant words to an unlisted lemma with `\hyperref[TAG]{converges absolutely}`.
- Define notions before using them. For instance, give the Mellin transform its own definition before the first lemma that uses it. Link auxiliary notions such as absolute integrability to an unlisted definition where they are used.
- Give each claim its own proof. Split independent claims into separate results or into parts (i), (ii), etc., with a corresponding proof paragraph for each part. Group a claim and its immediate consequence in the same part.
- Identify the type of each quantified variable. State quantifiers before the display with their dependencies visible. For example, write that there is a real $\sigma_0$ such that for every $\sigma\ge\sigma_0$ there are $C>0$ and an infinite set $K$ with the displayed property for every $k\in K$ and $\tau\in\mathbb R$.
- Leave evident continuity, measurability, and local integrability implicit.
- Give citable motivation its own listed Motivation result. Link illustrative examples from the results they illustrate and make those examples unlisted. When an example advances the section's main computation, it can be listed.
- Order a section around its computation. Give the general definition, apply it to the objects under study, define the notation needed to read off the answer, and state the result for each object in corresponding parts. Keep unrelated definitions separate. Link an unlisted technical lemma at the exact step that uses it.

## Proofs, estimates, and figures

- Keep short proofs focused on the estimate or identity that does the work and the resulting formula. Omit routine bookkeeping and closing sentences that merely restate the claim. Lemma `8JS3` is a model.
- Begin each numbered proof part in a new paragraph with `\emph{(i)}`, `\emph{(ii)}`, etc., corresponding to the statement's `\item[(i)]`, `\item[(ii)]`, etc. The site's part picker uses those labels.
- Open a long proof with an Idea paragraph, followed by short named steps. Use `\emph{(1)} \textbf{One sentence giving the idea of the step.}` followed by the details. Explain where each key hypothesis is used.
- Keep each step on the main line of the argument. Link routine computations or bounds to unlisted lemmas from the words naming the operation they justify, such as differentiating under the integral. When iterating an operation, show the first few cases before the general formula.
- State qualitative parameter conditions in general results and explain what they accomplish. Use explicit quantifiers for existence and dependence. Keep technical numerical estimates in unlisted lemmas and retain numerical constants in the main argument only when the statement forces them.
- Write multistep estimates as aligned chains in `alignat*{2}` or `align*`, with brief justifications in a right column. If a proof uses several estimates, finish with a chain that combines them. For a delicate estimate, define all objects first and explain their choice. Give the estimate in a single `alignat*{2}` chain with (a), (b), etc. in a right column, then give one phrase per label with links to unlisted lemmas for longer justifications. Use a right column for these labels and keep displays within the roughly 680 px text column.
- Put explanatory figures in the proof immediately after introducing the objects they depict. Use one SVG per panel, with each panel's function named in the text and in a centered TeX title above the SVG. Use inline fractions in panel titles so they wrap naturally. Proof `8JT2` and its linked lemmas `8JT3` and `8JT4` are models.
- Before saving an edited statement or definition, check for phrases such as “since,” “because,” and “by Lemma,” and for parenthetical explanations. Put any justifications in proofs or linked unlisted lemmas.

## Notation

- Write the logarithmic derivative with its argument on both terms. Use `\frac{L'(s,\chi)}{L(s,\chi)}` in displays and `\dfrac{L'(s,\chi)}{L(s,\chi)}` inside cases, arrays, or nested fractions. Use `$L'(s,\chi)/L(s,\chi)$` inline. Put a leading minus outside the quotient, as in `-\frac{L'(s,\chi)}{L(s,\chi)}`. Apply the same rules to `\frac{\zeta'(s)}{\zeta(s)}` and at specific points such as `\frac{L'(1,\chi)}{L(1,\chi)}`. Avoid `\frac{L'}{L}(s,\chi)` and `(L'/L)(1,\chi)`. The inline shorthand `$L'/L$` is allowed when referring to the function itself without evaluating it.
- Use `\ln` for logarithms and `\le` for the slanted inequality. The shared macros map `\le`, `\leq`, `\ge`, and `\geq` to their slanted forms.
- Reserve $\psi$ for characters and write $\Psi_\chi$ for the generalized Chebyshev function. Use calligraphic letters for family-level objects, pairing $G_\chi$ with $\mathcal G_\psi$ and $H_\chi=\mathcal M G_\chi$ with $\mathcal H_\psi=\mathcal M\mathcal G_\psi$.
- Prefer `align*` for multiline displays and case splits, with conditions in a right column introduced by `&&`.
