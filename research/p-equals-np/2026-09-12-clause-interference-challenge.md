# Clause interference: independent source and mechanism challenge

2026-09-12, S3118 / S008 / E004. Internal bounded research under
[integrity](../../INTEGRITY-CLAIMS.md). Informal AI review, not peer review,
Lean verification, a new theorem, or public claim. Only this record is owned
by the challenger. No experiment campaign, hardware, spend, release or commit.

## Selection assessment before derivation

The designer specifies a real unitary rotation between each clause's unique
local falsifying string v and the normalized sum r of its k one-bit repairs:
U=exp(theta (|r><v|-|v><r|)), theta=atan(1/sqrt(k)). Following an ordered
clause sweep, each overlapping pair receives U_d U_c U_d^-1 U_c^-1, in a
fixed syntax-dependent order. Rightmost factors act first.

This is an actual changed operation, not free amplitude amplification or
postselection. The local zeroing observation applies to the locally uniform
state; it does not survive arbitrary prior clause operations automatically.
The pair correction is speculative: neither its sign nor its order has a
proved repair effect. Generic alternating operators and commutator terms
are established ingredients. No exact prior-art subsumption of this fixed
rotation-and-pair schedule was located in the bounded search; that is not
proof of novelty.

GO for a bounded first-obligation derivation, conditional on root authority:
compare the fixed correction with the plain sweep on every two-clause
overlap/sign motif of the stated fixed width, including disjoint and
identical-clause controls where applicable. Record the full classification
and counterexamples to nonworsening. A favorable chosen motif is insufficient.
This permission is an assessment, not authorization for an experiment or
unbounded proof campaign. Final candidate disposition awaits that evidence.

## Primary comparison contracts

[Le Gall and Tamaki, arXiv:2604.12131v1](https://arxiv.org/html/2604.12131v1),
Theorems 1.1-1.4 and 2.4: conditioning-and-search matches the input promises
of specified short-path CSP guarantees, rather than simulating arbitrary
quantum circuits. For MAX-Ek-LIN2 the threshold promise gives classical
exponent saving at least min(gamma,h(eta/(2k))). For unweighted MAX-k-CSP,
the saving is at least 0.7213 Delta^2/(2^(2k) k^2 D), with
D=n sum_i d_i^2/(k^2 m^2) and Delta=|Hmin|/m in the paper's centered
normalization. The quantum amplitude-amplified upgrades halve the resulting
classical exponents. Satisfiable exact-3SAT has Delta=1. The paper suppresses
subexponential factors in O*, not only polynomial factors. These are
exponential optimization guarantees, not a polynomial SAT algorithm.
Its theorem does not directly cover the proposed noncommuting repair
schedule. Conversely, beating the older short-path exponent would be an
inadequate comparison because these stronger classical and quantum bounds
already exist. Unknown-optimum removal is addressed in the appendices;
candidate parameters may not silently use Hmin or solution density.

[Wurtz and Love, Counterdiabaticity and QAOA](https://arxiv.org/html/2106.15645v3)
already connects alternating gates, BCH commutators and counterdiabatic
corrections. Thus adding a commutator alone is not a new principle, and
a counterdiabatic interpretation needs an actual target path and error
argument. This source does not supply the proposed clause-pair nonworsening
guarantee. Its approximation-quality discussion cannot be imported as
exact satisfying-assignment probability or efficient parameter selection.

[Hadfield et al., alternating operator ansatz](https://arxiv.org/abs/1709.03489)
and [SAT ansatz comparison](https://arxiv.org/abs/2301.11292)
are relevant prior-art families. The latter's inspected abstract reports
finite Max-2/3-SAT numerical comparisons, not a general exact-SAT bound.
Broad family membership does not identify this schedule with a published
algorithm, nor establish a novel contribution.

[Generalized-measurement k-SAT](https://www.nature.com/articles/s41534-025-01069-y)
uses clause measurements with variable measurement strength and an angle
schedule. That is a different operation from the designer's unitary
rotation. Measurement outcomes, restarts, schedules and extraction must
be paid if that mechanism is imported. No measurement-based convergence
claim is transferred to this circuit. The primary page was opened; this
review does not claim independent validation of all its analysis.

[SAQC, September 2026 preprint](https://arxiv.org/html/2609.05737v1) preserves
SAT structure for clause-aware compilation and direct ansatz synthesis.
Its reported compilation improvements do not establish an exact-SAT
success bound. Explicit clause-level gates alone therefore supply neither
algorithm novelty nor a complexity advance.

The established [resource contract](2026-09-10-quantum-sat-resource-contract.md)
and [mechanism audit](2026-09-10-quantum-sat-mechanism-audit.md) retain
amplitude amplification, rigorous static-tree quantum backtracking and
random-k-SAT QAOA evidence with their distinct promises. A fair SAT runtime
comparison must also include classical PPSZ/Schoning and their coherent
amplifications, charging the reversible execution. Grover over assignments
is not the strongest known k-SAT baseline. The inspected
[Biased-PPSZ primary paper](https://people.csail.mit.edu/virgi/6.1420/papers/fasterksat.pdf)
separates unique and general cases; its 1.30699 base for unique 3-SAT must
not be silently described as its all-input theorem. This bounded review
does not certify a fastest-possible September 2026 SAT exponent.

## Total-resource and escape challenge

Let e be the number of distinct overlapping clause pairs and p the number
of rounds. Before compilation cancellations the schedule uses p(m+4e)
local rotations. Fixed width gives constant-size local matrices; generic
exponential-in-k unitary synthesis would not establish a polynomial general
CNF cost. Either retain the fixed-k scope or provide a charged sparse
construction. Clause loading, pair detection, order construction and
finite-precision angle synthesis belong in preprocessing. Each forward
rotation has an equally charged inverse. Fixed syntax-only angles avoid
training, but their precision must support the full amplified circuit.

For preparation A and satisfying overlap a>0, the relevant successful-input
cost is setup plus O((C_A+C_Ainv+C_verify+C_reflect)/sqrt(a)), together with
finite precision and error controls. Ordinary sampling instead pays 1/a.
Expectation of violated-clause count and probability of at least one
violation are different observables. Readout is a measured assignment
verified against the original formula; no amplitude table or free ground
state is available. A known stopping bound is necessary for bounded-error
UNSAT output. Without a proved overlap floor, failed candidate attempts
give UNKNOWN, or require a fully charged complete fallback.

Two-clause motifs occupy at most 2k variables and admit constant-size
classical calculation at fixed k. Disjoint copies factor and are also easy
classically. General low-width tensor contractions and CNF decomposition
are applicable only with their actual width/construction costs; bounded
clause width alone is insufficient to give a polynomial contraction.
These escapes prevent extrapolating a tiny motif gain into quantum
advantage. They do not simulate every interacting schedule. Prior
holographic, free-multiplicity and collision-memory failures are likewise
not lower bounds on this circuit.

An efficient verified-witness quantum algorithm for all SAT inputs would
place NP in BQP. A randomized classical output simulation would yield a
randomized witness-search result, not automatically P=NP. Deterministic
polynomial acceptance-probability approximation with sufficient bounded-error
separation could support a classical decision algorithm, but neither it nor
the quantum SAT algorithm has been supplied. Exponential or promised-family
improvements retain their own scope; failure of this schedule proves no
quantum lower bound or complexity-class separation.

## Search limits and next receipt

Primary searches covered short-path dequantization, quantum k-SAT/PPSZ,
clause repair rotations, alternating-operator SAT, measurement SAT,
counterdiabatic commutators and SAT-aware compilation. Primary texts and
the named statements were inspected; no exhaustive novelty search or full
paper proof audit is claimed. The April 2026 short-path result was checked
directly, not inferred from a search snippet. Early source scope and
mechanism concerns were sent to root and designer before derivation.

## Authorized independent exact assessment

Root subsequently authorized the finite two-clause calculation. The
challenger independently computed exact amplitudes using Python/SymPy
vector updates, rather than the designer's full-matrix construction.
This is a substantive bounded derivation contribution as well as review.
The executed recurrence is given here; no separate executable was added.

Write q=sqrt(3), retain unnormalized initial amplitude 1 on every string,
and divide final quadratic observables by 2^n. For each fixed assignment
outside a clause, let z be the amplitude on its falsifier and let
R=a_1+a_2+a_3 sum amplitudes on its one-flip repairs. A forward update is

    z' = q*z/2 - R/(2*q),
    a_i' = a_i + (q/2-1)*R/3 + z/(2*q).

Other amplitudes are unchanged. An inverse negates the cross terms
R/(2q) and z/(2q). Use old amplitudes for every right-hand side. This
implements exactly the rotation in the orthonormal (v,r) plane, with
cos= q/2 and sin=1/2; consequently U^T U=I analytically. The checker
also obtained exact final norm 1 for plain and corrected states on every
computed row. Apply C,D for the plain state, then C^-1,D^-1,C,D for
the corrected state. Count the clauses violated by each basis string;
sum its squared amplitude into success iff that count is zero, and into
expected violations with that count as multiplier.

Canonical first clause is positive on variables (0,1,2). The second shares
the first s variables, negates j of them, and uses 3-s fresh positive
variables. Here s=1,2,3 and j=0,...,s. Independent flips remove first-clause
and fresh-variable signs. Permuting shared variables sends every sign mask
of weight j to the canonical one and intertwines every specified local
rotation. Thus these nine classes cover all 2+4+8=14 masks. Both input
orders were calculated independently (18 computations); each gives the
same scalar observables. They cover the designer's full 28 mask/order
rows. Duplicate clauses are retained as the declared input-list semantics
require; both opposite clauses on the same support are also retained.

The exact independent results below matched the designer's matrix results.
Delta means corrected minus plain. Symbols in table entries use q=sqrt(3).

| s,j | P_plain | E_plain | Delta P | Delta E |
|---|---|---|---|---|
| 1,0 | (1673+28q)/1728 | (61-28q)/1728 | (4704539-2942860q)/181398528 | (-4640507+2895820q)/181398528 |
| 1,1 | (1615+60q)/1728 | (113-60q)/1728 | (8583655-5077252q)/181398528 | -Delta P |
| 2,0 | (371+28q)/432 | (73-28q)/432 | (2399929-1485473q)/22674816 | (-5120183+3118786q)/45349632 |
| 2,1 | (1637+40q)/1728 | (91-40q)/1728 | (78037373-52529332q)/2902376448 | -Delta P |
| 2,2 | (137+4q)/144 | (7-4q)/144 | (-16195+8180q)/944784 | -Delta P |
| 3,0 | 7/8 | 1/4 | 0 | 0 |
| 3,1 | (7+q)/9 | (2-q)/9 | (100-64q)/729 | -Delta P |
| 3,2 | (65+4q)/72 | (7-4q)/72 | (-16195+8180q)/472392 | -Delta P |
| 3,3 | 1 | 0 | 0 | 0 |

All seven nontrivial classes have Delta P<0 and Delta E>0. Exact signs can
be established by squaring the positive rational coefficients when
comparing them against q, without floating-point tolerance. Multiplicities
2*binom(s,j) give 24 strictly worsening ordered rows and four ties.
In particular, C=(x1 OR x2 OR x3), D=(NOT x1 OR x2 OR x3) gives
Delta P=(100-64sqrt(3))/729<0 because 100^2<3*64^2. No energy/success
conversion is assumed for the same-sign-overlap classes, which can violate
both clauses simultaneously. The table computes both observables separately.

Final mechanism selection is **NONE for this fixed commutator schedule's
uniform local-benefit rationale**. It failed the first stated obligation
on the complete declared motif class. This is a precise failure of one
uniform initial state, one plain sweep and one specified correction;
it does not prove failure for other states, angles, inverse orientations,
multiple rounds, selected distributions or all clause-dependent circuits.
No retuning or automatic successor was attempted. The partial polynomial
budget search specification still returns UNKNOWN without a witness and
supplies no all-input positive success floor. The derivation, source
contracts and refusal to infer a class separation support scoped closeout,
not a quantum impossibility or a novelty claim.

Root separately authorized constant-size bookkeeping of the obvious
inverse-orientation suggestion. For exactly two clauses,

    K^dagger S
      = (U_c U_d U_c^dagger U_d^dagger)(U_d U_c)
      = U_c U_d.

It is just the reversed plain sweep. Both orders already have the same
scalar motif observables above, so this suggestion supplies no new local
benefit. This identity is not a claim that all inverse pair corrections
on a larger formula equal a single globally reversed sweep. No new
parameter or performance search followed the identity.

The designer's complete 28-row matrix reproducer was crossread against
the independently executed recurrence: matrix cross entries q/6 equal
1/(2q), old-state block updates agree, mask coverage is complete, and
the reported exact expressions match. All local matrices preserve norm
by the displayed two-dimensional rotation and fix the orthogonal
complement. The review requested only cosmetic duplicate-text cleanup
and a reliable primary counterdiabatic link, with no mathematical repair.

Final source/mechanism review: **PASS** for the bounded failed-design
record, with selection NONE as scoped above. The final
[design](2026-09-12-clause-interference-design.md) was checked after those
cosmetic edits and inverse-bookkeeping addition. Its frozen working-file
SHA256 is `9e5cf79c213ef28d8bd6b56a78c84bb5288a4987327b5c52634cc6e6a5ee3f41`.
No mathematical correction remains. Disjoint pairs have K=I analytically;
they are a separate control outside the 28 enumerated overlapping rows.

Root's final source check identified an omitted newer comparator. The
designer added [Jiang--Cai, July 2026](https://arxiv.org/abs/2607.10697v1),
whose directly checked primary abstract reports general-3-SAT runtime
O*(1.307031578^n) using the existing unique-to-general lifting. This matches
the source-reported comparator already recorded in S3115; it is not an
independent proof audit or resolution of prior source-version questions.
The revised row charges a bounded trial's reversible cost C and success p
through O(C/sqrt(p)), including seed preparation, verification,
uncomputation and error controls. It does not square-root arbitrary
wall-clock solver runtime. Replacing only that updated row in memory
with its prior text reproduced the earlier file SHA256
`d411d38c0a66bbb4d9437e12f1035a31132df5faa4597b060e50e8f09356e020`.
Thus no other design content changed. The source correction is accepted;
all motif calculations and the scoped PASS/NONE disposition remain
unchanged, with no computation rerun.
