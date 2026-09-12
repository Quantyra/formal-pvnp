# Seed encoding proof-adversarial review

2026-09-12. S3131 / S3126. Independent top-level proof reviewer.

Verdict: **GO-WITH-NOTES**, limited to the finite seed equivalence, uniform event laws, and fixed suffix padding. No blocking proof, vacuity, or hypothesis issue found. This does not close S3131 or certify the full hardness proof.

## Frozen candidate and independent verification

Candidate: `e629518767cf00e54462abb2c1c7329ecd679187` (exact two source files and author receipt). Inspected actual source, upstream JointSamplingLaw, mathlib finite equivalences, S3131, the three-lens protocol, and INTEGRITY-CLAIMS.md. No root AGENTS.md exists in this satellite.

Working-file SHA256:

- SeedEncoding.lean: `6c4b145869109b08df7ec0d466c4001f5a14537b715e61f3731dc7056c705ad8`
- SeedEncodingChecks.lean: `7f09856c5816c4731e46bdc45cbe1a1ad38922fecf1a2047ef5c77f8ce55cb28`

Actual pinned toolchain: Lean 4.13.0; mathlib `d7317655e2826dc1f1de9a0c138db2775c4bb841`. With exclusive compiler authorization, no live Lean/Lake/elan before launch, more than 7.13 GB free, and LEAN_NUM_THREADS=1, independently executed:

```powershell
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/SeedEncoding.olean lean/PvNP/RealizableHardness/SeedEncoding.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/SeedEncodingChecks.olean lean/PvNP/RealizableHardness/SeedEncodingChecks.lean
```

Main session63414 actual exit0, no diagnostics. Checks session36123 actual exit0. Both observed through terminal completion; no restart, source edit, dependency download, or resource stop. Compiler released explicitly to root after both terminal results; final native check empty, free capacity approximately 7.130 GB.

Actual evaluations:

```text
[false, true, false, true, false, true]
[false, false, true]
```

All 25 printed axiom profiles observed. `split_join` and `join_split` use exactly `[propext, Quot.sound]`; the remaining 23 use exactly `[propext, Classical.choice, Quot.sound]`. No sorryAx, custom theorem axiom, or native decision axiom. Source scan found no sorry/admit/native_decide/new axiom or option override.

Audited profile names in namespace `PvNP.RealizableHardness.SeedEncoding`:

```text
unflatten_flatten flatten_unflatten split_join join_split
event_card_equiv uniformProbability_equiv uniformProbability_eq_sum
seedProbability_eq_uniform flat_event_card flat_probability
sampleFlat_probability prefix_fibre_card prefix_event_card
prefix_probability padded_sampleFlat_probability
zero_trials_inverse zero_width_inverse zero_trials_flat_inverse
zero_width_flat_inverse empty_seed_card row_major_example
padding_example no_padding_example empty_prefix_example diagonal_padded_law
```

## Adversarial findings

1. Flattening and unflattening are concrete computable definitions, with both inverse equations universally quantified over M and b. Mathlib finProdFinEquiv sends (i,j) to j+b*i, and finTwoEquiv sends 0 to false and 1 to true. The concrete row-major check agrees. Zero trials and zero width do not require division by a positive width in an inhabited domain; both inverse directions and the singleton empty seed are checked.
2. splitBits selects Fin.castAdd and Fin.natAdd coordinates, and joinBits uses the inverse finite-sum equivalence. Both full inverse laws are proved. The prefix fibre has an explicit inverse by appending any suffix; its cardinality is exactly 2^k, including k=0 and n=0.
3. Arbitrary Prop events are transported by explicit subtype equivalences. The generic uniformProbability definition also admits empty finite types (where total division gives zero); no false normalization-on-empty assertion is made. Actual Boolean seed and block-seed domains always have positive cardinality, including zero length. Padding cancels the nonzero real factor 2^k explicitly.
4. Prefix event cardinality is derived from its bijection with the product of the prefix-event subtype and all suffixes. No independence or rectangular-event hypothesis is supplied. The diagonal two-sample equality check exercises a nonrectangular event.
5. sampleFlat is definitionally the existing inverse-CDF sampleArray applied to unflattened bits. Its probability theorem retains exact cumulative rational normalization and nonnegative weights and invokes the actual established sampleArray_probability theorem. It does not replace this sampler with a distribution supplied as a premise. Padded sampling composes two proved event identities.

## Scope notes

The event probability is noncomputable mathematical bookkeeping; the seed maps themselves are executable definitions. Executability is not a Turing-machine implementation or polynomial runtime theorem. This module does not prove polynomial M*b, a polynomial envelope for input-dependent padding, actual output-tape encoding, malformed-input behavior, randomized reduction composition, specialized PCP/geometry/decoder results, or the learning corollary. The existing Lean 4.34 companion has not been independently compiled by this review. Full certification and paper reconciliation remain open.

Only this review receipt was written. No proof source, package, companion, Git index, release, or publication was changed. The other two review lenses remain independently required.
