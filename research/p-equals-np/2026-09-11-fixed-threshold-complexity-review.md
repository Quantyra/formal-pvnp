# Fixed-threshold restriction: independent complexity review

2026-09-11; S3079. Under [integrity](../../INTEGRITY-CLAIMS.md). Independent complexity/challenger lens on the saved [main derivation](2026-09-11-fixed-threshold-restriction.md). **GO for the scoped feasibility and conditional calculation; no GO for Hypothesis R.** No experiment, implementation, minimization algorithm or circuit lower bound is claimed.

## Quantifier obstruction actually checked

An unrestricted fixed-threshold recurrence would be false. Fix finite L <= T. On M=2^q truth-table bits, enumerate all q-input circuits of size at most floor(T), compare the input table with each represented table, and OR the equality tests. There are (q+T+2)^{O(T+1)} descriptions, so this nonuniform separator has size at most M(q+T+2)^{O(T+1)}. It decides size-at-most-T exactly, hence separates size-at-most-L from size-greater-than-T. For fixed T its size is M times a polynomial in log M.

Consequently, a fixed multiplicative shrinkage factor 2^(-1-epsilon) cannot hold for every arbitrarily large q down to a fixed positive base at the same L,T: iteration would imply Omega(M^(1+epsilon)). This is a contradiction to the displayed upper bound, not a lower bound. It does not refute a finite slab q0(n,beta) <= q <= n with T=2^(beta n). This consultation originated in this review and was independently checked by the separate proof reviewer before adoption.

## Minimum separators and the base scale

Defining S(q;L,T) as the minimum size of a promise separator is legitimate nonconstructively: finite truth tables have separators and nonnegative integer gate counts attain a minimum. Applying a hypothetical restriction to a minimizer does not require an efficient minimization oracle. It also removes irrelevant syntactic padding from the conjecture.

A useful elementary counting base is available. If at most 2^H tables have q-variable circuit complexity at most T, a separator depending on d of the M coordinates must have d >= M-H, provided the all-zero table is YES. Otherwise fixing all observed coordinates to zero leaves more than 2^H completions, including a NO table indistinguishable from the all-zero YES table. A fan-in-two circuit with g gates depends on at most g+1 distinct inputs, so g >= M-H-1. At M >= 4(H+L+1), this is a linear base. This argument concerns dependence of a separator on truth-table coordinates, not essential variables of the functions encoded by those tables. The separate [proof reviewer](2026-09-11-fixed-threshold-proof-review.md) independently verified this reviewer-originated observation, including the explicit count, stopping scale and gate-dependence bound in the saved main.

For the earlier every-separator syntax proposal, a double-NOT tail gives a precise padding objection only if double-negation elimination is absent from the specified simplifier. Under constant propagation, identical-input reduction and unreachable-gate deletion alone, a nonconstant output retains every gate in that reachable unary tail. Adding enough such gates defeats a fixed multiplicative shrinkage factor. This is not a claim about every stronger simplifier. The minimum-size formulation avoids relying on this artifact.

## Conditional consequence, not a mechanism

Stopping at M0 = Theta(T log T) for T=N^beta, with the needed counting constants, gives log2(M0)=beta log2(N)+O(log log N). If the finite-slab multiplicative shrinkage estimate with exponent epsilon were proved and the linear base held, iteration would give N^(1+epsilon)/M0^epsilon, hence leading exponent 1+epsilon(1-beta), up to logarithmic factors. One fixed epsilon and all sufficiently small fixed beta are necessary to infer a smaller fixed exponent in the OPS antecedent. Additive embedding costs cannot be omitted from an alleged shrinkage estimate.

The counting base and conditional arithmetic do not establish the crucial shrinkage estimate. Duplicating tables at fixed thresholds preserves the promise but does not by itself force sufficient gate deletion in an arbitrary shared circuit DAG. The earlier [direct-magnification review](2026-09-11-direct-magnification-review.md) records the exact primary theorem and its model limitations.

## Final saved-artifact inspection

The main uses all two-input Boolean gate functions with constants, so fixing the extra argument cannot increase circuit size. Unsigned duplication therefore preserves the exact integer L,T promises without hidden NOT or embedding costs. Its explicit A(q,T) overcounts every topologically described circuit, including gate counts below T and output choices. The q0 definition uses original n to bound all intermediate descriptions. The zero-cylinder base applies throughout that interval.

Hypothesis R is correctly limited to one finite slab for each original n,beta, with one epsilon and beta0 and an n0(beta) governing every intermediate q. It allows a different minimizing separator at each step, and claims no algorithm to locate one. The stated delta=epsilon(1-beta0)/2 is positive and absorbs logarithmic terms and constants for each fixed beta. Floors in L,T implement the source's integer circuit-size promise correctly.

The proposed topological-record charge is a precisely identified unresolved obligation. No average collision rate, gate deletion estimate or structural reason that a minimizing separator satisfies it has been proved. This review endorses the repaired model and conditional consequence, not its probability of success, novelty or a completed direct P-vs-NP stepping stone. No test suite or extra experiment is needed for this analytic assessment.
