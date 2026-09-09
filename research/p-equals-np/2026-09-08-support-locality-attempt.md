# Read-only support locality of the recorded fallback states

S3040 / S008 / E004 informal attempt, under `INTEGRITY-CLAIMS.md`.
Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-support-locality-2026-09-08.md`.
No general SAT runtime result or new solver implementation is claimed.

This is the discriminating measurement proposed by the
[fallback stress note](2026-09-08-fallback-stress-attempt.md). The
[observer driver](probe_support_locality.py) replays exactly the saved 32
formula/order runs using their recorded clauses, orders and caps. It wraps
the imported bucket call with read-only observation, restoring the original
function in a `finally` clause. The engine, constructors, bucket rule and
stress driver are unchanged. Each replay's complete result, every stage,
every diagnostic counter, and witness must equal the baseline JSON after
normalizing JSON object keys. Merely matching the final decision is not enough.

## Diagnostic and candidate checks

For each immutable DAG node cache its **syntactic** support: empty at constants,
the absolute variable ID at a literal, and the union of child supports at
AND/OR nodes. This is not a semantic-dependence oracle; a tautology can have
nonempty syntactic support. Independently verify every cached entry by a
separate uncached traversal collecting literal IDs. Diagnostic cache storage,
support union inputs, node/edge traversals, shape reads and independent
verification costs are counted separately from solver counters and caps.
Python sets, sorting, ID sizes and other host overhead still count; these
diagnostic counters do not purport to be a complete bit-time account.
In particular, supports are copied into sorted output lists, and candidate
membership counters count calls into those lists, not every inspected entry.
Serialization, list materialization and sorting are additional overhead.

Top-level factors are an AND root's children, or the whole root otherwise.
A factor is clausal if constant, literal, or an OR of literals. For current x,
record all independent/dependent clausal and nonclausal factors, their shapes
and supports. An independent offending factor alone does not recover local
eligibility: **every dependent factor must be clausal**. Constants contain no
variables and are retained in the independent remainder, including false.

Also compute

    E = support(root) minus UNION_(nonclausal top-level factors F) support(F).

These are exactly the active variables for which the dependent factors are
all clausal. An empty E excludes shape recovery by choosing another active
variable at this unchanged state. It excludes neither a different historical
order nor an equivalent representation. Absent variables are deliberately
excluded from this alternate-variable comparison.

For current x when shape eligible, and for each variable in E, recompute the
dependent clauses' positive/negative counts and their raw product. Separately
simulate the recognition/candidate-entry charges against the saved local
budget and the raw-pair cap16. No projected DAG is constructed. Passing this
check means only that the proposed local subproblem passes these precommit
checks; it is not an observed acceptance by the original solver, nor a bound
on subsequent normalization, reattachment, memory or total bit work.

A positive hand case uses the independent nonclausal factor
`(a AND b) OR (NOT a AND c)` together with `(x OR d)` and `(NOT x OR e)`.
The original global shape check fails, whereas the diagnostic must find no
dependent nonclausal factor for x and exactly one permitted resolvent pair.
This validates the diagnostic's positive path even if the recorded corpus
has no such recoverable state. The hand case does not replace or enlarge the
32-run solver campaign.

## Reproduction

```text
python research/p-equals-np/probe_support_locality.py --output research/p-equals-np/2026-09-08-support-locality-output.json
```

The unchanged baseline is `2026-09-08-fallback-stress-output.json`, read beside
the driver. The [output](2026-09-08-support-locality-output.json) records one
read-only replay, with all 32 complete baseline result objects identical.
This includes the same 5104 independent prefix comparisons, decisions,
witnesses, stage snapshots and original charged counters. The separate
positive hand case also passes.

## Measured locality, rather than an assumed repair

There are 288 observed bucket calls and the same 195 shape aborts. Every
shape-abort root has exactly one nonclausal top-level factor, an OR node.
For the current variable:

| Property on the 195 shape-abort states | Count |
|---|---|
| A dependent nonclausal factor remains | 194 |
| Independent offending factor and no dependent nonclausal factor | 1 |
| Current variable passes local shape, pair and entry checks | 1 |
| No active variable is shape eligible at that same state | 188 |
| At least one active variable is shape eligible | 7 |
| At least one active variable also passes pair/entry checks | 4 |

The sole current-variable opportunity is n=12, seed=17, static degree,
stage10, x=11. The nonclausal factor has support {10,12}; the root's active
support is {10,11,12}. The dependent clausal bucket has one positive and one
negative clause, one raw pair and precommit entry cost12. This is genuine
active-variable locality, not skipping a variable absent from the root.
No local projection or changed continuation was executed.

The other three states with an alternative passing all precommit checks are
n=12, seed=29, static degree, stage2 (variable12, three pairs);
n=12, seed=43, ascending, stage2 (variable8, sixteen pairs); and
n=12, seed=71, static degree, stage2 (variable6, five pairs). Across all seven
shape-eligible states there are ten eligible active-variable choices, but
six fail the pair cap. The mere presence of an eligible variable therefore
overstates the opportunity. More fundamentally, the nonclausal factor covers
the whole active support in 188 states. Its support size ranges from2 to11;
support-size frequencies are saved in the per-factor records, not equated
with exact semantic dependence. Across rejected states 1051 independent
clausal factors are present, but removing them cannot remove a dependent
nonclausal factor.

Initial states provide a separate ordering observation. All active variables
are shape eligible before the first projection; ten of the sixteen formulas
have at least one variable passing the pair/entry check. The table lists the
passing variables and their raw pair counts, counted once per formula rather
than twice for the two replayed orders.

| n, seed | Initial precommit-eligible variables (raw pairs) |
|---|---|
| 6,17 | 2 (16) |
| 8,29 | 2 (14), 4 (14) |
| 8,43 | 1 (15) |
| 8,71 | 4 (4) |
| 10,29 | 10 (15) |
| 10,43 | 2 (16) |
| 10,71 | 9 (15) |
| 12,29 | 3 (12), 12 (3) |
| 12,43 | 8 (16), 9 (12) |
| 12,71 | 6 (5) |

The other six initial formulas have no passing variable at the unchanged
cap. Of the actual 32 first choices, 31 fail the pair cap; n=8, seed=43,
ascending accepts variable1 and only fails the pair cap at step2. This
corrects the prior note's overly broad initial-step qualifier without
changing its aggregate total32 pair aborts or any recorded solver result.

## Diagnostic cost and next obligation

Across the replay, 5598 cached node supports receive independent literal-leaf
checks. The observer computes 40,387 support-union input entries over 18,181
support-edge traversals and retains 21,026 support entries cumulatively
across separate per-run caches. The largest one-run cache has 1647 variable
entries. There are 3430 top-factor visits, 15,759 candidate-factor membership
calls, 13,230 candidate-clause entries and 380 locally examined candidate
pairs. Independent support verification adds 71,278 node and 113,811 edge
visits. These costs are external to, and do not change, the baseline budgets.

The data support only a narrow one-state current-order opportunity, not the
hoped-for broad repair of 195 failures. Dependency-local replacement is
therefore not implemented in this increment. Selecting a pair-feasible
variable initially is a separate plausible candidate on ten formulas, but
its later trajectories, fill, witness storage and total work are unmeasured.
Choosing a variable differently would require a new expressly bounded test;
the counterfactual precommit checks cannot stand in for that test.

The substantive representation question is now how one broad-support OR
factor comes to cover nearly every active variable. A precise next measure
would count, within that offending OR, the support intersection and symmetric
difference of its branches, along with shared reachable nodes/edges. This
would distinguish actual branch sharing from mere broad occurrence support,
and test whether a compact conditional interface survives without assuming
semantic cancellation. It requires its own cost accounting and cannot yield
a polynomial invariant merely because sets are small here. No lower bound
for arbitrary representations, other historical orders or SAT follows.
