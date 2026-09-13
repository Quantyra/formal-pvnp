# ActualSourceNormalizedTable non-claims review

2026-09-13. S3131/S3132/S3137. **GO-WITH-NOTES** for bounded claims about the
actual normalized unary table/source producer. No independent-build or
complete-hardness conclusion is asserted by this source-only review.

Read the final main, Checks and receipt in full. Raw bytes of main, Checks and
receipt equal freeze `83a45660fe459d00a3ef39c4fd51ef317d33e755`, respectively:
`a4a112c753e7f917663dc1287e7889986bc1d086ab21dfe34cbfa39da8c4e809`,
`45af1a7d67110ed969622f3cb27fe8c4f66f4dae1cb381242630e72e1f2e85f6`,
`1cc00e9149ddf19f0bdb34b0209d9790515df50dd126c9d8837699cf46fdada1`.
Author packet SHA-256 `2edad1084b21478d306bd87f09ca0bf3e520a5a096d7557dace476d7b0c1fa3b`
was rehashed at companion
`.lake/build/actual-source-normalized-table-author-20260913/author-verification.json`.
It is an immutable prefreeze packet; null final_source_freeze is resolved by
the separate actual commit, not retroactively treated as matching an earlier draft.

The same reviewer supplies this and the complexity report. The reviewer authored
FirstOccurrence and relies on its prior independent acceptance; the reviewer did
not author Table. Authored CountFP is a separate consumer of Lookup/Prefix and
does not import Table. These are disclosed dependency/adjacent-work relationships,
not independent review of the reviewer's own source. Table's independent compiler
and proof audit are a different assignment and are not claimed here.

Supported wording: a total bitstring function has an FP proof and exact equality
to the encoded unary first-occurrence-normalized table with original RHS,
on every actual Source wire. The complete table and whole-source equations are
stronger than equal length or a permutation: their ordered row and RHS fields
are fixed. The output representation is explicit, and semantic first indices
remain distinct from original binary numeric labels.

The author receipt reports session45888 main1 followed by45646 main0/Checks0,
with21 standard-subset profiles,8 examples,4 signatures and one harmless main
linter warning. Those are attributed author observations, not independent
compiler observations made in this review. The source's historical uncompiled
headers are conservatively stale; the dated update explicitly supersedes that
status and records independent dependency acceptance. They should not be read
as current acceptance metadata in either direction.

Source validity is not asserted: unequal row/RHS lengths are carried unchanged.
For malformed raw input the theorem establishes total FP behavior, not rejection
or canonical parsing. For well-formed structural input it retains repeated labels,
duplicate rows, the empty case and unchanged RHS. The explicit quadratic bound
in m is separate from the same-function FP proof and derived raw-input polynomial
output bound. No arbitrary numeric-label bound or runtime exponent is claimed.

This completes neither the actual regularized output constructor nor its finite
carrier bridge. The sourceFn output is the normalized source, not gadget rows.
Executable code/anchor/gadget production, exact serialized finite construction,
upstream encoded source hardness, final hardness/learning composition and paper
consolidation remain distinct. A component FP theorem is not a proof that SAT or
the hardness source is solvable in polynomial time.

No novelty, quantum algorithm, P=NP/P!=NP, paper acceptance, DOI, publication,
public action or full goal completion follows from this increment. Three-lens
closeout and root acceptance remain separate from these two reports. No source
mutation, compiler launch or Git mutation occurred during this review.
