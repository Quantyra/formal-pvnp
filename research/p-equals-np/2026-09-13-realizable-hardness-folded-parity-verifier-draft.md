# Actual folded parity verifier: bounded source draft

Date: 2026-09-13. Route: S3132/S3137, satellite formal-pvnp.
Status: SOURCE ONLY, uncompiled and unfrozen. No compiler or source Git grant used. No proof acceptance, FP, source hardness, novelty, or full-paper completion claim follows from this receipt.

## Exact source inventory

- `drafts/2026-09-13-folded-parity-verifier/ActualFoldedParityVerifier.lean`: SHA256 `8c5237a19c06e89adaea2382405691541198d0c120a5699fab25fbff5dbbea0a`, 21495 bytes, UTF-8, 485 LF and no CRLF.
- `drafts/2026-09-13-folded-parity-verifier/ActualFoldedParityVerifierChecks.lean`: SHA256 `92cfce4d59a8ab73b1784f1b2b9bc5cb8d629bbb7d7ba36e5fda744039616956`, 4184 bytes, UTF-8, 97 LF and no CRLF.

Checks requests 37 axiom profiles, 19 examples, and 5 signatures. The examples include an actual repeated-label clause with U=W=[0], all three query addresses equal, both RHS bits, and contradictory selected clauses producing none. Kernel `decide` is used only for bounded examples and Boolean algebra. No sorry, admit, native_decide, or new axiom appears. This static scan is not compilation.

## Implemented mathematical targets

The source computes selected views from actual ordered clause/literal-position questions, sorts their variable names, enumerates Boolean assignments false-block before true-block, and proves enumeration coverage, length, and nodup. Full addresses are pairs (sorted variable list, full truth vector). `addressCode` composes the existing DataEncode injection with a positive sentinel binary word encoding. `wordNat_bounds` proves 2^length <= wordNat < 2^(length+1). This bounds the last encoding step; it is not a polynomial-time constructor proof.

One raw proof P:Nat->Bool supplies every query. No A/B role, tuple, or conditioning tag is added to its address. Conditioning selects the first satisfying assignment, forms the canonical member of the actual cond(f)/cond(not f) pair, and retains the chosen sign. The source exports arbitrary-P complement and restriction laws. If the domain is empty it returns Option.none, including at emitRow; there is no invented odd function on an empty domain.

The exact primary convention is retained: H?stad uses sign -1 for logical true, so Bool sat=true means h=-1. Off-domain bitfalse has sign +1 and is precisely primary conditioning. No bit convention was changed. The design-note clarification preserved the original formula.

The concrete third query is f restricted to U xor g xor noise on W. The honest proof is a semantic extension along the proved address injection, using classical choice only to recover addresses in the image. It is explicitly not an executable decoder or an FP witness. Honest evaluation requires the restricted assignment to satisfy the conditioning predicate; selectedSat_honest derives this from actual selected clauses of a satisfying source assignment. The honest verifier bit is exactly the sampled noise coordinate.

`rowOfQueries` emits the ordered three Nat addresses with RHS equal to the xor of the three folding signs. `verifier_accept_iff` connects actual emitRow to existing ActualSourceNormalization.rowValue/rhsValue without a caller-supplied output equality. The reverse arbitrary GF2 assignment direction is explicit, using the accepted Bool/ZMod roundtrips. Repeated addresses remain in the ordered triple. `rowSource` and `rowWire` reuse the actual downstream Source type and total wire encoder.

## Source and review alignment

The implementation follows `2026-09-13-realizable-hardness-folded-parity-execution-interface.md`, freeze fddd61d76706c0484f35748042f048e128e6390b, SHA256 549e0fe033414c5fceca1beaee90ccc33e15d8d863a103100e92702b13b6517b. Original note SHA256 8b245878127ab975a29c55bc0b47a11e530a9b02d650fdc048e97812a90579a7 is retained in the ignored draft evidence directory; the clarification only distinguishes Boolean and primary sign conventions.

Independent semantic design review: `2026-09-13-realizable-hardness-folded-parity-interface-semantic-review.md`, freeze 611991294f1add08129e8d4e8a5213687b96751d, SHA256 5bd66f76b43ab8ecbed52be2b76ff5764ef651e5d972f789ee8e5d9170f6af5e. This draft incorporates its shared-P, actual-pair-selection, honest-domain and empty-domain conditions. Concrete source review remains separate.

Preserved primary H?stad PDF SHA256 864df36f2bc692e47f1c94aff0afec34297e27116a5d76f204199e9ce098fa64, text SHA256 0b771d4539401742c0c41a89a201c318e6557ab6aada7de60df69610614bfe91: section 2.5 pp.15-16 (conditioning/folding), section 3 p.21 (shared table per set), Test L pp.24-25, theorem 5.4 pp.27-29. Extraction is `2026-09-12-realizable-hardness-gap3lin-source-construction-extraction.md`. This is a literature-aligned prerequisite, not a novel verifier claim.

Imports reuse accepted ActualSourceNormalization and ActualCloudSoundness. The author previously authored some underlying occurrence/cloud construction dependencies; those were independently accepted earlier. This authoring receipt is not an independent review of those dependencies or of this pair.

## Exact remaining obligations

First compile and independently review this pair with the pinned original dependency closure. No existing binary certifies these scripts. Full selected-view input-size inequalities, exact dyadic outcome enumeration and multiplicity/fibre counts, the global empty-domain scan and fixed-NO branch, and the actual whole-source list materializer remain next constructor work. rowWire on one emitted row is not that constructor.

The repeated-literal input semantics are total, but uniform literal-position sampling differs from uniform distinct-variable sampling on such clauses. No equivalence to the primary source game is claimed without the regular E3-CNF clause-format proof. Empty CNF / u=0 local types are total; the future source-level m=0 YES branch is not implemented here.

Base E3-CNF gap, parallel repetition, Fourier odd/conditioned support, Parseval/correlation extraction, the quantitative 4*epsilon*delta^2 soundness bound, exact fixed-parameter polynomial runtime on actual encoded inputs, and the complete upstream hardness reduction remain open. Cardinality and word-size estimates cannot replace a same-function library FP witness. Existing downstream regularization is not a proof of these upstream obligations.
