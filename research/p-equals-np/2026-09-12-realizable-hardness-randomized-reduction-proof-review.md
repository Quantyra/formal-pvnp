# Randomized reduction composition: independent proof review

Verdict: **GO-WITH-NOTES**, bounded to the four frozen machine-composition modules.

Reviewer: `/root/machine_composition_proof_review`, a top-level independent proof-adversarial reviewer. I did not author either target. Scope: S3126/S3131, frozen commit `9bcc6cf8eba1dfda445e6f2f082a696bb41a4364` in `formal-pvnp`. No target source, dependency source, Git state, configuration, or public artifact was changed during this review.

## Independent build evidence

Session **89351** terminated with actual exit zero. RandomizedReduction, its Checks, RandomizedReductionAssembly, its Checks, and the dependency scratch each independently exited zero. The four target sources were byte-identical to their frozen Git blobs before and after execution. Outputs are isolated under `certifications/realizable-hardness/.lake/build/randomized-independent-review-20260912/lib/lean`.

The two target Checks produced **27** exact declaration axiom profiles, **15** kernel-checked examples, and the two expected evaluation outputs `[true]` and `[]`. The imported dependency scratch produced **16** exact declaration profiles. All 43 profiles use only `propext`, `Classical.choice`, and `Quot.sound`, or a subset thereof. No sorry/admit/new axiom is present in these theorem profiles. The examples include zero/full prefixes, first-output-dependent required lengths, ignored padding, malformed inputs, and short supplied seeds. The two evaluations exercise the nested executor; they do not constitute an extracted composite executable.

Lean was 4.34.0-rc2 at `6a10ac8c22beadecabdbb0919c2b50214762f91d`; all eleven actual companion package HEADs matched manifest SHA256 `825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0`. One Lean thread was used. Each child started above 768 MiB actual available physical memory and was monitored with GlobalMemoryStatusEx against a 640 MiB termination threshold. The lowest observed memory was 1,766,547,456 bytes. Raw log bytes and actual-exit metadata were persisted before UTF-8 decoding.

I verified the 32 embedded author raw records against their lengths, hashes and current local files. The scoped 117-module Complexitylib source closure matched pinned Git after explicitly recorded CRLF normalization. All 1,392 author-recorded reused artifacts, including IR signatures, matched current origin and copy hashes. The independent root received 1,397 artifact copies: that closure plus the narrowly author-built Promise.Defs outputs. The missing Mathlib Tuple.Take output was checked against its successful source/output metadata and reused through the package path. The ten shared checkout dependency HEADs were rechecked. These checks establish **current provenance**. They are not historical per-output hash identity and do not claim a fresh-source rebuild of all transitive dependencies.

Portable evidence: `2026-09-12-realizable-hardness-randomized-reduction-proof-verification.json`, SHA256 `7104f3ee41f2eb39540383c5672d193e3341071e642b18517cc7fe9701da712d`. It embeds the runner, preparation script, raw target/scratch sources, five logs and actual-exit metadata, exact axiom lists, output hashes, frozen source identities and dependency provenance.

## Adversarial statement and proof audit

1. **Actual machine semantics.** SeededMap requires run and ruler membership in the pinned library's FP. Inspection of FP and TM.ComputesInTime confirmed an actual machine reaching a halted state with the specified output on every input. These are not arbitrary renamed runtime predicates. The natural-polynomial clock normal form includes all lengths, including small and malformed inputs. coinCount_poly derives a bound from the FP ruler on a representative string of every length.

2. **Derived padding.** second_coin_padding uses the pair length and monotone natural-polynomial output bounds for both the first executor and second ruler. It covers every sufficiently bounded first seed, regardless of promise membership or first-stage success. exists_padding constructs an exact FP ruler for the resulting polynomial. Padding is therefore not a supplied final probability or runtime assertion. The noncomputable pairEnvelope concerns a polynomial certificate; it does not replace the executor with an oracle.

3. **Dynamic prefix probability.** block_disintegration averages over the actual first seed and permits the entire second predicate to depend on it. Fin.take/List.take equality and prefix_probability cancel unused suffix bits separately in each first-seed fibre. execute_disintegration uses the actual first output to determine the second ruler length. No independence of that output and its induced length is assumed.

4. **Same executor throughout.** compose builds one flat seeded map. flat_seed_execution identifies its first prefix and reversed suffix with the two blocks of the same uniform seed. compose_probability transfers the exact conditional calculation to this map. exists_preserving_composition uses that same compose witness for preservation, polynomial coin count and the actual machine clock. There is no switch to a different convenient semantic map between the three conclusions.

5. **Promise sides and failure cases.** Preserves keeps YES and NO obligations separate. compose_success_lower only invokes the second guarantee on intermediate strings in the relevant promised side; all other outputs contribute nonnegative probability. The error hypotheses are sufficient for the additive bound. Allowing a first error above one can make that bound weak, but does not make the quantified closure false or conceal a hardness instance. Empty promise sides are allowed by the generic API; the theorem does not infer source hardness from them.

6. **Original-input clock.** scheduled_machine supplies both an all-input raw clock and a polynomial in the original input length for every seed of the specified length. It does not restrict the clock to successful seeds. Flat extraction remains total on malformed/short strings; the exact uniform-law theorem uses correctly scheduled seeds and the proved padding bound. No magical filling of missing bits occurs.

## Notes and remaining obligations

No HIGH proof, circularity, hypothesis, or vacuity defect was found within this scope. Assembly retains harmless unused-simp and unreachable-ring warnings. Frozen source comments still say UNCOMPILED; the dated author and independent receipts supersede that historical status, but comments should be reconciled at final artifact preparation without obscuring this freeze.

This is a generic composition theorem for deterministic machines supplied with uniformly sampled finite seeds. It does not independently construct an explicit randomized TM that samples those seeds, nor an extracted runnable composite. Those are distinct from the mathematical seeded reduction API proved here.

Component FP evidence and component promise-preservation hypotheses are real inputs to a closure theorem. They are not discharged for weighted CMMSA by this result. The actual finite codec, per-seed FP constructor, source NP-hardness, specialized outer reduction, full fixed-L assembly, and learning theorem remain outside this review. There is no P-versus-NP, novel algorithm, full-paper certification, or full dependency-replay claim.

The compiler was released after the terminal result. This verdict is one independent lens; root must combine it with the separate complexity and non-claims reviews before accepting the bounded increment.
