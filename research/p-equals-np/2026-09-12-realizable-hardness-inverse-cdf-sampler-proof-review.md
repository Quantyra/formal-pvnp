# Inverse-CDF sampler: independent proof-adversarial review

2026-09-12. S3130 under full S3126. Reviewer: `cdf_proof_review`, independently routed by the orchestrator and not an author of this increment.

## Scope and provenance

Candidate `d9f42bfef00ae3d9ebd217c33bfb30a2922493ae`: `InverseCDFSampler.lean`, `InverseCDFSamplerChecks.lean`, and the inverse-CDF formalization receipt. Read destination README and INTEGRITY-CLAIMS.md and the planning formal-three-lens-closeout protocol. No destination or scoped descendant AGENTS.md was found. No implementation changes, shared-file edits, push, or release were performed.

Inspected the entire two modules, their actual FiniteSampling definitions and supporting event-error/list reindexing proofs, and manuscript lines 647-693. Manuscript SHA256: `ff00997c8c243e88982c41b0b0e24faaaafe36cec6f1903824599dc242538686`.

| Source | Working SHA256 | Candidate Git SHA256 |
|---|---|---|
| `lean/PvNP/RealizableHardness/InverseCDFSampler.lean` | `866f96cbef6b045937cbedbfadc534176aa5376f81a3509205b30806352d2ed4` | `8350e861d27d1f8c58148bf7656a1f2f467b38403819540eefd065cc6193dad6` |
| `lean/PvNP/RealizableHardness/InverseCDFSamplerChecks.lean` | `c80b702ae6b568809da803747bd3cff4aae8c22095c5582ab54d75090116a0cd` | `c80b702ae6b568809da803747bd3cff4aae8c22095c5582ab54d75090116a0cd` |

Both working hashes match the author's receipt. Independent raw-byte comparison proves working CRLF-to-LF normalization equals the candidate Git bytes for both files; the main-module hash difference is solely that normalization. Scoped Git diff was empty.

## Adversarial inspection

- Normalization rules out S=0. The endpoint cut is exactly D and the actual witness j=S-1 puts the least crossing below S. `sampler` uses decidable Nat.find and returns Fin S; its definition does not assume any sampling law or select a function satisfying a law.
- The lower interval bound follows from minimality, including the zero index, and the strict upper bound from Nat.find_spec. Nonnegative atoms supply monotone cuts for the converse interval characterization. No strictly-positive-atom hypothesis is needed.
- The explicit fibre equivalence subtracts the lower cut and adds it back. The final endpoint bounds the inverse seed below D, and both inverse laws are proved. Empty intervals and repeated cuts give empty fibres; a seed on a boundary goes to the next nonempty interval.
- Fibre cardinality is derived from that equivalence. Rational division recovers the actual difference of cumulative rounded masses. At D=0 this is an empty-domain algebraic identity, not a normalized probability distribution; the receipt states that limitation. Binary grids are always positive.
- Event probabilities are sums over actual fibres, with arbitrary Boolean events. Binary sampling uses the actual positional equivalence from Fin b -> Fin 2 to Fin(2^b), followed by this sampler. The eps/8 conclusion follows from the existing proved event-error bound and the explicit grid hypothesis. Neither precision choice nor a runtime certificate is smuggled into the theorem.
- Concrete checks exercise a fractional distribution (1/3,0,2/3), rounded cuts (0,2,2,8), first/boundary/final seeds, the empty middle fibre, fractional fibre cardinality, and a nonzero-precision arbitrary-event example. They substantiate nonvacuity in addition to the general proofs.

No actionable mathematical, hidden-hypothesis, endpoint, or vacuity defect was identified in this bounded increment.

## Boundary for subsequent assembly

This is the single-draw realization step in the manuscript. The actual joint bit-array pushforward to the product trialMass law remains separate, as do simultaneous concentration, sample threshold, final promise/repair/rounding composition, and encoded polynomial-time computation. A computable finite search given rational atoms does not itself prove that support enumeration or atom evaluation has the required input-size bound. No full sampling reduction, specialized PCP theorem, NP-hardness, learning theorem, or P-versus-NP conclusion is certified by this review.

## Independent kernel verification and verdict

Both exact scoped commands were rerun against pinned Lean 4.13.0 and cached imports, without a dependency rebuild:

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/InverseCDFSampler.olean lean/PvNP/RealizableHardness/InverseCDFSampler.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/InverseCDFSamplerChecks.olean lean/PvNP/RealizableHardness/InverseCDFSamplerChecks.lean
```

Independent main session **74394** exited **0**, with no output. Independent checks session **25328** exited **0**, printing all **18** requested profiles. Each profile is exactly `[propext, Classical.choice, Quot.sound]`; no sorryAx, custom axiom, or native-evaluation dependency occurs. The FQNs are the nine general exports and nine concrete checks enumerated in the author receipt, all under `PvNP.RealizableHardness.InverseCDFSampler`. Source inspection found no sorry, admit, new axiom, or native_decide in the candidate modules. The kernel audit, not the scan alone, supports this verdict.

**Proof-adversarial verdict: GO**, solely for the stated inverse-CDF and single-draw binary event-law increment. No blocking or nonblocking defect findings. The remaining assembly obligations above remain open and are not waived.
