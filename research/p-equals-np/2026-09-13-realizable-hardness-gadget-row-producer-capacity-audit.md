# GadgetRowProducer capacity audit - 2026-09-13

S3137; read-only operational evidence audit by incidence_complexity_review, the Gadget author. This is not an independent mathematical review or build acceptance. Only this note was written; no source, runner, compiler, Git, application, or system-setting changes were made.

Recommendation: queue the unchanged e9c5c6aaf69c05856445e9a6aa1a969063b06f29 source until the prior compiler owner explicitly releases and a fresh measurement immediately before Lean child creation reports at least **3,758,096,384 bytes (3,584 MiB; 3.5 GiB)** available physical memory. A new root compiler grant and the existing provenance checks remain required. Keep one thread and the **671,088,640-byte (640 MiB) guard**. The higher start threshold is scheduling margin, not a proven sufficient bound or full-peak guarantee.

## Exact existing evidence

Paths below are repository-relative. SHA-256 values identify the raw metadata bytes reread for this note. Values in the table are exact bytes; drop = pre minus recorded minimum. These are machine-wide available-physical-memory measurements, **not Lean RSS**, and include unrelated OS/application changes. Minima are sampled, not continuous peak measurements.

| Record | Pre bytes | Minimum bytes | Drop bytes | Actual exit | Guard stopped |
|---|---:|---:|---:|---:|---|
| 1: ExecutablePortRotation-1789287451472876200 | 4292194304 | 2367516672 | 1924677632 | 0 | False |
| 2: ActualOccurrenceCountFP-1789306623089400300 | 3406770176 | 1382522880 | 2024247296 | 0 | False |
| 3: ActualSourceNormalizedTable-1789304772418591000 | 3406454784 | 1887162368 | 1519292416 | 0 | False |
| 4: ActualOriginalRowProducer-1789309427528639100 | 2946609152 | 1089900544 | 1856708608 | 1 | False |
| 5: ActualOriginalRowProducer-1789309894186886400 | 3176902656 | 1282494464 | 1894408192 | 0 | False |
| 6: ActualOccurrenceCode-1789307358522028400 | 3330314240 | 1262858240 | 2067456000 | 1 | False |
| 7: ActualOccurrenceCode-1789307716249147600 | 3106713600 | 1221062656 | 1885650944 | 0 | False |
| 8: ActualGadgetRowProducer-1789321905290465900 | 2681298944 | 661848064 | 2019450880 | 1 | True |

1. `certifications/realizable-hardness/.lake/build/executable-port-rotation-independent-review-20260913/diagnostics/ExecutablePortRotation-1789287451472876200.json`

   Raw SHA-256: `4c4fec0e15a19a311e2d00fd1aa4a5452e7d35cd0e687ade67457d29c17ad6a9`.

2. `certifications/realizable-hardness/.lake/build/actual-occurrence-count-fp-independent-review-20260913/diagnostics/ActualOccurrenceCountFP-1789306623089400300.json`

   Raw SHA-256: `63c0ce6f353c467e7d925efe980e37dc1adbb7743eace238b215f5ef6e7786ab`.

3. `certifications/realizable-hardness/.lake/build/actual-source-normalized-table-independent-review-20260913/diagnostics/ActualSourceNormalizedTable-1789304772418591000.json`

   Raw SHA-256: `8b67ba198d98adf106601e379b06e0191f42790c058da3c85a65d3efabd98090`.

4. `certifications/realizable-hardness/.lake/build/actual-original-row-producer-author-20260913/diagnostics/ActualOriginalRowProducer-1789309427528639100.json`

   Raw SHA-256: `6e35a5d91792b5f9e3eb2070a0e32d5b74cb82f444130d2da546f9665e588e3b`.

5. `certifications/realizable-hardness/.lake/build/actual-original-row-producer-author-20260913/diagnostics/ActualOriginalRowProducer-1789309894186886400.json`

   Raw SHA-256: `1689a9102f6c914d391ec3d8b4f0e50a5014986f9d023ab0474e74711b96f54f`.

6. `certifications/realizable-hardness/.lake/build/actual-occurrence-code-author-20260913/diagnostics/ActualOccurrenceCode-1789307358522028400.json`

   Raw SHA-256: `0280eb3dbd0aed36c6df64a904ecac49d0bde3204dc0ce8ef9a80108ef34c16f`.

7. `certifications/realizable-hardness/.lake/build/actual-occurrence-code-author-20260913/diagnostics/ActualOccurrenceCode-1789307716249147600.json`

   Raw SHA-256: `a48c7eb4078c7fdea06b49216c9d8a42da1873bfa5e04e11f88975219f4c2080`.

8. `certifications/realizable-hardness/.lake/build/actual-gadget-row-producer-author-20260913/diagnostics/ActualGadgetRowProducer-1789321905290465900.json`

   Raw SHA-256: `cfa913ef7dab7e56eba15d2ead85dbef6bd80fdbf3e92b098cf4f9a403d8c99e`.

## Derivation and execution boundary

The largest observed comparison drop is 2,067,456,000 bytes (1971.7 MiB), from the first Code author attempt, which completed with elaboration errors and was not guard-stopped. Adding the unchanged guard gives 2,738,544,640 bytes (2611.7 MiB). The proposed 3,584 MiB start threshold adds 1,019,551,744 bytes (972.3 MiB) above that empirical floor. The successful comparisons and the separately labeled non-guard elaboration failures support a conservative scheduling choice; they do not establish Gadget's unknown remaining peak.

Gadget session 51976 actually terminated with exit 1 and guard_stopped=true. Its minimum was 661,848,064 bytes; its source remained unchanged, output hash was null, and its log was empty (SHA-256 `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`). Thus this attempt supplies no mathematical diagnostic and warrants no proof repair. The compiler was explicitly released; no retry is authorized by this note.

Runner evidence: `certifications/realizable-hardness/.lake/build/actual-gadget-row-producer-author-20260913/author-runner.py`, raw SHA-256 `cff3dc6bec67a6ed089e91f6e86bfcd07096e7d186845e26ffa450fe53fdb587`. The existing runner checks 805,306,368 available bytes before each child, uses GlobalMemoryStatusEx available physical memory, sets LEAN_NUM_THREADS=1, samples every 0.25 seconds, and terminates its owned child when the recorded minimum falls below 671,088,640 bytes. It does not currently enforce the recommended 3.5 GiB scheduling threshold. A future authorized retry must arrange the additional immediate pre-child check; an earlier orchestration-time check alone can become stale during provenance verification. No runner edit was made here.

The runner hashes files with read_bytes. Streaming hashes could reduce temporary allocation during provenance work, without changing Lean source, but no measurement here establishes enough savings to make a below-threshold retry safe. This is an optional future runner-only optimization, not an implemented remedy or justification to loosen the guard.

Root subsequently reported OriginalRows independent session 13632 actual pair 0 and explicit compiler release, then acceptance record 32bf985. Root's latest supplied free-memory observation was 2,720,564 KiB (2,785,857,536 bytes), below the proposed threshold; this is attributed orchestration evidence, not a fresh OS measurement performed by this audit. Leave Gadget queued, with exact source semantics unchanged. Do not close user applications, change system settings, loosen the guard, or run repeated trial builds to obtain capacity. No full constructor, runtime theorem, hardness, novelty, or publication claim follows from this operational audit.
