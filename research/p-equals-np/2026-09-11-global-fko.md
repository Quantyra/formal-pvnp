# Global FKO attempt: implicit signed walks and the upper-certificate gap

2026-09-11; S3067. An informal mechanism investigation under the [integrity boundary](../../INTEGRITY-CLAIMS.md). The [primary-source companion](2026-09-11-global-fko-sources.md) supplies the exact current rooted-Kikuchi operator and comparison algorithms. No experiment, implementation, faster refuter, novelty claim or general lower bound is supplied.

**Attempted advantage:** replace a vector indexed by every lifted state with polynomial-cost random walks that query the global operator implicitly. The exact walk/trace identity succeeds. The proposed upper-certification step does not: the normalized moment requires dimension-dependent accuracy, and a statistical enclosure alone does not satisfy the source's pointwise-sound certificate contract. A negative closed walk provides a checked odd dependency, but neither useful return frequency nor sufficient bounded-overlap output follows. We did not obtain an improved FKO finder.

## The exact operator being queried

Retain the random 3-CNF target m=ceil(C n^(7/5)) and level ell=Theta_C(n^(1/5)), within the relevant primary theorem's parameter conditions. The lifted states are ell-subsets S of [n], with

    N=binom(n,ell),    log N=Theta(ell log(n/ell)).

The current odd-arity refutation construction roots every input clause a as (u_a,C_a), where C_a contains its other two variables. All clauses remain accounted for. Its cell at root u and state S consists of clauses rooted at u whose residual pair has exactly one variable in S. A same-root pair a,b with disjoint residuals defines T=S symmetric-difference C_a symmetric-difference C_b. The edge is retained only when both endpoint cells contain exactly that pair. Its sign is y_a y_b. At most one retained channel meets each root/state cell.

Write C for the signed adjacency, retaining parallel root channels in its sum; write G(S) for the source's capped nonnegative diagonal, and Gamma(S)=G(S)+d_*, where d_*>0 is the exact rational floor in the source. The matrix is

    H=Gamma^(-1/2) C Gamma^(-1/2).

The number of retained channels incident to S is at most G(S). This yields the known pointwise bound ||H||<=1. The source refuter needs a certified U>=max(0,lambda_max(H)), together with its complete diagonal and defect accounting; a Ritz value is a lower bound and cannot substitute. [The Kikuchi Hierarchy is Sharp for kXOR, Section 9.2, equations 9.3-9.10 and Figure 3](https://arxiv.org/pdf/2607.29672).

A row can be generated from a given S by scanning the rooted clauses, forming its cells, checking candidate pairs and their neighbor cells. This is polynomial in the explicit input and state encoding; no enumeration of all N states is required for one row. Computing a matvec on an unrestricted vector still has N coordinates. We attempt to avoid that operation, rather than claim that a simple row oracle already performs it.

## Selected mechanism: killed signed walks

For a current state S, assign transition probability 1/Gamma(S) to each retained root channel. The channel leads to its neighbor T and carries sign sigma in {+1,-1}. The unused probability

    1 - (number of retained channels at S)/Gamma(S)

goes to a cemetery state, because the numerator is at most G(S)<Gamma(S). This is a valid substochastic transition rule. Multiple channels to the same neighbor are sampled separately. Aggregating their signed probabilities gives

    P_signed=Gamma^(-1) C
            =Gamma^(-1/2) H Gamma^(1/2).

Thus this signed transition matrix is similar to H, even though it is not itself a probability matrix. The actual walk samples the unsigned channel probabilities and records their sign product.

Choose S_0 uniformly from all ell-subsets, which can be sampled using O(ell log n) random/input bits up to ordinary sampling overhead. For a walk of length 2p, output Y=0 if killed or if S_(2p) differs from S_0. Otherwise output the product of its channel signs. Then Y is in {-1,0,1}, and exactly

    E[Y]=(1/N) tr(P_signed^(2p))
        =(1/N) tr(H^(2p))=:mu_p>=0.                      (1)

The diagonal similarity factors cancel on closed walks. This derives the identity without materializing an N-dimensional vector. Conditional on a fixed input and fixed rooting, all quantities are well-defined; no random-input spectral assertion is used in (1).

A single walk takes 2p polynomial-cost row queries and stores one lifted state, its starting state, the sign and, if desired, the clause-channel history. Gamma is rational, so exact channel sampling can use integer rejection with charged expected bit cost; a fixed execution cap must abort the estimator and report no certificate rather than silently approximate transition probabilities or discard incomplete walks and average a biased surviving sample. For the source's rational d_* the denominator descriptions have polynomial bit length in the explicit parameters. This is a genuine implicit-query construction, not an assertion that the final spectral problem is solved.

## Why the upper-moment step loses the proposed advantage

For symmetric H, every eigenvalue contributes nonnegatively to an even trace moment, so

    ||H|| <= [tr(H^(2p))]^(1/(2p))
           = [N mu_p]^(1/(2p)).                          (2)

Using the norm rather than only lambda_max is conservative. If the spectrum has many comparable magnitudes, the standard bound can lose a factor up to N^(1/(2p)). To limit this dimension factor to a fixed constant requires p=Omega(log N)=Omega(ell log(n/ell)). This is a worst-case certificate bound, not a statement about the actual spectrum of each random input; a sharper effective-rank theorem could alter it, but none was supplied here.

The proposed estimator takes R independent walks on the fixed operator, computes the sample mean barY, and uses the distribution-free Hoeffding enclosure

    mu_p <= barY+eta with probability at least 1-delta,
    eta=sqrt(2 log(1/delta)/R).

This is the natural straightforward way to turn (1) into a global upper estimate. To resolve the scale needed for a target U=u<1 in (2), the additive error must be comparable to or smaller than

    u^(2p)/N.                                            (3)

For example, on the entirely possible observed transcript barY=0, this enclosure yields a value below u only if

    R > 2 N^2 u^(-4p) log(1/delta).                       (4)

Since N=exp(Theta(ell log(n/ell))), this sufficient sample budget for the chosen enclosure is already exponential in the lifted level scale. It does not remove the known n^O(ell) cost. Taking larger p reduces the root's dimension factor but makes the target normalized moment u^(2p)/N smaller; these two requirements must be charged together.

Equation (4) is NOT an information-theoretic lower bound against all moment estimators, nor a theorem that this particular random Kikuchi operator requires that many samples. It diagnoses the exact failed step in the selected distribution-free additive-error construction. Variance reduction, an analytically justified majorant, or other instance-specific structure might improve it, but they need their own bounds. We do not import a generic hidden-eigenvalue example as if it were this matrix's spectrum.

Even a successful statistical upper estimate is not the source's pointwise-sound refutation certificate. On a fixed input it has an exceptional probability delta of underestimating the norm. Returning UNSAT from that estimate alone can therefore violate the all-input/all-rooting certificate guarantee. Rechecking a proposed certificate is possible only if an independently sound upper-bound certificate was actually produced; the samples themselves do not supply such a certificate. Setting delta very small does not turn it into an exact implication.

The coarse rowwise domination bound proves ||H||<=1 without these samples. Refining it using a bound on max G can give a value below one because d_*>0, but no sufficiently small useful target is derived here. For example, replacing all unvisited diagonal terms of H^(2p) by the valid upper bound 1 leaves their total possible contribution charged explicitly; it cannot silently assign them zero. The missing operation is a useful, cheaply verified bound on those global contributions.

## Witness extraction: an exact positive identity with missing yield

A returned negative closed walk can be converted into an ordinary, checkable FKO tuple. Fix Boolean variables x in {0,1}, clause negative-literal parity nu_c, b_c=1+nu_c modulo two, and y_c=(-1)^(b_c). Then y_c is the target sign for the clause XOR equation a_c dot x=b_c in spin coordinates. The surviving even-incidence tuple has even cardinality, so its product y_c equals (-1)^(sum_c nu_c). Globally negating every y_c therefore gives the same tuple product; a negative product is precisely odd total negative-literal parity. Each channel is labeled by two original clause IDs a,b with the same root. Their full incidence vectors XOR to C_a symmetric-difference C_b because the root cancels. Along a closed lifted walk, these differences XOR to zero.

Reduce all clause-ID multiplicities on the walk modulo two. The surviving distinct-ID set T has even variable incidences. Its clause-sign product is the walk sign; a negative sign makes T nonempty and inconsistent. If the walk has 2p steps, then

    |T|<=4p.                                             (5)

This factor of two per step is essential for the odd-arity rooted operator. Verification and cancellation take polynomial time in the explicit walk length and input indexing. Positive returns need not supply anything: backtracking can cancel every clause ID, leaving the empty set.

This extraction does not solve the discovery problem. Equation (1) controls a signed difference of return masses, not a useful lower bound on negative-return probability. Unsigned backtracking returns can dominate; a small signed moment can involve rare returns or cancellations. No probability of obtaining a distinct negative tuple, no overlap bound across repeated walks, and no weighted packing guarantee was derived.

The direct FKO path would still require checking distinct tuples and clause loads and achieving t/d>(I+nL)/2, as in the [existing certificate contract](2026-09-11-fko-discovery.md). Duplicate outputs do not improve normalized mass. At the generic constant-dimension-slack moment order p=Theta(ell log(n/ell)), (5) guarantees only an O(n^(1/5) log n) support bound, rather than the desired O(n^(1/5)). This is a weakness of that guaranteed length, not proof that actual returned tuples cannot be shorter. A smaller moment order might be useful for tuple search, but the yield/coverage analysis would then be a separate missing theorem, not supplied by (2).

## Complete resource and soundness boundary

This attempt avoids storing the entire lifted vector and makes one walk inexpensive. It does not make arbitrary powers, trace accuracy or spectral certification inexpensive merely because rows are locally computable. Costs include every failed or killed walk, channel probabilities, p, R, random starting-state generation, rational bit operations, and any recorded witness histories. Processing retained tuples additionally includes duplicate detection, loads, rational packing and the final FKO numerical certificate.

If used as an alternative strong refuter, an upper bound for H is not the whole source certificate. The scalar capped-diagonal trace, omitted-edge defect and intersecting-pair count in equation 9.10 must still be computed or soundly bounded for all clauses. Local row access does not automatically provide those global sums. No complexity reduction for these terms was established.

The current primary algorithm retains n^O(ell) total cost at the relevant ell scale, with exact upper enclosures and all-input accounting. Its inference procedure, which can use a high-Rayleigh vector and validation, is a different task from its refutation procedure; we have not transferred the former's lower-bound query into the latter's upper certificate.

No quantum implementation is selected. Preparing a uniform superposition of lifted states or querying channels coherently would not, by itself, solve the accuracy, one-sided certification, witness support or packing obligations derived above. Without a concrete resource and output analysis, that is not an advantage claim.

## Disposition

The global-query bridge is exact: signed killed walks estimate normalized even trace moments, and a negative closed return yields an explicit odd dependency. The proposed polynomial-cost upper-certification bridge fails at dimension-sensitive accuracy and pointwise soundness; the witness route additionally lacks a yield and coverage theorem. Those are specific missing operations, not an assertion that global adaptive discovery is impossible.

No improved algorithm, novel mechanism or new experiment is selected. A substantive continuation would need an actual structured moment majorant, variance/return-yield theorem with useful costs, or another sound global certificate construction; merely naming one does not supply it. The present attempt ends with the failed derivation preserved rather than claiming that implicit storage removed the computational bottleneck.
