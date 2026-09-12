# Exact dyadic sampling thresholds: numeric formal increment

2026-09-12; S3130 under the open S3126 full proof-and-paper goal.
Author: `repair_complexity_reviewer`, explicitly reassigned by root to
this implementation after reviewing distinct earlier increments. This
author does not independently review the present new code.

## Source and exact scope

Read the manuscript's original sampling threshold (lines 673-684) and
the learning-confidence refinement (lines 733-736 and 772-775), at
SHA256 `ff00997c8c243e88982c41b0b0e24faaaafe36cec6f1903824599dc242538686`.
The original threshold uses log 6 for failure at most 1/3. The learning
corollary explicitly replaces this with log 12, giving failure at most
1/6 before the separate transfer's residual failure at most 1/6.
Both constants are implemented here. No manuscript edit is needed.

Owned files:

- `lean/PvNP/RealizableHardness/SamplingThreshold.lean`
- `lean/PvNP/RealizableHardness/SamplingThresholdChecks.lean`
- this receipt

All prior sampling, MGF, CDF, repair, rounding, concentration and other
authors' modules are untouched. Shared Audit, toolchain, dependencies and
claims manifests are unchanged. Namespace:
`PvNP.RealizableHardness.SamplingThreshold`.

## Actual mathematical construction

For N natural and real epsilon, define

```text
threshold N eps = (N*log 2 + log 6)/(2*(eps/8)^2)
sampleCount N eps = 2 ^ Nat.clog 2 (Nat.ceil (threshold N eps))
learningThreshold N eps = (N*log 2 + log 12)/(2*(eps/8)^2)
learningSampleCount N eps = 2 ^ Nat.clog 2 (Nat.ceil (learningThreshold N eps))
```

For `0 < eps <= 1`, these are the exact least powers of two at or above
the respective real thresholds. Positivity and lower bounds hold at the
stated broader domains; strict upper bounds use threshold > 1, proved
from the logarithm lower bound and epsilon <= 1.

| Export(s) | Actual conclusion |
|---|---|
| `sampleCount_pos`, `sampleCount_lower`, `sampleCount_least` | Positive count, original threshold met, no smaller admissible power of two. |
| `sampleCount_upper` | Count < 2 times the original threshold. |
| `failure_budget` | Any M meeting the original threshold gives `(2^N)*(2*exp(-2*M*(eps/8)^2)) <= 1/3`. |
| `sampleCount_failure_budget` | The chosen count satisfies that numeric failure-factor bound. |
| `failure_budget_of_log_threshold` | For every positive real C, replacing log 6 by log C yields the general numeric bound 2/C. |
| `learningSampleCount_pos/lower/least/upper` | Exact corresponding least-dyadic facts for the log-12 threshold. |
| `learning_failure_budget`, `learningSampleCount_failure_budget` | General qualifying M or the chosen learning count gives the numeric factor at most 1/6. |
| `threshold_numeric_upper`, `sampleCount_numeric_upper` | Original threshold <= `32*(N+5)/eps^2`; selected count < `64*(N+5)/eps^2`. |
| `learningThreshold_numeric_upper`, `learningSampleCount_numeric_upper` | Corresponding bounds with N+11. |
| `sampleCount_bound_of_inverse_error` | Under explicit `1/eps <= P`, natural count <= `64*(N+5)*P^2`. |
| `learningSampleCount_bound_of_inverse_error` | Under that same premise, learning count <= `64*(N+11)*P^2`. |

The numeric constants use proved `log 2 <= 1`, `log 6 <= 5` and
`log 12 <= 11`. Failure-factor proofs multiply the threshold by its
positive denominator, use monotonicity of exp, and simplify
`exp(-(N*log 2+log C)) = 1/(2^N*C)`. They assume no concentration or
probability estimate. The supplied reciprocal-error premise must still
be instantiated by the earlier parameter construction to obtain a
family-level polynomial size claim.

## Computational and probability boundary

These are mathematical real-log/ceiling choices, marked noncomputable.
The code does not claim an encoded algorithm computes an exact real
comparison or its least ceiling. A verified computable sampler may use a
proved rational upper bound and a dyadic count above it, together with a
semantic comparison to these exact thresholds. Its bit complexity and
runtime remain explicit future obligations.

The quantity bounded by `failure_budget` is a numeric expression, not a
probability defined in this module. The separate concentration author
must prove the actual assignment-union probability is at most that
expression, with the real/rational laws and independent seed pushforward
properly connected. Only then can the lemmas imply success at least 2/3
or 5/6 for generated lists. HN transfer residual failure, final promise
composition, encoded runtime and source hardness remain unproved here.
Fixed L precedes the machine and its polynomial; no uniform exponent or
L-to-machine algorithm is asserted.

## Scoped verification

Pinned Lean 4.13.0 and existing cached imports. No download or dependency
build was started. Direct commands use one thread and the existing
destination exports:

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/SamplingThreshold.olean lean/PvNP/RealizableHardness/SamplingThreshold.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/SamplingThresholdChecks.olean lean/PvNP/RealizableHardness/SamplingThresholdChecks.lean
```

Final expanded main export session 67986 exited zero without warnings.
Final Checks session 68791 also exited zero without warnings and printed
29 axiom profiles, all exactly `propext`, `Classical.choice`, `Quot.sound`.
The audit comprises 22 main results and seven examples. The examples
cover positive count at zero variables, an actual threshold comparison,
`sampleCount 3 (1/2) <= 2048`, both chosen-count confidence bounds, and
explicit numeric counts giving `4*exp(-16) <= 1/3` and
`4*exp(-32) <= 1/6`. No native evaluation is used.

Final compiled working SHA256:

- SamplingThreshold.lean: `915c257be9470041524b789db87a5de5ef946abe6e452650a02e5efb19b49791`.
- SamplingThresholdChecks.lean: `559bb713fae0f334e7eee2d467bc8d00d7264fe9913ee8913219017ad1e603cc`.

Earlier local script
failures and the original log-6-only build are not the final expanded
candidate's verification evidence. No sorry/admit or theorem axiom was
introduced to complete a proof.

Fresh proof-adversarial, complexity and non-claims review must be routed
by root now that both final exports and axiom profiles are green. S3130 and
S3126 remain open. No publication, push or release is performed.

## Completed independent three-lens review

Frozen code candidate: `dc660298e98e52ce2fed062791f598b440a63b23`.
Integration appends this table and preserves the three actual independent
review receipts; it changes no Lean source or declaration.

| Lens | Reviewer | Verdict | Actual evidence |
|---|---|---|---|
| Proof-adversarial | `concentration_proof_review` | GO | Independent main session 14771 and Checks session 28119 both exited 0; all 29 profiles exactly propext, Classical.choice, Quot.sound. |
| Complexity | `threshold_complexity_review` | GO-WITH-NOTES | Exact least-dyadic thresholds, constants and numeric size bounds sound; encoded count computation and input-size polynomiality remain open. |
| Non-claims | `cdf_proof_review` | GO | Numeric and noncomputable scope stated accurately; no implied sampler-success or full hardness certification. |

Review evidence:

- `2026-09-12-realizable-hardness-sampling-threshold-proof-review.md`
- `2026-09-12-realizable-hardness-sampling-threshold-complexity-review.md`
- `2026-09-12-realizable-hardness-sampling-threshold-nonclaims-review.md`

The exact working and frozen code hashes remain the two SHA256 values
recorded above. This closes review of this numeric increment only.
Remaining work includes an encoded computable count (or a proved
conservative replacement with reconciled manuscript description),
input-size and arithmetic/runtime bounds, actual joint sampler and
concentration/mean-approximation bridges, and final promise composition.
Neither S3130 nor the full S3126 proof-and-paper goal is closed.
