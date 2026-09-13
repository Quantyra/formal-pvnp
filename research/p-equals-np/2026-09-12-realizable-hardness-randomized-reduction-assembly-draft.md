# S3131: exact randomized assembly dependency audit

2026-09-12. Source-only audit in formal-pvnp under S3126/S3131. No compiler, Git, accepted-source edits, public action, or new Lean certification. Destination AGENTS.md remains absent; companion instructions, the S3131 randomized-reduction-semantics story and full dependency ledger were inspected.

The existing RandomizedReduction pair remains UNCOMPILED. Its source already derives the nested-pair executor's FP membership, an actual polynomial-clock TM, and output-dependent second-stage coin padding from component FP witnesses. Repeating those definitions or adding another assumed Preserves wrapper would not advance the missing probability/machine connection. No new RandomizedReductionAssembly Lean file is claimed by this audit.

## Precise remaining probability interface

For existing SeededMaps R,S and fixed input x, put n=R.coinCount(|x|), y(u)=R.apply x (List.ofFn u), and k(u)=S.coinCount(|y(u)|). Choose B independently of u with k(u)<=B for every n-bit u. The existing `second_coin_padding` derives such a polynomial B from the actual component machines; it need not be postulated in the eventual composite-map constructor.

The missing exact theorem is the following identity for every target language T:

    eventProb {w : Fin(n+B)->Bool |
      execute R.run S.run S.ruler
        (pair (pair x (List.ofFn (blockFst n B w)))
              (List.ofFn (blockSnd n B w))) in T}
      = (sum u : Fin n -> Bool,
           S.successProbability (y(u)) T) / 2^n.

Here `S.successProbability y T` denotes `RandomizedReduction.successProbability S y T`, not a new semantic object. The executor already truncates the B-bit suffix to `(S.ruler y).length=k(u)`. What is not proved is that this output-dependent prefix still has the exact uniform k(u)-bit distribution after conditioning on the actual first seed u. This is the substantive probability bridge.

The ingredients already exist in pinned complexitylib: `Classes/EventProb.lean:232` has constant-fibre ignored-bit cancellation; line270 has independent block event probabilities; line220 has finite partition disintegration. `Classes/FiniteCounting.lean:100-134` defines the exact block equivalence/projections/concatenation. These suffice to prove the identity by first partitioning on u, then cancelling B-k(u) ignored bits separately on each fibre. A direct application of block independence with a single fixed second predicate is insufficient because k and y depend on u.

The necessary list bridge must be explicit: the list prefix used by `execute_pair` must equal `List.ofFn` of the corresponding finite prefix restriction, including k=0 and k=B. This avoids substituting an abstract random-seed projection for what the existing machine actually consumes. Do not repeat SeedEncoding's already accepted generic array/prefix counting results as though they resolved this dependent executor identity.

From this identity, component YES/NO guarantees can compose separately. If stage-one error is e1 and every correctly classified intermediate output has stage-two error at most e2, with 0<=e1,e2<=1, composite success is at least (1-e1)(1-e2), hence at least 1-e1-e2. Out-of-promise intermediates contribute only nonnegative probability. This does not authorize majority-voting arbitrary output instances, nor reinterpret randomized preservation as deterministic PromiseProblem.MapReducesPoly.

## Machine connection and the first implementable source task

The lowest independent prerequisite is the dynamic-prefix identity above, followed in the same new `RandomizedReductionAssembly.lean/Checks` source task by an actual flat-input executor. Existing machine primitives permit it; no new codec choice is needed for this generic composition.

The flat executor consumes `pair x w`. Its first seed is the prefix of w selected by R's actual ruler on x. Its second block is the last B(|x|) bits, implemented as reverse/take/reverse using an exact FP polynomial ruler. For correctly scheduled seed length n+B this suffix is precisely the independent second block; on malformed or short inputs the total pairing/take operations specify behavior. Nest the resulting pair and invoke existing `execute`.

Use `Classes/P/Cobham/Internal.lean:431` (`exists_exact_ruler`) for B, line166 (`takeLenFn_mem_FP`) for both slices, existing `reverse_mem_FP`, machine-backed pair/projection/composition, and line145 (`appendFn_mem_FP`) to construct the total coin ruler of length R.coinCount(|x|)+B(|x|). The first ruler is already FP in SeededMap. Derive the output-dependent bound via `second_coin_padding` and `SeededMap.coinCount_poly`; do not assume final polynomial coin or runtime bounds. Relate the raw paired input length `2*|x|+2+n+B` to the original input with the resulting polynomial schedule. The exact successful-seed execution identity must connect this machine to the displayed probability theorem before claiming a composite SeededMap preservation theorem.

Suggested Checks: no first coins, no second coins, output-dependent k taking two distinct values, k=B, ignored suffix bits, a failed/out-of-promise first output, malformed input and a short flat seed. The existing RandomizedReduction pair must receive scoped author compilation before this extension can be compiled; its lack of acceptance is recorded, not treated as a mathematical obstruction to drafting the extension.

## Why this still cannot instantiate full encoded CMMSA hardness

The concrete missing constructor is visible at `SamplingFormulaPromises.lean:98`: `fromSeeds` takes an arbitrary function p:Nat->Rat, an arbitrary formula function F:Nat->Formula(Fin N), and a normalization proof, then returns a finite indexed family. `Formula.lean:6` supplies a semantic inductive tree with arbitrary variable type. Neither interface is a finite binary CMMSA input record with total parser, nor an FP encoded executor. `SamplingFormulaPromises.lean:167,184` prove actual finite YES/NO output probabilities, but contain no encode/decode or FP theorem.

The subsequent faithful codec task should define a finite input record containing binary-indexed variables, a finite list of the existing Formula trees, explicitly encoded positive rational coordinate weights and thresholds, with bounds validating variable indices. Required first bridge: total `decode : Bits -> Option Instance`, `encode : Instance -> Bits`, and `decode (encode I)=some I`, plus an explicit malformed-input policy for the executor. Arbitrary binary magnitudes must not silently expand into unary enumeration. A machine theorem must then identify each seeded encoded output with the encoding of the actual repair/rounding/sample construction and derive length/runtime from encoded bit length. Without it, specializing generic R,S to CMMSA would merely assume the missing algorithm.

Finally, the source of hardness must be an actual encoded NP-complete language and the specialized outer reduction, not a supplied source promise named NP-hard. The dependency ledger lines39 and87 require fixing sufficiently large L before selecting the machine and polynomial. Neither the semantic formula bounds nor polynomial dependence on unencoded cardinalities proves that fixed-L binary-input claim. The dynamic-prefix task above is executable now; the encoded constructor and specialized outer reduction remain the exact downstream boundaries.
