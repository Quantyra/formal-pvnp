# Independent finite derivative core and boundary review

2026-09-13. S3137. compact_source_encoding_audit. Mathematical source review only: no compiler, new Lean, paper edits, Git or public action. Destination protocol context is unchanged; no local AGENTS.md was present on the previously checked formal root/companion. Prior constructor authorship and analytic import reviews do not establish these derivative results or the fourth-moment inequality.

**Finding:** the actual Fourier selector gives exact rank loss and nested derivative composition for all subspace boundaries. A direct transcription using unrestricted natural-number subtraction is false. The safe formal interface uses additive level indices, with a separate vanishing theorem below the derivative order. These are finite linear-algebra derivations; they are not kernel-checked results and do not establish EKL22 Theorem58/Corollary65.

## Pinned primary and actual definitions

Read EKL22 arXiv:2209.04243v1, preserved `C:/Users/Dan/AppData/Local/Temp/s3134-ellis2209.04243v1.txt`, SHA256 9259246e882f05e02fb8585400fed15b6a1d9e68106cbcd813c8851ecfdc468a, Lemmas34-35 and Proposition38 (printed pp.22-23); and EKL24 arXiv:2404.00641v2, `s3134-ekl2404.00641v2.txt`, SHA256 7fb002153b3ac62a3238c61574b65b3a2a28de3ce253fe6272d697a63247ab1a, Definition2.1/Lemma2.2/Proposition2.3. The source order is dim(V0)+codim(W0), not the actual affine codimension of the restriction.

Let V,W be finite binary vector spaces, X:W->V a Fourier label, and chi_X(A)=(-1)^tr(XA) for A:V->W. Write q:V->V/V0 and j:W0->W for the canonical maps. The selector is

    sel(V0,W0,X) iff V0 <= im(X) and X^(-1)(V0) <= W0.

The derivative first retains selected Fourier terms, then restricts to A=T+jBq with B:V/V0->W0. It is not ordinary restriction. Cyclicity of the trace gives its action on each character exactly:

    D_(V0,W0,T)(chi_X)(B)
      = chi_X(T) chi_(qXj)(B), if sel(V0,W0,X);
      = 0, otherwise.

Fourier labels may collide after restriction. This formula, and finite linearity, accounts for the resulting sums and cancellations; no injective-frequency assumption is made.

## Rank loss, including small dimensions

Let a=dim(V0), b=codim(W0), i=a+b. If X is selected, ker(X)<=W0 because ker(X)<=X^(-1)(V0). Moreover V0<=X(W0): any preimage of a vector in V0 lies in W0. Thus

    rank(X|W0)=dim(W0)-dim(ker X)=rank(X)-b,
    rank(qXj)=rank(X|W0)-a=rank(X)-i.

Equivalently rank(X)=i+rank(qXj), an equality with no truncated subtraction. In particular selection is impossible when rank(X)<i. If i>min(dim V,dim W), the entire derivative is zero, even though the underlying affine restriction remains a well-defined nonempty coset. This settles those boundaries without any implicit dimension threshold.

Every selected original rank-d term has residual rank d-i. Conversely every term contributing to residual rank k had original rank i+k. Colliding frequencies cannot introduce a different rank. For every natural k the precise projection identity is therefore

    D(f^{=i+k}) = (Df)^{=k}.

Also D(f^{=d})=0 whenever d<i. These imply the familiar subtraction identity when i<=d, or for integer-indexed projections with negative levels defined as zero. For a degree-at-most-d input with d<i the output is zero; otherwise its degree is at most d-i. A claimed nonzero pure-degree output is unnecessary: cancellation can annihilate a level.

### Fully computed binary 1x1 counterexample to truncated subtraction

Take V=W=F_2, V0=V, W0=W, i=1 and T=0. The input matrices are a=0,1. Let f(a)=(-1)^a, so f(0)=1, f(1)=-1 and its normalized mean is zero. Its only Fourier label is X=id, of rank1, with coefficient1. This X passes the selector: im X=V and X^(-1)(V)=W<=W.

The restricted domain Hom(V/V0,W0)=Hom(0,F_2) contains one point. At that point the derivative is f(0)=1, hence Df is the constant1 function and (Df)^{=0}=1. But f^{=0}=0, so D(f^{=0})=0. With natural truncated subtraction, d=0 gives d-i=0 and the printed-looking equality would assert 0=1.

This is an indexing counterexample, not a counterexample to the source's usual interpretation of a negative Fourier level as zero. A Lean implementation must choose the additive identity above, an explicit i<=d premise, or integer levels. Merely defining out-of-range natural projections as zero does not fix the issue: level0 is in range.

## Nested selector composition, with affine types explicit

Take V2<=V1<=V and W1<=W2<=W. Put q2:V->V/V2 and j2:W2->W. After the first derivative, the actual dual label is Y=q2 X j2, a map W2->V/V2. The second selector uses V1/V2 and W1 inside these spaces. The exact equivalence is

    sel(V1,W1,X)
      iff sel(V2,W2,X) and sel(V1/V2,W1,Y).

Forward: the final conditions imply the first ones. Every v in V1 has an X-preimage in X^(-1)(V1)<=W1, hence its class is in im Y. If w in W2 has Yw in V1/V2, then Xw in V1, so w in W1.

Reverse: the first selector gives V2<=X(W2) and ker X<=W2. The second image condition lifts each v in V1 modulo V2 to X(W2); the remaining V2 error also lifts in W2. Hence V1<=X(W2). If Xw is in V1, choose w2 in W2 with Xw2=Xw. Then w-w2 is in ker X<=W2, so w is in W2. The second preimage condition now implies w in W1. This proves the final selector.

For S:V/V2->W2, its canonical ambient embedding is j2 S q2. It is not an arbitrary choice of extension. The two character phases multiply as

    chi_X(T) chi_Y(S)=chi_X(T+j2 S q2).

The final residual map agrees under (V/V2)/(V1/V2) ~= V/V1. Therefore finite character expansion proves

    D_(V1/V2,W1,S) o D_(V2,W2,T)
      = D_(V1,W1,T+j2 S q2),

with the quotient-domain identification explicit. The second order is dim(V1)-dim(V2)+dim(W2)-dim(W1); adding the first order gives dim(V1)+codim_W(W1). No generic-position, independence or strict-containment assumptions are needed.

One source-display typing detail should not be copied: the phase paragraph of EKL22 Proposition38 appears to name the intermediate Y using the final W1,V/V1 instead of the first W2,V/V2. Its subsequent selector equation(3.2) uses the correctly typed Y=X(W2,V/V2), and the proof above uses that type throughout. This does not undermine the composition identity.

## Zero/full boundaries and remaining foundation

At V0=0,W0=W, every Fourier label passes and D_(0,W,T) is translation f(T+.), not necessarily the identity; it is the identity at T=0. At V0=V,W0=W, only surjective labels survive and the output domain is a point. At V0=0,W0=0, only injective labels survive and the output domain is a point. More extreme or zero-dimensional cases are handled by the same selector/rank equality: if one ambient space is zero, positive-order derivatives vanish. All nested equalities above allow equal subspaces and zero/full choices.

The finite proof core is enough to justify exact degree bookkeeping and nested derivative composition once encoded with actual quotient maps. It does not provide the moment estimate, influence-to-globalness bounds or the degree-reduction expansion feeding Theorem58. Those remain separate substantive obligations. No full analytic, Lean, hardness, novelty or publication acceptance follows from this note.

## Final author-file binding

After the independent derivation above, I read the complete stable author artifact `2026-09-13-realizable-hardness-generalized-derivative-core-derivation.md`, freshly verified SHA256 aa45294da61022daa69fdf932b88b51cad0856b301596393a640e52162949328. Its hybrid definitions, rank case split, nested selector/phase proof and averaged energy agree with this review, including the explicit natural-subtraction warning. Bounded GO for that finite mathematical core; no Lean acceptance.

The author's additional Definition33 fixed-shift collision and binary Lemma53 repair were independently checked in `2026-09-13-realizable-hardness-fixed-derivative-collision-independent-review.md`, SHA256 b0f1e59069ecb431874161a9e5e0f0fd9c4ad4ff3cd476be0b3da03e3e8d270b. The four-character energy is 16 rather than 4, but the actual weighted second-energy inequality survives with coefficient at most 19/15 by counting collision fibers and rank projections. This does not restore the false pointwise contraction or prove Corollary55's weighted fourth-power bound. The final author file correctly keeps that step, Lemma46 and the Theorem58 induction unresolved; this binding preserves those limitations.

The author's final residual correctly identifies Lemma46 as the degree-reduction L4 input and Lemma59 as the separate later homogeneous-Laplacian/globalness ingredient. Neither is discharged by this core or collision review.
