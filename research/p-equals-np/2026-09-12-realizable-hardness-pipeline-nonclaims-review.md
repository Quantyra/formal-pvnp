# Finite repair/rounding pipeline: independent non-claims review

2026-09-12. Verdict: **GO for this bounded semantic increment**.
Reviewer `repair_complexity_reviewer` did not author the pipeline or its
receipt. This reviewer authored SamplingThreshold, SamplingGuarantee and
the separate unreviewed SamplingFormulaPromises draft; those are not
self-reviewed or certified by this note.

## Frozen evidence

Candidate `be83571ec0e4162f41d9d43da1fad20e29850387`.
Read both `lean/PvNP/RealizableHardness/FiniteRepairRoundingPipeline.lean`
and `lean/PvNP/RealizableHardness/FiniteRepairRoundingPipelineChecks.lean`,
the associated formalization receipt and actual manuscript sampling-end
and rational-weight-control passages. A working-versus-candidate Git diff
for both modules was empty. Independently computed working SHA256 values:

- Main: `d6377773387719ba05e19a590f2c19f2f6d7f7ab15cd9c10f1cbc4b54c9187d6`.
- Checks: `d4bb968301839f234e3387172776b4f91167d4fb2ceca3c6110cbfe5e3278ed2`.

These match the author's recorded compiled bytes. Author reports final
main 71982 and Checks 92725 exit zero, 18 standard profiles; this reviewer
did not rerun Lean for this non-claims lens. A separate proof reviewer is
responsible for independent exports. Historical failed/draft receipts
are retained and explicitly superseded by the author's final evidence.

## Claim-to-statement assessment

The receipt calls this a fixed-list semantic composition. That matches
the code: Parameters carries domain/positivity/normalization, numerical
smallness and budget conditions, but no promise witness or source hardness.
The indexed formula family remains an actual monotone formula AST.
Distinct occurrences receive distinct fresh coordinates, including
duplicate formulas. Output definitions depend on the instance parameters
and indexed family, not on a satisfying assignment or a YES/NO classifier.

The YES theorem assumes the actual original weighted witness and rational
acceptance premise, and yields perfect satisfaction with feasible rounded
weight. The NO theorem separately assumes a universal original promise
and yields a universal output promise. The receipt does not conflate the
two implications or assert that source promises have already been proved.
The two concrete Checks instances use different s values, so they do not
silently supply incompatible promises for one instance.

The final gap is `floor(floor(sigma/4)/2)` and the threshold remains
`2*Gamma`. Positivity/normalization, clipped budget at most one, common
integer denominator and exactly one added leaf are actual conclusions.
The reciprocal-budget result is an inequality, accurately described as
such. The denominator estimate is numeric and conditional on explicit
integer bounds for `1/s` and `sigma/Gamma`; it is not a polynomial-time
implementation theorem or a derivation of those source parameter bounds.

## Remaining boundaries

The source does not sample a list, prove its successful-event probability,
implement an encoded reduction, prove runtime, discharge specialized PCP
or source NP-hardness, or transfer a learning algorithm. The receipt
explicitly retains those obligations and does not claim full S3130/S3126
closure or public certification. In particular, the exact common
denominator enables a later integral-length construction; it is not the
HN transfer itself. Fixed L precedes the eventual machine and polynomial,
with no imposed uniform-in-L exponent or machine-selection requirement.

No actionable claim inflation or contradictory-promise shortcut found.
Acceptance is limited to this lens and candidate; completion still needs
the other independent lenses. No publication or push follows from GO.
