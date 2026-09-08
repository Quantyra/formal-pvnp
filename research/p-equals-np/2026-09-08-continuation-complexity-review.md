# Continuation complexity review

Date: 2026-09-08. Route: S3040 / E004 / S008. Independent harness reviewer; no OpenCode. Repository: `C:\Users\Dan\Desktop\Projects\formal-pvnp`. Observed HEAD: `028770f7e90f2817a5829dbbab1446e75269b48e`.

## Verdict

**GO for the explicitly bounded complexity conclusions; P=NP remains unproved and the route is not final.** No blocking complexity error was found in the reviewed versions of `2026-09-08-payload-summary-attempt.md`, `check_payload_summaries.py`, `2026-09-08-finite-bit-coupling-attempt.md`, and `2026-09-08-completed-carrier-attempt.md`. This review checks complexity implications and the elementary representation counting arguments. It does not independently audit the external PDE manuscript or certify the completed-flow analytic transfer.

## Counting and algorithm checks

1. Equality: after fixing all x variables, the 2^k distinct singleton y relations cannot merge even semantically as reusable residuals. This does not lower-bound endpoint decision or adaptive ordering. The explicit O(k log k) indexed encoding makes 2^k superpolynomial in encoded input length; it is not claimed exponential in that length.
2. Parity: a non-tautological implicate omitting any variable cannot hold on even parity, since its falsifying partial assignment has an even extension. Each full-width clause excludes at most one odd assignment. The 2^(k-1) bound therefore applies to an exact auxiliary-free CNF. Affine equations and retained auxiliaries legitimately escape it.
3. Affine unions for pair OR: each projected affine subset avoiding 00 has at most two points. Injecting an affine component into the product of its coordinate projections bounds its size by 2^k. Covering 3^k models needs at least ceil((3/2)^k) components, even with overlap.
4. Connected AND-difference: the d-to-c transformation is invertible and each possible d occurs. A nonempty rectangle in the deterministic relation cannot include two d columns. Thus 2^k rectangles are necessary and attainable. An AND graph contains no affine plane; every projected affine component has at most two points per triple, giving at most 2^k points per component against 4^k relation points. This proves the stated affine-union lower bound. The dense-table 8^k count is an allocation cost for that representation, not an intrinsic information lower bound.
5. The 7k-2 clause count is correct: 3k AND clauses, 4(k-1) XOR clauses, and two final equality clauses on 4k variables. The connected family still has a compact factor/circuit escape. Pinning d makes its pair constraints independent after backward recovery of c. Neither this example nor the triple chain implies a lower bound for arbitrary decompositions.
6. Resolution implements exact existential elimination including empty, one-sided, and tautological cases. Boolean matrix multiplication implements joins over shared pair values and exact projection. The restricted chain has constant-size states and polynomial total work; the text correctly separates logarithmic parallel depth from linear matrix work. Arbitrary cross-pair clauses retain the unresolved general payload problem.

## Independent reproduction and limits

Ran `python research/p-equals-np/check_payload_summaries.py` from the satellite repository; exit code 0. Observed equality counts 2 through 256, parity counts 2 through 128, 6,116 exact projection comparisons, 320 triple-chain checks (264 YES and 56 NO), and AND-difference counts through k=6 with 4^k rows and 2^k outputs. The projection oracle evaluates the original CNF over every assignment of eliminated variables for every remaining assignment at every elimination stage in 300 seeded examples; this is meaningful finite correctness evidence. These tests do not establish any universal running-time bound. The all-k representation statements rest on the arguments above, not extrapolation from enumeration.

**LOW / wording:** the reproducer prints `affine projection bound and false-positive relaxation check: PASS`, and the note says `Affine projection/cardinality ... checks passed`. The code checks affine hulls, small affine subset cardinalities, and invertible output reconstruction. It does not implement or test the general Gaussian-elimination existential-projection algorithm described in Candidate 2. Requested edit: label this `affine subset/cardinality and false-positive relaxation checks` (or explicitly identify coordinate-projection cardinality), so the output cannot be mistaken for testing an affine elimination implementation. The underlying affine projection mathematics is elementary and correct; this is an evidence-label issue, not a failed theorem.

## Physical-to-standard-model boundary

The bit note correctly locates the passive-signal cost in an additive absolute-error detector model. For fixed parameters and exponentially many ticks, Lambda is exponential and exp(-Lambda) requires order Lambda fixed-point absolute precision for sign separation. A symbolic exponent or sign description can remain short. This does not prove a universal encoding or numerical-complexity lower bound.

The 4M and Lambda integrated coefficient quantities are controller diagnostics; the note explicitly does not identify them with kinetic energy, minimum physical energy, or Turing work. An externally supplied command sequence is not a SAT solver. Alternating signal variation is not, without an applicable encoding and simulation theorem, a lower bound on all algorithms for the final SAT observable.

The completed carrier's existential stable graph is not an efficient initialization procedure. The text appropriately separates O(n) binary tolerance length for M=2^n at fixed parameters from computing the tolerance center, obtaining effective source constants, constructing the flow, or simulating it. Its tick law supplies no standard-model polynomial-time simulation theorem. Matching a radius exponent does not transfer the affine scalar device to the completed field.

## Required remaining result

A uniform exact deterministic endpoint algorithm with a worst-case polynomial bound in total encoded CNF length is still absent. The latest attempt specifies exact local projections but lacks an amortized polynomial bound on cumulative representation and evaluation work. Neither bounded carrier conclusions, restricted-family matrix success, nor representation-specific blowups discharge that requirement. No claim of P=NP, P!=NP, or a general fluid-computation impossibility is justified by this increment.
