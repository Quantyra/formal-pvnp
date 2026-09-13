# Independent review: Lp-dual globalness to rank-level influence

2026-09-13; S3137. Full candidate reviewed: `2026-09-13-realizable-hardness-lp-globalness-level-influence-derivation.md`, SHA256 `7b0e90c2e3ba37b513624b935bbc55dc6044bdf64c90f2acaf2f3b5f66f187c6`. Verdict: GO for the finite bridge conditional on the separately reviewed DY200 input. No circular influence premise or mathematical blocker found.

## Independence, source and input boundary

I did not author the Lp-dual bridge. I authored the separate square-globalness/dyadic derivation and parts of its earlier Fourier/derivative and L2 conversion foundations; that reliance is disclosed rather than presented as independent re-verification of my own work. I reviewed the entire bridge's argument, its actual witnesses, induction and numerical exponents. No compiler, source modification, experiment or Git action was used.

The primary comparison source is Evra/Kindler/Lifshitz arXiv:2404.00641v2, section 5; preserved text SHA256 `7fb002153b3ac62a3238c61574b65b3a2a28de3ce253fe6272d697a63247ab1a`, PDF SHA256 `fa4c9ebaf56104957b2cbb5dc3cb06f45e86152104e6311ed00a9491ddeb58c4`. This review concerns the candidate's finite proof, not an assertion that citing source Theorem 5.5 proves the target.

The actual pending DY200 input now has an explicit separate derivation: `2026-09-13-realizable-hardness-square-globalness-dyadic-derivation.md`, SHA256 `3c75f32e997b35156178ebbc9165717de55485565eb379d64eacc4eaefd0a98c`. Its statement matches exactly: normalized p-th moment of an actual degree-at-most-j function with up-to-j squared-L2 globalness eta is at most 2^(200j^2 p^2)||h||_2^2 eta^(p/2-1). It holds on arbitrary finite binary dimensions and dyadic p>=2. It uses only the fourth-moment and L2 conversions, not this bridge, so the dependency direction is noncircular. Its separate review remains required; this report is not a self-review of DY200.

## Explicit witness and positive orders

The polynomial P_(j,U) uses the actual translation-mixture E_U. For p'=p/(p-1)>=1, Minkowski on each fixed affine restriction bounds E_U and its square by the same norm parameter, because all shifted bases are part of the premise. There is no conditioning-density factor from the different reverse-conversion averaging argument. The coefficient sum K_j=(1+2^j)(1+2^(j-1)) is at most 2^(3j) for every j>=1.

The adjacent-level witness identity is applicable to arbitrary f, not only a bounded-degree function. Raw order-one restriction loses rank zero or one; only the original levels j and j-1 can reach residual level j-1, and the polynomial cancels the unselected parts of both. Canonical composition of affine restrictions proves the reduced function's actual up-to-(j-1) Lp-prime globalness at every shift. Both line and hyperplane choices are covered by the previously proved actual operators.

Applying lower-degree induction to this witness gives B=2^(500(j-1)^2 p+6j)epsilon^2. The 6j is the square of the norm multiplier, correctly distinguished from squared-norm globalness. Every positive-order hybrid derivative through j factors through such an order-one derivative, so the bound covers all positive orders, not merely order j.

## Zero-order energy, duality and noncircularity

Let h=f^{=j} and E=||h||_2^2. At E>B, the already established positive-order bound B and the exact zero-order energy E show that all actual influences are at most E. This conclusion precedes any use of DY200 and does not assume the desired final 500 bound. The reverse conversion therefore gives actual squared-L2 globalness eta=2^(10j^2)E.

More generally, if the influences are bounded by beta E, the p-th root of DY200 gives precisely

    ||h||_p <= 2^(200j^2 p+10j^2(1/2-1/p))
               beta^(1/2-1/p) sqrt(E).

The orthogonal projection identity |<h,f>|=E and normalized Holder yield the stated DUAL estimate after division by sqrt(E), only in the E>0 branch. The exponent can safely be bounded by 420j^2 p after squaring. The candidate then uses beta=1, so no unproved relation between beta and epsilon enters the argument.

In the other branch E<=B, B already bounds every influence. The inequality 6j<=500(2j-1)p holds for j>=1,p>=4 and absorbs the witness loss. Thus both branches give exactly the required 500j^2 p coefficient. The j=0 constant case is proved directly by Holder, and p=2 uses the existing forward L2 level bound, independent of DY200.

## Density and dimensional boundaries

The premise is an Lp-prime norm at most epsilon, not a density or a squared norm. For Boolean restrictions of density at most delta, the substitution epsilon=delta^(1-1/p) gives the squared-influence factor delta^(2-2/p), as stated. This includes delta=0 by the direct zero case; it does not strengthen the density exponent improperly.

Exact-order-to-up-to-order refinement averages p'-th powers over the actual coset partition and incurs no parameter loss when i<=dim V+dim W. If that dimensional condition fails, the rank-i projection is zero directly; the candidate does not infer full-function globalness from an empty family. The all-shift induction calls operate on the genuine quotient/subspace domains, including singleton spaces. These distinctions are sufficient for this rank-level conclusion, though not for an unrelated full-function exact-order claim.

## Conclusion boundary

The bridge is a finite proof from the precise DY200 theorem and the accepted actual L2 conversions. The only mathematical input conditionality retained here is the separate DY200 proof/review, not source Theorem 5.5 or an assumed target influence certificate. The subsequent Boolean hypercontractivity 500 join is separate. No Lean acceptance, full paper certification, upstream hardness, novelty or P-vs-NP conclusion is claimed.
