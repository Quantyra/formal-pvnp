# Independent Lp-dual level-influence review

2026-09-13. S3137. compact_source_encoding_audit. I read the complete final `2026-09-13-realizable-hardness-lp-globalness-level-influence-derivation.md` and freshly verified SHA256 7b0e90c2e3ba37b513624b935bbc55dc6044bdf64c90f2acaf2f3b5f66f187c6. I did not author this bridge. Prior contributions to the derivative/fourth-moment chain and reviews of conversions/DY200 are disclosed; this is not a kernel certification. No compiler, Lean/paper edits, Git or public action.

**Bounded mathematical GO for the exact bridge**, once joined to the independently reconstructed DY200 rather than an assumed source theorem. The required DY200 input is exactly the final square-globalness/dyadic derivation3c75f32e997b35156178ebbc9165717de55485565eb379d64eacc4eaefd0a98c, fully read and reviewed separately. That proof uses only the finite fourth moment and L2 conversions, so it does not depend on this L^{p'} bridge. Final combined HC acceptance remains a separate cross-review/root step.

## Actual hypotheses and duality

The premise bounds the L^{p'} norm, not its square, on every affine restriction through order j and at every base, with p'=p/(p-1), dyadic p>=2. The conclusion is squared-L2 hybrid influence of f^{=j}. The input function may be complex and need not have bounded degree; the projected function does have degree at most j.

For h=f^{=j}, E=||h||_2^2>0, suppose all its actual influences through j are <=beta E. The order-zero influence forces beta>=1. The proved reverse conversion supplies squared-L2 globalness2^(10j^2)beta E on actual restrictions through j. Applying DY200 and taking a p-th root gives

    ||h||_p<=2^(200j^2p+10j^2(1/2-1/p))
              beta^(1/2-1/p) sqrt(E).

The E exponents combine as1/p+(1/2-1/p)=1/2. The coarse coefficient210j^2p is valid for p>=2. The normalized complex orthogonal-projection identity is <h,f>=E, so Holder gives E<=||h||_p||f||_{p'}. Divide only in the E>0 branch and square to obtain

    E<=2^(420j^2p) beta^(1-2/p)||f||_{p'}^2.

This checks both the420 coefficient and the beta power. E=0 is separately trivial. The bound is not applicable until its influence hypothesis has actually been established; the induction below obeys that restriction.

## Concrete lower-level witness

The polynomial in the actual translation mixture is P_j=(I-2^jE_U)(I-2^(j-1)E_U). Mixtures of translations preserve all-base restriction bounds in L^{p'} by finite Minkowski, since p'>=1. Its coefficient sum is <=2^(2j+1)<=2^(3j) for j>=1. Thus the actual function f'=R_(U,T)P_j f has up-to-(j-1) L^{p'} bound2^(3j)epsilon.

The previously proved adjacent-level identity says (f')^{=j-1}=D_(U,T)(f^{=j}). It is valid at every base, for both the domain-line and codomain-hyperplane choices, and for arbitrary f. It uses the raw rank drop zero-or-one and removes contamination from original levels j and j-1 explicitly; it does not commute projection with restriction naively. Subsequent restriction bases compose canonically, preserving normalized measure.

## Positive influences first, then energy

Induct on j over all finite spaces and arbitrary f. At j=0, the projected function is the mean and Holder bounds its absolute value by epsilon, so its only relevant influence is <=epsilon^2.

At j>=1, the induction hypothesis applied to f' gives the bound

    B=2^(500(j-1)^2p+6j)epsilon^2

on every later influence through j-1 of each order-one derivative. Every positive-order derivative through j factors into such an order-one derivative followed by a lower-order one. The proof chooses a domain line or a containing codomain hyperplane as appropriate; arbitrary bases are retained by composition. Thus B is proved for all positive orders, not assumed from the desired conclusion.

Order-zero energy E=||f^{=j}||_2^2 is handled afterward. If E<=B, all influences are <=B, which is <=2^(500j^2p)epsilon^2 since6j<=500(2j-1)p. If E>B, the already proved positive influences are <=E and the zero-order influence equals E. Only now is the duality bound used with beta=1, yielding E<=2^(420j^2p)epsilon^2. This bounds every influence by the target coefficient500. The proof has no circular current-level influence assumption.

For p=2 the direct L2 level conversion is enough: the premise becomes squared-L2 globalness epsilon^2, giving2^(10j^2)epsilon^2<=2^(1000j^2)epsilon^2. The endpoint does not import DY200 or rely on a limiting dual exponent.

## Dimension and normalization boundaries

Exact-order globalness implies up-to-order globalness when the order is available: partition the larger variation coset into equal-size cosets of a chosen exact-order variation subspace and average their p'-th moments. When j exceeds dim V+dim W, that refinement is unavailable, but f^{=j}=0; no global norm bound is inferred from an empty family. Any rank above the available matrix rank similarly vanishes. The j=0 and zero-dimensional cases have their direct mean/zero proofs. Epsilon=0 is handled through the order-zero premise, or via the zero-level case in an unavailable exact-order formulation.

For Boolean F of density at most delta on each relevant restriction, the norm is density^(1/p') and the bridge parameter is epsilon=delta^(1-1/p). Squaring it yields exactly delta^(2-2/p), not delta^2 or a stronger unsupported density power. No assumption of basis invariance or full-rank matrix conditioning is used.

The author note's description of DY200 as pending records its creation-time state. The exact DY200 candidate has now been fully read and independently checked, with the dependency direction audited above. This supplies a complete finite mathematical LP-I argument for the stated actual operators; the combined500 Boolean bound requires the separate final algebraic join and cross-review. Lean verification, full manuscript, upstream hardness and publication/novelty claims remain outside this verdict.
