# Gap3Lin source construction extraction

2026-09-12. S3132 under S3126. Source extraction and an explicitly identified elementary derivation; no Lean proof acceptance, compiler or public action. This advances the missing specialized source theorem rather than adding a hardness-assumption wrapper.

## Acquired sources and access limits

The actual MZ bibliography identifies H?s01 as Johan H?stad, *Some optimal inapproximability results*, JACM 48(4), 798-859 (2001), DOI [10.1145/502090.502098](https://doi.org/10.1145/502090.502098). Downloaded the [official author PDF](https://people.kth.se/~johanh/optimalinap.pdf), linked from his [publication list](https://people.kth.se/~johanh/papers.html). It has 71 PDF pages and its own pagination, not the journal pagination. Citations below refer to the printed author-version pages: Section 2.5 pp.15-16; Section 3 pp.19-21; Test L and Lemmas 5.1-5.2 pp.24-27; Theorem 5.4 pp.27-29. The PDF page index is printed page minus one (the first printed page is 1). The source was acquired as a local research copy, not added as a redistributed repository file.

Min22 is Dor Minzer, *On Monotonicity Testing and the 2-to-2 Games Conjecture*, ACM Books 49, DOI [10.1145/3568031](https://doi.org/10.1145/3568031). The official DOI metadata confirms the book. The direct ACM PDF returned HTTP403. The historically linked TAU thesis URL https://www.cs.tau.ac.il/thesis/thesis/Minzer.Dor-Thesis-PhD.pdf redirected to a libraries.tau.ac.il path returning HTTP404. MIT author-page access also failed. I therefore did not read Min22's structural-reduction proof and cannot say whether it gives explicit gadgets or merely cites them. MZ24 Theorem 2.1 and MZ Definition3.1/Theorem3.1, already preserved locally, state that the structural reduction is elementary but do not supply its equations. No inaccessible text is treated as inspected.

## Actual specialized verifier

Let a constant-gap bounded-occurrence E3-CNF formula phi have m clauses. H?stad Theorem2.24 supplies this base reduction; Lemma3.1 bounds its clause-versus-variable game value by (2+c)/3 for NO value c<1. Lemma3.2 invokes parallel repetition (Theorem2.26) to obtain a constant c_c<1 and repeated-game value at most c_c^u. These are prerequisites, not consequences of the recent CMMSA modules. The pinned generic PCP theorem is related foundation but does not instantiate this exact regular E3-CNF/repetition interface automatically.

A verifier chooses u independent clause occurrences and one variable position from each. U is the selected-variable set, W the union of clause variables, h the conjunction of the selected clauses. The proof has long-code tables on assignments to U and W. Let A be the U table folded to be odd, and B the W table both conditioned on h and folded to be odd. It chooses uniform sign-valued functions f on assignments to U and g on assignments to W, then independent noise signs mu(y) with Pr[mu(y)=-1]=epsilon. Define

    g2(y) = f(y restricted to U) * g(y) * mu(y).

Accept exactly when A(f)*B(g)*B(g2)=1. This is the actual three-query parity verifier, not an arbitrary constant-query PCP predicate.

For an honest satisfying assignment, the three evaluations multiply to its noise coordinate. Completeness is exactly 1-epsilon (Lemma5.1 gives the lower bound). Folding and conditioning must be implemented as canonical address selection plus a sign; each parity check then becomes one GF(2) equation

    X[address1] + X[address2] + X[address3] = sign1+sign2+sign3,

with bits interpreted via (-1)^bit. The right-hand side is not always zero: canonical folding may negate a queried bit. Occurrences and repeated addresses must be retained. Splitting below permits three distinct output ports even if source addresses repeat.

Folding is defined in Section2.5 by selecting a canonical member of each sign-complement pair. It forces Fourier support on odd, hence nonempty, subsets of assignments (Lemma2.32). Conditioning makes B depend only on function values on assignments satisfying h, so nonzero Fourier coefficients have support entirely inside that satisfying set (Lemma2.34). The simultaneous canonical representation and the case h has no satisfying assignment need explicit executable handling. An implementation can detect an unsatisfiable selected clause tuple by exhaustive search on at most 3u variables (u fixed); such a tuple certifies phi is unsatisfiable and can route to a fixed NO output. This is an implementation branch to prove, not a claim that the source already formalizes it.

## Exact Fourier soundness chain

For a set S of W assignments let pi_odd(S) be the U assignments occurring an odd number of times among restrictions of S. With rho=1-2epsilon, Fourier expansion and character orthogonality give the local correlation

    corr(U,W,h) = sum_S Ahat(pi_odd(S))*Bhat(S)^2*rho^|S|.

If overall acceptance is (1+delta)/2, averaging this correlation gives delta. The candidate repeated-game strategies sample Fourier supports with squared-coefficient probabilities, then a uniform member of the chosen support. Parseval normalizes the distributions; folding excludes empty support; conditioning guarantees the first prover satisfies its clauses. For paired supports pi_odd(S) and S, consistency probability is at least 1/|S|. Thus their success is at least

    E_(U,W,h) sum_(S nonempty) Ahat(pi_odd(S))^2*Bhat(S)^2/|S|.

Lemma5.2 bounds this below by 4*epsilon*delta^2. For Lean, a direct weighted Cauchy-Schwarz derivation avoids multiplying inequalities by possibly negative Fourier coefficients: write the correlation as the inner product of Ahat*|Bhat|/sqrt(|S|) and |Bhat|*sqrt(|S|)*rho^|S|. For 0<epsilon<1/2, the second squared norm is at most 1/(4epsilon), since s*(1-2epsilon)^(2s)<=1/(4epsilon) for s>=1 and Parseval sums Bhat squared to one. Apply Cauchy-Schwarz across the joint finite index including the outer question. This yields the stated bound without any sign assumption on Ahat. This is a proof organization of the extracted identity, not a completed Lean proof.

To obtain a fixed source NO gap independent of epsilon, set delta=1/4 and choose fixed u after epsilon so c_c^u < epsilon/4. Acceptance greater than 5/8 would contradict the repeated-game bound. Hence source NO value <=5/8, while YES value >=1-epsilon. The source proof uses matched parameters for its approximation-ratio statement; separating them here follows directly from its two-parameter Lemma5.2. Rational dyadic epsilon can be chosen below any requested positive eta.

## Finite enumeration and unweighting

Theorem5.4 constructs one weighted equation per verifier outcome and assigns its exact probability. Its unweighting by duplication is left to the reader. A concrete implementation can avoid arbitrary rational denominators: take epsilon=2^(-b), sample each noise coordinate using b fair bits, and pad f/g/noise tables to |U|<=u and |W|<=3u. Then one common equiprobable outcome count is

    Q = (3m)^u * 2^K,   K = 2^u + (b+1)*2^(3u).

For fixed epsilon,u, K is constant and Q is polynomial in m. Enumerating every clause/position tuple and every padded fair-bit outcome, emitting one equation per outcome, preserves acceptance exactly, including duplicate occurrences. This gives exact unweighting with no extra completeness/soundness loss. It remains to prove an actual FP enumerator and malformed-input policy; a polynomial cardinality formula alone is not a clock proof.

## Explicit structural gadget: derived here, not attributed to inaccessible Min22

For terminals x,y and fresh internal variables a,b,c,d,e, use four GF(2) equations:

    x+a+b=0
    y+c+d=0
    a+c+e=0
    b+d+e=0.

Their sum is x+y=0. Consequently all four can be satisfied only if x=y. Choosing a=c=e=0, b=x, d=y satisfies the first three and violates the fourth exactly when x!=y. Minimum gadget violations are therefore precisely the inequality indicator of its terminals. Each triple has three distinct variables; any two rows intersect in at most one variable; each internal variable has degree two; each terminal appears once. Root independently checked this algebra during the task. No novelty claim is made.

For each source variable with t occurrences, create distinct occurrence ports and attach them to a graph on t vertices (or at most C*t vertices, with unused dummy ports). Every source equation now uses its three distinct occurrence ports. For each graph edge insert a fresh copy of the four-row gadget. Require graph maximum degree d<=9 and a fixed edge expansion kappa>0: every set of at most half the graph vertices has at least kappa times its size crossing edges. Graphs and all auxiliaries for different variables/edges are separate. Original rows are mutually disjoint; any gadget row contains at most one terminal, so intersections with original rows or other gadgets have size at most one. Original ports have degree at most 1+d<=10, dummy ports at most d, and internals degree two.

Let m0 be the number of original equation occurrences, e the total graph edges, and M=m0+4e. Since there are at most 3C*m0 graph vertices, e<=3dC*m0/2 and M<=(1+6dC)*m0. YES copying an assignment to its whole variable cloud satisfies all gadgets, so output unsatisfied fraction is at most the input epsilon (indeed epsilon*m0/M).

For any output assignment, majority-decode each complete variable cloud, breaking ties deterministically. Let B be the total number of minority cloud vertices, v0 the number of violated original rows, and vg the number of violated gadget rows. Expansion and disjoint gadgets imply vg>=kappa*B. Changing ports to cloud majorities can affect at most B original occurrences, even counting dummy minority vertices conservatively. If every decoded source assignment violates at least eta0*m0 rows, then v0+B>=eta0*m0. Therefore

    v0+vg >= min(1,kappa)*eta0*m0,
    unsat(output) >= min(1,kappa)*eta0/(1+6dC).

For eta0=3/8, this gives an absolute NO gap independent of the chosen positive YES error. Empty source occurrences are omitted; one-vertex clouds need no equality edges. A fixed NO instance for exceptional branches can be obtained from two contradictory source equations on the same three variables followed by the same construction, with its quantitative gap retained.

## The remaining graph obligation is real

This derivation still requires a deterministic polynomial-time graph family for every requested t, with t<=|V_t|<=C*t, max degree at most nine, and fixed positive edge expansion. Assuming such a family as a structure field only proves a conditional structural lemma. It does not finish MZ3.1. Pinned complexitylib has ExpanderFamily infrastructure used by Dinur; this task only located that infrastructure and has not verified it meets these exact degree, size, simple/multigraph, expansion and executable-interface requirements. Loops can be omitted for cut purposes; parallel edges can use distinct gadget internals, but degree and multiplicity must be counted honestly.

The next bounded Lean task is the four-equation gadget with exact minimum-violation and pair-intersection/degree proofs, followed by the explicit cloud constructor and majority-decoding inequality. In parallel the source owner must inspect and instantiate an actual bounded-degree expander construction, while a separate hard-proof route implements the folded noisy parity verifier, Fourier identity/decoding, base gap-CNF reduction and parallel repetition. None of these remaining theorems may be replaced by an assumed hardness field. Min22 access remains unresolved, but the explicit structural candidate above is executable mathematical work independent of that access.

## Status and source identity

No complete source-hardness theorem or final paper certification is claimed. H?stad extraction is from the author version; Min22 construction is unavailable; the four-row gadget and its loss accounting are an explicitly derived proposal requiring Lean verification and independent review. Full S3126 remains active.

- Local source C:\Users\Dan\AppData\Local\Temp\s3132-hastad-optimalinap.pdf: SHA256 `864df36f2bc692e47f1c94aff0afec34297e27116a5d76f204199e9ce098fa64`, 618419 bytes.
- Local source C:\Users\Dan\AppData\Local\Temp\s3132-hastad-layout.txt: SHA256 `0b771d4539401742c0c41a89a201c318e6557ab6aada7de60df69610614bfe91`, 189933 bytes.

## Follow-up: actual pinned expander interfaces inspected

The pinned complexitylib revision 6c248df7859f2f245e731c1e07057bf69d165fe2 contains useful concrete machinery. Expander.lean defines ExpanderFamily by degree, involutive rotation on Fin n x Fin degree for every n, lam<1 and SpectralBound lam. FamilyFin.lean constructs algFamily from a once-chosen finite zig-zag base; its degree is famDeg=widthBnd*fitD, and its uniform contraction is sqrt(1-27/(25*widthBnd)). Thus it is not merely a hypothetical expander argument. AlgFamily.lean proves FinBase.famTableFn_mem_FP and famRotFn_mem_FP, with explicit tables and size bounds. Rotation input uses unary n,vertex,dart; in the occurrence-cloud application n is at most the explicit input occurrence count, so this does not inherently cause exponential expansion, but the encoding bridge still needs proof. The one fixed base is noncomputably selected; its fixed finite table is a constant in the machine construction, not an input-dependent choice.

This family has arbitrary fixed degree; I found no theorem bounding it by nine. Margulis.lean defines eight explicit affine generators and proves rotation involutivity, but a targeted search did not locate a spectral theorem for those generators in the pinned tree. Its comment that the spectral proof is elsewhere is not usable evidence of a degree-eight expander theorem. Do not silently substitute it for algFamily.

Recommended next dependency audit: reuse algFamily and its FP table generation, prove a quantitative constant-degree-to-degree-three port/cycle replacement with linear constant-factor vertex blowup and fixed expansion, then connect cut counts to the family spectral inequality. This is preferable to inventing a new expander family, but the replacement and its expansion are additional real proofs. Loops and parallel darts in algFamily are allowed; define undirected edge occurrences by the rotation involution, omit self-loops for cut constraints, and retain all nonloop orbit multiplicities. No such degree-reduction proof or library kernel audit was executed in this source task.
