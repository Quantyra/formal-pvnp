# Holographic extraction: the actual short-tuple query

2026-09-11; S3069. Under [INTEGRITY-CLAIMS](../../INTEGRITY-CLAIMS.md). Supporting research, no implementation or novelty claim. Compare [S3067 rooted construction](2026-09-11-global-fko.md) and the S3068 novelty audit. Elementary signature and topology checks below require independent review before being used as new local evidence.

**Disposition:** the direct identity/Walsh planar-matchgate route does not yield a tractable implementation of this query. The concrete alternative, Fourier/dual-code low-weight coefficient extraction, is an established representation and still lacks a useful contraction/compression bound at the FKO scale. No improved finder is supplied. This is not a no-go theorem for all bases, gadgets, nonplanar holographic algorithms or instance-specific compression.

## Defined query and known representation

Let B be the n by m unsigned incidence matrix of the input three-variable clause occurrences, and let nu_a be clause a's negative-literal parity. A tuple is a selector q in {0,1}^m. The precise search query is

    Bq=0,    nu dot q=1,    1<=|q|<=k,    k=Theta(n^(1/5)).

This is a short vector in an affine parity coset, not satisfiability of the original OR formula. Define

    Z_e(z)=sum_{q:Bq=0} (-1)^(e dot q) z^|q|,
    W_odd(z)=(Z_0(z)-Z_nu(z))/2.

The coefficient of z^j in W_odd is the nonnegative integer number of inconsistent j-tuples. Positive total through degree k answers existence. Obtaining an actual tuple additionally needs reconstruction (for example, exact queries with selector bits pinned), and FKO needs enough distinct tuples with controlled clause loads; one positive coefficient does not give packing.

The factor graph has an even-parity signature at every original variable. Each clause occurrence is a degree-three equality selector carrying weight w_a=z(-1)^e_a: its symmetric signature is E3(w_a)=[1,0,0,w_a]. Splitting selector wires this way counts each clause weight once. It also avoids adding an extra global sign-parity node: two signed evaluations perform the filter exactly.

This is the standard code weight-enumerator/normal-factor-graph construction, not a new holographic identity. [Forney, Codes on graphs: Duality and MacWilliams identities, Sections 2, 3.5 and 4 (arXiv:0911.5508; IEEE TIT 2011)](https://arxiv.org/pdf/0911.5508) gives weight generating functions as partition functions and their Fourier duality on graphs with cycles.

## Two defined basis checks

Use symmetric signatures indexed by input Hamming weight. Standard matchgates have one parity of entries identically zero; the remaining entries satisfy the matchgate identities. For symmetric signatures the relevant alternating entries obey the geometric recurrence. [Cai-Lu-Xia, Section 2.5, Lemmas 2.12-2.13](https://pages.cs.wisc.edu/~jyc/papers/planar.pdf); [Cai-Lu, Section 6, parity and simultaneous realizability](https://eccc.weizmann.ac.il/report/2006/145/download).

In the identity basis, even parity is a matchgate signature, but E3(w) has nonzero entries of both parities whenever w!=0. Therefore this direct collection is not a standard-matchgate network.

For the normalized Walsh matrix H=(1/sqrt(2))*[[1,1],[1,-1]], which is its own inverse, the transformed E3(w) has entries proportional to

    [1+w, 1-w, 1+w, 1-w].

For generic z, and either sign choice w=+z or -z, this again has both parities. Meanwhile H transforms a variable's even-parity signature into a nonzero scalar times equality of all its incident bits. Equality of odd arity >=3 fails matchgate parity; equality of even arity >=4 fails the alternating recurrence (both endpoints nonzero but intermediate entries zero). Thus exchanging equality and parity does not simultaneously put this network into the standard matchgate class.

These checks cover the two stated uniform bases only. They do not classify arbitrary complex, mixed-edge or instance-dependent bases. A holographic transformation must use compatible inverse transformations on the two ends of each edge; separately finding a convenient basis for each tensor is insufficient. The cited simultaneous-realizability theory is precisely about this compatibility obligation. Planar #CSP classification theorems are not a blanket dichotomy for this sparse-incidence random ensemble, and broader Holant tractability need not be exhausted by FKT.

## Topology is an independent obstruction to the direct route

The unsplit incidence graph above is simple bipartite with n+m vertices and 3m edges. Repeated clause supports do not produce parallel graph edges: occurrence IDs are distinct clause vertices. A planar simple bipartite graph on these vertices must satisfy

    3m <= 2(n+m)-4, hence m <= 2n-4.

For m=ceil(C n^(7/5)), this fails for all sufficiently large n. The direct network is therefore nonplanar regardless of signs. Local basis transformations leave its graph unchanged. This is an elementary application of the planar edge bound, not a new random-graph theorem or a lower bound on all encodings.

One could change the graph with gadgets or another representation, but then exact crossing signatures, gadget size, simultaneous basis compatibility and contraction cost must be supplied. Drawing crossed wires or invoking a Pfaffian does not supply that conversion. The rooted operator has a different lifted graph; this edge-count argument is not asserted for that graph. Conversely, its cell tests, exact level restriction, diagonal normalization and defect accounting have not been converted into compatible matchgate tensors here.

## Exceptional evaluations do not recover short tuples

At z=1 the two evaluations are a total kernel count and a linear-character sum, computable by Gaussian elimination. Equivalently, the number of solutions to Bq=0 and nu dot q=1 is either zero or 2^(m-rank([B;nu])) when that affine system is consistent. This counts all lengths.

Every vector in ker B has even weight: summing the n parity equations gives 3|q|=0 modulo two. Hence Z_e(-1)=Z_e(1). The exceptional points +1 and -1 carry identical size information. They cannot determine low-weight coefficients. Full generic interpolation would use sufficiently many distinct evaluations (degree at most m); the two easy values alone do not suffice. Truncated power-series computation is another option, but requires an efficient contraction over that ring, not just scalar evaluations at easy points. This is not a claim that these are the only special algebraic evaluation points.

## Concrete remaining alternative checked: Fourier and truncated syndromes

Applying the standard binary Fourier indicator for Bq=0 gives the exact dual expression

    Z_e(z)=2^(-n) sum_{s in {0,1}^n}
                      product_{a=1}^m [1+z*(-1)^(e_a+(B^T s)_a)].

Repeated equal dual words can be collapsed using rank r=rank B, leaving 2^r distinct terms with normalization 2^(-r). This saves dimension relative to enumerating the entire kernel when m is much larger than n, but costs 2^r terms in the straightforward exact evaluation. No small-rank result for the actual input family was supplied. It is not automatically better than the existing n^O(k) tuple enumeration at k=Theta(n^.2).

Truncation does not remove the syndrome coordinate. A direct dynamic program retains D_i(s,j), the number of subsets of the first i columns with syndrome s and size j<=k; its usual include/exclude update shifts s by column i and increments j. Appending nu as a check makes the target syndrome (0,...,0,1). With r'=rank([B;nu]), the uncompressed table costs O(m*k*2^r') arithmetic operations and O(k*2^r') stored integers; counts have at most m+1 bits. This is a standard exact syndrome/trellis calculation, not a proposed new algorithm. Truncating j alone gives no bound on the number of distinct useful syndromes.

A supplied small-state trellis or other contraction order could change that cost. The relevant existing structural quantity is code trellis state complexity, related to matroid pathwidth, rather than the number of displayed parity equations alone. [Kashyap, Matroid Pathwidth and Code Trellis Complexity, Sections 1-2, arXiv:0705.1384v1, May 10, 2007](https://arxiv.org/pdf/0705.1384). Its general hardness of finding optimal width does not prove hardness on these random instances. No favorable width or coefficient-preserving quotient for this family was established in this check.

The concrete missing operation is therefore an exact low-degree contraction or compressed syndrome representation, with cost below n^O(k), that also supports pinned-selector reconstruction and load-aware repetition. A compatible mixed basis is only useful if it supplies that computation and its topology/encoding bounds. This describes an unresolved requirement of our route, not a newly verified open problem or a successor selected merely by naming it.

## Source and claims limits

Primary-source checks on September 11, 2026 used queries for symmetric matchgate parity/recurrences and Holant classification, Forney normal-factor-graph MacWilliams duality, and code weight-enumerator/trellis complexity. The cited primary PDFs were opened at the relevant statements; no exhaustive classification or literature survey was attempted. The identity and complexity calculations here are direct applications of known coding and matchgate tools. Generic coding hardness is not imported as random-input hardness. No quantum state preparation, sampler, norm certificate or improved FKO packing follows from changing the tensor notation. No experiments or code were run.
