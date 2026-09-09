# Independent proof review: source majorants and packet gates

2026-09-08; S3040 / E004 / S008. Harness only. No OpenCode, formal changes, or commits. Reviewed the source-certificate and packet-gate attempts and their check scripts, with the localized-bit dependency and previous effective proof review.

**Verdict: GO-WITH-NOTES for the explicitly conditional informal results. INCOMPLETE for an effective completed-flow certificate, a realized fluid computer, and the P=NP objective.** No blocking mathematical defect was found in the current bounded claims. These conclusions do not verify the full external blowup proof.

## Primary-source comparison

I directly inspected Appendix B, especially (B.1)-(B.15), of the [primary manuscript](https://cdn.openai.com/pdf/32d9f210-8b73-45e0-91bc-82a30aef8a9a/navier-stokes.pdf). Its pressure datum precedes the axis construction. The draft preserves this dependency and the further parameter thresholds. The actual signed coefficient is zeta=-LH/Q; the draft uses its absolute value, so its estimates are unaffected. No synthetic pressure or arbitrary admissible-looking h becomes a numerical completed field.

The rational tube bounds pass: the closest real point and connecting segment justify the denominator estimate, and the tube is convex. The exponential bound controls both signs of the real primitive, so the stated positive lower datum is valid even after increasing C. Cauchy conversion uses a disk safely inside the tube. The sequence maximum is 9/4. The inverse-series factorial denominators and conservative 80 degree-shift bound give the stated majorant; the center estimate follows. Pressure holomorphy, remainder contraction, outer admissibility and completed tails remain unverified inputs, as disclosed.

## Independent executable checks and their scope

I ran both commands from `C:/Users/Dan/Desktop/Projects/formal-pvnp`:

- `python research/p-equals-np/check_source_coefficient_majorants.py`: PASS for rational triangle and norm-constant arithmetic.
- `python research/p-equals-np/check_packet_gate_margins.py`: PASS for 16 gate corners, four allocation examples, the Taylor write certificate, and all 91 listed small CNFs.

I read both scripts. The source check does not verify contraction or source admissibility. The gate check tests Boolean compositions and error-budget arithmetic; it does not simulate a parabolic equation, implement staged registers or the loop controller, or prove worst-case polynomial runtime. The arbitrary-Q budget is justified symbolically in the note; the four numerical Q values are examples, not its universal proof. The independent mathematical review below supplies the continuum argument rather than claiming the scripts cover it.

## Coupled scalar invariant

The comparison amplitudes use the actual measured commands B_i(s). Consequently command dependence cancels exactly upon subtracting a_i p_i; there is no omitted gate-Lipschitz error in the resulting scalar-error equation. The comparison variables are analysis devices and need not be externally supplied truth registers. Their interval invariance follows from |B_i|<=1.

At a simultaneous first error exit, Q_i eps_i+sigma_i=1/32, and gamma_i eps_i/4 is at least chi_i P2_i/32. On the support of Delta p_i the mask equals one. The feedback and injection terms consume at most three quarters of damping at either signed contact; outside that support the injection consumes at most half. This closes the joint bounded-solution barrier with strict-barrier limits. It does not require positivity of a nonlocal system. Finite species isolation, bounded disturbances, finite-time coefficients and the specified solution class remain assumptions. Pointwise target-error allocation is valid because p_i<=zeta_i.

## Gates, hold and schedule

The gate score margins are correct for all truth-table rows. A valid input differs from its sign by at most 3/32 at the sensor. The smallest two-input pre-saturation margin is therefore at least 13/16, sufficient for exact saturation. A held valid amplitude has its own correct sign as constant target and moves toward that sign; by continuity and the strict saturation margin this is a closed invariant, rather than a circular assumption that the hold stays correct.

During a write, all sources are held and are distinct from the destination. Hence the target remains the exact desired Boolean value even while the destination is invalid. After integrated damping at least four, its error is below 1/16. Sequential induction is sound with the stated staging restriction. An actual compiler must implement COPY and counter updates through fresh intermediate destinations; the abstract existence of such polynomial workspace staging is standard, but the script is not a gate-schedule implementation test.

The finite microprogram constructs formula values from syntax and assignment bits. It does not encode satisfying assignments or truth flags into forcing. Repeating the program 2^n times visits every assignment and gives either answer. Its finite loop/control interface remains an explicitly supplied clock and schedule primitive. Counting its description as small does not prove a cheap execution: the written construction uses exponentially many gate slots, including continuous HOLD on all other registers. The integrated damping calculation follows by summing the slot integrals, and is a model diagnostic rather than a general energy or complexity lower bound.

## Output and communication

The exporter genuinely injects information at one boundary of its stipulated hyperbolic line. Along characteristics, the source accumulation lasts D/v, giving the stated error bound and correct-sign condition. The initial zero line supplies no precomputed answer. Strictly after the propagation deadline the characteristic originates in the driven boundary; no assumption about the discontinuous corner value is needed. Holding the packet valid supplies a constant logical boundary target despite sensor perturbations.

This is an added channel with a maintained emitter, integral transducer, line geometry and receiver. It does not implement packet-wide sensing or finite-speed gate wiring. The source assumption requires normalized sensor error at most 1/64, and therefore the unnormalized error scales with the packet normalization integral. Delay, distributed aggregation and transmission of inputs to a gate must independently meet the scalar disturbance budget; they are not certified here. The cutoff inequality correctly limits the specified fixed-distance, bounded-speed exporter for the stated clock family. It neither rules out all exporters nor guarantees export within the present fluid construction.

## Strain refinement

The symmetric-gradient replacement is valid for Euclidean multilinear operator norms. For the inverse-map derivative the homogeneous evolution acts on input indices; its one-index propagator is bounded by the exponential of the symmetric-gradient norm integral. The skew component contributes zero to the relevant squared vector norms, including the transposed evolution for covectors. Tensor products give the kth power bound.

The Hessian forcing is bounded by ||DL|| ||D2u||; variation of constants yields E_s^2 J2. The third derivative has three Hessian/D2u contractions and one DL/D3u contraction. Integration bounds the quadratic term even by (3/2) E_s^3 J2^2, so the displayed coefficient three is conservative. The global symmetric-gradient bound also controls forward pair separation by integrating along the connecting segment. Thus its substitution in the earlier sufficient packet-size and registration estimates is justified. It remains an upper bound; no actual completed-field strain values, necessary physical costs, or polynomial evaluation theorem follow.

## Remaining obligations

The source note narrows coefficient-majorant debt but does not instantiate a numerical admissible completed velocity. The gate note establishes robust compositional logic only inside its assumed controlled PDE model. Effective source bounds, realizable sensors and actuators, latency, finite-bandwidth switching, geometry, backreaction and readout costs remain open. Above all, no standard-model polynomial-time SAT procedure is supplied. The present exhaustive program is not evidence of P=NP, and its exponential implementation is not evidence of P!=NP. The original objective remains incomplete.
