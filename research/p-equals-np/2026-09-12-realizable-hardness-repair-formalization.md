# Finite exception repair: first formal increment

2026-09-12; S3126 / S3127 / E004 / S008. Kernel build green; awaiting three-lens review.

## Scope

The target is the explicit-list exception lemma in the published informal manuscript, not the complete hardness theorem. The full-goal obligations and dependency boundary are in [the formalization ledger](2026-09-12-realizable-hardness-lean-dependency-assessment.md). No imported PCP or hardness assertion is introduced as a Lean axiom, and the repository's True-valued complexity stubs are not used.

`lean/PvNP/RealizableHardness/ExceptionRepair.lean` defines finite Boolean acceptance averages over indexed lists, rational assignment weights, per-index exception coordinates, the exact output coordinate weights and semantic repair. Its intended theorem chain proves witness repair, universal NO preservation, exact coordinate-sum agreement, positivity and normalization of the output weights, and basic budget bounds.

`lean/PvNP/RealizableHardness/Formula.lean` defines an actual positive-variable AND/OR syntax, evaluation, leaf occurrence counts and variable renaming. The repaired formula on `Sum V I` is the old formula renamed into `V` OR the fresh coordinate for its index `i`. Repeated formula values retain distinct indexed exception coordinates. Its completeness and soundness theorems specialize the semantic construction; the latter uses the natural-number quotient `sigma / 4`, implementing the exact manuscript floor. The leaf theorem counts precisely one extra occurrence.

The universal NO statement is an explicit *input promise*, not an axiom. The theorem constructs a promise transformation from that input. It does not assert that its source instances are NP-hard, encode a polynomial-time reduction, prove denominator bit bounds, supply the sampling step or discharge any PCP interface.

## Exact correspondence

| Manuscript | Formal object / obligation |
|---|---|
| Indexed nonempty explicit list | finite index type `I`, with `Nonempty I` where fractions must be normalized; specializes to `Fin M` with M positive |
| Acceptance fraction | `average` is the rational sum of Boolean indicators divided by `Fintype.card I` |
| Original weighted assignment | `weight` is the finite sum of selected rational coordinates |
| Raw exception mass lambda/M | `repairedWeights` on the right summand; `repairedWeight_eq_sum` identifies the complete cost |
| Enable failed indices | witness in `exception_completeness` is the Boolean complement of original acceptance |
| New floor gap and strict 2 Gamma threshold | `Formula.repair_sound` with natural sigma/4 and strict rational NO comparison |
| One new leaf | `Formula.leaves_repair` |
| Normalized positive weights and feasible budget | `repairedWeights_pos`, `repairedWeights_sum`, `repairedBudget_pos`, `repairedBudget_le_one` |
| Polynomial output/rational bit complexity | Still missing; not inferred from noncomputable finite sums or existence proofs |

## Verification and review

All three scoped files were compiled successfully, sequentially, using the repository-pinned Lean 4.13.0 and actual generated local module exports:

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/ExceptionRepair.olean lean/PvNP/RealizableHardness/ExceptionRepair.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/Formula.olean lean/PvNP/RealizableHardness/Formula.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/Checks.olean lean/PvNP/RealizableHardness/Checks.lean
```

Each command exited zero. The initial Lake dependency trace rebuild was stopped after discovering that the pinned dependency exports already existed; the commands above perform actual kernel elaboration of the new files, not a textual source scan. No toolchain or mathlib version was changed.

`Checks.lean` prints 13 scoped axiom profiles. The two formula evaluation/leaf identities depend only on `propext`. The other audited theorems depend only on `propext`, `Classical.choice`, and `Quot.sound`. No proof placeholders, new axiom declarations or native evaluation are used. Genuine one-coordinate YES and NO promise examples also compile, so the scope is not only an empty-index or inconsistent-budget calculation.

The semantic NO theorem allows nonnegative rather than strictly positive old weights, arbitrary positive `sig`/`gam`, and any nonnegative rational `k <= sig/4`. This stronger local algebraic version is specialized by `Formula.repair_sound` to natural `sig >= 8` and its exact floor; output validity uses the separate positivity/normalization and budget theorems. The manuscript's `gam < 1/2` ensures the output threshold domain and, with its other assumptions, implies `eps <= 1` for the budget bound. This increment does not package these facts into a runtime-certified reduction object.

 Three-lens review must be launched by the root orchestrator after build green; no lens is claimed complete here. Shared `PvNP/Audit.lean` and existing claims manifests are untouched. Root authorized a scoped local build-preservation commit after final green, with all three reviews still pending; unrelated work is preserved.

## Remaining full-goal work

The local proof does not complete Part 1. Required next formal work includes encoding/runtime for the finite construction, finite sampling and simultaneous concentration, normalized denominator rounding, exact randomized many-one and NP-hardness semantics, all modified-PCP interfaces and proofs (posterior, rank, vector advice, total tables, threshold ladder and decoding), star compilation, fixed-parameter asymptotics and the bounded-advice learning transfer. The authoritative ledger assigns these separately and distinguishes existing library structures from proved end-to-end contracts. The submission-quality paper is Part 2 and must accurately reflect this remaining formal gap.

## Three-lens status at implementation handoff

| Lens | Status | Evidence |
|---|---|---|
| Kernel build / scoped axiom audit | GO | All three commands above exit zero; 13 standard-foundation-only profiles |
| Proof-adversarial | Pending root review | No reviewer verdict claimed by implementer |
| Complexity | Pending root review | Full reduction/runtime/PCP obligations remain open |
| Non-claims | Pending root review | Local lemma only; no full-certification wording |

Root was notified after actual green and explicitly authorized the scoped local preservation commit, with review pending. No shared Audit file, existing claims manifest, remote, release or public manuscript was changed by this increment.

## Frozen source hashes (compiled working CRLF bytes)

- ExceptionRepair.lean SHA256: `0e19aecf40ebbb828a7558e9411c1a485c698a009979ce9c359788e4d143bded`.
- Formula.lean SHA256: `a78a9462a39732bd05fd7977b21d6be55572de6043b3c366a6f128b283b89f04`.
- Checks.lean SHA256: `dc1cc30706645db8a9023c5a2b5cc6bd53b01bf363b48314c525f07702cc6597`.

Git normalizes these working CRLF files to LF. Independently checked that replacing CRLF by LF yields the committed bytes exactly; there is no semantic/text change. Committed LF SHA256 pins:

- ExceptionRepair.lean: `fe61a92953532bafc86f07dbb3f24fc43bc43bda6389518819da804b12189d4e`.
- Formula.lean: `ab893de33e2e52b337195add1bb317a9f69ccce9ba1bd972df934005257b5a00`.
- Checks.lean: `213d25d9ee18a5edae005fbd1b25afba15f94ef36f6347d403d5cfcf340e851b`.

## Completed bounded closeout: S3127

2026-09-12. The handoff status above is historical. All three independent
top-level lenses have now reviewed the exact implementation commit
`1693d167b1e3e23b229ac4c70418c0fead54798a`:

| Lens | Actual verdict | Evidence |
|---|---|---|
| Kernel build / scoped axiom audit | GO | Implementation commands above; proof reviewer independently re-elaborated all three sources and observed all 13 axiom profiles |
| Proof-adversarial | GO | [Full proof review](2026-09-12-realizable-hardness-repair-proof-review.md); no source correction requested |
| Complexity | GO-WITH-NOTES | [Full complexity review](2026-09-12-realizable-hardness-repair-complexity-review.md); future valid-instance assembly, encoding/runtime, bit-size/denominator and hardness obligations retained |
| Non-claims | GO | [Full non-claims review](2026-09-12-realizable-hardness-repair-nonclaims-review.md); wording bounded by the actual finite repair declarations |

S3127 is completed as the bounded finite indexed rational weighted semantic
repair and positive AND/OR formula increment. The source files retain every
compiled working and committed normalized hash listed above. These are AI
reviews, not human peer review or novelty certification. The proof review is
a scoped elaboration and axiom audit, not a clean-room rebuild of dependencies.

Full S3126 remains open. In particular, a bundled encoded valid-instance
constructor, polynomial runtime and output size, rational bit bounds and
polynomial-magnitude denominator, sampling, NP-hardness semantics, specialized
PCP and compilation proofs, asymptotics and the exact learning transfer are
not certified by this closeout. The complexity notes are retained in the
[full dependency ledger](2026-09-12-realizable-hardness-lean-dependency-assessment.md).
This evidence integration makes no code change, public claim expansion,
push, release or submission.
