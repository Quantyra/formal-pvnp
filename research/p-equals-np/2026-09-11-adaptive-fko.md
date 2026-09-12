# Adaptive FKO discovery: separating geometric progress from clause signs

2026-09-11; S3065. An informal mathematical attempt under the [integrity boundary](../../INTEGRITY-CLAIMS.md), continuing the [S3064 certificate and sampling analysis](2026-09-11-fko-discovery.md). No implementation, experiment, improved refutation algorithm, novelty claim or P versus NP result is supplied. The [source comparison](2026-09-11-adaptive-fko-sources.md) records the exact prior mechanism and current theorem contracts.

**Outcome:** a formula-aware version of focused growth can postpone all sign tests. We prove that this removes one genuine probabilistic obstacle: any sufficiently large, distinct, bounded-load family found from unsigned incidences alone supplies approximately half as many inconsistent tuples, even if its geometric construction was adaptive. What remains unproved is that the growth policy produces enough short, distinct tuples. A current uniform even-cover theorem survives arbitrary deletions, but its guaranteed length and unspecified search cost do not close that gap.

## One selected mechanism and its prior-art boundary

Wu et al. already grow a subformula by choosing a boundary clause with maximum overlap with the variables exposed so far, test XOR inconsistency, prune the result and repeat under clause-use limits. Their weighted variants and focused-growth experiments are not a polynomial-success theorem at m=C n^(7/5). We retain that incidence-aware growth rule; we do not present it as new. [Wu et al., Section IV.3](https://arxiv.org/pdf/1303.2413).

Relative to Wu's stopping rule, the modification is **geometric discovery first, signs last**. FKO already uses unsigned collection construction followed by sign filtering in Section 3.4; that general architecture is not new here. Stopping at the first unsigned dependence, rather than the first sign-inconsistent dependence, makes the entire selected family independent of literal signs. This may spend capacity on tuples later discarded; that loss is explicit. We have not established that this modification improves the practical algorithm or is itself novel.

Use m independently sampled signed clauses on three distinct variables, with occurrence IDs. Fix K=ceil(A n^(1/5)), capacity d=ceil(D n^(1/5)), and a polynomial attempt budget Q, where A,D are positive constants chosen before seeing the input. The procedure is:

1. Maintain an integer load per clause, initially zero. An available clause has load below d. Choose a seed uniformly among available IDs, using randomness independent of signs.
2. Let S be the selected growth prefix and U its exposed variables. Among available clauses outside S intersecting U, choose one maximizing the number of variables it shares with U; break ties uniformly, independently of signs. If none exists, this attempt fails.
3. Maintain Gaussian elimination on the unsigned incidence columns. Stop at the first linear dependence, or after K selected clauses. At the first dependence, previous columns are independent, so elimination returns its nonempty fundamental circuit T, with |T|<=K. If T was recorded before, count the attempt as failed; do not assume an uncharged search for a different circuit.
4. Record a new T and increase loads only on T. All transient prefix clauses outside T remain available. A failed attempt changes no loads. Repeat until Q attempts have been made or no clause is available.
5. Only after geometric selection ends, read signs, retain inconsistent tuples, and verify the FKO inequality with a certified spectral upper bound. Otherwise return no certificate.

Every incidence decision, seed, stopping test, duplicate rejection and capacity update before step 5 is sign-blind. The method is adaptive to the actual formula's unsigned structure. It is not an independent-restriction method, and S3064's failure proposition does not apply.

This policy has a concrete polynomial execution budget, but bounded execution is not successful refutation. Raw incidence cycles or a nonempty hypergraph core are not substitutes for its Gaussian test. For example, the four triples on four vertices, each omitting a different vertex, have incidence matrix I+J over GF(2). Since J^2=0 in dimension four, (I+J)^2=I: this minimum-degree-three hypergraph has no nonzero dependency.

## A proved reduction of the sign obligation

Condition on all unsigned supports and all sign-independent algorithm randomness. Suppose the output is t distinct nonempty even-incidence clause subsets T_1,...,T_t, each clause in at most d subsets. The conditional family is now fixed, regardless of how adaptively its supports were discovered.

For clause c let eta_c be its negative-literal parity. In the independent signed-clause model, the eta_c are independent uniform bits conditional on the supports. Let Z_j indicate that sum_{c in T_j} eta_c=1 modulo two. Each Z_j is Bernoulli(1/2). For distinct T_i,T_j, their distinct nonzero incidence vectors are linearly independent as a pair over GF(2). Thus the two parity bits are jointly uniform and

    E[sum_j Z_j]=t/2,    Var(sum_j Z_j)=t/4.

For every fixed epsilon in (0,1/2), Chebyshev therefore gives

    Pr[t_odd < (1/2-epsilon)t | supports, geometric randomness]
       <= 1/(4 epsilon^2 t).                              (1)

No disjointness, fresh clauses after deletion, or joint independence of all tuple parities is required. Pairwise independence suffices. Filtering preserves the original load cap d. Distinctness is essential: repeated copies have perfectly correlated signs and do not support this variance calculation. This is an elementary calculation, not an asserted novel concentration theorem. FKO already separates unsigned collection construction from sign filtering in Section 3.4; the calculation here states explicitly why sign-blind adaptive selection does not invalidate the conditional argument.

The same statement extends to geometrically chosen rational weights y_T: distinct tuple indicators give variance (1/4) sum_T y_T^2. Small individual weights can improve concentration, but their discovery and load feasibility remain separate obligations.

### What would suffice for a full random-formula certificate

Retain the exact all-input verification from S3064. Put H=(I+nL)/2, with L a certified upper bound on the maximum eigenvalue of the original FKO matrix. A retained family certifies UNSAT if t_odd/d>H. A XOR contradiction alone does not certify the OR formula.

Suppose an unsigned discovery theorem supplied t>=t_0 with probability 1-o(1), and an existing spectral/imbalance estimate supplied H<=H_0 with probability 1-o(1), with

    (1/2-epsilon)t_0/d > H_0.                             (2)

Equation (1) and a union bound then give a sound certificate with probability 1-o(1), provided t_0 tends to infinity. Independence between H and the odd tuple count is unnecessary. Their bad events are simply added. This uses a high-probability deterministic bound H_0 rather than pretending the sign-dependent H is fixed during conditioning.

At fixed sufficiently large C, the intended scales are H_0=O_C(n^(6/5)), d=Theta(n^(1/5)), t_0=Theta_C(n^(7/5)); the constants in (2) must actually have slack. These scales do not prove that our procedure attains t_0.

For sampling without replacement, conditional independence of signs need not hold for every unsigned multiset. Instead couple the entire run to independent sampling: collision probability of signed clauses is O_C(n^(-1/5)). Transfer asymptotic joint success or failure through that coupling, without asserting a false exact conditional independence statement in the other model.

## Attempted adaptive progress proof: the exact missing step

We tried to derive geometric progress from the fact that the greedy rule maximizes observed overlap. That does not yield a short dependency bound.

For a fixed set U of u variables independent of the random formula, the expected number of clauses having at least two variables in U is O(m u^2/n^2). At u=Theta(n^(1/5)) this is O(n^(-1/5)). But U in our algorithm was selected using the same clause incidences, and the choice explicitly favors overlaps. Substituting the adaptive U into this fixed-set expectation is invalid. The formula has been inspected, so an unobserved 'fresh random remaining hypergraph' is not available after each choice.

Conversely, the existence of many short even sets in the whole hypergraph does not force a maximum-overlap trajectory to encounter one, nor force repeated trajectories to cover different clause IDs. The first dependency may use only a subset of the growth prefix. A count of exposed variables or apparent closure steps in the whole prefix cannot be assigned to that circuit without proof. Minimizing support among all dependencies would be another operation, not ordinary Gaussian elimination.

The precise missing sufficient lemma can be stated without concealing it as an oracle. For typical unsigned inputs, and every history reached before t_0 accepted tuples, prove that an attempt produces a **new** circuit of size at most K with conditional probability at least p, while sufficient available clauses remain. If Qp>=2t_0, standard lower-tail bounds for adapted Bernoulli trials with this conditional lower bound would make Q attempts sufficient with exponentially small failure in t_0. For example p of order n^(-1/5) and Q of order n^(8/5) fit the desired t_0 scale. No such conditional lower bound was obtained; seed failures, duplicate circuits, cap depletion and tie choices are included in the obligation, not ignored.

One part of the depletion accounting is deterministic. After t accepted tuples, at most Kt clause incidences have been charged. The number of saturated clauses is at most Kt/d. Therefore, if

    K t_0/d <= (1-theta)m                                (3)

for a fixed theta>0, at least theta m clauses remain available until the target is reached. Condition (3) must be checked with the constants needed in (2). It does not imply that the remaining clauses have their original random distribution or that the growth rule finds a new circuit there.

This is a failed progress derivation, not a theorem that adaptive focused growth fails. In particular we do not replace the selected method by an oblivious algorithm to obtain another lower bound.

## Can a uniform even-cover theorem repair the argument?

A July 2026 primary result proves the hypergraph Moore bound for all uniformities, including three: there are constants c_3,C_3 such that every simple 3-uniform hypergraph with

    M >= c_3 n sqrt(n/rho)

contains a nonempty even cover of size at most C_3 rho log n, for 1<=rho<=n. It applies to every residual simple hypergraph, even after adversarial deletion. Thus fresh random residuals are unnecessary for this **existence** assertion. Its proof uses much larger lifted search structures; it is not a guarantee for the single focused trajectory above. [Bandeira et al., Theorem 1.2](https://arxiv.org/pdf/2607.14068v2).

Here is the exact tradeoff if we generously assume those covers could be found. At residual density M>=theta m with m=ceil(C n^(7/5)), choose

    rho = ceil((c_3/theta C)^2 n^(1/5)),
    L = ceil(C_3 rho log n) = O_{C,theta}(n^(1/5) log n).

Ceilings and the residual threshold can be adjusted by fixed constants. These parameters lie in the theorem's range for sufficiently large n. On an initially simple unsigned hypergraph, delete disjoint covers until fewer than theta m edges remain. The theorem ensures existence at every earlier step, and each deletion removes at most L edges. Hence this reasoning guarantees at least order

    (1-theta)m/L = Omega_{C,theta}(n^(6/5)/log n)

disjoint covers. Sign filtering then retains a constant fraction with high probability by (1), at d=1.

This **guaranteed count** is a logarithmic factor below the sufficient n^(6/5) FKO bound obtained from H_0. It does not show that the actual packing has only this many tuples: the covers could be shorter or a better overlapping packing could exist. It shows that the stated theorem plus this deletion accounting does not prove the required inequality at fixed C. Removing the log in the needed packing estimate would require additional structure or analysis. Reducing rho by a factor log n to force the guaranteed cover length down to O(n^(1/5)) raises the required density by sqrt(log n), which exceeds fixed C n^(7/5) asymptotically.

Repeated unsigned supports have probability O_C(n^(-1/5)) in our random input, so restricting this comparison to the initially simple event costs o(1). The selected algorithm itself still works on occurrence IDs without that assumption.

Most importantly, the hypothetical finder in this comparison is not implemented or assumed by the selected policy. A uniform existence theorem can repair the residual-existence premise while leaving both discovery cost and sufficient packing unresolved. The current sharp Kikuchi refutation comparison, including its n^O(ell) cost at ell of order n^(1/5), is recorded in the source companion; it is not a polynomial focused-growth guarantee.

## Charged execution and disposition

Every attempt scans the actual available clauses to choose maximum overlaps; no maximum clique, sparse-dependency or pricing oracle is used. At most K columns are selected and at most 3K variables exposed. A direct implementation uses O(Km+K^3) elementary incidence/GF(2) operations per attempt, with compact provenance on at most K selected columns. Clause-ID and input accesses add their ordinary logarithmic bit factors. Duplicate testing may use explicit sorted tuple lists; even a straightforward polynomial scan of the stored family is charged. Q attempts therefore remain polynomial for fixed A,D and polynomial Q, including all failures. This is a work upper bound for the bounded policy, not a success theorem.

Stored accepted tuples use at most md clause-ID occurrences, because each ID has capacity d. Workspace for input, loads, family and current elimination is polynomial, conservatively O(m log n+md log m+K^2+K log m) bits apart from rational certificate data. Final sign filtering and load verification scan the stored lists. Spectral certification, its bit precision and the final strict inequality remain separate required computations; nothing returns UNSAT solely because the attempt budget was exhausted.

The proved sign lemma and deterministic load accounting reduce the missing task to a geometric one. They do not supply the needed geometric progress theorem. Existing adaptive growth remains a data-aware possibility; existing uniform existence survives deletion but, used this way, leaves a logarithmic guarantee gap and a discovery gap. No improved FKO finder was established, and no new experiment or successor is automatically selected.
