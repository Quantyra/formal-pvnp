# Support locality complexity and observer review

Reviewed the final [attempt](2026-09-08-support-locality-attempt.md),
[observer](probe_support_locality.py), [output](2026-09-08-support-locality-output.json),
and correction to the [preceding stress note](2026-09-08-fallback-stress-attempt.md),
S3040/S008/E004. Disposition: PASS for the bounded read-only measurement.
No solver improvement, general independence oracle or polynomial invariant
is established.

## Observer fidelity and support meaning

The observer reads immutable DAG nodes and keeps its own support cache and
Counter. It neither constructs solver nodes nor increments the solver's
charged counters. The wrapper calls the original bucket with the same root,
variable and caps, and restores the imported function in finally. Equality
is checked for the entire reconstructed baseline result, including every
stage and counter, not merely the final SAT decision.

Support means syntactic literal occurrence. Unioning child supports computes
that set exactly, and the independent uncached literal-leaf traversal checks
every cached node. Absence of x justifies treating a factor as independent
of x. Presence does not prove semantic dependence: a represented tautology
may contain x. The final note correctly preserves this distinction.

For a top-level conjunction, let U be the union of nonclausal factor supports.
An active variable has only clausal dependent factors exactly when it is not
in U. Hence support(root) minus U is the right current-representation test.
An independent nonclausal factor alone is insufficient if any other
nonclausal factor contains the chosen variable. Empty eligible sets exclude
this syntactic selection rule at the unchanged state, not semantic rewriting,
other representations or different earlier elimination choices. Constants
have empty support and remain in the independent remainder; in particular,
this treatment does not discard a false constraint.

The precommit calculation is separate from this shape test. It counts both
polarity buckets, checks their raw product against 16, and adds the original
recognition and resolvent-entry charges. For the normalized dependent literal
clauses being considered, the simulated entry formula agrees with the bucket
routine. Passing it is a counterfactual precommit opportunity, not an executed
projection, a reattached-result certificate or a runtime bound. The positive
hand case tests that an independent offending factor can be detected without
forcing the measured corpus to contain such a case.

## Reproduction and evidence correction

I independently replayed the entire fixed observer suite once, with no changed
clauses, orders or caps. All 32 full baseline result objects remained identical.
The complete observer output was byte-identical to the recorded JSON, SHA-256
`1D754A76469D55BCE15EC394B955A39BC4F283432B0027D5E8FDC837AEFC2DED`.
This includes the existing 5104 prefix checks, independent support traversals
and positive diagnostic case; no new solver trajectory was introduced.

I also independently recomputed the interpretation-relevant aggregates.
Among 195 shape aborts, every root has one nonclausal top-level factor, 194
retain a dependent nonclausal factor for the chosen variable, and one has a
passing current-variable local subproblem. In 188 states the nonclausal
support covers all active variables. Seven states offer at least one active
shape-eligible alternative; only four states offer an alternative passing
both the pair and entry checks. There are ten eligible choices over those
seven states, and 1051 independent clausal factors over the rejected states.
These counts support the narrow conclusion in the final note.

The initial-variable analysis counts each formula once: ten formulas have a
precommit-eligible initial variable. It must not be reported as twenty distinct
formulas merely because each formula has two replayed orders. I verified the
prior stress-note correction directly: n=8, seed=43, ascending first accepts
variable 1 with 3 positive and 5 negative clauses (15 pairs), then rejects
variable 2 with 6 positive and 11 negative clauses (66 pairs). There are 31
initial pair aborts and 32 total pair aborts. The corrected qualifier changes
no recorded solver result or aggregate total.

## Cost and surviving obligation

Observer costs are external to solver budgets and cannot be treated as free
when considering a future implementation. The reproduced totals include 5598
cached support computations, 40387 union input entries, 18181 support-edge
traversals and 21026 stored support entries across per-run caches. Independent
support verification adds 71278 node and 113811 edge visits. The membership
counter counts calls on serialized support lists, not all element comparisons;
sorting, set materialization, handle sizes and host lookup costs remain extra.
These are openly partial diagnostics, not a complete bit-complexity account.

No dependency-local continuation is executed here. The single same-order
opportunity does not establish a useful improvement for the other 194 states.
Likewise an initially pair-feasible variable may lead to larger later
residuals; its future fill, witness history and work have not been measured.
The proposed further branch-support/shared-node measurement would characterize
an existing representation, not automatically supply a compact interface or
semantic cancellation. A proof bounding cumulative support work, residual
references and witness storage on all inputs remains missing.

The argument is self-contained and imports no new external complexity theorem.
All requested quantifier, cost and historical-evidence corrections are resolved
in the reviewed artifacts. No further change is needed for this bounded increment.
