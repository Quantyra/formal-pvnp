# Strict canonical CNF flag: finite transitions and exact FP composition

2026-09-13. S3132/S3137, formal-pvnp. This artifact specifies one concrete finite scanner for the ACTUAL DataEncode CNF grammar, proves its all-word language, and derives its flag's membership through existing pinned FP combinators at the mathematical API level. It is not a compiled Lean module or the whole folded-row producer. No source module, compiler, Git, paper or public operation was performed.

## 1. Exact target and why a finite scanner suffices

Use CNF = List (Literal * (Literal * Literal)), Literal = Nat * Bool. DataEncode maps a list to a node of encoded children, a pair to a node of exactly two children, Bool false to l[] and true to l[l[]], and Nat to the list of Bool nodes for its canonical least-significant-first Nat.bits. Data.toBits writes false on node entry and true on exit. Write enc_C(phi) for this exact whole-word encoding.

The target is one TOTAL word function

    strictCNFFlag(w) = [true] iff there exists phi with enc_C(phi)=w;
                      [] otherwise.                         (TARGET)

No canonical input premise is allowed in TARGET. In particular an empty word, a complete valid CNF followed by another tree, a wrong pair arity, a noncanonical Nat and an unfinished tree must be rejected.

Although an arbitrary Data tree has unbounded nesting, this grammar does not. Its longest child path is

    CNF -> Clause -> right-pair -> Literal -> Nat -> Bool -> empty-child.

It has seven nodes. Repetition of clauses or Nat bits creates siblings, never a deeper path. This fixed-depth observation permits a finite frame-stack automaton; it is not a claim that generic Data.fromBits is a finite-state parser.

Languages/Balanced.balanced_mem_P recognizes equality of false/true counts only. It even accepts a close before its matching open, so that theorem is NOT a Dyck or strict-tree recognizer and is not used below.

## 2. Frame alphabet, states, and exact coding width

There are precisely sixteen frame symbols, in this fixed order:

    0 C
    1 A0, 2 A1, 3 A2
    4 R0, 5 R1, 6 R2
    7 L0, 8 L1, 9 L2
    10 Nempty, 11 Nzero, 12 None
    13 B0, 14 B1
    15 E.

C is the CNF root. A is a clause's outer pair, R its right pair, L a literal pair. Their numeric suffix counts completed children. Nempty means no completed Nat digit; Nzero means the last completed digit was false; None means the last completed digit was true (the name is a frame token, not Option.none). B is a Bool node, with zero or one completed empty child. E is the empty child required in a true Bool.

Control states are Start, Done, Bad, and Active(stack), where stack is a bottom-to-top list of one through seven frames. We include ALL such lists in the finite state set, not only reachable ones; invalid context stacks are sent to Bad by transitions. There are exactly 3+sum_(h=1)^7 16^h states.

Encode a state by exactly33 bits:

- Two tag bits: 00 for Start, 01 for Done, 10 for Bad, 11 for Active.
- Three bits for the depth in ordinary fixed-width little-endian binary.
- Seven consecutive four-bit frame slots, each using the displayed number in fixed-width little-endian binary.

For Start/Done/Bad all31 remaining bits are false. For Active the depth is1..7, the first depth slots store its frames, and every remaining slot is all false. This encoding is injective: tags first distinguish the control kind, depth distinguishes stack length, and the four-bit fields distinguish frames. It has length ell=33 for every state. Every other raw bit word is an invalid state code, regardless of its length. The step functions on such codes return the code of Bad. This provides totality even on arbitrary intermediate bitstrings passed directly to the FP functions.

## 3. Allowed next-child table and stack validity

For a top frame f, the next allowed child entry frame child(f) is:

| Parent frame | Child entry frame |
|---|---|
| C | A0 |
| A0 | L0 |
| A1 | R0 |
| R0 or R1 | L0 |
| L0 | Nempty |
| L1 | B0 |
| Nempty, Nzero, or None | B0 |
| B0 | E |
| A2, R2, L2, B1, or E | no child permitted |

A frame's role ignores its progress suffix. A stack is ContextOK precisely when its bottom frame is C and, for every adjacent parent/child frame, child(parent) is defined and has the child's role. The parent progress is not advanced on opening a child; it advances only after that child's successful close. Thus the parent still identifies exactly which currently open child it is awaiting.

The directed role-child graph in this table has no cycle. Reading a path from C shows that every ContextOK stack has length at most7. We nevertheless explicitly reject an opening at depth7 in the transition definition; this branch is total and unreachable on a valid further child.

## 4. Transition table on each input bit

Define delta(state,bit) by the following ordered cases. False is OPEN, true is CLOSE.

- Bad stays Bad on either bit.
- Done goes to Bad on either bit. Acceptance is tested only after all input is consumed; no later bit can be ignored after a root closes.
- Start on OPEN becomes Active([C]); Start on CLOSE becomes Bad.
- Any Active stack failing ContextOK goes to Bad on either bit.
- Active(stack) on OPEN: inspect child(top). If undefined, or depth=7, return Bad. Otherwise push that child entry frame. All other frames stay unchanged.
- Active(stack) on CLOSE: use the close and parent-update rules below. A disallowed close or failed parent update returns Bad permanently.

The permitted closes and their return data are:

| Closing frame | Permitted? | Return data |
|---|---|---|
| C | yes | unit |
| A2, R2, L2 | yes | unit |
| A0,A1,R0,R1,L0,L1 | no | none |
| Nempty or None | yes | unit |
| Nzero | no | none |
| B0 | yes | Boolean false |
| B1 | yes | Boolean true |
| E | yes | unit |

If the closing stack has only its bottom C, return Done. Otherwise pop the closing frame and update its parent as follows. Parent/child role compatibility is checked, so these rules never accept a unit where a Bool is required:

| Parent before close | Required completed child | Parent after close |
|---|---|---|
| C | A | C |
| A0 | L | A1 |
| A1 | R | A2 |
| R0 | L | R1 |
| R1 | L | R2 |
| L0 | N | L1 |
| L1 | B, either Boolean | L2 |
| Nempty/Nzero/None | B returning false | Nzero |
| Nempty/Nzero/None | B returning true | None |
| B0 | E | B1 |

Every other update is failure. Any unit returned by A/R/L/N/E is only a close-event marker; it is not a semantic value substituted for its subtree. In particular the last-bit check in N applies to a FULLY parsed Bool node, not to the final raw framing bit (which is true for every closed node).

This enumerates all transition cases for all finite states and both input bits, including invalid context stacks. There is no unspecified EOF action: run delta over the whole input from Start, and accept exactly when the resulting state equals Done.

## 5. Exact grammar recognized by the scanner

Define the following finite-tree grammar, using node brackets as Data constructors:

    E        ::= l[]
    Bool     ::= l[] | l[E]
    Nat      ::= l[Bool_1,...,Bool_k], where k=0 or Bool_k denotes true
    Literal  ::= l[Nat,Bool]
    Right    ::= l[Literal,Literal]
    Clause   ::= l[Literal,Right]
    CNF      ::= l[Clause_1,...,Clause_m], any m>=0.

A role's well-formed completed subtree means membership in the indicated grammar. Each frame transition tracks exactly its child requirements: C repeats Clause, A/R/L have exactly the displayed ordered children, B permits zero or one E child, E none, and N loops over Bool children while remembering whether the last was true. This correspondence is proved in detail next, rather than assuming a parser certificate.

### Forward invariant for arbitrary words

For every prefix consumed without Bad, each active frame corresponds to one unmatched OPEN in that prefix. The completed children since that OPEN are well-formed subtrees of the required roles, in their input order. Its progress symbol records exactly those completed children: the finite arity counter for A/R/L/B; empty/last Boolean for N; arbitrary Clause sequence for C; no children for E. Between adjacent open frames the parent is waiting for the child's role. Before any OPEN the state is Start. Once the root closes the state is Done and all of the consumed prefix is exactly that root's serialization.

Induction on consumed bits proves the invariant. OPEN at Start creates the empty C frame. OPEN inside an Active state requires the exact next child role from the table, whose entry frame has no completed children. Existing parent children are unchanged. CLOSE is permitted exactly when the top's accumulated children form a completed subtree in its grammar; the return Bool for B is the grammar's value. The update table appends this completed child to the parent's conceptual child list and changes exactly its progress flag. Nzero cannot close, so redundant high-zero Nat encodings do not enter the completed-tree invariant. Closing C leaves no unmatched OPEN and marks Done. A subsequent bit makes Bad, and no Bad state can later accept.

The conceptual lists in this invariant are proof objects, not stored unbounded data in the finite machine. They reconstruct exactly the unique nested tree from the word's matched opens and closes. The finite state needs only the progress information listed above.

If the final state is Done, the invariant supplies a completed CNF grammar tree whose full serialization is the entire word. There is no unmatched close, unfinished frame or trailing suffix. This proves soundness for ALL raw words, not just balanced ones.

### Completeness of each subtree and root

For each role, induction on its grammar shows that, when opened in the appropriate parent context, its serialization processes the expected children and performs the allowed close/update. For C and N use induction on their finite child lists; for the other roles use their fixed ordered children. No stack overflow occurs: the role-child path bound is7. Bool false performs immediate B0 close; Bool true opens and closes E then closes B1. An empty Nat closes Nempty; a nonempty canonical Nat finishes in None because its final Bool is true, irrespective of preceding digits. The root starts with Start->C and its final close yields Done. There are no extra bits afterward. Thus every CNF grammar serialization is accepted.

### Equality with the actual DataEncode range

Bool grammar trees are exactly the two actual DataEncode Bool values. A Nat grammar's digit list is [] or ends true, which is exactly the canonical little-endian Nat.bits image: evaluation by fold(c::s)=2*fold(s)+bit(c) and induction on length prove that any list ending true re-encodes to itself; zero is uniquely empty. Conversely the minimal expansion of a positive Nat ends true. Therefore a Nat grammar tree is DataEncode of a unique Nat.

Applying the actual pair and list instance equations through Literal, Right, Clause and CNF proves that the grammar's root trees are exactly DataEncode.encode(phi). Their serialized words are exactly enc_C(phi). Combining both directions with the scanner invariant establishes TARGET. Distinct decoded CNFs cannot share a word by the existing DataEncode.bitstringEncode_injective theorem.

## 6. Exact all-word edge cases

The empty word ends in Start and is rejected. The word [false,true] is the canonical empty CNF, reaches Done and is accepted. A CLOSE at Start is Bad. An extra bit after any complete CNF changes Done to Bad, so concatenating two individually valid roots is rejected. A proper unfinished prefix remains Active or Bad, never Done. A third child in any required pair is rejected at its OPEN. Bool l[l[],l[]] fails because B1 has no next child; a nonempty E fails on its first child OPEN. A Nat list ending in the false Bool node finishes Nzero and is rejected even though its brackets and element shapes are correct. The Nat list may contain arbitrarily many earlier false or true digits; neither value nor bit count drives a state-size increase.

Wrong-role trees cannot exploit identical empty-node shapes to bypass the grammar. Empty l[] can represent a false Bool or a zero Nat in their respective contexts, but a pair's required role determines which interpretation is checked. For example a Literal cannot close until both its Nat and Bool children have completed, so a single empty node is not accepted as a Literal. The invariant is typed by context, as DataEncode itself is.

## 7. Concrete finite-state word functions in the pinned FP algebra

Let enc(q) be the33-bit state encoding from Section2. Enumerate the finite state set in the fixed order Start,Done,Bad, then stack length1..7 and lexicographic frame tuples. This enumeration is finite, explicit and duplicate-free. It may be large; no practical small table size is claimed.

For each b in Bool define a TOTAL bitstring transition function t_b(s) by a finite nested equality cascade over this enumeration:

    if s=enc(q_0) then enc(delta(q_0,b))
    else if s=enc(q_1) then enc(delta(q_1,b))
    ...
    else enc(Bad).

This is a precise expression built only from finitely many equality tests and constant words. Its value on every raw s is33 bits, and on enc(q) it is enc(delta(q,b)); on invalid codes it is enc(Bad). No unrestricted decoder is assumed to lie in FP.

Each equality test is the actual eqFlagFn_mem_FP applied to id_mem_FP and constFn_mem_FP(enc(q)); its output is [true] on equality and [false] otherwise. Each branch uses Cobham.selectHeadFn_mem_FP with constant then branch and the recursively constructed else branch. Induction from the final constant Bad leaf therefore proves t_false in FP and t_true in FP. This is a finite derivation in the pinned algebra, not a generic unproved DFA-to-TM theorem.

The recFold argument structure is exactly pair(pair W state) tail. Let

    extract(z) = pairSnd(pairFst(z)),
    A(z) = t_false(extract(z)),
    B(z) = t_true(extract(z)).

The actual fstBlock_mem_FP, sndBlock_mem_FP and mem_FP_comp prove extract,A,B in FP. These functions ignore W and tail but have the right total behavior on EVERY packed or malformed argument. Every result still has length33 because each transition cascade has only33-bit leaves.

Let E(z)=enc(Start) and let p be the constant natural polynomial33. The existing theorem Cobham.recFoldClamp_mem_FP gives the concrete function

    F(z)=recFoldClamp A B 33 enc(Start) (pairFst z) (pairSnd z)

in FP. There is no new state-bound field. Induction on any word t proves that recFold A B enc(Start) W t has length exactly33 for ALL t and ALL W: the base does, and both step functions always output a33-bit constant. This proves the STRONGER universal length premise demanded by recFoldClamp_eq_recFold (all words of bounded length, not only reachable suffixes). Hence its clamp is vacuous for every W,t.

recFold processes the tail before the head. Therefore feed it the reversed input. Define

    packInput(w)=pair [] (List.reverse w),
    runCode(w)=F(packInput(w)).

reverse_mem_FP and pairFn_mem_FP with the empty constant prove packInput in FP, and mem_FP_comp gives runCode in FP. To check the direction, write foldLeft(delta,Start,w) for the chronological scanner. Induction on t gives recFold(A,B,enc(Start),W,t)=enc(foldLeft(delta,Start,reverse(t))). In the cons case the recursive tail has already consumed reverse(tail), and the outer step adds the head last; this is precisely reverse(head::tail)=reverse(tail)++[head]. Thus runCode(w) is enc of the scanner state after w, using reverse(reverse(w))=w. No erroneous right-to-left grammar is being recognized.

Finally define the EXACT word flag

    strictCNFFlag(w)=selectHead(eqFlag(runCode(w),enc(Done)),[true],[]).

The existing equality and branch FP combinators prove strictCNFFlag in FP. Its output is [true] exactly when runCode equals enc(Done), otherwise []; injectivity of enc and Section5 give TARGET. Thus this is an explicit same-function FP expression derived mathematically from actual APIs, not 'some decision function' with unspecified malformed outputs.

## 8. What the FP theorem supplies, and the kernel boundary

The imported recFoldClamp_mem_FP internally constructs an exact polynomial ruler, bounded iteration and a concrete TM witness. Its conclusion is the actual FP defined by existence of a TM k with ComputesInTime and a polynomial BigO bound. Applying its conclusion and the finite composition derivations above supplies that existential witness for the expression strictCNFFlag without assuming equivalence to the earlier prose scan-model machine. The expression is instead built directly in the library's proved function algebra.

This mathematical application of existing Lean APIs is not yet a kernel-checked theorem in this repository. The required minimal source pair would define the sixteen frame constructors, finite states/33-bit encoder, transitions and finite cascade, then prove the transition invariant, TARGET, fixed-length bound and exact FP composition above. No such uncompiled module is added during the compiler pause. A successful build with source/provenance checks is still required before calling this a locally certified parser theorem.

The flag recognizes canonicality; it does NOT materialize the decoded CNF, sorted variable views or folded row. Once an exact row rule is implemented, the flag can gate its total output: selectHead(strictCNFFlag w, producer w, wire(NO)). Existing FP branching proves the gate only if producer already has its own FP proof. The original tuple/tape clocks, finite selected-view construction, shared address rows and RHS assembly still need their same-function entryFn/Materialize proofs. This artifact neither assumes them nor asserts the complete dyadic function is now in FP.

## 9. Exact source/API locations and disclosure

Pinned library root is certifications/realizable-hardness/.lake/packages/complexitylib at6c248df7859f2f245e731c1e07057bf69d165fe2. Exact definitions read for this derivation:

- Complexitylib/Encoding/Data.lean: Data.toBits and fromBits semantics.
- Complexitylib/Encoding/DataEncode.lean: Bool/list/pair/Nat instance equations and bitstring injection.
- Complexitylib/Encoding/BinaryNat.lean: minimal least-significant-first canonical digit convention.
- Complexitylib/Classes/P/Cobham/Internal.lean: recFold lines330ff, recFoldClamp338ff, selectHeadFn_mem_FP191ff, recFoldClamp_mem_FP938ff and recFoldClamp_eq_recFold981ff.
- Complexitylib/Classes/P/Cobham/Internal/Reverse.lean: reverse_mem_FP306ff.
- Complexitylib/Classes/Containments/Internal/FPBridge.lean: eqFlagFn_mem_FP125ff.
- Complexitylib/Classes/P/Composition.lean: mem_FP_comp.
- Complexitylib/Classes/PCP/Internal/DataScan.lean: actual packed state projection and use of recFoldClamp; its arbitrary-child scanner is NOT asserted to validate this grammar automatically.
- Complexitylib/Languages/Balanced.lean: its header and definition confirm that equal counts alone are its language; it is not used as a parenthesis theorem.

The current raw hashes and normalized-pinned comparisons are recorded in the table below. Source metadata is not a new build acceptance.

Incidence identified the fixed-depth scanner route and root authorized this bounded concrete transition derivation. The author supplied the exact frames, transition cases, canonicality invariant and finite FP cascade here. A distinct review must check the all-word invariant, role depth, return flags and fold direction before archival acceptance. This is a reusable prerequisite toward the same total producer, not a novelty or full-proof claim.

| Path within library | Raw SHA256 | Normalized equality to pinned Git |
|---|---|---|
| Complexitylib/Encoding/DataEncode.lean | 5fe45322139611eb24cdcb58e2a03db8056ea62f0231606fed7accd0e7524e97 | verified |
| Complexitylib/Classes/P/Cobham/Internal.lean | 7e1cc7e6efce97d8e57435e5121972cc19bb6b0192bacdd8c350cfe72a044033 | verified |
| Complexitylib/Classes/P/Cobham/Internal/Reverse.lean | 27cc98e7d96b4f764e2a243566db49711b99c9ada4cf36cb5a3f5f201024f353 | verified |
| Complexitylib/Classes/Containments/Internal/FPBridge.lean | f65eebfd519f2964f02075e19ba1b58bc4f1db3fe4ecc3bb255799d324a0b07e | verified |
| Complexitylib/Classes/PCP/Internal/DataScan.lean | 25ab298e68f8706bbe15e586fd52f7fabf1a2b15e6d8f009df4fb5e21ad22ce5 | verified |
