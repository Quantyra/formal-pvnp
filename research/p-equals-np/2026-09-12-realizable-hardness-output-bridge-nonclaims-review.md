# Output bridge independent non-claims review

Date: 2026-09-12. Lens: independent non-claims boundary review. Verdict: **GO-WITH-NOTES** for the bounded SamplingFormulaPromises increment only.

## Scope and evidence

Reviewed candidate `66672972b6577eb7058d1da574bf718b115320d3`, the actual main and Checks sources, `research/p-equals-np/2026-09-12-realizable-hardness-sampling-formula-promises-formalization.md`, repository `INTEGRITY-CLAIMS.md`, and the planning formal three-lens closeout protocol. No destination AGENTS.md was present at the repository root. Consulted the relevant SamplingGuarantee, JointSamplingLaw, ComputableSampleCount and FiniteRepairRoundingPipeline definitions to resolve claim scope. This reviewer is not the author.

Observed HEAD equals the candidate. Git diff against the candidate for main, Checks and author receipt is empty. Independently calculated working SHA256 pins match the supplied author pins:

- Main: `5b3be5d6cc5b66c9907855153b7e11c11c43e28fca5feff952ea649de278e941`.
- Checks: `ef50b659f0275a622c0a918c543b0ae6e58fbf47d4da9f6b9edacc225512af06`.

No compiler was launched by this lens. Author sessions 92355/85000, exit zero and 15 standard axiom profiles, are reported author evidence, not independently reproduced build evidence. Checks source contains the 15 corresponding `#print axioms` requests, including duplicate-position and zero-trial examples. This review does not replace independent build/audit or proof/complexity review.

## Source-to-claim assessment

| Boundary | Assessment |
|---|---|
| Actual finite sampling | `sampled` preserves trial indices, including repeated draws; `fromSeeds` calls `sampleArray`, whose coordinates call `bitSampler`. Probability conclusions directly use that same sampleArray construction. There is no source-promise branch selecting a different construction. |
| Fixed inputs and randomness | Parameters, formula family, distribution, dimensions and natural inverse-error bound P are fixed outside the uniform seed probability. The YES source witness is also supplied outside it. No adaptive choice of these inputs after observing seeds is claimed. |
| Distribution and precision | Normalization `cumulative p S = 1`, nonnegativity of p, positive rational epsilon and `1/epsilon <= P` are explicit hypotheses. Precision is the actual rational-ceiling dyadic choice. The probability is a finite uniform count of seed arrays, not an asserted sampling oracle or a probability over all inputs. |
| Deterministic bridge | `empirical_eq_average` identifies the empirical indicator mean with the cast rational formula average. The identity includes zero trials; output implications require positive trial count, supplied by count_pos in the probability specializations. `parameter_margin` derives the strict NO margin from pipeline parameters. |
| YES event | A supplied original assignment with weight at most s and original mean at least `1-eps/4` yields, with probability at least 5/6 and consequently 2/3, existence of a perfectly satisfying output assignment under actual output weights and budget. It does not construct or efficiently find a source witness. |
| NO event | The separate universal original-assignment promise through weight `sig*s` yields, with those same probability bounds, acceptance below `2*gam` for every enlarged output assignment under the actual floor-gap budget. No theorem assumes both incompatible source promises. |
| Probability transport | `computed_event_probability` uses the imported Good-probability theorem at the computable count, then finite event-count monotonicity. Its generic Good-to-event premise is discharged by the deterministic YES/NO implications in the specialized theorems. Neither specialization assumes Good or an external concentration axiom as a new premise. |
| Construction and validity | The formula adds one leaf per indexed sampled formula. Rounded weights, clipped output budget and natural floor gap are the actual pipeline definitions. Parameter validity is substantive and remains explicit. The author's statement that dedicated validity/common-denominator wrappers remain to be assembled does not erase existing pipeline validity results. |

## Notes and acceptance limits

1. ComputableSampleCount supplies the main theorem comparing the learning threshold with the conservative natural count. Its imported main proof is not acceptance of that increment's unfinished Checks or independent reviews. The author receipt explicitly preserves that distinction. This lens does not clear dependency review debt.
2. The natural inverse-error bound P is supplied as input with a hypothesis. A computable numerical count and exact mathematical sampler do not establish polynomial time in a chosen encoded input length. Several semantic output/probability definitions are noncomputable; no executable implementation or bit-complexity certification follows from this receipt.
3. The count used here is conservative, not a proof that it equals the least real-log sample count. Manuscript reconciliation remains open as recorded by the author.
4. Source distribution and weight promises are hypotheses; specialized source PCP hardness, encoding/runtime, asymptotic reduction, and HN learning transfer remain open. No complete realizable-hardness result, full S3126 certification, novelty, P-versus-NP resolution, circuit/proof-system lower bound, or general solver is supported or asserted here.
5. This GO-WITH-NOTES is one scoped review result. It authorizes neither publication nor route-final closure before remaining required lenses and validation. The author's pending-review wording is accurate for its recorded stage and must not be silently promoted to full acceptance.

No blocking wording-to-theorem mismatch found in the reviewed sources and author receipt. Only this review receipt was written; no Lean source, public artifact, Git history, or other receipt was changed.
