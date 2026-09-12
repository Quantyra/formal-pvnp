# Finite sampling: independent non-claims review

2026-09-12; S3130 under S3126. **Verdict: GO-WITH-NOTES for the bounded
cumulative-rounding/product-law/list-sampler increment.** No blocking
claims defect found. This does not close S3130 or certify concentration,
an encoded randomized reduction, or the full hardness/learning result.

## Scope, provenance and exact pin

Reviewed candidate `62064d9e9699c0337563a31ea205f6e5195fcbc2`: read both
FiniteSampling Lean modules and the complete implementation receipt;
compared public manuscript lines 647-693 and its explicit two sampler
roles. Manuscript SHA256:
`ff00997c8c243e88982c41b0b0e24faaaafe36cec6f1903824599dc242538686`.
The satellite has no AGENTS.md; its applicable claims boundary is
`INTEGRITY-CLAIMS.md`, together with the root-routed three-lens protocol.

The reviewer is an AI agent that did not author this sampling increment.
It authored the separate BernoulliMGF increment; this review does not
independently review that module. No compiler run was duplicated here:
the author receipt supplies reported build evidence and the separately
assigned proof lens performs actual independent verification. This is not
human peer review or a novelty assessment.

Verified working files equal the candidate Git blobs after CRLF-to-LF
normalization. Exact SHA256 pins:

| File | Committed LF SHA256 |
|---|---|
| `FiniteSampling.lean` | `7b1cf53b512e705d08d4eb20a1db69b4015d5fb561f5495e11316c0cfc49ab57` |
| `FiniteSamplingChecks.lean` | `9281576cae367164b01ec09649245ab7e3d91b17e51c531e5be591661a56461b` |
| `2026-09-12-realizable-hardness-finite-sampling-formalization.md` | `eb5897c556a40d4df16f780e95bdf92e985126ee521849a28dbd78b2b885b339` |

The main module's compiled working CRLF SHA256 is
`817347b74cd9f0ad17b5249fcbd03444e9927c492c7e54b5b8e127cf1112b7a6`,
as reported in the implementation receipt. The Checks working hash already
matches Git. The main difference is line endings only, not a code change.

## Wording checked against declarations

1. Cumulative sums, natural-floor cuts, rational rounded cumulatives and
   consecutive atom differences are actual definitions. The error results
   require positive grid size where division matters and nonnegative input
   masses where needed. `mass_sum` separately supplies normalization under
   the finite-support endpoint condition. The receipt does not confuse an
   unnormalized arbitrary function with a probability distribution.
2. `event_error_of_precision` proves the stated eps/8 error for every Boolean
   event under the explicit grid premise. On a normalized finite support
   this controls event-wise statistical distance. It does not implement
   the inverse-CDF algorithm that samples the rounded masses, and the
   receipt explicitly leaves that algorithm and its law open.
3. `trialMass` defines the concrete indexed product mass. Positivity and
   normalization are separately established under their hypotheses;
   `trial_event_factorization` proves every coordinate-cylinder identity.
   Thus finite independence is supported, without an assumed independence
   field. It is not a concentration inequality for empirical averages.
4. `assignment_count` proves the cardinality of actual Boolean assignments.
   A cardinality fact alone does not perform the simultaneous-event union
   bound; no such claim is made in the receipt.
5. `listSampler` uses a binary positional equivalence to address an actual
   materialized list of length 2^b. `listSampler_exact` proves equality of
   event averages and retains repeated entries. This is the final uniform
   list sampler, not the earlier arbitrary dyadic-law inverse-CDF sampler.
   The receipt expressly distinguishes the two.
6. The 19 audit requests and eight concrete support/example results agree
   with the receipt's descriptions. Reported standard axiom profiles are
   not presented as certification of missing concentration or runtime.

## Nonblocking notes to retain

- During evidence integration, label the two main-module hashes explicitly
  as compiled working CRLF and committed LF; the existing source-hash label
  gives the working value but should not be reused as a Git-byte pin.
- Preserve both sampler roles and all input hypotheses when summarizing
  the result. Supply normalized nonnegative finite masses for probability
  language, and materialized indexed entries for the exact uniform sampler.
- Keep the analytic Bernoulli bound, product-MGF composition, two-tail
  concentration, simultaneous 2^N union bound, least power-of-two sample
  size and resulting failure guarantee separate until their actual proofs
  are connected. The receipt's statement that the analytic bound was
  pending records this frozen candidate's handoff status; it is not a
  theorem or an assumed concentration premise in these files.
- Bounded-bit inverse-CDF realization, encoded enumeration/arithmetic,
  input/output sizes and polynomial runtime remain open, as do upstream
  realizability, source NP-hardness, PCP, full asymptotic assembly and the
  exact learning transfer. Fixed-L constants cannot acquire input-length
  dependence in later polynomial-time claims.

These are provenance and assembly boundaries, not required changes to the
reviewed Lean statements. No false full-certification, human-review,
priority, complexity-class-separation or public-release claim was found.
Only this review note is written; no code, other receipt, commit, push or
release is changed. Root must combine the actual three lenses before
accepting the bounded increment, while keeping full S3130/S3126 open.
