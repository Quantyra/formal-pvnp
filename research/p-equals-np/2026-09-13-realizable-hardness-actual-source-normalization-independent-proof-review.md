# ActualSourceNormalization independent proof review

Status: GO-WITH-NOTES for bounded normalization semantics; fresh independent pair compilation passed. Source freeze 02e5a57e6ab4c677bb285280c50e374c28fe3bba.

Reviewer: lookup_independent_proof, top-level proof-adversarial lens; not author of the reviewed pair. Imported dependency acceptance is reused, not claimed as a new independent proof review of the entire library.

## Source audit

The source is a list of right-associated natural-number triples paired with an ordered Bool RHS list. wire is its actual DataEncode bitstring encoding. No Fin-bound source representation or row-distinctness premise is silently imposed.

flatten concatenates three labels per row. first is idxOf in that exact ordered list, not numeric label magnitude or an assumed renaming table. A used label has index strictly below 3 times row count, and get_first recovers the used label. Equality of two used indices therefore implies equality of labels. Unused labels can share the out-of-range default index; injectivity is correctly restricted to used labels. First occurrence indices may have holes, but every used output label satisfies the required bound.

normalize maps rows in place and retains RHS unchanged. Repeated labels remain repeated; no row deduplication or parity simplification occurs. liftAssignment reads the original label at an output index, using original label zero outside the list. decodeAssignment reads the normalized assignment at first for used original labels and explicitly assigns zero elsewhere. Neither function is claimed to invert assignments on unused names.

Both rowValue transport directions use actual membership of each row label in flatten. Consequently all ordered violation flags match in both directions, and countP transports their exact violation count. The RHS stays in the same row position. Valid only means equal row/RHS lengths and is preserved. The stronger total flag theorems intentionally also hold on malformed sources: List.zip truncates equally on both sides. They do not claim one flag per row on malformed sources.

Empty normalization and repeated-label examples are present. Twelve selected axiom queries, four examples and three signatures are expected. No sorry, admit, new axiom or native_decide occurs in the reviewed pair.

## Boundaries and preparation

The bounded result is a semantic first-occurrence relabeling with both-direction satisfaction-count preservation. No FP theorem, machine implementation of normalization, binary-to-unary producer bound, Fin instance bridge, whole reduction or hardness theorem is supplied. wire alone is an encoding definition, not a runtime proof. The output label bound removes dependence on original label magnitude mathematically; encoded implementation and bridges remain separate obligations.

Fresh root actual-source-normalization-independent-review-20260913 uses 2622 original accepted dependency artifacts, never author Normalization output. Six direct mathlib exports are explicitly current-state evidence. The two direct mathlib source files are compared by explicit CRLF-to-LF normalization with pinned Git blobs; that does not assert historical binary identity. Receipt hashes are explicitly cached once per path. The original preparation withheld compiler authorization; its preserved pregrant record and later authorized build are reported below.

## Actual independent build closeout

Session 60285 terminated with actual exit 0. Main and Checks each exited 0 on the first independent attempt, with unchanged source, no warnings and no memory-guard stop. Twelve profiles are subsets of propext, Classical.choice and Quot.sound; four examples and three signatures elaborated. Both modules used Lean 4.34.0-rc2 commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, LEAN_NUM_THREADS=1, the pinned eleven-package manifest, and fresh scoped exports. No source repair or author Normalization output reuse occurred. The pinned DataEncode Nat instance was also inspected and encodes Nat.bits, consistent with binary source labels.

Runner SHA256: `ac49c9cd381e97efdfc3b2a3a4a33f5b9c05e8881bfe2caefbd598bda47b5bc9`. Preserved pregrant plan: `364949a89025e6c9109c4b013ae5ca78216091d244c659b63e0ddd56cdf99143`. Authorized plan: `d9b9ea13edc5bf9fc149658e14c9aa2fdd4820bbb6b9e439c7f533516fe44777`. Portable JSON SHA256: `0a9681ed7e30e65cb2aa36902fb55b7f923695b2adc8f4fdbf088bdcc8c4286e`. JSON embeds exact raw logs, metadata, source snapshots, runner and plans, and records every original/copy hash. This is the proof-adversarial lens only, not full theorem certification. Compiler released; no Git action. Final MD/JSON use explicit UTF-8 LF bytes while embedded raw records retain original newlines.
