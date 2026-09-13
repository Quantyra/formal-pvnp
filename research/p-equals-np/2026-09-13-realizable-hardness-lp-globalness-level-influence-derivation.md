# Binary Lp-dual globalness to actual rank-level influences

2026-09-13. S3137. Source-only derivation by incidence_complexity_review. Candidate for independent review. No Lean/compiler, paper change, Git or public action. The exact dyadic inequality below is a pending input until its separate proof is joined; Theorem5.5 or its desired influence bound is NOT an assumed input.

## Source and quantified statement

Evra, Kindler and Lifshitz, arXiv:2404.00641v2 (19 December 2024), Lemma5.1, Definition5.2, Lemmas5.3-5.4 and Theorem5.5, printed pp.12-14. Preserved `C:/Users/Dan/AppData/Local/Temp/s3134-ekl2404.00641v2.pdf`, SHA256 `fa4c9ebaf56104957b2cbb5dc3cb06f45e86152104e6311ed00a9491ddeb58c4`; same-stem `.txt`, SHA256 `7fb002153b3ac62a3238c61574b65b3a2a28de3ce253fe6272d697a63247ab1a`. The derivative core and the two separately reviewed finite globalness conversions are the local prerequisites. Satellite README/root S3137 boundaries apply; no local AGENTS file was found.

Let V,W be any finite binary vector spaces. Functions f:Hom(V,W)->C are arbitrary, with no Boolean or bounded-degree assumption. All measures and norms are uniform probabilities. Let p>=2 be a power of two and p'=p/(p-1). Let i>=0 and epsilon>=0. Suppose EVERY actual affine restriction of order at most i has L^{p'} norm at most epsilon, at EVERY base T. The norm is not squared in this premise.

I derive that g=f^{=i} has actual hybrid influences

    ||D_{A,B,T}g||_2^2<=2^(500i^2 p)epsilon^2            (LP-I)

for every dim A+codim B<=i and every T. The hybrid selector is A<=im Y and Y^-1(A)<=B; its derivative is the selected Fourier sum restricted to T+Hom(V/A,B). No rank-poset D_X is needed. The conclusion is about the actual rank-i projection of arbitrary f, not an arbitrary externally supplied low-degree approximation.

## Precise pending dyadic premise and derived duality estimate

The sole additional analytic input needed for p>=4 is the following exact pending theorem (DY200): for any finite binary spaces, any degree-at-most-j function h with actual squared-L2 globalness parameter eta on restrictions through order j,

    ||h||_p^p<=2^(200j^2 p^2)||h||_2^2 eta^(p/2-1).

It must hold simultaneously on all finite dimensions and dyadic p>=4, with the zero-function cases included. This is the quantity being proved by the separate dyadic task; this note does not replace it with a generic norm assumption. Its prerequisites must not include (LP-I), or that would be circular. The forthcoming dyadic route uses only L2 conversions and the fourth-moment theorem.

Here is the needed duality lemma derived from DY200 and the finite influence-to-globalness conversion. Let h=f^{=j}, E=||h||_2^2>0, and assume all its actual influences through order j are at most beta E. Necessarily beta>=1 because the order-zero influence equals E. Influence-to-globalness makes h squared-L2 global with parameter2^(10j^2) beta E. Taking a p-th root in DY200 gives

    ||h||_p <=2^(200j^2 p+10j^2(1/2-1/p))
                      beta^(1/2-1/p) sqrt(E)
             <=2^(210j^2 p) beta^(1/2-1/p) sqrt(E).

The equality E=<h,f> is actual orthogonal rank projection in normalized Fourier space, using the complex inner product and absolute value in Holder. Therefore

    E<=||h||_p ||f||_{p'},
    E<=2^(420j^2 p) beta^(1-2/p)||f||_{p'}^2.           (DUAL)

Dividing by sqrt(E) is done only in the E>0 branch. E=0 is trivial. This proves the relevant Lemma5.1 implication with its exact parameter powers; it does not assume a bound on influences of h unless that bound has separately been obtained. The induction below invokes it only with beta=1 AFTER proving all influences <=E in the corresponding case.

## Explicit polynomial witness in L^{p'}

For a domain line or codomain hyperplane U, let E_U be the actual order-one rank-resampling translation mixture established in the forward finite conversion. Its Fourier multiplier on rank r is zero on the selected hybrid frequencies and2^-r on unselected frequencies. Define, for j>=1,

    P_{j,U}=I-(2^j+2^(j-1))E_U+2^(2j-1)E_U^2.

Averages of translates contract the globalness parameter at fixed restriction order in ANY norm exponent p'>=1: Minkowski bounds the norm of each restricted average by the average of the norms of the corresponding restrictions at shifted bases. All bases occur in the premise. Thus both E_U f and E_U^2 f remain up-to-j,epsilon-global in L^{p'}, without the extra factor2 from a different conditioning argument.

The coefficient sum is

    K_j=(1+2^j)(1+2^(j-1))<=2^(2j+1)<=2^(3j).

Hence P_{j,U}f is up-to-j,2^(3j)epsilon-global in L^{p'}. This is an explicit norm calculation for the actual operator, not an assumed influence/globalness conversion.

For any requested base T set f'=R_{U,T} P_{j,U}f. Composition of actual affine restrictions implies f' is up-to-(j-1),2^(3j)epsilon-global on its true quotient/subspace domain. Canonical embeddings send later bases S to T+embedded(S), preserving uniform probabilities. The adjacent-rank interpolation and raw rank drop zero-or-one prove

    (f')^{=(j-1)}=D_{U,T}(f^{=j})                     (WIT)

for arbitrary f. Only original ranks j and j-1 can contribute to output rank j-1; on those levels P equals the selector. This retains all fixed-base phases and does not infer fixed-base orthogonality of coalescing individual frequencies.

## Induction, including the zero-order energy

For p>=4, induct on j simultaneously for all finite dimensions and arbitrary input functions. At j=0, the level is the constant E[f]; Holder bounds its absolute value by ||f||_{p'}<=epsilon. Its only relevant influence is therefore <=epsilon^2, proving the exact base coefficient1.

At j>=1, apply the inductive hypothesis to the explicit f' in (WIT). Every order-one derivative of f^{=j}, at every base T, has all its later influences through order j-1 at most

    B=2^(500(j-1)^2 p+6j)epsilon^2.

Every positive-order hybrid derivative through j factors as an order-one derivative followed by a lower-order derivative on the actual reduced domain. Choose a line in its nonzero domain constraint, or else a containing codomain hyperplane. Nested composition preserves the specified first base and uses zero for the later base. Thus B bounds ALL positive-order influences, not just derivatives of order exactly j.

Let E=||f^{=j}||_2^2. The maximum of B and E bounds every influence: positive orders by the proved induction and order zero by translation invariance. Split into two cases, without asserting the target bound in either premise.

* If E<=B, all influences are bounded by B. Since6j<=500(2j-1)p for j>=1,p>=4, B<=2^(500j^2 p)epsilon^2.
* If E>B, the already established positive-order influences are <=E and order zero equals E. Apply (DUAL) with beta=1. The up-to-order globalness premise includes ||f||_{p'}<=epsilon, so E<=2^(420j^2 p)epsilon^2<=2^(500j^2 p)epsilon^2. All influences are <=E in this branch.

This closes (LP-I). In particular the proof never uses DY200 on a function whose globalness was inferred from an unproved desired influence bound; the case distinction supplies that bound from lower-degree information and the actual energy.

For p=2, p'=2 and the premise is squared-L2 globalness epsilon^2. The already proved forward level conversion directly gives2^(10j^2)epsilon^2, which is <=2^(1000j^2)epsilon^2. No dyadic or duality premise is needed for this endpoint.

## Exact-order source convention and boundary cases

The source Definition5.2 uses exact-order globalness. When i<=dim V+dim W, any lower-order affine variation space is a disjoint union of cosets of a chosen order-i subspace. Averaging the p'-th powers of their normalized norms gives the lower-order bound epsilon^{p'} and therefore norm<=epsilon. Thus exact-order globalness at every base implies the up-to-order premise used here, with no parameter loss.

If i>dim V+dim W, that implication is vacuous and is NOT used; f^{=i}=0 because rank cannot exceed min(dim V,dim W), so (LP-I) holds directly. More generally every unavailable rank level gives the same direct zero case. Zero-dimensional spaces have singleton matrix domains; i=0 is the constant case and i>0 is zero. Orders above i annihilate the level, though only orders through i are claimed. Every actual induction call reduces a nonnegative level by one. If epsilon=0, the included order-zero norm bound forces f=0; in the exact-order formulation use refinement first when available, or the zero-level conclusion otherwise.

For a Boolean input F with all relevant affine densities at most delta in[0,1], its L^{p'} restriction norm is density^(1/p')<=delta^(1-1/p). Substituting epsilon=delta^(1-1/p) into (LP-I) yields the exact influence parameter

    2^(500i^2 p) delta^(2-2/p).

These are squared-L2 influences. One must not identify epsilon with density or turn the exponent into a stronger one. The subsequent influence-to-globalness and final DY200 application are separate algebraic joins; this note supplies only the required level-influence bridge.

## Remaining status

Conditional on the exact independently reconstructed DY200 theorem, the binary Theorem5.5 bridge is now derived using actual operators, duality and lower-degree induction, with the requested500i^2 p coefficient. The p=2 endpoint is unconditional on DY200 given the finite forward conversion. The DY200 proof and its independent review remain the explicit outstanding input at the time of this note. No theorem5.5 axiom, caller influence certificate, false D_X contraction, compiler result, paper claim or novelty assertion is introduced.
