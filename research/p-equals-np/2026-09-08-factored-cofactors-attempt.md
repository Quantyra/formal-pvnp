# Exact factored cofactor implementation attempt

Informal S3040/S008/E004 research increment. No general polynomial-time SAT
algorithm or complexity separation is established. The literature gate is
`docs/research/pvnp/literature-review-factored-cofactors-2026-09-08.md` in the
Quantyra-Planning repository. No Lean or physical-device claim is made.

The earlier [nonclausal payload attempt](2026-09-08-nonclausal-payload-attempt.md)
already exhibited the equality-family sharing failure in an XOR/AND engine.
This increment implements a local repair in a different representation:
signed-literal, n-ary AND/OR DAGs. It is not a newly discovered obstruction.
The existing `check_nonclausal_circuit.py` uses Boolean-ring operations and
affine pivots; importing its constructors would change the present experiment.

## Exact algorithm and local identities

The standalone [prototype](probe_factored_cofactors.py) has two modes. Both
hash-cons nodes, fold absorbing/identity constants and collapse unary gates.
`plain` retains child order and repeated children. `factor` additionally
flattens adjacent identical operators, removes repeated children, sorts child
IDs, detects complementary signed literals, and extracts the intersection of
conjunct sets at an OR. All are syntactic operations, with no equivalence oracle.

For an OR whose terms are conjunctions with common factor set I, the rule is

    OR_j AND(I union R_j) = AND(I, OR_j AND(R_j)).

Singleton terms count as one-factor conjunctions; empty conjunction is true.
Distributivity proves the identity. Associativity, idempotence and literal
complement laws prove the other rewrites. Factoring removes nonempty common
sets from the inner OR; no reverse distribution is performed, so recursive
factoring terminates. Constructors preserve Boolean semantics independently
of whether they find every available simplification.

At each variable x compute both restrictions G0 and G1 by memoized DAG
traversal, save their roots, and replace G by OR(G0,G1). This is exactly
existential elimination. Once all variables are eliminated, the root is a
constant. For a true root, lift a witness in reverse order: set x=0 if saved
G0 evaluates true under the already selected later variables, otherwise x=1.
The existential identity guarantees the selected saved root is true. The
prototype asserts this and independently checks the original CNF witness.
False final roots give a definite NO; no witness is invented.

## Family repair and measured resource contract

For F_m = AND_i (x_i iff y_i), eliminate every x before any y. If R is the
remaining conjunction, the two restrictions are R AND y and R AND NOT y.
The common-factor rule extracts R and reduces y OR NOT y to true. Thus this
mode returns the remaining equality conjunction at each x step and true after
all x steps. The plain mode need not recognize this cancellation.

This is a combined rewrite-package repair: the benchmark does not isolate
common-factor extraction from flattening, deduplication and complement laws.
This establishes a family-specific structural invariant, not an invariant for
arbitrary CNF. The initial size is linear in m; even the repaired mode must
scan/rebuild the shrinking residual repeatedly. Its n-ary edges and retained
history cannot be inferred from the final constant root alone.

The output separately records current reachable nodes/edges after the x
prefix, cumulative allocated nodes/edges, all stored-cofactor-root reachable
nodes/edges, and traversal/constructor counters. Nodes are never garbage
collected: allocated totals include intermediate nodes unreachable even from
history. Cofactor caches are local to one restriction, not semantic caches.
Counters include cofactor edges, normalization child visits, dedup inputs,
literal scans, factor entries/intersection inputs, hash-key edges and canonical
sort comparisons (including factor-remainder sorts), set-difference input
entries, and witness evaluation calls/unique visits/edges. Witness evaluation
includes the asserted selected-root check; independent truth-table validation
and final original-CNF verification are separate and not charged to these
construction counters. Reachability reporting is also diagnostic overhead.
These are diagnostic Python operations, not a complete
bit-runtime model: sets, tuple hashing, allocation, integer operations and
list/set materialization still have implementation costs. No polynomial bit-time
claim follows from the counters.

## Bounded verification and reproduction

Run from the repository root:

```text
python research/p-equals-np/probe_factored_cofactors.py --output research/p-equals-np/2026-09-08-factored-cofactors-output.json
```

The one fixed suite checks both modes on empty conjunction/clause, conflicting
units, duplicate/complement literals, overlapping clauses, all eight signed
three-variable clauses, and equality instances through six variables. At
every prefix, independently enumerate assignments to eliminated variables
against the original CNF for every remaining assignment, and compare with the
retained DAG. All produced witnesses receive a separate original-CNF check.
The larger equality measurements use m=1,2,4,6,8,10; they do not brute-force
twenty-variable truth tables. Output is written explicitly as UTF-8 with LF.

The fixed suite passed: 18 mode/case combinations, 414 independent prefix
evaluations, 12 SAT cases with verified witnesses and 6 UNSAT cases. It was
rerun once after reviewers requested complete sorting and witness-traversal
instrumentation; semantic checks and structural totals remained unchanged.
The final [JSON output](2026-09-08-factored-cofactors-output.json) records:

| m | Plain x-prefix nodes/edges | Repaired x-prefix nodes/edges | Plain total allocated nodes/edges | Repaired total allocated nodes/edges |
|---|---|---|---|---|
| 1 | 3 / 2 | 1 / 0 | 10 / 8 | 9 / 6 |
| 2 | 11 / 14 | 1 / 0 | 27 / 38 | 18 / 20 |
| 4 | 39 / 94 | 1 / 0 | 112 / 284 | 36 / 66 |
| 6 | 139 / 510 | 1 / 0 | 417 / 1546 | 54 / 136 |
| 8 | 527 / 2558 | 1 / 0 | 1590 / 7712 | 72 / 230 |
| 10 | 2067 / 12286 | 1 / 0 | 6223 / 36926 | 90 / 348 |

At m=10, forward cofactor edge visits are 74,212 versus 660, and witness
evaluation edge visits are 47,478 versus 558. The repaired mode additionally
records 865 normalization child visits, 913 sorting comparisons and 378
set-difference input entries. Both modes store 40 cofactor roots. Their
historical-root reachable nodes/edges are respectively 6198/36864 and 75/234;
both final current roots are one constant. Thus historical work remains
visible even after the final answer has simplified. All 12 benchmark witnesses
also pass original-CNF verification. These finite values are observations;
they are not an extrapolated asymptotic bound.

## Remaining general obligation

The procedure is an exact general finite SAT procedure with standard cofactor
semantics, continuing the [support elimination note](2026-09-08-support-elimination-attempt.md).
It supplies no uniform bound on residual size, child references, cumulative
restriction work, normalization or witness-history storage for arbitrary
input length. Local common-factor extraction can miss nonlocal identities;
the implementation neither assumes their availability nor proves they are
necessary. A general polynomial bound for this actual rewrite procedure, or
a stronger fully costed procedure, remains unproved. Small-instance semantic
checks establish only the tested behavior and complement the local identities;
they are not exhaustive verification of all Python executions.
The mathematical procedure is finite on finite inputs, but this recursive
prototype additionally has Python recursion and memory limits. An implementation
for arbitrary depths would need explicit traversal stacks and its own resource
accounting. Hash tables and integer/set iteration are implementation details;
operation diagnostics are not a platform-independent bit-complexity certificate.
