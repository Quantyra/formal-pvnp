# Conditioned covering: non-claims review

2026-09-12. S3134 under S3126. Top-level non-claims-boundary-reviewer.

**Verdict: GO-WITH-NOTES for this finite conditioned-covering component only.** This is not acceptance of the full realizable-hardness theorem, submission readiness, or permission to announce a completed formal proof.

## Evidence and scope

Reviewed frozen commit `ec3eed3a0fb05b59e0bb5985661ac8a10147eb20`, the complete `ConditionedCovering.lean` and `ConditionedCoveringChecks.lean`, and `2026-09-12-realizable-hardness-conditioned-covering-draft.md`. The two current sources have no diff against that freeze. Their SHA256 hashes are respectively `766695b48744854b9b1e71b27a5b442fdc6ce822381d7ca3207f14d74cf1b7ef` and `62b45015fb69034bcef93f367c73f4fca98e7b49236530dcb618ac4deb2c15cc`.

Read the planning formal-three-lens protocol and the available local KMS primary-source extraction at `C:/Users/Dan/AppData/Local/Temp/s3123-kms.pdf.txt`, including Lemmas 4.6 and 4.7. No repository-root AGENTS.md exists in this satellite; the supplied planning routing and review boundaries apply. This reviewer ran no compiler and makes no independent-build claim. The author receipt records main retry 83456 and Checks retry 96493 exiting zero, 26 standard axiom profiles, and 10 elaborated examples. Independent proof verification belongs to the separate proof lens.

## What the statements support

For rational beta >= 0, natural dimensions a < d <= J, and 2^d beta <= 1/8, `actual_conditioned_covering` defines a concrete exceptional predicate on actual a-dimensional subspaces of the binary ambient space of dimension 3J. Its ambient uniform mass is at most sqrt(beta) J^(1/4). Outside that predicate the actual deletion-sampler d-subspace law conditioned on Q being contained in L is normalized, and its half-L1 statistical distance from the correspondingly conditioned ambient law is at most sqrt(beta) J^(1/4) 2^(d+5). These constants and the interpretation of conditioning agree with KMS Lemma 4.7 on the displayed domain.

The final theorem is not an implication from an assumed conditional-TV bound. `actual_conditional_average_le` instantiates a shared flag kernel with actual Grassmann laws; `actual_conditional_average_le_real` imports the existing unconditioned covering result at dimension d. The exceptional predicate uses a strict excess over the stated threshold, so its complement gives the required weak inequality. The zero-error branch explicitly establishes zero conditional distance, avoiding division by zero.

The definitions and identities support the word “actual”: `ambientConditional_formula` and `deletedConditional_formula` identify containment-conditioned L laws; `deletedConditional_eq_eventPosterior_mixture` identifies the deletion-draw posterior followed by uniform conditioned L inside its retained space, treating zero fibres explicitly. `deletedConditional_eq_advicePosterior_mixture` connects that same law to the advice posterior used by the tail and density modules. This does not replace a conditioned deletion draw with an independent fresh draw.

The quantitative internal lemmas use 0 <= beta < 1 and a <= d <= J. Strict beta < 1 supplies the positive no-deletion atom and hence positive conditioning events. The public source-shaped theorem derives it from the small-beta condition. Algebraic identities with weaker hypotheses should not be advertised as normalized probability laws for arbitrary rational beta. Boundary checks at J=0 and a=d=0 concern internal results; they do not change the final theorem's strict a<d domain.

## Notes and remaining obligations

- Source and Checks retain historical UNCOMPILED/UNRUN banners. The receipt explicitly supersedes them with author outcomes. This is a documentation consistency note, not grounds for claiming a missing independent build has occurred or for rerunning unchanged mathematics.
- The exceptional bound is an ambient uniform fraction, not a bound on every Q or an automatically interchangeable bound under the deleted marginal. It can be numerically uninformative until the intended parameter inequalities are proved. The component does not show that the prescribed sampler eventually satisfies every source or downstream smallness condition.
- It does not establish the near-one Gaussian-ratio estimate, the remaining parameter asymptotics, the combined good-advice exceptional budget, or the final fixed-W conditional incidence estimate required later in the manuscript.
- It supplies no specialized PCP/decoder reduction, encoded randomized polynomial-time reduction, coin/runtime/weight guarantees, full CMMSA hardness theorem, exact learning transfer, or growing-parameter uniform polynomial-time claim.
- This follows the cited KMS conditional-TV averaging route. Neither the broader internal domain nor mechanizing these finite identities establishes novelty, publication merit, a quantum algorithm, or progress resolving P versus NP by itself.
- Final manuscript-to-Lean reconciliation and full-goal verification remain required. A bounded GO-WITH-NOTES here must not be promoted to an announcement of a certified full hardness proof.

No blocking claims inflation was found in the reviewed source or receipt. The receipt already distinguishes this existing dependency from novelty and lists the larger obligations as incomplete. This review modifies only this report and authorizes no public change.
