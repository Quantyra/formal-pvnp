# Folded parity verifier: independent concrete source review

2026-09-13. S3132/S3137. Bounded GO-WITH-NOTES for source-level semantic alignment; UNCOMPILED. No Lean acceptance, hardness, runtime or novelty conclusion. Reviewed the full stable main, Checks and draft receipt against the frozen design and semantic review611991294f1add08129e8d4e8a5213687b96751d. No source edits, compiler, Git or public action were performed.

## Exact reviewed identity

- Main: research/p-equals-np/drafts/2026-09-13-folded-parity-verifier/ActualFoldedParityVerifier.lean, SHA256 8c5237a19c06e89adaea2382405691541198d0c120a5699fab25fbff5dbbea0a, 21495 bytes.
- Checks: same directory, ActualFoldedParityVerifierChecks.lean, SHA256 92cfce4d59a8ab73b1784f1b2b9bc5cb8d629bbb7d7ba36e5fda744039616956, 4184 bytes.
- Dated author receipt: research/p-equals-np/2026-09-13-realizable-hardness-folded-parity-verifier-draft.md, SHA256 c988830b5fae766a91ecc2f8b9e4c4da6b0d1ed5394a0b9419cc3bcea051e81a.

Final archival source freeze dd3704fef7ddd99c7ace36e5b38d63f51e1cbfd4 was independently checked: all three reviewed files equal their frozen Git LF bytes. Main and Checks raw bytes were independently rehashed. Both are UTF-8 LF. This review applies only to those bytes, not to future elaboration repairs.

## Actual selected views and proof identity

Question is the actual finite function selecting clause occurrences and literal positions. clauseAt indexes phi; smallView deduplicates and sorts exactly the selected labels; wideView deduplicates and sorts the complete labels of exactly the selected clauses. No caller supplies either view, their inclusion, the restriction map or selectedSat. The small_subset_wide proof derives inclusion from literal membership. restrictLocal performs actual label lookup, and restrictLocal_honest proves the required restriction identity. selectedSat evaluates the conjunction of the selected clauses with their actual negation bits; selectedSat_honest derives its witness from satisfaction of every original clause.

The address is the pair of V and the complete ordered vector (assignments V.length).map f. The enumeration is explicit false-block/true-block recursion with the unique empty assignment. Coverage, length2^n and nodup targets are present. mkAddress_injective uses exhaustive enumeration, and addressCode_injective composes actual DataEncode injection with wordNat injection. Therefore full binary vector identity, not vector length alone, determines sharing. Sorted actual views give one representation for a variable set. There is no query-role, predicate or clause-tuple tag. U=W and different predicates on the same V read the same P:Nat->Bool at equal addresses.

wordNat uses a positive terminal sentinel and doubling plus the next bit. Its positivity and induction/parity injection arguments are mathematically correct. The new wordNat_bounds target states 2^length <= wordNat < 2^(length+1), the exact final-stage binary-width bound. Applying it to the actual encoded Address supplies that width bound without unary expansion. It is not a proof of a CNF-to-address polynomial bound: small/wide view-size estimates, encoded input clocks and FP of the whole enumerator remain explicitly outstanding.

## Conditioning and arbitrary proof semantics

condition returns false outside sat. As confirmed from rendered primary pages6/15/16, bitfalse means sign+1 (logical false) and sat=true means primary h=-1. canonical_pair identifies exactly the selected member of cond(f),cond(not f), using f at the first satisfying assignment as its sign. firstSat is actual list find; its soundness and none-iff-empty properties justify the selection domain.

foldEval_complement is quantified over every fixed raw P, and foldQuery_restriction proves equality from agreement only on satisfying assignments. Neither assumes an honest proof. Different predicates are derived from that same P, so the implementation does not accidentally quantify independently programmable conditioned tables. The A access uses only smallView and the identically true predicate, preserving independence from the other prover's clause information once U is fixed. The B accesses share wideView and the actual selected predicate.

honestAddress reads the coordinate for the restriction of one global sigma in the same explicit enumeration. honestProof extends this address function semantically along the proved injection with Classical.choose and a default outside its image. This is correctly marked noncomputable and is not used as a runtime witness or a generic decoder. foldEval_honest explicitly requires the global restriction to satisfy sat; there is no false assertion for an assignment outside the domain. selectedSat_honest supplies that premise from the actual CNF. verifierBit_honest then reduces the actual three accesses to exactly the noise coordinate through restrictLocal_honest.

## Actual emission and GF(2) predicate

queries constructs all three foldQuery accesses, including noisyThird's actual restriction/xor/noise operation. rowOfQueries retains their ordered Nat addresses and xor of their signs. queryParity reads the same raw P addresses with the same signs. The six-bit parity_algebra target matches the existing Normalization.rowValue sum and rhsValue, rather than defining an unrelated satisfiability notion.

The intermediate emitted_row_correct theorem takes queries=some qs, but the final verifier_accept_iff eliminates that premise by case analysis on the actual queries computation. It quantifies existence of the actually emitted row and its actual source satisfaction. verifier_accept_iff_GF2 provides the corresponding theorem for every Nat->ZMod2 assignment. I checked ActualCloudSoundness.fromBool/toBool: their definitions match Normalization.rhsValue and both roundtrips are used in bitAssignment_boolAssignment and boolAssignment_bitAssignment. The reverse direction is not restricted to an assumed Boolean subset of ZMod2.

Repeated addresses remain three summands throughout. No Instance.distinct assumption or distinct-input premise appears. rowSource and rowWire reuse the accepted concrete source format, with actual one-row Valid, but do not purport to produce the entire verifier equation list.

## Empty and repeated cases; remaining boundary

emitRow_none_iff identifies an empty selected conditioning domain exactly. The full-domain A query is always available, including V=[], because the enumeration includes the empty assignment. No odd function is invented on an empty B domain. The global exhaustive scan, fixed-NO output and m=0 YES branch are not implemented in this first pair and are correctly listed as later source-level work. In particular, no normal acceptance-count equality for a mixed exceptional branch is claimed.

Checks retains37 profile requests,19 examples and5 signatures. I read the actual examples: repeatedPhi produces smallView=wideView=[0], and concrete queries have all three addresses identical. Both folding-sign parities are exercised, along with the corresponding abstract ordered-row RHS values; a two-clause contradictory tuple gives queries=none and emitRow=none. The repeatedPhi conditioning domain is a singleton. Complement queries, empty conditioning, empty assignment enumeration, wordNat bounds and both Bool/GF2 roundtrips are also covered. These are source scripts only, not observed successful elaborations or axiom profiles.

No mathematical contract defect was found before implementation/build. Fresh compilation remains necessary: list/Fin API signatures, dependent simplification and the larger Boolean case proof have not been checked by the kernel. The module's size or finite nature does not itself guarantee memory success. All future repairs require exact diff review against these hashes.

The global size/runtime, exact dyadic fibre/counting, regular E3-CNF clause-format and occurrence-vs-distinct-variable sampling specialization, Fourier support/correlation, repetition and source-hardness theorems remain outstanding. A local honest noise identity does not establish the probabilistic completeness rate until a concrete noise distribution is counted. None of those missing results is assumed as a theorem field here.

I did not author this verifier pair. I authored the earlier semantic design review and downstream Normalization, CompactLookup, FiniteBridge, OriginalRows, WireBridge and paused regularized constructor draft; their separate prior acceptance is relied upon only for their stated APIs. This is a source-design review, not an independent compiler certificate or human peer review.
