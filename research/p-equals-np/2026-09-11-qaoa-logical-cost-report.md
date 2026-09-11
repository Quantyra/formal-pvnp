# S3048: QAOA logical block-cost accounting

2026-09-11. **The frozen construction cannot beat the uniform baseline in expected elementary unitary gates on any of the seven SAT instances, even if rotations cost zero and QAOA succeeds with certainty.** One p14 preparation already costs 2.79 to 14.42 times the entire expected gate cost of uniform preparation/measurement/retry. This is a gate-resource finding, not a total-runtime or general quantum-SAT lower bound.

The same S3047 seven SAT formulas and stored p14/p60 overlaps were reused. No new random data, QAOA evolution, angle optimization or compiler search occurred. The construction, metrics and sensitivities were frozen before target counts; reviewer preflight approved them. The freeze SHA256-LF is `72326f3d643ad321d7f2b53707e1e2a7bb80d6633ebc956f18662337f123b4c8`.

## Fixed implementation and exact counts

Repeated identical literals are removed within clauses, tautologies are discarded, and every other clause occurrence is retained. Thus equal clauses still contribute their full phase multiplicity. Each distinct-literal falsity predicate uses a clean AND ladder; cost phases compute, rotate and uncompute one ladder at a time. SAT marking retains every clause ladder, computes the AND of complemented flags, applies Z, and reverses everything. This deliberately wide implementation is the sole construction tested. It is not claimed gate- or ancilla-optimal.

The scalar metric counts each elementary unitary gate equally. A Toffoli costs15 gates: 7 T/T-dagger,6 CNOT,2 Hadamards. [Selinger, Eq(1) and Remark2.1](https://arxiv.org/pdf/1210.0974) justify this standard decomposition after combining the unnecessarily split adjacent T-dagger/S into T. Each synthesized Rz sequence has symbolic full length rho. Counts are exact for this construction as expressions in rho; no rho value is certified as an actual compiled sequence. The clean-ladder counts follow directly from its forward and reverse gate lists, not from a borrowed bound for dirty ancillas.

Here q is the retained clause count; L=L0+(q+16)rho is one QAOA layer, R includes the full SAT mark plus zero reflection. H=16 Hadamards. A=H+pL and its inverse have the same cost. V=0 unitary gates in the primary metric because final verification follows measurement and is performed classically; its substantial classical workload is reported below.

| Seed | K | q | Layer L0 | R gates | Peak clean ancillas | A14(rho=0) / uniform expected gates |
|---|---:|---:|---:|---:|---:|---:|
| 20260912 | 1 | 1207 | 224230 | 271624 | 8401 | 2.9938 |
| 20260916 | 5 | 1156 | 215958 | 261488 | 8082 | 14.4168 |
| 20260917 | 1 | 1197 | 223154 | 270322 | 8352 | 2.9794 |
| 20260920 | 1 | 1146 | 213262 | 258356 | 7986 | 2.8474 |
| 20260922 | 1 | 1128 | 211446 | 255948 | 7908 | 2.8231 |
| 20260924 | 3 | 1107 | 206486 | 250066 | 7730 | 8.2707 |
| 20260927 | 1 | 1126 | 209274 | 253700 | 7834 | 2.7941 |

Ancillas are additional to16 data qubits. The phase uses at most7 clean work qubits; predicate marking dominates the peak. The zero reflection uses15 reusable ancillas. Every target has clause widths at least2; unit-clause handling and trivial/empty-formula guards were separately tested. Full Toffoli/Clifford/rotation vectors, widths, measurements, resets and sign-conjugation counts are saved in JSON. There is no routing, connectivity or physical-depth claim.

## Fair restart comparison and resource tradeoff

For each candidate and nonnegative integer j, the objective is `[(1+2j)A+jR+V]/sin^2((2j+1)asin(sqrt(a)))`. The globally bounded optimizer includes j=0 for both candidates; it does not use a first-peak assumption or a 32-iteration cutoff. Uniform success is the exact offline diagnostic K/65536. Its primary optimum is j=0 on all seven formulas, yielding expected unitary-gate cost16*65536/K. No knowledge of K is required to implement that repeat-until-verified-witness policy, but choosing the optimizing QAOA j uses the offline ideal overlap. This is not a full unknown-a decision solver or an UNSAT stopping rule.

The rho=0 success-adjusted results are:

| Seed | p14 optimal j | p14 / uniform expected gates | p60 optimal j | p60 / uniform expected gates |
|---|---:|---:|---:|---:|
| 20260912 | 1 | 11.4082 | 0 | 18.2177 |
| 20260916 | 1 | 69.2944 | 0 | 154.7073 |
| 20260917 | 1 | 12.7294 | 0 | 30.9278 |
| 20260920 | 1 | 8.8005 | 0 | 15.8852 |
| 20260922 | 5 | 40.7275 | 2 | 78.3973 |
| 20260924 | 1 | 26.4914 | 0 | 53.5172 |
| 20260927 | 6 | 43.3042 | 8 | 230.1085 |

All predeclared rho values0,10,30,60,100 lose in the primary metric. More strongly, for every rho>=0 and every j the trial cost is at least A(rho)>=A(0), and success is at most1. The first table therefore rules out a positive primary break-even rotation length without any synthesis assumption or approximation-sensitive overlap calculation. This is a direct arithmetic certificate for the frozen construction, not a new general lower-bound method.

Classical checking and readout are not free runtime. The fixed non-short-circuit verifier uses W=2*literal_occurrences-1 classical literal/Boolean operations per attempt. Primary measurement and data reset use16 operations each per attempt. Expected attempt counts multiply all these separately reported resources. At rho=0:

| Seed | Classical operations/attempt W | Uniform expected attempts | Uniform expected classical operations | p14 expected classical operations | p60 expected classical operations |
|---|---:|---:|---:|---:|---:|
| 20260912 | 16803 | 65536.00 | 1101201408.00 | 20744.84 | 23858.03 |
| 20260916 | 16165 | 13107.20 | 211877888.00 | 25173.27 | 40475.79 |
| 20260917 | 16705 | 65536.00 | 1094778880.00 | 23123.19 | 40461.18 |
| 20260920 | 15973 | 65536.00 | 1046806528.00 | 15994.83 | 20792.78 |
| 20260922 | 15817 | 65536.00 | 1036582912.00 | 19959.44 | 20333.56 |
| 20260924 | 15461 | 21845.33 | 337750698.67 | 16044.75 | 23343.56 |
| 20260927 | 15669 | 65536.00 | 1026883584.00 | 17962.35 | 17544.79 |

Thus QAOA reduces verification attempts while spending more unitary gates. These resource vectors cannot be collapsed into a total runtime without specified relative costs; a stronger classical solver was not benchmarked. Counting only T gates creates a further degeneracy: uniform j=0 sampling uses zero T gates, so that metric cannot alone establish a positive-T improvement.

The separately frozen policy that performs final verification reversibly instead of classically changes the objective. At rho=0, p14 beats its corresponding uniform comparator on6/7 cases and p60 on4/7; at rho=100 these counts are4/7 and2/7. These are conditional comparisons against a deliberately more expensive verification policy, not evidence that the primary result should be replaced with a favorable one. No actual synthesis cost or hardware advantage follows.

## Precision and evidence limits

One j-trial uses Nrot=(1+2j)p(q+16) approximate rotations. A per-occurrence operator error at most1e-4/Nrot gives total state error at most1e-4 by telescoping and event-probability error at most2e-4. [Barenco et al., Section7.3 before Lemma7.8](https://arxiv.org/pdf/quant-ph/9503016) provides the conservative probability-error relation; the finite-product bound is a direct unitary telescoping argument. Inverse preparation must be the literal inverse compiled circuit. Global phases of these unconditionally applied flag rotations do not affect the outcome.

The rho=0 optimizing trials would require per-rotation accuracy ranging approximately8.6e-11 to2.2e-9 under this sufficient budget. The results include conservative fixed-j costs using success reduced by2e-4 when positive. These are conditional bounds, not certification that any frozen rho can realize those errors. [Ross-Selinger](https://arxiv.org/abs/1403.2975) studies actual Clifford+T approximation; a typical asymptotic T-count expression cannot be substituted for a certified finite full-gate length. The primary impossibility within this construction does not depend on that missing compilation, because even hypothetical perfect success and zero rotation cost cannot help.

Known K, overlaps and exact enumeration remain offline diagnostics. The count does not charge a fictional free oracle for K inside the implemented kernel. Training, compilation, classical control, fault correction, hardware noise and elapsed physical time are not evaluated; no P=NP, scaling, ensemble or complete-SAT-runtime claim is made. The original S3045 missing-source-formula replay remains a separate blocker.

## Verification and disposition

Synthetic controls checked signed literal preprocessing, retained duplicate-clause energy, unit clauses, trivial and empty cases, and independently hand-counted small block vectors. The prior global optimizer is reused unchanged. Independent review checks the target block counts and comparison arithmetic; its final scope is recorded in the [companion review](2026-09-11-qaoa-logical-block-cost-review.md).

**STOP this construction as a unitary-gate advantage candidate for these seven formulas. No synthesis campaign or further random batch is warranted by this result.** Before a paper or a new construction, use the existing S3050 nearest-work/contribution gate: determine whether the resource tradeoff or a precisely different construction has a genuinely new claim beyond routine counting. Novelty remains unknown. There is no automatic publication or next experiment.

Artifacts: [frozen contract](2026-09-11-qaoa-logical-cost-preregistration.md), [freeze and input pins](2026-09-11-qaoa-logical-cost-freeze.json), [counter](2026-09-11-qaoa-logical-cost.py), [full results](2026-09-11-qaoa-logical-cost-results.json). SHA256-LF normalizes CRLF to LF; all original S3047 files remain unchanged.
