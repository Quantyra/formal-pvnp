# Support locality: proof, code and nonclaims review

2026-09-08. S3040 / S008 / E004. Harness-only independent review of
`probe_support_locality.py`, `2026-09-08-support-locality-attempt.md` and
`2026-09-08-support-locality-output.json`, against the fixed fallback-stress
baseline. One reviewer covers the two lenses below; these are not two
independent reviews. Source/complexity review is assigned separately.
No candidate repair, larger search, formal build, commit or push occurred.

## Proof-adversarial and code lens — GO

The final saved diagnostic and interpretation pass without outstanding
corrections. The imported factored-DAG, overlap and fallback-stress source
files have no diff against HEAD. This observer wraps the bucket call,
returns its original result, and restores the original function in `finally`.
It does not choose a new variable, change the root or add a new projection.

The support recursion computes exactly the set of variable IDs appearing
at reachable literal nodes: constants contribute nothing, literals their
absolute ID, and gates the union of child sets. Immutable node contents
make the persistent per-run cache valid as new nodes are appended. Cache
membership is tested explicitly, including cached empty supports. Absence
from this support implies semantic independence; presence does not prove
semantic dependence. A syntactically nonempty tautology can therefore
remain an offending factor under this intentionally syntactic diagnostic.

The independent validator collects literal IDs by a separate iterative
walk without using cached child supports. It checks each cached entry,
not merely the root. Its cost is separately recorded. This is a structural
support check, not a semantic-dependence oracle.

Top-level factors are precisely an AND root's children or the single root.
The shape classifier accepts literals, ORs of literals and constants, and
rejects other shapes. Its empty tuple for both constants is only a shape
marker: constants have empty support and never enter a dependent bucket.
The independent remainder must still retain a false constant. No code
here constructs a projected formula by treating false as true.

For current x, every factor whose support contains x must be clausal for
the proposed dependent subproblem to be shape eligible. Consequently
support(root) minus the union of nonclausal-factor supports gives exactly
the shape-eligible active variables. Variables absent from the root can
be trivially independent but are correctly excluded from the alternate-
active-variable comparison. An independent nonclausal factor does not
make x eligible if another nonclausal factor still contains x.

The entry-cost formula matches the existing parser for the hypothetical
normalized dependent root. An empty dependent conjunction becomes true,
costing one root and one row visit, hence2. A singleton literal or OR
clause costs2+2 times its literal count. Multiple clauses cost
1+sum(1+2 times row length). Positive and negative counts give the raw
pair product before tautology removal. Each candidate adds
1+len(A)+len(B)+len(set(A) union set(B)), exactly the two tick charges.
A failing diagnostic can combine those charges in its report rather than
reproduce the precise partially used counter, but its acceptance predicate
is the same. It does not count accepted construction or reattachment as
already performed work.

### Independent copied-root checks

This reviewer compared the diagnostic with real bucket attempts on copied
DAG arenas, never on a modified baseline arena. The cases included true,
false, singleton literal, singleton clause, the positive hand case, and
all six observed states of n=6, seed17, ascending order. Current and active
alternate variables were tested with pair caps0,1,16 and work caps
0,1,2,3,10,16,1000. All 672 acceptance comparisons passed; every accepted
attempt's actual bucket ticks equaled the predicted precommit entry cost.
Original nodes, intern tables and solver counters remained identical,
and that representative solver replay matched its full saved result.

The essential independent comparison, after loading the observer module,
is reproduced by the following helper. `original_bucket` is the unwrapped
`stress.bucket`; the clone uses the existing factor-mode constructors:

```python
from collections import Counter

def compare(d, root, current, Diagnostic, Dag, original_bucket):
    diag = Diagnostic(d)
    event = diag.observe(root, current, 16, 1000)
    before = (list(d.nodes), dict(d.ids), dict(d.count))
    checks = 0
    for var in sorted(set(event['active_support']) | {current}):
        dependent = [f['node'] for f in event['top_factors']
                     if var in f['support']]
        for pairs in (0, 1, 16):
            for work in (0, 1, 2, 3, 10, 16, 1000):
                prediction = diag.local_check(event['top_factors'], var,
                                              pairs, work)
                clone = Dag('factor')
                clone.nodes = list(d.nodes)
                clone.ids = dict(d.ids)
                clone.count = Counter(d.count)
                dep_root = clone.op('and', dependent)
                stats = Counter()
                result = original_bucket(clone, dep_root, var,
                                         pairs, work, stats)
                expected = prediction.get('precommit_check_pass', False)
                assert (result is not None) == expected
                if expected:
                    assert stats['bucket_ticks'] == prediction['precommit_entry_cost']
                checks += 1
    assert (d.nodes, d.ids, dict(d.count)) == before
    diag.verify()
    return checks
```

The positive hand case has one nonclausal factor independent of x and two
dependent binary clauses of opposite polarity. It correctly passes with
one pair while the original whole-root parser fails shape recognition.
Both the saved positive check and the independent copied-root check passed.
This verifies the diagnostic's positive path; it is not an implementation
of reattachment or a changed continuation on the recorded corpus.

### Baseline identity, literal walks and measured counts

The observer's equality assertion compares each full replay result to
the saved baseline after JSON key normalization. It includes decisions,
witnesses, all snapshots and every original counter, not just the final
answer. The saved output records identity for all32 runs. Root separately
reported a byte-identical reproduction of the full observer output.
This reviewer independently obtained identical full results on the n=6,
seed17 ascending replay and n=12, seed17 static-degree replay. Diagnostic
cost lives in a separate ordinary Counter and does not charge solver caps.

On that n=12 replay, this reviewer used another direct literal-leaf walk
to check every currently cached support and every reported factor/root
support at each call. There were 2,841 cache-entry checks over 348 distinct
cached nodes and12 events, all passing. The actual stage10 variable was11;
its sole nonclausal factor was independent, no dependent nonclausal factor
remained, and the predicted precommit cost was12. This verifies the actual
reported opportunity, not only a synthetic positive example.

Independent aggregation of the saved records confirmed 288 events and
195 nonclausal aborts. Of those,194 have a dependent nonclausal factor;
only one current variable passes the local checks. There are188 states
with no active shape-eligible alternative and four states with an active
alternative passing all precommit checks. These are descriptions of the
unchanged recorded states, not outcomes of selecting those alternatives.
The saved independent support-validator total is5,598 cached entries;
the diagnostic and verification work is separately disclosed.

The historical first-step correction is valid:31 first calls fail the
pair cap, while n=8, seed43 ascending accepts its first variable and has
the remaining pair-cap failure at step2. The aggregate remains32. This
corrects an earlier temporal qualifier without changing a solver result
or the prior aggregate count.

## Nonclaims lens — GO-WITH-NOTES

The increment is an observational diagnostic, not a new solver or an
implemented support-local repair. A passing local shape/pair/entry check
does not establish accepted projection, cheaper continuation, better
ordering or a bound on total work. The final note explicitly withholds
those conclusions and recognizes that the hoped-for broad opportunity
did not appear in these states.

Syntactic support is not exact semantic dependence. An empty active
eligible set excludes only this syntactic shape recovery at the unchanged
state. It excludes neither different prior orders, semantic cancellation
nor other representations. Likewise the broad support of an OR factor
is not a lower bound or evidence of SAT hardness.

Support caches, union inputs, membership scans, sorting and independent
validation add real diagnostic cost outside the original solver budget.
Their counters are not a complete bit-runtime account. The one current-
order opportunity and proposed initial-order alternatives have no executed
counterfactual continuation here. Any future repair or order experiment
requires its own bounded execution and resource accounting.

No general polynomial-time SAT algorithm, P=NP conclusion, physical
transfer or formal theorem follows. The bounded diagnostic passes; the
general cumulative resource invariant and full research objective remain
unresolved. This is not formal route-final or full-goal closure.
