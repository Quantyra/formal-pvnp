# Independent binary degree-reduction review

2026-09-13. S3137. Reviewer compact_source_encoding_audit. I did not author this degree-reduction derivation. I contributed to the separate Corollary55 counterexample/repair and earlier derivative-core work; those contributions do not establish the present two-class L4 inequality. This is a bounded mathematical review, not a kernel proof. No compiler, Lean/paper edits, Git or public action.

Reviewed the complete candidate `2026-09-13-realizable-hardness-binary-degree-reduction-derivation.md`, initial SHA256 bd85a1e93402c6d964085ba3a41204b45d220eb9fbdc9dee912107eb3f1a6985. Direct primary checks used Ellis/Kindler/Lifshitz arXiv:2209.04243v1, preserved `C:/Users/Dan/AppData/Local/Temp/s3134-ellis2209.04243v1.txt`, SHA256 9259246e882f05e02fb8585400fed15b6a1d9e68106cbcd813c8851ecfdc468a, Lemmas46,48,50 and the intervening convolution-class definitions. Verdict binds the clarified final candidate identified below.

**Bounded GO for DR6:** the actual cover, complex-safe partition, nonnegative Boolean encoding and signed incidence inversion justify the displayed 6d^2 baseline and unchanged 7d(i+j) weight. This does not establish the stronger printed 3d^2 baseline, the later ordinary-to-hybrid transfer, or the full Theorem58 induction.

## Cover and complex partition

The actual frequency filter is P_(A,B): retain A<=im X and ker X<=B. It is the composition of two ordinary Laplacians; substituting the hybrid condition X^(-1)(A)<=B would change the inequality.

The cover proof needs both the zero triple-image intersection and W=K_Y+K_Z+K_X. The constructed maps act on these generating kernels as follows:

    on K_Z: (A,B,C)=(Y,0,0);
    on K_Y: (A,B,C)=(0,Z,0);
    on K_X: (A,B,C)=(0,0,Y).

Their consistency on intersections follows from the zero triple-image condition, as in the candidate's identity (K_Z+K_X) intersect K_Y=K_Z intersect K_Y. The generating-kernel decomposition then gives im Y=Y(K_Z)+Y(K_X)=im A+im C and the analogous identities for Z and X. Combined with the proved zero pairwise image intersections this gives the required rank additivity. I requested that the author explicitly state this step: disjoint images by themselves would not prove rank additivity, but the actual construction does supply what is needed.

The two classes may overlap. The candidate correctly partitions into F2 and its complement, using complement(F2)<=F1, instead of falsely identifying the convolution with the sum of both signed classes. Its bound by H_X+|O_X| is valid for arbitrary complex Fourier coefficients: only H_X is replaced by the absolute coefficient majorant. The identity ||f||_4^4=||f^2||_2^2 uses absolute-value norms, so it also remains valid for complex f.

## Boolean class, including collisions and constants

Rank-additive decompositions of a rank-r map factor through its image and kernel quotient. Choosing the first summand as a map between the resulting r-dimensional spaces gives the valid upper count 2^(r^2). It is not a count of arbitrary maps on the original ambient spaces.

The Boolean encoding uses two disjoint coordinate copies, including two separate coordinates for the zero map. Thus each ordered (A,C) defines one distinct degree-two monomial x_A y_C. Its squared L2 norm is sum_M |fhat(M)|^2 N(M)<=2^(d^2)||f||_2^2. There is no constant-coordinate convention hiding a collision.

For a real polynomial G=g+xh, the fourth-moment expansion and Cauchy-Schwarz imply ||G||_4^2<=||g||_4^2+3||h||_4^2. Induction over coordinates gives the stated weighted coefficient norm; degree two implies ||F||_4^4<=81||F||_2^4. The candidate's F is real and nonnegative in its coefficients even though the original f may be complex, so this application has its actual hypotheses.

The h(A,B) comparison to ||F^2||_2^2 is also sound. For A!=B, the cube coefficient indexed by the unordered pair is 2h(A,B); its squared contribution dominates the two ordered-pair contributions. The only direct pair with A=B is A=B=0. That single h(0,0) is bounded by the constant coefficient of F^2. All these coefficients are nonnegative. Therefore the cube comparison does not rely on false injectivity of ordered-pair characters.

The convolution output X can have rank 2d. Bounding its direct decompositions by 2^(4d^2), then combining the Boolean estimate with the squared encoding norm, gives exactly 81*2^(6d^2)||f||_2^4. The final partition factor2 gives 162. No part of this calculation proves a 3d^2 exponent. The primary Lemma48 indeed displays the 6d^2 estimate.

## Signed overlap inversion

The coefficients alpha_k=(-1)^(k+1)2^(k(k-1)/2) satisfy the finite nonzero-subspace indicator identity by the Gaussian product formula at z=-1. Its hyperplane recurrence counts extensions by 2^(t-k), so the proposed elementary derivation has the correct exponent. At dimension0 the sum is empty and the indicator is zero.

Apply this identity to U=im X intersect im Y intersect im Z and to W/(ker X+ker Y+ker Z). Inclusion-exclusion for their nonzero indicators gives alpha_(i,0), alpha_(0,j), and -alpha_i alpha_j for the mixed term. Subspaces of the latter quotient correspond exactly to ambient B containing the kernel sum with codimension j. Consequently the candidate's O_X identity is an equality of complex numbers with the actual squared-filter Fourier coefficients. It preserves cancellation; it does not bound a coefficientwise absolute majorant by the signed function's L4 norm.

For fixed X with rank<=2d, the image-subspace and kernel-quotient counts are at most 2^(2d(i+j)). For surviving filters, i,j<=d and the squared inversion coefficient is <=2^(d(i+j)). Weighted Cauchy-Schwarz with weight 2^(7d(i+j)) therefore has remaining factor bounded by sum_(i,j>=0,(i,j)!=(0,0))2^(-4d(i+j)). At d>=1 it is <=31/225<1. Summing over X, enlarging only nonnegative squared-coefficient sums, and applying Parseval proves the overlap estimate with exactly the proposed weights. No assumption rank X<=d is made.

## Assembly and limits

The two classes yield ||f||_4^4<=162*2^(6d^2)||f||_2^4+2 times the weighted overlap sum. Dividing by162 and weakening 1/81 to1 gives DR6. Degree0, zero-dimensional spaces and f=0 are covered directly. If d exceeds all possible ranks, restoring the larger d only increases the coefficients and cannot invalidate the bound.

The candidate establishes this finite degree-reduction inequality with the corrected sufficient baseline. The transformation of ordinary composed Laplacians into hybrid and rank-poset derivatives, the earlier stages of Lemma57, and the complete analytic/Lean proof remain separate. The independently developed weight-6 repair does not by itself validate those stages. No full theorem, hardness, novelty or publication acceptance is given here.

## Final exact-file binding

The requested cover clarification was added in the final author candidate, SHA256 bac648685bf7a8df7e3b1828f84e7347beccf06b56a9fe09209bd7b82080a92d. I read that explicit kernel-generator/image-equality paragraph and freshly verified the final raw hash. It supplies the already constructed image equalities without adding any hypothesis or altering DR6. The bounded verdict above binds to these final bytes. No compiler or Git action was taken.
