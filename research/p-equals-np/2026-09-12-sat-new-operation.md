# S3097: no new SAT operation survived source selection

2026-09-12; E004/S008; [integrity boundary](../../INTEGRITY-CLAIMS.md). **Selection NONE.** No new constructive operation toward total polynomial SAT was obtained. This is a bounded primary-source selection record, not a discovery, theorem, implementation, impossibility result, or exhaustive frontier survey. The objective remains ACTIVE and INCOMPLETE; publication HOLD.

The [catalytic attempt](2026-09-12-frontier-constructive.md), [resolution-frontier attempt](2026-09-12-resolution-search-mechanism.md), and [recent graph](2026-09-11-research-meta-graph.md) were read before selection. Their rejected oracle, state-preparation, representation, and full-frontier substitutions are not reopened. The existing random-input FKO results already distinguish distributional success from worst-case SAT; this record does not rediscover that distinction as progress.

## Current source and executable operation actually available

[Basu, Hsieh, Lin and Manohar, ICALP 2026, Definition 2 and Theorem 4](https://drops.dagstuhl.de/storage/00lipics/lipics-vol374-icalp2026/html/LIPIcs.ICALP.2026.23/LIPIcs.ICALP.2026.23.html) give a planted-CSP search algorithm. Its outline is: form candidate noisy parity instances, use degree-O(ell) SoS to approximate the planted assignment, then round and produce a short candidate list. For arity 2 <= k <= c log(n), with sufficiently small constant c, and planting-distribution complexity r, the runtime is n^{O(ell)}, with 2k <= ell <= n/8. The required density is

    m >= 2^{O(k)} n log(n) max{(n/ell)^{r/2-1}, 1}.

The list has at most 2^{k+2} assignments and contains the plant with high probability over the input distribution. That distribution draws scopes independently and uniformly with replacement; conditional literal signs come from a planting distribution supported on the predicate's satisfying inputs. The plant itself may be arbitrary. This is not a success guarantee on every satisfiable formula. Fixing k=3 and constant ell permits polynomial time at sufficient planted density; making ell grow does not preserve that bound.

The [current arXiv record](https://arxiv.org/abs/2507.10833) was checked in addition to the proceedings theorem. No independent verification of its proof or numerical implementation is claimed.

A closer 2026 source check, [Kothari, ECCC TR26-099](https://eccc.weizmann.ac.il/report/2026/099/), gives a spectral approximation and planted noisy even-XOR SoS integrality application, still on a random hypergraph. Its abstract does not provide a worst-case SAT transformation. It is corroborating source context, not a second nominated mechanism.

## Source gate: no uncertain operation reached implementation

The one prospective application inspected was to randomize a fixed CNF into an instance usable by planted recovery, then decode and check the original formula. No concrete new transformation with that property was found.

Global variable renaming and polarity masking give a known reversible representation of the same formula. They preserve its incidence structure up to isomorphism. Repeating clauses or sampling from its clause list likewise does not turn its scopes into the independent uniform scopes required above. These facts reject invoking that particular source guarantee for those wrappers. They do **not** establish that its algorithm fails on those wrappers, or that another randomization or distributional analysis is impossible. A source hypothesis mismatch is not an algorithmic lower bound.

The source gate settles this proposed *justification* before any empirical uncertainty arises. Therefore no planted benchmark, easy counterexample, SDP run, synthetic experiment, or newly named transformation lemma was produced. There is no refinement selected: independently creating a fresh planted instance would still need a concrete construction tied to an unknown witness and a valid decoder. Merely asking for such a construction is the missing task, not a mechanism.

## Exact full target contract, still unmet

For clarity, the authorized randomized intermediate target would require a uniform executable procedure A and a fixed polynomial p, on every CNF F of encoded length L:

1. On **every** random tape, A halts within p(L) bit operations and outputs an assignment or FAIL. Workspace, input/output, random bits and every subroutine are included. For variable-density inputs, formula reading and all generated constraints count toward this bound.
2. Every assignment is checked against the original F in polynomial time. Invalid candidates become FAIL. Hence UNSAT inputs never accept, including inputs outside any subroutine's promise.
3. For **every** satisfiable F, the probability of a verified assignment is at least 1/p(L). This quantifier concerns A's coins on that fixed F, not a random input ensemble, an unspecified favorable seed, or a promise-only subset.
4. Independent polynomially many bounded trials raise success to at least 2/3. FAIL after this budget is a randomized rejection; it is not a certified UNSAT answer. The resulting consequence would be SAT in RP and NP=RP, not P=NP or a zero-error algorithm.

For the contemplated recovery application, this bound must pay for any SAT-to-fixed-arity conversion, instance generation, seed sampling (including rejection-sampling cutoff), list generation, numerical precision, decoding and verification. No efficient recognition of the distributional promise is assumed: off-promise inputs must still produce a verified assignment or FAIL within the bound. A detected numerical failure or timeout returns FAIL. There can be no SAT oracle, unknown planted assignment supplied as advice, uncharged preprocessing, postselection, or unbounded search for a favorable transformed instance. A decoder alone cannot repair a missing all-input success bound.

This is an acceptance contract, not an algorithm outline for an invented new solver. The only algorithm outlined above is the imported planted algorithm under its actual promise. No new total procedure meeting items 1-4 is supplied. Deterministic total polynomial decision on every CNF remains the stronger original objective; an RP intermediary would require a further result to reach it.

## Preservation and review status

Only this assessment is authored by the constructive scout. Initial satellite HEAD was `be772260f80260d6fccb288d485ae2242496ea34`, with a clean worktree. No destination AGENTS.md was present; the assigned satellite boundary and integrity file were followed. No code, Lean claim, executable graph edge, push, publication, outreach or paid computation is part of this work. The subsequent root-authorized closeout preserves the assessment and reviews in a local commit only.

The bounded assessment is complete; the unrestricted target remains ACTIVE and INCOMPLETE. Selection NONE is not route-final completion of the research objective.

| Lens | Actual verdict | Scope |
|---|---|---|
| [Independent proof/adversarial](2026-09-12-sat-operation-proof-review.md) | PASS | Randomized acceptance contract and bounded source-transfer assessment; full target INCOMPLETE |
| [Source/model](2026-09-12-sat-operation-source-review.md) | GO | Actual source promises, computational costs and conditional RP consequence |
| [Non-claims](2026-09-12-sat-operation-nonclaims-review.md) | GO | Actual main, review integration and scoped graph record; selection NONE and publication HOLD |

The source and non-claims lenses were performed by the same AI agent and are not independent of one another. The proof reviewer is a distinct agent and supplied no candidate construction or repair; its requested source-range clarification is disclosed in its review. The source reviewer supplied a follow-on source pointer and model cautions, then performed the root-authorized integration. These are two agents providing three disclosed lenses, not three independent reviewers, Lean verification, human peer review or novelty certification.
