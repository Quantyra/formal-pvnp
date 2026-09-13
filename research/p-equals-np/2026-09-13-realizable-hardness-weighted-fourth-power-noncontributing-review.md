# Noncontributing review of the weighted fourth-power replacement

2026-09-13. S3137. Reviewer: incidence_complexity_review. Verdict: GO for the finite counterexample and W6; GO conditional on the exact (57-pre) inequality for the final constant propagation. This is not full Theorem58, hypercontractivity, paper or Lean acceptance.

Reviewed the complete `2026-09-13-realizable-hardness-weighted-fourth-power-derivation.md`, SHA256 `591d30061dfac1031d5990683aea1e7a88c6c0508e0d03691a724d5c53fd1120`. I did not derive or contribute to its counterexample or changed weight. I authored the separate degree-reduction DR6 and rank-incidence notes and earlier paper/proof components; their authorship is disclosed rather than counted as independent verification of those components. Compact contributed to the counterexample/repair, so this is the distinct noncontributing review requested by root. Its existing independent-review filename was preserved; this note uses a separate path.

Primary: Ellis/Kindler/Lifshitz arXiv:2209.04243v1, preserved Temp PDF SHA256 `4455f4a757b2abc1b7a3dd41f3495b68bf2e2b9aa4d05a5b0953fe4e751a991f` and text `9259246e882f05e02fb8585400fed15b6a1d9e68106cbcd813c8851ecfdc468a`. I read the relevant Definition33/core derivation and actual source Lemma57 statement and proof through its final Corollary55 invocation. The printed pre-step has exactly 6d^2, 100d^2, -31d(k+1), and -4dk as transcribed. Its derivation from the earlier transfer lemmas remains conditional.

## Actual derivative and GL4 counterexample

The operator restricts selected frequencies Y>=X at base zero; it is not an orthogonal projection. For rank-k X in identity block form, selected originals over reduced rank-l Z are

    Y=[[I+uZv,uZ],[Zv,Z]].

The maps u:im Z->im X and Zv:im X->im Z are independently arbitrary and determined by the off-diagonal blocks. There are exactly 2^(2kl) originals. Block elimination gives rank Y=k+l and rank(Y-X)=l; conversely rank additivity forces the image/kernel factorization and these blocks, without another upper-left parameter. Restriction characters depend only on Z, so coherent fiber multiplicities matter.

For V=W=F2^4 and f=sum_{Y invertible}chi_Y, Parseval gives E=|GL4|=15*14*12*8=20160. There are225 rank-one X. Each has168=|GL3| invertible residual frequencies; each residual coefficient sums64 positive terms. Hence

    e_X=||D_X f||_2^2=168*64^2=688128,
    e_X/E=512/15,
    225*2^-16*(512/15)^2=4.

The last line is the normalized rank-one contribution with the old weight. X=0 adds1. This strictly exceeds2 without floating point, asymptotics or nonzero phases. Thus the precise pinned Corollary55 statement is false; this does not refute Theorem58 or any uninspected revision.

## W6 and uniform constant

Fiberwise Cauchy-Schwarz gives e_X<=2^(2k(d-k))a_X, with a_X selected original Fourier energy. The correct next step is a_X^2<=Ea_X; it does not assume e_X<=E. For fixed rank-j Y, rank-k predecessors are projections on im Y and number [j choose k]_2 2^(k(j-k)). The Gaussian bound <=4*2^(k(j-k)) has a dimension-uniform denominator: the first three product factors give21/64, and the remaining product is at least7/8, greater in total than1/4; k=0,1,2 are direct cases.

The exact exponent after finite summation exchange is

    -6dk+4k(d-k)+2k(j-k)=2k(j-d)-6k^2.

Since j<=d, each original frequency coefficient is at most 1+4 sum_{k>=1}2^-6k^2<=1+4/63=67/63. This proves W6 uniformly in both dimensions, without dividing by E. Zero degree, zero spaces and zero function are handled correctly. A supplied oversized degree only weakens the bound.

## Conditional Lemma57 absorption

The factorization

    2^(-31d(k+1)-4dk)=2^-31d * 2^-29dk * 2^-6dk

is exact. Dropping the positive-order constraint enlarges the nonnegative sum. Applying W6 at common degree bound d to each hybrid derivative is valid on its actual quotient domain by rank lowering. Averaging over the original uniform T creates no extra factor. Consequently R<=(67/63)2^-31d Q(f)<=2^(1-31d)Q(f).

The zero-order hybrid derivative is a translate of f, giving Q(f)>=E^2, not ||f||_4^4. The residual factor after multiplying (57-pre) by162 is

    162[2^-94d^2+2^(1-31d)]<1, d>=1,

since each bracket term is at most2^-30 and324/2^30<1. The d=0 case is equality. Thus the repaired last step preserves100 conditional on (57-pre), and the separate incidence count then supplies103 under that same boundary.

The later200/500 algebra remains conditional. I checked its recurrence substitution: 4[200(p/2)^2-100(p/2)]+49p-82=200p^2-151p-82. This supports the invariant but proves none of the globalness/square-conversion premises. No new acceptance of those premises follows here.

## Limits and next obligation

No blocking error was found in the exact counterexample, W6 or conditional propagation. The next required work is the full hybrid/X restriction-transfer and counting route proving (57-pre). The separately authored DR6 candidate supplies only the convolution input and requires its own independent review. No compiler, experiment, Lean axiom, source/paper edit, Git or public action occurred. This bounded mathematical review is not a completed formal proof or novelty claim.
