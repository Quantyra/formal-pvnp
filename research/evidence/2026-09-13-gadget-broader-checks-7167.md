# Broader gadget Checks attempt 7167: evidence and diagnosis

2026-09-13 local date, S3137. The run failed at Geometry, before Rows, the full gadget producer and Checks. This is a failed-build evidence record, not theorem acceptance.

Session 7167, child 41576, actual exit 1 after 167.9875719 seconds. No timeout and no memory guard stop; source unchanged. Import completion: 147s. Available bytes: prelaunch 6,070,149,120; sampled minimum 4,174,979,072. The unchanged limits were one thread, 3,758,096,384-byte launch floor, 671,088,640-byte stop floor and default 200000 heartbeats. Compiler ownership was released at terminal, without repair or retry.

Command from C:/Users/Dan/Desktop/Projects/formal-pvnp:

```text
python certifications/realizable-hardness/.lake/build/actual-gadget-broader-checks-20260913/diagnostic-runner.py
```

The companion JSON is an exact byte copy of terminal-summary.json and preserves the complete absolute Lean argv: profiler=true, threshold=0, stderrAsMessages=false, Elab.async=false, -R lean, isolated output and Geometry source. The chain reused successful Machine output cc02a35cd6fc28c52a1d322927b7a6061b552c3f0c8c280d3b99ac1528c680e7 tied to repaired source fa7b350305e84cae10945abc9ea141b1cfeae6764ea0d6c5d8eeb0be4ae06bbd. It did not rebuild or edit that Machine. The runner checked original dependency copies/receipts, source pins, manifest and fallback exclusions before Geometry.

## Two root failures and four warnings

1. Geometry.lean:45:11, dartList_index: `simp_rw [reverse direction of FixedPortCycleFamily.degree_eq]` reported `simp made no progress`. The earlier simplifications ran, but this requested rewrite had no match at that stage. This is a proof-script failure, not evidence that the ordered-list theorem is false. Removing or localizing the redundant conversion is a candidate to inspect, not a tested repair; later tactics in that proof were not validated by this run.
2. Geometry.lean:81:75, ranks_at_dart: unsolved goals. The residual still contains lengths of kWord/jWord and pair projections of reverseWord on an argument whose unary index has been unfolded to List.replicate. The supplied hk/hj and reverse_at_dart equations did not rewrite those occurrences. This suggests a normalization/order-of-rewriting problem: preserve the original packed input while applying the word/reversal equalities, then simplify lengths. It does not establish a false rank identity. No revised proof was attempted.

The four warnings at 83:52 and 84:4/35/39 identify unused reverse_at_dart, ExecutablePortRotation.output, hk and hj simp arguments. They describe the same second failed proof's ineffective rewriting, not four additional semantic failures. Neither error is an unknown-name cascade from Machine: its earlier six compose errors were already resolved. The ranks proof does not invoke dartList_index, so its failure should not be dismissed as merely a consequence of the first failed theorem. There were no heartbeat error headers in this run.

No Geometry output was accepted (output hash is null). The runner stopped immediately on its nonzero exit; ActualGadgetRowProducerRows, ActualGadgetRowProducer and ActualGadgetRowProducerChecks were never launched. In particular no Checks axiom profiles were obtained. Full gadget correctness and formal closeout remain open.

## Evidence identities

Raw evidence root: certifications/realizable-hardness/.lake/build/actual-gadget-broader-checks-20260913. Diagnostic stem: diagnostics/ActualGadgetRowProducerGeometry-1789351935186421600.

| Artifact | SHA256 |
|---|---|
| Geometry source | 2e8888a1e7dc0b3886139c4f4a3268d74b160530cd67cf1a1649119161855160 |
| Diagnostic .log | b1e803b0ad777d488e250ed80d0d590c005bc72a396ac676f5b2079d162cbfcf |
| Diagnostic .jsonl telemetry | 8e9f5af6847dc553fc6ddd1036cbc82f992a39c233d4060d45ec0f439921ace3 |
| Diagnostic .json metadata | e5662d7bc98792f79ca9b8448346c93568ca113e314286808c43383190e25a71 |
| terminal-summary.json and companion archived JSON | 5d0ca1181fd2dccfe2fc884ade03d9ffebfd51b3a2238e3bd6057c6b0fe72869 |
| diagnostic-runner.py | 2ce58bff8780d0af7ce21462f1e6799e5bd5b82dc3c70f793aac27b845b79360 |
| plan.json | 6a76b48b6e8a179bde3391914ff0e80c60228948b6d495e62ffdbdc326dd0907 |

The author ran the attempt and supplied this diagnosis. Independent evidence review is separate; neither author nor evidence review constitutes independent compilation. Raw logs/telemetry and earlier attempts must remain retained: these compact archival files are not a self-contained reproduction bundle. No Lean source modification occurred during this attempt or diagnosis.
