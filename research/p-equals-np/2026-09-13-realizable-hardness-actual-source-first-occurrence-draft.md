# ActualSourceFirstOccurrence source-only draft

Date: 2026-09-13. Route: S3131 / S3132 / S3137, formal-pvnp satellite.

Historical initial status: UNCOMPILED SOURCE DRAFT. The author verification
update below supersedes the initial build status; independent acceptance is pending.
At initial draft time no author or independent build was claimed.
CompactSourceLookup is author-green pending independent acceptance; importing
its source here does not constitute acceptance. No compiler or Git action was
performed for this increment.

## Exact function and argument

`firstFn` takes `Complexity.pair T (replicate q true)` and searches the actual
table with `findFirst hit`. Its context stores the complete binary label from
`ownerLookup` at the query. `hit` uses full bitstring `equalityMark`, producing
exactly `[true]` or `[]`. It does not compare encoded lengths or treat `[false]`
as an empty hit. The clock is `marks (mulC 3 (posCount T))`: `mulC` itself emits
false bits, and `marks` preserves its numeric length while satisfying the
existing true-mark search API. On the actual table its length is exactly 3m.

The source states FP for this same raw function. Correctness uses the actual
Source row list and finite row/column div-mod decode, proves lookup agrees
with the flattened row-major labels, and obtains the least-hit property from
`List.idxOf` minimum. `search_correct` proves exact unary output, not only its
length. There is no first-correctness premise. Repeated labels and repeated
rows remain in the actual flatten list. No Valid/RHS length assumption is
needed to search labels; for empty rows the finite valid-query domain is empty.

The Checks source requests 16 axiom profiles, 5 examples, and 3 signatures.
These are requested checks, not observed compiler results. Examples include
repeated labels and duplicate rows. Input and internal search-wire lengths
are stated for actual encodings; output length is strictly below 3m.

## Remaining obligations and boundary

Elaboration must still be checked, particularly dependent getElem transport,
row-major flatMap induction, and idxOf/findIdx definitional conversion. No
proof repair may weaken the same-function or least-occurrence targets.
Later work must materialize all renamed rows, join the compact whole-source
wire to the exact unary normalized table producer with FP and bounds, preserve
RHS encoding, and bridge normalized addresses to the finite occurrence
construction. No whole-producer FP, encoded reduction, upstream source
hardness, complete gap theorem, learning result, or P-versus-NP claim follows
from this draft. No novelty or publication claim is made.

Raw SHA-256 (UTF-8 files):

- Main `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualSourceFirstOccurrence.lean`: `989829874c9b1d72fce5d1ca50b1e6913097e9316e1039fa79fcd085f5d1b014`.
- Checks sibling `ActualSourceFirstOccurrenceChecks.lean`: `4046bd80666970ca800570018a5314ba0c2e674d2b7864c9b45991d504566dcd`.

Authorship disclosure: the author previously implemented related degree and
unary occurrence Scan modules, and is not the author of CompactSourceLookup.
Any subsequent independent CompactSourceLookup review must disclose this
future-consumer authorship and suspend FirstOccurrence source editing during
the dependency review.

## Author verification update

CompactLookup was independently checked in session14164 and root accepted in
planning d3bf660 after all three lenses. FirstOccurrence compilation began only
after that acceptance and a sole compiler grant. The initial source baseline is
freeze `b6cfbe67589efc169f6145e0551b2a64104e8b58`; it is not the repaired main.

Sessions45842 and45572 each returned actual main exit1 without a memory stop.
The first exposed function unfolding, a specialized induction argument and
missing explicit flattened-index bounds. The second exposed remaining cons
index and optional-get transport. Root authorized proof-only repairs after
reading each actual log. Final session48892 returned main0 and Checks0. All
four actual outcomes [1,1,0,0], raw logs, terminal metadata and four source
snapshots are preserved. No function definition or theorem statement changed;
repairs unfold the same firstFn, reduce three explicit cons steps, and rewrite
optional get with proved bounds before Option.some.inj. No unchecked indexing
or heartbeat escalation was introduced.

Final main SHA-256: `9321feb3019303b869acdf80dbf7ef593bfc27b56565707a97a5e7ae23d2cfb0`.
Checks unchanged: `4046bd80666970ca800570018a5314ba0c2e674d2b7864c9b45991d504566dcd`.
Checks produced16 profiles: rank_decode uses propext/Quot.sound; the other15
use the standard three axioms. Five examples and three signatures elaborated.
Main has two deprecated-if warnings; Checks is clean. Compiler released after
the actual successful session terminal. No independent acceptance is claimed.

Fresh scoped author root:
`certifications/realizable-hardness/.lake/build/actual-source-first-occurrence-author-20260913`.
The 2624 originals and fresh copies include the original independent CompactLookup
main and the inherited original Normalization/Materialize closure, with eight
receipts. Six direct current package exports retain current-only provenance;
180 source records and11 package pins remain explicit. Originals/copies,
receipts, current exports, original/current source records, target sources,
logs/snapshots, final outputs and package pins were rehashed after execution.
No target author export was reused as its own dependency.

One Lean thread;768MiB physical preflight and640MiB owned-child stop threshold.
No guard fired. Minimum physical memory was1263947776 bytes across all attempts;
successful main/Checks minima1763700736/1928105984 bytes. Original pregrant,
dependency-accepted pregrant and each attempt plan remain separate.

Portable author packet: `author-verification.json` in that root, SHA-256
`b016b1eac345fa6e7f444e91c26238a046681ac031dd8285435d825d027e3649`.
Its `final_source_freeze` is explicitly null pending final source freeze;
the original draft-freeze field does not identify the repaired main. Runner,
plans, logs and snapshots are embedded from raw byte-decoded UTF-8 without
newline normalization. The exact repair diff is included.

The same-function first-occurrence component is author green. Independent
review, actual normalized-row materialization and whole-source producer FP,
finite-carrier bridge, upstream hardness and complete reduction/paper remain
separate obligations. This update makes no publication or novelty claim.
