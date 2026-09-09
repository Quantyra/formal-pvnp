# Global potential: proof and nonclaims review

2026-09-08. S3040 / S008 / E004. Baseline `f1d5a43`.
Harness only. One independent reviewer covers the two separately reported
lenses; these are not two separately staffed reviews. A separate reviewer
audits source/complexity scope. No code, formal modules/builds, commits,
planning edits or publication are involved.

Reviewed stable `2026-09-08-global-potential-attempt.md` against the retained
normalized flow and asymmetric initialization. This review verifies its new
identities and implications, not an external paper's convergence theorem.

## Proof-adversarial lens: GO for the compensated identity and scoped examples

**Exact identity.** At fixed b, the spin gradient of E is -G. Weight evolution
adds rho Cov_b(K^2,H), while (log rho)'=-rho barH. Subtracting the covariance
from barH gives exactly

    D=sum b_m(1-K_m^2)H_m + E barH.

Both terms are nonnegative because K lies in [0,1] and H>=0. Also
barH>=barK>=E, giving D>=E^2. Thus P'=-||G||_2^2-rho D has the correct
logarithm sign and no omitted weight contribution. The text correctly states
these identities almost everywhere at the prescribed switches; the potential
is continuous and locally absolutely continuous, so the integrated identity
has no jump term.

**Budget and range.** Integration gives E(0)-E(T)+log(rho(0)/rho(T)). Using
E(0)<=1, E(T)>=0, rho(0)=1/M and rho(T)>=1/(M+2T) yields exactly (5).
P is not claimed to have a finite lower bound. If a SAT-restricted additional
coercivity theorem supplied an inverse-polynomial positive rate before a hit,
the resulting linear-versus-logarithmic inequality would indeed force a
polynomial horizon. That rate is explicitly a missing hypothesis.

**Bounded transform.** For W=rho exp(E), differentiating within slots and
then integrating gives the weighted budget in (6). The factor W cannot be
removed. Because one q is active and its weight is at least rho, barH>=rho
and rho'<=-rho^3. Equivalently (rho^-2)'>=2, proving the displayed upper
bound 1/sqrt(M^2+2xi). Together with E<=1 it forces W to zero on every
continued run. This coexists with the lower reciprocal-scale bound and
does not imply finite-time vanishing. Integrating that upper cube gives
integral rho^3<=1/M; the same follows directly from -rho'>=rho^3.

**Actual UNSAT run.** All eight sign patterns on three variables contain a
clause falsified by every Boolean assignment. The rounding implication
therefore forces max K>=1/8 throughout the continuous cube. The specified
asymmetric seed and cyclic flow have a global normalized-time solution by
the established boundedness argument, so the dissipation budget applies to
this actual run. With M=8, its time-average upper bound is
[1+log(1+T/4)]/T, tending to zero. Nonnegativity then provides arbitrarily
late nonswitch times with arbitrarily small total dissipation; otherwise an
eventual positive lower bound would contradict the average. Spin force is
small along the same selected times while the residual threshold fails
everywhere. This invalidates an all-formula positive residual-only coercivity
bound, but does not invalidate a SAT-restricted version.

The lower estimate E>=rho R^2 uses the weight of a maximizing clause.
Combining it with D>=E^2 yields rho D>=rho^3 R^4. Its time-integrable scale
factor is compatible with permanent residual failure and gives no hit
contradiction by itself.

**Actual SAT-seed cancellation.** Recomputing the four clause residuals at
(1/8,1/4,3/8) gives the stated k=(495,135,175,231) over 2048. Each positive
integer multiplicity N_j makes N_j K_j^2 the same common factor times w_j.
The weighted sign sums for w=(7,2,3,4) are (-2,-4,-6), whose division by
16 equals -s. At this strictly interior seed,
c/(1-cs)=(c+s)/(1-s^2), proving cancellation of every coordinate of G.
The normalization factor 1/M is common and does not alter the cancellation.

The witness (true,true,false) satisfies all four clause types; all-true fails
the all-negative type, whose initial residual is above 1/8. Duplication
preserves satisfiability and is not removed by the declared preprocessing.
The original seed still depends on n=3, not on the number of copies. Thus
this is an actual initialized SAT instance with zero spin force before the
first boost changes the weights. It establishes neither future trapping nor
zero total dissipation: E>0 implies D>=E^2>0 and rho>0 there. The note keeps
these distinctions explicit.

No blocking mathematical defect was found in the identities, ranges,
integrated estimates or scoped counterexamples.

## Nonclaims lens: GO-WITH-NOTES for bounded exploratory use

The corrected potential is a valid new global identity for the specified
controlled system, without changing its dynamics. It is not reported as a
complete convergence proof. Its bounded transform is explicitly shown to
decay on UNSAT runs as well, so no scale-based SAT detector is implied.

The actual UNSAT trajectory refutes unqualified coercivity only. The SAT
construction refutes a pointwise spin-force bound only. Neither example
refutes all SAT-restricted total-dissipation estimates, integrated progress
arguments, the entire revised algorithm, or P=NP. A failed proof strategy
is not converted into a computational impossibility claim.

No fixed timeout is justified. The note correctly retains a universal
SAT-success horizon, reliable detection and uniform effective simulation as
the requirements that could justify a NO deadline. Bounded normalized
variables, small force and potential decay are not substituted for those
requirements or for Boolean witness verification.

Safe summary: covariance compensation yields an exact global dissipation
identity, but the available budget lacks a SAT-restricted residual-progress
theorem; explicit actual-run examples delimit weaker proposed criteria.
No full-goal completion, physical implementation or stronger claim expansion
is approved.
