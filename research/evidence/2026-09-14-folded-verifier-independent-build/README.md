# Fresh folded verifier and Checks build

S3137/S3126, 2026-09-14. PASS for fresh exact-source execution; root acceptance remains separate. Session17675 actual terminal0, main0/Checks0, both unchanged and guardfalse. Sole compiler was explicitly released. No source edits or Git actions occurred.

Both source inputs were copied from committed recovery5e49b7c, with raw hashes a84b6da84c406ce3e0725b16b98b6582473c3a69a0b948a5efa2c89d228f75f3 and1b70a36cfd2ad51b985dd94ce53b9b73d348cc9d33657fe2f7491acef6c6d999. Fresh root excludes all prior verifier/Checks exports. Checks imports only the newly built main. Run command: python certifications/realizable-hardness/.lake/build/actual-folded-verifier-independent-review-20260914/review-runner.py from formal-pvnp. Exact Lean command/environment/version and all per-child hashes are in the metadata and verification-summary.

Preparation verified308original lower artifacts and receipt identities/copies; preflight rechecked source pins,11packagepins,123current package exceptions,manifest and fallback absence. Current package exports establish identity, not historical provenance; original receipts/dependencies remain external and are not recursively embedded. This archive is durable run evidence, not a self-contained fresh-checkout dependency bundle. Guard thresholds remain3.5GiB start/640MiB globalavailable stop and one thread; no heartbeat increase.

Checks has19examples/5signatures; raw profile audit reconstructs all37requested names,36using only propext/Classical.choice/Quot.sound and one empty. One theorem name was split by native profiler output: assignments_ followed by1428complete timing lines, then length. The reconstruction removes only that exact contiguous timing-only insertion; every removed line matches a native timing record, and original log bytes are preserved. The complete removed lines/hash and reconstruction rule are in profile-interleaving-reconstruction.json. Initial generic-parser summary is retained. An initial overly broad in-memory prefix selection was rejected because it included another profile; only the unique prefix immediately followed by interpretation text is used. No missing theorem name or axiom is inferred from a count. Root may independently verify this reconstruction.

| Module | Exit | Warning headers | Output SHA256 |
|---|---|---|---|
|ActualFoldedParityVerifier|0|6|6aa2fc99204cb285aec7bee9384b96146efa730d88c5322533b1235afdfe5811|
|ActualFoldedParityVerifierChecks|0|7|7b2cdbbffdd2398872a6cc9b02a9ad3433a01396022b3650b624e36c36766165|

All errors are absent. Warnings remain verbatim in the summary/raw logs (main6,Checks7); they are not suppressed. The main/Checks mathematical scope is actual finite conditioned folding, shared addresses, local honest noise identity and GF2 row equivalence. No Fourier probability bound, whole CNF producer FP or full paper hardness theorem follows.

The verifier did not author these target modules/repairs, but contributed related lower encoding work and earlier semantic reviews; this is disclosed. No claim of independence from every lower dependency is made. Outputs stay in the isolated root and are bound by hashes; original raw evidence is retained.
