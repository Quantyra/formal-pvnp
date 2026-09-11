# Restricted simulation: exact source contract

Date: 2026-09-11. S3052, E014/E004. **Selected result: Fontana et al., published Theorem 1. Decision: STOP the proposed direct transfer to fixed-angle QAOA SAT acceptance.** This scope audit supplies no new simulator, theorem, or general complexity implication.

## Source and access pin

Enrico Fontana, Manuel S. Rudolph, Ross Duncan, Ivan Rungger and Cristina Cîrstoiu, *Classical simulations of noisy variational quantum circuits*, npj Quantum Information **11**, 84 (**2025**), [DOI](https://doi.org/10.1038/s41534-024-00955-1). The DOI contains 2024, but the version of record was published 22 May 2025. Use the [published PDF in the authors' institutional repository](https://strathprints.strath.ac.uk/92079/7/Fontana-etal-QI-2025-Classical-simulations-of-noisy-variational-quantum-circuits.pdf), not the older preprint as a substitute. Downloaded PDF SHA256: `b0d00ec906305f932c256a3e9d86fda2db5f00614f5d68ccd30fc985eff62d65`.

Read: definitions Eqs. (1)–(5), process expansion Eqs. (9)–(17), Algorithm 1, Theorem 1/Eqs. (18)–(19), its complete Methods proof Eqs. (33)–(39), and the related observable/parameter restrictions below. Page numbers refer to the printed twelve-page article. The initial DOI request failed at Nature's authentication redirect; direct publisher HTML then loaded, and the institutional PDF downloaded successfully. PMC returned a CAPTCHA. These did not prevent full-text access.

The [arXiv record](https://arxiv.org/abs/2306.05400) still lists only v1, 8 June 2023. A targeted title-plus-correction/erratum search and the accessible publisher record did not reveal an erratum changing this contract; that is not an exhaustive absence claim. The later related [González-García, Cirac and Trivedi full text, arXiv:2407.16068v2](https://arxiv.org/html/2407.16068v2), summary and Sections 5–6, treats additional geometry/noise conditions and worst-case failures. It is not a correction that converts Fontana's parameter-average theorem into an unrestricted fixed-angle guarantee. No second theorem is adopted here.

## The single selected theorem

Theorem 1, p. 5, Eq. (19), includes the short phrase **“m independently parameterised rotations”**. Its exact operational content, with noise parameter renamed eta to avoid confusing it with QAOA depth, is:

For every specified n-qubit circuit of the form

`U(theta) = (product_i C_i exp(-i theta_i P_i/2)) C_0`,

with m independently variable rotation coordinates, initial state `|0>^n`, a specified Pauli observable P, and the stipulated Pauli noise after each rotation, and for every integer cutoff ell, Algorithm 1 deterministically constructs a trigonometric polynomial g satisfying

`Delta = [(2pi)^(-m) integral_[0,2pi]^m |f_noisy(theta)-g(theta)|^2 dtheta]^(1/2)`

`Delta <= (1-2 eta)^(ell+1) <= exp(-2 eta ell)`,

in time `O(n^2 m 2^ell)`, where `eta = min(p_X,p_Y,p_Z) > 0`.

| Contract field | Exact scope and cost consequence |
|---|---|
| Circuit description | Explicit Clifford operations C_i and Pauli strings P_i; arbitrary topology. Clifford updates can use binary symplectic descriptions. The number m counts parameterized rotations, not parallel circuit depth. Reading or constructing the circuit is not a free oracle. |
| Input state | `|0>^n`, with the initial Clifford C_0 allowing stabilizer preparation. Arbitrary input-state access is not granted. |
| Noise | After each rotation, a tensor product of single-qubit Pauli channels acts on its nonidentity support: `N(rho)=(1-p_X-p_Y-p_Z)rho + sum_sigma p_sigma sigma rho sigma`. Probabilities are nonnegative, sum at most one, and known in advance. Theorem 1's simpler model leaves Clifford operations noiseless. Theorems 4–5 address extensions, but are not silently substituted. |
| Noise scale | Fixed eta>0 makes the epsilon exponent a constant. Eta tending to zero is not covered by a noise-independent polynomial bound. Eta=0 provides no decaying truncation-error certificate. The target is the noisy circuit, not its ideal counterpart. |
| Parameters and quantifiers | Circuit structure and P are fixed. Error is averaged over product-uniform independent angles across the full m-dimensional cube. There is no supremum over theta and no average over SAT formulas. One may evaluate g at a selected theta, but the theorem does not certify that selected value. |
| Observable | One specified tensor-product Pauli, possibly acting on every qubit, with norm one. Global support itself is allowed. An arbitrary global Boolean projector is not a single Pauli. |
| Cutoff | ell limits the number of nonzero entries of a frequency/process-mode vector in `{0,+1,-1}^m`. This is not the number of qubits in observable support, a graph degree, or QAOA depth. |
| Geometry/degree/depth | No bounded-degree, planar, or local-observable assumption is needed for Theorem 1. Hence bounded degree does not repair its parameter-average limitation. Runtime grows with the explicit gate description; grouping gates into a layer does not remove their cost. |
| Precision | For 0<epsilon<1, `ell=ceil(ln(1/epsilon)/(2 eta))` suffices, giving `O(n^2 m epsilon^(-ln(2)/(2 eta)))` up to the ceiling factor. This is a sufficient bound, not a lower bound on any simulator. |
| Arithmetic model | The paper counts classical Pauli-frame/path operations and assumes known noise coefficients. It does not supply a complete finite-bit encoding/roundoff theorem for arbitrary real angles and noise. A Turing-machine complexity claim must include their representation, evaluation precision and accumulated arithmetic error. |
| Randomization | LOWESA's construction enumerates surviving branches deterministically. Corollary 2's probability is over random input angles, not internal simulation coins for an arbitrary fixed input. Re-running LOWESA does not turn an uncertified chosen angle into a high-confidence approximation. |

## Proof dependency that blocks angle transfer

The Methods proof, p. 8, first uses product-angle orthogonality, Eq. (34), to turn the squared error into a sum of squared coefficients, Eq. (35). Each nontrivial process mode is damped because its rotation is followed by noise on the relevant support. The noiseless Pauli expectation has magnitude at most one, giving Eq. (39). Deterministic Pauli propagation then bounds the surviving binary tree by the cutoff, yielding the stated runtime.

QAOA uses common beta and gamma parameters across many gates within each layer. Expanding a k-local clause phase into Pauli rotations does not create independent physical parameters. The QAOA parameter manifold has lower dimension than the independent-angle cube; a full-cube L2 bound imposes no pointwise guarantee on that manifold. The source itself explains this problem on pp. 6–7, Eqs. (27)–(28): functions orthogonal under separate coordinates need not remain orthogonal after coordinates are identified. Its repeated-rotation example, Eqs. (29)–(30), already illustrates a zero low-weight reconstruction. Therefore a generic claim that correlation can obstruct this method is not a new research target.

Theorem 5's fixed gates are fixed **random** independent angles and retain a probability-over-angles qualification. They do not authorize adversarial, trained or prescribed angles. Adding a reversible SAT verifier to convert acceptance into one ancilla's measurement introduces further fixed non-Clifford operations, input/workspace and noise-accounting obligations; it does not remove this gap.

## Global SAT acceptance and a nonvacuous error scale

For a CNF F, the desired observable is `Pi_F=sum_{x:F(x)=1}|x><x|`, and acceptance is `a_F=Tr(Pi_F rho_F)`. Estimating a sum of violated-clause expectations is a different task: it does not determine the probability that every clause is satisfied simultaneously. Classical evaluation of F on a measured bitstring is efficient, but this does not automatically provide the Pauli representation required by the selected simulator.

To check the most immediate extension, Theorem 3, p. 6, Eq. (22), and its proof, p. 9, Eqs. (40)–(52), assume `O=sum_i c_i P_i` (identity handled separately) and give the cost factor

`(||c||_r/epsilon)^(ln(2)/(2 eta))`, with `r=ln(2)/(ln(2)+2 eta)<1`.

Replacing that quasi-norm with the l1 norm because r is near one is unsafe for growing observable size. For the elementary conjunction `F_n=x_1 AND ... AND x_n`, `Pi_F=product_i (I-Z_i)/2`. Including identity, it has 2^n coefficients of magnitude 2^-n: l1 equals one, whereas `||c||_r=2^(n(1/r-1))`. Substitution in the displayed source bound contributes 2^n even at constant epsilon; removing identity changes no asymptotic conclusion. This is an obstruction to using that **representation and bound**, not proof that this easy formula or every compactly represented projector is hard to simulate. Efficient coefficient-sampling alternatives would need their own guarantee.

The same width-one, degree-one example supplies a nonvacuity check without any experiment. At zero QAOA angles on `|+>^n`, `a_F=2^-n`; an unsatisfiable formula has acceptance zero. The constant estimator zero meets additive 1/12 on the satisfiable example for n>=4. To distinguish these two acceptance values by additive estimates one needs, for example, error at most `2^-n/3`, not a fixed constant. Plugging such precision into Theorem 1's sufficient cost already produces exponential dependence for fixed eta. This does not assert that conjunction SAT itself is difficult; it shows why constant additive simulation accuracy alone is useless as the proposed general SAT bridge.

A hypothetical all-input SAT circuit with acceptance at least 2/3 on SAT and at most 1/3 on UNSAT would make additive 1/12 informative. No such QAOA promise is established here. If only a randomized fixed-input simulator existed, combining such a hypothetical circuit with it would yield a bounded-error classical decision procedure, not automatically a deterministic polynomial-time one. The present theorem supplies neither the hypothetical acceptance gap nor that fixed-input simulation guarantee.

## Decision

**STOP this direct theorem-transfer candidate.** Three independent requirements are missing: a guarantee on prescribed correlated angles, an efficient treatment of the global acceptance observable, and a useful error scale relative to a demonstrated acceptance gap. Adding bounded graph degree alone supplies none of them. The source already discusses the broad correlation obstruction, so rediscovering it or performing a constant-additive zero-estimator demonstration would not meet S3052's novelty/nonvacuity gate.

No specific new lemma with both credible novelty and a nonvacuous SAT-acceptance target has been isolated in this bounded audit. A future proposal would need to name a narrower circuit family, noise model, input representation, fixed-angle or distributional quantifiers, observable access and signal-dependent precision before another literature gate. This note does not authorize that campaign and makes no P-versus-NP, NP-versus-BQP, general SAT simulation, or impossibility claim.
