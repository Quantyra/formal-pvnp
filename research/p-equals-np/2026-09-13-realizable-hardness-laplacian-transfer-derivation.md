# Actual Laplacian transfers and lower-degree induction

2026-09-13, S3132/S3134/S3137. Finite binary derivation, not a Lean or manuscript change. This reconstructs the actual character identities underlying EKL22 Propositions 39/40 and the norm transfers in Lemmas 51/52/56. The final reindexing to Lemma 57 is supplied in a separate accounting artifact and must be reviewed jointly before claiming the full analytic induction closed.

## Evidence and conventions

Primary: Ellis, Kindler and Lifshitz, arXiv:2209.04243v1, Definitions 28-33, Propositions 39-40 (printed pp23-24), Lemmas 51-57 (pp31-35), Appendix Lemmas 73-75 (pp41-45). Preserved text `C:/Users/Dan/AppData/Local/Temp/s3134-ellis2209.04243v1.txt`, SHA256 `9259246e882f05e02fb8585400fed15b6a1d9e68106cbcd813c8851ecfdc468a`; PDF SHA256 `4455f4a757b2abc1b7a3dd41f3495b68bf2e2b9aa4d05a5b0953fe4e751a991f`. Use the reviewed derivative core frozen at 0e5e5d090b80c8077e6485277dabfcfafb0093ed, and the subsequently reviewed DR6/W6 route at c7aaf61. No uninspected later source version is implicated by source-display corrections here.

V,W are arbitrary finite-dimensional F2 spaces; functions on Hom(V,W) are complex-valued. All norms and expectations use uniform probability. A frequency is Y:W->V with character chi_Y(M)=(-1)^Tr(YM). Write q_C for the canonical quotient and j_H for inclusion. Ordinary L_A L^B selects A<=im Y and ker Y<=B. Hybrid L_CH selects C<=im Y and Y^-1(C)<=H; its derivative is

    D_CH,T f(R)=(L_CH f)(T+j_H R q_C).

Rank-poset X<=Y means rank Y=rank X+rank(Y-X). D_X is the zero-base restriction of the selector retaining Y>=X to Hom(V/im X,ker X). It is not a contraction. Every equality below is first proved on individual input characters, so subsequent collisions of reduced frequencies cause no loss of phase or multiplicity.

## 1. Unique ordinary-to-hybrid decomposition

Fix A<=V,B<=W and a frequency Y selected by L_A L^B. Put

    C=Y(B) intersect A,
    H=B+Y^-1(A),
    R=q_C Y|H.

For h=b+z, b in B and z in Y^-1(A), define Xh=Yz modulo C. This is well defined: changing z by an element of B changes Yz by an element of Y(B) intersect A=C. Its image is A/C, since A<=im Y. Its kernel is B: X(b+z)=0 implies Yz in C<=Y(B), and ker Y<=B implies z in B. Further Y^-1(C)<=B, and C<=im Y, so Y passes the hybrid selector for C,H.

In V/C, the spaces Y(B)/C and A/C are disjoint. R splits as X+(R-X), the first term supported on the A/C component and the second on Y(B)/C. Their images are the whole respective components: use h=z for the first and h=b for the second. Thus their ranks add and X<=R.

Conversely suppose C<=A,H>=B, X:H->V/C has image A/C, kernel B, the hybrid selector accepts Y, and X<=R=q_C Y|H. Rank additivity implies ker R<=ker X and that R agrees with X on R^-1(im X). First A<=im Y: A/C<=im R and C<=im Y. Also ker Y<=H by the hybrid condition and then ker Y<=ker R<=B. Thus the ordinary selector accepts Y.

These conditions force the displayed C,H,X uniquely. For b in B with Yb in A, Rb lies in im X, so Rb=Xb=0; hence Y(B) intersect A<=C. Conversely, for c in C choose w with Yw=c. The hybrid condition puts w in H, and ker R<=B puts w in B. Thus C=Y(B) intersect A.

The image condition A/C<=im R implies Y^-1(A)<=H: for w with Yw in A choose h in H matching Yw modulo C; then w-h is in Y^-1(C)<=H. Let K=Y^-1(A). On K the equality R=X holds, and X(K)=A/C. Since ker X=B, every element of H is in B+K, proving H=B+K. Finally X is zero on B and equals R on K, giving exactly the construction above.

For every base T, on each selected character the unique right-hand summand has phase chi_Y(T) and final frequency q_A Y|B. Unselected characters have no right-hand summand. Linearity proves the actual operator identity

    (L_A L^B f)(T+j_B M q_A)
      = sum_{C<=A,H>=B, X:H/B isomorphic to A/C}
            (D_X D_CH,T f)(M).                         (T1)

All final domains are canonically Hom(V/A,B). No arbitrary choice of an extension of T is used.

## 2. Exact enumeration and the fourth-norm cost

Set i=dim A,j=codim B. The indexing triples in T1 are in bijection with ALL linear maps theta:A->W/B. Given theta, let C=ker theta and let H be the inverse image of im theta under W->W/B. The induced isomorphism A/C->H/B has inverse X. Conversely invert X and precompose A->A/C to obtain theta. This proves actual enumeration, including the zero map C=A,H=B,X=0. Thus the number of triples is exactly N=2^(ij), also when i or j is zero.

For any N complex numbers, |sum z_s|^4<=N^3 sum|z_s|^4 by Holder. Average this pointwise T1 bound over M and T. Uniform translation by T shows that the left side averages to ||L_A L^B f||_4^4. Consequently

    ||L_A L^B f||_4^4
       <= 2^(3ij) sum_{C,H,X} E_T ||D_X D_CH,T f||_4^4. (51*)

This is stronger than the loose counting bound needed from Lemma 51, but is derived here from the explicit theta bijection. It is not based on a norm contraction.

For degree-at-most-d f, ordinary terms with i>d or j>d vanish by their frequency selectors. For the others, 3ij<=3d(i+j). Write k=rank X and t=dim C+codim H+k. Each triple has i=dim C+k,j=codim H+k, so i+j=t+k<=2t. Combining (51*) with the reviewed DR6 ordinary-Laplacian inequality yields

    ||f||_4^4/162 <= 2^(6d^2)||f||_2^4
       + sum_{C,H,X:t>0} 2^(24dt) E_T||D_X D_CH,T f||_4^4. (52*)

Indeed 7d(i+j)+3ij<=10d(i+j)<=20dt<=24dt. The reindexing has multiplicity one: (C,H,X) determines A=q_C^-1(im X), B=ker X as a subspace of W. Also t=0 corresponds exactly to the excluded ordinary pair (0,W). Mixed derivatives lower rank by t, so t>d terms vanish. This uses DR6 with its sufficient 6d^2 coefficient, not the stronger printed 3d^2 claim.

## 3. Actual rank-poset/hybrid interchange

Fix X:W->V, A1=im X, B1=ker X, rank k. Fix A1<=A2<=V and B2<=B1. Let C range over complements of A1 inside A2, and H range over subspaces with H+B1=W and H intersect B1=B2. Put X'=q_C X|H. Then rank X'=k, im X'=A2/C, ker X'=B2.

For a frequency Y, the left selector of D_(A2/A1),B2 D_X says X<=Y and the hybrid selector accepts Ybar=q_A1 Y|B1. The right selector indexed by C,H says the hybrid selector accepts Y at C,H and X'<=Y'=q_C Y|H. We prove that the left selector holds if and only if exactly one right selector holds.

Forward, let Z=Y-X. Rank additivity gives im Y=im X direct-sum im Z, ker X+ker Z=W, and ker X intersect ker Z=ker Y. The map Ybar on B1 is Z|B1 followed by the injection im Z->V/A1; Z(B1)=im Z. Hence the left hybrid image condition forces

    A2=A1 direct-sum C, where C=im Z intersect A2.

Its preimage condition is {w in B1:Zw in C}<=B2. In particular ker Y<=B2. Set H=ker Z+B2. Then H+B1=W and H intersect B1=B2. If Yw is in C, the direct images force Xw=0, whence w in B1 and Zw in C, so w in B2<=H. Also C<=im Y. Therefore Y passes the right hybrid selector. Since H=ker Z+B2, X is supported on the first summand and Z on the second; after quotient by C their images remain disjoint. This proves X'<=Y'.

Reverse, suppose one right selector holds. First im X<=im Y: X(H)=im X because H+B1=W, and the rank-poset image inclusion modulo C together with C<=im Y implies im X<=im Y. If Yw is in im X, use im Y' containing im X' and C<=Y(H) to find h in H with Yh=Yw. The latter containment follows because the hybrid preimage condition puts every preimage of C in H. Then w-h is in ker Y<=H, so w in H. The rank-poset agreement property yields Yw-Xw in C; it is also in im X, disjoint from C, so Yw=Xw. The rank-poset characterization now proves X<=Y.

Let Z=Y-X. The hybrid rank-drop identity and rank X'=k give

    rank(q_C Z|H)=rank Z-dim C-codim H.

For any map Z, rank loss under restriction to H and quotient by C is at most codim H+dim C. Equality forces both maximal losses: ker Z<=H and C<=Z(H). These imply Z^-1(C)<=H. In particular C<=im Z. Since im Z is disjoint from A1 and C complements A1 in A2, necessarily C=im Z intersect A2. Also ker Z+B2<=H. Their dimensions agree: ker Z intersect B2=ker Y (because B2<=ker X and ker Y<=H intersect B1=B2), so rank-nullity gives dim(ker Z+B2)=dim H. Thus H=ker Z+B2, proving uniqueness.

Finally C<=Z(B1) since Z(B1)=im Z, so the left hybrid image condition holds. If w in B1 and Yw in A2, then Zw in im Z intersect A2=C, giving w in H intersect B1=B2. This proves its preimage condition and completes the equivalence.

The rank-poset characterization used above is elementary: X<=Y iff im X<=im Y and X agrees with Y on Y^-1(im X). The forward direction follows from the disjoint images of X and Y-X. Conversely the agreement condition implies im(Y-X)<=im Y and im X intersect im(Y-X)=0; their sum contains im Y, giving rank additivity.

For arbitrary S in Hom(V,W) and T in Hom(V/A1,B1), character phases give the full identity

    D_(A2/A1),B2,T D_X,S f
       = sum_{C,H} D_X' D_CH,(S+j_B1 T q_A1) f.        (T2)

Here D_X,S denotes the same rank-poset selector restricted at base S. Both sides have final domain Hom(V/A2,B2). The phase on every surviving frequency is exactly chi_Y(S+j_B1 T q_A1). No fixed-base Parseval equality is used, and the canonical embedded shift is required.

## 4. Lower-degree induction transfer with correct dimensions

Now begin with D_A0B0,T f and a rank-k frequency X on its reduced space. Put s=dim A0+codim B0 and t=s+k. If t>d the mixed derivative is zero. For 1<=t<=d it has degree at most d-t. Assume the Theorem-58 inequality already proved for every degree less than d on all finite spaces. Apply it to this actual mixed derivative. Its subsequent hybrid derivatives have order u+v<=d-t, where u is the added quotient dimension and v the added codimension in the post-X space.

Apply T2 in the reduced A0,B0 space to interchange each such derivative with D_X. The number of complements is exactly

    2^(ku) * 2^(kv) = 2^(k(u+v)).

For the first factor choose graphs of maps from a fixed u-dimensional complement to the k-dimensional image of X. For the second choose complementary graphs in the corresponding quotient of dimension k+v. Thus the fourth-power Holder loss is at most 2^(3dk), since u+v<=d-t<=d. This is safely bounded by the source's 2^(6dk).

After each interchange, compose the two actual hybrid derivatives using the reviewed nested composition identity. The final pair C,H in the original spaces satisfies A0<=C, H<=B0,

    C intersect A1=A0,   H+B1=B0,

where A1 is the preimage of im X in V and B1=ker X within B0. The final rank-poset frequency is the restriction/quotient of X to H->V/C and still has rank k. Conversely this pair reconstructs the intervening enlarged image A1+C and kernel B1 intersect H uniquely. Thus summing over the intermediate hybrid pairs and their complements introduces no additional multiplicity beyond the displayed Holder loss.

The shifts after composition are T plus a canonically embedded function of the inner translation parameter. For each fixed inner parameter, uniform original T remains uniform under that translation. Finite Fubini therefore removes the inner translation average without conditioning on rank, identifying the final expectation with the original-space uniform base. The complement indexing is independent of both translations.

Consequently the exact Lemma-56-type estimate needed is

    E_T||D_X D_A0B0,T f||_4^4
      <= 2^(100(d-t)^2+6dk)
          sum_{C,H: C intersect A1=A0, H+B1=B0}
              E_T||D_(X|H mod C) D_CH,T f||_2^4.      (56*)

One may keep 3dk instead of 6dk by the preceding count, but retaining 6dk aligns with the source's later accounting. All summands with degree below zero are removed before applying induction. The base case d=0 has no nonzero t term.

A source cutoff requires correction: the final ordinary dimension-plus-codimension in the intermediate pair is s+2k+u+v, which can be as large as d+k, not necessarily d. What is controlled is mixed order s+k+u+v<=d. The complement estimate above uses that correct mixed order and does not invoke the stronger, unjustified cutoff. In particular u,v<=d is sufficient. This distinction must survive any formal transcription.

## 5. Precise join and remaining status

T1, T2, (51*), (52*) and (56*) are finite derivations supplied here. They retain coherent Fourier phases, exact triple/complement indexing, true degree lowering and uniform translation averaging. The separate `2026-09-13-realizable-hardness-transfer-assembly-accounting.md` reconstructs the remaining interchange-of-sums multiplicity and exponents from (52*) and (56*) to the pre-Corollary-55 Lemma-57 estimate. Its hypotheses are these actual transfers, not external certificates; its proof and this note require joint independent review.

Once that join is validated, the reviewed weight-6 fourth-power estimate removes the auxiliary rank-poset derivatives while preserving the 100 exponent. This does not reinstate the false pinned Corollary-55 weight-4 statement. The final small-influence 103 estimate further uses the separately reviewed exact rank-incidence count. Globalness/influence conversion, subsequent dyadic foundations and complete kernel implementation remain distinct obligations even if this analytic fourth-moment chain closes.

No compiler, Git, paper, public action or new Lean module was used. This artifact asserts no novelty, full paper certification, upstream source-hardness completion, or P-vs-NP conclusion.
