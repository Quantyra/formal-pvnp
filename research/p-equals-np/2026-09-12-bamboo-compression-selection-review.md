# S3105 independent compression-route selection audit

2026-09-12; S008 frontier intake. Reviewer: `bamboo_size_fresh`.
**Selection verdict: NONE for an unrestricted circuit-compressed SoS
lower-bound continuation on the exact S3103 bamboo family.** The current
evidence points to polynomial-size compressed certificates through known
Boolean linear-algebra proofs and Hilbert-like IPS simulation. No weaker
artificial circuit class is proposed to preserve a lower-bound project.

This is research selection, not a theorem/release gate. I read the latest
[size theorem](2026-09-12-bamboo-size-mechanism.md) and the S3103/S3104
entries of the [research graph](2026-09-11-research-meta-graph.md), then
searched and read primary literature independently. I did not rely on
the author's future intake verdict.

## Imported upper-bound evidence

Garlik--Gryaznov--Ren--Tzameret explicitly state a polynomial-size
NC2-Frege upper bound for WRank, through the identity-matrix case and
the inversion principle; see the cached primary text, printed pp.5--6.
This directly challenges treating weak rank as hard for unrestricted
circuit proofs. Their Section 6 clause list provides the precise simple
bamboo premise used below. [Primary report, ECCC TR26-133](https://eccc.weizmann.ac.il/report/2026/133/).

Hrubes--Tzameret prove polynomial-size NC2-Frege proofs of the determinant
identities and the inversion principle `PQ=I -> QP=I` for matrices over
GF(2). They also explain that NC2-Frege uses polynomial-size Boolean
circuits of logarithm-squared depth; it is not ordinary formula Frege.
Their ordinary Frege bound is quasipolynomial, which must not be silently
upgraded. [Short Proofs for the Determinant Identities, abstract and
Introduction](https://arxiv.org/pdf/1112.6265).

Grochow--Pitassi distinguish a general IPS certificate C(x,y), with
`C(x,0)=0` and `C(x,f(x))=1`, from a Hilbert-like certificate
`sum y_i g_i(x)`, linear in the placeholders. Their Section 1.3.3 explicitly
states Hilbert-like IPS p-simulates Extended Frege. This stronger, linear
target is the relevant route here. Their Proposition 2.1 gives a
general-to-Hilbert-like conversion with costs depending on placeholder
degree and sparsity; it does not license an unconditional polynomial
conversion of every small nonlinear certificate. Their Theorem 3.1
also connects superpolynomial Hilbert-like lower bounds for Boolean
tautologies to VP versus VNP. [Circuit Complexity, Proof Complexity,
and PIT, Sections 1.3.3, 2.1 and Theorem 3.1](https://www.cs.toronto.edu/~jgrochow/grochow,pitassi-circuitsProofsPIT.pdf).

## Exact Boolean encoding transfer: audited inference

The following specialization is my analytic applicability check of those
imports, not a quotation of a source theorem about our named artifact.
It is not a new lower-bound construction.

The original CNF contains all base relations `u_(i,j,1)=x_(i,1)y_(1,j)`,
all prefix transitions `u_(i,j,k)=u_(i,j,k-1) XOR (x_(i,k) AND y_(k,j))`,
and all outputs `u_(i,j,N)=delta_ij`. Each gate relation is encoded by
the complete constant-size clauses given in Definition 6.1. Boolean
Frege/EF can derive the gate equivalence from these clauses at constant
cost. Induction along each prefix identifies its final value with the
GF(2) dot product using polynomially many circuit-proof steps. Sharing
these prefix calculations is permitted in EF. Thus the CNF efficiently
implies the Boolean matrix equation XY=I_m.

Only the first r=N+1 indices are needed; m=q^2>N supplies them. Restrict
X to its first r rows and Y to its first r columns to obtain matrices
X' of shape r by N and Y' of shape N by r, with X'Y'=I_r.
Let P be X' with a zero last column, and Q be Y' with a zero last row.
Then PQ=I_r. Substitute these matrices into the known GF(2) inversion
proof to obtain QP=I_r. But Q's last row is zero, so the last diagonal
entry of QP is zero, contradicting I_r. Padding, selecting the needed
clauses, and the zero-row calculation have polynomial Boolean proof
cost. Instantiating the inversion theorem at r=O(N) has polynomial cost
as well. This supplies the exact bridge from the original simple bamboo
CNF, without using z-variables or changing the instance to a real matrix
equation. Extra unselected clauses do not weaken the refutation.

NC2 circuit proofs are available within EF by introducing Boolean gate
definitions. The Hilbert-like EF simulation therefore applies to the
same unsatisfiable Boolean CNF. Applied over Q, hence R, with its clause
falsifiers and Boolean equations, it yields polynomial-size circuits
for an identity `sum f_i g_i=1`. The deduction/refutation presentation
and constant-width CNF translation are standard parts of this simulation;
there is no need to assume PIT is efficiently provable in EF to use
the direction EF to IPS. The reverse direction is a different issue.

Negating the multipliers gives the exact real SoS identity
`sum f_i(-g_i) + 0 = -1`, with an empty sum of squares (or zero root).
Thus a polynomial-size Hilbert-like circuit certificate is already a
circuit-SoS refutation when both multipliers and roots may be circuits.
Polynomially many multipliers mean that counting separate circuits
instead of a shared multioutput DAG changes this upper bound by at most
a polynomial factor. Optional twins can be ignored: the untwinned
certificate remains valid with unused extra equations, or transferred
by their complement equations at polynomial circuit cost.

This intake records the applicability chain; it does not supply a
machine-checked certificate generator or an explicit numerical size
polynomial. Such an implementation guarantee is absent. It is unnecessary
for selecting against a superpolynomial lower-bound search in this
unrestricted model.

## Characteristic and representation traps

There is no field embedding GF(2) into R respecting one. In particular,
the parity transition is not the real equality `b-a-xy=0`.
Its Boolean arithmetic representation over R can be written
`b=a+xy-2axy` on Boolean points. Therefore a GF(2) determinant identity
cannot simply be reinterpreted as the desired real ideal certificate.
Nor does knowing that det has small arithmetic circuits establish that
these real clause polynomials have small multiplier circuits.

The audited transfer passes through Boolean proofs of GF(2) statements
and then their real Hilbert-like arithmetization. It preserves the parity
semantics instead of transporting field operations. That is why the
field mismatch does not rescue the unrestricted compressed lower-bound
proposal, but would invalidate a direct determinant-over-R shortcut.

The old theorem counts original expanded monomial occurrences. A small
DAG can denote exponentially many such occurrences. Restriction preserves
small circuit size, but no theorem here makes each resulting output
monomial have small typed-row support with the needed probability.
Union-bounding over gates is not the original occurrence union bound:
a gate's output may contain many high-support monomials, and the PSD
functional cannot be applied outside its support domain. This is the
exact missing guarantee in the proposed lower-bound mechanism, not an
unaccounted constant. Given the upper-bound chain, a universal guarantee
strong enough to force the same contradiction for all small certificates
cannot hold in this unrestricted model.

If only roots were compressed while multipliers remained explicitly
expanded and charged, that would be a different mixed representation
model. The upper-bound argument here concerns compression of the whole
certificate; I do not claim it settles that mixed model or nominate it
as a successor merely to evade this obstruction.

## Falsifiable decision and remaining frontier

The proposed mechanism was: replace occurrence counting with polynomial
circuit accounting while retaining row-space PSD and semantic clause
annihilation, to prove a superpolynomial circuit-SoS bound. It fails the
research-selection challenge above. A concrete falsifier is the
polynomial-size EF-to-real-Hilbert-like certificate family obtained from
the padded inversion proof; roots are unnecessary. A challenge to this
selection would have to identify a precise failure in the local
clause-to-gate derivation, square padding, Boolean inversion proof,
or Hilbert-like real simulation. Merely pointing to characteristic two,
or to the nonlinear form of general IPS, does not identify such a failure.

There is no surviving unrestricted compression lower-bound test to
launch from this intake. If an explicit upper-bound artifact is later
independently valuable, its bounded task would be to instantiate and
verify the above known simulation chain and state its model/size costs;
that would document a representation separation, not advance the current
lower-bound frontier. I do not recommend inventing a restricted circuit
class solely to obtain another result.

Proof existence, constructing this recognizable family's proofs, and
discovering proofs for arbitrary CNFs are separate guarantees. The
literature upper bounds concern proof size and simulations of supplied
proofs. They yield no general SAT algorithm, efficient proof search,
or P-versus-NP conclusion. The S3103 explicit monomial-size theorem is
unaffected, since circuit succinctness is exactly what it does not charge.

Only this owned intake review was written. No implementation, public
artifact change, commit, push, release, outreach, or spend was performed.
