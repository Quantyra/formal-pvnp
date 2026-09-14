# Gadget Machine proof repair: successful native diagnostic

2026-09-13 (local date), S3137. This is evidence for one successful isolated Machine diagnostic, not full gadget-producer or paper-theorem acceptance.

The original native run 80233 exited 1 with six composition-application mismatches and dependent errors. Explicit composition arguments removed those errors in 35335, leaving a target-port whnf timeout. Explicit packVar function parameters alone in 99330 did not remove that timeout. The final change separates the literal packVar FP proof into a typed local h and transports it to portFn true using a separate definitional equality. Session 69028 then exited 0 at unchanged 200000-heartbeat settings. No function definition, theorem statement, import or runtime target was changed by these proof repairs. All earlier failed roots/logs remain preserved.

The successful run took 68.9609847 seconds. The profiler reports import completion at 14 seconds. Guard stopped=false, source unchanged=true; no error or warning headers. Available memory was 6,257,602,560 bytes immediately before launch and at least 4,174,135,296 bytes in sampled telemetry. Child PID 42440 used one Lean thread. The configured start floor was 3,758,096,384 bytes and stop floor 671,088,640 bytes. Different import timing across attempts is not attributed to the proof repair: cache and host conditions also changed.

Launch command from C:/Users/Dan/Desktop/Projects/formal-pvnp:

```text
python certifications/realizable-hardness/.lake/build/actual-gadget-machine-port-transport-repair-20260913/diagnostic-runner.py
```

The runner invoked the pinned v4.34.0-rc2 lean.exe with `-Dprofiler=true -Dprofiler.threshold=0 -DstderrAsMessages=false -DElab.async=false -R lean -o <isolated Machine.olean> <isolated Machine.lean>`. Exact absolute argv, cwd, LEAN_PATH, package pins and guard telemetry are in the raw metadata. It checked the accepted original dependency records/copies/receipts, direct-source pins, manifest and target fallback exclusions before launch. Compiler ownership was explicitly released immediately after actual terminal retrieval.

## Exact identities

Paths below are relative to certifications/realizable-hardness/.lake/build/actual-gadget-machine-port-transport-repair-20260913 unless stated otherwise.

| Artifact | SHA256 |
|---|---|
| lean/PvNP/RealizableHardness/ActualGadgetRowProducerMachine.lean | fa7b350305e84cae10945abc9ea141b1cfeae6764ea0d6c5d8eeb0be4ae06bbd |
| source.patch (increment over e8b6ef65) | 3c57b31f1219944e7d17a46ca49b28941368b020021bde2df8678509d7ecd8dd |
| diagnostic-runner.py | 16e7bb672bee588c974132178fd8776e2614aa8399a7ea5790c4c1d2725cf8b8 |
| plan.json | 3fbe6abd5b4a18a7949c13a315a8663d123c3472195117c251500a55a1e8c37e |
| diagnostics/ActualGadgetRowProducerMachine-1789351283504082600.log | 5ce516376aaae0b37c886fab5997dbb511d9d6358527619cea9c7db2ebf22152 |
| diagnostics/ActualGadgetRowProducerMachine-1789351283504082600.jsonl | 69c9f2eed628564636ca273f75327e7c9dd4f91c347d9cd931b675ce24ec30a7 |
| diagnostics/ActualGadgetRowProducerMachine-1789351283504082600.json | 6a7f381ed231dae035dc8ac2ff283741babc7ffae8f4d95663c6565d4742ac55 |
| terminal-summary.json | 117a724d3327f784fd54163b9242903cbbbaa6b67ecd61f48ce398c383c29fac |
| lib/lean/PvNP/RealizableHardness/ActualGadgetRowProducerMachine.olean | cc02a35cd6fc28c52a1d322927b7a6061b552c3f0c8c280d3b99ac1528c680e7 |

The original unchanged source was 2d1336f45e1766ac726cc75c1776c4b70626ff8451d624df5c0b4e3ab75406d3 at archive a57bc70003ccb442dcf1d192feee60b16c6bcecf. The intermediate sources e6e7bee4 and e8b6ef65, their patches and unsuccessful diagnostic evidence are in their distinct compose-repair and port-repair roots. This note's archive will not migrate or freeze the repaired Lean source itself.

## Remaining acceptance boundary

The final source has 22 theorem declarations including private compose. There were ZERO emitted axiom profiles: the Machine main contains no #print axioms commands. Successful elaboration is not a substitute for the unrun Checks and axiom-profile audit. This was an author diagnostic, not independent compilation. No semantic consumer pair, downstream rebuild, full three-lens formal closeout or complete theorem has been accepted by this result. Native profiler events alone are not additional proof evidence.

The author prepared the isolated proof repairs and ran this diagnostic. Incidence independently reviewed their source diffs and is separately reviewing this evidence note; that review does not become an independent build. No source edit, rerun or publication occurred while writing this note. The referenced raw records must be retained; this compact note is not a self-contained reproduction package.
