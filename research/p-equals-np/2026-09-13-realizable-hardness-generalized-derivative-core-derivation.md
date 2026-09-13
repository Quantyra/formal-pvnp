# Binary generalized derivatives: exact core and a weighted-energy repair

Date: 2026-09-13. S3132/S3134/S3137. Mathematical derivation only; not Lean, not a proof of the full hypercontractive theorem. No manuscript or source-module changes. The separate reviewer has checked the weighted-energy repair algebra; final exact-file review binding remains separate.

## Primary evidence and scope

The primary is Ellis, Kindler and Lifshitz, arXiv:2209.04243v1, Definitions 28-33, Lemmas 34-35, Proposition 38, Lemmas 46 and 53, Theorem 58. Preserved PDF `C:/Users/Dan/AppData/Local/Temp/s3134-ellis2209.04243v1.pdf` SHA256 `4455f4a757b2abc1b7a3dd41f3495b68bf2e2b9aa4d05a5b0953fe4e751a991f`; UTF-8 text `s3134-ellis2209.04243v1.txt` SHA256 `9259246e882f05e02fb8585400fed15b6a1d9e68106cbcd813c8851ecfdc468a`. Printed pages 20-24 give the operators; pages 27-35 give degree reduction and conditional hypercontractivity. This is Ellis EKL22, not the later Evra EKL24 paper. Prior dependency audit: `2026-09-13-realizable-hardness-hypercontractivity-dependency-audit.md`, frozen in 8306a4f6b4c9576ee54067727ad931449459b346. No new result or novelty is claimed.

## 1. Actual finite spaces, measures and operators

Let V,W be arbitrary finite-dimensional vector spaces over F2, including dimension zero. All functions are complex-valued on H=Hom(V,W); every average and Lp norm uses uniform probability, not counting measure. Frequencies are X in Hom(W,V). Set chi_X(M)=(-1)^Tr(XM), with matrix trace in F2, and fhat(X)=E_M f(M)chi_X(M). Nondegeneracy of the trace pairing gives the orthonormal Fourier basis and Parseval.

For A<=V and B<=W, let pi:V->V/A and j:B->W be the canonical quotient and inclusion. Define order i=dim A+codim_W B and selector

    P_AB(X) iff A<=im X and X^(-1)(A)<=B.
    L_AB f = sum_{P_AB(X)} fhat(X) chi_X.
    D_AB,T f(R) = (L_AB f)(T+j R pi), R in Hom(V/A,B).

No basis or arbitrary extension enters this definition. T is any element of H, without rank conditions. Its influence is ||D_AB,T f||_2^2. At order zero D_0W,T f(R)=f(T+R): it is identity only at T=0.

Cyclic trace gives the exact restriction formula

    chi_X(T+j R pi)=chi_X(T) chi_(pi X j)(R).

This can also be checked entrywise in any compatible bases; the scalar is independent of those choices.

## 2. Exact rank lowering and the necessary boundary split

Suppose P_AB(X). Then ker X<=X^(-1)(A)<=B. Since A<=im X, the inverse-image dimension is dim ker X+dim A. The kernel of pi X j is exactly X^(-1)(A), regarded as a subspace of B. Consequently

    rank(pi X j)=dim B-dim ker X-dim A=rank X-i.

In particular selected X have rank at least i. For Fourier projection f^{=d}:

* d<i implies D_AB,T(f^{=d})=0;
* d>=i implies D_AB,T(f^{=d})=(D_AB,T f)^{=(d-i)}.

The second assertion follows because each selected original rank j becomes exactly rank j-i; ranks from different j cannot mix. For degree at most d the derivative is zero if d<i, and otherwise has degree at most d-i. This is a dimension-independent algebraic lowering statement, not yet an L4 estimate.

An unrestricted natural-number subtraction identity is false. Take V=W=F2, A=V, B=W, T=0, f the nonconstant character and d=0. The derivative of f^{=0} is zero, while Df is the constant 1 on the zero-dimensional space. Its degree Nat(0-1)=0 projection is 1. A future Lean statement must use this case split or integer levels with negative projections zero.

## 3. Exact nested composition

Let A2<=A1<=V and B1<=B2<=W. First apply D_A2B2,T. On Hom(V/A2,B2), apply D_(A1/A2),B1,S. Write X2=pi_A2 X|B2. The crucial selector identity is

    P_A1B1(X) iff P_A2B2(X) and P_(A1/A2),B1(X2).

Forward: preimages of A2 lie in those of A1, hence in B1; every vector of A1 has an X-preimage in B1, which proves the quotient image requirement. The second inverse-image requirement follows immediately.

Reverse: the quotient image requirement says each a1 in A1 is Xz+a2 with z in B2 and a2 in A2. The first selector places A2 in im X, so A1<=im X. If Xw is in A1, choose z in B2 with Xz equal to Xw modulo A2. Then w-z is in X^(-1)(A2)<=B2, so w is in B2. The second selector now puts w in B1.

On characters, the two phases multiply to chi_X(T+j_B2 S pi_A2). The final frequency is pi_A1 X|B1. Linearity, the selector identity, and the canonical isomorphism (V/A2)/(A1/A2)=V/A1 therefore prove

    D_(A1/A2),B1,S (D_A2B2,T f)
      = D_A1B1,(T+j_B2 S pi_A2) f.

Orders add exactly. This proof remains valid when frequencies coalesce after restriction: it is an identity on each input character before summing. It does not substitute an arbitrary extension for the displayed canonical embedded S.

## 4. Averaged energy, and why fixed-T Parseval is different

Uniform translation and finite Fubini prove

    E_T ||D_AB,T f||_2^2
      = E_T,R |L_AB f(T+j R pi)|^2
      = ||L_AB f||_2^2
      = sum_{P_AB(X)} |fhat(X)|^2.

At a fixed T, several selected frequencies can induce the same reduced frequency, and their coefficients add coherently. Thus the last equality is generally unavailable pointwise. The separate rank-incidence derivation uses precisely the averaged identity and is unaffected.

## 5. A substantive repair of the printed fixed-base energy step

Definition 30 orders maps by X<=Y iff rank Y=rank X+rank(Y-X). Definition 33 sets L_X f=sum_{Y>=X} fhat(Y)chi_Y and D_X f=(L_X f)(j R pi), with A=im X, B=ker X and base T=0. These are different selectors from section 1.

The first equality in the proof of Lemma 53 identifies ||D_X f||_2^2 with sum_{Y>=X}|fhat(Y)|^2. Taken literally with Definition 33, that equality is false. A binary example is X=diag(1,0), and the four matrices

    Y_bc = [[1+bc,b],[c,1]], b,c in F2.

Each Y has rank 2 and Y-X has rank 1, hence Y>=X. All four induce the scalar frequency 1 on ker X -> V/im X. For f=sum_bc chi_Ybc, D_X f=4 chi_1. Its squared norm is 16, while the selected Fourier energy is 4. This disproves the displayed equality, not the weighted conclusion of Lemma 53.

Here is a direct repair that retains that conclusion. Choose splittings in which a fixed rank-k X has block form [[I,0],[0,0]]. For a prescribed reduced frequency Z:ker X->V/im X of rank l, the maps Y>=X inducing Z are exactly

    Y = [[I+u Z v, u Z],[Z v,Z]],

where u:im Z->im X is arbitrary, and Z v:im X->im Z is arbitrary. Here v denotes any lift through Z; u Z v depends only on Z v, so the displayed matrix has no lift ambiguity. There are exactly 2^(2kl) choices. Indeed Y-X factors as [u;I] Z [v,I] and has rank l, while block elimination gives rank Y=k+l. Conversely, if Y>=X, rank equality forces the bottom-right induced map to have rank rank Y-k; its off-diagonal blocks factor through Z and land in im Z, and elimination forces the upper-left residual to be u Z v. This also follows by decomposing im Y=im X direct-sum im(Y-X) and using the analogous kernel decomposition.

Therefore Cauchy-Schwarz on each reduced-frequency fiber, for f of degree at most d and k<=d, yields

    ||D_X f||_2^2 <= 2^(2k(d-k)) sum_{Y>=X}|fhat(Y)|^2.

For k>d the derivative is zero. This establishes actual lowering for D_X too: its selected original rank j induces rank j-k; mixed D_X D_AB,T lowers by i+k, with the same necessary low-degree zero branch.

For a fixed rank-j Y, maps X<=Y of rank k correspond bijectively to rank-k projections on im Y, by X=P Y. To see the forward direction, rank additivity gives ker Y<=ker X, so X factors through Y; the two images im X and im(Y-X) are complementary, and the induced factor P is their projection. Conversely every such projection gives rank additivity. Their number is

    [j choose k]_2 2^(k(j-k)).

For fixed image, complements are graphs of all maps from one complement to that image, giving the second factor. The elementary Gaussian bound [j choose k]_2<=4*2^(k(j-k)) follows from its product formula: the denominator product over a=1..k of (1-2^-a) exceeds 1/4. For example its first three factors give 21/64, and the remaining product is at least 1-sum_{a>=4}2^-a=7/8; the product is at least 147/512>1/4. k=0 is handled exactly as 1.

Interchange the finite sums and apply these two bounds, with j<=d. The coefficient of |fhat(Y)|^2 in the weighted sum is at most

    1 + 4 sum_{k=1..j} 2^(-4dk+2k(d-k)+2k(j-k))
      <= 1 + 4 sum_{k>=1}2^(-4k^2)
      <= 1 + 4 sum_{k>=1}2^(-4k)
      = 19/15 < 2.

Hence the actual Definition-33 operators satisfy the original desired inequality

    sum_X 2^(-4d rank X) ||D_X f||_2^2 <= 2 ||f||_2^2.

For d=0 only X=0 survives and the result is immediate. No ambient dimension enters the repair. This is a proved finite-fiber argument offered for independent verification, not a declaration that the rest of the printed hypercontractivity proof has been checked.

## 6. An additional unresolved fourth-power step

Corollary 55 asserts sum_X 2^(-4d rank X)||D_X f||_2^4 <= 2||f||_2^4. Its printed proof uses pointwise contraction ||D_X f||_2^2<=||f||_2^2. The same explicit four-character example gives 16>4, so that premise is false. The repaired weighted second-moment estimate above does not supply contraction and does not by itself prove this fourth-power assertion. Thus Corollary 55 requires a new argument or an explicitly propagated change of weights/constants. This note neither disproves Corollary 55 itself nor accepts it on the printed reasoning. It is an exact additional residual needed in Lemma 57's removal of the D_X derivatives.

## 7. Precise remaining analytic obligation

The algebra above proves genuine lowering, composition and the weighted auxiliary-derivative energy estimate. It does not prove that a general L4 moment is controlled by these derivatives. In particular the zero-order term in the final theorem is ||f||_2^4, not ||f||_4^4, so it cannot make the theorem tautological.

The earliest central inequality still to reconstruct is binary Lemma 46. Let L_A select im X containing A and L_B select ker X contained in B, separately (not the hybrid selector). For every f of degree at most d the required assertion is

    (1/162)||f||_4^4 <= 2^(3d^2)||f||_2^4
       + sum_{(A,B)!=(0,W)} 2^(7d(dim A+codim B)) ||L_A L_B f||_4^4.

The printed proof needs the convolution-pair decomposition of Fourier coefficients of f^2, a finite encoding of the first class into a Boolean cube with its fourth-moment bound, and a controlled estimate for the overlapping-image/kernel class. None of those L4 inequalities follows from rank lowering or Parseval alone. The later hybrid/X decomposition and Lemmas 51-57 still require proof with their counting constants, including repair of the Corollary-55 fourth-power step just isolated, before Theorem 58 follows. Lemma 59 concerns homogeneous combinatorial Laplacians for the subsequent globalness-to-influence argument; it is not the degree-reduction inequality.

A future kernel implementation can first prove sections 1-5 with explicit finite spaces and the case split d<i. It must then prove the displayed Lemma-46 inequality and the remaining induction transfers, without adding a theorem axiom or assuming the desired fourth moment. The separate rank-incidence note already supplies the final Theorem-58-to-Corollary-65 counting step, conditional on Theorem 58. This document therefore discharges a concrete algebraic core and repairs one auxiliary estimate, while leaving the substantive L4 foundation explicit.
