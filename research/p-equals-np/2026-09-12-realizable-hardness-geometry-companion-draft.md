# S3133 geometry companion source draft

2026-09-12. Initial source-only snapshot: all six companion sources were **UNCOMPILED**. Current author status is recorded in the appended checkpoints. This is source synchronization, not a compiler, axiom-audit, independent-review or acceptance result.

## Exact source scope

The six files live in `certifications/realizable-hardness/lean/PvNP/RealizableHardness/`: GrassmannIncidence, GrassmannCounting and TripleRestrictionDimension, each with its Checks module. The separate `certifications/realizable-hardness/geometry-draft-source-map.json` records all original Git blobs, byte/LF hashes, mirrored hashes and ordered transforms. Its per-entry pins are authoritative:

| Pair | Source pin | Source status |
|---|---|---|
| GrassmannIncidence | 3fb16f4508396007d35270b2657c217c75e62de7 | Bounded root4.13 acceptance in563e9b5074e55f3f1063d935d3e46da32c8e778e; does not transfer to companion |
| GrassmannCounting | ebf4d5d21a99c8c5483481219166d0b8b3fe66ce | Uncompiled root draft |
| TripleRestrictionDimension | b5c366b4c0e58403c9023be15a5c07693d5f336f | Uncompiled root draft |

The original dated incidence formalization and three review receipts substantiate its bounded source acceptance. The counting and dimension formalization receipts explicitly record uncompiled drafts. All three Git pins were inspected. None is a companion acceptance receipt.

## Source inspection and preserved goals

The incidence source constructs actual finite advice subspaces, the containing-subspace fibre and nonemptiness under a<=J, the normalized incidence kernel, joint/marginal laws and Bayes conditional including zero-marginal boundaries. Counting keeps the actual independent-frame/span equivalence, exact natural Gaussian cardinality formula including boundary cases, actual contained-subspace equivalence and incidenceCount equality. Dimension keeps the actual retained-coordinate equivalence and exact identity finrank(retained d)+2*dropCount d=3*J, its subtraction form and boundary examples. No hypothesis or theorem body was weakened or replaced.

Pinned4.34 mathlib e06eff5f95374108acfaf19f1ff7473aa7771df2 source inspection found the existing Matrix.GeneralLinearGroup.Card and Data.Fintype.BigOperators import paths. card_linearIndependent retains its global name and finite-field product signature; finrank_span_eq_card, linearIndependent_span, Submodule.finrank_map_subtype_eq, map_subtype_le and comap_map_eq_of_injective remain available. These six sources have no old Basis namespace references or ambiguous bare Vector simp entries. Their existing TripleRestrictionRank dependency now imports Algebra.Field.ZMod in the frozen companion base. No speculative API/proof patch was made. Import closure, tactic behavior and elaboration of these six files remain UNTESTED; source name availability is not compatibility evidence.

The only transforms are explicit line-ending normalization, any separately recorded BOM removal, an UNCOMPILED companion comment on every file, and correction of the incidence status comment. Reconstruction starts with raw Git bytes and applies each literal replacement only when it matches exactly once. All six reconstructions passed byte equality and SHA256 checks. All frozen33 proof hashes remained unchanged.

## Isolation and remaining gates

The frozen base6d7718919d681f57e28559bd0ee584c450cb2446 source-map,33 sources, aggregate, README, configuration and dependencies were not edited. New RandomizedReduction sources were not touched. These six files are excluded from the original aggregate and source-map, so the independent33-module review does not certify them. No compiler, Lake operation, cache work, download, package mutation or root proof edit was performed. Source-only preservation requires a separate exact-eight-path Git grant.

S3133 remains open: actual Gaussian product-ratio estimates, conditioned-law likelihood charging only bad events, probability/tail/Markov exclusions, coupling, mixture reweighting and the posterior/KMS conditioning bridge still require proofs and appropriate concrete hypotheses. These source ports do not establish those bounds, executable enumeration or polynomial runtime, specialized PCP/decoder assembly, the learning transfer, the full hardness theorem or P versus NP. Full dependency-ledger obligations and S3134 covering dependencies remain controlling.

Before acceptance: grant a bounded same-toolchain build; compile exact main/Checks sources with actual diagnostic-directed repairs and axiom checks; then obtain fresh top-level proof-adversarial, complexity and non-claims reviews. No root4.13 olean reuse or transfer of old verification status is permitted.

| Gate | Status |
|---|---|
| Source reconstruction | PASS, six byte-exact declared recipes |
| Companion compile/axiom audit | INCOMPLETE; not run |
| Independent three-lens review | INCOMPLETE; not run |
| Full geometry and hardness assembly | INCOMPLETE; obligations remain |

## Two-module author checkpoint

Initial geometry export failed because the newly added module-doc comment before imports was parsed as a command. All six banners were changed to ordinary comments through declared exact transforms. No theorem/import bytes changed. Retry27400 incidence main/Checks exited0;17 selected profiles are standard-axiom subsets. Counting then exited1 only for missing pinned Mathlib.LinearAlgebra.Matrix.GeneralLinearGroup.Card. Its direct dependencies have artifacts; scoped Card export47511 actually exited0 before this checkpoint was committed. The other four geometry modules remain uncompiled. Source banners preserve their original historical status; the separate map and this checkpoint give current verification evidence. No independent companion geometry reviews have run.

### GrassmannIncidence-1789262911577990800.log

SHA256 `ebfc696168874cd2d17907c9fdfe2c8a1548911d9eaf945872664e1c384f3e0e`.

```text
lean\PvNP\RealizableHardness\GrassmannIncidence.lean:2:0: error: invalid 'import' command, it must be used in the beginning of the file

EXIT 1
```

### GrassmannIncidence-1789262939470968700.log

SHA256 `e04461105a2e034eda158663c5821b27c3864a7c81861a7b7c7576e9b80a5cb0`.

```text
lean\PvNP\RealizableHardness\GrassmannIncidence.lean:64:2: warning: Try this: 
  letI̵

The goal is a proposition, so `let` is preferred over `letI`.
The difference between `let` and `letI` is that `letI` inlines the value.
But this is not relevant for proofs because of proof irrelevance.

Note: This linter can be disabled with `set_option linter.style.haveILetI false`
lean\PvNP\RealizableHardness\GrassmannIncidence.lean:79:17: warning: This simp argument is unused:
  Module.finrank_pi

Hint: Omit it from the simp argument list.
  [apply] simp [Coeff]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`

EXIT 0
```

### GrassmannIncidenceChecks-1789262939470968700.log

SHA256 `68cb4a347ff8b731bb626cb863fcc9040ce16af0804a091427de7568a13c5ec8`.

```text
'PvNP.RealizableHardness.GrassmannIncidence.selected_kept' depends on axioms: [propext]
'PvNP.RealizableHardness.GrassmannIncidence.embed_injective' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannIncidence.embed_mem' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannIncidence.retained_finrank_lower' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannIncidence.fibre_nonempty' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannIncidence.incidenceCount_pos' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannIncidence.kernel_pos_iff' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannIncidence.joint_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannIncidence.kernel_normalized' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannIncidence.prior_normalized' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannIncidence.joint_normalized' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannIncidence.adviceMarginal_normalized' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannIncidence.conditional_normalized' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannIncidence.conditional_formula' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannIncidence.conditional_support' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannIncidence.conditional_ratio' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannIncidence.bayes_joint' depends on axioms: [propext, Classical.choice, Quot.sound]

EXIT 0
```

### GrassmannCounting-1789262939470968700.log

SHA256 `55c99115338b494ef73377e7436ff4b28f542a54c4a8900b8bb6d2efd26eaae5`.

```text
lean\PvNP\RealizableHardness\GrassmannCounting.lean:2:0: error: object file 'C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\.lake\packages\mathlib\.lake\build\lib\lean\Mathlib\LinearAlgebra\Matrix\GeneralLinearGroup\Card.olean' of module Mathlib.LinearAlgebra.Matrix.GeneralLinearGroup.Card does not exist

EXIT 1
```

### Mathlib-Card-1789263038214200400.log

SHA256 `8e3c732ce1a8b24cb9b555ba883cf4bb55690f7de6694f4ad1fc0412508b73b2`.

```text

EXIT 0
```

## Four-module author checkpoint

GrassmannCounting54461 failed on cardinality/cast, natural division orientation/positivity and subtype-map argument inference. Five exact recorded proof-tactic replacements resolved these diagnostics without changing the frame bijection or any theorem statement. Retry19811 main/Checks exited0;21 standard-only selected profiles and all examples passed, including the GF(2)^3 counts of seven lines and seven planes. Incidence and counting pairs are author-green, not independently accepted. TripleRestrictionDimension is next and excluded from this count.

### GrassmannCounting-1789263091501840100.log

SHA256 `45ca140e5f1cb5352e96dc2ea673d15001ae35420e3430532ec0aa41891bdb55`.

```text
lean\PvNP\RealizableHardness\GrassmannCounting.lean:28:2: warning: Try this: 
  letI̵

The goal is a proposition, so `let` is preferred over `letI`.
The difference between `let` and `letI` is that `letI` inlines the value.
But this is not relevant for proofs because of proof irrelevance.

Note: This linter can be disabled with `set_option linter.style.haveILetI false`
lean\PvNP\RealizableHardness\GrassmannCounting.lean:60:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.GrassmannCounting.flatten_surjective`:
  [Finite V]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Finite V] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
lean\PvNP\RealizableHardness\GrassmannCounting.lean:78:2: error: Type mismatch: After simplification, term
  card_linearIndependent ha
 has type
  Nat.card { s // LinearIndependent (ZMod 2) s } = ∏ x, (2 ^ Module.finrank (ZMod 2) V - 2 ^ ↑x)
but is expected to have type
  Fintype.card { v // LinearIndependent (ZMod 2) v } = ∏ i, (2 ^ Module.finrank (ZMod 2) V - 2 ^ ↑i)
lean\PvNP\RealizableHardness\GrassmannCounting.lean:91:2: error: Type mismatch: After simplification, term
  h
 has type
  @Eq ℕ (↑(Fintype.card (Grass V a)) * frameProduct a a) (frameProduct (Module.finrank (ZMod 2) V) a)
but is expected to have type
  @Eq ℕ (Fintype.card (Grass V a) * frameProduct a a) (frameProduct (Module.finrank (ZMod 2) V) a)
lean\PvNP\RealizableHardness\GrassmannCounting.lean:105:27: error: Tactic `rewrite` failed: Did not find an occurrence of the pattern
  frameProduct a a * ?m.33 / frameProduct a a
in the target expression
  Fintype.card (Grass V a) = Fintype.card (Grass V a) * frameProduct a a / frameProduct a a

V : Type u_1
inst✝² : AddCommGroup V
inst✝¹ : Module (ZMod 2) V
inst✝ : Finite V
a : ℕ
ha : a ≤ Module.finrank (ZMod 2) V
⊢ Fintype.card (Grass V a) = Fintype.card (Grass V a) * frameProduct a a / frameProduct a a
lean\PvNP\RealizableHardness\GrassmannCounting.lean:109:2: warning: Try this: 
  letI̵

The goal is a proposition, so `let` is preferred over `letI`.
The difference between `let` and `letI` is that `letI` inlines the value.
But this is not relevant for proofs because of proof irrelevance.

Note: This linter can be disabled with `set_option linter.style.haveILetI false`
lean\PvNP\RealizableHardness\GrassmannCounting.lean:117:18: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
lean\PvNP\RealizableHardness\GrassmannCounting.lean:118:18: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead
lean\PvNP\RealizableHardness\GrassmannCounting.lean:123:50: error: unsolved goals
n : ℕ
⊢ frameProduct n n / frameProduct n n = 1
lean\PvNP\RealizableHardness\GrassmannCounting.lean:124:18: warning: This simp argument is unused:
  Nat.ne_of_gt (frameProduct_self_pos n)

Hint: Omit it from the simp argument list.
  [apply] simp [gaussian]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\GrassmannCounting.lean:139:50: error: Application type mismatch: The argument
  Subtype.val_injective
has type
  Function.Injective Subtype.val
but is expected to have type
  Function.Injective ⇑?m.124
in the application
  Submodule.comap_map_eq_of_injective Subtype.val_injective
lean\PvNP\RealizableHardness\GrassmannCounting.lean:139:2: error: Type mismatch: After simplification, term
  hc
 has type
  Submodule.comap W.subtype (Submodule.map W.subtype ↑Q) = Submodule.comap W.subtype (Submodule.map W.subtype ↑R)
but is expected to have type
  ↑Q = ↑R
lean\PvNP\RealizableHardness\GrassmannCounting.lean:141:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.GrassmannCounting.include_surjective`:
  [Finite V]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Finite V] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`

EXIT 1
```

### GrassmannCounting-1789263185678002300.log

SHA256 `ee4973be1bb7b78e76b7acb96e43b295bf17a68a670a66e2709735dd3da6fe9d`.

```text
lean\PvNP\RealizableHardness\GrassmannCounting.lean:28:2: warning: Try this: 
  letI̵

The goal is a proposition, so `let` is preferred over `letI`.
The difference between `let` and `letI` is that `letI` inlines the value.
But this is not relevant for proofs because of proof irrelevance.

Note: This linter can be disabled with `set_option linter.style.haveILetI false`
lean\PvNP\RealizableHardness\GrassmannCounting.lean:60:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.GrassmannCounting.flatten_surjective`:
  [Finite V]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Finite V] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
lean\PvNP\RealizableHardness\GrassmannCounting.lean:111:2: warning: Try this: 
  letI̵

The goal is a proposition, so `let` is preferred over `letI`.
The difference between `let` and `letI` is that `letI` inlines the value.
But this is not relevant for proofs because of proof irrelevance.

Note: This linter can be disabled with `set_option linter.style.haveILetI false`
lean\PvNP\RealizableHardness\GrassmannCounting.lean:119:18: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
lean\PvNP\RealizableHardness\GrassmannCounting.lean:120:18: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead
lean\PvNP\RealizableHardness\GrassmannCounting.lean:135:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.GrassmannCounting.include_injective`:
  [Finite V]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Finite V] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
lean\PvNP\RealizableHardness\GrassmannCounting.lean:144:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.GrassmannCounting.include_surjective`:
  [Finite V]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Finite V] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`

EXIT 0
```

### GrassmannCountingChecks-1789263185678002300.log

SHA256 `771ae818450b1468478931a4085bce09153db009609c6854f85f5c7781e5f108`.

```text
'PvNP.RealizableHardness.GrassmannCounting.span_flatten' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannCounting.flatten_injective' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannCounting.flatten_surjective' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannCounting.frameEquiv' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannCounting.card_frame' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannCounting.card_internal_frame' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannCounting.card_grass_mul' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannCounting.frameProduct_self_pos' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannCounting.card_grass_of_le' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannCounting.card_grass_of_lt' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannCounting.card_grass' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannCounting.gaussian_zero' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannCounting.gaussian_of_lt' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannCounting.gaussian_self' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannCounting.include_injective' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannCounting.include_surjective' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannCounting.containedEquiv' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannCounting.card_contained' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannCounting.incidenceCount_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannCounting.incidenceCount_zero' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannCounting.incidenceCount_of_lt' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
lean\PvNP\RealizableHardness\GrassmannCountingChecks.lean:50:8: warning: This simp argument is unused:
  Module.finrank_pi

Hint: Omit it from the simp argument list.
  [apply] simp

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`

EXIT 0
```

## Six-module author candidate for independent review

All six geometry modules now have actual author EXIT0 exports. Dimension main67493 passed after the explicit filtered-cardinality sum and summand-parenthesization repairs, preserving finrank(retained d)+2*dropCount d=3*J exactly. Its Checks67493 failed the final concrete dimension-four example. Naming the already-proved mixed drop count solved that goal; Checks93196 then failed only on redundant norm_num. Removing that trailing tactic produced actual Checks46724 EXIT0. The15 selected profiles include axiom-free keptEquiv and14 standard-three profiles. All boundary examples passed. Incidence17 plus counting21 plus dimension15 give53 selected profiles, all standard-axiom subsets. This is author verification, not independent acceptance or full geometry completion.

The six sources are frozen for fresh top-level proof-adversarial, complexity and non-claims reviews. Their leading status comments are historical source-port notices; this checkpoint and separate map record current results. Frozen33 baseline proof/map/aggregate, root4.13 sources, and RandomizedReduction remain untouched. No aggregate expansion, Gaussian ratio/tail/likelihood bridge, runtime theorem or full hardness/learning certification is asserted.

### TripleRestrictionDimension-1789263185678002300.log

SHA256 `0c288b420e1277dd5b704bc51bf4077d31e9130b525f754f83c82f3bffa660e9`.

```text
lean\PvNP\RealizableHardness\TripleRestrictionDimension.lean:62:62: error: unsolved goals
J : ℕ
d : Draw J
⊢ {x | ¬d x = none}.card = ∑ x, if d x = none then 0 else 1
lean\PvNP\RealizableHardness\TripleRestrictionDimension.lean:72:16: error(lean.unknownIdentifier): Unknown identifier `j`

EXIT 1
```

### TripleRestrictionDimension-1789263646367666100.log

SHA256 `8e3c732ce1a8b24cb9b555ba883cf4bb55690f7de6694f4ad1fc0412508b73b2`.

```text

EXIT 0
```

### TripleRestrictionDimensionChecks-1789263646367666100.log

SHA256 `543362eb2b96898fe36e02758570ff77a5d6512378a23ed9305f8c749e0f58d1`.

```text
'PvNP.RealizableHardness.TripleRestrictionDimension.retainedEquiv' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.retained_finrank_eq_card' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.keptEquiv' does not depend on any axioms
'PvNP.RealizableHardness.TripleRestrictionDimension.keptBlock_card' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.keptCoord_card_sum' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.dropCount_sum' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.retained_finrank_add_twice_dropCount' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.twice_dropCount_le' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.retained_finrank_eq' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.dropCount_le' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.dropCount_none' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.dropCount_some' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.retained_finrank_none' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.retained_finrank_some' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.retained_finrank_empty' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
lean\PvNP\RealizableHardness\TripleRestrictionDimensionChecks.lean:34:62: error: unsolved goals
⊢ 6 - 2 * {x | ¬x = 0 ∧ ¬some 1 = none}.card = 4

EXIT 1
```

### TripleRestrictionDimensionChecks-1789263836393551700.log

SHA256 `efb5596d56f8b0951b9a9c470328dec253b8d1672c1994fe0a0ff752a84b38b0`.

```text
'PvNP.RealizableHardness.TripleRestrictionDimension.retainedEquiv' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.retained_finrank_eq_card' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.keptEquiv' does not depend on any axioms
'PvNP.RealizableHardness.TripleRestrictionDimension.keptBlock_card' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.keptCoord_card_sum' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.dropCount_sum' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.retained_finrank_add_twice_dropCount' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.twice_dropCount_le' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.retained_finrank_eq' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.dropCount_le' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.dropCount_none' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.dropCount_some' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.retained_finrank_none' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.retained_finrank_some' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.retained_finrank_empty' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
lean\PvNP\RealizableHardness\TripleRestrictionDimensionChecks.lean:38:2: error: No goals to be solved

EXIT 1
```

### TripleRestrictionDimensionChecks-1789263872080620600.log

SHA256 `9a2f7909287fe3cb583ab2f89537aec9571c7841536169803a9ae02929922452`.

```text
'PvNP.RealizableHardness.TripleRestrictionDimension.retainedEquiv' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.retained_finrank_eq_card' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.keptEquiv' does not depend on any axioms
'PvNP.RealizableHardness.TripleRestrictionDimension.keptBlock_card' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.keptCoord_card_sum' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.dropCount_sum' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.retained_finrank_add_twice_dropCount' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.twice_dropCount_le' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.retained_finrank_eq' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.dropCount_le' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.dropCount_none' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.dropCount_some' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.retained_finrank_none' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.retained_finrank_some' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionDimension.retained_finrank_empty' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]

EXIT 0
```
