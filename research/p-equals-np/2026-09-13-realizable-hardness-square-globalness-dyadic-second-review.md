# Separate review of square-globalness and dyadic induction

2026-09-13. S3137. Reviewer: incidence_complexity_review. Verdict: GO for the finite SQ196/DY200 deduction from the explicitly reviewed finite inputs; no Lean, full-paper or source-hardness acceptance.

Bound to complete author note `2026-09-13-realizable-hardness-square-globalness-dyadic-derivation.md`, SHA256 `3c75f32e997b35156178ebbc9165717de55485565eb379d64eacc4eaefd0a98c`. I did not author the square-globalness/dyadic argument. I authored the reverse influence-to-globalness conversion and reviewed the forward conversion, and now use DY200 in my separate Lp-prime bridge. This dependency authorship is disclosed; it is not represented as independent certification of my own conversion. Compact has a separate review of this author note. The present review checks the new square/product and dyadic join against the stated accepted inputs.

The source comparison is Evra/Kindler/Lifshitz arXiv:2404.00641v2, Lemma4.1/Theorem1.13, preserved text SHA256 `7fb002153b3ac62a3238c61574b65b3a2a28de3ce253fe6272d697a63247ab1a`, PDF `fa4c9ebaf56104957b2cbb5dc3cb06f45e86152104e6311ed00a9491ddeb58c4`. The reconstruction explicitly does not inherit the source's omitted conversion factor, uncharged restricted-norm enlargement, or smaller doubled-degree coefficient.

## Actual functions and restriction hypotheses

The product identity for trace characters and rank subadditivity imply degree(f^2)<=2d. Complex f is allowed: |f^2|=|f|^2 gives both the norm identity in the induction and the equality between squared L2 norm of a restricted square and fourth moment of the restricted f. Raw affine restriction sends a frequency to q_A Y|B, whose rank never increases. Thus each restriction still has degree at most the supplied d; no assumption about available ranks on smaller spaces is needed.

Actual restrictions compose by canonical quotient/inclusion maps with base T+j_B S q_A and additive order. Up-to-3d globalness therefore makes every actual order<=2d restriction up-to-d global. The source's exact-order convention would not justify this on an empty family; the candidate uses the explicit up-to-order statement throughout, correctly.

## Both restricted factors and constants

The full-function conversion supplies influences2^(11d^2)epsilon; the reviewed fourth moment contributes103d^2. This gives F114, including the necessary conversion cost. Applying the reverse conversion at r=3d then gives B=2^(41d^2)epsilon.

For h an order<=2d restriction, its globalness parameter is B and its whole-space squared norm is also bounded only by B. Applying conversion and fourth moment on that actual smaller space yields

    ||h||_4^4<=2^(114d^2)B||h||_2^2
              <=2^(114d^2)B^2
              =2^(196d^2)epsilon^2.

Both B factors are charged. This proves actual square-globalness, not just an estimate for the unconditioned square. No original epsilon bound is improperly reused for the restricted norm.

## Dyadic induction and range

The p=4 base is F114. At p>=8, the p/2 hypothesis is applied to f^2 at degree2d, giving the factor4A_(p/2)d^2. Its globalness parameter is the proved SQ196 value. Substitution of ||f^2||_2^2=||f||_4^4 and F114 gives precisely

    A_p=4A_(p/2)+49p-82,
    epsilon exponent=2(p/4-1)+1=p/2-1.

The stronger invariant A_p<=200p^2-100p holds at4 and propagates to200p^2-151p-82, below the requested invariant. Thus the advertised200 coefficient is valid without the source's doubled-degree arithmetic shortcut. This induction is on p, simultaneous over degree bounds, dimensions and positive parameters; it never invokes the still-separate Lp-prime bridge or target Theorem1.13.

The endpoint p=2 is elementary; p=1 is excluded. Epsilon=0 forces f=0 by order-zero globalness, avoiding ambiguous zero powers. At d=0 the constant-function estimate has coefficient1. Singleton matrix spaces and oversized degrees are covered because all hypotheses quantify actual restrictions through the bound, not a nonexistent exact-order family. No rank-poset derivative contraction is used.

## Result and limits

No blocking defect was found. The note proves SQ196 and DY200 from the actual finite conversions and fourth-moment theorem, with precise parameter powers and all required dimension cases. Joining the independently reviewed Lp-prime bridge is a subsequent finite deduction; this review does not preempt that joint check. No compiler, experiment, Lean artifact, Git or paper change occurred. Finite derivation acceptance does not certify the complete paper or establish novelty.
