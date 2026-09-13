# Review of the actual Laplacian transfer identities

2026-09-13. S3137. Reviewer: incidence_complexity_review. Verdict: GO for the finite T1/T2 identities and their displayed norm transfers; (56*) remains conditional on strict lower-degree induction. This review is not a full analytic-chain, paper or Lean acceptance.

Reviewed the complete `2026-09-13-realizable-hardness-laplacian-transfer-derivation.md`, SHA256 `3ba2a817ed2462513448a83ddb2e2dda61b4ee0958308e1b25c468fea1d15e00`. I did not author its character-selector T1/T2 arguments. I authored the separate DR6 and final assembly accounting and coordinated with the author on the2^(ij) count and corrected mixed-order cutoff. Accordingly this is a separate check of the author's transfer proofs, not a claim of wholly noncontributing independence for the shared counting/arithmetic. Compact separately reviews my assembly. Prior derivative-core acceptance is explicitly relied on for normalized characters and nested hybrid composition.

Primary: Ellis/Kindler/Lifshitz arXiv:2209.04243v1, preserved PDF SHA256 `4455f4a757b2abc1b7a3dd41f3495b68bf2e2b9aa4d05a5b0953fe4e751a991f`, text SHA256 `9259246e882f05e02fb8585400fed15b6a1d9e68106cbcd813c8851ecfdc468a`. I checked source Propositions39/40 including the arbitrary-shift clause of40 and the Lemma56 transfer displays. The candidate reconstructs the identities, rather than using their source statements as unproved L4 certificates.

## T1: unique selected summand

The construction C=Y(B) intersect A, H=B+Y^-1(A), X(b+z)=Yz modulo C is well-defined; the ambiguity lies in B intersect Y^-1(A) and maps into C. The ordinary conditions A<=im Y and ker Y<=B give image A/C and kernel B for X. The quotient image components Y(B)/C and A/C are disjoint and separately attained, proving rank additivity against R=q_C Y|H.

The reverse direction also checks. From the hybrid selector and X<=R one gets A<=im Y, ker Y<=B, then C=Y(B) intersect A using the rank-poset agreement on R^-1(im X). Matching preimages modulo C puts Y^-1(A) inside H; on this space R=X surjects onto A/C. Since ker X=B, this forces H=B+Y^-1(A), and determines X uniquely. No extra multiplicity survives per input character. Arbitrary base T contributes the original phase chi_Y(T); both sides have the same reduced frequency q_A Y|B.

## T2: reverse direction and uniqueness

I checked the nontrivial reverse argument without presuming X<=Y. The right hybrid selector implies C<=Y(H) and ker Y<=H. Since X(H)=im X and im X'<=im Y', lifting from the quotient proves im X<=im Y. If Yw is in im X, matching it by an h in H and using ker Y<=H puts w in H. Rank-poset agreement for X'<=Y' then says Yw-Xw lies in C. It also lies in im X, whose intersection with C is zero. Thus Yw=Xw on Y^-1(im X), and the stated elementary rank-poset characterization proves X<=Y.

With Z=Y-X, the right hybrid rank-drop identity now gives

    rank(q_C Z|H)=rank Z-dim C-codim H.

The loss from restriction is codim H-dim(ker Z/(ker Z intersect H)), at most codim H. The subsequent quotient loss is dim(C intersect Z(H)), at most dim C. Equality in their sum forces ker Z<=H and C<=Z(H). These are the two precise maximal-loss consequences needed, and imply Z^-1(C)<=H.

Then C=im Z intersect A2: C lies in im Z, and A2=im X directplus C while im Z is disjoint from im X. For H, ker Z+B2 is contained in H. Write n=dim W, rank Z=l and codim H=v. Since B2=H intersect ker X, its dimension is n-k-v; ker Z intersect B2=ker Y has dimension n-k-l. Hence dim(ker Z+B2)=n-v=dim H, proving H=ker Z+B2. This confirms uniqueness without an implicit dimension assumption. The remaining left selector follows from Z(ker X)=im Z and Z^-1(C)<=H.

The forward construction has the same forced C,H and checks both selectors. The disjoint-image rank calculation is supported by H=ker Z+B2: X is attained on ker Z and Z on B2, so the image sum is an equality as well as disjoint. The final domains are canonically Hom(V/A2,B2). For arbitrary S,T, the common phase is exactly chi_Y(S+j_B1 T q_A1), agreeing with source40(2). There is no fixed-base energy contraction claim.

## Norm transfer and reindexing

The actual T1 index set has2^(ij) elements, including its zero map; the fourth-power Holder cost is N^3. Reconstructing A,B from the mixed triple is unique and its order obeys i+j=t+k<=2t. Thus the displayed conservative24dt coefficient is adequate with DR6.

For T2 on a reduced space, subsequent order u+v<=d-t gives exactly2^(k(u+v)) complements. Holder costs2^(3k(u+v))<=2^(6dk). Each final pair reconstructs the intermediate pair as A1+C and B1 intersect H, so no uncharged summation multiplicity is introduced there. The correct intermediate ordinary order is s+2k+u+v<=d+k; the candidate does not reuse the source's unjustified <=d cutoff.

Composition shifts the original uniform T by an embedded function of the inner parameter. For each fixed inner parameter this is a bijection of the original full matrix group; finite Fubini removes the average without a factor. Complement indices are independent of translations. This verifies the normalization and the stated (56*) under simultaneous induction over all finite dimensions at strictly smaller degree d-t.

Zero spaces, zero rank, and vanishing mixed orders are consistent with the constructions. In particular t>d terms vanish before subtraction or an induction call; d=0 has no positive-order call. No strengthened fixed-aspect-ratio premise is imported.

## Acceptance boundary

No blocking defect was found in the actual transfer proofs or these norm deductions. The separate exact final multiplicity/exponent accounting must retain its own independent review before treating the entire fourth-moment induction as assembled. Even a closed finite analytic chain is not a compiled Lean proof, a proof of later globalness/influence conversions, a full paper certification or a novelty claim. No compiler, experiment, source/paper edit, Git or public action occurred in this review.
