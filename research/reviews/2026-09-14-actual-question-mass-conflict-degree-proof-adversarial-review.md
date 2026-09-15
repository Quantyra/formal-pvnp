# Proof-adversarial review: actual question-mass conflict degree

Date: 2026-09-14

Verdict: **GO-WITH-NOTES**

## Frozen review target

- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualQuestionMassBridge.lean`
  - SHA-256: `FF3E0D2191D1D8285E5577353FDE8A71FB4CB6EE76F8997A78417F353EBF6B20`
- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualQuestionMassBridgeChecks.lean`
  - SHA-256: `C5D94284BA32768B5197494657953A046815861831F6D30B875E6F2810BC318D`
- canonical evidence: `research/evidence/2026-09-14-actual-question-mass-conflict-degree-fresh-run/`
  - `artifact-hashes.txt` SHA-256: `422DCEA522CF3AE7B4CE8A7094BFA1E54C63A5CA9BE9DD4993DBB4DA49DF33D2`

The source hashes in the evidence receipt agree with the frozen working-tree files before and after compilation.

## Exact statement review

The frozen `rowConflict row e f` has exactly the audited three branches:

1. `e = f`;
2. `row e` and `row f` are not disjoint;
3. some intermediary row `g` contains an `x` from `row e` and a `y` from `row f`.

The frozen `conflict_degree_le` assumes only finite/decidable row and point types, three points per row, and a uniform incidence bound `D`. Its conclusion is the audited bound

```text
card {f | rowConflict row e f} <= 1 + 3 * D + 9 * D^2.
```

No source-specific regularity, injectivity, distinct-row, symmetry, or additional degree assumption was introduced. The extra `[Fintype X]` section variable is reported by Lean as unused; this is harmless and does not strengthen the mathematical argument.

## Proof audit

The covering argument is sound.

- Direct conflicts lie in the union, over the three points of `row e`, of their incidence rows. `card_biUnion_le_card_mul`, `hthree`, and `hdegree` give `3 * D`.
- For each `x` in `row e`, cross conflicts are covered by choosing a row `g` incident to `x`, a point `y` in `row g`, and a row `f` incident to `y`. The successive bounds are `D`, `3`, and `D`; the outer three choices of `x` produce `9 * D^2`.
- The equality branch is covered by `{e}`. Union-cardinality inequalities deliberately permit overlaps, so equality, direct, and cross candidates may be counted more than once without invalidating the upper bound.

The witness directions in `hsubset` are correct:

- `Finset.not_disjoint_iff.mp` supplies a common point `z`, which places `f` in `directConflictCandidates`.
- A cross witness `(g, x, y)` places `g` in the incidence rows of `x`, `y` in `row g`, and `f` in the incidence rows of `y`, hence places `f` in `crossConflictCandidates`.

The final arithmetic is over `Nat` and follows from the two component bounds and the singleton cardinality. I found no reversal of inclusion, missing membership premise, invalid disjointness conversion, or multiplication-order error.

## Checks and fixture coverage

The Checks module confirms the exact theorem signatures and invokes `conflict_degree_le` on a concrete three-uniform family. It also separately exercises:

- the self-conflict branch;
- the direct-intersection branch;
- a cross-only witness whose endpoint rows are disjoint.

Note: the cross-only `badRows` fixture does not satisfy the theorem's three-uniform premise, so it checks the definition and witness geometry rather than instantiating the full cardinality theorem on a cross-only three-uniform family. This is a fixture-strength limitation, not a proof gap: the general proof's cross branch is explicit and kernel checked. A future stronger fixture could combine three-uniform rows with a cross-only pair, but it is not required to accept this theorem.

## Certification and axioms

The canonical evidence records successful fresh outputs for the frozen main module and Checks module:

- main exit: `0`; object SHA-256: `5D10D1B03531A99E7A161BA3B9127ABF352D4AAFC73BE6FE02D687A6228FC8C8`
- Checks exit: `0`; object SHA-256: `80B846FDFA25414E706C0599F3F93B0C74B84BFBA01CE02B4889B5FCF40B976B`
- forbidden-token scan: clean for `sorry`, `admit`, and `native_decide`
- reported axioms: `propext`, `Classical.choice`, and `Quot.sound`

Those are standard Lean/Mathlib axioms for this development; the theorem introduces no custom axiom.

Certification provenance has one explicit caveat. The initially empty target failed because dependency objects were absent. The run then seeded 2,794 dependency files from the prior canonical fresh output root, excluding both `ActualQuestionMassBridge` objects, and compiled the main and Checks objects afterward. The seed root, rule, `LEAN_PATH`, toolchain, manifests, dependency hashes, source hashes, commands, outputs, and target-object hashes are recorded. This certifies fresh target-module and Checks compilation against the recorded dependency objects; it is not an independent rebuild of every dependency from source. The caveat is adequately disclosed and does not invalidate this increment.

## Dependency boundary

The direct consumer is the still-unproved `bad_ordered_question_count_le`. This review accepts only the generic conflict-degree bound. It does not establish the concrete `D = 4` instantiation inside the ordered-question theorem, the bad-question count, retained probability mass, conditioning, actual-star acceptance, the randomized-reduction assembly, hardness, or a P-versus-NP conclusion.

