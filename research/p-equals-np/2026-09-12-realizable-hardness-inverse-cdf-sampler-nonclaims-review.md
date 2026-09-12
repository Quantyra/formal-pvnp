# Inverse cumulative sampler: independent non-claims review

2026-09-12. Reviewer `mgf_nonclaims_review`, not the inverse-CDF module or receipt author. Frozen candidate `d9f42bfef00ae3d9ebd217c33bfb30a2922493ae`; S3130 under S3126.

**Verdict: GO.** No actionable scope or claim-language defect found. This is the non-claims lens, not an independent build or full-goal certification.

## Inspected evidence and identity

Read the actual InverseCDFSampler and Checks modules, author formalization receipt, destination integrity ledger, planning formal-three-lens protocol, and the manuscript's sampling paragraph. No destination AGENTS.md exists. Independently compared binary Git blobs at the frozen candidate with the working sources:

| File under `lean/PvNP/RealizableHardness/` | Git SHA256 | Working SHA256 |
|---|---|---|
| `InverseCDFSampler.lean` | `8350e861d27d1f8c58148bf7656a1f2f467b38403819540eefd065cc6193dad6` | `866f96cbef6b045937cbedbfadc534176aa5376f81a3509205b30806352d2ed4` |
| `InverseCDFSamplerChecks.lean` | `c80b702ae6b568809da803747bd3cff4aae8c22095c5582ab54d75090116a0cd` | `c80b702ae6b568809da803747bd3cff4aae8c22095c5582ab54d75090116a0cd` |

The main working file contains 104 CRLF pairs versus zero in Git. Replacing CRLF with LF makes the entire byte sequences equal. Checks is raw-byte identical. Thus the author's working-source pins identify the reviewed contents correctly; no semantic source drift was observed.

## Claim assessment

The sampler is an explicit least crossing of decidable rational cumulative cuts, with a proof that its index is below S. It does not choose an arbitrary function satisfying a stipulated law. Its `Fin S` output, interval characterization, translated interval/fibre equivalence and cardinality theorem support the claimed actual single-draw rounded distribution. The strict upper endpoint and zero-mass-atom examples match that construction.

`bitSampler` actually maps b binary digits through the existing positional equivalence and that sampler. Its event-law and epsilon/8 error conclusions are exact statements about this function. The receipt distinguishes these semantic bounded-bit results from an encoded machine and rational arithmetic runtime. The construction's normalization-only hypotheses versus the law's nonnegative-mass hypotheses are accurately described.

The general D=0 identity is an algebraic empty-domain identity, not a normalized uniform probability distribution. The receipt explicitly reserves the probability interpretation for D>0 and notes that binary grids are positive. The example evidence is identified as examples, and the 18 named audit targets agree with the actual checks directives. Author-reported kernel results remain separately attributed; this review ran no build.

## Remaining scope

The single-draw law does not by itself establish the joint bit-array pushforward to the rational product trialMass law. The receipt explicitly leaves that bridge pending. Concentration, the sample-count choice, final promise/repair/weight composition, encoded runtime, source hardness, PCP dependencies and learning transfer are not certified by this candidate. A terminating search bounded in atom count does not alone bound bit-operation costs or establish polynomial support enumeration.

The receipt keeps S3130 and S3126 open. It claims no P-versus-NP result, completed hardness formalization, human certification, novelty certification, public release or submission. Its at-least-2/3 sampling reference describes the manuscript's base hardness paragraph, not a claim that the full learning confidence budget has been assembled.

The reviewer separately authors FiniteConcentration, which is not part of this review. No inverse-CDF code, other reviews, shared records, toolchain or remote state was changed. Only this review receipt was authored; no push or release occurred.