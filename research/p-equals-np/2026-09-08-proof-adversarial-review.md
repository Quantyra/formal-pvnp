# Proof-adversarial review: vortex-clock attempt

Date: 2026-09-08. Route: S3040 / E004 / S008.

Verdict: **GO-WITH-NOTES for bounded informal exploration. P=NP verdict: NO-GO / unproved.** No fluid computer, polynomial SAT algorithm, completed-flow retained bit, or computational impossibility theorem has been established. This review does not expand claims and is not a full audit of the external Navier-Stokes proof.

## Scope and independent evidence

Reviewed `2026-09-08-vortex-clock-attempt.md`, `2026-09-08-source-and-method.md`, `2026-09-08-material-carrier-analysis.md`, and `check_vortex_clock.py` in this directory. Read the parent protocol and claim-boundary-expansion protocol. No destination AGENTS.md exists. Worktree inspection showed the shared untracked research directory; it was preserved. This reviewer creates only this file and makes no commit or formal-code change.

Independently inspected the original [analytical manuscript](https://cdn.openai.com/pdf/32d9f210-8b73-45e0-91bc-82a30aef8a9a/navier-stokes.pdf), specifically equations (4.1)-(4.8), Appendix B.1, Lemma 5.1, and Proposition 9.9 Step 5. These confirm the coordinate identities, leading field, axis data, zero positive-order axial traces, and fixed-similarity sampling asymptotic used by the notes. No build or dependency audit of the manuscript's formal counterpart was performed.

## Ideal clock and scalar memory

The integrated clock has the correct sign and normalization. Substituting the stated rational endpoint into the phase recovers M. Differentiating the endpoint function of j gives exactly the displayed gate-gap bounds by the mean value theorem. Fixed q is essential to the polynomial encoding and arithmetic statements. Rational h=a/b instead gives a fixed-degree algebraic endpoint, correctly separated from exact rationality and numerical evaluation.

The timing-bit conclusion is valid for a fixed fraction of an ideal gate duration. It does not bound synchronization errors in an unknown physical controller. The source's sampled angular-rate correction integrates to a bounded remainder for h>0; no moving material particle is supplied by that integration.

For the scalar commanded bit, the worst boundary derivatives of [-17/16,17/16] are inward or zero for either command and any stated disturbance. Piecewise-constant command switches leave the state continuous, so repeated switching does not break forward invariance. Variation of constants supplies the stated overwrite margin independently of the number of slots. The rational exponential bound is conservative and valid. This is a controlled overwrite device, not autonomous programmable logic; the text correctly makes commands, normalized disturbance, gain, phase addressing, and physical realization assumptions explicit.

The total-variation bound follows by adding displacements between successive opposite-target endpoint neighborhoods. It is a lower bound for that coordinate of this prescribed alternating-update model, not a lower bound for all SAT algorithms or devices. The wording preserves that restriction. The finite reserve after M gates establishes available model time only. External transport or later safe readout remains an assumption, as stated.

Reproduced `python research/p-equals-np/check_vortex_clock.py`: exit 0; all ten q/n cases passed; rational endpoint error upper bound 85/568 is below 1/4. The script covers exact example arithmetic, not all-input runtime, physical noise, or the PDE. The general displayed calculus arguments remain necessary.

## Material equations and stability

I rederived the parcel equations from the source coordinate identities rather than treating the carrier note as evidence for itself. Along a leading parcel, the time and axial derivative contributions combine to give the displayed dq/dt and deta/dt. For X, the radial contribution is V0/q; combining the remaining terms and the incompressibility identity cancels 2 eta U and yields X'=XW in the stated rescaled time. The angular exponent is correct because A+1/2=1+h. Off the plane z=0, q must not be replaced by tau; the carrier note correctly retains tau=q(1-eta^2).

The root condition at the axis has exactly one interior solution by strict monotonicity of Hc/d. Its small-j0 expansion has no quadratic term. The root lies between -j0/4 and zero, which ensures the displayed axial derivative is positive. The radial derivative is negative; the two-dimensional Jacobian is triangular because X'=XW. Thus the leading similarity equilibrium is a saddle. The stable eigenvector has nonzero X component even when the axial/radial coupling is nonzero. The on-axis solution cannot be a rotating carrier because its cylindrical angle is undefined. The notes correctly avoid that inference.

The rejection of the exact fixed-X, z=0 material-circle ansatz near the axis is also valid: the two required leading identities have nonzero discrepancies as X decreases to zero. This tests that particular ansatz; it says nothing about all moving trajectories.

## Notes that constrain the next increment

1. A local stable-manifold theorem for the leading smooth system is a plausible next step. Its existence does not produce a robust bit or effective initial data. State a domain-extension or one-sided argument and preserve X>0 at every finite time.
2. Transfer to the completed flow needs uniform estimates along the proposed joint limit X→0 and eta→eta0, in an appropriate normalized norm. A fixed-X estimate at eta=0 alone is insufficient. Dividing radial and angular expressions by vanishing radii needs their smooth factorizations and corresponding remainder bounds. For saddle persistence or stable-manifold construction, derivative control is also needed; pointwise O(q^(2h)) alone is not a C1 estimate.
3. Vanishing positive-order axis traces do not by themselves prove off-axis stability, uniform convergence of all derivative expressions, or effective computation of the summed profiles. Localization must be checked to equal one on the actual candidate path.
4. An unstable direction is a quantitative sensitivity question, not an impossibility proof. For finite horizons, give allowed initialization and forcing errors and output separation. Binary description length alone settles neither realization cost nor simulation cost.
5. The endpoint fast-forward theorem for the enumerator would provide a polynomial SAT decider, but it remains exactly the missing algorithmic content. The converse statement concerns the final answer observable at the completed enumeration budget; it should not be interpreted as a theorem about arbitrary intermediate machine states or arbitrary M. The current wording explicitly scopes it to that observable.

No correction-blocking mathematical error was found in the reviewed bounded derivations. The unresolved carrier transfer, programmable coupling, both-outcome readout, and standard-model polynomial runtime are substantive open obligations, not administrative review debt. No new Lean theorem was introduced, so no new-module build was needed for this informal derivation review.

Remaining work belongs under S3040: completed-flow carrier and perturbation analysis; effective retained-bit/readout construction; programmable logic and forcing compiler; an all-input polynomial bit-time SAT argument. This review does not close the original goal.
