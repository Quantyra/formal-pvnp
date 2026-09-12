# S3118: clause repair with an overlap commutator

2026-09-12. Informal, AI-authored bounded mechanism design. First obligation
FAILS; selection NONE for this specified local-benefit rationale. This is one
specified speculative circuit schedule, with no established novelty or
runtime improvement. It does not reuse free solution preparation, residual
multiplicity credit, or a collision-search algorithm.

## Route and literature trigger

Planning S3118 under E004/S008; T1/T2 literature alignment accompanies the
changed mechanism. The destination integrity ledger and persistent research
meta-graph remain controlling. The target is verified classical witnesses
for classical 3-SAT, not the different quantum constraint problem QSAT.

Primary sources checked on 2026-09-12:

| Baseline | Applicable guarantee and comparison |
|---|---|
| [Montanaro, quantum backtracking](https://arxiv.org/abs/1509.02374), [Ambainis/Kokainis, unknown tree size](https://arxiv.org/abs/1704.06774) | Bounded-error search with roughly square-root tree-size dependence and polynomial depth factors. Predicate/branch computation is charged. A new circuit must beat a suitable classical tree, not merely exhaustive enumeration. |
| [Scheder, PPSZ is better than you think](https://theoretics.episciences.org/13222/pdf), [Jiang/Cai, July 2026 PPSZ analysis](https://arxiv.org/abs/2607.10697v1) | The latter source reports O*(1.307031578^n) for general 3-SAT, via the existing unique-to-general lifting, already tracked in S3115. This is the strongest general-3-SAT bound known to this selection, source-reported rather than independently proved here. For a bounded randomized trial of success p and reversible implementation cost C, amplitude amplification costs O(C/sqrt(p)) up to error-control factors. C includes the chosen fixed-inference implementation, random-seed preparation, verification and uncomputation; constants and precision/slack must be charged before translating a reported exponent. No automatic square root of an arbitrary wall-clock solver runtime is assumed. |
| [Le Gall/Tamaki, 2604.12131v1](https://arxiv.org/html/2604.12131v1) | Theorems 1.2/1.4 give classical MAX-k-CSP time O*(2^((1-c)n)) and its quantum upgrade O*(2^((1-c)n/2)), with c at least 0.7213 Delta^2/(2^(2k) k^2 D). Here D=n sum_i d_i^2/(k^2 m^2); Delta is their normalized optimum, equal to 1 for satisfiable exact-3-SAT. This dequantizes specified short-path guarantees; it is not a simulation theorem for arbitrary clause circuits. Their stronger quantumized classical baseline must be included. |
| [Hogg/Yanik, local quantum search](https://arxiv.org/abs/quant-ph/9802043), [QAOA](https://arxiv.org/abs/1411.4028) | Clause-aware quantum local search and alternating local unitaries are established ingredients. The former supplies empirical SAT evidence, not a general polynomial SAT guarantee. The latter supplies scoped approximation guarantees, not exact SAT search. |
| [Measurement-driven SAT](https://arxiv.org/abs/2511.09647), [generalized measurement SAT](https://www.nature.com/articles/s41534-025-01069-y) | Measurement/ramp schemes are close in motivation. Spectral-gap dependence and finite-time behavior must be charged. Their guarantees do not transfer to this unitary circuit. |
| [Brehm/Weggemans 2026](https://quantum-journal.org/papers/q-2026-01-20-1975/) | Structured-instance fault-tolerant comparisons against a strong classical solver show that asymptotic search-query advantage alone does not establish practical advantage. No hardware claim is made here. |

## Precisely specified changed operation

Scope: a list of clauses on three distinct variables, with no tautological
clauses. Use the input clause order and increasing variable indices. Other
inputs are outside this candidate's scope; no free preprocessing solver is
assumed. Let v_c be the unique three-bit string falsifying clause c and

    |r_c> = (|v_c xor e_1> + |v_c xor e_2> + |v_c xor e_3>)/sqrt(3),
    A_c = |r_c><v_c| - |v_c><r_c|,
    U_c = exp((pi/6) A_c).

Extend by identity outside the clause. Thus U_c sends v_c to
cos(pi/6) v_c + sin(pi/6) r_c, sends r_c to
-sin(pi/6) v_c + cos(pi/6) r_c, and fixes their orthogonal complement.
These definitions supply every matrix entry from the input clause. U_c is
a real unitary, not a many-to-one irreversible repair or a postselected
filter. For locally uniform amplitudes its falsifying output amplitude is
2^(-3/2)(cos(pi/6)-sqrt(3)sin(pi/6))=0. This elementary motivation is not a
guarantee for an entangled or previously modified input.

First apply the ordinary sweep S=U_m ... U_1. For each pair c<d sharing a
variable, in lexicographic order, apply

    K_cd = U_d U_c U_d^dagger U_c^dagger.

Rightmost factors act first. If pairs are e_1,...,e_q, one complete round
is V=K_e_q ... K_e_1 S. There is no free choice of commutator orientation,
angle, clause ordering, overlap threshold or learned parameter. The
overlap commutators, absent from the plain sweep, are the one changed rule.
They are identity on disjoint pairs and encode noncommuting repair-order
effects on overlapping pairs. The hypothesis is that this specified
correction can improve simultaneous satisfaction, not that noncommutation
by itself causes favorable interference.

This is not the standard diagonal cost/global-X QAOA schedule or Grover's
global marked-state reflection. It is still a local unitary ansatz made
from familiar ingredients; broad alternating-operator frameworks can
express it. Expressibility neither proves novelty nor supplies the missing
performance bound. A new guarantee, not renaming that framework, would be
needed for a contribution. Independent challenge has also identified
[counterdiabaticity and QAOA](https://arxiv.org/html/2106.15645v3) as
relevant commutator prior art; no claim of a new commutator primitive is made.

## Preparation, schedule, extraction and all costs

A fully runnable *incomplete search proposal* would use T=n rounds and
R=max(1,n^2) independent shots, with these values chosen solely from input
length. Prepare |+>^n with n Hadamards, apply V^T, measure all n qubits,
and verify every clause classically. Return the first verified witness;
if all shots fail, return UNKNOWN. This protocol never certifies UNSAT.
It is a specification only: no experiment is authorized by this note.

Let p_F(T)=sum_{x satisfies F}|<x|V^T|+^n>|^2. Ideal success is exactly
1-(1-p_F(T))^R. No positive uniform lower bound is currently known here;
p_F(T) is not an available input. If an independent bound p_F(T)>=p_0
were later proved, ceil(log(1/delta)/p_0) shots would suffice. This is a
conditional cost identity, not permission to estimate p_0 by free counting.

Build the clause-overlap list in O(m^2) fixed-width comparisons and store
q<=m(m-1)/2 pairs. Each round uses g=m+4q three-qubit operations. Each U_c
or inverse has a constant-dimensional known matrix and a constant-size
arbitrary-rotation gate decomposition; standard finite-gate synthesis to
operator error epsilon costs polylog(1/epsilon) elementary gates. No QRAM,
solution oracle, inaccessible matrix entry or exponential state-preparation
table is needed. Compile the finitely many sign templates and inverses.

For requested total distribution error eta, take epsilon at most
eta/[10 max(1,R T g)] per local operation, charging angle computation and
synthesis at that precision. Total gates are

    O(R [n + T g polylog(R T max(1,g)/eta)]),

plus overlap construction, circuit description/compilation and O(Rm)
classical verification. Readout costs O(Rn), memory includes n quantum bits
and polynomial classical circuit/overlap storage. These costs describe a
bounded incomplete procedure; they are not a polynomial SAT guarantee.
There is no ground-state, gap, overlap or postselection assumption.

Direct classical state-vector simulation costs O(T g 2^n) fixed-width gate
updates per state preparation, times precision overhead, with 2^n storage;
sampling can reuse the final distribution if it is explicitly constructed.
Small independent components can instead be simulated separately. Thus a
constant-size motif or disconnected repetitions cannot establish quantum
advantage. Bounded circuit contraction width is another possible escape;
general interacting rounds are not declared classically efficient merely
from 2604.12131.

## First falsifiable obligation and stop-loss

Before any runtime claim or experiment, compare one corrected round with
the plain sweep on every two-clause, width-three overlap/sign motif:
one, two or three shared variables, all shared-literal sign relations,
and the fixed input order. Compare the exact probability that *both*
clauses are satisfied, not only expected violated-clause count. The first
obligation is nondecrease on every such motif and strict increase on at
least one nontrivial motif. A single exact counterexample rejects this
proposed uniform local-benefit rationale. All these systems have at most
five qubits and admit cheap classical symbolic assessment; passing would
only justify further mechanism review, not an asymptotic speedup.

Candidate sent to the orchestrator and independent challenger before any
bounded derivation. The orchestrator then authorized exact symbolic
assessment of all two-clause overlap/sign motifs, both orders, satisfaction
probability and expected violations, including unitarity/normalization.
No silent angle retuning, inverse-commutator replacement or motif
selection follows a failure. A failed local rationale does not rule out
every nonmonotone quantum heuristic, every clause-dependent circuit or an
advantage on some restricted family.

## Authorized exact assessment: failure

Normalize the first clause to positive literals on variables 0,1,2 using
variable flips. For s shared variables, put those at 0,...,s-1, and put the
second clause's fresh variables at 3,...,5-s. Fresh-variable signs can be
made positive independently. Enumerate every shared sign mask 0,...,2^s-1
and both execution orders. Variable permutation and bit-flip conjugacy
preserve the initial uniform state, repair definition and measured
predicate; therefore these 28 ordered cases cover every two-clause motif
in scope. The table compresses equal rows by j=popcount(mask), with
2 binomial(s,j) ordered rows per class. The calculation still enumerates
every mask, not only representative popcounts. Duplicates are retained:
the input is a clause list and no deduplication was specified. Removing
the duplicate class would not change the failure.

Write a=sqrt(3), P for joint satisfaction probability and E for expected
number of violated clauses, counting duplicate list entries. A delta is
corrected minus plain. Corrected values are P+deltaP and E+deltaE, so both
algorithms' exact expressions are determined by these tables.

| s,j | Ordered rows | Plain P | deltaP |
|---|---:|---|---|
| 1,0 | 2 | (1673+28a)/1728 | (4704539-2942860a)/181398528 |
| 1,1 | 2 | (1615+60a)/1728 | (8583655-5077252a)/181398528 |
| 2,0 | 2 | (371+28a)/432 | (2399929-1485473a)/22674816 |
| 2,1 | 4 | (1637+40a)/1728 | (78037373-52529332a)/2902376448 |
| 2,2 | 2 | (137+4a)/144 | (-16195+8180a)/944784 |
| 3,0 | 2 | 7/8 | 0 |
| 3,1 | 6 | (7+a)/9 | (100-64a)/729 |
| 3,2 | 6 | (65+4a)/72 | (-16195+8180a)/472392 |
| 3,3 | 2 | 1 | 0 |

| s,j | Plain E | deltaE |
|---|---|---|
| 1,0 | (61-28a)/1728 | (-4640507+2895820a)/181398528 |
| 1,1 | (113-60a)/1728 | -deltaP |
| 2,0 | (73-28a)/432 | (-5120183+3118786a)/45349632 |
| 2,1 | (91-40a)/1728 | -deltaP |
| 2,2 | (7-4a)/144 | -deltaP |
| 3,0 | 1/4 | 0 |
| 3,1 | (2-a)/9 | -deltaP |
| 3,2 | (7-4a)/72 | -deltaP |
| 3,3 | 0 | 0 |

All seven nontrivial classes have deltaP<0 and deltaE>0; the two stated
classes tie. Thus 24 ordered rows worsen and four tie. Signs can be checked
by squaring the positive rational coefficients and comparing with 3; no
floating-point estimate is needed. Every local matrix is exactly unitary
and each plain/corrected state is exactly normalized.

For a short auditable counterexample take
(x OR y OR z) AND (NOT x OR y OR z). Its deltaP is
(100-64sqrt(3))/729<0, since 10000<3*4096. The commutator decreases, rather
than improves, joint satisfaction under the proposed fixed orientation.
The independent challenger independently reproduced the same expressions
using vector updates instead of the author's full matrices.

This is an actual changed-rule design attempt followed by an exact failed
first obligation. It is not a new successful mechanism result. NONE is
based on failure of the stated rationale, not merely on the absence of a
global runtime proof. A reverse commutator or different angle is a different
candidate and is not pursued. No broader experiment is opened.

The orchestrator additionally authorized a constant-size algebraic check
of the obvious inverse correction. On precisely two clauses,
K_cd^dagger S=U_c U_d U_c^dagger U_d^dagger U_d U_c=U_c U_d,
which is the reversed plain sweep. The all-order table already shows equal
P and E for those two sweeps on every motif. Thus this inverse supplies a
tie, not a rescue of the local-benefit obligation. This cancellation does
not claim that inverse pair corrections on a larger formula reduce to one
globally reversed sweep. No angle or schedule optimization was performed.

### Portable exact reproducer

Python with SymPy 1.14.0; run the following directly. Integer basis indices
use bit i for variable i. Intermediate vectors omit the common 2^(-n/2)
factor; statistics divide their squared entries by 2^n. Transposes are
adjoints because every matrix is real. This is the authorized bounded
symbolic derivation, not a SAT benchmark or a quantum-hardware execution.

```python
import sympy as s
rt = s.sqrt(3)
can = lambda x: s.collect(s.expand(x), rt)

def local(n, vs, mask):
    M = s.eye(1 << n)
    outside = [i for i in range(n) if i not in vs]
    for ob in range(1 << len(outside)):
        v = sum(((ob >> j) & 1) << i for j, i in enumerate(outside))
        v += sum(((mask >> j) & 1) << i for j, i in enumerate(vs))
        rr = [v ^ (1 << i) for i in vs]
        M[v, v] = rt / 2
        for r in rr:
            M[r, v], M[v, r] = rt / 6, -rt / 6
            for z in rr:
                M[r, z] += (rt / 2 - 1) / 3
    assert all(can(x) == 0 for x in M.T * M - s.eye(1 << n))
    return M

for shared in (1, 2, 3):
    n = 6 - shared
    av = [0, 1, 2]
    bv = list(range(shared)) + list(range(3, n))
    A = local(n, av, 0)
    for mask in range(1 << shared):
        B = local(n, bv, mask)
        viol = [
            int(all(((x >> i) & 1) == 0 for i in av))
            + int(all(((x >> i) & 1) == ((mask >> j) & 1)
                      for j, i in enumerate(bv)))
            for x in range(1 << n)
        ]
        for order, C, D in [('AB', A, B), ('BA', B, A)]:
            w = s.ones(1 << n, 1)
            for M in (C, D):
                w = (M * w).applyfunc(can)
            z = w
            for M in (C.T, D.T, C, D):
                z = (M * z).applyfunc(can)
            def stats(vec):
                sq = [can(v * v) / (1 << n) for v in vec]
                assert can(sum(sq) - 1) == 0
                return (can(sum(p for p, h in zip(sq, viol) if h == 0)),
                        can(sum(p * h for p, h in zip(sq, viol))))
            p, e = stats(w)
            q, f = stats(z)
            print(shared, mask, order, p, e, can(q-p), can(f-e))
```

Any polynomial verified-witness algorithm for all SAT with bounded error
would imply NP contained in BQP. P=NP would require an additional classical
polynomial simulation/algorithm. Smaller exponential exponents and
restricted-family results retain their own scope. No such result, novelty,
separation, publication milestone, Lean theorem or hardware result is
established here. No public action, commit, experiment or successor is
authorized by this design record.
