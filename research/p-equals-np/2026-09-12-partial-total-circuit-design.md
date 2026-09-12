# Partial-to-total circuit completion: one bounded interpolation design

2026-09-12; S3120, E004/S008; internal research evidence under [integrity](../../INTEGRITY-CLAIMS.md). **Updated after the authorized second bounded pass: the proposed universal preservation inequality (P) is false; the final strengthening rules out every bound polynomial in n+C*(p) for this exact rule, using existential masks. No partial-to-total hardness reduction or complexity-class separation is established.** One concrete operation was selected for a bounded derivation after independent early challenge and orchestrator authorization. The first-pass record below is retained as history; its unresolved outcome is superseded by the final addenda. No experiment, formal proof campaign, public claim or successor is selected by this note.

## Sources and precise difference

[Hirahara, FOCS 2022, Theorem I.2 and the paragraph following it](https://ieee-focs.org/FOCS-2022-Papers/pdfs/FOCS2022-4Bu7jGV9xIcveUWYj3oWoi/551900a968/551900a968.pdf) establishes randomized polynomial-time one-query hardness for partial truth tables. Its circuit YES threshold is q=s/log(s), with an O(log s)-depth witness; its NO case excludes even nontrivial agreement by circuits of size q n^epsilon, for a universal epsilon>0. Here n is the number of arguments of the partial function, N=2^n is its table length, and s=2^{Theta(n)} in the reduction. Section II.B explicitly constructs the partial function by enumerating the support of its distribution; for these produced instances the YES agreement is full consistency. Consequently the NO case excludes any exactly consistent circuit of that size. This is randomized hardness, not deterministic Karp completeness. The paper explicitly proposes exploiting the gap for a partial-to-total reduction. We do not claim that frontier question as new.

[Hirahara-Ilango, FOCS 2025, Theorem I.1](https://www.rahulilango.com/papers/MCSP-Proceedings-2025.pdf) gives conditional total-MCSP hardness under deterministic quasipolynomial-time nonadaptive reductions. Its assumptions are subexponentially secure noninteractive witness-indistinguishable proofs for SAT, almost-everywhere subexponential nondeterministic circuit hardness for coNP, and an essentially maximal circuit lower bound for P^NP/poly. This does not settle unconditional polynomial-time many-one hardness. [Ilango, SIAM 2026 / FOCS 2023](https://epubs.siam.org/doi/10.1137/24M1652568) instead obtains a nonuniform reduction with a random oracle, uniform when the reduction can access that oracle. Instantiating the oracle is not a proved ordinary reduction.

[Carmosino-Dang-Jackman, STACS 2026, introduction and main result](https://arxiv.org/html/2511.16903v1) show polynomial-time total XOR Simple Extension in both counted- and free-negation models; read-once OR extensions were already easy. Their input is a total extension with a key restriction and exact additive optimal-size condition. The present completion takes an arbitrary partial table and performs interpolation, so it is not that problem or an escape from their theorem. A restricted DNF/XOR partial-to-total reduction likewise cannot be transferred to unrestricted gate count; see the independent source challenge for its exact model.

The proposed operation uses familiar GF(2) evaluation-code interpolation, equivalently solving erasures in Reed-Muller evaluation spaces degree by degree. Gaussian elimination and this representation have no novelty claim. The proposed difference to examine is a circuit-size guarantee for its particular canonical choice, independent of the arbitrary specification mask. No source checked establishes that guarantee, and the bounded search is not a priority proof.

## Fully computed construction

Fix n>=1 and N=2^n. Input p is an N-symbol table over {0,1,*}, with an integer threshold s>=0; encoding the table takes O(N) bits. Circuits have unrestricted depth and fan-out, gates AND_2, OR_2, NOT, all counted; constants 0 and 1 and input wires are free. C(f) is minimum gate count, and C*(p)=min C(f) over consistent total f.

For d=0,...,n, list monomials x_S=product of x_i for subsets S of size at most d. Order first by degree and then lexicographically by the increasing tuple of indices. The empty monomial is 1. Rows are specified x in ordinary binary lexicographic order. Form A_d[x,S]=x_S and right-hand side p(x). Perform left-to-right Gaussian elimination over GF(2), selecting the first available nonzero row as pivot, obtaining reduced row-echelon form without column swaps. Stop at the first consistent degree. Set every free coefficient to zero and read the pivot coefficients. Output H(p)(x)=sum_S a_S x_S over GF(2) for all x. If p is wholly unspecified, degree zero returns constant zero.

Consistency at d=n is guaranteed because all multilinear monomials form a basis for functions on the Boolean cube. The procedure searches no circuits, invokes no SAT or completion oracle, and does not choose a hidden small-circuit witness. At most n+1 systems of dimension at most N by N are eliminated. Naive construction/evaluation and repeated elimination cost O((n+1)N^3) bit operations and O(N^2) working bits. Output length is exactly N, not exponential in N. This is an expensive but polynomial-in-table-length rule.

## Target contract and actual bounds

The sole proposed, **unproved** inequality is

    C(H(p)) <= 2 C*(p) + 10(n+1)^2.                 (P)

Its constants define the test; they are not justified by an existing estimate. Soundness needs no conjecture: H(p) agrees with p, hence C*(p)<=C(H(p)). If (P) held, set T=2s+10(n+1)^2 and map (p,s) to the total-MCSP instance (H(p),T). This preserves the source promise YES C*(p)<=s versus NO C*(p)>T. It does not preserve the exact source decision threshold s; the intermediate interval is a promise gap.

For Hirahara's exponentially large q, q n^epsilon eventually exceeds 2q+10(n+1)^2. Constant factors from conversion of a fixed bounded-fan-in complete basis can also be absorbed by n^epsilon, with the converted YES threshold substituted for s. Thus a proof of (P), with this conversion accounted for, would give the relevant randomized gap-to-total hardness transfer for sufficiently large instances; finitely many smaller source lengths can be handled separately. This remains conditional on (P).

The estimate actually available from this construction is much weaker. There are at most N selected monomials. Computing each separately uses at most n-1 AND gates and combining terms uses at most N-1 XOR operations, each realizable with four counted gates as (a OR b) AND NOT(a AND b). Thus C(H(p))<= (n-1)N+4(N-1) <=(n+3)N. This loses dependence on C*(p) and gives no promised preservation. Free ANF coefficient selection does not mean free circuit evaluation.

## Bounded first-obligation derivation: specification masks

The first falsifiable subobligation is (P) for every partial table consistent with AND_n. This family has C*(p)<=n-1 regardless of the mask. Require p(1^n)=1 and allow any subset of the remaining positions to be specified zero. The proposal must bound the chosen interpolant by 2(n-1)+10(n+1)^2 for every such subset. Arbitrary masks are genuinely quantified; their description is not charged to a supposed small circuit.

One exact symbolic stress case specifies only 1^n and its n Hamming neighbors: value 1 at 1^n and zero at each 1^n XOR e_i. Degree zero is inconsistent. At degree one the equations uniquely force coefficient a_i=1 for all i and a_empty=1 XOR (n mod 2). Thus the actual selected completion is

    H(p)(x)=1 XOR (n mod 2) XOR x_1 XOR ... XOR x_n.

For n=2 this is XNOR: p(01)=p(10)=0, p(11)=1, and the rule fills p(00)=1, although AND is a one-gate consistent completion. This follows from the specified unique solution, not a guessed alternative completion. The selected function still has a linear-size circuit, so this is neither a violation of (P) nor a new lower bound. It establishes that simple witness structure need not survive literally, while the numerical obligation survives this case.

Two endpoints also clarify the mask issue. A constant-compatible nonempty p returns that constant at degree zero regardless of the mask. Fully specified p returns p exactly. These checks prevent the immediate objection that the rule always exposes the mask as an output slice. Nevertheless, in the general case the arbitrary specified-row set controls the row space, minimal consistent degree, pivot pattern, and selected coefficients. No factorization of those choices into O(C*(p)+n^2) gates was derived. A small consistent circuit gives a feasible full-degree coefficient vector, but provides no bound on the canonical lower-degree RREF solution.

There is also an elementary safe regime: if the selected degree is at most two, separately evaluate at most n(n-1)/2 quadratic monomials and combine at most 1+n+n(n-1)/2 terms by four-gate XOR. The resulting bound is below 10(n+1)^2, so (P) holds in that regime. It does not control selected degrees above two.

Degree or coefficient count cannot replace that missing inference. For example, a fully specified OR_n has degree n and 2^n-1 nonzero ANF coefficients but only n-1 OR gates. Conversely no general-circuit lower bound for our selected output follows from its having many coefficients. We neither prove nor refute (P); the derivation stops at the explicit O(nN) construction bound and the mask-dependent structural obligation. No counterexample search or experimental suite was run.


A further exact reformulation addresses a possible adversarial-mask route. Write RM(d,n) for the degree-at-most-d evaluation space and let U be the unspecified positions. The homogeneous ambiguity space is K={g in RM(d,n): support(g) subset U}. If a simple witness f lies in RM(d,n), the compatible degree-d fiber is f+K. To force precisely {f,h}, one needs K={0,g} and h=f+g. For U=support(g), this is equivalent to g being a minimal-support nonzero codeword: over GF(2) any distinct nonzero codeword with support contained in U has strictly smaller support. This is a linear-algebra characterization, not an existence theorem for suitable g.

Three further checks remain necessary: the fiber must contain no degree-below-d member; the zero-free-variable rule must select h rather than f; and C(h) must actually exceed the target. When K has dimension one there is one free column j, and the actual rule selects the unique fiber member with coefficient j equal to zero. Thus h is selected precisely when f_j=1 (the kernel coefficient g_j is then 1). A dense g alone proves none of the required circuit bounds. For the AND_n stress family, f has degree n and is absent from the minimal-degree fiber whenever any position is unspecified: toggling the value at one unspecified point cancels the degree-n coefficient, giving a completion of degree at most n-1. The proposed two-element fiber containing that f therefore cannot directly apply there. For any f at full degree n with just one unspecified point, the two full-degree completions differ by one point indicator, computable with O(n) gates; this does not supply a large separation either.

This pins a concrete next obligation: exhibit a specified simple f and a minimal-support RM codeword g at degree d, establish the empty lower-degree fiber and the actual free-column choice, and then prove the required ordinary-circuit lower bound for f+g; alternatively prove an upper bound excluding such a counterexample for this rule. No such codeword/counting argument was established in this pass. This exact fiber reformulation avoids claiming that arbitrary ANF coefficients are realized by the canonical completion.
## Relationship and first-pass closeout (superseded)

Even successful randomized NP-hardness would not prove P=NP or P!=NP. If a compatible randomized reduction existed and total MCSP were in P, composing would put NP in BPP (without silently strengthening to deterministic P). A deterministic polynomial many-one reduction plus an MCSP P algorithm would imply P=NP. Hardness alone supplies neither algorithm nor the general-circuit lower-bound antecedent of the separate magnification route.

Reuse, without rerunning, the [direct-magnification assessment](2026-09-11-direct-magnification-selection.md), [separator-compression failure](2026-09-12-separator-compression.md), and [streaming assessment](2026-09-12-gap-first-selection.md). This operation assumes no separator-to-witness decoder, does not expand a verifier into an exponentially long table, and claims no time-sensitive streaming transfer.

Outcome: one admissible concrete speculative completion was investigated; its actual quantitative preservation question is UNRESOLVED. No novelty, general obstruction, successful reduction or new hardness result follows. The bounded pass records an active unresolved candidate, not selection NONE or a completed preservation proof. Remaining mathematical obligation: prove or refute (P) for the exact rule, with the mask/fiber conditions above supplying a specific next target; no experiment or proof campaign is automatically authorized. Independent challenge and planning/meta-graph closeout are handled by the orchestrator.



## Authorized second pass: counting refutes (P) for the actual selected completion

This addendum supersedes the first pass's unresolved preservation status. The orchestrator authorized the specific minimal-support/fiber route; the independent challenger checked the following count and selection argument before closeout. The conclusion is a nonconstructive family of counterexamples for all sufficiently large n, not an exhibited small table or an efficient algorithm finding a hard codeword.

### Source facts and their limited use

[Borissov-Manev, Minimal Codewords in Linear Codes, Serdica Math. J. 30 (2004), Section 2 and Proposition (vii)](https://www.math.bas.bg/serdica/2004/2004-303-324.pdf) defines binary RM(d,n) as the degree-at-most-d evaluation code, with dimension sum_{i=0}^d binom(n,i) and minimum distance 2^{n-d}. It also states that a nonminimal binary codeword splits into two nonzero codewords of disjoint, strictly smaller supports. The paper's detailed third-order classifications concern small dimensions; they are not an asymptotic enumeration theorem. We need only the elementary parameters and splitting fact, deriving the coarse count here. No novelty is asserted for those standard facts or their counting consequence.

The minimum-weight lower bound can also be seen directly. Write a nonzero multilinear polynomial as a(x)+x_n b(x). If b=0, its weight doubles the nonzero weight in n-1 variables. If b is nonzero, the sum of the weights of the two slices a and a+b is at least the weight of b, which has degree at most d-1. Induction gives weight at least 2^{n-d} (with the full-degree endpoint weight at least one). A degree-d monomial attains this weight.

### Many minimal words with at least two cubic coefficients

Fix d=3 and n>=3. Let

    K = 1+n+binom(n,2)+binom(n,3),
    K2 = 1+n+binom(n,2),
    L = binom(n,3),
    M = number of nonzero minimal-support words in RM(3,n).

Every nonzero word decomposes into disjoint-support minimal words: if it is nonminimal choose a nonzero proper-support subword u; the remaining word g+u has precisely the complementary support inside g. Repeat until each component is minimal. Support size strictly decreases, so this terminates. Each component has weight at least N/8, while their union has weight at most N, so at most eight components occur.

Consequently every codeword is the sum of at most eight members of the M-word set. Padding a tuple with zeros gives the safe upper bound

    2^K <= (M+1)^8,
    M >= 2^(K/8)-1.

There are at most (L+1)2^K2 codewords with zero or one cubic coefficient: choose its absent or single cubic term and choose all lower coefficients. Thus the number M_good of minimal words with at least two cubic coefficients satisfies

    M_good >= 2^(K/8)-1-(L+1)2^K2.                (1)

The right side is 2^{Omega(n^3)} for sufficiently large n, since K/8=n^3/48+O(n^2), while K2+log2(L+1)=O(n^2). This is not a claim that all cubic words are minimal.

### The precise mask forces the canonical RREF output

For each good g, let j be its highest ordered nonzero monomial index. Because g has cubic coefficients and degree at most three, this index is cubic. Let f=x_j denote that monomial (using j here as the monomial-list index, not a variable index), and define

    p_g(x)=f(x) when g(x)=0,
    p_g(x)=*    when g(x)=1.

Given g's coefficients or truth table, this mask and its labels are computable in polynomial time in N. The partial function has a consistent two-AND-gate completion f, so C*(p_g)<=2. The mask is allowed to encode substantial information; that is exactly the source of this counterexample.

The homogeneous kernel of the degree-three specified-row evaluation matrix consists of codewords supported inside support(g). Minimality over GF(2) forces that kernel to be precisely {0,g}. Hence the entire compatible degree-at-most-three fiber is {f,f+g}. Both members have degree exactly three: f is cubic, and removing its one coefficient from g leaves another cubic coefficient. Therefore no smaller degree is consistent. The completion algorithm must stop at d=3.

It remains to verify the actual tie-break. In a left-to-right column-order RREF matrix with one-dimensional kernel, its sole free column equals the highest nonzero coordinate of the kernel vector. Indeed all nonzero kernel coordinates below that free column would correspond to pivot rows with a nonzero entry before their leading pivot, impossible in echelon form; the free coordinate itself is one. Equivalently the unique column dependency first closes at its highest supported column. Thus our free column is j. The coefficient vector f has f_j=1; f+g has coefficient j zero. The specified free-zero rule therefore selects exactly

    H(p_g)=h_g=f+g.                              (2)

This controls the actual algorithm output rather than choosing a convenient alternative completion.

### Count these outputs against every small circuit

Different g may give the same h_g, but multiplicity is at most L: from any h and the deleted cubic monomial j one reconstructs g=h+x_j. Therefore the number of distinct outputs forced by (2) is at least M_good/L.

Set T=4+10(n+1)^2, the claimed bound when C*(p_g)<=2. A safe count of circuits of size at most T in the fixed AND/OR/NOT basis, with free constants and arbitrary output wire, is

    Q(n,T)=(T+1)(n+T+2)[3(n+T+2)^2]^T.          (3)

For each gate, allow any of three types and two input-wire choices among n+T+2 possibilities, even for NOT; this overcounts valid topological descriptions. Include the output-wire choice and all possible gate counts. It therefore also upper-bounds the number of functions computed by such circuits. Its binary logarithm is O(n^2 log n).

For every sufficiently large n,

    [2^(K/8)-1-(L+1)2^K2]/L > Q(n,T),           (4)

because the logarithm of the positive left side is Omega(n^3), and that of the right side is O(n^2 log n). Equations (1)-(4) imply that at least one p_g satisfies

    C*(p_g)<=2,
    C(H(p_g))>4+10(n+1)^2
              >=2 C*(p_g)+10(n+1)^2.

This refutes universal inequality (P). It is a counting lower bound for some members of a large family whose masks may be complex, not a lower bound inferred from ANF density, and not a lower bound for an explicit function in NP.

### Final scope

The polynomial-time completion algorithm remains well-defined; its proposed ordinary-circuit preservation contract fails. The refutation applies to that exact degree-first, free-zero interpolation rule and its stated constants. It does not prove impossibility of all partial-to-total encodings, nor exclude a version restricted to a different family of masks or a substantially weaker bound. No hardness-preserving reduction, general MCSP lower bound, or P-versus-NP conclusion follows.

The counterexample is nonconstructive in its choice of g; the algorithm H uses no hidden witness, and neither its definition nor its polynomial-time implementation depends on finding this g. Enumerating candidates or using a circuit-minimization oracle to produce an explicit hard g is not part of this assessment. No experimental suite was needed or run. The mathematical preservation question for this exact rule is now resolved negatively; successor selection remains a separate decision.

## Authorized strengthening of the same route: exponential output complexity

The orchestrator authorized checking the degree-drop case within the same mechanism. It strengthens the preceding cubic counterexample: for all sufficiently large n, there exists a partial table p with C*(p)<=floor(n/2)-1 whose actual selected completion has

    C(H(p)) > floor(2^(n/3)).                    (5)

Thus this particular completion has no universal bound polynomial in n+C*(p). This does not concern polynomial bounds in N=2^n; the existing O(nN) upper bound remains intact.

Here are all additional steps. Fix 1<=d<=n and K_d=sum_{i=0}^d binom(n,i). The same disjoint decomposition now has at most 2^d components, so its minimal-word count satisfies

    M_d >= 2^(K_d/2^d)-1.                        (6)

For every nonzero minimal word g of RM(d,n), let r be its actual degree, let f be its highest ordered monomial, and let h=g+f. Define p_g exactly as in the cubic construction. The compatible RM(d,n) fiber is exactly {f,h}, by the same support-minimality proof. We have C*(p_g)<=max(r-1,0)<=d-1.

If h has degree r, neither fiber member has smaller degree, so the completion stops at r. The kernel at that degree is still {0,g}; the unique free column is still the highest nonzero coefficient of g, and free-zero selects h. If h has degree below r, every compatible polynomial of lower degree must be h, since there are only two members in the entire RM(d,n) fiber. The completion therefore stops at the degree of h and uniquely returns h. If h=0 and f is nonconstant, it returns the unique compatible constant zero at degree zero. In the constant case g=f=1, the fiber is {1,0}; both constants are compatible, and the free-zero convention selects zero without uniqueness. Thus H(p_g)=h in every case, without requiring multiple top-degree terms. The fiber also proves that an earlier unrelated completion cannot intervene.

For a given output h and its deleted monomial f there is only one g=h+f. There are K_d possible monomials, so at least M_d/K_d distinct actual outputs occur. This multiplicity bound includes all degree-drop cases and does not assume masks are distinct merely because codewords are distinct.

Now choose d=floor(n/2). Symmetry of binomial coefficients gives K_d>=2^{n-1}, and trivially K_d<=2^n. Put A=K_d/2^d. Since 2^A-1>=2^{A-1} for A>=1, equation (6) yields

    log2(M_d/K_d) >= A-1-log2 K_d
                  >= 2^(ceil(n/2)-1)-n-1.       (7)

Use precisely the same circuit-description upper bound Q(n,T) in (3), now at T=floor(2^{n/3}). Its logarithm is

    log2(T+1)+log2(n+T+2)
       +T[log2 3+2log2(n+T+2)]
       =O(n 2^(n/3)).                           (8)

For all sufficiently large n the lower bound in (7) exceeds (8), since 2^(n/2)/(n 2^(n/3)) tends to infinity. There are therefore more forced outputs than functions computed by T-gate circuits, proving (5). The proof compares counts of entire functions/circuits, not polynomial descriptions against circuit gates. For every fixed polynomial b, floor(2^{n/3}) eventually exceeds b(n+C*(p_g)), since C*(p_g)<=n/2; this establishes the stated absence of a polynomial preservation bound for the rule.

This is an existential bad-mask result. No explicit hard g, efficient selection of one, or explicit hard total function is supplied. Given any chosen g, the mask construction is polynomial in N, while the existence proof does not become a hidden step of H. It remains an assessment of the specified completion algorithm, without a class separation, a general restriction on partial-to-total reductions, or a publication/novelty claim.

The initial challenger contributed to the mathematical count and checked the strengthening; that review is not represented as fully independent origination. A fresh proof reviewer must check the final frozen argument before route-final closeout. The earlier unresolved record and cubic argument are retained to make the scope and supersession explicit.
