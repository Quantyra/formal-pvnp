# Signed messages: proof and claims review

S3040 / S008 / E004. Reviewed the final saved
[attempt](2026-09-08-signed-messages-attempt.md), including its constant-safe
bounds, explicit bit accounting, private namespaces, and pointwise head-choice
clarification. This reviewer covers the two lenses below; they are not two
independent reviewers. Source/complexity review is supplied separately.
This is an informal mathematical increment, with no formal modules, build,
implementation or experiment involved.

## Proof-adversarial lens — GO

The boundary-aware Horn compiler is exact. True boundary values seed closure;
false boundary values remain constraints through the final rejection guard.
Every full model contains all derived true variables by induction. A positive
cycle without a seed cannot create an unsupported fact, while a seeded cycle
is handled by the same iteration. Each nonstationary round adds a variable,
so N rounds suffice, including facts and chains of length N. On acceptance,
the resulting fixed point agrees with every boundary bit, satisfies all
positive rules and avoids every false-head antecedent. Its private coordinates
give a witness. On rejection, a forced false boundary bit or a forced false-head
antecedent rules out every extension. Empty conjunctions, empty formulas and
N=0 are explicitly handled.

The projected example is correctly
`z OR NOT(AND_i(x_i OR y_i))`. Its specialized circuit has linear size; the
text now distinguishes this from the quadratic generic unrolling. The
auxiliary-free CNF lower bound is valid even for clauses with arbitrary signs:
two distinct designated false assignments have a satisfying coordinatewise
meet, whereas a clause false at both is false at their meet. Thus no clause
can exclude two designated assignments, giving 2^k clauses. Distribution
supplies the matching family. This does not constrain general circuits.

Conjunction and projection are effective through the retained Horn source,
not through a purported free existential operation on output circuits. Private
variables must be fresh against both the other private namespace and its
public names. The x-iff-y example correctly demonstrates the otherwise
unsound identification. On the stipulated original clause tree, a child-private
variable occurs neither in its sibling nor outside; all shared variables
remain identified boundary variables until their join. Consequently the
original source identities and a root least-model witness are consistent.

The cumulative bounds use the correct domain. There are O(m) modules with
at most N variables and ell literal occurrences each, giving the stated
constant-safe summed cubic bound in binary input length L. Sequential lookup
over the emitted polynomially many labeled records permits the conservative
O((L+1)^6 log^2(L+2)) bit bound for construction and one evaluation per module.
Boundary/provenance scans and reference comparisons fit this loose bound;
larger supplied tree encodings and additional queries are charged explicitly.
This is not a bound in the length of an arbitrary join/project DAG: differently
scoped copies may enlarge its actual provenance, as the note correctly states.

For arbitrary CNF, every selected-head Horn branch implies its original
clauses. Conversely a satisfying assignment supplies a true head for each
active antecedent and an arbitrary head for each inactive antecedent. Hence
the OR identity, and its existential projection, are exact pointwise. The
successful choice vector may depend on the boundary and extension; the final
text does not require a single vector for all boundaries. Enumerating all K
vectors gives a genuine finite YES/NO procedure with checked witnesses,
polynomial streaming workspace and explicitly K times polynomial bit work.
Neither a polynomial bound on K nor a justified polynomial branch selection
is established.

Finally, meet closure of Horn models and its preservation under existential
projection are proved correctly. The two satisfying assignments of x OR y
refute a Horn extension on that same boundary. The dual-rail false-head checks
indeed accept all-zero rails for every nonempty-clause input, including the
given unsatisfiable four-clause example. Totality/exact-one is the missing
non-meet-closed condition; existential Horn auxiliaries on those rails cannot
silently impose it.

All requested clarifications are present in the final file: specialized versus
generic circuit size, boundary-dependent choices, N=0 constants, and total
bit construction rather than only gate counts. No substantive correction
remains. Verification was a direct symbolic audit; no numerical evidence or
new test suite is being represented as proof.

## Non-claims lens — GO WITH NOTES

The result is a bounded, classical Horn-domain construction and an explicit
general continuation whose branch cost remains uncontrolled polynomially.
The note attributes classical Horn closure and does not present Horn SAT as
a new general tractability result. Its contribution in this sequence is the
explicit boundary evaluator, scoped composition contract, witnesses and
accounting relative to the prior interface obligation.

The exponential CNF example applies only to auxiliary-free CNF representation.
The meet-closure obstruction applies to exact existential Horn representation
on the specified original boundary or rails. Neither is an arbitrary-circuit,
general reduction or SAT running-time lower bound. Likewise K is a cost of
the stated enumeration, not a proof that every algorithm or instance needs
all branches. The compact individual evaluators do not establish inexpensive
arbitrary composition, deduplication or adaptive querying.

No polynomial-time general SAT algorithm, P-versus-NP conclusion, Lean theorem,
whole-flow result, Navier–Stokes computational device or physical transfer
follows. The general bridge remains incomplete. GO here approves this bounded
informal increment only; it is not formal route-final or full-goal closure.
