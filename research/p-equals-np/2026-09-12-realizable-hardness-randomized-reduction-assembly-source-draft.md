# Dynamic-prefix randomized machine composition: source draft

2026-09-12; S3131 under full S3126. **UNCOMPILED.** No author kernel results, axiom output, independent acceptance or full hardness claim. The preceding exact-interface audit remains separately preserved in commit `25ed651f6382d6476718d47b9db623e91e143846`.

New owned files are companion `RandomizedReductionAssembly.lean`, `RandomizedReductionAssemblyChecks.lean`, and this receipt. No accepted source, aggregate, toolchain or dependency was edited. No compiler, public action or nested delegation occurred. Separately authorized audit-only and ZoomOutPosterior draft-preservation commits were reported to root; these new assembly sources are not included in either commit.

## Concrete implemented scripts

The draft imports the existing UNCOMPILED RandomizedReduction machine bridge and the pinned Fin.take/List.ofFn API. Every theorem below has a full proof script; no sorry, admit, axiom or native_decide was introduced. Compilation may require API/elaboration repairs and is not inferred from source inspection.

`block_disintegration` derives the exact finite conditional average on one flat n+B-bit seed using the concrete block equivalence and rational eventProb. Its second predicate may depend on the first seed. `ofFn_prefix` invokes `Fin.ofFn_take_eq_take_ofFn`; `prefix_probability` cancels ignored suffix bits on each fixed first-seed fibre. `padded_success` identifies this finite prefix with the list actually taken by the second executor.

`execute_disintegration` consequently proves the exact identity from the audit: the actual nested-pair executor on the split uniform seed has success probability equal to the average, over first seeds u, of the second SeededMap's success probability on the actual first output y(u). The used prefix has length S.coinCount(|y(u)|), which may vary with u. It is not replaced by a fixed second predicate or an independently resampled deletion law.

`Padding R S` records a polynomial, its actual FP exact ruler, and the second-coin bound on every first seed of the scheduled length. `exists_padding` constructs this data from R's derived polynomial coin bound, the existing machine-backed `second_coin_padding` theorem, and Cobham.exists_exact_ruler. Thus the final construction does not assume its polynomial padding bound. Failed/out-of-promise first outputs are included in this bound.

The actual flat executor consumes pair(x,w). Its first block is a prefix selected by R's ruler on x; its second block is the suffix selected by the derived polynomial ruler, using reverse/take/reverse. FP membership follows from the existing take-length, reverse, pair/projection and composition machines. Its total coin ruler appends the first and second rulers, giving exact count R.coinCount(|x|)+B(|x|). The behavior on malformed or short strings remains the total behavior of the existing pair projections and list operations; no probability assertion is made for incorrectly scheduled seed lengths.

`flat_seed_execution` connects this very FP executor to the earlier nested executor on every correctly scheduled flat seed. `compose_probability` then connects its actual SeededMap.successProbability to the derived conditional average. The probability theorem is therefore attached to the constructed machine, not a standalone surrogate map.

`compose_success_lower` bounds the average using correctly promised first outputs; other outputs contribute nonnegative probability. It derives success at least 1-(e1+e2) from component success bounds. `compose_preserves` applies this separately to YES and NO sides of actual disjoint string PromiseProblems. These component guarantees are legitimate inputs to a closure theorem, not a declaration that a CMMSA reduction already satisfies them. A final 2/3 target still requires each accumulated side's error budget to be at most 1/3; no majority operation on output instances is assumed.

`scheduled_machine` extracts an actual halting TM with natural-polynomial raw-input clock from SeededMap.run_fp. It derives a polynomial bound on that clock measured against original |x| for every seed of the prescribed length, using exact pair length and the derived coin polynomial. `exists_composition` and `exists_preserving_composition` put the constructed map, its probability guarantees, polynomial coins and that actual TM/input-clock relation in the same existential package. The final clock is not a supplied hypothesis.

## Source inspection and planned verification

Pinned library APIs were inspected directly: EventProb's actual cardinality probability and block independence/disintegration; FiniteCounting.blockEquiv/blockFst/blockSnd; `Fin.ofFn_take_eq_take_ofFn`; `List.ofFn_add`; Cobham.takeLenFn_mem_FP, appendFn_mem_FP, exists_exact_ruler; reverse_mem_FP; the FP composition and polynomial-clock normal form; and TM.ComputesInTime's actual reachesIn/halting/output definition.

Checks request **18** axiom profiles and contain **10** examples, all UNRUN. They cover zero/full prefix widths, ignored suffix transport, zero first width, a first output that changes the second required length, an ignored padding bit, malformed input, a short supplied seed, and the actual composite FP field. They do not replace independent kernel verification.

Working source SHA256:

- main: `edcfc46cbd4bd4b580f591a85e7bd6ce6bf94b3c4f9d47552bfa6f9e303da8f4` (254 lines).
- Checks: `05e98f33f401695d500d1302c96ca47c3238b13d18417a35cb63994b11e58730` (65 lines).

Required execution order: compile the existing RandomizedReduction main/Checks first, repairing its source under the author's exact scope if needed; then compile this new pair under the same pins and guarded compiler discipline. Freeze successful sources and portable raw evidence, then perform the three independent review lenses. No acceptance is claimed before those steps.

## Exact remaining boundary

This is generic randomized machine composition over actual encoded strings. It does not instantiate either stage with the actual CMMSA repair/rounding/sampling constructor, supply its binary formula/rational-weight codec or malformed-instance policy, prove a per-seed encoding identity, select an actual specialized NP-hard source reduction, or establish the complete fixed-L size/runtime and learning theorem. Those concrete dependencies remain as specified in the preserved audit. The existence of FP witnesses for generic component maps does not discharge those missing constructions.
