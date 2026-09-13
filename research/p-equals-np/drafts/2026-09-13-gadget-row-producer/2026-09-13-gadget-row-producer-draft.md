# ActualGadgetRowProducer archival source candidate

2026-09-13. S3131/S3132/S3137. SOURCE ONLY, UNCOMPILED. No compiler, Git mutation,
live insertion or public action. This realizes the already documented per-owner
constructor obligation from audit3d661a94; it is not a novelty claim. All theorem
scripts below are proposed source, not observed kernel acceptance.

Raw UTF-8/LF main SHA-256: `ecbeecaad69e6c086662a30cc7a1938da4a724096df3f1926c78fc1ad491d554`.
Checks SHA-256: `96766935a00ceba263b70287d7f89f040d30887db033ab3b8cd24dae6ddb8eb5`.

## Exact function and semantic target

`cloudFn` accepts the machine pair `(ownerUnary, actualCountUnary)`. Its clock is
`marks (mulC (3*D) (pairSnd z))`, hence exactly 3*n*D on context(owner,n).
`ownerCloudFn` supplies that context from the EXISTING Lookup input
`pair (serializedSource I) (replicate v.val true)` using the actual CountFP
function. No external occurrence-count or runtime premise is introduced.

Each loop counter q is decoded as i=q%3, j=(q/3)%D, k=(q/3)/D. The proposed
`dartList_index` proof identifies the actual ordered dart list mapped by
(k*D+j)*3+i with range(n*D*3). It uses finite-range erasure and two successive
range-product equalities, not a cardinality, permutation or unordered graph.
`words_at_dart` supplies the exact inverse arithmetic used by the raw program.

The existing ExecutablePortRotation.rotationFn computes the reverse dart from
the exact size/port/label wire. `rank_value` identifies numeric k*D+j with the
actual finProdFinEquiv rank. The rule compares source and reversed ranks with
ifLtLen. A retained dart emits the four gadget rows in order
[0,2,3], [1,4,5], [2,4,6], [3,5,6], each with Bool false RHS. A rejected dart emits
no bits. Loops fail this strict comparison. Parallel copies retain their entire
representative source k,j,label in every internal code; no endpoint quotient or
deduplication occurs.

`packVar` writes the exact Code331 right-associated VarCode using encUnary and
the existing DATA product wrapper. Bool tags, owner, port coordinates, full
representative dart label and fresh internal index are preserved. `packRow`
writes the exact RowCode DATA product, not a machine pair or unary encTriple.
`dartVars_embed` and `dartRows_localRows` identify the four explicit emitted
records with actual embedFn/localRows. `representative_entries` erases the
existing edgeList attach/map proofs while retaining the filter order.

The same raw dartRule has an FP composition script. materialize_mem_FP derives
the polynomial state bound for listEncFn even when a rule emits variable amounts
of data. The semantic proof uses listEncFn_eq and entryCat with an explicit
filter/flatMap equality; it never uses materialize_eq's one-element-per-step
hypothesis to justify a four-or-zero emission. The proposed cloudFn_correct
identity is the complete DATA encoding of the actual ordered rows mapped by
localRowCode, with exactly one outer list bracket pair. cloudFn_instance and
ownerCloudFn_correct bridge that map to `codeRow I (I.tagRow v q)`.

FP and output-polynomial scripts concern those identical raw cloudFn and
ownerCloudFn definitions, including arbitrary malformed bitstrings. Only valid
existing table inputs receive the finite-instance semantic theorem. Empty
clouds output DATA encoding of [], not the empty bitstring. Context and loop
input lengths are explicitly 2*owner+2+n and 6*n*D+2*owner+n+4. Finite size is
not used as a substitute for the raw FP composition.

## Dependencies and verification boundary

Read the full frozen constructor audit, GraphEdges, EqualityCloud, Code331,
CountFPbec98 and ExecutablePortRotation APIs. Four direct imports are explicit:

- ActualOccurrenceCode, archived331d3a0c, main dae60a33b4b4cc6a1f3a09538c95c98d6ee38f1a7af26852803d7fca7931854f.
  Its author preparation exists; it remains uncompiled. It must not be treated
  as an accepted dependency for a future producer build.
- ActualOccurrenceCountFP, archivedbec98ede, main24600f651bbb3f35423718a5ce0e48e39a73923fb1c9a5417383518a3a8aa79f.
  Author evidence exists; independent acceptance is a separate root decision.
- ExecutablePortRotation live main d204a4333bcd5841623756d856f3c762a278141ed3c15e55f9bb45b043cfc1d2.
  A future build must recover its original accepted export/receipt provenance.
- ActualSourceNormalizedTable live main a4a112c753e7f917663dc1287e7889986bc1d086ab21dfe34cbfa39da8c4e809.
  Reuses only its justified generic dataPair wrapper; acceptance and original
  export closure must be supplied separately, never inferred from this import.

Generalized Allocation and its independently accepted closure remain required.
The archived source is outside that live closure. No dependency was rebuilt or
edited. No new axiom, sorry, admit or native_decide appears. Checks requests
31 axiom profiles, 9 examples and 4 signatures; these are requests, not results.

No missing general FP combinator was identified. The concrete source scripts
still require elaboration: nested range/flatMap rewrites, finProdFinEquiv
normalization, finite-vector reduction, attach erasure and Bool/ZMod conversion
are the sensitive joins. They must be checked against actual compiler evidence;
this receipt does not assert that the full exact-output theorem has passed.
If they fail, preserve their exact contracts rather than adding an assumed
ordering/encoder/first-correctness law. In particular Code's current uncompiled
status is an explicit dependency gate.

## Remaining constructor obligations

The global owner enumeration and concatenation of cloud entries after original
row entries remain outside this pair. The compact input/FiniteBridge join and
whole constructor equality/runtime composition remain separate obligations.
This per-owner adapter alone does not supply them. The Code assignment extension
is semantic and noncomputable; this pair does not turn it into an executable
decoder. Complete encoded reduction, upstream source hardness, final gap/learning
composition, independent three-lens closeout and paper acceptance remain open.
No P-vs-NP or publication conclusion follows.
