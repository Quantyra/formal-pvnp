# Sparse/dense collision schedule: nonclaims review

2026-09-12; S3117 / E004/S008. Scope reviewer output_scope_review.
**GO for the bounded design assessment; NONE for the proposed extra
inverse-multiplicity work credit.** This is an actual changed-rule attempt
with a failed local cost inference, not a new SAT advance or global lower bound.

Read INTEGRITY-CLAIMS.md, planning's S3117 story and literature trigger,
and the applicable frontier protocol. The root's recorded authorization
covers the explicit score, free/used-variable checks and bounded repair
assessment. Read the complete [design](2026-09-12-sparse-dense-search-design.md),
working SHA256 `46FDA9B564BD509CCDC76D29174AB9CB122B3834442A093EC528C778D8D0F87C`,
and final [actual challenge](2026-09-12-sparse-dense-search-challenge.md),
working SHA256 `9B92D21423605B6006FEDCDC425B68F417574C92E7C14E6B390C236715B074E1`.
The challenge pins that design and reports PASS with no correction remaining.
The author subsequently removed only excess EOF newlines after cached
whitespace validation failed; the prior working hash was
`68CC5A7FADC0A8F20C019A02D3B688271EECC9ADA47E844ED8BE121CDB02870E`.
Direct byte comparison confirmed the substantive text is unchanged.
These are byte hashes of frozen working files; integration separately
checks Git blob identity and line-ending normalization.

The operation genuinely specifies a block choice and order: enumerate all
b-subsets for b about log N and their assignments, canonicalize residuals,
group identical (remaining universe, residual formula) pairs, minimize
sum_C 2^ceil(2N_C/5)/w_C, and visit classes by decreasing multiplicity.
It uses exact rational comparison and deterministic ties. The score is a
computable proxy, not a published general-case search bound. Identity merging
is known residual caching; novelty of this additional heuristic is unknown,
and the reports neither equate every score with caching nor claim invention.

Every assignment, unit-forced bit and retained free variable is accounted
for. One representative of an identical residual preserves satisfiability
with reconstruction. No semantic equivalence oracle, exact solution count or
hidden witness is used. The fixed source-algorithm simulations have explicit
finite caps and verified-output acceptance: a timeout never means UNSAT.
Recursion, not the promise-only subroutine call, supplies completeness.
All block candidates, failed calls, normalization, comparisons, reconstruction
and verification are paid. The selector costs N^O(log N) per node, not
polynomial, and gives no global node bound. The rational proxy is not made
valid by being cheaper to compute.

Source contracts are correctly separated. Liu's few/unique-solution constants
are not updated by newer randomized PPSZ results. Servedio--Tan's full theorem
allows arbitrary positive epsilon but charges its dependence; the near-
polynomial specialization needs adequate density and polynomial clause count.
Unknown-density scheduling already exists and is not the new mechanism.
Finite simulations assert neither source promise on every residual. The
reported general deterministic comparator is qualified as a bounded source
comparison, not a certified exhaustive current record. This lens audits those
claims from the actual reviews, not an additional live literature survey.

The proposed extra work credit fails exactly where claimed. For one fixed
block, model preservation gives S(G)=sum_C w_C S(H_C) and

    mu(G)=sum_C w_C 2^(N_C-N) mu(H_C).

The forced-variable dimension matters; w_C/2^b is the simpler weight only
when no extra variables are forced. These are analysis identities, not
algorithmic count queries. Free-variable padding gives w=2^b with no density
increase and the identical residual H. Used-variable padding by r disjoint
(z_i OR t_i) clauses gives w=3^r while density increases by (4/3)^r,
not 3^r. The residual still has exactly H's search task and density.
The small-r alignment is explicitly r>=2; the example is admitted by the
block enumeration but is not proved to be globally selected by its score.

An easy H made of disjoint 3-clauses can have arbitrarily small density.
This refutes multiplicity as a dense-residual promise, not the solver's
speed on H or general SAT hardness. Decomposition, propagation and ordinary
caching are same-instance escapes. Their availability is retained, not
hidden behind a supposedly hard padding example.

If a deterministic evaluation of H takes t_H positive steps, replacing w
copies by one costs t_H instead of w*t_H. It does not additionally execute
that surviving call in t_H/w steps. This local accounting fact neither
lower-bounds t_H nor refutes every possible global amortized potential or
useful ordering heuristic. The numeric score alone supplies no extra credit.
The valid repaired recurrence pays selector cost plus one full evaluation
per visited distinct residual, including probes and reconstruction. Removing
the extra factor leaves known caching; no concrete new amortized saving
operation emerged. NONE is therefore supported by the failed specified
credit, not rejection merely because the final runtime theorem is unproved.

The challenger contributed the full dense-source contract, forced-dimension
density identity, used-variable diagnostic and r>=2 correction. This is
substantive constructive challenge, not verification-only provenance.
The corrected actual files preserve all these disclosures. No novelty,
publication significance, general heuristic impossibility or frontier
exhaustion is claimed. No experiment or redundant demonstration is needed.

A better exponential deterministic SAT algorithm would not resolve P versus
NP. Uniform polynomial total-bit-time witness search on every satisfiable
3-CNF with sound checking and a known polynomial timeout would imply P=NP;
this attempt supplies neither that bound nor a separation. No XOR/algebraic,
quantum or proof-system lower bound follows from this failed score.

The root authorizes only these three records plus a graph update and local
scoped evidence commit after final GO. Prior proofs/public artifacts remain
unchanged, and no automatic successor is selected. The broader objective
remains ACTIVE and unresolved. This is informal AI design review, not human
peer review or Lean verification; no formal build applies. Only this scope
record was written before authorized graph integration. No public/proof edit,
experiment, push, outreach or paid computation is performed. Frozen for
integration with working-file and Git-blob identities recorded separately.
