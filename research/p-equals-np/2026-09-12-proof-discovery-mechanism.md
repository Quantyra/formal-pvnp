# Constant-image certificate compilation: selection NONE

S3084 / E004 / S008. September 12, 2026. Bounded contribution-first assessment; independent proof, complexity/source and nonclaims reviews are GO for the rejection only. No new algorithm, lower bound, novelty claim or publication is selected.

## Closest result and proposed difference

Primary source inspected: Behera, Hansen, Limaye and Srinivasan, *Separation Results for Constant-Depth and Multilinear Ideal Proof Systems*, ECCC TR26-002, January 9, 2026, [full paper](https://eccc.weizmann.ac.il/report/2026/002/download/). Sections 1.3–1.4 use small Boolean image and addressing gadgets for restricted IPS separations. Theorem 1.7 provides a small functional inverse in a multilinear circuit class. Remark 1.8 explicitly withholds a corresponding bound for the Boolean-axiom correction. These are restricted proof-system results, not a general refutation-discovery theorem.

Proposed application: compile a CNF into a Boolean-valued arithmetic circuit, exploit its constant image to construct an inverse, and convert that into a short, efficiently discovered refutation. The prospective new guarantee would be the conversion, with total input-polynomial cost and sound checking. Merely constructing the aggregate or reciprocal is already elementary. The source's explicit caveat makes the missing conversion the first obligation, before any experiments.

This assessment does not claim that the source's precise multilinear hypotheses hold for the arbitrary CNF aggregate below. It tests whether its constant-image idea helps even after allowing unrestricted arithmetic circuits, a more permissive setting.

## Exact first obligation and failure

Work over the rationals. Let F have n variables and total literal-occurrence length L; discard tautological clauses and repeated literals. For clause C let v_C(x) be its violation indicator, a product of literal-falsity factors. Define

    p_F(x) = 1 - product_C (1 - v_C(x)),
    I_B = <x_i^2 - x_i : 1 <= i <= n>.

An arithmetic circuit for p_F has O(L+m+1) gates and constants 0, 1, -1, where m is the clause count. On Boolean inputs it is 1 exactly when at least one clause is violated. Thus p_F takes values in {0,1} for every CNF, while

    F is UNSAT  iff  1-p_F belongs to I_B.

The reverse direction is evaluation on Boolean assignments. The forward direction follows from the unique multilinear representative modulo I_B: a multilinear polynomial vanishing at every Boolean point is zero. This is a standard equivalence, not a new lower bound or mechanism.

For an UNSAT input, the inverse of p_F on the cube is simply the constant 1. Knowing this candidate inverse supplies no certificate that p_F is identically 1 on the cube. The exact missing output is a charged construction of H_i such that

    1-p_F(x) = sum_i H_i(x)(x_i^2-x_i).

If these circuits were supplied, set D(y)=1-product_C(1-y_C). Then

    C(x,y,z) = D(y) + sum_i H_i(x) z_i

is an IPS refutation: C(x,0,0)=0 and C(x,v(x),x^2-x)=1. This spells out the obligation; it does not solve it.

Two exact inputs separate ordinary circuit identities from Boolean identities. For SAT F=(x), p_F=1-x, so 1-p_F=x is not in I_B. For UNSAT F=(x) AND (NOT x), p_F=1-x+x^2, hence 1-p_F=-(x^2-x). In the latter case 1-p_F is not the zero formal polynomial, despite being zero on the cube. Ordinary polynomial identity testing on 1-p_F is therefore not the missing Boolean-ideal test.

The tempting nonzero shift loses the decision. Set q=2-p_F and u=(1+p_F)/2. Then

    q u = 1 - (p_F^2-p_F)/2.

The identity p_F^2-p_F in I_B is easy for this Boolean circuit for every CNF, including SAT inputs. For example, an AND gate satisfies

    (ab)^2-ab = b^2(a^2-a) + a(b^2-b),

and complementation preserves the idempotence defect. Inducting through the circuit produces polynomial-size unrestricted circuit coefficients for this Booleanity identity. Keeping a coefficient circuit for each variable at each gate costs O(n(L+m+1)) gates with shared DAGs; constants stay of bounded size. Consequently q=0 has a cheap full unrestricted IPS refutation for every F. It refutes an always-false shifted equation, not F. This is not an obstruction to the source theorem and not a new theorem: it is the elementary failed-use diagnostic.

The source's restricted-class correction caveat and our unrestricted-circuit rejection are distinct. We do not assert that Booleanity is difficult for these aggregates. The missing SAT-dependent correction is 1-p_F, not p_F^2-p_F.

## Discovery, total cost and exact P-versus-NP link

The known aggregate, shift, reciprocal and Booleanity certificate have polynomial construction cost. No polynomial size or construction-time bound for H_i has been established. Explicit evaluation on all 2^n Boolean assignments decides membership here in 2^n poly(L+n+m) time; that is an available exponential algorithm, not a lower bound on every alternative. Calling a Boolean-ideal membership oracle hides precisely the target decision.

There is also a separate verification obligation for general arithmetic circuit certificates. [Grochow, 2023](https://arxiv.org/abs/2306.02184), states that Boolean IPS has a deterministic Cook–Reckhow p-simulation exactly when PIT is in NP. Thus we do not silently assume general IPS verification is deterministic polynomial time. This does not rule out a special, explicitly checkable certificate format.

The sufficient direct P=NP contract would be a uniform algorithm with a known polynomial input-length timeout that outputs a deterministically sound-checkable refutation for every UNSAT CNF. Run it for that timeout: accept UNSAT only on a valid refutation, and otherwise accept SAT. Soundness and completeness within the timeout make this a deterministic polynomial-time SAT decision. Polynomial proof existence alone, runtime polynomial in an unbounded shortest-proof length, and an unqualified randomized checker are not that contract.

No part of the current candidate supplies this contract or its missing H_i construction. No general impossibility, NP/coNP separation, algebraic circuit separation or P-versus-NP result follows from the rejected transfer.

## Decision and preservation

Selection NONE. The recent source itself distinguishes functional inversion from complete certificate complexity; our proposed CNF application does not bridge that distinction. The source-backed first test rejects the transfer before a proof-discovery campaign. All displayed calculations are elementary diagnostics, not contributions offered for publication. The broader overnight objective remains unresolved.

No implementation experiment, Lean change, publication, push, paid computation or external communication was performed. Publication is not selected because no substantive novel result emerged. A successor is not automatic: a new attempt would need a specific charged action that constructs the SAT-dependent correction, rather than renaming it.


## Actual review closeout

| Lens | Actual inspected record | Verdict |
|---|---|---|
| Proof adversarial | [Independent proof review](2026-09-12-proof-discovery-proof-review.md) | GO for elementary identities, circuit-size accounting and scoped failed-use diagnostic |
| Complexity and sources | [Independent complexity/source review](2026-09-12-proof-discovery-complexity-review.md) | GO for bounded source transfer rejection and selection NONE |
| Nonclaims and publication | [Independent nonclaims review](2026-09-12-proof-discovery-nonclaims-review.md) | GO for main/graph scope; publication HOLD |

These are agent mathematical and document reviews, not Lean verification, executed algorithms or independent human validation. No missing SAT-dependent construction has been supplied by review.
