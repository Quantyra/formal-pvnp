# S3058 proof-adversarial review

2026-09-11. Independent proof-adversarial lens for the [mechanism](2026-09-11-global-parity-learning.md), [executable](2026-09-11-global-parity-learning.py), and [saved certificates](2026-09-11-global-parity-learning.json), under [INTEGRITY-CLAIMS.md](../../INTEGRITY-CLAIMS.md). Complexity and nonclaims reviews are separately assigned. This is an informal mathematical and computational review, not Lean certification or human peer review.

**Verdict: GO under the documented normalized-input contract.** Case closure, common-equation learning, fixed-support termination, the guarded-prism exclusion and the all-size guarded-path ring argument are sound. The result separates this policy from its specified conflict-only comparator; it does not establish general SAT completeness or superiority over existing solvers.

## Soundness and progress

Every closure step is justified under its case assumptions. A clause unit follows only when its other literals are false; a guarded row activates only when all guard literals have been established. Gaussian outputs are linear combinations of unconditional rows, currently activated rows and justified units. Feeding a derived singleton equation back into Boolean propagation preserves soundness. Consistent closure remains a relaxation of the full case formula, so surviving cases need not have actual models.

A conflicting case proves its full pattern-negation clause. The assignments on each fixed support exhaust all possibilities. An equation lying in every surviving case's **augmented** row space consequently holds in every actual model; refuted cases require no further restriction. Coefficient-space intersection alone would be insufficient because it would discard right-hand-side differences. Computing the intersection via equal combinations of two bases and projecting a nullspace basis is exact linear algebra. Intersecting successively retains precisely the common linear consequences of the supplied closure systems, not necessarily all consequences of the complete case formulas.

All case analyses in a pass use one unchanged global snapshot. The resulting clauses and equations are added simultaneously. If every case of a scope conflicts, or the empty case conflicts, the original formula is inconsistent. The final batch's XOR contradiction is likewise an unconditional certificate once its learned equations have been justified across their cases.

Let B be the sum of pattern counts over the frozen original supports including the empty support. There are at most B distinct pattern-negation clauses. A productive consistent pass either raises affine rank or adds a new such clause. Thus at most n+B productive passes occur, plus a terminal sweep. Each case has at most n new variable assignments; all guards, clauses, Gaussian operations, intersections, proof masks and unsuccessful scans must still be charged. The documented polynomial bound is valid for fixed maximum guard width. Newly generated arbitrary supports or unbounded-width case splits would invalidate that bound.

The implementation assumes normalized guards with distinct underlying variables, as stated by the author. Review noticed that syntactically repeated guard literals would otherwise duplicate variables in the enumerated support. No change is required under the explicit input contract; this review does not certify an unvalidated general-purpose parser. OPEN remains unknown, not SAT.

## All-size family arguments

In the guarded k-prism, all activated vertex rows XOR to 0=1 because each edge appears twice and the total charge is odd. Connectedness also proves that the only nonempty incidence-row dependency is the full vertex set. The case g=h=1 therefore justifies `NOT g OR NOT h`. Other guard patterns activate no data equations. Their three allowed patterns have full affine hull, so no nontrivial unconditional affine equation substitutes for that exclusion. Learning the clause and returning OPEN is consistent with this satisfiable fixture.

For every ring size m>=3 and path length ell>=1, the AND clauses under one complete guard-pair assignment fix z_i=alpha*beta. Exactly one pattern-private path at position i activates. Summing its ell rows cancels its internal variables and gives `x_i+x_(i+1)=alpha*beta`. Conversely every endpoint pair with that parity extends along the path, so this is its exact projection.

Combining the endpoint equation with the fixed indicator yields `x_i+x_(i+1)+z_i=0` in every one of the four cases, despite their different internal variables. That equation belongs to the common augmented consequence space. The emitted basis need not list it verbatim; membership in the span of the emitted and already-present equations suffices. Summing these consequences over all m positions gives even indicator parity, contradicting the unconditional odd parity. The rule therefore refutes every member in its first common-consequence pass, with polynomial work in the explicitly written input.

The conflict-only comparison also holds for all these parameters. In one case the global indicator equation retains m-1>=2 unknown indicators, so it forces no additional individual bit. The one active open path has free endpoints and forces no internal or endpoint bit. Other AND blocks have no units, and no other guard pair becomes assigned. Hence every selected case closure, including the empty case, remains consistent; conflict-only learning has nothing to add. This is not a claim that the actual conditional formulas are satisfiable, nor that stronger propagation, other supports or other solvers fail.

## Reproducible independent certificate-validation method

The reviewer performed a read-only Python replay of the saved JSON using the pinned `ring(m,path_length)` and `prism(k)` constructors solely to recover the explicit inputs. The validator did not call the author's closure, learning or Gaussian-certificate verifier. To reproduce the replay:

1. For each case and pass, retain the current affine rows and CNF; initially use the constructor's input. Read each context's scope, binary pattern, chronological steps and certificates.
2. Check that assumption steps are exactly the scope pattern. At every clause step, independently evaluate the prior fixed variables and require that the remaining clause is precisely its asserted unit. At every Gaussian step, require the cited certificate row to be that unit and all cited unit-input indices to precede the step.
3. For each Gaussian certificate, require unit tags to be the complete initial segment of context steps. Reconstruct its input list exactly: current base rows, every guard true in that unit snapshot, then those units. Require earlier Gaussian unit reasons to refer to earlier certificates, excluding circular provenance.
4. Independently XOR the input rows selected by every output proof mask, including the right-hand sides. Reject out-of-range mask bits. For a contradiction mask require coefficient zero and right-hand side one. Using a separate highest-pivot binary elimination, check that output rows plus a recorded contradiction span the entire input augmented row space.
5. For each conflicting context check its falsified clause or final XOR contradiction. For each surviving context check that its advertised rows are exactly its last Gaussian rows and that its final certificate includes all its unit steps.
6. For each common equation require a complete set of scope patterns and one combination witness for every surviving case, with no survivor omitted. Independently XOR the cited case rows to the learned augmented vector. For each new nogood require a matching conflicting pattern and absence from the current CNF.
7. Reconstruct the batch-certificate inputs from the previous rows and learned-equation records, then repeat the XOR and span checks. Advance the current rows and clauses exactly as the trace specifies. Finally compare both SHA256-LF code pins against actual file bytes with CRLF normalized to LF.

This replay passed **80 contexts, 142 Gaussian certificates, 730 certified rows, 200 unit steps, 14 common equations, two nogoods and four batch contradictions**. It verifies provenance relative to the explicit constructor inputs and earlier justified learning; it is not a claim to have independently synthesized those proofs.

A separate check tested the augmented-intersection helper on all 121 ordered pairs of the 11 nonempty affine relations on two variables. Independent truth sets supplied every equation valid on the union of the two model sets; these matched the returned intersection spans, including offset-sensitive cases.

The saved four controls and six family cases match script SHA256-LF `af30f9351f8614a5582883f1f92ea876226ce31beb768ee66537b33d84242c2c`; the pinned S3056 helper also matches. No prior experiment suite was rerun. The all-size claims are established by the preceding derivations, rather than extrapolated from the finite traces.

The [source note](2026-09-11-global-parity-learning-sources.md) identifies direct prior common-consequence and conditional Gaussian-learning principles. This review does not establish novelty, a short-proof discovery guarantee on arbitrary inputs, or any P-versus-NP conclusion. No mathematical blocker remains within the stated scope.
