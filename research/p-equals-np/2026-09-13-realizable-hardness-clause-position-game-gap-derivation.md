# Actual clause-position game: gap, multiplicities, and repeated questions

2026-09-13. S3132/S3137, formal-pvnp satellite. This note proves a finite classical two-prover game statement for the current structured CNF and folded-verifier interfaces. It does not prove parallel repetition, a gap-producing SAT reduction, encoded runtime, or a Lean theorem. No compiler, new Lean module, existing source-draft edit, Git, paper edit, or publication action is part of this increment. The supplied satellite routing and three-lens protocol apply; no AGENTS.md exists at the satellite or certification root. Independent repetition-contract review is separate.

## 1. Structured input and exact base game

Use the existing draft types `Literal := Nat * Bool`, `Clause := Literal * (Literal * Literal)`, `CNF := List Clause`. Fix phi of length m>0. Clause occurrence IDs are I=Fin m, literal positions are J=Fin 3, and `literalAt (phi.get i) j` is (v_ij,s_ij). Signs s_ij are negation bits. For a Boolean assignment sigma to the finite set N of all labels in phi, literal value is sigma(v_ij) XOR s_ij and the clause is the OR of its three literal values, exactly `literalValue` and `clauseValue`. True means satisfied. This treatment permits repeated clauses, repeated labels in one clause, repeated signs, tautologies, and arbitrary natural label sizes. No clause is deduplicated.

Let V_i={v_ij:j in J}. It is nonempty and has at most three elements. Define

    mult_i(v)=|{j in J:v_ij=v}|,  lambda_i=min_(v in V_i) mult_i(v).

Thus 1<=lambda_i<=3 and sum_(v in V_i)mult_i(v)=3. The assignment satisfaction fraction is

    Sat_phi(sigma)=(1/m)sum_i 1[OR_j(sigma(v_ij) XOR s_ij)].

The basic verifier samples (i,j) uniformly from I times J. It sends ONLY the occurrence ID i to the wide prover P1, and ONLY the label v_ij to the small prover P2. The literal position j is not sent to either prover. P1 returns a triple a=(a_0,a_1,a_2) of bits; P2 returns a bit b. It accepts exactly if all of the following hold:

1. a_j=a_k whenever v_ij=v_ik (local duplicate consistency).
2. OR_k(a_k XOR s_ik)=true (the chosen clause is satisfied).
3. a_j=b at the selected hidden position j (cross-prover consistency).

Condition 1 makes the valid triple exactly an assignment a:V_i->Bool, and conversely any such assignment gives a triple by lookup. It is checked independently of which position was selected. The alphabet is nevertheless the fixed eight triples for P1 and two bits for P2: invalid answers simply reject. This is an ordinary finite classical game. No quantum, entangled, communicating, or input-dependent shared-randomness strategies are considered.

Collapsing sampled positions to the label question produces the exact weighted distribution

    Pr[P1 question=i, P2 question=v]=mult_i(v)/(3m)

for v in V_i, and zero otherwise. Its marginal at v is its total literal-occurrence count divided by 3m. This is not generally the uniform distribution on distinct incident labels. Because accepted triples are locally duplicate-consistent, all positions mapping to (i,v) induce the same acceptance predicate: read the unique value assigned to v. Therefore the position experiment equals the usual weighted edge-question game pointwise after this pushforward, including multiplicity. Giving P2 the position or clause ID instead would define a different game and invalidate the global-assignment argument below.

## 2. Finite deterministic reduction

A deterministic strategy is a table a:I->Bool^3 for P1 and a table sigma:N->Bool for P2. All spaces are finite; hence the maximum winning probability over such tables exists. Denote this maximum by val(G_phi), defined from the actual predicate and probability above, not supplied as a premise field.

Randomized classical strategies do not increase it. To see this constructively at the probability level, condition first on the shared random seed, if any, which is independent of the verifier's questions. For each possible local question presample a private answer with its strategy's conditional distribution. Use independent private presampling between provers, conditional on the shared seed. This yields random deterministic tables. For each actual question pair their joint answer distribution agrees with the original strategy; summing the finite question law shows equality of expected acceptance. Consequently at least one deterministic table pair attains at least the randomized acceptance. Equivalently the acceptance is an average of deterministic acceptances, each at most their finite maximum. This also covers arbitrary correlated classical strategies implemented by question-independent shared randomness. It makes no assertion about nonlocal strategies.

## 3. Complete basic gap proof, with an exact stronger formula

Fix a deterministic small strategy sigma. Extend it arbitrarily outside N, if a total Nat assignment is desired; this does not affect any clause. If clause i is false under sigma, then every one of its three literals is false. For any wide answer, either duplicate consistency or clause satisfaction fails and rejection is certain, or the answer is a satisfying assignment to V_i. In the latter case at least one position must disagree with sigma; otherwise its three literal values equal the all-false literal values under sigma. A uniform hidden j detects that disagreement with probability at least 1/3. If clause i is true under sigma, the lower bound zero on rejection suffices. Thus for every wide table,

    Pr[reject] >= (1/(3m)) |{i:clause i is false under sigma}|
                = (1-Sat_phi(sigma))/3.                 (GAP)

There is no assumption that clauses or labels selected in this argument are independent beyond the actual single-round draw. In particular repeated positions remain separate equally likely detection events.

In fact the optimal wide response for fixed sigma is exactly computable as a finite mathematical expression. For a true clause, respond with sigma restricted to V_i and reject with probability zero. For a false clause, every satisfying local assignment differs on some label v, so duplicate consistency creates disagreements at all mult_i(v) positions for that label. Its rejection is therefore at least lambda_i/3. Choose a label attaining lambda_i and flip only its bit relative to sigma. Because the original clause was false, every occurrence of that label was a false literal; after the flip these occurrences are true and the clause is satisfied. No other label changes. The resulting response is consistent and its exact rejection probability is lambda_i/3. (If a label has both signs in the clause, that clause is a tautology and cannot enter the false-clause case.) An invalid wide triple rejects with probability one and cannot improve this optimum.

Since P1 observes i, these minimizing responses can be selected simultaneously, one per occurrence ID. Hence the exact repeat-aware value is

    val(G_phi)=1-min_sigma (1/(3m))sum_(i:clause i false under sigma) lambda_i.    (VALUE)

This formula proves rather than assumes the existence and value of an optimal local response. Let OptSat(phi)=max_sigma Sat_phi(sigma). Since lambda_i>=1,

    val(G_phi) <= 1-(1-OptSat(phi))/3.

In particular for 0<=eta<=1, the hypothesis that every assignment satisfies at most 1-eta of phi implies

    val(G_phi) <= 1-eta/3.                              (BASIC)

The same bound holds for every randomized classical strategy by Section 2. Eta=0 is the trivial upper bound one; division only uses m>0. Clause signs and occurrence multiplicity are included in both sides.

The factor 1/3 cannot be improved uniformly even on clauses with three distinct labels. Take three variables and all eight possible sign-pattern clauses on them, each exactly once. Every assignment falsifies exactly one of the eight clauses, so OptSat=7/8. Each lambda_i=1; equation (VALUE) gives val=1-1/24=23/24, attaining (BASIC) for eta=1/8. This is a direct eight-pattern counting example, not an experimental inference. Repeated-label clauses can have larger penalties: if all positions have one label then lambda_i=3. We retain the uniform 1/3 bound because it is the correct general interface.

## 4. YES and empty boundaries

If a global assignment sigma satisfies every clause, P1 returns its three values and P2 returns its value at the queried label. Duplicate consistency, satisfaction and agreement hold for every sampled (i,j); completeness is exactly one, with deterministic strategies. Conversely val(G_phi)=1 implies OptSat(phi)=1 by (GAP) and existence of an optimal deterministic strategy. Thus perfect value agrees with satisfiability for this finite game.

When m=0, there is no uniform draw from Fin m. Define the exceptional game to accept deterministically with no questions and value one, and define the empty formula's satisfaction fraction as one. Its YES completeness is valid. For eta>0 the soundness premise is false; for eta=0 the conclusion value<=1 is true. This convention supplies a total boundary but does not identify a nonexistent sampled-question law with a probability distribution. It corresponds to the separate zero-clause YES branch of the proposed source constructor. All subsequent nonempty question-law formulas explicitly assume m>0.

## 5. Actual u-fold question law: product positions, not uniform sets

For u>=0, the standard parallel repetition G_phi^(u) samples q:Fin u -> I times J uniformly, with each coordinate independent. Its mass at every q is (3m)^(-u). Write i_t=(q t).1 and j_t=(q t).2, with selected labels k_t=v_(i_t,j_t). It sends the ordered tuple (i_t)_t to P1 and the ordered tuple (k_t)_t to P2. P1 answers a triple a_t for each coordinate; P2 answers a bit b_t for each coordinate. The verifier requires the THREE conditions of Section 1 in EVERY coordinate t. A strategy may depend on its entire local tuple and may answer differently to repeated questions appearing in different coordinates; the parallel game imposes no extra cross-coordinate consistency.

The coordinate map q -> ((i_t)_t,(j_t)_t) is a bijection of the corresponding finite product sets. Pushing each (i_t,j_t) to (i_t,k_t) gives, for specified tuples i and k, the exact joint mass

    product_t mult_(i_t)(k_t)/(3m),

interpreting a missing label factor as zero. This is exactly the product of the base weighted question law, not a new product law on deduplicated variable sets. The number of preimage position tuples for fixed i,k is product_t mult_(i_t)(k_t), because the choices of positions with the required label are independent across coordinates. This proves the stated pushforward including repeated clause IDs, labels and rounds.

The draft's `Question phi u` is precisely q:Fin u -> (Fin phi.length * Fin 3). Its `smallView q` is the sorted set of k_t, its `wideView q` the sorted set of all v_(i_t,j), and `selectedSat q` the conjunction of the actual clauses i_t. Thus the probability law used by the Fourier soundness note is literally this outcome law when nu is uniform. Sorting/deduplication of views is a deterministic pushforward; no uniform distribution on resulting sets is asserted. In particular P2's tuple k determines U, and P1's clause tuple i determines W and h without access to j or k.

For u=0 there is one empty q, all conditions are vacuous, and the parallel game value is one. The draft has empty U,W, their unique assignments, and an empty conjunction h=true. These are legitimate nonempty assignment domains. An exponential repetition statement with exponent zero must also give one. Positive amplification uses u>=1.

## 6. Decoded assignments embed into the parallel game exactly

The accepted Fourier derivation at 398a3b5 constructs a small local decoder which, upon U, returns x in X_U, and a wide local decoder which, upon the clause tuple (or its determined W,h), returns y in D_q subset X_W. It uses independent private decoder coins from fixed shared proof tables. Because D_q depends on the clause tuple and not the selected positions, this is a legal pair of local strategies simultaneously for all q, not a per-joint-question choice.

Convert these into standard repeated-game answers by

    a_(t,j)=y(v_(i_t,j)),    b_t=x(k_t).

The wide answer automatically has duplicate consistency within every clause and even stronger consistency across all rounds; it satisfies every clause exactly because y belongs to D_q. Every selected cross-prover check is

    y(k_t)=x(k_t).

Since U is exactly the set of selected labels, the conjunction of these checks over t holds if and only if the actual restriction `restrictLocal U W y` equals x. For the forward implication, every coordinate of sorted U equals some selected label, by its defining finite-set membership property; for the reverse implication evaluate the function equality at the coordinate of k_t. Both lists are nodup and U is a subset of W, so lookup returns the actual matching coordinate. Repetition of k_t simply repeats the same equality. No injectivity of the map from W assignments to U assignments is needed.

Therefore, for every q and every realized decoded assignment pair, the repeated-game winning indicator equals the consistency indicator used in the Fourier decoder analysis. Averaging gives exactly the SAME success probability, not an inequality caused by changing questions. Fourier-selected y satisfies h, so there is no additional conditioning loss. The original proof's addresses may coincide when U=W; they remain reads of a fixed shared P, while the two decoder random choices remain independent conditional on local questions.

One may separately define an assignment-answer, set-question variant with the above restriction consistency check. Every strategy of that variant embeds as just described into standard repetition, giving

    val(assignment/set variant) <= val(G_phi^(u)).

Equality is not needed and is not asserted: the standard game can use tuple order/multiplicity and cross-round inconsistent answers unavailable to a single assignment on a set. This direction suffices to upper-bound all folded decoders by any valid soundness bound for the standard parallel game.

## 7. What can and cannot be concluded without parallel repetition

A satisfying global assignment wins every coordinate of every q, so repeated YES completeness is exactly one. Applying a deterministic base strategy independently in all coordinates gives value val(G_phi)^u as an achievable success probability. Consequently

    val(G_phi^(u)) >= val(G_phi)^u,

not the upper bound needed for hardness. General repeated strategies correlate their answers across coordinates through the full local question tuples. Nothing in Sections 1--6 proves equality or the desired exponential upper bound.

The valid conditional use of a repetition theorem is instead: once a theorem applicable to this finite weighted classical game establishes a bound R(eta,u) from (BASIC), the exact decoder embedding gives success<=R(eta,u). Combining with the already derived Fourier bridge, for 0<epsilon<=1/2 and positive correlation delta,

    4epsilon delta^2 <= val(G_phi^(u)) <= R(eta,u).

Hence the folded test accepts with probability at most (1+sqrt(R(eta,u)/(4epsilon)))/2, truncated at one. The first inequality and all representation joins here are proved finite mathematics. R and its quantitative decay are deliberately not introduced as a result field or asserted without a repetition theorem and checked hypotheses.

The base game's answer alphabet sizes are at most eight and two, regardless of label count or m. Questions retain occurrence identity and multiplicity. On clauses with three distinct labels, uniform literal positions and uniform distinct variables are identical; the game is then the usual basic source game. On repeated-label clauses, their distributions differ, but (BASIC) remains proved for the position law and the standard repeated position game is well-defined. Whether a particular quantitative repetition theorem can be applied directly to its weighted distribution, or a regular-format source theorem is used first, must be checked by the separate contract audit. No exact-five-occurrences condition was needed for the elementary base gap itself.

## 8. Remaining proof and implementation obligations

This note closes the actual basic clause-position gap, finite randomized reduction, perfect completeness, and the exact repeated-law/decoded-answer interface. It does not supply:

- An actual polynomial-time reduction from SAT to the fixed-gap structured CNF promise with the desired regular format. The hypothesis OptSat<=1-eta is an assignment promise in (BASIC), not a hardness claim or an assumed game value.
- A proof of a quantitative classical parallel-repetition theorem with constants sufficient for choosing fixed u, or validation of every distribution/answer-alphabet hypothesis of that theorem. In particular the value-power upper bound was not used.
- The global empty-conditioned-domain/fixed-NO branch, exact dyadic table/noise enumeration, row-count equality and same-function encoded polynomial-time construction. If D_q is empty for some clause tuple, there is no satisfying decoded y for that tuple; the Fourier bridge is used only on the all-nonempty branch specified there. The basic and repeated games themselves remain defined and reject any unsatisfied wide answers normally.
- Kernel proofs of these finite definitions, counting identities, strategy reduction and semantic joins. Existing draft Lean interfaces are pinned for the intended objects, not declared newly compiled by this derivation.

The eventual Lean statement should define the finite game from phi and its predicate, prove acceptance<=1-(1-Sat_phi(sigma))/3 for actual response tables, then maximize or quantify over tables. It should not accept the desired game-value bound as a certificate. A finite-alphabet distribution implementation may use explicit numerator counts over 3m outcomes; normalization requires the m>0 branch. The repeated-game bridge should be pointwise in q, followed by the exact product-law count. These are concrete kernel prerequisites rather than a generic wrapper.

## 9. Evidence pins and ancestry

- Current draft `research/p-equals-np/drafts/2026-09-13-folded-parity-verifier/ActualFoldedParityVerifier.lean`, raw SHA256 `8c5237a19c06e89adaea2382405691541198d0c120a5699fab25fbff5dbbea0a`. Relevant actual definitions: `Literal`, `Clause`, `Question`, `literalAt`, `literalValue`, `clauseValue`, `smallView`, `wideView`, `restrictLocal`, `selectedSat`; `smallView_nodup`, `wideView_nodup`, `small_subset_wide` and `selectedSat_honest` are the intended local interfaces.
- Execution interface `research/p-equals-np/2026-09-13-realizable-hardness-folded-parity-execution-interface.md`, raw SHA256 `549e0fe033414c5fceca1beaee90ccc33e15d8d863a103100e92702b13b6517b`.
- Accepted finite Fourier derivation `research/p-equals-np/2026-09-13-realizable-hardness-folded-parity-fourier-soundness-derivation.md`, raw/frozen SHA256 `4f598ae3736ac71072046045dc556bde9e1e0bec000b65f85c330aa024011cde`, three-note archive `398a3b5ce0d79cef1b1a9cc2245a2f5d19f47ce8`. Its acceptance is finite mathematical review, not Lean completion.
- Preserved primary author PDF `C:/Users/Dan/AppData/Local/Temp/s3132-hastad-optimalinap.pdf`, SHA256 `864df36f2bc692e47f1c94aff0afec34297e27116a5d76f204199e9ce098fa64`; layout text `C:/Users/Dan/AppData/Local/Temp/s3132-hastad-layout.txt`, SHA256 `0b771d4539401742c0c41a89a201c318e6557ab6aada7de60df69610614bfe91`. Printed pp19--20, lines884--906: the regular source promise and basic protocol/Lemma3.1; lines910--924: independent repeated coordinates and separately imported repetition/Theorem2.26 used for Lemma3.2; pp20--21, lines930--939: tuple-to-set notation and shared table per variable set. The source's shorthand is unpacked above without equating the full strategy classes of tuple and set games.

The elementary argument is the explicit actual-representation version of the primary Lemma3.1, with an exact multiplicity-aware formula and a full local-question bridge. It is not presented as novel research. The author previously constructed the folded draft and Fourier derivation; distinct review must assess the new gap and game-interface proof.
