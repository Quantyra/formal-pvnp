# S3131 flat Boolean seed and padding source draft

2026-09-12. Parent S3126. Status: **AUTHOR BUILD GREEN; INDEPENDENT REVIEW PENDING**.
The initial source draft was committed as 2ecc1f668a6cf22336cd9d19f159e4ec49bb2a84.
The separately authorized compiler pass below checked the corrected source.
This is finite-component verification, not full hardness certification.

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

## Actual verification

The source targets the existing root Lean 4.13.0 and pinned mathlib
`d7317655e2826dc1f1de9a0c138db2775c4bb841`. Actual local mathlib definitions
of `finTwoEquiv`, `finProdFinEquiv`, `finSumFinEquiv`,
`Fintype.card_subtype`, `Finset.sum_boole`, and `mul_div_mul_right` were
inspected. This source inspection does not establish elaboration success.

With the exclusive compiler grant and `LEAN_NUM_THREADS=1`, both scoped
exports were run using the following exact commands:

```powershell
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/SeedEncoding.olean lean/PvNP/RealizableHardness/SeedEncoding.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/SeedEncodingChecks.olean lean/PvNP/RealizableHardness/SeedEncodingChecks.lean
```

The checks include both inverse directions for zero trials and zero width,
the single empty seed, an executable row-major example, zero extra padding,
an empty prefix, a 16-element suffix fibre, and a nonrectangular two-output
equality event. Two `#eval` commands and 25 `#print axioms` commands are
present. Actual final evaluation lists were
`[false, true, false, true, false, true]` and `[false, false, true]`.
No umbrella import or legacy `BasicDefs`/`MetaComplexity` assumption is introduced.

| Session | Target | Actual exit | Evidence |
| --- | --- | --- | --- |
| 36870 | Main | 1 | Type-product notation, reserved identifier, inverse simplification and event inference errors |
| 46274 | Main | 1 | Only remaining padding event inference error |
| 9810 | Main | 0 | Final main export; no diagnostics |
| 31170 | Checks | 1 | Concrete list `decide` stuck; numeric padding equality not closed |
| 87783 | Checks | 1 | Only concrete Boolean recursor residual goal remained |
| 3397 | Checks | 0 | Both evaluations and all 25 standard-only axiom profiles |

Corrections use `×` for type products, rename the reserved `prefix`
identifier to `takePrefix`, apply the finite equivalence's inverse identity
directly, supply the two explicit event arguments, and prove the concrete
examples by `List.ofFn_succ` reduction, `norm_num`, and `rfl`. No theorem
was weakened. Failed checks printed `sorryAx` for their unsolved examples;
those runs are rejected evidence, superseded by final Checks session 3397.
No source-level `sorry`, `admit`, new axiom, or `native_decide` was added.

Final axiom inventory: `split_join` and `join_split` use exactly
`[propext, Quot.sound]`; the other 23 printed theorems use exactly
`[propext, Classical.choice, Quot.sound]`. The 25 printed names are the
command list in `SeedEncodingChecks.lean`; all appear in the final terminal
output. Independent proof/complexity/non-claims review remains required.

Frozen UTF-8 source SHA256 (no source edits after final green):

- Main: `6c4b145869109b08df7ec0d466c4001f5a14537b715e61f3731dc7056c705ad8`
- Checks: `7f09856c5816c4731e46bdc45cbe1a1ad38922fecf1a2047ef5c77f8ce55cb28`

Actual exports are 275832 and 138016 bytes respectively. Initial disk guard
reported 7271194624 free bytes and no Lean/Lake process; final guard reported
7134224384 free bytes and no Lean/Lake process. Compiler reservation was
explicitly released to root after final terminal success. No resource stop,
download, cache change, or observation-timeout restart occurred.

## Remaining boundary

This is a finite encoding and fixed extra-bit padding component. It does
not implement a Turing machine, establish polynomial evaluation time or
output length, show a polynomial bound on M*b, encode weighted formulas,
prove malformed-input behavior, or compose the full randomized reduction.
Input-dependent seed length and a chosen polynomial envelope still need
their concrete machine bridge. The upstream PCP/geometry/decoder and exact
learning obligations remain open. No NP-hardness or P-versus-NP result
follows from this finite construction alone.

The separately prepared Lean 4.34 companion has not been edited. A later
explicit source-map/provenance port and compilation are required there.
No toolchain/package/cache edits, release, push, or publication occurred.
Only these two source files and this receipt belong to this increment's
authorized commit; independent review receipts are separate work.
