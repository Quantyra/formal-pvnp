# One prescribed high-mass branch on an always-satisfiable wrapper

2026-09-08. S3040 / S008 / E004. Harness-only informal research.
Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-first-branch-2026-09-08.md`.
Read with `INTEGRITY-CLAIMS.md` and the spin-distribution/factor-compression
attempts. The reduction below is elementary and self-contained. No
impossibility, counting-class theorem, converse equivalence, or P=NP result
is asserted. No numerical experiment or implementation is supplied.

## An always-SAT wrapper with a known fallback witness

Let F(x_1,...,x_n)=AND_m C_m be arbitrary CNF. Remove unused declared
variables and relabel the occurring variables in polynomial time. Here
n=0, an empty conjunction, and an empty clause are allowed; their usual
Boolean meanings make the same construction work. Introduce z and exactly
two dummy variables y_1,y_2, with z the prescribed first queried variable.
Define

    H = AND_m (z OR C_m)
        AND AND_(i=1)^n (not z OR not x_i)
        AND (not z OR not y_1)
        AND (not z OR not y_2).                     (1)

For z=0 the first group enforces F while every other clause is true.
For z=1 the first group is true while all x and y bits must be0.
Writing S=#SAT(F), solely as an analysis quantity that need not be computed,

    #SAT(H with z=0)=4S,
    #SAT(H with z=1)=1.                             (2)

Thus H is always satisfiable, with an explicitly known fallback witness
z=1,x=0,y=0, whether or not F is satisfiable. The dummy bits supply the
fixed factor4; no solution or count for F enters their construction.
H has N=n+3>=3 variables and polynomial encoded size in that of F.

## The finite-temperature contamination and strict branch gap

Use the actual Gibbs distribution on H, with penalty tied to the entire
transformed variable count:

    q_H=2^(-2N), w_H(a)=q_H^(V_H(a)),
    Z_H=sum_a w_H(a), pi_H=w_H/Z_H.

Every satisfying assignment has weight1. Every nonsatisfying assignment
has weight at most q_H, irrespective of how many clauses it violates.
If B_0 and B_1 are the total nonsatisfying weights in the two selector
branches, then

    B=B_0+B_1<=2^N q_H=2^(-N)<=1/8,
    Z_H=4S+1+B,
    pi_H(z=0)=(4S+B_0)/(4S+1+B),
    pi_H(z=1)=(1+B_1)/(4S+1+B).                    (3)

If F is SAT, S>=1, and the fallback branch has

    pi_H(z=1)<=(1+B)/5<=9/40<1/4,
    pi_H(z=0)>=31/40>3/4.                          (4)

If F is UNSAT, S=0, and instead

    pi_H(z=0)=B_0/(1+B)<=B<=1/8<1/4,
    pi_H(z=1)>=7/8.                               (5)

These conservative rational bounds avoid interpreting the distribution
as zero-temperature counting. The nonsatisfying assignments are still
present and their total weight has been explicitly bounded. The bounds
also cover n=0, since N>=3 regardless of F.

## A one-call reduction with only a satisfiable-input promise

Consider a deterministic primitive with this limited contract:

    Given a satisfiable CNF and a prescribed first variable z,
    return a bit b with true Gibbs probability Pr[z=b]>1/4,
    in time polynomial in the supplied formula's total encoded length.

The penalty is always 2^(-2N) for that supplied formula. The primitive
need not estimate the probability, handle conditional prefixes, or have
any runtime/correctness guarantee on UNSAT inputs for this reduction.
Both possible promised branches are interpreted using the original
selector convention of (1): z=0 is the F branch; z=1 is the fallback.

Given arbitrary F, construct H, make exactly one call at its prescribed
first variable z, and return YES for b=0 and NO for b=1. Equation (4)
excludes b=1 when F is SAT; equation (5) excludes b=0 when F is UNSAT.
Every query is promised-SAT, including queries constructed from UNSAT F.
Therefore a uniformly polynomial primitive with just this promise would
give a deterministic polynomial-time SAT decision algorithm. The wrappers
even have an efficiently supplied fallback witness, if a proposed
primitive requests one.

This is strictly a prescribed-selector, first-query reduction. If a
procedure may freely choose another variable, it need not answer this
question and the one-call argument does not apply unchanged. Nor does
this reduction assume it supplies high-mass decisions on all prefixes or
along every adaptive path. It isolates the first branch alone.

An additive-1/8 estimate of pi_H(z=0) is also enough: in the SAT case
the estimate is at least31/40-1/8=13/20, while in the UNSAT case it is
at most1/8+1/8=1/4. Threshold1/2 decides. But a probability estimate is
not required for the high-mass-branch reduction above.

Finding any satisfying assignment of H is easy by the fallback. Returning
that fallback branch does not satisfy the high-mass contract when F is
SAT. Thus this construction separates finding an available witness from
certifying or selecting a branch with substantial Gibbs mass; it does not
claim ordinary SAT search is hard on these always-SAT wrappers.

## Width-at-most-three version with uniquely determined gates

The clauses z OR C_m can have arbitrary width. To obtain 3CNF, where
3CNF here means width at most3, build a polynomial-size acyclic Boolean
circuit computing the same function H on the N original wrapper inputs.
Binary AND/OR gates, NOT gates, and constants suffice. Long conjunctions
and disjunctions are binary trees. Introduce one fresh variable g per
gate and impose its full functional equivalence, not merely one direction:

    g = a AND b:
      (not g OR a), (not g OR b), (g OR not a OR not b);

    g = a OR b:
      (g OR not a), (g OR not b), (not g OR a OR b);

    g = not a:
      (g OR a), (not g OR not a).

Constants are pinned by unit clauses. Pin the final output gate to1.
Let the resulting formula be G, with N_star total variables, including
every gate variable. Keep z as the prescribed first input variable.

For every assignment to the wrapper inputs, topological gate evaluation
gives exactly one assignment satisfying all gate equivalences. That
extension satisfies the output pin exactly when H is true. Conversely,
the equivalences force every gate value in any satisfying assignment.
Therefore the satisfying counts by selector remain EXACTLY

    #SAT(G with z=0)=4S,
    #SAT(G with z=1)=1.                             (6)

The fallback extends uniquely by evaluating the circuit, in polynomial
time. Use q_G=2^(-2N_star), not q_H and not the original F-variable count.
Every nonsatisfying full assignment has weight at most q_G, so its total
weight is at most2^(-N_star)<=1/8. Equations (3)--(5) apply verbatim with
these newly defined branch bad weights. The same one-call reduction thus
holds for width-at-most-three CNF.

This conversion preserves satisfying multiplicities by unique extension;
it does NOT preserve the Gibbs weights of nonsatisfying wrapper inputs.
Those weights need not agree and are instead controlled by the new global
bad-weight bound. Naively splitting long clauses with unconstrained
auxiliary choices would not justify (6). No claim about exactly-three-
distinct-literal syntax is needed here.

## Bit work and the precise remaining implication

The direct wrapper, the binary circuit, the functional clauses, and the
fallback extension all have polynomial construction/evaluation cost.
N_star is polynomial in the original input length. Writing the rational
penalty needs only 2N_star+1 denominator bits. An individual Gibbs weight
has polynomial bit length in the transformed variable and clause counts.
None of these facts computes a partition sum or the high-mass branch.
The algorithm constructing the oracle input never computes S, B_0 or B_1;
they occur only in the proof of its answer gap.

The concrete outcome is a one-call polynomial reduction to a substantially
weaker inference promise than a general conditional-marginal oracle:
an always-SAT input with a known fallback witness, a specified first bit,
and a single required high-mass choice. Any successful implementation of
that promise would already supply the missing general SAT decision work.
This establishes neither impossibility of such an implementation nor a
converse from P=NP to the inference promise. Arbitrary variable selection,
uncontrolled randomized answers, or an easy fallback witness are not
substitutes for the specified deterministic guarantee. The full research
objective remains unresolved; no code, simulations or commits are made.
