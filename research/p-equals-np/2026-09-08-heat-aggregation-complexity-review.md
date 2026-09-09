# Hypercube heat aggregation: independent complexity review

2026-09-08. S3040 / S008 / E004. Baseline 0d661d4. Reviewed the stable `2026-09-08-heat-aggregation-attempt.md` in full. Harness only; no commits, code changes, numerical suites or planning edits.

## Exact construction and decision gap

The commuting coordinate-flip operators give the displayed product kernel, and the coefficients are nonnegative with row sum1. This proves positivity, sup-norm contraction and the globally defined solution of the finite linear IVP. The energy derivative has the correct factors for both unordered and directed edges; the same identity applies to differences of solutions.

At rational time1, every kernel entry is at least4^(-n). A satisfiable indicator therefore produces output at least that value at the all-zero vertex, whereas an unsatisfiable indicator remains identically zero. Additive error2^(-2n-2) separates these cases by the stated rational threshold. The requested precision has O(n) bits, not exponentially many bits.

The resulting reduction is correctly one-way and succinct: it asks for a uniformly polynomial deterministic evaluator taking the CNF predicate, not an explicitly supplied truth table. Such an evaluator would decide SAT. The construction does not provide the evaluator or prove its impossibility, and it imports no reverse equivalence or counting-class result.

## Stability and precision audit

Sup-norm initial perturbations propagate with no amplification. The normalized L2 coordinate bound has the separate factor2^(n/2), so the note does not conflate the two initial-error contracts. A bounded energy value alone gives neither of them.

The time derivative bound n follows from coordinates in [0,1]. The stated timing budget therefore suffices and has O(n+log n) description length. This description cost is distinct from physically attaining that timing accuracy.

Replacing one bit's kernel probability at a time changes the expectation of a [0,1]-valued predicate by at most the parameter change. The total error bound n|p_hat-p| is valid. Computing the constant exp(-2) is not the aggregation bottleneck: beyond degree2 its alternating-series terms decrease, the next term bounds the remainder, O(b) terms suffice for b requested bits, and rational intermediate lengths remain polynomial.

At t_star=(log2)/2 the exact dyadic kernel gives the stated weighted integer sum divided by4^n. The numerator is at most4^n, so numerator and denominator lengths are O(n). The note correctly separates the irrational-time interpretation from simply specifying this rational stochastic propagator. Neither interpretation computes the weighted sum for free.

## State size, norms and evaluation work

The full IVP has2^n coordinates and an explicit truth-table initializer. Preparing that direct representation requires2^n entries; an explicit RHS pass has n2^n neighbor contributions. Those are costs of the displayed materialized implementation, not lower bounds for all succinct algorithms.

Normalized energy at most1 uses the chosen2^(-n) measure per node. It is not a physical preparation, memory, coupling or readout bound. With unit node weights the unnormalized energy can be exponential. Shrinking physical node volume would require a separate resource model, which is not supplied or assumed.

No fixed-dimensional analog complexity theorem applies merely because this system is stable and has a short modeled runtime. Indeed the displayed derivative bound would even give full-state sup-norm trajectory length at most n through time1, but the state dimension and explicit initializer still grow exponentially. The required fixed-machine encoding and uniform evaluation obligations cannot be discarded. The candidate correctly invokes no BGP conclusion from these facts.

The bit-elimination recurrence computes the requested coordinate exactly when carried out. Direct tables and summation have exponential size; shared circuit substitution might avoid some repetition but has no proved uniform polynomial bound here. The cost of constructing or certifying a compact representation remains included in the missing theorem.

The tensor kernel factors over input bits, not over arbitrary overlapping clauses. The formula x AND not x verifies the distinction exactly: the true expectation is zero while the product of clause expectations is positive for positive time. Small-clause evaluation therefore cannot substitute for the global conjunction expectation.

## Source scope and verdict

The review required no external source theorem: the linear solution, norm identities, elementary error estimates and reduction are proved directly in the candidate. No Navier--Stokes result or physical implementation is imported.

Final verdict: GO for the stable heat flow, constant-time SAT gap, explicit accuracy budgets, dyadic propagator and exact contraction recurrence. INCOMPLETE for uniformly polynomial succinct evaluation, general polynomial-time SAT and a physical device. No mathematical or complexity-scope corrections were required in the saved candidate.
