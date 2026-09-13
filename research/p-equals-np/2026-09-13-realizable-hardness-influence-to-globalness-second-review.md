# Independent second review: influences to actual affine globalness

2026-09-13; S3137. Reviewed entire `2026-09-13-realizable-hardness-influence-to-globalness-derivation.md`, SHA256 `563187200f9761458f9d9b106042fafb381238d7a4ea2a7e88275ac2a4c1112b`. Verdict: GO for the stated finite mathematical implication, not Lean or complete hypercontractivity acceptance.

## Independence and evidence

I did not author this reverse-direction derivation. I authored the separate forward globalness-to-level-influence proof and earlier derivative-core/transfer material, and exchanged operator-normalization context with this author. Thus this is a distinct source review, not a claim of independent authorship of its shared foundations. The earlier derivative core has its own separate review. I read the full candidate, including conditional measures, both induction ranges and constants. No compiler, experiment, source modification or Git action was performed.

Primary ancestry is Evra/Kindler/Lifshitz arXiv:2404.00641v2, Proposition 3.6 and its averaging lemmas, as pinned in the candidate. The preserved text SHA256 is `7fb002153b3ac62a3238c61574b65b3a2a28de3ce253fe6272d697a63247ab1a`; PDF SHA256 `fa4c9ebaf56104957b2cbb5dc3cb06f45e86152104e6311ed00a9491ddeb58c4`. This review verifies the explicit argument supplied, not the sufficiency of citing that proposition.

## Conditional averaging law

The critical probability calculation is sound. With U=<v> contained in the original constrained A, conditioning on A'=ker(phi|A) leaves exactly one restriction of phi to A in the binary field: it is zero on A' and takes v to one. Its values on a chosen complement of A remain independently uniform. The noise w and these functionals stay independent after separately conditioning on B'=B+<w>.

Choose coordinates on V/A' consisting of v and a complement of A. A uniform original variation R in Hom(V/A,B) has its v-column zero and remaining columns independently uniform in B. In the same-B case w is uniform in B; adding w phi makes the first column uniform and the remaining B-columns remain independent and uniform even conditional on w and phi. Thus the full variation is uniform in Hom(V/A',B).

In the expanded-B' case, w is uniform in B' minus B. For each other column, an independent uniform B vector plus an independent uniform bit times w is uniform in B'. This conditional distribution is independent of the particular nonzero coset representative w. The resulting matrix is therefore uniform among all Hom(V/A',B') maps whose v-column is outside B. Since B has codimension one in B', this event has probability exactly one-half under the unrestricted uniform law. For nonnegative |f|^2, conditioning costs at most two. The affine base simply translates this law and remains one of the bases quantified in the globalness hypothesis.

The corresponding unrestricted orders drop by one or two, respectively. An apparent order s-1 at s=0 cannot introduce a negative-order assumption: the expanded case is then impossible, since the original order-at-most-one restriction containing U must have B=W. Zero-dimensional B and singleton distributions are also handled correctly. There is no full-rank conditioning, unidentified fiber weight or silent change to counting measure.

## Operators, induction and constants

The exact E_v Fourier multiplier is zero when v lies in im Y and 2^-rankY otherwise; the homogeneous identity f=L_Uf+2^d E_vf follows. Transpose/annihilator duality sends actual affine restriction spaces bijectively to the stated dual spaces, preserving their dimensions, shifts and uniform measures. It supplies the codomain-hyperplane case without a new hypothesis.

Level projections contract the actual hybrid derivative norm because distinct original levels become distinct residual ranks. This is projection contraction on the reduced space, not the invalid fixed-base rank-poset D_X contraction. Nested composition also verifies that an order-one derivative inherits the required influences on the reduced space with every base covered.

The strengthened statement for every r>=0 is the right induction invariant. Outer induction on d supplies all r for lower-degree functions, while inner induction on r supplies the top level at r-1. Both d=0 and r=0 use actual order-zero influence, and no exact-order family is assumed nonempty. These ranges justify all recursive calls.

For the top level the displayed relative coefficient is at most 2^-9+2^-6=9/512, strictly less than one-quarter. The lower-level triangle bound is used only where the restricted levels need not remain orthogonal; its geometric series gives the relative squared bound 1/961. Combining the whole top and whole lower parts costs a factor two, yielding 1/2+2/961<1. Thus the advertised 2^(10dr) epsilon squared-norm bound holds with its stated constants. Epsilon zero is covered without division, or directly by the order-zero norm bound.

## Boundary of the conclusion

No circular use of the forward conversion, the fourth-moment theorem or hypercontractivity occurs. The result concerns full bounded-degree functions and actual restrictions at all orders up to r. The later applications 10i^2 and 41i^2 are squared-norm parameters with the recorded input conversion, not density statements for signed projections. No mathematical blocker was found in this reverse implication. The dyadic product/globalness join, complete kernel proof, upstream hardness and full paper certification remain separate.
