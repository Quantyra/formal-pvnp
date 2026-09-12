# S3130 weight rounding: independent non-claims review

2026-09-12. Top-level non-claims lens assigned by root. Candidate commit
`332c92893aef751fd739d646a1b127f2be34a92a`.

**Verdict: GO-WITH-NOTES for the bounded finite rounding increment.**
The source and implementation receipt accurately limit the result to
finite rational rounding and conditional promise preservation. No false
NP-hardness, runtime, sampling, PCP, learning-transfer or full-certification
claim was found. The notes below are assembly/citation boundaries, not
blocking defects in the stated local claims.

## Scope and independence

Read `WeightRounding.lean`, `WeightRoundingChecks.lean` and the complete
weight-rounding-formalization receipt against the frozen candidate.
`git diff` against that commit for all three files was empty. Read the
public manuscript's rational-weight-control construction, lines 695-720,
and its following transition to learning transfer. The manuscript pin is
SHA256 `ff00997c8c243e88982c41b0b0e24faaaafe36cec6f1903824599dc242538686`,
previously independently verified during this reviewer's repair lens.
The inherited non-claims boundary is satellite `INTEGRITY-CLAIMS.md`.

This reviewer did not author the rounding code, checks or implementation
receipt. This is a statement/source/wording review, not a second kernel
build. The receipt's two successful pinned elaborations, six examples and
25 axiom profiles remain build evidence supplied by the implementer and
the independent proof/build lens. No source or public manuscript was
changed by this review.

## Claims checked against the actual statements

| Claim | Evidence and boundary |
|---|---|
| Exact least dyadic scale | `dyadicScale` is `2 ^ Nat.clog 2` of the natural ceiling of the rational threshold. Positivity, lower bound and leastness are actual theorems; upper bound requires `0 < t <= 1`. |
| Actual upward coordinates and clipping | Coordinates, their sum A, and `min A (ceil(D*t)+N)` are definitions. `rounding_complete` uses both the ceiling estimate and selected-weight-at-most-A, so the receipt correctly includes active clipping. |
| Positive normalized weights and valid budget | The named theorems explicitly require the relevant positivity, normalization and positive scale/budget hypotheses. The receipt gives the positive normalized input domain before its table. |
| Exact floor-half and strict NO preservation | `rounding_sound` uses natural `sig / 2` before rational coercion. It assumes the original universal NO promise and proves that same acceptance threshold for every assignment satisfying the rounded budget. The proof does not assume the rounded conclusion. |
| Unchanged formula semantics and leaves | The same indexed `F` and the same assignment are used before and after rounding. No assertion about altered formulas or a different size measure is smuggled into the theorem. |
| Integral common denominator | `common_denominator` provides positive natural numerators bounded by A and rational multiplication identities. `integral_lengths` supplies the identities at every natural multiple of A; it does not encode strings or construct the learning reduction. |
| Numeric polynomial denominator | `polynomial_denominator_bound` explicitly assumes N <= n and `1/t <= (n+1)^k` before proving `A <= 17*(n+1)^(k+1)`. The receipt states this condition and explicitly leaves its upstream instantiation open. |
| Inverse lower bounds | `rounded_lower_bounds` proves weights and budget at least `1/A`; combining this with a polynomial numeric A bound needs the corresponding hypotheses. No unconditional input-size or runtime conclusion is stated. |

## Notes to retain during integration

1. The general local soundness theorem permits positive natural sigma=1,
   hence floor(sigma/2)=0, and arbitrary rational gamma; the formula
   wrapper also does not require a nonempty index type. These are valid
   broader mathematical statements. A complete encoded target-instance
   theorem must restore nonempty indices, threshold in its required
   domain, and sigma at least two when a positive output gap is required.
   The manuscript supplies a larger gap after exception repair. Cite this
   wrapper as weight/budget validity plus conditional preservation, not
   as a complete valid encoded promise-problem reduction object.

2. The polynomial theorem is a concrete numeric inequality with n and k
   arguments. A family-level polynomial bound fixes k and discharges the
   reciprocal-budget premise uniformly over that family. The receipt's
   explicit caveat is accurate; do not drop it in a summary. No theorem
   here establishes rational input bit-cost, output encoding or machine
   running time merely because its arithmetic definitions are concrete.

3. The original NO premise is an input promise, not source NP-hardness.
   The scoped formulas and weights have actual semantics and are not
   True-valued complexity placeholders. Neither a clean axiom profile
   nor these local preservation lemmas proves the upstream PCP/sampling
   construction, asymptotic composition, or HN universal-program transfer.
   The final receipt explicitly says these remain uncertified and leaves
   the full S3126 goal open; preserve that distinction in closeout.

The implementer's table marks the three independent reviews pending and
does not award its own independent verdict. Its test descriptions agree
with the six concrete statements, including nontrivial fractional
ceilings, clipping and odd sigma=5. No unsupported public release or
publication claim is made. Root may close the bounded rounding increment
after recording all required lenses, while maintaining the separate
sampling, encoding, upstream premise and full-certification obligations.
