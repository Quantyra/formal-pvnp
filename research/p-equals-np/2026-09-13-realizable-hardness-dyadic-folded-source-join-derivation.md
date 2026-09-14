# Exact dyadic folded source: construction, counting, and gap join

2026-09-13. S3132/S3137 in formal-pvnp. This is a complete finite mathematical definition and derivation of the upstream typed source producer from the current folded-verifier draft, with its exact normal-branch law and global exceptional branches. It is not a new Lean implementation, a compiler result, or a raw-word FP theorem. No compiler, new Lean module, source-draft edit, Git, paper edit, or public action was used. The supplied satellite/planning protocols and existing source-route literature decision apply; no AGENTS.md exists at this satellite or its certification root.

## 1. What already exists and the actual missing join

The pinned `ActualFoldedParityVerifier` at dd3704f defines actual selected views, assignment enumeration, one shared raw proof address per variable set and truth vector, conditioned folding, the noisy third query, the ordered GF2 row and RHS, and the exact local acceptance/row predicate bridge. Its `emitRow_none_iff` identifies precisely an empty satisfying domain. Its honest theorem identifies the remaining queried parity bit with one concrete noise coordinate. Those local identities are reused here, not rederived by another six-bit algebra exercise.

Archive 7f2d6a6 is `ActualRegularizedSourceProducer`: it starts from an already supplied valid `ActualSourceNormalization.Source` and composes normalization and occurrence-cloud producers. It does NOT enumerate an upstream folded experiment from a CNF. Its uncompiled/global producer status is not upgraded here. The missing join is a concrete typed CNF -> ordered list of row/RHS pairs -> Source construction with exact outcome multiplicity and the correct probability law. We define and prove that construction below without assuming a producer certificate.

The Fourier soundness at398a3b5 and complete finite repetition recurrence at0992c099 now supply the actual normal-branch upper bound, including repeated-label position-game semantics. They remain finite mathematical proofs awaiting kernel formalization. This note joins their conclusions to the actual source count, not to a substitute idealized distribution.

## 2. Parameters, structured input, and deterministic views

Fix integers u>=1 and b>=2, with epsilon=2^(-b). They are fixed parameters, independent of the varying CNF input. Set

    F=2^u,   G=2^(3u),   K=F+G+bG=F+(b+1)G.

Input phi is the existing finite list of ordered triples of literals `(Nat * Bool)`, with the Bool denoting negation. Let m be its clause-occurrence length. Repeated clauses, labels, signs and literal positions are retained. No bounded occurrence or three-distinct-label hypothesis is imposed on the typed construction.

For m>0, a question q:Fin u -> (Fin m * Fin3) selects ordered clause-occurrence/position pairs. Use exactly the draft's `clauseAt`, `smallView U_q`, `wideView W_q`, `restrictLocal U_q W_q`, and `selectedSat h_q`. The small label list before sorting/deduplication has length u. Removing repeated labels cannot increase length, and sorting preserves the number of distinct labels. Thus |U_q|<=u. The concatenated wide label list has exactly3u entries, one triple per selected clause occurrence, so |W_q|<=3u. This proof counts list entries first; no assumption that selected labels are different is used. The lists after sorting are nodup, and U_q is contained in W_q by literal membership as already established in the draft.

Let A_q be the draft's lexicographic list `assignments |U_q|` and B_q its list `assignments |W_q|`. These list assignments false-prefix first, have no duplicates, contain every assignment exactly once, and have lengths

    f_q=2^|U_q|<=F,     g_q=2^|W_q|<=G.

A length-zero variable set still has one assignment, so f_q,g_q>=1. The draft's explicit enumeration proves these properties; the first-coordinate maps below are therefore genuine injections, not caller-supplied indexing bijections.

For each assignment a in A_q define rank_A(a) as its unique list index, in Fin f_q. Likewise rank_B(y) in Fin g_q. Existence follows from completeness; uniqueness and index recovery follow from nodup. The inclusion of these indices as the first f_q or g_q coordinates of the fixed pads is injective because distinct list indices have distinct natural values and the upper bounds just proved make them valid pad indices.

## 3. Exact tape map and its joint fiber count

A tape z is a bit vector in Bool^K with coordinates numbered from zero. Define the full truth functions used in the actual query by

    f_z(a)=z[rank_A(a)],
    g_z(y)=z[F+rank_B(y)],
    noise_z(y)=true iff all z[F+G+b*rank_B(y)+ell] are false, ell=0,...,b-1.

The first pad occupies [0,F), the second [F,F+G), and the noise pad [F+G,F+G+bG). Each actual assignment uses a disjoint b-bit noise block, and all displayed indices are <K. The inequality b>=2 ensures b>0; Euclidean block decomposition, or disjoint interval bounds, proves distinct (rank,ell) give distinct coordinates. In particular there is no overlap between f,g and noise coordinates even when U_q=W_q or later proof addresses coincide.

Fix q and specified truth functions f,g,nu on its assignment sets. Let r be the number of y in B_q with nu(y)=true. The exact number of tapes giving these THREE full functions is

    2^((F-f_q)+(G-g_q)+b(G-g_q)) (2^b-1)^(g_q-r).     (FIBER)

Proof: the f_q selected f bits are fixed, the g_q selected g bits are fixed, and each of the r true-noise blocks is its unique all-false block. Each of the remaining g_q-r blocks may be any of the2^b-1 non-all-false words, independently. All unused coordinates consist exactly of F-f_q first-pad bits, G-g_q second-pad bits and b(G-g_q) noise-pad bits; they are unconstrained. These sets partition the K tape coordinates, so multiplying their finite choice counts proves (FIBER). No independence assertion is substituted for the counting proof.

Dividing by2^K simplifies (FIBER) to

    2^(-f_q) 2^(-g_q) epsilon^r (1-epsilon)^(g_q-r).  (LAW)

Thus a uniform full tape produces uniform independent truth functions f and g, and independent noise bits true with probability exactly epsilon, independent of f,g. The first two uniform factors are probabilities on2^(f_q) and2^(g_q) truth functions, not on original assignments. Noise true means a negative sign in the parity experiment. The pads may have different unused portions for different q; the equal total2^K tape count ensures that this does not reweight questions.

This is exact dyadic noise, not an approximate inverse-CDF sampler. Question selection itself has denominator (3m)^u, which need not be a power of two. We use its explicit uniform finite law separately from the K fair bits and do not claim a fixed fair-bit sampler can realize every question denominator.

## 4. Explicit ordered outcome enumeration

Enumerate `Fin m * Fin3` in increasing clause index first and then increasing position; it has exactly3m distinct entries. Enumerate its u-tuples by the usual lexicographic recursion: the list for zero coordinates is the singleton empty tuple, and the next-coordinate list concatenates the recursively enumerated tails under each possible first entry. Induction proves completeness, nodup and length(3m)^u. The head blocks are disjoint because their first entries differ; within a block the induction supplies nodup and coverage. No coordinate occurrence or literal position is removed.

Enumerate tapes by the existing false-prefix-first Boolean-vector recursion at length K. It has exactly2^K elements, all distinct, and contains every tape. Define the outcome list O_phi by outer question order and inner tape order. Its members are pairs(q,z). Distinct questions lie in disjoint outer blocks; tapes inside each block are distinct. Therefore O_phi is an explicit nodup list of OUTCOME INDICES, complete and of length

    N_phi=(3m)^u 2^K>0.                               (COUNT)

The emitted rows are not claimed nodup. Identical rows, identical addresses within a row, and opposite RHS values may occur many times; each indexed occurrence remains in the output. Uniform sampling of this list is exactly independent uniform question and tape sampling. Equation(LAW) then proves equality to the normal noisy-parity experiment conditional on each q, and hence for the joint law. Sorting or deduplicating the emitted rows would destroy this law and is not part of the construction.

## 5. Total typed source construction, with GLOBAL exceptional branches

A row/RHS pair r has the existing type

    ((Nat * (Nat * Nat)) * Bool).

For a finite list R of such pairs define

    unzipSource(R)=(R.map first, R.map second).

This is exactly `ActualSourceNormalization.Source`; its Valid property is equality of the two list lengths, immediate since both maps have length |R|. Index t in both lists comes from the SAME row/RHS pair R[t], so no independent ordering or pairing choice is made.

Define the fixed sources

    YES=unzipSource([((0,(0,0)),false)]),
    NO =unzipSource([((0,(0,0)),false),((0,(0,0)),true)]).

Here repeated labels are legal in the upstream source representation. For any GF2 assignment a, the triple's value is a(0)+a(0)+a(0)=a(0). YES has a satisfying assignment a(0)=0 and value one. NO has exactly one satisfied row for EVERY assignment, so its value is exactly1/2. This is not merely an upper bound on an unspecified fixed contradiction.

For m>0 enumerate all ordered u-tuples c of clause occurrence IDs, without selected positions. From c form its sorted wide variable set and the conjunction of its selected clauses, and scan the existing assignment enumeration for a satisfying assignment. Define Empty(phi) to mean that at least one of these tuples has no satisfying assignment. This is a finite exhaustive decision, using `firstSat=none` for the exact domain; it is not a satisfiability oracle on the full input.

For any q, its wide view and conjunction depend only on its clause tuple c, not on selected positions. Conversely every clause tuple c extends to a q by choosing, for example, position0 in each coordinate. Hence Empty(phi) is equivalent to the existence of a question with empty h_q-domain. This establishes the exact global guard for the row constructor, not an assumed availability law for each query.

Define the TOTAL typed producer S_(u,b)(phi) by this deterministic order:

1. If m=0, output YES.
2. Otherwise, if Empty(phi), output NO.
3. Otherwise, form O_phi and, for every(q,z) in order, compute the actual draft
   `emitRow q f_z g_z noise_z`. Return unzipSource of those rows in that same order.

For a total definition of the step3 mapping even outside its guard, one may take `emitRow.getD ((0,(0,0)),false)`. The draft's `emitRow_none_iff`, together with not Empty(phi), proves that this fallback is never reached in step3. Equivalently pattern-match on some r in that branch after the finite guard has established nonemptiness. No row is filtered out and no per-question failure is replaced while claiming normal-law equality.

This construction outputs a valid Source in every branch, with lengths1,2,N_phi respectively, all positive. It makes no reference to P or to a source assignment; raw proof values are used only to evaluate its output later. Thus the output is an actual list of equations determined by the CNF, u and b.

## 6. Shared proof addresses and exact arbitrary-assignment count

The step3 row is precisely the draft's `rowOfQueries`: it records the three existing `addressCode(mkAddress V canonicalTruth)` labels, in query order, with RHS equal to the XOR of the three folding-sign bits. V is the sorted VARIABLE SET, never a role, tuple, predicate, or query identity. In particular different conditioned accesses on the same W use the same underlying raw table, and U=W does not create a second namespace. The word-sentinel code is injective on the actual DataEncode address, and its bitlength bound was established in the draft. It prevents accidental collisions while preserving intended equal addresses.

Let a:Nat->ZMod2 be ANY assignment to these numeric source labels. The existing Bool/ZMod roundtrip defines P(v)=toBool(a(v)) and recovers a(v)=rhsValue(P(v)) for all v. In the normal branch, for every outcome(q,z), the draft's `verifier_accept_iff_GF2` gives exactly

    emitted row at(q,z) satisfied by a
      iff verifierBit P q f_z g_z noise_z=some false.   (ROW)

The row is guaranteed some by the global guard, as proved in Section5. No desired output equality or honest-proof premise is being added to (ROW). The same identity in the other direction applies to every raw proof P through `bitAssignment`.

Let SatCount(S,a) count satisfied indices of the row list, and let AccCount(phi,P) count outcomes in O_phi with the displayed accepting predicate. Map/unzip preserve list index, and (ROW) identifies the indicator at each index. Summing gives the exact integer equality

    SatCount(S_(u,b)(phi),a)=AccCount(phi,toBool composed with a).    (INT)

This can also be read as equality of filter lengths on explicit occurrence lists; no quotient by repeated equations or addresses is taken. Only after (COUNT) proves N_phi>0 do we divide:

    SatCount(S,a)/N_phi
       =Pr_(q uniform,z uniform)[verifier accepts]
       =Pr[the exact noisy folded test accepts].        (PROB)

The last equality is the finite padding law(LAW), not an approximation. Its probability includes the actual position-weighted clause questions established in the base-game proof. These equalities are only claimed in the normal branch; a global NO or YES output has its separately computed semantics.

The value of any output source is well-defined as a finite maximum: only finitely many numeric labels appear, so maximize over their GF2 assignments and extend each by zero on all other Nat labels. Conversely every total assignment restricts to one of these finite assignments. Thus (INT) and (PROB) cover the actual optimum as well as individual assignments. They do not assume independently programmable conditioned tables.

## 7. Completeness: exact noise loss and the empty-input exception

Suppose the input CNF is satisfiable by a total variable assignment sigma. If m=0 the output is YES and has value one. If m>0, the restriction of sigma to each selected wide set satisfies every clause in that tuple. Hence no tuple can witness Empty(phi), so the producer is in the NORMAL branch. This proves directly that the global NO branch cannot be selected on a satisfiable input, including repeated clauses or literals.

Use the draft's single global `honestProof sigma` and its corresponding GF2 assignment. The local honest theorem reduces each outcome's queried parity to

    noise_z(sigma restricted to W_q).

The relevant wide assignment has one actual list index in B_q. Exactly one of the2^b patterns in its disjoint noise block makes this bit true, and all other K-b bits are free. Consequently, for EVERY fixed q, exactly

    (2^b-1)2^(K-b)

of its2^K tapes accept. This is an integer because K>=b. Summing over the(3m)^u questions gives exactly

    SatCount(S,honest)=(3m)^u(2^b-1)2^(K-b)
                     =(1-epsilon)N_phi.               (YESCOUNT)

Thus nonempty satisfiable inputs have completeness at least1-epsilon, not perfect completeness. The semantic honest extension is not an algorithm the source constructor must compute; it is a single witness assignment whose existence follows from sigma and the proved address injection.

One can in fact show the optimum is EXACTLY1-epsilon in this normal satisfiable case. In the accepted Fourier correlation identity, every nonzero wide coefficient is indexed by an odd nonempty beta. Write rho=1-2epsilon in(0,1). Parseval gives |a_alpha|<=1 and sum_beta b_beta^2=1. Therefore for every normal question and EVERY raw proof,

    C_q=sum_beta a_(pi_2(beta)) b_beta^2 rho^|beta|
          <=sum_beta b_beta^2 rho=rho.

This uses a genuine coefficientwise upper bound a_alpha rho^|beta|<=rho with nonnegative b_beta^2; negative coefficients do not invalidate it. Hence all normal acceptance rates are at most(1+rho)/2=1-epsilon. Combining with(YESCOUNT) proves equality of the source optimum when phi is nonempty and satisfiable. This universal upper bound also applies to other normal inputs, although the stronger5/8 NO bound below is the useful promise-gap conclusion. No perfect-completeness claim is hidden in the word YES.

## 8. Soundness and the global exceptional NO

Suppose every assignment satisfies at most1-eta of phi, for a fixed0<eta<=1, and choose

    u>=max(1,ceil(648000(b+2)/eta^3)).

For m=0 the premise is impossible under the empty satisfaction convention1, so that case does not enter soundness. If Empty(phi), output is NO with exact value1/2, already at most5/8. A witnessing empty tuple also directly proves phi is unsatisfiable: a full satisfying assignment would restrict to a member of its empty domain. The converse is neither needed nor asserted; an unsatisfiable CNF may have all sampled tuple domains nonempty.

In the remaining normal branch the accepted finite base-game/repetition chain gives the actual u-fold clause-position game value at mostepsilon/4. It applies to the exact question law of Section4, with repeated labels handled by the weighted position game, not an imported distinct-variable sampling premise. The accepted Fourier decoder says a positive correlation delta yields a legal game's success at least4epsilon delta^2. Therefore test acceptance is at most5/8 for EVERY raw proof, as proved in the final recurrence note. For nonpositive correlation it is already at most1/2.

Apply(PROB) to the raw proof associated with every GF2 assignment a. This proves

    SatCount(S_(u,b)(phi),a)<= (5/8)|S_(u,b)(phi).rows|

for every a in the normal branch, and the exact1/2 computation proves it in the exceptional NO branch. Hence the complete typed producer maps the promised NO input to a source of value at most5/8.

The final typed gap statement is therefore:

- Every output is a nonempty Valid actual Source, retaining ordered row multiplicity.
- On satisfiable nonempty input, output value is exactly1-epsilon; on empty input it is1.
- On input with OptSat<=1-eta and the displayed fixed u, output value is at most5/8, including the global empty-domain branch.

Since b>=2,1-epsilon>=3/4>5/8, so this is a genuine numerical gap. It is not a claim that the promise is NP-hard: the upstream gap-producing reduction remains to be supplied. It is also not the later regularizer's perfect-completeness theorem; the noisy verifier's YES error is explicit.

## 9. Actual serialization/downstream interface and remaining formal work

Define the typed output wire simply as `ActualSourceNormalization.wire (S_(u,b)(phi))`. The two component lists have equal length by construction, and all variable labels are the actual Nat address codes with all folding RHS bits retained. This is a total serialization of every structured CNF, including both exceptional branches. There is no claim here of a total parser on arbitrary input words or of the same raw parser/producer function belonging to FP.

The output is in the exact upstream Source type consumed by the accepted normalization and finite-wire APIs and by the archived `ActualRegularizedSourceProducer` interface. That downstream draft's actual original-plus-cloud row order, code identities, repeated source-label treatment and inherited degree results are not reimplemented or reverified here. Any downstream gap change must use its precise established constants; this note does not claim that its output preserves5/8 literally or that all its compiler obligations are closed.

The construction's outcome count is exactly(3m)^u2^K in the normal branch; with fixed u,b its dependence on m is polynomial. This is a counting fact, NOT by itself a same-function runtime theorem. Arbitrary source labels are binary Nat values, and address injection uses the actual DataEncode vector and wordNat sentinel, rather than unary expansion of the label magnitude. The draft supplies the final wordNat binary-width bound, but bounding and implementing the whole CNF-to-wire loop, finite-set sorting/lookup, malformed-word validation, clocks and exact source equality in the actual FP library remains required. No runtime or canonical-source correctness field is assumed.

For kernel formalization, the precise new objects are the lexicographic question list, padded tape-to-truth/noise map, positive-block fiber count, global empty-domain guard, total row map and unzipSource. The key theorem is integer equality(INT), followed by the two exceptional values and(YESCOUNT), then the already derived normal soundness. These mathematical definitions and proofs are given here; they are not represented as already-existing compiled `ActualDyadicParitySource` modules. No new Lean source was added under the compiler pause.

The source-hardness goal still requires the actual initial SAT-to-fixed-gap CNF reduction, kernel verification of the entire finite Fourier/game/repetition and producer chain, the encoded FP proof for the SAME total output function, and full downstream assembly. Paper-specific Lean consolidation remains conditional on full proof finalization. Nothing here authorizes publication or changes DOI/version records.

## 10. Exact evidence pins and review roles

All paths below are in formal-pvnp unless absolute. The current local source interfaces were read in full; their previous source-level reviews are not substituted for kernel evidence.

- `research/p-equals-np/drafts/2026-09-13-folded-parity-verifier/ActualFoldedParityVerifier.lean`, SHA256 `8c5237a19c06e89adaea2382405691541198d0c120a5699fab25fbff5dbbea0a`, archive dd3704fef7ddd99c7ace36e5b38d63f51e1cbfd4. Reused definitions and identities are identified in Sections1--7.
- `research/p-equals-np/2026-09-13-realizable-hardness-folded-parity-execution-interface.md`, SHA256 `549e0fe033414c5fceca1beaee90ccc33e15d8d863a103100e92702b13b6517b`, supplies the existing planned K and global branch convention; this note proves their finite join.
- `research/p-equals-np/2026-09-13-realizable-hardness-folded-parity-interface-semantic-review.md`, SHA256 `5bd66f76b43ab8ecbed52be2b76ff5764ef651e5d972f789ee8e5d9170f6af5e`, confirms primary -1=true/off-domain+1 and shared-address semantics.
- `research/p-equals-np/drafts/2026-09-13-regularized-source-producer/ActualRegularizedSourceProducer.lean`, archived at7f2d6a6c834d36a22f3ad8977fde9c32cbed52a6, is the downstream typed-Source constructor, not a CNF dyadic source generator. Its draft receipt records raw SHA256 `7b99cbf0b15cd0e68273a222e2211581eb6624460da5966d3fd08d5489d660d0`; no new build or acceptance is asserted here.
- `research/p-equals-np/2026-09-13-realizable-hardness-folded-parity-fourier-soundness-derivation.md`, SHA256 `4f598ae3736ac71072046045dc556bde9e1e0bec000b65f85c330aa024011cde`, archive398a3b5ce0d79cef1b1a9cc2245a2f5d19f47ce8.
- `research/p-equals-np/2026-09-13-realizable-hardness-repetition-conditional-success-recurrence-derivation.md`, SHA256 `9630cd466f725fe4c69c0128a17e39923291b530b95108bc96ec552f24cab207`, archive0992c0999b86700f53badf5589822b8975d3f0c1. Its preceding finite dependency chain and actual position-game application are retained.
- Primary Hastad author PDF `C:/Users/Dan/AppData/Local/Temp/s3132-hastad-optimalinap.pdf`, SHA256 `864df36f2bc692e47f1c94aff0afec34297e27116a5d76f204199e9ce098fa64`; preserved layout text SHA256 `0b771d4539401742c0c41a89a201c318e6557ab6aada7de60df69610614bfe91`. Test L and Theorem5.4 supply the ancestry of noise sampling and equation-per-outcome compilation; the exact global exceptional branches and typed list identity above follow the reviewed local interface rather than an assumed uniformity shortcut.

The author constructed the folded verifier draft and several underlying finite proofs. Distinct review is required for this new enumeration/branch/gap join. It reconstructs established source machinery for eventual formalization; no novel solver, new hardness theorem or full-proof completion is claimed.
