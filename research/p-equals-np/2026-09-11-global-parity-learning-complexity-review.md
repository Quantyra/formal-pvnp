# S3058 independent complexity review

2026-09-11. **Verdict: GO for the stated fixed-support saturation bound and the two restricted-family results.** No general SAT algorithm, P-versus-NP implication, novelty determination or publication recommendation is approved. This is an independent agent review of informal mathematics and executable finite checks, not human peer review or Lean verification.

Reviewed the repository README and integrity boundary, S3058 planning scope and three-lens protocol, [main note](2026-09-11-global-parity-learning.md), [implementation](2026-09-11-global-parity-learning.py), saved JSON, imported linear helper and [source comparison](2026-09-11-global-parity-learning-sources.md). The source comparison is the dedicated literature audit; this review does not independently re-establish publication priority. A direct DOI fetch of the 2024 source failed in this review, so no additional full-text verification is claimed here.

## Selection and progress accounting

The algorithm freezes the original normalized guard supports, adds the empty support, and visits every complete pattern in a prescribed order. Every pass uses the same global snapshot. Neither favorable contexts, a shortest proof, a minimal inconsistent subsystem nor future supports are selected by an oracle. Full-assignment nogoods are sufficient for the soundness and progress argument.

With B the sum of 2 to the support size, including the empty context, there are at most B candidate nogoods. A consistent productive pass adds a new nogood or increases global affine rank. Since rank is at most n, there are at most n+B productive passes and one final pass. Adding a dependent row cannot artificially extend this bound: the implementation tests the rank of the batched canonical basis and does not continue on dependent rows alone. Previously learned nogoods are deduplicated. A contradiction may terminate earlier.

The bound relies on normalized guards with distinct underlying variables, masks within the stated dimension, and n counting active explicitly represented variables. It does not assert polynomial work in the bit length of an artificially huge declared dimension containing unrepresented unused variables. These are the input conventions stated in the note; the executable fixtures satisfy them.

Within a case, every continuing iteration adds at least one assigned variable. Thus at most n productive rounds and a final scan suffice. Unit propagation, guard activation and Gaussian elimination inspect explicit data. Augmented row-space intersection solves a homogeneous linear system with at most twice the affine basis width and maps its kernel; it does not enumerate row-space points. The nonlinear formula is retained, and a consistent affine closure is not mistaken for a satisfying assignment.

## Representation, provenance and total work

Persistent state contains at most n affine rows and B learned clauses of width at most w. A scope can contribute at most n basis rows, so the temporary batch contains at most (g+1)n candidate rows. The repeated addition of equivalent rows can waste work but is still charged within this bound.

Gaussian certificates carry bit masks over the explicit inputs of that elimination. Case certificates reference original guarded rows, current global rows and at most n unit steps. Common-consequence witnesses reference bases of size at most n in each surviving case. Batch certificates can use masks of length proportional to the full candidate batch. These lengths are polynomial in the explicit input and B; they are not constant-cost unbounded integers. Keeping all certificates creates a polynomial number of polynomial-size records for fixed w, even without a linear-memory implementation.

Consequently the note's deliberately loose bound

`O((n+B+1) B (n+1) poly(N+B*n^2))`

is a valid polynomial upper-bound form under its explicit-input convention. It includes final unproductive scans, all support patterns, joins, clause scans and retained diagnostic traces. This is not a precise fitted running-time exponent. If w grows, the 2^w enumeration is part of the cost and the fixed-width conclusion does not become a uniform polynomial bound.

## Family conclusions and limitations

The guarded prism learns exactly the forbidden pattern g=h=1. Its global derivation can involve all vertex rows, while the resulting binary clause is not an affine equation: its three allowed guard patterns have full affine hull. The policy's final OPEN status on this satisfiable family is intentional.

For the AND ring, every single-pair case closure is consistent for m>=3, including arbitrary private-path length. Summing its activated path and the fixed indicator equation derives the same endpoint/indicator parity in all four cases. Intersecting case spaces therefore discovers that global consequence without a conflict. Collecting these consequences closes the ring contradiction in one pass. Fresh internal variables and all 4m*ell guarded rows are explicitly counted. The argument applies to every m>=3 and ell>=1, rather than extrapolating timings.

The comparison is strictly with the implemented fixed-support conflict-only policy. It proves no lower bound for CDCL, failed-literal methods with other supports, general local reasoning or all affine representations. The AND-gate CNF itself is Horn; the entire selected system includes negative guard activations and odd indicator parity, so the earlier positive-activation Horn shortcut does not apply. The note's nonlinear description is accurate.

Polynomial saturation is incomplete even on elementary CNF. With no guards or affine input, the unsatisfiable formula `(x OR y) AND (x OR NOT y) AND (NOT x OR y) AND (NOT x OR NOT y)` has no unit clause and returns OPEN. Thus this result does not supply the missing universal deterministic proof-discovery mechanism. The common-consequence principle has an explicit predecessor in the accompanying source audit; no new abstract inference rule is established.

## Reproducible independent checks

Run from the repository root:

`python research/p-equals-np/2026-09-11-global-parity-learning-complexity-check.py`

The [independent checker](2026-09-11-global-parity-learning-complexity-check.py) writes no artifacts and uses seed 3058. Results:

- 1,200 generated three-variable inputs with unconditional parity rows, arbitrary signed CNF clauses and normalized guarded parity rows: 669 OPEN and 531 UNSAT. Brute-force models independently validate every learned equation and nogood, and every UNSAT result has no model. The pass-count bound is checked. This does not assert completeness for the OPEN cases.
- All 256 pairs of subspaces of GF(2)^3: computed intersection equals direct intersection of independently enumerated point sets.
- New ring parameter m=3, ell=4, n=48, outside the author's six saved family cases: conflict-only OPEN and common-consequence UNSAT.
- The explicit unsatisfiable four-clause two-variable formula above returns OPEN.

SHA256-LF pins (CRLF normalized to LF): implementation `af30f9351f8614a5582883f1f92ea876226ce31beb768ee66537b33d84242c2c`, helper `0812936a4eee35b8680a20dbc5e2168e279c2b09b1d53f39e0ddb637aac14ef1`, independent checker `9a0cacba978ff1f61b5d124e7c77c105e481c769256590d868e390896cab3fda`. The saved JSON implementation pin matches the reviewed code. Reviewed main-note pin: `f8a339e599adc027fc41b99b1286a1ad532e86e652a6f8d3221a634b6f3a2d57`.

No blocking complexity findings remain for these claims. The next unresolved research issue, if separately selected, is useful support or richer consequence discovery beyond this incomplete fixed-support policy; this review does not authorize or promise that successor.
