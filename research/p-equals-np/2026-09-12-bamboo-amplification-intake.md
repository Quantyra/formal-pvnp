# Simple-bamboo amplification: bounded mechanism intake

2026-09-12; S3111/S008. Literature and construction assessment only.
[Integrity](../../INTEGRITY-CLAIMS.md). Source context: arbitrary-output
proof commit 4b748b22aa87587f761ddd2d99f342f427a9b0c9; public v4
09aca60184fe7b1d61856cd79ac21aa86ea4caca; current graph S3110.
No proof execution, experiment, theorem extension or public edit is reported.
No AGENTS.md is present at this satellite root; INTEGRITY-CLAIMS.md was read.

## Verdict and exact question

**Selection recommendation: NONE for the concrete transfer attempts below.**
This is not a conclusion that amplification is impossible or that an unproved
bound disqualifies a specified mechanism. The two actual proposed operations
lose necessary representation contracts before an asymptotic estimate can be
applied: independent source restrictions cease to be literal substitutions,
and the proposed full-row closure/conditioning sampler requests an empty
source fiber. No replacement sampler is specified here. A separately supplied
operation overcoming these defects would be eligible for new scrutiny.

The starting theorem is every fixed Boolean A, q even >=1024, m=q^2,
N=8q+4, D=floor(q/(32 log_2 q)), with explicit real SoS refutation size

    S=sum_i ||f_i||||g_i||+sum_j ||h_j|| >= (8/7)^((2D-1)/2).

Norms count original ordinary polynomial monomials before Boolean reduction;
roots are counted before squaring. There is no degree bound or coefficient-bit
charge. The residual row-space PSD theorem is at width q with B=2D typed
labels per root monomial, not across the entire sum. Full-row marginals are
available only within their stated local rank/independence budgets. Pointwise
uniformity in constant A does not assert compatibility when A contains
variables from another instance.

## Primary source comparison and search boundary

Checked 2026-09-12: [TR26-133](https://eccc.weizmann.ac.il/report/2026/133/)
shows its August 7, 2026 report; [arXiv](https://arxiv.org/abs/2608.08760)
shows v1, August 9, 2026, and no later listed revision. Read cached primary
full text Sections 5.4.1, 5.4.2, 6.2 and 8.3, especially Definition 5.32,
Lemma 5.42, Theorems 5.44 and 5.51 and their proofs. This matters more than
the abstract's phrase 'standard iteration'.

Theorem 5.44 concerns algebraic PCR over F_2, a shared Y and separate X^pi,
with descendant X entries or constants as outputs. It assumes kappa>0,
m>n>=16+192(kappa+2), and divisibility of n-16 by 192(kappa+2), obtaining
size 2^{Omega(sqrt(n/kappa))}. Row/column restrictions first reduce degree.
The recursive substitution X^pi -> A^pi X then reduces to Rank_n^m(I_m),
with degree multiplied by at most kappa+2. Lemma 5.42's footnote explicitly
allows proof size to increase. This is a degree contradiction over F_2,
not a bound on expanded real SoS roots after recursive substitution.

Theorem 5.51 instead uses the specially constructed four-copy CNF
psi_{P(H(G))}, not the simple-bamboo CNF of Section 6. Parameters are
N_source=8n+8, m_source=16(N_source+2), kappa<=n^alpha, alpha<1,
and a lossless expander with delta>4alpha and left degrees between
50 log n and 150 log n. Its bound is 2^{Omega((n^delta/kappa)^{1/3})}.
Three restriction stages control extension variables, columns and remaining
variables; the final reduction to graph FPHP multiplies degree by O(kappa).
The proof ends with a PCR_F2 degree lower bound. Its literal stages alone
do not supply the missing real PSD functional or transplant its FPHP
contradiction into SoS. Neither theorem has the fixed m=q^2 / N=8q+4
simple-bamboo contract of v4.

Also read the primary [Razborov manuscript](https://people.cs.uchicago.edu/~razborov/files/res_k.pdf),
Definitions 2.9/2.11, Theorem 2.19, Section 6 and the end of Section 10;
[publication record](https://annals.math.princeton.edu/2015/181-2/p01), 2015.
Theorem 2.19 proves iterability for its expander parity generator in PCR over
characteristic different from two. Section 6 forms a direct-sum incidence
matrix and adds at most one incidence per row for each output-to-input wire.
Expansion degrades controllably; a variable substitution plus bounded local
clause derivations invokes the generator-specific lower bound. Thus the
remark that the proof works for substitution-closed systems does not turn
arbitrary all-output hardness into iterability. Our bilinear dense matrix
constraints do not have that incidence-matrix/expander hypothesis. Real SoS
closure under restrictions is useful, but a PCR lower bound is not an SoS
lower bound. These primary comparisons are a bounded applicability search,
not a claim to have exhausted all amplification literature or certified novelty.

## One exact candidate composition

Fix q once at every node. Set s=2mN and t=m^2. Since m>=4N, two child seeds
fit in a parent output. At each internal node pi, reshape the first 4N
columns of its m-by-m matrix output into

    [ X^(pi0) | X^(pi1) | (Y^(pi0))^T | (Y^(pi1))^T ].

Each block has N columns. This is a specified row-aligned wiring, not a
parity substitution or a new choice of q at each level. The remaining
m-4N columns are unused outputs, not fixed zeros. At depth d>=0, the external
output is the concatenation of all 2^d full leaf matrices, in lexicographic
node order. It has T=2^d t bits; the sole external seed has s bits.
There are V=2^{d+1}-1 evaluations. For d=0 this is exactly G_q.

CNF: give every node fresh X,Y and all prefix U variables, retaining the
3 base clauses and 6 clauses per later prefix step from the exact source.
At every used internal output coordinate add the two clauses expressing
u_(i,j,N)=the indicated child input bit. At unused internal coordinates
add no output clause. At every leaf add its t target unit clauses. Do not
replace internal output coordinates by constants. Boolean equations apply
to all variables, and optional complement twins require their usual equations.

This CNF is satisfiable exactly when the given leaf string is an output of
the specified composition: forward evaluation fills every variable, while
prefix and wiring equations force the unique forward evaluation from the
root seed. Witnesses include intermediate seeds and prefixes; only the root
seed is the generator input. There are V(s+tN) variables before twins,
V(6N-3)t internal computation clauses, 4s(V-2^d) wiring clauses, and
2^d t leaf units. Each internal node wires 2s bits using two clauses each.
Width is at most four. Explicit description costs
O(V q^5 log(V q)) bits/time using direct indexing; evaluation costs O(V q^5)
Boolean operations. Input q and d are not unary-free sources of work: an
explicit T-bit output takes at least T time. A requested output bit can be
computed along one root-to-leaf path in O((d+1)q^5) operations, with address
length d+ceil(log_2 t). This indexing fact proves no function-generator
hardness. Choosing polynomial d gives an exponentially long explicit
output and formula, not polynomial total enumeration time in seed length.

Discarding unused internal columns is part of the defined construction.
For a single copy with this retained exact gate encoding, arbitrary-output
v4 hardness DOES pass to coordinate projection: any refutation of the gates
and observed-output units is the identical certificate for every completion
of the output, assigning zero multipliers to the additional units. Its size
is unchanged. If a completion is satisfiable, no such refutation exists.
Thus projection alone is not an obstruction; the obstruction below is the
coupled tree, whose intermediate coordinates are variables with their own
constraints. One could retain unused columns externally instead, but this
would be another target family and would not remove the coupling obligation.
This paragraph corrects the author's initial mistaken direction-of-inclusion
claim, identified by the independent actual-file reviewer; the failed
restriction and conditioning operations and NONE recommendation are unchanged.

## Depth-one semantic countercheck supplied by independent reviewer

The independently supplied shared-subspace test checks directly. Write
R=colspace_F2(X^root), so dim R<=N. Wiring implies that every column of
X^0, X^1, (Y^0)^T and (Y^1)^T lies in R. Consequently both the column
space and the transposed row space of each leaf product A^b=X^b Y^b lie
in R. Let A^0 have ones at (i,N+i), i=1,...,N, and zeros elsewhere; let
A^1=0. Both leaves have rank<=N and individually belong to the base range.
But A^0 has column space span(e_1,...,e_N) and transposed row space
span(e_{N+1},...,e_{2N}); their sum has dimension 2N>N. The pair is
outside this depth-one composition's range. Our m allows these indices.

Therefore a reduction which finds a nonrange leaf is false, and independently
chosen base preimages need not glue. This is a semantic counterexample to
those specific inferences, not a short SoS certificate, a runtime lower bound,
or a refutation of possible tree pseudoexpectations.

## Concrete transfer operation 1: parallel source restrictions

Proposed operation: independently apply Definition 6.8's row-type and offset
sampling to every node, transform the original certificate identity, and
try to evaluate it under coupled residual row laws. It must first preserve
the original-monomial shrinkage accounting. At a leaf, constant A makes every
U image a literal or constant, as in v4. At an internal node A_ij is a child
input bit. Definition 6.8 uses A_ij in gamma_(i,j,b), hence in the running
parity p_(i,j,b). After an earlier common-star block, an image U can be
A_ij XOR a residual prefix bit, up to a constant offset. Over R its ordinary
polynomial is a+u-2au, or its complement, rather than a literal.

For a concrete template location, the visually corrected first rows are
D=(1,*,1,0,0,*,*,*) and E=(1,0,0,1,*,*,*,*). Their first common-star block
is 6; at block 7 the accumulated parity includes A_ij once. Thus if that
child input survives the child restriction, the two-variable XOR image
occurs. This invalidates direct invocation of the v4 literal-survival and
endpoint argument: u_N maps to a child variable rather than a constant.
It does not prove that a different union bound cannot work.

Algebraic substitution preserves the identity and squares, but roots must
be expanded and their row supports tracked. A product of K uncomplemented XOR images has at most 3^K raw expansion
terms before collection; allowing complemented images gives at most 4^K,
since 1-a-u+2au has four terms. Cancellations or an alternative representation
need proof. The independent actual-file reviewer corrected the initial
3^K bound for the complemented case. This and the projection correction
above concern this intake only; the published proof is unchanged. The initial size convention supplies
no degree bound on a one-monomial root, so this estimate alone cannot be
charged by a universal constant per original monomial. Deferring evaluation
as an XOR circuit changes the certificate representation and is not licensed.
A valid replacement must specify a distribution and shrinkage event for the
actual original g_i/h_j monomials plus local image-axiom annihilation.

## Concrete transfer operation 2: close rows, then condition source samples

Proposed depth-one sampling rule: for a requested set of complete typed
rows at the two children, add every parent typed row needed to determine
their wired input bits. Sample each node's indicated rows independently
from its source full-row law, then condition on all equalities between the
sampled child bits and the parent inner products. Use the resulting
normalized law as the joint local marginal. Fix deterministic ordering of
rows and uniform sampling within each source fiber; zero conditioning
probability is failure, not a choice of arbitrary fallback values. This is
an actual operation to test, not an assumption that compatible kernels exist.

It fails the source representation contract before PSD is considered. One
complete X row at a child needs N parent output coordinates in its block,
hence one parent X row and N parent Y-column labels. A child Y-column
similarly uses N coordinates in its corresponding block. The existing
residual PSD budget is B=2D, far below either N or q. Even an idealized
residual-to-residual row wiring, granting q coordinates instead of N,
requires q parent Y columns. The source prime row law requires these
columns together with the fixed all-ones column to be linearly independent
in F_2^q. That requests q+1 independent vectors in dimension q: the proposed
source sampler has an empty fiber. Applying the same proposed full-rank
source-law recipe at width N likewise asks for N+1 vectors in dimension N.
Neither law is part of the v4 domain. This is an obstruction to this closure
sampler, not to arbitrary distributions that allow dependencies.

Sampling the parent on fewer rows and conditioning each output bit separately
avoids that particular empty fiber only by abandoning a complete child row.
It would need a specified new way to recover the joint distribution of that
row, common marginals under deleting labels, and square positivity for sums
across nodes. No such replacement operation is offered here. Independently
sampling leaf preimages also ignores the shared-space countercheck above.

For completeness, direct real elimination does not repair the lost contract:
a child input coordinate is the parity of N products and has multilinear
polynomial (1-prod_k(1-2 x_k y_k))/2, with exactly 2^N-1 distinct monomials.
This single-coordinate expansion already exceeds the scale of the v4
exp(Omega(q/log q)) lower-bound budget. This observation concerns that exact
substitution; it is not a lower bound on all representations or a universal
barrier to degree-based arguments. A compressed expression is available,
but compressed-certificate hardness is expressly outside the theorem.

## First falsifiable obligations and closeout boundary

The first counterchecks are now explicit: parallel literal closure fails at
block 7 of the displayed row types; full-row closure/conditioning fails its
source-fiber nonemptiness test; nonrange-leaf extraction fails on the displayed
two-leaf target. A genuinely new next operation would need to retain partial
parent-output information without forcing N or q independent parent columns,
yet provide complete-child-row marginal consistency and cross-node PSD.
That requirement is not itself a selected mechanism or a theorem conjecture.

No existing theorem inspected supplies this for our exact encoding and
explicit real SoS measure. This bounded negative applicability conclusion
credits known iteration machinery and does not assert an open-problem priority
claim. No all-m, amplified SoS, circuit-lower-bound-statement or P-versus-NP
result follows. Independent actual-file challenge and nonclaims review remain
required before root records the route selection.
