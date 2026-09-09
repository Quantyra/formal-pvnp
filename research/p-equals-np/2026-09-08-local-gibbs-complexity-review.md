# Local Gibbs implementation: independent complexity review

2026-09-08. S3040 / S008 / E004. Baseline c805419. Reviewed the stable `2026-09-08-local-gibbs-attempt.md` in full. Harness only; no commits, code changes, simulations or planning edits.

## Chain and source boundary

This is a specified randomized implementation candidate for the finite Gibbs lift, not a claim about the earlier analog ODE. The stationary and lower-bound arguments are direct finite-chain calculations. No external generic mixing, counting-hardness or convergence-rate theorem is imported.

The heat-bath conditional fixes every other bit, whereas the required inference primitive fixes only a prefix and sums over remaining coordinates. This distinction is substantive and is correctly maintained. Positivity makes the finite chain irreducible with self-loops, and the detailed-balance formula is exact. The finite-block minorization argument establishes eventual convergence at each fixed size without supplying a useful uniform rate.

A local update is implementable at polynomial expected bit cost. The violation-count difference yields a rational Bernoulli parameter with O(nM) bits, and rejection sampling of a uniform integer below its denominator has success probability greater than1/2 per attempt. Selecting a site has the same expected-cost construction. The unbounded rejection tail is acknowledged; no deterministic worst-case sampling contract is inferred.

## Exact growing-family obstruction

Each disagreeing edge of the equality-path CNF violates exactly one of its two clauses. Encoding an assignment by its first bit and edge-disagreement bits gives Z_n=2(1+q)^(n-1). Complement symmetry gives stationary one-site marginal1/2, while the stationary mass of0^n is at most1/2.

Starting at0^n, an endpoint flip costs one violation and an interior flip costs two. Equation (5) is therefore the exact departure probability, including n=2. The bounds r_n<=q and r_n<=3q/n follow from n q<=1. Until the first departure the transition law remains the same; thus the probability of no departure for k steps is exactly(1-r_n)^k and at least1-k r_n. Returns can only strengthen the stated lower bound on mass at0^n.

Testing the singleton event gives total variation at least1/2-k r_n. For k<=n/(24q), the product k r_n is at most1/8, so the distance remains at least3/8. The worst-start mixing time to error1/4 is consequently greater than the displayed integer horizon, yielding Omega(n4^n). The formula's O(n log n) explicit encoding makes this superpolynomial in encoded length. The draft does not incorrectly claim an exponential lower bound in every encoding convention.

The marginal statement follows directly, independently of whether total variation's worst event is relevant: a bit cannot become one before a departure. Its endpoint marginal bias is at least1/2-k r_n. For raw frequencies from that chain history, no departure makes every sample zero; with probability at least7/8 the resulting error is1/2 over the stated horizons. Burn-in plus a raw sampling window must count all updates and has the same obstruction when their combined length is in range.

These are worst-start and specified-estimator results. Complement-symmetric initial distributions preserve exact one-site marginals, so the conclusion does not cover every initialization. The all-zero starting state already satisfies the equality formula. Therefore failed estimation from this start is not failed SAT output, and the result is not a lower bound for every inference method or every SAT algorithm.

## Exact inference contrast

The forward recurrence correctly inserts the allowed-bit indicator and sums the two predecessor values with edge weight1 or q. The backward recurrence accounts for all future constraints without counting the current indicator twice. Their product divided by the positive restricted partition sum gives the conditional marginal for every consistent prefix, with the original q retained.

The rescaling by2^(2n(i-1)) gives the displayed integer recurrence. Forward and backward values, their products and marginal ratios have O(n^2)-bit integer representations. O(n) arithmetic operations per message pass therefore translate to polynomial bit work; polynomially many repeated prefix queries remain polynomial. This is an actual finite exact inference method for the path family, not merely a compact factor description assumed to be evaluable.

The easy path calculation and the exponential worst-start chain bound are compatible. Endpoint elimination retains a bounded boundary on this family; no corresponding arbitrary-CNF structural guarantee has been established.

## Final verdict

GO for the cheap expected-cost local update, exact worst-start mixing and raw-marginal obstruction, and polynomial exact path inference. NO-GO for a uniform worst-start polynomial mixing claim for this specified chain and for the stated raw estimator meeting the marginal tolerance on the displayed run horizons. INCOMPLETE for a deterministic uniformly efficient inference primitive on arbitrary CNF and its adaptive prefixes. Randomized sampling alone does not supply the previous always-correct deterministic contract. No mathematical or complexity-scope corrections were required; no general SAT lower bound or P=NP conclusion follows.
