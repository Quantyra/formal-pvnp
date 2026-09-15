# Actual question mass: generic conflict-degree bound closeout

Date: 2026-09-14

The certified increment adds the manuscript-facing generic row-conflict definition and its occurrence-sensitive degree bound in `ActualQuestionMassBridge.lean`.

## Exact declarations

```lean
def rowConflict
    (row : E → Finset X) (e f : E) : Prop :=
  e = f ∨
  ¬ Disjoint (row e) (row f) ∨
  ∃ g : E, ∃ x ∈ row e, ∃ y ∈ row f,
    x ∈ row g ∧ y ∈ row g
```

```lean
theorem conflict_degree_le
    {X E : Type*} [Fintype X] [Fintype E]
    [DecidableEq X] [DecidableEq E]
    (row : E → Finset X) (D : Nat)
    (hthree : ∀ e, (row e).card = 3)
    (hdegree : ∀ x,
      ((Finset.univ : Finset E).filter
        (fun e => x ∈ row e)).card ≤ D)
    (e : E) :
    ((Finset.univ : Finset E).filter
      (rowConflict row e)).card ≤
      1 + 3 * D + 9 * D^2
```

The declarations and quantifier order are exact. No assumptions were added, and no axioms, `sorry`, `admit`, or `native_decide` were used. The proof bounds equality, direct overlap, and cross-row conflicts by the explicit finite candidate constructions.

## Certification

Frozen source SHA256 values:

- `ActualQuestionMassBridge.lean`: `FF3E0D2191D1D8285E5577353FDE8A71FB4CB6EE76F8997A78417F353EBF6B20`
- `ActualQuestionMassBridgeChecks.lean`: `C5D94284BA32768B5197494657953A046815861831F6D30B875E6F2810BC318D`

Canonical evidence folder:
`research/evidence/2026-09-14-actual-question-mass-conflict-degree-fresh-run/`

Evidence artifact manifest SHA256: `422DCEA522CF3AE7B4CE8A7094BFA1E54C63A5CA9BE9DD4993DBB4DA49DF33D2`.

The fresh direct Lean certification used Lean `leanprover/lean4:v4.34.0-rc2`; main compiled before Checks. Both final commands exited 0, and neither output object existed before the run.

- Main object SHA256: `5D10D1B03531A99E7A161BA3B9127ABF352D4AAFC73BE6FE02D687A6228FC8C8`
- Checks object SHA256: `80B846FDFA25414E706C0599F3F93B0C74B84BFBA01CE02B4889B5FCF40B976B`

The initial empty-target invocation reported a missing dependency object and exited 1. The canonical target was then seeded recursively from the prior canonical dependency output, excluding both bridge objects; the frozen main and Checks were compiled afterward in sequence. This dependency-seeding caveat, commands, raw stdout/stderr, exits, provenance, target inventory, and source before/after hashes are preserved in the evidence folder. Temporary probe roots were excluded from the final certification `LEAN_PATH`; no `lake build` was used.

The forbidden-token scan over both frozen Lean sources found no `sorry`, `admit`, or `native_decide` and exited 0. The exact Checks transcript records both theorem signatures and `#print axioms`; each theorem depends only on `propext`, `Classical.choice`, and `Quot.sound`.

## Reviews

| Lens | Result | Review SHA256 |
|---|---|---|
| Proof adversarial | GO-WITH-NOTES | `FF139E268EFD629C4A58E7E5D0B8D55F79E26B6B8C466B4B9A8411AED6A93760` |
| Complexity theory | GO-WITH-NOTES | `EB9A550EF73437D5D4644BD48B47D3BD2D27AE26DF4D28C59588EDC05F80C276` |
| Nonclaims boundary | GO-WITH-NOTES | `1C866629359BBE5B8AC16ADD27767DBB071721CE140BFCAD223ED9CB1BECFAAC` |

The three review notes are retained at `research/reviews/2026-09-14-actual-question-mass-conflict-degree-*.md`.

## Consumer and boundaries

The direct consumer is `bad_ordered_question_count_le`. The actual-source bridge and the headline route remain open. This increment does not establish mass, conditioning, acceptance, any reduction or hardness result, P versus NP, or publication completion.
