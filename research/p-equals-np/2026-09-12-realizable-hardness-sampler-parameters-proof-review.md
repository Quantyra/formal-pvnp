# Prescribed sampler parameters: independent proof review

2026-09-12; S3126 / S3137. Verdict **GO-WITH-NOTES** for the exact prescribed sampler family and its eventual actual deletion-tail estimates. This is independent AI proof review, not human peer review or full hardness certification.

Frozen candidate: `21e4863c8e1b49c2a364d7f14c6fd0098630104b`. Both complete source files, the underlying numerical tail statements, actual strict-tail definition, and author receipt were inspected. Existing companion and planning three-lens instructions governed this review. No source, Git, configuration or publication edits were made.

## Independent verification

Session **54032** terminated with actual exit **0**. Both main and Checks exported into the fresh `.lake/build/sampler-parameters-independent-review-20260912/lib/lean` root. Checks printed all **16** requested profiles in source order, using only `propext`, `Classical.choice` and `Quot.sound`; **8** example declarations elaborated. The source audit found no sorry, admit, native_decide or new axiom declarations.

The adjacent `2026-09-12-realizable-hardness-sampler-parameters-proof-verification.json` has SHA256 `268264dfb39e405b3e6e24c2343d8283e07e98549d1157160010b68d72ecfb0a`. It contains the complete runner, commands, environment, all eleven checkout pins, 55 accepted dependency copy hashes, source/output/raw-log hashes, raw UTF-8 diagnostics, memory prechecks and actual exit codes.

Every one of 55 dependencies was hash-checked against its original independent export receipt, copied from the accepted covering-span independent root, and checked again. LEAN_PATH included only the fresh local output root and pinned package/core roots; no author or previous independent proof output root was included. Only this new pair compiled. No aggregate build, cache download, or dependency mutation occurred.

Lean 4.34.0-rc2 was verified at compiler `6a10ac8c22beadecabdbb0919c2b50214762f91d`; all eleven package HEADs matched manifest SHA256 `825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0`. LEAN_NUM_THREADS=1. GlobalMemoryStatusEx reported 3,372,507,136 bytes available before main and 3,188,797,440 before Checks. The runner required at least 768 MiB before each export and monitored the 640 MiB physical-memory/disk floor for its owned child. Raw log bytes and actual exit metadata were preserved before UTF-8 decoding. Compiler ownership was released immediately after terminal completion.

| Export | Frozen/current source SHA256 | Independent output SHA256 |
|---|---|---|
| SamplerParameters | `07a01672cd33afd6da7459566acfe75d890d76b3ee7d8260e4a6a1952f945deb` | `1156f52ced3fa3253f7bf98692a7a4c6ffde5d46024e2996fa9ac2b8ce359b16` |
| SamplerParametersChecks | `22d76ddf2ad02b84f0d5951a15aae4a5af90b3258211662c1c5228375fc2d5ca` | `ed3a5c5c32e512b60dc2a50e5b32afb2e13bae470235d68db619d223976ed356` |

## Adversarial mathematical audit

`blocks A h` is exactly the natural number `2^(2^(A*h^2))`. Both exponentials are present, without rounding or replacing the manuscript family by a smaller one. `beta A h` is the rational quotient `(A*h^2)/blocks A h`. Applying the symbolic inequality n<2^n twice proves the denominator strictly exceeds the numerator. Thus every natural A,h gives a strictly positive denominator and `0 <= beta < 1`; positive A,h give positive beta.

Cancellation proves both rational and real exact mean identities `blocks * beta = A*h^2`. There is no premise asserting this identity and no approximation hidden in the casts. Natural A avoids the impossibility of a positive-h irrational-real-A mean with rational beta and natural J noted in the prior numerical-tail review.

Zero cases are honest: if A=0 or h=0, blocks=2 and beta=0; the converse characterization of beta=0 is proved. Hence denominator-zero conventions cannot manufacture either the range or mean result. Concrete Checks establish blocks(1,1)=4 and beta(1,1)=1/4, and instantiate the eventual family at A=1.

The pointwise wrappers retain the explicit numerical `Ready` premise, as their signatures state. The final `eventual_actual_tail` discharges it: for every fixed positive natural A there exists a natural threshold N such that for every natural h>=N the actual event `dropCount > h^4` has mass at most `2^(-100*h^2)`, and that mass divided by `2^(-30*h^2)` is at most `2^(-70*h^2)`. The negative-exponent notation here denotes the exact reciprocal powers implemented by `decay`.

Quantifier order is A, positivity proof, N, then every h>=N. The sampler arguments J and beta are the defined functions of that same A,h. The final theorem has no supplied range, mean identity, readiness, small-tail, or asymptotic-growth premise. It composes the previously accepted actual strict-deletion-tail theorem, not an unrelated formal probability. Natural h above any finite N exists, so the eventual conclusion is not vacuous. Dividing by decay is justified by its proven positivity in the accepted numerical theorem.

## Notes and limits

No blocking proof, circularity, type/rounding, quantifier, or vacuity issue was found. Historical UNCOMPILED source banners are superseded by the author and independent receipts; the frozen proof bytes were not edited.

Choosing an arbitrary fixed positive natural A is valid for this tail family. This does not yet prove that the same A satisfies all decoding, proximity, zoom, dimension and divisibility constraints elsewhere in the manuscript. Nor does this pair provide advice-conditioned covering, the remaining exceptional-mass estimates, fixed-L spacing and limits, an encoded polynomial-time sampler/reduction, specialized PCP/decoder obligations, the final hardness theorem, or the learning transfer. No novelty or full-paper certification follows from this bounded acceptance.
