# Actual-star span intersection: non-claims review

Date: 2026-09-14. Scope: final frozen `ActualStarSpanIntersection` main and strengthened Checks sources, the original main certification in `2026-09-14-actual-star-span-intersection-fresh-run`, and the final checks-only certification in `2026-09-14-actual-star-span-intersection-strengthened-checks-fresh-run`. This is a top-level non-claims review. It does not modify or recompile Lean.

## Verdict

**GO-WITH-NOTES for the bounded abstract incidence span-intersection increment.** The main source and its certified object are unchanged. The strengthened Checks source has the requested final hash and compiled with exit code `0` against that exact certified main object. The raw transcript, source and object hashes, archived forbidden-token scan, exact printed theorem signature, and reported axiom profile are mutually consistent.

The stronger fixture closes the previous evidence note about a vacuous common-row intersection: the two questions now share the `other` row, so the right-hand span is nonzero, while the excluded `new` row still meets the old support through the one-coordinate `old`/`new` overlap. The result remains a homogeneous span identity over abstract finite incidence data. It is not an actual-source construction, retained-question-law theorem, RHS theorem, accepted-star theorem, randomized reduction, P-versus-NP result, or publication-ready headline theorem.

## Final frozen sources

| Item | Independently observed SHA256 | Assessment |
|---|---|---|
| `ActualStarSpanIntersection.lean` | `f3ce6ed0bf8fb9164f16eb846a3378fd2f3471016ece35f5db8c091e967042a5` | Matches the requested unchanged main pin and both evidence manifests. |
| `ActualStarSpanIntersectionChecks.lean` | `d2fecc62df0ab53de600e70ea89ffc0b1974a36d854b0211fd851185288dcbeb` | Matches the requested final Checks pin, the before/after fields in `terminal.json`, and the final manifest. |
| Final `hashes.json` | `c3232c760ab83ca067272327d97865c301a4b9b67493eab9510b8a60c6a440b6` | Matches the requested evidence-manifest pin. |

No theorem declaration or definition in the main module changed during the fixture strengthening.

## Checks-only certification

The original fresh main build exited `0` and produced `ActualStarSpanIntersection.olean` with SHA256 `decc2eaa887ac7c8c1db4f121fc0b5a9ba03369fa191e1de6b7cca3fce748dbd`. Its frozen main source hash was the same before and after compilation.

The final checks-only receipt records:

| Evidence | Independently observed value | Assessment |
|---|---|---|
| Checks process | exit code `0` | Successful kernel compilation. |
| Checks source before/after | `d2fecc62df0ab53de600e70ea89ffc0b1974a36d854b0211fd851185288dcbeb` / identical | Source stayed frozen during the run. |
| Imported main object | `decc2eaa887ac7c8c1db4f121fc0b5a9ba03369fa191e1de6b7cca3fce748dbd` | Exactly the previously certified main `.olean`; the same object is present in the strengthened target. |
| Final Checks object | `ca6511ffd164fa888d3b263be48aea597060b1b10dd29be1420a628d0d5bfba6` | Matches the final manifest and the object in the dedicated target. |
| `checks.stdout.txt` | `38c0633cf146a3d6a64205ee99f8189d7f471ab0cc02e7be9b7108e1a54a80e0` | Matches the final manifest. |
| `checks.stderr.txt` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` | Empty and matches the final manifest. |
| `checks.command.log` | `86e43b2b115116921615c383a7fd13be82c5cf9353e29a9a79262bca2e31cf3d` | Matches the final manifest and records exit, source pins, main-object pin, and `LEAN_PATH`. |
| `terminal.json` | `6a83263b14ffe3fdc64c79e37eaff3a575993d22093cf985d4a8cadeeef6c322` | Matches the final manifest. |
| `forbidden-scan.txt` | `88ed55cb63008cfe87032858ac0cbf432baa67e454e40ee2e17f2442e7541177` | Matches the final manifest; records `rg` exit `1`, meaning no matched forbidden token. |

The final target contains the pinned main object and the strengthened Checks object at the hashes above. The `LEAN_PATH` places that dedicated target first and the accepted dependency root second. This is adequate certification of the final Checks source against the unchanged certified main. It is not a new from-scratch main or transitive-dependency rebuild, and none is needed to assess a Checks-only fixture change.

The archived scan command covers `sorry`, `admit`, `native_decide`, and `axiom` in both frozen sources. Its empty result with `rg` exit `1` is correctly recorded as clean. Independent source inspection also found no `unsafe`. No unproved placeholder or project-specific axiom was found.

## Exact declaration and axiom boundary

The reviewed main theorem remains exactly:

```lean
theorem equationSpan_inf_coordinateSpace
    (row : E → Finset X)
    (hthree : ∀ e, (row e).card = 3)
    (hlinear : ∀ e f, e ≠ f → ((row e) ∩ (row f)).card ≤ 1)
    (U U' : Finset E)
    (hU : GoodQuestion row U) (hU' : GoodQuestion row U') :
    equationSpan row U' ⊓ coordinateSpace row U =
      equationSpan row (U' ∩ U)
```

The final Checks stdout prints this exact signature. It reports the axiom profile as exactly:

```text
[propext, Classical.choice, Quot.sound]
```

These are standard Mathlib/Lean foundations used by the proof. No source-specific assumption, satisfiability premise, RHS consistency premise, probability hypothesis, star acceptance assumption, runtime claim, or complexity-theoretic claim is hidden in the theorem.

The theorem assumes finite row and coordinate types with decidable equality, exactly three coordinates per row, pairwise intersection at most one for distinct rows, and `GoodQuestion` for both finite questions. It concludes equality of two `ZMod 2` submodules. Its definitions are the characteristic row vector, the span generated by selected row vectors, and the ambient coordinate subspace supported inside the first question's row union.

## Strengthened fixture coverage

The final fixture uses three rows:

- `old = {a,b,c}`;
- `new = {a,d,e}`;
- `other = {f,g,h}`.

It takes `U = {old, other}` and `U' = {new, other}`. Both questions are proved `GoodQuestion`; every row has cardinality three; distinct rows intersect in at most one coordinate; and `old ∩ new` has cardinality one. The private-coordinate example requires the witness for `new` to avoid the nonempty old support and the erased new-question support `{other}`.

Most usefully, `U' ∩ U = {other}`. The span-equality example therefore exercises the theorem with a nonzero common-row span and a genuinely excluded row. This addresses the prior fixture limitation while keeping one compact model. The universal mathematical result continues to rest on the kernel-checked general proof, not finite enumeration alone.

## Exact mathematical claim

The forward inclusion expands a vector in `equationSpan row U'` as a finite linear combination. For each `e ∈ U' \ U`, the compiled private-coordinate theorem supplies a coordinate outside the old question's support and all other rows of `U'`. Evaluation at that coordinate forces the coefficient of `e` to vanish. The same representation is therefore supported on `U' ∩ U`. The reverse inclusion uses span monotonicity and the fact that every common row vector is supported inside the old coordinate space.

Safe claim language is:

> For an abstract finite three-uniform linear incidence system and two questions satisfying the explicit `GoodQuestion` conditions, Lean proves that the span generated by the second question, intersected with the coordinate subspace supported on the first question, equals the span generated by their common row occurrences.

The statement uses row occurrence IDs. It does not identify or deduplicate semantically equal equations, and it makes no affine or RHS claim.

## Actual-source bridge remains conditional

The separate risk-first source audit remains **CONDITIONAL**. `ActualOccurrenceAllocation.Instance` appears to provide the finite types, `support_card`, and `pair_intersection` needed for the small specialization `row := I.support`. That specialization is still absent from the frozen module, and even after it is written it will continue to take `GoodQuestion I.support U` and `GoodQuestion I.support U'` as hypotheses.

No accepted producer currently constructs the manuscript's ordered retained-question law, proves its outputs satisfy `GoodQuestion`, or proves that the retained event has sufficient mass. Pairwise row intersection at most one does not imply the global no-cross clause. The `Finset` representation used for deterministic geometry also erases order and duplicate draws and therefore cannot itself serve as the final probability sample space.

The span theorem is homogeneous and contains no `rowRhs`. It neither constructs a well-defined RHS functional on a question span nor proves two such functionals agree on an overlap. It does not define actual Grassmann vertices, presented labels, transport, quotient descent, repeated-address coherence, or emitted-star acceptance. Those must be derived in separate declarations from the actual source rather than introduced as certificate assumptions.

## Headline audit remains NO-GO

The headline randomized-reduction audit remains **NO-GO for claiming an assembled headline theorem**. The strengthened fixture improves local verification but creates no new end-to-end bridge. The following obligations remain open:

- an NP-hard actual source family with the manuscript's stated YES/NO parameters;
- the ordered good-question distribution and its counting/probability bound;
- the RHS functional, overlap agreement, transport/descent, and concrete accepted-star producer;
- a total rational formula table with normalized masses, positive weights, leaf bounds, and the required global YES/NO means;
- an all-input polynomial-time `SeededMap`, exact coin ruler, and exact `Real`/`Rat` probability bridge;
- concrete promise definitions, encoded membership, and both `Preserves` theorems;
- randomized NP-hardness, fixed-`L` asymptotics, and the HN learning transfer.

Unsafe claims include that actual sampled questions already satisfy the span premises with adequate probability, that RHS labels glue, that every emitted star accepts, that the manuscript reduction is formalized, that P equals or differs from NP, or that the paper is ready for submission or public announcement.

## Next consuming dependency

This accepted span theorem should feed a narrow actual-source specialization, followed by the minimal RHS-functional and overlap-agreement theorem. In parallel with that local use, the higher-risk source lane must derive the actual ordered `GoodQuestion` mass bound. The remaining route is:

```text
actual-source span specialization + ordered GoodQuestion producer/mass
  → RHS functional and overlap agreement
  → minimal label transport/descent
  → actual emitted-star acceptance
  → actual star-to-rational-formula source bridge
  → encoded randomized reduction and Preserves proofs
  → quantitative parameter family
  → headline theorem
  → learning corollary
  → manuscript reconciliation and submission artifact
```

The final disposition is therefore **GO-WITH-NOTES** for this exact local dependency, with the source bridge still conditional and the headline claim still NO-GO.
