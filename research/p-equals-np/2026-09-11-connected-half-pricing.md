# Connected-half pricing and exact rational packing

2026-09-11, S3073. Informal reviewed derivation under [integrity](../../INTEGRITY-CLAIMS.md), with the scoped independent reviews recorded below. No implementation, experiment, novelty claim or P-versus-NP result. This note proves a deterministic pricing/packing guarantee, using balanced halves with logarithmically many connected pieces for every minimal circuit. The original robust FKO margin is accounted for below; strongest-prior and novelty assessments remain separate.

## Fixed input and the comparator

Let B have M>=1 original three-variable clause columns, and nu be their sign-parity vector. Let G be the clause-intersection graph, with maximum degree bounded by d=max(1,3(Delta-1)), where Delta bounds variable occurrence. The empty input is trivial. Fix k>=2, h=floor(k/2), and r=3 ceil(log2 k)+3. Let C be the family of nonempty odd even-incidence tuples T with |T|<=k that admit a disjoint partition T=U union V into two nonempty subsets of G, each of size at most h and a union of at most r connected sets. Connectivity refers to the induced graph on that subset. C is not supplied to the algorithm. The structural argument below shows it contains every minimal odd circuit of size at most k, although not necessarily every odd tuple.

Let W_C be its optimal fractional packing mass under unit original-clause capacities. The finite LP has variables y_T>=0, sum_(T containing c)y_T<=1, and objective sum_T y_T. Always W_C<=M. We construct an exactly feasible packing of general short odd tuples with mass at least W_C/(1+epsilon), for any rational 0<epsilon<=1/2. The output need not lie in C; this relaxation is deliberate and safe for FKO verification.

## General list-coverage contract

The pricing and rational-packing proofs below use only a finite explicit list of nonempty original-clause subsets, exact syndrome/sign/cardinality keys, and the following coverage condition: every comparator tuple has a disjoint partition into two listed subsets with total size at most k. They do not use connectivity after the list is built. If every short minimal circuit has such a partition, the odd-component argument makes the oracle and packing guarantee apply to all short odd tuples. List-generation time and list length must always be charged. The independently checked structural instantiation below uses balanced halves with at most r connected pieces. A simpler two-thirds connected split is retained as an intermediate result, not the final list bound.

## One deterministic pricing query

Enumerate once all connected subsets of size at most h, then all ordered collections of at most r such sets whose summed sizes are at most h. Store each nonempty union in L; duplicate unions may be discarded but are already charged in the attempt bound. Overlapping component choices are harmless. [Patel-Regts, Lemma 2.4](https://arxiv.org/pdf/1707.05186v2) supplies connected-set enumeration. The counting argument below bounds the complete union list, including generation, by poly(k,r) M^r (2 C_0 d)^h attempts for an absolute constant C_0. Precompute original-ID lists, exact syndromes B1_U, signs nu dot 1_U and cardinalities; group by exact sorting. Dense n-bit syndromes and sorting are charged.

Given any nonnegative rational price vector p on the M clauses, scan L to retain one minimum-price representative for each syndrome/sign/cardinality bucket. Among opposite-sign bucket pairs with the same syndrome and cardinalities i,j satisfying i+j<=k, choose the pair U,V minimizing p(U)+p(V), and output S=U symmetric-difference V. Opposite signs ensure S is nonempty and odd. Equal syndrome ensures B1_S=0. Its support is at most |U|+|V|=i+j<=k; cardinality keys make the support contract explicit and also support the two-thirds intermediate, where twice the list cap can exceed k. Exact verification uses original IDs.

For any comparator T=A disjoint-union D, its halves have equal syndrome and opposite signs. The retained representatives for their buckets satisfy p(U)+p(V)<=p(A)+p(D)=p(T). Nonnegativity gives p(S)<=p(U)+p(V). Thus the chosen output obeys

p(S) <= min_(T in C) p(T).

At this point the proof establishes domination relative to C. The structural reduction below strengthens it to exact minimum-price search over all short odd tuples for nonnegative prices. Overlap does not require a pairwise disjointness search: it cancels IDs, shortens support and only decreases nonnegative price. One representative per bucket suffices for this query but does not enumerate every tuple. If no opposite-parity bucket pair exists, C is empty; return the empty packing. Otherwise the same bucket-pair availability persists for every price vector.

Each query scans the list once and scans its buckets, using O(|L| h) rational additions and at most O(h^2) bucket-pair checks per syndrome, plus polynomial bit overhead and original-ID processing. There is no quadratic cross-product of list elements. Arbitrary rational input prices of bounded encoding length may be converted to a common denominator of polynomial encoding length; exact comparisons remain charged.

## Why the corrected comparator covers every circuit

The original requirement of two connected halves, each of size at most floor(k/2), is false. A connected cubic graph with a central vertex and three five-vertex lobes gives a 16-clause minimal circuit without an 8/8 connected bipartition. Each lobe is K4 with one edge subdivided; connect its subdivision vertex to the center. The graph is cubic. Encode each graph edge as a variable and each vertex as the clause of its three incident variables. Connectedness makes the full clause set minimal even-incidence: a proper subset has a graph edge crossing its cut. A connected part avoiding the center lies in one lobe and has at most five vertices. This is a finite structural counterexample, not a random-input lower bound.

For any minimal circuit T of e weight-three columns, pair the occurrences of each used variable arbitrarily within T. The pairs form a loopless cubic multigraph on the e clause IDs. Every edge corresponds to two clauses sharing a variable. This multigraph must be connected: a component would contain an even number of occurrences of each variable and hence would be a proper dependent subset. Take a spanning tree, which has maximum degree at most three. Root it at a centroid, so every branch has at most floor(e/2) vertices. The largest of at most three branches has size b>=ceil((e-1)/3). Cutting its edge to the centroid leaves two connected parts, each of size at most

e-ceil((e-1)/3)=floor((2e+1)/3).

Both parts are connected also in the original clause-intersection graph. This proves the simpler two-thirds disjoint split for every circuit; it neither assumes biconnectivity nor supplies the circuit to the algorithm. Size-two circuits are covered by the same tree argument.

To obtain balanced halves, recursively partition this subcubic tree with prescribed first-side size t. Cases t=0 and t=s assign the entire current tree of size s to one side. Otherwise put a centroid on the first side, assign whole branches to that side while they fit the remaining budget, and recurse in the first branch exceeding the residual budget. All later branches go to the second side; if the budget is zero, no recursion is needed. Only one branch recurses, and it has size at most floor(s/2). Each nonterminal level adds one connected first-side piece and at most two connected second-side pieces; a terminal level adds at most three pieces. Thus r=3 ceil(log2 k)+3 is a safe bound for each side. Every even-incidence tuple of weight-three columns has even size, because its total incidence 3e is even. Taking t=e/2 gives two halves of size e/2<=h. Tree pieces remain connected in G. This proves coverage without discovering an unknown circuit or its pairing tree in advance.

For completeness, a connected-set count of size j is at most M(C_0 d)^j for an absolute constant C_0. For a positive composition j_1+...+j_a=s<=h with a<=r, ordered component choices number at most M^a(C_0 d)^s. There are at most 2^h compositions across all s<=h. Summing and allowing polynomial bookkeeping gives poly(k,r) M^r(2 C_0 d)^h attempts. Each attempt constructs a union and its key in polynomial time. This bound counts duplicates and overlaps, so no free deduplication or hidden Cartesian search is used. It includes every required half by choosing its actual disjoint components. The complete structural derivation is in the [companion](2026-09-11-connected-half-structure.md), independently checked by the source/complexity reviewer; its author does not self-approve that lemma.

Every odd even-incidence tuple decomposes into disjoint minimal circuits, at least one odd. Replace its packing weight by that of an odd component. This preserves mass and cannot increase any clause load, including after identical components are coalesced. Since every such short odd component belongs to C, W_C equals the optimal mass W_all over ALL odd even-incidence tuples of size at most k. The same reduction shows min_(T in C)p(T)=min_(T short odd)p(T) for every nonnegative p: an odd minimal component has no greater price. Since the oracle output is itself a valid short odd tuple, its domination bound therefore attains this common minimum exactly. Thus the following packing bound is an all-short-tuple guarantee on a fixed input, not merely a hypothetical random split-compatible family.

## Explicit packing algorithm

Use positive row weights w_c, initially all one. Set eta=epsilon/4, b=ceil(log_2(max(2,M))), and

J=ceil(16 M b/epsilon^2).

Repeat J times: call the pricing oracle with weights w; record its output S_j; multiply w_c by 1+eta for every c in S_j, leaving other weights unchanged. Let l_c count the recorded outputs containing c, and L_max=max_c l_c. Return one weight 1/L_max for each recorded output, merging repetitions by adding their weights. Since every output is nonempty, L_max>=1. Every clause load is l_c/L_max<=1 exactly, and total output mass is J/L_max.

Assume W_C>0 for the performance proof; if W_C=0 any feasible output satisfies the claimed lower bound. Normalize the current weights only in the analysis: p_c=w_c/sum_v w_v. An optimal comparator packing induces a probability distribution y_T/W_C, whose expected p-cost is at most 1/W_C by feasibility. The oracle therefore returns p(S_j)<=1/W_C each round. The total weight increases by a factor 1+eta p(S_j), so

log(sum_c w_c after J rounds) <= log M + eta J/W_C.

On the other hand the maximum row weight is (1+eta)^(L_max). Consequently

L_max/J <= [eta/W_C + log M/J]/log(1+eta)
          <= (1+eta)[1/W_C + log M/(eta J)],

using log(1+eta)>=eta/(1+eta). Our choice of J gives log M/(eta J)<=epsilon/(4M)<=epsilon/(4W_C). Therefore

L_max/J <= (1+epsilon/4)^2/W_C <= (1+epsilon)/W_C,

and the exactly feasible output has mass at least W_C/(1+epsilon). The procedure need not know W_C or any optimal comparator tuple. Adaptive prices are handled pointwise on the same input; no fresh random-sign hypothesis occurs.

This is a direct specialization of the established multiplicative-weights/packing framework, not a new optimization principle. Compare [Arora-Hazan-Kale, multiplicative weights](https://theoryofcomputing.org/articles/v008a006/v008a006.pdf) and [Young, explicit mixed packing/covering, Theorem 1](https://arxiv.org/pdf/1407.3015). The short proof here specifies the exact oracle guarantee and rational implementation rather than importing an unspecified LP runtime.

## Exact bit costs and margin

Write eta=a/q in lowest terms. During round t one may store integer weights (q+a)^(l_c) q^(t-l_c), which share denominator q^t with the conceptual weights. Update all M integers by q or q+a each round. Their bit lengths are O(J log(q+a)); storing and updating them, summing at most h per list item, and comparing bucket minima costs polynomial(M,k,epsilon^(-1),bitlength(epsilon)) per list item across the whole procedure. No transcendental values are computed; logarithms above are only proof notation and b is an integer bit-length bound.

The number of oracle calls is J=poly(M,epsilon^(-1)). The total bit cost is

|L| poly(n,M,k,epsilon^(-1),bitlength(epsilon)),

plus the charged component-union enumeration and exact grouping. Memory is the precomputed list/syndromes times polynomial factors, the polynomial-bit row weights, and J outputs of at most k IDs. Final weights have denominator L_max<=J; verification of parity, sign, loads and total mass is polynomial in the explicit output length. Hence packing does not square |L| or double its degree exponent.

If a certified FKO threshold is H=(I+n lambda_bar)/2 with all directed numerical obligations satisfied, W_C/(1+epsilon)>H suffices for the returned packing to certify the strict inequality. This is a hypothesis on actual comparator mass and margin, not a conclusion from tuple existence. If only a tiny gap is available, epsilon and its inverse cost must be charged. A rational output and exact load checks do not themselves certify the spectral upper bound.

## Applying the original robust FKO margin

[FKO, Section 4, Theorem 4.1 and Corollary 4.2, printed p. 9](https://www.microsoft.com/en-us/research/wp-content/uploads/2017/03/unsat.pdf) supplies, with high probability at sufficiently large fixed density constant, robust witnesses of support cap k=O(n^(1/5)) satisfying t>d_FKO(I+n lambda). Here d_FKO is tuple load, distinct from graph degree d. Their normalized mass W_0=t/d_FKO exceeds 2H, where H=(I+n lambda)/2. We can take the actual maximum load, so a nonempty witness has W_0>=1. Since W_all>=W_0, choosing epsilon=1/2 yields output mass at least 2W_all/3>=2W_0/3>H+W_0/6>=H+1/6. Thus a directed upper estimate of H with additive error at most 1/8 still leaves a strict certificate gap. This uses the original robust existence theorem, not a new random packing lemma.

The source matrix is a rational symmetric n-by-n matrix with polynomial-bit entries. Compute a directed eigenvalue upper bound by rational bisection within Gershgorin bounds, widened by one. At each rational midpoint x, test positive definiteness of xI-M by exact leading principal determinants (Sylvester's criterion). A positive test means x>lambda_max; a failed test means x<=lambda_max. Maintain these two endpoints and stop at width at most 1/(4n); the upper endpoint gives H error at most 1/8. Exact determinant computation and rational bisection have polynomial bit cost here: the initial range is polynomial in the input magnitude, if the initial interval width is R, the number of bisections is O(log(4nR)), and determinant numerator/denominator lengths are polynomial in n and entry lengths. Fraction-free elimination or exact rational elimination suffices; no approximate-eigenvector upper certificate is assumed. Verify the original FKO sign convention, imbalance and load inequality on the actual input. This is sound on every input; the source theorem supplies success probability only on its random distribution.

FKO samples signed clauses without replacement. At M=Theta(n^(7/5)), iid uniform signed clauses collide with probability O(M^2/n^3)=O(n^(-1/5)); conditioned on no signed duplicate, the unordered distribution is the same. This transfers the robust existence statement to the iid model with an additional o(1) exception. Separately the maximum variable degree is O(M/n) with high probability by a binomial tail and union bound. Choose the constant in k large enough for the source witness theorem. These facts give the displayed random-input runtime and successful refutation with high probability; they do not identify a sharp support constant or establish superiority to refuters with different constants or contracts.

## Quantitative comparison and remaining boundaries

The deterministic bit-runtime upper bound, including preparation, all pricing queries and rational packing, is

M^{O(log k)} 2^{O(k)} max(1,Delta)^{floor(k/2)} poly(n,M,k,epsilon^(-1),bitlength(epsilon)).

At M=Theta(n^(7/5)), Delta=O(n^(2/5)), k=Theta(n^(1/5)) and constant epsilon, its logarithm is at most (1/5)k log n+O(k)+O((log n)^2). The simpler two-thirds list gives (4/15)k log n+O(k); full connected-set enumeration gives (2/5)k log n+O(k), at the same support cap. These are explicit upper-bound comparisons. The new bound remains exp(O(k log n)); no matching lower bound, polynomial finder, or literature-wide superiority is claimed.

The algorithm obtains mass at least W_all/(1+epsilon) with exact feasible rational output. The preceding application accounts for original robust FKO mass, constant margin and directed spectral precision at a sufficiently large source-dependent support cap. Existing refuters may have different support constants and output contracts; equal-symbol k comparisons do not settle their relative cost. A full strongest-source/novelty assessment is pending.

The [source comparison](2026-09-11-connected-half-sources.md) identifies close precedent for syndrome/sign/cardinality joins with symmetric difference despite overlap, including [Webster-Jacob-Higgott v2, Section 4.3.1, Algorithm 9](https://arxiv.org/html/2603.22532v2); multiplicative weights and connected enumeration are established tools. The [structural companion](2026-09-11-connected-half-structure.md) records the failed connected-half split, the two-thirds intermediate and the balanced-component construction. Dumer-Kovalev-Pryadko cluster enumeration and the cited signed join are established ancestors; see the source note for their exact models. The balanced-component-list/pricing synthesis has the scoped independent checks below; no novelty is presumed. No new experiment, implementation, publication or claim of meeting the continuing research goal follows from this draft. An improved average-case FKO procedure would still lack the worst-case bridge needed to settle P versus NP.

## Independent review and verification boundary

| Lens | Verdict and scope |
|---|---|
| [Proof-adversarial](2026-09-11-connected-half-proof-review.md) | GO: exact pricing, rational packing, robust-margin application and directed spectral precision. The structural contributor did not self-approve the partition lemmas. |
| [Complexity/source](2026-09-11-connected-half-complexity-review.md) | GO: independently checked the partition and union enumeration, then the complete pricing/packing bit cost and random-input application. |
| [Non-claims](2026-09-11-connected-half-nonclaims-review.md) | GO for final main, companions and updated meta-graph; source-dependent success, checked-baseline comparison and unresolved worst-case/novelty boundaries retained. |

These are informal mathematical and document checks, including whitespace inspection, not Lean verification, executed code or experimental evidence. The fixed-input oracle/packing theorem and source-dependent random refutation application are the reviewed scope. Priority, literature-wide fastest status and publication readiness are unverified; the continuing research goal is not declared achieved.
