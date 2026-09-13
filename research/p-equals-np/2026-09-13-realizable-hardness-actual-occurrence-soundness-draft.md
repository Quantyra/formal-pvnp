# Actual occurrence majority soundness draft

2026-09-13. S3132/S3137 under S3126. Source author: counts_complexity_nonclaims_review. Uncompiled and unaccepted. No compiler, Git or public actions for this draft. This author cannot independently review it.

The pair imports ActualOccurrenceCompleteness's exact sourceBadRow/sourceViolations and ActualCloudSoundness's all-port majority/minority. These are source dependencies pending their own compilation and acceptance, not asserted green dependencies. Counts supplies the actual output size and violation decomposition. The route follows the existing actual-cloud-assembly-obligations note; no new literature or novelty claim is made.

## Actual charging construction

decoded reads the zero-tie all-port majority of each restricted cloud. totalMinority sums the cardinalities over every actual cloud port, including unanchored dummy ports. BadSlot is a subtype of actual source Slots whose allocated anchor disagrees with the decoded owner value. ChangedRow consists of actual source equation indices violated by the decoded assignment but satisfied by the occurrence-port assignment.

changed_has_bad_slot proves a ChangedRow has a mismatching one of its three source slots: if all three anchor values agree, the exact three-term parity tests and stored RHS agree, contradicting the two BadRow flags. chargeSlot chooses such an index; this maps into actual BadSlot and is injective because its first coordinate is the source row index. There is at most one charged row per chosen mismatching slot, even when source equations repeat.

badSlotPort maps an actual bad slot to the tagged port (owner, ordinal, 0) in the dependent Sigma of all minority ports. Injectivity is proved by reconstructing the two actual anchor values and invoking Allocation.anchor_injective. No claim about recover being an inverse on dummy ports is used. Fintype cardinality of that Sigma is the actual totalMinority, so changed-row cardinality is bounded by totalMinority.

The original countP is explicitly rewritten as the Fin m sum of originalBadIndex indicators. The exact source countP uses the same occurrence enumeration. Pointwise Boolean case analysis bounds the source indicator by the original indicator plus the ChangedRow indicator. Summation and the two injections yield sourceViolations(decoded x) <= originalViolations x + totalMinority x.

## Actual gap transfer targets

clouds_lower sums CloudSoundness.rowsViolations_lower for the actual restrictCloud assignments. With lambda=min(1,kappa)>0, original cost is weighted by lambda<=1 and minority cost by lambda<=kappa. The exact Counts violation decomposition gives lambda*sourceViolations(decoded x) <= violations x for every global assignment.

conditional_no_count takes an explicit source promise that every original assignment violates at least delta*m equations. It derives target violations >= lambda*delta*m. conditional_no_fraction additionally requires delta>=0 and m>0, uses the actual output length T with 0<T<=(1+18D)m, and derives target violation fraction >= lambda*delta/(1+18D). D and kappa are the fixed accepted graph-family constants, independent of source instance and completeness error. All count/charging statements allow m=0; only the final division requires positivity. Zero ties/empty-cloud conventions come from the actual CloudSoundness decoder, not a separately chosen majority.

This is conditional soundness transfer, not proof that the source promise is NP-hard. In particular the intended delta=3/8 source theorem remains upstream work. No assumed expansion, charging, count identity or desired output gap replaces the actual joins. No runtime or encoded-size conclusion follows from finite cardinalities or classical choice used for the proof's charge map.

## Verification and outstanding work

The source scripts contain no sorry/admit/new axioms. Checks requests 13 profiles, three signatures and six examples, including actual injection, charging, weighted count, empty source and normalized gap signatures. No compiler has run this pair: elaboration repairs may still be needed, especially dependent subtype cardinality and finite countP/sum conversions. Independent proof, complexity and non-claims review are required after build green.

The mathematical decomposition now has scripts for all requested charging and conditional gap joins, rather than a remaining assumed lemma. It is still unverified source. ActualCloudSoundness and Completeness must first compile; then this pair needs its own guarded build and reviews. Encoded allocation/serialization FP, full specialized source hardness, upstream PCP/decoder and compatible parameters, final learning theorem, manuscript reconciliation, complete proof consolidation and fresh-checkout verification remain outside this pair and remain full-goal obligations.
