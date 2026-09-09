# Independent projection proof and complexity review

2026-09-08; S3040 / E004 / S008. Harness reviewer; no OpenCode. Scope: the
projection-cost attempt and reproducer, plus the complexity interfaces in the
effective-carrier and localized-bit attempts. No implementation changes, commit,
publication, or formal Lean verification by this reviewer.

**Verdict: GO for the bounded projection identity, exact flat algorithm, and
candidate-wide flat-resolution limitation. GO for the explicitly conditional
complexity statements in the two fluid dependency notes. The standard-model
P=NP goal is unresolved.** This is not a certificate for the external fluid
construction or a claim that its coefficients have been computed.

## Independent checks

Read `2026-09-08-projection-cost-attempt.md`, `check_projection_cost.py`, the
normalization and evaluation helpers in `check_payload_summaries.py`, and the
effective-carrier and localized-bit notes. No destination AGENTS.md was present.

Ran `python research/p-equals-np/check_projection_cost.py` independently: exit 0;
14,640 local truth comparisons, 2,538 non-tautological local certificates, 80
adaptive endpoint cases (30 YES, 50 NO), 5,161 charged generated candidates,
5,103 endpoint-run certificates. The cubic family produced 1,8,27,64,125 clauses.
An additional direct enumeration of all 15 masks confirmed 49 minimal covers.

Ran `python research/p-equals-np/check_effective_carrier.py`: exit 0; 20 conditional
initializers and 8 cutoff stages; rational axis and leading norm checks passed.
The script explicitly does not certify actual-source off-axis constants or
trajectories. These finite tests corroborate implementations; the arguments
below, rather than finite sampling, carry the all-input claims.

## Projection and proof trace

For a fixed outside assignment, a false residual forbids exactly its pair mask.
Existence of an allowed pair state is equivalent to failure of the false masks
to cover the domain. Grouping by mask preserves this test: a group conjunction
is false iff at least one member residual is false. Minimal covers suffice.
Every member of a minimal cover has a private domain state, giving cover size
at most four. Empty domains and empty cover collections have the stated Boolean
conventions. Distributing each cover term therefore gives the exact flat CNF.

For each resulting non-tautological clause R, a chosen source for a state s
has residual contained in R and pair literals contained in the clause excluding
s. The four weakened leaves R OR C_s resolve in a depth-two binary tree to R.
The reproducer checks subset inclusions and all three resolutions; the final
equality also checks the intermediate structure implicitly. Excluded states
require explicit domain axioms. The all-input endpoint uses the full domain,
so this source of additional axioms is absent there.

Each retained output can be appended to a DAG derivation from the previous
stage, using at most seven lines. Its sources are previous-stage clauses, not
outputs discarded at the same stage. Removing duplicates and subsumed outputs
requires no semantic inference. Initial normalization only discards input
clauses, so the surviving axioms are legitimate original axioms. Consequently
an UNSAT endpoint supplies a refutation with length at most the input clause
count plus seven times the cumulative retained output count. Rejected adaptive
pair choices need not be included in that refutation, but their actual work is
correctly charged by the executable. Selection order has no effect on this
simulation. Weakening elimination by propagated subclauses is sound: resolve
when both pivots remain; otherwise retain the parent missing its pivot.

This is an analytic trace-existence argument. The script checks local
certificates; it does not save and independently replay a complete global proof
object. No assertion of such a separately checked global object is needed for
the complexity inference.

## Imported lower bound and length model

Primary source inspected: [Ben-Sasson and Wigderson, Short Proofs Are
Narrow--Resolution Made Simple](https://people.inf.ethz.ch/emo/SatSem05/Papers/BensassonWidgerson01.pdf),
Definitions 2.1 and 4.1--4.3, Theorem 4.4 and Corollary 4.5. Their proof size
counts DAG lines, and their resolution system already permits weakening.
The stated hypothesis is connected cubic graphs with linear balanced edge
expansion and odd total charge. Thus a family on N vertices has 3N/2 variables,
at most 4N width-three clauses, and exponential-in-N refutation length. This
matches the trace above. With standard indexed encoding L=O(N log N), that
lower bound is superpolynomial in L; it is not being asserted as 2^Omega(L).

More explicitly, if K is the number of retained generated clauses on such an
UNSAT input, then 4N+7K bounds a refutation's line count above. The imported
lower bound forces K=2^Omega(N). Merely materializing those outputs takes at
least that much work. Clause bodies and predecessor indices have polynomial
encoding overhead, so the conclusion does not rely on unit-cost gigantic
integers, on tree-like resolution, or on an inference that an upper bound on
runtime is also a lower bound.

Two minor wording clarifications, neither changing this verdict:

- The cited theorem and corollary are on printed page 156, PDF page 8; printed
  page 155 contains the preceding Tseitin definitions.
- The endpoint may add one unused padding variable, so “no new variable names”
  is literally too strong. It adds no extension axioms or encoded information.
  Restricting that dummy variable in a refutation removes it without increasing
  length. Equivalently choose the cubic family with even edge count. This does
  not provide an escape from the lower bound.

## Local size versus cumulative work

The first factored rewrite has linear wire/literal size with constant mask and
cover overhead. Each clause-selection candidate uses at most four distinct
sources, yielding the stated O(m^4) count. The loose quadratic normalization
cost explains the m^8 envelope. A fixed polynomial envelope for all stage sizes
would imply a polynomial solver, but the resolution argument rules out that
envelope for the implemented flat candidate.

A later circuit is not necessarily a CNF. Applying the mask classification to
arbitrary gates as if their truth masks were independent of remaining variables
would be invalid. The note explicitly avoids this inference. General
cofactoring is semantically valid but offers no universal cumulative size bound.
Nonclausal gates, parity reasoning, extension definitions, and other SAT
algorithms are outside the flat proof simulation. No P versus NP separation or
general circuit lower bound follows.

## Fluid dependency complexity interfaces

The carrier's initialization bit-work statement is conditional on fixed
admissible rational parameters and a fixed certified positive-width rectangle.
For binary M, S and the required accuracy exponent grow as O(log M), and
fixed-degree root bisection and dyadic arithmetic then have polynomial bit
cost. This says nothing about physical positioning work. It does not give a
polynomial-cost way to obtain the certificate or an admissible effective field.
The note clearly distinguishes actual axis estimates from missing off-axis
majorants and labels the rational h used in tests as synthetic, not globally
source-certified.

Cutoff doubling gives O(log M) potentially active orders along the finite
horizon. Cardinality of active orders does not bound coefficient norm growth,
coefficient generation, output precision, cutoff-integer size, or evaluation
work. The interval search is conditional computability only and can be very
expensive. The note preserves these distinctions correctly.

The localized bit uses a supplied velocity/derivative interface, a nonlocal
weighted packet integral and distributed feedback, prescribed write commands,
and one-way scalar coupling. These are explicit resources and assumptions.
Its uniform endpoint error is not a bound on their construction or evaluation
cost. The integrated damping budget includes 4M; that quantity is neither a
proved minimum energy cost nor a Turing lower bound. Conversely, a tiny sensor
integral with a short exponent description is not a free accurately measurable
real. The note charges flow evaluation, quadrature, registration and precision,
and limits passive readout only for its stated fixed-volume fixed-error sensor.
No complexity shortcut is hidden in the amplitude recurrence: direct processing
of arbitrary commands still contains M updates.

## Closeout boundary

The flat candidate's universal polynomial bound is rejected for a specific,
proved proof-system reason. The remaining nonclausal cumulative-evaluation
bound and the fluid-to-standard-model algorithm are unsolved. This review
supports bounded progress tracking only, not route-final closure or P=NP.
