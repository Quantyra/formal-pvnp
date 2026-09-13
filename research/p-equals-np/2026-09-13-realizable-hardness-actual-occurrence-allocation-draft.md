# Actual ordered occurrence allocation

2026-09-13. S3132/S3137 under S3126. Source-only draft, uncompiled and unaccepted.

This follows `2026-09-13-realizable-hardness-actual-cloud-assembly-obligations.md`
and the preserved September 12 source-construction extraction. It constructs
the specified original-instance allocation rather than introducing an assumed
occurrence bijection or freshness interface. No novelty claim is made.

## Concrete input and ordinal allocation

`Instance N m` contains exactly the ordered source triples `Fin m -> Fin 3 ->
Fin N`, a proof each triple is injective, and its ZMod 2 right-hand sides.
There is no hardness, expansion, freshness or desired gap assumption. Repeated
source equation occurrences are retained by their Fin m identities.

All source slots are enumerated in row-major order using the product of the
two actual `finRange` lists. Each variable's `occurrenceList` is its actual
owner-filtered sublist. `ordinal` uses that list's nodup get/idxOf equivalence,
with an explicit membership conversion; it is not an arbitrary externally
chosen equivalence. `ordinal_get` recovers the actual slot at the assigned
index. A constructed Sigma-fiber equivalence partitions all slots, giving
sum_v n_v = 3m with n_v the actual list length and occurrence cardinality.

The complete variable type is Sigma v of the actual equality-cloud variable
type at n_v. An occurrence maps to its tagged `(ordinal,0)` port. The explicit
`recover` function reads that ordinal back to the original slot, proving global
anchor injectivity. Unused nonzero ports remain present; no graph compression
or degree claim is silently assumed.

## Actual rows and structural bridge

The output row index is the sum of original Fin m row identities and the
variable-tagged actual gadget row identities. The generated list puts original
rows first, then variable-ordered cloud lists, preserving each local edge and
four-equation order. Both directions of membership correspondence connect
these actual list entries with the explicit row index and right-hand side.

Distinct original rows have disjoint supports because their occurrence slots
have distinct anchors. Different variable clouds are disjoint by Sigma tags.
Original-versus-gadget intersections use the source triple's distinct-variable
condition: two shared entries would be two positions in that original row
owned by the same source variable, hence the same position. Same-cloud gadget
intersections reuse the actual cloud theorem, retaining parallel copies and
their distinct internal variables. `support_eq` connects each global support
to the actual row function; all rows have support cardinality three, and every
pair of distinct row indices has intersection cardinality at most one.
Empty-source size and row-list statements are included.

## Verification and exact remaining scope

No compiler, Git, package or public action. Checks requests 25 axiom profiles,
four signatures and eight examples. No new axioms, sorry, admit or native_decide.
Compilation and independent three-lens review remain pending.

This increment does not yet prove the global output row-list length T=m+4E,
the complete index/list multiplicity-and-violation-sum equality, incidence
degree bounds, compatible YES extension for the entire source instance, or
majority decoding and gap preservation. These are the next concrete joins,
using the actual rows and ordinals introduced here. The distinct row-support
result prevents equal row functions for distinct indices, but membership
correspondence alone is not advertised as the full list multiplicity theorem.
Encoded variable numbering, allocation/serialization FP, Håstad source
hardness, and final paper/proof consolidation remain open. The separately
owned ActualGraphIncidence source is untouched.

## Actual author verification update

Scoped author session 16835 completed with actual exit 0 for main and Checks,
with 25 standard-only profiles, eight examples and four printed signatures.
Final logs are clean. Main attempts were [1,1,0]; Checks passed first attempt.
The first failure was cascading unresolved dotted-method notation: instance
methods needed the Instance namespace. Definitions/theorems were placed in
that namespace, Checks opens it, and the intended dotted API now elaborates.
The second failure was only empty-instance simplification, repaired with
explicit zero_size and cloud empty-row rewrites. Mathematical constructions
and quantified statements are unchanged; qualified API names now include
Instance. Failed compiler placeholders in diagnostics are not source axioms
or accepted proof results; final profiles contain only standard axioms.

Portable author packet (relative to companion):
`.lake/build/actual-occurrence-allocation-author-20260913/author-verification.json`,
SHA256 `d47bbc3a461412c673798e4aeeccf841d53bd8a857bde5dbb18a33106d82cf95`.
It embeds all four module attempts, raw logs, terminal metadata, exact source
snapshots, runner, preparation and dependency-copy evidence. The 307 original
accepted exports and their receipt identities, and six additional current
package exports, were rehashed. Eleven pinned revisions, toolchain and manifest
are checked by the one-thread runner under the 768/640 MiB physical-memory
thresholds; observed minimum available memory was 1939374080 bytes.
Current package hashes do not retroactively claim historical per-export byte
identity absent from older acceptance inventories. No broad build, package
change, download or public operation occurred. Independent review remains
pending. The exact multiplicity/count/degree/YES/gap/FP obligations above
remain separate; this result does not complete the source-hardness theorem.
