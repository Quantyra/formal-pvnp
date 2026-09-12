# Independent contribution/subsumption challenge

2026-09-12; S3108 / S008. Bounded literature audit, not a novelty guarantee,
new proof, human peer review, or renewed theorem-validity certification.

## Verdict

**No direct subsuming theorem identified in the checked primary sources.**
The defensible candidate contribution is the quantitative application to the
unchanged rank-excluded mixed bamboo distribution, followed by its exact
row-space/monomial-size consequence. Hierarchical complements, conditional
covariance, finite Fourier analysis, and Gram diagonal domination themselves
are established mathematical tools; this audit does not claim their invention.
The v3 row-space extension is already implicit in the scope of the v2 estimates,
but it is stronger than v2's stated ordinary-degree theorem and is explicitly
extracted in v3. These distinctions matter when describing what was added.

## Actual artifacts and exact target

Read the v2 argument through its local-complement conclusion and the v3
row-space, restriction, and size accounting; consulted the earlier source and
fresh reviews without treating their verdicts as evidence of novelty.
Actual local hashes at this audit:

- `2026-09-12-shared-row-conditioning.md`:
  `FD35101F5B0AFFD31DDDE39FB8435A3A5CC50A887E8F0F51C285BE549EBB691F`.
- `2026-09-12-bamboo-size-mechanism.md`:
  `43821CCC9014F3A7C5B58580FFF7C94F5DC9B9F0CAA4961F57C51A69193B9F5B`.

The residual width is even q>=1024, m=q^2, D=floor(q/(32 log_2 q)),
B=2D. Every local law retains odd vectors, augmented full rank on each
side, prescribed F_2 cross products, the all-ones boundary, and actual prefix
evaluation. Typed X_i and Y_i are different labels. Laws exist only for small
contexts, not as one globally satisfying assignment. The desired form pairs
functions in the law of their union, with no averaging over support labels.

The required source-specific input is conditional maximal correlation
epsilon=2^(-q/2+4D+5) for **all complete-row L2 functions**, every supported
separator assignment, and disjoint mixed additions of total support <=4D.
It is not merely entrywise coordinate correlation, average mixing, fixed-context
positivity, or a statement about unconditioned random frames. With
L=sum_(r<=2D) binom(2q^2,r), v2/v3 use
L epsilon <= 2^(-3q/16+6)<1/2. Arbitrarily many monomials and arbitrary real
coefficients are covered by this all-support count.

The exact final consequence is for original N=8q+4, **original m=q^2**, A=I_m,
unaugmented simple bamboo, and source explicit size
sum_i ||f_i||||g_i|| + sum_j ||h_j||. It is
S >= (8/7)^((2D-1)/2)=exp(Omega(N/log N)). It is not exp(Omega(N)),
not the original m=N^2 family, and not a circuit-size claim.

## Primary-source challenges

**Published weak-rank results.** Reopened the current
[ECCC TR26-133 report](https://eccc.weizmann.ac.il/report/2026/133/) and checked
the cached primary PDF text, Definitions 4.3 and 6.5--6.8, Lemmas 6.7,
6.9--6.10, and Theorems 5.18 and 6.11. Theorem 6.11 is SA size for exact
simple bamboo; Theorem 5.18 is SoS size for perfect-matching encoding.
Neither states the claimed simple-bamboo SoS result. Section 6 supplies
consistency and restriction survival, not the missing all-square positivity.
Transferring the perfect-matching theorem would require an encoding reduction
with the right direction and explicit SoS size preservation. No such mapping
was supplied by the checked theorem. A circuit proof upper bound is also a
different measure and does not subsume the explicit lower bound.

**Generic SA-to-SoS lift: not available from consistency alone.**
[Kothari--Lin, arXiv:2608.18048v1](https://arxiv.org/html/2608.18048v1),
Theorems 1.2/2.2 and 1.3/2.1, is a particularly current and sharp challenge.
It constructs consistent SA pseudo-distributions with R(p^2)=0 but R(p)>0,
and proves an approximate Cauchy--Schwarz inequality with additive
coefficient-L1 error. Exact PSD would contradict the displayed counterexample
(apply positivity to p minus its mean). The additive error cannot be removed
by renaming consistency as positivity. This is not a counterexample to the
bamboo estimate: it establishes why an additional quantitative hypothesis is
necessary. The bamboo proof supplies one via conditional mixing, rather than
claiming a universal hierarchy lift.

**HDX rounding explicitly assumes the missing PSD.**
[Alev--Jeronimo--Tulsiani, arXiv:1907.07833v1](https://arxiv.org/pdf/1907.07833v1),
Section 2.4, Fact 2.7 and Theorems 6.2--6.3, starts from local PSD ensembles.
Its conditional covariance matrix is justified by a Gram representation from
SoS vectors. Fact 2.7 groups an already-PSD ensemble into faces. It is not a
construction of those vectors from arbitrary consistent local laws. Mapping
rho_T to its input without the bamboo proof would assume precisely the
property under audit. Its rounding conclusions concern average correlations
and approximate assignments, not the uniform conditional operator estimate
needed for every complete-row component here.

**HDX local-to-global spectral machinery: plausible framework, incomplete
subsumption mapping.** Checked
[Dikstein--Liu--Wigderson, CCC 2025](https://drops.dagstuhl.de/storage/00lipics/lipics-vol339-ccc2025/html/LIPIcs.CCC.2025.7/LIPIcs.CCC.2025.7.html),
weighted-complex/link definitions and Theorem 66's stated trickle-down theorem.
That theorem transfers link spectral expansion to skeleton expansion, assuming
the required connectivity and link spectra. It does not calculate spectra for
these rank-excluded affine F_2 fibers. A small-context assignment complex can
indeed have a genuine top-face law; absence of a global satisfying assignment
on all 2m labels does **not** by itself exclude HDX methods. What is missing
is a verified mapping of its weighted up/down or link operators to the exact
pair-union functional, plus the source-specific uniform spectral bounds and
constants at growing dimension. The v2 estimates do actual work on that
missing input. Repackaging their conclusion as expansion would not make
those estimates an already-published theorem.

**Dependent Hoeffding decomposition: related construction, failed direct
hypothesis.** Checked
[Chastaing--Gamboa--Prieur, arXiv:1112.1788v3](https://arxiv.org/pdf/1112.1788v3),
Theorem 1 and condition C.2. Their theorem uses a global joint law and positive
lower domination of split product marginals. Even a bamboo two-row context
has prescribed dot-product parity: product marginals give positive mass to
forbidden parity pairs, whereas the joint law gives zero. Thus the requisite
positive lower domination fails. The local finite-dimensional complements
J_A are nevertheless elementary and need no import of that theorem. The
contribution cannot be described as inventing hierarchical orthogonality.

**Other SoS-from-HDX results are not encoding-identical.**
[Dinur--Filmus--Harsha--Tulsiani, ITCS 2021](https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.ITCS.2021.38)
constructs explicit 3XOR instances from LSV complexes using cosystolic and
local isoperimetric expansion. The checked abstract/construction scope is not
an arbitrary consistent-distribution lift or an exact simple-bamboo theorem.
No reduction preserving this specific moment functional or explicit size was
identified. This was a scope screen, not a full independent audit of that paper.

## What the generic bridge already gives

Once uniform conditional correlation is assumed, the final bridge is ordinary
Hilbert-space reasoning: decompose locally into complements to proper subsets,
use consistency to lift identities, kill nested pairings, center incomparable
components on their intersection, and dominate all off-diagonal blocks by
epsilon. The scalar inequality sum_(A!=C) a_A a_C <= (L-1) sum_A a_A^2
then gives positivity. A prior abstract theorem formalizing these steps would
subsume this **generic bridge**, but would not automatically prove the
source-specific estimate. Accordingly the contribution description should
emphasize verified conditional rank-fiber estimates and their application,
not claim a new general SA-to-SoS conversion theorem.

Likewise, the v3 restriction proof reuses the source's literal substitution and
survival factor. Its additional requirements are row-space PSD, stripping
endpoint factors, counting original g/h occurrences before expansion, retaining
squares through a real polynomial homomorphism, and checking local axiom
annihilation. Ordinary root degree alone does not meet that interface because
one surviving row can contain arbitrarily many coordinates. A generic
degree-to-size slogan therefore does not establish these exact constants.

## Search coverage and limits

Independent web search on 2026-09-12 used combinations of exact bamboo/weak
rank/SoS, local distributions/PSD/maximal correlation, SA/SoS/lift, and
HDX/local spectral expansion/orthogonal decomposition; it included August
2026 Kothari--Lin and 2025 HDX material. Primary theorem statements were
read for the principal comparisons above. Existing internal reviews also
identify finite-field incidence and bilinear-forms association-scheme
precedents; those remain precedents for tools, not certified exact-fiber
subsumption. This bounded audit did not exhaust every association-scheme,
matrix-completion, or proof-complexity result, establish priority, or rule out
a future shorter proof. No experiment, theorem repair, public edit, commit,
push, outreach, or spend was performed.

## Actual author-audit crosscheck and freeze

Read the entire saved `2026-09-12-bamboo-contribution-audit.md` at its
initial FA913CC2641472A2CD5CA49F3AE95B0CEA8392BCEBCB8A2AB35D22C48AAED60E
hash, then rechecked the added A/m uniformity section and final disposition
at final SHA256
`C182520AFB2688AF5C304034E9C383E39F0F89BB9901807CCAC067CF6180A4D6`.
Its bounded verdict agrees with this independent search: no exact subsumption
identified, established tools, source-specific conditional estimate as the
potential contribution, and priority unknown. No blocking comparison error
was found. Independently checked the cached source Section 2.2 statement
that extending its method to SoS was not pursued. This supports a
source-relative extension description, not novelty or completion of the
source's entire generator program. The fixed identity-output family and
m=q^2 parameter regime do not give arbitrary outputs or stretch guarantees.
Uniformity of an individual Fourier estimate in its prescribed right-hand
side does not alone establish an arbitrary-A theorem. Nor does it remove
the dependence on m in L=sum_(r<=2D) binom(2m,r). Any such extension needs
its own quantified source/fiber and all-context accounting check; none is
asserted or constructed in this audit.
The author's final diagnostic makes that same distinction correctly:
output uniformity at fixed m is a possible scope extension requiring review,
whereas unrestricted m changes the global support budget. Its suggestion
that a generator may require only a specified polynomial-m regime is
conditional and does not claim that regime or a generator has been proved.

Also opened the author's closest additional generic precedent,
[Dikstein--Dinur--Filmus--Harsha, arXiv:1804.08155v5](https://arxiv.org/pdf/1804.08155v5),
January 2024, checking its measured-complex and up/down-operator definitions.
These confirm that its inner products and averaging weights require an
explicit applicability map. Its decomposition is substantial precedent; the
author correctly leaves open a shorter HDX derivation. I did not independently
re-audit every theorem of its pseudocalibration comparison, and do not count
that section as separate fresh evidence.

Final disposition: **bounded contribution audit PASS; no direct subsumer
identified; no novelty certification.** This file is frozen for integration.
