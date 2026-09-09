# Factored cofactors: proof, code and nonclaims review

2026-09-08. S3040 / S008 / E004. Harness-only independent review of
`2026-09-08-factored-cofactors-attempt.md`, `probe_factored_cofactors.py`
and `2026-09-08-factored-cofactors-output.json`. This reviewer covers the
proof-adversarial/code and nonclaims lenses separately below; these are
not two independent reviewers. Source/complexity review is assigned
separately. No formal build, commit, push or formal route-final is involved.

## Proof-adversarial and code lens — GO

The final saved code and results pass this bounded audit. The final
instrumentation additions for all sorting sites, set-difference inputs and
witness traversal were inspected. No outstanding correction was found.

`op` implements the claimed Boolean identities. Constant identity and
absorption, unary collapse, same-operator flattening, idempotent deduplication,
literal complement detection and child ordering all preserve semantics.
For common-factor extraction, each OR child is treated as either its
conjunct set or a singleton factor. Pulling their intersection outside the
OR is distributivity, including an empty remaining conjunction, which
correctly becomes true. Recursive construction removes common factors
from the inner OR and never reverse-distributes them. The implementation
does not invoke a hidden equivalence or SAT oracle, nor does it purport
to identify every semantic equivalence.

Constants are node IDs 0 and 1; literal IDs are separate tagged nodes.
Constructors compare IDs explicitly, not by Python truthiness. Both
cofactor and evaluation caches use membership tests, so a cached false
value or ID 0 is not mistaken for a missing entry. Signed literal
restriction returns int(bit==(value>0)), which gives the correct ID.
The complement test operates only on signed literal nodes and cannot
mistake the true constant for literal variable 1. The fixed driver uses
nonzero literals and orders covering all occurring variables once.
Those are the input preconditions for the tested `run_case` helper;
it is not a separately validated arbitrary-input parser.

`cofactor` traverses the explicit DAG with a cache local to one variable
and bit. Every rebuilt gate applies a semantics-preserving constructor,
so the root is the exact restriction. OR of the two roots is existential
elimination. Saved roots remain available in the immutable node table.
After all variables have been eliminated the constructor rules reduce
to a constant. Reverse lifting evaluates the zero cofactor under already
assigned later variables, chooses it if true and otherwise chooses one.
The selected-root assertion and final original-CNF check verify the
result. Empty SAT input correctly yields witness {}, which is distinct
from None; UNSAT results carry no invented witness.

The equality-family repair has a direct structural explanation beyond
the finite measurements. At each x step the two restrictions have a
common conjunction of the untouched equality clauses and complementary
y literals. The factor mode extracts that conjunction and reduces the
complementary OR to true. The final x elimination also works when the
common residual is the empty true conjunction. Thus the current root
after the entire x prefix is syntactically true in this mode. This is
a family-specific invariant, not a general polynomial bound.

### Validation independence and reproduced evidence

The truth oracle evaluates the original clause list directly with Python
Boolean operations and explicitly enumerates eliminated assignments.
It does not use DAG constructors, cofactor results or factoring to compute
the expected result. Every remaining assignment is checked at each
prefix. This tests the existential relation itself, beyond only final
SAT status. Original-CNF witness checks are likewise independent of the
rewrite representation. This is independent semantics validation, not
a formal proof of every execution of the Python interpreter.

The saved fixed suite reports 18 mode/case combinations, 414 prefix checks,
12 SAT cases with verified witnesses and 6 UNSAT cases. Its final results
were inspected after the instrumentation rerun. All 12 larger benchmark
witnesses are also checked, but those larger measurements do not claim
exhaustive prefix truth-table validation.

This reviewer additionally ran all 512 subsets of the nine normalized
non-tautological clauses on two variables, with both elimination orders
and both modes. The final saved code passed 2,048 runs and 14,336 prefix
checks; 380 runs were SAT and every returned witness passed original-CNF
verification. The sweep was repeated after the final instrumentation
change and produced identical counts. It creates no output file. To
reproduce from the repository root, execute the following Python code
with the ordinary interpreter, without `-O` (assertions must remain on):

```python
import runpy

api = runpy.run_path('research/p-equals-np/probe_factored_cofactors.py')
clauses = [(), (1,), (-1,), (2,), (-2,),
           (1, 2), (1, -2), (-1, 2), (-1, -2)]
runs = checks = sat = 0
for mask in range(1 << len(clauses)):
    cnf = [c for i, c in enumerate(clauses) if mask & (1 << i)]
    for order in ([1, 2], [2, 1]):
        for mode in ('plain', 'factor'):
            result = api['run_case'](cnf, order, mode, verify=True)
            runs += 1
            checks += result['semantic_checks']
            sat += result['sat']
assert (runs, checks, sat) == (2048, 14336, 380)
print('PASS', runs, checks, sat)
```

### Counted outputs and limits

The saved JSON agrees with the note's table. At m=10, the plain x-prefix
root has 2,067 nodes and 12,286 edges, while the repaired root is one true
constant with no edges. Total allocations are 6,223/36,926 nodes/edges
versus 90/348. Stored-history reachable totals are 6,198/36,864 versus 75/234,
and both modes retain 40 cofactor roots. All allocated nodes remain in the
node table, including nodes unreachable from current or historical roots.
These quantities therefore do not confuse final-root size with history
or cumulative allocation.

Final JSON counters also match the stated cofactor edges 74,212 versus 660
and witness-evaluation edges 47,478 versus 558. Factor mode records 865
normalization child visits, 913 sorting comparisons and 378 set-difference
input entries. The `sorted_ids` helper now covers every ID sort site.
Witness counters include the selected-root assertion; semantic oracle
work, final CNF checks and reachability reporting are explicitly separate.
The counters are operation diagnostics, not complete bit costs for Python
hashing, allocation, integer arithmetic, set iteration or materialization.

## Nonclaims lens — GO-WITH-NOTES

The concrete advance is an implemented local factor repair and bounded
semantic validation in a signed-literal AND/OR DAG engine. The prior
equality sharing failure is cited as existing evidence, not rediscovered
or presented as the new contribution. The Boolean-ring engine remains
a different representation and is not silently substituted here.

The method has exact cofactor semantics and definite final decisions
when its explicit finite execution completes. The recursive Python
prototype still has recursion and memory limits, which the final note
states. The semantic identities do not establish unrestricted runtime
or successful execution at arbitrary input depths.

The equality invariant and observed reductions are not extrapolated to
arbitrary CNF. Neither a finite benchmark nor a small final root bounds
cumulative restriction work, edge references, normalization, saved
history or bit complexity generally. Failure to find nonlocal identities
also does not prove that any such identity is necessary for every method.

No general polynomial SAT algorithm, complexity separation, Lean theorem,
physical device or Navier--Stokes consequence is established. The bounded
implementation result passes. General polynomial resource bounds and the
full research objective remain unresolved; this is not formal route-final
or full-goal closure.
