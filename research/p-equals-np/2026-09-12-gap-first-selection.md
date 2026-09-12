# Gap-first selection: current streaming lower bounds and MCSP

2026-09-12; S3082 under E004/S008 and [integrity](../../INTEGRITY-CLAIMS.md). One bounded candidate; **selection NONE**. This is a source-backed rejection of a proposed application before a derivation campaign, not a novel lower bound or publication claim. Independent [source/scope review](2026-09-12-gap-first-selection-review.md) is GO for this bounded assessment and selection NONE.

## Candidate and precise missing guarantee

**Proposed application:** transfer the 2026 general CSP streaming lower bound to circuit synthesis by an online reduction producing an MCSP truth table. The attraction is a genuinely current, broad lower-bound theorem and a published direct P-versus-NP implication. The critical question is whether its resource contract can transfer; the word "streaming" alone does not supply that connection.

Write m for the source CSP variable count, N=2^n for the target truth-table length, and s(n)>=n for a time-constructible circuit threshold. For a concrete small-threshold test take s(n)=n^k, fixed k>=1, and n=O(log m). The contemplated reduction would process the source in one pass, emit the target bits in their prescribed order, preserve the two answers, and have o(m) total workspace after composition, including buffers and output interpretation. No reduction with these properties is supplied or claimed new.

**Closest results:** [Singer-Tulsiani-Velusamy, arXiv:2604.08731v1, Theorem 1.2](https://arxiv.org/html/2604.08731v1#S1.SS2) gives an Omega(m) single-pass space lower bound for distinguishing CSP values at least gamma-epsilon from values at most beta+epsilon when the basic LP has a (gamma,beta) integrality gap. Fix an epsilon leaving disjoint promises. Its streaming model explicitly imposes no bound on computation time; arbitrary state transition functions are permitted. This is a preprint theorem statement, not a proof independently verified here.

[McKay-Murray-Williams, STOC 2019, Theorem 1.3](https://people.csail.mit.edu/rrw/MCSP-MKTP-stoc19.pdf) states: for some time-constructible s(n)>=n and A in PH, excluding every deterministic one-pass algorithm for search-MCSP^A[s(n)] with both polynomial-in-s space and polynomial-in-s update time implies P!=NP. Search returns an at-most-s circuit, or reports nonexistence. Taking A to be the empty oracle is permitted. Theorem 1.2 already provides this synthesis in roughly s space with short Sigma_3^P oracle queries and polynomial update time when oracle work is free.

**Why not already implied:** the CSP theorem lower-bounds retained information regardless of computation. The MCSP target must exclude efficient transitions, not merely short states. The required missing guarantee is a time-sensitive transfer to that joint resource bound. No such guarantee follows from the two theorem statements.

## First falsifiable obligation and its outcome

Before constructing the reduction, test whether it would also apply when the MCSP updates are arbitrarily slow. This is an immediate compatibility test, not an experiment.

For A empty, short Sigma_3^P queries can be evaluated by exhaustive quantifier evaluation in polynomial workspace, reusing scratch between queries. Thus the known oracle streamer yields an ordinary deterministic polynomial-in-s-space streamer with possibly enormous update time. This is our straightforward resource inference from the source upper bound; it gives no polynomial-time algorithm.

For s(n)=n^k and n=O(log m), that workspace is polylog(m). Composing it with a reduction whose total workspace is o(m), whose target stream has one pass, and whose output interpretation preserves correctness would produce an o(m)-space source CSP algorithm. Unlimited update work remains allowed in the source model. That contradicts the cited CSP space lower bound. Storing the synthesized circuit, if needed, costs only polynomial-in-s space.

Therefore **the proposed purely space-preserving black-box application fails its first test** in this parameter regime. Choosing larger target s may avoid the contradiction, but also removes this route's desired sublinear-space comparison. This excludes neither arbitrary reductions nor time-sensitive lower-bound arguments. It is not a new general barrier theorem: the original MMW discussion already distinguishes the computational obstacle from an information-theoretic one.

## Decision and re-entry criterion

| Required selection item | Assessment |
|---|---|
| New application with evidence of viability | Not established; the explicit proposed transfer is incompatible with the source models. |
| Exact P-versus-NP relationship | The fully achieved MMW joint-resource lower bound has a direct P!=NP implication. A restricted CSP space bound alone has none established here. |
| Strongest objection | MCSP's small-state, unlimited-update-time upper bound defeats a pure space argument at the stated parameters. |
| Next mathematical obligation | An explicit mechanism sensitive to bounded transition computation, with a transfer proof that does not assert an unconditional small-space reduction. Merely naming this obligation is not a mechanism. |
| Stop condition | Stop this application now; do not derive or experiment with it. Reopen only with a concrete mechanism meeting that distinction. |

No second candidate is manufactured to fill a quota. The parked quantum-transfer novelty question, witness-to-diagonal charging, and description-prefix reconstruction are not restarted. The outcome is an early rejection rather than another developed application of known machinery presented as discovery.

## Access, ancestry and verification limits

The September 12 bounded searches included current MCSP magnification/locality follow-ups and MCSP streaming update-time lower bounds through 2026. The MMW full primary PDF, its theorem/proof sections, and the current CSP HTML theorem/model sections were opened. The CSP arXiv record lists v1 dated April 9, 2026. The concurrently independent [Fei-Minzer-Wang preprint](https://arxiv.org/abs/2604.01400) was checked at abstract/version level only; no stronger theorem from its body is used. No exhaustive literature or priority conclusion follows from these searches.

[STACS 2021, One-Tape Turing Machine and Branching Program Lower Bounds for MCSP, Lemma 17 and Section 3.1](https://drops.dagstuhl.de/storage/00lipics/lipics-vol187-stacs2021/LIPIcs.STACS.2021.23/LIPIcs.STACS.2021.23.pdf) independently restates the short-oracle streaming upper bound and discusses model/parameter limitations. Its one-tape results are not unrestricted streaming or general-circuit lower bounds. The earlier [research graph](2026-09-11-research-meta-graph.md) retains all verified and parked routes.

Baseline satellite HEAD: `af0807b7fb3209103c6d3cf3ea085801f6493ec4`, initially clean index and worktree. No destination AGENTS.md was present; the root-provided satellite boundary and INTEGRITY-CLAIMS.md were followed. No implementation, proof formalization, experiment, external publication, push or paid work occurred. This assessment's ordinary resource inference and source matching received independent review GO; no claimed new theorem is routed to formal build.
