# Nonclausal endpoint: literature gate before implementation

2026-09-08. S3040 / S008 / E004. Harness only.

Target remains uniform deterministic polynomial-bit-time SAT, motivated by the
vortex endpoint. An accelerated clock supplies no free algebraic operations.

Primary sources opened:

- Clegg, Edmonds, Impagliazzo, *Using the Groebner basis algorithm to find proofs
  of unsatisfiability*, STOC 1996, DOI https://doi.org/10.1145/237814.237860
  (bibliographic identification of polynomial-calculus search).
- Miksa and Nordstrom, *A Generalized Method for Proving Polynomial Calculus
  Degree Lower Bounds*, https://arxiv.org/html/1505.01358v1 , sections 1.1,
  1.3 and 4. Their calculus uses linear combinations and variable multiplication;
  inconsistent mod-2 affine equations are easy over F2. Their graph functional
  pigeonhole formulas on suitable bounded-degree expanders have high degree and
  exponential expanded-monomial proof size. This is a restriction on that proof
  system, not on arbitrary SAT algorithms.
- Grochow and Pitassi, *Circuit complexity, proof complexity, and polynomial
  identity testing*, https://arxiv.org/abs/1404.3820 . Circuit representation of
  algebraic certificates changes the relevant size measure; a compact proposed
  certificate does not itself give deterministic efficient certificate search.

Initial proposal, rejected before implementation: Boolean quotient ideal saturation over F2, keeping
squarefree monomials. Encode a clause by its falsification polynomial. Add rows
by XOR elimination and multiply derived rows by variables, with Boolean
reduction x_i^2=x_i. Permit arbitrary mixed nonlinear constraints. The endpoint
is whether constant 1 enters the ideal. Full saturation is complete; a degree
cutoff can only report UNKNOWN when it fails to refute. No affine promise is
silently substituted for SAT.

Difference from retired flat projection: XOR consequences and multiplication
are retained as polynomials, not distributed into clause-pair consequences.
This handles explicitly supplied inconsistent F2 affine systems by Gaussian
elimination, unlike the short-resolution simulation used to retire the flat
candidate. It does not escape polynomial-calculus limitations.

Analytical closure, without implementing the rejected saturation: the Boolean
quotient is the ring of all F2-valued functions on the cube. An inconsistent
system generates 1, since each assignment indicator can be multiplied by a
constraint equal to 1 at that assignment, and the indicators sum to 1. Every
quotient variable multiplication lifts to ordinary PC: for each monomial
containing x_i, subtract the Boolean axiom x_i^2+x_i times that monomial with
x_i removed. Generating these axiom multiples and adding them has polynomial
overhead in n and explicit support size. XOR rows already are PC additions.
Hence polynomial cumulative explicit-support work would give polynomial PC
proofs. Theorem 4.9 of Miksa--Nordstrom, with its bounded-left-degree boundary
expander hypotheses, defeats that universal bound (Theorem 4.10 also treats
standard FPHP). No saturation code or bulk regression suite is warranted.

## Revised rule after parent stop-loss decision

Retain S=product_j(1+f_j), the satisfaction indicator, as a shared arithmetic
circuit. For a variable x construct cofactors S0,S1 by substituting x=0,1
through the DAG, then replace S by S0+S1+S0*S1. This is existential elimination
on Boolean values. Sharing is syntactic hash-consing, not free semantic
equivalence. No explicit monomial list is created.

The sparse-PC simulation ceases to bound work because a short circuit can
represent exponentially many monomials. This does not prove a general circuit
proof lower bound. Grochow--Pitassi supplies the representation distinction;
our rule is an explicit search procedure, not a consequence of their theorem.
Also reopened Darwiche--Marquis, *A Knowledge Compilation Map*,
https://arxiv.org/abs/1106.1819 : succinctness and transformation cost are
separate obligations. We will derive a mixed nonlinear projection and account
for all repeated cofactor construction. No arbitrary Boolean-identity oracle,
global factorization oracle or hidden quantifier gate is permitted.

Revised bounded target: decide whether this concrete shared-circuit rule has
a polynomial cumulative work bound; if it fails, record the exact recurrence
or family and distinguish it from all possible circuit compression rules.
Parent planning gate `literature-review-circuit-payload-route-2026-09-08.md`
now authorizes this shared-circuit rule and minimal discriminating code. The
sparse-PC implementation is cancelled.

Parent subsequently requested the in-scope factor-aware refinement: retain
independent factors under existential projection and join only dependent
factors, with a memoized syntactic unit-coefficient XOR pivot. This is the
same cofactor rule with exact locality, not a new proof-system force. The
candidate note now distinguishes the disproved raw-order bound from the
unproved adaptive factor-aware cumulative bound, and checks connected
nonlinear overlaps. No general circuit lower bound is claimed.

Stop-loss: this is one falsification/closure increment, not a new open-ended
search for sparse-PC polynomial bounds. No Lean packaging, publication, general
SAT capability, physical implementation, or P=NP claim follows. If the known
proof-system obstruction applies, preserve it and do not tune pivot order as a
purported escape. A different successor beyond the currently approved circuit
rule needs its own literature gate, exact inference rules, verification and
uniform search-cost theorem.
