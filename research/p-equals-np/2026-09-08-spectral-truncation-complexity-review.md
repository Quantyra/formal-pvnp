# Spectral truncation: independent complexity review

2026-09-08. S3040 / S008 / E004. Baseline 3ecc518. Reviewed the stable `2026-09-08-spectral-truncation-attempt.md` in full. Harness only; no commits, code changes, numerical suites or planning edits.

## Exact spectral and error calculations

The normalized Walsh orthogonality, inversion, Parseval identity and eigenvalues -2|S| follow directly from coordinate cancellation and flips. Because every omitted set is nonempty, its coefficient energy is at most alpha-alpha^2, giving the stated1/2 Cauchy--Schwarz bound. The alternate absolute bound follows from |f_hat(S)|<=alpha. Both are pointwise error bounds, not just statements about mean-square energy.

The coefficient-error term is correctly additive with spectral weights. Since D_d<=2^n, allocating epsilon/(2D_d) per coefficient still requires only O(n) precision bits at the stated epsilon. The exponentially many possible coefficients are a separate representation and evaluation cost.

## Fixed-time necessity and its precise scope

For the unit-clause singleton at0^n, all Fourier coefficients are2^(-n) and every character at the readout vertex is positive. The omitted tail therefore has no cancellation. Its single-term lower bound gives the necessary condition d+1>=((n+2)log2)/2 at time1. The weaker integer consequence d>=floor(n/4) is valid, and including all subsets of that many coordinates proves the explicit coefficient count bound2^floor(n/4).

This is a lower bound for the specified all-subsets degree cutoff satisfying the coordinate-approximation contract. Listing its retained nonzero terms has superpolynomial cost in the explicit singleton-CNF encoding. It is not a lower bound on succinct evaluation: the same instance has the product formula a(t)^n and a compact shared spectral description.

At the dyadic propagator time, the omitted degree-n term alone is4^(-n), so any proper cutoff misses the required error tolerance. The note correctly keeps its irrational-time and rational-matrix interpretations separate. It also correctly observes that failed approximation is not failed SAT classification on this example: even the degree-zero output would classify it correctly. No decision hardness follows from that representation test.

## Longer smoothing and the constant mode

At rational time2n, each bit's kernel differs from a fair bit by exp(-4n)/2 in total variation. Replacing factors one at a time yields the pointwise expectation error at most n exp(-4n)/2. The elementary estimates exp(2)>4 and4n<=4^n prove the displayed strict bound below4^(-n)/8, including n=1.

Thus the constant-mode approximation really does meet half of the old readout budget at this new horizon. Computing the constant mode to the other half would give the full claimed coordinate accuracy. This is a valid scalar approximation of the smoothed state, but it supplies no algorithm for the scalar's value.

The conserved mean is exactly the uniform satisfying-assignment fraction. Its zero-versus-at-least2^(-n) gap gives the stated one-way SAT reduction from additive2^(-n)/4 evaluation. This needs only n+O(1) precision bits; the tighter heat approximation uses2n+O(1). Neither bit length supplies efficient aggregation. Longer modeled time suppresses nonconstant modes while leaving this unresolved coefficient intact.

## Source and algorithmic boundary

The candidate proves its finite spectral and kernel claims directly; it imports no generic counting-hardness, approximation-hardness or converse theorem. Explicit truth-table coefficient calculation is exponential work, but this is a cost of that implementation, not a universal lower bound. Shared products, alternative representations and other succinct algorithms are not excluded by the singleton test.

The remaining task is uniform polynomial bit-work evaluation of the required coefficient or heat output from arbitrary CNF, with the specified error. The full state and original initialization remain exponentially dimensioned; suppressing spectral modes analytically does not establish an efficient preprocessing or evaluation procedure, nor invoke a fixed-dimensional analog complexity characterization.

Final verdict: GO for the truncation bounds, explicit-listing obstruction and longer-time constant-mode approximation. NO-GO for treating that fixed-time explicit degree listing as a uniform polynomial evaluator. INCOMPLETE for a general coefficient algorithm, deterministic polynomial SAT and P=NP. No mathematical or complexity-scope corrections were required in the saved candidate.
