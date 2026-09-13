# Finite source sampler: independent complexity review

2026-09-12. Reviewer `/root/rounding_independent_proof`, not a sampler author. S3130/S3131/S3137 under S3126. Source freeze `0ceef848a6adc88f85fa016c34243a4f7d397cb4`. **GO-WITH-NOTES** for the finite-table interface and exact semantic identities. No full reduction, FP or source-hardness certification follows.

## Evidence and independence

I inspected the complete FiniteSourceSampler and Checks files, their author receipt and superseding appendix, and the actual InverseCDFSampler and JointSamplingLaw definitions and probability theorems. Current source hashes are `239ddc6e4fc2171c2882b4d5e753b0306103b6de20a6635ebaa08b7b12add4e1` and `f21930d459c1fa38456b90b45220bda73fccd1506f2abce7a305661362335893`; their normalized bytes match the freeze. I previously prepared thirteen original dependency exports and verified ten author portable artifacts without launching a compiler. A different reviewer owns independent proof compilation. This document is a source complexity lens, not a second proof-build claim.

## What the interface establishes

The probability and formula inputs are explicit ordered rows, each a rational and a Formula (Fin N). ValidRows requires a nonempty list, nonnegative masses and an exact finite sum of one. Those conditions are decidable on the stored data. There is no arbitrary probability or formula function stored as an input oracle, nor a desired sampler output or final-equality certificate. The derived probability extension is zero outside the stored support; its normalization theorem discharges the original selector's endpoint premise. The formula fallback uses the first actual row, and the selector returns an in-support index.

The exact table and seed identities are pointwise: selectBits is the existing bitSampler, selectArray is the existing sampleArray, and selected is List.ofFn of the existing fromSeeds result for these same derived functions and the same seed array. They establish equality of execution outputs without assuming the final identity. They do not themselves postulate a random seed law or generate random bits.

## Rounded law versus original masses

For cumulative mass C_j and D = 2^b, the cuts are floor(D*C_j). Under uniform b-bit seeds, the probability of row j is exactly

    (floor(D*C_(j+1)) - floor(D*C_j)) / D.

It need not equal the stored rational mass. This follows from the inspected existing fibre_probability and bitSampler_event_law, which can be instantiated using the table endpoint and nonnegativity lemmas. The new module identifies their concrete execution path; it does not add an exact-original-mass theorem. Original-mass approximation still needs the existing grid precision hypothesis and its downstream error accounting. The imported bitSampler_event_error requires positive eps and 8*S/eps <= 2^b to conclude event error <= eps/8.

Zero-mass atoms always have equal adjacent cuts and are never selected, as proved in select_not_zero_mass. The converse is false: a positive atom can also have equal cuts on a coarse grid. For example, ordered masses 1/4 and 3/4 with b = 1 have cuts 0, 0, 2; the first positive atom is never selected. This arithmetic illustration is not claimed as an additional Lean example. No theorem in this pair asserts positive atoms always remain reachable.

The seed-array type is a finite product; merely supplying an element does not imply independence or uniformity. The existing sampleArray_event_law explicitly averages over the entire uniform product seed space and then proves the product law for rounded row masses, including arbitrary joint events. Repeating a single supplied block in every coordinate can give correlated or identical outcomes; selected_length still correctly says there are M trial positions. Any algorithmic probability claim must use the appropriate uniform seed experiment and its actual coin count, not infer independence from the type alone.

## Edge cases and representation boundary

Duplicate formulas retain distinct row indices and their own masses; selected may repeat formulas or indices and preserves trial order and count. No deduplication is smuggled into the source distribution. Equal formulas can of course merge under a formula-valued event, but row-level and formula-level probabilities should be related by the appropriate pushforward.

Zero masses are permitted, an empty table is rejected, and zero trials yield an empty result. For D = 0 there is no seed in Fin D; bit sampling always uses positive D = 2^b. The zero-bit case has a one-point seed space and is deterministic, with no approximation promise. selectRaw validates the length of a List (Fin 2). Binary digit validity and formula variable bounds are already built into typed inputs. It is not a byte parser for arbitrary malformed digits, rationals, formulas or source tables.

## Complexity obligations still open

Nat.find searches for the first strict crossing, and the existing endpoint proof places its result below the finite support size. This is useful termination/index evidence. It does not provide a machine-step count, certify the compiled search implementation, or account for cumulative rational sums, comparisons, denominator growth, indexing, normalization validation or bit conversion. The present module contains no FP membership or polynomial-time construction theorem.

Even finite-list computability does not prove that the outer source table can be generated in polynomial time or has polynomial encoded length. A complete reduction still needs its actual binary input representation and parser, the specialized outer reduction producing the table, precision b and trial count M with valid input-size bounds, uniform coin accounting, complete per-seed formula/rounding/serialization integration, and FP proofs for those operations. Formula syntax can be arbitrarily large despite intrinsic variable bounds. The frozen pair proves neither a bound on that payload nor the total reduction output size.

No HIGH false-force, circular-output hypothesis or quantifier defect was found in the inspected bounded statements. The precision, distribution, typed-input and runtime limits above must remain explicit in downstream assembly and paper wording. Independent proof and non-claims reviews remain distinct gates; the full proof and submission package remain open.
