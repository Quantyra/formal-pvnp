# Independent restricted-simulation scope review

2026-09-11. S3052 / E014 / E004. One independent reviewer applies three lenses under `INTEGRITY-CLAIMS.md`; no experiment or new theorem.

## Independent source check

Read the chosen [Fontana et al. published full text](https://pmc.ncbi.nlm.nih.gov/articles/PMC12098124/), Theorem 1, Corollary 2, Theorem 3 and its proof, and the correlated-parameter discussion. Theorem 1 bounds parameter-space RMSE, not error at every fixed angle, using independent rotations and positive Pauli-noise floor p. Its deterministic cost is O(n^2 m 2^ell). Corollary 2 randomizes the input angles, not a simulator that succeeds on every fixed input. The observable extension retains a coefficient quasi-norm; correlation limitations are already discussed in the source. This is a published May 2025 article despite the DOI's 2024 component.

## Transfer and nonvacuity

**STOP the proposed direct transfer to fixed correlated-angle QAOA SAT-success estimation.** No precise new substantive target has been established by this check. This is a scope failure, not a counterexample to the published theorem or a proof that such simulation is impossible.

- An average over an independent angle cube cannot bound every point on the correlated-angle subspace. Efficiently constructing a landscape does not change the quantifier on its approximation guarantee.
- A global Pauli observable is allowed; nonlocality alone is not the obstruction. A CNF-described SAT projector needs its own coefficient-access and error-cost accounting. Efficient classical checking of sampled bit strings does not automatically provide that representation to this deterministic algorithm.
- The elementary conjunction example has uniform success 2^-n. Constant additive error can admit the zero estimator. Relative accuracy, or additive error small enough to distinguish that probability from zero, needs a different analysis; polynomial dependence on inverse error becomes exponential at that scale. This easy conjunction family is an illustration, not a SAT lower bound.
- The conjunction projector's 2^n Pauli terms alone do not prove hard access: its coefficient l1 norm is one and uniform subset/sign sampling is easy. In the chosen deterministic source bound, however, r=ln(2)/(ln(2)+2p)<1 must not be replaced by one. Its coefficient quasi-norm incurs an exponential factor in that bound. This does not exclude an alternative representation, a randomized algorithm, cancellations or exact computation for the easy example.
- Matching each clause's expectation does not fix the probability that all clauses hold. The two-bit mixture example checks this elementary distinction; unless realized by the specified noisy QAOA family it is not a circuit-family counterexample.
- The circuit/noise compilation must preserve the actual noisy channel, not only the ideal unitary. A vanishing noise floor changes the exponent. Arbitrary Clifford blocks also require efficient descriptions, and numerical/angle precision remains charged.

## Final author review

Read the [source contract](2026-09-11-restricted-simulation-source-contract.md) and [bridge assessment](2026-09-11-restricted-simulation-bridge-assessment.md) in full. Both preserve the exact theorem quantifiers and the distinction between failure of this direct transfer and an impossibility result. The selected noisy target is specified rather than retroactively attached to earlier ideal experiments. The conjunction quasi-norm calculation and two-bit moment example check directly by algebra; no new numerical experiment was necessary.

The important review clarification was incorporated: exponentially many Pauli terms alone do not exclude efficient sampling/access, and the source extension's r<1 quasi-norm cannot be casually replaced with l1. The source's randomness is over angle choices, not independent runs of a randomized fixed-input simulator. Constant-error zero estimates and local-energy statistics are correctly rejected as substitutes for the target probability.

| Lens | Verdict | Scope |
|---|---|---|
| Source/proof | GO for audit; STOP direct transfer | Published theorem and proof dependencies checked. The fixed-correlated-angle target is not certified by the selected average-angle result. |
| Complexity | STOP claimed efficient useful SAT-probability bridge | Representation, precision and noise costs remain unsupplied together; polynomial inverse-error dependence can hide exponential input-size cost. No general simulation lower bound follows. |
| Novelty/non-claims | STOP new project from this gate | The broad correlation issue is already in the source, and elementary examples are not new research results. No precise substantive target, SAT decider or publication contribution was established. |

No successor, simulator, broad survey or proof campaign is recommended. This closes the bounded gate while preserving the earlier construction-specific STOP and publication HOLD.
