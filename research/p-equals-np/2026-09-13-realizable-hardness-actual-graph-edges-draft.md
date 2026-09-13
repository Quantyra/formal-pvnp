# Actual fixed-graph edge representatives

2026-09-13. S3132/S3137 under S3126. Source-only draft, not compiled or accepted.

## Route and actual construction

This is the next specific source-regularization obligation in the preserved
September 12 Gap3Lin source-construction extraction and critical-source audit.
It uses the accepted fixed port-cycle family, not a graph supplied as a
hypothesis. No new research mechanism or novelty is claimed.

`Vertex n` is the actual pair Fin n times Fin D, with D the family's fixed
positive degree. `Dart n` adds the actual degree-three dart label. `reverse`
is precisely the family's port-cycle rotation. Numeric vertex rank uses
`finProdFinEquiv`, hence gives an injective total order on the port vertices.
An edge representative is a dart whose source rank is strictly less than its
destination rank. Loops are omitted. The numeric order never identifies
distinct dart labels or collapses parallel reversal orbits.

The explicit ordered `dartList` enumerates vertex, port, and dart-label in the
same nested order as `FixedPortCycleFamily.table`; the source states the exact
equality with that table's source-dart list. `representativeList` filters it by
the actual rank comparison. Its nodup, membership, toFinset and length results
connect the ordered list to the finite representative set used for counting.

Reversal is involutive. Every nonloop orbit has exactly one selected dart, and
two selected darts in the same reversal orbit must be equal as darts. The
second dart of each selected orbit gives a disjoint reverse image, yielding
2 E <= 3 n D without any loop-free or simple-graph assumption.

## Actual cut bridge

For a Boolean vertex set S, select representative darts whose endpoints have
different S values. `orient` sends each to its true-to-false dart. The source
gives the inverse using the canonical rank orientation and proves a finite
bijection with the actual outgoing darts. Those outgoing darts are explicitly
identified with the fixed graph's `dartsBetween` set, so their cardinality
equals the already accepted graph cut. The positive fixed expansion inequality
therefore transfers directly to the crossing representative count.

`edge_terminals_distinct` explicitly exports the distinctness needed by the
seven-variable equality gadget's injective embedding. A loop cannot cross S,
and a loop must not be represented by embedding two distinct gadget terminals
at one global variable. Empty n has no representatives and an empty list.

## Verification and remaining join

No compiler, Git, package change or public action in this task. Checks requests
25 profiles, three printed signatures and eight boundary examples. These are
uncompiled statements/proofs, not verified results or independent review.

The next occurrence-cloud constructor must assign five fresh internal variables
to each retained edge occurrence and prove all local attaining extensions
coexist. A genuine port has three incident darts; joining the original equation
adds one occurrence, giving an intended bound at most four (hence at most ten),
while fresh gadget internal variables have degree two. That cross-copy degree
and pair-intersection proof remains to be implemented; it is not asserted by
this edge-selection module. For the graph's linear blowup C and expansion
kappa, the preserved loss accounting targets the absolute NO gap
min(1,kappa) * (3/8) / (1+18 C), substituting degree three in the extraction's
general denominator 1+6 d C. The complete majority-decoding/count accounting,
actual encoded FP filter/cloud constructor, source Håstad hardness and the
final paper theorem remain open. Numeric list construction here is not an FP
claim and does not complete the source reduction.
