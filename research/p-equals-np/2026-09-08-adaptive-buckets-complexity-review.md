# Adaptive bucket complexity and implementation review

Reviewed the final [attempt](2026-09-08-adaptive-buckets-attempt.md),
[driver](probe_adaptive_buckets.py), and [output](2026-09-08-adaptive-buckets-output.json),
S3040/S008/E004. Disposition: PASS for the bounded exact candidate and its
reported negative net comparison. This exact adaptive rule is not supported
as an improvement under the declared metric. General complexity guarantees
remain INCOMPLETE.

## Actual algorithm and exactness

The selector scans only a wholly syntactically clausal root, without support
or dependency-local rewriting. It scores all remaining variables by raw
positive/negative pair product, admits only candidates passing the existing
full-root precommit tests, and minimizes (pair count, variable ID). If shape,
selector-entry or feasibility checks fail, it uses the next uneliminated
variable in the original static-degree order. Tentative scoring constructs
no DAG projection and consults no solution information. Remaining variables
absent from the root are allowed; their elimination is semantically harmless.

The original complete bucket operation still executes after selection, with
original exact cofactor fallback. The code asserts actual bucket success for
every selected feasible candidate. The dense-order input check and explicit
remaining-list filtering ensure each chosen variable is removed exactly once.
Prefix verification uses the actual dynamic eliminated/remaining lists, not
the baseline order. The usual existential update and reverse mixed-history
argument therefore apply to these changed trajectories. Oracle results are
computed externally and do not feed selection or solving.

The recognition charge and pair-entry formula agree with the reused bucket
for normalized whole-root literal clauses, including the true/false constant
handling. Scoring is not credited as elimination: the actual operation and
its constructors are charged again. This duplication is necessary to assess
the implemented candidate rather than an imagined cheaper implementation.

## Costs and cap boundaries

The final note resolves the local-cap wording: 16nL0 bounds recognition and
scoring inside select(); static-order fallback scans and remaining-list
filtering lie outside that local cap but charge the global budget. All selector
counter increments use the shared charged counter mechanism. Global totals
are asserted equal to common DAG/hybrid units plus added selector units.

The numeric experiment caps are unchanged but the charged metric is expanded.
Thus comparison must retain the common-base and added-selector columns; equal
cap values do not make the accounting categories identical. The categories
are structural charges with overlaps, not an exact time, bit-operation or
peak-memory measure. Candidate list/set construction, handle sizes, hashing,
initial order setup, reporting and independent verification have additional
costs. No polynomial bit bound follows from a cap on these categories.

A local selector cap discards the incomplete scoring attempt and falls back;
it does not return NO. A global allocation/charged cap or recursion exception
stops with INCOMPLETE, null algorithm answer and no witness. The actual
variable diagnostic is cleared on entering selection, so an interruption
there is not attributed to the previous elimination. Completed snapshots
and terminal partial counters are kept separate.

The tiny boundary tests restore global caps in finally. They exercise local
selector fallback and each global allocation/charged interruption at tiny
limits; the global forced tests interrupt initialization rather than establish
coverage of every possible later stopping location. All primary runs finish
without a cap. No unexpected assertion is swallowed as a cap result.

## Independent execution and comparison

I independently ran the same fixed suite once: sixteen saved-formula adaptive
continuations plus the declared tiny boundary checks, without new seeds,
orders, scores or enlarged limits. It passed all 2552 small-prefix comparisons
and returned the same twelve SAT and four UNSAT decisions. The complete output
was byte-identical, SHA-256
`AABE062CC553A6F7508C36933C1637DB4498650258F1F34B9B993652797CF926`.

I independently recomputed the main comparison from the saved baseline and
new output: common-base adaptive units total 318378 versus static degree's
320586. Added selector units are 62632, giving adaptive total 381010. Every
individual adaptive total exceeds its static-degree counterpart under this
metric. Reporting only the 2208 common-base saving, or using only the weaker
ascending-order comparator, would misstate the result. The final note avoids
both errors and makes no wall-clock claim.

Accepted buckets increase from 34 to 39 and cofactor fallbacks decrease from
110 to 105 over the 144 adaptive steps. That modest eligibility improvement
does not compensate for the measured selector cost. Allocation and history
resources are mixed rather than uniformly better; sums across separate runs
are not simultaneous resident memory, and bucket literal histories must be
counted alongside saved DAG roots and cumulative arenas.

This is one actual continuation rule on sixteen small formulas, not a theorem
against adaptive ordering in general. Immediate pair minimization supplies
no invariant for future shared residual size, witness history or cumulative
selection work. A different score, cheaper selector or representation would
need its own implementation and evidence. No new external theorem is used;
correctness rests on the previously reviewed exact elimination identities.
All requested accounting and scope corrections are resolved. No further
change is required for this bounded increment.
