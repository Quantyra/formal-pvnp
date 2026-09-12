# Sampling to actual formula promises: unchecked source draft

2026-09-12, S3130 under the open S3126 goal. Author:
`repair_complexity_reviewer`. **No compiler has checked either new file.
No axiom profile or independent acceptance is claimed.** This draft was
authorized while the shared compiler capacity guard paused new builds.

Owned paths are `lean/PvNP/RealizableHardness/SamplingFormulaPromises.lean`,
`lean/PvNP/RealizableHardness/SamplingFormulaPromisesChecks.lean`, and this
receipt. The author read the sampling-promise assembly route in the planning
repository and the actual SamplingGuarantee, FiniteConcentration, Formula,
ExceptionRepair, JointSamplingLaw and FiniteRepairRoundingPipeline APIs.
No imported module or other author's file is changed.

## Proposed concrete statements

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
SamplingGuarantee draft. This new file does **not yet transport that
probability by event inclusion to the final YES/NO output events**.

## Required validation and remaining composition

SamplingGuarantee draft pin: `96e9ff75aafffe7f49243d7bf9914721335f0ff3`
(main export 6278 exit zero, Checks unrun at preservation).
FiniteRepairRoundingPipeline draft pin:
`29d489ca86b7d1bd4c3fc964e44ef779648961c3` (not green).
These imported drafts and this new increment still require successful
scoped exports and fresh independent proof, complexity and non-claims
reviews. The Checks source requests 11 profiles, including duplicate
positions and zero-trial identity examples; none is an observed profile.

Next validation uses pinned Lean 4.13.0, cached imports, one compiler at a
time, threads 1, capacity checked above 512 MiB before each command.
No builds, downloads or cleanup were performed for this draft. A later
observed capacity increase is not attributed to this work and does not
retroactively supply validation.

Remaining finite assembly: actual event inclusion/probability monotonicity,
the independently reviewed computable natural count instantiation,
at-least-5/6 (and 2/3) final output promise probabilities, and explicit
validity/common-denominator wrappers. The exact least real-log count
versus conservative computable count needs manuscript reconciliation.
Source distribution/weight promises, specialized PCP hardness, encoding,
bit complexity, polynomial runtime, asymptotic reductions and the HN
learning transfer are not established here. Neither S3130 nor full S3126
is closed. No push, publication or full-hardness claim is authorized.
