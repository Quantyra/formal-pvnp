# Independent review: conditional success and the complete repetition recurrence

2026-09-13. S3132/S3137. Reviewer: compact_source_encoding_audit. **GO for the finite Lemma 15, exact-6000 recurrence and clause-position application, joined to the accepted finite embedding foundations.** No blocking mathematical defect found. This discharges the previously conditional repetition application at the ordinary finite-mathematical level, not at the Lean/kernel level and not as a complete source-hardness result.

## Candidate, evidence and role

I read the complete nine-section candidate, directly compared pinned Holenstein v3 Lemma 15 and equations (35)-(39), and checked the accepted Lemma 14 statement, coordinate-preserving local extension, error ledger and endpoints against the interface used here. I rely on the separately accepted proofs of that embedding and product conditioning rather than claim to have reconstructed their entire proofs again in this final arithmetic review. Fresh raw SHA256 identities follow; all filenames below have prefix `research/p-equals-np/2026-09-13-realizable-hardness-` and suffix `.md`.

- `repetition-conditional-success-recurrence-derivation`: `9630cd466f725fe4c69c0128a17e39923291b530b95108bc96ec552f24cab207`.
- `repetition-dependency-breaking-embedding-derivation`: `4d0507860262b4be7888df6f323ab98bb5157ad2523239dc73a243b87eecf2bd`.
- `repetition-product-conditioning-derivation`: `6223d5cf281384406903eb9538fbea3988a8adcfcee83cbb843b1204567c6700`.
- `repetition-correlated-sampling-derivation`: `fd66b0d7d1a706c69a45f82636d6172bea3fdc42315f1bbdf31ee151345cbc8e`.
- `clause-position-game-gap-derivation`: `4b801f9e869038de2871c35c0744999716386ae71669cb3a404da466f4a99a03`.
- `folded-parity-fourier-soundness-derivation`: `4f598ae3736ac71072046045dc556bde9e1e0bec000b65f85c330aa024011cde`.

The candidate is 19488 bytes. Primary source is cs/0607139v3, preserved PDF SHA256 8d392c5ce04e333cdd47a6e15d6d02e1427d7d378b2ff59c0d94de0edad57f3f and extracted text SHA256 6f5ed5ca5191b63998bcfcaf51ffb8ce0f7d2c83b299a288378eec06c6a99e18. The proof's conventions are explicit binary logarithms and TV equal to half L1.

I did not author this candidate or contribute its ceiling repair. Incidence's arithmetic discussion is disclosed by the author and is not counted as this independent review. I previously reviewed correlated sampling, the actual game and Fourier bridge, and contributed other prior mathematical work. No compiler, new module, experiment, source edit, Git, paper change or public action occurred. Only this requested review note was written.

## Lemma 15 is an actual local strategy comparison

The accepted embedding has exactly the needed sum bound 15*sqrt(k*((n-k)*L+log2(1/p))) for k remaining coordinates, positive conditioning probability, and the actual full-tuple classical strategies. Its output coordinate j is equal to the fresh input for every seed/input, not merely almost surely under the target conditioned law. This matters when the approximate tuple law has off-support outputs.

Coordinate permutation is implemented by relabeling both input and output of each local function; the independent product of identical question-pair laws is preserved. Thus a set of m distinct conditioned wins can be moved to the tail without imposing symmetry or coordinatewise response restrictions on the strategy.

Averaging the embedding errors gives an unconditioned j with error at most 15*sqrt((mL+log2(1/p_I))/(n-m)). Applying the fixed tuple-response functions to the generated local tuples and outputting coordinate j is a legal base strategy. Exact coordinate preservation makes its actual base acceptance equal to the event Win_j on generated tuples. TV then compares that event with conditional Win_j in the target. Eliminating question-independent shared randomness by finite response-table averaging gives the desired comparison with the defined base maximum v.

The candidate correctly restricts the claim to m<n and p_I>0. Duplicate supplied indices are removed before selecting a new coordinate; no event is conditioned on at probability zero. With m=0, the embedding bound is exactly zero and p1<=v follows without the later inequality m+1<=2m. The finite greedy minimum among remaining coordinates is legitimate; at a zero intersection probability it switches to arbitrary deterministic remaining indices, with all later probabilities zero.

## Independent integer and constant check

For 0<v<1 put g=1-v, theta=1-g/2, t=n*g^2/(3000L), M=ceil(t), with n>=1 and L>=1. Then 1<=M<=n. Every induction index 1<=m<M satisfies m<t, including when t is an integer. The first step p1<=v<=theta covers M=1, so there is no large-n premise.

In a later step, if p_m<=theta^(m+1), monotonicity already finishes. Otherwise p_m is positive and log2(1/p_m)<=(m+1)<=2m. Hence mL+log2(1/p_m)<=3mL, and the error in the actual recurrence is at most sqrt(675mL/(n-m)). The inequality

    m*(2700L+g^2) < n*g^2*(2700L+g^2)/(3000L) <= n*g^2

follows from m<t and g^2<=1<=300L. It implies 2700mL<=g^2*(n-m) and error<=g/2. Thus p_(m+1)<=p_m*theta, closing induction to the CEILING M. Because M>=t and theta<1, p_n<=p_M<=theta^M<=theta^t; a floor here would not give that direction without another repair.

Finally a=g^2/3000 lies in [0,1] and b=g/2 lies below one. The candidate's derivative proof of (1-b)^a<=1-ab has the correct sign: a*((1-b)^(a-1)-1)>=0. It gives theta^(g^2/3000)<=1-g^3/6000. Raising to n/L preserves order and proves the stated rate for each strategy, then for the finite maximum. No unjustified value-power upper bound, noninteger index p_t, or coordinate-independent response assumption is used.

## Boundary cases and strategy class

For n=0, the all-coordinate predicate is vacuously true and the rate is a positive base to exponent zero. For v=1, the rate is the trivial upper bound one and a maximizing base strategy attains repeated value one. For v=0 and n>=1, the zero-error first-coordinate argument gives a zero-probability win coordinate for every tuple strategy, forcing all-win probability zero without forming log(1/0).

When the answer-alphabet product is one, both alphabets are singleton and all coordinate winning events depend only on their independent question pairs. Their value is exactly v^n for n>=1, and one at n=0. This separate formula correctly replaces the undefined log2(1) denominator. Nonempty alphabets and a normalized question law are explicitly required; zero support cells are allowed. Arbitrary classical private/shared randomization averages over finite deterministic response tables and cannot improve the maximum. No entangled or no-signaling claim is introduced.

## Actual 8-by-2 application

The earlier game proof supplies its concrete weighted law mult_i(v)/(3m), duplicate-consistent predicate, and v<=1-eta/3 for the stated assignment promise. The accepted decoder supplies a subclass of legal full-tuple strategies under precisely the independently repeated law. The reconstructed repetition theorem therefore applies directly with L=4; no regular occurrence counts or uniform question marginals are required.

Substituting g>=eta/3 gives decrement eta^3/162000 and rate exp(-eta^3*u/648000). With positive fixed rational eta and epsilon=2^(-b), b>=2, the rational ceiling u>=648000*(b+2)/eta^3 yields value<=exp(-(b+2))<=epsilon/4. The existing normal-branch Fourier success lower bound 4*epsilon*delta^2 then gives delta<=1/4 and acceptance<=5/8; nonpositive correlation is already <=1/2. All divisions use positive eta and epsilon. This checks the exact constants rather than a generic exponential-decay placeholder.

## Closure and remaining obligations

The recurrence uses the actual accepted finite embedding with its proved locality and null-input behavior; that embedding uses the accepted conditioning and finite shared-sampling constructions. The chain's conventions and quantifiers agree. At this mathematical level the 648000/5/8 application no longer needs an assumed parallel-repetition theorem: it follows from those reconstructed foundations and the new final recurrence. This verdict relies on their separate acceptance and the checked interface, not an assertion that a dependency list alone proves them.

The initial SAT-to-fixed-gap structured CNF construction, global empty-conditioned-domain/fixed-NO and zero-clause branches, exact dyadic source enumeration, total same-function encoded polynomial runtime and full Lean/kernel verification remain separate. The note appropriately distinguishes an assignment promise from its NP-hardness and does not close the entire source-hardness goal, the manuscript, publication or P versus NP. The source's m=0 and real-index displays are repaired here without a claim of a new theorem or of errors in uninspected editions.
