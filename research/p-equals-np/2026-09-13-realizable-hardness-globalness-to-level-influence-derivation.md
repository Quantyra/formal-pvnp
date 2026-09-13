# Binary restriction globalness gives all lower-order level influences

2026-09-13. S3132/S3134/S3137. Complete finite derivation of the binary Lemma-64/Proposition-63 implication with actual normalized affine restrictions. No Lean execution or new module, manuscript edit, Git operation or public action. This does not by itself prove the later dyadic hypercontractive theorem or the full paper.

## Primary identities and scope

Ellis, Kindler and Lifshitz, arXiv:2209.04243v1: Definition 41, Lemmas 43-44 and 59-64, Proposition 63 (printed pp24-25,35-37). Preserved text `C:/Users/Dan/AppData/Local/Temp/s3134-ellis2209.04243v1.txt`, SHA256 `9259246e882f05e02fb8585400fed15b6a1d9e68106cbcd813c8851ecfdc468a`; PDF SHA256 `4455f4a757b2abc1b7a3dd41f3495b68bf2e2b9aa4d05a5b0953fe4e751a991f`.

Evra, Kindler and Lifshitz, arXiv:2404.00641v2, Definition 2.1 and Proposition 2.5 cite precisely this ancestry. Preserved text `C:/Users/Dan/AppData/Local/Temp/s3134-ekl2404.00641v2.txt`, SHA256 `7fb002153b3ac62a3238c61574b65b3a2a28de3ce253fe6272d697a63247ab1a`; PDF SHA256 `fa4c9ebaf56104957b2cbb5dc3cb06f45e86152104e6311ed00a9491ddeb58c4`. The two first authors are different. The exact-order convention of the later paper is reconciled explicitly in section 7.

The reviewed finite derivative core at 0e5e5d090b80c8077e6485277dabfcfafb0093ed supplies canonical nested composition and the correct below-order zero case. No rank-poset D_X contraction is used. Indeed no D_X operator is needed for this proof.

## 1. Definitions and quantified target

Let V,W be arbitrary finite-dimensional F2 spaces, possibly zero dimensional. Functions f:Hom(V,W)->C are arbitrary, without a degree or Booleanity assumption. Equip every finite function space with uniform probability. Frequencies Y:W->V have character chi_Y(M)=(-1)^Tr(YM), normalized Fourier coefficients and rank level f^{=d}.

For A<=V,B<=W let q_A:V->V/A and j_B:B->W be the canonical maps. The affine restriction is

    R_AB,T f(N)=f(T+j_B N q_A), N in Hom(V/A,B).

Its order is dim A+codim_W B. Say f is up-to-d epsilon-global if ||R_AB,T f||_2^2<=epsilon for every order at most d and every T:V->W. Assume epsilon>=0. The hybrid selector L_AB retains precisely the frequencies with A<=im Y and Y^-1(A)<=B. Set D_AB,T=R_AB,T L_AB and I_AB,T(g)=||D_AB,T g||_2^2.

We prove, for every natural d, every such f, every order k<=d and every T,

    I_AB,T(f^{=d}) <= 2^(10d^2) epsilon.                (GI)

In fact the proof gives the explicit smaller bound 2^(4kd-2k^2+4k) epsilon. Keeping the advertised 10d^2 leaves later bookkeeping unchanged. The d=0 case means k=0 and requires no degree subtraction.

## 2. Actual averaging operators, including the dual direction

For a line U=<u> in V with u nonzero, choose phi uniformly among linear functionals with phi(u)=1 and w uniformly in W, independently. Define

    E_U f(M)=E_phi,w f(M+w phi),

where w phi maps v to phi(v)w. This is the source's average over hyperplanes complementary to U and all translations supported on the resulting one-dimensional quotient. Over F2, each such hyperplane has a unique functional phi with phi(u)=1, so the distributions agree exactly.

On a character, averaging over w annihilates it unless phi Y=0. If u is in im Y no permitted phi can annihilate im Y. If u is not in im Y, the count of phi annihilating im Y and taking u to 1 is 2^(dim V-rank Y-1), out of 2^(dim V-1). Hence E_U has multiplier zero when U<=im Y, and 2^(-rank Y) otherwise.

For a hyperplane B in W let psi:W->F2 be the unique nonzero functional with ker psi=B. Choose w uniformly with psi(w)=1 and phi uniformly in V*, independently, and define

    E_B f(M)=E_w,phi f(M+w phi).

Averaging phi retains chi_Y only when Yw=0. If ker Y<=B the probability is zero. Otherwise psi is nonzero on ker Y and the probability is 2^(dim ker Y-1)/2^(dim W-1)=2^(-rank Y). Thus E_B has multiplier zero on the hyperplane hybrid selector ker Y<=B and 2^(-rank Y) elsewhere. This proves the dual statement directly, without importing an unquantified symmetry convention.

Both distributions are nonempty whenever the corresponding line or hyperplane exists, including one-dimensional boundary spaces. If the other space has dimension zero, its unrestricted uniform distribution is the singleton distribution; the formulas still hold.

For either order-one choice denote the averaging operator by E and its hybrid Laplacian by L. On rank-r frequencies the preceding formulas prove

    L(f^{=r}) = f^{=r} - 2^r E(f^{=r}).                (59*)

Here L is the Fourier selector, not the source's separately named combinatorial operator I-E. The identity includes r=0; the order-one selector annihilates the zero frequency.

## 3. Two adjacent levels and exact restriction identity

For an integer d>=1 define the actual polynomial averaging operator

    P_d=(I-2^d E)(I-2^(d-1) E)
       = I-(2^d+2^(d-1))E+2^(2d-1)E^2.

On each of the original rank levels d and d-1, P_d equals L: selected frequencies have E multiplier zero and are retained, while unselected frequencies have multiplier 2^-r and one factor vanishes. E is Fourier diagonal, so no ranks are mixed by P_d.

A raw line restriction R_UW,T sends a rank-r character to a character of rank r-1 precisely when U<=im Y, and to rank r otherwise. This follows by quotienting the image by a line. A raw hyperplane restriction R_0B,T sends it to rank r-1 precisely when ker Y<=B, and to rank r otherwise: rank Y-rank(Y|B)=1-dim(ker Y/(ker Y intersect B)). Both restrictions preserve the phase chi_Y(T).

Therefore only original ranks d and d-1 can contribute to output rank d-1. On those levels P_d agrees with L. The selected rank-d terms drop to d-1. The selected rank-(d-1) terms drop to d-2 and cannot contribute; when d=1 the rank-zero selected part is zero rather than a degree-Nat(-1) term. We obtain for every f and every actual base T

    (R_order1,T P_d f)^{=(d-1)}
       = D_order1,T(f^{=d}).                           (61*)

All other original ranks are excluded by the raw rank-drop-zero-or-one argument. This is valid for arbitrary f, not just functions supported on adjacent levels. It does not misuse the known natural-number subtraction pitfall for derivatives of levels below their order.

## 4. Translation mixtures preserve the precise globalness hypothesis

Each E above is a convex combination of translations f(M)->f(M+Z), with a distribution on Z independent of M. For any actual restriction, the restricted translate is R_AB,(T+Z) f. Thus if f is up-to-d epsilon-global, each such restricted translate has L2 norm at most sqrt(epsilon). Triangle inequality for finite averages gives

    ||R_AB,T E f||_2 <= sqrt(epsilon)

for every order at most d and every T. The same holds for E^2, either by another application or by viewing it as a mixture of two independent translations. This argument uses all affine bases in the hypothesis; it introduces no conditioning or density factor.

The coefficient sum in P_d is

    K_d=1+2^d+2^(d-1)+2^(2d-1)
       =(1+2^d)(1+2^(d-1)) <= 2^(2d+1).

Consequently P_d f is up-to-d, K_d^2 epsilon-global, and in particular up-to-d, (4*2^(4d))epsilon-global. This is a norm estimate for an explicit mixture polynomial, not an assumed influence certificate.

## 5. Explicit one-step witness at every shift

For any chosen order-one derivative with base T define the actual function

    f' = R_order1,T P_d f.

Then (61*) gives (f')^{=(d-1)}=D_order1,T(f^{=d}). The choice of base is the given T, not an unproved reduction to zero.

Every restriction of f' of order at most d-1 is a restriction of P_d f of total order at most d. For a first line U, a subspace A' of V/U lifts to A2=q_U^-1(A') of dimension 1+dim A', and the codomain restriction is unchanged. Its base S embeds canonically as j_W S q_U, so the parent affine base is T+j_W S q_U. For a first codomain hyperplane H, a later B'<=H has codimension 1+codim_H B' in W; its base embeds as j_H S and the parent base is T+j_H S. The natural double quotients identify the variable domains. All embeddings are injective linear maps onto the actual restriction subspaces, so uniform probabilities agree.

The bound of section 4 therefore proves that f' is up-to-(d-1), (4*2^(4d))epsilon-global. This proves the full binary Lemma-64 witness, for both directions and arbitrary T.

## 6. All orders, not just exact order d

We prove the finer bound in section 1 by peeling off k order-one derivatives. If k=0, D_0W,T is translation, so Parseval and the order-zero globalness hypothesis give

    ||D_0W,T(f^{=d})||_2^2=||f^{=d}||_2^2<=||f||_2^2<=epsilon.

If k>0 and A is nonzero, choose a line U<=A. Apply the one-step witness to D_UW,T. Canonical nested composition with the remaining derivative D_(A/U),B,0 yields exactly D_AB,T. If A=0, then B is proper; choose a hyperplane H containing B, apply the witness to D_0H,T, and take the remaining derivative on Hom(V,H) at base zero. In both cases the level and globalness budget drop by one, and the remaining derivative order is k-1. This choice is possible whenever k>0, even when one of the two ambient spaces is zero dimensional.

Repeat exactly k times. Subsequent first-step bases are zero; the first base was the arbitrary requested T. Nested composition preserves that original phase. At the end, the desired derivative is the rank-(d-k) projection of a concrete function on the final quotient/subspace space, up to its order-zero translation. Its squared L2 norm is at most that function's globalness parameter by Parseval. The accumulated bound is

    epsilon * product_{r=d-k+1..d}(4*2^(4r))
      = epsilon * 2^(4kd-2k^2+4k).

This proves every k<=d, including k<d. The exponent increases with k on 0<=k<=d and is at most 2d^2+4d. For d>=1 this is at most 10d^2. For d=0 only k=0 occurs, with exponent zero. Hence (GI) holds with the unchanged advertised 10d^2.

No lower-order case is inferred merely from an exact-order-d induction hypothesis. The printed Proposition-63 proof's displayed exact-order choice is replaced by this explicit all-orders argument. The natural subtraction d-k always has k<=d; any order greater than d annihilates the rank-d level by the already proved rank-drop selector and needs no iteration.

## 7. Later exact-order globalness convention and dimensional boundaries

EKL22 Definition 62 uses all orders at most d. EKL24v2's displayed Definition 1.5/section 2.2 uses order exactly d. The bridge is elementary but must not be silently assumed.

Suppose d<=dim V+dim W. Given a restriction of order k<=d, enlarge its domain-fixed subspace and shrink its codomain subspace until the order is d. This is possible because the available additional dimensions total dim V+dim W-k. The smaller variation space Hom(V/A2,B2) is a linear subspace of the original variation space Hom(V/A,B). The original affine coset is a disjoint union of its cosets, each an actual order-d restriction at some parent base. Uniform averaging of their squared L2 norms gives the lower-order squared norm. Therefore an exact-order-d bound at all bases implies the up-to-d hypothesis with the same epsilon.

If d>dim V+dim W, exact-order globalness is vacuous, but the rank-d projection is identically zero because every frequency rank is at most min(dim V,dim W). Thus the advertised level-influence conclusion holds directly; no lower-order globalness is inferred from an empty family. More generally d>min(dim V,dim W) already gives this zero conclusion. At d=0 the exact-order condition is the whole-space L2 bound and the previous proof applies.

This reconciles the actual later Proposition 2.5 with the original all-orders result without any hidden ambient lower bound or rank-conditioning factor. The proof works for epsilon=0 as well, although the printed versions state epsilon>0.

## 8. Full bounded-degree corollary by orthogonality

Suppose f has degree at most d and is up-to-d epsilon-global. For a fixed hybrid derivative of order k<=d, every original rank-i level with i<k is annihilated. The others have distinct output ranks i-k. Consequently their images are orthogonal on the actual quotient/subspace domain, at every fixed base T, even if frequencies within an individual level coalesce. Parseval between these distinct levels gives the exact equality

    I_AB,T(f)=sum_{i=k..d} I_AB,T(f^{=i}).

For each i<=d, the original f is up-to-i epsilon-global. Apply (GI) with level i and the same derivative of order k<=i. Thus

    I_AB,T(f) <= sum_{i=k..d}2^(10i^2)epsilon
               <= (d+1)2^(10d^2)epsilon
               <= 2^(11d^2)epsilon, d>=1.

The last step uses d+1<=2^d<=2^(d^2). At d=0 only order zero occurs and the norm bound is epsilon directly. Orders greater than d annihilate f. This establishes the full-function influence bound needed by subsequent 114/41 bookkeeping, using orthogonality rather than a squared triangle bound.

The assumption here is explicitly globalness at all orders up to d. An exact-order-d premise implies it by section 7 only when d<=dim V+dim W. If d>dim V+dim W that premise is vacuous and the full bounded-degree function need not be zero: for example a nonzero constant survives. Therefore the full-function corollary under an exact-order convention requires that dimension condition or an independent up-to-d bound; the high-level zero argument of section 7 cannot be substituted for it.

## Outcome and remaining dependency boundary

The implication from actual binary restriction globalness to all generalized influences of the actual rank-d projection is proved here with constant 2^(10d^2), explicit witness functions, translations, dual averaging and dimension cases. No Boolean assumption is required. It does not use the fourth-moment theorem, the opposite influence-to-globalness implication, or the invalid rank-poset contraction.

The independently routed opposite conversion is a separate artifact. Their combination and the repaired dyadic square-globalness recurrence still require an explicit reviewed join before declaring the full MZ hypercontractivity import discharged. All mathematical derivations remain distinct from kernel verification, upstream PCP/source-hardness and complete paper proof. No new public or novelty claim follows from this reconstruction of known machinery.
