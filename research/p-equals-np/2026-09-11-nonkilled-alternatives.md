# Global alternatives to one-path non-killed sampling

2026-09-11; S3070, under [integrity](../../INTEGRITY-CLAIMS.md). Supporting scout, not an algorithm implementation or independent proof closeout. Reuse [actual retained-channel construction](2026-09-11-global-fko.md) and [S3069 scope](2026-09-11-interference-extraction.md). No experiment, novelty or generic hardness claim.

**Finding:** global collision search in original clause-syndrome space is a genuinely different representation from modifying the walk. Its elementary meet-in-the-middle baseline is known and retains n^Theta(k) cost. Neither a cheaper sufficient-list construction nor load-aware output coverage was established. It is a precise alternative to compare, not a verified new stepping stone or automatically selected next campaign.

## Explicit graph cycle exploration

A signed spanning forest detects an unbalanced component when a non-tree edge disagrees with the sign transported along its tree path. Retaining the original channel labels reconstructs a negative closed walk. Equivalently, a signed double cover allows a search from (S,+) to (S,-). These are established balance/cycle operations, not new interference mechanisms; the signed-cover primary comparison is already recorded in S3068. Harary's original balance paper is [On the notion of balance of a signed graph (1953)](https://doi.org/10.1307/mmj/1028989917).

An explicit graph algorithm charges all visited states and generated channels. For the actual retained graph, a row query is polynomial in the original formula, but the state universe has N=binom(n,ell) members. Full traversal costs N times polynomial input work, still n^O(ell). A bounded-radius exploration can cost much less only with a bound on its explored volume and a useful-cycle guarantee. A negative cycle obtained after unrestricted exploration can be too long for the required tuple support. A graph cycle basis likewise supplies relations only after paying for its graph and may produce long original-clause subsets.

Nonbacktracking exploration removes immediate reversal; it does not prevent cancellation of original clause IDs along more complicated closed walks. A nonbacktracking lifted cycle is not automatically a nonempty tuple. No theorem was recovered that gives a cheap exploration tree containing sufficiently many useful short cycles for this exact retained graph. This does not prove such an algorithm impossible.

## Direct original-clause meet-in-the-middle

Let B be the unsigned n by m clause-incidence matrix and nu the vector of negative-literal parities. The query is a set T with B1_T=0, nu dot 1_T=1 and |T|<=k. All even-incidence tuples have even cardinality because columns have weight three.

The standard exhaustive collision baseline enumerates subsets U of size at most floor(k/2), records their original IDs, and keys them by B1_U and sign parity nu dot 1_U. Two subsets with equal unsigned syndrome and opposite sign parity yield T=U symmetric-difference V. Then T is nonempty, has the required odd sign and size at most k. Overlap of U,V is harmless because IDs cancel. Conversely, an even tuple of size at most k can be divided into equal halves, so a matching pair exists in this list. One representative per syndrome and parity suffices to find one tuple; it does not preserve all outputs or packing options.

The list length is

    M_k=sum_{j=0}^{floor(k/2)} binom(m,j).

Enumeration, exact sorting/hashing, syndrome storage and verification cost M_k times polynomial factors in n,k and log m (with sorting overhead). At m=Theta(n^(7/5)), k=Theta(n^(1/5)), this is exp(Theta(k log(m/k)))=n^Theta(k). It halves the leading subset-size exponent of the naive full-list enumeration in this elementary comparison, but does not escape the known n^O(ell) scale or improve the strongest known refuter by a proved asymptotic class. Memory grows with the retained list. Finding one tuple is less than solving the full FKO packing problem.

This is an application of classical matching-list/low-weight-codeword search, not a new discovery algorithm. [Wagner, A Generalized Birthday Problem, CRYPTO 2002, Sections 1-2](https://www.iacr.org/archive/crypto2002/24420288/24420288.pdf) explicitly describes two-list merge/hash joins and extends them to multiple lists. Its favorable generalized-birthday analysis assumes independently uniform list values and a sufficient supply of extendable lists. The lists above reuse the same sparse columns, have strongly dependent values, and their syndrome weights are at most 3k/2. Treating them as independent uniform n-bit strings would be false.

## The concrete saving that remains unproved

A potentially useful alternative would generate much smaller structured lists of partial original-clause subsets whose same-syndrome/opposite-sign collisions remain plentiful, then recover many distinct tuples with controlled clause loads. The necessary estimate must relate list construction cost, collision yield, retained support size and overlap. A partial-syndrome filter can cheaply discard pairs, but the number of false candidates and probability of retaining true short tuples must be charged on this sparse ensemble. Randomizing a linear basis does not remove algebraic dependencies between the list entries.

Information-set decoding is the closest established algorithmic family: it combines elimination, coordinate splits and partial-syndrome joins. The published ball-collision comparison [Bernstein-Lange-Peters, Smaller decoding exponents: ball-collision decoding, CRYPTO 2011](https://eprint.iacr.org/2010/585) analyzes decoding exponents with code rate and relative weight parameters. Its advertised random-code exponent is not a theorem for this structured parity-check matrix with rate approaching one and target relative weight approaching zero. This scout recovered the primary abstract/author metadata; the author-hosted full PDF fetch failed, so no detailed theorem or superior numerical exponent is imported. A thesis describing Stern variants was accessible but is not substituted for primary verification of a new claim.

The prior [Fourier/trellis check](2026-09-11-holographic-extraction.md) is the other exact comparison: dual enumeration retains 2^rank states, and truncated syndrome dynamic programming retains its syndrome coordinate. Neither justifies a small collision list. Likewise, the July 2026 sharp Kikuchi algorithm already has n^O(ell) cost and cannot be beaten merely by calling this list representation implicit.

There is presently no evidence-backed list rule or proved ensemble estimate here that warrants selecting a new mechanism. The useful distinction is strategic: if the one-path route fails, another walk normalization is not automatically the answer. A future global collision proposal must first supply the missing structured-list estimate rather than rerun the known meet-in-the-middle identity. No all-method obstruction follows from failure to supply it.

## Search and evidence boundary

Focused primary searches on September 11, 2026 covered signed balance/BFS, low-weight codeword meet-in-the-middle, Wagner generalized birthday assumptions and ball-collision decoding. Wagner's original PDF Sections 1-2 were opened. Harary's original publisher page did not expose full text; the elementary forest argument above is stated as a standard reconstruction, not a newly checked theorem quotation. Ball-collision full-text access failed as noted. These limits prevent a claim to have optimized all modern decoding algorithms or excluded a better specialized method. No source result about generic codes, arbitrary signed graphs or planted quantum inference is transferred to the random FKO instance without its missing hypotheses.
