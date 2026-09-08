# Independent clock and complexity review

Date: 2026-09-08. Route: S3040 / E004 / S008. Destination: formal-pvnp. Reviewer: harness complexity-theory agent; no OpenCode. Scope: conditional mathematics and primary-source comparison, not a formal proof audit. No Lean files or public claim surfaces changed.

Initial worktree observation: `git status --short` showed `?? research/`; the source-and-method note was the existing research artifact. It was preserved. This review is a new, deliberately uncommitted research artifact. No repository-local AGENTS.md was present.

## Verdicts and ranked findings

- **NO-GO as proof of P=NP.** A clock schedule does not provide a polynomial-time algorithm for the information-bearing payload. No standard-model simulation bound, fluid logic construction, or robust output transport theorem is supplied.
- **GO-WITH-NOTES as exploratory mathematics.** The finite rational clock schedule is a useful positive lemma: exponentially many scheduled events can have polynomial-size endpoint descriptions. The reparametrization and separated-configuration lemmas below delimit precisely what pure acceleration does not improve.
- **Critical: model and payload.** An oracle for the final state after M transitions would silently contain the central difficulty. Efficiently computing the time of the Mth transition is not that oracle.
- **High: full-state trajectory length.** Polynomial physical duration and small positional path length do not imply polynomial computational trajectory length in the polynomial-ODE characterization. Include all auxiliary coordinates and the stated encoding.
- **High: both decision outcomes.** Exhaustive enumeration can return no at a finite cutoff conditional on a known gate bound and reliable counter. A persistent yes flag alone supplies no such completion certificate.
- **High: programmable finite carrier.** No verified coupling from the vortex to even one noise-tolerant logic update or memory bit is established by the supplied scaling assumptions.
- **Medium: precision.** Exponentially small gaps imply linearly many fractional bits in this schedule, not exponentially many. Error accumulation and physical timing are distinct obligations.

## Independent conditional clock calculation

Set singular time T=1, tau=1-t, and assume a gate rate a(t)=tau^(-1-h), with fixed h>0 and the normalization of one gate per unit integrated phase. Then

    S(t) = integral_0^t a(u) du = ((1-t)^(-h)-1)/h.
    tau_M = (1+h M)^(-1/h).

S is strictly increasing and reaches every finite M at t_M<1. A constant multiplicative rate changes constants, not this conclusion. An asymptotic fluid angular-frequency estimate is weaker than this exact assumed machine clock: it still needs uniform lower bounds and a gate-coupling theorem.

For h=1/q, where q is a fixed positive integer,

    tau_M = (q/(q+M))^q.

Numerator and denominator have O(log(M+1)) bits, with constants depending on fixed q. Repeated integer multiplication computes them in polynomial bit time in log(M+1). For M=2^n p(L), L the formula encoding length and p a fixed polynomial gate bound per assignment including counter and output overhead, log M=O(n+log L). Thus there is no exponential-bit endpoint obstruction in this example.

For adjacent events, the mean-value theorem gives

    tau_M-tau_(M+1) = q^(q+1)/(q+xi)^(q+1),  M<xi<M+1.

The gap is Theta((M+1)^(-q-1)) for fixed q. A fixed fractional timing margin therefore takes O(log M) binary fractional bits to specify. No conclusion follows that the necessary actuator bandwidth or accumulated gate error has polynomial physical cost.

If every assignment is tested and the counter reaches a predetermined total M including all overhead, the Boolean accumulator equals SAT(F). This covers unsatisfiable formulas too: read after the last committed update and after explicit output-transfer time. One can reserve extra clock ticks, but reserving ticks does not prove output transport to a macroscopic receiver. This is a finite conditional machine, not a decision based on an undefined state at t=1.

## Two elementary lemmas that isolate the issue

**Time-change invariance.** Let z:[0,M]->R^d be absolutely continuous, and s:[0,t_M]->[0,M] an increasing C1 bijection with positive derivative. For y(t)=z(s(t)), the chain rule and substitution yield

    length(y) = integral ||z'(s(t))|| s'(t) dt
              = integral_0^M ||z'(u)|| du = length(z).

This holds in any fixed norm. Adding clock coordinates to the full state cannot reduce the length of its payload projection under the infinity norm. Consequently accelerating a fixed computational trajectory does not shorten it. This is not a statement about all alternative algorithms for its endpoint.

**Separated-configuration bound.** Suppose sample times u_0<...<u_M have successive payload states separated by at least delta in a fixed norm. By the definition of variation/arc length,

    length(z) >= sum_(j=0)^(M-1) ||z(u_(j+1))-z(u_j)|| >= M delta.

For an enumeration whose assignment bits occupy fixed disjoint voltage bands, each successive distinct assignment changes at least one bit by the band separation. If delta>=1/poly(L), M=2^n such transitions cannot have polynomial length on families with n proportional to L. This obstructs that explicit robust enumeration encoding, not every SAT algorithm and not every compressed state representation. Dense encodings with tiny configuration distances evade the hypothesis; their decoding and evolution cost must be examined separately.

**A useful counterexample to an overbroad obstruction.** For the hypothetical planar carrier x(t)=r(t)(cos theta(t),sin theta(t)), r=tau^(1/2), theta'=tau^(-1-h), its Euclidean speed is sqrt((r')^2+(r theta')^2). Near tau=0 this is Theta(tau^(-1/2-h)); its total spatial length is finite if 0<h<1/2 even though theta diverges. This is not an asserted Navier-Stokes material trajectory. It shows why infinite rotations do not alone prove infinite positional length. Fixed-size bit separation disappears as the radius shrinks, and renormalizing x/r changes coordinates and their conditioning, rather than merely changing time.

## Primary-source complexity bridge

Bournez, Graca and Pouly, [journal manuscript, Definition 2.1 and Theorem 2.2](https://arxiv.org/html/1609.08059v3#S2), characterize P using fixed rational polynomial vector fields and polynomial input maps, canonical finite-word encoding including word length, global trajectories, stable separated yes/no outputs reached after polynomial full-state trajectory length, and a lower-growth condition on length. Their length uses the infinity norm. These hypotheses matter: the theorem is not a blanket simulation result for arbitrary analytic dynamics or Navier-Stokes PDEs. Applying it requires constructing the qualifying recognizer, not just bounding physical time or the length of one projected coordinate. Section 7 supplies the language proof; section 6.2 discusses simulation. The finite-time divergent clock itself does not meet the stated global-solution hypothesis.

The preceding length lemmas are independently derived here, not claims that their theorem proves a SAT lower bound. A polynomial-length compressed dynamics route is legitimate, but it must replace the long payload path, or prove a new efficient endpoint method, rather than reparametrize it.

Ercsey-Ravasz and Toroczkai's [2011 paper and supplement](https://arxiv.org/pdf/1208.0526), Figure 3 and pages 7-8, report analog search-time scaling over tested random ensembles and discuss exponentially large fluctuations of an auxiliary energy function. The supplement also measures numerical integration cost. This supports the relevance of auditing auxiliary state and numerical work; it is not an all-input polynomial worst-case SAT-decider theorem. Its reported length in the assignment-coordinate hypercube excludes the auxiliary energy variables, so it does not by itself instantiate the full-state polynomial-length characterization. The analog energy function is also not identical to kinetic energy of a fluid. These observations provide precedent and a warning about model accounting, not a transferred impossibility result.

## Precise next theorem

For the user's immediate carrier target: specify a uniformly constructed finite-dimensional or fluid-coupled device with a designated Boolean memory coordinate, a scheduled controlled update, and an external output. Prove an invariant giving two distinguishable bit states, correctness of the update on both inputs, and a quantitative perturbation tolerance through a finite cutoff; prove a receiver obtains the bit with a stated margin by a pre-singular deadline. State how input size changes forcing/control description and evaluation cost. A one-bit result would discharge a real engineering/mathematical dependency but would not imply P=NP.

For the actual P=NP target: construct fixed rational polynomial p,q and a polynomial length bound B satisfying the cited recognizer definition for SAT on every input, including unsatisfiable inputs. Prove global existence, initialization, stable sign, and the full-state bound. Alternatively provide a uniform deterministic endpoint algorithm with polynomial bit work for a separately specified correct SAT device. Neither residual is discharged by the clock calculation, and neither is a demand to prove that brute force is universally necessary.

Remaining work belongs to S3040 and its next routed carrier/recognizer increment. No stronger public claim is authorized or supported.

## Review of the landed constructive artifact

Read `2026-09-08-vortex-clock-attempt.md` after it appeared in the shared worktree. Its integration, rational endpoint, mean-value gap bounds, and conditional enumerator semantics agree with the independent derivation above. The repeated-composition discussion correctly distinguishes code sharing from evaluation sharing; the output-specific skip-ahead obligation is not supplied as an assumed solution. The text explicitly leaves physical transport and deterministic correctness open.

Correction/qualification: h=1/q is an abstract exact illustration for every fixed positive integer q. To place that illustration in the manuscript parameter interval reported by the source agent, 0<h<1/100, take a fixed q>=101. This keeps all bit estimates polynomial but can make their constants large. No n-dependent q is being hidden.

The resource-table phrase `O(log M) phase precision` should be read as binary precision of absolute event timing; phase error measured in gate units can be a fixed small constant. Neither automatically bounds perturbed fluid phase error.

The source agent separately reports a local material-carrier mismatch for a sampled similarity circle: remaining on it requires V0(X,0)=-X and U(X,0)=0, whereas the near-axis values it inspected have V0/X tending to -4 and U(0,0)>0. This report has not been independently rederived in this review and is not used as a theorem here. It reinforces that an Eulerian angular-frequency sample is not already a Lagrangian computing element. A circle-specific failure cannot exclude off-plane or controlled carriers.

Final assessment of the landed artifact: GO-WITH-NOTES for accurately bounded exploratory analysis, NO-GO as a proof of P=NP. Its clock result is real; its missing payload and model-bridge theorem remain explicit.
