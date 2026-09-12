# Bamboo compression intake: unrestricted circuit certificates have a known upper-bound route

2026-09-12; proposed S3105 / S008. Literature intake and route assessment
only; [integrity](../../INTEGRITY-CLAIMS.md). No new force theorem, certificate
implementation, publication or novelty claim is adopted.

**Selection: NONE. Reject unrestricted arithmetic-circuit SoS/IPS size
hardness for this exact family as the next target.** Known short Boolean
matrix-identity proofs and their characteristic-zero IPS simulation give
polynomial circuit certificates. The decisive issue is not an unproved
ability to compress monomials, nor a conjectural field change. The model
must allow circuit compression of the equality multipliers, not just of
the square roots. A roots-only variant is a different, unsettled-by-this-
assessment question.

## Exact starting point and resource being changed

The current graph records public v3.0.0 at
`613ceb80a6211097cd8e353c47ad79ba3069ecb5`, with mathematical source
`ea7a89576712fc21ae0127d688f703dfa05b1af1` and the
[explicit size theorem](2026-09-12-bamboo-size-mechanism.md). Its family is
the unaugmented simple-bamboo CNF on output I_m, where q is even and at
least 1024, N=8q+4, m=q^2. The original input width is N. Its Boolean
clause-falsification equations, including the prefix U variables and
Boolean equations, are over Q or R. The matrix relation expressed on
Boolean solutions is XY=I_m **over F_2**. These two fields have different
roles.

The published lower bound concerns

    sum_i f_i g_i + sum_j h_j^2 = -1,
    S=sum_i ||f_i|| ||g_i|| + sum_j ||h_j||,

where the norms count explicit ordinary monomials, without a degree bound.
The proposed unrestricted compressed model instead measures total
division-free arithmetic-circuit size for the tuple of g_i and h_j,
allowing DAG sharing and no restriction on depth, syntactic multilinearity,
variable order or degree. Either shared multi-output size or the sum of
separate circuit sizes is adequate for the polynomial upper-bound
assessment below; the number of axioms is polynomial in N. Coefficient-bit
cost and exact deterministic verification should be specified separately
from arithmetic gate count.

## Primary results read and their exact use

**Weak-rank source.** Garlik, Gryaznov, Ren and Tzameret explicitly discuss
a polynomial-size NC2-Frege upper bound for WRank in the introduction,
printed pages 5--6. They route through identity rank, the inversion principle
and Hrubes--Tzameret. Definition 6.1 specifies the simple prefix CNF used
here. Its outputs and local parity gates express the ordinary Boolean
matrix-product computation, without the separate product-extension
variables of another encoding. This is the first relevant upper bound to
check, rather than merely its lower-bound results.
[Primary ECCC report](https://eccc.weizmann.ac.il/report/2026/133/).

**Determinant/inversion proof.** Hrubes and Tzameret, *Short Proofs for the
Determinant Identities*, Proposition 12 and Theorem 13(ii), prove short
inversion proofs. Proposition 12 concerns arithmetic proof system P_c(F)
over any field. Theorem 13(ii) interprets the GF(2) case as polynomial-size
circuit Frege proofs of AB=I implying BA=I, with O(log^2 n)-depth lines;
the stated formula-Frege bound is quasipolynomial. Circuit Frege and
Extended Frege are polynomially equivalent. Their rational-field remark
about bit-encoding rational matrix entries is not needed here: the
matrix theorem used below is a Boolean tautology about GF(2) matrices.
[Authors' primary manuscript, Section 2.5](https://users.math.cas.cz/~hrubes/PDFs/DET.pdf),
[journal version](https://doi.org/10.1137/130917788).

**Propositional-to-IPS simulation.** Grochow and Pitassi's primary IPS
paper states, after Proposition 2.2, that Hilbert-like IPS polynomially
simulates Extended Frege. Hilbert-like means linear in the axiom
placeholders. The needed direction is unconditional; the PIT-axiom
hypothesis in their Theorem 4.1 concerns the reverse simulation. IPS
uses a circuit C(z,y) with C(z,0)=0 and C(z,f(z))=1 as formal polynomial
identities. Their Section 1.6 and Proposition 2.2 explain the relation
between a linear-placeholder certificate and its multiplier tuple.
[Primary paper](https://arxiv.org/pdf/1404.3820).

**Field check at the simulation step.** Pitassi and Tzameret's Theorem 3.3
and its displayed proof explicitly arithmetize the Boolean proof over the
rationals or prime finite fields, using 0,1,-1. This is a proof of the
simulation contract by its authors, not an inference that a characteristic-
two polynomial identity stays valid over Q. Their false-is-one translation
maps a clause to exactly its falsification product. The statement uses
3CNF for presentation; its proof starts with the translated input clauses
and places no width-three requirement on the initial-line step. The
constant-width-four clauses here therefore need no new variable encoding.
[Author proof of the simulation, Section 3.2](https://eccc.weizmann.ac.il/report/2016/101/download).

**General IPS to linear IPS, if needed.** Forbes, Shpilka, Tzameret and
Wigderson, Proposition 4.4(2), give a poly(s,t)-size linear-IPS circuit
from size-s circuits for the axioms and a general IPS refutation, where
t is the number of axioms. This circuit case works over any field and
has no polynomial-degree hypothesis. The separate formula case has
additional degree and field-size conditions. Their construction uses a
proved circuit division-by-a-variable lemma; simply differentiating an
arbitrary nonlinear IPS certificate at zero would not prove the required
linearization. Here each axiom has constant-size arithmetic description,
so the circuit-case hypothesis is met. This is a known conversion, not
a new S3105 obligation.
[Primary journal paper, Section 4.1](https://theoryofcomputing.org/articles/v017a010/v017a010.pdf).

## Applicability audit for the exact prefix encoding

The following is an explicit mapping of this instance to the imported
upper-bound results, not a newly claimed matrix theorem or a constructed
certificate artifact.

Select r=N+1 rows of X and r corresponding columns of Y. Since the
original output is I_m and m>N, the corresponding r-by-r product is I_r
under the simple-bamboo clauses. Let X' be the r-by-N selected matrix and
Y' the N-by-r selected matrix. Pad X' by one zero column to obtain an
r-by-r matrix A, and pad Y' by one zero row to obtain B. Then AB=I_r,
whereas the last row of BA is zero. The imported inversion tautology
forces BA=I_r and yields the contradictory bottom-right entry.

This uses a principal subinstance and constants; it does not identify
the simple CNF with the perfect-matching or z-extended encoding. All
product entries above mean Boolean dot parity. The supplied prefix
clauses allow an Extended Frege proof to propagate each U prefix's
equality to that parity computation, and to use the output clauses for
the selected entries. Circuit gates can be named by extension definitions.
There are only O(r^2 N) relevant gate occurrences. Changing from the
sequential prefix representation to the balanced expression in the
inversion theorem can be carried out by polynomially many associativity
steps or intermediate gate definitions; no exponential formula expansion
is required in Extended Frege. Only a polynomial-size EF proof is needed
for this intake's circuit conclusion; no preservation of the exact
NC2 depth through every encoding translation is asserted here.

Next apply the **Boolean proof** simulation over Q. In particular an XOR
gate is arithmetized as a Boolean operation over Q (for truth-valued
coordinates, a+b-2ab), not as the rational sum a+b. Consequently the
simulation returns a rational IPS certificate for the original real
clause-falsification equations and Boolean equations. It does not prove
the false assertion that the original real matrix product XY equals I_m.
Taking a polynomial-size Boolean derivation through this standard
simulation is precisely the field-safe route. No GRH, PIT derandomization,
or unproved cross-characteristic ideal transfer is a hypothesis.

Internal EF extension gates are proof devices, not extra final axioms
that strengthen the input. The EF-to-IPS simulation produces a certificate
for the translated original assumptions. A certificate retaining arbitrary
fresh extension equations without eliminating them would be the wrong
endpoint; that is not the cited simulation contract.

## Equality multipliers and the SoS endpoint

Use either the direct Hilbert-like simulation, or the general IPS
simulation followed by the cited linearization. Write its result as

    C(z,y)=sum_(i=1)^t y_i G_i(z),
    sum_i f_i(z)G_i(z)=1.

If a circuit for C has size s, substitute y=e_i to obtain each G_i with
at most s gates. Copying it t times costs at most O(ts), still polynomial;
the result does not depend on an uncharged multi-output representation.
This elementary coefficient extraction is valid because C is already
linear and C(z,0)=0. It is not extraction of the linear part of an
unrestricted IPS proof. Include the Boolean equations among the f_i.

Set g_i=-G_i and use no square terms. The result is the formal rational
identity sum_i f_i g_i=-1, which is also a real SoS refutation under the
equality-plus-squares convention. If a syntax insists on a square term,
add 0^2. Thus the broad circuit-represented SoS model has polynomial-size
certificates already in its equality-only fragment. There is no remaining
square-positivity construction to discover for this upper bound.

This inference composes established simulations and the explicit instance
mapping above. It is a known-upper-bound **route veto**, not a novelty
claim, a public new theorem, an implemented circuit family, an optimal
polynomial exponent, or another independent review of the imported proofs.

## Known, unsupported, and possible next uncertainty

| Proposed resource or inference | Assessment |
|---|---|
| Explicit monomial size from v3 | Preserved; polynomial circuit descriptions need not have polynomial monomial count. |
| Unrestricted rational/real circuits for all equality multipliers and roots | Polynomial upper-bound route above; reject a superpolynomial lower-bound campaign for this family. |
| General IPS versus linear-placeholder circuit IPS | Known polynomial conversion applies; no open conversion bottleneck here. |
| Only h_j compressed, g_i still explicitly sparse | Different mixed representation; the equality-only circuit upper bound does not meet its sparse-multiplier constraint. No hardness or upper bound established here. |
| Formula, bounded-depth, multilinear, ordered or restricted-ABP certificates | Not settled by the unrestricted circuit upper bound. Each needs its own literature and closure audit; this intake selects none. |
| Proof existence versus finding/checking arbitrary certificates | A small arithmetic circuit is not an automatic deterministic polynomial-time certificate checker. No general automation or SAT consequence is inferred. |

The useful concrete uncertainty, if the orchestrator wishes to continue,
is **which restricted multiplier-and-root representation is intended, and
whether the inversion-to-certificate simulation preserves that exact
restriction at polynomial cost**. A roots-only compression target must
first specify a joint size measure and show why the equality multipliers
cannot exploit the known circuit proof. A formula-only route must account
for the primary inversion theorem's quasipolynomial Frege alternative,
rather than labeling it an unrestricted circuit lower-bound problem.
These are bounded applicability questions for a new literature trigger,
not authorization to launch a fresh force lane.

No restricted-class successor is selected or recommended merely to evade
this upper bound. The distinctions above identify what a materially
different user objective would have to specify, not a new research lane.

No proposed parameter search or generic monomial-expansion demonstration
would answer those questions. The immediate completed recommendation is
to record the unrestricted-circuit upper-bound veto and avoid advertising
compression hardness as the next missing theorem. Stronger claims require
a separately selected model and actual proof/review work.

## Execution record

After completing this independent intake, cross-read the
[independent selection audit](2026-09-12-bamboo-compression-selection-review.md).
It independently reaches the same padded-inversion/Boolean-EF/rational-
Hilbert-like chain and NONE verdict. No substantive disagreement was found.
Its caution about the limitations of Grochow--Pitassi's original Proposition
2.1 is correct; the later Forbes--Shpilka--Tzameret--Wigderson Proposition
4.4(2) checked here additionally resolves general circuit linearization
under the small-axiom condition. Neither argument needs that later result
when the direct Hilbert-like EF simulation is used.

Read the satellite integrity instructions, current research graph, pinned
size source and public v3 context. No satellite AGENTS.md was present.
Browsed the primary sources above and inspected the exact theorem and
simulation passages; temporary downloads were used for text checking.
One author-hosted PDF download failed TLS validation, so its already
available browser-rendered primary text was used without bypassing TLS.
Only this intake file was added to the repository. No mathematical source
change, implementation, experiment, commit, public edit, push, outreach
or paid computation was performed.
