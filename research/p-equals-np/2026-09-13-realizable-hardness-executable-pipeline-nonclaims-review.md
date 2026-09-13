# Independent executable-pipeline non-claims review

2026-09-13. S3131/S3126. Reviewer: `/root/cmmsa_encoding_nonclaims_review`, independently assigned and not the ExecutablePipeline author. **GO-WITH-NOTES for this bounded constructor.** No blocking overclaim was found. This verdict is not a full hardness, learning, runtime or publication certification.

Read the complete main and Checks sources, dated author receipt, completed independent proof review and its JSON, and the relevant table, parameter, rounding and codec definitions. The applicable three-lens protocol separates this wording/semantic boundary review from compiler and complexity certification. No compiler, source edit, Git mutation, configuration change or public action occurred. This review does not certify my separately authored graph or FixedPortCycleFamily modules.

## Supported result and precise hypotheses

`draws` performs indexed lookup in the actual normalized table using the same t, b, M and seed array that appear in `fromSeeds`. `draws_eq` is pointwise for every such seed array, not a supplied coupling or distribution assumption. `repaired` adds the exception variable for the trial position i. Repeated rows and repeated sampled indices therefore remain separate ordered occurrences, each with its own exception coordinate. Original coordinates and exception coordinates use the disjoint inl/inr injections into Fin(N+M).

`data` computes all three fields: rounded weights, the complete ordered repaired formula list with indices cast to the actual output weight-list length, and the clipped budget. `tree` includes that entire payload, and `bits` serializes the actual tree. The constructor does not accept the desired output or an equality certificate. `record_congr` is equality elimination; its hypotheses are discharged by the concrete weight, draw and budget equalities in `data_eq`.

`decode_bits` and `decode_seeded_data` establish equality of the **decoded Data record** with the semantic pipeline's output for the same seeds. This includes weights, formula order/multiplicity, dependent coordinates and budget. It does not establish canonical byte equality: the executable tree preserves unreduced numerator/common-denominator fractions, and distinct rational encodings can decode to the same rational value. Calling this constructor a literal implementation of the canonical semantic encoder would be stronger than the theorem.

The source table is already a `FiniteSourceSampler.Table N`: a nonempty ordered list, nonnegative rational row probabilities, sum exactly one, and formulas indexed by Fin N. Duplicate formulas and zero-probability rows are permitted. These are structured input validity conditions, not source hardness or target-instance correctness assumptions.

The correctness/validity theorems use `FiniteRepairRoundingPipeline.Parameters ws.get`. Its conditions are positive weights summing to one; 0<s≤1; eps≥0; 0<gam<1/2; sig≥8; and eps*sig≤gam/2. It stores neither a YES nor a NO promise. The executable constructor takes only the raw scalar projection `InputParameters`; it does not run a general parser that reconstructs these proofs. `data_valid`, `decode_bits`, `decode_seeded_data` and `checkedBits_valid` additionally require M>0 and a source-row leaf condition `leaves(row)+1≤L`, including the new exception leaf. That condition applies to every stored row, including zero-mass rows, and is sufficient rather than claimed minimal. `read_tree` alone assumes positivity of the computed common denominator; valid parameters and M>0 later derive that positivity.

## Raw-input and endpoint behavior

| Case | What is supported |
| --- | --- |
| M=0 | The constructed formula list is empty. Valid-instance/decode-success theorems require M>0. Codec Valid requires a nonempty formula list, so the empty computed output cannot be accepted; this follows from inspected definitions, not a separately compiled zero-trial rejection theorem here. |
| b=0 | The typed seed space has one point. Same-seed equality remains valid; no exact equality with the original rational source distribution is introduced. The inherited finite sampler uses its rounded grid masses. |
| Repeated selections | Ordered occurrences and their distinct trial exception coordinates are preserved; no deduplication occurs. |
| Invalid raw scalars | Arithmetic definitions remain total. `checkedBits` tests the computed output tree, returning none when codec acceptance is false. It need not reject every invalid input scalar tuple if the output happens to be valid. |
| Malformed source/seed bytes | Outside this constructor's input type. `readTable` validates an already typed row list, and sampler raw-list helpers check typed seed lengths; neither is a complete binary input-table parser or general machine-input policy for this pipeline. |

`checkedBits` is output validation, not a validation oracle taken as input. Its rejection and valid-input acceptance theorems concern the actual computed tree. They do not supply roundtrips or failure semantics for arbitrary encoded inputs.

No probability guarantee is needed to prove pointwise seeded record equality. Uniform/random seed assumptions, rounding errors and confidence guarantees belong to subsequent probability and machine integration. This module does not itself reprove the source's YES/NO confidence theorem or a final randomized reduction.

## Full output size is covered; runtime is not

`formula_wire_bound` counts binary variable-index payloads and every AND/OR connective. For a formula over Fin N it proves length+7≤leaves*(4*N.size+10). `full_wire_bound` combines it with actual arithmetic fragments, the ordered formula-list overhead, and both outer tree nodes. Writing N=ws.length and B=`ExecutableRounding.inputMagnitudeBound ws M (inputOf p)`, its complete bound is

    (N+M)*(8*B.size+4)+1
      + (M*(L*(4*(N+M).size+10)+1)+1)
      + (8*B.size+3)+2.

B is input-derived: `16*(N+M+1)*(s.den+sig*gam.den)+(N+M)`. This avoids silently omitting formulas or treating variable names as constant-cost. It does not bound every rational intermediate or the time to construct, validate or serialize the output.

The expression still depends on numeric M, not merely its binary length. An arbitrary binary M can demand exponentially many output occurrences, particularly when b=0 contributes no random bits per occurrence. An actual reduction therefore needs polynomially bounded sample/coin rulers tied to its source encoding. Neither this output-length theorem nor the word “executable” establishes membership in FP for arbitrary binary encodings of the present arguments.

Still required are the source input codec and failure policy; actual input-size bounds; rational parsing/validation/arithmetic bit costs; bounded first-crossing and row traversals; repair/rename/serialization machine proofs; and extensional correctness for the same encoded function placed in the FP `run`/ruler fields. The supplied author plan states these gaps explicitly. Source-produced table size, parameter validity, specialized source hardness, fixed-L composition, confidence transport and learning remain separate obligations.

## Exact evidence checked

Frozen main/Checks/author receipt: `67d478d3d4c78a0e78323bccf053d6fa3b3c42a9`. All three current raw files equal those exact frozen blobs. This review found no CRLF-versus-LF discrepancy for this trio.

| Artifact | SHA-256 |
| --- | --- |
| ExecutablePipeline.lean | 1fa7f77a393115596bb6df4bec112b28848ce7f57d880154f2f4c8addca36495 |
| ExecutablePipelineChecks.lean | 03ce24722537453c907a3725855c93827f9b0fea29b132e042c0648b87027d84 |
| 2026-09-13 executable-pipeline draft receipt | db393a42f63f0110a295ccf593fb15b5ee6e74a95b1adc1555c7d16689db2a0b |
| Independent proof review | ed9384e3650fed60d89a1de983a3a8fb6b4441cf0b427a09584dd4907793f7d7 |
| Independent proof-review JSON | b58c3f458c945f8c65bdfc4797e38dfac7049cf47e605c3a5fec86d946ba69a4 |

I parsed and rehashed all 14 portable author artifact records, including raw text and byte counts. The six author attempts contain three failed main runs, a stable successful main, a successful but source-changed first Checks run, and the stable successful Checks rerun. The raced Checks result is correctly retained as history and excluded from final acceptance. Intermediate repair bytes were not all snapshotted; the receipt does not pretend otherwise. Historical corrupted/uncompiled source hashes and headers are superseded by the explicit successful appendix, not relabeled as successful historical builds.

The separate independent proof review reports GO-WITH-NOTES after session 3496 completed both targets with actual exit zero and unchanged sources. I rechecked its two source/output/log/metadata identities and the author accepted source/output/log identities. The independent output hashes are `d03e8f8b13e0d1993723442b3bbc9925ac383c1a99e3fc721b1fe4f75268b2ca` for main and `96d475a2d5928940d2ff4272b22ccad51e51d84c6671a34bd28c288d667cb194` for Checks. Sixteen selected profiles were recorded: `record_congr` is axiom-free, and the other fifteen contain only propext, Classical.choice and Quot.sound. Four examples compiled; no evaluations or benchmark outputs were claimed. This is read-only verification of existing author/independent evidence, not a new compiler run by this reviewer.

## Disposition

Safe wording is: “The complete finite seeded output constructor has verified decoded-record correctness and a full emitted payload bound under explicit input promises.” Retain the distinction from canonical byte identity, general binary input parsing and polynomial machine runtime.

No blocking non-claims issue was found. Full hardness, learning, novelty, publication readiness and P versus NP claims remain unsupported by this bounded result. Full S3126 and the final independently verified proof/paper consolidation remain active. This review stops here; it does not independently certify the reviewer's own graph work or authorize public action.
