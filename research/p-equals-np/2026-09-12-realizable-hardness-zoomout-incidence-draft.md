# Actual zoom-out incidence identity: source draft

2026-09-12. S3134 under S3126. **UNCOMPILED**: no compiler, axiom-query,
example or independent review result is claimed. No Git operation or publication
was performed by this source author.

## Target and source

This is the existing zoom-out probability identity in
`realizable-cmmsa-hardness/paper/submission-manuscript.md`, paragraph beginning
"For the zoom-out, put b=d-a" (line394 onward in the inspected manuscript).
It is a finite incidence dependency of the selected realizable-hardness route,
not a new algorithm, scientific mechanism or novelty claim. The planning
source-directed literature note and S3134/three-lens protocol were read.

The exact existing `ConditionedCovering.retainedConditional` is summed over the
event L contained in W. Under Q contained in V and W and a <= d <= dim(V), the
script derives

    P(L subset W | V,Q) = Gaussian(dim(V intersection W)-a,d-a)
                          / Gaussian(dim(V)-a,d-a).

V is the actual retained submodule from the actual deletion draw. The script
does not assume this ratio, a probability surrogate, or an independent posterior.
`GrassmannFlagPosterior.card_relativeUpper` already derives the requisite
actual flag count through a concrete subtype/quotient equivalence; this draft
reuses that theorem, rather than duplicating the finite linear algebra.

`retained_event_mass` and `retained_event_pos` prove the conditioning event's
exact mass and positivity for the actual dimension range. `retainedConditional_uniform`
cancels its concrete incidence denominator and identifies every mass point on
the actual fibre. The numerator sum then counts flags in V intersection W.
An explicit codimension equation dim(V intersection W)+c=dim(V) specializes
the numerator to dim(V)-a-c. No rank-stability probability estimate is supplied.

The ambient identity uses the existing `ambientConditional` and the same actual
relative flag count. Its pointwise uniform formula is proved from the accepted
ambient conditional formula and the Gaussian flag double-count identity. Its
current domain is a <= d <= J, matching that accepted interface; this covers
the manuscript regime and makes no stronger ambient-domain claim.

Null events retain the existing algebraic-zero convention. Noncontainment of
Q in V, excessive d, and Q not contained in W have explicit zero-mass lemmas.
The positive retained theorem allows d up to dim(V), not only J. In the
intersection-deficient case the Gaussian numerator is zero. The d=a boundary
has probability one for every W containing Q; top W has probability one on
every valid retained fibre.

## Files and planned checks

Only these new source files and this receipt are owned:

- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ZoomOutIncidence.lean`
  SHA256 `5f7a51424d360f9360ad0f8f2a8584e0e3748b9ad1da53ec090714004cd428cd`.
- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ZoomOutIncidenceChecks.lean`
  SHA256 `6531730fe9ff3af7d84f81f36aa7353228cbc54127144bccf7efb373898e2508`.

There are 14 planned axiom queries and 9 examples, all unrun. The examples
exercise null events, noncontainment, excessive dimension, impossible W,
top W, d=a retained and ambient cases, insufficient intersection dimension,
and a numerical zero-codimension/b=0 boundary. No sorry, admit, new axiom or
native_decide is introduced. Accepted sources, aggregate and package pins
remain untouched. Compilation and statement review remain required; scripts
may still have elaboration/API errors.

## Remaining scope

This identity supplies no near-one Gaussian estimate, asymptotic parameter
choice, conditioning-TV estimate, posterior rank-stability probability,
mixture reweighting bound, decoder/PCP theorem, encoded polynomial-time
reduction, learning transfer or full hardness result. GaussianNearOne is not
imported while it remains an uncompiled draft. Successful future compilation
will require independent proof, complexity and non-claims reviews before
bounded acceptance; full theorem certification and paper reconciliation are
separate outstanding work.
