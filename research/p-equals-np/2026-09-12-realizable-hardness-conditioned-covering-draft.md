# Actual advice-conditioned covering source draft

2026-09-12. S3134 under S3126. Status: **UNCOMPILED**. No author or independent verification is claimed. This increment implements the selected KMS dependency, not a novelty claim or the full realizable-hardness theorem.

## Sources and target

Khot--Minzer--Safra, *On Independent Sets, 2-to-2 Games and Grassmann Graphs*, Theory of Computing 21(10), 2025, DOI 10.4086/toc.2025.v021a010, Definition 4.5 and Lemmas 4.6--4.7; Section 8 proof of Lemma 4.7 from Lemma 4.6. Inspected local primary-source extraction `C:/Users/Dan/AppData/Local/Temp/s3123-kms.pdf.txt`, especially lines 1306--1326 and 1680--1737. Manuscript `C:/Users/Dan/Desktop/Projects/realizable-cmmsa-hardness/paper/submission-manuscript.md`, parameter-extension section from line 304. Routing follows the existing source-directed frontier note, with no new mechanism introduced.

Actual final target: for rational beta >= 0, a < d <= J, and 2^d beta <= 1/8, an explicitly defined badZoom set of actual a-subspaces has ambient uniform mass at most sqrt(beta) J^(1/4). For every Q outside this set, the actual deletion-sampler d-subspace law conditioned on Q contained in L is normalized and has TV from the ambient law conditioned on the same event at most sqrt(beta) J^(1/4) 2^(d+5).

## Concrete derivation

- flagKernel chooses a uniform a-subspace of the actual d-subspace L. Existing lowerCount proves normalization; explicit identity equivalences transport finite sums between Grass and Advice instances.
- Existing per-Q upperCount_ratio proves the ambient flag marginal is exactly ambientMass on Q. Existing containmentProbability_formula proves the retained-space flag marginal is exactly kernel s Q. Summing the actual prior proves the deleted flag marginal equals adviceMarginal beta Q.
- A generic finite conditioning calculation derives average conditional TV <= twice unconditional TV, using the actual shared normalized kernel. No TV estimate or joint-law identity is a hypothesis of the final application.
- The no-deletion atom has positive prior weight whenever beta < 1 and contains every Q. This proves positive actual conditioning events and normalization. The source's small-beta hypothesis implies beta < 1; the prescribed SamplerParameters family separately already proves beta < 1.
- ambientConditional_formula and deletedConditional_formula identify the actual global containment-conditioned L laws. deletedConditional_eq_eventPosterior_mixture disintegrates the latter into the actual event-posterior deletion draw followed by the actual conditioned uniform L inside its retained space. A separate identity uses the accepted eventPosterior_eq_conditional theorem to connect this very mixture to the advice posterior used by the density/tail proofs. Null retained fibres are proved zero explicitly.
- CoveringSpan.actual_adviceTV_le_manuscript at dimension d supplies the actual unconditioned TV estimate. The resulting expectation is bounded by zoomError^2 2^(d+5). Finite Markov yields the exact exceptional fraction; the zero-error branch proves every conditional distance is zero without dividing by zero.
- zoomError is sqrt(beta) sqrt(sqrt(J)); zoomError_eq_source proves equality with sqrt(beta) J^(1/4). Internal quantitative results require beta in [0,1), a <= d <= J. The source theorem retains a < d and the stated small-beta condition. This extension of the internal domain is not a significance claim.

## Files and unrun checks

Owned source files under `certifications/realizable-hardness/lean/PvNP/RealizableHardness/`:

- `ConditionedCovering.lean`: SHA256 `ebd45c21aef2a9af9616b3b3dd65fa1dd26493f7d47d5435122b51acb532480e`.
- `ConditionedCoveringChecks.lean`: SHA256 `899bc955a0d6b88d580a47872b87ce93f73c9aae1856cb796364ce912596141b`.

Checks contain 26 planned axiom reports and 10 examples, all **UNRUN**. Examples cover beta=0, J=0, a=d=0, a<d, positive normalization, exact posterior mixture, and a numerical source-small-beta instance. No sorry, admit, new axioms, native_decide, or compiler-trust extension was intentionally introduced. No aggregate or accepted dependency was modified.

The rejected reducibility override identified during the preceding covering increment is absent; explicit equivalences transport the two distinct Fintype enumerations. Compilation may still expose finite-sum elaboration, cast, cancellation, or tactic issues. Full proof scripts are present through the concrete final theorem; no desired conclusion is substituted as a hypothesis.

## Verification still required

Draft preservation, guarded author compilation under Lean 4.34.0-rc2 and the pinned companion manifest, actual exit/raw-log evidence, followed by independent proof, complexity, and non-claims reviews. No compiler or Git action was performed while preparing this draft. Full PCP, decoder, specialized parameter asymptotics, runtime/encoding, learning transfer, and manuscript reconciliation remain outside this increment and incomplete in the parent goal.


## Author build outcome (supersedes draft status above)

Main and Checks are now **AUTHOR EXIT0**, not independently accepted. Main first compile 69634 exited 1 at the final average definition elaboration and an incorrect multiplication-inequality API. The repair expanded the actual conditional definitions explicitly and used mul_le_mul_iff_right₀. Retry 83456 compiled the unchanged mathematical target with exit 0. Its Checks process exited 1 only at two boundary-example scripts. Checks-only retry 96493 exited 0 after a cast normalization, explicit finite-sum integrand, and real inequality transport. Main was not rerun after those Checks-only repairs.

All 26 requested axiom reports contain only propext, Classical.choice, and Quot.sound. All 10 examples elaborated successfully. Main retains benign unused-simp/unreachable-tactic warnings in the raw log. Source UNCOMPILED banners are historical draft comments; this receipt records the actual author status. No claim of full hardness formalization or independent verification is made.

The runner checked all 11 package HEADs against companion manifest SHA256 825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0, used Lean 4.34.0-rc2 commit 6a10ac8c22beadecabdbb0919c2b50214762f91d and one Lean thread, read actual available physical memory before each module (minimum start 768MiB), and monitored the owned child against the 640MiB stop threshold. No guard stop occurred. Raw bytes and actual exits were stored before UTF8 display. No dependencies, aggregate, or configuration were edited.

Final source and output hashes, memory observations, exact commands, logs, failure diagnostics, and profile output follow. Independent three-lens review remains required.

```json
[
  {
    "command": [
      "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
      "-R",
      "lean",
      "-o",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\ConditionedCovering.olean",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ConditionedCovering.lean"
    ],
    "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
    "exit_code": 1,
    "guard_stopped": false,
    "memory_pre": 3152097280,
    "memory_min": 1371418624,
    "source_sha256": "ebd45c21aef2a9af9616b3b3dd65fa1dd26493f7d47d5435122b51acb532480e",
    "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ConditionedCovering-1789269685069300800.log",
    "log_sha256": "2aff0cfe2f20035d405de63eeff7fa0acc071d55dd314c064e30417b37487dca",
    "output_sha256": null,
    "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
    "LEAN_NUM_THREADS": "1",
    "version": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
    "manifest_sha256": "825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0",
    "pins": {
      "cslib": "d9be64196bf145edd019f1ccfeaee0c11166ba6b",
      "mathlib": "e06eff5f95374108acfaf19f1ff7473aa7771df2",
      "complexitylib": "6c248df7859f2f245e731c1e07057bf69d165fe2",
      "plausible": "d9598f07b1bc701f1e3aae163d2681c1fd978793",
      "LeanSearchClient": "ba67e212be1197b84c1f1f6299488a10a3002713",
      "importGraph": "d8823026ac7ef130c253089d95685f9877b95323",
      "proofwidgets": "a8acbfd87375ff4abe14ce09db5b7664d383bc7f",
      "aesop": "18889deb9e83ea7420ef51c160d6f88552e744e3",
      "Qq": "507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3",
      "batteries": "7e23602c91bc04586b2b06de2708a041853e4681",
      "Cli": "ab3a82db9fea14cf0fd7f5a2de650f4b534640af"
    },
    "metadata_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ConditionedCovering-1789269685069300800.json",
    "metadata_sha256": "a6a4ee78ca24da1d06fc875dd5808cad7c4f0351cd4b01af9f74ea7d091549d3",
    "raw_log_utf8": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ConditionedCovering.lean:114:47: warning: This simp argument is unused:\n  Module.finrank_pi\n\nHint: Omit it from the simp argument list.\n  [apply] simp [TripleRestrictionRank.Vector, Coord, Nat.mul_comm]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ConditionedCovering.lean:268:12: warning: Unused tactic linter: `ring` does nothing\n\nNote: This linter can be disabled with `set_option linter.unusedTactic false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ConditionedCovering.lean:268:12: warning: this tactic is never executed\n\nNote: This linter can be disabled with `set_option linter.unreachableTactic false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ConditionedCovering.lean:309:2: error: Type mismatch: After simplification, term\n  h\n has type\n  @LE.le ℚ Rat.instLE\n    (∑ x,\n      ambientMass x *\n        AdviceExceptions.tv (posterior ambientMass flagKernel x) (posterior (adviceMarginal β) flagKernel x))\n    (2 * AdviceExceptions.tv ambientMass (adviceMarginal β))\nbut is expected to have type\n  @LE.le ℚ Rat.instLE (∑ Q, ambientMass Q * AdviceExceptions.tv (ambientConditional Q) (deletedConditional β Q))\n    (2 * AdviceExceptions.tv ambientMass (adviceMarginal β))\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ConditionedCovering.lean:385:34: error(lean.invalidField): Invalid field `mp`: The environment does not contain `Function.mp`, so it is not possible to project the field `mp` from an expression\n  mul_le_mul_right ?m.392\nof type\n  ∀ (a : ?m.386), a * ?m.387 ≤ a * ?m.388\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ConditionedCovering.lean:385:28: error: Application type mismatch: The argument\n  hpos\nhas type\n  0 < zoomError β J * 2 ^ (d + 5)\nbut is expected to have type\n  ?m.387 ≤ ?m.388\nin the application\n  mul_le_mul_right hpos\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ConditionedCovering.lean:374:45: warning: This simp argument is unused:\n  Bool.true_eq\n\nHint: Omit it from the simp argument list.\n  [apply] simp only [badZoom, hb, decide_true, ite_true]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\n"
  },
  {
    "command": [
      "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
      "-R",
      "lean",
      "-o",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\ConditionedCovering.olean",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ConditionedCovering.lean"
    ],
    "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
    "exit_code": 0,
    "guard_stopped": false,
    "memory_pre": 3212935168,
    "memory_min": 1397501952,
    "source_sha256": "766695b48744854b9b1e71b27a5b442fdc6ce822381d7ca3207f14d74cf1b7ef",
    "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ConditionedCovering-1789269737204358600.log",
    "log_sha256": "172e8959a38cb05c310edfe642a2cc1d7bfbc8631ced8d6182e29e677350ae02",
    "output_sha256": "30714b565370cb548b832273050d28aae9304dccb7df78f38e9515bd736dff1b",
    "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
    "LEAN_NUM_THREADS": "1",
    "version": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
    "manifest_sha256": "825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0",
    "pins": {
      "cslib": "d9be64196bf145edd019f1ccfeaee0c11166ba6b",
      "mathlib": "e06eff5f95374108acfaf19f1ff7473aa7771df2",
      "complexitylib": "6c248df7859f2f245e731c1e07057bf69d165fe2",
      "plausible": "d9598f07b1bc701f1e3aae163d2681c1fd978793",
      "LeanSearchClient": "ba67e212be1197b84c1f1f6299488a10a3002713",
      "importGraph": "d8823026ac7ef130c253089d95685f9877b95323",
      "proofwidgets": "a8acbfd87375ff4abe14ce09db5b7664d383bc7f",
      "aesop": "18889deb9e83ea7420ef51c160d6f88552e744e3",
      "Qq": "507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3",
      "batteries": "7e23602c91bc04586b2b06de2708a041853e4681",
      "Cli": "ab3a82db9fea14cf0fd7f5a2de650f4b534640af"
    },
    "metadata_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ConditionedCovering-1789269737204358600.json",
    "metadata_sha256": "a7603aca4e7531fb463a84a541caa0e96f28a16f6c6ed9e49655394ae533ff15",
    "raw_log_utf8": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ConditionedCovering.lean:114:47: warning: This simp argument is unused:\n  Module.finrank_pi\n\nHint: Omit it from the simp argument list.\n  [apply] simp [TripleRestrictionRank.Vector, Coord, Nat.mul_comm]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ConditionedCovering.lean:268:12: warning: Unused tactic linter: `ring` does nothing\n\nNote: This linter can be disabled with `set_option linter.unusedTactic false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ConditionedCovering.lean:268:12: warning: this tactic is never executed\n\nNote: This linter can be disabled with `set_option linter.unreachableTactic false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ConditionedCovering.lean:376:45: warning: This simp argument is unused:\n  Bool.true_eq\n\nHint: Omit it from the simp argument list.\n  [apply] simp only [badZoom, hb, decide_true, ite_true]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\n"
  },
  {
    "command": [
      "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
      "-R",
      "lean",
      "-o",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\ConditionedCoveringChecks.olean",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ConditionedCoveringChecks.lean"
    ],
    "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
    "exit_code": 1,
    "guard_stopped": false,
    "memory_pre": 3183632384,
    "memory_min": 1325936640,
    "source_sha256": "899bc955a0d6b88d580a47872b87ce93f73c9aae1856cb796364ce912596141b",
    "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ConditionedCoveringChecks-1789269760528829600.log",
    "log_sha256": "d5abd00dc76011e0488534948c1eb052d8b759009dc17677395341551b370608",
    "output_sha256": null,
    "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
    "LEAN_NUM_THREADS": "1",
    "version": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
    "manifest_sha256": "825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0",
    "pins": {
      "cslib": "d9be64196bf145edd019f1ccfeaee0c11166ba6b",
      "mathlib": "e06eff5f95374108acfaf19f1ff7473aa7771df2",
      "complexitylib": "6c248df7859f2f245e731c1e07057bf69d165fe2",
      "plausible": "d9598f07b1bc701f1e3aae163d2681c1fd978793",
      "LeanSearchClient": "ba67e212be1197b84c1f1f6299488a10a3002713",
      "importGraph": "d8823026ac7ef130c253089d95685f9877b95323",
      "proofwidgets": "a8acbfd87375ff4abe14ce09db5b7664d383bc7f",
      "aesop": "18889deb9e83ea7420ef51c160d6f88552e744e3",
      "Qq": "507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3",
      "batteries": "7e23602c91bc04586b2b06de2708a041853e4681",
      "Cli": "ab3a82db9fea14cf0fd7f5a2de650f4b534640af"
    },
    "metadata_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ConditionedCoveringChecks-1789269760528829600.json",
    "metadata_sha256": "e39dd1f8159455a5cc98876c4d22173cdc2016460b36dd3265cbb33bf5c3a015",
    "raw_log_utf8": "'PvNP.RealizableHardness.ConditionedCovering.fibre_conditional_tv_le' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.conditional_tv_average_le' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.flagKernel_nonneg' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.flagKernel_normalized' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.ambient_flag_marginal' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.retained_flag_marginal' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.deleted_flag_marginal' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.adviceMarginal_pos' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.ambientConditional_normalized' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.deletedConditional_normalized' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.ambientConditional_formula' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.deletedConditional_formula' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.retainedConditional_normalized' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.contained_kernel_zero' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.deletedConditional_eq_eventPosterior_mixture' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.deletedConditional_eq_advicePosterior_mixture' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.conditionalDistance_nonneg' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.actual_conditional_average_le' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.zoomError_nonneg' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.zoomError_sq' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.zoomError_eq_source' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.actual_conditional_average_le_real' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.badZoom_mass_le' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.goodZoom_distance_le' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.beta_lt_one_of_source' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.actual_conditioned_covering' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ConditionedCoveringChecks.lean:58:2: error: Type mismatch\n  (actual_conditioned_covering (1 / 16) ?m.63 ?m.64 ?m.65 ?m.66).left\nhas type\n  ↑(mass ambientMass (badZoom (1 / 16))) ≤ √↑(1 / 16) * ↑1 ^ (1 / 4)\nbut is expected to have type\n  ↑(mass ambientMass (badZoom (1 / 16))) ≤ √↑(1 / 16) * 1 ^ (1 / 4)\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ConditionedCoveringChecks.lean:70:4: error: Tactic `apply` failed: could not unify the conclusion of `@Finset.single_le_sum`\n  ?f ?a ≤ ∑ x ∈ ?s, ?f x\nwith the goal\n  ↑(ambientMass Q) * ↑(conditionalDistance β Q) ≤ ∑ R, ↑(ambientMass R) * ↑(conditionalDistance β R)\n\nNote: The full type of `@Finset.single_le_sum` is\n  ∀ {ι : Type ?u.70} {N : Type ?u.69} [inst : AddCommMonoid N] [inst_1 : Preorder N] {f : ι → N} {s : Finset ι}\n    [AddLeftMono N], (∀ i ∈ s, 0 ≤ f i) → ∀ {a : ι}, a ∈ s → f a ≤ ∑ x ∈ s, f x\n\nβ : ℚ\nhβ : 0 ≤ β\nhβ1 : β < 1\nQ : Advice 0 0\nh : ∑ Q, ↑(ambientMass Q) * ↑(conditionalDistance β Q) ≤ zoomError β 0 ^ 2 * 2 ^ (0 + 5)\nhn : 0 ≤ ↑(conditionalDistance β Q)\nhw : 0 < ↑(ambientMass Q)\n⊢ ↑(ambientMass Q) * ↑(conditionalDistance β Q) ≤ ∑ R, ↑(ambientMass R) * ↑(conditionalDistance β R)\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ConditionedCoveringChecks.lean:79:2: error: linarith failed to find a contradiction\nβ : ℚ\nhβ : 0 ≤ β\nhβ1 : β < 1\nQ : Advice 0 0\nhn : 0 ≤ ↑(conditionalDistance β Q)\nhw : 0 < ↑(ambientMass Q)\nhs : ↑(ambientMass Q) * ↑(conditionalDistance β Q) ≤ ∑ R, ↑(ambientMass R) * ↑(conditionalDistance β R)\nh : ∑ Q, ↑(ambientMass Q) * ↑(conditionalDistance β Q) ≤ 0\na✝ : 0 < conditionalDistance β Q\n⊢ False\nfailed\n"
  },
  {
    "command": [
      "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
      "-R",
      "lean",
      "-o",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\ConditionedCoveringChecks.olean",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ConditionedCoveringChecks.lean"
    ],
    "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
    "exit_code": 0,
    "guard_stopped": false,
    "memory_pre": 3152261120,
    "memory_min": 1524613120,
    "source_sha256": "62b45015fb69034bcef93f367c73f4fca98e7b49236530dcb618ac4deb2c15cc",
    "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ConditionedCoveringChecks-1789269811841045400.log",
    "log_sha256": "63756905e45adaa50b2ad6cbbb99377a122981bdffebdf127f41c508c930de3c",
    "output_sha256": "c5a1fb2083788a786dc67dfc96ecaaeadb888030721222a240d62d480369552f",
    "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
    "LEAN_NUM_THREADS": "1",
    "version": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
    "manifest_sha256": "825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0",
    "pins": {
      "cslib": "d9be64196bf145edd019f1ccfeaee0c11166ba6b",
      "mathlib": "e06eff5f95374108acfaf19f1ff7473aa7771df2",
      "complexitylib": "6c248df7859f2f245e731c1e07057bf69d165fe2",
      "plausible": "d9598f07b1bc701f1e3aae163d2681c1fd978793",
      "LeanSearchClient": "ba67e212be1197b84c1f1f6299488a10a3002713",
      "importGraph": "d8823026ac7ef130c253089d95685f9877b95323",
      "proofwidgets": "a8acbfd87375ff4abe14ce09db5b7664d383bc7f",
      "aesop": "18889deb9e83ea7420ef51c160d6f88552e744e3",
      "Qq": "507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3",
      "batteries": "7e23602c91bc04586b2b06de2708a041853e4681",
      "Cli": "ab3a82db9fea14cf0fd7f5a2de650f4b534640af"
    },
    "metadata_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ConditionedCoveringChecks-1789269811841045400.json",
    "metadata_sha256": "228379f30d29cccd8668f09bcdee4fb3364ef0499c9ab87eb8c6ffedf6813dae",
    "raw_log_utf8": "'PvNP.RealizableHardness.ConditionedCovering.fibre_conditional_tv_le' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.conditional_tv_average_le' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.flagKernel_nonneg' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.flagKernel_normalized' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.ambient_flag_marginal' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.retained_flag_marginal' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.deleted_flag_marginal' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.adviceMarginal_pos' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.ambientConditional_normalized' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.deletedConditional_normalized' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.ambientConditional_formula' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.deletedConditional_formula' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.retainedConditional_normalized' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.contained_kernel_zero' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.deletedConditional_eq_eventPosterior_mixture' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.deletedConditional_eq_advicePosterior_mixture' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.conditionalDistance_nonneg' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.actual_conditional_average_le' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.zoomError_nonneg' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.zoomError_sq' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.zoomError_eq_source' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.actual_conditional_average_le_real' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.badZoom_mass_le' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.goodZoom_distance_le' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.beta_lt_one_of_source' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ConditionedCovering.actual_conditioned_covering' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n"
  }
]
```
