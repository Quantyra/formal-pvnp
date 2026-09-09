# One adaptive continuation of the capped bucket hybrid

S3040 / S008 / E004, informal attempt under `INTEGRITY-CLAIMS.md`.
Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-adaptive-buckets-2026-09-08.md`.
No general polynomial-time SAT or physical-device claim is made.

The [support-locality measurement](2026-09-08-support-locality-attempt.md)
found at least one initially precommit-feasible variable in ten of sixteen
saved formulas, but did not test changed continuations. This increment tests
one fixed adaptive rule on exactly those sixteen saved formulas, without
new seeds, generation, satisfiability filtering or dependency-local rewrites.

## Exact selected rule and budget boundaries

The [driver](probe_adaptive_buckets.py) reuses the prior `CappedDag`, `Budget`,
`ChargedCounter` and complete bucket/cofactor operations; shared modules are
unchanged. Inputs are checked to have a static-order permutation of dense
IDs 1..n and nonzero signed literals in that universe. Let
L0=1+n+sum_C(1+width(C)). Each selector recognition/scoring call has an
entry budget 16nL0, fixed from the original input, in addition to the original
local bucket budget 32L0 and raw pair cap 16.

Scan the **whole current root** as literal clauses without distributing
nonclausal factors. If shape recognition fails or the selector entry budget
is exhausted, discard tentative scores and select the next uneliminated
variable in the original saved static-degree order. Otherwise examine each
remaining variable in ascending ID order, form its positive/negative clause
remainders, and test the original full-root precommit feasibility:

    recognition cost = 1 + sum_rows(1 + 2 width(row)),
    candidate pair cost = 1 + |A| + |B| + |A union B|.

True constant rows are skipped after their row-read charge; false constant
rows are empty clauses. A candidate must have at most 16 raw pairs and total
precommit entries at most 32L0. Among feasible candidates choose the minimum
pair (raw pair count, variable ID). If none is feasible use the same saved
static-degree fallback. Absent remaining variables are permitted and have
zero pairs; they are still removed exactly once. No DAG node or speculative
projection is constructed by selection, and no semantic equivalence or SAT
oracle is consulted.

After selection, call the unchanged actual bucket operation, with exact
cofactor fallback on local failure. The selector's feasibility estimate is
not itself elimination and is not used to skip that operation. Maintain the
remaining list in ascending order by explicit filtering; scoring uses an
incremental minimum, with no hidden per-step sorting. Initial static-degree
order is taken from the baseline, where its linear scan/sort construction
is documented. That setup, reporting and independent verification remain
separate overhead.

Selector root/row/literal reads, candidate/remainder entries, union inputs,
score comparisons, fallback-list scans and remaining-list filtering have
separate counters. Their positive increments also charge the same global
5,000,000-unit experiment budget as existing DAG/hybrid counters. The other
global limits remain 100,000 nodes and 1,000,000 arena edges. These are the
same limits but an expanded charged metric, not identical work accounting:
output separates common-base units from added selector units. Entry charges
are a declared structural metric, with overlapping quantities; host set,
tuple, integer, hash, allocation and bit costs are not thereby eliminated.
Neither local entry budget is a wallclock or full bit-work cap.
Fallback-list scanning and remaining-list filtering are outside the local
selector recognition/scoring cap, but are still charged to the global budget.

A selector-budget failure falls back, never returns NO. Global resource or
recursion exhaustion instead returns INCOMPLETE with null algorithm answer
and no witness. Unexpected errors/assertions remain errors. Terminal counters
retain work from an unfinished stage separately from completed snapshots.

## Exact dynamic prefixes and tests

Selection changes only the order. At each stage the root equals the original
CNF existentially quantified over the actual eliminated list: each accepted
resolution bucket and each two-cofactor fallback has that exact identity.
The chosen variable is in the remaining list and is removed once. Therefore
all variables are eventually eliminated unless the experiment interrupts.
Reverse the actual mixed bucket/cofactor history using the prior witness
rules; all variables in each saved remainder have already been assigned.

The independent prefix oracle uses the actual eliminated and remaining lists,
not the original static order. At n<=8 it checks every completed prefix and
remaining assignment against original-CNF enumeration. All sixteen completed
decisions are compared with a fresh direct truth-table search; any returned
witness is checked against original clauses. Oracle truth is never passed
to the solver. Initial clauses are read from the saved baseline; hashes link
the results to those exact inputs.

Before the sixteen primary runs, a tiny two-variable case forces selector
budget 1 and verifies exact fallback. Three tiny tests separately force the
node, edge and charged-unit global caps and require INCOMPLETE/null answer.
The original global caps are restored in `finally` before primary execution.
These are harness boundary tests, not additional corpus cases.

## Reproduction

```text
python research/p-equals-np/probe_adaptive_buckets.py --output research/p-equals-np/2026-09-08-adaptive-buckets-output.json
```

## Executed results and cost comparison

All sixteen primary runs complete and agree with fresh truth-table checks:
twelve SAT with verified witnesses, four UNSAT. There are 2552 independent
dynamic-prefix checks, all passing. The forced selector-cap case completes
correctly through fallback, and the three forced global caps each produce
INCOMPLETE with null answer/witness. Every selector-predicted feasible choice
also passes the actual unchanged bucket call, enforced by an assertion.

The same fixed suite was rerun after review tightened the dense-input check,
cleared the active-variable diagnostic on entering selection, and added the
prediction/actual-success assertion. Decisions and resource totals did not
change. No additional seeds or larger primary instances were run. Shared
modules remain unchanged. The [saved output](2026-09-08-adaptive-buckets-output.json)
records actual dynamic orders and all stages; baseline figures below are read
from the already saved stress output rather than another baseline campaign.

The comparison uses the same common-base counter categories plus the declared
added selector category. It is a structural-metric comparison, not measured
wallclock or bit-time superiority. In every instance, adding selector cost
makes the adaptive total larger than the static-degree baseline.

| n,seed | Saved static units | Adaptive common units | Added selector units | Adaptive total |
|---|---|---|---|---|
| 6,17 | 6970 | 7380 | 1907 | 9287 |
| 6,29 | 7725 | 7725 | 1041 | 8766 |
| 6,43 | 6853 | 6853 | 1052 | 7905 |
| 6,71 | 6887 | 6887 | 1026 | 7913 |
| 8,17 | 13735 | 13735 | 1825 | 15560 |
| 8,29 | 14057 | 12707 | 4958 | 17665 |
| 8,43 | 13761 | 14268 | 3334 | 17602 |
| 8,71 | 12275 | 12243 | 3113 | 15356 |
| 10,17 | 21477 | 21477 | 2651 | 24128 |
| 10,29 | 23050 | 22924 | 4819 | 27743 |
| 10,43 | 25777 | 24326 | 5156 | 29482 |
| 10,71 | 24864 | 27610 | 5090 | 32700 |
| 12,17 | 46195 | 46195 | 3904 | 50099 |
| 12,29 | 25849 | 25491 | 9173 | 34664 |
| 12,43 | 30138 | 30462 | 7124 | 37586 |
| 12,71 | 40973 | 38095 | 6459 | 44554 |
| Sum | 320586 | 318378 | 62632 | 381010 |

Common-base units decrease on six formulas, increase on four and are equal
on six. Their aggregate saving 2208 is outweighed by 62632 added selector
units. For completeness, the old ascending-order aggregate is 390525, and the
adaptive total beats that weaker comparator on twelve of sixteen formulas.
Selecting that comparator alone would hide the all-instance loss against
the already available static-degree rule.

Memory-related diagnostics are also mixed. Summed allocated nodes across
independent runs decrease 3372 to 3331 versus static degree, while allocated
edges increase 13172 to 13330. This is not simultaneous resident memory.
The largest adaptive arena is 508 nodes/1982 edges; the largest current
root has 263 edges (100 nodes), and the largest historical-root graph has
1157 edges (319 nodes). Bucket histories additionally retain 182 literal
entries across runs, versus seven in static degree; saved DAG roots alone
would conceal that change. All primary cases are far below declared caps.

## What the adaptive continuation did and did not repair

Out of 144 steps, the selector chooses 39 feasible buckets, falls back 16 times
because no candidate is feasible, and falls back 89 times because the whole
root is nonclausal. There are no primary selector-entry-cap aborts. All 39
predicted choices actually succeed. Compared with static degree, bucket
successes rise 34 to 39 and cofactor fallbacks fall 110 to 105; there are still
16 pair-cap and 89 nonclausal aborts in the actual bucket calls. This is a
small eligibility gain, not control of the subsequent shared residual.

Selection inspects 31,671 candidate literal entries, 10,354 candidate rows,
7212 remainder entries and 192 feasibility pairs, as well as whole-root
reads, score comparisons and fallback-list work. The unchanged bucket then
rechecks the selected projection: its 143 examined pairs and other counters
remain separately charged. Thus speculative feasibility is not counted as
free, and the duplicated work is visible rather than credited twice as a
single operation. Syntactic-only scans consult no solution information.

The experiment does not support adopting this exact adaptive rule as a net
improvement under its declared metric. Minimizing the immediate pair count
does not bound downstream residual size, history, or selection effort, and
successful first projections still usually reach a broad nonclausal factor.
The surviving research obligation is to explain or control that factor's
branch sharing and conditional interface, as identified in the prior
support-locality note, with an amortized bound on cumulative operations.
No such bound is established here. A more economical selector, a different
score, or another representation would be a separate untested algorithm;
none is substituted for this negative net result. The finite exactness proof
and the cap behavior remain valid independently of performance.
