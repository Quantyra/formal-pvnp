# Global potential: independent source and complexity review

2026-09-08. S3040 / S008 / E004. Baseline f1d5a43. Reviewed the saved `2026-09-08-global-potential-attempt.md` in full. Harness only; no code, commits, planning edits, numerical experiments or P=NP claim.

## Source and model scope

Reuse of `2026-09-08-normalized-sat-source-review.md` is appropriate. The [original Ercsey-Ravasz--Toroczkai paper and supplement](https://arxiv.org/pdf/1208.0526) do not provide a worst-case polynomial deterministic decision theorem for this modified cyclic control and prescribed asymmetric seed. The candidate correctly derives a new identity for its own retained flow without importing an attraction or timing theorem through that modification.

The normalized auxiliary equations retain their required rho factors. The schedule has one nonnegative unit boost per slot, positive weights initialized at one remain at least one in original coordinates, and b_m>=rho. Piecewise control causes no missing impulse in the continuous state: derivative identities hold almost everywhere, and their integrated forms are valid.

## Independent derivation checks

At fixed b, the spin force is minus the spin gradient of E. Differentiating the weight contribution gives exactly rho Cov_b(K^2,H). Adding log rho contributes minus rho barH, so the candidate's P, D and identity (4) have the correct signs. Every term in D=sum b(1-K^2)H+E barH is nonnegative. Since K>=K^2 on the cube, barH>=barK>=E, hence D>=E^2.

The integrated identity and budget in (5) use rho(0)=1/M and rho(T)>=1/(M+2T); the resulting logarithm is correct. This is an unweighted integral budget for the full displayed dissipation, but its right side grows with the horizon. It is not a uniform finite total dissipation bound or a residual convergence theorem.

The bounded transform satisfies W'= -W(||G||^2+rho D); the factor W cannot be discarded. The actual boost gives barH>=b_active>=rho, so (rho^-2)'>=2 and rho<=1/sqrt(M^2+2xi). Consequently W tends to zero irrespective of satisfiability. Both upper and lower rho bounds remain positive at each finite normalized time; no singular endpoint or answer at that endpoint is introduced. Integrating the cubic upper envelope gives integral rho^3<=1/M as claimed.

## Actual trajectories and quantifiers

The complete eight-sign three-variable CNF is UNSAT, and sign rounding proves R>=1/8 everywhere in the cube. The established existence and invariance results apply to its specified seed and cyclic weights. Its average full dissipation tends to zero by (5), so arbitrarily late states have arbitrarily small dissipation while residual remains bounded below. This is an actual retained-system consequence; no guessed equilibrium or arbitrary unreachable state is being substituted for the trajectory.

It rules out a fixed positive residual-only dissipation lower bound covering all formulas, even at that fixed input size. The candidate correctly separates that obstruction from a hypothetical theorem restricted to satisfiable inputs. The estimate rho D>=rho^3 R^4 supplies no contradiction with this UNSAT trajectory because the available cubic scale envelope is integrable. This observation does not by itself assert that the actual full dissipation integral is finite.

The satisfiable duplicate-clause example also checks exactly. At the n=3 seed its four residual numerators are (495,135,175,231). Multiplicities N_j=w_j product_(l!=j) k_l^2 make N_j K_j^2 proportional to w=(7,2,3,4). The weighted literal signs are (-1/8,-1/4,-3/8), the negative of the seed. The stated interior gradient identity therefore cancels every spin-force coordinate. The Boolean assignment (true,true,false) satisfies each clause type, whereas initial all-true rounding fails the all-negative clause.

This is a finite explicit duplicated CNF under the retained syntax policy. Its multiplicity description is a concise way to verify a fixed counterexample, not permission to count compressed copies as free input or free dynamics. The example disproves a strictly positive pointwise spin-force lower bound at unsolved satisfiable seed states. It does not refute full dissipation coercivity, an integrated bound, or eventual success: auxiliary control may immediately destroy the cancellation. Removing duplicates would alter the tested preprocessing rule.

## Complexity consequences and remaining bridge

If a separate theorem supplied an inverse-polynomial lower bound c(L) for full dissipation until a robust certified witness on every satisfiable input, the inequality c(L)T<=1+log(1+2T/M) would force a polynomial success horizon. That is a legitimate sufficient target. Neither the monotonicity identity nor the examples discharge it. In particular, small gradient, small W, or an accumulated dissipation estimate is not itself a SAT certificate.

The potential range is a scalar analytical estimate, not a computational trajectory-length bound for the full machine. Its logarithm does not silently measure preparation, variable-dimensional ODE evaluation, controller execution, storage or readout. Conversely, the vanishing scale does not establish exponential bit complexity: rho>=1/(M+2T) bounds the inverse scale polynomially at any already-proved polynomial horizon. The earlier uniform bounded-degree simulation argument could be used at such a horizon with an appropriate robust detector; it cannot supply the missing horizon. No direct fixed-dimensional BGP theorem is inferred for this input-dependent controlled system.

A universal satisfiable-input deadline with effective detection would permit rejection of all remaining inputs and would not intrinsically require a separate refutation-certificate system. This draft establishes no such deadline, so its results authorize no arbitrary UNSAT timeout. The restricted growing-family result from the previous increment remains separate.

## Final verdict

GO for the exact global potential, logarithmic dissipation budget, bounded-transform analysis, and both carefully scoped coercivity obstructions. NO-GO for residual-only positive coercivity over all formulas and for spin-force-only positive pointwise coercivity at all unsolved satisfiable seed states. INCOMPLETE for the SAT-restricted full-dissipation or integrated progress theorem, general polynomial-time SAT and P=NP. No mathematical or scope corrections were required after reviewing the saved candidate. This is an informal source/complexity audit, not a Lean formalization or a numerical solver validation.
