# Exact equitable lumping: independent complexity review

2026-09-08. S3040 / S008 / E004. Baseline 09b5cca. Reviewed the stable `2026-09-08-exact-lumping-attempt.md` in full. Harness only; no commits, code changes, simulations or planning edits.

## Exact quotient contract

The equivalence between equitability and invariance of the entire cell-constant vector subspace is valid. Off-cell neighbor counts follow by applying L to cell indicators; the regular degree determines within-cell counts. Identical coordinatewise reaction preserves cell constants, so the displayed heat and logistic quotients lift exactly by uniqueness.

This is a restricted but well-defined compression method. It does not purport to capture all representations fitted to one trajectory or one readout. The distinction is essential to the lower bound and is maintained throughout.

## Transition and counting checks

For a2k-bit block, the type j=min(w,2k-w) has the stated up/down counts. At j=k, both possible weight changes reduce the type, so the special rate2k is necessary and correct. The k=1 boundary case is included. Multiplying by the count h_j of blocks of each type gives the histogram transitions, and their total rate is2k sum h_j=2k^2=n.

Every histogram is realizable, and its initial indicator is one exactly for h_0=k. Thus the quotient is equitable and initially compatible. Stars and bars gives exactly binom(2k,k) cells; this is initially an exhibited quotient size, before the separate minimality proof.

## Independent minimality audit

Heat factors over the independent blocks and product initial indicator. Equation (5) has the correct factor2^(-2k), real-root power and even polynomial P_d. Its product gives the full histogram heat polynomial.

The multiplicities at r=1 and r=-1 are exactly J_h because every P_d is nonzero there. After removing common real-root factors, the positive even-degree P_d has the stated simple imaginary roots. The smallest-modulus pair is at plus/minus i tan(pi/(2d)), and that modulus strictly decreases with d. Choosing the largest degree with unequal multiplicity after cancellation therefore finds a root vanishing on only one side. This proves distinction without the false premise of pairwise coprimality. The root-free P_0 multiplicity is then recovered from the fixed number of blocks.

Distinct polynomials imply distinct heat trajectories as functions of time. Every initially compatible equitable partition keeps the heat solution cell-constant for all time, so no cell can contain two different histograms. Hence every such partition refines the exhibited histogram partition. This establishes coarseness and minimum cell count, rather than merely counting one symmetry partition.

The proof does not establish distinct values at a prescribed single time. It also does not identify heat and nonlinear reaction trajectories: heat provides a necessary separation invariant for the equitable partition contract, while the reaction quotient follows separately from closure.

## Complexity and exceptions

The central-binomial bounds give2^Theta(k)=2^Theta(sqrt(n)) cells. With O(n) clauses and O(n log n) explicit encoding length, this is superpolynomial in input length. It is not a2^Omega(n) claim. Sparse rows and polynomial-size histogram labels do not make explicitly storing and updating all cells polynomial; conversely, the state-count result alone does not exclude an implicit selected-coordinate algorithm.

The example remains an easy SAT family with an immediate all-zero witness. Its linear heat coordinate also has a polynomial product evaluator using the independent block factors. Positive bounded factors and the prior scalar-parameter accuracy budget permit polynomial rational bit work at the earlier precision targets. This explicitly prevents interpreting the minimum equitable quotient as a heat-evaluation or SAT lower bound.

No corresponding product formula is asserted for the nonlinear reaction. Approximation, non-partition representations, trajectory-specific compression and other selected-coordinate methods remain outside the obstruction. The elementary root proof needs no imported spectral or representation theorem and no unverified complexity source.

Final verdict: GO for the exact quotient, verified rates and minimum cell count under the stated initial-compatible equitable contract. NO-GO for a uniformly polynomial explicit quotient-state implementation of that contract on this family. INCOMPLETE for arbitrary succinct evaluation or general polynomial SAT. No mathematical or complexity-scope corrections were required in the saved candidate.
