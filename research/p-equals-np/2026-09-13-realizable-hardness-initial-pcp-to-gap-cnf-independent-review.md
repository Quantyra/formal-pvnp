# Independent review: actual PCP to fixed-gap ordered 3CNF

2026-09-13. S3132/S3137, formal-pvnp. Bounded verdict: GO for the finite mathematical specialization and ordinary uniform polynomial algorithm from the named library PCP theorem. No new kernel closure, extracted transition table, or composed library FP theorem is certified.

Exact candidate: 2026-09-13-realizable-hardness-initial-pcp-to-gap-cnf-derivation.md, SHA256 a4c4174a80dc54c1676b550979f55a4a95839d8d55f8f81050b9812d0f6b4f46, 23373 bytes. I read the complete candidate, rehashed its actual bytes, and independently checked the concrete library definitions below. I did not author this derivation or contribute its shared-position route. I previously authored separate normalization/lookup and downstream draft modules and reviewed the target raw-runtime/Fourier/repetition notes. That prior involvement is disclosed; this is an independent review of the new initial-gap argument, not an independent reproof of Dinur or fresh build acceptance of its ancestry.

## 1. Actual import contract, not an assumed gap

Classes/PCP.lean proves PCP_theorem as a union over r with eventual logarithmic bound and Constructible r, and q with eventual constant bound. Its forward implication calls exists_pcp_of_mem_NP. SAT/Headline.lean supplies SAT.language_mem_NP through its actual verifier and guess-and-verify construction. There is no new field assuming a gap language in the candidate.

PCP/Defs.lean has precisely the required quantifiers. positions_mem supplies one f in FP and equality on pair x coins for EVERY pair of words. The positions list depends only on those words, never on answers. QueryBounded holds for every input and coin word. verdict_mem puts one verdict language in P; Accepts tests pair (pair x coins) (positions.map (proof.getD _ false)). Completeness and soundness range over exactly r(input.length) coins, use finite proof lists, and respectively give probability 1 and at most 1/2. Constructible r is the actual function x -> replicate (r x.length) true in FP.

P/Defs and Time definitions expose fixed machines, total time functions and eventual polynomial bounds. Models/TuringMachine.lean lines 529--539 make both DecidesInTime and ComputesInTime universal over ALL words, with a finite halting time bounded by T(length). Thus rejection and malformed inputs do not evade totality. The candidate selects these witnesses once for fixed L; it does not purport to compute witnesses from an arbitrary proof of membership. That is sufficient for existence of a fixed uniform reduction.

Finite initial lengths can be absorbed into constants Q>=1, a>=1 and a polynomial p. q is never evaluated by the reduction. r is evaluated by its constructible machine. Finitely many short input words have finitely many finite runtimes, so their maximum is legitimate. R=2^r <= 2^a(n+2)^a holds globally after enlarging a. Neither the finite maximum nor the machine selection depends on the varying input.

## 2. Exact sign, repeated queries, and private gadgets

The target literal evaluates value XOR negationBit. Its blocker with sign b is false exactly at answer vector b. Library SAT/Semantics instead tests equality to its sign, so the corresponding library sign is NOT b, as explicitly stated. PCPtoSAT.acceptClauses indeed uses the complemented sign; its separate consClauses enumerates pairs of query slots. The candidate does not inherit that consistency overhead.

The even label 2p is injective on actual proof positions. Therefore repeated queries use one bit automatically. A contradictory transcript at repeated positions has a tautological blocker; retaining it affects only the uniformly bounded denominator. Every actual answer vector occurs exactly once in its coin's answer enumeration.

For k>=4, the proposed private assignment y_j = 'all first j+1 literals are false' satisfies the chain exactly when the original disjunction is true. If all are false, either an earlier chain clause fails or the forced final y makes the last clause fail. This supplies at least one failure for every private assignment, which is the soundness property actually used. k=1,2,3 repeat positions correctly; k=0 emits opposite repeated unit triples and always has exactly one failure.

FRESH is injective because j<B and e<2^Q: recovering quotient/remainders recovers t,e,j. All these labels are odd, so they cannot collide with shared labels, including the padding label 0. Unused private slots do not matter. Different failed gadgets are disjoint list-occurrence ranges, even if their contents coincide.

## 3. Denominator and all-assignment gap

Every coin emits a tautology and at most 2^Q gadgets of at most B=Q+2 triples. Hence R<=M<=CR with C=1+B*2^Q, R>=1 and M>0. No deduplication changes this measure.

Perfect PCP completeness on a finite uniform set makes every coin accept the same proof. Every emitted rejected transcript then differs from its actual answers, and private extensions can be combined by freshness. This proves satisfiability.

For soundness, every target assignment determines values on finitely many used proof positions. A proof of length maxPosition+1 realizes them all. This semantic finite extension may be huge; it is NOT computed or enumerated by the reduction. Its existence suffices because PCP soundness quantifies over all finite proof lengths. Thus at least R/2 coins reject. Each contributes a false blocker and hence a false triple under any private assignment. Dividing by M gives at least 1/(2C) unsatisfied fraction. This establishes a fixed positive eta for the fixed verifier, without a bounded numerical maximum position assumption.

The definitions, not an informal library comment, are decisive here: the Defs comment suggesting a short contiguous proof from the number of queried slots does not by itself follow for arbitrary sparse numeric addresses. The candidate correctly avoids relying on that comment. It does not challenge the PCP theorem's actual forward statement or inspect its whole proof closure anew.

All zero/small cases survive: r=0 has one coin; k=0 is handled above; no queried positions uses the empty proof; n=0 is covered by the global constants. Randomized assignments cannot defeat a pointwise bound on each deterministic assignment.

## 4. Uniform output algorithm and precise runtime status

I checked the actual pairing grammar: pair doubles each bit of its first argument and appends a two-bit separator, followed by its second argument. Its length is 2|x|+|y|+2. Both position and verdict calls therefore have length at most the candidate's loose z(n). The constructible call on x is smaller still.

The position output is guaranteed to be canonical DataEncode of List Nat. DataEncode uses list nodes, two-child product nodes and Nat.bits; labels remain binary digit records. A shift implements 2p, including the canonical zero case. FRESH uses a fixed shift by Q and multiplication by fixed B, plus binary additions. No loop traverses the numeric magnitude of p. The private-label digit bound 2+r+Q+ceil(log2 B) is sufficient.

The output is the right-associated literal-triple list in the target DataEncode grammar. It is not library SAT.CNF.encode. On each arbitrary input word the chosen verifier subroutines terminate and give a canonical output formula. In particular, a malformed SAT-language word is a NO word by SAT/Language's existential serialized satisfiable-CNF definition; PCP soundness applies to it without any syntactic promise. The downstream raw parser receives a canonical typed word and never needs its malformed fallback in this composition.

The TIME expression is a polynomial domination for a described bit algorithm, not a measured clock or a compiled transition theorem. It is defensible at that level: per coin there are constantly many local verdict calls and gadgets; their position records have length at most p(z); list framing and binary arithmetic require scans of polynomial-length records. With W=p(z)+r+Q+B+1, total stored data can be bounded by a fixed multiple of (R+1)W (a quadratic-record parser can also be absorbed in W^2). Sequential scan/copy/reset implementations take polynomial time; charging two full stored-data scans per elementary bounded record operation, across R coins, is dominated by a constant times (R+1)^3 W^6. Constants can include the fixed tape controllers and fixed 2^Q,C,Q factors. Simulating the finitely selected subroutines on reserved tapes with reset/copy overhead is polynomial as well. Output has polynomial bit length independently of that deliberately loose estimate.

Thus the algorithm-level existence claim is justified; the same ordered function follows by coin-loop and answer-loop invariants. There is no explicit composed TM transition object in this note, no newly extracted executable for the selected existential witnesses, and no proof that this exact function belongs to the pinned FP class. Calling TIME a fresh exact transition witness would exceed the evidence. The candidate expressly leaves that assembly open, so no repair is required for its stated scope.

## 5. Downstream join and scope

For fixed SAT witnesses, eta=1/(2C) is fixed. Choosing b>=2 and u>=ceil(648000(b+2)/eta^3) is independent of the SAT input. The accepted typed source theorem applies to the actual nonempty output Phi_x: satisfiable inputs yield optimum exactly 1-2^(-b), and NO inputs yield at most 5/8, including its empty-conditioning branch. The raw producer is applied to its exact canonical input word. Composing the polynomial output-size and time bounds remains polynomial, although the constants and degrees may be enormous.

This closes the previously missing initial finite-mathematical gap specialization from the named PCP foundation. It does not re-prove or revalidate that foundation's complete compiled ancestry, establish a bounded-occurrence strengthening, finish the downstream regularizer, or complete the paper's Lean theorem. Formalizing the exact specialization and composition in the pinned FP APIs and kernel checking the newer finite derivations remain substantive work. No novelty claim follows.

## 6. Exact local evidence

Actual files under certifications/realizable-hardness/.lake/packages/complexitylib/Complexitylib, raw SHA256 checked during this review:

- Classes/PCP.lean: ab845c87fe132d54e1c9f9d80b66af2965f5244cae98db52a3ae1d502ec620b0.
- Classes/PCP/Defs.lean: 6bdbec9ec7c2f775847b868852b10c9699a764858ec4e9e954b33df081b34e31.
- Classes/PCP/Internal/PCPtoSAT.lean: e6b864e91c42084233ca5b3d67346c4f15c01ab926cd99c45874577265fbe65c.
- SAT/Headline.lean: b39546ceaecb4fdf838999dfc14fe59ca8f4b81a80671fed1770e16fc85c7149.
- Models/TuringMachine.lean: 20d5709e35ec90d8c645726aa270eb9544dee38e1a6b5e7449af5b556a77fc2f.
- SAT/Semantics.lean: 0d9b4893ffc6826f57619019bbd6c96b01b3b543a74dc2c1ff144e727c61b139.
- SAT/Language.lean: e765b77ebfad6aa136879808c3c0868b973f06c3512f52635cf3f78f01bb6c42.
- Encoding/Pairing.lean: 07c32714d6f7ec010efcf991e82903caf178d7c9543d2d79585b86625a769f4c.
- Encoding/DataEncode.lean: 5fe45322139611eb24cdcb58e2a03db8056ea62f0231606fed7accd0e7524e97.

These bind the actual API text inspected; they are not a fresh Git/pinned-blob or compiler acceptance. The candidate records the normalized pinned identities and accepted downstream archive references separately. This review made no candidate/source changes, ran no compiler or experiments, and performed no Git or publication action.
