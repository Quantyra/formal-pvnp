# Semantic CMMSA data to binary syntax: source draft

2026-09-12. S3131 under S3126. **UNCOMPILED.** No axiom queries or examples have executed. No FP, encoded reduction, or full certification claim.

This continues the concrete codec route after inspection of Formula, ExceptionRepair, SamplingFormulaPromises, the machine assembly audit 25ed651, S3131, and manuscript instance conventions. Additional inspected pinned APIs include Nat.binaryRec', Nat.bits_append_bit, Nat.size_eq_bits_len, rational numerator/denominator interfaces, and finSumFinEquiv. Work is in formal-pvnp only. The separate CMMSACodec draft was preserved under the root's explicit scoped Git grant as 09638b71754950af80e8a29138dde1c1ca2f7b11. This new Encoding draft remains separate; no compiler, package, accepted source or public changes were made.

## Concrete construction

natTree encodes Nat.bits into the existing binary-digit tree. bitValue_bits proves decoding those digits recovers the natural using binary induction. natTree_length bounds wire bits by 4*Nat.size(n)+1. ratTree uses the binary absolute numerator and denominator of an actual Rat; read_ratTree proves exact recovery for nonnegative rationals, which covers all valid positive weights and budgets. Its wire bound is 4*size(abs numerator)+4*size(denominator)+3. A negative rational is deliberately outside that recovery theorem and outside valid CMMSA data. No unary-value encoding or arbitrary code witness is used.

formulaTree recurses on the existing Formula (Fin N) constructors with the exact parser tags and binary variable indices. Its parser theorem returns the original formula, including repeated leaves. The list parser/encoder theorem preserves ordered positions and duplicates.

dataTree explicitly encodes each weight, formula occurrence and budget. read_dataTree proves that every actual Data record satisfying Valid L parses back as that same dependent record. ofData produces a validated syntax instance, ofData_data proves its semantic projection is the original Data, and decode_encodeData proves the full bits-to-actual-Data round trip. These statements discharge the earlier limitation that only already-valid syntax had a round trip.

indexedData turns concrete finite coordinate weights and an indexed finite formula family into explicit lists using List.ofFn and an explicit coordinate Fin cast. indexedData_valid derives codec validity from positive normalized weights, M>0, leaf bounds, and budget range. encodeIndexed then constructs actual bits and decode_encodeIndexed returns that exact explicit Data. No existential assumption of an encoding replaces this constructor. The formula-evaluation bridge tracks the cast pointwise.

## Connection to the actual sampled/repair syntax

repairedFamily applies the existing Formula.repair and renames its sum coordinates by finSumFinEquiv. Its evaluation theorem gives the original formula on the old coordinates OR the distinct exception coordinate for that index. Its leaves theorem gives the original leaf count plus one.

seededFamily feeds the actual SamplingFormulaPromises.fromSeeds into that repair/renaming operation. seededFamily_eval exposes the actual sampleArray index selected by those seeds, together with the index-specific exception variable. This preserves duplicate selected formulas and distinct trial positions. The semantic sampler's arbitrary p/F inputs remain upstream theorem parameters; they are not fields of the encoded explicit CMMSA instance. This source connection does not assert that arbitrary such functions are finitely encoded or efficiently evaluable.

Seventeen axiom queries and nine examples are drafted, including binary zero/1024, rational 3/7 and zero, the bit-size bound, arbitrary valid semantic Data, occurrence counts and repair leaves.

## Source hashes

- CMMSAEncoding.lean: `5bc18ba57b90ccb743e77dcf8bc70ea1b9e524e7d3f959d15375a717dc3ad989`.
- CMMSAEncodingChecks.lean: `80b7b2fa88e4ff8f75fca74069132decc3baf04dbd75138fdca70478bfd5ade5`.

## Remaining obligations

Compilation and independent reviews remain mandatory; dependent record simplification, binary-recursion API names, rational casts and finite-list APIs may need elaboration repairs. The checked CMMSACodec interface has not yet been kernel accepted either.

The next full pipeline bridge must instantiate encodeIndexed with the actual rounded outputWeights transported through finSumFinEquiv and the actual outputBudget, discharge its validity from output_valid, and prove cost and satisfaction preservation under that coordinate bijection. Current seededFamily_eval supplies the formula part only; it does not yet assemble that per-seed full record equality. Total encoded input parsing and a finite sampler/source representation are still necessary before a seeded executor can compute this construction.

The field-size bounds here do not provide full output-size bounds, runtime for rational operations, an FP constructor/parser, polynomial coin bounds, or the machine's actual output-tape equality. Inverse-polynomial weight/budget bounds, denominator growth, and fixed-L input-size accounting remain tied to the actual construction. Existing noncomputable semantic output-weight definitions must be connected to executable rational/list computations rather than merely passed as abstract functions. No full randomized hardness, learning transfer, paper completion, or public readiness is implied.
