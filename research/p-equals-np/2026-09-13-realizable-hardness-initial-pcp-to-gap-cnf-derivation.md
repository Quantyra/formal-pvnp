# Initial fixed-gap ordered 3CNF from the actual constant-query PCP theorem

2026-09-13. S3132/S3137, formal-pvnp. This proves the finite gap-preserving conversion and its uniform polynomial algorithm from the actual pinned PCP theorem. It neither assumes a new PCP/gap certificate nor claims this specialization has been compiled. No Lean modules, compiler, Git, paper or public actions are part of this increment. The existing initial-gap literature route applies.

## 1. The precise missing specialization

The preserved primary Hastad author text, Theorems2.22 and2.24 on printed pages10--11, derives fixed-gap E3CNF from the constant-query PCP theorem and additionally imposes exactly five occurrences per variable. Our downstream ordered-triple source accepts repetitions and arbitrary degrees; the latter strengthening is unnecessary.

The actual library theorem is Complexity.PCP_theorem in Classes/PCP.lean:

    NP = union over r=O(Nat.log2), Constructible r,
         q=O(1), of PCP r q.

Its forward proof calls exists_pcp_of_mem_NP, not a caller's gap hypothesis. Expanding PCP in Defs gives a nonadaptive PCPVerifier V with the following ACTUAL data: positions(x,coins) and an FP function returning their DataEncode bitstring; a verdict language in P; QueryBounded q on every x and coin word; completeness1 and soundness1/2 for uniform strings of exactly r(|x|) coins. Constructible r provides an FP function writing that exact randomness length in unary. These requirements include the necessary uniformity.

The existing PCP/Internal/PCPtoSAT.lean is not this gap reduction. It uses per-slot variables, adds equality clauses between pairs of slots reading the same proof position, and proves satisfiability equivalence. Its O(4^r q^2) consistency clauses can dilute the fraction of rejecting-coin clauses. We reuse its elementary blocking-clause idea but use ONE shared variable for each ACTUAL proof position instead. We prove the quantitative gap and exact3 conversion explicitly below. No equality-consistency penalty or unproved expansion argument is used.

Fix any language L in NP, and instantiate the proved PCP theorem at this L. SAT is a permitted instance via the actual Complexity.SAT.language_mem_NP theorem in SAT/Headline.lean; this gives the initial SAT-to-gap reduction, without requiring a language-independent constructor for every possible NP verifier. All constants below may depend on the fixed L/verifier, never on its varying input x. The result required here is a fixed positive gap for SAT, not the stronger universal constant/degree promise in the primary source.

## 2. Global constants, finite exceptions, and actual effectivity

Let n=|x|. The eventual bound q=O(1) yields a fixed finite tail bound and a finite threshold. Taking the maximum of that integer tail bound and the finitely many values q(0),...,q(n0-1), and increasing it if needed, gives a constant Q>=1 with

    |V.positions(x,c)| <= q(n) <= Q for ALL x,c.

This is a finite maximum, not an algorithm that evaluates a possibly nonconstructible q on its input. The resulting machine hard-wires Q; it never computes q. Thus the finitely many small input lengths are covered, rather than discarded by an asymptotic claim.

Likewise r=O(Nat.log2) implies there is a fixed integer a>=1 such that for every n,

    r(n) <= a*log2(n+2)+a,
    R_n=2^r(n) <= 2^a*(n+2)^a.                         (COINS)

Here log2 in the display is the real logarithm. To obtain a, bound the eventual constant by an integer, use floor(log2 n)<=log2(n+2) on the tail, and enlarge a to dominate the finite initial values of r. These are constants selected once from the theorem witnesses. Constructible r is essential: its actual FP machine computes the unary word of length r(n), so enumeration knows when to stop. We do not infer computability from the bound alone. At n=0 or r(n)=0 the same statements apply, with one empty coin word when r(n)=0.

Unpack positions_mem to select one fixed machine for f_pos in FP, whose output on the actual paired input is DataEncode of the position list. Unpack verdict_mem using P and DTIME to select a fixed deterministic decider for V.verdict. On an input (x,c,bits), run that decider on the EXACT library word pair(pair x c) bits. It returns acceptance or rejection; no infinite truth table or oracle for the verdict is needed. Query selection precedes answer enumeration and is independent of those answers, as required by the actual PCPVerifier definition.

All existential selections here are once per L, as in a polynomial reduction existence theorem, and are selections of machines/constants already supplied by proved theorem membership. We do not promise an effective meta-algorithm extracting a machine from an arbitrary proof of L in NP. The finite program for the selected machines on every x is given below.

## 3. Shared query labels and rejecting transcripts

Enumerate all r(n)-bit strings in any fixed computable lexicographic order. For a coin c let p_c=(p_1,...,p_k) be the actual ordered position list, with 0<=k<=Q. Repeated positions remain repeated entries. The old proof bit at position p is represented by the output variable with Nat label 2p. Multiplication by two is a binary shift, and it reserves odd labels for private gadgets.

For every answer vector b in Bool^k, run the actual verdict decider. If it rejects, form the ordered clause

    D_(c,b) = (X_(2p_1) XOR b_1) OR ... OR (X_(2p_k) XOR b_k).     (BLOCK)

The target literal convention is (label,negationBit), evaluated as value XOR negationBit. Thus the target literal sign is b_i. The library SAT.Lit convention is different: it tests equality to its sign, so its corresponding literal sign is NOT b_i. This explicit translation prevents complementing the output predicate inadvertently.

For a fixed assignment alpha to all even labels, let b^alpha_i=alpha(2p_i). BLOCK is false iff b=b^alpha, including repeated positions. Every inconsistent vector assigning different values to the same repeated proof position has a tautological blocker; it causes no soundness problem and may simply remain in the output. There is no assumption that the queried positions are distinct and no deduplication of coin/answer occurrences.

For k=0 there is one answer vector, and its blocker is the empty, false clause when the verifier rejects it. That case is handled by the explicit contradictory gadget below, not omitted.

## 4. Exact-three gadget with occurrence-private variables

For each rejected occurrence(c,b), independently convert its ordered width-k clause D with literals l_1,...,l_k into ordered triples H(D). Take fresh private variables belonging only to this occurrence.

- k=0: use (z,z,z) and (NOT z,NOT z,NOT z). Exactly one is false under every value of z.
- k=1: use (l_1,l_1,l_1).
- k=2: use (l_1,l_2,l_2).
- k=3: use (l_1,l_2,l_3).
- k>=4: introduce y_1,...,y_(k-3), and use

      (l_1,l_2,y_1),
      (NOT y_j,l_(j+2),y_(j+1)) for j=1,...,k-4,
      (NOT y_(k-3),l_(k-1),l_k).

There are k-2 triples in the last case. In every case the number h(k) of triples is positive and at most B=Q+2. Every triple has EXACTLY three literal positions; repetition is allowed by the downstream input type.

For every fixed assignment to the original variables, the following two properties hold:

    D true  -> there exist private bits satisfying all of H(D);
    D false -> every private assignment falsifies at least one clause of H(D). (GADGET)

The first three positive-width cases are immediate by repeating literals. For k>=4, when D is true choose y_j=true iff all of l_1,...,l_(j+1) are false. The first triple holds because y_1 covers the all-false first two literals. An internal triple holds because y_j=false satisfies its negation, or else the next literal is true, or else y_(j+1)=true. The last triple holds because either the initial k-2 literals contain a true one, making y_(k-3)=false, or one of the remaining two is true. Conversely if all original literals are false, satisfying the first triple forces y_1=true, and every internal triple successively forces the next y true. The last triple then fails. This proves that some triple must fail under any private assignment, without claiming a particular triple fails independently of the private choices. For k=0 the first implication has a false premise and the second follows from the opposite unit triples.

Fresh labels are explicit, not a finite-choice premise. Let t be the coin's enumeration index, e the answer vector's index among the length-k vectors, and j the private index used in that gadget, 0<=j<B. Assign it

    2*((t*2^Q+e)*B+j)+1.                                (FRESH)

Since e<2^k<=2^Q, uniqueness of successive quotient/remainder operations proves these labels are distinct between every different occurrence/private index. They are all odd and hence disjoint from every shared label2p. The variable z of k=0 uses j=0. Unused private indices are harmless. This construction uses binary arithmetic with O(log(R_n)+Q+log B) digits, not enumeration up to a queried position value.

## 5. The complete ordered output and nonzero denominator

For each coin c emit first the tautological triple

    (X_0, NOT X_0, X_0),

then, in answer enumeration order, all triples H(D_(c,b)) for the rejected answer vectors. Use fixed order within each gadget. Concatenate the per-coin lists in coin enumeration order to obtain Phi_x, a list of right-associated triples of (Nat,Bool) literals in the exact CNF type accepted by the dyadic source.

The tautology is included for EVERY coin, not just in a global empty case. It is always satisfied even if position0 was never queried. It ensures a nonempty formula and makes the denominator bound uniform when every transcript is accepted. Write

    C=1+B*2^Q,             eta=1/(2C)>0.

If M is the number of output clauses, then

    R_n <= M <= C*R_n.                                   (SIZE)

Indeed each coin contributes its tautology and at most2^k rejected blockers, each with at most B triples. Every output clause occurrence is retained, including tautological blockers caused by repeated positions and coincident triples from different coins. Neither clauses nor labels are normalized in a way that could change their count. Different blocks remain different positions of the output list.

## 6. Perfect YES completeness and constant NO gap

Suppose x is in L. Actual PCP completeness gives a finite proof pi whose acceptance event has probability1. The event is a subset of the finite set of R_n equally likely coin strings, each having positive mass1/R_n; thus EVERY coin accepts pi. Set the shared even variables alpha(2p)=pi.getD(p,false). For every rejected transcript b, it differs from the actual answers on that coin, so BLOCK is true. GADGET extends alpha to satisfying private values for that occurrence. FRESH makes these extensions compatible across all rejected occurrences. All per-coin tautologies hold. Therefore Phi_x is satisfiable, with value exactly1.

Suppose x is not in L, and take ANY assignment alpha to every output label, including private labels. Only finitely many original proof positions occur. Let Pmax be their maximum, if any. Construct a finite proof pi of length Pmax+1 with pi[p]=alpha(2p) for every used position p (fill other entries arbitrarily). If there are no queried positions, take the empty proof. This is a semantic witness used to apply soundness; the reduction never constructs this potentially huge proof and never loops up to Pmax. The library allows finite proofs of arbitrary length; no claim that the maximum queried numeric position is polynomial is needed.

For every coin, V's actual answer vector on pi equals b^alpha. PCP soundness says at least R_n/2 coins reject pi, as a real inequality on the integer number of rejected coins. For each such coin, its actual vector appears among the enumerated rejected transcripts, and its BLOCK is false. By GADGET at least one triple in that occurrence's gadget is false under alpha, whatever its private values. Gadgets for different coins occupy disjoint OUTPUT OCCURRENCE ranges, so these failures count separately even if some clause contents coincide. Thus

    falseClauses(Phi_x,alpha) >= R_n/2,
    falseClauses(Phi_x,alpha)/M >= R_n/(2M) >= 1/(2C)=eta.

Since SIZE ensures M>0, division is justified. Therefore EVERY assignment satisfies at most1-eta of Phi_x. The argument covers repeated queries, zero-query coins and r(n)=0. In the last case NO soundness forces the unique coin to reject, and the displayed integer inequality remains valid. There is no randomized assignment loophole: averaging cannot improve the maximum of finitely many relevant deterministic assignments, and the established inequality already holds pointwise for each assignment.

We have proved the initial promise gap actually needed downstream:

    x in L     -> Phi_x satisfiable;
    x notin L  -> OptSat(Phi_x)<=1-eta;
    Phi_x is a nonempty ordered exact-three-literal CNF.    (GAP)

No bounded-occurrence or distinct-label condition is needed or asserted. This avoids importing the stronger five-occurrence clause/variable marginal identity of Hastad2.24.

## 7. Genuine polynomial algorithm on all input words

The algorithm does not take query sets or truth tables as input. On x it executes:

1. The selected Constructible-r machine to obtain r(n) in unary.
2. A length-r(n) bit counter to enumerate each coin word, including the empty word when r(n)=0.
3. The selected positions FP machine on the actual pair(x,c), obtaining its encoded ordered list of Nat positions. Parse its guaranteed canonical DataEncode result into canonical binary digit records, retaining duplicate entries. This uses the strict tree/Nat parsing routine already derived; no malformed-output branch can occur for this theorem-supplied subroutine on these inputs.
4. Enumerate the at most2^Q vectors of the actual list length k. For each run the actual deterministic verdict decider on pair(pair x c)b. Upon rejection write the explicit gadget with FRESH private labels. Write the tautology for this coin as specified.
5. Serialize the accumulated ordered triples with DataEncode at CNF, not SAT.CNF.encode's different token grammar. This output is directly canonical input to the dyadic raw producer of archive643023c.

Here is an explicit polynomial domination argument from the ACTUAL machine witnesses. Enlarge constants across their finite exceptional input lengths so all three subroutine runtimes/output lengths are at most p(z)=c(z+1)^d for some fixed integers c,d>=1. Such p exists because FP and DTIME give actual total machines with eventual polynomial time. For a finite set of shorter lengths there are finitely many input strings; totality gives a finite maximum runtime, absorbed into c. This is a proof of a global bound, not an executable SAT test or a choice depending on x.

From COINS, r(n) is O(log(n+2)); even the loose bound r(n)<=2a(n+2) suffices for every subroutine input length. Actual pairing satisfies |pair(s,t)|=2|s|+|t|+2. Consequently |pair(x,c)| and |pair(pair x c)b| are at most

    z(n)=10(a+Q+2)(n+2).

Their selected machines take at most p(z(n)) steps and emit at most that many bits, after enlarging c for a constant output overhead if needed. A queried position's binary digit width is at most the length of its encoded list, so at most p(z(n)). The label2p has at most one more digit, including the zero case. Private labels have at most

    2+r(n)+Q+ceil(log2 B)

digits, since t<R_n and e<2^Q. A per-coin output has at most C triples, each with three labels of polynomial digit width and three signs. Its full Data tree encoding therefore has length bounded by a fixed constant times C*(p(z(n))+r(n)+Q+B+1).

All extra operations are explicit binary counters, scans, comparisons, shifts, constant multiplications/additions for FRESH, and writes of framing/Bool nodes. Constant multiplication can be executed by B repeated binary additions (B fixed); the input-length-dependent multiplication t*2^Q is a Q-bit shift. Reusing the finite scan implementation in archive643023c, these operations take at most a polynomial in the total current record length per coin. There is no unit-cost arithmetic on unbounded values. One conservative total bound, after expanding those scans, is

    K0*(R_n+1)^3*(p(z(n))+r(n)+Q+B+1)^6,                (TIME)

for a constant K0 depending on the three selected machines and Q. To justify this deliberately loose expression: per coin there are at most2^Q verdict calls and O(CQ) gadget/counter operations; ordinary bit copying/decoding of a p(z(n))-bit position output can be bounded by its square; scan-based buffer access can in the worst case scan the accumulated R_n times that per-coin length for each copied bit. Counting O(R_n) coin iterations and two such full scan factors yields at most (R_n+1)^3; six powers of the per-coin length cover parse records, binary arithmetic and scan/reset overhead. All omitted factors 2^Q,C,Q and fixed subroutine controller transitions are constants incorporated into K0. Alternatively append-only output avoids these scans, but that optimization is not needed. COINS makes TIME a polynomial in n for the fixed verifier. Output SIZE and binary widths separately show polynomial output length.

Thus Phi_x is an actual uniform polynomial-time reduction in the stated ordinary bit-machine sense, based on machines supplied by the pinned PCP theorem. Its SAME equality to the ordered construction in Sections3--5 is proved by induction over the explicit coin/answer loops. It is not a formula chosen nonconstructively according to whether x belongs to L, and the only decider run is the already supplied local verdict decider on constant-query transcripts.

No new Lean assertion of the composed function's library FP membership is made. The actual subroutine witnesses belong to that library, but encoding this composition, its target DataEncode conversion and GAP as a kernel theorem remains formal work. This distinction does not remove the uniform finite algorithm just proved.

## 8. Exact join to the accepted folded source and remaining proof boundary

For SAT choose its PCP witnesses once and hence the fixed eta above. Fix b>=2 and then choose

    u>=ceil(648000(b+2)/eta^3).

The constant can be very large but is independent of the SAT input. GAP makes every output Phi_x nonempty. The accepted typed dyadic construction maps its satisfiable YES case to source optimum exactly1-2^(-b), and its NO case to optimum at most5/8, including its global empty-domain branch. The raw producer in archive643023c receives exactly enc_C(Phi_x), so its malformed fallback is never used in this composition. All runtime exponents of the two fixed machines are constants; composing their polynomial bounds with the polynomial intermediate output bound remains polynomial. This establishes the finite mathematical initial-gap join that earlier notes correctly left open.

This does not independently re-prove the entire Dinur PCP theorem or certify its compiled dependency closure. It uses the ACTUAL proved library theorem as the named foundation, after inspecting its statement and the verifier/machine definitions, rather than adding a theorem field assuming PCP. The existing foundation's source identity and prior acceptance boundary must be preserved in an eventual kernel assembly. There is no new build/provenance acceptance in this note.

What remains: formalize this shared-position/gadget/DataEncode specialization, connect its actual machine to the pinned FP API, complete kernel checking of the finite Fourier/repetition/upstream producer proofs, and join the downstream regularizer with its exact gap/runtime constants. The initial bounded-degree E3CNF strengthening and a fresh generic PCP wrapper are NOT additional requirements for our source. No complete-paper Lean theorem, publication or novelty claim follows from this increment alone.

## 9. Source evidence and review disclosure

Primary ancestry: C:/Users/Dan/AppData/Local/Temp/s3132-hastad-optimalinap.pdf SHA256864df36f2bc692e47f1c94aff0afec34297e27116a5d76f204199e9ce098fa64, preserved layout text SHA2560b771d4539401742c0c41a89a201c318e6557ab6aada7de60df69610614bfe91. Theorems2.22/2.24 and Remark2.23 were read at layout lines442--471. The existing source extraction note of2026-09-12 was also read; its stronger bounded-occurrence initial interface has since been removed by the accepted actual position-game/source derivations.

Actual package is certifications/realizable-hardness/.lake/packages/complexitylib, pinned6c248df7859f2f245e731c1e07057bf69d165fe2. Files read for this increment:

- Complexitylib/Classes/PCP.lean, current raw SHA256ab845c87fe132d54e1c9f9d80b66af2965f5244cae98db52a3ae1d502ec620b0: actual PCP_theorem and its proof calls.
- Complexitylib/Classes/PCP/Defs.lean, current raw SHA2566bdbec9ec7c2f775847b868852b10c9699a764858ec4e9e954b33df081b34e31: positions_mem, verdict_mem, QueryBounded, finite-proof Accepts, PCP and Constructible.
- Complexitylib/Classes/PCP/Internal/PCPtoSAT.lean, current raw SHA256e6b864e91c42084233ca5b3d67346c4f15c01ab926cd99c45874577265fbe65c: existing per-slot/consistency construction and satisfiability scope, not the quantitative map above.
- Classes/P/Defs.lean and Classes/Time.lean: P/FP/DTIME membership exposes actual total deterministic machine/time witnesses, used in Sections2 and7.
- PCP/Internal/AlgGapAll.lean and AlgGapCSP.lean were inspected for the existing constructive gap-graph ancestry; no new generic gap-graph wrapper is introduced.

The three PCP files above were also compared against their exact pinned Git blobs after CRLF-to-LF normalization, with equality in each case. Their frozen-blob SHA256 values, in the same order, are64d168ebdaad115180303a59b8a8e236d64acc2d223da3cb828d21ce8018080f, db2ce1bae7fc2c94ecddc253c4ce1f5c8e8233b61400d3f75ab0eaab037bdbf7, and8f71fe43372a9ba128a54673fb55201c61e2a02a0490fb77436fbf9275fd3efa. SAT/Headline.lean was read in full: language_mem_NP is proved from the actual verifier and guess-and-verify construction; its current raw SHA256 is b39546ceaecb4fdf838999dfc14fe59ca8f4b81a80671fed1770e16fc85c7149. The SAT input language uses its existing serialized CNF syntax; our OUTPUT deliberately uses the different DataEncode CNF syntax required downstream, so the two encodings are not silently identified.

Accepted target interfaces are the typed source join bb68fa567d9787195237a949da418942948ee369 (derivation SHA256bdaf52f2284a72f9c33c533c44e3649ef7b07c762ae02f9ef528ee3a098ed563), and raw algorithm archive643023cc7aeb9c8fe39b0f347aceb35da9d0638f (derivation SHA25675b5f66e7dc6543c25e7f5972d53e52e7e05411d2bee32c703fe07d205efc606). Those notes' finite-math/scan-model status is unchanged.

Incidence and root supplied the route check that actual PCP already exists, and incidence highlighted the per-slot consistency dilution and shared binary-label alternative. The author wrote the full gadget, gap and uniformity derivation here and authored the target source notes; these shared contributions are disclosed. Independent review should bind the complete candidate, particularly arbitrary-assignment soundness with sparse proof positions and the small-input effectivity argument. No compiler or claim of novel inapproximability is involved.
