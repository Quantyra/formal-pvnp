# Encoded occurrence constructor: next concrete API

2026-09-13. S3131/S3132/S3137. Source/API audit only; no compiler, Git mutation,
Lean edit, or acceptance claim. Read compact normalization audit (02e5a57) and
cloud assembly note (041f6025) first. The old assembly note's distinct-source-owner
requirement is superseded by the separately reviewed generalized Allocation
proposal; it must not be reinstated. The cloud structural, degree, completeness
and conditional-gap proofs already exist and should not be re-proved here.

## Next implementable function: actual owner count

Implement `ActualOccurrenceCountFP` first. Input is the EXISTING machine wire
`pair T (replicate v true)`, where T is the right-associated unary triple table
from NormalizedTable/Lookup. Output is the owner's occurrence count in true
marks. Define the total raw functions, with no external loop bound:

    countMark w := ifEqLen
      (ActualOccurrenceLookup.ownerLookup
        (pair (pairFst (pairFst w)) (pairSnd w)))
      (pairSnd (pairFst w)) [true] []
    occurrenceCountFn z := countOver countMark
      (pair (marks (mulC 3 (posCount (pairFst z)))) z)

Prove FP for this exact function via ownerLookup_mem_FP, ifEqLen_mem_FP,
posCount_mem_FP, marks_mem_FP, mulC_mem_FP, pairFn_mem_FP and countOver_mem_FP.
On `lookupInput (serializedSource I) v.val`, prove the ENTIRE result is
`replicate (I.size v) true`, for every `v : Fin N`, including unused owners.
Use length_countOver, Prefix.slotList_eq_decode, Lookup.ownerLookup_correct,
and Allocation.occurrenceList/size. Reuse the established enumeration rather
than inventing another slot order. Then derive count <= 3m and zero for unused
owners. This is a full-table count, unlike ordinalScan's stop-before-query count.

No current task inspected implements this function. The similarly named library
`cloudSizeFn` in AlgPreRot.lean:94 counts graph half-edges in an `encGraph` wire;
it is not this ordered three-position source table and cannot be substituted
without a new semantic bridge. No missing general FP combinator blocks the
proposed count: only this concrete composition and equality are missing.

## Exact serialization contract before row production

Input of the eventual whole producer stays `SourceNormalization.wire S`.
NormalizedTable.sourceFn yields DataEncode of `(unaryRows S, S.2)`; its table
projection equals Lookup.serializedSource of FiniteBridge.instanceOf S h.
Do not change that format or expand the original binary labels to unary.

The current DataEncode.lean supplies Bool/List/Option/Prod/Nat, but no encoding
of Allocation's dependent Sigma/Sum/subtype variable carrier. Thus a row producer
needs an explicit structural erasure bridge, not an unmentioned numbering of
variables. The following fully specified code is a proposed bridge contract,
not an already proved DataEncode instance or a new source representation:

    U := List Bool; u(n) := replicate n true
    VarCode := U * (Bool * (U * (U * (U * U))))
    code(I, <v, inl(k,j)>) := (u(v.val), (false, (u(k.val), (u(j.val), ([], [])))))
    code(I, <v, inr(e,h)>) :=
      (u(v.val), (true, (u(e.val.1.1.val),
        (u(e.val.1.2.val), (u(e.val.2.val), u(h.val)))))))

Here e is the ACTUAL retained representative dart, including its dart label;
the code never replaces e by an unordered endpoint pair or a deduplicated edge.
The zero-filled fields of port codes are fixed by this definition. The Bool
tag separates ports from internals. Prove code injective on I.GlobalVar by
Sigma/Sum cases, Fin.ext and subtype extensionality, using unary-length recovery.
This explicit map is the required semantics for using the composite DataEncode
instances. It must be formalized before claiming any serialized row theorem.

Use `RowCode := (VarCode * (VarCode * VarCode)) * Bool`. Map an actual row q to
`((code(q.1 0),(code(q.1 1),code(q.1 2))), rhsBool(q.2))`, with
`rhsBool b := decide (b = 1)`. Prove ZMod-2 conversion of rhsBool recovers b.
The required final equality is

    constructorFn(wire S) = DataEncode.bitstringEncode
      ((instanceOf S h).rows.map (rowCode (instanceOf S h)))

for Valid S. Injectivity of code must transport assignments, support/degree,
and exact ordered violation counts in both directions; mere output-list size
does not join the finite theorem to the emitted instance. Dense integer labels,
if an eventual consumer demands them, require a further encoded bijection and
runtime proof. No such consumer-specific renumbering is silently included here.

## Original rows, then actual gadget rows

After the count primitive and code bridge, `anchorCodeFn` is the immediate row
building block: on existing Lookup input use ownerLookup for v, ordinalScan for
k, and constant port/tag fields. Require exact equality to DataEncode(code(I,
I.anchor o)), not just an equal number of codes. Use encUnary for unary leaves
and NormalizedTable.dataPair for already-encoded subtrees. `encTriple` itself
encodes three unary strings and is NOT a serializer for three nested VarCodes.
Generic product brackets are already justified by
UnaryList.bitstringEncode_prod_eq and dataPair_mem_FP.

For original row r, call anchorCodeFn at counters 3r,3r+1,3r+2, wrap the three
codes in their fixed right-associated product, and append the actual encoded
Bool from `posAt R r`, where R is the unchanged RHS serialization. Materialize
over `marks(posCount T)` in increasing r. Require exact DataEncode of mapped
`I.originalRows`; Valid S supplies the RHS index bound. No source deduplication.

For each owner v in increasing 0..3m-1, occurrenceCountFn supplies n_v. Use the
EXISTING `ExecutablePortRotation.rotationFn_mem_FP` and `rotationFn_agrees`:
its input is `pair u(n) (pair (pair u(k) u(j)) u(i))`, output the same dart pair
without n. No need to reimplement algBase family tables or prove expansion.
Decode the increasing numeric clock 0..3*n_v*D-1 with i fastest, j next, k last.
Prove its list equals ActualGraphEdges.dartList; the existing
dartList_eq_table_sources already connects that list to FixedPortCycleFamily.table.

Retain exactly rank(sourcePort) < rank(rotatedPort), using ifLtLen on the
computed numeric port ranks; prove the arithmetic rank formula equals
ActualGraphEdges.rank/finProdFinEquiv before using it. This deletes loops and
chooses the existing representative orientation, while preserving parallel
dart copies. For retained darts emit the four row encodings in EqualityGadget.row
order: [0,2,3], [1,4,5], [2,4,6], [3,5,6], each RHS zero, substituting precisely
ActualEqualityCloud.embedFn's two ports and five edge-indexed internals.

Required equality is concatenation of these emitted records = encoded entries
of `ActualEqualityCloud.rows n_v`, using representativeList.filter order and
edgeList's attach/map erasure. A single loop step can emit four records or []:
use ListEncode.listEncFn_eq/entryCat and prove the flatten/filter equality.
Materialize.materialize_eq alone assumes one encoded element per index and
does not by itself prove this variable-output step correct. This concrete
filter/flatMap theorem is a missing semantic lemma, not a missing machine loop.
Flatten owners in increasing order, then concatenate after original entries,
with ONE outer list bracket pair. Do not concatenate complete encoded lists
without stripping their outer brackets. This order must equal Allocation.rows,
not merely its multiset. Nested bounded materialization is available.

## Bounds and task ownership

All clocks derive from T: owner count 3m, n_v <= 3m, dart count 3Dn_v.
The fixed D is independent of input; nested loops have a polynomial-size
clock in the supplied wire. Prove raw function FP composition separately from
finite output counts. For the proposed structural code, a conservative bound
per variable is 24m+4D+80 bits; row size <= three such codes plus10, so with
T_out <= (1+18D)m the row-list wire has a quadratic valid-m bound. Derive these
from exact unary and product encodings, then obtain a raw-input polynomial
from actual FP composition/output_length_poly_of_mem_FP. Do not infer time
from that size estimate. Empty/unused clouds must emit no rows.

| Obligation | Existing coverage / new work |
|---|---|
| Compact first-label normalization | FirstOccurrence author-green/frozen; independent acceptance remains separate. |
| Whole normalized unary table and unchanged RHS | NormalizedTable draft task already owns sourceFn/tableFn and FP; do not duplicate. |
| Normalized table = finite instance table, exact source parity | Isolated FiniteBridge task already owns the join; conditional dependencies remain. |
| Repeated-owner finite construction and fixed gaps | Generalized full20 closure and review task; not new work for this producer. |
| Owner occurrence count on actual unary table | Next new function above; no matching source-table API found. |
| Structural variable/row code bridge and anchor/original-row producer | New work; depends on existing ordinalScan, not a new ordinal algorithm. |
| Pointwise fixed graph rotation | Existing ExecutablePortRotation; verify accepted evidence when importing. |
| Ordered representative filtering, four-row emission, global materialization | New concrete semantic/FP assembly; generic loops already available. |

No full constructor, upstream hardness, quantum algorithm, learning theorem,
novelty or publication conclusion follows from this audit. It does not settle
the upstream source wire agreement; it isolates the next missing executable
function and the exact downstream serialization contract.
