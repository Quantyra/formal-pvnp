# Tagged finite 3-Lin source closeout

Date: 2026-09-15

This increment formalizes the semantic tagged-copy construction for `Finite3LinSource`. It proves assignmentwise restriction, support, bad-row, and violation decomposition facts for a copy indexed by `Fin K`.

## Exact declarations

In `TaggedFinite3LinSource.lean`, with
`{Row Var : Type*} [Fintype Row] [Fintype Var] [DecidableEq Row] [DecidableEq Var]`:

```lean
def taggedCopy (I : Finite3LinSource Row Var) (K : Nat) :
    Finite3LinSource (Fin K × Row) (Fin K × Var)

def restrictAssignment {K : Nat}
    (x : Fin K × Var ? ZMod 2) (k : Fin K) : Var ? ZMod 2

def repeatAssignment {K : Nat}
    (x : Var ? ZMod 2) : Fin K × Var ? ZMod 2

theorem taggedCopy_row (I : Finite3LinSource Row Var) (K : Nat)
    (q : Fin K × Row) (i : Fin 3) :
    (I.taggedCopy K).row q i = (q.1, I.row q.2 i)

theorem taggedCopy_rhs (I : Finite3LinSource Row Var) (K : Nat)
    (q : Fin K × Row) :
    (I.taggedCopy K).rhs q = I.rhs q.2

theorem taggedCopy_support (I : Finite3LinSource Row Var) (K : Nat)
    (k : Fin K) (q : Row) :
    (I.taggedCopy K).support (k, q) =
      (I.support q).image (fun v => (k, v))

theorem taggedCopy_badRow (I : Finite3LinSource Row Var) {K : Nat}
    (x : Fin K × Var ? ZMod 2) (k : Fin K) (q : Row) :
    (I.taggedCopy K).badRow x (k, q) =
      I.badRow (restrictAssignment x k) q

theorem restrictAssignment_repeatAssignment (x : Var ? ZMod 2) {K : Nat}
    (k : Fin K) :
    restrictAssignment (repeatAssignment (K := K) x) k = x

theorem taggedCopy_violations (I : Finite3LinSource Row Var) {K : Nat}
    (x : Fin K × Var ? ZMod 2) :
    (I.taggedCopy K).violations x =
      ? k : Fin K, I.violations (restrictAssignment x k)

theorem taggedCopy_repeatAssignment_violations
    (I : Finite3LinSource Row Var) (K : Nat) (x : Var ? ZMod 2) :
    (I.taggedCopy K).violations (repeatAssignment (K := K) x) =
      K * I.violations x
```

The source imports `PvNP.RealizableHardness.ActualFinite3LinSource`, whose carrier, support, bad-row, and violation definitions are the immediately preceding semantic bridge. No semantic assumptions are introduced beyond the displayed finite-type and decidable-equality parameters; no axioms, `sorry`, `admit`, or `native_decide` are used.

## Certification

Frozen source SHA256 values were unchanged before and after the target-fresh run:

- Main: `D2145BA050CBE6772999B41F3B4027A82312D1A0387C1E0EDF00781C732F2956`
- Checks: `936240D9DC71AD52427AAF7281FCBFC564D52A9865FAF3ED7ECBD2D43664E29D`

The canonical evidence is `research/evidence/2026-09-15-tagged-finite-3lin-source-fresh-run/`; its bundle manifest SHA256 is `D8A186FDB455357221FB6C6DD70F2FBDD3307D6C3B157DF04A3DFC961970D495`.

Sequential direct Lean 4.34.0-rc2 compilation exited 0 for both main and Checks. Fresh output objects are:

- Main: `CFC69AA8341AEE122687CE6B62551B0901C5664B454B2E4D160461F633B92FF7`
- Checks: `E67EBA0C2645A4A06E07426EAE81A48B099877406E5941C837772E45B94DB75B`

The target was seeded only with immutable objects from the prior actual finite-source certification target; the seed and fresh-output manifests, exact commands, raw stdout/stderr, toolchain/package provenance, terminal metadata, signatures, axiom output, and forbidden-token scan are archived in the evidence folder. Checks exercises a single violated row, a two-tag repeated assignment with total violation count 2, and an arbitrary copied assignment with one violating and one satisfying tag, yielding total count 1. Only standard inherited axioms occur: `propext`, `Classical.choice`, and `Quot.sound`. The forbidden scan is clean.

## Three-lens review

| Lens | Result | SHA256 |
|---|---|---|
| Proof | GO-WITH-NOTES | `594922E6035D24C3EE0460A2552CFAFD7E710AD8FD85C168C540C3D4BD4305E9` |
| Complexity | GO-WITH-NOTES | `F5C9F6EF77E377A21B9008FABD38884FDBD62B61C00BF778312507ABCA0AC8D4` |
| Nonclaims | GO-WITH-NOTES | `F543B19B90338FBDD8FD59EED38E188F9DFFEF45F64B214252B6D3892DEC8849` |

## Consumer and boundary

The direct consumer is the two-direction optimum-count/fraction preservation route: restriction gives the assignmentwise decomposition, while repeated assignments give the multiplicative violation identity. The later route still needs its positive tag-count and nonempty-row conditions at the consumer site, together with optimum equality, structural geometry, the encoded polynomial producer, the independent tuple law, the `N_outer` bridge, retained mass, and headline assembly. This increment does not establish a raw `ActualOccurrenceAllocation` copy, an optimum theorem, a producer theorem, a law or expansion theorem, hardness, P vs NP, or publication completion. S3138 and the headline remain incomplete.
