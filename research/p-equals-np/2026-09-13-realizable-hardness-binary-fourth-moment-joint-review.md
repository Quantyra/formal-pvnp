# Joint finite transfer and binary fourth-moment review

2026-09-13. S3137. compact_source_encoding_audit. Mathematical review and dependency join only; no compiler, new Lean, paper edits, Git or public action. I did not author the T2 transfer or assembly-accounting notes. I contributed to the separate rank-poset counterexample/W6 analysis and reviewed the core, DR6 and counting arguments. This is not a wholly noncontributing certification of every joined component; that role remains separately recorded. No kernel acceptance is asserted.

**Bounded mathematical GO:** the complete T1/T2 character identities and the exact assembly accounting close the finite binary fourth-moment argument with constants 100 and 103, using the reconstructed DR6 and W6 instead of the defective pinned auxiliary claims. No external hypercontractive theorem is needed for this binary fourth-moment deduction. This does not close the globalness/influence conversion, dyadic theorem, entire manuscript or Lean development.

## Exact reviewed inputs

I read the complete final transfer note and checked its T2 argument independently. All six raw files below were freshly rehashed; their full contents were read in this or the preceding bounded reviews. They are under `research/p-equals-np/`, with prefix `2026-09-13-realizable-hardness-` and suffix `.md`:

- generalized-derivative-core-derivation: aa45294da61022daa69fdf932b88b51cad0856b301596393a640e52162949328.
- binary-degree-reduction-derivation: bac648685bf7a8df7e3b1828f84e7347beccf06b56a9fe09209bd7b82080a92d.
- laplacian-transfer-derivation: 3ba2a817ed2462513448a83ddb2e2dda61b4ee0958308e1b25c468fea1d15e00.
- transfer-assembly-accounting: a7be5fb4442fbd8c947f98cef0d7cb1d44105a544e66f06c727a7f4811a74cef.
- weighted-fourth-power-derivation: 591d30061dfac1031d5990683aea1e7a88c6c0508e0d03691a724d5c53fd1120.
- rank-incidence-fourth-moment-derivation: 37b1c64799afcc38006c12376aa7ec685a05c70b2d5f96d963fb12d26ab574e1.

Primary comparison used Ellis/Kindler/Lifshitz arXiv:2209.04243v1, preserved text `C:/Users/Dan/AppData/Local/Temp/s3134-ellis2209.04243v1.txt`, SHA256 9259246e882f05e02fb8585400fed15b6a1d9e68106cbcd813c8851ecfdc468a, actual derivative definitions, Propositions39-40, and Lemmas51-58. This join supersedes the pending-T2 status of my earlier ordinary-transfer draft and discharges the T1/T2 premises of the separately saved conditional assembly review. Historical notes remain evidence of the earlier review boundary.

## Independent T2 selector challenge

Let X:W->V have image A1, kernel B1 and rank k. Fix A2>=A1 and B2<=B1. The left side first applies the rank-poset derivative and then the hybrid derivative on Hom(V/A1,B1). The right indices are C complementing A1 in A2 and H with H+B1=W and H intersect B1=B2. Put X'=q_C X|H.

For a left-selected Fourier label Y, write Z=Y-X. Rank additivity gives im Y=im X direct-sum im Z, ker X+ker Z=W, and ker X intersect ker Z=ker Y. In particular Z(B1)=im Z. The later hybrid image condition forces C=im Z intersect A2 to complement A1; its preimage condition forces ker Y<=B2. Set H=ker Z+B2. Then H+B1=W and H intersect B1=B2. If Yw belongs to C, its im X component is zero, so w belongs to B1; the left preimage condition then puts it in B2. Thus the right hybrid selector accepts Y. On H, the X and Z components, including their attained images, stay disjoint after quotienting by C. Hence X'<=q_C Y|H. This proves existence with the actual selectors.

For the reverse implication, suppose a right index accepts Y. The rank-poset image inclusion and C<=im Y imply im X<=im Y, since X(H)=im X. If Yw lies in im X, lift it through Y(H) modulo C and then through C<=Y(H). The hybrid preimage condition gives ker Y<=H, so w lies in H. The right rank-poset agreement property says Yw-Xw is in C; it is also in im X, hence zero. Therefore Y agrees with X on Y^(-1)(im X). Together with im X<=im Y this is exactly the elementary characterization of X<=Y. That characterization follows by decomposing the disjoint images of X and Y-X, not from a norm estimate.

Now X<=Y is established, so rank Z=rank Y-k. The right hybrid rank loss and the right rank-poset relation give

    rank(q_C Z|H)=rank Z-dim C-codim H.

For every linear map, restricting to H loses at most codim H in rank, and quotienting by C loses at most dim C. Equality in their sum forces equality in each loss separately. The first equality forces ker Z<=H by rank-nullity; the second forces C<=Z(H). Consequently Z^(-1)(C)<=H. Since im Z is disjoint from A1 and C complements A1 inside A2, C=im Z intersect A2.

Also ker Z+B2<=H. Its dimension is dim B2+k: ker Z intersect B2=ker Y, because B2<=B1 and ker Y<=H intersect B1=B2, while rank additivity gives dim ker Z-dim ker Y=k. The complement conditions give dim H=dim B2+k as well. Thus H=ker Z+B2, proving uniqueness rather than merely bounding its multiplicity. Finally Z(B1)=im Z and Z^(-1)(C)<=H recover both left hybrid conditions. This verifies the complete selector equivalence, including k=0 and all full/zero subspace boundaries.

## Phases, quotient domains and 56*

The final domain on both sides is canonically Hom(V/A2,B2). For bases S in Hom(V,W) and T in Hom(V/A1,B1), the phase is exactly chi_Y(S+j_B1 T q_A1). Each surviving input character has one summand, so Fourier labels may collide afterward without invalidating equality. No coefficient sum is silently replaced by a diagonal energy. The embedded shift is canonical; an arbitrary extension would not suffice.

The T1 selector decomposition was independently checked in the preceding review: C=Y(B) intersect A, H=B+Y^(-1)(A), with the unique induced X. Its all-triples count2^(ij), normalized shift averaging and Holder cost2^(3ij) give 51* and, together with DR6, the sufficient coefficient24 in52*. The final transfer note preserves those definitions and counts.

For 56*, the initial mixed order t=dim A0+codim B0+k is positive. Terms with t>d vanish; otherwise the function on its actual quotient/subspace domain has degree<=d-t<d. The lower-degree induction applies simultaneously to all finite spaces. Subsequent surviving hybrid order u+v is at most d-t. T2 introduces exactly 2^(ku)2^(kv) complements, so Holder costs at most2^(3dk), safely weakened to2^(6dk). This use is for fourth powers of L2 norms; it does not require a false contraction.

The resulting pair uniquely determines the intermediate enlarged image and kernel, and the composed shift has the form original T plus a fixed canonical embedding of the inner translation. Averaging original uniform T removes that translation without a measure factor. The intermediate ordinary dimension/codimension can be d+k, but final mixed order is t+u+v<=d. These are exactly the corrected cutoffs in the assembly note. Thus 56* supplies its pending transfer premise with no additional analytic assumption.

## Closing the finite chain without an external fourth-moment import

The theorem now justified mathematically is: for all finite binary V,W, all complex f:Hom(V,W)->C of Fourier rank degree at most d, and normalized uniform measures,

    ||f||_4^4 <= 2^(100d^2) Q(f),
    Q(f)=sum_(A<=V,B<=W) E_T ||D_(A,B,T)f||_2^4.

Induct on d, simultaneously for every finite V,W. At d=0, f is constant and only the order-zero derivative survives, so equality holds with coefficient1. At positive d, DR6 and T1 give52*. The actual T2/lower-degree argument gives56*. The reviewed exact graph/kernel multiplicities and exponent sums in assemblya7be5fb give57-pre. Each use of the induction hypothesis is at degree d-t<d; no current-degree conclusion is assumed.

The independently proved W6 inequality uses weight2^(-6dk). Its application is paid for by the exact existing57-pre weight factorization

    2^(-31d(k+1))2^(-4dk)
       =2^(-31d)2^(-29dk)2^(-6dk).

Retain its safe coefficient2. Since Q(f)>=||f||_2^4 from the order-zero derivative, the resulting multiplicative slack is

    162[2^(-94d^2)+2^(1-31d)]<1,  d>=1.

This closes the stated exponent100. It does not restore the false pinned weight-4 Corollary55 or the stronger printed DR3 baseline; the proof uses DR6 and W6 explicitly.

If actual influences satisfy ||D_(A,B,T)f||_2^2<=eta for every order<=d and every T, eta>=0, the independently reviewed normalized averaged-energy identity and exact Gaussian incidence count then give

    ||f||_4^4 <=2^(103d^2) eta ||f||_2^2.

The count adds at most3d^2 and has no ambient factor. At eta=0, order-zero influence forces f=0. Supplied degree bounds above the maximum possible rank, zero-dimensional spaces and empty subspace index sets satisfy the same induction with the recorded zero branches.

The basic Fourier facts used here are finite, not a hidden hypercontractive import: trace characters are orthogonal because a nonzero trace functional pairs ambient matrices by a translation on which the character changes sign. Counting dimensions gives the complete basis and Parseval. All remaining norm estimates in these notes are finite Cauchy-Schwarz/Holder and the explicitly proved degree-two Boolean moment argument. No EKL Theorem58, Corollary65 or MZ Theorem4.6 is assumed to establish these two binary fourth-moment statements.

## Precise remaining limits

This closes the finite mathematical 100/103 dependency for the actual binary derivatives at the review level. It is not Lean formalization: no theorem was compiled, no dependency was added as an axiom, and no kernel acceptance follows. The separate Proposition63/Lemma64 globalness-to-influence route, later globalness conversions and dyadic200/500 bookkeeping still need their own complete derivations and verification. Therefore MZ4.6, the complete manuscript proof, upstream hardness and the user's full goal do not become complete through this join. No novelty or publication claim is made.
