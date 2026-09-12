ï»¿# Independent complexity review: finite weight rounding

Date: 2026-09-12. Reviewer: root-routed `rounding_complexity_review`, independent of implementation. S3130 under S3126.

Verdict: **GO-WITH-NOTES** for the finite rounding increment. No blocking mathematical or complexity-statement defect found. This verdict does not close the full sampling story or certify the full hardness theorem.

## Reviewed evidence and scope

Frozen candidate: `332c92893aef751fd739d646a1b127f2be34a92a` in `formal-pvnp`. Read both new Lean modules in full, their implementation receipt, and the imported Formula definitions and acceptance-average definitions. Compared with `realizable-cmmsa-hardness/MANUSCRIPT.md`, lines 695-720 (including nearby context). Manuscript SHA256: `ff00997c8c243e88982c41b0b0e24faaaafe36cec6f1903824599dc242538686`.

Verified working contents match frozen Git blobs after CRLF normalization. Committed SHA256:

- WeightRounding.lean: `7060942e670044628284b864dca10d42c49fbc6fae3dc4bf1532a29a448ef863`.
- WeightRoundingChecks.lean: `f2a41e3853d98d13084f0d23c5ff9b052d0167235b23702d019eb76939639f82`.
- Implementation receipt: `b9a6c3983f46ca11258bfd7764dcc52feb4ff4ba76fc1e25fdf3513040cdd14a`.

Read planning formal-three-lens-closeout-protocol.md. No AGENTS.md exists in the destination repository; supplied planning routing instructions govern this delegated review. This lens is a mathematical statement and complexity-boundary audit, not an independent kernel rebuild. Scoped build results are documented by the implementer and independently audited by the separate proof lens. No dependency build, code change, public action, or changes to other evidence files were performed here.

## Construction and statement checks

1. The actual definitions compute positive-domain natural ceilings a(v)=ceil(D*w(v)), sum A, clipped numerator B=min(A,ceil(D*t)+N), and weights a/A and budget B/A. The dyadic scale is a power of two by definition; separate theorems prove its threshold, leastness, positivity and strict upper bound. Natural ceilings coincide with the manuscript's integer ceilings on the required positive domain.
2. The YES proof uses both raw selected weight <= D*t+N and raw selected weight <= A. Thus the min clipping is justified, including active clipping. The assignment and formula family remain literally unchanged. The actual Formula AST has variables and AND/OR with recursive Boolean evaluation and additive leaf count; no satisfaction or leaf-size surrogate replaces these semantics.
3. The NO statement is universal over assignments. The premise is the original universal NO promise, not the desired rounded promise. Cancellation by positive A, raw rounding lower bounds and B/D<=9t/8 give old weight <=9*sigma*t/16<sigma*t. Exact natural division gives floor(sigma/2). Acceptance threshold gam stays unchanged. The statement with any positive natural sigma correctly generalizes the manuscript's larger parameter regime.
4. Positive normalized weights and positive budget at most one are proved separately and bundled in formula_rounding. Common denominator and integral_lengths prove exact numerator identities, including the clipped budget. Bounds on positive numerators imply inverse-denominator lower bounds.
5. The numeric denominator bound is substantive: A<16(N+1)/t+N. The corollary from 1/t<=P gives A<=16(N+1)P+N; from N<=n and 1/t<=(n+1)^k it gives A<=17(n+1)^(k+1). This controls numeric magnitude, which is stronger than merely asserting polynomial bit length, exactly the distinction needed by the manuscript's later string lengths.
6. Concrete examples cover nonintegral ceilings, clipping, a YES assignment and a nonempty NO domain with odd sigma. These help inspect intended interpretation but do not substitute for universal theorem proofs or establish source hardness.

## Nonblocking notes and next composition obligations

- **Upstream bound remains conditional.** The polynomial corollary assumes the reciprocal-budget estimate; it does not prove it for the output of exception repair and preceding sampling/PCP stages. In a family indexed by input length, k must be fixed independently of that input length (it may depend on fixed L). Choosing an arbitrary input-dependent k would not establish a polynomial bound. The current pointwise theorem and receipt make no such family-level claim. Instantiate this explicitly at assembly.
- **Numeric bound is not runtime.** Arbitrary Fintype carriers and rational functions are mathematical data here. Encoded variable enumeration, rational input bit lengths, arithmetic complexity, scale calculation and total reduction time still need an actual computation-model proof. Polynomial output numeric magnitude alone cannot bound time to read an arbitrary input representation. The receipt correctly states this limitation.
- **Instance and YES packaging remains future work.** formula_rounding preserves feasibility of every original assignment, with evaluation unchanged; a full YES existence/all-formulas corollary follows by reusing the original witness, but is not a bundled CMMSA instance reduction here. Empty I is permitted by the local average convention and causes no false local implication; the eventual reduction must supply its required nonempty list and promises. This module does not prove sampling, realizability of upstream outputs, source NP-hardness, or the learning transfer.

These are tracked composition obligations, not reasons to reject this faithful local lemma. No new issue requiring alteration of the frozen code was found. Full S3126 certification and S3130 finite sampling remain open.
