# SamplingGuarantee independent non-claims review

2026-09-12. Verdict: **GO-WITH-NOTES**.

Scope: candidate `00ed4a43d429878f53c27dccf68813255961d36e`, namespace
`PvNP.RealizableHardness.SamplingGuarantee`, its Checks module, and
`2026-09-12-realizable-hardness-sampling-guarantee-formalization.md`.
This reviewer did not author these files. This receipt follows the planning
three-lens protocol and the destination `INTEGRITY-CLAIMS.md`. No destination
AGENTS.md was found at the repository root or relevant descendant directories.

## Identity and evidence

Direct SHA256 verification of the working source matched the supplied compiled pins:

| File | SHA256 |
|---|---|
| `lean/PvNP/RealizableHardness/SamplingGuarantee.lean` | `d051a6fdf0eaf06696838e266a340d4616bf4b37dd3594f2015bfbec1b139b76` |
| `lean/PvNP/RealizableHardness/SamplingGuaranteeChecks.lean` | `08effac99e531296d8361e56e4cadbf19b183d3a41a6a5fb77b7e9503f053b97` |

Independent byte comparison after CRLF-to-LF normalization against `git show`
for the candidate returned equality for both source files and the formalization
receipt. The scoped Git diff was empty. Build evidence is the supplied main
session 6278 and corrected Checks session 83651, both exit zero, with 18
standard-only profiles reported in the author receipt. This reviewer read all
18 profile requests but did not rerun the compiler or independently reproduce
those terminal outputs. Historical failed Checks evidence is explicitly
superseded, not accepted as successful validation.

## Claim audit

- The probability is genuinely defined on uniform `SeedArray M b`, containing
  M blocks of b binary digits. `sampleArray` applies the actual bit sampler per
  block. The imported arbitrary-Prop pushforward theorem connects this finite
  seed law to the rounded product law; wording does not replace that law with an
  assumed sampler success contract.
- `originalMean` is the rational event sum over the first S atoms cast to Real.
  The hypotheses require nonnegative masses and cumulative normalization at S.
  No claim about a probability law over later indices follows. The deterministic
  epsilon/8 rounded-mean error and the concentration result combine to bound
  empirical error against this original mean, not merely the rounded mean.
- `Good` universally quantifies over `Fin N -> Bool`. Thus the claimed
  simultaneous coverage of all 2^N assignments, including N=0, matches the
  statement. The error is strictly below epsilon/4. General-M theorems require
  the grid and analytic threshold bounds; chosen-count theorems discharge
  those conditions and give success at least 2/3 and 5/6 respectively.
- The count definitions use real logarithms and ceilings and are noncomputable.
  The receipt expressly excludes exact real-comparison computation and encoded
  polynomial runtime. The rational precision choice does not itself supply
  the missing bit-complexity, enumeration, or machine/tape analysis. Enumerating
  seeds or deciding arbitrary `Good` propositions is probability analysis,
  not asserted execution by the sampler.
- Formula promise preservation, exception repair, NP-hardness, PCP dependencies,
  learning transfer and asymptotic composition are explicitly separate. The
  5/6 confidence reserves a probability budget; it is not a learning theorem.
  No P-versus-NP resolution, new lower bound, novelty, public certification,
  full-goal completion, or uniform polynomial exponent over L is established.

## Notes and acceptance limits

1. The receipt's phrase "least log-6 sampleCount" should be read as the least
   **power of two** meeting the log-6 analytic threshold, as implemented by
   `2 ^ Nat.clog 2 (Nat.ceil threshold)` and the imported `sampleCount_least`.
   It does not mean the least unrestricted natural sample count. This is a
   precision note, not a blocking expansion of the stated probability guarantee.
2. The assertion that no distribution law is supplied as an assumed contract
   means the sampler approximation, product transport, and success estimates
   are proved; normalization and nonnegativity of the input masses remain
   explicit hypotheses. The receipt already lists those hypotheses.
3. This verdict applies only to the frozen candidate above. In particular the
   separate unreviewed `SamplingFormulaPromises` extension and computable-count
   work receive no approval from this receipt, even if present in the worktree.
   Neither S3130 nor the full S3126 goal closes on this review alone.

No blocking non-claims mismatch found. Other independent proof-adversarial and
complexity reviews remain separate requirements. Only this review receipt was
written; no source, compiler artifact, public destination, or commit was changed.
