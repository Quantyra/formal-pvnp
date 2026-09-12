# S3104 public size-note mathematical extraction review

2026-09-12. Reviewer: `bamboo_size_fresh`. **PASS** for the actual public
SIZE-NOTE.md mathematical extraction on branch
`candidate/v3-bamboo-size-2026-09-12` of Quantyra/weak-rank-positivity-window.

Reviewed SIZE-NOTE.md SHA256:
`6d22e0f1d72fb5fc2dc5446ca56da4c820ea5e24bb33809c8bb2335917c93667`.
Source derivation pin:
`ea7a89576712fc21ae0127d688f703dfa05b1af1`,
[S3103 source](2026-09-12-bamboo-size-mechanism.md).
This review read the entire actual SIZE-NOTE.md, the entire linked
FULL-NOTE.md, README.md, CITATION.cff, and SOURCES.md. It did not transfer
the earlier source PASS without reading the extraction.

## Complete clause table and exact model

The newly explicit table matches primary source Definition 6.1. For output
1, the falsifier is 1-u; for output 0, it is u. The three base clauses
`b or not x or not y`, `x or not b`, and `y or not b` give exactly
`(1-b)xy`, `(1-x)b`, and `(1-y)b`.

For transitions, the clauses `x or not a or b` and
`x or a or not b` give the first pair of displayed falsifiers, and
the analogous y clauses give the second pair. The clauses
`not x or not y or not a or not b` and
`not x or not y or a or b` give `xyab` and `xy(1-a)(1-b)`.
When xy=0 these enforce b=a; when xy=1 the final pair forbids a=b.
Thus all six encode exactly the Boolean parity gate. Every clause uses
at most X_i and Y_j, and no product-extension variables have been added.
The Boolean and optional twin equations are explicitly included.

The stated model remains unrestricted simple bamboo at original width
N=8q+4 and m=q^2. Restriction produces the specified boundary-augmented
residual law at width q, keeping m fixed. Even q gives source divisibility
by 16 of N-4, and q>=1024 gives m>N and availability of all bounds.
There is no illicit original m=N^2 assertion or transfer to another rank
encoding.

## Complete-row import and the new bridge

FULL-NOTE.md genuinely contains the conditional estimates imported by
SIZE-NOTE.md: equations (1)--(15) end with the supported-separator bound
`epsilon=2^(-q/2+4D+5)` for arbitrary complete-row L2 functions.
The rank exclusions, prescribed cross outputs, centered actual marginals,
probability normalizations, and mixed-block conditioning are retained.
No ordinary-degree hypothesis is needed for that operator statement.

The extraction explicitly proves the stronger row-space consequence.
Finite-dimensional local hierarchical complements decompose each
B-label monomial function; local almost-sure identities lift to every
pair union. Nested pairings vanish. Incomparable pairings are bounded
after centering on the intersection. Counting all supports controls
arbitrary sums with arbitrary real coefficients. FULL-NOTE equation (23)
is the correct numerical source for the displayed all-support bound.
Its n is consistently replaced by residual q. The old ordinary-degree
theorem alone is never treated as the stronger row-space theorem.

The linked FULL-NOTE is unchanged from v2.1.0, as are COROLLARY.md,
NOTE.md, and LICENSE: the Git diff for those four files is empty.
Their historical scope is explicitly explained by README/SOURCES rather
than silently rewritten. The links and renumbered mathematical contract
therefore support the extraction's actual dependency.

## Restriction and certificate contradiction

The extraction preserves the exact corrected D/E templates verified
visually against the primary PDF printed page 72 in this reviewer's source
audit, including both first rows. Its template entries were compared
again to that verified source during this extraction read. Endpoints,
gamma values, parity offsets, complements, and boundary-prefix images
also agree with the source pin and primary Definition 6.8.

Size is precisely `sum ||f_i|| ||g_i|| + sum ||h_j||`, before Boolean
reduction and with explicit square roots. The number of original
multiplier/root monomial occurrences is at most this size. Endpoint
stripping invokes the valid interior-subterm survival bound. Killing
every occurrence with at least B-1 interior labels has positive probability
under the stated strict small-size hypothesis. Surviving terms use at
most B-2 labels, leaving room for the clause's two labels.

Literal substitution is a ring homomorphism, so whole root squares stay
squares. Arbitrary signs, cancellations, powers, and affine complement
expansion do not enlarge row support. The argument counts original
occurrences, not expanded squares or restricted-certificate size, and
discloses the potentially huge expansion and local spaces.

Every substituted clause vanishes on the residual local law for its
labels by the source's semantic endpoint, within-block, and block-boundary
checks. This is sufficient for pointwise annihilation in the union law
with a surviving multiplier. It does not assume that the source's SA
derivation is an arbitrary-sign equality-ideal simulation. Boolean/twin
images vanish in the quotient. Axiom products and root squares all remain
inside R's row-domain. Thus applying R yields zero plus nonnegative
numbers equal to -1, proving the exact bound.

## Public scope and final verdict

README and CFF reproduce the same parameters, monomial-size convention,
and bound. SOURCES credits the primary restriction and distinguishes it
from the new complete-row square-positivity bridge. The comparison to
existing exponential SA size and the distinct perfect-matching SoS result
does not import either conclusion into this theorem.

The exponent is Omega(N/log N), not Omega(N). The clause and variable
counts are O(N^5); including usual variable-name bit encoding adds only
a logarithmic factor, which preserves the claimed superpolynomial
comparison to explicit input length. No circuit-compressed-root, arbitrary
proof-system, general SAT, circuit, or P-versus-NP consequence follows.
The public scope statements respect those boundaries and state that
novelty/priority are unknown.

**Final actual-hash verdict: PASS** for SIZE-NOTE.md at the hash above and
the mathematical scope of the inspected accompanying metadata. No
mathematical or extraction repair is requested. This is informal
AI-agent verification, not machine verification or human peer review.
The reviewer supplied verification only, made no public-repository edit,
and performed no commit, push, release, outreach, or paid computation.
Only this review file was written in the domain source repository.
