# Half-list bound: focused novelty and strongest-prior audit

2026-09-11; S3074 under [integrity](../../INTEGRITY-CLAIMS.md). Reviews the final [S3073 pricing/packing bound](2026-09-11-connected-half-pricing.md) and its [structural proof](2026-09-11-connected-half-structure.md). No code, experiment, publication or claim of priority.

**Disposition: candidate bound/application; priority HOLD.** The inspected primary sources do not supply an exact matching or stronger theorem with the same sparse-input, arbitrary-nonnegative-price and aggregate-packing contract. This does not establish novelty. The reduced exponent relative to the named full-cluster enumeration bound is mathematically meaningful in the growing-degree regime; it does not change the established exp(O(n^(1/5) log n)) FKO order or certify the fastest known refuter.

## Exact statement being compared

Input is a binary n-by-M matrix with exactly three ones per column, maximum row weight Delta, an arbitrary sign vector, a support cap k, and nonnegative rational clause prices. The algorithm finds a minimum-price nonempty zero-incidence, odd-sign support of size at most k, or detects absence. Its common preprocessing/list bound is

    M^{O(log k)} 2^{O(k)} max(1,Delta)^{floor(k/2)}.

Polynomial original-input, price-encoding and inverse-accuracy factors are additional. Repeated pricing gives an exactly feasible rational fractional packing within a factor 1+epsilon of the optimum over all such supports. This is a stronger output guarantee than finding one unweighted low-weight word, but uses the existing multiplicative-weights framework. The proof relies on binary circuit decomposition and nonnegative prices; it is not a theorem for arbitrary nonlinear codes or general integer-lattice shortest vectors.

## Direct ancestors and what their theorems cover

| Primary source | Verified operation and boundary |
|---|---|
| [Kovalev-Dumer-Pryadko, arXiv:1302.1845v1, Sections III-C and IV, Theorem 1](https://arxiv.org/pdf/1302.1845) | Syndrome bipartition and connected-support search are existing algorithmic ingredients. The shared-check adjacency graph is the same construction. No connected-component half-union theorem was located in these sections. |
| [Dumer-Kovalev-Pryadko, arXiv:1611.07164v1, Section III.B, Proposition 3; Section V, equations (33)-(37)](https://arxiv.org/pdf/1611.07164) | Generic matching bipartition and sparse irreducible-codeword search are separate methods. In the binary irreducible search, each extension adds one coordinate among at most row-weight-minus-one choices, retaining the full-weight degree exponent. Its average-ensemble bounds require their own code distributions and are not pointwise arbitrary-price guarantees. |
| [Webster-Jacob-Higgott, arXiv:2603.22532v2, August 14, 2026, Section 4.3.1, Algorithm 9; Sections 4.3.2-3](https://arxiv.org/html/2603.22532v2) | Direct prior for syndrome plus logical/sign parity plus cardinality classes and symmetric-difference output despite overlap. Connected-cluster search is still presented separately with full-distance exponent. Truncated Stim search is not universally exact for column weight three. Benchmark wins supply no asymptotic sparse weighted-pricing theorem. |
| [Patel-Regts, arXiv:1707.05186v2, Lemma 2.4](https://arxiv.org/pdf/1707.05186v2) | Explicit connected-subset enumeration O(M h^3 (exp(1)d)^h), with d exposed. S3073 reduces the total size in products of these lists; it does not invent enumeration. |

These exact sections were read during S3073 and reused, with their scoped evidence in [the source contract](2026-09-11-connected-half-sources.md). The latest 2026 version predates the cutoff. No claim of current superiority is drawn from an older paper's description of its contemporary best algorithms.

## Additional focused comparisons

**Sparse information-set decoding.** [Rahmi El Mechri, Improving Information Set Decoding for Low-Density Parity-Check codes, master's thesis, academic year 2023-2024](https://tesi.univpm.it/retrieve/1bd15751-60b1-4197-84e5-884466a1420e/Tesi_ElMechri.pdf), Chapter 4, especially Sections 4.1-4.3 and Propositions 4.3.1-4.3.2, was opened. SparseISD selects rows, exploits the union of their supports, performs partial Gaussian elimination, and uses two collision searches. Its cost divides by a weight-allocation success probability and uses ensemble-average support sizes. This is relevant sparse-MITM ancestry, but not a deterministic uniform short-odd pricing or packing contract. Its numerical comparison at fixed rates is not transferred to M=Theta(n^(7/5)) and fixed column weight three. It is a thesis source, not treated as an independently validated strongest-algorithm theorem.

**Separator-based pattern algorithms.** [Bjorklund-Kaski-Kowalik, Counting thin subgraphs via packings faster than meet-in-the-middle time, arXiv:1306.4111v2, August 14, 2015, Theorem 3](https://arxiv.org/pdf/1306.4111v2) counts a supplied k-vertex pattern of pathwidth p using a host-size exponent below k/2 plus p-dependent terms. Theorem 4 counts disjoint set packings from an explicit family. These are substantive stronger-than-naive-MITM results, not an excuse to regard half exponents as optimal. Their hypotheses do not turn the unknown parity-support problem into a supplied low-pathwidth pattern: the S3073 spanning tree omits many parity-coupling edges and is not a low-pathwidth certificate for the whole circuit or full code. No reduction yielding the same weighted pricing/mass guarantee was verified. The primary theorem statements and their scope, rather than the entire matrix-multiplication proof, were inspected.

**Global trellis representations.** [Kashyap, Matroid Pathwidth and Code Trellis Complexity, arXiv:0705.1384](https://arxiv.org/abs/0705.1384) relates code trellis width to matroid pathwidth. Its primary abstract was inspected; no unread runtime theorem is imported. A small decomposition of an unknown witness spanning tree is not an efficiently supplied small-width trellis of the entire code. Generic syndrome tables still have a rank-dependent state count. These different input representations must not be silently substituted.

## Statement, proof and application novelty are different

| Layer | Assessment |
|---|---|
| Operations | Known: sparse connected search, syndrome/sign joins, minimum representatives, centroid recursion, rational multiplicative weights. |
| Structural/list bound | The exact logarithmic-component half-list coverage and its M^{O(log k)} Delta^{k/2} accounting were not matched to a prior theorem in the inspected material. The proof is an elementary combination of established tools; absence of a match is not priority evidence. |
| Weighted oracle and packing | The same-input all-short-support guarantee is the concrete statement to audit further. Nonnegative prices make overlap cancellation safe; general packing optimization is established. Neither a new optimization principle nor automatic novelty follows. |
| FKO application | Original robust packing existence and spectral verification are reused. The application lowers the displayed list exponent at equal k; it does not improve the source density exponent or the known broad runtime order. |

An exact match to any one building block would not refute the combined bound, but several known building blocks do not make the combined theorem novel by themselves. The present record supports a candidate statement for focused priority checking, not a manuscript or public novelty announcement.

## Where the comparison matters, and where it does not

At the stipulated FKO scales, k=Theta(n^(1/5)), Delta=O(n^(2/5)), M=Theta(n^(7/5)), the leading log upper bound is (1/5)k log n, with O(k)+O((log n)^2) overhead. The checked whole-cluster list has (2/5)k log n at the same cap. Here k log Delta dominates the quasi-polynomial overhead. The comparison is between specified upper bounds; it is not a lower bound on actual cluster-search runs.

For the usual fixed-degree LDPC regime, existing cluster search is exponential in k times polynomial input size. The additional M^{O(log k)} overhead can make S3073 worse, and its displayed bound is not fixed-parameter tractable in k alone as written. There is no blanket improved quantum-LDPC distance algorithm. For small k or modest n the overhead, extensive storage, repeated exact pricing scans and large rational weights may dominate; no numerical implementation or practical crossover was measured.

The original FKO witness support constant is source-dependent and unspecified numerically here. Choosing the same symbolic k for two procedures does not compare their optimal witness lengths or establish superiority over July 2026 spectral refuters. All these methods remain within n^{O(n^(1/5))} at the discussed density. Publication significance would require an exact-priority assessment and a statement emphasizing the honest growing-degree and output-contract scope, rather than a P-versus-NP narrative.

## Search record and limits

September 11, 2026 queries included `LDPC minimum distance algorithm meet-in-the-middle sparse`, `low weight codewords connected algorithm complexity`, `minimum distance cluster half LDPC algorithm`, `LDPC bidirectional distance search algorithm`, `codeword separator algorithm`, `sparse Even Set algorithm`, and `low weight codewords split algorithm cluster`. Earlier S3073 exact queries are retained in its source note. Additional primary hits were opened above; unrelated support-splitting, nonlinear compression, graph clustering and general hardness snippets were not used as applicable theorems.

No equivalent bound under different notation was verified. This is a focused source audit, not exhaustive access to coding-theory books, all conference proceedings, theses or unpublished work. The large 2026 PDF exceeded web limits, but its relevant HTML sections were read; Kashyap access was abstract-level. Source crawl dates were not treated as publication dates. Final recommendation: preserve the reviewed theorem and bounded baseline gain as a candidate stepping stone; HOLD novelty/fastest-known/publication claims. Do not launch experiments merely to replace unresolved priority with empirical activity.
