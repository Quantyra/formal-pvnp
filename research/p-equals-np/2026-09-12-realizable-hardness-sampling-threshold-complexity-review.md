# Sampling-threshold complexity review

Date: 2026-09-12. Reviewer: `threshold_complexity_review`, independently assigned by root; no authorship of this candidate. S3130 under the open S3126 goal.

**Verdict: GO-WITH-NOTES for the numeric threshold increment.** No blocking defect found. This is not approval of a complete probability theorem, encoded reduction, NP-hardness theorem, or learning transfer.

## Evidence inspected

- Frozen candidate `dc660298e98e52ce2fed062791f598b440a63b23` and its three-path commit scope.
- Full `lean/PvNP/RealizableHardness/SamplingThreshold.lean`, `SamplingThresholdChecks.lean`, and `research/p-equals-np/2026-09-12-realizable-hardness-sampling-threshold-formalization.md`.
- Public manuscript lines 673-684, 733-736, and 772-775, SHA256 `ff00997c8c243e88982c41b0b0e24faaaafe36cec6f1903824599dc242538686`.
- Planning formal three-lens closeout and claim-boundary expansion protocols. No destination AGENTS.md exists at repository root.

Working bytes equal frozen Git bytes exactly for all three candidate files. SHA256 values:

| File | SHA256 |
|---|---|
| `SamplingThreshold.lean` | `915c257be9470041524b789db87a5de5ef946abe6e452650a02e5efb19b49791` |
| `SamplingThresholdChecks.lean` | `559bb713fae0f334e7eee2d467bc8d00d7264fe9913ee8913219017ad1e603cc` |
| Formalization receipt | `085fec553b6a9db227f9d1ee39c55bec77c82732ca829d6e09acb54db09078f1` |

The receipt records author main/checks exits zero and 29 standard axiom profiles. This lens reviewed statements, proofs, and correspondence; it did not rerun a build or independently reproduce those profiles. The separate proof-adversarial lens supplies kernel verification.

## Mathematical and complexity assessment

1. `2 ^ Nat.clog 2 (Nat.ceil threshold)` is the exact least admissible natural power of two. The lower bound and leastness are proved independently of error positivity. Strict doubling bounds correctly require `0 < eps <= 1`, which establishes threshold greater than one and licenses the predecessor-power argument. No nonexistent power `2^(-1)` or ceiling-off-by-one is used.
2. Multiplying the threshold inequality by the positive denominator gives the exponential upper bound. The leading two-sided factor 2 and assignment factor `2^N` cancel against `exp(N log 2 + log C)`, yielding `2/C`. The general theorem needs only `C > 0`: for `C < 1` the logarithm can be negative, but the proof still works and its loose bound greater than 2 makes no probability-confidence assertion. It does not silently assume `log C` is positive.
3. `C=6` yields 1/3; `C=12` yields 1/6. These match the two different manuscript thresholds. The learning count provides a numeric reserve for a separate residual failure at most 1/6; it does not establish that transfer or its joint composition.
4. The count bounds `64*(N+5)*P^2` and `64*(N+11)*P^2` follow from the explicit hypothesis `1/eps <= P`, positivity and the numeric logarithm bounds. This proves a size estimate polynomial in N and P, not automatically in the original encoded input length. No common exponent across varying L is asserted. Fixing L before selecting the reduction and its polynomial is consistent with the manuscript's quantifiers.

## Notes and remaining obligations

- **Encoded computation remains open.** Real.log and Nat.ceil over arbitrary reals are used in explicitly noncomputable definitions. A small numeric output does not certify efficient construction, real comparison, rational bit complexity, or an encoded sampler. To certify the manuscript's exact least count, give an effective method and correctness/runtime proof under its actual rational parameter encoding. Alternatively, a conservative computable dyadic count can support the mathematical reduction after proving the same threshold/size conditions and reconciling the algorithm description; it must not be described as computing this exact least-count definition without an equality proof.
- **Concentration remains separate.** The bounded expression is not a probability in this module. The actual independent sampler, event probabilities, assignment union, distribution-approximation error, and YES/NO promises still have to imply this expression bounds the failure event. A final theorem cannot replace that implication with an assumed failure inequality.
- **Family-level polynomiality remains separate.** Instantiate P by a proved inverse-error bound in the input size, bound N, and account for all seed/output encodings and downstream construction costs. Constants and exponents may depend on fixed L; this module neither supplies nor obstructs that required result.

These notes are already acknowledged in the candidate receipt. No source revision is required for this bounded increment. S3130 and full S3126 remain open; no publication, push, or release is authorized by this review.
