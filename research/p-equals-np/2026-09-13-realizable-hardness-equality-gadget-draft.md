# Equality gadget source draft

2026-09-13. S3132/S3137 under S3126. **Uncompiled source; no acceptance or review verdict.**

This implements the explicit four-equation prerequisite from the preserved
`2026-09-12-realizable-hardness-gap3lin-source-construction-extraction.md` and
`2026-09-12-realizable-hardness-critical-source-obligation-audit.md`.
It is literature-aligned elementary regularization machinery, with no novelty
claim and no attribution of this explicit gadget to inaccessible Minzer text.

## Concrete target

The seven variables are numbered x=0, y=1, a=2, b=3, c=4, d=5, e=6.
Four ordered triples are (0,2,3), (1,4,5), (2,4,6), (3,5,6), all with
right-hand side zero in ZMod 2. `rows` is the actual `List.ofFn` of the four
triple/right-hand-side pairs, retaining occurrence identity. The companion has
no existing Gap3Lin equation carrier located by the source audit; this carrier
matches its specified ordered `Fin 3 -> Fin N` triples and ZMod 2 right-hand
sides. It does not define a competing Boolean formula encoding or claim a
binary codec. Future cloud construction can map these exact triples directly.

`violations` counts the unsatisfied equation occurrences. `exact_minimum`
asserts the universal lower bound for fixed terminal bits and supplies the
explicit extension a=c=e=0, b=x, d=y attaining their inequality indicator.
`satisfiable_iff_equal` quantifies over the internal assignment: equal terminals
admit an all-satisfied extension. It does not falsely assert that arbitrary
internal values work when the terminals are equal; Checks includes a
counterexample to that stronger statement.

The source also states four distinct row supports, exactly three distinct
variables per row, pair intersection at most one, terminal degree one and
internal degree two. Injective relabeling exposes concrete relabeled row lists
and preserves support cardinality, support distinctness, pair intersection and
degrees; variables outside the embedding have degree zero. For every global
assignment the count on the actual relabeled equations retains the mismatch
lower bound. No desired gadget law is supplied by a caller.

## Verification status

Source-only task: no Lean compiler, package mutation, Git index or commit,
public write, or release action. Checks requests 22 axiom profiles, two theorem
signatures, and ten examples. Finite constant proofs use kernel `decide`, with
no `native_decide`, sorry, or added axioms. The 128 possible assignments are a
constant gadget audit, not an experiment intended to infer general hardness.
Compilation and independent three-lens review remain required. This receipt
does not count the pair as accepted. Source byte identities are reported to the
orchestrator separately to avoid a self-referential receipt hash.

## Remaining obligations

The full occurrence-cloud constructor must choose nonloop edge orbits, retain
parallel-edge multiplicity, assign globally fresh internal names, connect the
degree-three graph and majority-decoding cut bound, preserve exact equation
counts and YES/NO losses, and prove its actual encoded map in FP. The explicit
attaining extension here is local; a global assembly must prove its extensions
coexist. Håstad's source hardness, repetition and the complete paper theorem
remain separate unfinished obligations. No P-versus-NP, algorithmic novelty,
source-hardness completion, or paper readiness claim follows from this draft.
