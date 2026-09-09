# Branching dual: proof and nonclaims review

2026-09-08. S3040 / S008 / E004. Harness-only independent review of
`2026-09-08-branching-dual-attempt.md`, with `INTEGRITY-CLAIMS.md` and
the bounded reaction-amplifier result as context. The same reviewer covers
both separate lenses below. Two independent reviewers cover the three
lenses overall; this file is not two independent reviews. No formal build,
numerical test, code change, commit, push or formal route-final is involved.

## Proof-adversarial lens — GO

The core derivations pass. A finite-bit terminology clarification was
requested: the conditional transition-law error in the coupling paragraph
should explicitly mean total variation, uniformly over histories, with
halted paths padded if M is a maximum number of transitions. The author
applied this clarification and the saved text was verified. No outstanding
corrections remain.

The first-event rate is n+lambda: n independent unit-rate bit flips and
a split at rate lambda. The no-event term and both event contributions
in equation (2) have the correct survival density and remaining duration.
At a split the two independent descendant processes start at the same
position, giving v^2. The terminal leaves themselves need not be
independent. Changing variables in the integral equation and
differentiating gives v_t=Lv+lambda(v^2-v). Substitution u=1-v gives
the desired positive logistic term, with lambda=4n. The bounded product
and prior IVP uniqueness identify this expectation with the amplifier.
For Boolean f the product of 1-f is exactly the indicator that all
terminal leaves fail, proving the terminal-witness probability identity.

The stopped population has birth rate at most lambda times its current
size; its mean is at most exp(lambda t). Markov's inequality at the
absorbing level M bounds the probability of reaching M by exp(lambda t)/M.
Letting M grow rules out finite-time population explosion. Movement also
has finitely many events on bounded intervals with a finite genealogy.
The geometric probabilities in (5) satisfy the forward equations, initial
conditions and total mass1. Recursive uniqueness of these scalar forward
equations verifies the stated law, mean and tail, including B=0.

Every split increases particle count by one, so a complete tree has
N_2-1 splitting events. Conditional on the genealogy, the independent
movement clocks have aggregate Poisson parameter n times total edge
duration integral N_s ds. Taking expectations gives the factor1/4 in
the expected movement count and5/4 in the total event count. Genealogical
independence from movements is essential here and is explicit.

The bound Pr[N_2<=B]<=B exp(-8n) is the geometric lower-tail union bound.
For B=4^n, exp(8)>256 yields the strict probability bound in (8).
Consequently the complete tree is large with high probability, not only
in expectation. These are complete-generation counts; they do not
automatically apply to every early-success or compressed implementation.
The final draft also correctly identifies the unaugmented success-or-tree-
completion rule: on UNSAT there is no success, so it generates the full
tree and cannot have a uniform polynomial runtime guarantee. Its time
to first success on SAT remains unsettled by the full-tree calculation;
formula-aware UNSAT detection and other pruning are separate methods.

The prior exact gap u(2,x)>4/5 gives a successful witness probability
above4/5 for the ideal full experiment. Independent repetition gives
the stated miss bound. A successful Boolean check is valid, but a miss
is not an UNSAT certificate. No deterministic solver is derived.

For the cap, condition on the chosen finite genealogy and retained leaves.
This choice is independent of motion and formula. Each retained path's
edge durations sum to exactly t; independent heat increments concatenate
to the original heat law for that full duration. At root0, the singleton
target1 has probability [(1-exp(-2t))/2]^n<=2^(-n) for each leaf.
There can be shared ancestral increments, but the union bound does not
require leaf independence. At most B leaves therefore give success at
most B2^(-n), also after averaging over genealogy. This justifies the
lower bound on the number of retained leaves necessary to maintain a
success probability at least4/5 within the stated cap contract.

The expectation discrepancy statement is also valid: the target exceeds
4/5 and the capped raw-OR expectation is at most B2^(-n), so their
absolute discrepancy is at least4/5-B2^(-n), a useful positive bound
when that expression is positive. No distributional coupling between
the full and capped experiments is needed for this expectation bound.

The complete-Yule tail estimate follows from1-p<=exp(-p). The proposed
integer-rounded K>=exp(8n)log(1/epsilon), for0<epsilon<1, is a sufficient
exponential population cutoff. It does not by itself cap all motion
events or specify a finite-bit simulator. Sequential conditional
total-variation errors can be coupled stepwise, yielding their sum as
an overall error bound for a fixed or padded transition budget. This
is an error contract only, as the note states. Sampling edge endpoints
instead of every flip changes motion accounting but leaves the tree
population obligation intact. The inherited n=0 case is direct evaluation;
the branching analysis explicitly assumes n>=1.

## Nonclaims lens — GO-WITH-NOTES

The dual is an exact mathematical probability representation of the
specified finite-dimensional amplifier. It is not an implementation of
its law at unit-cost exact-real precision, a polynomial evaluator, or a
Navier--Stokes device. The finite-bit section preserves this distinction.

The exponential counts apply to complete genealogy generation. The cap
obstruction applies to a formula- and movement-independent selection
with full-duration terminal paths and raw Boolean OR output. Neither
result excludes position-dependent retention, formula-aware pruning,
early stopping, changed initial roots, or other postprocessing. Such
changes require new analyses and may invalidate the heat marginal used
here. The draft explicitly identifies these scope restrictions.

The singleton test is easy SAT with a directly readable witness. Its
failure under the restricted cap is not a SAT-search lower bound.
Likewise, a positive witness probability does not turn one miss into a
negative decision or yield a deterministic guarantee.

The prior amplifier's proven constant gap is used only to interpret the
dual and compare this sampler. It supplies no free initialization,
simulation or inference. No generic representation lower bound, counting
hardness theorem, P=NP result, physical transfer or full-goal closure
follows. The bounded informal identities and scoped sampling limitations
pass; the general efficient evaluator remains unresolved.
