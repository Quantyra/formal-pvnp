# Asymmetric seed: quantitative paired-clause progress and failed global invariant

2026-09-08. S3040 / S008 / E004. Harness-only informal research.
Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-asymmetric-seed-2026-09-08.md`.
Read with `INTEGRITY-CLAIMS.md` and the normalized-analog-SAT attempt.
No approved general SAT capability, implemented fluid device or P=NP result.

## Changed initialization and unchanged corrected flow

Keep the exact normalized clause-cycling system from the preceding note:

    s_i'=G_i=sum_m 2b_m c_mi K_m K_mi,
    b_m'=rho b_m(K_m+q_m-barH),
    rho'=-rho^2 barH,        barH=sum_m b_m(K_m+q_m),

where primes mean normalized time xi and q_m is the known unit-slot round-robin
schedule. Original analog-model time obeys dt/dxi=rho; it is not measured
device time. Initialize a_m=1, b_m=1/M, rho=1/M, but now take

    s_i(0)=i/[2(n+1)],       i=1,...,n.                    (1)

The O(n) rational seed coordinates require O(n log(n+1)) bits. Every gap is
at least d0=1/[2(n+1)], and all spins lie strictly between zero and1/2.
The seed uses only variable indices, not a satisfying assignment. An inverse-
polynomial coordinate gap does not establish distance from an arbitrary
formula's exceptional invariant sets.

The [original Ercsey-Ravasz--Toroczkai article](https://arxiv.org/html/1208.0526)
and the preceding independent source audit remain the source boundary:
the modified clause control does not inherit an all-input deterministic
convergence theorem, and almost-everywhere attraction cannot certify (1).
The prior normalization proof gives a_m>=1 and

    rho>=1/(M+2xi),        b_m=a_m rho>=rho,       |s_i'|<=1.    (2)

## Exact gap dynamics for complementary triples

For one block, let its clauses be all-positive and all-negative on three
variables. Write b_+,b_- for their GLOBAL normalized weights; other blocks
may contribute to the normalizer. For distinct indices i,j and remaining
block index k, direct polynomial factorization gives

    (s_i-s_j)'=A_ij(s_i-s_j),
    A_ij=[b_+(1-s_i)(1-s_j)(1-s_k)^2
          +b_-(1+s_i)(1+s_j)(1+s_k)^2]/32 >=0.           (3)

Thus the strict seed order persists and each gap is nondecreasing. This is
more than leaving the old equal-coordinate diagonal. Furthermore, for either
block clause m,

    A_ij >= (1/2)b_m K_m^2.                              (4)

For the positive term, divide K_+^2 by its corresponding factor in (3)
when the factor is nonzero: the ratio is
(1-s_i)(1-s_j)/2<=2. At zeros the same inequality follows directly without
division. The negative term is identical. This checks boundary cases too.

Let R_block=max(K_+,K_-). If R_block>=epsilon throughout [0,X], (2)--(4)
imply, for any one positive initial block gap d,

    log(d(X)/d(0)) >= (epsilon^2/2) integral_0^X rho
       >= (epsilon^2/4) log(1+2X/M).                    (5)

The maximizing clause may change; the estimate is pointwise and uses its
weight's common lower bound. It therefore holds with the actual cyclic
weights, not only a fixed-gradient surrogate.

## A growing family and a polynomial normalized-time hit bound

Take n=3r variables and a disjoint union of r complementary triples, so M=2r.
The formula size and the seed representation are polynomial in n. Set
epsilon=1/32 and

    H=(M/2)[(8(n+1))^4096-1].                            (6)

If any one block failed to reach R_block<1/32 by H, equation (5), its
initial gap at least d0, and (6) would force its gap to be at least4.
Every gap in the cube is at most2, a contradiction. Thus EVERY block has
its own strict hit by H. The exponent4096 is fixed, so H is polynomial
in n, albeit completely impractical. This bound applies to an infinite
growing family, including the formerly trapped two-clause example at n=3.

Different blocks need not hit at the same instant, and this proof does not
assert simultaneous globally small residuals. Add an explicit observer that
latches each independently verified block assignment once found. Because
blocks share no variables, their stored assignments combine consistently.
This requires O(n) bits of witness storage and r completion flags. It does
not modify the flow or provide a free consistency operation for overlapping
clauses. The observer is part of this restricted-family algorithm.

The usual sign-rounding certificate is strict K_m<1/8 for 3-clauses; use
the stronger detection threshold1/16. Since |partial_i K_m|<=1/2 and
|s_i'|<=1, each block residual changes at speed at most3/2 in xi.
Sampling every1/192 normalized time units ensures that the first sample
after a hit R_block<1/32 has R_block<5/128. It lies before H+1.
Approximate spins to sup error1/4096 and evaluate each residual to absolute
error1/4096, keeping a rigorous upper enclosure. Even allowing both sides
of this error interval, its upper endpoint is below1/16, since

    5/128 + 2[(3/2)/4096+1/4096] < 1/16.

Clip approximate spins to the cube (which does not increase their error).
The true and approximate residuals are therefore below the rounding threshold;
round the approximate block spins with a fixed tie convention and directly
verify its two Boolean clauses before latching. These finite checks provide
actual witnesses, not an inference from a floating-point trajectory.

This family is structurally easy and always satisfiable. The result is a
positive test of the specified flow and seed, not a replacement for solving
arbitrary signed overlapping 3-CNF.

## Polynomial bit work for this restricted-family computation

For completeness the finite-time numerical step is not left as a free oracle.
For 3-CNF, each normalized slot has a polynomial vector field of degree at
most6 with rational coefficients and a straight-line representation of size
polynomial in input length L. There are d=n+M+1 state coordinates. On the
complex polydisc where each coordinate has modulus at most2, use

    B=128(M+1)

as a componentwise vector-field bound: |K_m|<4, |K_mi|<2,
|G_i|<=32M, and the b,rho components are bounded by60(M+1).
These bounds follow by literal product estimates and also hold for all slot
choices q. The exact real path remains in the established compact cube/simplex.

On the complex 1/2 neighborhood of the exact invariant real state set,
a conservative row-sum derivative bound is Lips=4dB, by Cauchy on contained
coordinate discs and the triangle inequality. Start a local step at a
numerical point within 1/4 of the EXACT invariant real set. A complex Picard
argument gives its local solution an analytic time disc of radius at least

    Rtime=1/(16dB),

staying within a further 1/4 spatial neighborhood of that starting point,
hence inside the preceding complex 1/2 neighborhood. For example, the vector
bound controls displacement by B Rtime<=1/16 and the derivative bound
makes the integral operator contract by at most1/4. Its analytic solution
has component magnitude at most2. Thus Cauchy bounds its time-series
coefficients, giving a geometric Taylor remainder at any step at most
Rtime/4. Use the smaller rational step

    hstep=1/(12288dB).

Both integer control switches and the observer's1/192 grid are exact step
boundaries. A final shortened step is allowed. The number of steps to H+1
is polynomial in n. Approximate a step by Taylor coefficients computed by
substituting truncated univariate series into the polynomial straight-line
field and solving the coefficient recursion (division by the coefficient
index). This avoids enumerating high multivariate derivative tensors.

If Nstep is an upper bound on the number of steps and delta=1/4096, choose
each local truncation/rounding error at most

    eta=delta exp(-Lips(H+1))/(4(Nstep+1)).

A directly computable smaller dyadic tolerance is
2^(-14-2 ceil(Lips(H+1))-ceil(log2(Nstep+1))), using delta=2^-12
and e<4; the logarithm ceiling here is obtained from an integer bit length.

The standard one-step Lipschitz propagation inequality, iterated across the
known slot boundaries, then keeps global error below delta. This simultaneously
closes the numerical-neighborhood assumption used for the bounds. A Taylor
order and arithmetic bit precision polynomial in

    Lips(H+1) + log(Nstep+1) + log(1/delta) + log(dB+1)

suffice: the local analytic ratio is uniformly below1/4, and coefficient
magnitudes grow at most Rtime^(-order). Interval or directed-rounding
arithmetic allocates the stated local error among the polynomially many
truncated-series operations. More explicitly, the field has fixed degree and
a polynomial-size circuit, so recursion through order p uses polynomially
many scalar arithmetic operations. The analytic bound gives coefficient
magnitudes at most 2 Rtime^(-j) for j<=p; convolution bounds for the fixed-
degree products bound their intermediate coefficients by exp(poly(p,log(dB+1),L)).
Sums and products in that polynomial-length arithmetic calculation therefore
have forward-error amplification with polynomial logarithm, once tentative
errors are kept below1. The only divisions in the coefficient recursion are
by positive integer indices and fixed nonzero rational denominators, not
unknown small state coordinates. Polynomially many additional guard bits
thus bound total local rounding by eta. This explicitly budgets intermediate
precision, rather than inferring it from the final coefficient sizes alone.
Naive series multiplication is already polynomial in the order; all rational
divisions have polynomial bit overhead.

Every displayed quantity is polynomial in L for this family, with a very
large fixed degree. This is a conditional-on-the-derived-ODE-mathematics
uniform bit-work argument, not a practical numerical implementation or a
blanket application of BGP to variable-dimensional controlled systems.
The proof does not extend the horizon H to arbitrary overlapping formulas.

## One attempted universal invariant and its exact obstruction

The attempted extension was: this asymmetric seed makes positive coordinate
gaps nondecreasing under signed3CNF, allowing the gap-versus-residual argument
to charge all unresolved clauses to increasing separation. That invariant is
false with the ACTUAL seed and corrected flow, even on a satisfiable formula
with no pure variable:

    C1=( x1 OR NOT x2 OR x3),
    C2=(NOT x1 OR x2 OR x3),
    C3=( x1 OR NOT x2 OR NOT x3),
    C4=(NOT x1 OR NOT x2 OR NOT x3).                       (7)

The Boolean assignment (true,true,false) satisfies all four clauses. The
initial rounded all-true assignment does not satisfy C4, so an immediate
successful rounding does not remove this test from the candidate's run.
At the prescribed seed (1/8,1/4,3/8), with b_m=1/4, direct rational evaluation
gives

    (K1,K2,K3,K4)=(175,135,385,495)/2048,
    (G1,G2,G3)=(-925/262144,-19675/524288,-6495/262144),
    (s2-s1)'=G2-G1=-17825/524288<0.                      (8)

The first boost affects auxiliary derivatives, not these instantaneous spin
velocities. Thus (8) also tests the corrected rule's actual first slot.
A small exact Fraction calculation checked these substitutions; no numerical
integration was run and no regression program was added. The formulas can
also be checked directly by multiplying the three rational literal factors.

This disproves the proposed universal monotone-gap invariant. It does NOT
prove that the asymmetric algorithm fails on (7), never terminates, or
requires superpolynomial work: a different progress measure could succeed.
The favorable factorization (3) depended on the complementary block structure;
the signed overlapping terms can instead shrink gaps. Merely retaining the
initial inverse-polynomial separations does not restore that proof.

## Remaining all-input obligation

For arbitrary formulas the seed and normalized evolution are specified, but
there is no proved universal success horizon. Therefore failure to obtain a
verified witness by the restricted bound H is not a valid UNSAT decision.
A proved polynomial success bound for EVERY satisfiable input, together with
uniform effective simulation and a certified detector, would justify NO at
its deadline on the remaining inputs; a separate refutation system would not
be mandatory. That universal bound is precisely absent here.

The disjoint-block observer also cannot combine arbitrary overlapping local
witnesses: shared variables must agree. The full P=NP task still requires an
all-input invariant or another decision mechanism, and its uniform bit-work
proof. This increment supplies positive growing-family dynamics and a bounded
simulation argument while locating an exact failure in the attempted global
extension. It claims neither P=NP nor P!=NP.
