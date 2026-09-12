# Separator reconstruction: independent source and complexity review

September 12, 2026; S3081, under [integrity](../../INTEGRITY-CLAIMS.md). **GO for the scoped failed-construction assessment** in the saved [main](2026-09-12-separator-compression.md), not a compression or lower-bound theorem. This review concerns the actual prefix-description reconstruction proposal, not every possible compression argument.

## Primary comparisons checked

[OPS, published 2021](https://theoryofcomputing.org/articles/v017a011/v017a011.pdf), Section 4, does not provide a free selector. Theorem 4.2 uses a SAT oracle for relative counting; Corollary 4.3 invokes NP in P/poly to replace the oracle and fix randomness. The construction also explicitly charges truth-table addressing O(tN). These conditional resources cannot be imported unconditionally into the proposed reconstruction. The exact direct implication remains Theorem 1.4, with its stated general-circuit and fixed-epsilon/all-small-beta quantifiers.

[Chen-Kabanets-Kolokolova-Shaltiel-Zuckerman](https://www.cs.haifa.ac.il/~ronen/online_papers/mining.pdf), Theorem 7.1, concerns deterministic truth-table-polynomial-time compression for every polynomial-size bound in a class C. The conclusion is NEXP not contained in C. Neither this conclusion nor its output-size threshold below 2^n/n substitutes for the present NP/P-poly implication and output target N^beta. I inspected the primary theorem and proof opening, not just its abstract.

[Ilango, The Minimum Formula Size Problem is (ETH) Hard](https://www.rahulilango.com/papers/MFSP-hard.pdf), Theorem 5, gives exact deterministic polynomial-time search from an MFSP oracle. The model is De Morgan formulas measured by leaves. It supersedes the older formula search bound depending on near-optimal multiplicity; that older bound should not be presented as the current formula limitation. The result is not a general-circuit Gap-MCSP reduction. Its partial-to-total and decomposition machinery is substantive, not ordinary SAT self-reducibility applied without a model change.

[Ren-Santhanam](https://hanlin-ren.github.io/files/pdf/stacs22_relativized_MCSP.pdf), Theorem 13 in the inspected STACS 2022 primary version, states a relativized separation between easy decision and hard search. It constrains relativizing transfers; it is not an unrelativized impossibility result. The exact source models matter in both directions.

## Substantive prefix-query test

A prefix query asks whether there is a valid circuit description extending p and computing the given full table f. Querying C(f) is independent of p and does not answer that question. Moreover, a gap separator may accept tables of complexity between L and T, where a size-L witness need not exist. Prefix reconstruction on promised YES inputs still requires a real reduction for the successive prefix predicates.

The literal verifier-table proposal has a stronger parameter failure in addition to its output length. Let r=Theta(L log(n+L))=Theta(N^beta) be the full padded description length. The r-input predicate V_f,p(d) checking validity, prefix agreement and equality to f has an explicit polynomial-in-N,L B2 circuit: universally evaluate d on each of the N assignments and conjoin the comparisons. Hardwire f, p and the size parameters; no oracle is needed for this bound. Its 2^r-bit truth table therefore has circuit complexity polynomial in N,L.

If this table is queried at the same fixed beta in Gap-MCSP, the new YES threshold is 2^(beta r)/(c r), eventually larger than that polynomial verifier size. Both satisfiable and unsatisfiable such verifier tables are then YES. This rules out this literal same-beta satisfiability encoding, not reductions with changed parameters or a different construction. Keeping only a short remaining suffix changes the dimension; it does not explain how the preceding long prefix was found. This reviewer-originated observation was independently verified against the saved main in the [proof check](2026-09-12-separator-compression-proof-check.md), including fixed-beta asymptotics, floors and retained prefix variables.

A decoder embedding the hypothetical separator charges its actual size s. The supplied upper bound s<=N^(1+epsilon) is too weak to certify a decoder within the desired N^beta circuit budget; this is not a lower bound on every such s. Encoding the separator into advice does not remove the need to implement its evaluation. A valid improved reconstruction must give an explicit smaller accessed computation or another charged implementation. The size of the input's description and the size of its recognizer are separate resources.

No new proof of a lower bound, code, experiment or universal obstruction is claimed. Source checks were focused primary-PDF inspections on September 12, 2026; they are not an exhaustive current-literature ranking.

## Final main inspection

The prefix invariant is correct if its W queries were available and the input really were YES; the note does not promote separator acceptance to witness existence. Its same-length query contract is explicit. Full verifier-table length, prefix computation, exhaustive enumeration, decoding advice and per-bit separator evaluation are charged separately. The accepted-set counting statement is sound because a correct separator rejects every table above T, but the main draws no recognizer lower bound from that fact.

The final disposition parks this literal prefix reconstruction, not all reductions. It also records that even an efficient YES-description finder would need a separate quantitative contradiction before yielding the OPS antecedent. No side-class compression consequence or relativized separation is substituted for that missing link. The source-author attribution and newer formula theorem were checked; the main does not rely on the misidentified older oracle paper.

No additional search, code or experiment is needed for this bounded assessment. The continuing P-vs-NP objective remains unresolved.

The saved S3081 meta-graph addition was also inspected: it preserves the parked-construction scope and adds no achieved implication. Source/model/significance GO covers that addition; the independent proof receipt now resolves its diagnostic cross-check.
