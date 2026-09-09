# Navier--Stokes to rational Hodge: bounded transfer audit

S3040 / E004, 2026-09-09. Literature checkpoint under `INTEGRITY-CLAIMS.md`.
Both proof and counterexample directions are considered. This is not a proof
of either conjecture, an experiment, or an implementation proposal.

**Decision: HOLD both transfer directions.** A specific pressure-analyticity
lemma has a reusable integration argument, but it does not supply a geometric
operation on rational Hodge classes. An exact currents criterion makes the
missing step explicit rather than treating singularity formation as evidence.

## Target and counterexample boundary

Deligne's official statement is in [the Clay volume](https://www.claymath.org/library/monographs/MPPc.pdf),
*The Hodge Conjecture*, Section 1; the [author's standalone version](https://publications.ias.edu/sites/default/files/hodge.pdf)
has the statement on pp.1--2. For smooth projective X over C, it asks whether
every alpha in H^(2p)(X,Q) intersect H^(p,p)(X) is a rational linear combination
of codimension-p algebraic-cycle classes. Section 1 distinguishes closed or
harmonic representatives from integration currents of cycles. Section 2(i)
identifies closed analytic subspaces with algebraic ones in the projective
setting by Chow's theorem. Sections 2(iv)--(v), pp.2--3, distinguish the failed
integral version and the failure of the merely Kahler generalization.

Accordingly a counterexample here must establish nonmembership in the FULL
rational cycle span on such an X. Torsion disappears after tensoring with Q;
an integral obstruction, a nonprojective example, or failure to obtain an
effective positive cycle does not meet this target. Rational combinations
may have negative coefficients.

## Exact NS lemma inspected

The [announced NS manuscript](https://cdn.openai.com/pdf/32d9f210-8b73-45e0-91bc-82a30aef8a9a/navier-stokes.pdf),
Appendix A.4, Lemma A.5, printed pp.133--134, equations (A.21)--(A.23), uses
the reference inner profile (A.7) followed by the actual Section A.2 outer
schedule, with its positive Pstar and h. Omit only its pressure-neutral azimuthal corrections; retain the
other transitions. Its datum is

    Pi0(eta) = -1/2 integral_R E_id,sched(y,eta)^2 dy.

It is independent of the later radial scale XR, holomorphic near [-1,1],
even, has Pi0'(eta) of the sign of eta away from zero, and satisfies
Pi0 <= -(5/2) Pstar^2 f(eta)^2, with f=(1+eta^2)^(-1).
The proof writes E=c(y)f(eta)^theta(y), 0<=theta<=1, chooses one analytic
logarithm, and uses integrable squared-profile tails bounded by C exp(y/5)
and C exp(-(1+2h)y). Restoring pressure-neutral corrections preserves the
datum. These are hypotheses and conclusions for that schedule, not for an
arbitrary geometric flow or singular current.

The earlier [pressure-effectivity note](2026-09-08-pressure-effectivity-attempt.md)
already quantified this particular integral. Those scalar bounds do not add
an input consisting of a projective variety and a specified cohomology class.

## What a proof transfer would actually require

The reusable analytic step is modest: a holomorphic parameter-dependent
integrand with a uniform integrable majorant has a holomorphic integral.
With effective integrand and tail data, this can support certified integration.
For Hodge work this would be an auxiliary estimate only AFTER the geometric
integrand, domain and cohomological interpretation have been supplied. The
NS parameter eta is not a Hodge-filtration coordinate by declaration, and its
scalar pressure integral is not a period or cycle class without a map proving
that identification.

A precise possible geometric endpoint comes from [Teh--Yang, Theorem 1.1,
p.1 and Definitions 2.1--2.3, pp.2--3](https://arxiv.org/pdf/1901.04152v2),
version 2. A current of real dimension 2k and bidimension (k,k) is a real
holomorphic chain exactly when it is locally real rectifiable, d-closed,
and its full closed support spt(T) is H^(2k)-locally finite. This support
condition is not merely a mass bound. The type hypothesis is essential;
the abbreviated abstract must not be read as removing it. This criterion
is used here as a literature result, not a newly established theorem.

Let dim_C X=N and k=N-p. A proof route could construct such a current T
whose homology class is Poincare dual to the specified rational alpha.
On compact projective X its holomorphic components would be algebraic;
compactness and local finiteness of the analytic decomposition make their
list finite. Their cohomology vectors and alpha
are rational. A real solution expressing alpha in their span implies a
rational solution by ordinary rational row reduction. Real coefficients of
the chain therefore need not themselves be asserted rational to obtain the
required rational span statement.

However, the construction of T with all these properties is precisely absent.
The NS lemma gives no map from (X,alpha), no preservation of that class or
Hodge type, no rectifiability theorem, and no support-measure control.
Analytic norm bounds do not establish any of these. For an EFFECTIVE cycle
construction one would additionally need finite geometric descriptions,
exact class identification and a terminating method to obtain them; a
holomorphic integral or convergent numerical approximation is insufficient.

This endpoint is a conditional reformulation, not an independent advance:
a rational algebraic cycle already gives a current with the stated properties.
Positivity is not substituted for the signed rational-span target.

## What a counterexample transfer would actually require

Showing that one NS-inspired evolution fails to produce T would exclude
only that proposed construction. A singular or diffuse representative does
not show that its cohomology class has no alternative algebraic representative.
Nor does failure of a pressure estimate separate a rational Hodge class from
all cycle classes. The scalar sign inequality in Lemma A.5 has no established
pairing with that span.

A counterexample route therefore still needs a concrete smooth projective X,
a verified rational (p,p) class alpha, and an obstruction covering every
rational combination of codimension-p cycles. Neither such data nor such a
separating theorem is produced by the inspected lemma. The known integral
and nonprojective failures are boundary checks, not candidates for this task.

## Justified next action

Do not initiate an NS-driven Hodge proof or counterexample construction from
this evidence. Reopen only upon an independently specified map from (X,alpha)
to geometric data, together with a noncircular lemma supplying the missing
class/type/rectifiability/support conditions, or a genuine all-cycles
obstruction on a concrete projective example. Generic analytic regularity,
finite-time blowup, or a restatement of the currents endpoint does not pass
that gate. The separate effectivity audit is not presumed to fill it.

No fluid experiment, code, new proof-development lane or publication follows
from this checkpoint.
