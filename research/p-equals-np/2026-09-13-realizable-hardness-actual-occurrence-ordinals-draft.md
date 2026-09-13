# Actual occurrence ordinal scan: direct semantic prerequisite

2026-09-13. S3131/S3132/S3137. Source-only, uncompiled, independent review pending.
No compiler, Git, package download, public action or canonical-source edit.

Read current ActualOccurrenceAllocation, ExecutablePortTable and
ExecutablePortRotation, Mathlib NodupEquivFin, and actual complexitylib UnaryList /
Materialize FP APIs. No AGENTS.md exists at satellite root, certifications, or
companion root. Existing planning protocol routing applies.

The direct function scanOrdinal takes the explicit ordered finite source triples
vars : Fin m -> Fin 3 -> Fin N and an actual slot. It scans the existing
lexicographic slotList, stops before that slot, and counts preceding slots with
the same owner. It is defined recursively without noncomputable or a caller
supplied equivalence. Generic scanBefore_eq_filtered_idxOf establishes its link
to the index in the owner-filtered list. Because canonical Instance.ordinal uses
that very idxOf as the inverse of List.Nodup.getEquiv, scanOrdinal_eq_ordinal is
an equality with the existing construction, not a substitute ordinal. Strict
range correctness uses the canonical Fin bound. Prefix count is separately
exposed as takeWhile.countP. Empty lists and a first target return zero; querying
an empty source requires an impossible Slot 0, so no invented ordinal is returned.
Unused source owners cannot be queried by a slot owned by them.

unaryAnswer is an actual output list, with length at most 3*m. This is a direct
output-size bound only: it is NOT a proof that the encoded function belongs to
FP, nor a bound polynomial in a binary encoding of m. The target source format
must store all explicit triples. Fixed D has not changed or become input data.

Exact next encoded join: use DataEncode.bitstringEncode of the explicit list of
unary triples (matching UnaryList.recFst/recSnd/recThd), and a unary slot counter
q=3*r+i. Owner lookup selects recFst/Snd/Thd at q/3 via modC 3; these projections
have actual library *_mem_FP theorems. A one-mark equality indicator compares
that owner with the query owner. Materialize.countOver, with a clock of q marks,
counts all preceding indices; countOver_mem_FP and length_countOver provide the
actual library computation and semantics. Output is unary by
countOver_eq_replicate. The missing essential correctness lemma is that the
first q mixed-radix indices produce exactly the same owner sequence as the
slotList prefix before (r,i). Then its numeric sum must be joined to the
countP theorem here, and rec* correctness must be established on the same exact
serialized source table. Input-wire bounds must include the actual table and
query encoding. No caller-supplied FP field or desired output equality can
replace any of those joins. They remain unimplemented in this pair.

Checks request eight axiom profiles, three signatures, four examples. No new
axiom, sorry, admit or native_decide declaration appears. This is a useful
prerequisite for genuine encoded FP, not completion of the assigned full encoded
ordinal objective. The broader occurrence/cloud serialization, fresh global
encoding, full reduction runtime, upstream source hardness and final paper
proof consolidation remain separate obligations. No novelty claim is made.

## Failed source transport and correction

The initial main hash 947b93eb6de9907dfb8873c52f4d06b2c65220d9aeb82ef8d15b54edd8f47f41
and Checks hash fceae8070a2a636bded67b22d430c1e9b1a8ced6e5568e249dc52d96b3ac3df4
record a FAILED source transmission, not accepted Lean source or proof. The
PowerShell-to-Python transport replaced intended Unicode tokens with literal
question marks. Root detected this before any compiler launch. Repairs target
each specific syntactic context: ASCII function arrows and inequalities,
explicit Subtype.mk constructors, and branch bullets generated from Unicode
escape sequences in an ASCII-only transport script. No ambiguous blanket
replacement was used. Both final raw files contain zero question marks and
zero replacement characters. No compile or Git action has occurred.

The ordinal equality is definitionally targeted: Instance.ordinal composes
occurrenceMembership with getEquiv.symm; getEquiv.invFun is idxOf on the exact
owner-filtered list. scanBefore_eq_filtered_idxOf proves the direct recursive
scan equals that index. The final rfl performs only this unfolding and no
assumed ordinal equality is introduced. Elaboration remains unverified.

## Author verification update

The valid source draft freeze is 5a2bc6002f1c4dc4e511b241ba38afdbe0185361.
Earlier corrupt transport hashes above remain failed transmissions. Sessions
75317 and 15034 exited 1; session 86350 completed actual main/Checks pair exit 0.
All four attempts [1,1,0,0] preserve raw UTF-8 metadata, logs and exact source
snapshots. No source changed during an attempt and no memory guard fired.

Repairs normalize generic/Prod lawful BEq through Bool.beq_eq_decide_eq and
unfold List.product for its length; an omitted Bool namespace was corrected
on the third attempt. Unused/deprecated simp arguments were corrected. These
are proof-body changes only: the executable definitions and mathematical
targets are unchanged from the valid draft. In particular the canonical
ordinal equality's final rfl compiled without modification or assumption.

Final main and Checks are clean: eight profiles (two propext-only, six using
propext/Classical.choice/Quot.sound), four examples, three signatures.
308 original accepted artifacts, copies and receipts were rehashed after the
run, together with six current direct package exports and eleven pins. Current
package identity is not historical per-export certification. One thread;
768 MiB preflight, 640 MiB owned-child stop. Minimum available RAM: 2032685056 bytes.
Compiler released; independent review and final source freeze remain pending.

Portable packet: certifications/realizable-hardness/.lake/build/actual-occurrence-ordinals-author-20260913/author-verification.json
SHA256 5b313fc113cba1f9506308f64c1ae2be584ee3ed8aca53842300396beb13f591. Raw embeddings use byte.decode UTF-8 with no newline normalization.
Encoded lookup is being implemented separately on the exact unary triple
format above. Prefix enumeration and countOver semantic/FP joins remain open;
this author milestone does not certify the full encoded constructor or paper.
