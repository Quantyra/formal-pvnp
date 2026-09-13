# Binary generalized influences imply actual affine globalness

2026-09-13. S3137. Source-only derivation by incidence_complexity_review; candidate for independent review. No Lean/compiler, paper change, Git or public action. This direction is disjoint from the ongoing EKL22 Lemma64/Proposition63 conversion from globalness to level influences. It does not use hypercontractivity, the fourth-moment bound, or dyadic induction.

## Primary source and exact claim

Evra, Kindler and Lifshitz, arXiv:2404.00641v2 (19 December 2024), Definitions2.4/2.7, Lemmas2.11 and3.2-3.5, Proposition3.6, printed pp.9-11. Preserved `C:/Users/Dan/AppData/Local/Temp/s3134-ekl2404.00641v2.pdf`, SHA256 `fa4c9ebaf56104957b2cbb5dc3cb06f45e86152104e6311ed00a9491ddeb58c4`; same-stem `.txt`, SHA256 `7fb002153b3ac62a3238c61574b65b3a2a28de3ce253fe6272d697a63247ab1a`. This is distinct from Ellis/Kindler/Lifshitz arXiv:2209.04243v1. The binary derivative core0e5e5d0 supplies normalized characters, rank lowering and nested hybrid composition. No local AGENTS file was found; satellite README and root S3137 boundaries apply.

For finite binary V,W, let f:Hom(V,W)->C have degree at most d. Assume the ACTUAL influences satisfy

    ||D_{A,B,T}f||_2^2<=epsilon

for every A<=V,B<=W with dim A+codim B<=d and every full base T. Here D retains frequencies Y:W->V satisfying A<=im Y and Y^-1(A)<=B, then restricts to T+Hom(V/A,B). All norms and measures are normalized uniform probabilities. Take epsilon>=0.

I prove the slightly stronger, nonvacuous statement: for every natural r, every actual affine restriction of order AT MOST r has squared L2 norm at most

    2^(10dr) epsilon.                                       (G)

The source Proposition3.6 prints r>=d and globalness at exact order r. Its proof invokes an inner induction at r-1, which can fall below d. Proving (G) for all r closes that bookkeeping gap and handles nonexistent exact-order restrictions safely. It immediately implies the source's exact-order conclusion in its stated range. This is a bound for full degree-at-most-d f, not only homogeneous f. In the later level application f=F^{=i}, set d=r=i to get the required2^(10i^2) multiplier on the squared-norm influence parameter.

## Level projections preserve the influence hypothesis

For a fixed hybrid order s and rank level i, D(f^{=i})=0 if i<s; otherwise it is the rank-(i-s) Fourier projection of Df on the ACTUAL reduced space. Each selected original rank j becomes exactly j-s. Coalescing frequencies can therefore occur only within one original level, so reduced-level projection does not erase phases incorrectly. Parseval on that reduced space proves

    ||D(f^{=i})||_2^2<=||Df||_2^2.

Thus each level f^{=i} inherits all influences through order d, in particular through order i. An order-one derivative inherits all influences through d-1 by the exact nested composition and arbitrary-base hypothesis. This uses projection contraction, not the false fixed-base contraction of rank-poset D_X. No opposite-direction globalness theorem is invoked.

## The actual rank-one averaging operator and its multiplier

For v!=0 in V, let phi be uniform among V* functionals with phi(v)=1 and w independently uniform in W. Define

    E_v f(M)=E_{phi,w} f(M+w tensor phi).

This equals the source averaging over complements of span(v): phi corresponds bijectively to its kernel, and w is the free value at v. The tensor is a map V->W, correcting the reversed Hom-space typo in the source's prose identification.

On character chi_Y, averaging over w first gives indicator(phi composed with Y=0). If v is in im Y there is no admissible phi. Otherwise, if rank Y=j, exactly2^(dim V-j-1) of the2^(dim V-1) functionals qualify. Hence the multiplier is0 or2^-j respectively. For homogeneous degree d this proves the exact identity

    f=L_U f+2^d E_v f, U=span(v),                       (H)

where L_U is the order-one hybrid filter (U,W). No interpolation polynomial or imported spectral assertion is needed. All translations commute with E_v because it is an average of additive translations.

The codomain-hyperplane version follows by transposing Hom(V,W) to Hom(W*,V*). Actual affine restrictions (A,B) become (B annihilator,A annihilator), preserving order and uniform measure. The frequency kernel condition ker Y<=B becomes the corresponding dual-line image condition. Thus the same averaging identity and estimates apply to a codomain restriction. This is only finite duality, not a new influence hypothesis.

## Restriction averaging: explicit distribution and factor2

Suppose f is globally bounded by eta on every actual restriction of order at most s. Let U=span(v), and restrict E_v f first by U at ANY base, then by a further restriction of order at most s in the quotient. It suffices to bound an original restriction M0+R with R uniform in Hom(V/A,B), U<=A and dim A+codim B<=s+1. Translation moves the arbitrary M0 into f without changing any globalness hypothesis.

Jensen gives

    E_R |E_{phi,w} f(M0+R+w tensor phi)|^2
       <=E_{R,phi,w}|f(M0+R+w tensor phi)|^2.

Condition on A'=ker(phi|A) and B'=B+span(w). Since phi(v)=1, dim A'=dim A-1. Over F2 the restriction phi|A is uniquely determined by its kernel and its value at v, and its extensions outside A remain uniform. The choices of phi and w remain independent under these two separate conditions.

If B'=B, w is uniform in B. In a basis of V/A' starting with v, R has first column zero and its other columns independently uniform in B. Adding w tensor phi makes the first column uniform in B; all other columns stay independently uniform in B because their independent R entries absorb the shifts. Thus the resulting map is uniform in Hom(V/A',B).

If B' has dimension dim B+1, w is uniform in B' minus B. Conditional on w, each remaining column is an independent uniform element of B plus an independent uniform binary multiple of w, hence is uniform in B'. The first column is w. Thus the map is uniform among all Hom(V/A',B') maps taking v outside B. This event has density exactly1/2, so its conditional nonnegative expectation is at most twice the unrestricted expectation. No full-rank conditioning is present.

The unrestricted orders in these two cases are respectively at most s and s-1. Therefore the squared norm above is at most2eta. This proves that (E_v f) restricted first at U, at every base, is globally bounded by2eta through further order s. Zero-dimensional B is covered: the same-B case is deterministic zero and the expanded case has one nonzero choice. If an expanded case cannot exist its probability is zero. Complex f is handled throughout by absolute squares.

## One-step bound for a homogeneous function

Let r>=1 and f be homogeneous of degree d>=1. Assume f is globally bounded through order r-1 by eta2, and every order-one derivative at every base is globally bounded through order r-1 by eta1. For an actual restriction of order r, choose either a nonzero line in its domain constraint or, if that constraint is zero, a hyperplane containing its codomain constraint. This factors the actual restriction as one order-one restriction followed by order r-1. All base shifts are actual translations.

By (H), squared triangle inequality, and the preceding averaging lemma,

    restriction_norm_squared <=2eta1+4*2^(2d)eta2.        (S)

The derivative term is an order-(r-1) restriction of the actual order-one derivative. The averaging term has factor2 from the conditional density1/2, in addition to the squared triangle factor2. This derives the source Lemma3.5 with the correct squared-norm convention and arbitrary affine bases. Restrictions of smaller order are already covered by the hypothesis.

## Complete double induction and explicit constants

Induct first on d, simultaneously over all finite V,W and all r; at fixed d induct on r. If d=0, f is constant and order-zero influence bounds its squared absolute value by epsilon, hence every restriction has that bound. If r=0, the only restriction is the full-space translate, and the order-zero influence gives ||f||_2^2<=epsilon. These are valid even on singleton matrix spaces.

For d,r>=1, split f=sum_{i=0}^d f_i into rank levels. Each f_i inherits the influence bounds as proved above. Outer induction gives globalness through order r for i<d with parameter2^(10ri)epsilon. For the top level f_d, inner induction gives globalness through order r-1 with parameter2^(10d(r-1))epsilon. Every order-one derivative of f_d has degree at most d-1 and small influences through order d-1; outer induction makes it global through r-1 with parameter2^(10(d-1)(r-1))epsilon. Apply (S). Relative to K=2^(10dr)epsilon its coefficient is at most

    2*2^(-10(r+d-1))+4*2^(-8d)
       <=2^-9+2^-6=9/512<1/4.

For restrictions of order below r the inner bound is also at most K/4, since2^-10d<=1/4. Thus every top-level restricted squared norm is <=K/4.

For the lower levels, triangle inequality and a geometric series give the squared norm bound

    epsilon (sum_{i=0}^{d-1}2^(5ri))^2
      <=epsilon (32/31)^2 2^(10r(d-1)) <=K/961.

Using squared triangle once between the entire lower-level sum and the top level bounds the full restricted squared norm by

    2K/961+K/2 < K.

This proves (G). These comparisons may be read multiplicatively without division when epsilon=0; alternatively order-zero influence makes f identically zero immediately. No stronger density exponent is obtained by an inequality in the wrong direction.

If no restriction of exact order r exists, the inner-induction step simply uses the already established order<=r-1 result; no line is selected from an empty set. If a nominal degree d exceeds min(dim V,dim W), its top level is zero and the same induction still works. All smaller quotient/subspace dimensions are allowed in the simultaneous hypothesis. No ambient dimension enters the coefficient.

## Application and remaining boundary

The result concerns full f; specializing to f=F^{=i} with influence parameter eta gives actual affine restriction L2 squared norms <=2^(10i^2)eta at order i. At order3i it gives2^(30i^2)eta. If a previous conversion supplies eta=2^(11i^2)epsilon, the latter is2^(41i^2)epsilon. These are precisely squared-norm globalness parameters, not their square roots or a Boolean density claim for a signed level projection.

This derivation supplies the influence-to-globalness direction using only finite Fourier rank projection, core composition, exact rank-one averaging and elementary inequalities. It does not need the binary fourth-moment theorem5f203d3 and is therefore not circular with later dyadic hypercontractivity. The opposite conversion, full dyadic/globalness-product bookkeeping, kernel formalization and complete paper proof remain separate obligations. The proof is a reconstruction of a known source dependency, with explicit range/normalization corrections; no novelty claim or paper modification is made.
