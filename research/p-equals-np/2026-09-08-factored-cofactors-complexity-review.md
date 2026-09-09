# Factored cofactor complexity and implementation review

Reviewed the final [attempt](2026-09-08-factored-cofactors-attempt.md),
[prototype](probe_factored_cofactors.py), and
[recorded output](2026-09-08-factored-cofactors-output.json) for S3040/S008/E004.
Disposition: PASS for this bounded exact implementation and its reported
measurements. The general polynomial-time obligation remains INCOMPLETE.
No Lean theorem, general circuit lower bound, or physical accelerator follows.

## Exactness and representation

Both constructors use valid Boolean identities. The repaired OR extracts
only syntactically identical conjunct IDs common to every term; distributing
that intersection back recovers the original expression. Empty remainders,
singleton terms, duplicate factors and complementary literals have the stated
Boolean meanings. No semantic equivalence query or SAT oracle is hidden in
this operation. Memoization is per restriction traversal and hash-consing is
syntactic sharing, not semantic canonicalization.

The update G := G[x=0] OR G[x=1] computes existential projection exactly.
Saved restriction roots support reverse witness lifting: the selected suffix
satisfies at least one branch, and testing the zero branch chooses a valid
value. This assumes the elimination order contains every input variable
exactly once, as all supplied cases do. Mathematical correctness of these
identities is separate from exhaustive correctness of every Python execution;
recursion and memory limitations of this prototype remain explicit.

For paired equalities with every x eliminated before every y, the residual R
is a common conjunct of the two branches R AND y and R AND NOT y. The combined
rewrite package returns R. This is a genuine implemented repair of the prior
restricted equality failure. The old Boolean-ring engine and the present
signed-literal AND/OR engine differ, so their counter values are not directly
comparable. The note correctly cites the previous failure and does not claim
novel discovery of either the obstruction or Boolean distributivity. The
benchmark compares whole rewrite packages; it is not an ablation isolating
common-factor extraction.

## Resource accounting

Final code resolves the initial counter omissions. Every canonical child-ID
sort, including common-factor and remainder sorts, uses the counted helper.
Set-difference counters charge input entries, not an invented exact Python
operation cost. Witness evaluation explicitly counts calls, unique visits and
edges, including the asserted selected-branch check. Truth-table verification
uses the uncounted evaluation mode and does not contaminate benchmark witness
counts. Original-CNF checking and reachability diagnostics are separately
identified overhead.

Cumulative allocated edges count each newly interned gate's full child tuple;
current and historical reachable edges count references in their respective
root unions. The arena retains orphaned intermediate nodes, so historical
reachability is not a substitute for cumulative allocation. Stored root
references and local restriction caches also incur costs. The repaired final
constant does not erase work or storage already incurred.

N-ary gates are not unit-size objects: an arena with A node IDs and E child
references needs child-ID storage on the order of E log(A+2) bits, in addition
to tags, literal encodings, root references and implementation overhead.
Tuple hashing, dictionaries, set operations, materialization and allocation
are not completely accounted for by these primitive-category counters.
The explicit diagnostic-only qualification is therefore necessary and
sufficient for the claims made here. Neither finite measurements nor cheap
individual constructors give a uniform polynomial bit-time guarantee.

## Independent reproduction and scope

I independently ran the final fixed suite once, writing its output to a
reviewer temporary file. It exited successfully: 18 semantic mode/case
combinations and 414 independent prefix checks. Its full JSON was byte-identical
to the tracked output, SHA-256
`E7DB020F32126F3A90CB02ED2CF0B25271334F51554A40231715C9A75A12073F`.
The suite includes SAT and UNSAT semantics and separately checks constructed
witnesses against the original CNF. The twelve larger equality benchmarks
also pass their witness checks; they do not exhaust twenty-variable truth
tables.

At m=10 the reproduced plain/repaired allocated totals are 6223/90 nodes and
36926/348 edges. Forward cofactor edges are 74212/660, witness evaluation
edges 47478/558, and both modes save 40 cofactor roots. These match the final
note and show why both historical and traversal accounting matter even when
the final root is true in both modes.

The local identities are self-contained; this review imports no new external
complexity theorem. The finite equality observations are not a general
asymptotic lower bound, nor evidence that arbitrary residuals admit the same
repair. Conversely, failure to find a local factor would not establish a lower
bound for stronger representations or algorithms. A uniform bound on actual
residuals, cumulative edges, normalization work and witness history on all
inputs remains missing. All requested counter corrections are resolved in
the reviewed version; no further change is required for this bounded increment.
