# ActualCompactSourceLookup independent proof review

Date: 2026-09-13. Route: S3131 / S3132 / S3137. Verdict: **GO-WITH-NOTES**
for the exact compact lookup/equality component only.

## Independence and frozen identity

The reviewer did not author CompactLookup. The reviewer authored the future
FirstOccurrence consumer and previously authored related Degree and unary Scan
modules. Consumer source editing remained suspended during this review. This
review does not certify FirstOccurrence. Prior accepted dependency evidence is
relied on explicitly; no CompactLookup author output was used.

Final source freeze: `6a2bf297469a4306c189c8002996e6c4fe62c2ac`.
Raw source bytes equal the frozen Git blobs, with no newline-normalization
substitution for raw identity.

- Main SHA-256: `f9a4ef3052e254edb8bcef06525ad86cec3174b66fa1e60521f07e57b37c4906`.
- Checks SHA-256: `0488e76d5650b748b87608642e249d7411287a1b62cff77d63cb591aba861420`.
- Author packet SHA-256: `64e9898001ea505f13b929cf7233c28cf3228d3940b9fbf4d631715ff3712f1b`. Its null final-freeze field is prefreeze metadata; the separately verified commit above establishes identity.

## Independent execution evidence

Fresh root: `certifications/realizable-hardness/.lake/build/actual-compact-source-lookup-independent-20260913`.
Actual session 14164 terminated with exit 0. Main and Checks each returned 0.
Lean 4.34.0-rc2 commit `6a10ac8c22beadecabdbb0919c2b50214762f91d`;
11 manifest package pins verified. The runner used one Lean thread, 768 MiB
preflight and a 640 MiB owned-process stop threshold. Minimum available memory
was 2,213,240,832 bytes for main and 2,279,137,280 bytes for Checks; no stop fired.
No source repair, heartbeat override, download, or broad rebuild was performed.

All 2,623 dependency files were freshly copied from original exports, including
accepted independent Normalization main and the inherited Materialize closure.
Seven original receipts were verified. Six direct mathlib exports retain their
explicit current-only provenance; 180 source records and their original source
hashes were checked. Duplicate output paths cannot silently disagree. Originals,
copies, receipts, sources, logs, snapshots and final outputs were rehashed after
execution. Both pregrant and granted plans are embedded separately.

Checks printed 13 axiom profiles, each exactly `propext`, `Classical.choice`,
`Quot.sound`; four examples and three signatures elaborated. Main emitted only
the two expected deprecated `if_pos`/`if_neg` warnings. Checks was warning-free.
The raw runner, plans, logs, terminal metadata and snapshots are embedded as
UTF-8 decoded from raw bytes, preserving their recorded hashes.

Portable evidence JSON SHA-256:
`6a18a673bacc31303fc3771564a65275d771e366fbce24eb8e86b8fd6d5c4be4`.
File: `2026-09-13-realizable-hardness-actual-compact-source-lookup-independent-proof-review.json`.

## Adversarial source audit

Read the full main and Checks, final repair diff, SourceNormalization definitions,
and PosScan lookup/count statements. The final repairs only destruct the actual
triple product and order equality-flag rewrites; contracts are unchanged.

`tableFromWire` extracts the actual encoded row list. `rowCount` counts its
entries and `slotClock` has length exactly 3m. The latter uses `mulC` and is a
length clock, not a theorem that its bits are true marks. `ownerLookup` divides
the unary query by three for the row and dispatches on its remainder for the
right-associated triple column. The output retains the entire Nat binary
serialization; no unary expansion of the original numeric label occurs.
The total raw lookup function has the stated FP proof. Correctness uses a
finite valid row and column, not an assumed lookup equation.

`equalityMark` compares complete serialized bitstrings, then converts the flag
to `[true]` or `[]`. Encoding injectivity yields equality of the original Nat
labels, including different labels with equal encoded lengths. `[false]` is
not used as a search miss. Repeated rows and labels are preserved; no Nodup or
row-distinctness premise appears. RHS validity is unnecessary for label lookup.
Empty row lists have no valid finite row query, while the raw function remains
defined. The input length bound is for the actual table-plus-unary-query wire.

## Limits

The concrete discharged gap is full binary owner-label extraction and an exact
empty/nonempty equality marker with same-function FP and valid-query semantics.
This pair proves no first-occurrence search correctness, normalized-table
materializer, whole-source producer FP, finite-carrier bridge, encoded hardness
reduction, upstream hardness theorem, learning theorem, or P-versus-NP result.
Those obligations remain separate. No novelty or publication claim is made.
This is the proof-adversarial lens; separate complexity and non-claims reviews
and root closeout remain distinct requirements.
