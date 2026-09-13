# Actual drop-count exponential tail: source draft

2026-09-12. S3133, child of S3126. **UNCOMPILED; no kernel verification,
axiom report, independent review, acceptance or publication claim.**

This source-only task owns exactly the two new companion modules
`DropCountTail.lean`, `DropCountTailChecks.lean` under
`certifications/realizable-hardness/lean/PvNP/RealizableHardness/` and this
receipt. No compiler, dependency download, Git command, source-map change,
aggregate import, existing source modification or publication was performed.
The three files are deliberately left for the orchestrator's exact-scope
preservation and later compiler routing.

## Inputs and route

Read the full full-goal dependency assessment in this directory, S3133,
planning protocol and literature-trigger protocol, and the source-directed
frontier review dated 2026-09-12. This implements the selected manuscript
posterior-tail dependency, not a new research direction or novelty claim.
There is no applicable AGENTS.md in this satellite source ancestry; the
only AGENTS.md files found under certifications belong to vendored
complexitylib/cslib packages and neither package was modified.

Inspected actual companion GrassmannIncidence, TripleRestrictionDimension,
TripleRestrictionRank, FiniteSampling, FiniteConcentration and BernoulliMGF
source. The accepted centered Bernoulli/Hoeffding bound is not substituted
for the rare-drop Chernoff exponent: the source derives the uncentered exact
moment anew using the concrete product mass and finite exponential-sum
identity. Inspected pinned mathlib's Real.log_nonneg and exponential API.
No external dependency or binomial distribution theorem is assumed.

## Actual definitions and intended conclusions

`dropped b` is one for a singleton block choice and zero for none.
`dropCount_eq_sum` and its real-cast form identify the existing actual
`TripleRestrictionDimension.dropCount` with the sum of these block indicators.
`tail beta J T` is the real cast of the existing rational
`TripleRestrictionRank.probability beta (fun d => T < dropCount d)`.
`tail_sum` identifies this with the sum of the actual GrassmannIncidence
prior atoms, restricted by the strict integer event. It is not a newly
postulated distribution.

The draft theorem scripts derive:

1. `block_moment`: sum over none and three singleton outcomes is exactly
   `1 - beta + beta * exp(t)`, including all rational-to-real casts.
2. `moment_identity`: `sum_d prior(beta,d) * exp(t*D(d)) =
   (1-beta+beta*exp(t))^J` for every rational beta, natural J and real t.
   Finite product expansion proves this directly; no independence premise
   or supplied `D ~ Binomial` fact appears.
3. `moment_bound`, under `0 <= beta <= 1`, bounds that moment by
   `exp(J*beta*(exp(t)-1))`. It applies for all real t and uses
   `1+x <= exp(x)` and nonnegative powers.
4. `exponential_tail`, under the same beta constraints and `t >= 0`, gives
   `Pr[D>T] <= exp(J*beta*(exp(t)-1)-t*T)` for all natural J,T.
   The strict event implies the weaker threshold D>=T; t=0 is allowed.
5. `optimized_tail`, adding `0 < mu=J*beta <= T`, substitutes
   `t=log(T/mu)` and gives `exp(T-mu-T*log(T/mu))`.
6. `chernoff_tail`, with those same hypotheses, discards the favorable
   `exp(-mu)` factor and derives exactly `(exp(1)*J*beta/T)^T`.
7. `chernoff_tail_allow_zero` permits `mu=0` as well, assuming only
   `0<=beta<=1` and `J*beta<=T`. At T=0 this is Lean's explicit natural
   exponent convention `0^0=1`; the actual tail is zero when mu=0.

Zero/support boundaries are separate exact scripts: tail is nonnegative
and at most one for valid beta; tail is zero for J<=T without any beta
constraint; an empty draw has zero tail; beta=0 has zero tail for all J,T;
mu=0 has zero tail. The beta=0 proof locates an actually dropped block and
uses its zero atom in the product, rather than taking a limiting bound.
The upper endpoint beta=1 is permitted throughout.

## Intended checks and source integrity

The Checks module contains **17 intended axiom queries and 10 examples**.
Examples cover the none/singleton indicator values, empty draw, beta=0,
full and beyond-support cutoffs, t=0 moment normalization, mu<T, mu=T,
and the zero-mean extension. These are proof scripts only; no outputs
exist and none is counted as passed. No native_decide is used.

SHA256, UTF-8 source bytes:

- Main: `7070cf6093f68e6804ba8a135d5d7c24b72a2fd3a76838aa159769233ba34eb1`
- Checks: `ad33060916b75c6ac1959fa63f514f02ad0a9c9fadac7820025f3bbe276dde59`

Targeted source scan found no sorry, admit, native_decide or axiom
declaration tokens in the two files. This is not a transitive axiom audit.
An initial rg command using a Windows literal wildcard failed; the exact
two-file scan was rerun and returned no matches. No build was attempted.

## Remaining work and claims boundary

All new scripts need the exclusive compiler slot, actual diagnostics and
statement-preserving repairs if necessary, then fresh independent proof,
complexity and nonclaims reviews. The scripts use existing accepted modules
but that does not transfer acceptance to this new source. In particular,
the real-cast finite sums and logarithmic denominator algebra are untested
elaboration sites.

The intended generic optimized Chernoff inequality is fully scripted;
the manuscript parameter specialization is still open: instantiate
`T=h^4`, `J*beta=A*h^2`, prove beta's domain and all eventual inequalities,
and derive the concrete `2^(-100*h^2)` target. This does not supply the
posterior Markov exceptional-set theorem, advice-marginal closeness,
likelihood/rank combination, KMS covering or relative-error mixture bound.
The specialized PCP/decoder, actual encoded randomized reduction,
learning transfer, fixed-L asymptotics, final Main/Audit and manuscript
reconciliation remain required by S3131-S3137/S3128. Full S3126 remains open.
