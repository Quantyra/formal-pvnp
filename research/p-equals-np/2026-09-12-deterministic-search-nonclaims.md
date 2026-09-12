# Deterministic-search screening: nonclaims review

2026-09-12; S3116 / E004/S008. Separate AI scope reviewer output_scope_review.
**GO for source/screening accuracy and bounded selection NONE.** This is
not a new mechanism result, proof campaign or complexity-class advance.

Read INTEGRITY-CLAIMS.md, planning's S3116 story and literature trigger,
and the applicable frontier/contribution-first protocol. Read the complete
actual [intake](2026-09-12-deterministic-search-intake.md), SHA256
`75BE0319C25A89B0B47A312199B2AEE524E31CB0477D17C8A5A5BB9565318837`,
and final [independent challenge](2026-09-12-deterministic-search-challenge.md),
SHA256 `3C4268BD0F8E03F68C0DE14B7097F88915750DA2FA780925AED40DE1CF262895`.
The challenge pins that intake and reports PASS/NONE with no outstanding
correction. This lens checks claims against that actual evidence; it does
not claim another live literature survey or independent proof of each source.

The Liu deterministic general-3-SAT comparator is explicitly the strongest
applicable bound located in a bounded search, not an exhaustive current-record
certification. Partial PPSZ derandomization retains its few-solution dependence
and original forcing constant; interleaving restriction sizes removes a need
to know the solution count without giving an exact-count oracle. Unique/few-
solution guarantees do not become a general UNSAT timeout. Dense-CNF search
keeps its density promise. Lyu's PRG seed bound requires charged enumeration
and sufficiently small additive error to guarantee hitting a singleton
solution; that particular guarantee is not a lower bound on every PRG or
every formula-specific search. Current primary citations and the limited
extent of the checks are disclosed in both records. Novelty and priority
are not certified by failure to locate stronger results.

Zaleski's inclusion-exclusion/Bonferroni SAT procedure is direct prior
machinery for the screened operation. Adding ordinary prefix branching is
not identified as a changed cancellation or search mechanism. The records
do not claim every wrapper detail is literally in the source, only that
no concrete additional saving operation emerged. An original structural
analysis of a known operation could still be research; NONE does not demand
that its final conjectured bound already be proved.

The screened deterministic procedure is specified and sound: simplify and
unit-propagate, enumerate clause-falsification intersections through fixed
even order r, prune only at upper bound U_r=0, otherwise branch in fixed
variable order, and check complete witnesses. A compatible intersection is
a subcube with 2^(N-v) assignments, not an unexplained residual #SAT query.
No hidden satisfying-assignment, global counting or success-probability
oracle appears. Positive U_r does not certify satisfiability.

With Q=sum_(j<=min(r,m))binom(m,j), per-node work Q poly(n,m,r) and
O(n+r log(m+1))-bit integer accumulation are charged. Streaming avoids
storing every intersection but not computing them. Fixed r permits
polynomial per-node work; increasing r changes Q, and r=m can enumerate
2^m intersections. Zero random seed bits do not eliminate the binary search
tree. The generic 2^n Q poly(n,m,r) upper bound is neither an established
improved deterministic base nor a runtime lower bound. No unproved global
amortization is inferred from polynomial local cost.

The even-order identity

    U_r = #SAT + sum_(t>=r+1) N_t binom(t-1,r)

is analysis of the explicit truncated sum. N_t need not be computed by
the procedure. It says exact-zero pruning requires UNSAT and no assignment
violating more than r residual clauses. Joint falsifiability of r+1 clauses
therefore prevents that particular zero test. It does not prove the solver
visits exponentially many nodes, refute every aggregate analysis, or supply
a family hard for other algorithms. Disjoint satisfiable clauses may admit
a first-branch witness; an easy separate UNSAT core may succumb to
propagation/decomposition. The challenger supplied this important diagnostic
and the direct prior-source comparison; its role is substantive screening,
not verification-only provenance.

A smaller exponential deterministic SAT upper bound would improve an exact-
algorithm guarantee without settling P versus NP. Uniform deterministic
search guaranteed in known polynomial total bit time on every satisfiable
3-CNF, with sound output checking and a corresponding polynomial timeout,
would decide 3-SAT and imply P=NP. No such guarantee is established here.
A promise-only or unbounded satisfiable-only search does not supply that
stopping contract. Failure of this screen proves no separation.

Final selection NONE is limited to this known truncated-count/pruning
operation as screened. No changed cancellation, restriction selection or
construction operation was found to justify a follow-on proof campaign or
experiment. It is not frontier exhaustion, universal impossibility, proof
of algorithmic slowness or a prohibition on speculative new constructions.
The source comparisons and accurate diagnostic complete a bounded selection;
they are not a novel research result or publication milestone.

No automatic successor, repeated known demonstration or public claim follows.
The root authorized these three records plus a graph update and local scoped
commit after final actual reviews. All previous proofs/public artifacts remain
unchanged. The broader objective remains ACTIVE and unresolved. Review is
informal AI work, not human peer review or Lean verification; no formal build
is relevant. Only this nonclaims record was written before authorized evidence
integration. No experiment, proof/public edit, push, outreach or spend is
performed. Frozen for scoped integration.
