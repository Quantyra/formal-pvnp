# Gadget Machine native diagnostic: bounded repair diagnosis

2026-09-13, S3137. Read-only source/API diagnosis; no Lean source changed, compiler rerun, or Git action. The proposed proof edits below have NOT been elaborated.

## Evidence and scope

Actual session 80233, child 31764, exit 1 after 568.38 seconds. Source unchanged, guard_stopped=false; minimum available memory 1,938,714,624 bytes. Native log records `import took 370s`. This run reached elaboration and failed with concrete errors, rather than stopping at the memory guard. No successful export or proof acceptance follows.

Evidence root: certifications/realizable-hardness/.lake/build/actual-gadget-machine-native-profiler-20260913.

- terminal-summary.json SHA256 319fa382d7700d030021e57f2ef34cf411061f617afc6d38e804b598a81a3cf0.
- diagnostics/ActualGadgetRowProducerMachine-1789348663951214100.json SHA256 34487b01a896354cf0e984dcc28914a04fc8c12362879302858324cfeb7089a1.
- Same stem .log SHA256 4000c5547b7c0e67c6972b55be0e3e5f606b4017905bb6ab62e2908fd1aac526.
- Same stem .jsonl SHA256 31eb8bfa5ab4f4e2b376d3098bc495650c6d49bfe79ba5687c5f1e539a986573.
- Uninstrumented Machine source SHA256 2d1336f45e1766ac726cc75c1776c4b70626ff8451d624df5c0b4e3ab75406d3, archive a57bc70003ccb442dcf1d192feee60b16c6bcecf.

The raw stream interleaves native profiling and diagnostic text, including a split path near line 100's errors. Preserve original bytes rather than treating every line as a clean diagnostic record. Fourteen error headers are recorded in the summary.

## Actual API and failure mechanism

The local private helper at source lines 60--62 has implicit functions f,g and conclusion `(fun w => g (f w)) in FP`, taking hf:f in FP first and hg:g in FP second. It correctly delegates to Complexity.mem_FP_comp (Complexitylib/Classes/P/Composition.lean:24), whose conclusion is `(g composed with f) in FP`. The API argument order is NOT reversed.

The direct term proofs put this helper under an expected goal with a named reducible function. The observed error says its first proof argument is expected to prove `(fun w => w) in FP`, although the supplied argument proves pairFst or a concrete paired-input function in FP. This is a higher-order inference/expected-type elaboration problem, not evidence that the supplied projection or pairing theorem has a wrong statement. Explicitly instantiate BOTH function metavariables and expose only the intended outer definition. Do not change the mathematical composition or substitute identity proofs to satisfy the incorrectly inferred goal.

Relevant existing contracts are Cobham.fstBlock_mem_FP for pairFst, Cobham.sndBlock_mem_FP for pairSnd, Cobham.pairFn_mem_FP for pointwise machine pairing, ExecutablePortRotation.rotationFn_mem_FP for rotationFn, and Materialize.materialize_mem_FP for listEncFn E given E in FP. Data-pair encoding is not implicated; these failing arguments use the internal machine pair.

| Source location | Supplied first function | Required second function / intended result | Classification |
|---|---|---|---|
| 65 ownerWord | pairFst | pairFst; ownerWord w=pairFst(pairFst w) | First primary application mismatch |
| 67 sizeWord | pairFst | pairSnd; sizeWord w=pairSnd(pairFst w) | Same primary inference pattern |
| 74 reverseWord | w -> pair(sizeWord w)(pair(pair(kWord w)(jWord w))(iWord w)) | rotationFn | Same primary inference pattern |
| 78 reverseK | reverseWord, followed by pairFst | a second pairFst | Primary ambiguous nested application; also depends on earlier reverseWord proof |
| 80 reverseJ | reverseWord, followed by pairFst | pairSnd | Primary ambiguous nested application; also depends on earlier reverseWord proof |
| 129 cloudFn | z -> pair(dartClock z)z | listEncFn dartRule | Additional occurrence of the same inference pattern |

Lines 78:62 and 80:62 also exhaust 200000 heartbeats at whnf; line 130:5 does likewise while elaborating the second argument of cloudFn's composition. These are real failures in this attempted elaboration. The log does not establish that the actual computation or theorem needs more heartbeats. First remove the unresolved higher-order composition inference; only an authorized later unchanged-budget build can determine whether an independent normalization-cost problem remains.

## Minimal proposed proof-only changes

Keep every function definition, theorem statement, import, namespace and runtime target unchanged. Replace only the six composition proof bodies listed above with explicit function arguments. A small `by simpa only [...] using ...` wrapper makes the intended function equality local and avoids broad simplification.

For example, ownerWord's proposed body is:

```lean
by
  simpa only [ownerWord] using
    (compose (f := pairFst) (g := pairFst)
      Cobham.fstBlock_mem_FP Cobham.fstBlock_mem_FP)
```

For sizeWord use the same f and g:=pairSnd, with its corresponding proof. For reverseWord explicitly name the paired-input lambda in f, g:=ExecutablePortRotation.rotationFn; reuse the existing pairFn membership proof unchanged. For reverseK/reverseJ, avoid leaving the inner composition unconstrained:

```lean
have h : (fun w => pairFst (reverseWord w)) ? FP :=
  compose (f := reverseWord) (g := pairFst)
    reverseWord_mem_FP Cobham.fstBlock_mem_FP
```

Finish reverseK with f:=(fun w => pairFst(reverseWord w)), g:=pairFst, hf:=h; reverseJ uses g:=pairSnd. Convert their named goals with `simpa only [reverseK]` / `[reverseJ]`. Both inner and outer functions are now fixed before elaborating evidence arguments.

For cloudFn use f:=(fun z => pair(dartClock z)z), g:=listEncFn dartRule, the existing pairing membership and materialize_mem_FP dartRule_mem_FP. A local `show`/`simpa only [id_eq]` around the pairing proof can reconcile `id z` with z if required; this is definitional equality, not a new lemma assumption. Finish with `simpa only [cloudFn]`. Prefer the existing helper with explicit parameters; deleting or redesigning it is unnecessary.

These are candidate tactics, not verified source syntax or a guarantee of success. No heartbeat increase, new axiom, target weakening, import enlargement or public-function change is justified by this diagnostic.

## Cascades and next gate

Unknown reverseK_mem_FP/reverseJ_mem_FP at line 84 (targetRank) and line 100 (target port) follow failed declarations at 78/80. Unknown cloudFn_mem_FP at line 133 follows the failed declaration at 129/130. Do not add replacement declarations, assumptions or alter these downstream consumers. Repair the defining proof bodies first. The log alone cannot certify all later declarations: error recovery may continue with incomplete upstream evidence.

After separate authorization, preserve this entire failed diagnostic root and records, put the proof-only patch in a distinct isolated repair attempt, and run only the Machine target at unchanged budget/guards. Root review should compare definitions and signatures byte-for-byte and inspect the six proof-body diff locations. This note requests no launch and makes no diagnosis of the separate strict-parser or upstream folded producer modules.
