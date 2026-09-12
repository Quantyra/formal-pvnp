# S3065 independent complexity review

2026-09-11. **GO for the conditional sign lemma, bounded adaptive procedure, and explicit unresolved geometric obligation.** Reviewed the final [main derivation](2026-09-11-adaptive-fko.md), [source comparison](2026-09-11-adaptive-fko-sources.md), integrity ledger, S3065 planning scope and frontier protocol. This is informal review, not formal verification, a novelty assessment, or a successful refutation algorithm. No material correction required.

## Procedure and resource accounting

The modification actually uses observed clause incidences, so the earlier oblivious-restriction failure bound does not apply. Its seed and maximum-overlap choices, coefficient-dependence stopping, duplicate rejection and capacity updates use no signs. The family is fixed conditional on supports and geometric randomness. Reserving selected prefix IDs prevents a repeated column from being mistaken for a dependency. At the first dependence, the preceding independent columns give a nonempty fundamental circuit with at most K distinct IDs; no minimum-support oracle is assumed.

At most K growth stages per attempt scan at most m available IDs each. Elimination in at most 3K coordinates and K columns has a straightforward O(K^3) operation bound with compact provenance. Sorted-tuple duplicate comparisons add polynomial work, explicitly mentioned outside the displayed scan/elimination count. All Q attempts, including failures, are charged. The total number of stored clause occurrences is at most md; the stated polynomial workspace follows. These are execution upper bounds only. Certified spectral evaluation and its precision remain part of any actual accepting implementation; no implementation is claimed.

## Conditional signs and progress

Distinct nonempty subsets of occurrence IDs have distinct nonzero vectors over GF(2); any pair is linearly independent. Independent clause sign parities therefore yield pairwise independent fair tuple parities after conditioning on the whole unsigned construction. Mean t/2, variance t/4 and the displayed Chebyshev bound follow. Repeated unsigned supports do not invalidate independence across clause occurrences in the declared independent model. Distinct tuple rejection is necessary. Filtering cannot increase clause loads. The weighted variance formula is also valid for fixed, geometrically determined weights.

The sign-dependent spectral threshold is handled correctly through a separate deterministic high-probability upper bound and union bound. No independence from the retained-tuple count is asserted. Without-replacement transfer uses an o(1) signed-clause collision event rather than claiming exact conditional sign independence in that model.

The proposed conditional success probability p is an unproved hypothesis for every reached pretarget history on typical supports. Under that hypothesis, adapted Bernoulli lower-tail concentration and Qp>=2t_0 do suffice. Neither polynomial Q nor fresh random seeds establishes the hypothesis. The deterministic saturation bound Kt/d and condition (3) preserve availability only; they do not preserve the original distribution or supply discovery probability. Constants in the certificate inequality and depletion condition must both hold, as the main text states.

## Current theorem comparisons checked independently

I directly checked [Bandeira et al., Theorem 1.2 and the simple-hypergraph convention](https://arxiv.org/pdf/2607.14068v2). The result includes odd arity three and is uniform over residual simple hypergraphs. Substituting rho of order n^(1/5) gives cover size O(n^(1/5) log n). Repeated deletion therefore guarantees only order n^(6/5)/log n disjoint covers by this accounting, without supplying an efficient finder. This is an insufficient lower guarantee, not an upper bound on possible packing mass or an inherent logarithmic obstruction. The derivation preserves that distinction. Repeated-support probability O(n^(-1/5)) correctly permits the random-input comparison on the simple event.

I directly checked [Schmidhuber and Hastings, Theorem 2.5 and exact-evaluation statement](https://arxiv.org/pdf/2607.29672v1). At ell=Theta(n^(1/5)), the displayed arity-three threshold scales as n^(7/5) for fixed epsilon, and its certified n^O(ell) bit cost remains exp(O(n^(1/5) log n)). The level-range condition holds for fixed delta<4/5 at sufficiently large n. This is a pointwise-sound spectral kXOR bound with probabilistic null-model success; it is not a tuple-output theorem or a polynomial focused-growth guarantee. This audit checked those theorem contracts, not their complete proofs or exhaustive priority.

## Disposition

The attempt separates a valid, elementary conditional sign calculation from the unsolved incidence-dependent discovery task. No conditional geometric progress estimate, sufficient packing theorem for this policy, improved finder, novelty conclusion, or P-versus-NP consequence has been obtained. GO permits closeout as a documented failed progress derivation with the exact remaining obligation. No experiment, implementation or commit was performed by this reviewer.
