# Overlap repair complexity and implementation review

Reviewed the final [attempt](2026-09-08-overlap-repair-attempt.md),
[driver](probe_overlap_repair.py), reused [DAG engine](probe_factored_cofactors.py),
and [output](2026-09-08-overlap-repair-output.json), S3040/S008/E004.
Disposition: PASS for the bounded implementation, exactness argument and
reported measurements. General polynomial-time SAT remains INCOMPLETE.

## Actual repair and exact fallback

The XOR relation clauses have the correct signs. Restricting their private
x variable produces the two complementary binary relations displayed in
the note. Their OR is true but the existing syntactic common-factor and
literal-complement rules do not identify that functional complement. The
measured residual after all x variables is linear in the number of chain or
cycle edges, not exponentially large. Removing that residual is the actual
increment; no stronger overlap obstruction is demonstrated.

The bucket step is the classical existential resolution identity already
proved in the support-elimination note and attributed to Davis--Putnam,
Section 4, Rule III. That primary source was independently checked in the
prior support-elimination review; no additional external theorem is imported
here. For this XOR bucket, all four raw cross-polarity resolvents contain a
complementary literal pair and may be discarded. Shared y variables elsewhere
do not affect the identity because the selected x is absent there.

Recognition accepts only an already syntactically clausal root. It never
expands an arbitrary AND/OR DAG into CNF. The code first checks the raw
positive-count times negative-count against the pair cap, then examines
permitted candidates, charging also those later found tautological. No DAG
constructor runs until all required resolvents have been processed. A cap
or shape abort therefore leaves the old root unchanged; exact cofactoring
runs on that root, not on an incomplete set of resolvents. A cap is not an
UNSAT answer. Retrying the bucket at later stages preserves this invariant.

The mixed witness history is correct. Bucket records store both polarity
remainders; choosing x=1 precisely when a positive remainder is false is
justified by all retained resolvents. Cofactor records use the previously
reviewed branch rule. Under the stated complete, duplicate-free variable
order, reverse lifting has all needed suffix variables assigned. Final
original-CNF verification is separate from that reasoning. Empty clauses,
empty and one-sided buckets are consistent with these arguments.

## Accounting and corrected complexity scope

The work cap is a structural-entry budget, not a hard wall-clock or Python
instruction bound. Tick counts include failed attempts; abandoned ticks are
an overlapping diagnostic subset, not a second disjoint amount to add.
Requested pairs and examined pairs are distinct, and the raw pair guard
prevents duplicate or tautological outputs from evading the pair cap.
Temporary lists from failed attempts are discarded, while their recorded
processing remains visible before fallback.

Final wording resolves the original overclaim about polynomial overhead in
original input length. Recognition and candidate processing have polynomial
structural entry/comparison counts in the caps. Postcommit normalization,
node-ID bit lengths, arena lookups and host hashing require separate costs;
previous fallback may already have enlarged the arena. A structural cap
alone does not supply a platform-independent bit bound. The reused engine's
postcommit constructor/allocation counters are correctly kept outside the
bucket tick budget.

Cumulative node and child-reference allocation includes intermediate arena
nodes, even when only a final constant remains reachable. Bucket witness
literal lists and cofactor-root histories are different retained resources;
the history DAG statistic omits the former by design, and the note reports
their storage separately. Final witness bucket evaluation materializes all
literal values before calling any(), so its literal counter now counts
actual literal evaluations, rather than charging an entire short-circuited
row. Other dictionary, sorting, allocation and final verification overhead
is explicitly outside the complete-bit-runtime claim, which is not made.

## Independent verification and surviving obligation

I ran the final fixed suite once independently. It passed 28 configuration
runs and 1540 existential-prefix comparisons. The entire JSON output was
byte-identical to the tracked result, SHA-256
`19DC652AFF52675741F634659047CD632D9073639E08CED97AD050F9423F7152`.
The tests include pinned UNSAT chain/cycle cases and restrictive pair/work
caps, as well as empty and conflicting inputs. The larger 16 measurements
check returned witnesses but do not exhaust their truth tables.

For the m=8 cycle, the reproduced old x-prefix has 73 nodes and 120 edges;
the hybrid prefix is true. Cumulative allocated node/edge totals are 152/720
versus 74/240. The hybrid still records 1288 ticks, 32 examined tautological
pairs, 64 stored bucket-literal entries and 64 witness-literal evaluations.
The simplification does not make these costs disappear.

This is a tested local repair and an exact capped-resolution/cofactor hybrid,
not a general bound on its residuals or runtime. The selected family is easy;
its successful repair gives no all-CNF polynomial inference. Cap failure
likewise gives no lower bound against other algorithms or representations.
A uniform bound on fallback growth, cumulative traversals, normalization and
history storage remains open. All requested implementation/scope corrections
are resolved in the reviewed version; no further change is required for this
bounded increment.
