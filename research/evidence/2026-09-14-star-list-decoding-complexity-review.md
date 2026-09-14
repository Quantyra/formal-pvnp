# Star-list decoding: independent complexity lens

Verdict: GO-WITH-NOTES for the finite quantitative decoding component. This is a source and author-evidence review, not a fresh independent build or acceptance of a complete hardness reduction.

## Exact evidence

Reviewed `certifications/realizable-hardness/lean/PvNP/RealizableHardness/StarListDecoding.lean`, SHA256 `244400f8a0d9762b7ee30ed287d92e1a525352e264eb874786a5be7b4a53eec8`, and `StarListDecodingChecks.lean`, SHA256 `f309f94b11a80d777acf8b5d5cf872f6bbb07befa84d4bd8b367f2fe7ab6a1da`.

Under `certifications/realizable-hardness/.lake/build/star-list-decoding-author-20260914/`, the final main record is `1789367400735514700/terminal.json` (SHA256 `4163a05d7bcd0d47e340f2b8306f01265c23b3eed0b8d02a2eacbbf2723ccb09`); Checks is `1789367438150651800/terminal.json` (SHA256 `197018b8e9d37e7c54d03f10d38d0dd2e7306dd1c3438b7eceeed029e9c3f49a`). Both report actual exit 0, unchanged source and no guard stop. I independently rehashed their source snapshots, raw logs and output files against the records. Main raw log is `8a7dc37a373b6659225c3f87a3935475e281efd6cdfcf90328bb40724ac6a3fc`; Checks raw log is `de3209d32895d1c7b80228e3cd1d52d812d5fb14fead16b158598ecb78718377`. Main output is `42c4aeec789971e74051f2f077a90766308d6769acb1f3d7262a27697b0f95ad`; Checks output is `1bbe86b2516780b2c8fc23434c2a7233c7f8e6aeb22d7cdce3356a4f884fb438`.

The logs contain no errors, 19 main diagnostic warnings and zero Checks warnings. There are 20 raw occurrences of `warning:` because one diagnostic hint also says "silence this warning:"; the extra occurrence is not a second diagnostic. All 17 named axiom profiles were parsed from the raw Checks log and compared in order with the actual #print commands, not merely counted. Each contains exactly propext, Classical.choice and Quot.sound. Checks also contains five examples and three checked signatures. These profiles cover the listed intermediate lemmas and final decoding statements, not an unimplemented compiler. The records explicitly retain `diagnostic_only=true` and `new_closure_independently_accepted=false`; this review does not upgrade the author environment or reverify its complete lower dependency closure.

## Quantitative conclusion and normalization

For nonnegative edge masses, rho > 0, and listBudget <= rho, `exists_decoding` constructs an existential global labeling with score at least

`(eventMass(listWitness) - 1/8) / (8*rho)^(m+1)`.

The proof derives the slot-sum mean from actual occurrence weights, applies the 1/8 Markov bound, and uses the finite product-labeling probability and AM-GM bound. It does not assume the desired decoding inequality or a supplied mean identity. If every labeling has score <= zeta and `(8*rho)^(m+1)*zeta <= 5/8`, `witness_mass_le_three_quarters` gives witness mass <= 3/4. The endpoint is non-strict; the contradiction argument would require witness mass > 3/4.

`occurrenceWeight` counts all m+1 slots with multiplicity. With normalized nonnegative p, these weights sum to one. `alphabetMass >= 1` follows from inhabited finite alphabets, so division is justified, and `selectedWeight_budget_iff` proves the actual normalized selected-weight equivalence. The more general core decoding result legitimately does not need sum p = 1: its list budget and event mass use the same finite nonnegative measure. The probability interpretation and normalized variable-weight corollary do require the separately supplied normalization hypotheses.

## Repeated vertices and boundary cases

A single random label is chosen per distinct vertex. `listWitness` requires one coherent global labeling, so contradictory projections at repeated leaves do not acquire artificial independent slot choices. The distinct-support cylinder probability is compared with the larger slot product using positive list cardinalities on the witnessed support. Repeated slots therefore preserve the lower bound rather than introducing unjustified independence. The examples explicitly include a repeated-leaf contradiction.

Empty lists have a total singleton fallback distribution, but cannot witness an edge that uses that vertex; the fallback is not counted as membership in the empty list. Finite inhabited alphabets supply a total global labeling, including empty vertex domains. The slot count is m+1, so m=0 does not create division by zero. Zero edge masses are retained consistently. Individual occurrence weights may consequently be zero; no claim of strictly positive compiler weights follows. The earlier handoff's support restriction is unnecessary for this finite decoding theorem and remains an additional operation if a later compiler demands positive weights.

## Remaining reduction boundary

The implementation does not construct the actual paper game, its projections or its soundness parameter. It assumes the upper bound on every labeling when using the final 3/4 corollary. It does not prove a monotone Formula evaluation identity, resolve empty projection fibres in a syntax without false constants, supply a positive rational weight encoding, or bound formula leaf count or encoded output size. Real-valued finite masses and noncomputable finite label selection are legitimate for this existential lemma but do not certify an executable reduction.

No same-raw-function FP witness, malformed-word behavior, randomized SeededMap/Preserves instance, unconditional source-hardness theorem, or full manuscript theorem is established here. The result supplies a substantive finite decoding component for those later joins; it is not a P-versus-NP result, full Lean certification of the paper, or novelty certification.

I previously reviewed the mathematical handoff and raised its support-order caveat. I did not author this Lean pair. This shared mathematical context is disclosed; this lens checks its complexity scope and actual source/evidence, and leaves independent build/proof and non-claims acceptance to their designated reviews. No source, build, Git or public action was performed for this review.
