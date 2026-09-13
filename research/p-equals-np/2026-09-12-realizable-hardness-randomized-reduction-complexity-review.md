# Randomized reduction composition: independent complexity review

2026-09-12. S3131 under S3126. **GO-WITH-NOTES for the generic machine composition increment.** This does not establish the paper's encoded CMMSA reduction or full hardness theorem.

Reviewer: `/root/machine_composition_complexity_review`, launched directly by the orchestrator as the complexity-theory lens. I did not author or repair either reviewed module. I read all four source files, the author receipts' narrative and verification appendices, the applicable planning and three-lens protocols, S3131, and the selected source-directed literature note. I inspected the actual pinned library definitions and interfaces below. No compiler, dependency/configuration edit, Git mutation, public action, or nested delegation occurred. Independent kernel replay belongs to the proof lens, not this source review.

## Exact source identity

Frozen commit: `9bcc6cf8eba1dfda445e6f2f082a696bb41a4364`.
All four current source files were checked against their frozen Git bytes and are byte-identical, not merely normalized-text matches. Paths are under `certifications/realizable-hardness/lean/PvNP/RealizableHardness/`.

| Source | SHA256 |
|---|---|
| RandomizedReduction.lean | 4850fbb2452ef9735fc8971d3cc685ff33d0958f11f1d48575e8d3c5d4af3fd4 |
| RandomizedReductionChecks.lean | 7058242ee9ec6be9bbb82fbe5efae72d95e55129b682623b2b2f8b9eb8bc2bfb |
| RandomizedReductionAssembly.lean | 92629ad53d0029e422d75b1637f8e0e33aae052b2a2f36fabdd13c4c01df1f3e |
| RandomizedReductionAssemblyChecks.lean | 05e98f33f401695d500d1302c96ca47c3238b13d18417a35cb63994b11e58730 |

## Complexity findings

1. **Actual machine semantics.** `SeededMap.run_fp` and `ruler_fp` use complexitylib FP, whose definition supplies an actual deterministic TM, all-input computation witness, and asymptotic polynomial bound. `TM.ComputesInTime` requires bounded transition reachability, halting, and the specified output for every raw string. Polynomial normal form replaces the asymptotic clock with an everywhere-valid natural polynomial. The composition API constructs a sequential TM; it does not define FP closure as an axiom or an assumed conclusion. The local `execute_fp` applies pairing, projection, take-length and sequential composition to the actual executor.

2. **Coins and padding are derived.** The ruler's exact length depends only on original input length. Its FP output-length bound yields `coinCount_poly` at every natural length by testing an all-false string of that length. For any first seed bounded by a polynomial a, exact pair length is `2*|x|+2+|u|`. The machine output and second ruler bounds give `B = q.comp (p.comp (2*X+2+a))`. Natural coefficients justify monotonicity. Neither successful first execution nor membership in the intermediate promise is needed. `exists_padding` constructs a polynomial-length FP ruler using `exists_exact_ruler`; the latter builds finite polynomial sums from actual concatenation and length multiplication machines. The noncomputable polynomial certificate does not allow a noncomputable executor: the chosen ruler and composite still carry actual FP machine evidence.

3. **Output-dependent probability is handled fibre by fibre.** A single uniform seed has n+B bits, with n equal to the first map's scheduled count. `block_disintegration` exactly averages over first seeds. For fixed first seed u, y is the actual first output and the second prefix length is `S.coinCount |y|`, bounded by B even when y is outside the promise. `ofFn_prefix` identifies list truncation with the finite-coordinate prefix; `prefix_probability` cancels its unused suffix bits. `execute_disintegration` therefore gives the average of the second map's actual success probabilities on y(u). No independence of the second required length from the first output is presumed.

4. **The probability law and clock concern the same map.** `flatRun` consumes pair(x,w), takes the first n bits and the last B bits using FP operations, and invokes the nested executor. On every correctly scheduled seed, these are exactly the nonoverlapping blocks of w, as proved by `flat_seed_execution`. `compose_probability` applies to this actual `compose` record. `scheduled_machine` then supplies a TM computing its same run function, with a raw-input polynomial clock and a polynomial upper bound in original |x| for every scheduled seed. `exists_preserving_composition` packages one C with preservation, coin bounds, and this clock. There is no separate surrogate probabilistic function or composite FP/runtime hypothesis.

5. **Promise sides and failures remain distinct.** `PromiseProblem` has disjoint string YES/NO sets; `Preserves` quantifies each separately. In the averaging inequality, first outputs in the appropriate middle side get the second-stage guarantee; all other outputs contribute only nonnegative probability. The proof obtains the additive error bound from component guarantees and nonnegative errors, with second-stage error at most one. First-stage errors above one are allowed mathematically and may make the lower bound vacuous; this does not invalidate closure but cannot establish useful hardness. YES and NO errors must each be instantiated with a useful final budget. No behavior on an unpromised source input is asserted.

6. **Malformed strings do not evade runtime accounting.** Pair projections and list operations are total; malformed outer encodings supply an empty second projection, and short supplied seeds are not silently replenished. Their raw execution is covered by the FP clock. The exact uniform probability and original-input schedule statements intentionally quantify seeds of the specified length. They do not assert the same probability law for malformed or arbitrarily long external seeds.

## Imported sources inspected

At the pinned complexitylib source used by the companion (revision `6c248df7859f2f245e731c1e07057bf69d165fe2`): `Classes/P/Defs.lean`, `Classes/P/NormalForm.lean`, `Classes/P/Internal/NormalForm.lean`, `Classes/P/Composition.lean`, `Classes/P/Internal/Composition.lean`, `Classes/P/Pairing.lean`; the relevant take-length, append, output-length and exact-ruler proofs in `Classes/P/Cobham/Internal.lean`; `Classes/Promise/Defs.lean`; the finite probability definition in `Classes/EventProb.lean`; total pair projections and exact pair length in `Encoding/Pairing.lean`; and `Models/TuringMachine.lean`'s transition/halting/output computation definition. This is a focused semantic review, not an independent reconstruction of every transitive machine proof.

The author receipts report four exit-zero target exports, 27 target axiom reports, 15 kernel examples and two evaluations. Their portable provenance explicitly distinguishes freshly recorded dependency output hashes from absent historical per-output hashes. I do not upgrade those author results to an independent build or claim a complete fresh dependency replay. The frozen source headers retain historical UNCOMPILED wording; the appended author-verification sections supersede that status only for author compilation. Final presentation should reconcile those headers after independent verification.

## Remaining full-goal obligations

These are legitimate generic closure theorems, but their component preservation assumptions are not discharged for the paper's actual reduction. S3131 still needs a faithful finite binary formula/positive rational-weight instance codec, malformed-instance policy, actual repair/rounding/sampling FP executor, per-seed equality to the mathematical construction, and explicit output/denominator size accounting. An arbitrary semantic function supplied to an earlier formula construction is not such an encoding.

An actual encoded NP-complete source and specialized outer reduction must supply the component maps and both promise-side guarantees. Deterministic `PromiseHardFor` imported from Promise.Defs is not itself randomized hardness. Final YES and NO error sums must be at most 1/3 for a 2/3 target; composition alone neither supplies that budget nor licenses majority voting on arbitrary output instances. The result uses uniform externally supplied random bits with an actual deterministic seeded executor; it is not a proved transition-level equivalence to a particular probabilistic/NTM acceptance model.

The polynomial witnesses may depend on fixed component machines and fixed paper parameters. Nothing here proves polynomial uniformity when L grows as part of the input, the full specialized PCP/decoder chain, the learning theorem, or a P versus NP consequence. No novelty claim follows from this standard composition mechanism. The increment is useful specifically because it eliminates the formerly separate probability-versus-executor gap; it must now be instantiated with the actual CMMSA construction.

**Closeout:** GO-WITH-NOTES for the stated generic composition scope. No blocking complexity or circularity defect found in that scope. Independent proof and non-claims lenses remain separate gates. S3131 and S3126 remain open; no full-paper or publication readiness is certified here. This newly written review is intentionally left untracked for the orchestrator's exact-scope preservation; pre-existing Transfer and codec work was untouched.
