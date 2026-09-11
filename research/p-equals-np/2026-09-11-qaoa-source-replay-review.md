# Independent source-replay review

2026-09-11. S3045 / E014 / E004; predecessor S3044. Under `INTEGRITY-CLAIMS.md`.

One independent reviewer applies source/proof, complexity and non-claims lenses. This is not a three-person formal theorem closeout. No hardware, paid resource, publication or commit is included.

## Preflight criteria

Use only frozen source ID `101678_3_1653518225511123992`, at p=14 and p=60. Recover its actual formula rather than reconstructing one from an overlap or solution count. Pin formula bytes, angle arrays and source driver before the target computation. Establish sign, half-angle, basis-bit and layer-order conventions from source evidence; do not select them by whichever output matches.

Freeze numerical tolerance and CPU/memory/time limits before target execution. Outcome-independent controls must cover clause signs, repeated literals, tautologies, qubit ordering, zero-angle uniform behavior and mixer agreement with a separate small dense reference. Report norm drift without silently normalizing it away. A mismatch must preserve its original result and stop alternate-angle exploration.

Matching two archived overlaps would support this one reference circuit's provenance and implementation. It would not identify all null-angle rows, reproduce an ensemble, validate p=623, or establish a gate/runtime advantage. If the formula or driving convention cannot be recovered, stop target execution and record the exact source dependency.

## Verification and disposition

The [numerical contract](2026-09-11-qaoa-replay-numerical-contract.md) fixes the evidence label to **paper-defined convention check**. The original empirical driver is absent from the recovered public code. The proposed gamma sign conversion is an analytic-coefficient inference, not a certified reconstruction of that missing driver. This limitation is appropriately fixed before target execution.

The reviewer independently parsed the pinned angle-source dictionary using AST literal interpretation and verified every beta/gamma value at depths 14 and 60 against [recovered arrays](2026-09-11-qaoa-recovered-angles.json). Source SHA256 matches `a25049edf7c11dd3a69ee1e36a01bde851fbd86cdf8cf5394cdc8d4fde123821`. No module execution or alternate-angle trial was used. Authenticity of the published table does not establish its linkage to every null-angle benchmark row.

The [replay engine](2026-09-11-qaoa-source-replay.py) was inspected before any target execution; its then-current raw SHA256 was `345fbc3242e1783599a2366dd246e372afdf4eaf3b9e3039dbc1c816e53fb55e`. Signed bitmask predicates correctly identify clause violations; repeated clauses retain multiplicity and tautologies contribute zero. In-place mixer updates preserve both old amplitudes. The reviewer independently ran the synthetic controls: literal evaluation, basis-bit action, three-qubit dense Kronecker evolution, zero-angle uniformity, analytic one-qubit sign tests and memory monitoring all passed.

Frozen tolerances are acceptable for the stated bounded numerical comparison: source absolute error <=1e-8+1e-6 times source probability; norm-squared drift <=1e-10; synthetic dense amplitude error <=1e-12. These are pragmatic numerical acceptance criteria, not a rigorous accumulated-error theorem. One process, one numerical-library thread, 120 seconds for the target pair and 512 MiB peak working set are enforced. No renormalization or outcome-dependent parameter adjustment is allowed.

The final engine only changes output hash metadata relative to that review. Its SHA256-LF is `f6dc1da104221fc6ccfc41a5a55e439ac91d087c716ab56fa2aaeeab948d0805`; the numerical-contract SHA256-LF is `40afde298db1786c6a35cd937aceb9920308f851c373d4cf348f36f537cd51cf`. The reviewer independently recomputed both and matched [status evidence](2026-09-11-qaoa-source-replay-status.json). SHA256-LF replaces CRLF with LF before hashing; it is not the earlier raw-byte convention.

## Source-recovery result

The final [source lookup](2026-09-11-qaoa-source-lookup.json) reports a complete 2,033,188-member filename scan with no filename containing the fixed formula ID. The complete parsed 8-SAT QAOA inventory contains 457,785 metric/reference-only records, with no inline clauses. Other benchmark-category contents were sampled, not exhaustively searched for arbitrary hidden encodings. The sole summary contains aggregates and arrays rather than the target formula. These scopes support **not recovered from the checked source surfaces**, not a universal absence claim.

The reviewer checked the saved lookup and independently recomputed its canonical evidence SHA256: `671b5ba5ab1352df497480c8a7989cea12af370e0ae113cfb2edbeabd9659652`. Reusing the cached summary content, the reviewer independently confirmed exactly one matching record at each requested depth, with complete arrays equal to the recovered table, and no fixed formula ID. This strengthens table-to-summary provenance but does not supply clauses or the missing empirical driver. No duplicate full archive scan was performed by this reviewer.

The source author completed both lookup passes and reports no background scan remains. The actual formula and execution manifest remain absent. Status records **zero target replays** and no target probabilities computed; only synthetic controls ran.

## Final three-lens disposition

**GO for the completed source-recovery/preflight evidence only. The requested target replay remains BLOCKED / INCOMPLETE; S3045 is not complete.**

| Lens | Verdict | Scope |
|---|---|---|
| Source/proof | GO for the scoped lookup; BLOCKED for target replay | Published arrays and summary linkage are checked. Actual clauses and original driver were not recovered. |
| Complexity | GO for synthetic implementation checks only | Numerical engine and prospective limits are reviewable; no source-instance circuit or logical cost has been validated. |
| Non-claims | GO with explicit incompleteness | No reproduction, algorithm failure, ensemble inference, quantum advantage or P=NP result is reported. |

Resume only when the exact CNF/description for the frozen ID is obtained with provenance and literal conventions, then freeze its bytes and execution manifest. Do not substitute another formula, infer clauses from metrics, or search angle/sign variants. The missing source artifact is a provenance blocker, not evidence against QAOA or the surviving S3044 statistical result.
