# Explicit finite source table sampler: source draft

2026-09-12. S3131/S3130 under S3126. **UNCOMPILED.** No compiler or axiom checks executed; no FP or full reduction claim.

Inspected FiniteSampling, InverseCDFSampler, JointSamplingLaw and SamplingFormulaPromises, including cumulative/cut, sampler/bitSampler, the first-crossing interval theorem, sampleArray and fromSeeds. The existing selector is already a computable def using Nat.find and a proved support endpoint. Consequently this draft reuses that selector and its CDF theory instead of implementing a duplicate search algorithm. The missing interface was an explicit finite source representation discharging its functional inputs and normalization premise.

## Concrete representation and operations

Table N stores an ordered list of pairs (rational probability, existing Formula (Fin N)). ValidRows is a computable predicate requiring positive list length, nonnegative coordinate masses and normalized finite mass sum. Zero masses are allowed and duplicate formulas remain separate atoms. readTable rejects invalid rows. Variable bounds are intrinsic to the existing finite Formula syntax. No arbitrary p or F function is a table field.

probability is the table's indexed finite extension, equal to the stored mass within support and zero outside. formula returns the stored formula within support and the first stored formula outside; that total fallback has probability zero and cannot be a sampled support index. The nonempty table proof supplies the fallback without an arbitrary external formula.

cumulative_endpoint derives the exact normalization required by the existing selector from the explicit table. cumulative_prefix identifies every in-support prefix sum with the stored coordinates. select reuses the actual first strict upper-cut crossing. select_interval exports its exact half-open interval, including equality at the lower cut. select_not_zero_mass proves a zero-probability row is never selected: its repeated cumulative cuts make the required interval empty. No assumption of strict positivity for every atom is introduced.

selectBits and selectArray use the existing positional finite seed interpretation. Their equalities identify the exact existing bitSampler and sampleArray for the table's derived extension. selected returns an actual List.ofFn of the selected stored formulas. selected_eq_fromSeeds identifies it with the ordered list produced by the existing fromSeeds interface for the same seeds; selected_length preserves the number of trial positions even when selected atoms or formulas repeat.

selectRaw accepts a List (Fin 2) only if its length equals b, otherwise returns none. selectRaw_ofFn gives exact compatibility with typed seed functions. Fin 2 intrinsically restricts digits to binary values; there is no malformed numeric digit inside this typed interface. This is a raw finite-list policy, not a binary-tape parser for a source table. The zero-bit case is allowed and corresponds to the existing one-point dyadic seed domain.

Sixteen axiom queries and eight examples are present but unrun: invalid empty table, zero extension, normalization, zero trials, incorrect raw seed length, zero-bit seed compatibility, zero-mass exclusion and repeated-trial occurrence count.

## Hashes

- FiniteSourceSampler.lean: `7a5c449ca365ce4d8fa2fde78ca158493c95c2d9b8709f4307b0b5c5cdb38df9`.
- FiniteSourceSamplerChecks.lean: `f21930d459c1fa38456b90b45220bda73fccd1506f2abce7a305661362335893`.

## Remaining boundary

Only these new source/Checks/receipt files were written in the satellite; no compiler, Git, package/configuration, accepted-source or public operations were performed. All source assertions await compilation and independent review. Dependent list indexing, sum reindexing, simplification and finite seed casts may need elaboration repairs.

The finite table eliminates input function oracles for selection. It does not serialize the table into a binary input tape, prove parser or selector FP runtime, bound rational numerator/denominator operation costs, or derive fixed-L output size and machine time. Nat.find's mathematical endpoint bound is not a verified Turing-machine time bound. The positional seed implementation is reused rather than given a new runtime certification.

The next integration must feed selected into the complete executable rounding/formula-output construction, connect to the existing semantic pipeline record and confidence events, and identify the actual encoded output tape with that record for every seed. ExecutableRounding and the codec integration remain separate pending increments. The source distribution itself must arise from the specialized outer reduction with the required encoded complexity bounds; a finite table alone does not establish that reduction or full hardness. Full proof/paper certification and eventual consolidation remain open.
