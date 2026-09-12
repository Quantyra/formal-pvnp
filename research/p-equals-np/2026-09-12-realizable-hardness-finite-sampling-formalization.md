# Finite sampling: cumulative rounding and product-law increment

2026-09-12. S3130 under full proof-and-paper S3126. Implementation author is `rounding_complexity_review`, explicitly reassigned after completing its independent review of the preceding, distinct weight-rounding increment. This author must not independently review these new sampling modules.

## Scope and source

Source: `realizable-cmmsa-hardness/MANUSCRIPT.md`, lines 647-693, SHA256 `ff00997c8c243e88982c41b0b0e24faaaafe36cec6f1903824599dc242538686`. Read the full Lean dependency ledger and the destination integrity ledger. No AGENTS.md is present in this satellite; planning routing and delegated ownership apply.

Owned files only:

- `lean/PvNP/RealizableHardness/FiniteSampling.lean`
- `lean/PvNP/RealizableHardness/FiniteSamplingChecks.lean`
- this receipt

Existing reviewed repair/rounding modules, shared audits, toolchain, manifests and others' evidence remain untouched. No public push or release.

## Proved construction

Namespace: `PvNP.RealizableHardness.FiniteSampling`.

For nonnegative rational atom masses p indexed by naturals, an enumerated support length S, and a positive integer grid D:

```text
cumulative p j = sum (i < j) p(i)
cut p D j = floor_nat(D * cumulative p j)
roundedCumulative p D j = cut(p,D,j)/D
mass p D i = roundedCumulative(p,D,i+1)-roundedCumulative(p,D,i)
```

The atom enumeration can extend by zero after S; normalization assumes the actual cumulative sum at S equals one. Nonnegativity of all p(i) is explicit, not a source hardness premise.

| Actual theorem | What is established |
|---|---|
| `cumulative_error` | Every cumulative rounding error lies in [0,1/D). |
| `cut_mono`, `mass_nonneg` | Rounded cumulative cuts are ordered and masses are nonnegative. |
| `mass_error` | Absolute atom error is at most 1/D. |
| `mass_sum` | The rounded masses over the S atoms sum to one, by telescoping and exact endpoints. |
| `event_error` | Every Boolean event has probability error at most S/D. |
| `event_error_of_precision` | For D=2^b and 8S/eps<=2^b, every event error is at most eps/8. This is the event-wise statistical-distance guarantee. |
| `trialMass_nonneg`, `trialMass_sum` | The explicit product mass over indexed M-tuples is a normalized finite probability law when its one-trial mass is. |
| `trial_event_factorization` | Every coordinate-cylinder event factors exactly as the product of its marginal event masses under this concrete law, proving independence algebraically. |
| `assignment_count` | Actual Boolean assignments `Fin N -> Bool` number exactly 2^N. |
| `listSampler_exact` | Uniform b binary digits sample an arbitrary materialized indexed list of size 2^b exactly, including repeated entries. |

`listSampler` uses mathlib's explicit `finFunctionFinEquiv`, whose forward map is the positional sum of binary digits and whose inverse extracts digits by division/modulo. It is not an unspecified uniform-sampling oracle. Digits have type Fin 2. The probability identity is exact for every Boolean event on entries.

Product independence is a theorem about the defined mass function, not an assumed independence field. The theorem that factors cylinders is an algebraic identity valid even before positivity/normalization; the separate product-law lemmas supply those conditions.

## Actual reuse and missing concentration proof

Pinned Lean 4.13.0 and mathlib v4.13.0. All added imports are available in the existing cache. Search in the pinned Probability sources found no Hoeffding theorem. `Mathlib.Probability.Moments` supplies actual `ProbabilityTheory.measure_ge_le_exp_mul_mgf`, its lower-tail analogue, and `iIndepFun.mgf_sum`, but these do not by themselves discharge the required bounded Bernoulli MGF estimate or final concentration theorem.

The necessary centered Bernoulli bound is being implemented independently in a distinct module by another author:

```text
0 <= p <= 1 -> (1-p)*exp(-t*p)+p*exp(t*(1-p)) <= exp(t^2/8).
```

It is pending at this increment and is not declared as an axiom, argument, typeclass field or accepted concentration result here. The full concentration work remains required.

## Verification

Scoped commands (no umbrella or dependency rebuild):

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/FiniteSampling.olean lean/PvNP/RealizableHardness/FiniteSampling.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/FiniteSamplingChecks.olean lean/PvNP/RealizableHardness/FiniteSamplingChecks.lean
```

Final results and source hashes are recorded below after both final exports succeed. Earlier attempts exposed an accidental UTF-8 BOM, a missing product-nonnegativity import, and an example rewrite requiring explicit arguments. Those failed attempts are not accepted kernel evidence.

## Remaining required work and review boundary

This is a cohesive first finite-sampling increment, **not completion of S3130 or S3126**. In particular:

- Realize the cumulative rounded mass law by a concrete bounded-bit inverse-CDF sampler and prove that sampler's law. The rounded distribution itself is constructed and proved here; `listSampler_exact` addresses the later materialized uniform list, not this earlier inverse-CDF step.
- Prove the actual Bernoulli concentration theorem, compose product sampling, and take a union bound over the actual 2^N assignment family.
- Construct the least power-of-two M meeting `(N*ln 2+ln 6)/(2*(eps/8)^2)` and prove the failure probability at most 1/3, including the distribution approximation in the final eps/4 error.
- Derive the manuscript YES/NO bounds and compose with actual exception repair and weight rounding.
- Prove encoded enumeration, rational arithmetic, bounded coins, input/output size and total runtime. Finite probability and numeric precision conditions do not establish polynomial time. Fixed L constants must remain independent of varying input size N.

No full PCP, NP-hardness, learning transfer or end-to-end randomized reduction certificate is asserted. All three independent review lenses were pending at implementation handoff; their completed outcomes are recorded below.

## Final scoped build evidence

Both final scoped commands exited zero with no warnings. Main export session 13097; final Checks export session 62938. Checks prints 19 FQNs (11 main results and eight concrete example/support results); all depend only on propext, Classical.choice and Quot.sound. No sorryAx or native-evaluation dependency occurs. Concrete checks include fractional thirds rounded at grid eight, a normalized two-atom rounded distribution, arbitrary-event eps/8 precision, a two-trial probability 1/9, and exact one-bit sampling probability 1/2.

Final compiled working source SHA256:

- FiniteSampling.lean: 817347b74cd9f0ad17b5249fcbd03444e9927c492c7e54b5b8e127cf1112b7a6.
- FiniteSamplingChecks.lean: 9281576cae367164b01ec09649245ab7e3d91b17e51c531e5be591661a56461b.

The main module's working bytes use CRLF. Its committed LF SHA256 at
`62064d9e9699c0337563a31ea205f6e5195fcbc2` is
`7b1cf53b512e705d08d4eb20a1db69b4015d5fb561f5495e11316c0cfc49ab57`.
Replacing CRLF by LF gives exactly the committed bytes, with no semantic
or text change. Checks has the same working and committed SHA256 above.

## Final independent three-lens closeout

The exact frozen sampling candidate
`62064d9e9699c0337563a31ea205f6e5195fcbc2` now has all required independent
root-routed AI reviews. Neither Lean source changed during integration.

| Lens | Actual verdict | Evidence |
|---|---|---|
| Scoped kernel build / axiom audit | GO | Author builds above; independent proof reviewer reran both scoped exports successfully and observed all 19 standard-foundation-only profiles |
| Proof-adversarial | GO | [Independent proof review](2026-09-12-realizable-hardness-finite-sampling-proof-review.md); main session 26329 and Checks session 46545 both exited zero |
| Complexity | GO-WITH-NOTES | [Independent complexity review](2026-09-12-realizable-hardness-finite-sampling-complexity-review.md) |
| Non-claims | GO-WITH-NOTES | [Independent non-claims review](2026-09-12-realizable-hardness-finite-sampling-nonclaims-review.md) |

No blocking source correction was requested. This accepts only cumulative
dyadic rounding, the finite product law and cylinder factorization, actual
assignment cardinality, and exact sampling from a materialized uniform
power-of-two list. The two GO-WITH-NOTES lenses retain these obligations:

- Construct the bounded-bit inverse-CDF sampler and prove its law; the
  already proved uniform list sampler has a separate later role.
- Connect the centered Bernoulli analytic bound to empirical concentration,
  union over the full assignment family, choose the least power-of-two M,
  and prove the final error/failure and YES/NO composition guarantees.
- Supply normalization and nonnegative masses for probability statements,
  retain indexed multiplicity, and instantiate the upstream finite support
  and precision bounds. Do not treat an all-draw sum as an algorithm.
- Certify encoded enumeration, rational arithmetic, coin and output lengths,
  and total runtime for each fixed L; do not allow fixed parameters to vary
  with input length or infer a uniform polynomial exponent across L.

The Bernoulli-bound paragraph above describes this candidate's handoff;
separate later analytic work does not itself complete the concentration
composition. Full S3130 and S3126 remain open. These AI reviews are not human
peer review or novelty certification. This closeout changes only three
sampling review notes and this receipt, with no code, shared-ledger,
remote, release or public-metadata change.
