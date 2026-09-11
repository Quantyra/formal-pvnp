# Independent contribution gate

2026-09-11. S3050 / E014 / E004. Under `INTEGRITY-CLAIMS.md`. One independent reviewer applies source/proof, complexity and non-claims lenses. This is a contribution assessment, not a manuscript or formal theorem closeout.

## Decision

**HOLD publication/manuscript development of the combined tail-and-cost story.** The local calculations are valid within their audited scopes, but a substantive new research claim has not been established. Repeating the audits in a new package does not resolve that deficit.

The strongest precise candidate claim supported now is: **In the frozen 1,415 source-ID-paired, SAT-retained n=20 archive records, depth-60 empirical mean inverse-root success exceeds inverse-root empirical mean success by a factor 2.6923; this finite diagnostic does not determine a runtime exponent or crossover.** This is a reproducible data-derived observation. Its significance beyond an illustrative reanalysis is not yet demonstrated.

## Adversarial findings

1. The published source did not simply overlook distributions. The [2024 journal paper](https://journals.aps.org/prxquantum/pdf/10.1103/PRXQuantum.5.030348), Sec. III and Figs. 2 and 4, explicitly compares average-success predictions with median runtime and discusses divergence and substantial instance-level tails. Its 2022 arXiv entry is not the final journal version. The local inverse-root mean functional is distinct from a median or quantile. The 2.6923 ratio cannot be applied as a correction factor to the paper's median or to a later physical crossover.
2. The [2025 resource paper](https://arxiv.org/html/2504.01897v1) uses a median classical benchmark, a quantum scaling model and a carefully optimized physical implementation. The currently retrieved arXiv record lists v1; a nonexistent v2 URL is not evidence of an update. The present source shows 14.99 hours in its abstract. Version-specific numbers must remain pinned; the old local substituted arithmetic is not a reproduction. Our small SAT-conditioned records do not validate its large-n/depth extrapolation, and neither do they refute it.
3. Elementary Jensen inequalities, conditioning identities and a sufficient lower-tail integral condition are standard probability tools. A new name or resource notation is insufficient. A theory contribution would need a nontrivial tail guarantee for a specified circuit/ensemble, a demonstrably stronger bound, or a new obstruction relevant to an existing claim. None has been proved here. Moreover, depth 60 still has the lower observed mean inverse-root value (6.415 versus 9.706); a larger averaging penalty is not an overall degradation claim.
4. The seven n=16 formulas in S3048 are a separate generated population. Its negative result concerns one fixed wide clean-ancilla construction and elementary unitary gates, with classical verification reported separately. The arithmetic certificate that preparation alone exceeds the comparator is sound, but routine for that construction. It does not contradict an optimized large-instance physical implementation, compare total runtime, or constitute a general lower bound. A proposed compiler improvement must also consider existing SAT-aware compilation, including the recent [SAQC preprint, v2 September 9, 2026](https://arxiv.org/abs/2609.05737v2); only its abstract was independently checked in this review.
5. Original source formula/circuit provenance remains incomplete. The existing source-ID pairing and count checks do not establish original formula bytes or every null-angle record's exact circuit. Combining that archive with independent small formulas does not repair the gap. Any finite-schedule proof-constant counterexample is a separate possible technical correction, requiring an exact version and effect on the intended theorem; it cannot supply novelty for the broad empirical story by association.

## Minimum gate and stopping rule

Do not generate another survey, manuscript, seed batch or compiler campaign to continue this story automatically. Reopen publication consideration only upon a concrete missing contribution: an exactly matched source calculation whose correction changes the intended statistic/conclusion, or a proved nontrivial statement beyond existing tail and resource analyses. Specify that one claim and its closest theorem first. If no such difference can be stated, retain the work as internal reproducibility and design evidence and stop the paper route.

## Author-artifact review

Read the [contribution assessment](2026-09-11-qaoa-contribution-assessment.md), [nearest-work note](2026-09-11-qaoa-contribution-nearest-work.md), and the catalog's dated status update. They agree on HOLD, identify the finite statistic as the strongest supported candidate, distinguish the two populations and resource objectives, and do not claim a manuscript/metadata review that has not happened. Requested corrections were verified: incomplete witness search replaces an unsupported formal SAT-only promise, seven SAT cases replace clause-width-seven wording, and journal-version discussion locators replace ambiguous subsection labels. The updated crosslinks and separate source-functional prerequisite preserve HOLD without opening a successor.

| Lens | Verdict | Reason |
|---|---|---|
| Source/proof | GO for assessment; HOLD novelty | The current journal discussion already overlaps the broad tail warning. Full-text evidence is sufficient to reject that novelty claim; it is not exhaustive certification of every possible related contribution. |
| Complexity | GO for bounded findings | Mean functionals, medians, conditioning, size/depth transfer and unitary versus total-resource comparisons remain distinct. No local result refutes the source crossover. |
| Non-claims/publication | HOLD combined paper | No substantive new theorem, matched correction or justified changed forecast is established. Preserve internal evidence; no manuscript, outreach, experiment or successor campaign follows automatically. |

The optional final-constant correction-impact question is a separate, unexecuted possibility. Merely locating a defective intermediate step does not prove its final guarantee false. It is not a reason to keep packaging this combined paper.
