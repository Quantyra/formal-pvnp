# Connected pricing parts: a deterministic two-thirds bridge

2026-09-11, S3073. Informal candidate under [integrity](../../INTEGRITY-CLAIMS.md), requiring independent review. No implementation, experiment, novelty claim or end-to-end packing runtime theorem. The initial half-size comparator restriction is unnecessary if the connected-list cap is enlarged to approximately two thirds and cardinality is retained in the query buckets.

## Exact obstruction to balanced halves

Construct a cubic graph as follows. Start with a central vertex v. Take three disjoint copies of K4, subdivide one edge in each copy, and connect its new subdivision vertex to v. Each five-vertex lobe now has all degrees three, as does v. There are 16 vertices in total. Assign a variable to each graph edge and a weight-three clause column to the three edges incident with each vertex. Every variable occurs exactly twice. The graph is connected, so a zero-sum subset of columns must include either both or neither endpoint of every edge; the full set is its only nonempty zero-sum subset. It is therefore a minimal binary circuit.

Its clause-intersection graph is precisely the constructed cubic graph. In any connected bipartition, the side avoiding v lies in a single five-vertex lobe. Consequently an 8/8 connected bipartition does not exist. Choosing odd sign parity on the full circuit makes this an odd-circuit example. This is an exact fixed-input obstruction, not an assertion of typical random-input frequency or packing mass.

## Pairing lemma for every minimal weight-three circuit

Let T be any minimal dependent set of e weight-three binary columns with distinct original clause IDs. Each used row has positive even incidence within T. Pair its incident clause IDs arbitrarily, separately for each row. Create an edge for each pair, labeled by that row, on the vertex set T. No edge is a loop, since a column uses each row at most once. Parallel edges are allowed. Each clause vertex has degree three, counting multiplicity.

The resulting cubic multigraph is connected. Indeed, each of its connected components contains whole pairs at every row, hence has even incidence at every row. A proper component would be a nonempty proper dependency, contradicting minimality of T. Every pairing choice has this property; no favorable probability event is needed. Every edge of this multigraph also joins two columns adjacent in the clause-intersection graph.

## Connected partition theorem

Take a spanning tree of the connected pairing multigraph. Its maximum degree is at most three. A tree has a centroid vertex whose removal leaves components of size at most floor(e/2): starting at a vertex with an oversized component, move into that component; this strictly reduces the size of the oversized side until none exists. The centroid has at most three branches, whose sizes sum to e-1. A largest branch therefore has size b satisfying

    ceil((e-1)/3) <= b <= floor(e/2).

Cutting its edge to the centroid partitions the tree into two nonempty connected sets of sizes b and e-b. Both induce connected subgraphs of the original clause-intersection graph, and both sizes are at most

    e - ceil((e-1)/3) = floor((2e+1)/3).

The nonzero weight-three model has no one-column circuits; the argument includes two-column duplicate-support circuits. Thus every circuit of size e<=k admits connected parts each of size at most h=floor((2k+1)/3). Biconnectivity and the stronger degree-two-per-variable property are unnecessary.

## Comparator-mass consequence and necessary query detail

For a nonnegative price vector, enumerate connected sets of size at most h and retain a cheapest representative for each triple (binary incidence syndrome, sign parity, cardinality). To compare with a circuit T of size e<=k, use the partition above. Its parts have equal syndrome and opposite sign parity when T is odd. Replacing each part by its cheapest representative of the same cardinality cannot raise the summed price. Their symmetric difference is nonempty, zero-sum and odd. Nonnegative prices ensure its price is no larger than the representatives' summed price, and its size is at most the sum of their cardinalities, namely e<=k.

Retaining cardinality, or an equivalent explicit total-size budget, is essential for this exact support contract. Without it the representatives might total 2h>k. Finding a single least-price pair needs no Cartesian product within a bucket: scan opposite-parity cardinality pairs whose sizes sum to at most k. The main author's algorithm must charge the bucket construction, comparisons and query repetitions.

Every even tuple decomposes into disjoint minimal circuits. An odd tuple contains an odd component. Replacing each weighted odd tuple by an odd component preserves fractional mass and cannot increase any clause load. Therefore the connected-parts query now compares against the full short-odd-tuple packing opportunity on each fixed input, rather than an unproved typical subfamily. This does not itself construct a packing or supply its numerical accuracy and runtime. It eliminates the structural comparator-mass gap, conditional on the stated query proof and subsequent optimization obligations.

## Source and significance boundary

The previous [source note](2026-09-11-greedy-basis-sources.md) already records the established connected-set enumeration bound and classical st-numbering sufficient condition for biconnected graphs. The present proof uses an elementary cubic-pairing and tree-centroid argument instead. Exact closest-prior comparison for this combination with syndrome pricing is pending; no novelty or fastest-algorithm claim follows from deriving it locally. At maximum original row degree Delta=O(n^(2/5)), the raw connected-list cap h gives a displayed upper logarithmic scale (4/15)k log n+O(k), before numerical packing and query-count costs. This is a comparison with the specified full connected-set list, not a complexity lower bound or an established full refutation improvement.

## Stronger candidate: half-size sets with logarithmically many pieces

The same subcubic tree permits an exact prescribed-size partition with only O(log e) connected pieces on each side. This observation is submitted for independent review, not yet a final algorithm claim.

Here is a recursive construction for a tree of size s and desired first-side size t. If t=0 or t=s, assign the entire tree to one side. Otherwise choose a centroid v and assign v to the first side. Order its at most three branches arbitrarily. Assign whole branches to the first side while they fit the remaining budget t-1. At the first branch larger than the remaining budget, recurse inside that branch with precisely that residual budget; assign all subsequent branches to the second side. If the budget reaches zero, assign all remaining branches to the second side without recursion. There is at most one recursive branch, and its size is at most floor(s/2).

At each nonterminal recursion level, the centroid together with all whole first-side branches forms one connected piece; there are at most two whole second-side branches. A terminal level adds at most three pieces to either side. Thus each side is a union of at most q=3 ceil(log2 e)+3 connected vertex sets. Extra edges in the actual clause-intersection graph can only merge components. The construction assigns exactly t vertices to the first side. With t=e/2 (e is even), both sides have size e/2.

For a uniform algorithmic cap k, set h=floor(k/2) and q=3 ceil(log2(max(2,k)))+3. Enumerate all unions of at most q nonempty connected sets whose summed sizes are at most h. Reject overlaps if desired. Every half supplied above is included, using its actual connected components. If the connected-set count of size s is at most M(C D)^s, where D=max(1,3(Delta-1)), then enumerating ordered component choices and size compositions takes at most

    poly(h,q) M^q (2 C D)^h

attempts, with polynomial processing per attempt. This follows by multiplying counts for each composition and using at most 2^h compositions across all numbers of positive parts. Duplicate unions do not invalidate the bound. Thus in the FKO scale k=Theta(n^(1/5)), M=Theta(n^(7/5)), Delta=O(n^(2/5)), its logarithm is at most

    (1/5) k log n + O(k) + O((log n)^2).

Retain the same syndrome/sign/cardinality price buckets. Every odd circuit up to size k now has equal-size comparator halves on this list, so the existing representative argument and full packing comparator transfer apply. This does not provide packing optimization or establish novelty. Source comparison should include tree separator/pathwidth enumeration and sparse-codeword meet-in-the-middle methods, not only strictly connected halves.

## Primary comparisons checked in this scout

[Kovalev-Dumer-Pryadko, arXiv:1302.1845v1, Sections III-C and IV, Theorem 1](https://arxiv.org/pdf/1302.1845) explicitly gives syndrome bipartition search for arbitrary linear codes and connected-support search using the same shared-parity-check adjacency graph. Its connected technique lists whole clusters; the inspected theorem does not state the logarithmic-component half-list construction above. These are direct algorithmic ancestors, so neither connectivity nor syndrome joining should be claimed as new.

[Feige's even-cover paper, Section 1.1, printed pp. 3-4](https://www.wisdom.weizmann.ac.il/~feige/mypapers/evencover.pdf) explains repeated deletion to obtain many disjoint even covers and relates random density n^(0.4) to cover size O(n^(0.2)). That passage does not supply biconnectivity of clause-intersection graphs. The deterministic circuit decomposition above avoids requiring such an additional structural assertion about its random tuple family. These focused source checks do not constitute an exhaustive novelty audit.
