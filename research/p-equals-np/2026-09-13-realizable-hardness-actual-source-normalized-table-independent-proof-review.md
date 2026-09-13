# Normalized source table: independent proof-adversarial review

2026-09-13. S3131/S3132/S3137. GO-WITH-NOTES: independent session 95364 ended actual exit 0 for main and Checks; sources unchanged, no guard stops, postflight checks passed. Sources fixed at final freeze 83a45660; no source edits or repairs in this review.

## Disclosure and scope

I authored imported ActualSourceNormalization and ActualCompactSourceLookup, not ActualSourceNormalizedTable or its FirstOccurrence dependency. This review relies on those imports' prior independent acceptance, including the original independently exported FirstOccurrence main. I also authored the future OriginalRowProducer draft, which remained paused throughout this dependency review; it is not imported here. The separate uncompiled finite-carrier bridge is likewise not a dependency. This is an agent proof/build review with this disclosed involvement, not human peer review.

I read the entire final main and Checks, and the actual UnaryList/Materialize/DataEncode interfaces used by the proof. The functions named in the FP assertions are exactly those in the correctness statements; there is no alternate producer, assumed producer FP field, external runtime certificate, or assumed serializer law.

## Proof findings

unaryRows maps unaryTriple over the actual normalized rows, preserving every row and all three positions. unarySource pairs that list with the original RHS list verbatim. slotArg derives the queried occurrence address 3r+i from the current row counter, then calls the previously verified full-binary-label firstFn. In particular the input's original numeric label is never converted into unary by magnitude: only its first-occurrence index is written in marks. Repeated names receive the same first index while their distinct row positions and row multiplicities remain present.

rowRule uses encTriple appropriately here: its three arguments are unary leaf strings, not already encoded nested variable structures. The exact equality is the existing DataEncode of the renamed unary triple. The three concrete column equalities are proved using actual FirstOccurrence correctness. tableFn runs actual listEncFn over the posCount-derived row clock; materialize_eq supplies exact increasing row-order output. No output-order or list-length premise is merely assumed.

sourceFn uses a DATA product through dataPair, not a machine argument pair. Its first component is the concrete tableFn output from tableFromWire; its second is the actual sndEnc input subtree. The product-encoding theorem proves complete DataEncode(unaryRows S,S.2), so the full RHS bitstring and its order are retained. The fstEnc/sndEnc projection theorems confirm both components. This correctness holds for every typed Source, even a row/RHS length mismatch: the theorem preserves such a mismatch, it does not certify Source.Valid or interpret unmatched equations. Empty rows and empty input are included; the raw bitstring function remains total beyond well-formed typed inputs.

sourceFn_mem_FP is a real composition proof for that same raw function. sourceFn_output_polynomial is derived from Cobham.output_length_poly_of_mem_FP, rather than using a finite output-size estimate as a runtime premise. Separately, the exact unaryTriple length and all normalized labels <3m yield table length <=2+m*(36m+10), and full output length <=4+m*(36m+10)+encodedRHS.length. Retaining encoded RHS length is necessary for arbitrary typed Sources. No hidden bound on the magnitude or universe size of original binary labels appears.

No proof objection was found in this source audit. The source header still describes the FirstOccurrence dependency as uncompiled; that historical draft comment is superseded by the accepted final dependency records and does not weaken or alter the theorem statements. The final source explicitly unfolds the relevant function definitions before FP composition and uses Nat-indexed local equalities for the three fields; these are elaboration repairs, not target changes.

## Independent build and provenance

Fresh root: certifications/realizable-hardness/.lake/build/actual-source-normalized-table-independent-review-20260913. Runner SHA 4550952f9b4a45a991f8d5391affaf41feec640dd83f32c6af4c733fbf1b9cfc; preserved pregrant plan SHA ad072a3ca8998a006b3bf5feada76450912c5c31a17e3663b1e40f97a3369a83. The runner remains identical to the author runner except for its independently scoped root. It rechecks original dependency hashes, receipt identities, source pins, package revisions and absent fallback exports before spawning; one thread and the unchanged 768 MiB pre-child / 640 MiB running memory guard are used.

Independent preparation copied 2625 original lower dependency artifacts tied to nine accepted receipt identities. No author NormalizedTable target output was used. It checked six explicitly current mathlib exports and 180 current source pins, including 178 original Materialize source counterparts. Current direct mathlib raw bytes normalized to LF were compared with pinned Git blobs. All eleven package revisions and the pinned manifest matched. Preparation checked 180 fallback paths absent: FirstOccurrence plus the Table pair, five export extensions, eleven package roots plus the toolchain root. No Table target was copied into the fresh root.

Current source bytes normalized to LF match final 83a45660; raw CRLF hashes and frozen LF hashes are kept separately. The author packet identity is 2edad1084b21478d306bd87f09ca0bf3e520a5a096d7557dace476d7b0c1fa3b. Its author results do not replace this independent build. The accompanying portable JSON preserves each independent raw log, source snapshot, terminal metadata and output hash, together with postflight source/original-copy/receipt/pin checks and the actual printed axiom profiles.

## Boundary

This module closes the concrete compact binary Source -> unary first-occurrence normalized table plus unchanged RHS producer obligation. It does not itself prove the finite-carrier bridge, its assignment transport, original/gadget encoded output construction, an upstream hardness theorem, a quantum advantage, novelty, publishability, or P versus NP. Acceptance of this pair is separate from completion of the overall reduction and from root's planning count.

## Actual independent result

Session 95364 terminated with actual process exit 0 after main and Checks each recorded exit 0. Every successful source/log/snapshot/output hash was revalidated, together with all 2625 original dependency sources and copies, nine receipt identities, six current exports, 180 source pins, eleven package revisions and the manifest. Final source bytes normalized to LF equal the frozen Git blobs. No target export fallback was used. The postflight collector also checked all 96 pair-only fallback paths absent; the broader 180-path preparation and runner check includes FirstOccurrence and the .ir suffix.

The 21 printed profiles consist of 19 using only propext/Classical.choice/Quot.sound and two with no axioms (unarySource_empty and unarySource_rhs). Checks has eight examples and four signatures. The main has one existing unnecessarySeqFocus linter warning; Checks has none. The initial evidence parser counted only the 19 nonempty axiom reports and stopped before producing a packet. It was corrected to parse the two explicit no-axiom reports as empty profiles, with its prior script preserved; raw compiler records and source bytes were unchanged, and no compiler retry occurred.
