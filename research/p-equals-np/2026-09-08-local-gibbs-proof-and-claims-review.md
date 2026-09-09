# Local Gibbs implementation: proof and nonclaims review

2026-09-08. S3040 / S008 / E004. Baseline `c805419`.
Harness only. One independent reviewer covers the two separately reported
lenses; these are not two separately staffed reviews. No code, simulation,
formal modules/builds, commits, planning edits or publication are involved.

Reviewed stable `2026-09-08-local-gibbs-attempt.md`, including the added
trivial-case handling before defining a random site. The review concerns
the specified heat-bath chain, estimator and exact path inference.

## Proof-adversarial lens: GO after the domain clarification

**Update and transition cost.** The final draft handles n=0 and trivial
formulas separately and restricts site selection to n>=1. For two states
differing at one site, the conditional denominator is their weight sum.
The displayed detailed-balance equality therefore includes the correct
1/n factor. Positivity ensures irreducibility and self-loops; a finite
uniform positive block probability supports convergence at each fixed
input, without implying a useful bound.

Cancelling unchanged clauses reduces each update to a rational determined
by an integer violation-count difference at most M. Its denominator needs
O(nM) bits. Rejection sampling with ceil(log2 D) random bits accepts with
probability greater than one half (or one when D is a power of two), so
the expected transition cost is polynomial. The rejection loop lacks a
deterministic worst-case bound, as disclosed. A conditional on all other
bits is not the prefix marginal requested by the preceding inference contract.

**Equality-path weights.** On each edge, unequal bits violate exactly one
of its two clauses. The first bit and all edge-disagreement indicators
bijectively encode the assignment, giving Z=2(1+q)^(n-1). Complementation
proves stationary single-site marginal one half. The all-zero state has
stationary mass at most one half and is itself a satisfying assignment.

From all zeros, an endpoint flip creates one disagreement and an interior
flip creates two. Averaging over the n chosen sites gives exactly (5).
For n=2 there are two endpoints and zero interior sites, so no extra
interior penalty is introduced. The bounds r<=q and r<=3q/n are valid
using n/4^n<=1. Until first departure, the state is unchanged and the
departure probability remains the same; hence no departure through k
steps has probability (1-r)^k>=1-kr. Possible returns only increase
the endpoint mass at all zeros.

**Mixing and estimator bounds.** Choosing the singleton all-zero event in
the stated total-variation convention gives (7). For integer
k<=n/(24q), the product kr is at most one eighth, yielding TV distance
at least three eighths. The mixing-time-to-one-quarter conclusion and
its strict floor bound follow. It is exponential in n and superpolynomial
in the explicit O(n log n) formula encoding.

The event that a particular endpoint bit is one requires some earlier
departure, so its probability is at most kr. This directly lower-bounds
the single-marginal bias, without relying only on an unrelated TV event.
For raw history averages, no departure forces every recorded bit to zero
and occurs with probability at least seven eighths over the stated horizon.
Thus the draft correctly states a high-probability estimator error, rather
than confusing expected bias with deterministic failure of every estimate.
The argument also applies when the horizon includes a burn-in and sampling
window, but not to arbitrary postprocessing or other initialization laws.

**Exact path inference.** The forward recursion in (9) adds exactly the
two possible previous bits with their equality/disagreement edge weight
and the new unary prefix restriction. The backward recursion includes
only later restrictions, so f_j(a)g_j(a) neither omits nor double-counts
an edge or unary factor. Every consistent prefix has positive partition
because q>0, even when it has no all-equal completion. The original n
continues to determine q.

Scaling by 2^(2n(i-1)) gives the displayed integer recurrence. A sum of
at most 2^i terms bounded by one with this denominator has O(n^2) bits.
Backward messages and the marginal products have the same order of bit
length. O(n) operations per pass and at most n successive query passes
therefore cost polynomial bit work. This is an actual exact special-family
inference rule; it does not assume cheap inference for arbitrary factor
graphs.

No blocking mathematical defect remains after the n=0 domain clarification.

## Nonclaims lens: GO-WITH-NOTES for bounded exploratory use

The lower bound is for this particular random-scan chain from an explicit
worst start. It is not a lower bound for all samplers, every initialization,
analytic inference or SAT. The complement-symmetric-start observation is
correct and prevents overgeneralizing the marginal-bias result.

The formula is easy and its starting state is already a valid SAT witness.
Slow convergence to stationary marginal probabilities therefore does not
establish slow SAT solving. The separate exact path recurrence makes that
distinction concrete. No hard-distribution or general inference-hardness
claim is supplied by the example.

An expected-cost randomized update and probabilistic empirical estimate
do not meet the earlier total deterministic marginal contract by themselves.
The note leaves initialization, convergence, sample accuracy and deterministic
guarantees as separate obligations for a general implementation. It does
not infer a P=NP impossibility from failure of this candidate or promote
the local conditional formula to a free prefix-marginal oracle.

Safe summary: random-scan local sampling has an exponential worst-start
mixing obstruction on equality paths, while exact path inference is
polynomial. Arbitrary-CNF deterministic inference remains unproved. No
stronger claim expansion or full P=NP goal completion is approved.
