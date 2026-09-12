# Independent gap-first selection review

2026-09-12; S3082/E004/S008. Reviewed the saved [selection note](2026-09-12-gap-first-selection.md) and S3082 paragraph of the [research graph](2026-09-11-research-meta-graph.md) under [integrity](../../INTEGRITY-CLAIMS.md).

**Verdict: GO for the bounded assessment and selection NONE.** The literature supplies a credible target with a direct conditional P-versus-NP implication. It does not supply a credible mechanism for the proposed transfer. This review approves neither a new lower bound nor a novel application.

## Independent primary-source checks

| Source reopened on September 12 | Checked scope |
|---|---|
| [Singer-Tulsiani-Velusamy, arXiv:2604.08731v1, Theorem 1.2 and Section 1 model](https://arxiv.org/pdf/2604.08731) | The theorem transfers a basic-LP integrality gap to a linear-space single-pass CSP distinguishing lower bound with the stated epsilon slack. The state-transition model explicitly permits unrestricted computation time and randomness. The note correctly fixes disjoint promises and labels this a preprint claim rather than an independently verified full proof. |
| [McKay-Murray-Williams, STOC 2019, Theorems 1.2 and 1.3](https://people.csail.mit.edu/rrw/MCSP-MKTP-stoc19.pdf) | The oracle synthesis algorithm has tilde-O(s) workspace and query length, and tilde-O(s squared) update time with oracle calls. The direct consequence requires excluding algorithms with both polynomial-in-s space and polynomial-in-s update time. A pure space lower bound is not the missing computational guarantee. |
| [Cheraghchi-Hirahara-Myrisiotis-Yoshida, STACS 2021, Lemma 17 and Section 3.1](https://drops.dagstuhl.de/storage/00lipics/lipics-vol187-stacs2021/LIPIcs.STACS.2021.23/LIPIcs.STACS.2021.23.pdf) | Independently restates the short-oracle upper bound. The surrounding one-tape lower bounds and their threshold restrictions do not fill the small-threshold unrestricted-streaming target. |

The CSP HTML fetch failed in this independent pass; the complete primary PDF supplied the inspected theorem and model. No stronger concurrent-preprint theorem was imported.

## Resource inference cross-check

For the empty A oracle used in the concrete test, a short Sigma_3 SAT query can be evaluated by exhaustive quantifier loops while retaining only polynomial workspace in its length. Scratch can be reused between calls. This gives an ordinary polynomial-in-s-space simulation, not the same tilde-O(s) workspace and not polynomial update time. With fixed s(n)=n^k and n=O(log m), every fixed polynomial workspace overhead is polylog(m). The author's explicit parameter choice therefore handles the otherwise unspecified simulation exponent.

The rejection requires all of the stated composition assumptions: one source pass, target bits emitted in the required order, preserved answers, and o(m) total retained workspace including reduction, buffering, and synthesis-output interpretation. Under these assumptions the unlimited-time simulation would violate the source space theorem. This is a straightforward compatibility consequence of known results, not a new general no-go theorem. It does not exclude arbitrary reductions, different size regimes, or arguments that distinguish computationally efficient from arbitrarily expensive transitions.

## Novelty and significance challenge

The assessment passes the early stop rule: it identifies the closest exact contracts, tests the required transfer before developing it, and rejects this candidate when the contracts conflict. It does not call a renamed hard antecedent a mechanism. The remaining demand for a time-sensitive argument is an unfilled obligation; stating it alone supplies no reason to expect a successful application.

For later candidates the same disqualifiers remain: known consequence after matching promises and outputs; hidden selection/advice/access costs; altered thresholds or quantifier order; qualitative identities offered as quantitative gains; and a source-supported open target presented as evidence for an unsupported proposal. S3077-S3081 were read to ensure those earlier paths were not silently restarted.

Both the main note and graph correctly select NONE, retain the parked quantum route, and add no achieved lower-bound or P-versus-NP edge. There is no novelty, publication, or completeness verdict. This was independent agent source and document review, not Lean verification, experiments, circuit execution, or human expert certification. No implementation or proof artifacts were modified and no commit was made by this reviewer.
