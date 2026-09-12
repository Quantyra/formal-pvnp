# Arbitrary-output bamboo: nonclaims and scientific readiness review

2026-09-12; S3109 / S008. Independent AI nonclaims/readiness lens.
This is a review of informal written mathematics, not human peer review,
Lean verification, a publication decision, or authorization to publish.

## Reviewed evidence and exact boundary

Read the full author note [arbitrary-output uniformity](2026-09-12-bamboo-output-uniformity.md),
SHA256 `CADA42936367F0F238BEE5EEEAB873BB9535EE463C1C8F5EA85D5A566170A7D9`,
and the complete actual-file [source/complexity review](2026-09-12-bamboo-output-source-review.md).
Also read INTEGRITY-CLAIMS.md and planning's S3109 story, dated output-uniformity
literature trigger, claim-boundary expansion protocol, and research publication
readiness protocol. Base repository HEAD at review is
`6cbcbd89e7a7320a4529c38158fb3731d34b23ce`; the new working files are separately
hash-pinned and must not be described as already contained in that commit.
This lens checks claim fit and readiness, not an additional independent
primary-PDF or full mathematical validity review.

The claimed output quantifier is every Boolean m-by-m matrix A, at exactly
q even >=1024, m=q^2, N=8q+4, D=floor(q/(32 log_2 q)), B=2D.
The row-space claim concerns the specified restricted prime local functional:
R_A(p^2)>=0 for Boolean-reduced real polynomials whose individual monomials
use at most B typed labels. It imposes neither an ordinary-degree bound nor
a bound on the total labels in p. This does not assert a globally supported
probability law on all labels; consistency is only used within the stated
local support window. The ordinary root-degree-D corollary is weaker.

The explicit SoS statement uses the original unrestricted simple-bamboo
clause-falsification encoding over R, Boolean equations, and the stated
optional twin convention. Matrix constraints and prefix parity are over F_2.
The refutation identity and charged measure are exactly

    sum_i f_i g_i + sum_j h_j^2 = -1,
    S=sum_i ||f_i|| ||g_i|| + sum_j ||h_j||
      >= (8/7)^((2D-1)/2).

Monomials are counted before Boolean reduction, roots before squaring,
and repeated occurrences separately. There is no certificate-degree limit
and no coefficient-bit charge. This is not an arithmetic-circuit or implicit
Gram representation bound. Its asymptotic exponent is Omega(N/log N), not
Omega(N); input size is polynomial in N under this encoding. Changing
auxiliary variables, the gate encoding, the proof system or its measure
would require a separate transfer argument.

For rank_F2(A)<=N the original encoding is satisfiable, so no sound real
SoS refutation exists: the size statement is vacuous on those outputs.
The local PSD theorem is still a substantive assertion about its particular
functional. For rank(A)>N the encoding is contradictory and the refutation
bound is nonvacuous. I_m supplies a concrete nonrange witness because
m=q^2>N. The author correctly distinguishes these cases; 'every output is
unsatisfiable' would be false and is not asserted.

## Conditional generator report remains separate

The source reviewer provides a conditional implication for G_q(X,Y)=XY
with seed s_q=2mN=16q^3+8q^2 and output t_q=m^2=q^4. Prefix variables
are existential encoding witnesses, not seed bits. Its polynomial stretch
is Theta(s_q^(4/3)), and the hardness conclusion uses exactly the specified
simple-bamboo real explicit-monomial SoS encoding and the assumed reviewed
all-output bound. The map's range is rank<=N; rank testing and preimage
factorization are polynomial-time operations. Thus this proof-complexity
terminology entails no computational pseudorandomness or inversion hardness.

This implication is explicitly separated from the author's theorem and is
not automatically adopted as a public generator claim by a positive review.
No arbitrary-m extension, all-seed-length padding convention, iteration,
amplification, source PCR-to-SoS transfer, nearly quadratic stretch, or
function-generator consequence is established. No SAT runtime lower bound,
circuit lower bound, general proof-system collapse, P=NP or P!=NP follows.
The repository integrity boundary remains binding.

## Scientific readiness recommendation for a future addendum

The substantive prospective increment is output uniformity at fixed parameters
relative to the identity-output v3 statement, with no improved exponent or
new restriction. It gives readers an explicit audit of output-dependent
fibers, normalization, supported conditional laws, local assembly and size
transfer, and explains the satisfiable/nonrange split. This is sufficient
to identify a potentially useful bounded addendum milestone. It is not
novelty or priority certification. The current comparison credits TR26-133
for arbitrary-output laws and restrictions, separates the prior identity
positivity/size argument, and leaves exhaustive novelty unresolved.

**Recommendation: REVISE for future public-addendum readiness preparation.**
This is not a PUBLISH/REVISE/HOLD decision by the publication owner and does
not request or authorize public changes now. No claim-language defect has
been identified in the author note. The remaining preparation is concrete:

- Freeze the eventual source and public candidate commits, retaining these
  exact reviewed working-file hashes and the dispositions of all reviews.
- Prepare the actual bounded extraction, compare it with the prior publication,
  and independently review that extraction rather than transferring verdicts.
- Record exact manuscript/README/release/CITATION/DOI/other affected metadata
  differences and a scoped claim-expansion packet if the approved public
  wording is broadened; retain all parameters and representation restrictions.
- Keep the conditional generator assessment separate unless an exact proposed
  implication and its public wording undergo their own applicable gate.
- Record informal AI authorship/review roles, source credits, unresolved
  novelty/priority and absence of human or Lean verification. Lean FQN,
  build and axiom-profile fields must be marked inapplicable to this written
  argument, not fabricated or presented as passed formal checks.
- Have the responsible owner record the exact candidate readiness decision
  and applicable authorization/approvals before publication execution.

A scoped encoding-specific SoS bound does not itself assert any of the
protocol's stronger circuit, P-versus-NP, general SAT or collapse claims.
This review neither waives an applicable claim-expansion gate nor invents
a new human approval requirement for the present internal review.

## Final evidence integration

**Final internal bounded nonclaims verdict: GO** for the exact author hash
above. No scope or wording revision is required by this lens. This is an
internal review verdict, not a claim-expansion approval packet or public
wording authorization.

I read both completed mathematical reviews in full, including their
separate checks of the generator implication. Each reports PASS for the
same author hash and the same source-report implication, with no repair
or unresolved blocking finding. Final source pins are:

| Record | SHA256 | Actual verdict |
|---|---|---|
| [Source/complexity](2026-09-12-bamboo-output-source-review.md) | `F95B9530A6ADBC50430003E8331691BD302F9347A17F3A052152B19936CE60F2` | GO; conditional implication separately delimited |
| [Mathematical proof](2026-09-12-bamboo-output-proof-review.md) | `9534EDF20A3922DE61997A1E053E9707DFBD1B472F579C72CF86364C64EB65F2` | PASS main theorem and implication under it |
| [Fresh adversarial mathematics](2026-09-12-bamboo-output-fresh-review.md) | `9E1AE507443B72D008D91FE86EEBCE858DDEA9E112E0963DECE84B83AF14BFC5` | PASS same theorem and conditional implication |

The scope audit and these actual-file findings support internal bounded
closeout of the arbitrary-output increment. The separate generator
implication has now passed both mathematical lenses; keeping its statement
conditional identifies its theorem dependence and does not represent a
remaining mathematical failure. It still requires its own exact public
claim assessment if later proposed for adoption. The future-addendum
readiness preparation recommendation above remains REVISE for the listed
candidate/extraction/metadata/decision steps, with no research defect found.
Frozen for integration.

Only this review record is owned and written by this reviewer. No author
repair, public edit, experiment, Lean work, commit, push, outreach or paid
computation was performed.
