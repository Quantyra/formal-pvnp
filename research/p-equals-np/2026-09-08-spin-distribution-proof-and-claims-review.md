# Spin distribution: proof and nonclaims review

2026-09-08. S3040 / S008 / E004. Baseline `92ca457`.
Harness only. One independent reviewer covers the two separately reported
lenses; these are not two separately staffed reviews. No code, experiments,
formal modules/builds, commits, planning edits or publication are involved.

Reviewed stable `2026-09-08-spin-distribution-attempt.md`. The review verifies
its finite-distribution construction and conditional reduction, not an
implementation of inference or a claim about the earlier spin ODE.

## Proof-adversarial lens: GO for the construction and one-way reduction

**Trivial cases and weights.** Empty clauses and conjunctions, and n=0, are
handled directly before invoking q or the branch argument. For n,M>=1,
q=2^(-2n) lies strictly between zero and one. Every weight is positive and
has the stated polynomial-bit rational representation. Evaluating one
assignment's violated-clause count is polynomial; compact specification of
all weights does not evaluate their sum. Occurring-variable relabeling and
duplicate-clause counting are consistent with these bounds.

**Convex objective.** Substituting log pi=-beta V_F-log Z gives (2) exactly.
For p with zero coordinates, the stated 0 log 0 convention is valid because
pi is strictly positive. Applying the logarithm inequality on the support
of p gives relative entropy at least 1-sum_support pi>=0. Equality requires
full pi support and equality of the coordinate ratios, hence p=pi. The
entropy is strictly convex on the finite simplex, confirming uniqueness.
This is a 2^n-coordinate optimization, not a polynomial-dimensional one.

**Gap and representation.** A satisfying assignment contributes one to Z.
For UNSAT, each of the 2^n terms is at most q, giving Z<=2^-n<=1/2.
Additive error 1/8 leaves the claimed separation about threshold 3/4.
The common denominator 2^(2nM) and numerator sum bound give at most
2nM+n+1 numerator bits, even for unrestricted partitions. This polynomial
output length is not confused with polynomial computation of the numerator.

Every prefix has at least one completion with positive weight, including
prefixes without satisfying completions. Thus every conditional denominator
is positive. The penalty q remains that of the original n. Removing a common
factor from already false clauses is legitimate for ratios only; it must
not alter an absolute partition value used in the SAT gap.

**Robust deterministic readout.** If the approximate probability is at least
one half, selecting one has true probability at least 3/8. Otherwise choosing
zero has true probability greater than 3/8. Ties are therefore safe under
the stated convention. The chain rule multiplies the selected conditional
probabilities of the original fixed distribution, even for adaptive error
choices, giving leaf mass at least (3/8)^n>(1/4)^n=q for every n>=1.
On a SAT input a nonsatisfying leaf has mass at most q because Z>=1. Hence
the returned leaf must satisfy F. On UNSAT, exact final verification must
fail and the algorithm correctly returns NO, provided the oracle terminates
under its stated total contract.

The alternative prefix argument also checks: a prefix with a satisfying
completion has good weight at least one and total bad weight at most
2^n q<=1/2. Its conditional bad probability is therefore at most 1/3,
strictly below a selected branch's 3/8. This handles n=1 without replacing
normalized bad probability by a weaker unnormalized bound.

**Contract and costs.** Nearby grid outputs exist with the required error,
but their computation is not assumed accomplished. The reduction works for
every admissible answer; a total deterministic polynomial-time implementation
would make the n adaptive calls and all exact comparisons/verification
polynomial in original input length. The original formula, q and prefixes
have polynomial-length query representations. A SAT-promise-only procedure
or one that may not terminate on a bad prefix would not meet this contract.

**Partition approximation versus conditionals.** For a=Z(u1), z=Z(u)>0,
approximations with both absolute errors at most delta<=z/2 satisfy

    |a_hat/z_hat-a/z|
       <= delta(z+a)/(z(z-delta)) <= 4delta/z.

There is no unproved division by a nearly zero estimated denominator:
z_hat>=z/2. Every prefix has z>=q^M, so delta<=q^M/32 suffices for error
at most 1/8. These precision bits are polynomial in nM. If z is assembled
from two approximate child sums, their component budgets must ensure the
stated error on z; no independent child-error convention is substituted
for the displayed hypothesis. The final optional-grid addition is also
valid: delta<=q^M/64 gives ratio error at most 1/16, clipping to [0,1]
cannot increase error, and nearest j/16 rounding adds at most 1/32.
The total 3/32 remains strictly below 1/8. Computing those sums efficiently remains
unresolved despite their finite precision requirement.

The result is a valid one-way polynomial-time reduction from SAT to the
specified constant-error conditional-inference task. It does not provide
that task's implementation, assert a converse reduction, or establish any
counting-class hardness statement. No blocking proof defect was found.

## Nonclaims lens: GO-WITH-NOTES for bounded exploratory use

The lift is explicitly a different candidate from the retained analog flow.
Its convexity is not transferred to the earlier nonconvex spin dynamics.
The exponentially large assignment simplex and potentially large restricted
factors are disclosed; no free normalization, semantic oracle or hidden
summation step is granted by the compact weight description.

The positive claim is a robust conditional readout and exact gap/reduction.
It is not an approved general SAT solver because the essential deterministic
all-prefix inference primitive has not been implemented or bounded. The
oracle has to work on UNSAT inputs as well to justify the NO branch.

The note does not infer exponentially many precision bits from small
partition values, nor infer an efficient sum from polynomial output size.
It makes no P!=NP, impossibility, unsupported #P-hardness or equivalence
claim. A satisfying assignment is neither supplied as advice nor used to
construct the queries.

Safe summary: a rational Gibbs lift has a convex target and a deterministic
SAT readout from uniformly accurate conditional marginals; obtaining those
marginals in polynomial time is the unproved algorithmic obligation. No
formal route-final status, stronger claim expansion or P=NP completion follows.
