# Degree-three port/cycle replacement: source draft

2026-09-12. S3132 under S3126. **UNCOMPILED.** No axiom query, example, compiler, Git, package configuration or public action was performed. This increment implements the explicit graph transformation needed by the source Gap3Lin regularization route extracted at ed92019. The existing extraction and independent review reports are unchanged.

## Actual graph and cut convention

Port n d is Fin n x Fin(d+1), so the original positive degree D is d+1. An input rotation R is an actual involution on those ports. The output rotation has three labels: external follows R and keeps label zero; forward applies finRotate D and returns with backward label two; backward applies its inverse and returns with forward label one. The involution proof uses the actual inverse and input involution. The resulting Complexity.RegGraph has exactly nD vertices and degree three. It retains parallel edges and self-loops. The executable finite table enumerates nD*3 actual input/output dart pairs. Its length theorem is a structural count, not an FP certificate.

Cut is one half the sum of endpoint-disagreement indicators over all rotation darts. Every crossing nonloop orbit therefore contributes one; loops contribute zero. The decomposition into external cut plus sum of forward cycle cuts is proved by reindexing the backward cycle sum. At D=1 the two cycle darts make a loop and add no cut. At D=2 there are two parallel cycle edges, both counted; they must not be silently merged into a simple graph.

## Derived expansion and proof route

Each cloud is rounded to its Boolean majority, with true on ties. The minority discrepancy is its actual number of differing ports. If every adjacent pair agrees, Fin induction around the concrete cycle proves the assignment constant. Otherwise a real crossing contributes at least one, while discrepancy is at most D. Thus minority <= D*cycleCut, including D=1, and total B <= D*C.

For an arbitrary port subset S and its rounded cloud subset A, separate positive and complementary volume inequalities give min(|S|,nD-|S|) <= D*min(|A|,n-|A|)+B. This does not assume a final rounding-distance conclusion.

The original graph cut of A is at most the new external cut plus B. The proof uses the pointwise Boolean distance perturbation inequality and reindexes the second endpoint discrepancies through the actual involutive R. This controls loops and parallel darts using their exact multiplicities.

If the original graph satisfies h*min(|A|,n-|A|) <= originalCut(A) for every A and h>0, these two transports and B<=D*C imply

    cutReplacement(S) >= h/[D*(1+h+D)] * min(|S|,nD-|S|).

All intermediate estimates and the final algebra are source proof scripts. The expansion hypothesis concerns the input graph, not the output or source hardness. It must later be discharged for the actual chosen library graph. There is no assumed final replacement-expansion field.

## Library and runtime boundary

The graph uses the actual pinned Complexity.RegGraph/Expander interfaces. The earlier extraction identifies algFamily and its FP rotation-table machinery. Instantiating it still requires a spectral-to-cut theorem with exact constants, the Fin degree transport into this D=d+1 representation, and the encoded composition giving the same output rotation/table in FP. Noncomputable real-valued cut/count definitions are semantic analysis; the data-level rotation and table are ordinary finite definitions. Lean computability and table length alone do not establish binary-time bounds.

The equality gadget, actual occurrence-cloud equation construction, quantitative regularized NO gap, and complete H?stad source-hardness proof remain separate tasks. Neither this graph theorem nor a future generic instantiation establishes MZ Theorem3.1 by itself. The full PCP/decoder/learning chain, paper reconciliation and final consolidated proof artifact remain open.

## Source identities and pending verification

- PortCycleReplacement.lean: SHA256 35e492e5fce8750ac83d5d0a875fc2a53ffeede00d4f94a2f4df5fac7a1b9c2b; 12214 bytes, 274 lines.
- PortCycleReplacementChecks.lean: SHA256 7a92daffd1c92598bef0fb4c720ed52e6e7c934fa840e759c3a57146095e9a1c; 1534 bytes, 35 lines.

Checks contain eleven axiom queries, one full-name signature query and eleven examples, all unrun. Boundaries include constant clouds at D=1/2, degree-one cycle loops, the two loop labels, output degree/order, empty base vertex set and exact table size. The source does not contain sorry, admit, native_decide or new axiom declarations. API/simplifier repairs may be required during compilation; no successful theorem export is claimed. Root read the original full main/Checks and reported no mathematical blocker; the final source-only cleanup narrows the tactic imports from Mathlib.Tactic to FinCases, NormNum and Push.

Next: exact draft preservation when authorized, scoped author compilation of main then Checks, source/evidence freeze and three independent review lenses. The new Complexitylib import must use verified compatible exports; no broad build or cache operation was performed. S3126 remains active.
