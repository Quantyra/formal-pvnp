# Folded verifier Checks: proof-adversarial review

2026-09-14. S3137, formal-pvnp. GO WITH NOTES for the exact successful author verifier/Checks evidence and preservation of the reviewed semantic targets. Not a fresh independent build, accepted dependency promotion, Fourier soundness theorem or full hardness proof.

I read the complete final Checks, its cumulative patch and the verifier's cumulative source diff against the original semantic-review source. I did not author these files or helpers. I previously reviewed the verifier semantics and authored imported normalization/compact-source modules; prior independent acceptance of those imports is relied upon, not repeated here.

## Exact evidence

The reviewed bundle research/evidence/2026-09-14-folded-checks-green initially has manifest SHA256 d50c3b17fc2df1ed15d78f61e42e7d73ca815914ced038c1a74d6b352fe01f35. All 23 records rehashed successfully. This identity predates the separately requested README-only warning classification correction; the source and raw receipt identities below are authoritative for this verdict.

Final Checks source and snapshot: 1b70a36cfd2ad51b985dd94ce53b9b73d348cc9d33657fe2f7491acef6c6d999. Session81334 summary: 0452a39718bda12b954613eeef8b1fb839d41760725bbf5de7a792e61301bc5f. Metadata: fc284c6fc69acd61a96d51313f6c986f3ede579dfb63c0df91d72ad087719050. Raw log: 30993cb923e7f72610d97ea5b31218ba22f3ec9cdaa27c515d3877109de87341. Profile record: de9180f4b685f8b0660628fc69f71062b481c02e403b43240dd136bdd30d8eee.

Actual metadata and summary agree on exit0, unchanged source and guard_stopped=false. The existing output hashes to d46efe4a22a2b6f1429a5d1d5ec2f01dd95121b459448a92795df3ffcd8e1380. The imported verifier source is the existing green a84b6da84c406ce3e0725b16b98b6582473c3a69a0b948a5efa2c89d228f75f3. Its original output and the copy consumed by Checks hash identically to 6b9b234de01e183384d81c5b4cba3abe8c0d1cc647e8683ef026ec0c0161960b. This is exact reuse, not another main compilation.

The bundle also preserves preceding failed72561 records, which must not be relabeled green. No source/metadata/log is edited by this review. Current success records keep dependency_accepted=false, diagnostic_only=true and export_not_proof_evidence=true. This review does not override them.

## Example propositions and helper proofs

All 19 example propositions match the original Checks after whitespace normalization, in their original order; all 37 #print requests and five #check signatures remain. RepeatedQuestion changes only the Fin index spelling from overloaded zero to an explicit zero with its bound proof. The mathematical query is unchanged. No example has acquired an extra assumption.

The new private constant_fold is correctly conditional on firstSat being nonempty. In its some branch the constant truth value XOR itself is false at every satisfying assignment and the condition is false outside that domain, so canonical is the constant-false function. foldQuery returns that address with the original constant sign. The none branch is excluded by the actual hypothesis, not by an invented inhabited-domain axiom.

true_nonempty supplies a real witness (the all-false assignment) for the always-true predicate, including the empty variable set. repeated_nonempty uses the existing selectedSat_honest with the all-true global assignment to the repeated positive clause; it supplies the actual restriction witness. Hence the two shared-address examples retain all three identical addresses and the specified sign patterns without a caller-supplied query equality. The contradictory positive/negative repeated clauses force selectedSat false for every assignment; foldQuery_none_iff and emitRow_none_iff then prove the same original none examples. Replacement of decide by these proofs does not weaken their conclusions.

Verifier cumulative edits correct product-type syntax explicitly to Prod, clarify induction/inference and make the assignment-list disjointness contradiction explicit; selectedSat_honest gets a locally typed clause hypothesis. They do not alter folding/conditioning, query formation, truth-vector enumeration or the row parity/GF2 targets of the earlier semantic review. No new axiom, sorry, admit or native_decide appears. The three helper declarations are actual proofs; they are not new axioms or unproved fields.

## Axiom profiles and limits

I independently parsed the raw log's full multiline profile blocks, also handling the separate 'does not depend on any axioms' form. Exactly37 records match the archived parser JSON and source request names in order. Of these, rowSource_valid is axiom-free; all others contain only subsets of propext, Classical.choice and Quot.sound. An initial parser matching bracketed lists alone returned36, and including the explicitly axiom-free row resolved this parsing limitation; no actual profile was missing.

The private helpers are not separately #print-audited. Their complete proof bodies were inspected and use the displayed accepted theorem applications and elementary cases; no helper is silently counted among the37 requested public profiles. Nineteen successful examples and five signature displays are retained, not described as additional independent full theorems.

There are seven nonfatal warnings: six unused simp arguments and one tactic-style warning. No error or axiom escape was observed. Global available memory was recorded as6466985984 bytes before and4472975360 minimum sampled; guard_stopped=false. These are sampled telemetry, not a guarantee about every instant. Toolchain/profiler/synchronous settings and lower dependencies remain those of the author diagnostic; no fresh whole-closure provenance replay was conducted by this reviewer.

The result establishes successful checking of this concrete finite semantic verifier and its examples with exact reused main bytes. It does not establish a randomized soundness probability from syntax alone, a same-function row producer FP theorem, the full outer-source reduction, or the paper's CMMSA hardness theorem. Fresh independent source-bound build and acceptance remain separate obligations. No compiler, Git, source or paper actions were performed for this proof review.

Final archive binding: the authorized README-only warning classification correction produces README SHA256 ee707f7f084d503d743f88673958bf67ea1e9cab3e523864a62bed971675c8e7 and manifest SHA256 2be106f88a2b42f07dd4eca7cd200da4f9140d48c2f463a26b69a5c95ed949bf. All 23 records were reverified; only the README record hash/size changed. Every source and raw diagnostic record above remains unchanged. The initial manifest identity is retained above as review chronology.
