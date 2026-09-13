# ActualOccurrenceCountFP isolated draft

2026-09-13. S3131/S3132/S3137. SOURCE ONLY, UNCOMPILED. No compiler or source
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
