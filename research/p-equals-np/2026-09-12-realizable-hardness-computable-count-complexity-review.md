# Computable sample count: independent complexity review

2026-09-12. Reviewer `count_complexity_review`, not the author. Candidate `287b4e02997e94eb44572e228d8223f11ba045f4`; main inherited from the earlier `fd834dbc268361483820db17fc36ee25a85575a5` candidate. S3130/S3131 under open S3126.

**Verdict: GO-WITH-NOTES for the bounded computable-count increment.** No false complexity force or blocking quantifier defect was identified in the inspected constructor and theorem statements. This is not certification of an encoded reduction, learning runtime, full NP-hardness proof, or publication readiness.

## Evidence and identity

Read the actual main and Checks modules, imported SamplingThreshold module, pinned Mathlib Nat.clog definition, author formalization receipt, earlier static preflight, INTEGRITY-CLAIMS.md, and planning formal-three-lens closeout protocol. No destination root AGENTS.md exists. This independent lens used source inspection and file/Git identity checks; it did not rerun a compiler or evaluator. Independent proof-adversarial and non-claims lenses remain separate.

Working SHA256 matches the supplied successful-export pins:

| File | Working SHA256 | Git LF SHA256 |
|---|---|---|
| `lean/PvNP/RealizableHardness/ComputableSampleCount.lean` | `cd100cb750324c1d3591f8bc8b6d2546c39614c6ae9fa516e5f53d0d11249a1a` | `d611b5fe4b3770b27aeb05deb690fcc160948b96e6268fea681288cf6c26fac9` |
| `lean/PvNP/RealizableHardness/ComputableSampleCountChecks.lean` | `6d063c574b945cbe25d01ce2b281fd112b732a6038cd3d666d4a723ac2f34ae0` | `282d5a67e260750d27685de1afceed64fb3638f42d8f3d1d7c7ec697081bfee8` |

Both working files equal the candidate Git blobs after CRLF-to-LF normalization. The byte-hash distinction is line-ending normalization, not a changed proof.

The final author receipt records main session 40350 and Checks session 7491 as terminal exit zero, evaluations 512, 2048, 1, and all 17 standard axiom profiles without sorryAx/custom axioms/native_decide dependencies. These are attributed build results, not independent recompilation by this reviewer. The final precautionary stop request returned an already-completed successful run; historical stopped attempts and historical pending text do not negate that final result. The earlier preflight's missing final Checks obligation is therefore resolved by the reported final export on matching bytes.

## Complexity assessment

1. The constructor is exactly `2 ^ Nat.clog 2 (32 * (N + 11) * P^2)`. The pinned clog is terminating recursion on naturals using division of `n+b-1` by b. At base two this requires no real-log evaluation, real ceiling, classical witness selection, or assumed satisfying count. Analytic imports used in proofs do not become computational inputs to count.
2. The exact thresholds are `32*(N*log(2)+log(6))/eps^2` and `32*(N*log(2)+log(12))/eps^2`. The learning upper bound uses log(2)<=1 and log(12)<=11. Positive eps and reciprocal domination justify squaring, giving learningThreshold <= target <= count; base-threshold domination follows. There is no hidden eps<=1 assumption in these new results.
3. For P>0, target>1. The predecessor-clog inequality gives `2^(clog(target)-1)<target`; doubling yields the strict `count<2*target=64*(N+11)*P^2`. This is a factor-two bound relative to the conservative integer target, not relative to the exact real threshold. No assertion of exact real-threshold leastness is warranted.
4. N=0 is supported: count(0,1)=512. P=0 gives count=1 for every N, so the strict upper bound would be false there; the theorem correctly requires P>0. Positive eps and `1/eps<=P` imply P>0, excluding that case from the confidence consequences. The checks also cover count(3,2)=2048 and count(0,0)=1.
5. The numerical tail expressions retain both the two-sided factor 2 and assignment factor 2^N. Log 12 supplies at most 1/6 and log 6 at most 1/3. These conclusions contain no probability event, sampled formula, learner or final reduction success assertion. The same expression satisfying two bounds does not supply two independent failure allowances.
6. Polynomial magnitude in N and P is not polynomial runtime in their binary lengths or the source instance length. Merely outputting count in binary is different from generating count samples. An arbitrary binary P can have exponentially large numerical value relative to its encoding. No source-size-controlled P, support enumeration, rational precision bound, encoded bit-cost model or total-runtime theorem is supplied here. The local computability improvement is real and bounded; it does not discharge those separate obligations.

## Concrete obligations retained

- Instantiate positive eps and a computable reciprocal bound P with numerical size polynomial in source input length, and bound N, support size, rational descriptions, seed lengths and output representation in that same length.
- Preserve fixed-L quantifier order: fix L before choosing the reduction and its polynomial bound; constants and degrees may depend on L. Do not upgrade this to uniform polynomial time when L is part of the varying input.
- Compose this actual count with the sampler/concentration and formula-promise results, then account for sample generation, lookup, rational arithmetic, repair and downstream learning costs. Later composition results require their own review; this count review does not certify them.
- Explicitly reconcile the manuscript's least exact-threshold power-of-two M with this conservative constructor before presenting the computational algorithm. Preserve power-of-two/confidence properties and the size accounting; do not claim equality or leastness without a new proof.
- Record the other independent lenses before bounded route closeout. Keep encoded runtime, upstream hardness/PCP and final learning assembly, S3130/S3131 and full S3126 open until their separate obligations are met.

Only this uncommitted review receipt was written. No Lean source, author receipt, publication artifact, compiler state, or other review was changed.
