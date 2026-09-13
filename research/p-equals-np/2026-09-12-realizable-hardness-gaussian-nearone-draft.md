# Gaussian near-one probability: source draft

Status: UNCOMPILED. Source and checks have not been run; no kernel acceptance,
executed axiom profile, independent review, or full theorem completion is claimed.

Route: S3134 under S3126, the existing source-directed realizable-hardness
posterior/zoom-out dependency. Read the planning source-directed frontier note and
the submission manuscript's zoom-out paragraph beginning at line 394. This is a
finite formalization of the product estimate already used there, not a novelty claim.

## Concrete mathematical target

For binary Gaussian counts, m=n-c, b+1<=m and c<=n, the actual count ratio
G(m,b)/G(n,b) equals 2^(-bc) times normalizedFrame(m,b)/normalizedFrame(n,b).
The latter quotient is exactly the product, over i<b, of
(1-2^i/2^m)/(1-2^i/2^n). No identity or closeness premise is assumed.
Its value lies between 1-E and 1, where E=(2^b-1)/2^m.

The proof uses accepted GaussianRatio frame counting, monotonicity of each
normalized product factor, the elementary product lower bound, and positivity
under one spare dimension. If b+c+k<=n, then E<=2^(-k), yielding the explicit
finite near-one interval. k=1 yields probability at least 2^(-bc)/2. k=J/2
yields the floor(J/2) exponent needed for the manuscript's O(2^(-J/2)) estimate.

The domain includes b=0 and c=0. Checks separately cover n=b=c=0, where the
ratio is exactly one but the spare-dimension premise is unavailable. No theorem
claims a lower bound beyond the valid-dimension hypotheses.

## Scope and remaining work

Owned new files: GaussianNearOne.lean and GaussianNearOneChecks.lean in the
realizable-hardness companion, plus this receipt. Accepted sources unchanged.
Eleven planned axiom queries and eight planned examples are unexecuted.
No compiler, Git operation, publication, or nested delegation was performed.

The finite theorem has actual Gaussian count terms. It does not yet establish
eventual b+c+J/2<=dim(V)-a for the prescribed sampler family; the parameter
author can discharge that arithmetic using dim(V)>=J. Nor does this module
identify a probability kernel with the Gaussian ratio, compare normalized
weighted posterior mixtures, prove conditioned covering, discharge the decoder,
or establish encoded hardness/runtime/the complete Lean theorem. Those remain
separate mandatory obligations in the full goal.

Verification next: compile only these two modules against hash-verified accepted
dependencies with the coordinator's compiler grant and physical-memory guard;
repair actual diagnostics without weakening the concrete finite target; then
freeze for independent proof, complexity, and non-claims reviews.
