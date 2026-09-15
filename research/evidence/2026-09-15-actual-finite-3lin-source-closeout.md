# Actual finite 3-LIN source bridge closeout

This increment adds a finite 3-LIN semantic carrier for an actual occurrence allocation and exact occurrence-preserving correspondences. It does not construct tagged copies, prove a copied value theorem, establish a producer/law bridge, or identify the outer manuscript row universe.

## Frozen declarations

`ActualFinite3LinSource.lean` contains:

1. `Finite3LinSource` with finite `Row`/`Var`, `row`, `rhs`, and row injectivity.
2. `Finite3LinSource.support` as `Finset.univ.image I.row q`.
3. `Finite3LinSource.badRow` using the exact three-variable `ZMod 2` parity equation.
4. `Finite3LinSource.violations` as the finite row-index sum.
5. `row_injective_of_support_card`.
6. `ActualOccurrenceAllocation.Instance.rowId_card_eq_rows_length`.
7. `Finite3LinSource.ofActual`.
8. `Finite3LinSource.ofActual_row`, `ofActual_support`, `ofActual_rhs`, `ofActual_badRow`, and `ofActual_violations` correspondence theorems.

The actual source file SHA256 is `3109F8B0078B7F6253110ED2C39FC85935268768AB0A0A6B9CDA2F029B8B761F`. The Checks source SHA256 is `469AC0A70E0339B21706A7696E173C2C6E19CB211C6AAEF6135F0ECAE3AB8A0F`.

## Verification

The target-fresh sequential certification dated 2026-09-15 compiled main before Checks with exit `0` for both.

- Main object SHA256: `72FE7300086DFB3B13844319C75725AC16032C3413699F20810B2282C6235F48`.
- Checks object SHA256: `69793BC0944858BF5846E32D23956F29A20D852AA3C18FF30FDBE1E9D7D4E008`.
- Evidence folder: `research/evidence/2026-09-15-actual-finite-3lin-source-fresh-run`.
- Evidence manifest SHA256: `00C7B7E93ED9BEFD2F0B351E6E9E9C04455D7A576D5C37D3211D0F7161DAAE9C`.
- Seed OLean manifest SHA256: `83E6928E14575E5679022C0CA5716E6C53092B8EB176D1F85BF9CD95554F1ADB`.

The target was populated from immutable cached dependency objects in the prior canonical `actual-question-mass-d4-count-fresh-20260915` target. The current main and Checks objects were absent before compilation. The dependency seed is a certification provenance caveat; it is not a fresh dependency rebuild.

Checks print the exact signatures and axiom profiles. The declarations use only standard inherited axioms: `propext`, `Classical.choice`, and `Quot.sound`. The forbidden scan for `sorry`, `admit`, `native_decide`, and axiom declarations is clean. The compact `Instance 1 1` fixture uses an explicit all-zero assignment and RHS `1`, proving a nonvacuous violated original row, row-cardinality equality, support/RHS correspondences, and exact violation equality.

Three-lens review results:

| Lens | Result | Review SHA |
| --- | --- | --- |
| Proof adversarial | GO-WITH-NOTES | `294D25BDC040564D863D04ABF6F2EA7C964310625EB7CF9A93E75CD1FF928CAD` |
| Complexity theory | GO-WITH-NOTES | `76D04E534AF977D5CCA85B421E1CC61F682338AF28F51CD48501908063A8BC5E` |
| Nonclaims boundary | GO-WITH-NOTES | `E6A531EAF30B3C1C304243B70A94D91F2045132E91C48A3E147C091CE8C0DCC7` |

The direct consumer is a future copied violation decomposition and repeated-assignment multiplication. A semantic noncomputable carrier is not FP evidence. `RowId = rows.length` does not identify raw `m`, raw `N`, or an outer `N_outer`. The fixture is nonvacuous but not a numeral-normalized full allocation evaluation.

## Remaining boundary

The next obligation is an explicit tagged-copy carrier with row/global-variable maps and assignment preservation, followed by copied violation decomposition. Producer serialization, output-law/value preservation, distribution, padding, conditioning, acceptance, reduction, hardness, and P-versus-NP claims remain open.
