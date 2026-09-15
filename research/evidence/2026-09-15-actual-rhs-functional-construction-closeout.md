# Actual RHS-functional construction certification closeout

Date: 2026-09-15. Certification disposition: **PASS; three-lens GO-WITH-NOTES**. This record binds the frozen RHS-functional increment to a target-fresh Lean build and the completed independent review set.

## Frozen sources

| Source | SHA-256 |
|---|---|
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualRhsFunctionalConstruction.lean` | `A38112D36CED08F6D8AD151D85D08D1140CD8A17D40EFED8DEAB6B25E3100428` |
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualRhsFunctionalConstructionChecks.lean` | `59CD64CCACDE1E2F3BB286A600939187FD5C5DC93024BAB11DBB1F0E1A1DCB9B` |

The certified main source proves four statements:

- `equationVectors_linearIndependent`: equation vectors indexed by pairwise-disjoint, nonempty rows are linearly independent over `ZMod 2`.
- `existsUnique_rhsFunctional`: every supplied row RHS assignment induces a unique linear functional on the equation span of a good three-coordinate question.
- `actual_existsUnique_rhsFunctional`: the corresponding actual occurrence-allocation instance wrapper.
- `equationSpan_finrank_eq_card`: the equation span has dimension equal to the good-question row count.

The construction uses the equation-vector incidence representation, isolates a coefficient at a coordinate in its row, builds a basis from the independent spanning family, and defines the functional with `Module.Basis.constr`. The main source introduces no satisfying-assignment premise or assumed RHS-consistency functional.

## Target-fresh certification

Canonical evidence: `research/evidence/2026-09-15-actual-rhs-functional-construction-fresh-run`.

The certifier seeded a new isolated target from the preceding side-condition certification while excluding every object for the support, span-intersection, finite-source, RHS-functional main, and Checks modules. It rebuilt `ActualStarQuestionSupport`, `ActualStarSpanIntersection`, and `ActualFinite3LinSource`, then compiled the frozen main and Checks modules sequentially with Lean `4.34.0-rc2` and `LEAN_NUM_THREADS=1`. All five stages exited `0`; none of their objects existed in the target before compilation. This is a target-fresh direct-project-dependency rebuild against hashed transitive dependencies, not a from-source rebuild of Mathlib and the complete project graph.

| Module | Source SHA-256 | Object SHA-256 |
|---|---|---|
| `ActualStarQuestionSupport` | `39E6F608A3735BCFB5BBD0F8B5E3A3E875151EAF3A4B74298B2A6063411DAE35` | `8B4A75485327BA8836F8FDB1AB561ACD15DB816E8C7C16084C58DCEA0B9461FF` |
| `ActualStarSpanIntersection` | `F3CE6ED0BF8FB9164F16EB846A3378FD2F3471016ECE35F5DB8C091E967042A5` | `DECC2EAA887AC7C8C1DB4F121FC0B5A9BA03369FA191E1DE6B7CCA3FCE748DBD` |
| `ActualFinite3LinSource` | `3109F8B0078B7F6253110ED2C39FC85935268768AB0A0A6B9CDA2F029B8B761F` | `72FE7300086DFB3B13844319C75725AC16032C3413699F20810B2282C6235F48` |
| `ActualRhsFunctionalConstruction` | `A38112D36CED08F6D8AD151D85D08D1140CD8A17D40EFED8DEAB6B25E3100428` | `9A8526B28F205FD8153F9E43FB3A36DF374E6BADB4F7091C9C9721AFDA9D650F` |
| `ActualRhsFunctionalConstructionChecks` | `59CD64CCACDE1E2F3BB286A600939187FD5C5DC93024BAB11DBB1F0E1A1DCB9B` | `C46CFA10CD02A6F1E32B5B8F3B0AF359C413577D17633DD2BD1D05CB389636FF` |

The 36-row evidence manifest has SHA-256 `6DCE57B5372EEEEA857AC23C93662F5B6B64F7ABF520CCBE40BEC33C93163E3C`. Independent post-run rehash found `0` missing, malformed, size-mismatched, or hash-mismatched artifacts. The source-before and source-after inventories match. The dependency seed manifest is `BEEE1C6CF087AF09448E2A93AC698F3BAF25E5C41E29BF7BADB83D029B04EC6C`; the 2,816-record output inventory is `96CD63A912E973E93E19D1BAC4863AA21CA48D7B7801AD99336B7018A7F5C6C2`.

The source scan found no `sorry`, `admit`, `native_decide`, `span_induction`, or explicit `axiom` declaration. `#print axioms` reports exactly `[propext, Classical.choice, Quot.sound]` for each of the four theorems. Lean emitted only unused-section-variable linter warnings: one in the new linear-independence theorem and three inherited warnings across the rebuilt support and span modules. There were no errors and no Checks warning.

## Fixtures and claim boundary

The Checks module exercises a concrete one-row actual instance with RHS `1`, so the existence/uniqueness wrapper is tested on a nonempty equation span. It also exercises the empty-question case. These fixtures check elaboration and theorem use; they are not exhaustive semantic tests.

This increment constructs and uniquely characterizes the equation-span RHS functional and certifies the expected dimension. It does not construct the coordinate-space functional, extend either functional to a common ambient space, prove label gluing or transport, establish star acceptance or clique stationarity, assemble the randomized reduction, formalize outer hardness, prove the manuscript headline theorem, or establish a result about `P` versus `NP`.

The immediate consumer is specialization of the already-certified side-condition agreement theorem with this constructed equation-span functional. The remaining local route is:

```text
constructed unique rhsFunctional
  -> specialize side-condition agreement
  -> coordinate-space extension and gluing
  -> minimal label transport
  -> actual star acceptance and stationarity
  -> reduction assembly and quantitative consumers
```

## Three-lens review

All required top-level lenses reviewed source commit `0ae4103373c1848a8ed6980cbca63784ab3a7025`, the frozen source hashes above, and the target-fresh certification. Each returned **GO-WITH-NOTES**.

| Lens | Verdict | Review artifact | SHA-256 | Material notes |
|---|---|---|---|---|
| Proof-adversarial | **GO-WITH-NOTES** | `research/reviews/2026-09-15-actual-rhs-functional-construction-proof-adversarial-review.md` | `E9DCD2806678C233FA6CDEE9796950AABF2A7A762338EF7F87A72DDF49152118` | No proof gap, signature drift, hidden assumption, false uniqueness scope, or certification defect found. The global `hthree` premise and unused second `GoodQuestion` conjunct are conservative; a two-row fixture would strengthen interface coverage but is not required. |
| Complexity theory | **GO-WITH-NOTES** | `research/reviews/2026-09-15-actual-rhs-functional-construction-complexity-theory-review.md` | `8521714903294C75D057F0122E5DF6EAF8ADF5285326FA6062C1D6FADA014879` | The equation-span functional obligation is closed. The construction is noncomputable and provides no FP/runtime claim, source satisfiability, coordinate extension, star acceptance, stationarity, or hardness result. |
| Non-claims boundary | **GO-WITH-NOTES** | `research/reviews/2026-09-15-actual-rhs-functional-construction-nonclaims-review.md` | `8D7D8843DBF0DB55552B6E004288A7A5549E306A416ED5B8F259B8A8741832C4` | The accepted claim is limited to the unique RHS functional on the equation span and its dimension. Coordinate-space uniqueness, label transport, star construction, reduction, NP-hardness, manuscript completion, novelty, and P-versus-NP conclusions remain prohibited. |

The review set accepts this as the canonical completed RHS-functional construction obligation. Its immediate consumer is a composition theorem that instantiates the already-certified side-condition agreement with `actual_existsUnique_rhsFunctional`; that consumer must separately construct the permitted coordinate-space or ambient extension and retain its generally nonunique boundary. The remaining route is still:

```text
constructed equation-span RHS functional
  -> specialize side-condition agreement
  -> coordinate-space extension and gluing
  -> minimal label transport
  -> actual star acceptance and stationarity
  -> reduction assembly and quantitative consumers
```
