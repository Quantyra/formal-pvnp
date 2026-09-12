# S3130 joint sampling law: independent proof-adversarial review

2026-09-12. Top-level proof-adversarial lens assigned by root.
Candidate `3538058a63c08de4ed1f1304fc8353cd991bd471`.
**Verdict: GO for the scoped joint-law increment.** No blocking vacuity,
missing-hypothesis, cardinality, event-scope or statement defect found.
Full sampling composition and encoded runtime remain outside this verdict.

## Independence and frozen source evidence

Read both JointSamplingLaw modules and the complete implementation receipt.
This reviewer did not author them. Earlier authorship of the separate
SamplingThreshold module does not make this a review of that module;
JointSamplingLaw does not import it.

An empty diff against the candidate was verified for both sources and
`research/p-equals-np/2026-09-12-realizable-hardness-joint-sampling-law-formalization.md`.
Independently measured working SHA256 and committed Git blobs:

| File | Working SHA256 | Committed blob |
|---|---|---|
| `lean/PvNP/RealizableHardness/JointSamplingLaw.lean` | `9fa34f18df84710816148738fb8c553e05207ff48524b0db3866d490e5a9e32f` | `fa3644b5eb58b6e61859c817a528607a998c3c58` |
| `lean/PvNP/RealizableHardness/JointSamplingLawChecks.lean` | `f0147de48192b3748b723978ecb4ec71ed98bdbe76403192807fa5a075039829` | `57f83d101243909840286ed0e5134ff3a675ab40` |

## Independent kernel verification

Used the existing pinned Lean 4.13.0 environment and cached dependencies.
Ran only these two scoped exports, sequentially, with
`LEAN_NUM_THREADS=1`:

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/JointSamplingLaw.olean lean/PvNP/RealizableHardness/JointSamplingLaw.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/JointSamplingLawChecks.olean lean/PvNP/RealizableHardness/JointSamplingLawChecks.lean
```

Independent main session **77333 exited 0**, without output or warnings.
Independent Checks session **19467 exited 0**, without warnings. All
11 printed profiles are exactly `[propext, Classical.choice, Quot.sound]`:

```text
array_fibre_card, bit_fibre_probability, array_fibre_probability,
sampleArray_event_law, sampleArray_probability, half_nonneg,
half_normalized, half_mass, two_trial_diagonal, zero_atom_joint,
concrete_real_event_bridge
```

Each name has namespace `PvNP.RealizableHardness.JointSamplingLaw`.
No sorryAx, native-evaluation or custom axiom appears in these actual
profiles. Checks consumed the freshly exported main module. The real-event
bridge was therefore kernel-checked, not accepted solely from prose or
the earlier author's receipt.

Capacity was checked before each launch, above the 512 MiB guard:
728,375,296 bytes at initial inspection and 751,763,456 bytes before
Checks. Final reading was 1,010,139,136 bytes. Capacity-change causes are
not inferred. No download, cleanup, dependency rebuild, source edit or
external-library restart occurred. Both review processes are terminal.

## Adversarial statement checks

- The array map is actual coordinatewise inverse-CDF sampling on the
  explicit seed array. Its fibre equivalence contains the value and proof
  for every coordinate and reconstructs an array whose equality to x is
  proved by function extensionality. Both inverse laws hold. There is no
  assumed independent-law field or chosen map with a desired law.

- Cardinalities multiply over the actual coordinate fibres. The binary
  fibre equivalence uses the explicit positional bijection, and division
  by the full seed-array cardinality matches the product of single-block
  probabilities. This is the previously defined rounded `trialMass`, not
  a second distribution assigned the same name.

- Event-law quantifiers cover arbitrary Boolean events on the whole
  output array. Fibrewise summation does not restrict them to products of
  coordinate events. The Prop version uses classical decidability solely
  for mathematical events and explicitly casts the rational identity to
  the actual `FiniteConcentration.probability` definition. No arbitrary
  event oracle is part of `sampleArray`.

- For M=0 the domain is one empty array and the product mass is one;
  neither is an empty probability space. For b=0 every block has one
  zero-bit seed, so denominators remain positive. The typed support
  normalization enforces S>0. Zero atoms yield zero-length fibres and
  zero probability without any positivity or injectivity hypothesis.
  The tested diagonal event is nonrectangular and has probability 1/2;
  the zero-atom array test exercises a genuinely empty fibre.

The scoped law is not vacuous and closes the local joint-pushforward
obligation. It still does not instantiate the successful-list event,
sample-size confidence, formula YES/NO promises, repair/rounding, or
encoded iteration/runtime. Those are separate assembly obligations,
accurately left open in the receipt. This GO supports bounded closeout
after the other required lenses; it does not close S3130 or S3126.
