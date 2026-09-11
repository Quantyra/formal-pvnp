# S3057 independent complexity review

2026-09-11. E004/S008. Independent agent complexity lens under [INTEGRITY-CLAIMS.md](../../INTEGRITY-CLAIMS.md). This is not human peer review, a Lean theorem, or a novelty certification.

**Verdict: GO for closing this bounded informal mathematical attempt. NO-GO for interpreting polynomial fixed-budget saturation as a complete polynomial SAT algorithm or the counterfamily as a general complexity lower bound.**

Reviewed the final [author derivation](2026-09-11-affine-feedback-mechanism.md), [source comparison](2026-09-11-affine-feedback-sources.md), script and saved JSON. No Lean source changed; Python exact checks and independent algebraic review match this increment's scope.

## Fixed-parameter work bound

Let n be the explicitly represented variable dimension and L the total number of original affine-form occurrences in residual clauses. Masks and matrix rows have dimension-dependent bit length. Every pass substitutes a particular solution and kernel basis into the retained original clauses. Canonicalization row-reduces each clause's falsifying equations, removes affine tautologies, and detects an identically false clause. Its number of independent rows cannot exceed that clause's original number of forms. Consequently the number R of distinct occurring nonzero coefficient vectors is at most L on every pass; retaining clauses does not create an exponentially expanding CNF.

The candidate scheme enumerates generating subsets of size at most the fixed w, at most sum_(j=1..w) binomial(R,j), bounded by O((L+1)^w) for fixed w. It row-reduces each to a canonical span and may deduplicate repeated spans. It does not enumerate all subspaces of GF(2)^n, all clause subfamilies, or all subsets of global assignments. Each candidate scans the actual residual clauses and checks membership for every row, charging polynomial work in L,n,w. Storing all candidates and all proposed equations is polynomial for fixed w, although potentially expensive; it is not constant storage.

For a candidate of rank r<=w, its independent linear forms map quotient assignments surjectively onto GF(2)^r. Therefore evaluating all 2^r patterns computes the exact local relation. The implementation then checks up to 2^r normals against those patterns, so the hull-learning calculation includes a 4^w factor, not just 2^w. Row reduction, membership coordinate reconstruction, table evaluation, hashing/equality, equation translation and learned-equation elimination all have polynomial bit costs at fixed w. If w grows with the input, neither the candidate nor local-table factors are claimed polynomial.

All original clauses remain semantically present. Only entailed affine equations are added. The code lifts quotient equations through the original free coordinate indices; these free bits equal the quotient coordinates under its RREF parametrization. Retaining a non-affine local relation prevents the unsound replacement of that relation by its larger affine hull. Constants survive normalization and local evaluation. Zero-dimensional constant cases are discharged during normalization, so omitting the zero candidate span does not lose an inference required for those cases.

Every consistent productive pass adds at least one independent equation and strictly increases the affine rank. There are at most n minus the initial rank such passes, followed by at most one unproductive scan. If learned equations conflict, termination is immediate. The code's rank assertion is justified because a learned nonzero quotient equation restricts free coordinates; it cannot already belong to the old affine row space. Total work therefore charges O(n+1) complete candidate scans and Gaussian updates. The rank count alone would not prove polynomial work, but the bounded enumeration and bit-cost accounting supply the missing bound.

## What termination means

This is a polynomial saturation procedure for fixed w, not a complete polynomial decision algorithm. UNSAT follows only from an inconsistent affine system, a false normalized clause or an empty exact local relation. SAT is returned only when every retained clause normalizes away, and a concrete affine solution is checked as witness. Otherwise a stable state returns OPEN. OPEN includes satisfiable and unsatisfiable inputs; it cannot be promoted to either verdict or to a small remaining search space.

The current residual coefficients are those of canonically normalized clause-falsity rows. The scope is consequently tied to this explicit normalization and generating-vector rule. Alternative derived spans, implication composition, arbitrary affine-hull oracles and stronger inference systems are not covered by the cost or incompleteness claim.

## Bowtie family and positive checks

For each fixed w>=2, the two implication cycles of length w+1 sharing a root force opposite root values and are jointly UNSAT. Initially their clause-falsity coefficient vectors are coordinate vectors. Every allowed scope therefore covers at most w variables and cannot include a complete cycle. Its induced binary-clause graph is a forest. For any vertex, neighbors can be chosen to satisfy their edge for either value of that vertex, and those fixed neighbor choices extend into the disjoint remaining trees. Thus two satisfying local assignments differ only at that vertex. Their differences span every coordinate direction, giving full affine hull and no learned equation. The procedure stops OPEN on its first unproductive pass.

This is a fixed-rule incompleteness result, not a lower bound for SAT decision, implication reachability, all affine-clause solvers, or all bounded-width methods. Increasing the scope to w+1 sees each complete cycle and derives contradictory root equations. For any fixed w, choosing longer cycles gives further failures. The paired-path and two-pass examples independently verify genuine feedback: learned equalities expose later affine structure. They do not imply completeness on arbitrary inputs.

## Independent exact verification

PASS: ran exact temporary copies of the current script and its pinned helper. All eight author controls and nine family cases passed, and semantic JSON matched the saved output after removing elapsed wall time. The author output was preserved. Script SHA256 with CRLF normalized to LF: `7ea5252f2489de80689653e726d4d22f529c04c0f7bb48c80068cb30f818fad4`. Helper SHA256-LF: `0812936a4eee35b8680a20dbc5e2168e279c2b09b1d53f39e0ddb637aac14ef1`.

Independently enumerated all 256 subsets of the eight affine forms on two variables as single clauses, under each of nine initial equation choices (none or one of eight affine equations): 2304 finite controls. Direct truth tables verified UNSAT detection, each SAT witness, every learned equation on all original models, and strict growth of successive recorded ranks. Width two covers the full coefficient rank in these controls; that special finite completeness does not extend to arbitrary n at fixed w. These checks target constants, offsets, lifting and retained non-affine clauses. They are not a random campaign or a timing/scaling study.

The final added exactly-one-of-three fixture passed on replay: odd parity is learned, but assignment 111 remains excluded by the retained clauses and the result is OPEN. Only the fixture changed after the independent 2304 controls; the saturation core remained unchanged. Final eight-control/nine-family semantic output was rechecked against the updated saved JSON.

## Final disposition

The final narrative's fixed-w bound includes all candidate spans, row reduction, full clause scans, local tables, the 4^w normal calculation, equation lifting, batch elimination, unsuccessful scans and at most n+1 passes. Its parameter-dependent storage and runtime claims agree with the implementation. It explicitly distinguishes the scope-threshold observation from an efficient strategy when w grows, and gives the infinite family by allowing cycle length ell to exceed the fixed budget. No unresolved complexity blocker remains for the scoped result.

The surviving result is a sound polynomial preprocessing/saturation rule with a proved, explicit incompleteness threshold on an easy family. Any complete solver or stronger inference extension requires further work and its own cost bound; this increment supplies neither a P-versus-NP conclusion nor a novel algorithm certification.
