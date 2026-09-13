# ActualSourceNormalizedTable complexity review

2026-09-13. S3131/S3132/S3137. **GO-WITH-NOTES** for this exact normalized-table
and whole normalized-source producer. Source review only; no independent
compiler assertion, live promotion decision, or full-constructor acceptance.

Read the full final main/Checks and dated author receipt, with the actual
FirstOccurrence, Materialize and UnaryList contracts previously inspected.
Freeze `83a45660fe459d00a3ef39c4fd51ef317d33e755` matches all three raw files:

- Main `a4a112c753e7f917663dc1287e7889986bc1d086ab21dfe34cbfa39da8c4e809`.
- Checks `45af1a7d67110ed969622f3cb27fe8c4f66f4dae1cb381242630e72e1f2e85f6`.
- Receipt `1cc00e9149ddf19f0bdb34b0209d9790515df50dd126c9d8837699cf46fdada1`.

Author packet rehashed to `2edad1084b21478d306bd87f09ca0bf3e520a5a096d7557dace476d7b0c1fa3b`
at `.lake/build/actual-source-normalized-table-author-20260913/author-verification.json`
under the companion. Its null final-freeze is explicitly prefreeze metadata;
the separate final commit above identifies the repaired bytes.

Disclosure: this reviewer authored imported FirstOccurrence, not NormalizedTable.
FirstOccurrence's prior independent acceptance is relied on, not self-certified
again. The reviewer also authored CountFP, which does not import this Table
module. This reviewer supplies both complexity and non-claims reports as two
lenses, not two independent people. Independent proof/build review is separately
assigned. No compiler or source changes were performed for this review.

The exact raw producer is sourceFn, not an existential substitute. Its table
stage composes firstFn with three concrete slot counters, then encTriple, then
listEncFn rowRule with posCount of the actual supplied table. marks corrects the
false-bit mulC clock into the all-true query convention. All three fields use
the same original compact table and canonical first-occurrence function. The
rowRule equation identifies the complete right-associated unary triple encoding.
materialize_eq applies at EVERY actual row index and proves ordered list
encoding equality to unaryRows. No external count, search-correctness or runtime
law is an assumption of the producer theorem.

sourceFn uses DATA brackets around the normalized table and untouched encoded
RHS. This differs correctly from Complexity.pair for machine arguments.
sourceFn_correct identifies the entire output with DataEncode(unarySource S),
and both projections are proved. Unary labels are first-occurrence indices;
this is not DataEncode of the binary Nat-labeled normalize S. No original numeric
label is expanded to unary, and no N <= poly(m) premise is required.

The FP proof uses actual composition and materialize_mem_FP, which supplies
the loop-state bound from the record rule. sourceFn_output_polynomial follows
from FP for the same raw function, uniformly over all bitstrings. The separate
explicit bound is 2+m(36m+10) for the table and
4+m(36m+10)+length(DataEncode RHS) for the whole source. This size estimate is
not used to infer runtime, and the theorem does not identify a runtime exponent.

Repeated labels/rows retain their order and multiplicity through map and the
row-indexed materializer. Empty lists are covered. The correctness theorem is
valid for all structural Source pairs, including unequal row/RHS lengths; it
preserves such an RHS rather than asserting source validity. Arbitrary malformed
bitstrings have total FP behavior but no claimed canonical parser or valid-source
output guarantee. That distinction is mathematically appropriate.

The discharged gap is an actual compact-binary-label to unary-normalized-source
machine with exact output semantics. Still separate: the finite generalized
Allocation/serializedSource join, executable occurrence/gadget row constructor,
structural-code transport, upstream source encoding and hardness, and final
reduction/learning theorem. Author green and the reported21 profiles do not
replace the separate independent build. No novelty or publication result is
certified here.
