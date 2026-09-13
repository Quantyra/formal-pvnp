# Independent complexity review: complete per-seed constructor

2026-09-13. S3131/S3126. Reviewer `/root/matrix_identity_independent_proof` did not author ExecutablePipeline. **GO-WITH-NOTES for the complete typed per-seed constructor and its output-length theorem.** This is not FP or full-hardness certification.

## Exact evidence

Read complete main/Checks sources, author narrative and final evidence, independent proof review and verification JSON, and relevant ExecutableRounding definitions. Current main, Checks and author receipt are raw-identical to freeze `67d478d3d4c78a0e78323bccf053d6fa3b3c42a9`:

- Main SHA256 `1fa7f77a393115596bb6df4bec112b28848ce7f57d880154f2f4c8addca36495`.
- Checks SHA256 `03ce24722537453c907a3725855c93827f9b0fea29b132e042c0648b87027d84`.
- Author receipt SHA256 `db393a42f63f0110a295ccf593fb15b5ee6e74a95b1adc1555c7d16689db2a0b`.
- Independent verification JSON SHA256 `b58c3f458c945f8c65bdfc4797e38dfac7049cf47e605c3a5fec86d946ba69a4` records session 3496, two stable actual EXIT 0 results, sixteen profiles (record_congr axiom-free, fifteen standard-only), four examples and released compiler ownership. This complexity review did not rerun Lean.

## Function and representation

`bits` computes the complete serialized tree from an explicit rational weight list, normalized finite source table, scalar input values and typed seed array. The implementation does not call the noncomputable semantic encoder as a substitute. Its weight and budget trees retain the actual computed unreduced fractions; formula trees contain every repaired formula. `decode_seeded_data` identifies decoded data with the semantic seeded instance on exactly the same seeds. This establishes a useful extensional semantic connection, not equality of bytes with a canonical rational encoder.

The seed assertion is pointwise. Uniform independent bits are not hypotheses of this identity and cannot be inferred from it. Transport of probabilistic correctness requires applying the already established uniform product seed law to this same function, together with appropriate precision, sample-count and concentration premises. At finite precision the source sampler has rounded grid probabilities, not necessarily the original rational masses. In particular b=0 provides a one-point typed seed space, and the constructor's correctness remains a decoding statement, not a concentration guarantee.

The table carries source nonemptiness and probability normalization proofs. They are input promises, not certificates of the completed output. `InputParameters` contains computable scalars only; `inputOf p` erases the input promise proofs. The validity/decode theorems additionally require M>0 and a source-row leaf bound that includes the exception leaf. None assumes the desired output record or its validity. `checkedBits` tests the computed output tree; an invalid scalar tuple can still be accepted if it happens to produce a valid output. This is consistent and is not an all-input source validator.

List.ofFn emits M ordered occurrences. Repeated sampled row indices remain repeated formula occurrences with distinct exception coordinates indexed by trial position. Weights have N+M coordinates in original-then-exception order, with disjoint inl/inr injections and a cast to the actual weight-list length. There is no hidden deduplication, source-index-based exception sharing, or reordering in the equality proof.

## What the size theorem proves

Writing N=ws.length, the theorem bounds all emitted bits by

    (N+M)*(8*size(B)+4)+1
      + M*(L*(4*size(N+M)+10)+1)+1
      + (8*size(B)+3)+2,

where B=16*(N+M+1)*(s.den+sig*gam.den)+(N+M). Formula payload includes variable-index bits and connective overhead; this is stronger than a bound on only the arithmetic fragments. The bound includes repeated formulas and their fresh exception variables. Its omission of source-table length and b is appropriate for an output-length upper bound: emitted formulas are bounded by L and the selected trial count is M.

That omission emphatically does not bound processing time. Input table traversal and probability arithmetic can depend on the whole table; seed reading depends on M*b. Rational arithmetic involves input numerator/denominator lengths and intermediate values, including values not visible in the final B. A small final output can follow expensive computation. The program also rebuilds data and arithmetic expressions in several definitions; source-level sharing or a compiler optimization must not be silently assumed as a cost theorem.

If M is treated as an arbitrary binary scalar by itself, the M emitted formulas can be exponential in its bit length. The actual typed input also includes an M-by-b seed array: for positive b and an explicit framing this may already contribute Omega(M) input bits. That observation does not establish an all-input polynomial bound, since the input codec is absent and b can be zero. In the intended reduction the seed array is randomness, not the original deterministic instance; its ruler must itself be polynomially bounded. Thus the right pending obligation is an encoded-input/coin-ruler bound, not a blanket assertion that every encoding of this function is necessarily exponential.

## Remaining complexity obligations

1. Define and verify the actual binary input representation, signed rational policy, table normalization checks, variable bounds, seed framing and malformed-input behavior. The existing readData/decode handles output syntax; it is not this input parser.
2. Prove polynomially bounded sample and precision rulers from the actual original source instance under fixed-L parameters. Count random bits M*b and ensure the output-length expression is polynomial in that original encoding length.
3. Bound cumulative probability arithmetic, floor cuts, bounded first-crossing search, row lookup, rational multiplication/division/ceiling, dyadic scale construction and all intermediate integer lengths. Mathematical computability and an index bound alone are not an encoded machine runtime proof.
4. Establish FP for an actual encoded implementation extensionally equal to this bits function on accepted inputs and the same seeds. If arithmetic/traversal is optimized, prove that connection rather than substituting a different encoder by semantic plausibility. Prove rejection behavior and cost on all remaining inputs.
5. Connect that machine and its rulers to the randomized reduction theorem and transport YES/NO events through the complete decoded-data identity. Source-produced table size, source hardness, fixed-L parameter assembly and learning transfer remain separate requirements.

No blocking complexity mismatch was found within the stated constructor/output-size scope. No source edits, compiler launches, Git mutations, novelty assertions or public actions were performed in this review. Full submission readiness and final consolidation are not established by this increment.
