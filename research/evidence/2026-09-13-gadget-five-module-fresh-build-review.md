# Gadget five-module fresh build verification

2026-09-13, S3137. **PASS for fresh execution of the exact five-module chain.** Root acceptance and claim review remain separate. This is execution-independent from the preceding author outputs; the verifier previously authored source and contributed repairs, so it is not a noncontributing proof review.

Session 23366 reached actual terminal exit zero. Machine, Geometry, Rows, aggregate and Checks each exited zero with unchanged source and no memory guard stop. Compiler ownership was explicitly released. No source repair, planning edit, Git or public action occurred.

Fresh root: `certifications/realizable-hardness/.lake/build/actual-gadget-five-module-review-build-20260913`. Launch: `python certifications/realizable-hardness/.lake/build/actual-gadget-five-module-review-build-20260913/review-runner.py` from formal-pvnp. Exact per-child Lean argv/environment/version, raw logs, telemetry, snapshots and output identities are retained in that root.

Preparation60976 exited zero after verifying/copying 2,784 original lower dependency records with receipt identities. All five target outputs were absent; no prior author target export was imported. The runner rechecked originals/copies/receipts, 214 pinned source entries as recorded by the inherited plan, 11 package pins, manifest, current-package exceptions and fallback exclusions before launching. Each later target consumed this run's newly generated predecessor output. The unchanged limits were one thread, 3.5 GiB start floor and 640 MiB global-available stop floor, with default heartbeat budget; native profiler and synchronous elaboration flags match the reviewed route.

| Module | Source SHA256 | Output SHA256 | Warnings |
|---|---|---|---|
| ActualGadgetRowProducerMachine | fa7b350305e84cae10945abc9ea141b1cfeae6764ea0d6c5d8eeb0be4ae06bbd | cc02a35cd6fc28c52a1d322927b7a6061b552c3f0c8c280d3b99ac1528c680e7 | 0 |
| ActualGadgetRowProducerGeometry | faaf300cf7a58946727496882f2185b50ef62053795d4ae302abd947bafe4577 | d47ca0d290d16a1e7362c1d2b05f13cd6ec47d56f6386ae467316c1e0c5d7c6e | 0 |
| ActualGadgetRowProducerRows | b8743f0e0d6acab28f3e8d1920343bd9766359bf0e33f5e393524ec92e8731a0 | 51c0486373b6a34e758e79c6f34e43769fd3fb0f957b328e78afb8c679f7b112 | 5 |
| ActualGadgetRowProducer | 423bce28d031ab3aa89a4d381ba891411a28cbd3ae735599026090f0493e30d4 | b3e143f46fdcf759de1e5816052ac354c1f3a9adbdd6677e616ca541a496edc0 | 0 |
| ActualGadgetRowProducerChecks | 96766935a00ceba263b70287d7f89f040d30887db033ab3b8cd24dae6ddb8eb5 | bd53dc8de913b0c7d225ce4aa496a1984fa5a15894b3c288a078a6ae524edf1c | 3 |

All raw error lists are empty. Checks emitted exactly the 31 requested axiom profiles, all confined to propext, Classical.choice and Quot.sound. Its nine examples and four signatures match the unchanged Checks source. Remaining warnings are recorded verbatim in the JSON; they are not hidden or classified as proof failures.

The adjacent JSON is an exact copy of the verified summary: SHA256 `67b165d3a0316fcd749ea6982cae8ee40e97647b117b8167570950c2ea79f6fe`. It binds every source, command, raw log, telemetry, snapshot, metadata and output hash, plus the plan/runner/preparation hashes. The summary collector rehashed all these child records and confirmed matching source snapshots before reporting success. These compact records require the preserved build root; they are not a standalone reconstruction bundle.

This run confirms the repaired finite per-owner cloud construction and Checks elaborate against the specified environment. It does not prove the global compact-source constructor, upstream CNF folded producer, complete paper theorem, novelty or either direction of P versus NP. Earlier author diagnostic outputs remain distinct; this run produces a new verification record rather than retroactively relabeling those outputs.

Reviewer disclosure: original Gadget packaging/source, related lower-module authorship and repair diagnosis contributions were disclosed before launch. A noncontributing proof-adversarial reviewer must assess any independence requirement beyond this fresh execution.
