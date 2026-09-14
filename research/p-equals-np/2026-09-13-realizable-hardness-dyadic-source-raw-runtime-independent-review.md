# Independent review: exact raw dyadic-source algorithm and bit cost

2026-09-13. S3132/S3137. Reviewer: compact_source_encoding_audit. **GO for SAME and the algorithm-level bit-tape CLOCK derivation in the specified scan/rewrite model.** This is not verification of an existing transition-table artifact, a compiled program, or membership in the pinned library's FP class. That distinction is material and must remain in any acceptance record.

## Exact evidence and scope

I read the entire nine-section candidate, the relevant typed-source construction, actual folded definitions, and actual Data/DataEncode/BinaryNat/Materialize source APIs. Fresh raw identities:

- `research\p-equals-np\2026-09-13-realizable-hardness-dyadic-source-raw-runtime-derivation.md`: `75b5f66e7dc6543c25e7f5972d53e52e7e05411d2bee32c703fe07d205efc606`, 25768 bytes.
- `research\p-equals-np\2026-09-13-realizable-hardness-dyadic-folded-source-join-derivation.md`: `bdaf52f2284a72f9c33c533c44e3649ef7b07c762ae02f9ef528ee3a098ed563`, 24110 bytes.
- `research\p-equals-np\drafts\2026-09-13-folded-parity-verifier\ActualFoldedParityVerifier.lean`: `8c5237a19c06e89adaea2382405691541198d0c120a5699fab25fbff5dbbea0a`, 21495 bytes.
- `certifications\realizable-hardness\.lake\packages\complexitylib\Complexitylib\Encoding\Data.lean`: `0a8488f7928074f18ea9c5cf17a512d09c3487ff2049736b36646cba977dcf22`, 9353 bytes.
- `certifications\realizable-hardness\.lake\packages\complexitylib\Complexitylib\Encoding\DataEncode.lean`: `5fe45322139611eb24cdcb58e2a03db8056ea62f0231606fed7accd0e7524e97`, 4647 bytes.
- `certifications\realizable-hardness\.lake\packages\complexitylib\Complexitylib\Encoding\BinaryNat.lean`: `8170e80045523ff8caa8a50c88aadb82e5fef44254fa7d9bc4ff7c0c0a2c2b29`, 2429 bytes.
- `certifications\realizable-hardness\.lake\packages\complexitylib\Complexitylib\Classes\PCP\Internal\Materialize.lean`: `ed7df12f59690b10e37fbd96d62d328b31b363cd304e607d338c8982eccad4dc`, 12808 bytes.

The candidate's package pin is 6c248df7859f2f245e731c1e07057bf69d165fe2. The raw library hashes above match its records; raw CRLF files and normalized pinned blobs are intentionally distinguished in the author table. I performed no Git operation to claim a new repository-state or blob verification. Source content was inspected directly; no fresh binary evidence is asserted.

I did not author this raw runtime algorithm or contribute its sentinel observation. Incidence's encoding/sentinel contribution is disclosed separately. I authored some downstream source normalization/encoding interfaces and reviewed earlier folded mathematics; this review concerns the new strict parser, whole-word function and cost argument with that dependency involvement disclosed. No compiler, experiments, modules, source edits, Git or paper/public actions occurred. Only this requested note was written.

## Exact grammar and both parser directions

Data.toBits emits false, all ordered child serializations, then true. Data.fromBitsStep opens an empty frame on false and closes/appends only when both a top and parent frame exist; fromBits finishes only at some [[d]]. The proposed P1 therefore matches the actual whole-word parser, including rejection of an empty word, unmatched framing and extra top-level roots. The artificial outer frame is not serialized. The invariant about consumed contiguous subtrees establishes the needed converse, not merely the library's encoder left inverse.

The typed validator matches the existing instances: Bool false is an empty node, true is a node with one empty-node child; products have exactly two children; lists have one arbitrary-arity root; Nat is a list of encoded Bool digits. Exact arity prevents accepting extra children. Minimal little-endian Nat codes are [] for zero and otherwise end true. Every nonempty suffix of such a word is positive; the recurrence 2*tail+bit reconstructs that unique code, so rejecting a redundant high false agrees with BinaryNatCode.decode?. Validation can operate on digit strings without evaluating their potentially exponential numeric values.

Consequently successful parsing identifies precisely one canonical typed CNF. Canonical empty CNF is false,true and follows the typed YES branch; malformed empty input follows fixed NO. That difference is preserved. The parser uses positions bounded by input length as its node IDs, not the numeric labels contained in the input.

## Whole output semantics, order and binary sentinel

The guard enumerates ordered clause tuples, determines sorted wide views and scans at most 2^(3u) assignments. It is the typed global empty-domain test, not an oracle for arbitrary CNF satisfiability. Clause/position question order and false-prefix-first tape/assignment order agree with the accepted typed construction. Digit-length followed by most-significant-digit comparison gives true Nat order; all equal-label testing is full binary equality. Thus sorting and deduplication affect only the specified variable-set views.

The tape pads, noise blocks, actual restriction by matching labels, first satisfying assignment, canonical XOR vectors and folding signs are retained. Step 2 ensures no Option fallback is reached during normal emission. Output uses the two ordered unzip buffers and a single Source product frame: it does not serialize a list of row/RHS pairs or permute the RHS list. Rows and repeated address occurrences are never deduplicated. These observations establish SAME for every canonical CNF and fixed NO for every other word, without any proof assignment or input satisfiability premise.

Independently, bits(wordNat(s))=s++[true]: the appended true makes a canonical little-endian code, and its fold value equals the recursive wordNat, with the empty case bits(1)=[true]. Equivalently each recursive low digit is prepended to the positive tail's canonical expansion. The algorithm therefore writes the exact existing address Nat without computing or unary-expanding its numeric value. It retains the shared namespace and intended address equalities.

The framing counts check directly. Address size H(n)=6+6u+12un+4G bounds at most 3u label encodings and at most G truth entries. A sentinel-coded label costs at most 4H+6, a right-associated triple at most 12H+22, and its RHS at most four. Three outer frames contribute six bits. Fixed YES has 6+10+2=18 bits; fixed NO has 6+20+2+4=32. These counts also cover exceptional inputs independently of the normal row count.

## Primitive-model review: what the claimed machine bound means

The algorithm is specified as a record program compiled by the stated sequential scan/rewrite convention. It is not just the extensional RAW case definition: the parser, guard, odometers, table loops, numeric comparisons and output writing are described independently of the correctness equation. Nor does the cost argument treat arbitrary record access as unit cost: it subsequently charges each such primitive by a quadratic bit-tape simulation.

The 100(B+1)^2 allowance is justified for the primitive implementations described, with packed delimiter words and scratch reset after operations. In lookup, at most B delimiters are traversed; each ordinal increment/comparison/reset uses a constant number of scans of at most B cells. This is quadratic even though a label's numeric value may be much larger than B. Once located, a record may be copied to a scratch tape and sequentially rewritten; insertion/removal/replacement uses this same second-tape rewrite. A saved boundary/position is a marked symbol. Word comparisons and bit selection use sequential scans and resets, not a RAM jump. At most eight scans per update, at most a quadratic copy/comparison budget and ten complete cleanup scans fit within 100(B+1)^2. One must not reinterpret 'copy' as an arbitrary nested call to the entire lookup primitive for each bit; the stated direct sequential copy is the implementation that supports this bound.

A fixed number of tapes suffices: the parsed tree, parser stack, views, counters and buffers are packed records, not one tape per input node. Program constants and the controller may depend on fixed u,b. The constant controller dispatch and binary ripple-carry operations are included in the primitive allowance. B measures the occupied packed record/scratch words, with their delimiter and index storage, so an uncharged sparsely addressed tape is not being substituted. This is an ordinary existence/cost derivation for those specified subroutines, not a transition-by-transition test of an encoded machine. A serialized instruction list and proof of its denotation remain part of the library realization obligation.

## Storage, primitive ledger and final exponent

The input parser has at most n nodes/links with IDs of at most n+1 bits under the deliberately loose bound, hence the quadratic record-space allowance. Typed validation and copying are covered by the cubic primitive allowance; malformed data cannot supply later loop bounds. Per tuple/question, at most 3u labels are fetched, at most (3u)^2 comparisons/matches are performed, and at most G assignments are tested, with explicit digit scans charged. Per tape, K bits are accessed and at most F/G truth entries and O(H(n)) encoded address symbols are processed. The counts are on labels' digits or on bounded positions, never on decoded numeric label values.

The numbers of guard tuples, questions and tapes are m^u, (3m)^u and T respectively. The written LEDGER counts all of them, including preprocessing that could be reused, and its doubling covers odometers and final buffer traversal. With x=n+1, its powers are at most x^(u+4). For u>=1,b>=2, h>=13,G>=8, the numerical coefficients are dominated by the explicit factor 2^20*h^6*(G+1)^2 left in A after factoring T*3^u*h^4*(G+1)^2. This is concrete slack on counted operations, not a replacement for a missing input-sized loop.

For storage, only one question's tables are retained while the two output buffers grow. The output bound is O(3^u*T*h*(G+1)*x^(u+1)); its ten-copy/metadata allowance is safely below the stated x^(u+2) bound. Parser, tables and scratch are separately counted. Binary record references have width bounded by log2 A+(u+2)log2 x, rather than by a numeric address value. The displayed log2 A formula, K<=(b+2)G, log2 x<=x and the generous h/G margins cover the ten references and working counters without an extra uncounted exponent. Output bits can be held as words in the two buffers, not a separately indexed record with a long ID for each bit. This is the storage organization described in the algorithm.

Thus the presented B<=A*x^(u+2) and J<=A*x^(u+4) give

    100 J (B+1)^2 <=400 A^3*x^(3u+8),

since A*x^(u+2)>=1. Start, failure and halt costs lie in the doubled ledger. The argument establishes termination from finite loops first; CLOCK is not a deadline used to force a different output. The polynomial is for each fixed u,b only, and is intentionally far from optimized.

## Remaining boundary and verdict

DataEncode supplies encoding and injectivity, not a generic typed parser in FP. BinaryNatCode's canonical decoder supplies semantics, not the whole producer runtime. Materialize.materialize_mem_FP explicitly requires the actual entry rule's FP membership, and materialize_eq additionally requires the actual entry equality. None of these imports can silently identify the scan/rewrite machine above with a pinned RTM/Cobham function.

Accordingly SAME and CLOCK are supported at the described algorithm/model level, but there is no existing encoded transition table or library FP proof certified by this note. The next realization must implement this exact strict parser and branch function on all raw words, preserve the sentinel output and ordering, and prove denotation and runtime in the pinned framework, or use an actual proved machine-model equivalence with a concrete realization. That remains substantive work, not just attaching an FP label to this review.

The initial gap-producing SAT reduction, kernel verification and downstream full assembly also remain separate. The note does not establish full hardness, a complete Lean proof, publication readiness or novelty. This bounded GO must retain these limits.
