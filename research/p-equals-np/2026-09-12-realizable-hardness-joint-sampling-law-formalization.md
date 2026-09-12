# Joint binary sampling law: formal increment

2026-09-12. S3130 under the open full S3126 goal. Author `cdf_proof_review`, explicitly reassigned by root to implementation after independently reviewing the distinct inverse-CDF increment. This author cannot independently review these new modules.

## Construction and proof target

Read destination README and integrity ledger, planning three-lens protocol and manuscript sampling lines 647-693. Imports use the frozen inverse-CDF code at `d9f42bfef00ae3d9ebd217c33bfb30a2922493ae` and concentration code at `a72739e7b192035f9c37370189c1de1d5a811b5c`. No existing module is changed.

`SeedArray M b` is explicitly `Fin M -> (Fin b -> Fin 2)`: M blocks of b binary digits. `sampleArray` applies the actual inverse-CDF `bitSampler` to each indexed block, retaining indices and duplicate output atoms. No joint law or independence assumption is an input.

`arrayFibreEquiv` constructs the equivalence between a fibre of this coordinatewise map and the dependent product of the single-coordinate fibres. Both inverse laws are proved. Fintype.card_pi gives the product of the actual fibre cardinalities. `bitFibreEquiv` explicitly reindexes one block through the positional binary equivalence to its inverse-CDF seed fibre; the existing proved CDF fibre count gives its actual atom probability. Multiplying these ratios proves `array_fibre_probability` equals the previously defined rational `trialMass` of rounded masses.

`sampleArray_event_law` sums over fibres of the actual array map. It proves the pushforward identity for every Boolean event on the entire output array, not only cylinder or rectangular events. `seedProbability` is a real finite uniform-seed sum for arbitrary Prop events. `sampleArray_probability` casts the rational identity and directly equates that seed probability to the actual `FiniteConcentration.probability` API. This is the previously missing seed-array-to-product-law bridge.

The general statements allow M=0 and b=0. Their seed domains remain nonempty: no draws gives one empty array and a zero-bit block has one input. Normalization still requires S>0 through the imported CDF construction. Zero atoms are permitted and handled through empty fibres; no strictly-positive-atom or injectivity hypothesis is added.

## Claims boundary

This is exact finite-distribution semantics, not encoded polynomial-time certification. The actual array function does not enumerate its fibres or all seed arrays; those are proof objects used to establish its law. The underlying atom representation, support enumeration, rational arithmetic, encoded iteration and input-size/runtime bounds remain separate. Noncomputable real probability and arbitrary Prop events are mathematical analysis, not executable event tests.

The bridge enables concentration transfer, but this module does not yet instantiate mean approximation, choose a sample count, prove the complete successful list's YES/NO promises, or compose exception repair and weight rounding. Both base and learning confidence budgets remain for subsequent assembly. No full S3130, reduction, PCP, hardness or learning theorem is certified here. S3126 remains open. No push, release, submission or novelty claim.

## Verification

Pinned Lean 4.13.0 with cached imports; no dependency build or toolchain change. Actual main export session 78629 exited zero without warnings after repairing initial Unicode transport and local cast-normalization errors. Those failed runs are not verification evidence. Final Checks export session 46802 exited zero without warnings and printed 11 profiles, each exactly [propext, Classical.choice, Quot.sound]. No sorryAx, custom axiom or native-evaluation dependency remains.

Fresh independent proof-adversarial, complexity and non-claims review is required before bounded closeout. Own only JointSamplingLaw.lean, JointSamplingLawChecks.lean and this receipt.


Exact commands:

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/JointSamplingLaw.olean lean/PvNP/RealizableHardness/JointSamplingLaw.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/JointSamplingLawChecks.olean lean/PvNP/RealizableHardness/JointSamplingLawChecks.lean
```

Compiled working SHA256:

- `lean/PvNP/RealizableHardness/JointSamplingLaw.lean`: `9fa34f18df84710816148738fb8c553e05207ff48524b0db3866d490e5a9e32f`.
- `lean/PvNP/RealizableHardness/JointSamplingLawChecks.lean`: `f0147de48192b3748b723978ecb4ec71ed98bdbe76403192807fa5a075039829`.

All 11 audited names are under `PvNP.RealizableHardness.JointSamplingLaw`: array_fibre_card, bit_fibre_probability, array_fibre_probability, sampleArray_event_law, sampleArray_probability, half_nonneg, half_normalized, half_mass, two_trial_diagonal, zero_atom_joint, concrete_real_event_bridge.

The concrete distribution has masses (1/2,1/2,0) and uses one-bit blocks. The nonrectangular two-trial equality event has probability exactly 1/2, proved by the joint law and explicit finite reindexing to pairs. Any output array whose first coordinate is the zero atom has probability zero. A separate real-event example instantiates the exact concentration API equality. Earlier failing example elaboration emitted a diagnostic sorryAx; only the final successful export with all standard profiles is accepted evidence.

| Lens | Status |
|---|---|
| Author scoped exports and 11 profiles | GO |
| Independent proof-adversarial | Pending root routing |
| Independent complexity | Pending root routing |
| Independent non-claims | Pending root routing |
