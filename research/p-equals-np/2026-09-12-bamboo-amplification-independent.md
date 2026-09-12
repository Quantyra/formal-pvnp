# Bamboo amplification: independent applicability challenge

2026-09-12; S3111 / S008. Independent reviewer `output_fresh_proof`.
[Integrity boundary](../../INTEGRITY-CLAIMS.md).

**Current disposition: no established SoS amplification transfer.** The
existing arbitrary-output theorem does not discharge the stronger
variable-output, multi-copy obligation needed for iteration. The source
PCR iteration proofs have specific field, encoding and degree arguments
that cannot simply be relabeled as real explicit-monomial SoS arguments.
This intake selects a bounded depth-one test and records its obstructions;
it does not claim that all amplification is impossible.

This is source/applicability selection and adversarial examination of a
candidate interface. No new coupled-law proof, parameter experiment,
implementation, public edit, commit or push is authorized or performed
here. Further execution awaits the root literature-trigger gate.

## Available theorem and target mismatch

The current public v4 map is G_q(X,Y)=XY over F_2 with q even>=1024,
m=q^2, N=8q+4, seed length s=2mN and output length t=m^2. Its exact
simple-bamboo real clause encoding has refutation size at least
K_q=(8/7)^((2 floor(q/(32 log_2 q))-1)/2), for the measure
sum_i ||f_i||||g_i||+sum_j ||h_j||. Every A is a fixed Boolean matrix.
For rank(A)<=N the assertion is vacuous; otherwise it is the proved
nonrange lower bound. The functional has complete-row square positivity
on bounded-row monomials, with no degree or whole-sum label limit.

Iteration needs output entries at internal nodes to be variables from
other copies, not fixed parameters. This changes the joint law, the
clauses that link copies, and the domain on which square positivity must
hold. Separate positive functionals for every constant A do not specify
a consistent coupling with those variables, their own gate constraints,
or the other nodes' functionals. A pointwise-in-A theorem is not already
an iterable-source theorem.

## Primary-source mapping

The cached primary text of [TR26-133](https://eccc.weizmann.ac.il/report/2026/133/)
was read at Section 5.4, Definitions 5.32, 5.41, 5.45 and 5.67,
Lemmas 5.42 and 5.68, Theorems 5.44 and 5.51, and their proof chains.
Section 7.1 was also checked to distinguish its parameter amplification.

| Source operation | Exact applicability problem here |
|---|---|
| Definition 5.32 / Theorem 5.44 | Algebraic PCR over F_2; the X copies share one Y. Internal output entries may be descendant X variables. Its bound is 2^(Omega(sqrt(n/kappa))) under the displayed divisibility/size hypotheses, not a real SoS theorem for the simple-bamboo tree. |
| Definition 5.41 / Lemma 5.42 | Recursive X^(pi) -> (A^(pi) after substitution)X controls degree by d(kappa+2). The source explicitly permits proof size to increase. The later contradiction is a PCR degree contradiction, so it does not supply the required raw SoS monomial-size bound. |
| Definition 5.45 / Theorem 5.51 | Uses four copies at each node, graph-restricted Y, product z variables, extra w output variables and expander hypotheses. Its PCR bound is 2^(Omega((n^delta/kappa)^(1/3))). These are not v4's dense unaugmented simple-bamboo formulas or parameters. |
| Definitions 5.53--5.67 / Lemma 5.68 | Multiple special restrictions, z-star contractions and PC derivation repairs reduce to graph FPHP degree hardness. This is not a real SoS square-preserving simulation with charged axiom multipliers. |
| Theorem 7.1 | Low-degree algebraic reductions between identity-output rank principles with different m/n ratios. This is a different use of “amplification”; it neither proves generator iteration nor upgrades fixed-m simple-bamboo SoS size automatically. |

The Section 5.44 proof first derives low row and column degree from a
hypothetically small PCR proof and then tolerates size growth during
the final degree reduction. The Section 5.51 proof likewise ends in a
different degree-hard system. A literal/constant restriction step may
have a useful analogue, but those endpoints and intermediate systems
must be replaced or proved separately for real SoS.

Additional primary targets were opened and selected on 12 September 2026:

- [Razborov, Annals 2015](https://annals.math.princeton.edu/wp-content/uploads/annals-v181-n2-p01-p.pdf),
  Definition 2.9, Theorems 2.10, 2.12 and 2.19, Sections 6 and 10. Iterability requires
  hardness for acyclic variable/constant output interfaces. Its Nisan
  proof rewrites the combined linear system as a direct-sum expander
  with at most one added incidence per row. The tree corollary consumes
  that stronger property. The proof also prunes unused copies to H<=S.
  This gives the correct stronger interface to test; the nonlinear
  bamboo coupling has not been identified with that incidence argument.
  Theorem 2.19 treats PCR in characteristic other than two. Section 10's
  variable-substitution closure observation still consumes the particular
  expander-generator lower bound; it is not a generic base-hardness theorem.
- [Krajicek, 2004 author manuscript](https://www.karlin.mff.cuni.cz/~krajicek/dual.pdf),
  Definition 3.6 and Theorem 3.7. The theorem assumes s-iterability and
  a proof-system simulation condition, and yields an Omega(s/t)
  iterability bound for a protocol of size t. Its hypothesis is stronger
  than base all-output hardness. Applying it to the present certificate
  representation would require proving that hypothesis and matching the
  encoding/simulation costs, not merely invoking composition closure.

These are bounded primary applicability checks, not an exhaustive
literature or novelty audit. No general SoS amplification theorem was
identified in these precise sources.

## Raw substitution cost: the missing quantitative invariant

For a polynomial substitution phi, square preservation alone gives
phi(h_j^2)=phi(h_j)^2. It does not control the explicit root size.
If every variable image has at most L ordinary monomials, an original
degree-e monomial can expand into as many as L^e monomials before
cancellation. The present measure imposes no degree bound, and a single
high-degree monomial still counts as one. Thus this estimate is not a
polynomial bound in the original certificate size.

A particularly concrete test is eliminating one intermediate output bit
of G_q. Its real Boolean polynomial is

    P(x,y) = (1-product_(k=1..N)(1-2 x_k y_k))/2.

The nonempty subsets of [N] give distinct monomials, so P has exactly
2^N-1 nonzero ordinary monomials and degree 2N. This already greatly
exceeds exp(O(q/log q)), the scale of the proved base lower bound.
Consequently naive seed-bit elimination provides no useful size transfer
on the current budget even before expanding products inside a root.
This is an obstruction to that representation-level argument, not a
proof that a different extension-variable argument cannot work.

Real arithmetic substitution of the source's F_2 sums is also invalid
without a translation: an F_2 linear sum is parity, not a real linear
sum. Prefix variables can avoid parity expansion, but then their defining
axioms remain part of a larger coupled system whose hardness is unproved.

Even if all variable images are controlled, a complete transfer must
express every substituted source axiom using target axioms, say

    phi(f_i) = sum_l F_l a_(i,l),

and charge at least the resulting bound

    sum_i ||phi(g_i)|| sum_l ||F_l|| ||a_(i,l)||
      + sum_j ||phi(h_j)||,

including any Boolean/twin repair terms. Degree-only derivability and
semantic implication do not supply that size estimate. No such estimate
for the proposed iterated real simple-bamboo system has been provided.

## Exact bounded candidate and decisive semantic test

The root communicated the author's proposed row-aligned binary interface:
the first 4N columns of a parent's output contain

    [ X_child0, X_child1, Y_child0^T, Y_child1^T ].

Each block has m rows and N columns, so this uses 4mN=2s output bits and
is dimensionally possible because m>=4N for the current q. The remaining
parent output columns are not observed. Each child receives the same
seed dimensions as the parent; leaves expose complete m-by-m outputs.
The root seed remains s bits. At leaf depth kappa the candidate exposes
2^kappa m^2 bits using 2^(kappa+1)-1 copies. This fixes an indexed map
without silently changing to a new q at each level.

The first mandatory nonrange test cannot be reduced to inspecting leaf
ranks individually. In the depth-one interface all columns of
X_child0, X_child1, Y_child0^T and Y_child1^T lie in the same parent
output column space R, of dimension at most N. Both the row and column
spaces of each leaf product therefore lie in R.

Take A0 to have an N-by-N identity block in rows 1..N and columns
N+1..2N, and zero elsewhere. Take A1=0. Each leaf output individually
lies in the base range, since its rank is N or zero. But A0's column
and row spaces are disjoint N-dimensional coordinate subspaces. Their
combined dimension is 2N>N, so the pair (A0,A1) is outside the proposed
depth-one range. This directly refutes a putative “every nonrange tree
output has a nonrange leaf” argument. It does not exhibit a short SoS
refutation or refute the candidate tree's possible hardness.

There is a separate locality test. Deterministically lifting a complete
child X row through this wiring requires N parent dot-product output
coordinates, hence the parent X row and N distinct parent Y columns.
At residual width q an analogous full residual-row lift still reaches
q parent Y columns. This exceeds the current O(q/log q) support budget.
The inherited degree-free complete-row estimates therefore do not justify
a naive bounded-row pullback of whole child-row function spaces.
A more economical coupled law would need its own construction and proof.

## First-test protocol and conditions for any replacement

The first test selected before the saved author proposal was received
was the exact depth-one three-node interface above with the concrete
(A0,A1) target. The cross-review below checks the author's resulting
sampling and restriction recipes and rejects those exact operations.
No replacement coupled source is selected here. Any later proposal,
after the root literature-trigger gate, would need to retain original
node variables, prefixes and variable-output clauses and establish:

1. Nonempty supported local fibers and deletion consistency across
   parent/child boundaries, retaining every variable-output equation.
2. Actual real square positivity on the required cross-node root space;
   pointwise fixed-output PSD and independent node products are insufficient.
3. A compatible restriction law that respects wiring and kills original
   root/multiplier monomials with an explicitly quantified survival bound.
4. Exact axiom-image annihilation or charged ideal simulations and an
   explicit monomial-size budget, including Boolean and twin terms.

Failure of a proposed law to marginalize consistently, a deterministic
shared low-support channel defeating its mixing estimate, or a needed
parity expansion of the size above should reject that proposed mechanism
promptly. These are possible falsifiers, not results of experiments.

For larger trees one must also charge the number of contexts/copies and
compare the lower-bound exponent with log of the actual output/encoding
length. A superpolynomial-length output cannot be written in time polynomial
in the root seed; its claimed uniformity must specify bit access or
output-sensitive construction. Constant or logarithmic depth and
superpolynomial depth are different contracts. The base indexed q values
do not themselves provide an all-length family.

Finally, the random restriction used in a lower-bound contradiction may
be selected existentially after seeing a hypothetical small certificate.
That is legitimate for the lower bound. It does not make the generator
depend on finding an unknown small proof, or yield an efficient proof
discovery/refutation algorithm. Any proposed compiler or generator
construction that needs such a search must account for it separately.

## Cross-review status

The source and representation challenges above were independently sent
to the root and author before reading the saved author intake. I then
read the entire actual
[author intake](2026-09-12-bamboo-amplification-intake.md), initially SHA256
`3D9C62C4ED72638F3655ABC7FDE3A3723A2AF4FD9D3C85C6DB923A1D2F321547`.
It supplied two concrete operations rather than merely listing a desired
coupling theorem. Their checks are as follows.

First, applying the source restriction in parallel to all nodes does not
retain the old literal-image contract. With the first D/E template rows,
the first common-star block is 6. At block 7 the running prefix offset
contains the variable internal output A_ij once. If that child bit remains
unfixed, the prefix image is A_ij XOR u, up to a fixed sign/complement.
Its real polynomial is a+u-2au or 1-a-u+2au. The endpoint U_N also need
not become constant. The old constant-output literal survival proof
therefore cannot be invoked unchanged. This is a specific failure of
literal closure, not a proof that every replacement shrinkage estimate
must fail.

Second, the author's actual sampler closes each requested complete child
row under all parent rows needed to determine it, samples independent
node source rows, and conditions on the wired equalities. The closure
already requests N parent Y columns at width N, or q at idealized
residual width q. Together with the fixed boundary e it requires N+1
independent vectors in dimension N, or q+1 in dimension q. Such a source
fiber is empty for every choice of its prescribed output data. Thus this
particular source-law sampler fails before its conditioning normalizer,
deletion consistency or PSD can be considered. Allowing dependent frames
would be a different sampler, not a conclusion ruled out by this check.

The author's node, seed, leaf-output, clause and evaluation counts were
checked directly: V=2^(d+1)-1 nodes, V(s+tN) variables, V(6N-3)t gate
clauses, 4s(V-2^d) wire clauses and 2^d t leaf units are correct for the
specified fresh-variable encoding. Its O(V q^5 log(Vq)) explicit indexed
description and O((d+1)q^5) individual-bit evaluation upper bounds are
consistent with that map. Keeping intermediate seeds as witnesses does
not increase the external seed length.

I found two corrections in the actual intake, both disclosed to the
author and root before the final disposition:

1. Contrary to the initial intake, the base all-output hardness DOES
   pass to coordinate projection under the same retained gate encoding.
   Any certificate using only observed-output units remains the identical
   certificate after adding every missing output unit at any completed
   target, with zero multipliers on the new units and unchanged S.
   Therefore projection alone is not the obstruction. It does not prove
   hardness of the coupled tree with variable internal outputs.
2. An uncomplemented two-bit XOR has three monomials, but its complement
   has four. The generic expansion upper bound for K such images is
   4^K, with 3^K applicable when every image is uncomplemented. Either
   estimate lacks the required degree-free original-size control.

The initial source scope reviewer also suggested replacing the undefined
phrase “function-length output” in this record with the precise
“superpolynomial-length output”; that editorial clarification was made.
The projection argument, semantic target and monomial-count corrections
are mathematical contributions to this intake review, not a claim of
verification-only provenance for S3111.

The complete corrected author intake was reread after the projection
correction, and its final XOR/complement cost correction was then
checked in the saved file. Final author SHA256:
`2DB5661AE7727780D341B83FB99AC7648C3D8EAC7325CFEB995D564D49AF9453`
(14,916 bytes). Both corrections are accurate and disclosed there.

**Final independent disposition: PASS for the corrected bounded intake
and its NONE recommendation for the two specified transfer recipes.**
Their literal-image and nonempty-source-fiber requirements fail explicitly;
they are not rejected merely because an asymptotic bound is unproved.
Projection alone is a valid base-hardness transfer and is no longer
counted as a failure. No alternative coupling, amplified theorem, global
impossibility claim or public change is adopted. The root retains the
selection/closeout decision. Frozen for integration.
