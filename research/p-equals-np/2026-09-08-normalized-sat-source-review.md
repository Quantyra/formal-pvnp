# Normalized analog SAT: source and complexity review

2026-09-08. S3040 / S008 / E004. Baseline 8df8582. Independent harness-only review; no code, commits, planning edits or P=NP claim.

## Primary-source scope

[Ercsey-Ravasz--Toroczkai, arXiv:1208.0526](https://arxiv.org/pdf/1208.0526) is the original Nature Physics 2011 solver paper with supplement, uploaded in 2012. Equations (1)--(2) use positive weights a_m, spins in [-1,1], clause product K_m=2^-k product_i(1-c_mi s_i), spin derivative sum_m 2a_m c_mi K_m K_mi, and a_m'=a_m K_m. K_mi is the product with factor i removed, retaining normalization; quotient notation need not introduce boundary division.

Main text and Supplement E distinguish solution attractors from unstable projected cancellations and measure-zero exceptional regions. Supplement E.1 explicitly offers a sketch of general escape. Absence of stable nonsolution attractors does not guarantee success from every fixed deterministic initialization. Section H's extrapolation assumes the ensemble scaling law for all sizes. Reported polynomial continuous-time behavior and spin-projection length are not uniform all-input polynomial bit-cost theorems. The full weight state is excluded from that projected length. Numerical-integration cost is separately discussed. The paper supplies no finite, certified UNSAT deadline suitable for the requested deterministic decision procedure.

## Independent normalization checklist

Let S=sum a_m, p_m=a_m/S and Kbar=sum p_m K_m. Product differentiation gives S'=S Kbar and p_m'=p_m(K_m-Kbar). The original spin equation retains a factor S. Dropping this factor while leaving the weight equation unchanged changes relative time scales and therefore changes the dynamics, rather than merely rescaling time.

If new time tau satisfies d tau/dt=S, then ds/dtau is the normalized spin force, dp_m/dtau=p_m(K_m-Kbar)/S, and d(1/S)/d tau=-(1/S)^2 Kbar. An exact normalization can move the large scale into a small coefficient, reconstruction sensitivity, or time conversion. A bounded state alone does not prove bounded computational work or a correct deadline.

For original 0<=K_m<=1 and positive initial weights, a_m stays positive on finite time intervals and a_m(t)<=a_m(0) exp(t). Thus normalization is nonsingular for finite original times. Extension to a closed compactified boundary S=infinity or 1/S=0 requires separate interpretation; that boundary cannot silently provide an UNSAT decision.

A correction of initialization, weight evolution, spin forcing, or time control needs its own correctness analysis. The source's attraction/escape discussion cannot be inherited automatically. A rounded satisfying assignment can be checked cheaply, but failure to find one by an unproved deadline is not a certificate of unsatisfiability. Measure-zero exceptions are still relevant for a deterministic initialization chosen without solving the instance.

## Status

Source and final candidate reviewed. GO for exact normalization and the corrected-flow counterexample; NO-GO for universal convergence of this clause-cycling correction; INCOMPLETE for a polynomial-time SAT algorithm and P=NP. No empirical fits or large experiments were used.


## Final candidate complexity review

Inspected `2026-09-08-normalized-analog-sat-attempt.md` in full. The variable-width clause normalization is an explicit natural generalization; no original convergence theorem is transferred through it or through the correction. Source weights and normalized coordinates obey the stated quotient/product differentiation identities, including rho in both normalized auxiliary equations. The corrected physical law a_m'=a_m(K_m+q_m), xi'=A transforms exactly into the displayed normalized law. The added schedule is explicitly controlled, rather than silently called an autonomous polynomial ODE.

The simplex and cube invariance arguments are valid. Because (1/rho)'=barH lies between0 and2, rho lies between1/(M+2xi) and1/M. Integrating yields the stated logarithmic lower bound on physical time. Thus this normalization creates no finite-time endpoint at xi=infinity. Fixed finite intervals have finitely many schedule switches and bounded states; slotwise uniqueness justifies the invariant-subspace argument.

The paired positive/negative three-literal formula is satisfiable but invariant under coordinate permutations. Equal-coordinate initialization consequently remains on the diagonal for arbitrary positive clause-weight controls of this stated form. The two residuals and diagonal velocity in equation(7) are correct. At the initial point, the first boosted slot gives b_+'=1/8, b_-'=-1/8 and z''=1/128. The correction therefore escapes the origin while preserving the obstruction. For every diagonal value, the largest residual is at least1/8, defeating the strict progress criterion without any asymptotic or empirical assumption. Common sign rounding cannot produce a mixed Boolean assignment there. This refutes the corrected rule's claimed universal convergence, not all deterministic perturbations or SAT algorithms.

The residual threshold certifies satisfiability by contraposition on a false rounded clause. Its enclosure bound follows from |partial_i K_m|<=1/2 and at most k_m participating coordinates. Verifying a candidate Boolean assignment remains sufficient regardless of approximate dynamical residuals. The candidate correctly supplies no finite UNSAT decision from perpetual failure; such a timeout would already fail on its explicit satisfiable example.

The normalized energy derivative includes the covariance term. The negative spin-gradient term alone is therefore not a valid monotonicity proof. A small weighted energy does not control all individual residuals without weight lower bounds; the note's example is scoped to that missing implication, not asserted to be a visited dynamical state. Inverse rho sensitivity, schedule execution, dimension and full-state simulation costs remain explicit. Neither small coordinates nor large inverse derivatives imply the requested polynomial or exponential bit-time conclusion by themselves.

Final source/complexity verdict: no mathematical or scope corrections required. GO for the bounded derivations and deterministic-correction counterexample; NO-GO for this correction's all-input progress claim; INCOMPLETE for P=NP. No code, commits, planning edits, numerical fitting or large experiments were performed by this reviewer.
