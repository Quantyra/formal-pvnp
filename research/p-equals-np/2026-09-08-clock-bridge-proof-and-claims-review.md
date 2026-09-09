# Clock bridge: proof and nonclaims review

2026-09-08. S3040 / S008 / E004. Baseline `445fbf7`.
Harness only. One independent reviewer covers both lenses in separate sections;
these are not two independently staffed reviews. The separate complexity
reviewer audits the BGP source and its application. No formal modules or
builds, code, tests, commits, planning changes, or publication are involved.

Reviewed the stable `2026-09-08-clock-trajectory-bridge-attempt.md` against the
packet gate assumptions and the existing claim boundary. The conclusions below
concern the elementary written derivations and their wording. They do not
independently certify a source PDE or formalize a new complexity theorem.

## Proof-adversarial lens: GO for the declared conditional derivations

**Alternation and robustness.** Oppositely signed readings with margin g differ
by at least 2g. Applying the K-Lipschitz inequality to each consecutive sampled
pair and summing gives K Len(X)>=2gJ. The argument uses a partition of the actual
path and does not assume each gate consumes length. For open norm balls of
radius rho, centers at distance less than 2rho have an overlapping midpoint
neighborhood; conflicting required labels are impossible there. Hence the
norm-ball version has the stated 2rho spacing. This requires full-ball
robustness and cannot be inferred from structured disturbances alone.

**Moving decoder.** At each adjacent pair insert the decoder at the later time
evaluated on the earlier state. The spatial term is bounded by K times that
state displacement; the remaining term is bounded by the stated common-domain
temporal variation. Summing proves (2). The common comparison domain and a
uniform spatial constant are necessary and explicitly present. For a decoder
parameterized by z(t), the same insertion yields (3) with Len(z). An infinite
V_time gives no finite conclusion and is not hidden. Reparameterization by an
increasing continuous bijection maps partitions in both directions, proving
exact length invariance on the finite interval.

**Actual program trace.** In the specified non-early-terminating binary
enumerator, the least significant assignment bit alternates between every
pair of consecutive completed assignments. This gives J=2^n-1, independently
of staging/HOLD slots. The final persistent SAT flag is not used. The
exponential-over-polynomial conclusion requires short inputs with growing n;
the note explicitly restricts that comparison to L=O(n log n) families rather
than all padded inputs. An input-dependent decoder is allowed only with
uniform K and margin bounds. Comparison amplitudes are not automatically
declared physical state coordinates.

**Packet sensor and normalization.** The packet invariant gives noise-free
reading error at most 1/16+1/64=5/64 relative to its Boolean sign, leaving
margin 59/64; 7/8 is conservative. For equal profile norm sqrt(D), inserting
<c',p> in the numerator yields

    |A(c,p)-A(c',p')|
      <= (||c-c'||_2 + C||p-p'||_2)/sqrt(D).

Cauchy--Schwarz on the two components gives the displayed pair-norm constant.
No convex-domain assumption is used. Positive D is fixed along each transported
incompressible packet; a different initialization scale for each input is a
different member of the family, not decreasing material volume along one run.
The note correctly does not deduce finite L2 error from a whole-space uniform
error bound. Moving p must either be a state component or incur the temporal
decoder term.

**Exact-mode check.** Under the stated L2 absolute-continuity and constant-D
hypotheses, differentiation gives <p,p'>=0 almost everywhere. Thus for c=ap,
the cross term in ||a'p+ap'||_2^2 vanishes. Integrating implies
Len(c)>=sqrt(D) Var(a). The sampled amplitudes have opposite signs with
magnitude at least 15/16, giving the stated coefficient in (6). This exact
subclass does not cover every perturbed field. Comparing it to a complete
computational trajectory needs the declared norm-domination constant.

**Shrinking encodings.** Polynomial length together with (6) requires
sqrt(D)<=poly(L)/2^n. For fixed p, the L2 measurement operator has norm exactly
1/sqrt(D), since equality is attained in the p direction. Thus the sensitivity
tradeoff is valid. It gives no exponential bit-precision or bit-time lower
bound; the draft explicitly preserves that distinction. Likewise sup-norm
operator scale Q and L2 scale D^(-1/2) are not interchangeable.

**Ideal polynomial clock.** Solving the displayed system gives
y=(1-t)^(-1/q), s=q(y-1), with tau=1-t. Up to any finite cutoff,
max(|tau'|,|y'|,|s'|)=y^(q+1), so integration gives full infinity-norm length
M when s=M. Without s, the y coordinate alone contributes M/q and the sum
of coordinate variations gives the upper bound 1+M/q. The fixed-q and
finite-cutoff hypotheses are explicit. This solution blows up at t=1, so the
note correctly withholds a global-ODE characterization claim. A different
compactification or cutoff would need a new analysis.

No blocking mathematical defect was found in these derivations. Finite
arithmetic tests would not establish the uniform geometric conclusions and
were not substituted for these checks.

## Nonclaims lens: GO-WITH-NOTES for bounded exploratory use

The result is a conditional trajectory/decoder tradeoff for a faithful trace
of the current exhaustive counter program. It is not a blanket lower bound
on fluid computers, Navier-Stokes dynamics, arbitrary encodings, or SAT.

Complete-state accounting includes the evolving interpretation/control
variables when invoked; forcing generation is not silently free. The note
does not assert that L2 scalar-field length is source kinetic energy or that
bounded kinetic energy certifies low simulation cost. It does not mistake
exponentially small scales for exponentially many description bits.

The BGP target remains a requested uniform translation with its full hypotheses,
not an achieved embedding. Infinite-dimensional fields, moving integral
sensors, external switching, incomplete effective source data, and the
nonglobal ideal clock are disclosed. A family of variable-dimensional systems
is not silently treated as one fixed system, and coordinate-dependent norm
rescaling requires separate bounds.

Safe summary: traversing all the existing binary counter states cannot have
polynomial length under a uniformly polynomial-sensitive decoder with
inverse-polynomial signed margin; the chosen ideal clock lift independently
has length linear in its ticks. Neither fact rules out endpoint compression,
another fully analyzed encoding, or P=NP. Preserve these qualifiers in the
closeout. No stronger claim or full-goal completion is approved.
