# Finite source sampler: independent non-claims review

Date: 2026-09-12. Reviewer: `/root/rounding_nonclaims_review`, neither source author nor repair author. Repository: `C:/Users/Dan/Desktop/Projects/formal-pvnp`. S3130/S3131/S3137 under S3126.

**Verdict: GO-WITH-NOTES for the bounded finite-table bridge.** Independent source review only; no compiler was launched and this report does not replace independent proof verification or complete three-lens acceptance.

## Frozen evidence

Freeze `0ceef848a6adc88f85fa016c34243a4f7d397cb4`; current bytes equal frozen bytes exactly:

| File | SHA256 |
| --- | --- |
| certifications/realizable-hardness/lean/PvNP/RealizableHardness/FiniteSourceSampler.lean | 239ddc6e4fc2171c2882b4d5e753b0306103b6de20a6635ebaa08b7b12add4e1 |
| certifications/realizable-hardness/lean/PvNP/RealizableHardness/FiniteSourceSamplerChecks.lean | f21930d459c1fa38456b90b45220bda73fccd1506f2abce7a305661362335893 |
| research/p-equals-np/2026-09-12-realizable-hardness-finite-source-sampler-draft.md | a0ed2de29996e5eeaa2bc5229cc4038cce5b3ba4192ff078f3e66c946b1c3bf4 |

Read the full pair and receipt, parsed its structured evidence, and inspected actual inherited cumulative/cut, sampler/bitSampler, SeedArray/sampleArray and fromSeeds definitions. The planning three-lens, protocol and claim-boundary-expansion rules read for this review role continue to apply. No source, dependency, Git or public surface was changed; concurrent matrix and port-cycle work was preserved.

All ten portable raw UTF-8 artifacts match their embedded hashes and current disk bytes. Both final source/output/log triples match the author receipt; accepted records are EXIT0 with unchanged sources and no guard stop. Historical exits remain [1,0,0]. The receipt reports sixteen standard-only axiom profiles and eight examples, consistent with the full Checks source and recorded log. No evaluation commands or observed executable sample outputs are present. This is verification of author evidence, not a newly independent compiler result or a fresh transitive build.

## Concrete semantic audit

Table stores an ordered finite list of rational masses and Formula (Fin N), plus ValidRows. ValidRows checks nonempty length, every indexed mass nonnegative, and the exact sum equal to one. It neither renormalizes invalid rows nor assumes strict positivity of every row. readTable accepts already-valid typed rows or returns none. It is not a decoder from a binary string. Variable bounds are already represented by Fin N; arbitrary malformed formula bytes are outside this interface.

The probability extension is the stored mass at each indexed row and zero outside. Normalization required by the inherited selector is proved from the table sum; no arbitrary probability function or desired output is supplied by the caller. The formula extension uses the first stored formula outside support. This fallback is total because the table is nonempty, but select returns Fin rows.length, so selected formulas never reach an outside index. The fallback value itself may equal an ordinary sampled formula; only the outside index has zero mass. Do not call the fallback formula globally impossible.

The exact selection interval is [cut(i),cut(i+1)), where cut is the natural floor of D times cumulative mass. Lower-cut equality belongs to the interval; upper-cut equality does not. Repeated cuts from zero original mass make an empty interval, proving zero-mass exclusion. Conversely, positive mass does not guarantee selection at a coarse finite grid: floor cuts may still coincide. No such guarantee is claimed.

Crucially, this selector samples the inherited rounded grid law, not necessarily the original rational masses exactly. Equality to bitSampler/sampleArray/fromSeeds is pointwise for the same seed interpretation and table extension. Probability/error claims about the original law require the inherited precision assumptions and a distribution on seeds. The current pointwise equalities do not make arbitrary supplied seeds uniform or independent. They do not convert finite precision into exact sampling of every rational distribution.

D = 0 gives no inhabitant of Fin D; select makes no actual zero-domain draw. selectBits instead uses D = 2^b, always positive. At b = 0 the seed domain has one element and selection is deterministic. M = 0 produces an empty output list and is allowed without turning the source table into an empty valid table.

Duplicates remain distinct row positions and repeated trials remain distinct list positions. selected is List.ofFn of the stored formulas indexed by selectArray; selected_length counts M positions, not distinct formulas. No deduplication, independent-draw assumption for arbitrary seeds, or multiplicity-changing set conversion appears.

selectRaw takes List (Fin 2), so digits are already binary. It rejects exactly the wrong-length case and agrees with selectBits on List.ofFn. A malformed numeric digit cannot inhabit Fin 2. This is a typed finite-list length policy, not a machine parser validating untrusted bytes. The source binders consistently tie table length, formula variable count, seed length and trial count to these same inputs; no hidden output-law certificate was found.

## Claims and remaining obligations

Permissible wording: an explicit normalized finite source table supplies the stored probability/formula functions to the existing bounded-seed selector, with exact interval, zero-mass, ordered-output and typed-seed compatibility theorems. The receipt stays within that boundary.

The main and Checks headers still say uncompiled. The receipt explicitly supersedes that historical status with author verification. Update stale headers in a future verified packaging freeze, without changing this reviewed freeze during compilation. This is a conservative documentation note, not a mathematical defect.

The finite table and computable Nat.find selector do not establish FP. A support endpoint bounds mathematical search, but no binary-table parser, rational bit-cost analysis, verified traversal/time implementation, or Turing-machine reduction follows merely from that fact. The table must also be constructed from the specialized source reduction with the necessary encoded size bounds; representing it explicitly does not prove it is polynomial-sized.

Remaining S3126 work includes independent proof and complexity reviews of this pair, connecting selected formulas and executable rounding into the complete per-seed encoded output, confidence/event transport, actual machine/runtime bounds, specialized source hardness and fixed-L composition, the learning theorem, full manuscript reconciliation, and final paper-repository consolidation with a fresh-checkout audit. No novelty, P-versus-NP resolution, full theorem certification or publication readiness is established by this component.

No blocking non-claims defect found. Keep the full certification and submission-quality paper goal active.
