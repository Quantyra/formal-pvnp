# Independent square-globalness and dyadic review

2026-09-13. S3137. compact_source_encoding_audit. Bounded mathematical challenge; no compiler, new Lean, paper edits, Git or public action. I contributed to the earlier derivative/W6 work and reviewed the finite fourth-moment and conversion chains. This review does not confer kernel acceptance or claim independence from every upstream contribution. Final exact author-file binding is recorded after its stable draft is read.

## Actual inputs, not source theorem certificates

The relevant setting is finite binary V,W, complex f on Hom(V,W), degree at most d and squared-L2 globalness on all actual affine restrictions of order at most d, at every base. Let the bound be epsilon>=0. This is the up-to-order premise, not a potentially empty exact-order family.

The finite inputs already reconstructed are: the small-influence fourth-moment estimate with exponent103; up-to-d globalness implies full degree-at-most-d influences with exponent11d^2; and degree-at-most-d small influences imply globalness at all orders through r with multiplier2^(10dr). These are statements about actual hybrid derivatives and normalized probability restrictions. No EKL1.13 or MZ4.6 is used as an input to this review.

## Constants114,41 and196

The full-function influence conversion uses orthogonality between residual rank levels and gives parameter2^(11d^2)epsilon. Combining with the fourth-moment theorem gives

    ||f||_4^4<=2^(114d^2)epsilon||f||_2^2.

Using the reverse conversion instead, at order3d, gives actual up-to-3d globalness parameter2^(41d^2)epsilon. This remains meaningful if3d exceeds the available restriction dimensions: the reverse theorem bounds every existing restriction, including order zero, rather than inferring something from an empty exact-order premise.

For any raw restriction R of order at most2d, let g=Rf. A character's residual rank cannot exceed its original rank, so g has degree at most d. Any further raw restriction of order at most d composes to an actual restriction of the parent of order at most3d, with the canonical embedded affine base. Consequently g is up-to-d global with parameter eta=2^(41d^2)epsilon, on its actual smaller function space.

Apply the already derived114 estimate to g. Its order-zero globalness gives ||g||_2^2<=eta. Thus

    ||g||_4^4<=2^(114d^2)eta||g||_2^2
              <=2^(196d^2)epsilon^2.

Both factors eta are retained. This is exactly the square-globalness claim because ||R(f^2)||_2^2=||Rf||_4^4, valid also for complex functions. No pointwise rank-poset contraction or unsupported restricted-norm bound by the original epsilon is used.

Fourier convolution and rank(Y+Z)<=rank Y+rank Z show that f^2 has degree at most2d. Arbitrary affine restriction does not increase degree, and restriction commutes with squaring as an equality of actual functions. No false commuting of rank projection with restriction is needed.

## Doubled degree in the dyadic induction

The target moment range is dyadic p>=2; it does not include p=1. One may take A_2=0, A_4=114 and for dyadic p>=8

    A_p=4A_(p/2)+49p-82.

The intermediate bound is ||f||_p^p<=2^(A_p d^2)||f||_2^2 epsilon^(p/2-1). At p=2 it is an identity; at p=4 it is the114 estimate. For p>=8, apply the already proved p/2 case to f^2, whose degree bound is2d and whose up-to-2d globalness parameter is2^(196d^2)epsilon^2. The coefficient from the induction hypothesis is4A_(p/2)d^2, not A_(p/2)d^2. Also ||f^2||_2^2=||f||_4^4. Applying the114 estimate to that factor gives

    4A_(p/2)+196(p/4-1)+114
      =4A_(p/2)+49p-82,

and the epsilon exponent is2(p/4-1)+1=p/2-1. This proves the recurrence without assuming the current p theorem at doubled degree: the induction is on p simultaneously for all d and all finite spaces.

The proposed invariant A_p<=200p^2-100p holds at p=2 and p=4. Its induction step gives

    4[200(p/2)^2-100(p/2)]+49p-82
      =200p^2-151p-82<=200p^2-100p.

Hence the advertised200 coefficient follows. The negative linear slack is what permits repeated doubling of the degree. Merely applying the coarser200p^2 induction statement would not reproduce the printed50d^2p^2 intermediate coefficient.

## Boundaries and remaining scope

If epsilon=0, order-zero globalness forces f=0 and every moment/square conclusion is immediate. If d=0, f is constant with |f|^2<=epsilon; for p>=2, |f|^p<=|f|^2 epsilon^(p/2-1). Zero-dimensional spaces fall in the same constant case. Larger supplied degree bounds are allowed: the proof needs degree at most d, and every conversion uses up-to-order premises on actual spaces. The exact-order convention may be used only with a justified refinement to up-to-order globalness; the vacuous d>dim V+dim W case is not valid for arbitrary full functions.

All parameters here are squared-norm globalness parameters, not their square roots. No assumption epsilon<=1 is needed for this moment induction, unlike the later weakening of a density exponent for Boolean level projections. The latter and the L^{p'} bridge remain separate joins. This review does not establish the full manuscript, upstream hardness, Lean verification, novelty or publication readiness.

## Final exact-file binding

I read the complete author `2026-09-13-realizable-hardness-square-globalness-dyadic-derivation.md` and freshly verified SHA256 3c75f32e997b35156178ebbc9165717de55485565eb379d64eacc4eaefd0a98c. Its exact inputs are the binary fourth-moment joint review f7fc37b4fb420e65d2c5cc473db798482f85f03df9e196291f87aa533ca77512, forward conversion c905e6ae82fcc0369161f20b007a02339ecb01a4e4e94bfeea32d4d2ba98f111 and reverse conversion 563187200f9761458f9d9b106042fafb381238d7a4ea2a7e88275ac2a4c1112b, all previously fully reviewed. These are finite mathematical derivations, not kernel-certified dependencies.

Bounded mathematical GO for actual SQ196 and DY200 on the stated up-to-order hypotheses. The author proves the original function's114 bound, actual all-orders41 enlargement, both restricted factors, product/restriction rank bounds and the full simultaneous dyadic induction. Its explicit p=1 exclusion and epsilon=0/d=0 branches agree with this challenge. There is no remaining reliance on EKL1.13 as an imported analytic assumption for DY200, and the earlier provisional status of this arithmetic is superseded for these exact premises. The L^{p'}-to-level bridge, final MZ500 join, full manuscript and Lean verification remain separate. No compiler or Git action was taken.
