# Guided sampling: proof and nonclaims review

2026-09-08. S3040 / S008 / E004. Harness-only independent review of
`2026-09-08-guided-sampling-attempt.md`. The same reviewer covers the two
separate lenses below; they are not two independent reviews. Source and
complexity review is assigned separately. No formal build, numerical
experiment, implementation change, commit or push is involved.

## Proof-adversarial lens — GO

The stable draft passes without corrections.

The dyadic target P is strictly positive on the Boolean cube and sums
to one. Requiring Q>0 on every satisfying assignment is exactly the
support condition needed for cancellation in E_Q W=Z. Values at Q-zero
points outside that support are never sampled and do not affect the
identity. For Z>0 the normalized second moment is exactly sum pi^2/Q;
subtracting one gives relative variance. Independence of the K draws
gives the relative mean-square error (R-1)/K. Markov on squared error
then gives the stated sufficient failure-probability bound. Relative
error is not defined at Z=0, and a finite string of zero observations
does not certify absence of a satisfying assignment.

For disjoint blocks, P and the indicator both factor, so the enumerated
A_j and Z_j compute the exact global normalizer. Positive local factors
give Q=pi with full target support, and zero local factors prove UNSAT.
The weight is identically Z under this Q. A_j<=4^b_j and the common
dyadic denominator show O(b_j) local and O(n) final integer bit lengths.
Enumerating block assignments and checking their clauses costs the
claimed O(L2^b) literal work plus polynomial arithmetic. Choosing stored
positive assignments is deterministic; optional rejection from fair
bits has success greater than one-half per trial and expected, not
fixed worst-case, sampling cost. Logarithmic b therefore gives the
claimed restricted deterministic normalizer/decision/witness result.

For arbitrary CNF with only internal block clauses retained, every
satisfying assignment obeys A. Thus the proposal has the required
support, and cancellation gives W=Z_A indicator[F], p=Z/Z_A and R=1/p
when Z>0. This is an actual computable rejection proposal with a possibly
small acceptance probability, not an assumed optimal law.

On the alternating path with even block size, each internal phase has
b/2 ones and equal dyadic weight. Independent blocks therefore choose
uniform independent phases. Since an even-length alternating block ends
opposite its initial bit, the crossing inequality forces the next block
to start in the same phase. Exactly two of2^r phase combinations survive,
giving p=2^(1-r) and the stated normalizers. The no-hit probability for
independent draws is exactly(1-p)^K and at least1-Kp. That probability
argument is independent of the second-moment discussion. It concerns
this rejection rule on a path with an easy witness.

The tree repair keeps every cross factor under the explicit assumption
that each crosses exactly two blocks and the interaction graph is a
tree or forest. For a fixed parent assignment, different child subtrees
have disjoint variables; summing their weighted valid assignments
therefore factors. Induction gives equation (4) and the root partition
sum (5). The messages are unnormalized subtree weights indexed by the
parent value, not a claim that the parent itself was probabilistically
conditioned on constraints before normalization.

If the root sum is positive, a positive root summand has positive child
messages. Each such message has a positive summand, which provides a
compatible child assignment and positive messages below it. Induction
constructs a satisfying full assignment without dividing by zero.
Normalizing these same summands instead gives the exact conditional
sampling law; multiplying the conditional factors recovers pi. The
normalizer is computed first, so zero variance is not obtained by
assuming an unavailable oracle. Forest components factor in the same way.

Each edge message examines at most2^(2b) pairs of assignments. Incoming
message products can be precomputed for each local assignment, with
total O(r2^b) products over all child incidences, giving the stated
O(r2^(2b)) interactions. Clause-table construction is separately charged
O(L2^(2b)). A subtree containing n_j bits has a common denominator4^n_j;
its message is a partial probability at most one. Products combine
disjoint child subtrees and local variables. Exact arithmetic can retain
these common dyadic denominators, so all numerators and denominators
need O(n) bits, including partial sums. Arithmetic and witness selection
remain deterministic polynomial work at logarithmic block size. Optional
rational conditional sampling retains only an expected random-bit bound.
The path indeed satisfies the tree assumptions and this recurrence
removes its previously demonstrated rejection loss.

For a complementary bit pair, both satisfying assignments have P-mass
3/16, so its conditional target is uniform over01 and10. With full-support
independent Bernoulli proposal parameters a,b in(0,1), put s=(1-a)b
and t=a(1-b). Then (1/4)(1/s+1/t)>=1/(2 sqrt(st))>=2, because
st=a(1-a)b(1-b)<=1/16. The product proposal and product conditional
target factor the second-moment sum, giving R>=2^m. Thus the ordinary
iid sample mean requires K>=(2^m-1)/epsilon^2 for the stated relative
mean-square error requirement. This does not infer a fixed-confidence
lower bound solely from variance. For fair bits, the separate event
calculation has per-draw success2^(-m), giving its correctly scoped
no-hit bound. Correlated two-bit blocks avoid the obstruction exactly.

## Nonclaims lens — GO-WITH-NOTES

The constructive result is exact deterministic inference on disjoint
bounded blocks and trees of bounded blocks, with optional zero-variance
sampling after computing the normalizer. The tree recurrence is expressly
identified as standard sum-product, not a new general inference theorem.
The review above checks its specialized derivation and bit accounting;
external attribution is audited by the separate source reviewer.

The general block relaxation is fully specified mathematically, including
support, sample weights and its unresolved ratio Z_A/Z. It is not reported
as executed code or as a uniformly efficient arbitrary-CNF estimator.
Its path failure is repaired constructively and is not advertised as
path-inference hardness.

The independent-bit result restricts that proposal class and the ordinary
sample mean's relative mean-square error. It is neither a general
fixed-confidence probability lower bound nor a restriction on correlated
proposals. The separate direct no-hit arguments retain their specific
raw-sampling assumptions. The draft does not turn randomized relative
estimation into deterministic always-correct inference.

Cycles or higher-arity cross factors invalidate the stated tree
factorization. Merging may recover it only with a separately controlled
block size and construction cost. Neither a uniform merging rule nor a
general acceptance/variance guarantee is supplied. General UNSAT
termination also remains an explicit obligation.

No blanket representation impossibility, general SAT solver, P=NP result
or physical/Navier--Stokes transfer follows. The bounded informal results
pass; arbitrary-CNF inference and the full research objective remain
unresolved. This review is not formal route-final or full-goal closure.
