# Sampling to actual formula promises: formalization and evidence

2026-09-12, S3130 under the open S3126 goal. Author:
`repair_complexity_reviewer`. Current status: **author-build green;
independent three-lens acceptance pending**. This increment
began as an explicitly unchecked draft while the shared compiler capacity
guard paused new builds. Subsequent attempts are recorded below.

Owned paths are `lean/PvNP/RealizableHardness/SamplingFormulaPromises.lean`,
`lean/PvNP/RealizableHardness/SamplingFormulaPromisesChecks.lean`, and this
receipt. The author read the sampling-promise assembly route in the planning
repository and the actual SamplingGuarantee, FiniteConcentration, Formula,
ExceptionRepair, JointSamplingLaw and FiniteRepairRoundingPipeline APIs.
No imported module or other author's file is changed.

## Concrete statements

The original formula family has type `Nat -> Formula (Fin N)` and the
actual finite domain has length S. `sampled F draws` indexes this family
at each draw in `Fin M -> Fin S`. Different trial positions remain distinct
even when they select equal atoms or equal formulas. `fromSeeds` uses the
actual `JointSamplingLaw.sampleArray`; it performs no deduplication and
has no YES/NO branch.

`empirical_eq_average` identifies the real empirical indicator average
with the cast of the actual rational formula acceptance average. It also
states the identity for zero trials, using the existing zero-division
convention; output promise implications separately require M positive.

`good_yes_average` uses the simultaneous Good event and an ORIGINAL-law
mean at least `1-eps/4` to obtain the conservative empirical repair
premise `average >= 1-eps`. `good_no_average` separately uses original
mean at most `gam/2` and `eps/4 < gam/2` to obtain `average < gam`.
`parameter_margin` derives that strict numerical margin from the actual
pipeline parameters `sig>=8`, `eps>=0`, `eps*sig<=gam/2`, and `gam>0`.

`good_yes_output` carries a source assignment of original weight at most
s into a perfectly satisfying assignment to the repaired, rounded formula
instance. `good_no_output` separately quantifies over all original
assignments of weight at most `sig*s` and all output assignments up to
the floor gap times the output budget. It concludes acceptance below
`2*gam`. The output is the same input-only construction in both theorems.
No theorem conjoins incompatible YES and NO promises. `output_leaves`
retains exactly one additional leaf per indexed sampled formula.

The Good event in these deterministic implications is an explicit
conditional premise, not a new assumed concentration theorem. Its actual
uniform bit-array probability has been proved in the separate main-green
SamplingGuarantee draft. The source extension now transports that
probability by event inclusion to the final YES/NO output events. This
extension was initially preserved uncompiled; final export evidence below
now covers it together with the rest of the file.

`seedProbability_mono` uses the actual finite uniform seed count.
`computed_event_probability` instantiates the exact rational precision
and the computable natural count `2^(clog 2 (32*(N+11)*P^2))`, with positive
rational epsilon and `1/epsilon<=P`, then transports the actual Good bound.
`computed_yes_probability` and `computed_no_probability` separately give
at least 5/6 and hence 2/3 for their respective concrete output events.
The NO event is universal over assignments to the whole enlarged variable
set and uses the actual rounded weights, floor gap and clipped budget.
Neither specialization assumes Good, a concentration law, a runtime bound
or both source promises. The generic event-inclusion lemma is discharged
by the explicit separate deterministic output implications above.

## Required validation and remaining composition

SamplingGuarantee initial draft pin: `96e9ff75aafffe7f49243d7bf9914721335f0ff3`
(main export 6278 exit zero, Checks unrun at preservation). The final
author-green pin is `00ed4a43d429878f53c27dccf68813255961d36e`, corrected
Checks 83651 exit zero with all 18 standard profiles; independent reviews
remain pending.
FiniteRepairRoundingPipeline initial draft pin:
`29d489ca86b7d1bd4c3fc964e44ef779648961c3` (then not green). Its final
author-green pin is `be83571ec0e4162f41d9d43da1fad20e29850387`, main 71982
and Checks 92725 exit zero. Independent proof export was subsequently
queued. ComputableSampleCount draft `fd834dbc268361483820db17fc36ee25a85575a5`
has a green main but unfinished Checks validation; no full acceptance of
that separate increment is inferred by importing its main.
The imported drafts and this new increment require their own scoped
validation and fresh independent proof, complexity and non-claims reviews.
The 15 requested profiles, including duplicate positions and zero-trial
identity examples, were initially unrun; final observed evidence is below.

Next validation uses pinned Lean 4.13.0, cached imports, one compiler at a
time, threads 1, capacity checked above 512 MiB before each command.
No builds, downloads or cleanup were performed during the initial source-only draft. A later
observed capacity increase is not attributed to this work and does not
retroactively supply validation.

Remaining finite assembly: independent review of the new event inclusion,
computable count instantiation and final output probabilities, completion
of count Checks validation, and explicit validity/common-denominator
wrappers. The exact least real-log count
versus conservative computable count needs manuscript reconciliation.
Source distribution/weight promises, specialized PCP hardness, encoding,
bit complexity, polynomial runtime, asymptotic reductions and the HN
learning transfer are not established here. Neither S3130 nor full S3126
is closed. No push, publication or full-hardness claim is authorized.

## Initial author export and correction

After capacity recovery and successful dependency main exports, scoped
main export 50484 exited 1 on the empirical/average cast identity. Casts
had crossed sums and division but remained around the rational Boolean
conditional. Explicit `apply_ite`, `Rat.cast_one` and `Rat.cast_zero`
simplification was added. Later declarations elaborated in that run, but
the failing module is not accepted verification. Corrected main and the
15-profile Checks export were then pending. No heartbeat limit was raised,
no theorem premise was added, and no dependency was edited for this fix.

## Final successful author exports

Corrected main session **92355 exited zero**, with one cosmetic
`unnecessarySeqFocus` warning at the cast simplification. The compiled
source was retained unchanged. Checks session **85000 exited zero**
without warnings. All **15 profiles** were inspected: `output_leaves`
and `duplicate_positions` use only `propext`; the other 13 use exactly
`propext`, `Classical.choice`, `Quot.sound`. None contains `sorryAx` or
a custom theorem axiom. This supersedes the historical unchecked and
failed statuses above, without treating any earlier failure as evidence.

Actual repository-root commands, pinned Lean 4.13.0, threads 1, cached
imports, serialized compiler and fresh 512 MiB/native-process guards:

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/SamplingFormulaPromises.olean lean/PvNP/RealizableHardness/SamplingFormulaPromises.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/SamplingFormulaPromisesChecks.olean lean/PvNP/RealizableHardness/SamplingFormulaPromisesChecks.lean
```

Compiled working SHA256:

- Main: `5b3be5d6cc5b66c9907855153b7e11c11c43e28fca5feff952ea649de278e941`.
- Checks: `ef50b659f0275a622c0a918c543b0ae6e58fbf47d4da9f6b9edacc225512af06`.

The author does not independently review these new files. Fresh three-lens
review is required before bounded acceptance; source hardness, encoded
runtime, learning transfer and full S3126 certification remain open.
