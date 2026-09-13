# Tail and exceptional advice: independent complexity review

2026-09-12. Top-level independent complexity-theory lens for S3133/S3126.
Verdict: **GO-WITH-NOTES**, limited to the four modules below. This is not
acceptance of the full hardness theorem, full S3133, or publication readiness.

## Candidate and evidence

Orchestrator-frozen candidate: `5401443679c5f35178e4dcbdca170d9523e13360`.
Read the actual four companion files, their dated author receipts (including
the superseding author-compilation updates), the relevant GrassmannIncidence
and PosteriorReweighting definitions and total-probability proof, planning
S3133/S3126, the formal three-lens protocol, and the satellite full dependency
assessment. Current source byte hashes independently computed in this review:

| File under certifications/realizable-hardness/lean/PvNP/RealizableHardness | SHA256 |
|---|---|
| DropCountTail.lean | d2994d1124c7bfc39208906725a1475fe49ec1b8e33dc97303649401ffda2dd8 |
| DropCountTailChecks.lean | e2d2719251410fc14b746bb69a3eea88ad931550e103c1266811011fa1aa1239 |
| AdviceExceptions.lean | eb0ac116e6a12a3f0ae9cc2e09b8ad75db261c7d521119688075532b276cf553 |
| AdviceExceptionsChecks.lean | f9037941388cb479ee62e03b38c584a6dd9887a57ffc6f31571e5681e7560e11 |

The author receipts report successful direct main exports followed by successful
Checks-only repairs: tail main in session 8486 and final Checks 77923;
exception main in 22399 and final Checks 25111. Their reported total is 36
selected standard-axiom profiles and 20 examples. This reviewer did not run
a compiler or independently certify output provenance. Frozen Git equality
and independent kernel export are the proof/build lens's separate obligations.
Historical UNCOMPILED source banners are superseded by the dated receipts
for author status only; neither banner nor receipt replaces independent review.

## Mathematical and quantifier findings

1. The tail is the real cast of the actual rational product-prior mass of
   `T < dropCount d`. The indicator sum uses the same existing drop count;
   the none outcome contributes zero and each singleton contributes one.
   Summing the three singleton masses gives beta. `moment_identity` derives
   `(1-beta+beta*exp(t))^J` by finite product expansion. It assumes neither
   a binomial law nor the desired moment inequality. This is an actual
   distribution calculation, although no separate binomial PMF identification
   theorem is needed or exported here.

2. `moment_bound` uses the nonnegative Bernoulli factor and `1+x <= exp(x)`.
   `exponential_tail` requires nonnegative t and bounds the strict natural
   cutoff by the weaker real threshold D >= T. This loses sharpness but is
   valid. `optimized_tail` has exactly `0 < mu = J*beta <= T`; hence T and
   T/mu are positive and log(T/mu) is nonnegative. Removing exp(-mu) then
   yields `(exp(1)*mu/T)^T` without an unproved exponential-tail premise.

3. Zero mean is handled algebraically through J=0 or beta=0. A dropped
   block has zero atom when beta=0, so the actual tail is zero. J<=T has
   zero tail by support, independently of the beta range. The final bound
   allows mu=0, including T=0 with Lean's division-by-zero and natural
   exponent conventions, where the displayed upper bound is 1. Positive
   mean cannot reach T=0 under the hypotheses. Beta=1 is allowed. For
   thresholds near mu the bound can exceed 1; it is not by itself a useful
   rare-event estimate in every allowed parameter regime.

4. `tv` is half-L1. `event_sub_le_tv` derives the sharp event-difference
   constant using equal total masses, not an assumed distance-to-event
   interface. Nonnegativity is unnecessary for this algebraic inequality;
   accordingly normalization-only event-transfer and low-marginal lemmas
   may accept beta outside [0,1]. Their probability interpretation requires
   the valid beta range, which the final exceptional-advice theorem retains.

5. The actual joint law is product prior times the uniform incidence kernel.
   The condition a<=J guarantees nonempty fibres for every retained draw
   and therefore kernel normalization. `posterior_tail_expectation` sums
   the imported actual total-probability identity to recover the original
   tail. That imported proof derives zero joint atoms at zero marginals
   using nonnegativity. A null marginal's conditional function is zero,
   not a normalized probability law on an impossible event. Such advice
   is not in badTail for positive zeta, but lies in lowMarginal when the
   ambient atom is positive. No null advice silently escapes the union.

6. Markov bounds the marginal mass of `tailMass > zeta` by priorTail/zeta,
   with positive rational zeta and nonnegative posterior tail. Transferring
   that set to uniform advice costs one TV. On `P'(Q) < P(Q)/2`, pointwise
   lost mass and the event inequality give uniform mass at most two TV.
   The union is thus at most priorTail/zeta + 3 TV, with no additional
   multiplicative likelihood cost. Equality at either bad-set threshold
   belongs to the good set, whose two weak inequalities are extracted.
   The final real corollary casts the actual rational tail and substitutes
   the actual Chernoff result. No conditional independence, all-Q positivity,
   desired exception estimate, or small-TV premise is smuggled into it.

## Limits and next required discharges

No blocking complexity or probability-quantifier defect was found in these
four modules. Their progress is the actual rare-drop exponential estimate
and actual exceptional-advice transfer, previously required in the posterior
route. The estimates are analytic probability lemmas, not runtime bounds.
Noncomputable finite subspace enumeration is not a polynomial-time sampler.

The quantitative proximity `adviceTV <= beta*sqrt(J)*2^(a+4)` remains open.
The Chernoff theorem has not specialized T=h^4 and mu=A*h^2, proved the
eventual `(e*A/h^2)^(h^4) <= 2^(-100*h^2)` inequality, or chosen A before h
with all integrality and beta-range obligations. Substitution of
zeta=2^(-30*h^2) and the resulting 2^(-70*h^2) loss also remain to be
assembled. A small total exceptional mass cannot be asserted merely from
the symbolic coefficient-three bound: TV may still be large.

This union contains low-marginal and posterior-tail exceptions only. It does
not include or bound the separate covering/zoom exceptional set. Actual KMS
conditioning identity and covering proximity, near-one relative probability
ratios and positive mixture normalization, final parameter losses, specialized
PCP/decoder proofs, encoded randomized reduction/runtime/coins, fixed-L
asymptotic assembly, and the exact HN learning transfer remain required by
the full ledger. It proves neither CMMSA NP-hardness by itself nor P=NP,
P!=NP, a quantum speedup, or a new research novelty claim.

Independent proof/build and non-claims verdicts remain separate required
closeout evidence. Only this report was written; no source, compiler,
dependency, staging, commit, push, publication, or planning changes were made.
