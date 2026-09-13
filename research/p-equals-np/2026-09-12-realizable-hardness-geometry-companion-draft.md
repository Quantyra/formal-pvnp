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
