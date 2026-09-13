# Independent complexity review: numerical deletion-tail specialization

Date: 2026-09-12. Route: S3133/S3137, parent S3126.

Verdict: **GO-WITH-NOTES** for the exact numerical specialization and its
composition with the actual deletion-event mass. This is not acceptance of
the complete parameter construction, encoded hardness reduction, learning
transfer, or final manuscript.

## Frozen evidence and review method

Candidate: `5985c7bb74a9947a37fd2d207cc21e5a0d0f4d35`.
Working bytes were compared with `git show` at that candidate and matched
for all three files:

| File | SHA256 |
| --- | --- |
| `DropTailParameters.lean` | `9fc28c616488e2ff2cc167ac018695dd4612358a5360e40ba351dacb01e97793` |
| `DropTailParametersChecks.lean` | `37af3e9fc1cc809b059d9156509bded4f0b8149c7550bb561050b011453f0df9` |
| `2026-09-12-realizable-hardness-tail-parameters-draft.md` | `ed674f656a991c318be0381b410656fb49e3c7b3f062bbd222757fde18786172` |

The Lean files are under
`certifications/realizable-hardness/lean/PvNP/RealizableHardness/`;
the author receipt is under `research/p-equals-np/`.
I read the complete candidate statements and proofs, the checks, the author
receipt, the actual `DropCountTail.tail` definition and
`chernoff_tail_allow_zero` theorem, and the manuscript posterior section
around lines 321-350. No compiler was run in this complexity review. The
author reports 15 standard-axiom profiles and seven compiled examples;
independent build acceptance belongs to the separate proof reviewer.

## Mathematical and quantifier audit

`Ready A h` expands to precisely `100 <= h^2` and
`2 * exp(1) * A <= h^2`. It contains no tail, statistical-distance, or
hardness hypothesis. `eventually_ready` proves these inequalities for every
fixed real A by choosing a natural N greater than
`max 100 (2 * exp(1) * A)`. Every h >= N then satisfies h <= h^2 and the
two required bounds. The threshold is deliberately loose but sufficient.
There is no circular choice of A in terms of h in this argument.

For A >= 0, the proof derives the mean/cutoff inequality A*h^2 <= h^4,
the nonnegative Chernoff base exp(1)*A/h^2 <= 1/2, and
h^4 >= 100*h^2. Monotonicity in the base followed by decreasing powers
of 1/2 gives the asserted decay. All exponents are natural; `decay k h`
has the exact reciprocal meaning 1 / 2^(k*h^2). No logarithmic estimate
or desired asymptotic bound is assumed.

`actual_tail` uses the real cast of the existing rational probability of
the strict event `h^4 < dropCount d` under the actual independent triple
draw. It retains beta in [0,1], so this is an actual probability, and uses
the exact mean identity J*beta = A*h^2 to instantiate the previously proved
zero-mean-compatible Chernoff theorem. It neither replaces the sampler nor
assumes posterior independence. Rewriting its base requires h > 0, which
is derived from Ready before any cancellation.

`decay 30 h` is strictly positive at every natural h. Power addition proves
the exact quotient `decay 100 h / decay 30 h = decay 70 h`; dividing the
actual-tail inequality therefore justifies the numerical bound needed by
the exceptional-advice Markov argument. This module does not itself state
or apply the Markov exceptional-set theorem.

`eventual_actual_tail` has the appropriate order: fixed A > 0, then one N,
then every h >= N, then every J and rational beta satisfying the range and
mean identity. N is independent of J and beta. It exports both unconditional
numerical inequalities and the conditional actual-tail consequences.

## Realizability and boundary cases

The mean identity is a genuine retained parameter constraint, not the
desired tail estimate in disguise. It does not construct parameters. In
particular, because J and beta are rational after casting and Ready forces
h > 0, an irrational A admits no J,beta satisfying this equality. The
actual-tail branch of the theorem is vacuous for such A, although its
numerical bounds remain nonvacuous. This does not invalidate the stated
conditional theorem, but an application must choose admissible A and prove
the mean identity rather than cite this theorem as a parameter-existence
result.

For nonnegative rational A, admissibility is mathematically nonempty:
choose a positive natural J at least A*h^2 and set rational beta=A*h^2/J.
That observation is not a new Lean theorem in this candidate, and it is
not a proof for the prescribed double-exponential J. The intended integer
or rational constant choice and its coercions must be supplied by the later
parameter assembly.

The pointwise theorems allow A=0. With beta in [0,1] the zero-mean case is
handled by the imported actual-tail theorem; the checks instantiate beta=0,
A=0, h=10 for arbitrary J. The eventual wrapper intentionally requires
A>0. Ready is impossible at h=0, avoiding division by a zero cutoff. The
separate decay and quotient identities still hold at h=0, where the quotient
is 1. For positive A and Ready, J=0 cannot satisfy the mean identity.
No unintended positivity assumption is silently dropped.

## Remaining limits

This increment discharges the numerical tail step in the manuscript under
its explicit mean/range premises. It does not construct
J=2^(2^(A*h^2)), establish integrality for that expression, prove the range
of beta=A*h^2/J, establish advice or zoom statistical-distance estimates,
or combine all thresholds and floor losses into the fixed-L theorem.
It has no encoded runtime, random-bit complexity, polynomial-time reduction,
NP-hardness, HN learning-transfer, or P-versus-NP conclusion.

The Archimedean existence of N is an analytic threshold result, not an
algorithm computing a complexity-theoretic parameter from encoded input.
The distinction between each sufficiently large fixed L and growing-L
uniform polynomial runtime remains untouched. Paper reconciliation must
retain these limits until the actual parameter construction and complete
dependency chain are verified.

No source files, dependency pins, compiler artifacts, Git index, or public
artifacts were changed by this review. Only this review file was written.
