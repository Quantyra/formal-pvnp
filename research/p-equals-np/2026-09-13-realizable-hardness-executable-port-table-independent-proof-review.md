# Independent proof review: complete encoded port table

2026-09-13. S3132/S3137 under S3126. Reviewer `/root/matrix_identity_independent_proof` did not author ExecutablePortTable. **GO-WITH-NOTES for the exact FP table and serialization increment.** Full main/Checks and the underlying list materialization proofs were read; no statement or mathematical blocker found.

Target freeze `45e7ceede7b17cf083ea56c23a0f485e78743c62`. Main SHA256 `072922f7590d18226c27a52b163654e604df3dd827bfb70bd9e7918284ebf839`; Checks `572bd4ecdbcdcbdbc0f0a29bebace9630b9d2a7e8b4a0aeebf25418536e2c7a3`. Raw/current versus frozen identities are recorded separately in the accompanying JSON. Author packet hash supplied for this scope is `0457d633303216d481efb1611de03aab2d5fa16f7a52904c208082194511f0bb`; author outcomes do not substitute for an independent build.

## Actual function and bounded iteration

tableFn interprets the length of every input string as n. It creates its own unary loop count n*degree*3 and invokes listEncFn on the actual rowRule. The FP theorem concerns this exact tableFn, with no caller-supplied loop bound, runtime proof or output equality. Private stage definitions isolate the same projections/divisions/moduli/pairings/rotation/encoding used by rowRule. rowRule_eq_stage is proved by unfolding these definitions; it is not assumed. stageR uses the already independently accepted rotationFn, and its composition order is stageInput followed by rotationFn.

Inspected materialize_mem_FP and listEncFn_mem_FP in the pinned library. The materializer derives a polynomial output bound from the FP row rule and uses the argument's unary counter length to bound the iteration state. Thus this application is not invoking an unrestricted iteration closure or assuming the required polynomial state bound. The constructed counter has linear length in n because the fixed family degree is constant. The explicit final wire bound is additional size evidence; it is not being used circularly to infer runtime.

## Exact rows and serialization

rowAt decomposes counter q as v=q/3/degree, j=(q/3)%degree, i=q%3. rowAt_mixedRadix proves inversion for (v*degree+j)*3+i with bounded j and i. Canonical-order proofs expand finite ranges using ordered flatMap/map identities, so vertex varies slowest and dart label fastest. They prove literal ordered-list equality, not merely a permutation, matching the actual accepted FixedPortCycleFamily.table enumeration.

numericRow emits both the source dart and the output of the actual rotationFn. numericRow_agrees uses the accepted pointwise rotation theorem to identify this with the actual graph rotation row. The range-to-finRange conversion preserves this order and every occurrence. Loops and repeated/parallel darts are retained, with both endpoints serialized.

rowRule emits the DataEncode encoding of an individual raw bitstring row. listEncFn then supplies the outer list framing. tableFn_rows identifies the full output with DataEncode.bitstringEncode of the row list, and tableFn_eq substitutes the actual table list. There is no confusion between a raw row bitstring and its list-element encoding. The exact equality holds for every raw z, with table size z.length; arbitrary bit contents are deliberately interpreted by length rather than rejected by a canonical unary parser.

At n=0 the row count is zero and the function emits the encoded empty list, not necessarily an empty tape. tableFn_zero states that precise encoding. No valid-vertex premise is silently needed for the all-input equality: valid finite vertices are used only for individual rows inside the nonempty range. Degree positivity handles divisions and mixed-radix index bounds.

## Complete wire bound

output_length counts both nested pair delimiters and unary coordinate payloads. rowWire_length_le bounds both endpoint encodings using their actual Fin ranges. rowAt_length_le derives those ranges from q<rowCount n, then uses the actual graph agreement. bitList_encode_length_le includes each bit's DataEncode overhead and its list wrapper. The outer accumulation adds its own two framing bits.

Consequently the full bound is 2+n*degree*3*(4*(12*n+6*degree+26)+2), represented by wireBound. It is a polynomial in the input length n for the fixed degree. This does not assert polynomial complexity in binary log n, a small numeric degree, or an extracted executable base table. The inherited fixed Classical.choose base is fixed independently of n; the FP claim is the established existential machine claim for that fixed object.

## Independent verification preparation

A fresh pair output root is prepared using 2764 original accepted artifacts: the earlier 2762-file rotation dependency closure plus the two independently accepted Rotation exports. The 212 upstream source identities, local/frozen LF distinctions, traces, acceptance receipts and original/copied artifact hashes are rechecked. No Table author output is reused and no dependency source is rebuilt.

The narrow runner preserves source snapshots/raw logs/actual terminal metadata, checks source freshness and absent target exports, all artifact/receipt hashes, pinned Lean/manifest/eleven packages, one thread, 768 MiB physical-memory preflight and 640 MiB owned-child stop. Expected results are fifteen profiles, seven examples and three full signatures; actual independent results are still required. Embedded text uses raw UTF-8 byte decoding with explicit source normalization distinctions.

This scope does not provide a full occurrence gadget, gap-3Lin reduction, specialized source hardness, full paper theorem or submission readiness. No source edits, package changes or public actions are authorized by this review.

## Independent build completed

Authorized session 38355 compiled main and Checks with actual EXIT 0 and unchanged sources, then terminated EXIT 0. Fifteen emitted profiles were parsed and use only propext, Classical.choice and Quot.sound; seven examples and three full-signature checks compiled. The printed FP, serialized equality and wire-bound signatures name the identical tableFn and have no extra premise. Main log is empty; no diagnostics were emitted. All 2764 original/copied artifacts and 212 original/local source hashes were rechecked after the run, along with the two source/log/output/metadata triples. Compiler ownership was released immediately. No source repair, retry, download or public action occurred. Full occurrence-gadget/source-hardness and paper completion remain open.
