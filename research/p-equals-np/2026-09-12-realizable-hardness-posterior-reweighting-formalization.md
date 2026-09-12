# Finite posterior and normalized reweighting increment

2026-09-12; S3133 under S3126. **SOURCE WRITTEN, UNCHECKED.**

The two `PosteriorReweighting` Lean modules target finite rational Bayes
identities and the algebraic mixture step in the archived manuscript's
posterior/zoom-out argument (lines 304–423). This is an existing documented
argument, not a new novelty or force claim. The prior S3126 literature
assessment applies.

The actual marginal is a sum of prior times kernel; the posterior is its
normalized joint mass. Normalization requires positive marginal. Bayes mass
covers zero-prior atoms, and the ratio identity requires positive prior.
Zero-marginal terms contribute zero in total probability, proved using
nonnegative prior and kernel. The cutoff inequality charges its likelihood
constant only to the event's prior mass and adds posterior bad-set mass.

The mixture theorem assumes a nonnegative normalized finite rational law,
weights in [0,1], reference probability 0<p0<=1, nonnegative eta and zeta,
stability |w/p0-1|<=eta on a specified good set, bad mass<=zeta, and
eta+zeta/p0<=1/2. It derives Z>=p0/2>0, normalized bad mass<=2*zeta/p0,
and event-response difference<=4*eta+4*zeta/p0 for actual responses in [0,1].
The normalized weighted law and its comparison are conclusions, not inputs.
Checks include zero-prior, zero-marginal, zero-weight, and satisfiable
nontrivial small-error examples.

## Explicit remaining obligations

This generic finite rational result is not the full posterior lemma.
Grassmann cardinalities/Gaussian ratios, the actual V,Q incidence distribution,
binomial tails, rank/transversality bounds, KMS covering, conditioned law
matching and decoding remain S3133/S3134 obligations. It does not certify
runtime, source NP-hardness, the full hardness theorem, learning transfer,
or a publication claim. Finite noncomputable sums are not a reduction machine.

## Verification and three-lens

| Lens | Status | Evidence |
|---|---|---|
| Build/axiom audit | UNCHECKED | Awaiting exclusive compiler grant |
| Proof-adversarial | INCOMPLETE | Fresh top-level review required after green |
| Complexity | INCOMPLETE | Fresh top-level review required after green |
| Non-claims | INCOMPLETE | Fresh top-level review required after green |

No route-final or full-story completion is recorded.
