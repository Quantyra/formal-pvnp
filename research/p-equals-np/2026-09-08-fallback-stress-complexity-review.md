# Fallback stress complexity and implementation review

Reviewed the final [attempt](2026-09-08-fallback-stress-attempt.md),
[driver](probe_fallback_stress.py), and
[fixed output](2026-09-08-fallback-stress-output.json), S3040/S008/E004.
Disposition: PASS for the bounded experiment and its measured conclusions.
A general polynomial-time algorithm, asymptotic growth law, and physical
computational transfer remain unestablished.

## Generation, order and semantic separation

The generator uses the stated fixed seed for each size, samples three distinct
variables, gives each an unrestricted sign and rejects only exact duplicate
clauses. It does not plant a witness, filter on satisfiability, or change the
seeds after obtaining a result. The density floor(17n/4) is a configuration,
not a claim that these cases are hard or representative of a threshold.
The stored clauses, draw counts and checksums make the actual finite inputs
reviewable without relying solely on future RNG implementation behavior.

The second order sorts initial occurrence counts once, with variable-ID tie
breaking. Computing counts by a literal scan and sorting n keys is polynomial
in input length under ordinary explicit encodings. It is not an adaptive SAT
oracle or a search for the best elimination order. The direct truth-table
oracle is computed separately and is not supplied to solve(). Its exponential
verification cost is not attributed to the candidate solver or hidden in its
reported charged metric.

The existing exact constructors, atomic local bucket attempt, cofactor update
and mixed witness lifting are reused. The new interning override preserves
syntactic node identity while checking allocation limits before insertion.
The script verifies all completed decisions against original-CNF truth tables
and separately checks returned witnesses; small-input prefix checks compare
against existential projection of the original clauses.

## Experiment caps and accounting

Global ResourceCap is distinct from the bucket's local Abort. A local pair,
shape or entry failure invokes exact fallback; a global limit stops the run.
The algorithm answer is assigned only after elimination and witness handling
finish. A caught global cap or Python recursion exhaustion therefore returns
INCOMPLETE, null algorithm_sat and no witness. Independent oracle truth is
kept in a separate field and cannot turn that interruption into NO or YES.
Unexpected assertions and other implementation errors are not silently
reclassified as resource limits.

Both new-node count and total n-ary edge count are checked incrementally,
including initialization. The charged-unit limit intercepts positive counter
increments. It deliberately aggregates overlapping categories: requested and
examined pairs, for example, are not disjoint work, and abandoned ticks are
already included in ordinary bucket ticks. The final note correctly calls
this an artificial diagnostic budget. It is neither a hard time/peak-memory
cap nor a complete machine-operation count. Materialized temporary objects,
integer/handle lengths, host dictionaries and reporting/verification still
have their own costs.

Completed-stage snapshots preserve current reachable graphs, historical root
unions and cumulative arenas separately. Saved bucket literals are reported
through the hybrid counters, not implicitly included in historical DAG roots.
Terminal diagnostics retain partial allocations/counter increments if a later
stage or witness traversal stops before a completed snapshot. Thus final
simplification does not erase intermediate work. Counter increments may be
charges before the corresponding action finishes; partial diagnostics do not
constitute another completed semantic stage.

No global cap was reached in the fixed suite. Accordingly cap-exit behavior
is code-reviewed, not empirically exercised by these 32 primary runs. This
limitation is now explicit; no extra cap configuration was needed or run for
this review.

## Independent verification and interpretation

I replayed four existing runs only: n=8, seed=29 and n=12, seed=17, each in
both orders, with unchanged caps and parameters. Regenerated clauses and
draw counts agreed. Every replayed result field matched its recorded JSON
value after ordinary JSON key normalization. The n=8 replays independently
performed 1022 prefix comparisons; the n=12 replays checked completed exact
runs and returned witnesses without exhaustive prefix checks.

I also independently recomputed the saved aggregate counters: 32 complete
runs, 24 SAT outcomes, 5104 small-prefix checks, 61 accepted buckets and 227
fallbacks. The latter split into 32 pair-cap and 195 nonclausal-shape aborts,
with no local work-cap abort. There are 1798 requested pairs but only 20
examined pairs, eight tautological. Total bucket ticks are 22647, of which
21938 are abandoned-attempt ticks. These agree with the final narrative.

Static degree improves the chosen aggregate charged metric on this sample,
but n=12, seed=17 allocates 508 nodes/1982 edges versus ascending's 446/1794.
The result already rules out describing the observations as uniform resource
dominance even within the suite. It supplies no worst-case order theorem.
The small completed arenas and successful capped runs do not imply a
polynomial scaling law, and the high fallback frequency does not establish
an asymptotic computational bottleneck.

The proposed dependency-local selection is a future, unimplemented change in
this driver. The identity exists x(R AND B)=R AND exists x B is valid when x
is absent from R; shared other variables must keep consistent values. The
current output does not report whether nonclausal offending factors are
independent of x, so it cannot establish that this proposed change would
recover bucket eligibility. Exact support computation, support unions,
factor scans, reattachment and cumulative witness storage must be included
in any subsequent cost argument. A uniform bound remains missing.

No new external complexity theorem is invoked: this experiment reuses the
previously reviewed exact elimination rules and is interpreted directly.
All requested scope and accounting distinctions are resolved in the final
artifact. No further change is required for this bounded increment.
