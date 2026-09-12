# Finite rational weight rounding: formal increment

2026-09-12; S3130, child of the active S3126 full-formalization goal.
Implementation candidate; fresh independent three-lens review remains pending.

## Source and ownership

This increment implements the finite construction in the public manuscript's
"Rational-weight control and learning transfer" section, lines 695-720.
Inspected manuscript SHA256:
`ff00997c8c243e88982c41b0b0e24faaaafe36cec6f1903824599dc242538686`;
source repository HEAD at handoff inspection:
`419736bb99fac4c6fb71e9fc12cd3bab66fe307a`.

Only two new Lean modules and this receipt are owned by this increment:

- `lean/PvNP/RealizableHardness/WeightRounding.lean`
- `lean/PvNP/RealizableHardness/WeightRoundingChecks.lean`
- this implementation receipt

The reviewed ExceptionRepair, Formula and Checks modules, shared Audit,
claims manifests, dependency ledger, review receipts, toolchain and package
pins are unchanged by this author. The prior proof-review role ended before
this implementation task; this author does not independently review this
new increment. Root must route fresh reviewers after build green.

## Actual construction and proved bounds

All names below are in `PvNP.RealizableHardness.WeightRounding`. Let N be
the finite variable cardinality, w positive rational weights summing to one,
and 0<t<=1. The definitions are concrete:

```text
D = dyadicScale N t = 2 ^ Nat.clog 2 (Nat.ceil (8*(N+1)/t))
a(v) = coordinate w D v = Nat.ceil (D*w(v))
A = denominator w D = sum_v a(v)
B = budgetNumerator w D t = min(A, Nat.ceil(D*t)+N)
w'(v) = roundedWeights w D v = a(v)/A
t' = roundedBudget w D t = B/A
```

Natural ceiling equals the integer upward rounding in this positive-input
domain. No chosen rounding coordinates or preservation contract is assumed.
The explicit floor-half gap uses natural division before rational coercion.

| Manuscript obligation | Actual theorem(s) |
|---|---|
| D is a positive least power of two above the rational threshold | `dyadicScale_pos`, `dyadicScale_lower`, `dyadicScale_least`; the power-of-two identity is the definition |
| D < 16(N+1)/t | `dyadicScale_upper` |
| D*w(v) <= a(v) < D*w(v)+1; a(v)>0 | `coordinate_lower`, `coordinate_upper`, `coordinate_pos` |
| D <= A <= D+N | `denominator_bounds` |
| Rounded weights positive and normalized | `roundedWeights_pos`, `roundedWeights_sum` |
| Clipped budget positive and at most one | `roundedBudget_valid` |
| Original YES assignments remain feasible | `rounding_complete`; the assignment and every indexed formula are unchanged |
| Rounded k-budget implies original weight < sigma*t when 0<=k<=sigma/2 | `rounding_budget_transfer` |
| Universal NO threshold unchanged at floor(sigma/2) | `rounding_sound` |
| Formula-level combined validity, numeric bound and YES/NO preservation | `formula_rounding` |
| Natural numerators 1<=a(v)<=A, 1<=B<=A and exact common-denominator identities | `common_denominator` |
| Every multiple m*A gives actual integer coordinate/budget lengths | `integral_lengths` |
| Rounded weights and budget at least 1/A | `rounded_lower_bounds` |
| A < 16(N+1)/t+N | `dyadic_denominator_bound` |
| If 1/t<=P, then A<=16(N+1)P+N | `denominator_bound_of_inverse_budget` |
| If N<=n and 1/t<=(n+1)^k, then A<=17(n+1)^(k+1) | `polynomial_denominator_bound` |

The NO proof establishes B/D<=9t/8, then original assignment weight is at
most k*B/D<=9*sigma*t/16<sigma*t. It applies the actual original universal
NO promise to that assignment. It does not assume the desired rounded NO
claim or any source NP-hardness assertion. The local statement permits any
positive natural sigma; the manuscript's larger sigma is a specialization.

Clipping uses both inequalities independently: the selected integer weight
is bounded by A and by ceil(D*t)+N. Thus clipping is part of the YES proof,
not silently omitted. Formula satisfaction and leaf occurrences are preserved
because the formula family and assignments are literally unchanged. No
formula size or semantic property is replaced by a True-valued stub.

The reciprocal-budget premise in the numeric polynomial theorem is explicit.
This theorem does not prove that an earlier randomized reduction supplies
that premise; the cross-module instantiation remains an obligation.

## Verification

Pinned Lean 4.13.0, existing mathlib v4.13.0 exports. Commands are scoped
direct elaboration/export, with no umbrella or dependency rebuild:

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/WeightRounding.olean lean/PvNP/RealizableHardness/WeightRounding.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/WeightRoundingChecks.olean lean/PvNP/RealizableHardness/WeightRoundingChecks.lean
```

Both final commands exited zero without warnings. All 25 audited FQNs
depend only on `propext`, `Classical.choice`, and `Quot.sound`. No
`sorryAx`, custom theorem axiom, or native-evaluation dependency appears.
Source inspection/search found no sorry/admit, new axiom declaration or
native_decide. Earlier failed example elaborations were fixed and were not
accepted as green evidence.

The audit module checks six concrete examples: fractional coordinates
43 and 86 from weights 1/3 and 2/3 at D=128; their denominator A=129 and
budget numerator B=45; the least dyadic scale 256 at N=1,t=1/16;
active clipping giving B=A=16; a nonempty YES example; and a nonempty NO
example with odd sigma=5 and exact floor-half factor two. No native
evaluation is used. The fractional-ceiling examples use explicit
`Nat.ceil_eq_iff` inequalities rather than trusting numerical evaluation.

The audit prints 25 FQNs: the 19 main results `coordinate_lower`,
`coordinate_upper`, `denominator_bounds`, `roundedWeights_pos`,
`roundedWeights_sum`, `roundedBudget_valid`, `rounding_complete`,
`rounding_budget_transfer`, `rounding_sound`, `dyadicScale_lower`,
`dyadicScale_least`, `dyadicScale_upper`, `common_denominator`,
`integral_lengths`, `dyadic_denominator_bound`,
`denominator_bound_of_inverse_budget`, `polynomial_denominator_bound`,
`rounded_lower_bounds`, `formula_rounding`, and the six example theorems
`fractional_coordinate_example`, `fractional_denominator_example`,
`dyadic_scale_example`, `clipped_budget_example`, `rounded_yes_example`,
`rounded_no_example`. Each FQN has the namespace prefix stated above.

Final compiled source SHA256 pins:

- WeightRounding.lean: `7060942e670044628284b864dca10d42c49fbc6fae3dc4bf1532a29a448ef863`.
- WeightRoundingChecks.lean: `f2a41e3853d98d13084f0d23c5ff9b052d0167235b23702d019eb76939639f82`.

## Closeout boundary

| Lens | Status |
|---|---|
| Main source kernel elaboration | GO |
| Final scoped examples/axiom audit | GO; six examples and 25 standard-foundation-only profiles |
| Proof-adversarial | Pending fresh root-routed review |
| Complexity | Pending fresh root-routed review |
| Non-claims | Pending fresh root-routed review |

This is a finite mathematical rounding increment, not an encoded
polynomial-time reduction or a full hardness certification. No machine
runtime, rational-arithmetic bit-cost bound, sampler, concentration theorem,
PCP interface, source hardness, asymptotic composition, or learning transfer
has been certified here. The concrete polynomial numeric bound is proved;
an encoded runtime and upstream inverse-budget bridge are separate work.
S3130 sampling and the full S3126 goal remain open. No push, release or
publication is performed by this increment.
