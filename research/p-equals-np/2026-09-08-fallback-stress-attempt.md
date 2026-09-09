# Fixed fallback stress of the capped cofactor hybrid

S3040 / S008 / E004 informal attempt. Read with `INTEGRITY-CLAIMS.md`.
Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-fallback-stress-2026-09-08.md`.
No general polynomial-time SAT or physical-device result is claimed.

## Preregistered bounded configuration

The [driver](probe_fallback_stress.py) reuses the existing `Dag` constructors
and `bucket` resolution routine without modifying either source module.
It overrides interning only to check resource limits and collect metrics.
The preceding [overlap repair](2026-09-08-overlap-repair-attempt.md) established
exact prefix semantics and reverse witness rules; this increment tests their
actual fallback behavior beyond specifically constructed simplification families.

There are exactly 16 generated formulas and 32 primary solver runs:
n in {6,8,10,12}, seed in {17,29,43,71}, m=floor(17n/4). For each formula,
initialize Python `random.Random((n<<16)+seed)`. Draw three distinct variables
uniformly without replacement, then independently choose each sign using
`getrandbits(1)`. Sort signed literals into a canonical tuple and reject only
an exact duplicate clause, continuing until m distinct clauses are obtained.
There is no planted witness, SAT-based rejection or postselection. The saved
clauses are authoritative reproduction data; output also records draw counts,
the exact RNG seed and SHA-256 of compact clause-list JSON.

Compare ascending variable order with decreasing *initial* literal-occurrence
degree, breaking ties by increasing variable ID. Degrees are computed once
by a clause scan, then sorting n keys; the ordering does not call SAT or
recompute degrees after elimination. Both full orders are saved.

Before execution, fix per-run limits of 100,000 allocated arena nodes,
1,000,000 allocated n-ary edges, and 5,000,000 charged counter units. New-node
and edge limits are checked before insertion, including initialization.
Every positive increment in the DAG or hybrid diagnostic counters charges
the shared counter budget. This metric deliberately counts some overlapping
quantities (for example requests and traversals); it is not elapsed time,
peak bytes or a complete machine-operation/bit budget. Temporary Python
lists/sets, ID lengths, hash costs and reporting/verification are additional.
Python recursion exhaustion is a separately recorded resource interruption.

These *experiment* caps differ from the hybrid's local pair cap 16 and local
scan/candidate budget 32L0. A local failure invokes exact cofactor fallback;
an experiment-cap exception stops that run as INCOMPLETE. Such a result has
`algorithm_sat=null` and no returned witness. Independently computed oracle
truth is stored in a separate field and is never copied into that answer.
Assertions and unexpected implementation errors are not swallowed as caps.

## Verification and counters

Run from the repository root:

```text
python research/p-equals-np/probe_fallback_stress.py --output research/p-equals-np/2026-09-08-fallback-stress-output.json
```

For every formula an independent direct original-CNF truth-table search
computes a decision and optional witness. Completed runs must agree; each
returned assignment is also checked against the original clauses. For n<=8,
every completed prefix is independently compared against existential truth
tables for every remaining assignment, using original-CNF evaluation rather
than any DAG or resolution operation.

Initialization and every completed elimination have snapshots of current
reachable nodes/edges, historical-root reachable nodes/edges, cumulative
arena allocations, charged work, DAG counters and hybrid counters. Literal
bucket-history storage is reported separately from DAG roots. Terminal
diagnostics also retain partial allocations and counter increments when an
interrupted stage has no completed-prefix snapshot. Witness evaluation is
charged; independent oracle and diagnostic traversals are separate overhead.
Counter snapshots are cumulative, so differences quantify individual stages.

## Executed fixed-suite results

The single configured sweep completed all 32 primary runs. All agreed with
independent truth-table decisions: 12 of the 16 formulas were SAT and four
UNSAT, giving 24 verified SAT runs and eight verified NO runs. The n<=8
prefix suite made 5104 comparisons, all passing. No experiment cap or Python
recursion limit was reached; therefore the cap-exception code is a reviewed
safety path, not a behavior empirically exercised by these primary runs.
No shared module changed and no increased-cap or enlarged rerun occurred.
The [output](2026-09-08-fallback-stress-output.json) includes actual clauses
and every stage, rather than just these aggregate values.

Each cell below is cumulative allocated **nodes / edges / charged units**,
including initialization and witness work where applicable. Charged units are
the declared artificial aggregate of overlapping counters, not primitive
operations or a runtime measurement.

| n | seed | Ascending | Static degree |
|---|---|---|---|
| 6 | 17 | 94 / 334 / 9298 | 90 / 297 / 6970 |
| 6 | 29 | 106 / 351 / 9566 | 96 / 318 / 7725 |
| 6 | 43 | 94 / 330 / 9351 | 79 / 262 / 6853 |
| 6 | 71 | 98 / 337 / 8035 | 94 / 309 / 6887 |
| 8 | 17 | 168 / 604 / 17103 | 133 / 508 / 13735 |
| 8 | 29 | 193 / 721 / 19140 | 145 / 544 / 14057 |
| 8 | 43 | 173 / 637 / 14467 | 160 / 606 / 13761 |
| 8 | 71 | 161 / 612 / 15449 | 127 / 490 / 12275 |
| 10 | 17 | 245 / 1093 / 24726 | 229 / 974 / 21477 |
| 10 | 29 | 220 / 897 / 24331 | 217 / 856 / 23050 |
| 10 | 43 | 336 / 1349 / 35116 | 271 / 1065 / 25777 |
| 10 | 71 | 311 / 1170 / 31104 | 253 / 978 / 24864 |
| 12 | 17 | 446 / 1794 / 47959 | 508 / 1982 / 46195 |
| 12 | 29 | 406 / 1623 / 37787 | 251 / 1103 / 25849 |
| 12 | 43 | 345 / 1403 / 39618 | 289 / 1189 / 30138 |
| 12 | 71 | 456 / 1796 / 47475 | 430 / 1691 / 40973 |

Static degree reduces this charged metric on all 16 pairs, but it allocates
more nodes and edges on n=12, seed=17. There is no single observed resource
ordering even on this small set, and no worst-case order advantage follows.

The largest completed-prefix current graph has 102 nodes (270 edges), at
n=12, seed=71, ascending, prefix 6. The largest current edge count is 280
(97 nodes), at n=12, seed=17, ascending, prefix 5. The largest historical-root
edge count is 1211 (322 nodes). These are smaller than cumulative arenas:
unreachable intermediate nodes are still allocated and counted. The greatest
charged total is 47,959; the largest arena is 508 nodes/1982 edges. These
small capped-domain observations establish no polynomial growth law.

## Measured fallback mechanism and next testable obligation

Across 288 elimination steps, 61 bucket attempts succeed and 227 fall back.
There are 32 pair-cap aborts (one initial rejection in each run), 195
nonclausal-shape aborts, and zero local work-cap aborts. Only 20 raw candidate
pairs are actually examined, versus 1798 requested pair candidates including
pre-enumeration rejected products. Eight examined candidates are tautologies.
The attempt scans charge 22,647 ticks; 21,938 are from abandoned attempts.
That abandoned subtotal is part of the counter aggregate as well as the
underlying scan count; it is not additional independent physical work.

Thus the local repair is mostly bypassed on this set. The first projection
typically fails the raw pair cap; thereafter even one nonclausal top-level
factor can reject the entire clausal attempt. For n=12, seed=17 ascending,
the first pair request is 36>16. Prefixes 2 through 10 then fail shape
recognition. The current graph grows from 76 nodes/204 edges initially to
97/280 at prefix 5, then shrinks to 5/5 at prefix 10. Only the final two
steps return to the bucket path. This is measured eligibility loss, not
evidence of a difficult instance or an asymptotic bottleneck theorem.

The next concrete candidate is **dependency-local bucket selection**, not
an increased budget: maintain the top-level conjunction as explicit factors
with exact syntactic variable-support sets. For next x, partition factors
into independent R and dependent B. If every factor of B is a clause and
the existing pair/entry cap permits it, apply the same complete clausal
projection to B and reattach R. Otherwise cofactor only B, retaining R.
The identity exists x(R AND B)=R AND exists x B holds because x is absent
from R; it does not assert independence among the other variables or allow
inconsistent choices for shared variables. Reverse witness roots/remainders
must still preserve the dependent relation at every stage.

Before implementing that candidate, the discriminating measurement is how
often the nonclausal factors causing these 195 rejections are actually
independent of the current x. The current logs do not answer this and do not
claim the proposed change will help. Support computation/union, factor scans,
reattachment and duplicated fallback work all need counting. The intended
uniform invariant would bound the *cumulative* dependent-factor child
references and support-set entries traversed, plus historical witness
storage, by a polynomial in total input length. No such invariant is proved
by this experiment. If the offending factors mostly contain x, this candidate
does not resolve the observed loss of eligibility; another substantive
representation or progress argument would be needed.
