# Exact folded-row entry function and pinned FP composition

2026-09-13. S3132/S3137, formal-pvnp. This is a finite mathematical derivation of an explicit entry expression in the existing FP algebra. It uses the reviewed strictCNFFlag expression, not an assumed parser oracle. No new Lean module, compilation, Git, paper or public action is made. Every local finite table below depends only on fixed u,b; no input-dependent advice is supplied.

## 1. Exact interfaces and total target

Fix u>=1,b>=2. Set F=2^u,G=2^(3u),K=F+(b+1)G,T=2^K. Let S(phi) be exactly the typed dyadic source in archivebb68fa56. A row is ((Nat*(Nat*Nat))*Bool). Write r0=((0,(0,0)),false), r1=((0,(0,0)),true).

Define the intended row list L(w), for EVERY raw word w:

- If w is not the canonical DataEncode word of a CNF, L(w)=[r0,r1].
- If it encodes an empty CNF, L(w)=[r0].
- If it encodes a nonempty CNF having a globally empty selected u-clause domain, L(w)=[r0,r1].
- Otherwise L(w) is the exact ordered list of emitRow outcomes, question outermost and K-bit tape innermost, as in the typed source join.

Then unzipSource(L(w)) is the raw producer's target Source. Define

    nRows(w)=|L(w)|,
    E(z)=DataEncode.bitstringEncode(L(pairFst z).getD |pairSnd z| r0). (ENTRY)

The outer argument uses the library's INTERNAL pair encoding, not DataEncode pair framing. On pair(w,replicate i true), E returns the ith encoded row, or r0 out of range. On an arbitrary malformed outer argument z, pairFst/pairSnd are total functions; ENTRY uses exactly those extracted values. Strict validation is applied to the extracted CNF word w. An entry is one row, so malformed w cannot make a single call return the entire two-row fixed NO wire. Rather nRows=2 and its two entries r0,r1 produce precisely that NO. This distinction is necessary for Materialize's interface.

We derive explicit FP expressions for nRows in unary and E, then project/materialize their two components to produce the exact Source wire, not a different list-of-row-pairs serialization.

## 2. Available primitives and total data extraction

Use actual posCount and posAt from PosScan, fstEnc/sndEnc, encUnary and length arithmetic from UnaryList, bitwise_mem_FP, countOver/materialize from Materialize, and divFn2/modFn2 from UnaryDivMod. Their proofs are in the pinned package. posAt_mem_FP takes an FP index word a and encoded list b and returns posAt(b(z),|a(z)|). On a canonical list, posCount is its length in true marks and posAt returns the exact encoded element, with [] outside the list. Pair projections are likewise correct on their canonical DataEncode pairs. Their all-word functions are total even when that semantic premise is absent.

Use the exact reviewed flag Fcnf(w) in {[true],[]} and define

    clean(w)=selectHead(Fcnf(w),w,enc_C([])).

This is an explicit FP composition of the strict flag, identity, constants and selection. By the flag theorem clean(w) is canonical for EVERY w. Its length is at most |w|+2. Set M(w)=posCount(clean(w)); its length m is the decoded clause count and M is exactly replicate m true. In particular m<=|w|+2 on all words. Keep the original flag separately so malformed input chooses NO before the clean empty-CNF branch.

For clause c, extract its encoded pair by posAt(clean(w),c); literal positions are fstEnc(clause), fstEnc(sndEnc(clause)), and sndEnc(sndEnc(clause)). A literal's label code is fstEnc(literal), its sign code sndEnc(literal). These paths exactly reflect the right-associated CNF type. On a valid index each label is the full DataEncode Nat, not its length. A sign is read by equality to the constant DataEncode(true), yielding the single Boolean verdict [true]/[false]. This equality is on the entire Bool node, not its last framing bit.

Finite simultaneous registers can be represented by iterated INTERNAL pair functions and read by the corresponding fixed projections. Below a vector of a fixed number of word-valued expressions means this explicit nested pair representation. No array access outside the given posAt primitive is assumed polynomial-time.

## 3. Constructed binary-Nat comparison, without unary label expansion

We need sorting/equality of at most3u labels of unbounded binary width. Equality of their full canonical encodings is eqFlag. To compare values, construct this total comparator for arbitrary two encoded words A,B, with its numeric meaning asserted on canonical Nat encodings.

Let a=|posCount(A)|, b=|posCount(B)| and W=max(a,b). Compute a unary word of length W by ifLtLen(posCount A,posCount B,posCount B,posCount A), followed by marks if needed. These are existing FP compositions. The kth digit of either input is

    bit(A,k)=true iff posAt(A,k)=DataEncode(true).

The corresponding one-bit FP result is eqFlag applied to that posAt and the constant true node. For canonical Nat A it is exactly its kth little-endian digit, padded false out of range because posAt then gives [] rather than the true node.

Construct a raw word Z of length2W, with

    Z[2k]=bit(A,k),     Z[2k+1]=bit(B,k),      0<=k<W.

Here is the actual bitwise recurrence, valid on all packed inputs: its unary length is mulC2 of the max-width word; on pair(input,unary j) use divC2 on j for k, modC2 for parity, and select the appropriate one-bit equality flag. bitwise_mem_FP proves Z in FP because its bit rule always returns exactly one bit, including on every out-of-range request. No count of numeric label values is used.

Process Z left to right by a fixed finite comparison machine. States are Ready(c) for c in {LT,EQ,GT}, Have(c,aBit) for those three values and aBit in Bool, and Bad: ten states, encoded injectively at width4. Initial state Ready(EQ). On the next bit a, Ready(c)->Have(c,a). On the following bit b,

    Have(c,a)->Ready(c)       if a=b;
    Have(c,false)->Ready(LT)  if b=true;
    Have(c,true)->Ready(GT)   if b=false.

Bad stays Bad; invalid raw state codes transition to its code. Exact finite equality/constant selection cascades implement both transitions in FP, as in strictCNFFlag. Feed reverse(Z) to recFoldClamp with constant width4; all step leaves have length4, so the clamp is vacuous on ALL suffix words, not merely valid comparison inputs. Its final output LT is tested by equality to enc(Ready(LT)).

After processing k digit pairs, c compares the two k-bit low-order values. If the new higher bits agree, that comparison stays valid; if they differ, their difference has magnitude2^k greater than any possible lower-bit difference (at most2^k-1), so the new comparison is determined by those bits. Induction proves the claimed recurrence. At k=W zero-padding represents the exact canonical Nat values, so the resulting [true]/[false] flag is exactly A-value<B-value. Odd Z words or malformed inputs still give a total FP result; the entry's canonical clean paths are where numeric semantics are needed. This supplies the genuine dynamic comparison primitive required by the finite shape tests.

## 4. Explicit unary clocks and outcome-index decoding

All clocks are computed, not supplied as fields. Write Pow_0(A)=replicate1 true and

    Pow_(j+1)(A)=marks(mulLen(Pow_j(A),A)).

For fixed j this is a finite FP composition, with length |A|^j on EVERY word A by the existing mulLen/marks equations. Thus Cguard=Pow_u(M) has length m^u. Let Qbase=marks(mulC3(M)); the normal row ruler Rnorm=marks(mulCT(Pow_u(Qbase))) has length (3m)^u*T. In particular all these rulers are polynomial in |w| with u,b fixed.

On pair(w,unary i), use divCT i and modCT i to obtain unary question rank q=floor(i/T) and tape rank t=i mod T. For coordinate ell=0,...,u-1 set

    d_ell = (q div (3m)^(u-1-ell)) mod (3m),
    clause_ell=d_ell div3,     position_ell=d_ell mod3.    (RADIX)

The quotients/remainders with varying divisors are exactly divFn2(pair(baseWord,numberWord)) and modFn2 with that same packing. Its positive-divisor equations apply whenever m>0. All exponent rulers use the displayed Pow recurrence. Constant divisions3,T use the actual divC/modC functions. These are total FP expressions on all words even when m=0, but no zero-divisor arithmetic semantics are asserted there; final branching selects the exceptional row instead.

For i<Rnorm.length and m>0, q<(3m)^u and RADIX is its unique u-digit base3m expansion, most significant coordinate first. The standard division identity a=(a div h)*h+a mod h, with 0<=a mod h<h, proves the reconstruction by induction on u. Thus this is exactly the lexicographic question order of the typed source. The inner tape of rank t is the constant K-bit word whose kth bit is floor(t/2^(K-1-k)) mod2: precisely false-prefix-first order. We will select among these T constant tapes by a finite equality test on the unary remainder; we do not need a new binary conversion routine.

Guard tuples use the same radix formula with base m and rank j<m^u, and fix all selected positions to0. Every such tuple appears once; domain emptiness depends only on its clauses, so this restricted position choice is exact for the global guard.

## 5. Finite local shapes replace an unproved variable-size truth-table routine

For one decoded question fetch all3u literal label codes and signs in clause-coordinate then position order. Let H=3u. A local shape consists of:

- an integer r in1..H;
- a surjective map alpha:{0,...,H-1}->{0,...,r-1};
- a sign vector s in Bool^H;
- selected positions p in {0,1,2}^u.

Enumerate shapes by r, then all maps in lexicographic order filtering finite surjectivity, then signs and positions. This is a concrete FINITE constant set for fixed u. A shape matches actual local data if signs and selected positions agree and, for every pair i,j,

    alpha(i)=alpha(j) implies label_i=label_j;
    alpha(i)<alpha(j) implies label_i<label_j.

Equality and strict comparison are the previously constructed FP flags. All H^2 tests and the signs/position tests are a fixed finite conjunction implemented by nested selectHead on single-bit flags. Thus every shape-match predicate is explicitly in FP. On valid local data exactly one shape matches: assign to each label its rank in the finite sorted set of distinct numeric labels. Existence follows by sorting finitely many Nats; uniqueness follows because the complete pairwise equality/order relations determine that rank. The comparisons operate on actual binary label codes. This proof does not assume the sort as an FP primitive.

For a shape define the wide ordered variable ranks as0,...,r-1. The small ordered rank list Ualpha is the increasing list of distinct alpha(3ell+p_ell), ell<u. Representatives rep(j) are the smallest slot i with alpha(i)=j. Therefore its actual wide label list is label_rep(0),...,label_rep(r-1); its actual small list is the representative labels at the ranks in Ualpha. These are CONSTANT selection indices within the fixed shape branch, not variable-length sorting instructions.

For each shape compute these finite tables by the following explicit recurrences. Assignments of width h are enum_0=[[]], enum_(h+1)=[false::a for a in enum_h] ++ [true::a for a in enum_h]. For y in enum_r define

    Sat_alpha,s(y)=AND_(ell<u) OR_(j<3) (y[alpha(3ell+j)] XOR s[3ell+j]).

Its domain D is the filtered enum_r, and its first element is the first satisfying entry if present. Restriction to the small view selects y at the ordered ranks Ualpha. For each tape tau in Bool^K define f on enum_|Ualpha| from the first prefix; g on enum_r from prefix starting F; noise(y) as the all-false b-bit block starting F+G+b*rank(y). Set h3(y)=f(restrict(y)) XOR g(y) XOR noise(y).

For the small query use domain all enum_|Ualpha| and its first assignment. For the two wide queries use D and its first assignment. For each truth function h and chosen first assignment a0, the canonical vector is h(a) XOR h(a0) on the domain and false outside it; its sign is h(a0). If D is empty, mark the shape empty and use r0 as a total fallback rather than choosing a nonexistent assignment.

All these finite tables involve at most H variables, G assignments and K tape bits, with u,b fixed. The recursion above computes their actual bits and no input labels are consulted once the shape is fixed. They can therefore be used as constFn_mem_FP constants for each shape/tape branch. This is finite enumeration of explicitly evaluated Boolean expressions, not input-dependent advice, arbitrary canonical truth functions, or a certificate of folding identities. It preserves repeated clause/sign patterns automatically through the shape classification.

For actual matching data, alpha is precisely the sorted wide-label index and Ualpha precisely the sorted small list. The formulas then coincide with selectedSat, actual restriction and noisyThird in the existing draft. Their enum ranks coincide by the stated recurrence. Consequently the precomputed canonical vectors and sign bits are exactly those of its foldQuery on this tape. The raw proof P never enters this construction.

## 6. Explicit row expression in a shape/tape branch

For already serialized child words a,b define FramePair(a,b)=false::(a++b)++[true]. For a fixed list of serialized entries define FrameList(e1,...,eh)=false::(e1++...++eh)++[true]. These are finite compositions of prepend/append constants and functions in FP. Unlike encPair on raw bit lists, FramePair does not encode its children a second time. The actual DataEncode pair/list equations prove its meaning.

In a shape branch, FrameList of the representative Nat encodings is exactly the DataEncode variable-set list. Pair it with the constant encoding of the canonical Boolean truth vector using FramePair, obtaining the EXACT address serialization z. Its Nat code is

    NatAddress(z)=encUnary(z++[true]).                   (SENTINEL)

appendFn_mem_FP and encUnary_mem_FP prove this expression in FP on all z. The earlier proved identity Nat.bits(wordNat z)=z++[true] and encUnary_eq establish that it is precisely DataEncode of the actual addressCode, including every arbitrary binary input label. No unary numeral is produced. Both roles use the same variable-set/address rule, so U=W and all intended shared addresses remain shared.

Build three such label encodings a0,a1,a2 in query order. Let Rhs be the constant XOR of the three precomputed folding signs. The branch result is

    FramePair(FramePair(a0,FramePair(a1,a2)), encBool(Rhs)).

This is exactly the encoded row/RHS pair. Its FP proof is finite composition of the explicit functions above. Choose the branch by shape match and equality of t to each constant unary tape rank in0..T-1, using a fixed finite cascade; final fallback is enc(r0). Every branch expression is total and in FP even on malformed local data. For normal valid in-range indices exactly one branch applies and Section5 proves it equals the actual emitRow. This is the concrete local entry function, not an assumed entryFn_mem_FP premise.

## 7. Constructed global empty-domain guard and complete entry

Define EmptyEntry(pair(w,unary j)) to return [true] when j<m^u and the guard-tuple local shape from Section4 matches one whose precomputed D is empty, and [] otherwise. The in-range test is ifLtLen on the unary index and Cguard; its truth value is constant-selected. The empty-shape predicate is a finite disjunction of the explicit match predicates, implemented by selection. Hence EmptyEntry is in FP. Outside valid positive-m semantics it still has this exact total bitstring definition; clean(w) is always canonical.

Compute

    BadCount(w)=countOver EmptyEntry (pair(Cguard(w),w)).

Materialize.length_countOver says its length is exactly the sum of the entry lengths over j<m^u. Each length is0 or1, so BadCount is empty iff no guard tuple has empty domain. This is a proved computed global test; no universal guard premise is assumed. For m=0 we still give priority to the earlier empty-CNF branch rather than interpret a guard decision as the producer's mode.

Define mode and unary nRows(w) by the following ordered selections:

1. Fcnf(w)=[]: mode NO, ruler replicate2 true.
2. Otherwise M(w)=[]: mode YES, ruler replicate1 true.
3. Otherwise BadCount(w) nonempty: mode NO, ruler replicate2 true.
4. Otherwise mode NORMAL, ruler Rnorm(w).

Empty tests use isEmptyMark/emptyFlag and selection; all rulers and mode flags are therefore in FP. In NO mode entry i=1 is enc(r1), every other i gives enc(r0). In YES mode every i gives enc(r0). In NORMAL mode, if i<nRows(w), use the shape/tape row expression of Section6; otherwise return enc(r0). Equality/inequality tests operate on the index word's LENGTH, as required by ENTRY. Every component has already been constructed in FP, so these selections and projections prove E in FP. No evaluation branch is partial: division at zero, missing shape and out-of-range list selection all have total library functions or explicit constant fallbacks.

The flag theorem, guard count theorem, radix identity, shape uniqueness and branch row equality prove ENTRY on every packed pair(w,unary i). The same algebra with i=|pairSnd z| proves it on every outer raw word z. Invalid CNF w gives exactly the two-row NO when used with nRows, canonical m=0 gives YES, and a global empty-domain input gives NO. No per-question row deletion or replacement is used in the NORMAL branch.

## 8. Actual Materialize join: two component lists, not the wrong wire

Let ET=fstEnc composed with E and ER=sndEnc composed with E. The encoded result E is always a genuine row/RHS pair, including every default. Therefore these projections give precisely the encoded triple and Bool for every valid row index. Their FP memberships follow from the actual projection/composition APIs.

Set Z(w)=pair(nRows(w),w). By the proved ruler and pairing membership, Z is in FP. materialize_mem_FP applies separately to ET and ER. materialize_eq, with the explicit entry equality just proved, gives

    listEncFn ET (Z(w)) = DataEncode(L(w).map first),
    listEncFn ER (Z(w)) = DataEncode(L(w).map second).

Finally FramePair of these two results is EXACTLY

    DataEncode.bitstringEncode(unzipSource(L(w))).       (FULL-WIRE)

On canonical enc_C(phi), this is wire(S(phi)); otherwise it is wire(NO). Directly materializing E would instead produce DataEncode of the list of row/RHS pairs. We do not identify those different raw words. The two-list construction above is the required actual source interface.

This yields a mathematical pinned-API FP derivation for the complete expression, conditional only on the previously derived strict-flag expression and the explicit finite comparator/shape constructions in this note being formalized exactly as stated. None of these is a newly assumed semantic/runtime certificate. It remains a source-level mathematical composition proof, not a claim that a corresponding Lean theorem has already been elaborated or its TM witness extracted.

### Comparison with existing FirstOccurrence and NormalizedTable

ActualSourceFirstOccurrence.firstFn at lines39--43 searches an ALREADY encoded source triple table: firstFn_correct at147 returns the first flattened slot of an existing source label. ActualSourceNormalizedTable.tableFn at76--84 materializes renamed fields into unaryRows(S)=(normalize S).rows.map unaryTriple. Its sourceFn_correct at115--117 has the exact interface sourceFn(wire S)=DataEncode(unarySource S), preserving S.RHS while changing owner names to unary first-occurrence indices. Those same-function FP theorems are substantive and previously accepted; historical draft comments do not erase their prior build evidence.

They do not consume canonical CNF literal/sign triples and do not construct selected clause tuples, noise truth functions, folding signs or raw proof addresses. This entry E is the PRECEDING upstream output, and substituting tableFn would change its intended numeric labels and omit the verifier construction. Those normalizers may consume FULL-WIRE afterward at the existing downstream bridge. The present proof reuses the same pinned Data extraction/Materialize APIs rather than re-proving normalization or renaming. Thus the remaining kernel gap is this explicit upstream comparator/shape/entry expression and strict flag, not a missing proof of the already existing first-occurrence normalizer.

## 9. Derived clocks, size bounds, and runtime witness provenance

Let n=|w|. clean(w) has length<=n+2. Canonicality gives m<=n+2. Hence for ALL raw words,

    Cguard.length=m^u<=(n+2)^u,
    nRows(w).length <= 2+3^u*T*(n+2)^u.                 (RULERS)

These inequalities follow from actual length equations for Pow/mulC and the mode selections. They are not supplied polynomial-clock assumptions. Unary division/remainder functions have existing all-word FP proofs; their arithmetic equations are used only at positive divisors in the normal semantics proof.

For an in-range normal row, the address serialized length is bounded by

    H(n)=6+6u+12u(n+2)+4G.

This counts the pair frame, the variable-set list of at most3u Nat entries each of encoded size<=2+4(n+2), and the truth list of length<=G with Bool size<=4. The sentinel gives a label Nat encoding of size<=4H(n)+6. Two triple pair frames plus three labels, then one row/RHS pair frame and a Bool give entry length<=12H(n)+28. Constant r0/r1 rows cost14/16 bits. Thus ENTRY semantics implies, for every raw z,

    |E(z)| <= 400*(u+G+1)*(|z|+1).

Use |pairFst z|<=|z| and the displayed coefficient bounds; the default branches satisfy the same bound. This is an explicit output bound for the total entry function, not merely for canonical inputs. The complete two-list source word length is correspondingly bounded by6+nRows(w)*(12H(n)+26), with fixed-mode cases covered by the harmless additional constant40.

The runtime membership proof does not appeal to the earlier prose scan-machine model. Every infinite-input operation here is a named FP combinator, the comparator uses the same constant-width recFoldClamp construction as strictCNFFlag, and every shape/tape enumeration is a FIXED finite cascade. The library's finite composition, bitwise construction, unary arithmetic, countOver and materialization theorems supply actual existential TM/ComputesInTime/BigO witnesses for their composed expressions. materialize_mem_FP derives its own iteration-state polynomial from the entry's FP output bound; it does not require an unproved state-width field from us. The additional explicit bounds above identify the actual semantic clocks and show there is no hidden exponential loop in the varying input. The constants may be enormous in fixed u,b; no uniform polynomiality in those parameters is asserted.

The exact unresolved kernel obligations are implementation and verification of these finite expressions: the strict flag from archivee4710908, the10-state comparator and padded bitwise oracle, the fixed local-shape/tape enumeration with its correctness, and the ENTRY/FULL-WIRE equality chain. They have explicit recurrences and proofs here, but no source pair or compiler record yet. This artifact must not be cited as a compiled FP theorem or full producer acceptance. It also does not fill the separate paused downstream gadget-row constructor obligation.

## 10. Evidence and contribution boundary

Library root is certifications/realizable-hardness/.lake/packages/complexitylib at6c248df7859f2f245e731c1e07057bf69d165fe2. Actual APIs inspected include PosScan.posAt_mem_FP/posCount_mem_FP and their canonical equations; UnaryList pair projections, encUnary, mulLen, divC/modC/mulC; UnaryDivMod.divFn2/modFn2 and positive-divisor equations; BitwiseFP.bitwise_mem_FP; Materialize.countOver, length_countOver, materialize_mem_FP and materialize_eq; Cobham recFoldClamp and finite branching. Current raw identities and normalized-pinned comparisons are below.

The typed outcome/row reference is research/p-equals-np/2026-09-13-realizable-hardness-dyadic-folded-source-join-derivation.md SHA256bdaf52f2284a72f9c33c533c44e3649ef7b07c762ae02f9ef528ee3a098ed563, archivebb68fa567d9787195237a949da418942948ee369. The strict-flag transition derivation SHA2562b7de56cd90a9c4a6e6d91e51ca5cdf68673142c320e34af1ecbd224c321bdd4 is archivede4710908d3b77f171a02e6a390472b5683c42385. Their finite derivation versus kernel status is unchanged.

The author also authored those sources/notes. Incidence is assigned distinct review of this entry construction and has not supplied its comparator or shape proof. Root requested a bounded concrete candidate with any residual implementation obligations identified; no independent GO is inferred before that review.

| Internal PCP file | Raw SHA256 | Normalized pinned comparison |
|---|---|---|
| PosScan.lean | e18cfcb68e9875e2bde15e8afedb3f153d0cbbf5aa6779a019721e47e37c11eb | verified |
| UnaryList.lean | 59f7d902988a16bd8a2f26b7630831f8ec15998c5d4f6403e28c6c1a787cf7bf | verified |
| UnaryDivMod.lean | 7a9ce9c12432bfc0f61abf0e518e14cbffa95831597025715631696f87dde3fc | verified |
| BitwiseFP.lean | 75377b7b08497b1d70b7cdc2731cea2a22b23574c4a75bb0873e061dccb367d7 | verified |
| Materialize.lean | ed7df12f59690b10e37fbd96d62d328b31b363cd304e607d338c8982eccad4dc | verified |

Existing comparison source certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualSourceFirstOccurrence.lean raw SHA256 9321feb3019303b869acdf80dbf7ef593bfc27b56565707a97a5e7ae23d2cfb0.

Existing comparison source certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualSourceNormalizedTable.lean raw SHA256 a4a112c753e7f917663dc1287e7889986bc1d086ab21dfe34cbfa39da8c4e809.
