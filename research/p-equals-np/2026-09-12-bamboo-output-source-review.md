# Arbitrary-output bamboo: independent source and generator review

2026-09-12; S3109 / S008. Source/complexity review, not the independent
mathematical proof lens. Only this record is owned by this reviewer.

## Final source verdict

**GO for the actual author artifact's source/complexity interfaces and the
conditional generator implication below.** Source local laws, extension counts, and random substitution already
quantify over arbitrary Boolean A. No identity-entry dependence was found
in the displayed conditional Fourier/rank-deletion argument at fixed m=q^2.
This is an applicability assessment; the final actual-file check is recorded
below. The separate mathematical review remains a distinct required lens.
No proof was repaired or new spectral estimate supplied by this reviewer.

## Primary source and exact all-output interfaces

Checked the live [ECCC TR26-133 record](https://eccc.weizmann.ac.il/report/2026/133/)
and [arXiv history](https://arxiv.org/abs/2608.08760) on 2026-09-12: ECCC
displays August 7 and arXiv only v1, August 9. Used the cached ECCC primary
PDF/text `C:/Users/Dan/AppData/Local/Temp/wrank-2026-133.pdf[.txt]` for
numbering. The source's informal generator definition is on printed page 2;
the SA discussion is Section 2.2; the exact encoding and laws are Section 6.

Definition 6.1 uses arbitrary A as final prefix bits. Definitions 6.5--6.6
specify uniform full-rank augmented frames with all-ones boundary and exact
prefix evaluations. Lemma 6.7 explicitly quantifies over every Boolean A.
Its extension count is

    2^(q-|I|-1) - nu,

where nu counts solutions of a linear system determined by the prescribed
augmented A submatrix and label sets. It is independent of the sampled
frame, and positive in the specified support window. Starting at the empty
context proves nonemptiness; equal extension counts prove marginal
consistency. Thus no global rank condition on A is needed for small-context
laws. Term consistency includes complete-row atom indicators and hence the
complete-row marginal statement used by the analytic proof.

Definition 6.8 and Lemmas 6.9--6.10 also quantify over arbitrary A. The
substitution preserves A and m; A_ij selects parity offsets and the final
prefix value. Its survival bound and local clause-image argument do not
require A=I. These statements are from the primary source, not extrapolated
from its identity instance. The precise source hypotheses are m>N>=20 and
16 divides N-4. With q even>=1024, m=q^2 and N=8q+4, all hold; the
residual laws also have m>q. The v3 corrected D/E transcription was previously
visually checked against printed page 72; arbitrary output does not change it.

## Hidden identity-reliance screen

Read the displayed S3099 argument (7)--(30), v3 row-space proof and size
transfer, and S3108 contribution audit. The checks are source-specific:

- Separator dimensions u,v and pairing rank t may depend on A and supported
  data. The bound h=q-u-v+t>=q-|S|-2 uses no identity formula.
- Prescribed outputs select affine cosets and Fourier signs. Direction-space
  bilinear rank h, and channel rank kh, are unchanged by those signs/shifts.
- Rank-exclusion intersections can be empty or nonempty. The proof bounds
  their dimensions without assuming a particular right-hand side or t value.
- Same-side uniform marginals use the all-A extension counts above; mixed
  covariance reduction conditions only on supported fibers of the same laws.
- Hierarchical decomposition and pair-union consistency concern complete-row
  function spaces. The all-context count remains sum_(r<=2D) binom(2q^2,r),
  independent of the entries of A. Nothing here licenses unrestricted m.
- Output clauses and endpoint prefix constants must consistently use A_ij.
  The size proof applies the real polynomial homomorphism to roots before
  squaring, counts original monomials, and annihilates every axiom locally.

The specific use of I_m in v3's introductory contradiction is rank(I_m)>N.
For arbitrary A, satisfiability must instead be classified by rank(A).
It would be incorrect to say that every output instance is contradictory.
The theorem form 'every refutation has size at least K_q' remains meaningful
for every A: when the instance is satisfiable, there are no such refutations.

## Exact conditional generator implication

Assume the reviewed extension establishes, for **every** A in {0,1}^{m x m},
the same explicit SoS size bound for unaugmented simple bamboo at

    q even>=1024, m=q^2, N=8q+4,
    D=floor(q/(32 log_2 q)),
    K_q=(8/7)^((2D-1)/2).

Then define the uniform indexed family

    G_q : {0,1}^{s_q} -> {0,1}^{t_q},
    G_q(X,Y) = XY over F_2,
    s_q = 2mN = 16q^3+8q^2,
    t_q = m^2 = q^4.

Inputs are the entries of an m-by-N matrix X and an N-by-m matrix Y in
a fixed row-major order. Output entries are listed row-major. For these q,
t_q>s_q; asymptotically t_q=Theta(s_q^(4/3)), with ratio Theta(q).
This is polynomial stretch, not nearly quadratic or exponential stretch.
The map is computable by m^2 dot products using O(m^2 N)=O(q^5)
Boolean operations. Explicit binary indices require O(log q) bits each;
including index/description overhead still gives polynomial total cost. Its circuit
description and the encoded formulas are constructible by explicit indexed
loops in polynomial time. No decomposition of the enormous local L2 spaces
is part of evaluating G_q. The statement is an indexed family at the displayed
seed lengths; no additional all-length padding convention is needed or claimed.

For fixed A, define the inversion relation by input X,Y and prefix bits

    u_(i,j,1)=x_(i,1)y_(1,j),
    u_(i,j,k)=u_(i,j,k-1) XOR (x_(i,k) AND y_(k,j)),
    u_(i,j,N)=A_(i,j).

Use exactly Definition 6.1's clauses for these recurrences. This is a
constant-arity circuit encoding with a ternary XOR-of-AND gate relation;
adding separate product variables would be a different encoding requiring
its own transfer. Prefix bits are uniquely determined by X,Y, are existential
extension witnesses, and **are not seed bits or extra output bits**. The
all-ones boundary and oddness used inside the restricted proof are also
not constraints of this original generator map.

The CNF has 2mN+m^2N variables and (6N-2)m^2 clauses before optional
twins and Boolean equations: one output clause, three base clauses, and
six clauses for each of N-1 steps, per matrix entry. Clause width is at most
four. Thus literal count is O(q^5), and a standard binary indexed encoding
has O(q^5 log q) bits. Its real clause-falsification equations have constant
many monomials per axiom. Optional twins/Boolean equations preserve these
polynomial bounds. The precise certificate size remains
sum_i ||f_i||||g_i||+sum_j ||h_j||, without coefficient-bit charges.

Existence of a satisfying assignment is equivalent to A in range(G_q).
Over F_2, that range is exactly the matrices of rank at most N: the forward
direction is rank submultiplicativity, and a rank-r factorization for r<=N
can be padded with zero columns/rows. Consequently rank(A)>N is exactly
the nonrange/unsatisfiable case. In-range instances have no sound SoS
refutation; out-of-range instances have no refutation smaller than K_q
under the assumed theorem. This gives the source's 'every output' hardness
condition, with satisfiable cases understood vacuously.

The lower bound is

    K_q=exp(Omega(q/log q))
       =exp(Omega(s_q^(1/3)/log s_q))
       =exp(Omega(t_q^(1/4)/log t_q)),

and is superpolynomial in both output length and explicit CNF bit length.
The counting bound |range(G_q)|<=2^s_q<2^t_q establishes
non-surjectivity; explicitly I_m is already outside the range. The hardness
assertion nevertheless concerns all outputs and the fixed SoS encoding,
not just that explicit witness.

This is an encoding-specific proof-complexity generator implication.
Its range membership is decidable in polynomial time by F_2 rank, and
preimages can be recovered by rank factorization whenever they exist.
No computational pseudorandomness, SAT algorithmic hardness, P-versus-NP
separation, circuit-SoS lower bound, or hardness for other encodings follows.
No stretch iteration or function-generator consequence is adopted: those
require an explicit iterated map/encoding and hardness-preservation theorem
for this proof system and measure. The source's PCR iteration cannot simply
be relabeled SoS.

## Actual author artifact review

Read the entire saved `2026-09-12-bamboo-output-uniformity.md`, SHA256
`CADA42936367F0F238BEE5EEEAB873BB9535EE463C1C8F5EA85D5A566170A7D9`.
The actual statement matches the fixed parameter and representation contracts
above. Its clause-falsification table matches source Definition 6.1 for both
output bits, including all six XOR-of-AND clauses. The augmented pairing
matrix keeps arbitrary A_(I,J), and its extension count explicitly retains
the empty/nonempty affine intersection distinction. The later estimates
bound the actual separator rank rather than silently substituting an
identity-output value. The restriction retains A_ij in block offsets and both
final endpoints; no new independence hypothesis is inserted for those offsets.

The argument uses complete-row marginal consistency, uniform supported
conditional fibers, the unchanged all-support budget, and real square-root
homomorphism exactly where required. The satisfiability paragraph correctly
states rank(A)<=N and treats the bound vacuously there. In particular it
does not assert that every Boolean output is outside the range. It explicitly
withholds a generator theorem and arbitrary-m/iteration claims. No source
misapplication, hidden identity assumption, or complexity overclaim requiring
revision was found in this actual artifact.

**Final source/complexity verdict: GO** for that hash. The generator section
of this review remains an explicit conditional implication until the theorem
passes its full gate; this review does not replace the separate mathematical
verdict. No author proof edits or repairs were made. Only this review file
was written; no public change, experiment, commit, push, or spend occurred.
Frozen for integration.
