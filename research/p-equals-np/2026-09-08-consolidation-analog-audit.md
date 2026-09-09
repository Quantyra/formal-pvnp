# Consolidation audit: analog mechanisms, empirical evidence and novelty

2026-09-08. S3040 / S008 / E004, baseline 8456346. Harness-only independent
proof/nonclaims consolidation reviewer. This checkpoint selects the strongest
relevant artifacts; it is not another technical increment, an exhaustive
literature search, or a new experimental campaign. No commits or publication.
The attack-specification review appears below.

## Assessment

The lane has established useful exact local mathematics and carefully bounded
correctness evidence. It has not demonstrated a new general-case computational
advantage or a publishable novelty claim for S3040. The strongest all-input
analog construction is the heat/reaction model: constant decision gap by time
2 and polynomial full sup-norm path length, but with 2^n coordinates and no
polynomial succinct evaluator. This is a clean application of familiar
mechanisms; a simple construction being new to these notes does not establish
substantive research novelty.

The most potentially distinctive local results are the custom cyclic-control
estimates and the explicit minimum-size equitable-quotient example. They are
valid restricted results according to the saved mathematical reviews, but
their novelty and independent scientific significance remain unverified.
Neither closes the arbitrary signed-CNF obstacle. A separate publication case
would need a precise theorem that exceeds its nearest literature and matters
beyond diagnosing a deliberately chosen representation or controller.

## Primary comparisons actually inspected

1. [Bournez, Graca and Pouly, arXiv:1609.08059v3](https://arxiv.org/html/1609.08059v3),
   Definition 2.1, Theorem 2.2 and Section 2.3. The source already discusses
   exponential acceleration and compression into bounded modeled time.
   Its language characterization uses a fixed rational polynomial ODE,
   prescribed uniform word initialization, global solution, stable decision,
   and a polynomial full-trajectory-length budget with a length-growth
   condition. It does not license exponentially many input-dependent
   coordinates or an external PDE controller for free. Thus the clock warning
   is established prior art, and the local bridge is a conditional application,
   not a new characterization of P.

2. [Ercsey-Ravasz and Toroczkai, arXiv:1208.0526](https://arxiv.org/html/1208.0526),
   equations (1)-(2), main-text timing discussion and Supplementary H-J.
   The original weighted spin equations are the source of this lane's
   normalization. The paper's scaling discussion depends on fitted ensemble
   behavior and its extrapolation; it also reports unfavorable digital
   discretization scaling. Its plotted trajectory lengths concern spin
   projection, and its auxiliary weights evolve separately. These statements
   provide neither an all-input deadline for our selected rational seed nor a
   theorem for our changed cyclic controller. Their almost-all/ensemble
   quantifiers cannot be replaced by a worst-case deterministic guarantee.

3. [McKean, 1975, Application of Brownian Motion to the Equation of
   Kolmogorov-Petrovskii-Piskunov](https://www.cs.fsu.edu/~mascagni/McKean_1975_CPAM.pdf),
   pp. 324-325, Section 2 and equation (6). The scanned primary pages were
   visually inspected. They give the binary branching population's geometric
   law and an expectation of a product of initial-data values, with the
   first-split integral producing the quadratic reaction equation. Replacing
   Brownian motion by the finite hypercube chain and adjusting the splitting
   rate is the local adaptation. Complementing the solution gives the logistic
   sign convention. The branching dual and exponential population mechanism
   are therefore established mechanisms, not novel solutions to SAT.

4. [OpenAI's announced Navier-Stokes result](https://openai.com/index/navier-stokes-solution/),
   result and continuum-model discussion. This is a primary announcement of
   a finite-energy forced construction; it also identifies infinite speeds as
   a failure of the continuum description of a real fluid. This audit does
   not independently verify its analytical proof or Lean formalization.
   Its statements do not establish programmable gates, memory or a SAT
   algorithm. The source remains inspiration and a conditional carrier input.

For the heat/Fourier identification, the author's
[Analysis of Boolean Functions](https://www.cs.cmu.edu/~./odonnell/papers/Analysis-of-Boolean-Functions-by-Ryan-ODonnell.pdf),
Definition 2.46, supplies an additional established reference: the independent
bit-noise operator is precisely the hypercube heat operator after setting its
correlation parameter to exp(-2t). This textbook is corroboration, not a
claim to the historical first publication of the mechanism. The elementary
kernel is also proved directly in our artifact.

Searches for the particular SAT/reaction and normalized cyclic-control
combinations did not establish priority for the exact custom constructions.
That limited outcome is uncertainty, not a negative literature theorem or
permission to label them novel. Related analog-SAT work is extensive; no
exhaustive comparison of later controllers, hardware or solver benchmarks
was completed in this checkpoint.

## Strongest retained claims and their classification

| Local evidence | What survives | Classification and limiting resource |
|---|---|---|
| [Vortex clock](2026-09-08-vortex-clock-attempt.md) and [trajectory bridge](2026-09-08-clock-trajectory-bridge-attempt.md) | Exact finite cutoff with short rational description; robust alternation inequality; chosen polynomial clock lift has length exactly M to M ticks | Elementary reformulation/application. Small cutoff is not itself exponentially many bits, but the exhaustive trace still has exponentially many robust transitions. This is not a blanket lower bound for all clocks or endpoint algorithms. |
| [Heat aggregation](2026-09-08-heat-aggregation-attempt.md) | Positive kernel gives SAT signal at least 4^-n at time 1; UNSAT stays zero; O(n) precision bits suffice for the stated gap | Established averaging mechanism applied to a succinct SAT predicate. Computing the aggregate, not writing its formula, remains unresolved. |
| [Reaction amplification](2026-09-08-reaction-amplification-attempt.md) | All-input exact gap: UNSAT 0 and SAT greater than 4/5 at time 2; signed-error bootstrap; sup-norm length at most 4n | Clean Fisher/KPP-type application with explicit constants. The state and explicit preparation contain 2^n entries. The sufficient preparation budget 2^(-32n-4) uses only O(n) fractional bits but must be implemented across the actual representation. |
| [Branching dual](2026-09-08-branching-dual-attempt.md) | Exact alternative probabilistic representation; complete-tree expected event count (5/4)(exp(8n)-1), geometric population tails | Classical representation plus sampler-specific resource accounting. A capped, motion-independent genealogy has the stated rare-witness limitation; this is not a lower bound on guided sampling or all algorithms. |
| [Exact lumping](2026-09-08-exact-lumping-attempt.md) | For the specified n=2k^2 equality-block family, the smallest initially compatible equitable partition has binomial(2k,k) cells, proved by distinct heat polynomials | Potentially distinctive explicit restricted example, novelty unverified. It constrains exact partition closure for all cell-constant states. The formula is easy and its heat factors are compact; no general representation or SAT lower bound follows. |
| [Normalized flow](2026-09-08-normalized-analog-sat-attempt.md), [cycle estimate](2026-09-08-cycle-progress-attempt.md) | Correct scale/time transformation; bounded normalized variables; actual zero-seed obstruction; cyclic reciprocal-scale bound and integral rho^2 at most 10; summable covariance error at most 240 over complete cycles | Normalization is a reformulation. The controller-specific estimates and counterexamples are potentially distinctive but novelty unverified. Intrinsic dissipation has no sufficiently strong SAT-restricted coercivity/deadline. |
| [Validated five-clause trajectory](2026-09-08-five-clause-trajectory-attempt.md) | Reviewed interval Taylor induction certifies the selected exact IVP's satisfying orthant by normalized time 14 | Concrete computer-assisted instance result, not proof-assistant formalization or general solver evidence. It repairs an inference from initial repulsion to permanent trapping, not general SAT. |

The finite-energy fluid claim, normalized square energy of an array, bounded
spin coordinates, full computational-state path length, and bit work are
different quantities. In particular the reaction model genuinely has a short
path in its specified sup norm; it would be wrong to dismiss this by claiming
every SAT-bearing path must be long. Its input-dependent exponential dimension
and missing effective evaluator are the obstruction to invoking the BGP
characterization. Conversely the clock's long enumerator trace is only a
restriction on that trace with its declared decoder, margin and norm.

## What the general-case experiments actually show

The [fallback stress](2026-09-08-fallback-stress-attempt.md) and
[adaptive comparison](2026-09-08-adaptive-buckets-attempt.md), with their saved
JSON outputs and independent reviews, use **16 distinct generated formulas**
on n in {6,8,10,12}. Two orders give 32 baseline runs, not 32 independently
generated formulas. The generator uses signed distinct-variable ternary
clauses, rejects duplicates only, and does not filter by satisfiability.
The 16 formulas contain 12 SAT and 4 UNSAT cases. Brute-force answers and
prefix checks establish finite semantic correctness; their work is a
verification cost, not the claimed solver's oracle.

These instances are small and all primary runs complete well below the global
caps. They do not exercise an asymptotic hard regime or establish useful
scaling. Local caps invoke exact fallback; global interruptions are INCOMPLETE,
not NO. Forced-cap checks validate that distinction, not a polynomial bound.

The fixed adaptive selector uses 381010 aggregate charged units, versus
320586 for the already available static-degree rule, and is worse on every
formula. Its common underlying solver work drops by 2208, outweighed by 62632
selector units. The metric is an overlapping instrumentation count, not wall
time, bit complexity or peak bytes. Comparison only against the weaker
ascending order would misrepresent the retained evidence. There is no
benchmark against a mature independent SAT solver in this suite and no
demonstrated novel general-case advantage.

Earlier parity/disjoint-block examples establish useful exact simplification
and witness preservation. They remain structured probes, not replacements
for these general signed instances. The observer and adaptive continuation
show where clausal eligibility fails and what a selector costs; they do not
control the size or lifetime of the resulting broad residual.

## Publication and direction

Applying the planning lane's
[publication readiness protocol](../../../IGH/Quantyra-Planning/docs/research-publication-readiness-protocol.md)
prospectively: (1) local milestones exist, but the proposed new S3040 citable
contribution is not yet selected; (2) the primary comparisons above establish
substantial prior mechanisms and leave exact custom-result novelty uncertain;
(3) frozen informal derivations and reviews exist, with the stated scope;
(4) there is no new frozen manuscript/release/DOI wording package to compare;
(5) this review recommends HOLD at baseline 8456346, dated above, with the
Chief Scientist/planning owner recording the publication decision. Reopen
under S3040 after a specific contribution, closest-prior-work comparison and
consistent reviewable manuscript are identified. A meaningful restricted
theorem or negative result could qualify; solving general SAT is not a
publication prerequisite.

For a **new S3040 substantive-publication claim**, the present disposition is
HOLD: novelty and general scientific advance are not established by this audit.
An honest expository or negative-results technical note may be useful, but
that is a different claim from a novel SAT algorithm, a complexity theorem
or a fluid computer. This judgment does not retract, relabel or alter the
separate S3041 Navier-Stokes effectivity publication lane. Its inherited
pressure/contraction results are already separately archived/published per
the planning record; their publication status and novelty are not certified
or reconsidered here.

The next direction should confront a declared general-case bottleneck, with
an exact operation and a cost bound that can fail visibly. In the analog
route that means a SAT-restricted, selected-seed robust deadline together
with uniform effective simulation, or an actual succinct endpoint evaluator.
In the current symbolic route it means controlling signed conjunction,
projection, conditioned sharing and witness reconstruction in total binary
work. New clocks, stronger output amplitudes, more controller dissipation,
or another easy family do not supply either missing theorem by themselves.

The proposed attack must say what it computes on arbitrary normalized input,
what it returns on both outcomes, which operation is genuinely new relative
to elimination/compilation, and exactly what cumulative quantity is bounded.
An unresolved lemma may be the research target, but cannot be a callable
subroutine. Continued work is credible only as a bounded attempt to prove or
refute that specified lemma, with a stop condition before another sequence
of restricted repairs. This checkpoint authorizes no new experiment itself.

## Adversarial review of the proposed attack specification

Reviewed [the saved specification](2026-09-08-consolidation-attack-spec.md).
This is the same reviewer's proof/nonclaims lens, separate from the other
reviewer's primary classical/compilation audit. The disposition is **GO for
the checkpoint's rejection and bounded audit recommendation; NO-GO for direct
implementation as a universal polynomial SAT attack**. No algorithm was run.

The proposed Horn-guided chronological search is a sound finite decision
procedure. Horn reasons derive only context-forced true variables, and false
values assigned merely to propose a least-model witness are not used as
forced facts. A proposed witness is checked against the original formula.
If that proposal violates a clause, the clause cannot be among the satisfied
Horn residuals. An originally non-Horn residual retains at least two unassigned
positive heads unless one has just been forced true, in which case the clause
is satisfied. Thus step 5's branch variable exists, and the two branches cover
all remaining models. Each branch fixes a fresh original variable, giving
finite depth even without any polynomial node bound.

The stored source reasons, conflict resolutions, and resolutions combining
failed children remain consequences of the original F. Eliminating propagated
literals in reverse derivation order leaves a clause over decisions; original
positive cycles do not create cyclic first-derivation reasons. If a child
explanation already blocks its parent, reusing it is sound. At a failed root
the explanation is empty. Append-only clause sharing can give a resolution
DAG rather than a tree, but adds no extension axiom or stronger inference
rule. The source of the blocking result is therefore proof power, not a
particular variable ordering.

The proposed frontier mass is not a model-count oracle. It counts disjoint
assignment cubes that have not yet been removed by checked conflict evidence;
on an UNSAT input it starts nonzero. Decisions preserve total weight, while
certified exclusions decrease it. Its integer value is at most 2^N. Paying
for any refinements and explanations is essential and is explicitly included
in the proposed hypothesis. A decrease by a 1/p(L) fraction in each block of
at most p(L) bit operations would force exhaustion or success after
O((N+1)p(L)) blocks, hence polynomial total work. This is a clear research
hypothesis rather than an available subroutine.

However that hypothesis is false for this certificate discipline. The
primary [Ben-Sasson-Wigderson paper](https://people.inf.ethz.ch/emo/SatSem05/Papers/BensassonWidgerson01.pdf),
Theorem 4.4 and Corollary 4.5, was independently opened for this review. Its
connected 3-regular expander, odd-charge Tseitin family requires exponential
general-resolution length. With q graph vertices, the constant-width encoding
has O(q) literal occurrences and O(q log q) binary input length. Exponential
proof length in q exceeds every fixed polynomial in that binary length.
The candidate emits an explicit refutation whose size is bounded by its
charged bit work, contradicting the alleged bound. This imports a known
certificate lower bound; it proves neither P != NP nor failure of arbitrary
SAT algorithms or stronger extension systems.

The ordinary-Horn-cover check is also correctly restricted: independent
complementary pairs give mutually meet-incompatible models, so an ordinary
Horn piece contained in their relation covers at most one. This concerns
exact all-model covers, not finding one witness, and the stated example
becomes Horn under a suitable polarity change. It must not be used against
all renamable-Horn compilation.

The alternate circuit-extension action is credible only as a **capability
audit**. Fresh acyclic full gate definitions preserve a unique extension of
each original assignment, while explicitly checked resolution preserves
unsatisfiability reasoning in the extended formula. None of that supplies
useful gate discovery, general short refutations, efficient proof search,
existential projection or a global runtime bound. The deliverable must expose
an actual generation rule and its costs; a standard circuit representation
or a parity-only success would not meet the proposed continuation test.

Final delta checked: the saved specification now lists all AND, OR and NOT
CNF equivalences explicitly; their polarities are correct, including the
two NOT clauses. Inputs refer only to originals or earlier gate variables,
and the only inference is binary resolution besides complete fresh
definitions and syntactic deduplication. The wording now distinguishes
unpaid evaluation from free existential projection, equivalence and proof
search. No substantive review correction remains.

The stop condition is appropriate: end after one contract and comparison;
reject a merely renamed ordinary-resolution method; mark an oracle-dependent
or uncontrolled extension operation unresolved; do not substitute more small
benchmarks or special cases. Consequently this checkpoint identifies no
credible new general-case algorithm. It recommends a bounded way to decide
whether a genuinely stronger, effectively generated operation is even
available. Passing that future review would warrant only a separate proposal,
not implementation or a full-goal claim in this turn.
