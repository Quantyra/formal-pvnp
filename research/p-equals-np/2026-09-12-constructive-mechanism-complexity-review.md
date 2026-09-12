# Constructive mechanism: independent complexity and source review

2026-09-12; S3083/E004/S008. Scope: the proposed strong-field partition evaluation followed by a sparse formula-independent average over field centers. This is an agent mathematical/source review under [integrity](../../INTEGRITY-CLAIMS.md), not formal verification or novelty certification. Final inspection of the [main derivation](2026-09-12-constructive-mechanism.md) is GO for its bounded claims; the graph is outside this review unless separately recorded.

## Independently inspected source contract

I opened [Barvinok arXiv:2608.03687v2](https://arxiv.org/pdf/2608.03687v2), revised August 16, 2026, independently of the author. Theorem 1.2 requires rp >= 12. Thus its advertised large-interaction improvement does not directly apply with width r=3; increasing r to satisfy its premise does not permit arbitrarily large incident interaction strengths, since its influence cap is at most 1/(10 sqrt(12)).

The applicable small-p Theorem 1.3 requires p=exp(-6L)/r and incident Lipschitz sum <= L/5. For penalties -beta times clause-violation indicators, width <=3 and maximum occurrence Delta, choosing L >= 5(1+2 delta) beta Delta supplies the Section 1.5 approximation slack, at the cost of exponentially small p. Center translation preserves Lipschitz constants and occurrence counts. This checks applicability of the cited statement; it does not independently certify that preprint's proof.

Section 1.5 computes up to m^(k+1) local moments of cost O(2^(rk)), with k=O_delta(log log M-log epsilon) and M=3 exp((1+2 delta)r sum_i L_i). This is explicitly quasipolynomial for fixed r and constant error under polynomial input parameters. Polynomial-time arithmetic from supplied moments is not a polynomial-time algorithm to obtain those moments. Polynomially many centers alone would therefore not establish P=NP. Precision, field representation and aggregation still require bit-cost analysis.

## Independent mathematical checks

For n unit clauses selecting a, set t=exp(-beta). The soft weight at x is t^d(x,a). Under independent flips of probability p around center c, the expectation factors exactly as

Q_c(F_a)=(q+pt)^(n-d(c,a)) (p+qt)^d(c,a)
         =(1+t)^n K_{p'}(c,a),

where p'=(p+qt)/(1+t), q=1-p, and K is the binary product-noise transition matrix. The uniform expectation is ((1+t)/2)^n. For beta=(n+3)ln2 and the stated strong field, p' < 2^(-n-1).

For a omitted from a fixed stencil's support, each K_{p'}(c,a) <= p'. Consequently nonnegative weights summing to one cannot approximate the uniform expectation within relative error 1/2 for all these formulas. This is a finite-temperature calculation, not an interchange of limits. Exact signed reconstruction for every a forces uniform full-support weights: the one-bit matrix has eigenvalues 1 and 1-2p', both nonzero, so its tensor power is invertible and fixes the uniform vector.

These formulas are easy. An adaptive algorithm can read their clauses and choose c=a. The calculation refutes the specified universal stencil, not SAT algorithms that inspect the formula, nonlinear aggregation, implicit sums computed through special structure, or all analytic-continuation paths. A signed approximate stencil's large coefficient norm is an error-amplification obligation, not by itself an exponential bit-complexity lower bound.

The elementary decision gap also checks: beta=(n+3)ln2 gives Z>=1 for satisfiable formulas and Z<=1/8 for unsatisfiable formulas, since every nonsatisfying assignment has at least one violation. A deterministic uniform polynomial-time algorithm approximating this Z to additive error 1/4 for every width-three CNF would decide SAT. No such algorithm is obtained. Center-specific relative evaluation is a different query from this global decision-resolution guarantee.

## Significance and publication

The original source already presents soft-constraint penalties. Averaging all translated product measures to recover uniform expectation and diagonalizing binary noise are known mathematical ingredients. The proposed new capability was efficient removal of the field while retaining decision resolution, and that capability was not established. Source applicability and exact diagnostic correctness do not establish a new application or priority.

Final decision: GO for the narrowly scoped rejection of a sparse formula-independent positive averaging mechanism and the exact signed identity; HOLD for publication as a research contribution. No P-versus-NP result, novel solver, unrestricted impossibility, executed experiment, or goal completion is certified. No author or graph edits, commit, push, paid work, or external messages were made by this reviewer.

## Final main inspection

I read the saved main derivation after independently checking the source and formulas. It correctly restricts the exponential-support result to fixed formula-independent stencils, uses the finite soft family, explicitly weakens the signed approximate conclusion to a constant conditioning bound in that family, charges the source quasipolynomial moment work, and preserves adaptive/nonlinear/implicit aggregation escapes. Its locality ratio follows by taking product expectations of the Delta-Lipschitz upper/lower bounds. The final source/correctness-scope decision is GO; publication remains HOLD for lack of an established research contribution. Separate proof review supplies the other lens; neither agent lens certifies novelty or P-versus-NP progress.
