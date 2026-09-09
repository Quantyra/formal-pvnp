# A branching representation of the amplifier and its counted tree size

2026-09-08. S3040 / S008 / E004. Harness-only informal research.
Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-branching-dual-2026-09-08.md`.
Read with `INTEGRITY-CLAIMS.md`, the reaction-amplification attempt and
the exact-lumping attempt. The probability identities below are derived
directly. No general SAT algorithm, physical implementation, counting
hardness claim or P=NP result is supplied. No code or simulations are used.

## First-event derivation of the dual

Let f be the Boolean CNF satisfaction indicator on {0,1}^n, n>=1, and
let lambda=4n. Start one particle at x at time0. Each particle flips each
bit at rate1, independently, giving the hypercube generator L. Separately
it splits at rate lambda into two children at its current position. After
splitting, the children have independent clocks and movements. The
genealogical branching clocks are independent of all movements and of f.

Write N_t for the number of particles at time t and X_l(t) for their
positions. Put g=1-f and define

    v(t,x)=E_x product_(l=1)^(N_t) g(X_l(t)).        (1)

The finite-time population is almost surely finite, as proved below, so
this bounded product is well defined. The first event at the initial
particle has total rate n+lambda. Conditioning on its time and type gives

    v(t,x)=exp(-(n+lambda)t)g(x)
      +integral_0^t exp(-(n+lambda)s)
         [sum_i v(t-s,x xor e_i)+lambda v(t-s,x)^2] ds. (2)

The square uses independence of the two descendant processes conditional
on their common starting point. Terminal leaves in general are not
independent, since they can share a moving ancestor. Differentiating the
renewal equation yields

    v_t=Lv+lambda(v^2-v), v(0)=1-f.

Consequently u=1-v solves exactly

    u_t=Lu+4n u(1-u), u(0)=f.                       (3)

Uniqueness of the bounded finite-dimensional reaction solution identifies
it with the preceding amplifier. Because f is Boolean, its interpretation
is especially concrete:

    u(t,x)=Pr_x[at least one terminal leaf satisfies F]. (4)

Thus this representation is a real alternative to storing the full state
array, but its genealogy and evaluation work must be counted.

## The population law, nonexplosion and full-tree event counts

Movement does not change population. With m particles the next split has
rate lambda m and increases the population by1. Stop this pure-birth
process on reaching M. Its mean obeys E[N_(t,stopped)]<=exp(lambda t)
by the elementary differential inequality for its birth rate. Hence
Pr[reach M by t]<=exp(lambda t)/M. Letting M increase proves that no
infinite population is reached in a finite time, almost surely.

The forward equations, starting with one particle, are

    p_1'=-lambda p_1,
    p_m'=-lambda m p_m+lambda(m-1)p_(m-1), m>=2.

Direct substitution, the initial condition, and summation of the geometric
series give the normalized solution

    p_m(t)=p(1-p)^(m-1), m>=1, p=exp(-lambda t),
    E N_t=1/p=exp(lambda t),
    Pr[N_t>B]=(1-p)^B for integer B>=0.             (5)

At time2, E N_2=exp(8n). There are exactly N_2-1 splitting events in
a completely generated tree. Conditional on the genealogy, let
A_t=integral_0^t N_s ds be its total particle time. Motion events are
Poisson with mean n A_t, by independent rate1 bit clocks on its edges.
Taking expectations gives

    E[motion events through2]
       =n integral_0^2 exp(4ns) ds=(exp(8n)-1)/4,
    E[all split and motion events through2]
       =(5/4)(exp(8n)-1).                           (6)

This expectation is not hiding a typically small tree with only rare
huge outliers. From (5) and 1-(1-p)^B<=Bp,

    Pr[N_2<=B]<=B exp(-8n).                         (7)

For example, setting the exact integer B=4^n gives

    Pr[N_2>4^n]>1-64^(-n),                          (8)

because exp(2)>4 implies exp(8)>256. Thus even this much smaller
exponential population threshold is exceeded with overwhelming
probability. The genealogy is independent of whether the input is SAT.

These counts concern explicitly generating the complete tree and, if
used for (1), evaluating its terminal leaves. They apply directly to
that implementation, including an UNSAT run with no successful leaf.
They do not establish the cost of every lazy, early-success, or
formula-aware alternative. Depth-first generation can change memory
usage but does not erase the events of a fully generated tree.

## The ideal witness sampler has a gap, but not a polynomial cost bound

The earlier comparison theorem gives u(2,x)>4/5 for every x on SAT
inputs and u(2,x)=0 on UNSAT inputs. By (4), generating the full ideal
branching experiment and checking its leaves therefore finds an actual
SAT witness with probability greater than4/5, while never producing a
false witness. Independent repetitions reduce the miss probability to
less than(1/5)^r after r trials. A missed trial is not a definite UNSAT
certificate.

The exact witness check is ordinary Boolean evaluation. Its per-leaf
cost is polynomial in the formula length, but a complete experiment has
the population and event counts (5)--(8). On SAT inputs, the complete-tree
calculation alone does not settle the time to the first verified witness.
On UNSAT inputs, the unaugmented rule that stops only on success or tree
completion must finish the full tree. That rule therefore has exponential
expected and typical cost there, excluding a uniform polynomial runtime
guarantee. This does not cover additional formula-aware UNSAT detection
or other pruning. No deterministic marginal or evolution evaluator is
obtained simply by naming this randomized representation.

## A precise genealogy-only cap loses the amplification

Consider the following restricted cap implementation, with root0^n and
fixed horizon t. A finite genealogy and at most B retained terminal
particles may be chosen using branching times, independent randomness,
n,t and B. They are independent of the formula and of all particle
movements. Every retained root-to-leaf path has total diffusion duration
exactly t. Each edge carries the original rate1-per-bit walk, independently
of the genealogy and of movement increments on other edges; descendants
inherit their ancestor's endpoint. Branch suppression or terminal
selection based only on genealogy is allowed under these conditions.
The proposed output is the raw OR of the terminal Boolean witness checks.

Condition on the selected genealogy. Along any specified retained leaf,
concatenating its edge walks gives the heat transition law for duration t,
because the edge durations add to t. For the singleton formula

    F=(x_1) AND ... AND (x_n),

the only target is1^n. Therefore each retained leaf has conditional
success probability

    [(1-exp(-2t))/2]^n<=2^(-n).

No independence among the leaves is required for the union bound. It
holds conditional on every allowed genealogy and hence after averaging:

    Pr[capped raw OR finds a witness]<=B 2^(-n).    (9)

At t=2 the full process's probability exceeds4/5. The expectation of
this capped raw-OR estimator therefore differs from the target by at
least4/5-B2^(-n). A B polynomial in the singleton family's explicit
encoded length O(n log n) cannot preserve that constant signal. In
particular obtaining success probability
at least4/5 within this restricted cap requires B>= (4/5)2^n.

This bound does not cover position-dependent retention, formula-aware
pruning, early position-dependent stopping, changing the root or movement
law, or arbitrary postprocessing and general algorithms. Such choices
can condition selected paths and invalidate the fixed heat marginal used
in (9). The requirement that each retained path still lasts t is also
essential to the stated derivation; earlier observations are not silently
treated as terminal samples. The singleton CNF itself is easy: its
all-one witness is read directly from its unit clauses. Equation (9)
limits this specified sampling rule, not SAT search on the example.

## Continuous-time identities versus finite-bit implementation

The process above defines a mathematical law; sampling exponential
waiting times and comparing them with the terminal horizon is not granted
unit-cost exact-real arithmetic. A finite implementation must specify its
random-bit model, numerical tolerances, stopping rules and the resulting
distributional error. Neither an exact clock oracle nor exact arbitrary
transition probabilities are supplied by (1).

There is a simple scale check even before those numerical details. To
discard a complete Yule genealogy only on a small tail event, (5) gives

    Pr[N_2>K]=(1-exp(-8n))^K<=exp(-K exp(-8n)).

Thus K>=exp(8n)log(1/epsilon) is a sufficient integer-rounded cutoff for
tail probability at most epsilon. It is exponential, consistent with
the lower-tail obstruction (7); this is not a proposed cheap cap.
For at most M sequential random transitions, pad halted paths with dummy
transitions. Conditional total-variation errors at most epsilon/M,
uniformly over histories, give total law error at most epsilon by
stepwise coupling. That elementary union bound describes an
error contract, not an implemented sampler here. The logarithm of an
exponential event budget can still be O(n); modest precision-bit counts
do not eliminate the number of events being sampled.

One can alternatively draw edge endpoints using the product heat kernel,
rather than explicitly recording every intermediate flip. This changes
the accounting for motion events but retains the branching tree and its
terminal-particle count. Neither form by itself provides the missing
polynomial evaluator for arbitrary CNF.

## Outcome

The lazy representation is exact and turns the reaction's constant output
gap into a witness probability. Its full genealogy is typically as well
as on average exponentially large. A precisely movement-independent,
formula-independent terminal cap loses that gap on an explicit easy
formula. More informed pruning or another succinct representation remains
an open implementation direction, with its own correctness and work
obligations; neither is ruled out here. No general SAT algorithm, P=NP
result, physical transfer, simulation, code or commit is claimed.
