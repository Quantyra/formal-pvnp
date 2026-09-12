# Separator compression: testing prefix reconstruction

2026-09-12; S3081 under [integrity](../../INTEGRITY-CLAIMS.md). Bounded mathematical/source attempt, with scoped independent reviews below. The [OPS target](2026-09-11-direct-magnification-selection.md) and the parked [gate-charge attempt](2026-09-11-separator-gate-charge.md) remain unchanged. No proof of separator failure, implementation, experiment, Lean or novelty claim.

**Outcome:** the tested bit-by-bit reconstruction construction does not turn a small gap separator into a circuit-description finder. Its missing queries are precisely specified below; compiling their verifier neither preserves the MCSP promise nor has the required truth-table length. Short descriptions therefore supply no contradiction to a small separator in this attempt. This is not a lower bound against all search-to-decision reductions.

## One proposed reconstruction obligation

Let N=2^n, T=floor(N^beta), L=floor(N^beta/(c n)), and let C be a general B2 separator accepting every table of circuit size at most L and rejecting every table of size greater than T. It may answer arbitrarily in the gap. Its hypothetical size is s<=N^(1+epsilon), with the OPS quantifier order unchanged.

Fix an explicit padded encoding of circuits with at most L gates, of length r=Theta(L log(n+L)); invalid encodings are rejected. For an N-bit table f and an encoding prefix p, define

    W(f,p)=1 iff there exists a valid r-bit description d extending p
                     with at most L gates and truth table exactly f.

The proposed mechanism would implement W for every YES f and every prefix p, using the given C, with a uniform polynomial bound on total gates/work in N,s, no auxiliary instance-dependent advice, and only explicitly constructed N-bit queries whose promise status makes their C answers valid. It would then start with the empty prefix and query W(f,p0), keeping p0 if true and p1 otherwise. On a YES input the invariant of a valid completion would recover a description after r calls; evaluating the final circuit on all N arguments verifies it.

This is a falsifiable search-to-decision obligation. It is not inferred from the existence of short descriptions, and no such reduction is claimed here. It is also only a potential intermediate mechanism: recovering a description already known to exist on YES tables would not itself contradict C or prove an OPS lower bound. A downstream contradiction would still require a separate quantitative argument.

## First attempted query: use the given separator

The direct call C(f) is the same for every prefix p. It recognizes neither the structural constraints imposed on a description nor the existence of a completion of that prefix. Even with f known to be YES, two different prefix subtrees can have different completion status while the input to C remains unchanged.

More generally, C(f)=1 does not certify that f has an L-gate description; an accepted gap table may have no such description. The prefix recursion cannot use acceptance as its initial witness-existence invariant on all accepted inputs. Restricting the algorithm's guarantee to true YES inputs avoids this particular problem but does not provide prefix answers.

A prefix of the function's truth table is also not a prefix of its circuit description. The alternative query 'does some accepted truth table extend this table prefix?' is SAT for a partially fixed copy of C. Its variables are missing truth-table entries, not circuit gates. Neither predicate is what the supplied gap separator decides.

## Second attempted query: compile the verifier

There is an explicit verifier V_(f,p)(d): test the encoding and prefix, simulate the described circuit on all N arguments, and compare with f. Ordinary indexed-wire simulation can scan all possible predecessors; its total cost is polynomial in N,L,r, rather than treating random access as free. Hence W is the satisfiability of a polynomial-size verifier circuit on r description bits. This makes a standard NP query, not an answer obtained from C.

One attempted bridge is to feed the full truth table of this verifier to a circuit-size separator. At the initial prefix its length is 2^r. For each fixed positive beta,

    r=Theta(L log(n+L))=Theta(N^beta),
    2^r=2^{Theta(N^beta)}.

The explicitly materialized query has superpolynomial length in N, and is not an input of length N for the available C. A separator at that new length, were supplied, would be additional nonuniform advice at a different parameter regime. More fundamentally, satisfiability of V is not equivalent to its having low circuit complexity: an unsatisfiable verifier is the constant-zero function, which has tiny circuits. No YES/NO gap mapping with the needed orientation and thresholds has been constructed. Exponential table construction would not fix that semantic defect.

For the literal fixed-beta reuse there is a sharper failure. Keep all r description variables and implement prefix constraints inside V. Its circuit size is polynomial in N,L for every p. At truth-table length 2^r the same fixed-beta YES threshold is 2^(beta r)/(c r), which eventually exceeds that polynomial because r=Theta(N^beta). Thus every such verifier table is a YES instance of that gap problem, whether W(f,p) is true or false. Removing fixed prefix bits changes the query parameters and does not repair the initial query. This observation was supplied by the complexity challenger and independently checked in the linked proof receipt; it excludes this literal query construction only.

Enumerating descriptions directly is sound: visit all 2^r encodings, verify each, and retain the first matching one. Its charged bound is 2^r times polynomial(N,L,r). This is the cost of this attempted exhaustive implementation, not a lower bound on other reconstruction algorithms. Prefix selection, approximate counting or an NP oracle cannot be omitted to turn it into polynomial cost.

## Why short encodings do not finish the compression argument

For a fixed valid C, its accepted set contains the L-easy tables and is contained in the T-easy tables. Circuit counting thus bounds its size by 2^{O(T log(n+T))}. A rank among accepted tables is an information-theoretically short label, but neither constructing the rank nor decoding it is supplied by C. A lookup table for the accepted set carries its own size cost; exact enumeration/ranking is not free auxiliary advice.

Even an r-bit description of f is not a compressed description of C, whose input is an entire truth table. Likewise, directly embedding C into a per-bit reconstruction circuit charges its s gates. A promised upper bound s<=N^(1+epsilon) does not bound that cost by T=N^beta; the displayed construction budget is too large to establish such a compression guarantee. This is a failure of that upper-bound argument, not a claim that every hypothetical C has size N^(1+epsilon).

To force C to misclassify by reconstructing a NO table, one would need an actual decoder circuit for that table of size at most T, including selection, advice evaluation and addressing. Neither the rank label nor the prefix procedure supplies one. A counting argument saying most tables are hard does not fill this decoder gap or imply a lower bound for the sparse-set recognizer.

## Primary comparisons that change the interpretation

[Oliveira-Pich-Santhanam, Sections 4.1-4.2, Theorem 4.2 and Corollary 4.3](https://theoryofcomputing.org/articles/v017a011/v017a011.pdf) explicitly use NP-oracle relative counting and, under the assumed inclusion NP in polynomial-size circuits, replace those oracle calls. Truth-table addressing is charged in the proof. Reusing that conditional selector unconditionally would assume the premise being analyzed; it is not an available reconstruction primitive here.

[Ilango, The Minimum Formula Size Problem is (ETH) Hard, Theorem 5](https://www.rahulilango.com/papers/MFSP-hard.pdf) gives a genuine polynomial-time exact search-to-decision reduction for MFSP. This newer result supersedes the multiplicity-dependent guarantee in his [CCC 2020 paper](https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.CCC.2020.31). Its input model is De Morgan formulas and its oracle is exact MFSP. It does not establish the arbitrary-circuit, fixed-gap, same-length prefix reduction above. This is a real successful adjacent mechanism, not evidence that reconstruction from every decision oracle is automatic.

[Chen-Kabanets-Kolokolova-Shaltiel-Zuckerman, Mining Circuit Lower Bound Proofs for Meta-Algorithms, Theorem 7.1](https://www.cs.haifa.ac.il/~ronen/online_papers/mining.pdf) derives NEXP not in a circuit class from a specified deterministic polynomial-time compressor for all polynomial-size functions in that class, with output size below N/log N. This is not the exact OPS antecedent and does not directly imply P!=NP. It is not selected as a replacement objective.

The primary OPS and compression PDFs were opened, and the challenger independently checked the newer MFSP theorem/model. Focused search queries included `MCSP search to decision reduction find circuit witness minimum circuit size problem prefix search gap` and `MCSP search version circuit reconstruction decision oracle reduction`. The older Limits of Minimum Circuit Size Problem as Oracle PDF accessed in this search is Hirahara-Watanabe, not Ren-Santhanam; no misattributed barrier theorem is imported from it. No current unrelativized impossibility of the proposed reconstruction is asserted.

## Selection and review

Park the tested prefix-reconstruction construction. An actionable continuation would need an explicit, costed reduction of W(f,p) to the same gap promise, or a different decoder with a proved size bound relevant to a contradiction. No such construction emerged. Even successful YES reconstruction alone would still need an established link to separator failure; that implication is not assumed. The continuing goal remains unresolved.

| Review | Actual verdict |
|---|---|
| [Independent source/complexity scope](2026-09-12-separator-compression-review.md) | GO for the failed construction, charged costs and source limits. |
| [Independent proof cross-check](2026-09-12-separator-compression-proof-check.md) | GO for the challenger-origin both-YES diagnostic only. |
| [Final non-claims](2026-09-12-separator-compression-nonclaims-review.md) | GO for final main and meta-graph scope; literal failed construction only, no general decoder or separator lower bound. |

These are scoped review receipts, not a full three-lens approval of a new algorithm or lower-bound theorem. No compression inequality, separator lower bound or witness-inversion theorem is claimed proved.
