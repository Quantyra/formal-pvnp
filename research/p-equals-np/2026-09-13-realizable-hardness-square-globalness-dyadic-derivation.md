# Actual square-globalness and the binary dyadic 200 bound

2026-09-13, S3132/S3134/S3137. Finite mathematical derivation from the reviewed fourth-moment and conversion proofs. This replaces the earlier provisional 114/196 bookkeeping with explicit hypotheses and a complete dyadic induction. It does not invoke EKL24 Theorem 1.13 as an assumption. No Lean/compiler, new module, Git, manuscript or public action was performed.

## Evidence and exact accepted inputs

The original comparison source is Evra, Kindler and Lifshitz, arXiv:2404.00641v2, Lemma 4.1 and Theorem 1.13. Preserved text `C:/Users/Dan/AppData/Local/Temp/s3134-ekl2404.00641v2.txt`, SHA256 `7fb002153b3ac62a3238c61574b65b3a2a28de3ce253fe6272d697a63247ab1a`; PDF SHA256 `fa4c9ebaf56104957b2cbb5dc3cb06f45e86152104e6311ed00a9491ddeb58c4`. The following proof is reconstructed from the actual finite inputs, rather than relying on its printed induction arithmetic.

All local paths below have prefix `research/p-equals-np/2026-09-13-realizable-hardness-`:

* `binary-fourth-moment-joint-review.md`, SHA256 `f7fc37b4fb420e65d2c5cc473db798482f85f03df9e196291f87aa533ca77512`, frozen with the transfer/assembly reviews at `5f203d33c00f6806202f4f16ca9b492f0f050ed7`: for degree-at-most-d functions with actual hybrid influences through order d bounded by eta, the fourth moment is at most 2^(103d^2) eta ||f||_2^2. The joined proof includes the replacement weight-6 estimate, not the false original rank-poset contraction.
* `globalness-to-level-influence-derivation.md`, SHA256 `c905e6ae82fcc0369161f20b007a02339ecb01a4e4e94bfeea32d4d2ba98f111`, frozen at `b01bc9e4303da6a1745d139f58754aea582d834d`: a full degree-at-most-d function globally bounded through order d by epsilon has all hybrid influences through order d bounded by 2^(11d^2) epsilon. Section 8 proves this using exact orthogonality of distinct residual rank levels. Its d=0 case is direct.
* `influence-to-globalness-derivation.md`, SHA256 `563187200f9761458f9d9b106042fafb381238d7a4ea2a7e88275ac2a4c1112b`, frozen at the same commit: for every natural r, the preceding actual influence hypothesis eta implies actual globalness through order r with parameter 2^(10dr) eta, including small or zero-dimensional spaces.

These are reviewed finite derivations, not kernel-certified imports. Their separate review records remain the evidence for the inputs. This note discharges the next join using those precise statements; it asserts neither their Lean formalization nor complete paper certification.

## 1. Spaces, globalness and target

Let V,W be arbitrary finite-dimensional F2 spaces, including zero dimensions. Functions f:Hom(V,W)->C use normalized uniform probability for every norm. For A<=V,B<=W,T:V->W, let

    R_AB,T f(N)=f(T+j_B N q_A), N in Hom(V/A,B).

Its order is dim A+codim_W B. Up-to-r epsilon-global means every such restriction of order at most r has squared L2 norm at most epsilon, at every base T. The hypothesis here is expressly this up-to-order one, not a possibly vacuous exact-order condition.

Assume f has rank-Fourier degree at most d and is up-to-d epsilon-global, with d natural and epsilon>=0. For every p=2^t with integer t>=1, prove

    ||f||_p^p <= 2^(200d^2 p^2) ||f||_2^2 epsilon^(p/2-1). (DY)

For p=2 the density factor is one and no ambiguous zero-to-zero expression is needed. The necessary powers are 2,4,8,...; p=1 is not asserted. In fact that extension is false without extra assumptions: d=0,f=1,epsilon=4 would give 1<=1/2. Thus the dyadic lower bound must be explicit.

## 2. Actual products, restrictions and dimensions

The trace-character identity chi_Y chi_Z=chi_(Y+Z) and rank(Y+Z)<=rank Y+rank Z show by finite Fourier convolution that f^2 has degree at most 2d. This is the ordinary complex square, and |f^2|=|f|^2; no real-valued or nonnegative assumption is needed.

A raw affine restriction sends chi_Y to chi_Y(T)chi_(q_A Y|B). Its new frequency has rank at most rank Y. Therefore every raw restriction h=R_AB,T f has degree at most d, even if its quotient/subspace dimensions are less than d. Colliding restricted frequencies cannot introduce higher ranks.

Restrictions compose canonically. A further domain constraint in V/A lifts to a containing subspace A2 in V, and a further codomain constraint is a subspace B2 of B. The total order is the sum of the two orders. The base becomes T+j_B S q_A, followed by the canonical double-quotient identification. Both variable maps are bijections onto the relevant variation spaces, so normalized uniform measures agree. In particular an order-at-most-2d restriction of an up-to-3d global function is itself up-to-d global with the same parameter. This holds without assuming any exact-order family on the smaller space is nonempty.

## 3. The actual 114 and 41 bounds

The accepted full-function conversion gives influence parameter 2^(11d^2) epsilon for f. Apply the accepted fourth-moment bound with this parameter:

    ||f||_4^4 <= 2^(114d^2) epsilon ||f||_2^2.           (F114)

For d=0 this is the elementary constant-function bound and the same display is valid. The conversion factor is included; globalness alone was not substituted directly for the influence hypothesis.

Apply the reverse conversion at r=3d. It gives up-to-3d globalness of f with squared-norm parameter

    B = 2^(30d^2) 2^(11d^2) epsilon
      = 2^(41d^2) epsilon.                             (G41)

This uses the accepted all-r version of the reverse implication. It remains meaningful if 3d exceeds the sum of the dimensions: every actual restriction of smaller order is still bounded. No empty exact-order family is used to infer a norm bound.

## 4. Explicit square-globalness with coefficient 196

Take any actual restriction h=R_AB,T f of order at most 2d. By section 2 and G41, h has degree at most d and is up-to-d B-global. In particular its whole-space squared L2 norm is at most B. Apply the full-function conversion on this actual smaller matrix space, giving influence parameter 2^(11d^2)B. Apply the fourth-moment bound on the same space:

    ||h||_4^4 <= 2^(103d^2) 2^(11d^2) B ||h||_2^2
              <= 2^(114d^2) B^2
              = 2^(196d^2) epsilon^2.

Both factors B are retained: one comes through the influence hypothesis and the other from the restricted squared norm. Pointwise R_AB,T(f^2)=h^2, so ||R_AB,T(f^2)||_2^2=||h||_4^4. Therefore the actual function g=f^2 is of degree at most 2d and up-to-2d global with parameter

    epsilon_g=2^(196d^2) epsilon^2.                    (SQ196)

This proves square-globalness for every affine base and every order up to 2d. For d=0 the claim also follows directly from a constant f and |f|^2<=epsilon. The displayed general proof is compatible with that case. It does not require any new witness or assumed runtime/analytic certificate.

## 5. Dyadic induction with the doubled degree retained

First handle boundary cases. If epsilon=0, the order-zero globalness condition gives ||f||_2^2=0, so f is pointwise zero on the finite nonempty matrix space; DY follows. If d=0, f is constant c with |c|^2<=epsilon. For p>=2,

    |c|^p <= |c|^2 epsilon^(p/2-1),

which proves DY with no power-of-two loss. We may now assume d>=1 and epsilon>0. If p=2, the claimed estimate follows directly with coefficient one before weakening to the stated exponential factor.

For p>=4 define numerical coefficients recursively by

    A_4=114,
    A_p=4A_(p/2)+49p-82 for p>=8.

We prove the stronger bound

    ||f||_p^p <= 2^(A_p d^2) ||f||_2^2 epsilon^(p/2-1)  (IND)

simultaneously for all finite V,W, all natural degree bounds and all positive globalness parameters. The p=4 case is F114. For p>=8 apply the previously proved p/2 bound to the ACTUAL square g=f^2, with degree bound 2d and parameter epsilon_g from SQ196. This yields

    ||f||_p^p = ||g||_(p/2)^(p/2)
      <= 2^(4A_(p/2)d^2) ||g||_2^2
                    (2^(196d^2)epsilon^2)^(p/4-1).

The factor 4 multiplies A_(p/2) because the degree is 2d; it cannot be omitted. Also ||g||_2^2=||f||_4^4, to which F114 applies. Consequently the total power of two has coefficient

    4A_(p/2)+196(p/4-1)+114
      =4A_(p/2)+49p-82,

and the density power is 2(p/4-1)+1=p/2-1. This is exactly IND. Every use of globalness is the up-to-order statement on the actual spaces, so the induction remains valid when the nominal degree 2d exceeds the matrix ranks available.

Finally A_p<=200p^2-100p for every dyadic p>=4. At p=4, 114<=2800. If it holds at p/2, the recurrence gives

    A_p <= 4(200(p/2)^2-100(p/2))+49p-82
         =200p^2-151p-82
         <=200p^2-100p.

In particular A_p<=200p^2. This proves DY with the advertised 200 for every p=2,4,8,..., after the explicit boundary cases above. No invocation of EKL24 Theorem 1.13 occurred in the induction.

## 6. What is now discharged, and what is not

The actual full-function conversion supplies 11, the fourth moment supplies 103, their combination gives 114, enlargement to order 3d gives 41, and both restricted factors yield square-globalness 196. The doubled-degree recurrence then proves the dyadic 200 bound. These constants are now derived with their actual premises, not merely checked for arithmetic feasibility.

The original printed Lemma-4.1 coefficient 144 is not claimed here, and the original printed induction's smaller intermediate exponent is not used. This sufficient reconstruction retains the final 200 conclusion under the explicit up-to-order hypothesis. The separate Lp-prime-to-level-influence bridge and its normalized pairing/duality must still be joined before declaring the required MZ 500 import fully discharged. The independently reconstructed bridge is routed elsewhere and is not assumed as an input to this proof.

All acceptance here is at the finite mathematical derivation level. Complete Lean verification, upstream source-hardness, complete paper certification and any P-vs-NP conclusion remain outside this artifact. No novelty or public claim is made by reconstructing this known analytic dependency.
