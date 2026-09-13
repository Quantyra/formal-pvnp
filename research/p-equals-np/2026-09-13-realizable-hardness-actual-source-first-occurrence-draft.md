# ActualSourceFirstOccurrence source-only draft

Date: 2026-09-13. Route: S3131 / S3132 / S3137, formal-pvnp satellite.

Status: UNCOMPILED SOURCE DRAFT. No author or independent build is claimed.
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
