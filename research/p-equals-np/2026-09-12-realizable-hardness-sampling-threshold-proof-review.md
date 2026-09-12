# Sampling thresholds: independent proof-adversarial review

2026-09-12. Reviewer `concentration_proof_review`, independently routed by root; not the threshold author. S3130 under the open S3126 goal.

## Verdict

**GO** for the exact mathematical dyadic thresholds and numeric bounds. No actionable proof, hypothesis, leastness, constant, or vacuity defect found. This is not an implemented sampler, probability-success theorem, runtime certificate, or full hardness/learning proof.

## Frozen scope and independent verification

Reviewed candidate `dc660298e98e52ce2fed062791f598b440a63b23`, comprising `lean/PvNP/RealizableHardness/SamplingThreshold.lean`, `SamplingThresholdChecks.lean` and the sampling-threshold formalization receipt. Read actual declarations/proofs, the receipt, integrity and full dependency boundaries, and the manuscript's ln 6 sampling passage and ln 12 learning refinement. The planning three-lens protocol and S3130 requirements were read for the preceding independent concentration review and remain applicable.

Independent raw-byte Git/working comparison found exact equality, not merely normalized equality:

- SamplingThreshold.lean SHA256: `915c257be9470041524b789db87a5de5ef946abe6e452650a02e5efb19b49791`.
- SamplingThresholdChecks.lean SHA256: `559bb713fae0f334e7eee2d467bc8d00d7264fe9913ee8913219017ad1e603cc`.

Independently executed both exact pinned commands sequentially, without dependency rebuilding:

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/SamplingThreshold.olean lean/PvNP/RealizableHardness/SamplingThreshold.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/SamplingThresholdChecks.olean lean/PvNP/RealizableHardness/SamplingThresholdChecks.lean
```

Main session **14771 exited 0** with no output or warnings. Checks session **28119 exited 0** without warnings, printing all **29** profiles: 22 main results and seven examples. Each profile contains exactly `[propext, Classical.choice, Quot.sound]`. No sorryAx or theorem axiom appears. Source inspection found no sorry/admit/native_decide or axiom declaration; this scan supplements actual elaboration and axiom checks.

## Adversarial checks

1. Both counts are actual powers of two, defined using natural ceiling and base-two ceiling logarithm. The lower-bound proof uses real-to-natural ceiling followed by `Nat.le_pow_clog`. Leastness compares against every admissible natural exponent j, not merely an assumed minimizing candidate. Both counts are positive even outside the stronger epsilon domain.

2. Strict count < 2*threshold correctly depends on 0<epsilon<=1. The proof establishes threshold>1, hence positive clog, and shows its predecessor power is strictly below the real threshold via the ceiling equivalence. This handles an exact power-of-two threshold without an off-by-one error. The learning threshold is at least the original threshold and uses the same valid argument. No claim is made that the strict upper bound holds for arbitrary large epsilon.

3. Both confidence numerators have the manuscript constants: N*log 2+log 6 and N*log 2+log 12; the denominator is exactly 2*(epsilon/8)^2. Positive epsilon makes multiplication by the denominator valid. Exponent monotonicity and exact exponential/log identities give factors 1/3 and 1/6 respectively, including N=0.

4. The general constant theorem explicitly assumes C>0, which suffices for exp(log C)=C and reciprocal simplification. It does not silently require C>=1. Values 0<C<1 yield a weaker but still true upper bound 2/C; this is not a probability contradiction because only a numeric expression is bounded.

5. Logarithm upper bounds produce threshold <=32*(N+5)/epsilon^2 and its N+11 analogue. The dyadic factor gives the stated strict numeric upper bounds. Squaring 1/epsilon<=P is justified by positive epsilon and natural P; the final exact casts yield natural bounds 64*(N+5)*P^2 and 64*(N+11)*P^2. The reciprocal-error premise is explicit and has not been replaced by an assumed polynomial runtime claim.

6. The seven examples instantiate zero-variable positivity, a positive-variable threshold, the 2048 numeric bound, both chosen-count confidence constants, and explicit counts with exponential factors -16 and -32. They use kernel proofs and no native evaluator. The general theorems, rather than the examples, establish the universal result.

7. The receipt accurately calls the choices noncomputable mathematical real-log/ceiling definitions. Numeric output bounds do not prove a machine can compute exact transcendental comparisons or enumerate a finite support efficiently. The numeric failure-factor lemma does not assume or prove concentration, independence, or actual sampler success.

## Unclosed composition obligations

The concrete joint seed law and mean-approximation bridge must connect the implemented sampler to the separately proved finite-product concentration theorem. Only then may these numeric factors be applied to the actual bad-event probability and complemented for success. An encoded computable count, arithmetic and support enumeration runtime, upstream reciprocal-error bounds, actual list YES/NO and repair/rounding composition, source hardness, specialized PCP, asymptotics and learning transfer remain separate. Both confidence variants are present here, but HN residual-failure composition is not. Full S3130/S3126 remain open.

Only this proof-review receipt was written during the threshold review; no threshold source, author receipt, other review, concurrent JointSamplingLaw file, index, commit, push or release was changed.
