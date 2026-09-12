# Dimension-budget extension: source and complexity review

2026-09-12; S3113 / S008. Reviewer `output_fresh_proof` acting as the
source/implication lens, separate from the mathematical proof reviewer.
[Integrity boundary](../../INTEGRITY-CLAIMS.md).

The proposed dimension budget is compatible with the imported source
interfaces. Its explicit indexed family has nearly quadratic output
length and a superpolynomial explicit SoS threshold in the actual CNF
description length, conditional on the dimension-budget theorem.
The frozen author file was read in full; the exact-hash verdict below is
PASS for this source/implication lens. This assessment does not replace
the independent mathematical review of the complete positivity argument.

## Source interfaces and required domain

The primary source is [Garlik--Gryaznov--Ren--Tzameret, TR26-133](https://eccc.weizmann.ac.il/report/2026/133/),
Definition 4.3, Definitions 6.1, 6.5--6.8, Lemmas 6.7, 6.9--6.10 and
Theorem 6.11. The cached primary text was inspected again for these
quantifiers, the measure and the comparison results.

The augmented local-law definitions and consistency lemma do not impose
m=q^2. They allow arbitrary m>q at residual width q. Their local support
is at most q-2 typed labels, with separate augmented frame independence,
oddness, prescribed outputs and actual prefix evaluation retained.
The all-A extension counts depend on the selected local pairing matrix,
not on the number of unused labels m.

For the random substitution at original width N=8q+4, the source needs
m>N>=20 and divisibility of N-4 by 16. Even q>=1024 satisfies the latter
two conditions. The substitution preserves m and A and reduces width to
q; it does not require m to be a polynomial in either width. Lemma 6.9's
interior-row survival probability and Lemma 6.10's local clause-image
check likewise have arbitrary-m and arbitrary-output quantifiers.

Consequently the imported restriction is applicable for m>N. For a
generator corollary, stretch is an additional condition m>2N, since
t/s=m/(2N). A size theorem for all m>N must not silently assert generator
stretch throughout that entire interval.

For the proposed D=floor(q/(32 log_2(2m))), the useful domain should ensure
D>=1, equivalently log_2(2m)<=q/32. If a version permits D=0, its theorem
and survival threshold require separate treatment and provide no growing
size conclusion. The explicit family below satisfies D>=1 comfortably.

## Where m enters the positivity budget

The inherited opposite-block character estimates, rank-exclusion counts,
same-side Schur bound and mixed conditional-covariance reduction depend
on q and the total local support. They do not count all m labels.
For total support at most 4D, the proposed inherited estimate is

    epsilon = 2^(-q/2+4D+5).

The all-context assembly is the step that must be changed explicitly:

    L_ctx = sum_(j<=2D) binom(2m,j)
          <= 2(2m)^(2D),
    log_2 L_ctx <= 1+2D log_2(2m) <= 1+q/16.

Also 4D<=q/8 under the stated domain, so the conservative combined bound is

    L_ctx epsilon <= 2^(6-5q/16) < 1/2.

This arithmetic accounts for all contexts at the actual larger m. It
does not retain the old m=q^2 context count. The degree-free row-space
argument and source substitution then have the intended interface if
the author's full proof verifies this extension. The independent proof
lens remains responsible for the complete analytic theorem.

## Exact indexed family and integer checks

For each integer r>=32 put

    q=2r^3, m=2^r, N=8q+4=16r^3+4,
    log_2(2m)=r+1,
    D=floor(r^3/(16(r+1))).

Here q is even and at least 65,536; 16 divides N-4. The base value
2^32>32*32^3+8 proves m>2N at r=32. This inequality persists as r
increases: 32(r+1)^3+8 grows by a factor less than two for r>=32,
whereas 2^r doubles. Thus m>2N>N>q, all source hypotheses hold, and
the output stretches the seed.

The D>=1 domain follows from r+1<=r^3/16. More quantitatively,
r+1<=2r gives D>=r^2/32-1>=r^2/64 for r>=32, while D<=r^2/16.
Therefore D=Theta(r^2). These are integer parameters; r need not be
even. In this subfamily computing D uses exact integer division and
does not require numerical approximation to a logarithm.

The unchanged map is binary matrix multiplication:

    G_r(X,Y)=XY,
    s_r=2mN=2^(r+1)(16r^3+4),
    t_r=m^2=2^(2r).

Prefix U variables remain uniquely determined inversion witnesses, not
seed or output bits. Augmented boundaries and oddness belong only to
the residual proof, not to the unrestricted map's inputs.

Since s_r=Theta(2^r r^3), log_2 s_r=Theta(r). Exactly

    t_r = s_r^2/(4N^2),

and hence

    t_r = Theta(s_r^2/(log s_r)^6) = s_r^(2-o(1)).

This is a nearly quadratic output-length statement. The expansion ratio
is instead t_r/s_r=Theta(s_r/(log s_r)^6). It is not quadratic output
without a loss factor, exponential stretch, iteration, or an all-length
padding construction.

## Actual formula length, hardness scale and uniformity

The original encoding remains the unaugmented simple-bamboo
clause-falsification system over R, with Boolean equations and optional
literal twins. It has 2mN+m^2N variables and (6N-2)m^2 CNF clauses
before twins/Boolean equations. Width is at most four, and each clause
axiom has constant many ordinary monomials. No extra product-variable
encoding or circuit-compressed root representation is introduced.

For the displayed r family, the variable/clause count is Theta(4^r r^3).
A usual explicit binary variable-index encoding has bit length

    L_r = Theta(m^2 N log(m^2 N)) = Theta(4^r r^4).

An upper bound O(4^r r^4), together with the explicit output length,
already suffices for log L_r=Theta(r). This is not polynomial in q;
the previous m=q^2 input-size estimate must not be reused here.

The proposed exact threshold is

    K_r=(8/7)^((2D-1)/2)=exp(Theta(r^2)).

Thus a theorem S>=K_r implies superpolynomial lower bounds in seed
length, output length and actual CNF bit length:

    S >= exp(Omega((log s_r)^2)),
    S >= exp(Omega((log t_r)^2)),
    S >= exp(Omega((log L_r)^2)).

The proved threshold is at a quasipolynomial scale in those lengths;
this is not an upper bound on refutation size. It is not an exponential
lower bound in L_r or the former exp(Omega(N/log N)) at this enlarged m.
The relevant dimension-dependent exponent is q/log(2m)=Theta(r^2).

The map uses m^2 binary dot products and O(m^2N)=O(4^r r^3) Boolean
operations. Indexed loops construct its formula in time polynomial in
the explicit seed/output/formula lengths. Including index arithmetic
adds polynomial, and here only logarithmic-factor, overhead. This is
an explicitly indexed polynomial-time family at seed lengths s_r.
It does not claim polynomial total enumeration time in the short index
r alone: the output already has 4^r bits. Nor does it require efficient
evaluation of the proof's potentially enormous local L2 spaces.

The original certificate size counts explicit root/multiplier monomials
before squares and Boolean reduction, with no degree or coefficient-bit
charge. The source has 6m independent restriction bits. Counting original
monomial occurrences for the union bound is unaffected by the larger m;
there is no need for a small expanded restricted certificate.

## Range, comparisons and claim boundary

The map's range is exactly matrices with F_2 rank at most N. Forward
rank submultiplicativity and zero-padded rank factorization give both
directions. Every nonrange output therefore has contradictory inversion
CNF and receives the proposed lower bound. In-range cases have no sound
real SoS refutation, so all-output hardness is vacuous there. I_m is an
explicit nonrange output because m>N. Rank testing and preimage recovery
remain polynomial-time in their actual matrix representations.

The primary source already has arbitrary-m SA size bounds for this
simple-bamboo encoding (Theorem 6.11), and arbitrary-m exponential SoS
bounds for the different perfect-matching encoding (Theorem 5.18 /
Theorem 2.3). Its PCR bamboo and iteration results use their stated
systems and representations. Nearly quadratic output lengths for rank
maps are therefore not a newly invented generator geometry or a first
general SoS-generator claim.

The proposed contribution is the larger-m quantitative window of the
existing complete-row positivity argument and its consequence for this
exact explicit real simple-bamboo encoding. It uses the same map and
credited restriction, not a successful coupling or repair of the failed
S3111/S3112 iteration samplers. No new general lower-bound mechanism,
novelty/priority certification, other-encoding transfer, computational
pseudorandomness, SAT runtime bound, circuit lower bound or P-versus-NP
conclusion is justified by it.

## Actual-artifact review and verdict

**PASS (source/implication lens).** Reviewed the complete actual
[dimension-budget proof](2026-09-12-bamboo-dimension-budget.md), 29,436 bytes,
at SHA256
`DA37598D495EFC1DA7302FBC664F74B45302A8F6EC12A3DE423B9AB1107F5676`.
This verdict is specific to that file and these source, parameter,
encoding, uniformity and complexity obligations. It is not a substitute
for the separate full mathematical lens or a public-extraction review.

The actual artifact explicitly restates the local proof and charges all
contexts at general m. Its domain is m>N with log_2(2m)<=q/32 and even
q>=1024. It treats D=0 separately rather than invoking the nontrivial
B>=2 restriction proof there. Source arbitrary-m and arbitrary-A
interfaces match its use. No concealed m=q^2 assumption was found in
these imported interfaces or the displayed aggregate-error budget.

The stronger floor arithmetic in the actual corollary is also valid:
for r>=32, r^3/(16(r+1))-1>=r^2/32, hence D-1/2>=r^2/64.
Its general bound D-1/2>=q/(128 log_2(2m)) follows from floor(x)>=x/2
for x>=1 and floor(x)-1/2>=floor(x)/2. The stated sufficient condition
q/(log m)^2 tending to infinity for superpolynomial hardness in actual
CNF length is justified; the author correctly does not assert this
throughout the entire nonzero-D window.

The indexed corollary separately proves m>2N, exact seed and output
counts, near-quadratic output with the sixth logarithmic power, actual
CNF construction cost, and its nonrange interpretation. Its formula
length upper bound together with the output-count lower bound suffices
for log L=Theta(r). The monomial-size lower bound therefore is
superpolynomial in L, with the precise representation and size convention
preserved. The final contribution language does not assert a first
rank-map generator, optimal dimension window or new amplification
mechanism. The primary-source comparison above limits its significance
to the stated simple-bamboo real SoS certificate measure.

No blocking source or complexity defect remains in the frozen file.
The actual author proof needed no repair from this lens; earlier source
guidance about m>2N, D>=1 and actual input length is reflected explicitly
in its completed text. Only this source review file was written; no
author or public changes, commits or pushes were made. Review remains
informal AI analysis, with no human-review, Lean or novelty certification.
