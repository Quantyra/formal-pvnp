# Posterior reweighting: independent complexity review

2026-09-12. S3133 under S3126. Reviewer: `posterior_complexity_review`,
independently assigned by the orchestrator as the complexity-theory lens.

**GO-WITH-NOTES for the finite rational algebra increment only.** No blocking
quantifier, normalization, or false complexity-force issue was found in the
inspected statements. This does not close S3133 or certify the full posterior
geometry, hardness theorem, learning corollary, or publication readiness.

## Scope and evidence

Inspected candidate `f6126f7213c91741932be465e8041f26e7e8427f`, main and Checks
in `lean/PvNP/RealizableHardness/`, and the dated posterior-reweighting
formalization receipt. Read `INTEGRITY-CLAIMS.md`, the planning S3133 story,
and the formal three-lens closeout protocol. No local AGENTS.md exists in
this satellite root. This was a source-only review: no Lean/Lake invocation,
dependency download, source edit, companion edit, or publication action.

| File | Working-byte SHA256 | Candidate Git-blob SHA256 |
|---|---|---|
| PosteriorReweighting.lean | e69b54f5efc8412e8e04081a5d88ebdc588a51325aca0a830b08518c10e35b39 | 9ae9b4c017b76eb1ae8adc951e8cb077996862a032f1758065e43c238ac1ccf1 |
| PosteriorReweightingChecks.lean | a1a5a12a6040d7befbba9d0a660ac5cfcb9072d682a3de6056324aba4506512b | 48ca57c80a389efa3d8460010acb8875b25e06d598749cbb623ee8b443b321aa |

Independently computed both hash forms and verified exact equality after
CRLF-to-LF normalization. Author-reported main session 87985 and Checks
session 84646 exited 0 with 13 standard-only profiles; those are author
build evidence, not an independent compiler run by this reviewer.

## Mathematical and quantifier assessment

1. `marginal` and `posterior` are actual finite sums and normalized joint
   masses. The identities do not assume their own Bayes conclusions.
   `marginal_normalized` uses prior and row sums equal to one; probability
   interpretation additionally requires the separately explicit
   nonnegativity conditions. `posterior_normalized` is an algebraic sum
   identity under positive marginal, not by itself a packaged probability
   distribution for arbitrary signed inputs.
2. Zero-prior atoms are retained. At zero marginal Lean's total division
   makes the posterior zero, not a normalized conditional law.
   Normalization correctly requires positive marginal. Total probability
   proves zero joint contributions from nonnegativity before summing, so
   it does not silently condition on a null event. The ratio identity's
   zero-marginal branch remains an algebraic identity and should not be
   cited as meaningful probabilistic conditioning there.
3. `posterior_event_cutoff` has the correct event-local cost:
   posterior(B) <= C prior(B) + posterior(not G). It does not multiply the
   entire exceptional posterior mass by C. Its likelihood domination on
   G is explicitly an input, not a derived Grassmann estimate. The bound
   holds for arbitrary events B,G at each supplied q; this permits later
   q-dependent choices but supplies no independence of W(q) and V.
4. `normalized_reweighting` requires a normalized nonnegative finite law,
   weights in [0,1], 0 < p0 <= 1, nonnegative eta,zeta, relative weight
   stability on G, bad mass <= zeta, and eta + zeta/p0 <= 1/2. It derives
   Z >= p0/2 > 0, reweighted bad mass <= 2 zeta/p0, and response error
   <= 4 eta + 4 zeta/p0 for every response taking values in [0,1].
   The estimate follows from the absolute weighted error and denominator
   lower bound; the desired mixture comparison is not assumed. Indicator
   responses give event comparisons. A different convention for a full
   L1 norm should not silently reuse the same constant.
5. Reweighted normalization is proved separately. Together with input
   nonnegativity and the positive normalizer it yields a probability law.
   No positivity assumption excludes individual zero-weight atoms.
   The Checks example with masses 7/8 and 1/8, weights 1 and 0, p0=1,
   eta=0, zeta=1/8 demonstrates satisfiable nontrivial hypotheses.

## Required application work and limits

The increment proves finite algebra used by the intended argument, not the
geometric hypotheses. Still required are actual finite-field subspace
counts/Gaussian ratios, the V,Q incidence kernel and its support and
normalization, binomial and Markov exclusions, rank/transversality for the
actual subspace W(q), and the likelihood bound on the actual cutoff set.
The unconditional rank estimate must be transported to the posterior
through the proved density bound; conditional independence cannot be
substituted for that step.

The later mixture application must identify its actual base law and
conditioning weights, prove the conditioned-law matching, establish
0<p0<=1 and the numerical smallness hypothesis, and instantiate the
bounded response with the actual decoder or event. KMS covering and the
specialized decoding/parameter obligations remain external to this file.

All carriers are arbitrary finite types and sums are noncomputable Lean
definitions. There is no input encoding, sampler machine, runtime bound,
polynomial parameter bound, or randomized reduction theorem here. No
NP-hardness, complexity-class separation, growing-parameter uniformity,
or novelty conclusion follows from this finite increment alone. These
limits agree with the candidate's author receipt.

This receipt supplies only the complexity lens. Independent proof and
non-claims lenses and orchestrator integration remain separate gates.
