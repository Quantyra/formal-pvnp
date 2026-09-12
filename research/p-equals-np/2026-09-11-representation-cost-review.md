# S3063 independent adversarial representation-cost review

2026-09-11. Reviewed the final [investigation](2026-09-11-representation-cost.md), [primary-source companion](2026-09-11-representation-cost-sources.md), repository integrity boundary, S3063 planning story and frontier protocol. This is independent review of explanatory mathematics and source synthesis, not a new formal lower-bound increment, human peer review or novelty certification. No experiment or solver run was performed.

**GO for the known conditional compatibility result and bounded accounting conclusions.** The minor checker/proof-system terminology clarification has been verified in the final main note; no correction remains pending. No new universal invariant or proof of either P-versus-NP outcome is established.

## Independently checked concrete reduction

Read the [Darwiche-Marquis proof of Proposition 5.1](https://arxiv.org/pdf/1106.1819), Appendix printed pp.259-260. It explicitly invokes NP-completeness of consistency of two OBDDs with different orders, while preserving the polynomial common-order binary-conjunction exception. Its citation to Meinel-Theobald is accurately distinguished from independently accessing that original book proof.

Checked the reconstructed occurrence-copy reduction directly. Each nonempty clause gets distinct occurrence variables, so its disjunction can be checked with constant state while reading that clause's group. Conjoining these disjoint clause checks produces a linear-node OBDD. A second OBDD groups occurrences by original variable, remembers its first bit and checks equality of subsequent bits, also with linear nodes. Original literal signs occur only in the first diagram's clause tests; the second compares the underlying Boolean variable values. Both diagrams are individually satisfiable. Their common satisfying assignments correspond exactly to models of the original CNF. Evaluation gives NP membership. Thus the result concerns the joint decision query, not merely an expensive chosen compilation order.

For any fixed effective target with a uniform polynomial consistency procedure, a uniformly polynomial construction preserving that decision bit would decide the NP-complete pair problem in polynomial time. The conditional P=NP consequence follows even without full equivalence. One uniformly evaluable tagged target collection is a valid extension. A direct polynomial interleaved decision algorithm has the same consequence. No argument here implies an unconditional output-size bound: the correct constant answer would be tiny if it were known. Randomized/quantum conclusions are correctly changed to NP contained in BPP/BQP rather than P=NP.

## Invalidating examples and algorithm quantifiers

The investigation retains the substantive counterexamples raised during review. Exact UNSAT semantics collapse to the empty relation. Best decision-preserving output size collapses to one bit. A pointwise minimum over globally correct algorithms is cheap via an instance-specific hardcoded case and exhaustive fallback, even when program length is charged. A single algorithm also handles every member of a polynomially recognizable all-UNSAT family by recognition and fallback. Such families can still be hard for an explicitly required certificate language; decision and certificate production must not be conflated.

The equality-order example properly defeats a particular width invariant without making equality hard. Defining compatibility to be optimal solver time or minimum successful search would restate the target problem. The document does not claim that rejecting these candidates proves all useful abstractions impossible.

## Whole-trace and access-model scope

The transfer inequality is conditional on an actual uniform simulation of the whole admissible hybrid transcript into the reference proof language. The routine sum-of-local-costs argument requires one fixed exponent and shared earlier derivations; arbitrary repeated polynomial endpoint translations do not imply a single polynomial global bound. Projection, extension variables and imported lemmas require explicit treatment. The same-input Tseitin escape correctly invalidates a polynomial simulation of the full Gaussian route into ordinary resolution, not the Gaussian algorithm itself.

A fixed sound polynomial-time checker defines a certificate relation. It is a complete Cook-Reckhow-style refutation system only if every UNSAT formula has an accepted trace; the final main note now states this qualification explicitly. Restricted transcript transfer does not require pretending that an incomplete H is a complete system or that a universal efficient verifier has been constructed.

For a fixed oracle, query bounds tolerate input-independent intermediate computation. They do not supply unrestricted time bounds on explicit CNF: reading its L bits takes at most L queries, after which the query model allows uncharged computation. The source note correctly confines state-conversion assertions to the specified initial information, output/error contract and robustness conditions. No arbitrary input-dependent preparation or classical compilation is free.

## Relevance and disposition

The meaningful result is a known, transparent conditional obstruction to cheap coordination of independently tractable descriptions. The source companion identifies actual restricted simulation/lifting tools and explicitly declines to infer a new parameterized frontier from incomplete searching. This answers what can remain costly without presenting a renamed runtime definition as a discovery.

No novelty, new solver, universal lower bound, quantum separation, publication readiness or automatic research campaign follows. The outstanding scientific obligation is a new effective compatibility measure or an actual scoped transcript simulation; neither was produced here. That limitation is reported directly, and does not prevent closing this bounded investigation.
