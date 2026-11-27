-- Insert Chapter 2, From Chebyshev's method to smooth divisibility.
-- Baseline: backup-before-move-auxiliary-data-2026-11-27.sql, then
-- move-auxiliary-data-2026-11-27.sql and refs-sync-2026-11-27.sql.
-- Apply as one atomic batch. In SQLite, wrap the entire file in a transaction.
-- Reference targets were extracted with src/latex.ts renderTex and the stored macros.

INSERT OR ROLLBACK INTO write_guard (ok)
SELECT 0 WHERE
  NOT EXISTS (SELECT 1 FROM sections WHERE id = 100
    AND revision = 1
    AND tag = '7HA2'
    AND position = 1
    AND kind = 'chapter'
    AND parent_id IS NULL
    AND instr(intro_tex, 'We follow \cite{Outline}.') > 0)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id = 103
    AND revision = 3
    AND tag = '7HH9'
    AND position = 3
    AND instr(intro_tex, 'This is the arithmetic input for Chapter~1.') > 0)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id = 111
    AND revision = 3
    AND tag = '8JV5'
    AND position = 3
    AND kind = 'chapter'
    AND parent_id IS NULL
    AND instr(intro_tex, 'used in Chapter 2.') > 0
    AND instr(intro_tex, 'the Chapter 2 theorem') > 0)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id = 105
    AND revision = 4
    AND tag = '8JU2'
    AND position = 2
    AND kind = 'chapter'
    AND parent_id IS NULL
    AND instr(intro_tex, 'Chapter 3 (\ref{8JV5})') > 0)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id = 106
    AND revision = 8
    AND tag = '8JU3'
    AND position = 1
    AND instr(intro_tex, 'In Chapter 2, \ref{8JU7}') > 0)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id = 109
    AND revision = 3
    AND tag = '8JU6'
    AND position = 3
    AND instr(intro_tex, 'Chapter 2 normalization') > 0)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id = 113
    AND revision = 5
    AND tag = '8JV7'
    AND position = 2
    AND instr(intro_tex, '\ref{8JVK} in §2.3') > 0)
  OR NOT EXISTS (SELECT 1 FROM sections WHERE id = 114
    AND revision = 4
    AND tag = '8JV8'
    AND position = 3
    AND instr(intro_tex, 'Chapter 3 supplies') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 110
    AND revision = 3
    AND tag = '8JK2'
    AND position = 1
    AND instr(statement_tex, 'See \ref{8JU2} for the Fourier step.') > 0)
  OR NOT EXISTS (SELECT 1 FROM results WHERE id = 155
    AND revision = 2
    AND tag = '8JV3'
    AND position = 1
    AND instr(statement_tex, 'of Chapter 2.') > 0)
  OR NOT EXISTS (SELECT 1 FROM settings WHERE key = 'bibliography'
    AND revision = 8
    AND value = '\bibitem{Outline} \emph{The Generalized Riemann Hypothesis for Dirichlet $L$-functions: from smoothed prime sums to zeros on the critical line}, AI-generated natural-language outline of the Lean proof, 21 November 2026.
\bibitem{Alpoge} L. Alpöge, \emph{Remark}, \url{https://alpo.ge/remark.pdf}.
\bibitem{Davenport} H. Davenport, \emph{Multiplicative Number Theory}, 3rd ed., Graduate Texts in Mathematics 74, Springer, 2000.
\bibitem{Adriazola} J. Adriazola, \emph{The Alpöge Proof of the Riemann Hypothesis}, Arizona State University, 2026.')
  OR (SELECT COUNT(*) FROM sections WHERE kind = 'chapter') <> 3
  OR NOT EXISTS (SELECT 1 FROM settings WHERE key = 'macros' AND revision = 2)
  OR NOT EXISTS (SELECT 1 FROM settings WHERE key = 'needs_rebuild')
  OR EXISTS (SELECT 1 FROM tags WHERE tag IN ('UTUF', '4M8T', 'WJQV', '8V4M', 'ZEA3', 'CQAP', 'HPW7', 'JMUK', '9DWZ', '6HEC', '9QGA', '3QUC', '9KTS', 'ZFM6', '4Y6Q'))
  OR (SELECT COALESCE(MAX(id), 0) FROM sections) <> 114
  OR (SELECT COALESCE(MAX(CAST(entity_key AS INTEGER)), 0) FROM revisions WHERE entity = 'section') <> 114
  OR (SELECT COALESCE(MAX(id), 0) FROM results) <> 171
  OR (SELECT COALESCE(MAX(CAST(entity_key AS INTEGER)), 0) FROM revisions WHERE entity = 'result') <> 171
  OR (SELECT COALESCE(MAX(id), 0) FROM proofs) <> 139
  OR (SELECT COALESCE(MAX(CAST(entity_key AS INTEGER)), 0) FROM revisions WHERE entity = 'proof') <> 139;

-- Preserve a baseline snapshot where the editor has not recorded it.
INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '100', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "7HA2", "kind": "chapter", "title": "From an interval estimate to GRH", "intro_tex": "The plan: state the theorem, define a positively weighted smoothed prime sum, state a one-sided bound for it on sparse intervals, and show that this bound alone excludes zeros off the critical line. We follow \\cite{Outline}. Terms in the text link to their definitions: click one to expand it in place.", "parent_id": null, "position": 1}', 'claude', '2026-11-27 12:30:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '103', 3, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "7HH9", "kind": "section", "title": "The arithmetic interval estimate", "intro_tex": "This is the arithmetic input for Chapter~1. The Fourier deduction is in \\ref{8JU2}, and the proof outline for its arithmetic input is in \\ref{8JV5}. The deduction in \\ref{7HM3} uses classical properties of Dirichlet $L$-functions.", "parent_id": 100, "position": 3}', 'codex', '2026-11-27 12:30:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '111', 3, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "8JV5", "kind": "chapter", "title": "The arithmetic bound", "intro_tex": "This chapter outlines the proof of the \\hyperref[8JVG]{arithmetic bound} used in Chapter 2. We start from the window and auxiliary data of \\ref{8JU7}, record the error exponents and the cohomological bound on it, then outline how the theta lifts bound the centered counts separately for each subgroup shift $u\\in A_0$, and finally normalize that bound.\n\nThe deep inputs come from the Lean development and the chain-record hypotheses in \\cite[Sections 6.2 and 18]{Adriazola}. A first reading can take the Chapter 2 theorem as a black box and return here to see where its hypotheses and error sizes come from.", "parent_id": null, "position": 3}', 'claude', '2026-11-27 12:30:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '105', 4, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "8JU2", "kind": "chapter", "title": "The Fourier step", "intro_tex": "Chapter 1 reduces the problem to an upper bound for the \\hyperref[8JG8]{weighted prime sum} $\\mathcal G_\\psi$. Here we recover that sum from counts of prime powers sorted by residue class. Fix any \\hyperref[8JH4]{primitive character} $\\psi$ and any real $\\eta>0$ as the margin above the square-root exponent. \\ref{8JU7} gives intervals $[Y,Y^{3/2}]$ with $Y$ arbitrarily large. For every $x$ in a chosen interval we have the arithmetic bound on the \\hyperref[8JVF]{normalized count} $D_\\psi(x)$ and the Fourier comparison:\n\\[\n\\begin{aligned}\nD_\\psi(x)&\\le Cx^{1/2+\\eta},\\\\\n\\mathcal G_\\psi(x)&\\le D_\\psi(x)+O_{\\psi,\\eta}(x^{1/2+\\eta}).\n\\end{aligned}\n\\]\nTogether they give $\\mathcal G_\\psi(x)\\le C''x^{1/2+\\eta}$. The constants are independent of the interval and of $x$ in it. Chapter 3 (\\ref{8JV5}) gives the proof outline for the first inequality.\n\nThis chapter proves the second inequality. We learn two finite-group averages, expand the prime-power count in characters, and specify the data supplied by the arithmetic bound. Finally we apply the two averages to the expansion and track the errors. The only analytic estimates the averaging uses are collected in \\ref{8JVH}.", "parent_id": null, "position": 2}', 'codex', '2026-11-27 12:30:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '106', 8, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "8JU3", "kind": "section", "title": "Error exponents and cohomological lengths", "intro_tex": "In Chapter 2, \\ref{8JU7} chooses the window $[Y,Y^{3/2}]$, the auxiliary primes $q,d$, the groups $A,A_0$ of \\ref{8JVC}, and the shift set $T$ at each scale. The lattice estimates must work at each $x$ in that window. This section records what they need there: the \\hyperref[8JV2]{error exponents} of the theta-lift chain and the \\hyperref[8JU8]{cohomological bound}, which is used in the finite-place divisibility estimate.\n\nThe auxiliary field in Adriazola''s construction has group $B=\\Z/2\\Z\\times\\Z/2\\Z\\times A$ as in \\ref{8JVP}. The two signs are cut out by the quadratic fields associated with $d$ and $q$, and $A$ comes from the fixed conductor and a cyclotomic tower. The subgroup $A_0$ is the kernel of the target character on $A$. The choice of the shift set $T$ in \\ref{8JU7} uses the freedom along the tower to obtain many shifts without too many collisions in short progressions. The estimates for the coset proportions are stated in \\ref{8JU7}. See \\cite[Sections 5.7--5.8 and 18.1]{Adriazola} and \\cite[Sections 3 and 9--11]{Outline}.", "parent_id": 111, "position": 1}', 'claude', '2026-11-27 12:30:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '109', 3, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "8JU6", "kind": "section", "title": "Balancing and normalizing the errors", "intro_tex": "The bound in \\ref{8JUA} holds for each $u\\in A_0$, so it also bounds the average of the centered counts. We divide it by the \\hyperref[8JVF]{Chapter 2 normalization} to prove the arithmetic bound. The two largest terms in the error balance when the number of lifts $m$ is near $\\sqrt x$. \\ref{8JUG} gives the four estimates and \\ref{8JUF} combines them.", "parent_id": 111, "position": 3}', 'codex', '2026-11-27 12:30:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '113', 5, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "8JV7", "kind": "section", "title": "Prime classes and weighted counts", "intro_tex": "The weighted prime-power count in \\ref{8JU9} assigns classes to prime powers and attaches weights to those classes. Three definitions supply the groups, the labels, and the local character values.\n\nThe \\hyperref[8JVC]{residue groups for the averages} give the two averages of \\ref{8JV6} their inputs. The modulus $N_1$ lets $A$ record both the residue modulo $2^{e+2}$ up to sign and the value of $\\psi$. The groups of residues up to sign form the real cyclotomic tower, so increasing $e$ gives room to choose the shift set $T$ for the coset average in \\ref{8JVA}. Requiring $\\psi_{N_1}(v)=1$ in $U_1$ makes the induced character $\\psi_A$ on $A$ independent of the representative of a class. The uniform average in \\ref{8JV9} uses $A_0=\\ker\\psi_A$. Since the image of $\\psi_A$ has order $o$, the cosets indexed by $A/A_0$ are the $o$ character-value classes for the second average.\n\nThe \\hyperref[8JVP]{quadratic coordinates} enlarge $A$ to $B$. The map $\\pi$ sends a unit modulo $N=N_1qd$ to its two quadratic bits followed by its class in $A$. The Chinese remainder theorem lets the bits vary independently of the class in $A$. The bit at $d$ distinguishes the half with $\\xi_c=-1$, which gives the extra divisibility in the arithmetic argument. The complementary half $\\Phi$ labels the weights. The bit at $q$ distinguishes the positions with weights near the reference value in \\ref{8JVK}. For any shift $t\\in A$, the map $p_t$ of \\ref{8JU9} adds $(1,1,t)$. This translation flips the first quadratic bit and gives a bijection from $B\\smallsetminus\\Phi$ to $\\Phi$. Among the characters that survive the subgroup average, those using either quadratic bit are the auxiliary twists. Their smoothed prime sums are small at the target cutoff $x$, as in \\ref{8JVH}.\n\nThe \\hyperref[8JVQ]{prime-power classes and primitive characters} give the inputs to the Fourier expansion in \\ref{8JVD}. Away from $N$, the class of $p^i$ is a single element, and only odd powers of a prime with $\\xi_c(\\vartheta_p)=-1$ enter the count. The \\hyperref[8JVM]{example modulo $840$} computes such a class. At $p\\mid N$, the prime power has no unit class modulo $N$. The coset $i\\vartheta_p+I_p$ uses its residue away from $p$ and shares its mass uniformly across the corresponding classes. The portion outside $\\Phi$ enters the count. For each $\\xi\\in\\widehat B$, the value $\\xi^*(p^i)$ gives the coset average in the Fourier expansion, including when $p\\mid N$.\n\nThe count in \\ref{8JU9} and the Fourier expansion in \\ref{8JVD} allow arbitrary positive weight functions (with $w_\\alpha\\le\\upsilon$ in the Fourier expansion), and \\ref{8JVK} in §2.3 supplies the particular weight functions $w_{u,j}$ used in the normalized count of \\ref{8JVF}.", "parent_id": 105, "position": 2}', 'codex', '2026-11-27 12:30:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '114', 4, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "8JV8", "kind": "section", "title": "The normalized count and its arithmetic bound", "intro_tex": "We now specify the data needed to normalize the counting formula of \\ref{8JU9}. \\ref{8JU7} gives windows $[Y,Y^{3/2}]$ with $Y$ arbitrarily large. The primes $q,d$ are fixed on each window, while the groups and the shift set $T$ from \\ref{8JU7} can depend on the point $x$. At each $x\\ge x_{\\rm wt}$, \\ref{8JVK} gives the scale $\\upsilon_t$ for each $t\\in T$ and a weight function $w_{u,j}$ for each $u\\in A_0$ and each lift $j=1,\\dots,m$ in the theta-lift chain. \\ref{8JVE} collects the data, including the coset proportions of $T$.\n\nFix any point $x$ and any choice of data as in \\ref{8JVE} there. For each $t\\in T$, $1\\le j\\le m$, and $u\\in A_0$, use \\ref{8JU9} to compute the count $S(t,\\upsilon_t,w_{u,j})$ and subtract its main term $\\Re M(\\upsilon_t,w_{u,j})$. Add these differences over all $t$ and $j$ to get $\\Delta_u$. Then average $\\Delta_u$ over $u$, giving each $u$ weight $1/|A_0|$.\n\nA term of weight $w$ has cutoff $\\upsilon_t/w$. This comes from writing $(\\upsilon_t/p^i-w)_+=w((\\upsilon_t/w)/p^i-1)_+$, so the summand vanishes for $p^i\\ge \\upsilon_t/w$. In the positions $\\Phi_u$ of \\ref{8JVK}, $w$ is close to $b=\\exp(x^\\varepsilon)$, where $\\varepsilon>0$ is a small parameter. The number $\\upsilon_t$ is close to $xb$. Thus $\\upsilon_t/w$ is near $x$, and we call these the terms at scale $x$. The comparison in \\ref{8JUD} replaces their weights by $b$ and uses $|\\upsilon_t/b-x|\\le1$ to return to cutoff $x$.\n\nAt every other position, $w\\le2b''$ with $b''=xb/X''$ and $X''=\\exp(x^{\\varepsilon/3})$. Since $\\upsilon_t\\ge (x-1)b$ and $x\\ge3$, the cutoff is at least $(x-1)X''/(2x)\\ge X''/3$. These cutoffs are much larger than $x$ for large $x$. The decay estimate in \\ref{8JVH}(i) bounds their contribution.\n\nThe two kinds of shifts have different jobs. Changing $u\\in A_0$ moves the positions in $\\Phi_u$ along $A_0$. The average over $u$ removes characters that are nontrivial on $A_0$, by \\ref{8JV9}. The shift $t\\in T$ permutes the weight labels as in \\ref{8JU9}. The coset proportions of $T$ give the surviving characters the Chapter 1 weights by \\ref{8JVA} with $k=3$. Each $t$ enters the sum once, so the final division accounts for the factor $h=|T|$.\n\nEach $(t,j)$ has $h_2=|T_2|$ positions at scale $x$. After replacement each supplies weight $b$ and has Fourier coefficient $1/f$ at the trivial character, where $f=2n$ and $n=|A|$. There are $hm$ pairs $(t,j)$, and the average over $u$ preserves this coefficient. With $\\delta_2=h_2/n$ and $Q=hmb$, the total weight at scale $x$ is\n\\[\nhm\\cdot\\frac{bh_2}{f}\n=(hmb)\\frac{h_2}{2n}=\\frac{Q\\delta_2}{2}.\n\\]\nThis is the denominator in the \\hyperref[8JVF]{definition of $D_\\psi(x)$}. The next section derives the common factor for the surviving characters and then applies the coset weights. After division, the weighted sum $\\mathcal G_\\psi(x)$ has coefficient one, with the replacements and the coset discrepancy contributing the errors estimated there. Chapter 3 supplies the one-sided bound on $D_\\psi(x)$.", "parent_id": 105, "position": 3}', 'codex', '2026-11-27 12:30:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '110', 3, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "8JK2", "type": "theorem", "title": "Arithmetic interval estimate", "statement_tex": "For each primitive $\\psi$ there is $\\varepsilon_0>0$ such that for every $0<\\varepsilon<\\varepsilon_0$ and every $Y_0\\ge1$ some $Y\\ge Y_0$ satisfies\n\\[\n\\mathcal G_\\psi(x)\\le x^{1/2+9\\varepsilon}\n\\qquad(Y\\le x\\le Y^{3/2}),\n\\]\nwhere $\\mathcal G_\\psi$ is the \\hyperref[8JG8]{weighted sum}. This is (W) of \\cite{Outline}. See \\ref{8JU2} for the Fourier step.", "section_id": 103, "position": 1, "listed": 1, "aliases": ["interval-estimate"]}', 'codex', '2026-11-27 12:30:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '155', 2, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "8JV3", "type": "motivation", "title": "From $L''(s,\\chi)/L(s,\\chi)$ to the smoothed prime sum", "statement_tex": "\\textbf{The von Mangoldt function.} For $\\Re s>1$, the Euler factor $L_p(s,\\chi)=(1-\\chi(p)p^{-s})^{-1}$ of the \\hyperref[8JC4]{Dirichlet $L$-function} satisfies\n\\begin{align*}\n-\\frac{L_p''(s,\\chi)}{L_p(s,\\chi)}\n  &= \\frac{\\chi(p)\\ln p\\;p^{-s}}{1-\\chi(p)p^{-s}} \\\\\n  &= \\sum_{k\\ge1}\\chi(p^k)\\ln p\\;p^{-ks}.\n\\end{align*}\nThe \\hyperref[8JUR]{von Mangoldt function} assigns weight $\\Lambda(p^k)=\\ln p$ to every $p^k$. Summing over $p$ gives $-L''(s,\\chi)/L(s,\\chi)=\\sum_{n\\ge1}\\chi(n)\\Lambda(n)n^{-s}$ (\\ref{8JUS}). An order-$m$ zero gives a simple pole of residue $-m$, and a principal character gives one of residue $1$ at $s=1$. Thus the coefficients encode the zeros.\n\n\\textbf{The Chebyshev function and its Mellin transform.} The \\hyperref[8JUT]{generalized Chebyshev function} $\\Psi_\\chi(x)=\\sum_{n\\le x}\\chi(n)\\Lambda(n)$ reduces to Chebyshev''s $\\psi(x)$ for $\\chi=\\mathbf 1$. We write $\\Psi_\\chi$ for the classical $\\psi(x,\\chi)$ to reserve $\\psi$ for characters. Its \\hyperref[8JS2]{Mellin transform} is (\\ref{8JUU})\n\\[ \\int_1^\\infty \\Psi_\\chi(x)\\,x^{-s-1}\\,dx = -\\frac1s\\,\\frac{L''(s,\\chi)}{L(s,\\chi)} \\qquad (\\Re s>1). \\]\nThe continuation has poles at the zeros of $L(s,\\chi)$, as used in \\ref{7HM3}.\n\n\\textbf{Why smooth.} $\\Psi_\\chi$ jumps at prime powers, so its transform is not \\hyperref[8JV4]{absolutely integrable} on $\\Re s=c>1$: otherwise Mellin inversion would make $\\Psi_\\chi$ continuous. Integrating once removes the jumps. For $x\\ge1$,\n\\[ R_\\chi(x) = \\sum_{n\\ge1}\\chi(n)\\Lambda(n)\\Bigl(\\frac xn-1\\Bigr)_+ = x\\int_1^x \\Psi_\\chi(t)\\,\\frac{dt}{t^2}, \\]\nsince $\\int_n^x t^{-2}\\,dt=1/n-1/x$ for $n\\le x$. For $\\Re s>1$, reversing the order of integration gives\n\\begin{align*}\n\\int_1^\\infty R_\\chi(x)\\,x^{-s-1}\\,dx\n  &= \\frac{1}{s-1}\\int_1^\\infty \\Psi_\\chi(t)\\,t^{-s-1}\\,dt \\\\\n  &= -\\frac{L''(s,\\chi)}{L(s,\\chi)}\\,\\frac{1}{s(s-1)}.\n\\end{align*}\nThe extra factor $1/(s-1)$ gives $O(|s|^{-2})$ decay on $\\Re s=c>1$ and absolute convergence in Mellin inversion. Shifting left gives summable terms $-m\\,x^\\rho/(\\rho(\\rho-1))$ from order-$m$ nontrivial zeros $\\rho$ (the explicit formula for $\\zeta$ is in \\ref{8JTA}). The same weight appears in the \\hyperref[8JU9]{prime-power count} of Chapter 2.\n\n\\textbf{The main term.} For primitive $\\chi$, the residue of $-(L''(s,\\chi)/L(s,\\chi))\\frac{x^s}{s(s-1)}$ at $s=1$ gives the main term of \\ref{8JS3},\n\\begin{align*}\nM_{\\mathbf 1}(x) &= x\\ln x-(1+\\gamma)x, \\\\\nM_\\chi(x) &= -x\\,\\frac{L''(1,\\chi)}{L(1,\\chi)} \\qquad (\\chi\\ne\\mathbf 1).\n\\end{align*}\nThe first formula uses $-\\zeta''(s)/\\zeta(s)=\\frac1{s-1}-\\gamma+O(s-1)$. The \\hyperref[8JF7]{smoothed prime sum} $G_\\chi=R_\\chi-M_\\chi$ has Mellin transform regular at $s=1$, with poles exactly at the zeros of $L(s,\\chi)$ in $\\Re s>0$ (\\ref{8JN4}).", "section_id": 102, "position": 1, "listed": 1, "aliases": ["smoothed-sum-motivation"]}', 'codex', '2026-11-27 12:30:00');

INSERT OR IGNORE INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('setting', 'bibliography', 8, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"key": "bibliography", "value": "\\bibitem{Outline} \\emph{The Generalized Riemann Hypothesis for Dirichlet $L$-functions: from smoothed prime sums to zeros on the critical line}, AI-generated natural-language outline of the Lean proof, 21 November 2026.\n\\bibitem{Alpoge} L. Alpöge, \\emph{Remark}, \\url{https://alpo.ge/remark.pdf}.\n\\bibitem{Davenport} H. Davenport, \\emph{Multiplicative Number Theory}, 3rd ed., Graduate Texts in Mathematics 74, Springer, 2000.\n\\bibitem{Adriazola} J. Adriazola, \\emph{The Alpöge Proof of the Riemann Hypothesis}, Arizona State University, 2026."}', '(before history)', '2026-11-27 12:30:00');

-- Update the roadmap, renumber the existing prose, and move the two chapters.
UPDATE sections
SET intro_tex = replace(intro_tex,
    'We follow \cite{Outline}.', 'We follow \cite{Outline}. \ref{UTUF} motivates the arithmetic bound through Chebyshev''s comparison of divisibility and size.'),
  intro_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-27 12:30:00',
  updated_by = 'codex'
WHERE id = 100;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '100', 2, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "7HA2", "kind": "chapter", "title": "From an interval estimate to GRH", "intro_tex": "The plan: state the theorem, define a positively weighted smoothed prime sum, state a one-sided bound for it on sparse intervals, and show that this bound alone excludes zeros off the critical line. We follow \\cite{Outline}. \\ref{UTUF} motivates the arithmetic bound through Chebyshev''s comparison of divisibility and size. Terms in the text link to their definitions: click one to expand it in place.", "parent_id": null, "position": 1}', 'codex', '2026-11-27 12:30:00');

UPDATE sections
SET intro_tex = replace(intro_tex,
    'This is the arithmetic input for Chapter~1.', 'This is the arithmetic input for Chapter~1. \ref{UTUF} motivates the comparison behind the estimate.'),
  intro_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-27 12:30:00',
  updated_by = 'codex'
WHERE id = 103;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '103', 4, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "7HH9", "kind": "section", "title": "The arithmetic interval estimate", "intro_tex": "This is the arithmetic input for Chapter~1. \\ref{UTUF} motivates the comparison behind the estimate. The Fourier deduction is in \\ref{8JU2}, and the proof outline for its arithmetic input is in \\ref{8JV5}. The deduction in \\ref{7HM3} uses classical properties of Dirichlet $L$-functions.", "parent_id": 100, "position": 3}', 'codex', '2026-11-27 12:30:00');

UPDATE sections
SET intro_tex = replace(replace(intro_tex,
    'used in Chapter 2.', 'used in Chapter 3.'),
    'the Chapter 2 theorem', 'the Chapter 3 theorem'),
  position = 4,
  intro_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-27 12:30:00',
  updated_by = 'codex'
WHERE id = 111;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '111', 4, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "8JV5", "kind": "chapter", "title": "The arithmetic bound", "intro_tex": "This chapter outlines the proof of the \\hyperref[8JVG]{arithmetic bound} used in Chapter 3. We start from the window and auxiliary data of \\ref{8JU7}, record the error exponents and the cohomological bound on it, then outline how the theta lifts bound the centered counts separately for each subgroup shift $u\\in A_0$, and finally normalize that bound.\n\nThe deep inputs come from the Lean development and the chain-record hypotheses in \\cite[Sections 6.2 and 18]{Adriazola}. A first reading can take the Chapter 3 theorem as a black box and return here to see where its hypotheses and error sizes come from.", "parent_id": null, "position": 4}', 'codex', '2026-11-27 12:30:00');

UPDATE sections
SET intro_tex = replace(intro_tex,
    'Chapter 3 (\ref{8JV5})', 'Chapter 4 (\ref{8JV5})'),
  position = 3,
  intro_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-27 12:30:00',
  updated_by = 'codex'
WHERE id = 105;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '105', 5, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "8JU2", "kind": "chapter", "title": "The Fourier step", "intro_tex": "Chapter 1 reduces the problem to an upper bound for the \\hyperref[8JG8]{weighted prime sum} $\\mathcal G_\\psi$. Here we recover that sum from counts of prime powers sorted by residue class. Fix any \\hyperref[8JH4]{primitive character} $\\psi$ and any real $\\eta>0$ as the margin above the square-root exponent. \\ref{8JU7} gives intervals $[Y,Y^{3/2}]$ with $Y$ arbitrarily large. For every $x$ in a chosen interval we have the arithmetic bound on the \\hyperref[8JVF]{normalized count} $D_\\psi(x)$ and the Fourier comparison:\n\\[\n\\begin{aligned}\nD_\\psi(x)&\\le Cx^{1/2+\\eta},\\\\\n\\mathcal G_\\psi(x)&\\le D_\\psi(x)+O_{\\psi,\\eta}(x^{1/2+\\eta}).\n\\end{aligned}\n\\]\nTogether they give $\\mathcal G_\\psi(x)\\le C''x^{1/2+\\eta}$. The constants are independent of the interval and of $x$ in it. Chapter 4 (\\ref{8JV5}) gives the proof outline for the first inequality.\n\nThis chapter proves the second inequality. We learn two finite-group averages, expand the prime-power count in characters, and specify the data supplied by the arithmetic bound. Finally we apply the two averages to the expansion and track the errors. The only analytic estimates the averaging uses are collected in \\ref{8JVH}.", "parent_id": null, "position": 3}', 'codex', '2026-11-27 12:30:00');

UPDATE sections
SET intro_tex = replace(intro_tex,
    'In Chapter 2, \ref{8JU7}', 'In Chapter 3, \ref{8JU7}'),
  intro_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-27 12:30:00',
  updated_by = 'codex'
WHERE id = 106;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '106', 9, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "8JU3", "kind": "section", "title": "Error exponents and cohomological lengths", "intro_tex": "In Chapter 3, \\ref{8JU7} chooses the window $[Y,Y^{3/2}]$, the auxiliary primes $q,d$, the groups $A,A_0$ of \\ref{8JVC}, and the shift set $T$ at each scale. The lattice estimates must work at each $x$ in that window. This section records what they need there: the \\hyperref[8JV2]{error exponents} of the theta-lift chain and the \\hyperref[8JU8]{cohomological bound}, which is used in the finite-place divisibility estimate.\n\nThe auxiliary field in Adriazola''s construction has group $B=\\Z/2\\Z\\times\\Z/2\\Z\\times A$ as in \\ref{8JVP}. The two signs are cut out by the quadratic fields associated with $d$ and $q$, and $A$ comes from the fixed conductor and a cyclotomic tower. The subgroup $A_0$ is the kernel of the target character on $A$. The choice of the shift set $T$ in \\ref{8JU7} uses the freedom along the tower to obtain many shifts without too many collisions in short progressions. The estimates for the coset proportions are stated in \\ref{8JU7}. See \\cite[Sections 5.7--5.8 and 18.1]{Adriazola} and \\cite[Sections 3 and 9--11]{Outline}.", "parent_id": 111, "position": 1}', 'codex', '2026-11-27 12:30:00');

UPDATE sections
SET intro_tex = replace(intro_tex,
    'Chapter 2 normalization', 'Chapter 3 normalization'),
  intro_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-27 12:30:00',
  updated_by = 'codex'
WHERE id = 109;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '109', 4, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "8JU6", "kind": "section", "title": "Balancing and normalizing the errors", "intro_tex": "The bound in \\ref{8JUA} holds for each $u\\in A_0$, so it also bounds the average of the centered counts. We divide it by the \\hyperref[8JVF]{Chapter 3 normalization} to prove the arithmetic bound. The two largest terms in the error balance when the number of lifts $m$ is near $\\sqrt x$. \\ref{8JUG} gives the four estimates and \\ref{8JUF} combines them.", "parent_id": 111, "position": 3}', 'codex', '2026-11-27 12:30:00');

UPDATE sections
SET intro_tex = replace(intro_tex,
    '\ref{8JVK} in §2.3', '\ref{8JVK} in §3.3'),
  intro_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-27 12:30:00',
  updated_by = 'codex'
WHERE id = 113;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '113', 6, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "8JV7", "kind": "section", "title": "Prime classes and weighted counts", "intro_tex": "The weighted prime-power count in \\ref{8JU9} assigns classes to prime powers and attaches weights to those classes. Three definitions supply the groups, the labels, and the local character values.\n\nThe \\hyperref[8JVC]{residue groups for the averages} give the two averages of \\ref{8JV6} their inputs. The modulus $N_1$ lets $A$ record both the residue modulo $2^{e+2}$ up to sign and the value of $\\psi$. The groups of residues up to sign form the real cyclotomic tower, so increasing $e$ gives room to choose the shift set $T$ for the coset average in \\ref{8JVA}. Requiring $\\psi_{N_1}(v)=1$ in $U_1$ makes the induced character $\\psi_A$ on $A$ independent of the representative of a class. The uniform average in \\ref{8JV9} uses $A_0=\\ker\\psi_A$. Since the image of $\\psi_A$ has order $o$, the cosets indexed by $A/A_0$ are the $o$ character-value classes for the second average.\n\nThe \\hyperref[8JVP]{quadratic coordinates} enlarge $A$ to $B$. The map $\\pi$ sends a unit modulo $N=N_1qd$ to its two quadratic bits followed by its class in $A$. The Chinese remainder theorem lets the bits vary independently of the class in $A$. The bit at $d$ distinguishes the half with $\\xi_c=-1$, which gives the extra divisibility in the arithmetic argument. The complementary half $\\Phi$ labels the weights. The bit at $q$ distinguishes the positions with weights near the reference value in \\ref{8JVK}. For any shift $t\\in A$, the map $p_t$ of \\ref{8JU9} adds $(1,1,t)$. This translation flips the first quadratic bit and gives a bijection from $B\\smallsetminus\\Phi$ to $\\Phi$. Among the characters that survive the subgroup average, those using either quadratic bit are the auxiliary twists. Their smoothed prime sums are small at the target cutoff $x$, as in \\ref{8JVH}.\n\nThe \\hyperref[8JVQ]{prime-power classes and primitive characters} give the inputs to the Fourier expansion in \\ref{8JVD}. Away from $N$, the class of $p^i$ is a single element, and only odd powers of a prime with $\\xi_c(\\vartheta_p)=-1$ enter the count. The \\hyperref[8JVM]{example modulo $840$} computes such a class. At $p\\mid N$, the prime power has no unit class modulo $N$. The coset $i\\vartheta_p+I_p$ uses its residue away from $p$ and shares its mass uniformly across the corresponding classes. The portion outside $\\Phi$ enters the count. For each $\\xi\\in\\widehat B$, the value $\\xi^*(p^i)$ gives the coset average in the Fourier expansion, including when $p\\mid N$.\n\nThe count in \\ref{8JU9} and the Fourier expansion in \\ref{8JVD} allow arbitrary positive weight functions (with $w_\\alpha\\le\\upsilon$ in the Fourier expansion), and \\ref{8JVK} in §3.3 supplies the particular weight functions $w_{u,j}$ used in the normalized count of \\ref{8JVF}.", "parent_id": 105, "position": 2}', 'codex', '2026-11-27 12:30:00');

UPDATE sections
SET intro_tex = replace(intro_tex,
    'Chapter 3 supplies', 'Chapter 4 supplies'),
  intro_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-27 12:30:00',
  updated_by = 'codex'
WHERE id = 114;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '114', 5, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "8JV8", "kind": "section", "title": "The normalized count and its arithmetic bound", "intro_tex": "We now specify the data needed to normalize the counting formula of \\ref{8JU9}. \\ref{8JU7} gives windows $[Y,Y^{3/2}]$ with $Y$ arbitrarily large. The primes $q,d$ are fixed on each window, while the groups and the shift set $T$ from \\ref{8JU7} can depend on the point $x$. At each $x\\ge x_{\\rm wt}$, \\ref{8JVK} gives the scale $\\upsilon_t$ for each $t\\in T$ and a weight function $w_{u,j}$ for each $u\\in A_0$ and each lift $j=1,\\dots,m$ in the theta-lift chain. \\ref{8JVE} collects the data, including the coset proportions of $T$.\n\nFix any point $x$ and any choice of data as in \\ref{8JVE} there. For each $t\\in T$, $1\\le j\\le m$, and $u\\in A_0$, use \\ref{8JU9} to compute the count $S(t,\\upsilon_t,w_{u,j})$ and subtract its main term $\\Re M(\\upsilon_t,w_{u,j})$. Add these differences over all $t$ and $j$ to get $\\Delta_u$. Then average $\\Delta_u$ over $u$, giving each $u$ weight $1/|A_0|$.\n\nA term of weight $w$ has cutoff $\\upsilon_t/w$. This comes from writing $(\\upsilon_t/p^i-w)_+=w((\\upsilon_t/w)/p^i-1)_+$, so the summand vanishes for $p^i\\ge \\upsilon_t/w$. In the positions $\\Phi_u$ of \\ref{8JVK}, $w$ is close to $b=\\exp(x^\\varepsilon)$, where $\\varepsilon>0$ is a small parameter. The number $\\upsilon_t$ is close to $xb$. Thus $\\upsilon_t/w$ is near $x$, and we call these the terms at scale $x$. The comparison in \\ref{8JUD} replaces their weights by $b$ and uses $|\\upsilon_t/b-x|\\le1$ to return to cutoff $x$.\n\nAt every other position, $w\\le2b''$ with $b''=xb/X''$ and $X''=\\exp(x^{\\varepsilon/3})$. Since $\\upsilon_t\\ge (x-1)b$ and $x\\ge3$, the cutoff is at least $(x-1)X''/(2x)\\ge X''/3$. These cutoffs are much larger than $x$ for large $x$. The decay estimate in \\ref{8JVH}(i) bounds their contribution.\n\nThe two kinds of shifts have different jobs. Changing $u\\in A_0$ moves the positions in $\\Phi_u$ along $A_0$. The average over $u$ removes characters that are nontrivial on $A_0$, by \\ref{8JV9}. The shift $t\\in T$ permutes the weight labels as in \\ref{8JU9}. The coset proportions of $T$ give the surviving characters the Chapter 1 weights by \\ref{8JVA} with $k=3$. Each $t$ enters the sum once, so the final division accounts for the factor $h=|T|$.\n\nEach $(t,j)$ has $h_2=|T_2|$ positions at scale $x$. After replacement each supplies weight $b$ and has Fourier coefficient $1/f$ at the trivial character, where $f=2n$ and $n=|A|$. There are $hm$ pairs $(t,j)$, and the average over $u$ preserves this coefficient. With $\\delta_2=h_2/n$ and $Q=hmb$, the total weight at scale $x$ is\n\\[\nhm\\cdot\\frac{bh_2}{f}\n=(hmb)\\frac{h_2}{2n}=\\frac{Q\\delta_2}{2}.\n\\]\nThis is the denominator in the \\hyperref[8JVF]{definition of $D_\\psi(x)$}. The next section derives the common factor for the surviving characters and then applies the coset weights. After division, the weighted sum $\\mathcal G_\\psi(x)$ has coefficient one, with the replacements and the coset discrepancy contributing the errors estimated there. Chapter 4 supplies the one-sided bound on $D_\\psi(x)$.", "parent_id": 105, "position": 3}', 'codex', '2026-11-27 12:30:00');

UPDATE results
SET statement_tex = replace(statement_tex,
    'See \ref{8JU2} for the Fourier step.', 'See \ref{UTUF} for the motivation and \ref{8JU2} for the Fourier step.'),
  statement_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-27 12:30:00',
  updated_by = 'codex'
WHERE id = 110;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '110', 4, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "8JK2", "type": "theorem", "title": "Arithmetic interval estimate", "statement_tex": "For each primitive $\\psi$ there is $\\varepsilon_0>0$ such that for every $0<\\varepsilon<\\varepsilon_0$ and every $Y_0\\ge1$ some $Y\\ge Y_0$ satisfies\n\\[\n\\mathcal G_\\psi(x)\\le x^{1/2+9\\varepsilon}\n\\qquad(Y\\le x\\le Y^{3/2}),\n\\]\nwhere $\\mathcal G_\\psi$ is the \\hyperref[8JG8]{weighted sum}. This is (W) of \\cite{Outline}. See \\ref{UTUF} for the motivation and \\ref{8JU2} for the Fourier step.", "section_id": 103, "position": 1, "listed": 1, "aliases": ["interval-estimate"]}', 'codex', '2026-11-27 12:30:00');

UPDATE results
SET statement_tex = replace(statement_tex,
    'of Chapter 2.', 'of Chapter 3.'),
  statement_html_cache = NULL,
  revision = revision + 1,
  updated_at = '2026-11-27 12:30:00',
  updated_by = 'codex'
WHERE id = 155;

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '155', 3, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "8JV3", "type": "motivation", "title": "From $L''(s,\\chi)/L(s,\\chi)$ to the smoothed prime sum", "statement_tex": "\\textbf{The von Mangoldt function.} For $\\Re s>1$, the Euler factor $L_p(s,\\chi)=(1-\\chi(p)p^{-s})^{-1}$ of the \\hyperref[8JC4]{Dirichlet $L$-function} satisfies\n\\begin{align*}\n-\\frac{L_p''(s,\\chi)}{L_p(s,\\chi)}\n  &= \\frac{\\chi(p)\\ln p\\;p^{-s}}{1-\\chi(p)p^{-s}} \\\\\n  &= \\sum_{k\\ge1}\\chi(p^k)\\ln p\\;p^{-ks}.\n\\end{align*}\nThe \\hyperref[8JUR]{von Mangoldt function} assigns weight $\\Lambda(p^k)=\\ln p$ to every $p^k$. Summing over $p$ gives $-L''(s,\\chi)/L(s,\\chi)=\\sum_{n\\ge1}\\chi(n)\\Lambda(n)n^{-s}$ (\\ref{8JUS}). An order-$m$ zero gives a simple pole of residue $-m$, and a principal character gives one of residue $1$ at $s=1$. Thus the coefficients encode the zeros.\n\n\\textbf{The Chebyshev function and its Mellin transform.} The \\hyperref[8JUT]{generalized Chebyshev function} $\\Psi_\\chi(x)=\\sum_{n\\le x}\\chi(n)\\Lambda(n)$ reduces to Chebyshev''s $\\psi(x)$ for $\\chi=\\mathbf 1$. We write $\\Psi_\\chi$ for the classical $\\psi(x,\\chi)$ to reserve $\\psi$ for characters. Its \\hyperref[8JS2]{Mellin transform} is (\\ref{8JUU})\n\\[ \\int_1^\\infty \\Psi_\\chi(x)\\,x^{-s-1}\\,dx = -\\frac1s\\,\\frac{L''(s,\\chi)}{L(s,\\chi)} \\qquad (\\Re s>1). \\]\nThe continuation has poles at the zeros of $L(s,\\chi)$, as used in \\ref{7HM3}.\n\n\\textbf{Why smooth.} $\\Psi_\\chi$ jumps at prime powers, so its transform is not \\hyperref[8JV4]{absolutely integrable} on $\\Re s=c>1$: otherwise Mellin inversion would make $\\Psi_\\chi$ continuous. Integrating once removes the jumps. For $x\\ge1$,\n\\[ R_\\chi(x) = \\sum_{n\\ge1}\\chi(n)\\Lambda(n)\\Bigl(\\frac xn-1\\Bigr)_+ = x\\int_1^x \\Psi_\\chi(t)\\,\\frac{dt}{t^2}, \\]\nsince $\\int_n^x t^{-2}\\,dt=1/n-1/x$ for $n\\le x$. For $\\Re s>1$, reversing the order of integration gives\n\\begin{align*}\n\\int_1^\\infty R_\\chi(x)\\,x^{-s-1}\\,dx\n  &= \\frac{1}{s-1}\\int_1^\\infty \\Psi_\\chi(t)\\,t^{-s-1}\\,dt \\\\\n  &= -\\frac{L''(s,\\chi)}{L(s,\\chi)}\\,\\frac{1}{s(s-1)}.\n\\end{align*}\nThe extra factor $1/(s-1)$ gives $O(|s|^{-2})$ decay on $\\Re s=c>1$ and absolute convergence in Mellin inversion. Shifting left gives summable terms $-m\\,x^\\rho/(\\rho(\\rho-1))$ from order-$m$ nontrivial zeros $\\rho$ (the explicit formula for $\\zeta$ is in \\ref{8JTA}). The same weight appears in the \\hyperref[8JU9]{prime-power count} of Chapter 3.\n\n\\textbf{The main term.} For primitive $\\chi$, the residue of $-(L''(s,\\chi)/L(s,\\chi))\\frac{x^s}{s(s-1)}$ at $s=1$ gives the main term of \\ref{8JS3},\n\\begin{align*}\nM_{\\mathbf 1}(x) &= x\\ln x-(1+\\gamma)x, \\\\\nM_\\chi(x) &= -x\\,\\frac{L''(1,\\chi)}{L(1,\\chi)} \\qquad (\\chi\\ne\\mathbf 1).\n\\end{align*}\nThe first formula uses $-\\zeta''(s)/\\zeta(s)=\\frac1{s-1}-\\gamma+O(s-1)$. The \\hyperref[8JF7]{smoothed prime sum} $G_\\chi=R_\\chi-M_\\chi$ has Mellin transform regular at $s=1$, with poles exactly at the zeros of $L(s,\\chi)$ in $\\Re s>0$ (\\ref{8JN4}).", "section_id": 102, "position": 1, "listed": 1, "aliases": ["smoothed-sum-motivation"]}', 'codex', '2026-11-27 12:30:00');

UPDATE settings SET value = '\bibitem{Outline} \emph{The Generalized Riemann Hypothesis for Dirichlet $L$-functions: from smoothed prime sums to zeros on the critical line}, AI-generated natural-language outline of the Lean proof, 21 November 2026.
\bibitem{Alpoge} L. Alpöge, \emph{Remark}, \url{https://alpo.ge/remark.pdf}.
\bibitem{Davenport} H. Davenport, \emph{Multiplicative Number Theory}, 3rd ed., Graduate Texts in Mathematics 74, Springer, 2000.
\bibitem{Adriazola} J. Adriazola, \emph{The Alpöge Proof of the Riemann Hypothesis}, Arizona State University, 2026.
\bibitem{Erdos1932} P. Erdős, \emph{Beweis eines Satzes von Tschebyschef}, Acta Sci. Math. (Szeged) 5 (1932), 194–198. \url{https://acta.bibl.u-szeged.hu/13396/}
\bibitem{Honda1968} T. Honda, \emph{Formal groups and zeta-functions}, Osaka J. Math. 5 (1968), 199–213. \url{https://ir.library.osaka-u.ac.jp/repo/ouka/all/8997/}', revision = revision + 1 WHERE key = 'bibliography';

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('setting', 'bibliography', 9, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"key": "bibliography", "value": "\\bibitem{Outline} \\emph{The Generalized Riemann Hypothesis for Dirichlet $L$-functions: from smoothed prime sums to zeros on the critical line}, AI-generated natural-language outline of the Lean proof, 21 November 2026.\n\\bibitem{Alpoge} L. Alpöge, \\emph{Remark}, \\url{https://alpo.ge/remark.pdf}.\n\\bibitem{Davenport} H. Davenport, \\emph{Multiplicative Number Theory}, 3rd ed., Graduate Texts in Mathematics 74, Springer, 2000.\n\\bibitem{Adriazola} J. Adriazola, \\emph{The Alpöge Proof of the Riemann Hypothesis}, Arizona State University, 2026.\n\\bibitem{Erdos1932} P. Erdős, \\emph{Beweis eines Satzes von Tschebyschef}, Acta Sci. Math. (Szeged) 5 (1932), 194–198. \\url{https://acta.bibl.u-szeged.hu/13396/}\n\\bibitem{Honda1968} T. Honda, \\emph{Formal groups and zeta-functions}, Osaka J. Math. 5 (1968), 199–213. \\url{https://ir.library.osaka-u.ac.jp/repo/ouka/all/8997/}"}', 'codex', '2026-11-27 12:30:00');

-- Allocate tags and rows above both the live and historical id maxima.
INSERT INTO tags (tag, kind) VALUES ('UTUF', 'section');
INSERT INTO tags (tag, kind) VALUES ('4M8T', 'section');
INSERT INTO tags (tag, kind) VALUES ('WJQV', 'section');
INSERT INTO tags (tag, kind) VALUES ('8V4M', 'result');
INSERT INTO tags (tag, kind) VALUES ('ZEA3', 'result');
INSERT INTO tags (tag, kind) VALUES ('CQAP', 'result');
INSERT INTO tags (tag, kind) VALUES ('HPW7', 'result');
INSERT INTO tags (tag, kind) VALUES ('JMUK', 'result');
INSERT INTO tags (tag, kind) VALUES ('9DWZ', 'result');
INSERT INTO tags (tag, kind) VALUES ('6HEC', 'result');
INSERT INTO tags (tag, kind) VALUES ('9QGA', 'result');
INSERT INTO tags (tag, kind) VALUES ('3QUC', 'result');
INSERT INTO tags (tag, kind) VALUES ('9KTS', 'result');
INSERT INTO tags (tag, kind) VALUES ('ZFM6', 'result');
INSERT INTO tags (tag, kind) VALUES ('4Y6Q', 'result');

INSERT INTO sections (id, tag, kind, title, intro_tex, parent_id, position, revision, intro_html_cache, created_at, updated_at, updated_by)
VALUES (115, 'UTUF', 'chapter', 'From Chebyshev''s method to smooth divisibility', '\ref{7HA2} reduces GRH to the \hyperref[8JK2]{one-sided interval estimate} for the \hyperref[8JG8]{weighted smoothed prime sum} $\mathcal G_\psi$. The precision to aim for is $x^{1/2+\eta}$ for every real $\eta>0$. Chebyshev''s method gives an upper bound in the required direction. If prime powers divide a nonzero integer, their logarithmic contribution is bounded above by the logarithm of its absolute value.

The factorial calculation explains why the ramp in \ref{8JF7} is natural and where the loss of precision occurs. The lemniscate gives a first example of divisibility governed by smooth exponents. Its defects explain the roles of \ref{8JU2} and \ref{8JV5}.', NULL, 2, 1, NULL, '2026-11-27 12:30:00', '2026-11-27 12:30:00', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '115', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "UTUF", "kind": "chapter", "title": "From Chebyshev''s method to smooth divisibility", "intro_tex": "\\ref{7HA2} reduces GRH to the \\hyperref[8JK2]{one-sided interval estimate} for the \\hyperref[8JG8]{weighted smoothed prime sum} $\\mathcal G_\\psi$. The precision to aim for is $x^{1/2+\\eta}$ for every real $\\eta>0$. Chebyshev''s method gives an upper bound in the required direction. If prime powers divide a nonzero integer, their logarithmic contribution is bounded above by the logarithm of its absolute value.\n\nThe factorial calculation explains why the ramp in \\ref{8JF7} is natural and where the loss of precision occurs. The lemniscate gives a first example of divisibility governed by smooth exponents. Its defects explain the roles of \\ref{8JU2} and \\ref{8JV5}.", "parent_id": null, "position": 2}', 'codex', '2026-11-27 12:30:00');

INSERT INTO sections (id, tag, kind, title, intro_tex, parent_id, position, revision, intro_html_cache, created_at, updated_at, updated_by)
VALUES (116, '4M8T', 'section', 'Chebyshev''s method', 'For a prime $p$, write $v_p$ for the exponent of $p$ in a nonzero rational number, counting exponents in the denominator with a minus sign, and put $v_p(0)=+\infty$. Use $\Lambda$ for the \hyperref[8JUR]{von Mangoldt function} and write $\Psi_{\mathbf 1}(x)=\sum_{r\le x}\Lambda(r)$ for real $x\ge1$. The central binomial coefficient gives a direct example of the comparison used in Erdős''s proof of Bertrand''s postulate \cite{Erdos1932}.', 115, 1, 1, NULL, '2026-11-27 12:30:00', '2026-11-27 12:30:00', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '116', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "4M8T", "kind": "section", "title": "Chebyshev''s method", "intro_tex": "For a prime $p$, write $v_p$ for the exponent of $p$ in a nonzero rational number, counting exponents in the denominator with a minus sign, and put $v_p(0)=+\\infty$. Use $\\Lambda$ for the \\hyperref[8JUR]{von Mangoldt function} and write $\\Psi_{\\mathbf 1}(x)=\\sum_{r\\le x}\\Lambda(r)$ for real $x\\ge1$. The central binomial coefficient gives a direct example of the comparison used in Erdős''s proof of Bertrand''s postulate \\cite{Erdos1932}.", "parent_id": 115, "position": 1}', 'codex', '2026-11-27 12:30:00');

INSERT INTO sections (id, tag, kind, title, intro_tex, parent_id, position, revision, intro_html_cache, created_at, updated_at, updated_by)
VALUES (117, 'WJQV', 'section', 'What a better object must do', 'Suppose that at cutoff $x$ the desired prime-power count is $T(x)$, with main term $M(x)$, and that the divisibility and size are measured on a common scale $B(x)>0$. A lower bound $B(x)T(x)-E_{\rm div}(x)$ for the divisibility and an upper bound $B(x)M(x)+E_{\rm size}(x)$ for the size would give
\[
T(x)-M(x)\le\frac{E_{\rm div}(x)+E_{\rm size}(x)}{B(x)}.
\]
This is the comparison of \ref{8V4M} with three requirements.

\begin{enumerate}
\item[(i)] The divisibility lower bound should have explicit exponents varying smoothly with the prime power, for example $(x/p^h-1)_+$. After summation and division by $B(x)$, the rounding allowance must fit within $O_\eta(x^{1/2+\eta})$.
\item[(ii)] The size upper bound should match the main term of the count through the term linear in $x$. Its normalized error must fit the same budget, which is $O_\eta(x^{-1/2+\eta})$ relative to the linear scale $x$.
\item[(iii)] The counted primes must be all primes or belong to classes whose counts can be combined to give the desired centered sum. For \ref{8JK2} this combination must yield the character weights of $\mathcal G_\psi$ up to errors within the same budget.
\end{enumerate}

The lemniscate sine illustrates the change in the shape of the exponents. The smooth contributions at inert primes $p\equiv3\bmod 4$ involve odd powers $p^h$. The example can be read directly from the derivative recurrence, and the valuation proof explains the role of the height-two logarithm.', 115, 2, 1, NULL, '2026-11-27 12:30:00', '2026-11-27 12:30:00', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('section', '117', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "WJQV", "kind": "section", "title": "What a better object must do", "intro_tex": "Suppose that at cutoff $x$ the desired prime-power count is $T(x)$, with main term $M(x)$, and that the divisibility and size are measured on a common scale $B(x)>0$. A lower bound $B(x)T(x)-E_{\\rm div}(x)$ for the divisibility and an upper bound $B(x)M(x)+E_{\\rm size}(x)$ for the size would give\n\\[\nT(x)-M(x)\\le\\frac{E_{\\rm div}(x)+E_{\\rm size}(x)}{B(x)}.\n\\]\nThis is the comparison of \\ref{8V4M} with three requirements.\n\n\\begin{enumerate}\n\\item[(i)] The divisibility lower bound should have explicit exponents varying smoothly with the prime power, for example $(x/p^h-1)_+$. After summation and division by $B(x)$, the rounding allowance must fit within $O_\\eta(x^{1/2+\\eta})$.\n\\item[(ii)] The size upper bound should match the main term of the count through the term linear in $x$. Its normalized error must fit the same budget, which is $O_\\eta(x^{-1/2+\\eta})$ relative to the linear scale $x$.\n\\item[(iii)] The counted primes must be all primes or belong to classes whose counts can be combined to give the desired centered sum. For \\ref{8JK2} this combination must yield the character weights of $\\mathcal G_\\psi$ up to errors within the same budget.\n\\end{enumerate}\n\nThe lemniscate sine illustrates the change in the shape of the exponents. The smooth contributions at inert primes $p\\equiv3\\bmod 4$ involve odd powers $p^h$. The example can be read directly from the derivative recurrence, and the valuation proof explains the role of the height-two logarithm.", "parent_id": 115, "position": 2}', 'codex', '2026-11-27 12:30:00');

INSERT INTO results (id, tag, type, title, statement_tex, section_id, position, visibility, state, listed, revision, statement_html_cache, created_at, updated_at, updated_by, created_by)
VALUES (172, '8V4M', 'lemma', 'Divisibility versus size', 'Let $N\in\Z\smallsetminus\{0\}$ and let $P$ be a finite set of primes. For each $p\in P$ let $e_p$ be a real number with $0\le e_p\le v_p(N)$. Then
\[
\sum_{p\in P}e_p\ln p\le\ln|N|.
\]', 116, 1, 'published', 'active', 1, 1, NULL, '2026-11-27 12:30:00', '2026-11-27 12:30:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '172', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "8V4M", "type": "lemma", "title": "Divisibility versus size", "statement_tex": "Let $N\\in\\Z\\smallsetminus\\{0\\}$ and let $P$ be a finite set of primes. For each $p\\in P$ let $e_p$ be a real number with $0\\le e_p\\le v_p(N)$. Then\n\\[\n\\sum_{p\\in P}e_p\\ln p\\le\\ln|N|.\n\\]", "section_id": 116, "position": 1, "listed": 1, "aliases": []}', 'codex', '2026-11-27 12:30:00');

INSERT INTO results (id, tag, type, title, statement_tex, section_id, position, visibility, state, listed, revision, statement_html_cache, created_at, updated_at, updated_by, created_by)
VALUES (173, 'ZEA3', 'example', 'Primes between $n$ and $2n$', 'For every integer $n\ge1$,
\[
\sum_{n<p\le2n}\ln p\le2n\ln 2,
\]
where the sum runs over primes.', 116, 2, 'published', 'active', 1, 1, NULL, '2026-11-27 12:30:00', '2026-11-27 12:30:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '173', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "ZEA3", "type": "example", "title": "Primes between $n$ and $2n$", "statement_tex": "For every integer $n\\ge1$,\n\\[\n\\sum_{n<p\\le2n}\\ln p\\le2n\\ln 2,\n\\]\nwhere the sum runs over primes.", "section_id": 116, "position": 2, "listed": 1, "aliases": []}', 'codex', '2026-11-27 12:30:00');

INSERT INTO results (id, tag, type, title, statement_tex, section_id, position, visibility, state, listed, revision, statement_html_cache, created_at, updated_at, updated_by, created_by)
VALUES (174, 'CQAP', 'lemma', 'Legendre''s formula and the factorial identity', 'For every integer $n\ge1$ and every prime $p$,
\[
v_p(n!)=\sum_{h\ge1}\left\lfloor\frac{n}{p^h}\right\rfloor,
\qquad
\ln(n!)=\sum_{r\le n}\Lambda(r)\left\lfloor\frac{n}{r}\right\rfloor.
\]', 116, 3, 'published', 'active', 1, 1, NULL, '2026-11-27 12:30:00', '2026-11-27 12:30:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '174', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "CQAP", "type": "lemma", "title": "Legendre''s formula and the factorial identity", "statement_tex": "For every integer $n\\ge1$ and every prime $p$,\n\\[\nv_p(n!)=\\sum_{h\\ge1}\\left\\lfloor\\frac{n}{p^h}\\right\\rfloor,\n\\qquad\n\\ln(n!)=\\sum_{r\\le n}\\Lambda(r)\\left\\lfloor\\frac{n}{r}\\right\\rfloor.\n\\]", "section_id": 116, "position": 3, "listed": 1, "aliases": []}', 'codex', '2026-11-27 12:30:00');

INSERT INTO results (id, tag, type, title, statement_tex, section_id, position, visibility, state, listed, revision, statement_html_cache, created_at, updated_at, updated_by, created_by)
VALUES (175, 'HPW7', 'lemma', 'Chebyshev bounds', 'For every real $x\ge1$, $\Psi_{\mathbf 1}(x)\le 4x\ln 2$. For every real $x\ge6$,
\[
\Psi_{\mathbf 1}(x)\ge\frac{\ln 2}{3}\,x.
\]', 116, 4, 'published', 'active', 1, 1, NULL, '2026-11-27 12:30:00', '2026-11-27 12:30:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '175', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "HPW7", "type": "lemma", "title": "Chebyshev bounds", "statement_tex": "For every real $x\\ge1$, $\\Psi_{\\mathbf 1}(x)\\le 4x\\ln 2$. For every real $x\\ge6$,\n\\[\n\\Psi_{\\mathbf 1}(x)\\ge\\frac{\\ln 2}{3}\\,x.\n\\]", "section_id": 116, "position": 4, "listed": 1, "aliases": []}', 'codex', '2026-11-27 12:30:00');

INSERT INTO results (id, tag, type, title, statement_tex, section_id, position, visibility, state, listed, revision, statement_html_cache, created_at, updated_at, updated_by, created_by)
VALUES (176, 'JMUK', 'proposition', 'The ramp and the fractional parts', 'For every real $x\ge1$, the ramp sum $R_{\mathbf 1}$ of \ref{8JF7} satisfies
\[
x\sum_{r\le x}\frac{\Lambda(r)}{r}
=R_{\mathbf 1}(x)+\Psi_{\mathbf 1}(x).
\]
For integers $n\ge1$, write $\{y\}=y-\lfloor y\rfloor$ and put $E(n)=\sum_{r\le n}\Lambda(r)\{n/r\}$. Then
\[
R_{\mathbf 1}(n)=\ln(n!)-\Psi_{\mathbf 1}(n)+E(n).
\]
There are absolute constants $c>0$ and $n_0\ge1$ such that
$cn\le E(n)\le4n\ln 2$ for every integer $n\ge n_0$.', 116, 5, 'published', 'active', 1, 1, NULL, '2026-11-27 12:30:00', '2026-11-27 12:30:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '176', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "JMUK", "type": "proposition", "title": "The ramp and the fractional parts", "statement_tex": "For every real $x\\ge1$, the ramp sum $R_{\\mathbf 1}$ of \\ref{8JF7} satisfies\n\\[\nx\\sum_{r\\le x}\\frac{\\Lambda(r)}{r}\n=R_{\\mathbf 1}(x)+\\Psi_{\\mathbf 1}(x).\n\\]\nFor integers $n\\ge1$, write $\\{y\\}=y-\\lfloor y\\rfloor$ and put $E(n)=\\sum_{r\\le n}\\Lambda(r)\\{n/r\\}$. Then\n\\[\nR_{\\mathbf 1}(n)=\\ln(n!)-\\Psi_{\\mathbf 1}(n)+E(n).\n\\]\nThere are absolute constants $c>0$ and $n_0\\ge1$ such that\n$cn\\le E(n)\\le4n\\ln 2$ for every integer $n\\ge n_0$.", "section_id": 116, "position": 5, "listed": 1, "aliases": []}', 'codex', '2026-11-27 12:30:00');

INSERT INTO results (id, tag, type, title, statement_tex, section_id, position, visibility, state, listed, revision, statement_html_cache, created_at, updated_at, updated_by, created_by)
VALUES (177, '9DWZ', 'definition', 'Lemniscate derivatives', 'Let $\operatorname{sl}$ be the local inverse at $0$ of the holomorphic function
\[
\ell(t)=\int_0^t\frac{du}{\sqrt{1-u^4}},
\]
for $t\in\C$ near $0$, where the branch of the square root equals $1$ at $0$. For every integer $n\ge0$, put $A_n=\operatorname{sl}^{(n)}(0)$.', 117, 1, 'published', 'active', 1, 1, NULL, '2026-11-27 12:30:00', '2026-11-27 12:30:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '177', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "9DWZ", "type": "definition", "title": "Lemniscate derivatives", "statement_tex": "Let $\\operatorname{sl}$ be the local inverse at $0$ of the holomorphic function\n\\[\n\\ell(t)=\\int_0^t\\frac{du}{\\sqrt{1-u^4}},\n\\]\nfor $t\\in\\C$ near $0$, where the branch of the square root equals $1$ at $0$. For every integer $n\\ge0$, put $A_n=\\operatorname{sl}^{(n)}(0)$.", "section_id": 117, "position": 1, "listed": 1, "aliases": []}', 'codex', '2026-11-27 12:30:00');

INSERT INTO results (id, tag, type, title, statement_tex, section_id, position, visibility, state, listed, revision, statement_html_cache, created_at, updated_at, updated_by, created_by)
VALUES (178, '6HEC', 'lemma', 'The derivative recurrence', 'The coefficients $A_n$ of \ref{9DWZ} are integers. They satisfy $A_0=0$, $A_1=1$ and, for every integer $m\ge0$,
\[
A_{m+2}=-2\sum_{i+j+k=m}\binom{m}{i,j,k}A_iA_jA_k,
\]
where $i,j,k$ range over nonnegative integers. Also $A_n=0$ unless $n\equiv1\bmod 4$.', 117, 2, 'published', 'active', 1, 1, NULL, '2026-11-27 12:30:00', '2026-11-27 12:30:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '178', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "6HEC", "type": "lemma", "title": "The derivative recurrence", "statement_tex": "The coefficients $A_n$ of \\ref{9DWZ} are integers. They satisfy $A_0=0$, $A_1=1$ and, for every integer $m\\ge0$,\n\\[\nA_{m+2}=-2\\sum_{i+j+k=m}\\binom{m}{i,j,k}A_iA_jA_k,\n\\]\nwhere $i,j,k$ range over nonnegative integers. Also $A_n=0$ unless $n\\equiv1\\bmod 4$.", "section_id": 117, "position": 2, "listed": 1, "aliases": []}', 'codex', '2026-11-27 12:30:00');

INSERT INTO results (id, tag, type, title, statement_tex, section_id, position, visibility, state, listed, revision, statement_html_cache, created_at, updated_at, updated_by, created_by)
VALUES (179, '9QGA', 'lemma', 'Inverting the height-two logarithm', 'For an odd prime $p$, let $q=p^2$, $c_p=p/(q-1)$, and let $g$ be the formal inverse of
\[
\ell_p(X)=\sum_{d\ge0}\frac{(-1)^d X^{q^d}}{p^d}.
\]
For positive integers $n,j$, the coefficient $[z^n]g(z)^j$ vanishes unless $n\ge j$ and $n\equiv j\bmod(q-1)$. In those degrees,
\[
v_p\bigl(n![z^n]g(z)^j\bigr)\ge c_p(n-j)+v_p(j!).
\]', 117, 3, 'published', 'active', 0, 1, NULL, '2026-11-27 12:30:00', '2026-11-27 12:30:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '179', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "9QGA", "type": "lemma", "title": "Inverting the height-two logarithm", "statement_tex": "For an odd prime $p$, let $q=p^2$, $c_p=p/(q-1)$, and let $g$ be the formal inverse of\n\\[\n\\ell_p(X)=\\sum_{d\\ge0}\\frac{(-1)^d X^{q^d}}{p^d}.\n\\]\nFor positive integers $n,j$, the coefficient $[z^n]g(z)^j$ vanishes unless $n\\ge j$ and $n\\equiv j\\bmod(q-1)$. In those degrees,\n\\[\nv_p\\bigl(n![z^n]g(z)^j\\bigr)\\ge c_p(n-j)+v_p(j!).\n\\]", "section_id": 117, "position": 3, "listed": 0, "aliases": []}', 'codex', '2026-11-27 12:30:00');

INSERT INTO results (id, tag, type, title, statement_tex, section_id, position, visibility, state, listed, revision, statement_html_cache, created_at, updated_at, updated_by, created_by)
VALUES (180, '3QUC', 'proposition', 'Divisibility of the lemniscate derivatives', '\begin{enumerate}
\item[(i)] For every prime $p\equiv3\bmod 4$ and integer $n\ge1$,
\[
v_p(A_n)\ge\left\lfloor\frac{np}{p^2-1}\right\rfloor
>n\sum_{\substack{h\ge1\\h\ {\rm odd}}}\frac{1}{p^h}-1.
\]
\item[(ii)] For every prime $p\equiv1\bmod 4$, $v_p(A_p)=0$.
\end{enumerate}', 117, 4, 'published', 'active', 1, 1, NULL, '2026-11-27 12:30:00', '2026-11-27 12:30:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '180', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "3QUC", "type": "proposition", "title": "Divisibility of the lemniscate derivatives", "statement_tex": "\\begin{enumerate}\n\\item[(i)] For every prime $p\\equiv3\\bmod 4$ and integer $n\\ge1$,\n\\[\nv_p(A_n)\\ge\\left\\lfloor\\frac{np}{p^2-1}\\right\\rfloor\n>n\\sum_{\\substack{h\\ge1\\\\h\\ {\\rm odd}}}\\frac{1}{p^h}-1.\n\\]\n\\item[(ii)] For every prime $p\\equiv1\\bmod 4$, $v_p(A_p)=0$.\n\\end{enumerate}", "section_id": 117, "position": 4, "listed": 1, "aliases": []}', 'codex', '2026-11-27 12:30:00');

INSERT INTO results (id, tag, type, title, statement_tex, section_id, position, visibility, state, listed, revision, statement_html_cache, created_at, updated_at, updated_by, created_by)
VALUES (181, '9KTS', 'example', 'A table of lemniscate valuations', 'For inert $p=3,7,11$, each pair gives $v_p(A_n)$ and the lower bound $\lfloor np/(p^2-1)\rfloor$. The split-prime columns give $v_p(A_n)$.
\[
\begin{array}{c|ccc|cc}
n & p=3 & p=7 & p=11 & p=5 & p=13\\ \hline
13  &(4,4)&(1,1)&(2,1)&0&0\\
29  &(10,10)&(4,4)&(2,2)&0&0\\
53  &(19,19)&(7,7)&(4,4)&0&0\\
105 &(39,39)&(15,15)&(9,9)&0&0
\end{array}
\]
The table uses the integer recurrence of \ref{6HEC}, followed by repeated division by each prime.', 117, 5, 'published', 'active', 1, 1, NULL, '2026-11-27 12:30:00', '2026-11-27 12:30:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '181', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "9KTS", "type": "example", "title": "A table of lemniscate valuations", "statement_tex": "For inert $p=3,7,11$, each pair gives $v_p(A_n)$ and the lower bound $\\lfloor np/(p^2-1)\\rfloor$. The split-prime columns give $v_p(A_n)$.\n\\[\n\\begin{array}{c|ccc|cc}\nn & p=3 & p=7 & p=11 & p=5 & p=13\\\\ \\hline\n13  &(4,4)&(1,1)&(2,1)&0&0\\\\\n29  &(10,10)&(4,4)&(2,2)&0&0\\\\\n53  &(19,19)&(7,7)&(4,4)&0&0\\\\\n105 &(39,39)&(15,15)&(9,9)&0&0\n\\end{array}\n\\]\nThe table uses the integer recurrence of \\ref{6HEC}, followed by repeated division by each prime.", "section_id": 117, "position": 5, "listed": 1, "aliases": []}', 'codex', '2026-11-27 12:30:00');

INSERT INTO results (id, tag, type, title, statement_tex, section_id, position, visibility, state, listed, revision, statement_html_cache, created_at, updated_at, updated_by, created_by)
VALUES (182, 'ZFM6', 'proposition', 'Three defects of the integer comparison', 'For integers $n\ge1$ with $n\equiv1\bmod 4$, put
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
\end{enumerate}', 117, 6, 'published', 'active', 1, 1, NULL, '2026-11-27 12:30:00', '2026-11-27 12:30:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '182', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "ZFM6", "type": "proposition", "title": "Three defects of the integer comparison", "statement_tex": "For integers $n\\ge1$ with $n\\equiv1\\bmod 4$, put\n\\[\nB(n)=\\sum_{\\substack{p\\le n\\\\p\\equiv3\\bmod4}}\n          \\left\\lfloor\\frac{np}{p^2-1}\\right\\rfloor\\ln p.\n\\]\nThen $A_n\\ne0$ and $B(n)\\le\\ln|A_n|$. The comparison has three defects.\n\n\\begin{enumerate}\n\\item[(D1)] Removing the floors in $B(n)$ increases the sum by an amount between $c n$ and $C n$ for some absolute $c,C>0$ and all such $n\\ge n_1$, for some absolute $n_1$.\n\\item[(D2)] The guaranteed exponents use only inert primes. On odd prime powers $p^h$, the corresponding selection with weight two is $1-\\chi_4(p^h)$, where $\\chi_4$ is the nontrivial character modulo $4$.\n\\item[(D3)] As $n$ tends to infinity through $n\\equiv1\\bmod4$,\n\\[\nB(n)=\\tfrac12 n\\ln n+O(n),\n\\qquad\n\\ln|A_n|=n\\ln n+O(n).\n\\]\n\\end{enumerate}", "section_id": 117, "position": 6, "listed": 1, "aliases": []}', 'codex', '2026-11-27 12:30:00');

INSERT INTO results (id, tag, type, title, statement_tex, section_id, position, visibility, state, listed, revision, statement_html_cache, created_at, updated_at, updated_by, created_by)
VALUES (183, '4Y6Q', 'remark', 'From the integer to the lattice comparison', 'For $a,w\in\R$ with $a,w>0$, put $x=a/w$. Subtracting the weight and taking the positive part gives
\[
\left(\frac{a}{p^h}-w\right)_+
=w\left(\frac{x}{p^h}-1\right)_+.
\]
The identity follows by factoring out $w>0$. This is the smoothing in \ref{8JU9}, with $a=\upsilon$ there.

For (D2), \ref{8JU2} organizes the prime powers into a table of residue classes as in \ref{8JV7}. The \hyperref[8JV6]{finite-group averages} and the \hyperref[8JU5]{Fourier comparison} there transfer an upper bound for the normalized centered count to $\mathcal G_\psi$.

For (D1) and (D3), \ref{8JV5} outlines the comparison for maps between lattices built from chains of theta lifts. In \ref{8JU4} the slope inequality compares the finite-place divisibility with bounds from norms and lattice sizes. The weights of \ref{8JVK} magnify the prime-power contributions, with the normalized losses tracked in \ref{8JV2}. The size calculation must match the prime-power main term through the linear term, using the cancellation in \ref{8JUC}.

The error analysis in \ref{8JU6} balances a cost $x/m$ from the ends of the chain against a cost $m$ from its steps. At $m$ near $\sqrt{x}$ both have square-root size, as reflected in the parameters of \ref{8JUG}.', 117, 7, 'published', 'active', 1, 1, NULL, '2026-11-27 12:30:00', '2026-11-27 12:30:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('result', '183', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"tag": "4Y6Q", "type": "remark", "title": "From the integer to the lattice comparison", "statement_tex": "For $a,w\\in\\R$ with $a,w>0$, put $x=a/w$. Subtracting the weight and taking the positive part gives\n\\[\n\\left(\\frac{a}{p^h}-w\\right)_+\n=w\\left(\\frac{x}{p^h}-1\\right)_+.\n\\]\nThe identity follows by factoring out $w>0$. This is the smoothing in \\ref{8JU9}, with $a=\\upsilon$ there.\n\nFor (D2), \\ref{8JU2} organizes the prime powers into a table of residue classes as in \\ref{8JV7}. The \\hyperref[8JV6]{finite-group averages} and the \\hyperref[8JU5]{Fourier comparison} there transfer an upper bound for the normalized centered count to $\\mathcal G_\\psi$.\n\nFor (D1) and (D3), \\ref{8JV5} outlines the comparison for maps between lattices built from chains of theta lifts. In \\ref{8JU4} the slope inequality compares the finite-place divisibility with bounds from norms and lattice sizes. The weights of \\ref{8JVK} magnify the prime-power contributions, with the normalized losses tracked in \\ref{8JV2}. The size calculation must match the prime-power main term through the linear term, using the cancellation in \\ref{8JUC}.\n\nThe error analysis in \\ref{8JU6} balances a cost $x/m$ from the ends of the chain against a cost $m$ from its steps. At $m$ near $\\sqrt{x}$ both have square-root size, as reflected in the parameters of \\ref{8JUG}.", "section_id": 117, "position": 7, "listed": 1, "aliases": []}', 'codex', '2026-11-27 12:30:00');

INSERT INTO proofs (id, result_id, position, body_tex, status, generated_by, generator_detail, reviewed_by, review_notes, visibility, revision, body_html_cache, created_at, updated_at, updated_by, created_by)
VALUES (140, 172, 1, 'By unique factorization, $\ln|N|=\sum_p v_p(N)\ln p$. Keep the terms indexed by $P$ and bound each of them below by $e_p\ln p$.', 'ai_generated', 'gpt', 'Codex (GPT-6)', NULL, NULL, 'published', 1, NULL, '2026-11-27 12:30:00', '2026-11-27 12:30:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '140', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"result_id": 172, "body_tex": "By unique factorization, $\\ln|N|=\\sum_p v_p(N)\\ln p$. Keep the terms indexed by $P$ and bound each of them below by $e_p\\ln p$.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex (GPT-6)", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 12:30:00');

INSERT INTO proofs (id, result_id, position, body_tex, status, generated_by, generator_detail, reviewed_by, review_notes, visibility, revision, body_html_cache, created_at, updated_at, updated_by, created_by)
VALUES (141, 173, 1, 'For $n<p\le2n$, the prime $p$ divides $(2n)!$ and is coprime to $n!$, so it divides $\binom{2n}{n}$. Apply \ref{8V4M} with $e_p=1$ and use $\binom{2n}{n}\le\sum_{k=0}^{2n}\binom{2n}{k}=2^{2n}$.', 'ai_generated', 'gpt', 'Codex (GPT-6)', NULL, NULL, 'published', 1, NULL, '2026-11-27 12:30:00', '2026-11-27 12:30:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '141', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"result_id": 173, "body_tex": "For $n<p\\le2n$, the prime $p$ divides $(2n)!$ and is coprime to $n!$, so it divides $\\binom{2n}{n}$. Apply \\ref{8V4M} with $e_p=1$ and use $\\binom{2n}{n}\\le\\sum_{k=0}^{2n}\\binom{2n}{k}=2^{2n}$.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex (GPT-6)", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 12:30:00');

INSERT INTO proofs (id, result_id, position, body_tex, status, generated_by, generator_detail, reviewed_by, review_notes, visibility, revision, body_html_cache, created_at, updated_at, updated_by, created_by)
VALUES (142, 174, 1, 'Each multiple of $p^h$ contributes one to the count at level $h$, so an integer with valuation $j$ contributes at precisely $j$ levels. There are $\lfloor n/p^h\rfloor$ such multiples at level $h$. Multiply by $\ln p$ and sum over $p$, using $\Lambda(p^h)=\ln p$.', 'ai_generated', 'gpt', 'Codex (GPT-6)', NULL, NULL, 'published', 1, NULL, '2026-11-27 12:30:00', '2026-11-27 12:30:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '142', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"result_id": 174, "body_tex": "Each multiple of $p^h$ contributes one to the count at level $h$, so an integer with valuation $j$ contributes at precisely $j$ levels. There are $\\lfloor n/p^h\\rfloor$ such multiples at level $h$. Multiply by $\\ln p$ and sum over $p$, using $\\Lambda(p^h)=\\ln p$.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex (GPT-6)", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 12:30:00');

INSERT INTO proofs (id, result_id, position, body_tex, status, generated_by, generator_detail, reviewed_by, review_notes, visibility, revision, body_html_cache, created_at, updated_at, updated_by, created_by)
VALUES (143, 175, 1, 'By \ref{CQAP}, the coefficient of $\Lambda(r)$ in $\ln\binom{2n}{n}$ is $\lfloor2n/r\rfloor-2\lfloor n/r\rfloor$. It is $0$ or $1$, and it is $1$ for $n<r\le2n$. Thus
\[
\Psi_{\mathbf 1}(2n)-\Psi_{\mathbf 1}(n)
\le \ln\binom{2n}{n}\le \Psi_{\mathbf 1}(2n).
\]
The binomial sum bounds the middle expression above by $2n\ln 2$. Sum the resulting difference bound over consecutive powers of $2$ and use $\Psi_{\mathbf 1}(1)=0$. At the least power of $2$ greater than or equal to $x$, this gives $\Psi_{\mathbf 1}(x)\le 4x\ln 2$ by monotonicity.

The central coefficient is the largest of the $2n+1$ coefficients, as the ratio of consecutive coefficients is $(2n-k)/(k+1)$ at index $k$. Hence $\binom{2n}{n}\ge 2^{2n}/(2n+1)$. For $n\ge3$, $2n+1\le2^n$ by induction, starting at $n=3$. Taking $n=\lfloor x/2\rfloor\ge x/3$ for $x\ge6$ proves the lower bound.', 'ai_generated', 'gpt', 'Codex (GPT-6)', NULL, NULL, 'published', 1, NULL, '2026-11-27 12:30:00', '2026-11-27 12:30:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '143', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"result_id": 175, "body_tex": "By \\ref{CQAP}, the coefficient of $\\Lambda(r)$ in $\\ln\\binom{2n}{n}$ is $\\lfloor2n/r\\rfloor-2\\lfloor n/r\\rfloor$. It is $0$ or $1$, and it is $1$ for $n<r\\le2n$. Thus\n\\[\n\\Psi_{\\mathbf 1}(2n)-\\Psi_{\\mathbf 1}(n)\n\\le \\ln\\binom{2n}{n}\\le \\Psi_{\\mathbf 1}(2n).\n\\]\nThe binomial sum bounds the middle expression above by $2n\\ln 2$. Sum the resulting difference bound over consecutive powers of $2$ and use $\\Psi_{\\mathbf 1}(1)=0$. At the least power of $2$ greater than or equal to $x$, this gives $\\Psi_{\\mathbf 1}(x)\\le 4x\\ln 2$ by monotonicity.\n\nThe central coefficient is the largest of the $2n+1$ coefficients, as the ratio of consecutive coefficients is $(2n-k)/(k+1)$ at index $k$. Hence $\\binom{2n}{n}\\ge 2^{2n}/(2n+1)$. For $n\\ge3$, $2n+1\\le2^n$ by induction, starting at $n=3$. Taking $n=\\lfloor x/2\\rfloor\\ge x/3$ for $x\\ge6$ proves the lower bound.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex (GPT-6)", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 12:30:00');

INSERT INTO proofs (id, result_id, position, body_tex, status, generated_by, generator_detail, reviewed_by, review_notes, visibility, revision, body_html_cache, created_at, updated_at, updated_by, created_by)
VALUES (144, 176, 1, 'For $r\le x$, the summand in $R_{\mathbf 1}(x)$ is $\Lambda(r)(x/r-1)$, and all terms with $r>x$ vanish. Add $\Psi_{\mathbf 1}(x)$ and apply \ref{CQAP} at $x=n$. The upper bound follows from $0\le\{n/r\}<1$ and \ref{HPW7}.

For the lower bound, put $\vartheta_3(t)=\sum_{p\le t,\ p\equiv3\bmod 4}\ln p$. The prime number theorem for the fixed modulus $4$ gives $\vartheta_3(t)=t/2+O(t/(\ln t)^2)$ for $t\ge2$ \cite[Chapter 20]{Davenport}. Consequently $\vartheta_3(2n/3)-\vartheta_3(3n/5)=n/30+O(n/(\ln n)^2)$. Every prime in this interval contributes $\{n/p\}=n/p-1\ge1/2$. For example, one can take $c=1/120$ and choose $n_0$ so that the absolute error in the difference is at most $n/60$ for $n\ge n_0$.

Comparing $\ln(n!)$ with $\int_1^n\ln t\,dt$ gives $\ln(n!)=n\ln n-n+O(\ln(n+1))$. The floor correction is of the same order as the linear term. In $G_{\mathbf 1}(n)$ the term $n\ln n$ cancels, leaving $\gamma n-\Psi_{\mathbf 1}(n)+E(n)+O(\ln(n+1))$. Treating the fractional parts only by their size gives an error of order $n$. The Chebyshev bounds in \ref{HPW7} illustrate this scale, while \ref{8JK2} asks for an upper bound at square-root precision.', 'ai_generated', 'gpt', 'Codex (GPT-6)', NULL, NULL, 'published', 1, NULL, '2026-11-27 12:30:00', '2026-11-27 12:30:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '144', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"result_id": 176, "body_tex": "For $r\\le x$, the summand in $R_{\\mathbf 1}(x)$ is $\\Lambda(r)(x/r-1)$, and all terms with $r>x$ vanish. Add $\\Psi_{\\mathbf 1}(x)$ and apply \\ref{CQAP} at $x=n$. The upper bound follows from $0\\le\\{n/r\\}<1$ and \\ref{HPW7}.\n\nFor the lower bound, put $\\vartheta_3(t)=\\sum_{p\\le t,\\ p\\equiv3\\bmod 4}\\ln p$. The prime number theorem for the fixed modulus $4$ gives $\\vartheta_3(t)=t/2+O(t/(\\ln t)^2)$ for $t\\ge2$ \\cite[Chapter 20]{Davenport}. Consequently $\\vartheta_3(2n/3)-\\vartheta_3(3n/5)=n/30+O(n/(\\ln n)^2)$. Every prime in this interval contributes $\\{n/p\\}=n/p-1\\ge1/2$. For example, one can take $c=1/120$ and choose $n_0$ so that the absolute error in the difference is at most $n/60$ for $n\\ge n_0$.\n\nComparing $\\ln(n!)$ with $\\int_1^n\\ln t\\,dt$ gives $\\ln(n!)=n\\ln n-n+O(\\ln(n+1))$. The floor correction is of the same order as the linear term. In $G_{\\mathbf 1}(n)$ the term $n\\ln n$ cancels, leaving $\\gamma n-\\Psi_{\\mathbf 1}(n)+E(n)+O(\\ln(n+1))$. Treating the fractional parts only by their size gives an error of order $n$. The Chebyshev bounds in \\ref{HPW7} illustrate this scale, while \\ref{8JK2} asks for an upper bound at square-root precision.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex (GPT-6)", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 12:30:00');

INSERT INTO proofs (id, result_id, position, body_tex, status, generated_by, generator_detail, reviewed_by, review_notes, visibility, revision, body_html_cache, created_at, updated_at, updated_by, created_by)
VALUES (145, 178, 1, 'Differentiating $\ell(\operatorname{sl}(z))=z$ gives $(\operatorname{sl}'')^2=1-\operatorname{sl}^4$ and $\operatorname{sl}''(0)=1$. Differentiate once more and divide by $2\operatorname{sl}''$, which is nonzero near $0$, to get $\operatorname{sl}''''=-2\operatorname{sl}^3$. The product rule gives the recurrence and hence integrality by induction. A term in the sum can be nonzero only if each index is $1$ modulo $4$. Their sum is then $3$ modulo $4$, so $m+2$ is $1$ modulo $4$.', 'ai_generated', 'gpt', 'Codex (GPT-6)', NULL, NULL, 'published', 1, NULL, '2026-11-27 12:30:00', '2026-11-27 12:30:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '145', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"result_id": 178, "body_tex": "Differentiating $\\ell(\\operatorname{sl}(z))=z$ gives $(\\operatorname{sl}'')^2=1-\\operatorname{sl}^4$ and $\\operatorname{sl}''(0)=1$. Differentiate once more and divide by $2\\operatorname{sl}''$, which is nonzero near $0$, to get $\\operatorname{sl}''''=-2\\operatorname{sl}^3$. The product rule gives the recurrence and hence integrality by induction. A term in the sum can be nonzero only if each index is $1$ modulo $4$. Their sum is then $3$ modulo $4$, so $m+2$ is $1$ modulo $4$.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex (GPT-6)", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 12:30:00');

INSERT INTO proofs (id, result_id, position, body_tex, status, generated_by, generator_detail, reviewed_by, review_notes, visibility, revision, body_html_cache, created_at, updated_at, updated_by, created_by)
VALUES (146, 179, 1, 'The equation $\ell_p(g(z))=z$ gives $g=z-\sum_{d\ge1}(-1)^d g^{q^d}/p^d$. Induction on degree shows that $g$ is supported in degrees $1$ modulo $q-1$, since each $q^d$ is $1$ modulo $q-1$.

Put $r=p^{c_p}$ and $H(z)=r g(z/r)$. The support condition makes the coefficients of $H$ rational. In its recursion the term $H^{q^d}$ has coefficient $-(-1)^d/p^{D_d}$, where $D_d=d+c_p(q^d-1)$ is an integer. By \ref{CQAP},
\[
v_p((q^d)!)=\frac{q^d-1}{p-1}
=D_d+\frac{q^d-1}{q-1}-d\ge D_d.
\]
For any series $F$ with zero constant term and integral derivatives at $0$, the derivatives of $F^a/a!$ for positive integers $a$ are integral. Its $n$th derivative is a sum over partitions of an $n$-element set into $a$ nonempty blocks, with the product of $F^{(|B|)}(0)$ over blocks $B$. The recursion for $H$ involves integral multiples of $H^{q^d}/(q^d)!$, and the coefficient of degree $n$ in each such power uses only lower degrees of $H$. Induction gives integral derivatives for $H$ and therefore for $H^j/j!$. Now $g(z)^j=r^{-j}H(rz)^j$, which multiplies the coefficient of degree $n$ by $p^{c_p(n-j)}$ in the stated degrees.', 'ai_generated', 'gpt', 'Codex (GPT-6)', NULL, NULL, 'published', 1, NULL, '2026-11-27 12:30:00', '2026-11-27 12:30:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '146', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"result_id": 179, "body_tex": "The equation $\\ell_p(g(z))=z$ gives $g=z-\\sum_{d\\ge1}(-1)^d g^{q^d}/p^d$. Induction on degree shows that $g$ is supported in degrees $1$ modulo $q-1$, since each $q^d$ is $1$ modulo $q-1$.\n\nPut $r=p^{c_p}$ and $H(z)=r g(z/r)$. The support condition makes the coefficients of $H$ rational. In its recursion the term $H^{q^d}$ has coefficient $-(-1)^d/p^{D_d}$, where $D_d=d+c_p(q^d-1)$ is an integer. By \\ref{CQAP},\n\\[\nv_p((q^d)!)=\\frac{q^d-1}{p-1}\n=D_d+\\frac{q^d-1}{q-1}-d\\ge D_d.\n\\]\nFor any series $F$ with zero constant term and integral derivatives at $0$, the derivatives of $F^a/a!$ for positive integers $a$ are integral. Its $n$th derivative is a sum over partitions of an $n$-element set into $a$ nonempty blocks, with the product of $F^{(|B|)}(0)$ over blocks $B$. The recursion for $H$ involves integral multiples of $H^{q^d}/(q^d)!$, and the coefficient of degree $n$ in each such power uses only lower degrees of $H$. Induction gives integral derivatives for $H$ and therefore for $H^j/j!$. Now $g(z)^j=r^{-j}H(rz)^j$, which multiplies the coefficient of degree $n$ by $p^{c_p(n-j)}$ in the stated degrees.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex (GPT-6)", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 12:30:00');

INSERT INTO proofs (id, result_id, position, body_tex, status, generated_by, generator_detail, reviewed_by, review_notes, visibility, revision, body_html_cache, created_at, updated_at, updated_by, created_by)
VALUES (147, 180, 1, '\emph{(i)} Use the elliptic curve $E$ with equation $Y^2=X^3-X$. Its formal group is the power series for addition near the identity in a local parameter. If $u=\operatorname{sl}(z)$, set $X=u^{-2}$ and $Y=-\operatorname{sl}''(z)u^{-3}$. These satisfy the equation and give $dX/(2Y)=dz$. The usual parameter $-X/Y$ is $u/\sqrt{1-u^4}$, an integral change of coordinate at every odd prime. Its inverse is integral by solving for successive coefficients, since its linear coefficient is $1$. Thus $u$ is also an integral parameter, and its formal logarithm, the integral of the invariant differential with zero constant term, is $\ell(u)$ of \ref{9DWZ}.

The curve has good reduction at odd $p$, since $X^3-X$ has three distinct roots there. For $p\equiv3\bmod4$, the terms in the point count at $X$ and $-X$ cancel in the quadratic-character sum: their right sides are negatives and $-1$ is a nonsquare. Thus $\#E(\mathbb F_p)=p+1$ and the local Euler factor is $(1+p^{1-2s})^{-1}$. Apply \cite[Theorem 5 with the prime set $\{p\}$]{Honda1968}. The Dirichlet coefficient at $p^{2d}$ is $(-p)^d$, so Honda''s logarithm is precisely $\ell_p$ of \ref{9QGA}. The theorem gives an integral change of coordinate between the two formal groups over $\Z_{(p)}$, the rationals with denominator prime to $p$. With linear coefficient $1$ this change, from the model to $E$ in parameter $u$, is $U=\operatorname{sl}\circ\ell_p$. Indeed both logarithms are normalized to have linear coefficient $1$. The series $U$ is odd since both factors are odd. This is the height-two model, in which the successive degrees of the logarithm are powers of $p^2$.

Write $\operatorname{sl}(z)=U(g(z))$. Only odd $j\ge1$ occur in $U$, with $p$-integral coefficients. For such $j$, write $j=\sum_{i\ge0}d_i p^i$ in base $p$. Applying \ref{CQAP} gives
\[
(p^2-1)v_p(j!)-pj
=-p d_0-d_1+\sum_{i\ge2}(p^i-p-1)d_i>-(p^2-1).
\]
Equality in the lower bound would require $d_0=d_1=p-1$ and all other digits zero, which would make $j=p^2-1$ even. Thus each derivative term from $U_jg^j$ has valuation greater than $c_p n-1$ by \ref{9QGA}. The sum has the same lower bound. Since $n$ with $A_n\ne0$ is odd, $c_p n$ is nonintegral, so the integer valuation is at least $\lfloor c_p n\rfloor$. Finally $p/(p^2-1)=\sum_{h\ge1,\ h\ {\rm odd}}p^{-h}$ by the geometric series.

\emph{(ii)} The coefficient of $t^{4k+1}$ in $\ell(t)$ is $4^{-k}\binom{2k}{k}/(4k+1)$, by the binomial series. The coefficients of degrees below $p$ are $p$-integral. In degree $p$, $k=(p-1)/4$ gives $2k<p$, so the coefficient has valuation $-1$. Inverting the series degree by degree shows that the coefficient of degree $p$ in $\operatorname{sl}$ is the negative of this coefficient plus a $p$-integral number. Multiplication by $p!$ gives valuation $0$.', 'ai_generated', 'gpt', 'Codex (GPT-6)', NULL, NULL, 'published', 1, NULL, '2026-11-27 12:30:00', '2026-11-27 12:30:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '147', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"result_id": 180, "body_tex": "\\emph{(i)} Use the elliptic curve $E$ with equation $Y^2=X^3-X$. Its formal group is the power series for addition near the identity in a local parameter. If $u=\\operatorname{sl}(z)$, set $X=u^{-2}$ and $Y=-\\operatorname{sl}''(z)u^{-3}$. These satisfy the equation and give $dX/(2Y)=dz$. The usual parameter $-X/Y$ is $u/\\sqrt{1-u^4}$, an integral change of coordinate at every odd prime. Its inverse is integral by solving for successive coefficients, since its linear coefficient is $1$. Thus $u$ is also an integral parameter, and its formal logarithm, the integral of the invariant differential with zero constant term, is $\\ell(u)$ of \\ref{9DWZ}.\n\nThe curve has good reduction at odd $p$, since $X^3-X$ has three distinct roots there. For $p\\equiv3\\bmod4$, the terms in the point count at $X$ and $-X$ cancel in the quadratic-character sum: their right sides are negatives and $-1$ is a nonsquare. Thus $\\#E(\\mathbb F_p)=p+1$ and the local Euler factor is $(1+p^{1-2s})^{-1}$. Apply \\cite[Theorem 5 with the prime set $\\{p\\}$]{Honda1968}. The Dirichlet coefficient at $p^{2d}$ is $(-p)^d$, so Honda''s logarithm is precisely $\\ell_p$ of \\ref{9QGA}. The theorem gives an integral change of coordinate between the two formal groups over $\\Z_{(p)}$, the rationals with denominator prime to $p$. With linear coefficient $1$ this change, from the model to $E$ in parameter $u$, is $U=\\operatorname{sl}\\circ\\ell_p$. Indeed both logarithms are normalized to have linear coefficient $1$. The series $U$ is odd since both factors are odd. This is the height-two model, in which the successive degrees of the logarithm are powers of $p^2$.\n\nWrite $\\operatorname{sl}(z)=U(g(z))$. Only odd $j\\ge1$ occur in $U$, with $p$-integral coefficients. For such $j$, write $j=\\sum_{i\\ge0}d_i p^i$ in base $p$. Applying \\ref{CQAP} gives\n\\[\n(p^2-1)v_p(j!)-pj\n=-p d_0-d_1+\\sum_{i\\ge2}(p^i-p-1)d_i>-(p^2-1).\n\\]\nEquality in the lower bound would require $d_0=d_1=p-1$ and all other digits zero, which would make $j=p^2-1$ even. Thus each derivative term from $U_jg^j$ has valuation greater than $c_p n-1$ by \\ref{9QGA}. The sum has the same lower bound. Since $n$ with $A_n\\ne0$ is odd, $c_p n$ is nonintegral, so the integer valuation is at least $\\lfloor c_p n\\rfloor$. Finally $p/(p^2-1)=\\sum_{h\\ge1,\\ h\\ {\\rm odd}}p^{-h}$ by the geometric series.\n\n\\emph{(ii)} The coefficient of $t^{4k+1}$ in $\\ell(t)$ is $4^{-k}\\binom{2k}{k}/(4k+1)$, by the binomial series. The coefficients of degrees below $p$ are $p$-integral. In degree $p$, $k=(p-1)/4$ gives $2k<p$, so the coefficient has valuation $-1$. Inverting the series degree by degree shows that the coefficient of degree $p$ in $\\operatorname{sl}$ is the negative of this coefficient plus a $p$-integral number. Multiplication by $p!$ gives valuation $0$.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex (GPT-6)", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 12:30:00');

INSERT INTO proofs (id, result_id, position, body_tex, status, generated_by, generator_detail, reviewed_by, review_notes, visibility, revision, body_html_cache, created_at, updated_at, updated_by, created_by)
VALUES (148, 182, 1, '\emph{(D1)} The increase is at most $\sum_{p\le n}\ln p\le4n\ln 2$ by \ref{HPW7}. For $3n/5<p\le2n/3$ and $p\ge3$, $np/(p^2-1)$ lies between $3/2$ and $15/8$. Its fractional part is at least $1/2$. The inert primes in this interval give the same linear lower bound as in the proof of \ref{JMUK}.

\emph{(D2)} For odd $p$, $\chi_4(p)=(-1)^{(p-1)/2}$. The primes $p\equiv3\bmod4$ are inert in $\Z[i]$ and the primes $p\equiv1\bmod4$ split, since $\Z[i]/p\Z[i]\cong\mathbb F_p[X]/(X^2+1)$. By cyclicity of $\mathbb F_p^\times$, $-1$ is a square precisely when $4\mid p-1$. Thus $1-\chi_4(p^h)$ is $2$ exactly for the odd powers at inert primes and $0$ otherwise. The split-prime calculation in \ref{3QUC} illustrates the absence of a corresponding forced exponent there.

\emph{(D3)} Partial summation with $\vartheta_3(t)$ as in \ref{JMUK} gives
$\sum_{p\le n,\ p\equiv3\bmod 4}(\ln p)/p=\tfrac12\ln n+O(1)$, since the integral of the error is bounded by a constant times $\int_2^\infty dt/(t(\ln t)^2)$. The difference $p/(p^2-1)-1/p=1/(p(p^2-1))$ gives a convergent sum against $\ln p$. This proves the formula for $B(n)$ using (D1).

Write the coefficient of $z^{4k+1}$ in $\operatorname{sl}(z)$ as $(-1)^k b_k$. The differential equation in \ref{6HEC} gives
\[
b_0=1,\qquad
b_k=\frac{2}{4k(4k+1)}\sum_{i+j+l=k-1} b_i b_j b_l
\quad(k\ge1).
\]
There are $k(k+1)/2$ ordered triples in this sum. The factor $(k+1)/(4(4k+1))$ is between $1/16$ and $1/10$, so induction gives $16^{-k}\le b_k\le10^{-k}$. In particular $A_n\ne0$ for $n=4k+1$ and $\ln|A_n|=\ln(n!)+O(n)=n\ln n+O(n)$. Now \ref{3QUC} and \ref{8V4M} give $B(n)\le\ln|A_n|$. The size bound has twice the leading coefficient of the guaranteed divisor sum, so the comparison has a gap of order $n\ln n$ before one compares the linear terms.', 'ai_generated', 'gpt', 'Codex (GPT-6)', NULL, NULL, 'published', 1, NULL, '2026-11-27 12:30:00', '2026-11-27 12:30:00', 'codex', 'codex');

INSERT INTO revisions (entity, entity_key, revision, operation_id, snapshot_json, author, created_at)
VALUES ('proof', '148', 1, 'd9127db5-bb29-45da-aaf2-008185cee437', '{"result_id": 182, "body_tex": "\\emph{(D1)} The increase is at most $\\sum_{p\\le n}\\ln p\\le4n\\ln 2$ by \\ref{HPW7}. For $3n/5<p\\le2n/3$ and $p\\ge3$, $np/(p^2-1)$ lies between $3/2$ and $15/8$. Its fractional part is at least $1/2$. The inert primes in this interval give the same linear lower bound as in the proof of \\ref{JMUK}.\n\n\\emph{(D2)} For odd $p$, $\\chi_4(p)=(-1)^{(p-1)/2}$. The primes $p\\equiv3\\bmod4$ are inert in $\\Z[i]$ and the primes $p\\equiv1\\bmod4$ split, since $\\Z[i]/p\\Z[i]\\cong\\mathbb F_p[X]/(X^2+1)$. By cyclicity of $\\mathbb F_p^\\times$, $-1$ is a square precisely when $4\\mid p-1$. Thus $1-\\chi_4(p^h)$ is $2$ exactly for the odd powers at inert primes and $0$ otherwise. The split-prime calculation in \\ref{3QUC} illustrates the absence of a corresponding forced exponent there.\n\n\\emph{(D3)} Partial summation with $\\vartheta_3(t)$ as in \\ref{JMUK} gives\n$\\sum_{p\\le n,\\ p\\equiv3\\bmod 4}(\\ln p)/p=\\tfrac12\\ln n+O(1)$, since the integral of the error is bounded by a constant times $\\int_2^\\infty dt/(t(\\ln t)^2)$. The difference $p/(p^2-1)-1/p=1/(p(p^2-1))$ gives a convergent sum against $\\ln p$. This proves the formula for $B(n)$ using (D1).\n\nWrite the coefficient of $z^{4k+1}$ in $\\operatorname{sl}(z)$ as $(-1)^k b_k$. The differential equation in \\ref{6HEC} gives\n\\[\nb_0=1,\\qquad\nb_k=\\frac{2}{4k(4k+1)}\\sum_{i+j+l=k-1} b_i b_j b_l\n\\quad(k\\ge1).\n\\]\nThere are $k(k+1)/2$ ordered triples in this sum. The factor $(k+1)/(4(4k+1))$ is between $1/16$ and $1/10$, so induction gives $16^{-k}\\le b_k\\le10^{-k}$. In particular $A_n\\ne0$ for $n=4k+1$ and $\\ln|A_n|=\\ln(n!)+O(n)=n\\ln n+O(n)$. Now \\ref{3QUC} and \\ref{8V4M} give $B(n)\\le\\ln|A_n|$. The size bound has twice the leading coefficient of the guaranteed divisor sum, so the comparison has a gap of order $n\\ln n$ before one compares the linear terms.", "status": "ai_generated", "generated_by": "gpt", "generator_detail": "Codex (GPT-6)", "reviewed_by": null, "review_notes": null, "position": 1}', 'codex', '2026-11-27 12:30:00');

-- Sync the statement and proof reference graph with the TeX.
DELETE FROM refs WHERE source_result_id = 110 AND source_proof_id IS NULL;
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (110, NULL, '8JG8');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (110, NULL, 'UTUF');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (110, NULL, '8JU2');
DELETE FROM refs WHERE source_result_id = 155 AND source_proof_id IS NULL;
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (155, NULL, '8JC4');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (155, NULL, '8JUR');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (155, NULL, '8JUS');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (155, NULL, '8JUT');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (155, NULL, '8JS2');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (155, NULL, '8JUU');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (155, NULL, '7HM3');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (155, NULL, '8JV4');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (155, NULL, '8JTA');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (155, NULL, '8JU9');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (155, NULL, '8JS3');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (155, NULL, '8JF7');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (155, NULL, '8JN4');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (176, NULL, '8JF7');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (178, NULL, '9DWZ');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (181, NULL, '6HEC');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (183, NULL, '8JU9');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (183, NULL, '8JU2');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (183, NULL, '8JV7');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (183, NULL, '8JV6');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (183, NULL, '8JU5');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (183, NULL, '8JV5');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (183, NULL, '8JU4');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (183, NULL, '8JVK');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (183, NULL, '8JV2');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (183, NULL, '8JUC');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (183, NULL, '8JU6');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (183, NULL, '8JUG');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (173, 141, '8V4M');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (175, 143, 'CQAP');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (176, 144, 'CQAP');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (176, 144, 'HPW7');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (176, 144, '8JK2');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (179, 146, 'CQAP');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (180, 147, '9DWZ');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (180, 147, '9QGA');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (180, 147, 'CQAP');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (182, 148, 'HPW7');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (182, 148, 'JMUK');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (182, 148, '3QUC');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (182, 148, '6HEC');
INSERT INTO refs (source_result_id, source_proof_id, target_tag) VALUES (182, 148, '8V4M');

UPDATE settings SET value = '1' WHERE key = 'needs_rebuild' AND value <> '1';
