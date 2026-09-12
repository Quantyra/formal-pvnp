# Finite posterior and normalized reweighting increment

2026-09-12; S3133 under S3126. **KERNEL CHECKED; THREE-LENS REVIEW PENDING.**

The two `PosteriorReweighting` Lean modules target finite rational Bayes
identities and the algebraic mixture step in the archived manuscript's
posterior/zoom-out argument (lines 304–423). This is an existing documented
argument, not a new novelty or force claim. The prior S3126 literature
assessment applies.

The actual marginal is a sum of prior times kernel; the posterior is its
normalized joint mass. Normalization requires positive marginal. Bayes mass
covers zero-prior atoms, and the ratio identity requires positive prior.
Zero-marginal terms contribute zero in total probability, proved using
nonnegative prior and kernel. The cutoff inequality charges its likelihood
constant only to the event's prior mass and adds posterior bad-set mass.

The mixture theorem assumes a nonnegative normalized finite rational law,
weights in [0,1], reference probability 0<p0<=1, nonnegative eta and zeta,
stability |w/p0-1|<=eta on a specified good set, bad mass<=zeta, and
eta+zeta/p0<=1/2. It derives Z>=p0/2>0, normalized bad mass<=2*zeta/p0,
and event-response difference<=4*eta+4*zeta/p0 for actual responses in [0,1].
The normalized weighted law and its comparison are conclusions, not inputs.
Checks include zero-prior, zero-marginal, zero-weight, and satisfiable
nontrivial small-error examples.

## Explicit remaining obligations

This generic finite rational result is not the full posterior lemma.
Grassmann cardinalities/Gaussian ratios, the actual V,Q incidence distribution,
binomial tails, rank/transversality bounds, KMS covering, conditioned law
matching and decoding remain S3133/S3134 obligations. It does not certify
runtime, source NP-hardness, the full hardness theorem, learning transfer,
or a publication claim. Finite noncomputable sums are not a reduction machine.

## Verification and three-lens

| Lens | Status | Evidence |
|---|---|---|
| Build/axiom audit | GO | Main session 87985 exit 0; Checks session 84646 exit 0; 13 standard-only axiom profiles |
| Proof-adversarial | INCOMPLETE | Fresh top-level review required after green |
| Complexity | INCOMPLETE | Fresh top-level review required after green |
| Non-claims | INCOMPLETE | Fresh top-level review required after green |

No route-final or full-story completion is recorded.

## Actual verification record

Pinned root toolchain `leanprover/lean4:v4.13.0`, existing cached mathlib;
`LEAN_NUM_THREADS=1`. No downloads, dependency cache mutation, companion
package edits, or umbrella build were performed. Preflight found no live
Lean/Lake/elan processes and 6,079,029,248 bytes free on C. Final capacity
check found 5,609,476,096 bytes free and no live Lean/Lake/elan processes.

Commands (repository relative):

```powershell
$env:LEAN_NUM_THREADS='1'
lake env lean -o .lake/build/lib/PvNP/RealizableHardness/PosteriorReweighting.olean lean/PvNP/RealizableHardness/PosteriorReweighting.lean
lake env lean lean/PvNP/RealizableHardness/PosteriorReweightingChecks.lean
```

Main attempt 95337 exited 1 on local elaboration errors. Attempt 31567
exited 1 on the remaining commutative-ring equality in `bayes_ratio`.
Attempt 87985 exited 0. The first Checks invocation exited 1 because its
UTF-8 BOM prevented parsing the import; after removing the BOM, session
84646 exited 0. No observation timeout was treated as terminal or used
to restart an active process. Final warnings are unused section/lemma
parameters and a redundant example tactic, not proof failures.

Source corrections preserve all theorem statements: unfold the marginal
normally in normalization; split the zero marginal case in the ratio
identity and discharge the nonzero case by field algebra; supply explicit
product nonnegativity in the reweight error estimate; use the direct
bounded-weight multiplication lemma for bad mass. Added audit commands
cover `marginal_nonneg` and `joint_zero_of_marginal_zero` as well.

All 13 declarations printed by Checks have exactly the axiom profile
`[propext, Classical.choice, Quot.sound]`:
`marginal_nonneg`, `marginal_normalized`, `posterior_normalized`,
`bayes_mass`, `zero_prior`, `bayes_ratio`,
`joint_zero_of_marginal_zero`, `total_probability`,
`posterior_event_cutoff`, `reweight_error`, `normalizer_deviation`,
`normalized_reweighting`, and `reweighted_normalized`, all under
`PvNP.RealizableHardness.PosteriorReweighting`.
There are no source `sorry`, `admit`, `native_decide`, or new axiom
declarations. Clean axioms do not discharge the explicit geometry inputs.

SHA256 of the exact verified working-tree sources (before Git newline
normalization; reproduced here to distinguish source bytes):

| Source | SHA256 |
|---|---|
| `PosteriorReweighting.lean` | `e69b54f5efc8412e8e04081a5d88ebdc588a51325aca0a830b08518c10e35b39` |
| `PosteriorReweightingChecks.lean` | `a1a5a12a6040d7befbba9d0a660ac5cfcb9072d682a3de6056324aba4506512b` |

Fresh independent top-level proof-adversarial, complexity-theory, and
non-claims review remains the orchestrator's next gate. This author
receipt is not one of those reviews.

## Final bounded integration (2026-09-12)

The earlier pending-review sections above are preserved as historical
snapshots. They are superseded for this finite increment by the following
completed independent reviews of candidate
`f6126f7213c91741932be465e8041f26e7e8427f`.

| Lens | Final verdict | Evidence |
|---|---|---|
| Build/axiom audit | GO | Independent main export 44164 exit 0 and Checks export 99953 exit 0; all 13 profiles exactly `[propext, Classical.choice, Quot.sound]` |
| Proof-adversarial | GO | `2026-09-12-realizable-hardness-posterior-proof-review.md`; actual finite definitions, zero-mass cases, denominator signs, nonvacuity, and all 13 exports inspected |
| Complexity | GO-WITH-NOTES | `2026-09-12-realizable-hardness-posterior-complexity-review.md`; actual geometric inputs, conditional-law matching and computational obligations remain explicit |
| Non-claims | GO-WITH-NOTES | `2026-09-12-realizable-hardness-posterior-nonclaims-review.md`; wording bounded to finite algebra and the pinned root toolchain |

Root read all three independent receipts and authorized this exact four-file
evidence integration. The finite rational posterior and normalized
reweighting increment is accepted within its stated scope. Both working
source hashes remain equal to the verified pins above; no Lean source was
changed by review or integration. The actual thirteenth export is
`reweighted_normalized`; the normalizer lower bound is a conjunction of
`normalized_reweighting`, not an additional standalone export.

This acceptance does not close S3133 or S3126. Actual Grassmann counts,
incidence kernels, tails, rank/transversality, conditioned-law matching,
covering and decoder application, machine/runtime, specialized hardness,
learning and final paper reconciliation remain required. The separately
pinned newer-toolchain companion is not certified by this root 4.13 result.
There is no new novelty, publication-readiness, or full-goal claim.
