# Exact sampler proximity parameter specialization

Status: UNCOMPILED source draft. No author compiler, independent export, axiom
profile result, three-lens acceptance, or full hardness certification is claimed.

Route: S3126, S3134 and S3137. Source-directed parameter-extension work follows
the existing frontier note and submission-manuscript lines 304--383. Destination
is the active Lean companion in formal-pvnp. The prescribed sampler dependency
is SamplerParameters, author freeze 21e4863 and independently exported in session
54032. No accepted source, configuration, aggregate, or paper was changed.

## Exact scope

The final `eventual_proximity` fixes a positive natural A and a natural r before
choosing one threshold N. Every later natural h and every a,c bounded by r uses
the exact `blocks A h = 2^(2^(A*h^2))` and actual rational `beta A h`.
The target conjunction includes:

- r+1 <= J and 2h <= J;
- sqrt(beta)*J^(1/4) <= decay 100 h;
- sqrt(beta)*J^(1/4)*2^(2h+5) <= decay 100 h;
- 2^(2h)*beta <= 1/8;
- beta*sqrt(J)*2^(a+4) <= decay 100 h;
- 8*2^(2*a*h^4)*(2^c-1)*beta <= decay 30 h;
- zoom+3*advice+decay 70 h < decay 20 h.

The rpow exponent is the real rational 1/4, all sampler casts are explicit,
and `decay` is the previously accepted natural-power interface. No growth,
smallness, or Ready premise occurs in the final eventual theorem.

## Derivation and source inspection

The reusable `eventual_inner_domination` applies mathlib's
`tendsto_pow_const_div_const_pow_of_one_lt` to h^4/2^h and uses h<=A*h^2.
It proves C*h^4 <= the actual inner exponent for each positive real C.
`eventually_ready` discharges an explicit generous polynomial exponent budget.
The pointwise beta bound uses the elementary numerator<=2^numerator inequality.
Monotonicity and addition/multiplication laws for real powers then supply the
advice, zoom and density estimates. Exceptional-set arithmetic uses
decay 100<=decay 70 and decay 70=decay 20*decay 50, with decay 50<=1/8 for h>=1.

The relevant power and exponential-limit API declarations were inspected in
the pinned mathlib source. Source inspection is not kernel verification.
The Checks file has 21 planned axiom queries and seven example declarations,
covering zero-A and zero-h boundaries, a nonvacuous A=1 eventual instance,
maximal permitted a=c=r, and strict exceptional-set arithmetic. All are UNRUN.

## Remaining boundary

All listed targets have source scripts, but elaboration and kernel checking
remain outstanding. The scripts may need API, cast, or tactic repairs. They
do not prove KMS conditioning, PCP or decoding theorems, the list-counting
argument, choice of A from source constants, arithmetic subsequences for h,
fixed-L asymptotics, reduction runtime, the full randomized hardness theorem,
or the learning transfer. No novelty or publication claim follows.

## Source hashes

- SamplerProximity.lean SHA256:
  `62579c479003666a87e7d23e27398f849023a80ecdb640f0d157e712bbe1dbd3`
- SamplerProximityChecks.lean SHA256:
  `ed429ccc1b44b48d8f359b7ab015451f9c573417e710b044c9ea781a05aaf6b8`

No compiler or Git operation was performed by this source author. Exact-three
draft preservation and scoped compilation await root grants.
