# ActualOccurrenceScan independent proof review

Status: GO-WITH-NOTES for bounded same-function unary ordinal scanner; independent pair compilation passed. Source freeze 633f4df6ee66e76a3cc441bccc3b703980b61a67.

Reviewer: lookup_independent_proof, top-level proof-adversarial lens; not author of Scan. I previously independently reviewed the imported Lookup and Prefix pairs; their accepted original artifacts are reused, not author Scan exports.

## Source audit

sameOwnerMark receives pair(original query wire, unary current index). Its nested projections recover the actual table and query. It compares the lengths of the current and target ownerLookup outputs. On the serialized unary owner table this is exactly owner equality: each owner result is replicate(owner.val,true), and Fin.ext converts value equality to owner equality. This would not be an equality test on arbitrary binary label strings; the theorem correctly specializes to the actual unary wire.

ordinalScan uses countOver sameOwnerMark with pair(pairSnd z,z). The unary query length is therefore the loop bound, so it counts strictly earlier slots. Both FP proofs compose pinned total projections, pairing, ownerLookup and countOver for the very functions in the correctness theorems. Function.comp_def normalization is a proof presentation step, not an alternate abstract algorithm.

The countOver length theorem gives the sum over indices below rank o. Prefix.decode maps each such index to its actual slot and rank_decode supplies the same loop counter. The finite sum/countP bridge preserves actual order via the independently accepted exact prefix list. The subsequent equality is to I.ordinal for this very owner and slot, not a caller-supplied ordinal law. countOver_eq_replicate establishes all output bits are true, so length equality yields the full unary output equality. The strict size bound comes from the actual Fin ordinal.

The external query wire has exact length 2*table.length+2+q. Its internal countOver argument has exact length 2*table.length+3*q+4; the clock is unary and included in this accounting. Valid slot bounds use rank < 3*m. No polynomial relation to the original unnormalized binary source is inferred.

Thirteen axiom queries, five examples and three signatures are present. Two deprecated-if warnings were reported by the author and are expected only as style notes. No sorry, admit, new axiom or native_decide occurs in the reviewed pair.

## Boundaries and preparation

This is an encoded FP ordinal scanner relative to an already supplied serialized unary table. It does not prove the table producer FP, source normalization runtime, the complete constructor, upstream NP-hardness, full paper theorem or learning corollary. Empty sources have no valid slot query; raw function totality is still covered by FP.

Fresh root actual-occurrence-scan-independent-review-20260913 reuses 2625 original accepted dependency artifacts, six explicitly current direct package exports, and 178 current/original Materialize source identities. No author Scan output is copied. Receipt hashes use an explicit cache. Source bytes match the final freeze. The original preparation withheld compiler authorization and remains preserved. The later root grant and actual build evidence are recorded below.

## Actual independent build closeout

Session 7511 terminated with actual exit 0. Main and Checks each exited 0 on the first independent attempt, with unchanged source and no memory-guard stop. Thirteen profiles are subsets of propext, Classical.choice and Quot.sound; five examples and three signatures elaborated. Main has exactly the two expected if_pos/if_neg deprecation warnings; Checks is clean. Both used Lean 4.34.0-rc2 commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, LEAN_NUM_THREADS=1, pinned eleven-package manifest and fresh scoped exports. No source repair or author Scan output reuse occurred.

Runner SHA256: `8017cb3fc4bbdf5820d804e7b401d5749e6274649ef39aa97626360b80824b15`. Preserved pregrant preparation: `3bc4afdf1b6f73a3987501571404f92abbac6872b439bb6878b182bc3f14543d`. Authorized preparation: `f6bc7efb2845c5e945e691effdaab19fa08cafe054a72d197e4f79d4f50d9d4b`. Portable JSON SHA256: `5efd0129cb8ea768b0dbc84757403609a623e51e21723a0b205ba6428536633e`. JSON embeds raw logs, metadata, source snapshots, runner and preparation, and records original/copy artifact hashes. This is the proof-adversarial lens, not a full-theorem certification. Compiler released; no Git action. Final artifacts use explicit UTF-8 LF; embedded raw records retain their original newlines.
