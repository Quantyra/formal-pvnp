# Concrete finite-list executable rounding: source draft

2026-09-12, S3131/S3130 under S3126. **UNCOMPILED.** This task authored source only while the codec/encoding compiler remained owned by another agent. No kernel acceptance, runtime result, Git preservation or publication is claimed here.

## Concrete missing operation and reuse

WeightRounding already supplies ordinary computable definitions for rational upward coordinate rounding, the dyadic scale, and the clipped budget. ExceptionRepair and FiniteRepairRoundingPipeline define their generic repaired weights and output functions noncomputably. CMMSAPipelineEncoding materializes semantic outputData from those functions. Merely encoding that semantic record does not establish an executable finite-data reduction.

This module adds a concrete arithmetic path with input `ws : List Rat`, an explicit natural formula count M, and the four scalar fields s, eps, gam, sig. It stores no YES/NO promise, no desired output function and no equality/runtime certificate. It computes lambda, repaired budget, each repaired coordinate, dyadic scale, the finite list of upward-rounded natural numerators, their list-sum denominator, the clipped budget numerator, and the rational output list and budget. Existing ceiling and logarithm arithmetic is reused; no duplicate rounding theory or unary-magnitude encoding was introduced.

The original coordinates occupy the first ws.length positions in their original list order. M separate exception coordinates occupy the second block. The explicit finSumFinEquiv map relates those positions to `Fin ws.length ⊕ Fin M`. Original and exception placement have general pointwise lemmas. The complete output-weight list is proved equal to List.ofFn of CMMSAPipelineEncoding.flatWeights; outputBudget equals the semantic pipeline outputBudget, including clipping. outputData_fields connects both fields to the full semantic pipeline record for every formula family.

All these statements have full proof scripts, but none have been elaborated in this source-only task. API/elaboration repairs may still be required. Source-token scanning found no sorry, admit, native_decide or new axiom declarations; that scan is not a kernel verification.

## Validity, magnitudes and binary wire size

The arithmetic definitions are total even for zero or invalid raw scalar inputs and empty lists. Their equality to the semantic pipeline uses an actual FiniteRepairRoundingPipeline.Parameters proof for the concrete ws.get input. That proof stores original input validity, not a final comparison. Positivity and output-size theorems additionally require M > 0, providing a nonempty formula index type. No empty list is silently treated as a valid normalized positive-weight instance.

positive_integer_data derives a positive common denominator, positive coordinate and budget numerators, and their upper bounds by that same denominator. denominator_bound transports the accepted numeric pipeline bound through the proved equality.

The stronger input-derived path proves 1/q <= q.den for any positive rational q using its positive integral numerator. Consequently the computed denominator is bounded by

    B = 16 * (ws.length + M + 1) * (s.den + sig * gam.den) + (ws.length + M).

This bound is computed from the explicit input fields; no reciprocal-budget or final output-size hypothesis is needed in input_denominator_bound or input_arithmetic_wire_bound. The validity hypotheses remain necessary.

fractionTree serializes each computed numerator and common denominator directly through CMMSAEncoding.natTree. The existing codec accepts positive unreduced fractions, so this wire representation avoids an unproved canonical-numerator growth argument. read_weightTree and read_budgetTree prove exact decoding of the arithmetic fragments. read_semantic_fields then identifies their decoded values with the actual semantic pipeline fields.

For n,d <= B, a fraction tree has at most 8*B.size+3 encoded bits. The actual weight-list fragment has at most (ws.length+M)*(8*B.size+4)+1 bits, and the clipped-budget fragment at most 8*B.size+3. These are genuine binary wire-length expressions using Nat.size, not claims that the numeric value B is the bitlength. They do not bound the full formula payload, input parsing, arithmetic execution time, memory or a Turing-machine simulation.

## Checks prepared, not executed

26 axiom queries, ten kernel examples and three evaluations await execution. The examples include a valid scalar configuration s=1, eps=0, gam=1/4, sig=8 with one original unit weight and one exception coordinate. Hand arithmetic predicts scale 1024, numerators [32,993], denominator 1025 and budget 34/1025. A separate intentionally invalid raw configuration exercises active clipping; empty raw lists exercise totality. General coordinate-order and equality statements are proved in main, rather than inferred from these examples.

The expected evaluation outputs are [32,993], 34/1025 (with Lean's rational formatting), and 32. None are reported as observed.

## Remaining obligations

Compile the exact pair against the finally frozen encoding dependencies; repair any elaboration failures without weakening full equalities; collect actual exits/profiles/evaluations; then perform independent three-lens review with different target authors. The prior proof-review role of this author does not confer independent review on this newly authored module.

This operation handles arithmetic fields only. The actual formula-source list and sampler, input decoding/validation, full per-seed formula construction, semantic-to-wire assembly, and FP proofs for parsing, rational arithmetic, dyadic logarithm, traversal and serialization remain required. Existence of these computable definitions and a binary output bound do not prove polynomial time. Specialized source hardness, final fixed-L composition, learning and full manuscript reconciliation remain open. No novelty or full-paper certification is claimed.

## Exact source snapshot

- `certifications\realizable-hardness\lean\PvNP\RealizableHardness\ExecutableRounding.lean`: SHA256 `a30c477eedce34ee4e041cc2d03b93f452325f272ade4b581d641cf3a0d8d2e4`, 14348 bytes.
- `certifications\realizable-hardness\lean\PvNP\RealizableHardness\ExecutableRoundingChecks.lean`: SHA256 `675a000ad14426e6d3ab27aa5ef9b6bf4caf100943dee9ac7ad537299f4793ba`, 2311 bytes.
