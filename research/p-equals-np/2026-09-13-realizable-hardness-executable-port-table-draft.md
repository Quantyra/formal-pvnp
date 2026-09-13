# Actual serialized fixed-family rotation table: source draft

2026-09-13. S3132/S3137 under full S3126. Author: `/root/cmmsa_encoding_nonclaims_review`, in the author role. **SOURCE ONLY, uncompiled.** No compiler, Git, package, download or public action occurred in this increment. The repository root and scoped directories contain no local AGENTS.md; the supplied planning/satellite routing and three-lens instructions remain applicable. This implementation is in the formal-pvnp satellite, not the planning repository.

## Actual object and exact output

The new `ExecutablePortTable.tableFn : List Bool -> List Bool` interprets its input length as n and materializes the complete actual `FixedPortCycleFamily.table n`. It does not use the upstream tower-level table as a substitute. D is the same fixed family degree already used by the graph and the encoded rotation.

There are n*D*3 rows. For counter q, the rule extracts

    v = (q / 3) / D,   j = (q / 3) % D,   i = q % 3.

It constructs p = pair(pair(unary v)(unary j))(unary i), calls the actual `ExecutablePortRotation.rotationFn` on pair(unary n)(p), pairs p with that returned destination, and runs the library bit-list encoder on the result. The outer `listEncFn` writes the list of these encoded rows. Both endpoints and reverse labels are present; no dart, parallel occurrence or loop is removed. The row rule remains total even outside the loop's valid counter range.

`tableFn_eq` states equality, for every bitstring z, to `serializedTable z.length`, defined as `DataEncode.bitstringEncode ((FixedPortCycleFamily.table z.length).map rowWire)`. This is a specified serialization of the actual typed table, not a claim that the existing typed graph has a built-in encoding. `tableFn_unary` specializes to unary n. `tableFn_zero` states the encoded empty list, rather than the empty-string fallback used for an invalid rotation coordinate. Arbitrary z is treated by its length; no canonical-input parser or rejection policy is implied.

## Proof chain and canonical order

The row rule's FP proof composes the pinned divC, modC, marks, pairing, encodeListFn and actual rotationFn FP theorems. `tableFn_mem_FP` then composes the constructed clock/input with `materialize_mem_FP`. Neither theorem accepts a caller-supplied FP certificate, output equality, polynomial bound or expander law.

The loop clock `mulC (D*3) (marks z)` is a word of false bits of the required length. The iterator uses the clock length only. Accordingly `tableFn_rows` uses the exact `listEncFn_eq_bitstringEncode` theorem, whose clock hypothesis is length equality, rather than silently identifying a false-bit clock with a true-bit unary word. The row counter itself is the materializer's true-bit unary counter.

`rowAt_mixedRadix` proves that q=((v*D+j)*3+i), for j<D and i<3, recovers exactly v,j,i. `rows_canonical_order` uses two proved range-product identities to show the actual ascending counter order is v outermost, j next, i innermost. `numericRow_agrees` invokes the same rotation function's actual graph-agreement theorem. `rows_eq_actual_table` then connects the numeric ranges with the original nested finRange enumeration. It proves list equality, retaining order and duplicates; it does not replace equality with a permutation or choose an unproved inverse ordering.

## Full wire bound

The proposed checked polynomial is

    2 + n*D*3 * (4*(12*n + 6*D + 26) + 2).

`output_length` computes 4*v+2*j+i+6 bits for one nested paired unary dart. `rowWire_length_le` bounds the full pair of endpoints by 12*n+6*D+26. Encoding a bit list adds at most four bits per bit plus two delimiters; `bitList_encode_length_le` reuses the actual boolBits cipher bound. `tableFn_wire_bound` sums the encoded rows and includes the outer list's two delimiters, using the materializer's exact accumulated output. The conservative constant avoids unnecessary tightness claims. This is polynomial in unary n with D fixed, not polynomial in log n for a binary size field. The same total tableFn receives both the FP statement and the wire bound.

## Dependency and verification gate

The source imports only `ExecutablePortRotation`, frozen author-green at `b48024f255ed12d70340c5ca16488218ad37b059`. That rotation pair is still pending independent acceptance at this draft milestone. Its source SHA-256 is d204a4333bcd5841623756d856f3c762a278141ed3c15e55f9bb45b043cfc1d2. This draft does not independently certify that dependency. All underlying materializer/encoding primitives were inspected in pinned Complexitylib 6c248df7859f2f245e731c1e07057bf69d165fe2; no new upstream import or package is introduced beyond that rotation closure.

Relevant source interfaces are Materialize.lean:43 `materialize_mem_FP`, ListEncode.lean:157 `listEncFn_eq_bitstringEncode`, ListEncode.lean:85 `bitstringEncode_of_entries`, ListEncode.lean:104 `length_entryCat_le`, NatEncode.lean:151/157 `encodeListFn_mem_FP`/`encodeListFn_eq`, NatEncode.lean:86 `length_flatMap_boolBits`, and UnaryList.lean's actual constant arithmetic. Original graph order is PortCycleReplacement.lean:275 `table`, reused by FixedPortCycleFamily.lean:93.

Fifteen axiom-profile queries, seven examples and complete signatures for FP, exact output equality and the wire bound are authored but unrun. Source inspection cannot establish Lean acceptance. Mixed-radix simplification, nested flatMap/range rewriting and dependent Fin coercions are the likeliest elaboration-repair points. No axiom or sorry is introduced. There is no known mathematical obstruction in the specified construction, but its proof scripts require compilation and then independent three-lens review before acceptance.

| Draft source | Raw UTF-8 LF SHA-256 |
| --- | --- |
| ExecutablePortTable.lean | 0634582e24c54fd58fdb10ef37b0e86004c5baf9003bf069e9ca22f0b38d1c27 |
| ExecutablePortTableChecks.lean | 572bd4ecdbcdcbdbc0f0a29bebace9630b9d2a7e8b4a0aeebf25418536e2c7a3 |

## Remaining original obligation

This is the full-table interface required by the concrete occurrence-cloud reduction recorded in `2026-09-12-realizable-hardness-gap3lin-source-construction-extraction.md`, not another assumed expander wrapper. The next actual construction must select one representative of each nonloop rotation orbit, preserve parallel-edge multiplicity, attach five fresh internal variables per four-equation equality gadget, and prove fresh-name, occurrence-degree, pair-intersection and majority-decoding bounds. With t occurrences the graph has tD ports; the intended cloud loss remains M<=(1+18D)m and NO gap at least min(1,kappa)*eta0/(1+18D), with the actual hypotheses and counting still to prove.

The specialized Håstad/PCP source gap, its executable verifier/unweighting and exceptional branches remain separate essential obligations. A fixed finite base is still existentially chosen once; this does not exhibit its numerical table or an extracted runnable machine. No completed occurrence reduction, full source hardness, decoder, learning theorem, novelty, publication readiness or P versus NP result is claimed. Full S3126 and final verified proof/paper consolidation remain active.
