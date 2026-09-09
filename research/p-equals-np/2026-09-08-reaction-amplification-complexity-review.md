# Reaction amplification: independent complexity review

2026-09-08. S3040 / S008 / E004. Baseline 8fca568. Reviewed the stable `2026-09-08-reaction-amplification-attempt.md` in full. Harness only; no commits, code changes, simulations or planning edits.

## Constant-gap construction

The finite polynomial system preserves the cube and is globally defined from its exact Boolean initializer. Variation of constants with the positive heat propagator gives u>=h, so the earlier4^(-n) heat lower bound holds at every coordinate at time1 on SAT inputs. The spatially constant logistic comparison is valid for this cooperative finite system. Its value at2 exceeds4/5 with coefficient4n, while the UNSAT zero solution stays zero. This is a genuine nonlinear amplification to a constant coordinate gap, not merely rescaled readout notation.

The comparison, kernel and elementary exponential inequalities are derived directly. No external analog-convergence or complexity theorem is imported. The construction is separate from Navier--Stokes and supplies no physical fluid implementation.

## Preparation and forcing error

The signed-error bootstrap correctly avoids assuming cube invariance for perturbed data. Before an error reaches1, the exact state lies in [0,1] and the perturbed state in [-1,2], giving |4n(1-u-u_tilde)|<=8n. Heat sup contraction and the integral inequality yield exp(16n)(delta+2eta) through time2. The rational budget2^(-32n-4) makes this strictly less than1/16, rules out the first exit and supplies finite-time continuation in the bounded neighborhood.

Adding readout error1/16 gives the stated1/8 upper UNSAT value and27/40 lower SAT value. These are valid constant margins. The preparation and forcing tolerances have only O(n) specification bits, but that fact neither implements nor bounds the physical cost of achieving them across2^n coordinates.

The spatially uniform perturbation of an actual UNSAT family gives the exact logistic formula because diffusion vanishes. Its threshold delta=1/(1+exp(8n)) verifies exponentially shrinking robustness to uniform positive bias. Taking0<delta<1 keeps that run within the cube. This example proves a real preparation-sensitivity phenomenon rather than only looseness of the sufficient Gronwall estimate; it does not prove an exponential bit-precision requirement.

## Energy, trajectory length and dimension

The energy identity has the correct diffusion and reaction coefficients. The maximum of a^2(1-a) on [0,1] is4/27, giving instantaneous normalized reaction contribution at most32n/27 and total through2 at most64n/27. The singleton example actually increases normalized energy from at most1/2 to more than16/25. Thus the amplification is not being called purely dissipative averaging or free physical work.

The full sup derivative is at most2n and its length through2 at most4n. This polynomial full-state length and constant decision gap are genuine mathematical facts. They do not imply standard polynomial-time computation: dimension is2^n, the explicit initializer has2^n entries, and an explicit RHS pass uses n2^n neighbor contributions. The polynomial-size reaction coefficient and cheap local formula do not remove global state or preparation costs. No fixed-dimensional uniformly encoded polynomial-ODE characterization is invoked from this growing-dimensional construction.

## Concrete evaluation test

The time-coefficient recurrence includes the neighbor shifts, linear reaction and quadratic convolution correctly. For the singleton at1^n, coefficients below graph distance vanish. At the first possible degree d, exactly d nearer neighbors contribute their first coefficient1, yielding a_d=1. Therefore a global Taylor polynomial of degree less than n about time0 evaluates to zero at0^n, although the exact time2 output exceeds4/5.

This disproves the specified low-degree global truncation's approximation guarantee. It does not assume convergence of the infinite Taylor series at2, exclude repeated local stepping, or imply that every degree-n representation has exponential size. In particular the same singleton family has the exact n+1-variable Hamming-weight reduction: its coefficients k and n-k count neighbors at the two adjacent levels, and uniqueness preserves the initial permutation symmetry. The special compression is valid and is not extended to arbitrary CNF.

## Final complexity scope

A uniformly polynomial deterministic evaluator of the exact designated coordinate from arbitrary succinct CNF initial data, with additive1/8 error, would decide SAT using the constant gap. The comparison proof and local RHS do not construct that evaluator. Likewise a polynomial norm length or normalized energy bound supplies no free truth-table preparation, reaction control or global readout.

Final verdict: GO for the constant-gap amplifier, explicit signed-error budget, reaction accounting and bounded Taylor/symmetry test. NO-GO for the stated degree-less-than-n global Taylor evaluator on the test family. INCOMPLETE for uniformly efficient succinct evolution/evaluation and general polynomial SAT. The uniform-bias hypothesis0<delta<1 and derivative-defined Taylor coefficients are present in the final candidate. No corrections remain.
