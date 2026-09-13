# Independent influence-to-globalness review

2026-09-13. S3137. compact_source_encoding_audit. Reviewed the complete final candidate `2026-09-13-realizable-hardness-influence-to-globalness-derivation.md`, freshly verified SHA256 563187200f9761458f9d9b106042fafb381238d7a4ea2a7e88275ac2a4c1112b. I did not author this conversion. I contributed to earlier derivative/collision work and reviewed the opposite conversion; neither supplies the current conclusion. No compiler, new Lean, paper edit, Git or public action.

Primary route is Evra/Kindler/Lifshitz arXiv:2404.00641v2, preserved `C:/Users/Dan/AppData/Local/Temp/s3134-ekl2404.00641v2.txt`, SHA256 7fb002153b3ac62a3238c61574b65b3a2a28de3ce253fe6272d697a63247ab1a, actual averaging/globalness definitions, Lemmas3.2-3.5 and Proposition3.6. The candidate reconstructs their finite argument and strengthens the induction range; the verdict does not rely on citing the proposition as a premise.

**Bounded mathematical GO:** for a degree-at-most-d function whose actual hybrid influences through order d are <=epsilon at every base, the bound2^(10dr)epsilon holds on every actual affine restriction of order at most r, for every natural r. This is nonvacuous and dimension-uniform, including r<d. No fourth-moment or opposite globalness-to-influence theorem is assumed.

## Inheritance and the homogeneous identity

At a fixed hybrid derivative order s, input rank i<s is killed; otherwise it becomes precisely residual rank i-s. Orthogonal projection on the residual space therefore shows that every level inherits the influence bound. Collisions inside a level do not undermine orthogonality between distinct levels. For an order-one derivative at a fixed base, any subsequent derivative of order<=d-1 composes to an original derivative of order<=d at an actual translated base. The universal-base premise provides its influence bound directly.

The explicit line average translates by w tensor phi, with phi(v)=1 and w uniform. Its Fourier multiplier is0 if v belongs to im Y, and2^(-rank Y) otherwise. Thus on a homogeneous rank-d function, f=L_U f+2^d E_v f exactly. The frequency selector, additive map direction and squared-norm parameter are consistent. This is an actual finite character computation; no assumed spectral certificate occurs.

The codomain case uses ordinary finite transposition. An affine restriction (A,B) becomes (B annihilator,A annihilator), preserving variation-space order and uniform measure. For order one, ker Y<=B becomes the dual-line image condition, and the actual derivatives and phases correspond. More generally, the hybrid selector is compatible: A<=im Y and Y^(-1)(A)<=B are equivalent to ker Y<=B and A<=Y(B); annihilation turns these into the dual image and preimage conditions. Thus the dual step does not require a new influence premise.

## Conditional averaging checked column by column

Consider a restriction M0+Hom(V/A,B) with U=<v><=A and total order at most s+1. Condition the averaging choices on A'=ker(phi|A) and B'=B+<w>. The first condition leaves phi's values outside A uniform; the second leaves w uniform on the indicated part of B'. Because these conditions involve originally independent choices, their conditional distributions remain independent.

In coordinates of V/A' beginning with v, the raw restriction has first column zero and the other columns independently uniform in B. If w is in B, adding w tensor phi makes the first column uniform in B and preserves independent uniform B columns elsewhere. Hence the resulting map is uniform on Hom(V/A',B), an order-at-most-s restriction.

If w is outside B, the other columns become independent uniform B' columns: each is an independent uniform B column plus an independent fair binary multiple of w. Conditional on w, that distribution is uniform B' and does not depend on which outside vector w was chosen. The first column is uniform on B' minus B. Therefore this is precisely the uniform distribution on Hom(V/A',B') conditioned on its v column being outside B. That event has probability1/2. Nonnegative expectations are thus at most twice the unconditioned restriction expectation, whose order is at most s-1. The expanded case cannot arise at s=0 in the permitted total-order range, so no negative-order assumption is used.

Jensen before this conditioning gives the desired averaging bound2eta on the squared L2 norm. The same-B case costs only1. There is no hidden full-rank condition or cardinality factor. Zero-dimensional B and impossible expanded cases are handled by the stated singleton/zero-probability branches. An arbitrary M0 only translates the original function, preserving its all-base globalness hypothesis.

## One-step bound and double induction

For homogeneous degree d>=1, split using f=L_Uf+2^d E_vf on an actual order-r restriction. If the derivative term is globally bounded through order r-1 by eta1 and f itself through r-1 by eta2, squared triangle and the averaging lemma give

    restricted squared norm <=2eta1+4*2^(2d)eta2.

The factor4 comprises the triangle factor2 and the conditional averaging factor2. The derivative term is a restriction on its actual quotient space. A domain line exists when the domain constraint is nonzero; otherwise a codomain hyperplane can be chosen for a nonzero restriction order. These are exactly the cases covered by the argument.

Induct on d across all finite spaces and all r, and then on r at fixed d. The d=0 case is constant and is bounded by order-zero influence. The r=0 case is the translated whole-space L2 norm, also that influence. For positive d,r, every lower level i<d uses outer induction at r. The top level uses inner induction at r-1; its order-one derivatives use outer induction at degree d-1 and order r-1. All are already available because the theorem is stated for all r>=0, not merely r>=d.

Set K=2^(10dr)epsilon. The resulting exact-order-r top-level coefficient relative to K is

    2*2^(-10(r+d-1))+4*2^(-8d)
      <=2^-9+2^-6=9/512<1/4.

For smaller restriction orders the inner bound is <=2^-10d K<=K/4. For the sum of lower levels, the geometric series gives

    epsilon [sum_(i=0..d-1)2^(5ri)]^2
      <=epsilon (32/31)^2 2^(10r(d-1))<=K/961.

Squared triangle between this whole lower-level sum and the top level gives2K/961+K/2<K. The constants therefore close with the claimed10dr and with no unspecified large-parameter cutoff. The reasoning is multiplicative when epsilon=0, or that case follows immediately from zero order-zero influence.

## Dimensions and actual conclusion

If there is no exact-order-r restriction, the inner step uses the already proved smaller-order result; it does not select a line from an empty set. A nominal degree exceeding all possible ranks makes the top level zero, not the full function zero, and the proof treats it correctly. Quotient/subspace spaces are included in the outer simultaneous induction. There is no vacuous exact-degree-globalness premise anywhere: the input is the actual influence hypothesis including order zero, and the conclusion concerns all existing restrictions through r.

For degree parameter i the conclusion at r=i supplies the squared-norm multiplier2^(10i^2); at r=3i it supplies2^(30i^2). A separately proved full-function influence parameter2^(11i^2)epsilon would therefore give2^(41i^2)epsilon, with no square-root normalization error. This arithmetic does not alone prove square-globalness or the later dyadic theorem.

The candidate provides a complete finite proof of this reverse conversion, using core composition, finite projection and explicit averaging. It is not kernel formalization or blanket hypercontractivity acceptance. The dyadic/product bookkeeping, full Lean proof, upstream hardness and complete manuscript remain separate obligations. No novelty or publication claim is made.
