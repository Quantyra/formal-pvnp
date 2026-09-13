# Independent restriction-globalness to level-influence review

2026-09-13. S3137. compact_source_encoding_audit. Bounded finite mathematical challenge; no compiler, Lean/paper edits, Git or public action. I did not author this conversion candidate; I contributed to earlier derivative/collision work and reviewed the binary fourth-moment chain. Those activities do not establish the present projection/globalness argument. Applicable satellite protocol context is unchanged.

Primary read directly: Ellis/Kindler/Lifshitz arXiv:2209.04243v1, preserved `C:/Users/Dan/AppData/Local/Temp/s3134-ellis2209.04243v1.txt`, SHA256 9259246e882f05e02fb8585400fed15b6a1d9e68106cbcd813c8851ecfdc468a, Lemmas59-61, Definition62, Lemma64 and Proposition63. The raw source proof has a zero-base construction despite an arbitrary-base statement and writes only the top-order induction case. The reviewed route must explicitly cover both issues rather than inherit them silently.

## Actual line and dual averaging operators

For a nonzero u spanning U<=V, define E_U by averaging translations w tensor phi with w uniform in W and phi uniform among functionals satisfying phi(u)=1. Averaging w first on a character chi_Y kills it unless phi annihilates im Y. If u lies in im Y that condition is impossible. Otherwise the proportion of eligible phi annihilating im Y is 2^(-rank Y). Thus the multiplier is0 when U<=im Y, and2^(-rank Y) otherwise. The average has total probability1 even if W is zero.

For a hyperplane B<=W, use its nonzero annihilating functional psi and average translations w tensor phi with w uniform in psi(w)=1 and phi uniform in V*. Averaging phi first gives the multiplier Pr[Yw=0]. If ker Y<=B it is0. Otherwise the intersection of ker Y with psi(w)=1 has half the elements of ker Y, giving exactly2^(-rank Y). This proves the dual formula directly; it is not an unchecked symmetry assertion. When a line or hyperplane of the requested kind does not exist, that derivative case is absent.

These are actual convex mixtures of ambient translations, so they commute with rank-level projections. More importantly, they preserve every bound on normalized L2 norms of actual affine restrictions at all shifts: Minkowski bounds the restriction of the average by the average of restriction norms, each controlled by globalness at a translated base. Their squares have the same property. No hypothesis about derivative energy contraction is needed.

## Projection/restriction interaction

For d>=1 define T_d=(I-2^d E)(I-2^(d-1)E). On levels d and d-1 it is exactly the order-one selector: its multiplier is1 on selected labels (E multiplier0) and0 on unselected labels (E multiplier2^(-rank)). This is a two-level statement, not the assertion that T_d equals that selector on all frequencies.

A raw line restriction sends a dual Y to its quotient by U; a raw hyperplane restriction sends it to Y|B. Each loses zero or one in rank. It loses one precisely on the corresponding selected labels. Therefore the output level d-1 of the restriction can receive input only from levels d and d-1. T_d removes the unselected contamination in both. Selected input of rank d gives the desired derivative level d-1; selected input of rank d-1 drops below that level. Consequently

    D_(order-one,T)(f^{=d})
      = ((T_d f) restricted at T)^{=d-1}.

This holds for arbitrary f, not only degree-at-most-d f, and at arbitrary affine base T; the input character phase is preserved. At d=1, the level0 contamination is explicitly killed by the second factor I-E. Higher and lower input ranks cannot reach output d-1. Thus no naive commuting of projection with restriction is used.

## Globalness parameter and all derivative orders

Let f have normalized squared-L2 restriction norm <=epsilon for every order<=d and every base, epsilon>=0. Set f' to the restriction of T_d f at the actual requested base T. Any subsequent order<=d-1 restriction of f' composes to an ambient restriction of order<=d with an embedded translated base. The triangle inequality and translation-mixture bounds give a norm loss at most

    C_d=1+2^d+2^(d-1)+2^(2d-1)<=2^(2d+1).

Squaring yields restriction-globalness parameter4*2^(4d)epsilon for f'. The argument explicitly uses f' at T, not a zero-base function substituted into an arbitrary-base theorem.

Induct on d simultaneously over all finite spaces to prove influences of f^{=d} at EVERY order k<=d are bounded by2^(10d^2)epsilon. For k=0 use Parseval/orthogonal projection directly: its energy is at most ||f||_2^2<=epsilon. For k>=1, if A is nonzero choose a line U<=A and factor off D_(U,W,T). Otherwise choose a hyperplane containing the target B and factor off D_(0,H,T). The remaining derivative has order k-1<=d-1 and base zero, with the canonical nested composition yielding the originally requested base T. The exact projection identity above supplies the level d-1 function to which induction applies. Thus its bound is

    2^(10(d-1)^2) *4*2^(4d)epsilon
      <=2^(10d^2)epsilon,

since 10(d-1)^2+4d+2<=10d^2 for d>=1. This proves all orders, not merely k=d. There is no need to pad a derivative with extra operations that might change its norm.

At d=0, f^{=0} is constant and the only order is0, handled by its mean-square bound. At epsilon=0, order-zero globalness forces f=0. If d exceeds maximum rank, f^{=d}=0. Zero-dimensional spaces and absent subspaces therefore do not create vacuous inference. The stated premise uses all actual restriction orders<=d, as in Definition62; converting a different nominal exact-budget convention is a separate, previously recorded interface argument.

## Scope

This is a finite conversion proof based on explicit averaging operators, adjacent-level interpolation and nested derivative composition. It does not use a fourth-moment inequality as a premise or a caller-provided theorem certificate. The reverse influence-to-globalness conversion, full dyadic hypercontractivity, Lean implementation and the complete manuscript goal remain separate. No novelty, hardness or publication claim follows. Final exact-file binding is recorded below once the author's stable candidate has been read.

## Final exact-file review and full-function corollary

I read the entire stable author `2026-09-13-realizable-hardness-globalness-to-level-influence-derivation.md` at initial SHA256 f3ff240c06f1a25c0e09aab516bb452fcb7acea9fa0d464ed1cfd25904715760, then read its added full-function section8 and freshly verified final SHA256 c905e6ae82fcc0369161f20b007a02339ecb01a4e4e94bfeea32d4d2ba98f111. Bounded mathematical GO for the actual arbitrary-shift/all-orders conversion. The author's finer accumulated exponent 4kd-2k^2+4k is the exact sum of 4r+2 over r=d-k+1,...,d, and is <=10d^2 in the stated range.

For a full degree-at-most-d function, the added corollary correctly uses orthogonality, not a squared triangle bound. At a fixed derivative of order k, input levels i<k vanish and levels i>=k have different residual ranks i-k. Therefore the actual influence is the sum of the individual level influences even though same-level frequencies may collide. Applying the proved level theorem at each i yields at most (d+1)2^(10d^2)epsilon<=2^(11d^2)epsilon for d>=1. Degree0 gives epsilon directly. This supplies the concrete full-function constant needed for later114 bookkeeping.

The exact-order convention is also handled correctly. When d<=dim V+dim W, a lower-order affine restriction can be partitioned into equal-size cosets of an actual order-d restriction subspace, so its squared norm inherits the same bound. If d exceeds that dimension sum, the exact-order family is empty. The rank-d projection is then zero, but a full degree-at-most-d function need not vanish. The new corollary expressly requires up-to-d globalness or the valid dimension condition; no vacuous exact-order assumption is used for the full-function conclusion.

No external analytic inequality is needed for this finite10/11 conversion. This does not establish the reverse direction, dyadic moment theorem, kernel implementation or the complete manuscript. No compiler or Git action was taken.
