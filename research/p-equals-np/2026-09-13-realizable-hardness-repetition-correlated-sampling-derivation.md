# Finite correlated local sampling for the repetition proof

2026-09-13. S3132/S3137 in formal-pvnp. The selected missing step is Holenstein v3 Lemma 8, with its changed-input Corollary 9. We prove the local sampling and total-variation bounds on finite spaces, including an exact finite shared-random construction. This is not a proof of the whole parallel-repetition theorem, not Lean acceptance, and not a new sampling result. No compiler, new Lean module, source-draft edit, Git, paper edit, or public action was used.

Routing: the supplied satellite/planning instructions and formal three-lens protocol apply; no AGENTS.md exists at the satellite root or certification root. The scoped literature decision is `C:/Users/Dan/Desktop/Projects/IGH/Quantyra-Planning/docs/research/pvnp/literature-review-clause-position-repetition-2026-09-13.md`. The actual basic game and conditional repetition interface were archived at e2e5436ead1e8f2721abef0eba1f7dba93801596. Those notes do not prove the local embedding lemma reconstructed here.

## 1. Exact target, probability conventions, and zero cells

Let X,Y,S be finite nonempty sets and let mu(x,y,s) be a probability mass function. Put p(x,y)=sum_s mu(x,y,s). Define kernels

    c_xy(s)=mu(x,y,s)/p(x,y) when p(x,y)>0,
    a_x(s)=mu_XS(x,s)/mu_X(x) when mu_X(x)>0,
    b_y(s)=mu_YS(y,s)/mu_Y(y) when mu_Y(y)>0.

At a zero denominator choose the point mass at one fixed s0 in S. Each kernel is therefore a normalized probability distribution on all inputs, even unreachable ones. The choices at p-null cells have no effect on the Lemma 8 conclusion. They must be retained consistently in Corollary 9, whose changed input law can visit previously null cells.

For two probability distributions P,Q on the same finite set, write

    TV(P,Q)=(1/2)sum_z |P(z)-Q(z)|.

Let eps1,eps2>=0 and assume the actual distribution comparisons

    TV(mu, p a)<=eps1,       TV(mu,p b)<=eps2,             (H8)

where (p a)(x,y,s)=p(x,y)a_x(s) and analogously for b. Then there exists a finite random variable R independent of (X,Y), and deterministic functions fA:X times R->S, fB:Y times R->S, such that, if (X,Y) has law p, the output law lambda of (X,Y,fA(X,R),fB(Y,R)) satisfies

    TV(lambda,Delta(mu))<=2eps1+2eps2.                   (E8)

Here Delta(mu)(x,y,s,t)=mu(x,y,s) if s=t and zero otherwise. Thus the desired target has the SAME original (X,Y) coordinates and two equal copies of S. This is precisely 1-2eps1-2eps2 embeddability in the source's Definition 7. If the bound exceeds one it is valid but uninformative; no negative success probability is interpreted as a new probability distribution.

All spaces may have size one, the kernels may be point masses, and eps1 or eps2 may be zero. An empty S cannot carry the given normalized joint probability and so is not a missing case. Probability weights may be arbitrary nonnegative reals. There is no rationality premise, independent-question premise, Markov assumption, or independence assumption on S. In particular S may be a common bit already known through correlated X,Y.

The construction below also preserves exact local marginals:

    Law(fA(x,R))=a_x,      Law(fB(y,R))=b_y

for every input, including the declared zero-marginal defaults. There is no efficiency claim about generating R. This is a strategy-existence lemma for finite classical games.

## 2. Elementary total-variation facts, with proofs

For probability vectors P,Q, put d=TV(P,Q). Since their total masses are equal, the positive and negative parts of P-Q both sum to d. Consequently

    sum_z min(P(z),Q(z))=1-d,
    sum_z max(P(z),Q(z))=1+d.                            (TV1)

For any subset E, |P(E)-Q(E)|<=d, and equality is attained by E={z:P(z)>=Q(z)}. This follows by retaining all positive differences and no negative ones. Thus TV is the maximal event-probability discrepancy.

If Z,T are coupled random variables on the same finite alphabet, then for every E,

    |Pr[Z in E]-Pr[T in E]|<=Pr[Z!=T],

because equal values have equal membership indicators. Taking the preceding maximizing event gives

    TV(Law Z,Law T)<=Pr[Z!=T].                          (TV2)

Triangle inequality follows from the triangle inequality for absolute values in the defining finite sum. If two laws have a common marginal w(i) and conditional probability vectors P_i,Q_i, factoring each nonnegative w(i) from its absolute-value summands gives the exact identity

    TV(w P,w Q)=sum_i w(i) TV(P_i,Q_i).                 (TV3)

The identity remains valid at w(i)=0 without dividing by w(i). Finally copying the last coordinate onto a diagonal preserves TV exactly: only diagonal cells contribute to the L1 sum. These facts supply every distance comparison used below.

## 3. A finite first-hit construction for any finite family of laws

Let K be ANY finite family of probability vectors on S. Eventually K will contain all a_x,b_y,c_xy. Construct a single shared source R with a sampler F_k:R->S for each k in K. The rule uses the vector k alone and the same R; it does not inspect another party's input.

Take the distinct sorted thresholds consisting of 0,1 and every value k(s) for k in K,s in S:

    0=t0<t1<...<tL=1.

Let n=|S|>=1. The finite atom set is Z=S times {0,...,L-1}. Give atom z=(s,l) weight

    w_z=(t_(l+1)-t_l)/n>0.

The weights sum to one. For a probability vector k define its acceptance set

    A_k={(s,l):t_(l+1)<=k(s)}.

Every k(s) is a threshold. Telescoping the intervals therefore gives

    w(A_k intersect ({s} times {0,...,L-1}))=k(s)/n,
    w(A_k)=1/n>0.                                     (CELLS)

This includes k(s)=0 and k(s)=1 exactly. No interval endpoint is sampled, so there is no strict-versus-nonstrict ambiguity; the construction is the exact finite partition of the continuous threshold sampler's acceptance regions.

Let R be a random permutation of Z drawn by successive sampling without replacement, choosing each next remaining atom proportionally to its weight. For a permutation (z1,...,zM), M=|Z|, its probability is

    product_(i=1)^M w_(zi)/(sum_(j=i)^M w_(zj)).         (PERM)

Every denominator is positive. At the last step the factor is one; no empty denominator is formed. Induction on the number of remaining atoms shows these probabilities sum to one, since the first atom is chosen with a normalized distribution and each remaining conditional permutation law is normalized. Thus R is a genuine FINITE probability space; the permutation may be sampled independently of all game questions. If the original kernel probabilities are rational, all these weights and permutation probabilities are rational, but that is not needed for the existence statement.

For a nonempty A subset Z, let first_A(R) be its first atom in R. It exists for every permutation. The central finite identity is

    Pr[first_A=z]=w_z/w(A) for z in A.                  (HIT)

Proof by induction on the number of atoms, allowing arbitrary positive total weight W before normalization. If the first atom is z, the event holds; its probability is w_z/W. If the first atom u lies in A minus {z}, the event is impossible. If u lies outside A, the conditional remaining size-biased permutation has, by induction, probability w_z/w(A) to hit z first. Indeed removal rescales all remaining weights by the same factor, which cancels in the ratio. Summing over u outside A gives

    w_z/W + ((W-w(A))/W)(w_z/w(A))=w_z/w(A).

The single-atom case is immediate. This proves (HIT) on the finite space, without an infinite sequence, an almost-sure termination claim, a limit exchange, or a truncation error.

Define F_k(R) to be the S component of first_(A_k)(R). Equations (CELLS) and (HIT) give

    Pr[F_k=s]=(k(s)/n)/(1/n)=k(s).                     (MARG)

All samplers in the finite family are thus realized simultaneously with exact prescribed marginals and common randomness. They always terminate after at most |Z| inspected atoms. This bounded inspection count is only a property of this finite existence construction, not a polynomial-time game reduction or a fair-bit implementation for arbitrary real weights.

## 4. Pairwise correlated agreement and the constant two

For k,l in K let d=TV(k,l). At each label s the threshold acceptance regions are nested. Therefore

    w(A_k intersect A_l)=(1/n)sum_s min(k(s),l(s))=(1-d)/n,
    w(A_k union A_l)=(1/n)sum_s max(k(s),l(s))=(1+d)/n.

The union has positive weight even when d=1. If the first atom of this union lies in its intersection, it is the first accepted atom for BOTH samplers. In that event their output labels agree. By (HIT),

    Pr[F_k=F_l] >= (1-d)/(1+d),
    Pr[F_k!=F_l] <= 2d/(1+d) <= 2d.                    (AGREE)

The first inequality need not be equality: different accepted atoms can still have the same label. Only the stated lower bound is used. For d=0 the acceptance sets coincide and the samplers agree on every R. For d=1 the guarantee is zero, with no division by zero. This proves the same factor-two correlated-sampling estimate as the primary rejection sampler, using a common finite random permutation for the entire family.

The estimate does not require that one party can compute the other party's law. The common family and its shared source depend on the fixed finite joint distribution, known in the mathematical construction; party A chooses the acceptance set determined by a_x using x alone, and party B uses b_y using y alone.

## 5. Lemma 8: exact local embedding

Use K={a_x:x in X} union {b_y:y in Y} union {c_xy:(x,y) in X times Y}, omitting duplicate vectors if desired. Let R have the finite distribution (PERM), independent of a pair (X,Y) with law p. Define

    FA=fA(X,R)=F_(a_X)(R),
    FB=fB(Y,R)=F_(b_Y)(R),
    FC=F_(c_XY)(R).

FC is a joint-input ANALYSIS variable, not a local strategy and not an oracle supplied to either party. By (MARG), (X,Y,FC) has law mu. For positive p(x,y), apply (AGREE) to the vectors a_x,c_xy, then average:

    Pr[FA!=FC] <= 2sum_(x,y) p(x,y)TV(a_x,c_xy)
                =2 TV(p a,mu)<=2eps1.

The equality is (TV3); at p-null cells all summands are zero and all kernels remain defined. Similarly Pr[FB!=FC]<=2eps2. A union bound gives

    Pr[(FA,FB)!=(FC,FC)]<=2eps1+2eps2.

Couple the two tuples (X,Y,FA,FB) and (X,Y,FC,FC) using these same random variables. Their second law is Delta(mu), and (TV2) proves (E8). The local output marginals asserted in Section 1 follow from (MARG). This completes the entire finite lemma, including all constants and all zero-support choices.

When eps1=eps2=0, each positive-p pair has a_x=c_xy=b_y. The common sampler then agrees identically on that pair. This proves the exact-embedding endpoint without assuming S independent of X,Y. More generally the bound is the minimum of one and the displayed error if a probability-range form is desired.

## 6. Changed-input corollary with exact source constants

Let q(x,y) be ANY probability law on X times Y. Retain the normalized kernels a_x,b_y from mu, including their chosen defaults at mu-null marginals. Suppose now

    TV(mu,q a)<=eps1,       TV(mu,q b)<=eps2.            (H9)

There are the same kind of finite local samplers, now run with input law q, such that

    TV(Law(X,Y,FA,FB),Delta(mu))<=3eps1+2eps2.          (E9)

This is source Corollary 9's stated asymmetric constant. A direct proof avoids paying unnecessary marginal-change losses.

Use the shared finite samplers for the family {a_x,b_y}; including c_xy as in Section 5 also works. Conditional on (x,y), (AGREE) gives mismatch at most 2TV(a_x,b_y). Hence

    Pr_q[FA!=FB] <=2sum_(x,y)q(x,y)TV(a_x,b_y)
                 =2 TV(q a,q b)
                 <=2eps1+2eps2.                       (MISMATCH)

The first-coordinate output law (X,Y,FA) is exactly q a. Thus the diagonal tuple (X,Y,FA,FA) has law Delta(q a). Coupling it to (X,Y,FA,FB) costs at most the mismatch in (MISMATCH). The distance from Delta(q a) to Delta(mu) is exactly TV(q a,mu)<=eps1. Triangle inequality proves (E9). Reversing the roles gives 2eps1+3eps2; both statements are valid, so one may retain the smaller bound 2eps1+2eps2+min(eps1,eps2). No converted premise involving p a or p b was assumed.

If q visits an x or y of zero mu marginal, the designated default kernel supplies an actual local distribution there. Any mismatch with mu is already included in (H9). If eps1=eps2=0, then mu=q a=q b, including equality of the (X,Y) marginals; the construction is exact. This handles changed supports without an undefined conditional law.

Incidence reviewer contributed this direct changed-input proof route during coordination. The author supplied the finite-permutation construction and the full derivation above. A distinct full reviewer must therefore assess this corollary rather than treating its contributor as its sole independent verifier.

## 7. Exact downstream role and unresolved repetition work

Holenstein's classical proof first bounds dependence created by conditioning on already-won coordinates. Lemma 5 and Corollary 6 provide statistical-distance estimates; they have NOT been proved in this note. The present Lemma 8 and Corollary 9 turn two approximate-locality estimates into a legal common-randomness embedding of an auxiliary shared variable. Their outputs preserve each party's original input and use only its local input plus shared randomness. This is the missing strategy-construction step used in Lemma 14, not a supplied game-value certificate.

For the actual clause-position game, the local input spaces are finite (clause occurrence IDs versus variable labels), their joint law is the multiplicity-weighted law already proved at e2e5436. The present lemma allows precisely such an arbitrary joint law. The auxiliary S in the later repetition argument is not assumed to be a literal assignment; its intended role is the finite dependency-breaking data derived from a conditioned tuple. Establishing the two numerical premises (H8) or (H9) for that actual variable remains the information/conditioning part of the proof. The existence of local maps under explicit TV premises is fully proved here; those later TV premises are not asserted without derivation.

The remaining full chain includes: the product-conditioning information estimate (Lemma 5), its auxiliary conditioning extension (Corollary 6), exact local extension/Markov factorization (Lemma 10), construction and error estimate of the dependency-breaking embedding (Lemma 14), the one-coordinate conditional-success implication (Lemma 15), and the final repetition recurrence with its constants and integer boundaries. None follows merely by renaming (E8) as a repetition theorem. The upstream CNF gap construction and encoded source producer also remain separate. Kernel verification of this lemma and all preceding finite notes is still pending; compiler capacity remains below its explicit guard.

For eventual Lean implementation, this increment needs finite PMFs, sorted distinct thresholds, a positive-weight permutation PMF with the first-hit induction, finite TV identities, and a shared-random coupling. It does not require measure theory for an infinite tape, an unproved sampler field, a termination axiom, or a complexity oracle. The fixed finite construction also pushes forward to a finite distribution over pairs of deterministic local response tables, compatible with the classical strategy definition. No polynomial bound in the game-input size is claimed for this auxiliary sampler.

## 8. Pinned primary evidence and displayed-inequality correction

Primary: Holenstein, *Parallel Repetition: Simplifications and the No-Signaling Case*, arXiv:cs/0607139v3, versioned PDF `C:/Users/Dan/AppData/Local/Temp/s3137-holenstein-cs0607139v3.pdf`, SHA256 `8d392c5ce04e333cdd47a6e15d6d02e1427d7d378b2ff59c0d94de0edad57f3f`. Preserved text `C:/Users/Dan/AppData/Local/Temp/s3137-holenstein-cs0607139v3.txt`, SHA256 `6f5ed5ca5191b63998bcfcaf51ffb8ce0f7d2c83b299a288378eec06c6a99e18`.

Section 5, printed pp9--10, extracted lines462--520: Definition 7, Lemma 8, shared rejection sampler, exact overlap/union ratio, and union bound. Lines524--536: Corollary 9 and its optional symmetric bound. Our finite partition/permutation implementation proves the same necessary estimates without a new approximation parameter. Lines547 onward and Lemma14 onward locate its role in the full classical repetition argument.

The preserved text's final Lemma 8 display at line521 reads a total-variation expression followed by a lower bound of the form '>=1-2eps1-2eps2'. That is not the required conclusion and cannot follow from a high-probability equality coupling: for identical distributions the TV distance is zero. The correct implication, derived explicitly in Section 5, is TV<=Pr[not all equal]<=2eps1+2eps2. This local displayed-line issue in the pinned version does not refute the lemma statement, whose intended embedding error is exactly what has been proved here. No claim about other editions or novelty is made.

Boundary evidence: `research/p-equals-np/2026-09-13-realizable-hardness-clause-position-repetition-interface.md`, SHA256 `dd3919b3f423330088f6040e4994490ae262c762480dc1ef59eda049b59ee90f`, archive e2e5436ead1e8f2721abef0eba1f7dba93801596, supplies the still-conditional overall Theorem4 application, not a proof imported into this lemma. The new finite proof requires only the explicit joint PMFs and inequalities written above. Independent review and kernel acceptance are separate records.
