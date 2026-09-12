# S3131 flat Boolean seed and padding source draft

2026-09-12. Parent S3126. Status: **UNCOMPILED SOURCE DRAFT**.
No Lean or Lake process was launched for this increment. No compiler exit,
axiom profile, runtime measurement, or independent review is claimed.

## Concrete construction

`SeedEncoding.lean` imports the actual `JointSamplingLaw` implementation,
plus mathlib's finite equivalences. It defines an executable row-major map
from `SeedArray M b = Fin M -> Fin b -> Fin 2` to
`FlatSeed (M*b) = Fin (M*b) -> Bool` and its inverse. The existing
`finProdFinEquiv` addresses block i and digit j at j+b*i; `finTwoEquiv`
maps digit zero to false and digit one to true. The proposed inverse proofs
do not assume M or b positive, so either zero case remains included.

For every Prop-valued event, an explicit equivalence between its finite
subtypes gives exact cardinality preservation and hence uniform probability
preservation. A proposed sum/cardinality identity connects this definition
to the existing real-valued `JointSamplingLaw.seedProbability`. The
`sampleFlat_probability` theorem transfers the actual inverse-CDF array
sampler law, retaining the original nonnegative rational mass and exact
normalization hypotheses. Events need not factor into coordinate events.

The additional padding construction splits exactly n+k Boolean coins into
a used n-bit prefix and a k-bit suffix. Its explicit inverse joins them.
For each fixed prefix the fibre is equivalent to all k-bit strings and has
cardinality 2^k. An event fibre is equivalent to its prefix-event subtype
times all suffixes; cancellation gives exact event probability preservation.
`padded_sampleFlat_probability` composes this with the actual sampler law.
No independent-distribution premise is supplied to obtain padding.

## Proposed verification

The source targets the existing root Lean 4.13.0 and pinned mathlib
`d7317655e2826dc1f1de9a0c138db2775c4bb841`. Actual local mathlib definitions
of `finTwoEquiv`, `finProdFinEquiv`, `finSumFinEquiv`,
`Fintype.card_subtype`, `Finset.sum_boole`, and `mul_div_mul_right` were
inspected. This source inspection does not establish elaboration success.

After a separate exclusive compiler grant, run both scoped exports:

```powershell
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/SeedEncoding.olean lean/PvNP/RealizableHardness/SeedEncoding.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/SeedEncodingChecks.olean lean/PvNP/RealizableHardness/SeedEncodingChecks.lean
```

The checks include both inverse directions for zero trials and zero width,
the single empty seed, an executable row-major example, zero extra padding,
an empty prefix, a 16-element suffix fibre, and a nonrectangular two-output
equality event. Two `#eval` commands and 25 `#print axioms` commands are
present. Expected evaluation lists are `[false,true,false,true,false,true]`
and `[false,false,true]`; neither has been executed in this increment.
Use actual terminal exits, actual printed profiles and independent
proof/complexity/non-claims reviews before acceptance. No umbrella import
or legacy `BasicDefs`/`MetaComplexity` assumption is introduced.

## Remaining boundary

This is a finite encoding and fixed extra-bit padding source draft. It does
not implement a Turing machine, establish polynomial evaluation time or
output length, show a polynomial bound on M*b, encode weighted formulas,
prove malformed-input behavior, or compose the full randomized reduction.
Input-dependent seed length and a chosen polynomial envelope still need
their concrete machine bridge. The upstream PCP/geometry/decoder and exact
learning obligations remain open. No NP-hardness or P-versus-NP result
follows from this finite construction alone.

The separately prepared Lean 4.34 companion has not been edited. A later
explicit source-map/provenance port and compilation are required there.
No toolchain/package/cache edits, release, push, publication, or Git index
operation was performed for this draft.
