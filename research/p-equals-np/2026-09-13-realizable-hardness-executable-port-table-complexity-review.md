# Independent complexity review: actual port-cycle table

2026-09-13. S3132/S3137 under S3126. Reviewer specialization_complexity_review, independent of Table authorship. **GO-WITH-NOTES for the actual ordered table materialization, same-function FP and wire bound.** This is the complexity lens, not independent build acceptance. At assignment, the independent pair session 38355 was still running; author success is not substituted for that result.

## Evidence

Read complete ExecutablePortTable main and Checks; the actual library Materialize.materialize_mem_FP proof, ListEncode listEncFn and its state-bound/ordered-encoding interfaces, NatEncode encodeListFn and its FP/equality proof, and the imported rotation and fixed-table definitions reviewed previously. Re-read the planning formal-three-lens-closeout protocol. No compiler, Git, source, package or public operation was performed. Only this review was created, untracked for root freezing.

Both current raw sources equal freeze `45e7ceede7b17cf083ea56c23a0f485e78743c62`:

- Main SHA256 `072922f7590d18226c27a52b163654e604df3dd827bfb70bd9e7918284ebf839`.
- Checks SHA256 `572bd4ecdbcdcbdbc0f0a29bebace9630b9d2a7e8b4a0aeebf25418536e2c7a3`.

Checks covers fifteen named axiom profiles, three full signatures and seven examples. These are coverage statements from source, not a claim that this reviewer ran those commands. Independent compilation and full dependency evidence remain the separate proof/build lens.

## Constructed loop and FP content

The one function tableFn maps every raw bitstring z to a table for n=|z|. It constructs a unary clock of length n*D*3, where D is the single fixed base-family degree. The clock is not a caller-supplied binary natural or an assumed polynomial bound. marks and mulC construct it in FP. The row rule uses total projections, constant division/modulo, pairing, the accepted same-function rotationFn and actual bit-list encoding. Its private stages establish FP for the actual composition and rowRule_eq_stage relates them definitionally to the public rowRule. There is no supplied runtime or hidden fast-function equality premise.

The library materialize_mem_FP does not leave listEncFn's state bound as an unproved hypothesis. It derives a polynomial output bound q for the FP row rule, substitutes Q=q composed with (3X+2), bounds each indexed row argument by that size, bounds the concatenation by input-length times Q, and discharges the iteration state bound with 4XQ+3X+6. Thus tableFn_mem_FP uses a genuine bounded-iteration theorem with its needed bound already proved. This does not confuse a polynomial output bound alone with polynomial runtime: the row rule's FP premise and the actual iteration closure are both present.

D and the chosen finite base precede all input lengths. Classical choice of that fixed finite base supports existence of one uniform polynomial-time program with its finite constants hardwired; it is not arbitrary advice changing with n. Numerical extraction of the chosen base and practical program evaluation remain unprovided. The module's noncomputable declaration is compatible with this precise FP existence statement.

## Exact table identity

rowAt uses mixed-radix coordinates v=q/3/D, j=(q/3)%D, i=q%3. The range is exactly n*D*3. The source proves the mixed-radix inverse on j<D and i<3, then expands the range to nested v/j/i loops. Vertex varies slowest and label fastest. It converts these loops to the same finRange loops used by FixedPortCycleFamily.table. No canonical-order premise is assumed; rows_canonical_order and rows_eq_actual_table prove it.

numericRow contains both the source dart and the actual rotation result. numericRow_agrees uses the exact accepted rotationFn agreement. Therefore tableFn_eq gives exact serialized byte equality to the mapped actual replacement table, retaining ordering, both endpoints, duplicate rows, loops and parallel darts. It is stronger than equality of graph edge sets or a list permutation. This is the degree-three port-cycle replacement table, not merely the library's upstream tower table returned by famTableFn. The upstream table is used inside rotation computation, not silently substituted for this output.

The final equality and FP statements concern the identical tableFn. There is no graph-equality, canonical-order, spectral, size or runtime premise attached to tableFn_eq. For n=0 it returns the encoded empty list, which is two framing bits rather than an empty failure string. For every raw z, tableFn z equals the table on unary |z|; arbitrary bit values are intentionally ignored. This is a length-indexed total function, not a parser that rejects malformed unary syntax.

## Checked wire arithmetic and cost measure

Actual pair_length is 2*|first|+2+|second|. Hence output(v,j,i)=pair(pair(unary v)(unary j))(unary i) has exact length 4v+2j+i+6. For valid endpoints, each dart encoding has the conservative bound 4n+2D+8 (using v<n, j<D and i<3). A pair of two such dart encodings has length at most 2*(4n+2D+8)+2+(4n+2D+8)=12n+6D+26. This independently checks every pairing level, avoiding the earlier Rotation review's corrected length-arithmetic error.

Encoding one row bit-list adds at most a factor four and two framing bits, so each encoded entry is at most 4*(12n+6D+26)+2. Encoding the outer list concatenates those already encoded entries and adds two framing bits. There are exactly 3nD entries. Consequently the proved bound is

    2 + 3nD * (4*(12n+6D+26)+2).

For fixed D this is quadratic in n. The source wireBound_eval matches that expression, and tableFn_wire_bound derives it from actual row lengths and list concatenation; it is not a bound on an unrelated abstract representation. The table's FP bound may have larger degree than this explicit output bound because repeated rotation lookups and materialization must also execute. No quadratic runtime theorem is claimed.

The all-input FP and wire theorems are in |z|=n. They do not establish polynomial cost in log n. A final source reduction may use this function only after proving that its requested graph size n and unary clock construction are polynomial in the original source-input length, with fixed-L constants selected first. This component does not itself prove that source-size connection.

## Remaining scientific scope

This increment closes the actual serialized replacement-table construction step, subject to completion of the independent build and other lenses. It does not create the occurrence/equality gadget, select or enumerate formula occurrences, prove fresh-variable bookkeeping, enforce degree<=10 and pair intersections<=1, count gadget violations, transfer the near-perfect YES and absolute NO gap, or establish specialized source hardness. The graph may have loops and parallel darts; later gadget accounting must explicitly handle them rather than assuming a simple graph. It also does not settle sampler original-source bounds, arithmetic runtime, the modified PCP, decoder, learning, full-paper formalization, novelty or P versus NP.

Historical source comments about uncompiled status and Rotation pending review must be reconciled with completed evidence at final artifact preparation. This review neither rewrites those receipts nor grants publication approval.

Remaining to-do list: S3137 verifies the independent Table terminal result and remaining lenses before bounded acceptance; S3132 constructs actual occurrence gadgets and specialized source hardness with original-source size bounds; S3131 proves the actual source-parameter/coin-ruler and bounded executor bridge; S3134/S3135 completes decoder and parameter assembly; S3136 completes learning; S3128 reconciles and consolidates the finalized paper/proof with fresh-checkout verification. Full S3126 remains open.
