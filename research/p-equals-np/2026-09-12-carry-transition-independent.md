# S3107 independent design: exchange-pair saturation of exact carry boxes

2026-09-12; S008. Designer/reviewer: `bamboo_size_fresh`.
**Final selection: NONE for a new force continuation from this design.**
One fully specified speculative local rule and its first quantitative
challenge are preserved below. The cross-challenge at the end records
the known branching overlap and exact exceptional-child accounting.
No complexity gain, novelty, or theorem is claimed.
Unlike S3106's unspecified selective branch, the updates below can be
performed directly from the input and current state. Whether they offer
anything beyond existing exact branching and additive-structure methods
is an independent selection obligation, not a consequence of specifying
them. No experiment or proof implementation has been run.

Read S3106's primary contracts, exclusions and final selection correction.
This design uses exact subset alternatives; it is not independent CRT
answers, a min/max/gcd relaxation, or an oracle for a conditioned fiber.

## State and exact query contract

An input is a list of positive binary integers a_1,...,a_n and a
nonnegative binary target t.
Remove items exceeding t, handle t=0, and charge input reading and binary
arithmetic. A state is a product of disjoint item blocks. Each block has
one or two explicitly stored options, and an option is an actual subset
of that block's original item indices. Initially block i has options
empty and {i}. Item-index disjointness is maintained structurally.

For a block with two options, order them by integer sum and write the
lower option's sum into a base B and their difference as delta_i>=0.
One-option blocks contribute only to B. Then the state's exact integer
sumset is

    B + {sum_i delta_i b_i : b_i in {0,1}}.

The query is whether t belongs to this set. A recovered bit b_i chooses
the stored option, so YES yields a valid original subset. States in the
search tree partition assignment choices before duplicate-sum
identification. Equal-sum alternatives may be replaced by one option:
this preserves existential reachability and one witness, though not
counting. A NO conclusion requires exhausting every child or an exact
empty-intersection/terminal test; no unvisited child is dropped because
it merely looks irrelevant.

For a selected modulus p and target residue, blocks with delta_i
divisible by p are residue-neutral. Their changes affect only integer
carries. The operation below constructs exact intervals of those carries
from the options, without computing the entire residue fiber.

## Exact saturation certificate, constructed locally

For each positive delta occurring at a state, try p=delta. Sort the
positive differences divisible by p by d_i=delta_i/p. Set H=0 and scan
in increasing order, absorbing the next difference precisely while

    d_i <= H+1; then set H := H+d_i.

The first absorbed difference must be 1. Stop at the first gap; no later
larger difference can repair it in this scan. The absorbed block set J
has an exact subset-sum interval [0,H] in carry units. Its certificate
is the sorted list and the displayed inequalities. Recovering a desired
carry works backwards: at step d_i choose 0 if the remaining carry is
at most H_before, otherwise choose 1 and subtract d_i. Store the
prefix H values and the original options for this decoder.

This complete-sequence coverage test is elementary established
machinery, not a claimed new additive theorem. It certifies all points
of an interval, unlike a minimum/maximum/gcd outer approximation.
Choose the certificate absorbing the largest number of binary blocks;
break ties by smaller p and then input index order. Zero differences
are absorbed for free using a fixed representative.
If there are no positive differences left, decide the singleton sum B
directly; no modulus or scan is needed, including for the empty input.

If all remaining binary blocks are absorbed, the state is exactly
`B+p[0,H]`. Decide t by divisibility and interval membership and decode
YES. If not all blocks are absorbed, their choices remain explicit;
the certified interval is not used as a substitute for them.

## The proposed exchange-pair refinement

Let U be the binary blocks outside the chosen saturated set. If U has
at least two blocks, inspect every pair of its blocks. The two blocks
have four option combinations, each an explicitly represented subset
of their disjoint union. For each of the six choices of two combinations,
form a prospective central child whose new block permits exactly those
two combinations. The other two combinations give one exceptional
child apiece with that new block fixed. All other blocks are unchanged.

Compute each prospective central child's saturation certificate using
the previous rule. Choose the proposal with the fewest unsaturated
binary blocks in that central child; break ties by the greatest number
of absorbed blocks, then by lexicographic original indices/options.
Recurse on the chosen central child and both exceptional children in
that order. Equal sums may subsequently be collapsed as above. This
is an exact partition of the four option choices, not a promise that
one of them extends to a solution. Construct all three children even
when the central child's newly certified interval looks favorable.

If U has exactly one block, branch on its two options. If U is empty,
use the exact terminal test. The elementary bounds t<B and
t>B+sum delta_i can prune a state but are not the design's claimed
advance. Every transition reduces the number of binary blocks in each
child, so the finite search eventually decides YES or NO. This statement
specifies intended correctness; no formal proof claim is made.

The proposed mechanism is that near-equal sums of two *block options*
can create a small carry difference even when original item values are
large. That new difference can bridge a gap and absorb several existing
residue-neutral choices into an exactly decodable interval. Exceptional
choices are retained and charged. This block-option exchange operation,
rather than generic density alone, is the candidate to assess.

## Local potential and charged uncertainty

Let k(S) be the number of binary blocks and u(S) the number outside the
selected saturation certificate. Both are computable from the state.
For a fixed proposed analysis constant lambda in (1,2), use

    Phi_lambda(S)=lambda^u(S).

The local branching load is the sum of Phi_lambda over all nonterminal
children divided by Phi_lambda of the parent. Central-child absorption
alone is insufficient: both exceptions enter this load. A useful
quantitative conjecture would bound products of these loads, or charge
their increases to a decreasing input-derived quantity. No such bound
is assumed. Plain k-based recurrence for a central child and two
exceptions is `T(k)<=T(k-1)+2T(k-2)+poly(L)`, which is compatible with
2^k time and supplies no gain by itself.

Every option contains at most n indices and has sum bit length
O(log W), W=sum a_i. At a state there are O(n^2) block pairs and six
central proposals each. Recomputing the scan for O(n) candidate moduli
costs a conservative polynomial in n and log W per proposal, including
sorting, divisions, copying, and reconstructing sums. No polynomial
bound on the number of states is hidden in this local cost. Witness
decoding is polynomial per completed path. A depth-first implementation
could avoid storing the whole tree, but that would not reduce total time.

**First falsifiable obligation:** on the exact SAT digit-reduction
images, does this fixed deterministic exchange rule ever force sustained
extra absorption sufficient to beat its two-exception charge, or can
one derive a family with repeated u-level branch loads at least one
for every lambda<2 and no compensating progress? This is a mathematical
recurrence challenge about the specified rule, not an invitation to
benchmark an unspecified heuristic. A claimed polynomial-time outcome
would additionally require polynomial total state count, not merely a
small exponential improvement or an average-case success rate.

The first test must track target pruning and both exceptional branches
on the same instances. A progression-free set of all subset sums alone
would not settle the target-specific algorithm, since the target might
be decided by another exact branch immediately. Conversely, fast YES
witnesses would say nothing about worst-case NO search.

## Existing-method and significance screen

Complete-sequence coverage, exact option branching, and additive
progressions are established ingredients. Chan's deterministic
pseudopolynomial/output-sensitive methods are stronger baselines than
ordinary subset enumeration. [Chan 2026](https://arxiv.org/html/2601.01390v1).
Dense search itself is also already constructive: Chen--Mao--Zhang
give efficient arithmetic-progression witnesses and a near-linear
dense Subset Sum search application. A claim that adding witnesses to
dense structure is new would therefore be wrong.
[Primary STOC 2025 paper](https://arxiv.org/abs/2503.19299).

The potentially distinct design choice is the exact three-way
partition of two evolving option blocks, selected by central-child
carry saturation while explicitly retaining exceptions. This intake
has not established that this is novel relative to the substantial
exact knapsack/subset-sum branching literature. It must not be announced
as a new algorithmic result merely because it has a name or a complete
transition definition. If the operation is known, another demonstration
would not meet the contribution-first rule. If its branch-load challenge
survives comparison, it is at least a concrete speculative object that
can be analyzed without an extension oracle; lack of a proved favorable
bound alone is not a reason to reject that analysis.

No P-versus-NP implication is achieved. A complete uniform polynomial
bit-time bound on all SAT reduction images would imply P=NP; the current
finite exhaustive fallback does not provide that bound. An exponential
speedup would be a different exact-algorithm result requiring its own
comparison. No claims about all solvers, quantum access, or proof-size
discovery are involved.

Only this owned record was written; no experiment, implementation,
public edit, commit, push, release, outreach or spend.

## Actual-file challenge of the author's cofactor transition

Read the entire [separate author design](2026-09-12-carry-transition-design.md),
SHA256 `C5B534E755225D0F804DB564F20514537B974C2073ADC71912C7BFF866DBD9F9`.
This review is independent of its construction. No defect found in the
specified state/query semantics or the submitted two-lift accounting.
That is a design audit, not a new certified complexity theorem.

The key (cut,old cofactor,prefix residue) suffices for the proposed
suffix query. Including the cut handles skipped variables. An old
nonzero cofactor admits a common suffix witness, so two prefixes
reaching it have the same sum modulo 2^b, and at most two residues
modulo 2^(b+1). No suffix needs to be discovered by the algorithm for
that counting observation. The old cofactor is already present in the
computed diagram. This is not the extension-oracle circularity that
blocked S3106's unspecified branch.

Shannon recursion covers both choices, memoization preserves their
query, and reduction preserves the predicate. At the final modulus
larger than W, congruence is exact equality. Following a nonzero path
and fixing skipped bits is valid because those bits do not affect the
represented final predicate. The final integer-sum check is an
appropriate witness verification.

The proposed at-most-two-lifts-per-nonzero-old-cofactor accounting
includes intermediate keys; it does not assume the next diagram was
available without construction. The bit/dictionary/storage costs are
charged. Iterating a factor two across bit positions supplies no
polynomial bound in the input's bit length. Those are materially
different statements and the author keeps them separate.

I agree with the author's specific duplicate-route screen: this is a
concrete fused cofactor-construction specialization, using equality of
the same remaining Boolean predicates as its sharing relation. It
does not supply another contraction operation beyond that established
representation. Its algorithm can be specified correctly without
becoming a new P-versus-NP mechanism. I did not infer a new lower bound,
repeat an equality-cut example, or reject it solely because its width
bound is unproved. No fix is requested for that saved design.

This reciprocal review does not confer novelty, significance, or a
favorable branch-load bound on my own design. The completed challenge
and root selection are recorded next.

## Completed exchange challenge and final selection

Read the author's appended exchange challenge in full at final design
SHA256 `36C93F665723C35E39AC3E95259F373432C352B4E4D8FB79A21CD2FFB7BF0C6D`.
The original cofactor-design hash above remains its earlier review
snapshot. I independently checked the following conclusions rather
than accepting the recommendation from its label.

For any fixed modulus p, inserting positive differences cannot reduce
the scan's absorbed count: an inserted entry no larger than a later
previously absorbed entry cannot create a first gap there, and absorption
only increases coverage. Deletion therefore cannot increase that count.
Every remaining child candidate modulus was already a parent candidate.
For each exceptional child, the parent's selected J and modulus survive
unchanged because the two deleted blocks were outside J. Consequently
the maximum absorbed count is exactly the old |J|, and
`u_exception=u_parent-2` before pruning or terminal treatment.

Thus, writing d_c=u_parent-u_central, the nonterminal load when both
exceptions survive is `lambda^(-d_c)+2 lambda^(-2)`. This definition
also accommodates collapse of an equal-sum central pair. The exception
term alone prevents strict local contraction for lambda<=sqrt(2),
irrespective of central absorption. The statement concerns this one-step
potential argument, not a global runtime lower bound.

In particular it does **not** exclude improvements with larger lambda:
for example a central drop of two would give load `3/lambda^2`, less
than one for lambda>sqrt(3). It does not account for target pruning,
small initial u relative to the number of items, terminal states, or
possible multilevel credits. Inferring that the whole algorithm cannot
beat a meet-in-the-middle running time would therefore be invalid.

The known-method comparison also checks structurally. Four combinations
form a square: its two diagonal pairs have sum/difference differences,
and its four edge pairs fix one option bit. Our two singleton exceptions
further split the complementary pair. Complete sum/difference branching
is established CKK machinery; ordinary edge branching is not a new
operation. [Korf's primary paper, Section 3](https://web.cecs.pdx.edu/bart/cs510cs/papers/korf-ckk.pdf).
The saturation score is not asserted to be identical to a published
heuristic, nor is global simulation of every search order claimed.

The root selected NONE for force continuation. I agree on the specific
grounds that the specified update combines known branching with known
coverage certificates, and its only proposed favorable structural event
is central-child absorption, which leaves both exceptional saturation
counts unchanged. No target-pruning condition or input-derived
multilevel credit was designed to address that cost for the intended
polynomial-time route. This is narrower than demanding a proved runtime
bound: a concrete speculative pruning/credit mechanism with an unproved
quantitative conjecture would remain eligible for research.

The design task did produce an exact operation instead of leaving an
oracle-shaped blank. Its negative selection is a separate outcome of
the actual operation's challenge and comparison. No lower-bound family,
experiment, proof implementation, publication, or automatic weaker
successor is generated from this closeout. Only this owned file changed.
