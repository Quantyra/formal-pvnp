# Connected-part pricing: independent complexity and structural review

2026-09-11; S3073 under [integrity](../../INTEGRITY-CLAIMS.md). Independently read [pricing/packing](2026-09-11-connected-half-pricing.md) and [structure](2026-09-11-connected-half-structure.md). This reviewer contributed the [source comparison](2026-09-11-connected-half-sources.md), not those proofs. Informal analytic review; no implementation, experiment, Lean verification or human peer review.

**GO for the deterministic structural, general-list pricing and rational packing guarantees below.** The latest main text was reread after adoption of the logarithmic-component half-union list. This covers that final instantiation, with the two-thirds connected list retained as an intermediate. It is not novelty certification, a fastest-refuter claim, or a worst-case P-versus-NP bridge.

## Structural checks independent of the originating scout

The 16-vertex cubic three-lobe counterexample is valid: any connected side not containing the center lies inside one five-vertex lobe. Its incidence matrix has exactly one nonempty zero-sum support, since every graph edge forces equal inclusion of its endpoints. Thus balanced connected halves cannot be presumed for all circuits.

For any minimal weight-three circuit, pairing the occurrences at each row gives a loopless cubic multigraph, with parallel edges allowed. A connected component includes complete row pairs and would itself be even; minimality forces the graph connected for every pairing. A subcubic spanning tree has a centroid whose largest branch is between ceil((e-1)/3) and floor(e/2). Cutting that branch gives the exact two-thirds bound. The argument includes a two-column duplicate-support circuit and does not assume random biconnectivity.

The stronger prescribed-size recursion is also sound. At each centroid, assign the centroid and fitting whole branches to the first side; at most one branch is partially assigned recursively, with size at most half the current tree. Whole branches plus the centroid form one connected first-side piece; the remaining whole branches contribute at most two second-side pieces. There are logarithmically many nonterminal levels. The stated q=3 ceil(log2 k)+3 is conservative. With e even, prescribed size e/2 yields disjoint equal halves; each consists of at most q connected sets in the actual clause graph, because extra edges cannot disconnect a piece.

For component sizes s_1+...+s_r<=h and r<=q, multiplying connected-set counts gives M^r(Cd)^(sum s_i). Summing positive compositions costs at most an exponential-in-h factor, giving poly(h,q) M^q(2Cd)^h. Overlap rejection and duplicate retention do not omit the disjoint comparator representation. Attempt processing, exact keys and sorting introduce polynomial factors or logarithms of this list bound. The M^q factor cannot be called polynomial uniformly; at M=Theta(n^(7/5)), k=Theta(n^(1/5)), its logarithm is O((log n)^2).

## Exact oracle and output contract

Retaining a cheapest representative per syndrome, sign and cardinality is sufficient. For a comparator split, its bucket representatives have no larger summed nonnegative price. Their symmetric difference has zero incidence, odd sign and hence nonempty support. The cardinality-pair condition i+j<=k controls output size despite the larger two-thirds list. Overlap only lowers price, and no disjoint-pair search is necessary.

Every short odd tuple contains an odd minimal circuit of no greater price; transferring its packing weight to that component preserves mass and decreases loads. Universal split coverage therefore makes the returned feasible tuple an exact minimum-price tuple among all short odd tuples, not just a restricted comparator. Empty compatible buckets mean that no such tuple exists. These statements are pointwise for all nonnegative rational prices on the fixed signed input, so adaptive prices do not require independent new signs.

The oracle costs a complete list rescan plus polynomially many cardinality comparisons per syndrome. It does not materialize all pairs. A minimum from an earlier price vector cannot be reused without updating; the main proof correctly rescans. The full-union list uses identical keys and logic after construction.

## Packing and bit arithmetic

The main multiplicative-weights potential argument is valid. With eta=epsilon/4 and J>=16 M b/epsilon^2, b=ceil(log2(max(2,M))), one has log M/(eta J)<=epsilon/(4M)<=epsilon/(4W). Combining the maximum-row lower potential with the total-weight upper potential yields maximum load/J <=(1+epsilon/4)^2/W <=(1+epsilon)/W. The returned weights 1/maximum-load give exactly feasible loads and mass at least W/(1+epsilon). If the tuple family is empty, the explicit early empty-packing case is necessary and supplied.

For eta=a/q, integer numerators (q+a)^load q^(t-load) all have the same denominator q^t, so the claimed integer updates and exact minimum comparisons implement the conceptual weights. Numerator bit length is O(J log(q+a)); J is polynomial in M and inverse epsilon. Output weights have denominator at most J. Hence total wrapper bit work is list length times polynomial original-input, inverse-accuracy and encoding factors. No unproved near-linear implicit LP implementation is being substituted for this direct argument.

The two-thirds list has leading log bound (4/15)k log n; the logarithmic-component half list has (1/5)k log n+O(k)+O((log n)^2), at the stipulated FKO scales and polynomially bounded inverse accuracy. These improve the displayed full connected-list upper bound at the same k. They do not compare exact support constants of every existing refuter. The original FKO Section 4 and Corollary 4.2 explicitly supply robust witnesses t>d(I+n lambda)=2dH for sufficiently large density constant, so a constant approximation factor below two has source-backed room. Transfer from its without-replacement signed-clause model to iid signed clauses loses only O(M^2/n^3)=O(n^(-1/5)) probability by coupling on no duplicate signed clause. Certified spectral data and its precision remain application obligations; rational load feasibility alone does not discharge them.

## Source and significance verdict

Syndrome/sign/cardinality matching with symmetric difference is explicit prior in Webster-Jacob-Higgott2026 Algorithm 9. Dumer-Kovalev-Pryadko's sparse irreducible-cluster method and Patel-Regts enumeration are direct ancestry. The focused source check did not verify a theorem already supplying the exact hybrid reduced list, but does not establish novelty or optimality. The meaningful local conclusion is a checked algorithmic upper-bound improvement over named baselines, with all quasi-polynomial and accuracy costs retained, not a universal computational shortcut.

## Final robust-margin and spectral addition checked

The latest main application's robust-margin paragraphs were independently reread after saving. Using actual maximum tuple load ensures W_0=t/d_FKO>=1; robust existence gives W_0>2H. With epsilon=1/2, returned mass is at least 2W_all/3>=2W_0/3>H+W_0/6>=H+1/6. A directed H error at most 1/8 is therefore sufficient, with no unquantified tiny-margin assumption.

For the rational symmetric source matrix, widened Gershgorin bounds enclose the maximum eigenvalue strictly. Sylvester's leading-principal-minor test on xI-M is true exactly when x exceeds that eigenvalue, including the correct negative answer at equality. Rational bisection preserves a valid upper endpoint and narrows its error to at most 1/(4n), giving H error at most 1/8. Polynomially many exact rational determinant operations have polynomial bit lengths in matrix dimension and entry encodings. This establishes the claimed polynomial spectral overhead; it does not invoke a numerical heuristic.

Final GO includes this source-conditioned random-FKO application and its iid/no-replacement coupling, with the support-cap constant chosen sufficiently large for the original theorem. The same-input certificate is sound independently of the distribution. No sharper leading support constant or literature-wide runtime advantage has been verified. Both the new list bound and successful-refutation statement remain within the existing exp(O(n^(1/5) log n)) order, while improving the specified full-list comparison at equal k.
