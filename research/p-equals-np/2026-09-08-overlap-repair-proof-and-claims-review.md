# Overlap repair: proof, code and nonclaims review

2026-09-08. S3040 / S008 / E004. Harness-only independent review of
`2026-09-08-overlap-repair-attempt.md`, `probe_overlap_repair.py` and
`2026-09-08-overlap-repair-output.json`, using the previously reviewed
factored DAG implementation. One reviewer covers the separate lenses
below; these are not two independent reviews. Source/complexity review
is assigned separately. No formal build, commit or push is involved.

## Proof-adversarial and code lens — GO

The final saved derivation, code and bounded results pass. No outstanding
correction remains. The final full-list witness evaluation was inspected:
its literal-visit counter now corresponds to evaluating every literal in
each visited row, including rows whose `any` result could short-circuit.

The four displayed clauses exclude exactly the triples violating
x=(a XOR b). Direct inspection and an independent truth-table check against
the XOR equation verify the signed convention. The chain pins x=1,a=b=0
contradict one such equation. The cycle pins impose odd total x parity,
contradicting the XOR of the edge equations around the cycle. These are
actual UNSAT inputs, rather than merely unexpected simulation outputs.

Each unconstrained x bucket has two positive and two negative remainders.
Every cross-polarity union has a complementary y pair, so every resolvent
is tautological. The exact elimination therefore leaves the remainder R,
even when other clauses share the y variables. The old factor constructor
instead retains a small OR of complementary functions. The note correctly
describes the measured old residual as linear-sized, not exponential.

The parser accepts only a conjunction of literal clauses, a single literal,
a single literal clause, or constants. It does not distribute arbitrary
DAGs into CNF. Canonical factor construction has already removed duplicate
and complementary literals; otherwise a clause containing both polarities
would invalidate a one-sided bucket classification. Nonliteral clause
children cause `Abort('not_clausal')` and exact fallback.

Constants are handled explicitly: true rows are ignored, false rows retain
the empty clause. A successful projected false root is node ID0, and `run`
tests `result is None`, so it does not confuse that valid success result
with an aborted attempt. Empty and one-sided buckets obey the same exact
resolution identity. The input contract requires nonzero signed literals
and an order covering every occurring variable once; extra unused listed
variables are harmless.

Before commit, `bucket` only reads the DAG and builds local Python lists,
sets and statistics. Both pair-cap and work-cap aborts return None without
allocating or changing DAG nodes. No partial resolvent list is committed.
Only after all candidates pass does it call constructors on the complete
list and return the projected root. The fallback uses the original root
to construct both cofactors and their OR. Thus each step is an exact
existential elimination, regardless of cap failures or nonclausal shapes.

For bucket witness lifting, some false positive remainder forces x=1;
otherwise x=0 works. Accepted resolvents ensure that the other polarity
is then satisfied. All remainder variables are assigned by the reverse
stage. Cofactor records use the already reviewed zero-branch rule. The
code checks the selected clauses or cofactor and then the original CNF.
Caps never directly return NO; only a final false exact root does.

The tick cap bounds selected structural entries before commit, not elapsed
time or every Python operation. Sorting, set operations, hashing and
accepted constructor work remain real costs; the note explicitly identifies
them. Bounded local candidate sizes do not cap the exact fallback's size
or traversal work. Python recursion and memory limits remain separate
from finiteness of the mathematical elimination procedure.

### Independent validation, including intermediate aborts

The final author's JSON reports 28 configuration/case runs and 1,540 prefix
checks, with 12 SAT and 16 UNSAT results. The oracle evaluates the original
CNF under explicitly enumerated eliminated assignments, independently of
the DAG representation. Its cap-zero and work-one cases exercise fallback
but do not alone establish correct intermediate-abort handling.

This reviewer therefore tested all 512 normalized two-variable CNFs in
both variable orders under six cap configurations. The final saved code
passed 6,144 runs, 43,008 prefix checks and 1,140 SAT witness checks. These
runs included 668 work-cap aborts and 348 pair-cap aborts. The sweep was
repeated after the final witness instrumentation change, with identical
counts. The following Python code reproduces it from the repository root
without writing output or bytecode files; do not disable assertions:

```python
import sys, runpy
from pathlib import Path
from collections import Counter
sys.dont_write_bytecode = True
sys.path.insert(0, str(Path('research/p-equals-np').resolve()))
api = runpy.run_path('research/p-equals-np/probe_overlap_repair.py')
clauses = [(), (1,), (-1,), (2,), (-2,),
           (1, 2), (1, -2), (-1, 2), (-1, -2)]
configs = [(0, 10000), (1, 10000), (16, 3),
           (16, 12), (16, 40), (16, 10000)]
runs = checks = sat = 0
stats = Counter()
for mask in range(512):
    cnf = [c for i, c in enumerate(clauses) if mask & (1 << i)]
    for order in ([1, 2], [2, 1]):
        for pairs, work in configs:
            r = api['run'](cnf, order, True, True,
                           pair_cap=pairs, work_cap=work)
            runs += 1
            checks += r['semantic_checks']
            sat += r['sat']
            stats.update(r['stats'])
assert (runs, checks, sat) == (6144, 43008, 1140)
assert (stats['abort_work_cap'], stats['abort_pair_cap']) == (668, 348)
print('PASS', runs, checks, sat)
```

A targeted non-tautological bucket used clauses
`[(1,2),(1,3),(-1,4),(-1,5)]`. With pair cap4 and work cap30 it aborted
after examining two candidates, with one candidate already stored. Exact
copies of `d.nodes`, `d.ids` and `d.count` were unchanged. It recorded
29 used ticks and two candidate literal entries. Pair cap3 rejected the
same four-pair bucket before generation, while pair cap4 with work cap10000
accepted all four pairs with41 ticks. For each configuration, a full
five-variable run passed all63 prefix checks and witness verification.
The accepted one-step projection was also checked at every remaining
assignment. To reproduce these targeted checks after the setup above:

```python
cnf = [(1, 2), (1, 3), (-1, 4), (-1, 5)]
for pairs, work, reason in [(4, 30, 'work_cap'),
                            (3, 10000, 'pair_cap'), (4, 10000, None)]:
    d = api['Dag']('factor')
    root = d.op('and', [d.op('or', [d.lit(x) for x in c]) for c in cnf])
    before = (list(d.nodes), dict(d.ids), dict(d.count))
    stats = Counter()
    out = api['bucket'](d, root, 1, pairs, work, stats)
    if reason:
        assert out is None and stats['abort_' + reason] == 1
        assert (d.nodes, d.ids, dict(d.count)) == before
        if reason == 'work_cap':
            assert stats['pair_candidates_examined'] >= 2
            assert stats['candidate_literal_entries'] >= 2
    else:
        assert out is not None
        for rest in api['assignments']([2, 3, 4, 5]):
            expected = any(api['cnf_value'](cnf, rest | {1: bit})
                           for bit in (False, True))
            assert d.evaluate(out[0], rest) == expected
    result = api['run'](cnf, [1, 2, 3, 4, 5], True, True,
                        pair_cap=pairs, work_cap=work)
    assert result['semantic_checks'] == 63 and result['witness_verified']
```

Independent direct-XOR checks additionally covered every assignment for
one- and two-edge chains and a three-edge cycle, each with and without
pins: 208 truth rows passed. These checks compared generated clauses with
the XOR equations and explicit pin conditions, not merely with themselves
as the prefix oracle would do. The tests are bounded evidence and do not
replace the local semantic proofs or prove every Python execution correct.

### Recorded resource observations

The note's representative final JSON values were inspected. At m=8 on
the cycle, the old prefix has73 nodes/120 edges and cumulative allocation
152 nodes/720 edges. The repaired prefix is true; cumulative allocation
is74 nodes/240 edges. Old cofactor and witness edge visits are2,860 and
2,460, with historical roots reaching133 nodes/522 edges. The hybrid has
1,288 bucket ticks,32 examined tautological pairs,64 saved literal entries
and64 witness-literal visits. A one-node historical DAG in that hybrid
does not include its separate saved literal lists; the note discloses them.
These are finite operation diagnostics, not complete bit-runtime bounds.

## Nonclaims lens — GO-WITH-NOTES

The implementation repairs a concrete missed identity using standard
bounded Davis--Putnam elimination before an exact fallback. It does not
claim a new resolution rule, exponential old growth on the measured
overlap family, or a general overlap lower bound. The old residual's
linear size and the limited novelty of the local repair are explicit.

The mathematical procedure preserves exact support and can produce both
SAT witnesses and definite NO results on completed runs. A local budget
failure is not a NO certificate, not a timeout-based decision and not a
hardness proof. The new cap is not a general runtime cap on fallback or
on Python execution. Successful local projection likewise supplies no
uniform polynomial bound for arbitrary-CNF residuals or history.

No general polynomial-time SAT algorithm, P=NP conclusion, physical
transfer or Lean theorem follows. The bounded implementation increment
passes; general cumulative resource bounds and the full research objective
remain unresolved. This is not formal route-final or full-goal closure.
