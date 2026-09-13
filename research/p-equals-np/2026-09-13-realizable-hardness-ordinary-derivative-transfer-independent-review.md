# Independent ordinary-to-derivative transfer challenge

2026-09-13. S3137. compact_source_encoding_audit. Finite mathematical challenge, no compiler, new Lean, paper edits, Git or public action. I contributed to prior core/collision work and checked the present selector/count estimates in coordination with the author. This is not a claim of independent kernel acceptance or full analytic certification.

Primary checked directly: Ellis/Kindler/Lifshitz arXiv:2209.04243v1, preserved `C:/Users/Dan/AppData/Local/Temp/s3134-ellis2209.04243v1.txt`, SHA256 9259246e882f05e02fb8585400fed15b6a1d9e68106cbcd813c8851ecfdc468a, Proposition39 and its stated uniqueness lemma, Proposition40, and Lemmas51,52,56. The exact author-file binding is recorded below when stable.

## Selector decomposition checked from the maps

Let A<=V, B<=W. The ordinary filter P_(A,B) retains Y when A<=im Y and ker Y<=B. It is not the hybrid filter. For a retained Y define

    C=Y(B) intersect A,   H=B+Y^(-1)(A),
    X(b+z)=Yz mod C,  b in B, z in Y^(-1)(A).

The formula is well-defined because ambiguity lies in B intersect Y^(-1)(A), whose image lies in C. It gives ker X=B and im X=A/C. Also C<=im Y and Y^(-1)(C)<=B<=H: the latter uses ker Y<=B. Thus Y passes the hybrid selector for (C,H).

Put R=q_C Y|H. Its image is (Y(B)+A)/C, the direct sum of Y(B)/C and A/C. On H=B+Y^(-1)(A), R-X is the projection to the first image component and X to the second; both images are attained. Hence rank R=rank X+rank(R-X), so X<=R in the actual rank-poset order.

Conversely, if a triple C<=A, H>=B, X:H/B~=A/C passes the two derivative selectors on Y, then A<=im Y and ker Y<=B. Indeed hybrid selection gives C<=im Y and Y^(-1)(C)<=H; the poset relation gives im X<=im R and ker R<=ker X=B. These imply the two ordinary conditions without an extra query-equality hypothesis.

For uniqueness, the standard rank-additive identities are used only in their actual form: ker R<=ker X and R agrees with X on R^(-1)(im X). If w in B has Yw in A, these identities give Yw in C. Conversely, every c in C has a Y-preimage in H, and its R-image is zero, so that preimage lies in B. Therefore C=Y(B) intersect A. Next Y^(-1)(A)<=H: lift the class of any Yw in A through im R, then use Y^(-1)(C)<=H. For h in H, lift Xh via R on R^(-1)(im X); the difference lies in ker X=B. Thus H=B+Y^(-1)(A). The agreement rule then determines X exactly by the displayed formula.

## Phases, quotient domains and all-triples count

On an input character chi_Y, the first derivative at T contributes the scalar chi_Y(T); the rank-poset derivative has base zero. The final residual label is q_A Y|B under the canonical quotient identification. Each passing ordinary character occurs in exactly one summand; each failing one occurs in none. Therefore the decomposition is an exact linear identity at every T. Frequencies may coincide after restriction, but this argument proves equality before summing them and does not require them to stay orthogonal at fixed T.

All possible triples are in bijection with arbitrary linear maps theta:A->W/B. The data are C=ker theta, H/B=im theta, and X is the inverse of the induced isomorphism A/C->H/B. Conversely the quotient map to A/C followed by this inverse gives theta. Thus there are exactly N=2^(ij) summands, i=dim A and j=codim B. This count is independent of ambient dimensions and includes theta=0, giving C=A,H=B,X=0. No arbitrary basis or extension choice multiplies it.

For any fixed residual variable, uniform translation by its canonical embedded map preserves uniform ambient T. Hence averaging the fourth power of the ordinary restricted function over T gives ||P_(A,B)f||_4^4 exactly. Pointwise finite Holder on the N summands yields N^3=2^(3ij) times their summed fourth moments. This does not assert fixed-base Parseval or energy contraction; those are false for rank-poset derivatives and are not used here. The source's looser Lemma51 coefficient follows as well, since 3ij<=5(i^2+j^2).

## Lemma52 coefficient and positive-order discipline

Apply this transfer to the independently reviewed DR6, with baseline 2^(6d^2). A nonzero ordinary filter has i,j<=d. The resulting coefficient exponent satisfies

    7d(i+j)+3ij<=10d(i+j).

For k=rank X, let t=dim C+codim H+k. The triple has i=dim C+k, j=codim H+k, so i+j=t+k<=2t. Hence the exponent is <=20dt<=24dt, retaining the source Lemma52 coefficient. No attempt to recover the stronger printed DR3 baseline is made.

The triple (C,H,X) uniquely determines A as the preimage of im X in V and B=ker X inside H, so reindexing introduces no additional multiplicity. The zero value t=0 is equivalent to C=0,H=W,X=0, which is precisely the excluded ordinary pair A=0,B=W. Thus the nontrivial DR6 terms become positive-order triples. For t>d the mixed derivative vanishes by the true rank-lowering theorem; the source expression with d-t must not be interpreted via unrestricted natural subtraction. For 1<=t<=d it has degree at most d-t<=d-1. These facts support the later induction's domain, but do not prove its derivative-interchange step.

Zero-dimensional spaces and d=0 are harmless: only the appropriate zero/identity maps occur, nontrivial surviving ordinary filters disappear, and all identities keep their actual singleton probability measures.

## Unresolved transfer needed before the full theorem

Proposition40 and Lemma56 require a separate exact interchange of a hybrid derivative with a rank-poset derivative, including a sum over complements and the affine shift embedded into the correct ambient space. Their invocation is not justified merely by the present Proposition39 identity. In particular independent uniform shift averaging may legitimately absorb a fixed embedded translation; it must not erase a phase or replace a coherent fixed-base norm by diagonal Fourier energy.

The displayed Lemma56 uses lower-degree induction on each actual quotient space and then complement multiplicity estimates. Its positive-order cases require 1<=t<=d, with t>d handled as zero. The later Lemma57 interchange/counting argument also remains a separate obligation. Accordingly the bounded result here is the exact Proposition39 transfer and the sufficient Lemma51/52 estimates; it is not (57-pre), Theorem58, global hypercontractivity, Lean, hardness, novelty or publication acceptance.

## Final bounded T1 binding and superseded status

I read the complete final author `2026-09-13-realizable-hardness-laplacian-transfer-derivation.md`, SHA256 3ba2a817ed2462513448a83ddb2e2dda61b4ee0958308e1b25c468fea1d15e00, and freshly verified its raw bytes. Sections1-2 match the T1 construction, exact count and 51*/52* bounds checked above. This note binds that bounded T1 verdict to the final author artifact.

The preceding pending-T2/56 language records the earlier review stage and is now historical. The full T2 identity and its joint consequence with assembly accounting were subsequently checked in `2026-09-13-realizable-hardness-binary-fourth-moment-joint-review.md`, SHA256 f7fc37b4fb420e65d2c5cc473db798482f85f03df9e196291f87aa533ca77512. That joint note supersedes the earlier pending status while retaining the distinction between finite mathematical100/103 closure and uncompleted globalness, dyadic and Lean obligations. No compiler or Git action was taken.
