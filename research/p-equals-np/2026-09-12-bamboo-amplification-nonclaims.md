# Bamboo amplification intake: claims and selection-boundary review

2026-09-12; S3111 / S008. Independent AI nonclaims lens,
output_scope_review. Informal applicability/selection review, not a new
mathematical proof, human peer review, Lean verification or publication gate.

## Actual evidence and scope

Read INTEGRITY-CLAIMS.md, planning's S3111 story, the complete saved
[author intake](2026-09-12-bamboo-amplification-intake.md), and the
[independent applicability challenge](2026-09-12-bamboo-amplification-independent.md).
The author snapshot is SHA256
`2db5661ae7727780d341b83fb99ac7648c3d8eac7325cfeb995d564d49af9453`.
Final independent crosschallenge and pins are recorded below.
This lens compares the actual proposed operations and conclusions; it does
not claim another primary-PDF audit or exhaustive literature search.

The inherited theorem is fixed q even>=1024, m=q^2, N=8q+4,
D=floor(q/(32 log_2 q)), with every fixed Boolean output A. Real SoS
size is sum_i ||f_i||||g_i||+sum_j ||h_j||, on explicit ordinary monomials,
roots before squaring, no degree bound and no coefficient-bit charge.
The residual row-space PSD supports at most 2D typed labels in each
monomial, with unrestricted sums; it does not cover arbitrary full-row
collections. F_2 rank/parity constraints and real polynomial certificates
remain distinct. All-A source laws do not supply joint consistency when
output parameters are variables of other nodes.

The source PCR iteration and graph/extension-variable variants have
specific fields, encodings and degree-reduction endpoints. A substitution
preserving squares does not itself preserve explicit root size. Source
permission for size growth in a degree contradiction is particularly
inapplicable to a size contradiction unless separately charged. Semantic
axiom implication does not give a bounded ideal simulation, and characteristic-
two sums cannot be substituted as ordinary real sums. The intake correctly
refuses these automatic transfers without claiming a universal barrier to
other proof systems, encodings, simulations or coupled-law constructions.

## The proposed map is explicit; its hardness remains unproved

The row-aligned binary tree uses the first 4N parent output columns as
[X_child0, X_child1, Y_child0^T, Y_child1^T]. The remaining columns are
unobserved rather than set to zero. Every node keeps the same q,m,N.
At leaf depth d it has V=2^(d+1)-1 nodes, root seed s=2mN, and external
output T=2^d m^2 bits. Intermediate seeds and prefixes are existential
witnesses, not new seed bits. Its CNF contains V(s+m^2 N) variables,
V(6N-3)m^2 computation clauses, 4s(V-2^d) wiring clauses and 2^d m^2
leaf units, before twins. These distinguish computation clauses from the
output clauses changed by composition. No hardness is inferred from merely
specifying that inversion relation or its uniform construction.

Explicit construction has the stated O(V q^5 log(Vq)) cost and evaluation
O(V q^5); bit access along one path has a different cost contract. A
superpolynomial-length output cannot have polynomial total writing time in
root seed length. Output length T, its ratio T/s, encoding length, depth,
and lower-bound exponent must remain separate. The reports do not present
an amplified exponent or an all-length family. The independent reviewer
replaced the initially undefined 'function-length' wording with the precise
'superpolynomial-length' after this lens's wording observation.

Truncating unused internal outputs is part of this exact map. The fresh
mathematical reviewer identified a genuine direction-of-inclusion error in
the initial author intake; this lens's draft repeated it. Both are corrected:
for one copy retaining the gate encoding, all-output hardness DOES pass to
coordinate projection. Any certificate for gates plus observed output units
is the identical certificate for every full output completion, using zero
multipliers for the added units. Its size is unchanged; a satisfiable
completion means no such certificate exists. Projection is therefore not a
blocker. The remaining issue is the coupled variable-output tree, not this
single-copy restriction of observed coordinates. This mathematical correction
was supplied by the fresh reviewer, not by this nonclaims lens.

## Concrete failure scope and recommendation

Three distinct claims have concrete counterchecks, each with a limited scope:

- Leafwise nonrange detection is false for this wiring. The off-diagonal
  rank-N identity block A0 and A1=0 are separately in the base range, yet
  their depth-one pair is nonrange because the combined row/column span of
  A0 has dimension 2N>N, while the wiring forces both into one parent span.
  This is neither a short SoS refutation nor an impossibility theorem for
  tree pseudoexpectations or amplification.
- Independent source restrictions do not retain the literal-image contract.
  The displayed template block 7 produces a child-bit XOR residual-prefix
  image when that child bit survives. Its real polynomial is a+u-2au (up to
  complementation). The existing literal-survival proof cannot simply be
  reused. An uncomplemented image has at most three terms; a complemented
  image 1-a-u+2au has four, so the uniform expansion upper bound is 4^K.
  The fresh reviewer supplied this correction to the initial 3^K statement.
  That upper bound supplies no degree-free constant cost per original
  monomial; it is not a lower bound on every substitution, nor does absence
  of a replacement bound itself disprove a new mechanism.
- The author supplies an actual closure/conditioning sampler: close complete
  child rows under parent dependencies, sample source full-row laws, and
  condition on wiring, with zero conditioning probability treated as failure.
  Its parent closure asks for N independent columns plus the fixed column at
  width N, or q plus the fixed column in the idealized residual setting.
  That source-law recipe has an empty fiber by dimension. This rejects this
  explicit sampler, not all distributions allowing dependent columns or
  another partial-information coupling.

The exact parity-elimination polynomial has 2^N-1 distinct monomials for
one bit. This exceeds the scale of the proved base bound and prevents that
naive compiler from obtaining the intended transfer at that budget. It does
not upper-bound actual refutation complexity, establish a general
representation lower bound, or preclude an extension-variable approach.

The author's NONE recommendation is therefore bounded to its concrete
attempts, supported by failed representation/fiber/semantic contracts rather
than treating an unproved estimate as a veto. Its request for a new explicit
partial-information operation is an unselected research requirement, not a
proved gluing theorem, selected named residual, or evidence that no solution
exists. The independent obligations for nonempty consistent fibers, cross-node
PSD, wiring-compatible shrinkage and charged axiom simulations remain future
proof requirements. The root decides whether any successor is selected.

No new amplified SoS theorem, arbitrary-m result, circuit-certificate bound,
computational pseudorandomness, inversion hardness, general SAT runtime or
P-versus-NP conclusion follows. Existing published v4 remains unchanged.
Novelty and priority of broader methods are not certified; the literature
checks are bounded applicability comparisons with standard work credited.

## Final crosschallenge and disposition

Read the final actual independent crosschallenge at SHA256
`8B74F694543867700AD7A2DEFE57028F6FEB56CCA8EC322DA1DD70E7797502FC`,
including its explicit review of the corrected author snapshot above
(14916 bytes), both contribution disclosures and final PASS. I reread the
author's corrected projection and complemented-XOR paragraphs; neither
correction is a repair of the published v4 theorem.

**Final nonclaims disposition: GO for the corrected bounded intake and
NONE recommendation for the two specified recipes only.** The author's
explicit sampler and transport operations have actual failed contracts;
projection is a valid single-copy transfer and is not used as a blocker.
No new alternative is selected, and no global amplification impossibility,
novelty certification or amplified theorem is asserted. The independent
reviewer contributed the semantic test and two mathematical corrections;
this record does not label that role verification-only.

After the final actual-file PASS, the root authorized scoped integration
of the three intake/review records plus the research graph, recording its
bounded NONE selection. The broader research objective remains ACTIVE and
unresolved. This reviewer initially wrote only this nonclaims record; the
subsequent authorized graph and local-commit closeout are evidence tracking,
not proof execution. No theorem/public edit, experiment, push, outreach or
paid computation is performed. Frozen for scoped integration.
