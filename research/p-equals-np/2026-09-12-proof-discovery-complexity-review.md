# S3084 independent complexity and source review

September 12, 2026. Reviewer: proof_discovery_challenge. Actual artifact inspected: [constant-image certificate compilation](2026-09-12-proof-discovery-mechanism.md). Scope: contribution-first selection, source transfer, resource model and P-versus-NP relationship. Verdict **GO for the bounded rejection / selection NONE**, not GO for a new algorithm, theorem of research significance, lower bound or publication.

## Primary-source comparison

Independently opened the full [Behera–Hansen–Limaye–Srinivasan ECCC TR26-002 PDF](https://eccc.weizmann.ac.il/report/2026/002/download/), especially Sections 1.3–1.4, Theorem 1.7 and Remark 1.8. Its upper guarantee in Theorem 1.7 is a functional refutation computed by a small syntactic multilinear circuit. Remark 1.8 explicitly distinguishes this from a full refutation in the corresponding restricted IPS class because the Boolean-axiom correction is not bounded. The main correctly identifies that caveat and does not import the theorem for arbitrary CNF arithmetic circuits. Addressing-gadget lifting and restricted separations do not supply a general certificate finder.

Independently opened [Grochow, Polynomial Identity Testing and the Ideal Proof System](https://arxiv.org/abs/2306.02184). The main correctly preserves the distinction between arithmetic circuit certificates and deterministic Cook–Reckhow verification. The source's equivalence with PIT in NP does not make a deterministic polynomial-time verifier available here. Nor does it rule out a specially structured format with its own deterministic checker.

For an independent proof-search comparator, [Atserias–Müller, Automating Resolution is NP-Hard](https://www.cs.upc.edu/~atserias/papers/automating-resolution-np-hard/automating-resolution-np-hard.pdf), Definition in the introduction and Theorem 1, measures automatability in input size plus shortest refutation length and proves polynomial automatability would imply P=NP. The main does not mistake polynomial dependence on an unbounded proof parameter for input-polynomial SAT decision. Its separate sufficient input-timeout contract is valid; it does not purport to enumerate every possible route to P=NP.

## Strongest escape and mathematical scope

The source warning alone was not sufficient to reject the proposal: unrestricted circuits can escape its syntactic multilinear restriction. I therefore challenged the author to account for a stronger escape. The Boolean aggregate has inexpensive unrestricted circuit coefficients for its idempotence defect. The author incorporated this, and a separate proof reviewer independently checked the identities and shared-DAG accounting.

For p equal to the clause-violation aggregate, the shifted equation 2-p=0 is unsatisfiable for every CNF. Its inverse candidate (1+p)/2 and polynomial-size Booleanity correction provide a full unrestricted IPS refutation. This succeeds computationally but cannot distinguish satisfiable from unsatisfiable original formulas. The correction required for the original decision is instead 1-p in the Boolean ideal. On UNSAT inputs the constant functional inverse 1 does not construct that correction.

The main's singleton SAT and contradictory-unit UNSAT examples correctly distinguish formal polynomial identity from identity modulo Boolean axioms. Its exhaustive Boolean evaluation is an available upper bound, not a general lower bound. XOR elimination, counting, symmetry, decompositions, preprocessing or a quantum subroutine cannot restore the discarded SAT distinction merely by refuting the same shifted system. A different procedure using retained information is not excluded, and no common barrier against those methods is claimed.

## Decision

The precise proposed new guarantee was a uniform, charged conversion to sound refutations of the original CNF. The tested inverse mechanism does not provide it. The result is an elementary source/application compatibility rejection, not a novel impossibility theorem or discovery. Polynomial certificate existence, constructive discovery, total bit complexity and deterministic verification remain distinct. No algebraic-class or restricted-proof-system separation is promoted into a Boolean P-versus-NP separation.

No publication candidate emerged. This review supports parking this exact transfer and preserving its failure in the research graph. It does not establish that every possible certificate-compilation mechanism fails, certify a breakthrough, or complete the overnight objective. No code experiment, Lean verification, publication, push, spend or external communication was performed by this reviewer.
