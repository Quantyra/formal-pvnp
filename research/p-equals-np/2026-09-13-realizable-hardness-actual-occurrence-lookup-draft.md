# Exact serialized occurrence owner lookup

2026-09-13; S3131/S3132/S3137. SOURCE ONLY: uncompiled, unaccepted. Author: matrix_identity_independent_proof under root routing; this author cannot independently review this pair. No compiler, staging, commit, package mutation, download or public action occurred.

Read the actual Allocation source, Ordinals draft receipt, accepted table/rotation coding style, and pinned complexitylib UnaryList, Materialize, DataEncode and Pairing APIs. The Ordinals author confirmed the same intended wire format. Neither Ordinals nor another agent's source was edited.

## Exact format and same-function target

sourceTriples I is List.ofFn over the actual Fin m source rows. Each entry is a right-associated triple of unary owner words: replicate (I.vars r 0).val true, replicate (I.vars r 1).val true, replicate (I.vars r 2).val true. This is List (List Bool times (List Bool times List Bool)), not a list of pre-encoded row bitstrings and not a binary Nat triple. serializedSource is DataEncode.bitstringEncode of that exact typed list. This exactly matches the hypotheses of recFst_eq, recSnd_eq and recThd_eq in UnaryList. Source RHS values are intentionally absent because owner lookup reads only the ordered variable table; this is not a complete source-instance parser or serializer.

lookupInput table q is Complexity.pair table (replicate q true). For source slot (r,i), q=3*r.val+i.val. ownerLookup is one total bitstring function: pairFst gives the table, pairSnd supplies the length-coded query, divC 3 gives the record index, and modC 3 selects first, second or third projection using nested ifEqLen against the zero- and one-mark words. Malformed inputs are interpreted by these total library operations; no validation/rejection guarantee is asserted.

ownerLookup_mem_FP composes the actual library pair projections, divC_mem_FP, modC_mem_FP, recFst/Snd/Thd_mem_FP and ifEqLen_mem_FP for this very definition, with no caller FP field or assumed equality to a separate semantic encoder. The library primitives are noncomputable Lean definitions with FP machine-realizability proofs. This candidate therefore targets the library's same-function FP notion; it is not evidence of native Lean evaluation, extracted executable code or a complete reduction constructor.

## Concrete semantic joins and bounds

sourceTriples_get identifies the actual indexed row. Each rec*_source theorem applies the pinned library's concrete serialized-list correctness theorem to that row and its valid Fin m bound. ownerLookup_dispatch proves quotient and remainder for q=3r+i and handles all three Fin 3 branches. ownerLookup_correct returns replicate (I.owner slot).val true from the same serializedSource and lookupInput used above. Checks include all three explicit source-column cases. No lookup-semantics hypothesis or canonical ordinal replacement is introduced.

The output length is exactly the owner's value, hence less than N on a valid slot. The actual pair wire length is exactly 2*table.length+2+q; valid-slot q is less than 3m, yielding input length at most 2*serializedSource.length+2+3m. These statements count the real outer pair and unary query. They are not a proof that constructing the whole serialized table is FP from a binary or abstract Instance input. A bound for the complete table's encoding in terms of a chosen original source wire, and its construction algorithm, remain separate obligations. No polynomial-in-binary-m or binary-N assertion follows from these direct bounds.

In particular, converting arbitrary binary source labels to these unary owner words can expand the wire exponentially in the binary input length. Neither N nor the largest owner label is assumed polynomial in m. Before using this lookup in a polynomial source reduction, the actual source family needs a proved polynomial label bound or a compact-label normalization algorithm with its own correctness and FP proof. The actual serialized-table producer also needs an FP proof on that chosen source format. ownerLookup_mem_FP on the already supplied unary table does not discharge either obligation.

The empty source has an empty typed triple list. A valid Slot 0 cannot be supplied, so no nonexistent source owner is invented. Repeated source rows and repeated variables across rows preserve their positions in List.ofFn. The inherited within-row distinctness condition is available in Instance but is not needed to make the three projection operations agree with that row.

## Status and next joins

Main SHA256: a8b376f9834591a995a58f953b27c11bce76fca6a37b45b0cd0672c1f81d7a6b.
Checks SHA256: 9216b4490b9944b086d6ddd70a7848579935817e8ad6ef76233cf435a432259b.
Both new Lean files use ASCII syntax, written through apply_patch; no ambiguous Unicode shell transport is used. The draft requests fourteen axiom profiles, six examples and three signatures. No compilation has run, so elaboration of list-get proof terms and mixed-radix branch simplification remains unverified. No sorry, admit, new axiom or native_decide is used.

Next: first compile and independently review this pair under the guarded protocol. Then join the first q mixed-radix lookups to the actual slotList prefix; compare each returned unary owner with the query owner using a one-mark equality predicate; prove countOver's numeric sum equals the canonical prefix count; and apply countOver_mem_FP for the exact final ordinal function. Those prefix-enumeration, counting and encoded-scanner joins remain unimplemented here. Broader allocation/cloud numbering and serialization FP, full source hardness, final theorem and paper consolidation remain open. No novelty or publication claim is made.
