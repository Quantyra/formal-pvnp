# Classical, algebraic and proof-complexity research candidates

S3049 / E014 / E004, 2026-09-11. Literature catalog under INTEGRITY-CLAIMS.md; no new theorem, experiment, originality certification or execution authorization. The 14 entries distinguish established open targets from proposed narrow questions. Every narrow question below has **novelty unknown**: it needs a focused prior-art check and a precise theorem or reproducible diagnostic before becoming a paper claim. None is a promise that a major problem is tractable.

Status was checked against primary author papers, original theorem sources and 2025/2026 research records where available. This is a scoped literature check, not exhaustive certification that no new result exists. Preprints are identified as research reports, not automatically accepted solutions. A polynomial bound always refers to the specified input encoding, machine, uniformity, precision and error model.

## 14 candidate families

### C01. P versus NP: effective structural SAT algorithms

**Open question:** Does every NP language have a deterministic polynomial-time decision algorithm? Equivalently, is general SAT in P? [Cook's official statement](https://www.claymath.org/wp-content/uploads/2022/02/MPPc.pdf) and the current [Clay problem page](https://www.claymath.org/millennium/p-vs-np/) retain the open problem. A correct polynomial SAT algorithm proves equality; a lower bound against one search procedure does not prove inequality.

**Narrow paper question:** For one explicitly defined CNF family, does the proposed height/interface parameter bound the size of a constructible decision representation after every elimination step? State a bound in input bits, include recognition and construction, and seek a counterexample before extending the family. This could produce a structural theorem or an obstruction paper. A short certificate/path, small geometric dimension or compact description alone does not bound search work.

### C02. NP versus coNP: short certificates for impossibility

**Open question:** Does every unsatisfiable CNF have a polynomial-length certificate checkable in deterministic polynomial time? NP=coNP is equivalent to the existence of **some** polynomially bounded Cook-Reckhow propositional proof system. NP!=coNP implies P!=NP; NP=coNP is not known to imply P=NP. [Cook-Reckhow original paper](https://www.cs.toronto.edu/~sacook/homepage/cook_reckhow.pdf); [Cook's explicit correction to Corollary 4.7](https://www.cs.toronto.edu/~sacook/) prevents confusing these two separations.

**Narrow paper question:** Give an independently checkable UNSAT certificate translation for one existing structural solver, and bound the translation's total bit size and checking time. This is useful even without universal short certificates; short proofs also do not automatically imply efficient proof search.

### C03. NP versus P/poly: unrestricted Boolean circuits

**Open question:** Does some NP language require superpolynomial-size Boolean circuits? A positive lower-bound answer implies P!=NP because P is contained in P/poly. The converse is not known: uniform hardness does not itself rule out small nonuniform circuits. Circuit lower bounds for larger classes must retain their class labels.

[Williams's nonuniform ACC lower-bound paper](https://people.csail.mit.edu/rrw/acc-lbs.pdf), Theorem 1.1, proves NEXP is not contained in polynomial-size ACC; it does **not** prove NP is outside P/poly. Its Theorem 1.3 gives an algorithms-to-lower-bounds route with explicit circuit-class closure and running-time hypotheses.

**Narrow paper question:** For a named restricted circuit representation of the local SAT residuals, determine whether an existing restriction/width argument survives one added operation, with an explicit size bound. Do not rename a monotone, bounded-depth or formula result an unrestricted circuit lower bound.

### C04. P versus BPP: removing randomness

**Open question:** Can every bounded-error randomized polynomial-time decision algorithm be simulated deterministically in polynomial time? P=BPP is not known to resolve P versus NP or NP containment in BQP. A randomized classical simulation of a quantum decision procedure normally yields a BPP algorithm, not automatically a P algorithm.

The current frontier includes stronger quantitative derandomization under explicit hypotheses: [Doron-Moshkovitz-Oh-Zuckerman, ECCC 2026/082, revision 1](https://eccc.weizmann.ac.il/report/2026/082/) states the still-open near-optimal generator issue under standard deterministic circuit-hardness assumptions and gives improvements for insensitive algorithms.

**Narrow paper question:** For a fixed restricted verifier/sampler, quantify how flipping a random seed bit changes correctness, and determine whether the cited insensitivity condition actually applies. A finite empirical sensitivity estimate alone would not prove the condition at every length.

### C05. General polynomial identity testing (PIT)

**Open question:** Is identity testing for general succinct arithmetic circuits deterministically polynomial-time under a specified field/integer encoding and degree convention? Random evaluation supplies randomized algorithms in the standard bounded-degree setting; sparse, noncommutative, read-once or restricted-depth results are not a solution for general circuits.

[Kabanets-Impagliazzo](https://www.cs.sfu.ca/~kabanets/Research/poly.html) prove that deterministic polynomial-time PIT for arithmetic circuits over integers entails **either** NEXP not contained in P/poly **or** superpolynomial arithmetic-circuit lower bounds for the permanent. This disjunction is not a direct P!=NP theorem. [Aaronson-van Melkebeek](https://www.theoryofcomputing.org/articles/v007a012/) provide an alternative proof.

**Narrow paper question:** For one precisely bounded tensor/signature family arising in the local holographic contract, can identity tests be reduced to a provably small hitting set? First account for degree, field size, coefficient bit growth and whether an explicit coefficient expansion is exponential.

### C06. VP versus VNP over a specified field

**Open question:** Do polynomial-degree VNP polynomial families all have polynomial-size arithmetic circuits? Fix the field and allowed constants; permanent completeness statements require their characteristic assumptions (the usual permanent route uses characteristic different from two). This is an algebraic analog, not a synonym or unconditional equivalence for Boolean P versus NP.

The [2025 Bhargav-Dwivedi-Saxena factoring primer](https://arxiv.org/abs/2506.19604) distinguishes VP, VNP, their related circuit models and remaining closure questions. Restrictions matter: the [2026 min-plus semiring paper](https://arxiv.org/abs/2605.09551) proves results for explicitly defined semiring models, not the field-based VP/VNP separation.

**Narrow paper question:** Choose one algebraic branching-program or low-depth representation from the SAT encoding and prove a model-specific size blowup under its required equality/copy operation. Consult the exact model's existing lower bounds before claiming a new obstruction.

### C07. P versus PSPACE: time required by compact state spaces

**Open question:** Is every polynomial-space computation decidable in polynomial time? P=PSPACE would imply P=NP. P!=PSPACE alone does not decide whether P=NP because NP may occupy either position within that gap.

[Williams, ECCC 2025/017](https://eccc.weizmann.ac.il/report/2025/017/) proves a time-t computation can be simulated in O(sqrt(t log t)) space and derives explicit linear-space problems requiring n^(2-epsilon) time for every positive epsilon in the stated multitape model. This is a genuine quantitative advance, not a P/PSPACE separation.

**Narrow paper question:** For an explicit compact configuration graph, compare representation size, path length and space needed to evaluate a proposed height function. A formally checked tradeoff or a counterexample to the alleged polynomial-height guarantee is a bounded project; showing one traversal is slow does not exclude another algorithm.

### C08. L versus NL: directed reachability

**Open question:** Can directed s-t reachability be decided with deterministic logarithmic workspace? It is NL-complete. Both L and NL lie within P, so resolving their equality is not itself a P/NP resolution. [Reingold](https://omereingold.wordpress.com/wp-content/uploads/2014/10/sl.pdf) solved **undirected** connectivity in logarithmic space; this is an established boundary, not the open directed problem. [Reingold-Trevisan-Vadhan's restricted directed result](https://salil.seas.harvard.edu/publications/s-t-connectivity-digraphs-known-stationary-distribution) needs a supplied suitable stationary distribution and polynomial mixing.

**Narrow paper question:** Does a specified graph family induced by the height construction satisfy those distribution/mixing hypotheses, with logarithmic-space access to the promised data? Prove the promise or exhibit its failure; do not give an exponentially large configuration graph for free. No recently checked primary result resolving general directed reachability was found.

### C09. Exponential Time Hypothesis (ETH)

**Open hypothesis:** 3-SAT on n variables has no deterministic 2^o(n) poly(input length)-time algorithm. ETH is stronger than P!=NP; refuting ETH with a subexponential but superpolynomial algorithm would not establish P=NP. Randomized variants require a separate label.

[Impagliazzo-Paturi-Zane](https://www.ccs.neu.edu/home/viola/classes/papers/ImpagliazzoPaturiZane01Which.pdf) develop reductions preserving subexponential complexity. The sparse-instance and parameter bookkeeping is part of the statement, not incidental notation.

**Narrow paper question:** Audit whether one structural SAT representation has a subexponential number of states after charging its construction. A parameter-preserving reduction or explicit lower-bound transfer conditional on ETH can be publishable without proving ETH. Polynomial-time reductions with large variable blowup may be useless for this purpose.

### C10. Strong ETH (SETH)

**Open hypothesis:** For every epsilon>0, some fixed clause width k admits no deterministic O((2-epsilon)^n poly(input length)) algorithm for k-SAT. Fixed-width improvements are compatible with SETH; the quantifier over k is essential. SETH implies ETH, hence P!=NP; falsifying it need not falsify ETH or prove P=NP.

The [IPZ primary paper](https://www.ccs.neu.edu/home/viola/classes/papers/ImpagliazzoPaturiZane01Which.pdf) and the [June 2026 revision of Durr et al.](https://arxiv.org/abs/2507.11098v2) supply foundational and recent conditional context. Classical SETH is not automatically a conjecture about quantum running time.

**Narrow paper question:** For one algorithmic shortcut, calculate its actual exponent as a function of clause width, preprocessing and branching overhead. This can expose whether the suggested gain is merely a constant-width phenomenon; finite n=16 data cannot settle that asymptotic question.

### C11. Orthogonal Vectors and fine-grained reductions

**Open conjectural boundary:** In the usual moderate-dimension formulation, for every epsilon>0 there is c such that two sets of N Boolean vectors of dimension c log N cannot be tested for an orthogonal pair in O(N^(2-epsilon)) time. State deterministic/randomized and machine conventions explicitly. SETH implies the corresponding OV barrier; breaking an OV bound does not by itself prove P=NP. OV is already a polynomial-time problem.

[Durr-Kipouridis-Lampis-Wegrzycki, ICALP 2026 version](https://arxiv.org/abs/2507.11098v2) improves low-dimensional algorithms while retaining SETH-based boundaries. Thus low-dimension improvements must not be advertised as refutations of all OV conjectures.

**Narrow paper question:** Track dimension and representation size in a reduction from a concrete SAT residual-intersection problem to OV. Identify the exact parameter regime where a known low-dimensional algorithm changes the total bound. This is a more discriminating question than calling every pairwise-compatibility step quadratic-hard.

### C12. Worst-case to average-case hardness and one-way functions

**Open questions:** Do classical one-way functions exist, and can they be based on an appropriate worst-case NP hardness assumption? OWF existence implies P!=NP; the reverse is not known. Average-case hardness requires an explicit efficiently samplable distribution, error criterion and length quantifiers. It is not the observation that a random-SAT benchmark has a difficult tail.

[Liu-Pass, On One-way Functions from NP-Complete Problems](https://eccc.weizmann.ac.il/report/2021/059/) give a particular conditional time-bounded Kolmogorov-complexity characterization. [Chatterjee-Li-Vasudevan, ECCC 2026/028](https://eccc.weizmann.ac.il/report/2026/028/) derive OWFs from worst-case NP hardness **plus specified weak zero-knowledge assumptions**. Neither result removes all additional conditions to establish OWFs from P!=NP alone.

**Narrow paper question:** For an already frozen solver distribution, prove which summary statistics bound its expected restart cost and which fail under rare hard instances or SAT filtering. This is a distributional algorithm-analysis project, not a cryptographic hardness construction. The existing QAOA tail audit supplies a concrete starting example.

### C13. Frege, Extended Frege and restricted proof-system lower bounds

**Open target:** Exhibit an explicit tautology family with superpolynomial proof-size lower bounds for unrestricted Frege or Extended Frege. A lower bound for one fixed proof system does not rule out every polynomially bounded Cook-Reckhow system and therefore does not alone prove NP!=coNP or P!=NP.

Recent primary context: [ECCC 2025/098](https://eccc.weizmann.ac.il/report/2025/098/download/) distinguishes restricted algebraic proof systems and open general Frege lower bounds; [ECCC 2026/055](https://eccc.weizmann.ac.il/report/2026/055/download/) studies formalizing bounded-depth Frege lower bounds. [Pich-Santhanam's conditional EF-to-P!=NP result](https://arxiv.org/abs/2312.08163) has extra hypotheses that must not be dropped.

**Narrow paper question:** Select one existing resolution/Tseitin or bounded-depth proof family and verify a quantitative translation, width-size estimate or import-free lemma under the exact encoding. This matches the repository's strengths. A Lean wrapper around an imported lower bound is useful evidence packaging, not a new proof of that lower bound; unrestricted EF is not an incremental consequence of a bounded-depth result.

### C14. MCSP and meta-complexity

**Open question:** Is standard Minimum Circuit Size Problem NP-hard under a specified conventional reduction, hence NP-complete? Input is a full Boolean truth table plus a size threshold; the truth-table length is 2^n, not n. Circuit certificates give NP membership. The [2025 revision of ECCC 2023/046](https://eccc.weizmann.ac.il/report/2023/046/) explicitly retains the standard NP-completeness question. Partial, gap, implicit, oracle and randomized-reduction variants must be separately named.

Even proving NP-completeness would not separate P from NP; finding a polynomial-time algorithm as well would imply equality. Conditional hardness magnification theorems have exact weak-bound, gap and model hypotheses. [Austrin-Risse](https://arxiv.org/abs/2311.12994) prove strong limitations on Sum-of-Squares proofs of circuit lower bounds, not a general MCSP or NP lower bound.

**Narrow paper question:** Audit one magnification implication already represented in this repository, with exact input length, gap, reduction type and target circuit model. A substantive project needs a new verified premise or translation result; restating an implication as a named axiom does not discharge it.

## Established methodological barriers, not additional open conjectures

- **Relativization:** [Baker-Gill-Solovay](https://doi.org/10.1137/0204037) construct oracle worlds with P=NP and with P!=NP. Therefore an argument valid uniformly relative to every oracle cannot settle the unrelativized question by itself. This does not prove independence from ZFC or ban every use of diagonalization.
- **Natural proofs:** [Razborov-Rudich](https://www.sciencedirect.com/science/article/pii/S002200009791494X) give a conditional obstacle to circuit lower bounds from properties satisfying their constructivity, largeness and usefulness conditions, under sufficiently strong pseudorandomness assumptions. It is not an unconditional ban on combinatorics, geometry or all lower-bound arguments.
- **Algebrization:** [Aaronson-Wigderson](https://www.scottaaronson.com/papers/alg.pdf) formalize a barrier involving access to low-degree oracle extensions. Merely introducing polynomials does not evade it. [Chen-Hu-Ren's 2025 research report](https://arxiv.org/abs/2511.14038) develops further barriers in specifically stated models; it is not a theorem that every algebraic approach fails.

A useful methods paper must show which precise hypotheses a concrete technique satisfies or violates. The words 'geometric', 'quantum', 'nonlocal' or 'nonconstructive' do not establish that a barrier has been overcome.

## Solved neighbors and local research disposition

Do not relist NEXP versus ACC as wholly open: the separation above is established. Do not list primality testing as an open P-membership problem: [Agrawal-Kayal-Saxena](https://cse.iitk.ac.in/users/manindra/algebra/primality_original.pdf) give a deterministic polynomial algorithm. Factoring is a distinct problem. Do not describe graph isomorphism as lacking subexponential progress: [Babai](https://arxiv.org/abs/1512.03547) gives a quasipolynomial algorithm; that is not a polynomial-time theorem or evidence that GI is NP-complete.

The [classical consolidation](2026-09-08-consolidation-classical-audit.md) found established Horn/closure/decomposition mechanisms and counterexamples to particular generalization contracts. It did not identify a new uniformly polynomial general-SAT operation. The [holographic contract](2026-09-09-holographic-sat-contract.md) rejects a particular common matchgate basis for OR3 plus equality, not every possible holographic algorithm. The [Hodge transfer audit](2026-09-09-ns-hodge-transfer-audit.md) holds the proposed transfer for a missing effective bridge; geometric existence is not a bit-complexity bound.

The [fixed QAOA batch](2026-09-11-qaoa-fixed-batch-cost-screen.md) provides actual bounded independent data and conditional preparation-cost thresholds, not a P/NP result. Its immediate next question is logical block cost on the same formulas. The best classical complements are C01's precise structural obstruction, C12's distributional cost analysis, and C13's restricted proof-system result. Major class separations remain long-term context; cataloging them does not make all 14 into active research campaigns.
