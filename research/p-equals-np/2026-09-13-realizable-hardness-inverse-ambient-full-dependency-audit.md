# Inverse theorem ambient-dependency audit

2026-09-13. S3132/S3134/S3137. Bounded informal derivation by occurrence_gadget_author. No paper/source module edits, compiler, Git, experiment, or public action. This reviewer did not author the paper's robust lemma; prior lower Lean authorship does not certify these analytic imports.

**Verdict: the current proof's assertion that all remaining inverse steps follow after only the two displayed repairs is not justified literally. There are additional proof discrepancies. The explicit replacement below preserves S and epsilon-prime, makes every constant independent of ambient n, and requires only another displayed lower bound on n plus fixed-parameter cutoffs on h. It does not refute the inverse theorem.** The replacement is a candidate for separate mathematical review, not a kernel proof or permission to modify the manuscript.

## Evidence and exact scope

Paper repository (read only): C:/Users/Dan/Desktop/Projects/realizable-cmmsa-hardness. Parent identified source integration dba95d1; current archived HEAD inspected is 6516d231c55ff17ff7efb4f518cc617f0f3e6738. Submission source SHA256 de70a3f42bf015989831da342d017eccbda973b7518d1c248da25411d035e82c (53733 bytes); generated body ff512bcfc611d8a03a9bfd38b4c3347839f4c54057e2b7dbe219e5fef7346577 (62031 bytes). The relevant canonical source is submission-manuscript.md lines355-388, especially the inverse uniformity assertion following the high-degree residual bound.

Primary evidence: preserved arXiv:2510.23991v1 text C:/Users/Dan/AppData/Local/Temp/s3123-mz2510.23991.pdf.txt, SHA256 e8cb21fb8279f7881a5cf5c53b87b09b215f0bb3c8466b8fbdfcd4517ee5fbce (121472 bytes). Source locations: Definition2.1 p.6; Theorem4.3/proof pp.12-14; Lemma4.4 p.15; Theorem4.6 and Lemma4.7 p.16; Lemma4.8 p.17 and final Lemma4.1 proof p.18. Formula references below refer to this version, not a later silent correction. Read the existing joint1ac0de5, independent53d54aa and manuscript reviewd705765 notes; their exact complement, distinct-Q covering, randomization-history and learning calculations are not repeated or reopened here.

## Additional discrepancies that matter

1. In4.8 the already-repaired bound is ||H||_2^2 <= 2^(-r(2 rho h-1)). At the printed cutoff |H|<=2^(-0.9r rho h), Markov gives failure at most 2^(-0.2r rho h+r), not 2^(-r rho h). With r=10m/rho this is 2^(-2mh+r). Comparing this only against S is insufficient: the inverse selection signal also contains beta and 2^(-2m rho h), and beta can be exponentially small. The printed last-term absorption cannot be inherited on that calculation.

2. Theorem4.6 requires a power-of-two norm exponent.4.8 invokes it at mt; even if t is a power of two, mt need not be. Rounding the moment upward is legitimate but its exponent must be tracked, as below. Also4.3's selected t=(m+1)/(rho-rho^2) is not generally a power of two; the replacement chooses one explicitly.

3. The4.3 random-linear-function argument refers to tuples with pairwise Li intersection Lj=R. For m>=3 this does not ensure the leaf functions, agreeing on R, glue to a common linear function. For example, modulo R let leaf increments be A, B and {(a,a):a in A} in A direct-sum A. They meet pairwise only at zero. Zero labels on the first two and a nonzero label on the diagonal agree on R but have no common extension. This is a counterexample to that proof step, not to the inverse theorem. Moreover, unconditional generic-position probability at least1/2 does not imply that half the accepting tuples are generic. An additive bad-tuple bound small relative to epsilon is needed.

4. Source4.3(1) prints codim(Q)+dim(W)=r. Definition2.1 actually uses dim(Q)+codim(W)=r; non-pseudorandomness supplies exactly the latter witness. The expectation paragraph also prints a1000rho exponent for the center density where its exact value is 2^(-2(1-rho)h). The replacement uses actual center dimension throughout. The rank comparison in4.4 additionally has reversed/mislabeled probability expressions; the previously accepted rank-event repair is retained, not those displayed lines verbatim.

## Fixed parameters and repaired analytic estimate

Use m>=1 an integer, 0<rho<=1/4000, r=10m/rho integral, and sufficiently large admissible integer h (in particular h>=r). Write

    c=2(1-rho)h, s=2rho h, d=c+s=2h,
    S=2^(-2(1-1000rho)hm),
    e=epsilon-prime=2^(-2(1-1000rho^2)h), b=s-1.

These are the paper's small-slack regime and its unchanged thresholds. Require e<=1/2. Retain the two existing ambient conditions

    (2h+2rho*m*h)*2^(2h-n) <= 1/2,
    b>=1, n>=2h+r*b+log2(6).

By4.7 and orthogonality these give ||H||_2^2<=2^(-r*b). Choose instead the cutoff eta=2^(-(2/3)r*rho*h). Then

    Pr[|H|>eta] <= 2^r * 2^(-(2/3)r*rho*h).

Since TF is in[0,1], split on this event, and on its complement use |L+H|^m<=2^(m-1)(|L|^m+|H|^m). This holds also at m=1. The high contribution is at most 2^(m-1)*eta^m, and eta^m<=eta. This avoids the invalid printed0.9-cutoff estimate.

Choose a power of two T>=max(4,4(m+3)/(m*rho)), and let P be the least power of two >=mT. These depend only on m,rho. Holder uses T against the center indicator. By probability-space norm monotonicity, ||F^{=i}||_(mT)<=||F^{=i}||_P. Theorem4.6 at P, for i<=r, gives the conservative bound

    ||L||_(mT)^m <= (r+1)^m * 2^(500*m*r^2*P)
                         * (2e)^(m-2m/P).

Here2e is the4.5 pseudorandomness parameter for the matrix lift. Because P>=mT, m-2m/P>=m-2/T. With e<=1/2, the right side is at most (r+1)^m*2^(500*m*r^2*P+m)*e^(m-2/T). No parameter involving n has appeared. The moment constant is deliberately loose.

Combining with the factor2 rank comparison, for an (r,e)-pseudorandom leaf set and a center set of Grassmann density beta, the true star density X satisfies

    X <= K * beta^(1-1/T) * e^(m-2/T) + D*2^(-(20/3)*m*h),
    K=2^(2m)*(r+1)^m*2^(500*m*r^2*P),
    D=2^m+2^(r+1).

The matrix center expectation is at most beta, which is sufficient for this upper bound. The error is weaker than the printed2^(-10mh) claim but strong enough for the inverse argument. This is not an assertion that the original stronger Lemma4.8 statement has now been proved.

## Corrected random-linear selection and its ambient condition

Draw the actual center and independent uniform leaves containing it. Call a tuple good when the m quotient increments Li/R are in joint direct sum. Its total span then has dimension c+ms, and arbitrary linear labels agreeing on R glue uniquely on that span.

For n>=d+1, expose each leaf's ordered basis modulo R, requiring independence only inside that leaf as in the actual uniform conditional law. At a step with j previously exposed increments, the forbidden global span has at most2^(c+j) vectors, while the permitted denominator is at least2^(n-1). A union bound over j=0,...,ms-1 gives

    q=Pr[tuple not good] < 2^(c+ms+1-n).

Require the extra lower ambient condition

    n >= c+ms+2+log2(1/S).                         (A)

Then q<=S/2<=epsilon/2 for every actual test density epsilon>=S. Thus good accepting tuples have mass at least epsilon/2. For a uniform global linear f, each such tuple has probability exactly2^(-(c+ms)) that all its labels equal f. Let X_f be the all-matching star density and beta_f the matching center density. Exactly E[beta_f]=2^(-c), while

    E[X_f] >= (epsilon/2)*2^(-(c+ms)).

Choose f by averaging X_f-(epsilon/4)*2^(-ms)*beta_f. For this f, writing beta=beta_f and X=X_f,

    X >= (epsilon/4)*2^(-ms)*beta
             + (epsilon/4)*2^(-(c+ms)),
    beta >= X >= (epsilon/4)*2^(-(c+ms)).          (B)

The inequality beta>=X uses normalization by all actual star tuples; there is no ambiguous normalization by a generic subset M. Because epsilon>=S,

    beta >= (1/4)*2^(-2(m+1)h).

The last inequality follows by substituting S,c,ms: the additional exponent (2(m-1)-2000m)rho*h is nonpositive. This corrects both the center-exponent typo and the unjustified generic-tuple conditioning.

## Explicit absorption and contradiction

Suppose the matching leaf set for this f were (r,e)-pseudorandom. The analytic bound applies. To absorb its additive error against half of the first term of(B), it suffices that

    D*2^(-(20/3)mh) <= (S^2/32)*2^(-(c+2ms)).    (C)

An explicit equivalent sufficient cutoff is

    [(8/3)m-2+(3996m+2)rho]*h >= log2(32D).

The coefficient is positive for every m>=1. This is the comparison against the complete inverse signal, not against S alone. Combining(B),(C) with the analytic upper bound yields

    1 <= 8K*2^(ms)*beta^(-1/T)*e^(m-2/T)/epsilon
      <= 8K*2^(2/T)
           *2^([2m*rho+2(m+3)/T-2000m(rho-rho^2)]h).

Let lambda=2000m(rho-rho^2)-2m*rho-2(m+3)/T. Our choice of T gives lambda >= m*rho*(2000(1-rho)-2.5)>0. Taking

    h > [log2(8K)+2/T]/lambda                    (D)

contradicts the preceding inequality. The matching leaf set is therefore not (r,e)-pseudorandom. By actual Definition2.1, some nonempty Zoom[Q,W] has dim(Q)+codim(W)=r and matching density >e. The chosen global f restricts to W and supplies agreement >epsilon-prime, hence also >=epsilon-prime. This derives the agreement needed by the paper rather than interpreting a source Omega(e) as an unspecified factor of1.

## Dependency conclusion and bounded repair recommendation

K,D,T,P,lambda depend only on fixed m,rho. The h cutoffs above depend only on those parameters. The ambient requirements are explicit lower bounds, including(A), and none imposes an upper bound on n or a relation loglog(n)=A*h^2. For fixed m,rho and large admissible h, n=2J with the manuscript's J satisfies them. In fact its existing n>=2h+r(2rho*h-1)+log2(6), for large h, already dominates(A): the former grows as (20m+2)h-r+O(1), whereas(A) has coefficient at most2m+2. Nevertheless(A) must be stated or derived in the inverse proof; two unrelated rank/spectral repairs alone do not repair its gluing step.

Consequently a separately reviewed insertion of this repaired inverse derivation preserves S, epsilon-prime, C=epsilon-prime/5, the robust input8S, the later lucky-mass count, and the A-before-h order. No enlarged J or new ambient-dependent decoder constant is indicated. The current paragraph should not merely assert the rest follows from the printed proof; it should provide the moment/Markov/gluing repairs or cite an exact corrected derivation.

This conclusion relies on the explicitly uniform statements of source4.5/4.6 and4.7 (including their cited bilinear/global-hypercontractivity ancestry), not a new proof of EKL or every MZ24 spectral lemma. It does close the inspected inverse proof's remaining parameter/slack calculations conditional on those precise analytic inputs. Complement transport, amplification, base PCP hardness, all other paper imports, complete Lean formalization and publication readiness remain outside this bounded audit. No theorem falsity or novelty claim is made.
