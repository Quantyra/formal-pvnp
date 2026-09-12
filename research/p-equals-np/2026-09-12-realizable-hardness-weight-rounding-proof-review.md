# Weight rounding: independent proof-adversarial review

2026-09-12; S3130 under the active S3126 goal.

**Verdict: GO for the bounded finite weight-rounding increment.** No actionable
proof error, missing hypothesis for an asserted conclusion, circular premise,
or high-severity vacuity was found. This is not full hardness, runtime,
sampling, PCP or learning certification.

## Reviewed pin and independence

Reviewed commit `332c92893aef751fd739d646a1b127f2be34a92a`. Read all of
`WeightRounding.lean`, `WeightRoundingChecks.lean`, their implementation
receipt, and manuscript lines 695-720. The manuscript SHA256 is
`ff00997c8c243e88982c41b0b0e24faaaafe36cec6f1903824599dc242538686`.
Inspected the actual local Formula/ExceptionRepair definitions of evaluation,
weight and indexed average, and the mathlib ceiling-logarithm results used
by the dyadic proof. Read the pinned toolchain/package configuration,
`INTEGRITY-CLAIMS.md`, and planning's formal three-lens protocol. No destination
AGENTS.md was found. This independent top-level AI reviewer did not author
this increment; this is not human peer review or novelty certification.

Both compiled working files and committed Git bytes have these exact SHA256
pins, matching the author receipt:

| Source | SHA256 |
|---|---|
| `lean/PvNP/RealizableHardness/WeightRounding.lean` | `7060942e670044628284b864dca10d42c49fbc6fae3dc4bf1532a29a448ef863` |
| `lean/PvNP/RealizableHardness/WeightRoundingChecks.lean` | `f2a41e3853d98d13084f0d23c5ff9b052d0167235b23702d019eb76939639f82` |

## Statement and proof inspection

- Lines 9-34 define actual natural ceilings of rational scaled coordinates.
  `coordinate_lower` is unconditional; the strict upper bound correctly
  requires nonnegative old weights, and positivity uses positive weights
  and positive D. Natural ceiling agrees with the manuscript's integer
  upward rounding in this domain.
- Lines 40-117 prove lower/upper selected integer-weight bounds, the bound
  by the full integer denominator, D <= A <= D+N, positive normalized
  rounded weights, and a positive clipped budget at most one. The old sum
  equal to one excludes empty-variable normalization vacuity in the
  combined construction. Denominator positivity is proved before it is
  canceled in the nondegenerate results.
- `rounding_complete` (line 119) proves both bounds needed by the minimum
  defining B: selected integer cost is at most A and at most ceil(D*t)+N.
  It therefore retains active clipping in the YES argument. Its broader
  allowance of D=0 is harmless; `formula_rounding` uses positive dyadic D.
- `budgetNumerator_div_bound` and `rounding_budget_transfer` (lines 142-179)
  use D >= 8(N+1)/t and t>0 to obtain B/D <= 9t/8. After canceling positive
  A, the upward-coordinate bound gives old weight <= k*B/D. With
  0<=k<=sig/2 and sig*t>0 this is strictly below sig*t, since 9/16<1.
  No strictness is lost at equality in a ceiling or at a budget endpoint.
- `rounding_sound` (line 182) applies the actual universal old NO promise
  to that same arbitrary assignment. The new factor is natural `sig / 2`
  before rational coercion; `Nat.cast_div_le` provides the floor-half bound.
  The old acceptance threshold and formula family are unchanged. The
  hypothesis is the original NO condition, not the desired rounded result.
- `dyadicScale_lower`, `dyadicScale_least`, and `dyadicScale_upper`
  (lines 202-233) establish the least power of two above the rational
  threshold, not just an unspecified sufficiently large integer. The upper
  bound uses 0<t<=1 to place the threshold above one; the predecessor power
  is strictly below that rational threshold via the natural-ceiling
  equivalence. Consequently D<16(N+1)/t also holds when the threshold is
  itself exactly a power of two.
- `common_denominator` and `integral_lengths` (lines 236-271) prove positive
  bounded natural numerators and exact rational multiplication identities
  for every coordinate and the clipped budget. The common denominator is
  explicitly A, not an assumed divisibility field or an unspecified LCM.
  Allowing the length multiplier m=0 does not invalidate the identity;
  applications requiring positive lengths must choose m>0.
- `dyadic_denominator_bound`, `denominator_bound_of_inverse_budget`, and
  `polynomial_denominator_bound` (lines 274-317) prove numerical magnitude
  bounds, culminating in A <= 17(n+1)^(k+1) under the explicit cardinality
  and reciprocal-budget premises. They do not assume A's desired bound,
  and do not claim that earlier modules already supply those premises.
- `rounded_lower_bounds` and `formula_rounding` (lines 320-355) connect
  positive integer numerators, normalized valid weights/budget, the numeric
  denominator estimate, YES feasibility and universal NO preservation.
  Keeping the same indexed Formula family and assignments preserves its
  genuine evaluation and leaf counts without an additional syntactic map.

The local soundness statement permits sig=1, with floor-half zero, and any
finite formula index type. This is a valid more general implication, not an
assertion that these choices satisfy the final promise-problem domain.
The manuscript specialization has its stronger gap/domain assumptions.

The six check theorems exercise fractional upward rounding (43 and 86),
their nontrivial denominator 129 and budget numerator 45, a least dyadic
scale 256, active clipping, and nonempty YES and odd-gap NO examples. The
NO example uses sig=5 and exact floor-half two. Its all-false assignment is
admissible; its true assignment is excluded by the displayed positive
budget, so the example is not merely an empty admissible set. The fractional
ceilings are proved using inequalities, with no native evaluation.

## Independent kernel verification

Ran these exact commands sequentially; both exited zero without warnings:

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/WeightRounding.olean lean/PvNP/RealizableHardness/WeightRounding.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/WeightRoundingChecks.olean lean/PvNP/RealizableHardness/WeightRoundingChecks.lean
```

The second command uses the freshly exported first module. This is actual
scoped elaboration/export on the pinned Lean 4.13.0 and existing mathlib
v4.13.0 dependencies, not a clean-room rebuild of the dependency graph.

Independently observed all 25 `#print axioms` profiles. Each of the following
names, with prefix `PvNP.RealizableHardness.WeightRounding.`, reports exactly
`propext`, `Classical.choice`, and `Quot.sound`:

```text
coordinate_lower
coordinate_upper
denominator_bounds
roundedWeights_pos
roundedWeights_sum
roundedBudget_valid
rounding_complete
rounding_budget_transfer
rounding_sound
dyadicScale_lower
dyadicScale_least
dyadicScale_upper
common_denominator
integral_lengths
dyadic_denominator_bound
denominator_bound_of_inverse_budget
polynomial_denominator_bound
rounded_lower_bounds
formula_rounding
fractional_coordinate_example
fractional_denominator_example
dyadic_scale_example
clipped_budget_example
rounded_yes_example
rounded_no_example
```

Full source reading and scoped search found no proof placeholders, new theorem
axioms or native_decide. The inspected local import chain uses the genuine
finite weight/formula development, not the umbrella's complexity stubs.

## Findings and boundary

Actionable findings: none. Accept this finite mathematical construction
subject to the other two independently assigned lenses. Preserve the
implementation receipt's limits: encoded runtime and rational-arithmetic
bit cost, the upstream inverse-budget instantiation, finite sampling,
specialized PCP, source NP-hardness, asymptotic composition and learning
transfer remain separate obligations. S3130's sampling work and full S3126
remain open. This reviewer changed only this note and the authorized
generated local module exports; no Lean source, shared documentation,
dependency, commit, remote or release was changed.
