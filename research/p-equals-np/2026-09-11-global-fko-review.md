# Global FKO: independent adversarial and nonclaims review

2026-09-11; S3067. **GO for the exact identities and explicitly unsuccessful certificate derivation.** Reviewed the [main note](2026-09-11-global-fko.md), [source companion](2026-09-11-global-fko-sources.md), existing FKO contract and S3067 planning/frontier scope under [INTEGRITY-CLAIMS](../../INTEGRITY-CLAIMS.md). This is a distinct agent's informal mathematical review, not human peer review, Lean certification, novelty determination or publication approval. No experiment or implementation was performed.

## Exact mathematical content

The operator is the source's rooted refutation operator, including input-dependent diagonal normalization. Direct checking of [Section 9.2, equations 9.3-9.10](https://arxiv.org/html/2607.29672v1) confirms that retained channel count at each row is bounded by its capped diagonal. Therefore the killed walk is a valid substochastic process. The main samples root channels separately, preserving signs and original clause IDs even when parallel channels cancel in the matrix sum.

The signed transition matrix Gamma^(-1) C is similar to the symmetric H. A uniformly started closed-walk sign estimator has expectation tr(H^(2p))/N; killing and nonreturn contribute zero. This is an exact identity for a fixed input and rooting. It requires neither an explicitly stored lifted vector nor a probabilistic assertion about the input. Exact rational sampling is described with expected bit costs and an explicit failure rule if a fixed budget is imposed.

The even-moment inequality bounds the full norm from above. The N factor is retained when converting the normalized trace back to the norm. The Hoeffding radius is appropriate for independent fixed-operator samples in [-1,1]. On the zero-mean observed transcript, the stated sample threshold follows algebraically from requiring the particular upper enclosure to fall below u^(2p)/N. It is a diagnostic for this enclosure, not a distributional sample lower bound for the actual operator or for all estimators. The final note makes that distinction explicitly.

A negative channel-labeled closed walk cancels to a nonempty set of distinct clause IDs with even incidence and odd sign. Each rooted transition uses two clauses, so a 2p-step walk supplies only the bound |T|<=4p. Parallel matrix entries alone would not retain that witness information; the main's channel-level construction does. Positive returns and immediate backtracking do not guarantee a nonempty odd tuple.

## What the identities do not establish

A statistical upper enclosure with error probability delta is not the source's pointwise-sound certificate. Small delta does not make every returned numerical bound valid. This does not rule out randomized decision algorithms with a different contract; it identifies why the proposed samples alone do not meet this selected certificate contract. An independently verifiable certificate could repair that issue, but none is constructed here.

The mean of signed returns supplies no lower bound on negative-return yield, distinct output count, or capacity-normalized tuple mass. The O(n^(1/5) log n) guaranteed support at the stated generic moment order is not an upper bound on achievable packing and does not preclude shorter actual outputs. Useful return frequency, sufficient packing and verified FKO numerical slack remain unproved.

Cheap row access and an inexpensive single walk do not imply inexpensive global trace accuracy or certificate verification. The complete scalar diagonal trace, omitted-edge defect and intersecting-pair contributions remain charged in the target refuter. No reduction of their complexity is claimed. The ordinary norm bound one is sound but does not establish a useful smaller enclosure.

## Source alignment and frontier relevance

The final selected mechanism is the signed return estimator; Krylov is an earlier comparison. The source now distinguishes their output contracts. Return-moment methods have established precedents, and the note does not claim their reinvention as novel. The primary refuter's upper certificate was checked directly; this review does not certify the full external paper proof. The [quantum theorem's stated output](https://arxiv.org/html/2607.29672v1) is detection and weak recovery, not the required pointwise refutation certificate. No quantum implementation or advantage is derived here.

This increment provides an actual global computation and exact extraction identity, then records the failed cost/soundness bridge. It does not simply restate the local capped-policy result, and it does not turn a missing bound into a negative theorem. GO applies to that scoped research record. No improved FKO finder, universal barrier to implicit or quantum methods, general SAT lower bound, P versus NP result, novelty or publishability follows.
