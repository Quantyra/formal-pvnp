# Executable rounding: independent complexity review

2026-09-12. S3131/S3137 under S3126. Independent top-level source reviewer `/root/cmmsa_encoding_complexity_review`. I did not author ExecutableRounding. I read the full final main/Checks and author appendix, actual semantic pipeline equalities and codec interfaces, and the original dependency-copy preparation and runner. This is the complexity lens only; the independent compiler/proof lens must be a separate reviewer. No compiler or Git mutation was performed for this review.

**Verdict: GO-WITH-NOTES for actual finite arithmetic, semantic equality, and arithmetic-fragment binary output bounds.** No full FP reduction or paper certification follows.

## Identity and evidence

Author freeze `6ec557d61ccfc0603aff59c9dbcf2e8672c531ad`. Current bytes and frozen Git blobs were checked directly, with exact LF equivalence required for all files.

| Artifact | Current SHA256 | Frozen SHA256 | Comparison |
|---|---|---|---|
| ExecutableRounding.lean | `306c0c17d14e706e98e1b0cec9b5bdc54d59c2649bd0abe0b09de523210fb28e` | `306c0c17d14e706e98e1b0cec9b5bdc54d59c2649bd0abe0b09de523210fb28e` | raw identical |
| ExecutableRoundingChecks.lean | `e81b713dfa09aa5733c69dc9924bca417d19fd92faac59f8326842692a2abcf7` | `e81b713dfa09aa5733c69dc9924bca417d19fd92faac59f8326842692a2abcf7` | raw identical |
| 2026-09-12-realizable-hardness-executable-rounding-draft.md | `ec21a89b31e185770e8f41d47ea12cebeb7de11ba4a2b45954e14a70f3a2be29` | `ec21a89b31e185770e8f41d47ea12cebeb7de11ba4a2b45954e14a70f3a2be29` | raw identical |

The appendix reports actual author exits zero for both final modules, 26 standard axiom profiles, ten examples and three evaluations [32,993], 34 / 1025, and 32. Those outputs correspond to preserved executable checks, not replacements for the general theorems. The initial UNCOMPILED comments and original hashes are historical; the appendix supersedes author status, while independent verification remains separate. Failed/heartbeat attempts remain recorded. This reviewer did not rerun them or infer success from an interrupted observation.

## Actual operation and semantic correspondence

InputParameters contains only s, eps, gam and sig. The raw function inputs are an explicit weight list and a natural occurrence count M; there is no desired output function, promised YES/NO outcome, asymptotic certificate, or semantic-equality oracle stored as data. inputOf forgets the original semantic validity proofs and copies the four scalar values.

The definitions compute the actual repair lambda and budget, original and exception coordinate weights, dyadic scale, positive upward-rounded integer numerators, their sum, clipping before division, and the resulting rational list and budget. They reuse the existing ceiling and logarithm arithmetic. Every one of the M exception coordinates retains its index, and original coordinates retain their order through finSumFinEquiv.

The equality chain covers each computed numerator, the complete common denominator, the clipped numerator, all output weights in their actual order, and the budget. outputData_fields connects both arithmetic fields to the actual CMMSAPipelineEncoding outputData for every formula family. It does not prove or claim that this module computes the formulas themselves. These are full input-parametric equalities, not extrapolations from example executions.

The semantic parameter proof used in correctness statements expresses input validity and numerical repair constraints; it does not assume the output equality or a final preservation conclusion. M>0 is explicit where nonempty formula indices and positive integer output data are needed. The raw functions remain total for empty/invalid data by the underlying total rational and natural operations. Totality does not make those invalid outputs valid CMMSA instances, and the module does not define the full malformed-input policy of the eventual reduction.

## Binary-size audit

The computed denominator has a transported numerical bound. More strongly, inverse_le_denominator proves 1/q <= q.den for positive rational q from its positive integer numerator. Hence the final input-derived bound uses only

    B = 16*(length(ws)+M+1)*(s.den + sig*gam.den) + length(ws)+M.

The input_denominator_bound and input_arithmetic_wire_bound theorems require actual input validity and M>0, but no separately supplied reciprocal-budget or output-size premise. B is a natural magnitude; the wire theorem correctly uses B.size as its binary length measure.

The wire representation serializes computed natural numerators and the common denominator directly as unreduced binary fractions. The codec permits that representation and its parser equality proves exact rational interpretation. Thus there is no hidden assertion about the size of a canonical reduced output numerator or denominator. Positive_integer_data ensures that all emitted numerators and the denominator are positive and at most B. Each fraction occupies at most 8*B.size+3 bits; the explicit weight-list fragment occupies at most (length(ws)+M)*(8*B.size+4)+1 bits. The budget has the same per-fraction bound. Those statements refer to actual emitted trees, including list overhead.

These are substantive output-size results, but they do not yet express total output size as a polynomial in the final source tape length. A proof must relate scalar bit sizes, weight-list size and M to that source encoding. In particular a natural M supplied in binary cannot be freely enumerated in polynomial time without proving its value is bounded appropriately. The numeric B may be exponentially large while B.size remains modest; confusing the two would invalidate a later runtime argument.

## Remaining full-goal obligations

1. Integrate the concrete sampled formula list, actual repaired formula payload and arithmetic fragments into a total encoded per-seed output tape, proving equality to the existing semantic record and promise events.
2. Define the source tape format and validity/malformed-input policy; prove rational arithmetic, dyadic scale, list traversal, serialization and sampling belong to the required machine-time class. Lean computability, a few successful evaluations and a binary output bound do not establish FP.
3. Bound the complete formula payload, coordinates, occurrence count, seed length and every numerical parameter in terms of encoded source length for each fixed L; then connect to the same machine used in randomized composition.
4. Complete the specialized PCP/decoder/source-hardness and learning chain, full parameter assembly, independent build/other lenses, manuscript reconciliation and finalized proof consolidation with fresh-checkout verification. No complexity-class separation, novelty or publication-readiness claim is supported by this component.

## Prepared independent verification handoff

Prepared but did not execute two scripts for the distinct proof reviewer:

- C:/Users/Dan/AppData/Local/Temp/executable_rounding_independent_prepare.py, SHA256 `61b1f80ad9d7920653abd72dda1fa13fc6860a8b2e4d876326e057a48ac37bc9`.
- C:/Users/Dan/AppData/Local/Temp/executable_rounding_independent_runner.py, SHA256 `71e6d8be3ee8cc3ecbddaba8bebb5e653a6725a172dbfcbc160dd63bbaa861a8`.

They prepare a fresh executable-rounding-independent-review-20260912 root from the original nineteen accepted exports listed by the pinned CMMSA verification receipt, checking each original/copy hash. The runner pins the manifest, eleven package revisions, compiler version and exact current target hashes; uses one Lean thread and the 768 MiB preflight / 640 MiB physical-memory stop guards; records raw logs and actual exit metadata before UTF-8 display; and retains all ten examples and three evaluations. Both scripts were syntax-checked only. The proof reviewer must inspect and run them under the root's exclusive compiler handoff and independently record the actual result.
