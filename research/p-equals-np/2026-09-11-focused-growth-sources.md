# Focused growth: conditional exposure contract

2026-09-11; S3066. Supporting research under [INTEGRITY-CLAIMS](../../INTEGRITY-CLAIMS.md), reusing [S3065 policy and source comparison](2026-09-11-adaptive-fko-sources.md). No code, experiment or new algorithm. The mathematical author and independent reviewers own the final first-trajectory proposition; the calculations below record the consultation supplied to them.

## Relevant existing method, with model limits

Wu et al.'s focused search chooses a clause of maximum overlap with all exposed variables, breaking ties randomly, tests XOR inconsistency, prunes and repeats under clause-use restrictions. Our S3065 version instead stops at first unsigned linear dependence and postpones sign filtering. Neither the published empirical scaling nor the July 2026 even-cover existence results provide the required growth probability. [Wu et al., Section IV.3](https://arxiv.org/html/1303.2413).

Cooley et al.'s Pathfinder analysis explicitly prevents re-querying an already queried hyperedge, including from another explored set. This is what permits independent Bernoulli query outcomes in their binomial hypergraph model; forbidden-query bookkeeping is part of their argument, not dispensable overhead. Their exploration algorithm and Proposition 21 concern a different path-building policy. They do not assert that an adaptive maximum-overlap residual is fresh. [Longest paths in random hypergraphs, query rules Q1-Q4 and analysis](https://arxiv.org/pdf/2003.14143).

Bal and Bennett explain partial-edge exposure by deferred decisions for greedy processes in a random configuration model. This supports the technique of exposing only the information needed for the next choice. Their matching theorem assumes a prescribed degree distribution, bounded first/second degree moments and maximum degree o(n^(1/3)); it is not a theorem for our independent-clause input of mean degree Theta(n^.4), or for focused dependence search. [Sections 1.1 and 2, Theorem 2](https://www.combinatorics.org/ojs/index.php/eljc/article/download/v30i1p11/pdf/).

## Exact consultation for the first unloaded trajectory

Use m independent occurrence IDs, each carrying a uniform three-element subset of [n]. This is a fixed number of independent samples, not the uniform simple-hypergraph fixed-edge-count model. Ignore signs and start with no loads. Expose the seed support. Thereafter, for each unselected ID, expose its membership inside the growing U, but not the identities of its remaining outside vertices. The transition chooses an ID uniformly within the highest nonempty overlap class using independent tie randomness.

The proposed inductive invariant is: conditional on this complete coarse transcript, the unexposed part of each unselected clause is a uniform subset of [n] minus U of the required size, independently across IDs. Membership tests, including failed tests, factor by clause. Choosing an ID using only the observed classes does not inspect its outside completion. Revealing that chosen completion then updates the membership tests of all other clauses. The proof must explicitly include those negative observations; vertex symmetry alone does not prove independence. The same factorization survives collisions when exact inside memberships remain in the transcript. Both the K-clause cap and first unsigned-dependence stopping are measurable from that transcript; this is the capped S3065 policy, not an analysis of uncapped Wu search.

Before the first unselected clause with overlap at least two exists, the selected prefix grows by one old vertex and two new vertices per step. It is a loose hypertree, so its incidence columns remain independent. Let N=n-|U|, and let N1 and N0 count the other one-overlap and zero-overlap clauses. The chosen extension has a uniform pair of outside vertices. Conditional on the transcript, a union-bound hazard for creating an overlap-at-least-two candidate is at most

    4 N1/N + 6 N0/[N(N-1)].

These terms respectively charge a one-overlap clause hitting the new pair, and a zero-overlap clause containing both new vertices. Seed collisions must be charged separately. Creating such a candidate is only a necessary gateway for dependence, not sufficient for dependence.

One way to control N1 is to stop when N1>|U|D, for D a sufficiently large constant times n^.4. The probability of that stop can be bounded separately by the original input's maximum-degree tail. Do not condition the product-law argument on the global good-degree event: use stopping and a union bound instead. Summing the stopped hazards up to K=ceil(A n^.2) suggests O(D K^2/n + mK/n^2), with dominant order n^(-1/5). This is a proposed bound for the main proof to establish, not an imported theorem or a claim that all histories have typical boundary size. An alternative expected-boundary recurrence requires its own conditional justification.

## All-stage refinement consulted with the author

The author subsequently proposed counting each unselected clause once when its overlap first crosses from at most one to at least two. The invariant above is suitable after collisions as well. An extension adds at most two new vertices after the seed, so the same hazard upper bound controls new crossings. Conditional on the chosen new set, the crossing indicators factor across the other clause IDs. This permits a conditional moment-generating-function argument, subject to the visible boundary stop and a separately charged degree exception.

A core T of e clauses has at most 3e/2 vertices because its nonzero degrees are even. Its total selected-time overlap relative to the entire prefix is at least its overlap relative to its own earlier clauses, namely 3e-|union T|>=3e/2. Since overlaps are at most three, at least e/4 selections in T have overlap at least two. Each requires a distinct earlier crossing; seed-created crossings must be included. This connects a dependency to many crossing events rather than merely one collision. The final theorem and constants belong to the main derivation and review.

Crucial exception accounting: a high-probability lower bound on the smallest tuple does not imply an exponentially small exceptional probability. In the iid-support model, repeated supports can already create length-two dependencies. Therefore an exponential crossing tail on the event of no short tuples must retain the short-tuple exception separately in any unconditional bound. Do not advertise an unconditional exponential failure rate by dropping that term.

## What does not transfer

A fully read input does not invalidate analysis through a coarser equivalent simulation if the policy's choices only use the revealed information and independent ties. Extra tie priorities consulting hidden endpoints, degrees or previous trajectories would invalidate the stated invariant. The equivalence therefore belongs in the theorem's policy definition.

The first attempt is not an independent sample from every later capacity-depleted state. Failed prefixes can reveal information, retained tuples change availability, and tie choices may revisit the same geometry. No multiplication of independent failure probabilities, all-attempt lower bound, or failure of all adaptive finders follows. A separately proved restart statement may use the unchanged full-input marginal, but must specify the randomness and conditioning; it is not part of this source consultation.

The substantive opening here is a rigorously justified transcript/exposure estimate for the actual policy. It does not improve FKO discovery; it can identify precisely why the first short trajectory usually does not reach the structural event needed to close a dependency. Source scope checked; no full-proof endorsement of external papers, novelty claim or general SAT complexity conclusion.
