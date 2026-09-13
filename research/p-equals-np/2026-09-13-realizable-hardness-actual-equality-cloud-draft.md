# Actual equality-cloud allocation and simultaneous extension

2026-09-13. S3132/S3137 under S3126. Source-only draft; no build or review acceptance.

## Construction and provenance

This implements the next concrete equality-gadget allocation step in the
preserved September 12 source-construction extraction and critical-source
audit. It imports the actual edge-representative construction and accepted
four-equation gadget. This is an elementary prerequisite of source
regularization, not a new hardness mechanism or novelty claim.

Global variables are the explicit sum type
`Vertex n ⊕ (Edge n × Fin 5)`. A graph port belongs to the left summand. Each
actual nonloop reversal-orbit representative supplies one edge identity and
owns five internal variables in the right summand. Distinct parallel edges
therefore retain different internal variables even when their endpoints agree.

The actual `Fin 7` map sends local x,y to the representative's source and
destination ports; local a,b,c,d,e to its five orbit-indexed internals. Its
injectivity uses the already exported terminal inequality, sum disjointness,
and distinct finite internal indices. There is no supplied freshness law.
The ordered `edgeList` comes from attaching membership proofs to the actual
`representativeList`; `rows` concatenates each edge's four concrete ordered
triple/right-hand-side pairs. Each indexed row appears in this actual list.
The source proves the edge list has no duplicates and its finite set is all
actual Edge identities, so its length is their cardinality.

## Structural argument, including parallel edges

Within one copy, the inherited three-variable and pair-intersection proofs
apply through its actual injective embedding. Across distinct edge identities,
any shared variable must be a terminal: equality of internal variables forces
both the edge identity and internal index to agree. A kernel finite lemma on
the four concrete local supports establishes that each individual row contains
at most one terminal. Thus even two parallel copies sharing both endpoint
ports have row-to-row intersection at most one. The source proves this bound
for every distinct pair of indexed rows and derives distinct row supports.
Checks explicitly instantiates the parallel-endpoints case without discarding
either edge identity.

## One global assignment, not independent existence claims

For an arbitrary port assignment x, `extension x` keeps all port values and
sets each edge's internals to (0, x(source), 0, x(destination), 0). The same
global function pulls back under every concrete embedding to precisely the
accepted gadget's attaining extension. Therefore every copy simultaneously
has minimum violation count equal to its terminal mismatch indicator.
`localViolations_eq` identifies the count with the actual relabeled equations;
`extension_total` sums these exact per-copy counts over actual edge identities.
`rowsViolations_eq_total` and `total_eq_filter_length` identify that indexed sum
with the unsatisfied-count filter on the generated ordered row list itself.
`extension_rows` therefore gives simultaneous attainment on the actual output
list, not merely on an unrelated semantic sum.
`rows_lower` applies to every global assignment, and `exact_minimum` compares
all competing assignments with the fixed port values against the one explicit
global attaining extension, using the generated list's violation count.
No constant-port-assignment assumption or caller-provided attainment premise
is used.

## Verification boundary and next assembly

No compiler, Git, package or public actions. Checks requests 31 axiom profiles,
five signatures and nine examples. Compilation and independent three-lens
review are pending. No new axiom, sorry, admit or native_decide is used.

This module allocates one graph cloud. The next assembly must allocate clouds
for all source variables with disjoint global tags, attach the original
equation occurrences to distinct ports, prove total occurrence/list counts
and incidence-degree bounds, and join arbitrary-assignment gadget lower bounds
to the actual cut/majority decoding inequality. Encoding the sum-type variables and
constructing the same complete output in FP remain unproved. Håstad source
hardness, the full source theorem, later decoder work, and final paper/proof
consolidation remain separate obligations.
