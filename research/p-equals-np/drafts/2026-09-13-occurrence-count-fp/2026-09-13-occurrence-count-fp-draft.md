# ActualOccurrenceCountFP isolated draft

2026-09-13. S3131/S3132/S3137. Initial status: SOURCE ONLY, UNCOMPILED. No compiler or source
Git action was performed. Files are archived here, outside the live consumer
closure, pending source review and generalized Allocation dependency acceptance.

Main SHA-256: `24600f651bbb3f35423718a5ce0e48e39a73923fb1c9a5417383518a3a8aa79f`.
Checks SHA-256: `2398fc36543278f2502a4a0bf81182096697dcfb5666d4b431567bf325811b46`.

The implementation follows the frozen constructor audit3d661a94. Input is
exactly Lookup's pair(serialized unary table, owner unary); the total raw
countMark compares the extracted owner's unary length to that query. The loop
clock is marks(mulC3(posCount table)), derived from the actual table. The FP
theorem concerns the same occurrenceCountFn used in full-output correctness.
No externally assumed count/size/time bound is supplied.

Correctness converts the actual countOver sum to the full row-major slotList
using accepted Prefix.slotList_eq_decode and rank_decode, then identifies
countP with the actual filtered occurrenceList length. It is quantified over
every owner v, including unused owners, and proves the entire output equals
replicate(I.size v) true. Count <=3m, empty-row output, unused-owner output and
exact external/internal wire lengths are included. This is a full-table count,
not Scan's query-prefix count and not the graph half-edge cloudSizeFn API.

Checks requests14 axiom profiles,7 examples,3 signatures. Its explicit
Instance2 1 assigns all three source positions to owner0 and none to owner1,
with expected counts3/0. This example intentionally requires generalized
Allocation; it must not be changed to add the old distinctness condition.
All numbers here are requested Checks, not observed compiler output.

Source imports Lookup and Prefix; a future isolated build must use freshly
accepted generalized consumer exports. Existing restricted Allocation binaries
do not certify the broader domain. The library API route has no identified
mathematical obstruction. Elaboration, finite sum normalization and concrete
example reduction remain untested. No source dependency was modified.

The structural GlobalVar/row-code injection and assignment bridge from the
constructor audit remain a separate obligation. This pair does not emit
anchors, original equations, retained-edge gadgets, or the entire regularized
instance. NormalizedTable and FiniteBridge remain independently assigned work.
No full constructor FP, source hardness, PvsNP, learning, novelty or publication
claim follows from this draft. Author verification and all required independent
lenses must precede acceptance.

## Author verification update; final archive copy pending

This dated update supersedes the initial uncompiled status for the isolated
author pair only. Initial archival freeze is
`f27abe7be8ddeadb88fec6d778f8732c6b29ccde`; its original receipt is also preserved
byte-for-byte at the author root as initial-archive-receipt.md, SHA-256
`cc790bdf9ce99a7ed8289b7da6aef6df74109298f185664104a28d3824c8404c`.

The main is unchanged in both archive and isolated source, SHA-256
`24600f651bbb3f35423718a5ce0e48e39a73923fb1c9a5417383518a3a8aa79f`.
The archive Checks still has its original SHA-256
`2398fc36543278f2502a4a0bf81182096697dcfb5666d4b431567bf325811b46`.
Final author-green Checks exists ONLY in the isolated author source directory,
SHA-256 `276ee189946266738c345e3abdda6b574b5ceda3f2d8e713dd11af341a63be13`.
Its sole difference is one repeated-owner example proof: replace rw/decide by
the concrete size=3 fact and simpa only [Fin.val_zero, hs, List.replicate_succ,
List.replicate_zero] using the same occurrenceCountFn_correct theorem. No
definition, theorem statement, example target or assumption changes.

Author root: `certifications/realizable-hardness/.lake/build/actual-occurrence-count-fp-author-20260913`.
Session99102 returned actual main0/Checks1, then Checks-only95475 returned1 and
Checks-only30573 returned0. Main was compiled once. Outcomes [0,1,1,0], all
four raw logs/terminal metadata/source snapshots and pregrant/attempt plans
are preserved. The first example failure was Nat/Fin zero rewrite matching;
the second needed explicit replicate expansion. No semantic repair or heartbeat
escalation. Final Checks printed14 standard-subset profiles (13 standard three,
count_wire_length propext/Quot.sound),7 examples,3 signatures. All logs are
warning-free. No guard fired; minimum available memory1416314880 bytes.

Fresh dependency scope is original independently accepted generalized5164 mains
Allocation/Lookup/Ordinals/Prefix, verified against promotiond12ed5b9, plus2624
original lower records. All2628 originals/copies,9receipts,9current-only package
exports,178source records and11package pins were verified; current-only package
provenance is not upgraded. Restricted old consumer exports were excluded and
fallback exclusions rechecked immediately before every launch and afterward.
The runner used isolated cwd/source copies, one thread and768/640MiB guards.

Portable author packet `author-verification.json` in that root:
`ecc6fff0f6aaf50e029c2fe28140d13dcdddd317d5870b00cc0e903c5318b811`.
Companion narrative `author-verification.md`:
`0ce646efb90caf31b2bfe7b5d09983f24e3d81dd4fbf529ead4fe32375f0985e`.
Packet embeds raw bytes decoded as UTF-8, including all attempts, exact repair
diff, dependency records/receipts and archive-versus-final hashes. Its
final_source_freeze is null; initial_archive_freeze does not identify the
repaired Checks. Preserve that immutable prefreeze distinction and record the
eventual actual commit separately.

Proposed final archival scope is exactly this directory's main, Checks and
dated receipt. The main needs no change; copying final isolated Checks into
the archive and committing remain pending explicit root grant. No live source
insertion, independent acceptance, full constructor FP, source hardness,
publication or complete theorem is claimed. Table source reviews are unchanged.

## Authorized final archival copy

Root reviewed the exact repair and all four actual outcomes, then authorized
the final archival copy and exact-three-file freeze. The isolated final Checks
was copied byte-for-byte into this archive: SHA-256
`276ee189946266738c345e3abdda6b574b5ceda3f2d8e713dd11af341a63be13`.
Main remains `24600f651bbb3f35423718a5ce0e48e39a73923fb1c9a5417383518a3a8aa79f`.
This paragraph supersedes pending-copy wording above, while preserving the
chronology. Original Checks2398fc36 remains available in f27abe7b and the raw
failed snapshot. The immutable ecc6fff0 author packet retains its explicit
prefreeze/null-final-freeze status; the actual archive commit is reported
separately after freezing. This copy is not live insertion or independent
acceptance. No further compiler or public action was performed.
