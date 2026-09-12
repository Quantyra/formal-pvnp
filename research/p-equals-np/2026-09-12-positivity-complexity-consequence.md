# Exact SoS degree consequence of source square positivity

2026-09-12; S3101 / E004 / S008; [integrity](../../INTEGRITY-CLAIMS.md).
Author implication audit; final actual-file proof PASS, source/model GO and
nonclaims PASS are recorded below. This is an
analytic corollary conditional on the precisely pinned analytic PSD theorem,
not a Lean formalization or a new proof of that theorem.

## Statement and import contract

Let n be even, n>=1024, m=n^2, A=I_m, and
D=floor(n/(32 log_2 n)). Let F' be the Boolean polynomial encoding of the
restricted **simple** bamboo CNF BT•Rank′_n^m(A) in source Section 6:
each clause C becomes its falsification polynomial f_C=0, and each remaining
variable v has Boolean equation v^2-v=0. Work over the real polynomial ring.
Optional separate literal twins bar(v) are permitted, together with
1-v-bar(v)=0 and their Boolean equations.

**Corollary.** There is no SoS identity

    sum_C f_C g_C + sum_v (v^2-v) b_v
      + [optional twin-equation multiples] + sum_j h_j^2 = -1

whose degree, measured in the ordinary polynomial ring before Boolean
reduction, is at most 2D+1. Thus every such refutation has integer degree at
least 2 floor(n/(32 log_2 n))+2, an Omega(n/log n) degree lower bound for
this explicit unsatisfiable family. The degree convention is exactly source
Definition 4.3: max of every individual axiom-product degree and twice every
square-root degree. It is not the degree after cancellations between summands
or after Boolean reduction.

The sole additional positivity import is the full actual X/Y/U theorem in
[the source author record](2026-09-12-shared-row-conditioning.md), source
commit `90868e5d032db6dba4cdf61d8a3fe07bfacdbfd7`, published v2 commit
`95701cf`: for these parameters, the unchanged source R has R(p^2)>=0 for
every actual Boolean-reduced ordinary-degree-at-most-D polynomial p,
including arbitrary sums over different row contexts. The theorem must cover
the boundary prefix variables as well as all free interior prefix variables.
The corollary does not replace this import by fixed-context positivity,
monomial positivity, a compressed Gram, or a different pseudoexpectation.

The other imports are the explicit local laws in Definitions 6.5--6.6 and
their nonemptiness and marginal consistency (equation (36), Lemma 6.7) from
[Garlik--Gryaznov--Ren--Tzameret, ECCC TR26-133](https://eccc.weizmann.ac.il/report/2026/133/).
The cached primary PDF text was checked directly, including Definitions 4.3
and 6.1 and the proof of Lemma 6.4. These facts are used explicitly below.

## Exact axiom family, including the boundary

Use typed labels X_i and Y_j for i,j in [m]. A free x_(i,k) mentions X_i,
y_(k,j) mentions Y_j, and u_(i,j,k) mentions X_i and Y_j whenever those
indices are free. A boundary index m+1 contributes no free label. Numeric
equality i=j never identifies an X label with a Y label.

Source Definition 6.1 first has i,j in [m+1]. Write x=x_(i,k), y=y_(k,j),
a=u_(i,j,k-1), b=u_(i,j,k). Its complete clause-falsification list is:

| Family | Falsification polynomials before boundary restriction | Raw degree / typed rows |
|---|---|---|
| Output | 1-u_(i,j,n) for output 1; u_(i,j,n) for output 0 | 1 / at most 2 |
| Base, k=1 | (1-u)xy; (1-x)u; (1-y)u | 3,2,2 / at most 2 |
| Summation, k>=2 | (1-x)a(1-b); (1-x)(1-a)b; (1-y)a(1-b); (1-y)(1-a)b; xyab; xy(1-a)(1-b) | 3,3,3,3,4,4 / at most 2 |
| Boolean | v^2-v | 2 / at most 2 |
| Optional twins | 1-v-bar(v); bar(v)^2-bar(v) | 1,2 / same labels as v |

Here every sum in the intended gate relation b=a+xy is over F_2; the real
clause polynomials, not the incorrect real equation b-a-xy=0, are the axioms.

The restricted formula is obtained from the augmented output matrix
tilde(A), with interior A, boundary row/column entries 1 and bottom-right
n mod 2. Fix x_(m+1,k)=y_(k,m+1)=1 and u_(m+1,m+1,k)=k mod 2, and their
twins to complements. Keep u_(i,m+1,k) and u_(m+1,j,k). Apply this substitution
to every row of the table. Interior clauses remain; the two boundary strips
are one-row prefix parity gates with output 1; the corner clauses vanish.
Zero polynomials/tautologies may be discarded. Every nonzero surviving
clause polynomial has positive degree and at most two typed labels. There
is no surviving constant 1 axiom: each one- or two-label law below satisfies
every clause on those labels, including the boundary strips. This also
checks all boundary special cases without deleting the parity constraints.

## Functional domain and local satisfaction

For each I,J subset [m] with |I|+|J|<=n-2, source D_(I,J) is uniform on
full-rank augmented matrices M,N, with their boundary row/column equal to
the all-ones vector, and MN=tilde(A) on that rectangle over F_2. Source rho
assigns X/Y their coordinates, every relevant U its actual prefix dot parity,
and twins their complements. These are nonempty genuine finite local laws.
Their marginals agree whenever labels are removed.
Full-rank exclusions are conditions on these sampling supports, not extra
polynomial axioms supplied to the refutation system.

Define R on the span of Boolean-reduced monomials of typed row degree at
most n-2 by the expectation of each monomial in its own law, then extend
linearly. Consistency implies that a polynomial supported on any one such
context has R equal to expectation in that law. This domain permits sums
with arbitrarily many total labels, provided each monomial has small support.
R(1)=1. Prefix evaluation satisfies all base/summation clauses; MN gives
all output clauses; the all-ones boundary gives the parity-strip outputs.
Boolean and twin equations hold pointwise. Hence each complete listed axiom
is locally zero, not merely selected output or interior axioms.

## Degree accounting and contradiction

Suppose a degree-at-most-(2D+1) identity exists. First substitute bar(v)=1-v
if twins were used. This polynomial-ring homomorphism preserves the identity,
does not increase ordinary degree or labels, turns twin linear equations
into zero, and turns twin Boolean equations into v^2-v. Then take the
Boolean quotient, always retaining the original raw-degree bounds.

For an original nonzero clause axiom f of raw degree r>=1, polynomial-ring
degree additivity gives deg(g)<=2D+1-r whenever fg is a nonzero summand.
(If g=0 there is nothing to show.) After twin substitution each multiplier
monomial t still has degree at most 2D+1-r. Each factor mentions at most two
typed labels. Consequently the union of the labels of f and t has size at
most

    2 + 2(2D+1-r) <= 4D+2 <= n-2.

For the last inequality, 4D+2<=n/80+2<=n-2 when n>=1024.
It is the common-context bound for the **whole axiom times each multiplier
monomial**, not an inference from possible cancellations in fg. Restricting
or substituting twins can lower the degree of f, but using its original
positive r in this bound remains valid. A zero substituted axiom contributes
zero. In the common law f vanishes pointwise, so consistency gives
R(BoolReduce(f t))=0. Summing over t proves annihilation of every clause
multiple. All Boolean multiples vanish identically in the Boolean quotient,
and all twin linear multiples have already vanished.

For each square root h, integer degree gives deg(h)<=floor((2D+1)/2)=D;
its substituted Boolean reduction p also has degree at most D. This is why
the statement excludes odd certificate degree 2D+1 as well as degree 2D.
Boolean reduction is a ring homomorphism, so the reduction of h^2
is the reduction of p^2. A monomial in p has at most 2D labels; a monomial
in p^2 has at most 4D labels. Thus R is defined on the entire reduced
identity, and the exact imported full-square theorem gives R(p^2)>=0.
Applying R yields 0+sum_j R(p_j^2)=-1, impossible since R(1)=1.
This proves the stated corollary with no appeal to an unquantified duality
principle and no efficient evaluation assumption about R.

## Nonvacuity and precise encoding transfers

Every Boolean satisfying assignment to the interior base/summation/output
clauses would give XY=I_m over F_2. But rank(XY)<=n<m, whereas rank(I_m)=m.
Thus F' is Boolean-unsatisfiable for every parameter above. With Boolean
equations over the reals this is also an unsatisfiable real polynomial
system. The result concerns an actual infinite contradictory family, not
a vacuous statement about a satisfiable instance.

Two modest transfers follow directly, with no degree loss:

1. The unaugmented simple bamboo BT•Rank_n^m(I_m) clauses and variables are
   literally contained among the restricted system's interior clauses and
   variables. Any certificate using only those axioms remains a certificate
   in the larger polynomial ring with the extra boundary axioms unused.
   Therefore the same lower bound holds for this unaugmented **simple**
   encoding. Adding the boundary constraints strengthens satisfiability
   requirements; the certificate inclusion, rather than an informal word
   such as stronger/weaker, fixes the direction.
2. A certificate for the augmented simple bamboo BT•Rank_n^(m+1)(tilde(A))
   restricts under the explicit sigma above to a certificate for F'. A
   restriction preserves sums of squares and does not increase any raw
   axiom-product or square-root degree. Hence that augmented family inherits
   the same bound as well.

These arguments do not identify source Section 5's BTRank encoding with
additional z product variables, nor its perfect-matching PMRank encoding,
with the present simple prefix encoding. No transfer to either is asserted
without a separately checked axiom simulation and its degree overhead.

## Published comparison and complexity relevance

The same primary paper's Lemma 6.4 proves an SA **row-degree** lower bound
n-1 for this restricted simple bamboo encoding. Its R is nonnegative on
terms; that alone does not guarantee nonnegativity on arbitrary polynomial
squares. Its Theorem 6.11 obtains SA size hardness through a separate
restriction analysis. Neither is silently imported as a SoS size result.
The present implication adds exactly the use of full square positivity
at ordinary degree D to the source's already available local laws.
The positive-functional contradiction is the standard SoS lower-bound
principle; the work of this audit is its exact encoding and degree contract,
not a newly invented proof-complexity mechanism.

The paper's Theorem 5.18 (also Theorem 2.3) already proves SoS size
2^Omega(n) for the different perfect-matching encoding PMRank. Lemma 5.17
sets X,Y to all ones and maps matching extension variables to counting
principles; these are not the prefix U variables above. This established
result prevents any claim of a first SoS lower bound for rank encodings,
but does not by itself prove the particular bamboo consequence here.
The checked comparison is narrow; it is not an exhaustive novelty audit.

No size lower bound follows here merely by quoting degree: no applicable
size-degree theorem with these parameters and encoding is proved or
imported. The system has many extension variables, so such an inference
would in any case require quantitative checking. This corollary gives no
runtime lower bound for arbitrary SAT solvers, no general proof-system
lower bound, no NP/coNP or P-versus-NP conclusion, and no algorithm.
It is a bounded proof-complexity consequence for a specified encoding,
with two explicit degree-preserving transfers.

## Review and execution record

The implication author did not author the imported PSD proof in this task.
The final actual-file reviews independently inspect the complete consequence,
including the odd-degree refinement to minimum certificate degree 2D+2.

| Lens | Actual saved review | Independence and contribution | Verdict |
|---|---|---|---|
| Independent proof | [Proof review](2026-09-12-positivity-consequence-proof-review.md) | `conditional_nonclaims`; no construction or repair; checks the new implication under the pinned PSD import | PASS |
| Source/model and complexity | [Source review](2026-09-12-positivity-consequence-source-review.md) | Earlier PSD author and hierarchical-bridge contributor, disclosed; source comparison and optional size-tradeoff diagnostic, not independent recertification of that theorem | GO |
| Independent nonclaims/publication | [Nonclaims review](2026-09-12-positivity-consequence-nonclaims-review.md) | `consequence_nonclaims`; no construction or repair; also integrates this closeout metadata | PASS for exact scope; public readiness REVISE |

The three reviewers are distinct. The proof and nonclaims reviewers supplied
no construction or repair. These are AI-agent analytic reviews, not Lean
verification, independent human peer review or novelty certification. The
reviewed pre-closeout author file has SHA256
`88B7BBD0F911D425D76F6A0B61B2D602E0DB1D17C610CA87B206C3CBA45E3C43`;
this final integration changes status metadata only and preserves the entire
mathematical body.

The exact analytic degree consequence and its two specified transfers are
complete at this review level. A public addendum is worthwhile because it
supplies v2's deliberately unadopted certificate interpretation, not a new
lower-bound mechanism. Public readiness is REVISE until the exact claim packet,
frozen public extraction, actual-candidate reviews and metadata comparison,
and recorded candidate PUBLISH decision are complete. S3102 owns that separate
curation. Existing user authorization covers worthwhile publication of this
exact bounded result; this closeout does not itself publish or expand public
metadata. The broader P-versus-NP objective remains unresolved.

The orchestrator authorized a local scoped commit of the consequence, its
three reviews and the research graph. No mathematical change, experiment,
parameter search, implementation, Lean build, push, publication, outreach or
paid computation is part of this integration.
