# S3096 resolution search: no surviving mechanism selected

2026-09-12. Local research assessment; publication HOLD. The target remains deterministic resolution automatization in time polynomial in input length plus shortest resolution refutation length. No successful mechanism, complexity improvement, or P-versus-NP result was obtained.

Selection: **NONE**. The considered candidate was exact symbolic compilation of clauses admitting short derivations, followed by empty-clause lookup and certificate extraction. This is not certified as a distinct idea: symbolic clause-family resolution is established, and the proposed proof-budget modification does not supply the missing representation or construction bound. No BDD benchmark, solver implementation, or formal proof was run. The first test below is analytic and rejects an eager representation hypothesis; it does not reject demand-directed search.

## Source veto before implementation

[Pan and Vardi, *Symbolic Decision Procedures for QBF*](https://cs.rice.edu/~vardi/papers/cp042.pdf), especially sections 2.1 and 3, already describes clause sets represented by literal-index ZDDs and symbolic multi-resolution. Merely using decision diagrams to share clauses is therefore an existing architecture, not a new search mechanism.

[Bova and Slivovsky, *On Compiling Structured CNFs to OBDDs*](https://pmc.ncbi.nlm.nih.gov/articles/PMC6979531/), Theorem 19, supplies bounded-degree expander graph CNFs with exponential OBDD size for every variable order. This theorem concerns the characteristic function of satisfying assignments. It must not be silently transferred to every resolution frontier or to an algorithm that never constructs that function. The precise transfer used in the bounded test below is explicit.

The accompanying source review records the exact automatization implication and the established size/width and length/space boundaries. This assessment assumes neither logarithmic space nor logarithmic width from a short DAG proof. It also does not replace DAG derivation length by tree length: a recurrence adding two parent certificate lengths would need a separate accounting of shared ancestors.

## Exact failed representation hypothesis

For a CNF F and integer B, define U_B(F) as the family of non-tautological clauses C containing some clause D that has a binary-resolution DAG derivation from F with at most B inference nodes. Weakening is used only in this final family definition, not as an intermediate inference. Input axioms are free for this definition. Represent the characteristic function of this family by an ordered ZDD on literal-membership bits, with both-polarity clauses excluded.

The rejected hypothesis is that this exact reusable frontier always has size polynomial in |F| and the shortest refutation size when B is below that size. The definition is semantic; no efficient construction procedure is supplied or assumed. In particular, bounded-proof SAT encoding is not a proposed algorithm.

Here is the budget-before-refutation strengthening of the source obstruction. It is an application of an established compilation lower bound, with no novelty claim.

Let G=(V,E) be a bounded-degree expander from the cited theorem, with m edges and no isolated vertices. On variables x_v and z_e form K_G with clauses

- A = OR over e in E of z_e;
- (not z_e OR x_u) and (not z_e OR x_v) for each edge e={u,v}.

On a disjoint alphabet take H_L = {y_0, (not y_i OR y_(i+1)) for 0<=i<L, not y_L}, with L=4m, and let F=K_G union H_L. The literal count is O(m). H_L has a refutation with L+1 inferences and is minimally unsatisfiable: deleting an endpoint unit or any one chain implication admits a satisfying threshold assignment.

Consequently every H_L refutation requires at least L+1 inferences. Indeed, the ancestor DAG of a derived empty clause with k binary inference nodes has at most k+1 distinct axiom leaves; minimal unsatisfiability requires all L+2 chain axioms. K_G is satisfiable. Without weakening, a binary resolvent cannot mix clauses from the two disjoint alphabets: a common pivot is necessary. Therefore F also has minimum inference count L+1. Its shortest proof size, with axioms counted, is Theta(m).

Nevertheless the pure-positive-x slice of U_m(F) is exactly the vertex-cover family of G. For necessity, no H_L empty clause is available at budget m, and no nonempty H_L clause is contained in a pure-x clause. A K_G consequence OR_(v in C) x_v requires C to meet every edge: if an edge misses C, set its z variable and endpoints true and all x in C false to obtain a countermodel. For sufficiency, choose a minimal vertex cover C' contained in C. Every member of C' has an edge whose other endpoint lies outside C'; otherwise it could be removed. Select an endpoint in C' from each edge. Resolving A successively against the corresponding m binary clauses derives exactly OR_(v in C') x_v in m inferences. Its final weakening belongs to U_m(F).

Fixing every other literal-membership bit to zero thus gives the function AND_{uv in E}(c_u OR c_v), where c_v denotes membership of x_v in the clause. The cited all-order exponential OBDD lower bound applies to precisely this function. An ordered ZDD of size t on q bits converts to an OBDD of size O(q(t+1)) by inserting tests enforcing zero on skipped variables. Restriction does not increase OBDD size. Hence a ZDD for U_m(F) also requires exponential size in |V|, while the input literal count and shortest refutation line count are O(m)=O(|V|). With binary variable indices, their written encodings have an additional O(log m) factor, which does not affect the superpolynomial separation.

This disproves the stated exact-frontier size hypothesis at a budget strictly below the first refutation. It does not show that a resolution search procedure must construct this frontier. Unit propagation immediately handles H_L; component decomposition also avoids the clutter. The construction is therefore not a lower bound against demand-directed symbolic resolution, adaptive partial compilation, preprocessing, or automatization generally. Its purpose is solely to prevent proof-budget truncation from being asserted as a sufficient repair of the known compilation problem.

## Outcome and remaining boundary

No concrete demand-directed mechanism with an output-sensitive cost theorem survived selection. Naming relevance filtering or partial compilation would only restate the missing search task. No restricted solver is substituted for the full target. The target and broader objective remain ACTIVE and INCOMPLETE; this record is a source-backed candidate rejection, not a discovered frontier advance or route-final completion.

## Actual-file three-lens review

| Lens | Actual verdict | Scope |
|---|---|---|
| [Proof/adversarial](2026-09-12-resolution-search-proof-review.md) | PASS | DAG counting, exact cover slice, ZDD conversion and bounded representation rejection; full target INCOMPLETE |
| [Source/complexity](2026-09-12-resolution-search-source.md) | GO | Established target equivalence and symbolic prior art; exact imported compilation-bound application only |
| [Non-claims](2026-09-12-resolution-search-nonclaims-review.md) | GO | Bounded local record and graph scope; selection NONE and publication HOLD |

These are three distinct AI-agent assessments. The source reviewer supplied the compilation theorem and ZDD-conversion diagnostic. The separate proof reviewer supplied no construction or repair, flagged DAG-budget and weakening distinctions before actual-file inspection, and independently checked the adopted mathematics. The non-claims reviewer supplied no mathematics. This is an AI-authored analytic assessment, not Lean verification, human peer review, or priority certification. No public artifact, release, push, outreach, or paid computation is authorized by this record.
