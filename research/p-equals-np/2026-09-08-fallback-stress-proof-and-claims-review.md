# Fallback stress: proof, code and nonclaims review

2026-09-08. S3040 / S008 / E004. Harness-only independent review of
`probe_fallback_stress.py`, `2026-09-08-fallback-stress-attempt.md` and
`2026-09-08-fallback-stress-output.json`. One reviewer covers the two
separate lenses below; these are not two independent reviews. Source and
complexity review is assigned separately. No formal build, commit, push
or larger stress search was performed.

## Proof-adversarial and code lens — GO

The final saved code, bounded data and interpretation pass. No outstanding
correction was found. The two imported implementation files have no diff
against HEAD; this driver changes neither their rewrites nor bucket logic.
Its subclassed interning retains the same node-key semantics, adding
pre-insertion allocation checks and diagnostics only.

The generator samples three distinct variables and independently chooses
their signs, then canonicalizes the signed tuple. It rejects only duplicate
clauses. The formula generation function makes no oracle call and does not
condition on SAT status. The fixed size/seed product gives 16 formulas,
each used with two specified complete orders. Static degree is computed
from initial literal occurrences and never updated using solving results.
This is a saved finite pseudorandom suite, not a theorem about a random
CNF distribution or a general hardness benchmark.

The original clause list is used for direct truth-table decisions and
prefix expectations, independently of the DAG and resolution machinery.
These oracle results are not arguments to `solve`. The driver compares
only completed solver answers with them. Witnesses are independently
checked against the clauses; JSON key conversion occurs only after these
checks and is handled explicitly by the review's saved-witness audit.

`ChargedCounter` charges every positive increment before storing the new
counter value. `Budget.charge` rejects an excessive addition without
changing the used total. The arena's node and edge caps are tested before
insertion, and the allocated-edge charge is also made before modifying
the intern table or node list. No exceeded insertion is reported as a
completed DAG update. A cap later in a larger constructor can leave
earlier allocations, which terminal diagnostics preserve.

Local bucket `Abort` still means exact cofactor fallback. Experiment-wide
`ResourceCap` is a different exception and is not caught by the bucket's
local handler. It reaches the outer solver handler and stops the run.
The new root and history record are committed only after the whole chosen
elimination operation returns. A cap can also occur during initialization
or witness reconstruction. `algorithm_sat` is assigned only after the
complete decision and any required witness verification finish. Both
resource handlers clear a partial witness and leave the algorithm answer
None. Oracle truth is never substituted. Assertions and unrelated errors
are not caught as resource events.

Snapshots are taken after initialization and each committed elimination.
They count current reachable DAG structure, the union with saved cofactor
roots, cumulative arena allocation, records and cumulative counters.
Bucket literal lists remain a separate resource in the hybrid counters.
The final stage snapshot precedes witness work, so terminal counters,
rather than that snapshot alone, are needed for total charged work.
An interrupted attempt can have partial allocation or counter increments
beyond the last snapshot; these are intentionally kept in terminal data.

### Independent audit of the saved fixed suite

This reviewer regenerated each of the 16 saved formulas using its stated
seed and verified exact clauses and generation-draw counts. Every clause
has three distinct variables in range, every clause set has the requested
size with no duplicates, and each compact-JSON SHA-256 matches. The two
saved orders agree with ascending order and the independently recomputed
static-degree order.

An independent integer-bitmask truth-table evaluator, using neither the
driver's `assignments` nor `cnf_value` helper, verified all 16 formula
decisions and every returned saved witness. All 32 runs are COMPLETE:
24 SAT and 8 UNSAT. The saved smaller-instance tests report 5,104 prefix
checks. This review checked all 320 snapshots for consistent prefix and
history-record indices, monotonically accumulated arenas/work, and
current <= historical <= allocated node/edge counts. At every snapshot
and terminal record, charged units equal the sum of DAG and hybrid
counter values, and arena edges equal the allocated-edge counter.

Independent aggregation also verified 288 attempts, 61 accepted buckets,
227 fallbacks, 32 pair-cap aborts, 195 nonclausal aborts and no local
work-cap aborts. There are 20 examined candidates, 1,798 requested pairs,
8 tautologies, 22,647 bucket ticks and 21,938 abandoned ticks. Overlapping
charged counters are not independent physical operations, as the note
expressly explains. No experiment cap was reached in this main suite;
its results alone would not test interruption semantics.

### Forced-cap checks on tiny inputs

This reviewer therefore ran ten small targeted cap cases, without adding
larger stress instances. For `[(1,2),(-1,-2)]` in order `[1,2]`, charged
budgets 0, 52, 80 and 81 interrupted initialization, elimination, witness
and witness respectively. Budgets 80 and 81 occur after both eliminations;
neither returned the known true root as a completed algorithm answer or
leaked its partial witness. Budget 82 completed with the verified witness.
Node cap2 and edge cap0 also interrupted initialization correctly. A
capped UNSAT unit-conflict input returned None, not an oracle-derived NO.

For `[(1,2),(-1,3)]`, setting either arena cap to its initialization total
interrupted accepted-bucket construction in the first elimination. Both
runs retained only the initialization snapshot and zero committed
eliminations, with no answer or witness. These checks distinguish local
fallback from interruption during a globally accepted construction.
The following reproduces all ten cases from the repository root, with
assertions enabled and no output or bytecode files written:

```python
import sys, runpy
from pathlib import Path
sys.dont_write_bytecode = True
sys.path.insert(0, str(Path('research/p-equals-np').resolve()))
api = runpy.run_path('research/p-equals-np/probe_fallback_stress.py')
caps = api['CAPS']
defaults = dict(caps)
def configure(**changes):
    caps.clear()
    caps.update(defaults)
    caps.update(changes)

cnf = [(1, 2), (-1, -2)]
for changes, phase in [({'charged_units': 0}, 'initialization'),
                       ({'charged_units': 52}, 'elimination'),
                       ({'charged_units': 80}, 'witness'),
                       ({'charged_units': 81}, 'witness'),
                       ({'nodes': 2}, 'initialization'),
                       ({'edges': 0}, 'initialization')]:
    configure(**changes)
    r = api['solve'](cnf, [1, 2], True)
    assert r['status'] == 'INCOMPLETE' and r['stop_phase'] == phase
    assert r['algorithm_sat'] is None and r['witness'] is None
configure(charged_units=82)
r = api['solve'](cnf, [1, 2], True)
assert r['status'] == 'COMPLETE' and r['algorithm_sat'] is True
configure(charged_units=0)
r = api['solve']([(1,), (-1,)], [1], True)
assert r['status'] == 'INCOMPLETE' and r['algorithm_sat'] is None
assert r['witness'] is None
configure()
cnf = [(1, 2), (-1, 3)]
base = api['solve'](cnf, [1, 2, 3], True)
for resource, field in [('nodes', 'allocated_nodes'),
                        ('edges', 'allocated_edges')]:
    configure(**{resource: base['stages'][0][field]})
    r = api['solve'](cnf, [1, 2, 3], True)
    assert r['status'] == 'INCOMPLETE' and r['stop_reason'] == resource
    assert r['stop_phase'] == 'elimination' and len(r['stages']) == 1
    assert r['terminal_diagnostics']['completed_eliminations'] == 0
    assert r['algorithm_sat'] is None and r['witness'] is None
configure()
print('PASS ten forced-cap cases')
```

An additional temporary in-memory replacement of the prefix oracle by
constant False on the satisfiable unit formula caused the expected
AssertionError to propagate, rather than being swallowed as INCOMPLETE
or a false answer. The original helper was restored immediately. No
source file was changed. Python-recursion interruption was checked by
inspection of its explicit handler, not claimed as reached by this suite.

## Nonclaims lens — GO-WITH-NOTES

This is a fixed 32-run implementation diagnostic with independent exact
checks. Completion on these inputs, low measured arenas and an order's
better charged total do not establish asymptotic bounds or a general
ordering advantage. The note identifies a counterexample to a single
resource ordering even inside the suite.

The charge metric deliberately adds overlapping diagnostic quantities.
It is not wall-clock time, peak memory, physical energy or complete bit
complexity. Oracle and reporting work are extra and are not passed off as
free solver computation. The production suite's absence of experiment-cap
events is explicitly disclosed; the forced-cap tests above provide separate
bounded evidence for their result semantics.

The 195 shape failures are observed eligibility losses, not hardness
evidence. Dependency-local projection is only a proposed next candidate.
The identity separating a factor independent of the eliminated variable
is valid, but the present data do not establish how often it helps or a
uniform bound on support, dependent-factor traversal or saved histories.
No such follow-up implementation or expanded search was performed here.

No general polynomial-time SAT algorithm, P=NP conclusion, physical
device, Lean theorem or formal route-final follows. The bounded audit
passes; arbitrary-input cumulative resource bounds and the full research
objective remain unresolved.
