# Independent proof-adversarial review: constant-image compilation

2026-09-12; S3084/E004/S008. Final proof verdict: **GO for the elementary identities and bounded failed-use diagnostic** in the [main assessment](2026-09-12-proof-discovery-mechanism.md). No new theorem, SAT algorithm, lower bound, novelty or publication readiness is certified. This is an independent agent review under [integrity](../../INTEGRITY-CLAIMS.md), not Lean verification.

## Independently checked identities and sizes

Over the rationals, a clause-violation product v_C is 0 or 1 on the Boolean cube, including the constant-one product for an empty clause. Thus p=1-product_C(1-v_C) equals one exactly when some clause fails. Its arithmetic circuit has O(L+m+1) size after standard literal simplification. Boolean reduction modulo I_B=<x_i^2-x_i> gives a unique multilinear representative. Evaluation on the cube is injective for multilinear polynomials, by induction on variables (equivalently interpolation). Hence F is UNSAT if and only if 1-p belongs to I_B.

For purported coefficients H_i with 1-p=sum_i H_i(x)(x_i^2-x_i), the main's IPS circuit D(y)+sum_i H_i(x)z_i, where D(y)=1-product_C(1-y_C), is zero when all axiom placeholders vanish. Substituting clause and Boolean axioms gives p+(1-p)=1. Its signs are correct. No construction or size bound for the necessary H_i follows just from the existence of an inverse on the cube.

For F=(x), p=1-x and 1-p=x is not in I_B. For F=(x) AND (NOT x), p=1-x+x^2 and 1-p=-(x^2-x), which is a nonzero formal polynomial. These examples correctly distinguish ordinary polynomial identity testing from Boolean-ideal membership.

I independently expanded the proposed gatewise identities:

    (ab)^2-ab = b^2(a^2-a)+a(b^2-b),
    (1-a)^2-(1-a) = a^2-a.

At input x_j, the defect coefficient vector has entry 1 at j and 0 elsewhere. Constants 0 and 1 have zero defect. At a NOT node retain the coefficient vector. At an AND node with child vectors A_i and B_i use b^2 A_i+a B_i. Keeping references to existing gate circuits and coefficient nodes creates O(n) new arithmetic gates per original gate, for O(n*s) size with shared DAGs; it does not expand each product into monomials or unfold reused subcircuits. All introduced scalar constants have bounded bit length. If one requires separately represented coefficient circuits instead of a shared multiple-output representation, copying the polynomial-size shared DAG a polynomial number of times still gives polynomial size. This is an unrestricted arithmetic-circuit claim, not preservation of multilinearity or constant depth.

The aggregate consists of variable literals, complements and products, so these rules construct B_i satisfying p^2-p=sum_i B_i(x)(x_i^2-x_i) for EVERY input CNF.

The shifted inverse calculation is exact:

    (2-p)(1+p)/2 = 1-(p^2-p)/2.

A full IPS refutation of the shifted equation 2-p=0 together with Boolean axioms is therefore

    C_shift(x,y,z)=((1+p(x))/2)y+(1/2)sum_i B_i(x)z_i.

It vanishes at y=z=0 and equals 1 under y=2-p and z_i=x_i^2-x_i. In particular this full cheap refutation exists for SAT inputs too: on the cube 2-p is either 1 or 2, never zero. It refutes the shifted equation, not the original clause system. This verifies the sharper correction argument independently of its originating source challenger.

## Discovery and verification boundary

A hypothetical uniform procedure with a known polynomial timeout and deterministic sound certificate checking, complete for every UNSAT input, yields deterministic polynomial SAT decision by timeout and verification, as stated. Completeness only for certificates of unbounded size, or polynomial existence without discovery, does not suffice. General arithmetic circuit identities in IPS checking must not be assumed to have an available deterministic polynomial algorithm; the separate complexity/source reviewer owns the precise cited PIT equivalence. The local syntactic gate identities checked here do not discharge the missing SAT-dependent H_i construction.

## Final assessment

The main correctly separates the easy Booleanity correction p^2-p from the SAT-dependent correction 1-p. It does not falsely infer a restricted IPS separation from the unrestricted gate construction, or infer P=NP from randomized verification. Selection NONE and publication not selected are consistent with these calculations: the proposed new capability has not been obtained, and the verified identities are standard algebraic diagnostics. No universal impossibility is proved.

Only this review file was written. No author or graph edits, experiment, commit, publication, push, paid service or external communication was performed. Source novelty and final graph scope are separate review obligations.
