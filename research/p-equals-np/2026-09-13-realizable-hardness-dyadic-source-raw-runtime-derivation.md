# Exact raw-word dyadic producer: parser, binary costs, and derived clock

2026-09-13. S3132/S3137, formal-pvnp. This note defines a total finite algorithm and proves its exact input/output meaning and a bit-tape polynomial clock. It does not assert membership in the pinned Lean library's FP class. No Lean source, compiler, Git, paper or publication operation is involved. The satellite README/integrity boundary and previously supplied S3132/S3137 protocols apply.

## 1. Exact function and encoding, not another source interface

Fix u>=1 and b>=2, independent of the input word. Retain the typed producer S=S_(u,b) in the reviewed dyadic join bb68fa567d9787195237a949da418942948ee369. Set F=2^u, G=2^(3u), K=F+(b+1)G and T=2^K. These are constants of this machine, however large. The machine is not claimed polynomial uniformly in u or b.

The input encoding is exactly DataEncode.bitstringEncode at the existing CNF type

    List ((Nat * Bool) * ((Nat * Bool) * (Nat * Bool))).

This specializes an existing instance, not a new alternative label or framing scheme. Write enc_C for this instance and wire for ActualSourceNormalization.wire. Define the raw function

    R(w) = wire(S(phi))  if w=enc_C(phi) for a CNF phi;
           wire(NO)     otherwise.                              (RAW)

The typed source NO is the two rows ((0,(0,0)),false) and ((0,(0,0)),true). Injectivity of enc_C makes (RAW) unambiguous. The algorithm below decides the case and computes the output; this displayed specification is not its implementation or a runtime assumption.

Data is a rose tree l(children). The actual toBits emits false, then the encodings of all children in order, then true. Every node contributes exactly two framing bits. DataEncode represents:

- Bool false by l[], true by l[l[]]; their serialized lengths are 2 and 4.
- A list by one node whose children encode the entries.
- A pair by one node with exactly two children, in order.
- Nat v by the list of Bool entries Nat.bits(v), least significant first.

Zero has the unique empty bit list. A nonzero canonical bit list ends in true. These are nested tree nodes, not unframed bits. Source output is the PAIR of the list of right-associated Nat triples and the list of Bool RHS values. It is not the list of row/RHS pairs used during construction.

## 2. Concrete whole-word parser and typed validation

The following deterministic algorithm operates on bits and finite records. All record operations are expanded into scans in Section7.

P1. Scan w from left to right, with a stack initially containing one empty outer frame. On false push an empty frame. On true require at least a top frame and a parent, close the top as one node, and append that node to the parent's children. If this is impossible, enter permanent failure. At end require exactly one frame containing exactly one node. Otherwise fail. Empty w, unmatched opens/closes, and multiple top-level trees therefore fail. This is the exact Data.fromBitsStep/fromBits algorithm, including its whole-word final test.

For implementation no recursively copied subtree is needed: assign each opening an input-position identifier, and store its closing position, parent identifier and ordered child identifiers. The outer artificial frame is not a node. Closing a node appends its identifier; the represented tree is unchanged by this storage convention. At most n=|w| openings occur and every identifier is an index bounded by n, never an input Nat label.

P2. Validate the resulting tree according to this recursive grammar:

    Bool: node with no children, or with exactly one child which has no children;
    Nat: node containing only valid Bool children; their values form [] or end true;
    Literal: node with exactly two children, Nat then Bool;
    Clause: node with exactly two children, Literal then a two-child node
            containing Literal then Literal;
    CNF: node whose children are all Clause.

Arity checks are exact, not 'at least' checks. Validate the entire tree and retain the sequence of canonical label bit strings and signs in original order. A Nat value is represented throughout by its validated digits; there is no loop of length that value. On any failure emit wire(NO) and halt. On success, these finite records represent phi.

### Parser correctness in both directions

The stack invariant is that every closed node in a frame represents precisely its consumed contiguous balanced substring, and the frame lists these nodes in substring order; open frames correspond to the unmatched opens. Opening and closing preserve this invariant. At the final one-node condition, the root's serialization is all of w. Thus successful P1 implies w=toBits(d) for its tree d. This is the converse direction needed for rejecting trailing material; only citing the existing fromBits_toBits left inverse would not establish it. In the forward direction, induction over a node's ordered children shows that consuming its serialization appends exactly that node to the current frame. Consequently P1(toBits(d))=d, as in the library theorem.

For the Nat test, [] denotes zero. If t ends true, recursively set value([])=0 and value(c::s)=2value(s)+bit(c). Induction on length shows that each nonempty such suffix represents a positive number, and repeated division by two gives exactly the digits t. Conversely the highest digit of a nonzero number is true, so its minimal expansion passes this test. A nonempty list ending false is a redundant high zero and fails. Therefore the tested lists are exactly Nat.bits(v), with a unique v. This is extensionally the actual BinaryNatCode.decode? canonicality test, though the algorithm does not construct a huge integer and re-encode it.

Structural induction through Bool, pair and list instances now proves:

    P2(P1(w)) succeeds with phi  iff  w=enc_C(phi).       (PARSE)

In particular no malformed word is silently interpreted as a different well-formed CNF. The canonical empty CNF is the two-bit node false,true; it is different from the malformed empty word. On that canonical input the later typed m=0 branch emits YES, whereas malformed input always emits NO.

## 3. Concrete normal and exceptional execution

After PARSE let m be the number of clause records. Its counter is a count of records, not a decoded label. Execute the following finite loops.

1. If m=0, emit wire(YES) and halt.
2. Enumerate the ordered u-tuples of clause occurrence IDs with a base-m odometer, first coordinate outermost, each coordinate increasing from0 to m-1. For each tuple collect its3u labels; insertion-sort their canonical binary records by numeric order and discard adjacent equal labels to obtain its wide set. Numeric comparison uses digit length, then bits from highest position downward, so it has exactly Nat's order. Enumerate assignments to this sorted set by the draft's false-prefix-first recursion. Evaluate all selected literal signs/OR clauses and their conjunction by lookup in the sorted label list. If none of the assignments satisfies it, emit wire(NO) and halt. Otherwise proceed to the next tuple. This is the global Empty(phi) guard in S, not a test of satisfiability of the whole CNF.
3. Enumerate q in exactly the outer order of the typed join: u-tuples over the clause/position alphabet whose entries are ordered by clause then position. Derive small and wide sorted views by the same insertion-sort/dedup routine. Enumerate their assignments in the existing false-prefix-first order and find the first satisfying wide assignment. Step2 guarantees one exists, because wide view and conjunction do not depend on the selected positions.
4. For this q enumerate each K-bit tape in false-prefix-first order, with the leftmost coordinate the outer recursion coordinate. Build the f, g and noise truth tables by the precise prefix and b-bit-block rules of the typed join. For each wide assignment y, compute its restriction to the small labels by their actual matching positions, then h3(y)=f(restrict(y)) XOR g(y) XOR noise(y). This uses equality of label records; no injectivity of the assignment restriction is assumed.
5. Form the three canonical folded truth vectors. On the small full domain choose the first assignment. On the wide domain use the first satisfying assignment from step3. For each truth function h and base a0, emit canonical value h(a) XOR h(a0) on satisfying assignments and false elsewhere; record folding sign h(a0). Serialize the address (sorted variable list, canonical truth list), transform it into the exact Nat code using Section4, and emit the ordered triple of its three labels. Append the XOR of the three folding signs to a separate RHS buffer.
6. Output the Source pair framing with the complete triple list first, then the complete RHS list, closing the pair. Buffers preserve insertion order. No row or repeated variable address is deduplicated. The only deduplication is the already specified variable-set view construction.

These loops are executable with record scans, Boolean operations and bounded counters. They do not query P, a satisfying assignment, a game value or any output certificate. The normal branch could alternatively compute RHS in a second identical pass, but this algorithm uses one pass and two buffers.

Each finite loop has its explicit bound: m^u guard tuples, at most G wide assignments, (3m)^u questions, T tapes per question, and at most F or G truth entries per tape. Both odometers are just nested finite loops; their order agrees with the recursive outcome list by induction on the number of coordinates. For m>0 all question/tape outcomes are visited exactly once, even if their rows coincide.

## 4. Same binary address: sentinel identity and size

The actual draft defines wordNat([])=1 and wordNat(c::s)=2wordNat(s)+bit(c). For every bit list s,

    Nat.bits(wordNat(s)) = s ++ [true].                    (SENTINEL)

Proof: the empty case is bits(1)=[true]. For c::s the tail wordNat(s) is positive, by the same recursion. Appending a low digit to a positive number prepends that digit to its canonical little-endian expansion, with no exceptional leading-zero case. Applying the induction hypothesis gives c::(s++[true]). This can equally be proved by the Nat validation argument in Section2: s++[true] is canonical and its fold value is wordNat(s); uniqueness supplies the equality.

Thus step5 does NOT change the numeric address. To encode addressCode(a)=wordNat(DataEncode.bitstringEncode(a)) as a Nat, let s be that actual address serialization, and emit a Data list whose Bool children have values s followed by true. There is no unary expansion and no multiplication/division of an unbounded integer. Identical raw addresses give identical label strings in every role; the established address injection is preserved.

Let ell(v)=|Nat.bits(v)|. An occurrence of an input label has ell(v)<=n because its encoding is a subtree of w. For a valid label its encoded size is at most2+4ell(v). For a view of r<=3u labels and its full truth vector of length2^r, the address serialization length a satisfies

    a <= 2 + (2+r(2+4n)) + (2+4*2^r)
       <= 6+6u+12un+4G = H(n).                         (ADDRESS)

The first2 is the pair frame, the next two2's are the label-list and truth-list frames. By SENTINEL the new label width is exactly a+1. Its encoded Nat size is at most2+4(a+1)=4a+6.

A right-associated triple has two pair frames, hence size at most4+3(4H(n)+6)=12H(n)+22. Its matching RHS costs at most4. Source has one pair frame and two list frames. Therefore, writing N=(3m)^u*T,

    |wire(S(phi))| <= 6+N(12H(n)+26)                    (OUTPUT)

in the normal branch. The fixed YES/NO sources cost18 and32 bits respectively: each triple(0,0,0) has size10, the false RHS2 and true RHS4, with6 outer frame bits. These direct counts provide bounds even for malformed n=0 inputs. In all cases the result has length at most40+6+3^u*T*n^u*(12H(n)+26), taking the normal summand as zero when m=0. The inequality m<=n is enough here; we do not need an input label magnitude bound.

## 5. Exact functional correctness

If PARSE fails, the algorithm explicitly emits wire(NO). If it succeeds, PARSE identifies the unique typed phi. The first branch is exactly the m=0 branch of S. The guard's sorted views, conjunction truth table and first-hit test have the same values as the typed Empty(phi) definition; its clause tuple enumeration is identical. Thus the second branch is also exact.

In the normal branch, sorted canonical binary comparison gives the exact Nat-sorted lists, and record equality gives their exact distinctness relation. The assignment recursion is identical, so all prefix ranks and the actual restrictLocal lookup coincide. The tape extraction and noise block operation are the typed definitions. The canonical-fold vector and sign formulas are exactly condition/canonical/foldQuery with the same first assignment; SENTINEL gives the actual addressCode Nat encoding. Consequently each emitted triple and RHS is the corresponding emitRow at that exact outcome. The all-nonempty guard proves the Option fallback never arises. Source buffers implement unzipSource without a permutation.

Induction over the ordered outcome loop therefore identifies the two buffer lists with the typed two map lists. Final framing is DataEncode at Source. This proves the total equality

    algorithm(w)=R(w),
    algorithm(enc_C(phi))=wire(S(phi)) for every phi.      (SAME)

This proves the whole serialized result, including folding signs and exceptional rows; it is not equality merely after renaming or equality of optimum values. The accepted finite YES/NO and count conclusions therefore apply on canonical inputs to this exact output word after decoding. No satisfiability promise is needed for termination, validity or SAME.

## 6. Named finite bit-tape cost model

Use a deterministic multitape Turing transducer over a fixed finite alphabet consisting of bits, blank, delimiters and finitely many marked versions. Each transition reads/writes one symbol on each of a fixed number of tapes and moves each head by at most one cell; cost is transitions. The number of tapes and finite-control states may depend on the fixed u,b, not on w. There is no unit-cost unbounded Nat, RAM address or whole-string operation.

For clarity the algorithm above is expressed using a finite record-program notation. Here is the explicit compilation convention. Store each mutable record as a delimiter-separated finite word on a work tape. Refer to a record by a binary ordinal; keep at most a fixed number of references at one time in scratch tapes. Lookup scans record delimiters, updating/comparing the scan ordinal on a scratch tape. Copy, append, insertion, removal or replacement use a second work tape to rewrite the record list, then exchange the tape roles. A scan over a word with a saved position uses a marked symbol; equality, length and lexicographic comparison use two scratch tapes and sequential cursors. Binary-counter increment is ripple carry. Read a selected bit by a scan from its record boundary. No hidden operation is allowed except these, finite branching and Boolean gates.

If the total occupied encoding of all records, indices and scratch words is at most B>=1, each such record primitive can be implemented in at most100(B+1)^2 transitions. To see this bound without invoking a simulation theorem, scanning at most B records with an ordinal update/comparison costs at most O(B) symbol moves per delimiter: the ordinal width is <=B, and its heads can be reset with at most2B moves. There are at most B delimiters. Copying or rewriting at most B symbols uses at most a constant number of passes of B cells; even locating a requested source bit afresh for every copied bit is at most2B^2 moves. Comparisons use at most two scans of B cells per bit, at most B bits. Scratch reset/mark removal adds at most ten full scans. Assigning at most eight scans per update plus these copy/reset costs is bounded by100(B+1)^2. Choosing this deliberately wasteful simulation also covers insertion shifts and stack append. The finite controller routes these subroutines, so it introduces only a constant transition overhead included in100.

This is a model-and-program bound, not a claimed efficient implementation. We next derive B and the number of primitives from the actual loops, rather than supply either as a hypothesis.

## 7. Derived storage and primitive counts

Put x=n+1, h=u+b+10, and

    A = 2^(K+20) * 3^u * h^10 * (G+1)^4.

All constants are explicit integers of the fixed machine. We claim that the algorithm just specified can use storage

    B <= A*x^(u+2)

and at most

    J <= A*x^(u+4)

record primitives. The following accounting proves these generous bounds.

Parser records have at most n nodes and n child links, each using a position ordinal of at most n+1 bits (the loose unary-width upper bound for a binary ordinal). Frames, boundaries, marks, children and signs therefore need at most100x^2 cells. Every typed node is visited once, but allow each validation to scan the entire parsed tree and its digits. At most100x^3 record primitives suffice, including scanning canonical digits and forming the validated record list. Invalid inputs terminate here, so no later loop can be driven by malformed counts.

For one clause tuple or question, fetching at most3u literals uses at most3u record lookups and copies. Insertion sort uses at most(3u)^2 comparisons and moves. Each comparison scans at most n digits, and we allow one separate record primitive per digit even though the compiled comparison subroutine already covers the scan. Dedup and matching small-to-wide labels use at most(3u)^2 further comparisons. Enumerating at most G assignments and evaluating at most3u literals each, including a linear search among at most3u labels and comparison of their at most n digits, costs at most100h^4(G+1)x^2 primitives per tuple/question. Storing these tables, views and indices uses at most100h^4(G+1)x^2 cells. Assignment counters count positions in a bounded view, not values of label records.

For a question and tape, extraction uses at most K bit lookups. Since F<=G and K<= (b+2)G, this is at most hG. Restriction for every wide assignment uses at most3u label-position lookups and bit copies once those matches have been determined. The three truth-vector scans, first-hit lookup, folding XORs and RHS XOR add at most100h^2(G+1) primitives. Writing all address frames/digits uses at most100h^2(G+1)x primitives by ADDRESS, including the sentinel Bool and re-encoding each raw address bit as an actual Bool tree. Allowing a separate lookup and append per digit and repeated scans yields the uniform conservative bound

    1000h^4(G+1)^2*x^2

primitives per tape, including loop counters and appending to both buffers. A K-bit tape counter and u question counters require at most hG+ux bits. A counter rollover scans its full digits, already within this per-tape allowance.

There are m^u<=x^u guard tuples, at most(3m)^u<=3^u*x^u questions and T tapes per question. Thus the three displayed operation contributions sum to at most

    100x^3 + 100h^4(G+1)x^(u+2)
      + 3^u*x^u*[100h^4(G+1)x^2
                   + T*1000h^4(G+1)^2*x^2].             (LEDGER)

The brackets may count preprocessing even when it can be reused; that only enlarges the bound. Finite odometer enumeration and final buffer traversal add at most the same ledger again: one digit/counter step or buffer symbol is already bounded by the corresponding per-item allowances. Twice(LEDGER) is <=A*x^(u+4): u>=1, x>=1, T>=1, h>=13 and G>=8; after replacing all powers of x by x^(u+4), the sum of numeric coefficients is less than5000, whereas the factor2^20*h^6*(G+1)^2 in A exceeds it. This verifies the bound for short inputs as well as long ones.

By OUTPUT, both normal buffers together occupy at most6+3^u*T*x^u*(12H(n)+26), before a constant number of copying/scratch duplicates. Since H(n)<= (6+6u+12u+4G)x <=30h(G+1)x, ten copies/metadata expansions of this output are at most4000*3^u*T*h*(G+1)*x^(u+2). Parser/table/counter storage and scratch for the record subroutines add at most1000h^4(G+1)x^2 and ten binary record references. Their digit widths are bounded by the number of stored symbols, and more tightly by O(log A+(u+2)log x). The fixed log A contribution depends only on u,b and is absorbed in A: log2 A=K+20+u log2 3+10log2 h+4log2(G+1), which is <=100h(G+1)h for these parameters. Using log2 x<=x gives the loose reference allowance1000h^4(G+1)^2*x^2. The sum is below A*x^(u+2) by the same factor margins. Keeping only input/parsed records, one question's tables, counters and the two output buffers ensures no history of all intermediate tables is retained. This establishes the stated B bound rather than assuming memory proportional to the output without accounting for scratch.

Combining the explicit primitive simulation with J gives the derived clock

    time_R(n) <= 100 J (B+1)^2
              <= 400 A^3 (n+1)^(3u+8).                 (CLOCK)

A few start/halt steps may be included in the ledger's doubled allowance. The exponent and constant are intentionally loose. CLOCK is a derived polynomial, not a caller-supplied field or a machine deadline used to manufacture termination. Every loop was independently shown finite and its executed iterations bounded before this multiplication. Output length and storage have their separate tighter bounds above.

## 8. Exact library boundary and genuinely remaining work

The inspected Data.fromBits provides a concrete parser definition and inverse theorem, but DataEncode has only encode and injectivity fields. There is no generic typed CNF decoder FP theorem to instantiate. BinaryNatCode.decode? proves canonical decoding semantics, not this entire machine's FP membership. Materialize.materialize_mem_FP assumes the actual entry rule belongs to FP; materialize_eq additionally requires equality to each actual DataEncode entry. countOver and findFirst similarly require the precise marker rule in FP. Existing compact source lookup already preserves full binary owners, but its source-row queries neither parse arbitrary CNF words nor produce the upstream folded experiment.

Accordingly this result is SAME plus CLOCK for an explicitly described finite bit-tape machine, under the named model. It is NOT yet a Lean theorem `R in FP`. The missing realization is concrete: encode this exact strict parser, same sorted-view/table routines, sentinel output and branch function in the pinned machine/FP language, prove its denotation equals R on ALL words (including every malformed case), and prove the actual library running-time witness. An equivalence theorem between machine models could be used only with its actual hypotheses and a realization of this machine; neither is silently imported here. Compilation is unavailable in this increment, so no new uncompiled queue is created.

There is also an independent mathematical dependency: a concrete reduction from SAT to the fixed-gap ordered CNF promise used in the finite source theorem. The game/repetition/source proofs do not derive that initial gap reduction. This note does not replace it with an assumed NP-hardness field. Kernel checking of the finite proofs, that initial gap reduction, the library realization and the downstream constructor assembly all remain before the full-proof goal and conditional paper-repository consolidation can be claimed complete.

## 9. Evidence versions and authorship

The algorithm was checked against the following actual files under certifications/realizable-hardness/.lake/packages/complexitylib, package commit6c248df7859f2f245e731c1e07057bf69d165fe2. Each current raw file was read and SHA256 hashed; CRLF-normalizing its raw bytes gives the same text as the pinned Git blob. The package status is clean. These are source identities, not new compile evidence.

| File | Current raw SHA256 | Pinned Git blob SHA256 |
|---|---|---|
| Complexitylib/Encoding/Data.lean | 0a8488f7928074f18ea9c5cf17a512d09c3487ff2049736b36646cba977dcf22 | 8570feabcd2da085a5b41f43b78d32bb1760d3723b46bf34167b5b18b15ae1d4 |
| Complexitylib/Encoding/DataEncode.lean | 5fe45322139611eb24cdcb58e2a03db8056ea62f0231606fed7accd0e7524e97 | db05dd2b00d4e380210ad00fad7a5f42854474a7617f7ccd2ae330c228550568 |
| Complexitylib/Encoding/BinaryNat.lean | 8170e80045523ff8caa8a50c88aadb82e5fef44254fa7d9bc4ff7c0c0a2c2b29 | 2b03a5e1c0cd061260061f943c0b111b4ced647f0b60822f2fe326add6cd0a17 |
| Complexitylib/Classes/PCP/Internal/Materialize.lean | ed7df12f59690b10e37fbd96d62d328b31b363cd304e607d338c8982eccad4dc | 915d07082348c45d3f341d3557caa3f5c471cc2952a6bd915d6caac15a3cbae6 |

Typed source derivation: research/p-equals-np/2026-09-13-realizable-hardness-dyadic-folded-source-join-derivation.md SHA256 bdaf52f2284a72f9c33c533c44e3649ef7b07c762ae02f9ef528ee3a098ed563, archive bb68fa567d9787195237a949da418942948ee369. Folded source draft: research/p-equals-np/drafts/2026-09-13-folded-parity-verifier/ActualFoldedParityVerifier.lean SHA256 8c5237a19c06e89adaea2382405691541198d0c120a5699fab25fbff5dbbea0a, source archive dd3704fef7ddd99c7ace36e5b38d63f51e1cbfd4. Their complete claims boundary and local identities are retained; draft source is not upgraded to a kernel-accepted result.

The author also authored the typed join and folded draft. Incidence supplied encoding checks and the sentinel-route observation; its contribution is disclosed, not presented as wholly independent review of that identity. A distinct reviewer should check this entire strict-parser, same-function and tape-cost derivation before archival acceptance. No claim of novelty, compiled FP membership or full theorem completion is made.
