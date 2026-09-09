# Adaptive buckets: proof, code and nonclaims review

2026-09-08. S3040 / S008 / E004. Harness-only independent review of
`probe_adaptive_buckets.py`, `2026-09-08-adaptive-buckets-attempt.md` and
`2026-09-08-adaptive-buckets-output.json`. One reviewer covers the two
separate lenses below; they are not two independent reviews. Source and
complexity review is assigned separately. Only the saved sixteen formulas
and bounded small correctness/cap cases were used. No larger search,
formal build, commit or push occurred.

## Proof-adversarial and code lens — GO

The final saved implementation and interpretation pass. The dense-input
permutation assertions, clearing of `active_var` when entering selection,
and predicted-versus-actual bucket-success assertion were inspected after
application. No outstanding correction remains. Imported implementation
modules have no diff against HEAD.

The input guard requires `static_order` to permute1..n and all literals to
have nonzero IDs in that range. The remaining list starts as that dense
ascending range and is filtered once after a successful elimination.
Selected and fallback variables are checked for membership before use.
Thus completed runs cover every variable exactly once, including harmless
unused listed variables. The diagnostic fix prevents a selection-phase
resource interruption from reporting the previous eliminated variable as
its active variable.

Selection reads the whole root as clauses. It handles true and false
constants distinctly during recognition, accepts literals/ORs of literals,
and aborts on nonclausal shapes. No partial distribution into CNF or
speculative DAG construction is performed. Candidate remainders and set
unions are local data only. The parser and candidate cost formulas match
the original whole-root bucket ticks, including empty and singleton roots.
Every candidate must pass both the raw-pair and precommit-entry tests.
Among all feasible candidates, the incremental comparison selects the
lexicographic minimum(raw pairs, variable ID). Remaining variables are
already sorted; this is not an uncharged per-stage sort.

A selector entry-cap failure discards the tentative best score, rather
than claiming optimality from a partially scanned candidate list. Shape
failure or no feasible candidate likewise selects the first remaining
variable in the original static-degree order. These branches change only
the order. The unchanged actual bucket is still called; local failure
uses exact two-cofactor elimination. A prediction is not substituted for
that operation. The new assertion checks accepted predictions directly.

The prefix oracle ranges over the actual current `remaining` list and
existentially quantifies the actual `eliminated` list. Those lists are
disjoint and cover the original dense variables. It does not accidentally
use the original static order. Accepted bucket and cofactor identities
therefore maintain the correct dynamic-prefix relation. Reverse lifting
uses the actual mixed history: later-eliminated variables have already
been assigned when a saved remainder or cofactor is evaluated. The
original CNF independently verifies each completed witness.

Selector, local-bucket and experiment caps have distinct meanings. Local
selector failure falls back; local bucket failure cofactors; a global
resource exception interrupts the entire experiment. In particular the
charged remaining-list update occurs before list/history/root commit.
If that charge fails after a candidate root has been constructed, the
old state remains the last committed state. Partial allocation/work is
retained in terminal counters. An answer is assigned only after complete
elimination and any witness verification. Global interruption clears the
partial witness and leaves a null algorithm answer. Unexpected assertions
are not swallowed as cap results.

### Independent bounded semantic and selection checks

All512 subsets of the normalized two-variable clause universe were tested
in both static orders under selector caps1,5,20,10000. This gave4,096
completed runs,28,672 actual-prefix checks and760 verified SAT witnesses.
Every snapshot's eliminated/remaining partition was also checked. The
selection reasons included3,490 entry-cap fallbacks and4,702 completed
selections. This is an exhaustive small-domain semantics check, not a
larger primary stress campaign. It can be reproduced from the repository
root with assertions enabled and the following code:

```python
import sys, runpy
from pathlib import Path
sys.dont_write_bytecode = True
sys.path.insert(0, str(Path('research/p-equals-np').resolve()))
api = runpy.run_path('research/p-equals-np/probe_adaptive_buckets.py')
clauses = [(), (1,), (-1,), (2,), (-2,),
           (1, 2), (1, -2), (-1, 2), (-1, -2)]
runs = checks = sat = 0
for mask in range(512):
    cnf = [c for i, c in enumerate(clauses) if mask & (1 << i)]
    for order in ([1, 2], [2, 1]):
        for cap in (1, 5, 20, 10000):
            r = api['solve'](cnf, order, True, selector_cap_override=cap)
            assert r['status'] == 'COMPLETE'
            assert sorted(r['eliminated']) == [1, 2] and not r['remaining']
            for i, stage in enumerate(r['stages']):
                assert len(stage['eliminated']) == i
                assert sorted(stage['eliminated'] + stage['remaining']) == [1, 2]
                assert not set(stage['eliminated']) & set(stage['remaining'])
            runs += 1
            checks += r['semantic_prefix_checks']
            sat += r['algorithm_sat']
assert (runs, checks, sat) == (4096, 28672, 760)
```

Separately, all512 starting roots were tested with local work caps
0,2,4,10,16,1000 and a large selector cap. For each of3,072 selections,
the reviewer copied the DAG and actually called the bucket for both
remaining variables, forming the minimum score among accepted calls.
The selected variable or absence of one matched exactly. Original nodes,
intern table and DAG counters stayed unchanged by selection. This checks
feasibility independently of merely trusting the selector's own report.

### Independent commit and cap boundary checks

For `[(1,2),(-1,-2)]` with static order `[1,2]`, initialization used51
units; completed stages used114 and124, and full witness completion126.
The following final-code checks passed:

- Global cap112 interrupted after a successful bucket but before the
  remaining-list charge. The terminal bucket-success counter was one,
  but eliminated was empty, remaining was `[1,2]`, only initialization
  had a snapshot, and no answer or witness was returned.
- Global cap114 interrupted the next selection after variable1 had been
  committed. `active_variable` was None, as required by the diagnostic fix.
- Global cap124 interrupted witness reconstruction after both variables
  were eliminated, still returning no answer and no partial witness.
- Selector cap22, with static order `[2,1]`, interrupted after a feasible
  tentative score for variable1 had been found. The run discarded that
  score and chose variable2 from static fallback, completed, and passed
  all dynamic-prefix and original-witness checks.

These are tiny boundary tests, separate from the fixed formula results.
To reproduce after loading `api` above:

```python
caps = api['base'].CAPS
defaults = dict(caps)
cnf = [(1, 2), (-1, -2)]
try:
    for limit, phase, eliminated in [(112, 'elimination', []),
                                      (114, 'selection', [1]),
                                      (124, 'witness', [1, 2])]:
        caps.clear()
        caps.update(defaults)
        caps['charged_units'] = limit
        r = api['solve'](cnf, [1, 2], True)
        assert r['status'] == 'INCOMPLETE' and r['stop_phase'] == phase
        assert r['algorithm_sat'] is None and r['witness'] is None
        assert r['eliminated'] == eliminated
        if phase == 'elimination':
            assert r['remaining'] == [1, 2] and len(r['stages']) == 1
            assert r['terminal']['hybrid_counts']['bucket_successes'] == 1
            assert r['terminal']['selector_counts'].get('remaining_list_entries', 0) == 0
        if phase == 'selection':
            assert r['active_variable'] is None
finally:
    caps.clear()
    caps.update(defaults)
r = api['solve'](cnf, [2, 1], True, selector_cap_override=22)
assert r['status'] == 'COMPLETE' and r['eliminated'][0] == 2
assert r['stages'][1]['selection']['reason'] == 'entry_cap'
```

### Saved corpus and accounting checks

This reviewer independently evaluated each of the16 saved formulas by
integer-bitmask truth enumeration and checked all returned witnesses.
All16 completed:12 SAT and4 UNSAT, with2,552 saved dynamic-prefix checks.
The input hash references match the unchanged saved corpus. All160
snapshots were checked for variable partition and actual transition order,
and charged totals equal the sums of the three counter categories.

All39 reports of a selected feasible variable matched the minimum listed
score and an actual successful bucket call. Each actual bucket-tick delta
equaled the selected candidate's predicted entries. The16 no-feasible
and89 nonclausal fallbacks chose the first remaining static-order variable.
These checks are stronger than final-answer agreement alone.

The comparison figures were independently aggregated: static-degree units
sum320,586; adaptive common-base units318,378; added selector units62,632;
adaptive total381,010. Common work decreases on six formulas, increases
on four and ties on six. Adaptive total exceeds static-degree total on
every formula. The saved negative net result is therefore supported and
not obscured by selecting only a weaker baseline or omitting selector cost.

## Nonclaims lens — GO-WITH-NOTES

This is one implemented adaptive continuation on the same sixteen inputs,
not the prior dependency-local proposal and not a search for favorable
seeds. Read-only selection and exact dynamic elimination are established
for the stated finite procedure; a uniform polynomial resource bound is not.

The budgets count declared, partly overlapping structural categories.
They are not wall-clock or full bit costs. Adding selector units changes
the charged metric relative to the baseline, and the output separates
common and added work explicitly. Recorded memory sums are across
independent runs, not simultaneous resident memory.

The small increase in accepted buckets does not control later nonclausal
residuals or offset this selector's measured cost. The note correctly does
not recommend adopting the exact rule as a net improvement under its
metric. Neither this negative finite result nor an inexpensive individual
projection proves a general complexity lower or upper bound. Alternative
selectors or representations remain distinct untested algorithms.

No general polynomial-time SAT algorithm, P=NP conclusion, physical
device or Lean theorem follows. The bounded implementation passes;
arbitrary-input cumulative work bounds and the full research objective
remain unresolved. This is not formal route-final or full-goal closure.
