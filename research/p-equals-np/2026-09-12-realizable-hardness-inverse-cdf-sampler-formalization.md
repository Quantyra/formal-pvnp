# Inverse cumulative sampler: exact realization increment

2026-09-12. S3130 under full S3126. Author `sampling_proof_review`, reassigned to implementation after completing the distinct Bernoulli MGF review; this author cannot independently review these new modules. Actual scoped builds are green. Fresh three-lens review is complete for this bounded increment.

## Target and construction

Read the full Lean dependency ledger, destination integrity ledger, and the sampling argument in `../realizable-cmmsa-hardness/MANUSCRIPT.md`, lines 647-693, SHA256 `ff00997c8c243e88982c41b0b0e24faaaafe36cec6f1903824599dc242538686`. No destination AGENTS.md exists. This implements the earlier missing inverse-CDF realization using the frozen `FiniteSampling` cumulative-cut definitions at candidate `62064d9e9699c0337563a31ea205f6e5195fcbc2`.

For nonnegative rational atoms p with cumulative sum one at S, grid D and seed r in Fin D, the actual function `sampler` searches for the least j such that

```text
r < cut(p,D,j+1).
```

It uses decidable `Nat.find`, not choice of a function having a prescribed law. Endpoint normalization proves S>0 and cut(S)=D. The witness j=S-1 proves that the search terminates within the enumerated support, and the returned value has type Fin S. The construction itself requires only normalization; nonnegativity supplies ordered cuts and the exact law. The intended uniform-seed probability interpretation requires D>0. The finite-sum identities are valid more generally for empty Fin 0 as algebraic identities; binary grids 2^b are always positive.

The proved interval characterization is

```text
sampler(r)=i iff cut(i)<=r and r<cut(i+1).
```

The explicit `fibreEquiv` subtracts cut(i) from each seed in the fibre and adds cut(i) in the inverse direction. Its target is Fin(cut(i+1)-cut(i)), with both inverse laws proved. Consequently each fibre has exactly that cardinality, and its cardinality divided by D equals the actual `FiniteSampling.mass p D i`. Empty intervals handle zero-mass atoms without a special positive-atom assumption. The strict upper endpoint sends a boundary seed to the next nonempty interval.

## Exported proof bridge

Namespace `PvNP.RealizableHardness.InverseCDFSampler`:

| Export | Exact result |
|---|---|
| `support_pos`, `cut_endpoint`, `crossing_exists` | Normalization supplies a nonempty support, final cut D, and a bounded-search witness. |
| `sampler_interval`, `sampler_eq_iff` | Actual output belongs to exactly its cumulative-cut interval. |
| `fibre_card`, `fibre_probability` | Constructive interval equivalence gives the exact fibre count and rounded atom mass. |
| `sampler_event_law` | Uniform finite-seed average equals the rounded event mass for every Boolean event. |
| `bitSampler`, `bitSampler_event_law` | Actual b binary digits pass through positional `finFunctionFinEquiv` and the constructed sampler; every event has exactly the rounded law. |
| `bitSampler_event_error` | Under `8*S/eps <= 2^b`, eps>0, every event of that actual b-bit sampler differs from its original rational probability by at most eps/8. |

Event-law proof uses actual fibre sums and the proved fibre probabilities, not an assumed pushforward-law interface. The bit-seed proof reuses the previously reviewed exact positional reindexing theorem. It then invokes the proved cumulative-rounding event-error theorem. No sampling-law axiom is introduced.

## Actual scoped kernel verification

Unchanged pinned Lean 4.13.0 and cached mathlib imports. No dependency build or toolchain upgrade. Final commands:

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/InverseCDFSampler.olean lean/PvNP/RealizableHardness/InverseCDFSampler.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/InverseCDFSamplerChecks.olean lean/PvNP/RealizableHardness/InverseCDFSamplerChecks.lean
```

Main session **21881** exited **0**, without output or warnings. Checks session **26739** exited **0**, without warnings, and printed **18** axiom profiles, each exactly `[propext, Classical.choice, Quot.sound]`. No sorryAx or native-evaluation dependency remains. Earlier Unicode text-transport failure and local rewrite/example tactic failures were corrected before these final exports; those failed elaborations are not accepted evidence.

Audited FQNs, all under the namespace above: `support_pos`, `cut_endpoint`, `sampler_interval`, `sampler_eq_iff`, `fibre_card`, `fibre_probability`, `sampler_event_law`, `bitSampler_event_law`, `bitSampler_event_error`, `gapThirds_nonneg`, `gapThirds_normalized`, `gapThirds_cuts`, `first_seed_example`, `boundary_seed_example`, `final_seed_example`, `zero_atom_example`, `fractional_fibre_example`, `binary_precision_example`.

Concrete distribution is (1/3,0,2/3) on three atoms. Grid eight gives cuts (0,2,2,8); first seed zero reaches atom zero, boundary seed two skips the zero atom, and final seed seven reaches atom two. The zero atom has an empty fibre and the first atom has exactly two seeds. A separate arbitrary-event example uses eight binary digits with eps=1/8.

Final compiled working SHA256:

- `lean/PvNP/RealizableHardness/InverseCDFSampler.lean`: `866f96cbef6b045937cbedbfadc534176aa5376f81a3509205b30806352d2ed4`.
- `lean/PvNP/RealizableHardness/InverseCDFSamplerChecks.lean`: `c80b702ae6b568809da803747bd3cff4aae8c22095c5582ab54d75090116a0cd`.

## Remaining scope and review

This closes the previously missing local inverse-CDF law and bounded-bit semantic realization, with the independent reviews below. It does not itself certify an encoded polynomial-time machine: enumeration of the original support, rational arithmetic costs, encoding, choosing precision, and total runtime still require their computational proofs. Having an explicit terminating function and search bound is useful evidence, not a machine-level complexity certificate. Preserve fixed L before the reduction and its polynomial.

Finite-product concentration, sample-count threshold, the at-least-2/3 simultaneous guarantee, and composition with actual formula promises/repair/rounding are being implemented separately. No full sampling/reduction/PCP/hardness/learning-transfer theorem is asserted here. S3130 and S3126 remain open.

| Lens | Status |
|---|---|
| Author scoped kernel build and 18-profile audit | GO |
| Independent proof-adversarial (`cdf_proof_review`) | GO; independent exports 74394/25328 exit 0, all 18 profiles standard |
| Independent complexity (`repair_complexity_reviewer`) | GO-WITH-NOTES; encoded runtime and joint-law obligations remain explicit |
| Independent non-claims (`mgf_nonclaims_review`) | GO; exact single-draw scope |

Own only the two new InverseCDFSampler modules and this receipt. Frozen FiniteSampling, MGF and weight-rounding modules remain untouched, as do other agents' concentration/threshold work and shared records. Only a local candidate commit is prepared; no push, public release or full-certification claim.

The next assembly must also prove the actual joint bit-array pushforward equals the product trialMass law. The one-draw event law here does not by itself certify that multi-draw seed-to-product bridge. This remains explicit alongside threshold and final promise composition.

## Independent review integration

Frozen code candidate `d9f42bfef00ae3d9ebd217c33bfb30a2922493ae` is unchanged. Review receipts are the sibling `2026-09-12-realizable-hardness-inverse-cdf-sampler-proof-review.md`, `2026-09-12-realizable-hardness-inverse-cdf-sampler-complexity-review.md`, and `2026-09-12-realizable-hardness-inverse-cdf-sampler-nonclaims-review.md`. All three lenses actually ran; none is inferred from another. The proof lens independently reran both exact scoped exports and all 18 axiom profiles.

The main module working SHA256 above covers CRLF bytes. Its Git LF SHA256 is `8350e861d27d1f8c58148bf7656a1f2f467b38403819540eefd065cc6193dad6`; independent byte comparison confirms CRLF-to-LF normalization exactly matches the frozen blob. Checks is byte-identical in Git and working state. This evidence-only integration changes no Lean source and does not close S3130 or S3126.
