# Capped clausal repair for overlapping cofactor residuals

S3040 / S008 / E004, informal harness-only attempt. Read with
`INTEGRITY-CLAIMS.md`. Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-overlap-repair-2026-09-08.md`.
No general polynomial-time SAT result, physical transfer or Lean theorem is
claimed. The earlier [factored cofactor experiment](2026-09-08-factored-cofactors-attempt.md)
is reused without changing its DAG implementation.

## Actual missed simplification

For each edge (a,b) of a y-chain or y-cycle, introduce its own variable x
and encode x iff (a XOR b) by excluding each of the four incorrect triples.
Concretely the clauses are

    (x OR a OR NOT b), (x OR NOT a OR b),
    (NOT x OR a OR b), (NOT x OR NOT a OR NOT b).

The driver also independently verifies each prefix against the original
truth table. Eliminating x leaves the tautology

    [(a OR NOT b) AND (NOT a OR b)]
       OR [(a OR b) AND (NOT a OR NOT b)].

The current literal-complement/common-factor constructors do not recognize
these complementary *functions*. They extract the independent remainder R
but leave this OR of two binary CNFs. Overlapping y variables do not cause
exponential growth in the measured family: the x-prefix residual is a
linear-sized conjunction of these tautologies. The new result is removal of
this actual missed identity, not an all-overlap blowup claim.

## Fully specified hybrid candidate

The local repair is standard Davis--Putnam clausal elimination, not a new
resolution rule. See [Davis and Putnam, Section 4, Rule III](https://web.stanford.edu/class/cs357/DP60.pdf)
and the prior [support elimination derivation](2026-09-08-support-elimination-attempt.md).
For a syntactically clausal root write

    G = R AND AND_i(x OR A_i) AND AND_j(NOT x OR B_j).

The projection is R AND AND_(i,j)(A_i OR B_j). Discard tautological
resolvents; allow empty clauses and empty buckets. In the XOR bucket above,
each of the four cross-polarity pairs contains complementary y literals,
so every resolvent is a tautology and only R remains. The other constraints
may share either y variable: they are still independent of this particular x.

The [new driver](probe_overlap_repair.py) imports the existing `Dag('factor')`.
Inputs use nonzero signed variable IDs and an elimination order containing
each occurring variable exactly once (unused listed variables are harmless).
At each step it tries the following bounded operation before cofactoring:

1. Scan the existing root as a conjunction of literal clauses (a literal or
   single clause is allowed). Do not distribute an arbitrary DAG into CNF.
   Fail the attempt immediately on a nonclausal child.
2. Charge root/child visits and literal-row operations to a per-attempt
   structural budget C=32L0, where L0=1+n+sum_C(1+width(C)) for the original
   input. Reject a charge that would exceed C. After recognition, require
   p*q<=16 for the raw positive/negative bucket counts; the cap is on pairs
   before tautology elimination or deduplication.
3. Examine all permitted pairs under the same budget, storing the complete
   tentative clause list. No DAG nodes are allocated until this attempt has
   succeeded. Then construct the exact projected root and retain both
   polarity remainder lists for witness lifting.
4. On either cap or a shape failure, discard tentative lists and call the
   original exact two-cofactor operation on the unchanged root. Save both
   restriction roots. A cap is never a NO answer and never accepts a partial
   set of resolvents.

There is at most one attempt per eliminated variable; later steps may try
again even after fallback. Failure work is counted before fallback work,
so repeated scans are not hidden. The budget counts structural entries,
not every Python instruction. Sorting a produced literal list, hashing,
materializing sets and accepted DAG construction have additional costs;
their entry counts are bounded by C and the pair cap. Recognition and
candidate processing involve polynomially many structural entries and
comparison operations in these caps. This is not a polynomial bit-work
bound in original input length: node-handle bit lengths and access/hash
costs in the accumulated DAG arena also count, and that arena may have
grown during fallback. Postcommit constructor counters are reported
separately; their host lookup costs are not absorbed into the tick budget.
No polynomial bound follows for the fallback residual or repeated traversal.
The initial encoding length
also pays O(log(n+2)) per dense variable ID. Saved literal histories and
saved DAG roots are distinct resources. Recursive Python depth/memory limits
remain; counters are diagnostic operations, not a bit-runtime certificate.

## Exactness and witness recovery

Every accepted bucket equals exists x G: if A_i is false then x must be 1,
and its resolvent with every B_j forces those B_j true. Otherwise choose
x=0. This proves both directions including empty/one-sided buckets;
discarding a tautology cannot remove a pair with both remainders false.
Every fallback is G[x=0] OR G[x=1]. Hence induction proves the exact
existential-prefix invariant for arbitrary CNF, regardless of cap failures.

Reverse a true final root. For a saved bucket choose x=1 iff some positive
remainder is false under the later assignment; check the other polarity.
For a saved cofactor record use the prior zero-branch evaluation rule.
All remainder variables have already been assigned in reverse order.
The driver checks the returned complete assignment directly against the
original CNF. False final constants give NO. The mathematical algorithm is
finite, while no uniform polynomial bound on the fallback is proved.

## Bounded executed evidence

```text
python research/p-equals-np/probe_overlap_repair.py --output research/p-equals-np/2026-09-08-overlap-repair-output.json
```

The [UTF-8 LF output](2026-09-08-overlap-repair-output.json) records one fixed
suite: 28 configuration/case runs and 1540 independent prefix checks, PASS.
The same fixed suite was rerun after replacing short-circuit literal
evaluation by full-row evaluation in the witness counter; reported results
and structural totals were unchanged. This makes literal-visit counts actual
evaluations rather than upper row-entry charges.
It includes a two-edge chain (five variables), three-edge cycle (six),
their UNSAT pinned variants, empty CNF, empty clause and opposite units.
For a cycle the pins prescribe odd XOR parity around the cycle; for the
chain they fix an edge's x=1 and both endpoint y=0. The 12 SAT runs return
independently verified witnesses; the remaining 16 return NO. Configurations
include the old package, the hybrid, pair-cap zero and work-cap one, exercising
exact fallback. These deliberately restrictive caps are configuration tests,
not alternative solver claims.

The family sweep uses chain/cycle m=3,4,6,8 with x variables first and then y;
larger cases receive final witness checks, not exhaustive truth tables.

| m | Shape | Old x-prefix nodes/edges | Hybrid x-prefix | Old total allocated nodes/edges | Hybrid total allocated nodes/edges |
|---|---|---|---|---|---|
| 3 | chain | 30/45 | true | 60/152 | 31/60 |
| 3 | cycle | 28/45 | true | 57/150 | 29/60 |
| 4 | chain | 39/60 | true | 79/235 | 40/88 |
| 4 | cycle | 37/60 | true | 76/232 | 38/88 |
| 6 | chain | 57/90 | true | 117/449 | 58/156 |
| 6 | cycle | 55/90 | true | 114/444 | 56/156 |
| 8 | chain | 75/120 | true | 155/727 | 76/240 |
| 8 | cycle | 73/120 | true | 152/720 | 74/240 |

For m=8 cycle, old cofactor edge visits are 2860 and witness DAG edge visits
2460; its historical-root graph has 133 nodes/522 edges. The hybrid instead
charges 1288 bucket ticks, examines 32 raw pairs (all tautological), retains
64 bucket-literal entries and visits 64 witness-literal entries. It allocates
74 nodes/240 edges cumulatively, although its historical DAG roots contain
only the final constant. This literal history is not zero-cost memory.
All 16 sweep witnesses pass original-CNF verification.

## Surviving obligation

This repairs a concrete missed simplification with a bounded classical local
operation on an overlapping chain/cycle family. The initial-compatible
projection is exact, but general clauses can exceed the pair/work cap or
produce nonclausal residuals after fallback. A uniform bound on those exact
fallback residuals, cumulative cofactor work and historical storage is still
missing. Successful local projection does not establish such a bound, and
failed local projection does not establish that the general task is hard.
