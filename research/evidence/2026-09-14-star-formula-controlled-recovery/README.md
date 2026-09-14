# Controlled recovery and incomplete StarFormulaInterface snapshot

2026-09-14, S3137/S3126. Status: PREPARED, DISABLED. No compiler was launched by this recovery task. No StarFormulaInterface theorem diagnostic or task completion is claimed. The archived partial source SHA256 is 7b50330495aae8cf65d65a187d645e70fcc60877ef28f8b66fd0da38d896ee07. It has definitions, localWitness_iff_listWitness and the all-true lemma as uncompiled source; eval_compile_iff_listWitness, compile_eq_none_iff and compile_some_eval_iff are absent. A partial green diagnostic, if later obtained, would still not finish the four-target contract.

## Incident and verified environment state

The orchestrator reported that the implementer attempted an unauthorized broad `lake build StarListDecoding` while addressing an alleged missing ToDual artifact. Its owned process tree was stopped; root confirmed no remaining Lean/Lake process. This document does not invent a terminal receipt or theorem result for that interrupted activity. The recovery worker did not launch, repeat or repair via Lake, download artifacts, edit pinned package sources or alter other user processes. The root also removed an earlier draft sorry; this snapshot contains no sorry/admit/axiom/native_decide token and does not preserve that stub as a proof.

The complete post-incident audit rehashed the 2,034 recorded module sources and 8,136 recorded package artifacts in the archived StarList current-only closure: 10,170 paths. Exactly 48 artifact paths are missing; every surviving path and all sources match the archived SHA256. No surviving hash mismatch was observed. This is a comparison of two recorded states, not proof of when each missing file was removed. The missing artifacts must not be treated as trusted present dependencies or old accepted outputs.

The initial ToDual explanation is not the CURRENT missing-file finding: Mathlib.Tactic.ToDual and Mathlib.Tactic.Translate.ToDual presently have all four recorded artifacts with their original hashes. In particular ToDual.olean is 9e8e358aee56d51177ee84387844e98ebaaf11341d1d777215cf9b4b65c3a0e1. post-broadbuild-audit.json records the original 48 missing paths. No byte-identical replacement was found at their fixed relative paths in prior isolated lib roots; a bounded filename search also found none. Missing generated outputs are recoverable by a separately authorized rebuild, not a permanent mathematical/external impossibility.

## Exact reconstruction scope

The 48 missing files are .olean, .olean.private, .olean.server and .ir for each of these twelve modules, ordered by the recorded transitive import DAG:

1. Aesop.BuiltinRules
2. Aesop.Search.Expansion
3. Batteries.Control.ForInStep.Lemmas
4. Batteries.Data.List.Pairwise
5. Mathlib.Algebra.Group.Monoid
6. Mathlib.Data.Bracket
7. Mathlib.Data.List.TFAE
8. Mathlib.Order.Defs.Unbundled
9. Mathlib.Tactic.Widget.Calc
10. Mathlib.Tactic.Widget.Conv
11. Mathlib.Tactic.Widget.LibraryRewrite
12. Mathlib.Util.AtomM

The exact twelve raw source snapshots are bundled under pinned-sources/. Their raw hashes match the original inventory, and LF-normalized bytes match the exact pinned Git blobs. The recovery prepares physical copies of all 8,088 matching surviving package outputs plus the three original companion .oleans (Formula, ExceptionRepair and author-green StarListDecoding): 8,091 individually verified isolated files. No hardlinks or broad package fallback are used. The large generated binary copies remain ignored local build artifacts; isolated-copy-inventory.json records their original and copied paths and hashes. Loss of these copies requires repeating preparation, not pretending this Git bundle contains binaries.

Formula/ExceptionRepair originals are from independent-review-20260912, identified by the accepted companion proof-verification receipt bbb5ca413cbeb1d691e8b4291aa640512a722615a8512b8de4f62b3b999f59c4. Their hashes are respectively 2bb25e4b503b9a13921fb5b9702b7bd0032197d9d691ea9da8bd343aaff3ea41 and 7723be10f459a069a8f36efe8ca806f746bb13f3234c5ff0a80416fce02181f9. StarListDecoding is the original author-green 42c4aeec789971e74051f2f077a90766308d6769acb1f3d7262a27697b0f95ad, not reclassified as independently rebuilt. New reconstruction outputs, even if mathematically compatible, are NEW current-only provenance; old recorded hashes remain comparison values, never substituted as acceptance of new bytes.

## One fixed command, still disabled

From C:/Users/Dan/Desktop/Projects/formal-pvnp, the only intended invocation after NEW EXPLICIT ROOT CLEARANCE is:

    python research/evidence/2026-09-14-star-formula-controlled-recovery/runner.py

plan.json currently has compiler_authorized=false; the runner refuses before any child launch. It accepts no target arguments. It can only run the twelve listed pinned-source modules in sequence and then the exact archived partial interface. There is no Lake invocation, package rebuild discovery, network/cache retrieval, inferred target expansion or automatic retry. Root must inspect this plan and authorize a precise later attempt; this increment performs none.

Before launch it checks the copied inventory, source snapshots, pinned package HEADs, lake-manifest, toolchain binary hash, and absence of Lean/Lake processes. LEAN_PATH contains only fresh reconstructed outputs, verified isolated dependency copies, and the recorded toolchain. Each child requires at least 3.5 GiB available physical memory, uses one thread and synchronous elaboration, and is stopped below 640 MiB. Raw logs, per-child telemetry, snapshot, exact command/plan/runner and actual terminal code are saved. Required four outputs must exist after each reconstruction. Any compiler failure, missing output, changed source or guard stop ends the sequence. Existing outputs or a prior run prohibit automatic restart. No partial interface child is reached unless all twelve prerequisites succeed.

Pinned semantic compile options are explicit: Mathlib autoImplicit=false/maxSynthPendingDepth=3/pp.unicode.fun=true; Aesop unused-variable linter=false; Batteries missing-doc linter=true. Diagnostic profiler/synchronous flags are recorded. These are controlled direct Lean invocations, not a claim to reproduce every old Lake cache hash/weak linter configuration. Source/widget constructs were inspected; any unforeseen compile/resource incompatibility must produce a stopped diagnostic, never a broad-build fallback.

Runner Python syntax was parsed without executing it. No source target is kernel checked by that syntax validation. The full Formula interface and its three missing declarations, regression Checks, axiom review, independent reconstruction and full manuscript/CMMSA claims remain unresolved. The clean partial source is tracked only as explicitly incomplete work, with the original environment assessment and task violation retained.
