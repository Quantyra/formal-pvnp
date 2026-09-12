# Actual binary-array sampling guarantees: formal increment

2026-09-12. S3130 under the open full S3126 proof-and-paper goal.
Author `repair_complexity_reviewer`, explicitly reassigned by root after
reviewing the distinct joint-law increment. This author cannot independently
review these new modules. Build status pending until final evidence below.

## Exact scope and sources

Read the actual reviewed JointSamplingLaw, FiniteConcentration and
SamplingThreshold APIs and the manuscript's sampling paragraph (lines
647-693) and log-12 confidence refinement (lines 733-736 and 772-775).
The manuscript SHA256 is
`ff00997c8c243e88982c41b0b0e24faaaafe36cec6f1903824599dc242538686`.
The source code imports actual sampler, product concentration and count
theorems. No distribution, approximation, independence or success law is
supplied as an assumed contract.

Owned files:

- `lean/PvNP/RealizableHardness/SamplingGuarantee.lean`
- `lean/PvNP/RealizableHardness/SamplingGuaranteeChecks.lean`
- this receipt

No reviewed module, shared Audit, toolchain, dependency or other author's
source is edited. Namespace `PvNP.RealizableHardness.SamplingGuarantee`.

## Actual guarantee

Inputs are rational masses p on an enumerated finite domain of length S,
with nonnegative values and `cumulative p S = 1`; a positive rational
epsilon; N Boolean assignment variables; and a family F giving a Boolean
event on atoms for every assignment in `Fin N -> Bool`. These can be
instantiated with formula acceptance events. Define:

```text
roundedLaw p S b i = FiniteSampling.mass p (2^b) i.val
originalMean p S f = (FiniteSampling.eventMass p S f : Real)
Good p S N M F eps draws =
  forall x, abs(empirical (F x restricted to Fin S) M draws
                - originalMean p S (F x)) < eps/4
precision S eps = Nat.clog 2 (Nat.ceil (8*S/eps))
```

`finiteMean_eq_eventMass` connects the real indicator mean on `Fin S`
to the original rational event sum. `roundedLaw_nonneg` and
`roundedLaw_sum` discharge the concentration law's hypotheses.
`roundedMean_error` proves the epsilon/8 mean approximation from actual
cumulative rounding and the dyadic precision bound; it does not assume
the desired deterministic error. Values beyond S remain outside the law.

`seed_failure_bound` applies proved concentration to every assignment
and transports its failure event through the actual arbitrary-Prop
joint bit-array pushforward. `seed_success_bound` uses normalization and
the actual probability-complement identity. The result is a bound for
the true uniform input seeds of `sampleArray`, relative to the ORIGINAL
rational atom distribution, not only the rounded mean or an abstract
product law unconnected to a sampler.

`good_probability_of_threshold` and
`good_probability_of_learningThreshold` prove success at least 2/3 and
5/6 respectively for any qualifying M and dyadic precision b. The M>0
condition is derived from the positive threshold. No tail bound or
success probability is an input hypothesis.

Finally `precision_bound` proves the actual chosen dyadic grid meets
`8*S/eps <= 2^b`. `chosen_good_probability` sets b to this precision and
M to the reviewed least log-6 `SamplingThreshold.sampleCount`, proving
success at least 2/3. `chosen_learning_good_probability` uses the exact
log-12 `learningSampleCount` and proves success at least 5/6. All 2^N
assignments are covered simultaneously, including the single empty
assignment when N=0. The complement yields strict error below epsilon/4,
which also implies the manuscript's non-strict tolerance.

## Boundaries

The exact sample counts use mathematical real log/ceil definitions.
These semantic guarantees do not claim a machine computes their exact
real comparisons. A separate computable-count layer can instantiate the
general-M theorems after proving its natural/rational count exceeds the
threshold. That separate layer requires independent implementation and
review; its main-green draft alone is not accepted complete validation.

The rational precision definition is concrete, but no polynomial
bit-operation bound, support enumeration algorithm, encoded array/tape
bridge or total runtime is proved here. Finite sums over seeds and
noncomputable Good-event tests are probability analysis, not work that
the sampler must perform. Fixed L precedes the reduction machine and
polynomial; no uniform exponent over L is asserted.

Formula YES/NO promises, exception repair, rounded instance validity,
source NP-hardness, specialized PCP dependencies, asymptotic composition
and HN learning transfer remain separate. The 5/6 confidence theorem
reserves room for a separate 1/6 transfer error; it does not prove that
transfer. S3130 and S3126 are not closed by this increment.

## Verification and review

Pinned Lean 4.13.0, cached imports, one exclusive compiler at a time,
`LEAN_NUM_THREADS=1`, capacity checked above 512 MiB before each launch.
No cache download, cleanup, external-library restart or dependency build.
Scoped commands:

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/SamplingGuarantee.olean lean/PvNP/RealizableHardness/SamplingGuarantee.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/SamplingGuaranteeChecks.olean lean/PvNP/RealizableHardness/SamplingGuaranteeChecks.lean
```

Initial main session 35723 exited 1 on four local cast/rewrite/unfolding
issues; those were corrected and are not accepted kernel evidence.
Final main export session 6278 exited zero without output or warnings.
Checks export/profile evidence remains pending at this draft.

Compiler coordination then paused all new launches when independently
observed free capacity crossed below 512 MiB. This module's main was
already terminal; its Checks was still queued and was not launched.
Do not count the main-only state as a completed candidate or full audit.
No cleanup or download is authorized or performed by this increment.

Fresh independent proof-adversarial, complexity and non-claims review is
required after final green. Only an authorized local candidate commit
will be made; no push, publication or full-certification claim.

### Resumed validation: failed first Checks retained

After root independently verified recovered capacity, two immediate
launches used an incorrect working directory (file not found, then unknown
module prefix); neither checked this source. Correct repository-root
launch 56767 terminated with exit 1. Three example applications timed out
while comparing real rational literals with rational casts inside the
analytic count, and the explicit-count example needed the same cast
normalization. The 11 main profiles and three support profiles showed only
the standard three axioms; the four failed examples showed `sorryAx` from
elaboration failure and are explicitly rejected. This is not a green
Checks export. The example types were corrected to match the exact rational
casts, and the numeric example now normalizes the goal as well as its
bound. No heartbeat limit was raised and no main theorem was edited.
Corrected Checks validation remains pending; the compiler slot passed to
the queued pipeline author after actual terminal exit.

### Final successful author export

After the queued pipeline author completed its exports and the count
owner confirmed an authorized resource-stop terminal exit, corrected
SamplingGuarantee Checks session **83651 exited zero** without warnings.
All **18 profiles** printed exactly `propext`, `Classical.choice`,
`Quot.sound`; none contained `sorryAx` or a custom theorem axiom. The
unchanged main was already exported successfully in session **6278**.
The exact same repository-root commands above were used, pinned 4.13.0,
threads 1, cached dependencies, fresh capacity/native-process guards.
No main proof was weakened to resolve the example elaboration issue.

Final compiled working SHA256:

- Main: `d051a6fdf0eaf06696838e266a340d4616bf4b37dd3594f2015bfbec1b139b76`.
- Checks: `08effac99e531296d8361e56e4cadbf19b183d3a41a6a5fb77b7e9503f053b97`.

These successful terminal results supersede the historical pending and
failed draft statuses above. The candidate is now **author-build green**;
fresh independent three-lens review remains required. No self-review,
full-goal completion or public certification follows from this receipt.
