# Actual conditioned covering: independent proof review

2026-09-12; S3126 / S3134. Verdict: **GO-WITH-NOTES**, bounded to the actual finite containment-conditioned covering theorem and posterior-mixture identities. This is independent AI review, not human peer review or full hardness certification.

Frozen candidate `ec3eed3a0fb05b59e0bb5985661ac8a10147eb20`. Read the complete main and Checks files and author receipt, and inspected KMS Lemma 4.7 and its Section 8 argument in the preserved primary-source extraction `C:/Users/Dan/AppData/Local/Temp/s3123-kms.pdf.txt` (around lines 1306 and 1680). Existing companion and planning three-lens instructions applied. No source, configuration, index, release or publication changes were made.

## Independent verification

Session **38915** terminated with actual exit **0**. Both main and Checks independently exported into the fresh `.lake/build/conditioned-covering-independent-review-20260912/lib/lean` root. All **26** requested profiles appeared in source order and contain only `propext`, `Classical.choice` and `Quot.sound`. All **10** examples elaborated. The source token audit found no sorry, admit, native_decide or new axiom declarations.

The adjacent `2026-09-12-realizable-hardness-conditioned-covering-proof-verification.json` records full runner source, commands, environment, all eleven manifest checkout pins, all 57 copied dependency hashes, frozen/current source hashes, raw UTF-8 logs, log/output hashes, memory prechecks and actual exits. Its SHA256 is `c0f7bb746ca9bda5c0970631d2c2008e03d43cabe3aafae45cd7378f370a0de0`.

Each of the 57 prior ordinary oleans was checked against its original independent export receipt, copied from the accepted sampler-parameters independent root, then checked again. LEAN_PATH used only the fresh local proof root plus pinned package/core roots, excluding author and earlier independent proof roots. Only this new pair compiled, without an aggregate, broad build, cache download or dependency mutation.

Lean was verified as 4.34.0-rc2, compiler `6a10ac8c22beadecabdbb0919c2b50214762f91d`, with manifest SHA256 `825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0` and all eleven actual package HEADs matching. LEAN_NUM_THREADS=1. GlobalMemoryStatusEx measured 3,043,454,976 bytes available before main and 3,227,807,744 before Checks. Both exceed the 768 MiB precheck; the runner monitored its owned child against the 640 MiB physical-memory/disk floor. Raw bytes and actual exit metadata were durable before UTF-8 decoding. Compiler ownership was released after terminal completion.

| Export | Source SHA256 | Independent output SHA256 |
|---|---|---|
| ConditionedCovering | `766695b48744854b9b1e71b27a5b442fdc6ce822381d7ca3207f14d74cf1b7ef` | `30714b565370cb548b832273050d28aae9304dccb7df78f38e9515bd736dff1b` |
| ConditionedCoveringChecks | `62b45015fb69034bcef93f367c73f4fca98e7b49236530dcb618ac4deb2c15cc` | `c5a1fb2083788a786dc67dfc96ecaaeadb888030721222a240d62d480369552f` |

## Adversarial mathematical audit

The final `actual_conditioned_covering` has rational beta>=0, natural a<d<=J, and the source condition `2^d*beta <= 1/8`. It explicitly bounds ambient-uniform mass of `badZoom` by `sqrt(beta)*J^(1/4)`. For every Q outside that set it proves normalization of the actual deleted conditional L law and bounds its rational half-L1 TV from the ambient conditional law by `sqrt(beta)*J^(1/4)*2^(d+5)`. These are concrete finite distributions on actual Grassmann subspaces, not supplied abstract proximity hypotheses.

`flagKernel` samples an actual uniform a-subspace of L. Gaussian lower counts prove its normalization. Actual upper counts prove its ambient marginal equals ambientMass; the retained containment formula proves its per-draw marginal equals kernel s Q. Summing the actual prior proves the deleted flag marginal equals adviceMarginal. Distinct Fintype instances are transported by explicit equivalences, with no assumed marginal identity.

The generic fibre argument controls marginal-weighted conditional half-L1 TV by the full fibre L1 difference. Summing through the shared normalized nonnegative kernel yields at most twice the unconditional TV. It does not assume the desired conclusion. Applying the accepted actual basic covering theorem at dimension d yields the precise expectation bound `zoomError^2*2^(d+5)`. The factor two and half-L1 normalization are consistent.

Both conditional definitions use the same event Q contained in L. Their formulas show global conditioning of the ambient and deleted d-subspace laws. The deleted law is also proved equal to the exact event-posterior draw mixture followed by the retained-space conditional L law; the accepted flag-posterior identity then converts its weights to the existing advice posterior. This does not resample deletion independently after fixing Q. Null retained fibres have zero contained-kernel numerator, proved by nonnegativity and a finite-sum bound, so the disintegration handles those fibres without invalid cancellation.

For beta<1 the all-undeleted atom has positive prior mass and retained space top. This proves every advice marginal and global containment event positive; normalization cannot arise only from a zero-denominator convention. The internal range is beta in [0,1), a<=d<=J. The final small-beta condition proves beta<1 explicitly, retaining the source's a<d restriction. The admissible family is nonempty, for example J=d=1, a=0, beta=1/16, which the Checks instantiate.

`zoomError` is sqrt(beta)*sqrt(sqrt(J)), and its equality with the source fourth-root expression is proved. Markov's argument separates the zero-error case: positive ambient point masses and zero expectation force every conditional distance to zero. Only the nonzero branch cancels a strictly positive threshold. Thus beta=0 and J=0 do not hide division-by-zero errors; the latter is tested in the wider internal a=d=0 domain, while the final strict-dimension theorem correctly excludes it.

The explicit bad set uses a strict distance threshold. Consequently its complement gives the required weak bound. The final statement measures bad Q under ambient uniform, matching the source, and the exact mixture connects this conditional law to the posterior used by earlier tail/density components. No posterior-independence assertion or simultaneous union over arbitrary subspaces is introduced.

## Notes and remaining scope

No blocking proof, vacuity, conditioning, constant, or hidden-hypothesis issue was found. Benign unused-simp/unreachable-tactic warnings remain in main's raw log. Historical UNCOMPILED banners are superseded by the author and this independent receipt; proof bytes were not edited.

This accepts the finite conditioned-covering dependency on its stated domain. Prescribed-parameter compatibility, exceptional-mass specialization, remaining posterior/decoder machinery, fixed-L assembly, encoded polynomial runtime and randomness, full realizable hardness, exact learning transfer, and final paper reconciliation remain outside this review. The broader internal parameter range is not a novelty claim. No complete hardness proof, quantum algorithm, P-versus-NP result or publication readiness follows from this bounded acceptance.
