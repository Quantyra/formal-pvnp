# Weighted fourth powers without pointwise derivative contraction

2026-09-13; S3132/S3134/S3137. Binary finite-matrix derivation. No Lean execution, new module, manuscript edit, publication or claim of novelty. This proves a sufficient changed auxiliary weight and propagates its cost through the displayed induction estimates; it does not claim that all prior degree-reduction lemmas have been proved.

## Evidence and exact operators

Primary: Ellis, Kindler and Lifshitz, arXiv:2209.04243v1, Definition 33 and Lemmas 53, 55-58, printed pages 22 and 32-35. Preserved text `C:/Users/Dan/AppData/Local/Temp/s3134-ellis2209.04243v1.txt` SHA256 `9259246e882f05e02fb8585400fed15b6a1d9e68106cbcd813c8851ecfdc468a`; PDF SHA256 `4455f4a757b2abc1b7a3dd41f3495b68bf2e2b9aa4d05a5b0953fe4e751a991f`. The exact core and collision example are frozen in `0e5e5d090b80c8077e6485277dabfcfafb0093ed`, including `2026-09-13-realizable-hardness-generalized-derivative-core-derivation.md`, SHA256 `aa45294da61022daa69fdf932b88b51cad0856b301596393a640e52162949328`. The following uses the proved fiber and predecessor counts, not the false fixed-base Parseval equality or contraction premise in the printed proof.

Let V,W be any finite-dimensional F2 spaces, with dimensions allowed to be zero. All averages and norms use uniform probability. For f:Hom(V,W)->C use the trace-character Fourier transform. For X,Y:W->V set X<=Y when rank Y=rank X+rank(Y-X). L_X retains the frequencies Y>=X. D_X f is the restriction of L_X f at base zero to Hom(V/im X,ker X), using the canonical inclusion and quotient. This is the actual Definition-33 operator, not an orthogonal projection. Fix a natural degree bound d for f; it need not be the smallest degree bound.

Write

    E = ||f||_2^2,
    a_X = sum_{Y>=X}|fhat(Y)|^2,
    e_X = ||D_X f||_2^2.

For rank X=k<=d, the exact reduced-frequency fiber of rank l contains 2^(2kl) frequencies. They all have original rank k+l. Fiberwise Cauchy-Schwarz therefore gives

    e_X <= 2^(2k(d-k)) a_X.

For k>d, e_X=a_X=0. Also 0<=a_X<=E. A fixed rank-j Y has exactly [j choose k]_2 2^(k(j-k)) rank-k predecessors. For k>=1 this is at most 4*2^(2k(j-k)); for k=0 the count is exactly one. These statements include all multiplicities and do not replace a frequency fiber by a set of reduced frequencies.

## 1. A sufficient fourth-power inequality

For every d>=0 and every f of degree at most d,

    sum_X 2^(-6d rank X) ||D_X f||_2^4
       <= (67/63) ||f||_2^4 <= 2 ||f||_2^4.               (W6)

Proof. Squaring the fiber bound and using a_X<=E gives

    e_X^2 <= 2^(4k(d-k)) a_X^2
            <= 2^(4k(d-k)) E a_X.

This uses a bound on selected Fourier energy, not the false assertion e_X<=E. Interchange finite sums in the weighted expression. For each Y of rank j<=d its coefficient, after extracting E|fhat(Y)|^2, is at most

    1 + 4 sum_{k=1..j} 2^(-6dk+4k(d-k)+2k(j-k))
      = 1 + 4 sum_{k=1..j} 2^(2k(j-d)-6k^2)
      <= 1 + 4 sum_{k>=1} 2^(-6k^2)
      <= 1 + 4 sum_{k>=1} 2^(-6k)
      = 67/63.

Summing |fhat(Y)|^2=E proves (W6). For d=0 only X=0 contributes, D_0=f, and the sum is exactly E^2. This also covers zero-dimensional V or W and f=0. No division by E or dimension hypothesis is used. The proof actually works at any translated base, since phases have modulus one, but only the base-zero statement is needed here.

The original weight 2^(-4d rank X) of Corollary 55 cannot be retained: the statement in this pinned version is false, as the following exact family shows. W6 is an explicit replacement auxiliary lemma, not a proof of that original statement.

### Exact counterexample to the original fourth-power statement

This family was identified by the independent reviewer and checked here from the fiber count. Set V=W=F2^d and f=sum_{Y in GL_d(F2)}chi_Y. This is a real-valued function homogeneous of degree d, so it meets even an exact-degree reading of the source. Put G_d=|GL_d(F2)|. Parseval gives E=G_d. For each rank-one X, the residual domain and codomain have dimension d-1. The selected invertible original frequencies lie over precisely the invertible residual Z, each with fiber 2^(2(d-1)); all coefficients and zero-base phases are 1. Therefore

    e_X = G_(d-1) * 2^(4(d-1)).

There are (2^d-1)^2 rank-one binary maps. The standard ordered-basis count gives G_d=(2^d-1)*2^(d-1)*G_(d-1). Thus the rank-one portion alone of the original weighted fourth-power sum, divided by E^2, equals

    (2^d-1)^2 * 2^(-4d) * 2^(8(d-1))
        * G_(d-1)^2/G_d^2 = 2^(2d-6).

At d=4 this is 4, already greater than the asserted upper constant 2. The X=0 term adds another 1. All other terms are nonnegative. No numerical experiment, asymptotic approximation, or choice of nonzero affine phase is involved. This disproves Corollary 55 as stated with Definition 33 in arXiv:2209.04243v1; it does not disprove Theorem 58, its later small-influence corollary, or any uninspected later revision.

## 2. Exact use of the unused Lemma-57 slack

For brevity let

    g_AB,T = D_AB,T f,
    Q(f) = sum_{A<=V,B<=W} E_T ||g_AB,T||_2^4.

Here D_AB,T is the actual hybrid derivative of Definition 29, and the expectation is over the original full Hom(V,W). The already proved lowering identity says every g_AB,T has degree at most d, and is zero if its order exceeds d. Thus W6 with the common degree bound d applies to every one of these functions on its actual quotient/subspace domain; it is not necessary to change their probability normalization.

The displayed Lemma-57 bound before its final Corollary-55 invocation is

    ||f||_4^4/162 <= 2^(6d^2) E^2 + 2^(100d^2) R,

    R = sum_{k=0..d} 2^(-31d(k+1))
          sum_{A,B,Y: rank Y=k, order(A,B)+k>0}
             2^(-4dk) E_T ||D_Y g_AB,T||_2^4.           (57-pre)

The q=2 specialization is literal. This is a conditional input to this section: the preceding Lemmas 46, 51, 52 and 56, and the interchange/counting steps establishing (57-pre), still require their full proofs.

For each k>=0 the coefficient in R factors exactly as

    2^(-31d(k+1)) 2^(-4dk)
       = 2^(-31d) 2^(-29dk) 2^(-6dk)
       <= 2^(-31d) 2^(-6dk).

All summands are nonnegative. Enlarge the restricted (A,B,Y) sums by dropping order(A,B)+k>0. Apply W6 to each g_AB,T, then average T and sum A,B. Therefore

    R <= (67/63) 2^(-31d) Q(f) <= 2^(1-31d) Q(f).       (R)

This step removes all D_Y derivatives with their actual coherent fibers; it never assumes pointwise contraction. The existing k-dependent slack more than pays for changing the auxiliary weight from 4d to 6d. No change to (57-pre), its 100d^2 exponent, or its original dimensions is required.

## 3. Closing the same Theorem-58 induction constant

The zero-order hybrid derivative at T is translation by T, so its squared L2 norm is E for every T. Hence E^2<=Q(f). Combining (57-pre) and (R), for d>=1,

    ||f||_4^4
      <= 162 [2^(6d^2)+2^(100d^2+1-31d)] Q(f)
      = 2^(100d^2) 162[2^(-94d^2)+2^(1-31d)] Q(f)
      <= 2^(100d^2) Q(f).

For the last inequality, d>=1 gives each bracket term at most 2^-30, so the extra factor is at most 324/2^30<1. The true first term is much smaller. At d=0, f is constant and all positive-order derivatives vanish; the desired theorem is equality. Induction is over nonnegative degrees on all finite dimensions simultaneously, as required for the quotient-domain calls in Lemma 56.

Thus the new auxiliary weight restores this final induction step with the SAME exponent 100. This is a conditional mathematical implication from (57-pre), not a declaration that Theorem 58 has now been proved in full. The outstanding degree-reduction and derivative-transfer estimates cannot be replaced by the conclusion of this calculation.

## 4. What changes downstream, and what remains conditional

No constant loss propagates beyond the auxiliary estimate:

* Theorem 58 retains 2^(100d^2), conditional on its remaining pre-step foundations.
* The separately reviewed exact rank-incidence derivation, frozen in ece5d79, adds 3d^2. Consequently the small-influence fourth-moment bound retains 2^(103d^2) eta ||f||_2^2. That derivation uses averaged hybrid energy, which is valid; it does not depend on the false contraction of D_X.
* The earlier dyadic bookkeeping candidate therefore receives exactly the same 103 input. Its fourth-moment/globalness coefficients remain 114 and 196, and the recorded recurrence A_4=114, A_p=4A_(p/2)+49p-82 still satisfies A_p<=200p^2-100p: substitution in the induction step gives 200p^2-151p-82, below the claimed bound. This does not discharge the still-required globalness/influence conversion proofs and dimension boundaries.
* Conditional on those precise conversions and the dyadic bound, the earlier MZ import calculation is unchanged: its p-th-moment power of 2 is (450p^2-495p-10)i^2, at most 500p^2 i^2, with density power p-2+2/p>=p-2 for p>=4 and density in (0,1]. Thus the required 500 and the weaker density exponent (p-2)/p remain sufficient. The i=0 constant level is immediate; no special derivative argument is needed.

The references for those later conditional calculations are `2026-09-13-realizable-hardness-hypercontractivity-dependency-audit.md` (dba4baaa544e6ab2a413cd19e485c9c76171e1dbb601bc3c54a1e1d2c6858c8e) and the separate rank-incidence fourth-moment derivation. The former expressly retains conversion and dyadic foundational review debt. This note removes one specific analytic obstruction rather than upgrading that conditional chain to full certification.

## Outcome and next exact obligation

W6 is a proved dimension-independent fourth-power inequality for the actual rank-poset derivative. Its changed weight is absorbed by the existing Lemma-57 slack, preserving the numerical 100/103 constants and hence introducing no new loss to the conditional 200/500 chain. It is unnecessary to assume the original Corollary 55 in this repaired route.

The next central mathematical obligation remains the actual convolution/Boolean-cube degree-reduction inequality and the hybrid/X transfer and counting lemmas leading to (57-pre). The separate ongoing degree-reduction reconstruction targets the sufficient 6d^2 first-term coefficient already present in (57-pre), rather than the stronger printed Lemma-46 coefficient 3d^2. This does not change the absorption calculation above and is not treated here as an already accepted proof. No complete hypercontractivity theorem, Lean proof, source-hardness theorem, paper certification or P-vs-NP result is claimed here. No compiler was launched; the memory-constrained diagnostic remains disabled.
