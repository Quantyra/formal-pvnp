# Catalytic witness isolation: testing an oracle-free collision compressor

2026-09-12; S3090 / E004 / S008; [integrity](../../INTEGRITY-CLAIMS.md). **Selection NONE for the tested mechanism.** This note tests one proposed operation and its minimum-certification repair. It establishes neither a SAT algorithm nor a complexity separation. The counting argument and explicit reduction are elementary mechanism diagnostics, with no novelty or publication claim. The completed review outcomes are recorded below.

## Frontier, proposal and exact objective

The primary frontier source is [Arvind, Chakraborty and Datta, *Derandomizing Isolation In Catalytic Logspace*, December 2025, Theorem 3.2, Claim 3.3 and its reconstruction procedure](https://arxiv.org/html/2512.09374v1#S3). It reduces minimum-weight witness search to weighted decision in catalytic logspace. Its compression uses an element on which two **minimum** witnesses differ; reconstruction still queries weighted decision. Theorem 4.3 places SearchSAT in a catalytic class with two rounds of NP queries. The introduction states CL is contained in ZPP, with CL containment in P unknown. These source statements are not independently proved here.

**Single proposed replacement:** remove the weighted-decision calls by finding any two explicitly verifiable satisfying assignments u != v of equal weight. Select a coordinate e on which they differ, erase its weight, and reconstruct it from

    w_e = - sum_(i != e) w_i (u_i-v_i) / (u_e-v_e).       (1)

The denominator is +1 or -1. The equation is exact. The hoped-for mechanism was to share or regenerate witness/index data across weight blocks so that arbitrary verified collisions yield net clean storage without the NP oracle. It is the metadata regeneration and aggregate storage gain, not equation (1), that must be tested.

A complete oracle-free catalytic SearchSAT algorithm would give NP contained in ZPP using the cited upper bound; this would be a meaningful intermediate consequence, not P=NP by itself. A deterministic implementation returning a witness or correct UNSAT answer on **every** CNF, with a uniform polynomial bound on total time including restoration, would imply P=NP. Neither implication is achieved here. Removing this one oracle dependency would still leave discovery, successful isolation, full correctness and total-time obligations.

This is distinct from the parked PPSZ/quantum routes and the earlier purely space-preserving streaming reduction. No speedup is inferred from reduced workspace.

## First falsifier: arbitrary ties need not identify compressible weights

Fix the tautological n-variable CNF and positive integer weights w_i in [W], with W=2^b. Encode w_i-1 using exactly b bits, so all nb-bit strings are legal weight blocks. Every assignment is satisfying. There are 2^n assignments but only nW+1 possible integer subset sums. If

    2^n > nW+1,                                         (2)

every weight block contains two distinct equal-weight satisfying assignments. Nonetheless, the empty assignment is the unique minimum for every block, because every weight is positive. For example n=8 and W=16 give 256>129, covering all 32-bit weight blocks. This is a mathematical count, not an enumeration experiment. It continues asymptotically with polynomial W, for example W=2^ceil(log2 n).

Now take k independent blocks, B=knb total input bits, and fix the formula and clean initial auxiliary state. Suppose the proposed compression always reaches a common completed checkpoint with s designated catalyst bits clean, B-s remaining unrestricted catalyst bits, and at most a bits of other distinguishing state. Include selected witnesses/coordinates, metadata, branch history retained for restoration, heads, control, output if readable for restoration, and any clock information in that state budget. Any future deterministic restoration must recover the original B bits. The checkpoint map is therefore injective, giving

    2^B <= 2^(B-s+a), hence s <= a.                     (3)

Thus no positive **net** storage gain s-a is guaranteed over the full cube. An apparent small saving can be held in auxiliary storage; it is not net compression. Adaptive collision selection, cross-block sharing and rereading retained data cannot change injectivity. Variable checkpoint times supply no free side channel: if a decoder can access the time, that information belongs to its state budget.

For compression invoked only on a restricted set R of original catalyst strings, the correct scoped inequality is

    log2 |R| <= B-s+a,
    s-a <= B-log2 |R|.                                 (4)

This explicitly permits compression of structured or rare reached states. The contradiction applies to the proposed rule that *arbitrary collision existence alone* justifies a net gain, since that predicate is true on the whole cube in this example. A hybrid that recognizes the easy empty witness and exits on these inputs is not refuted. Its compression branch needs an additional restriction R and a decoder respecting (4); arbitrary collisions supply neither. This easy formula is not a SAT-hard family and does not refute the source algorithm, whose minimum-tie predicate is false here.

Equation (1) also identifies the operational debt: discarding u,v,e requires regenerating enough of them from the shortened record, while storing them must be charged. Checking F(u)=F(v)=1 and equal weight only certifies a collision; it does not make its identity available later for free.

## Repair test: require certified prefix minima

A natural repair in the **same compressor** is to demand that the two colliding witnesses minimize weight in the two slices at a marked coordinate e, optionally below a fixed assignment prefix. Then their minimum values determine the erased threshold uniquely. We test the strongest straightforward oracle-removal contract: given the CNF, prefix, coordinate, retained weights and the promise that they extend to a genuine minimum-tie record, restore the missing weight in deterministic polynomial total time. It suffices to test the empty prefix.

Here is an explicit reduction that keeps the formula and both slices satisfiable, so the difficulty is not a hidden empty-slice query. Let F(x_1,...,x_n) be any CNF with n>=1. Introduce z,y,r and define G_F by these clauses:

    (z OR r), (not z OR not r),                         [r = not z]
    (z OR y),
    (z OR not x_i)                  for every i,
    (not y OR not x_i)              for every i,
    (not z OR y OR C)               for every C in F.   (5)

The construction has linear overhead in the size of F and n; general CNF is the declared model. Set retained weights

    w_(x_i)=1, w_r=1, w_y=n+1,                         (6)

and erase w_z. Explicit satisfying assignments are available in both slices:

    z=0: x=0, y=1, r=1;
    z=1: x=0, y=1, r=0.                                (7)

At z=0, the clauses force exactly the first assignment, so its retained minimum is A=n+2. At z=1, r=0. The y=1 option forces x=0 and costs n+1. The y=0 options are exactly the satisfying assignments of F and cost their Hamming weights. Consequently the other retained minimum is

    B_F = n+1                         if F is UNSAT,
    B_F = min_(x satisfies F) |x| <= n if F is SAT.      (8)

The positive missing weight producing a tie of the slice minima is uniquely

    Delta_F = A-B_F in [1,n+2],
    Delta_F = 1 iff F is UNSAT,
    Delta_F >= 2 iff F is SAT.                         (9)

For **every** F the erased record is semantically valid: setting w_z=Delta_F creates at least one globally minimum witness in each slice. It is not necessary to construct this unknown original weight to supply the erased record. Thus a general polynomial-time threshold-restoration routine under precisely that semantic promise decides SAT by (9). Conversely, if P=NP, polynomially bounded slice minima can be found by polynomially many SAT queries and restored, so this broad restoration contract is equivalent to P=NP. This equivalence does not supply a solver or establish that such restoration is impossible.

The reduction separates witness reuse from minimum certification. Both witnesses (7) are given and cheaply checked. In the z=1 slice, the supplied fallback witness has minimum weight exactly when F is UNSAT. Therefore a sound polynomial-time verifier with polynomial-length certificates for **every** assertion that this fallback is minimum would imply UNSAT is in NP, hence NP=coNP. This is a conditional certificate consequence, not P=NP. A deterministic polynomial-time routine that decides or finds a complete such certificate on all these records would give P=NP. A verifier alone with incomplete certificate coverage has no such consequence.

The promise distinction matters: (9) proves hardness on all *semantically valid* erased minimum-tie records. It does not show these records lie in the image of a particular canonical compressor, or that its decoder is required to handle them. A route restricted to a smaller actually reached image may avoid this reduction. It must exhibit that restriction, count its metadata, produce it without the weighted-decision oracle, and bound every repeated verifier/read/restoration step in total time. No such restriction or implementation is supplied by the proposed operation; naming it would merely restate the gap.

## Decision and evidence boundary

The proposed oracle-free replacement is rejected in its tested universal form. Arbitrary witness collisions do not provide a compressible event; switching to general exact prefix-minimum restoration reinstates SAT in the decoder even when both slices have explicit witnesses. These are two tests of one compression operation, not two nominated research routes.

No experiment, Lean theorem, circuit lower bound, or general catalytic impossibility is claimed. The tautology diagnostic does not rule out hybrid algorithms; the threshold reduction does not cover unspecified reachable-state restrictions. No novelty is inferred from the derivation or a bounded literature search. The source's minimum-tie/oracle guarantees remain intact. Re-entry requires an explicit, costed reached-state restriction or other concrete decoder that avoids both tests, not another unspecified minimum lemma. Publication HOLD; broader objective unresolved.

Source access: full primary HTML Section 3, reconstruction and Section 4 plus introductory class bounds were inspected on September 12, 2026. The initially inspected source is v1 dated December 10, 2025. The [current record](https://arxiv.org/abs/2512.09374) identifies v3 dated February 6, 2026; its [Section 3](https://arxiv.org/html/2512.09374v3#S3) was additionally opened and confirms the retained-oracle search theorem, renumbered Theorem 3.3, and reconstruction contract. No superseded theorem numbering is attributed to v3. Its detailed proof is not independently verified here. A preliminary check of general deterministic isolation was discarded because the all-set-systems obstruction is already stated in primary literature; it is not presented as a discovered mechanism or result.

Baseline satellite HEAD: `559bd8b3599bf6a6afe937fb36b398a28fda16ec`, initially clean index/worktree. No destination AGENTS.md was present; the delegated satellite boundary and integrity file were followed. Only this research note is authored by this scout. No commit, push, release, outreach, paid computation or public artifact change.

## S3090 review closeout

| Lens | Actual record | Outcome and scope |
|---|---|---|
| Independent proof | [Proof review](2026-09-12-frontier-proof-review.md) | PASS for the two bounded mathematical rejection tests. |
| Source and complexity | [Selection/constructive-source review](2026-09-12-frontier-reselection-review.md); [structural source review](2026-09-12-frontier-structural-source-review.md) | GO for scoped source contracts, complexity consequences and structural source correction. |
| Independent non-claims | [Nonclaims review](2026-09-12-frontier-nonclaims-review.md) | GO for preservation and the scoped ledger entry; publication HOLD. |

The selection reviewer contributed mathematics and is not the independent proof lens. The proof reviewer is distinct and contributed no candidate mathematics; the structural source reviewer is distinct from the structural author. These are AI-agent reviews, not Lean verification, human peer review or novelty certification. Selection NONE for the two tested candidates; broader objective ACTIVE. The [S3090 ledger node](2026-09-11-research-meta-graph.md#s3090-reject-two-tested-frontier-operations) preserves their bounded rejection evidence. No public artifact is changed.
