# A matching-order X-only positivity window for the bamboo-tree functional

2026-09-12; S3091 / E004 / S008; [integrity](../../INTEGRITY-CLAIMS.md). Research derivation; independent final proof review PASS. No SoS lower bound, feasible full pseudoexpectation, priority claim, or P-versus-NP consequence.

The [previous obstruction](2026-09-12-frontier-structural.md) gave one negative square at ordinary polynomial degree O(n/log n) when m=n^2. The extension here proves positivity for **every X-only polynomial of degree at most D**, for an explicit D=Omega(n/log n). Thus, at polynomially many rows, combining more characters or mixing degrees cannot sharpen that obstruction to constant or logarithmic ordinary degree. This is an actual positive-semidefiniteness statement for the whole X-only low-degree space, beyond the fixed-character principal block. It does not compute the full spectrum or cover Y and auxiliary variables.

## Imported source contract

The source is [Garlik--Gryaznov--Ren--Tzameret, TR26-133](https://eccc.weizmann.ac.il/report/2026/133/download/), Definitions 6.5--6.6, Lemma 6.7, and the functional in the proof of Lemma 6.4 (printed pages 69--71). The cached primary text and the previous [source review](2026-09-12-frontier-structural-source-review.md) were read for this increment. With J empty, its local distribution on t X rows is uniform over odd vectors x_1,...,x_t in F_2^n such that e,x_1,...,x_t are linearly independent, where e is the all-ones vector. Its functional R is defined on multilinear polynomials whose individual monomials have row-degree at most n-2. These statements concern the bamboo-tree encoding, not the source's separate perfect-matching SoS lower bounds.

Throughout, n is even, n>=16, m>n, q=mn, and N=2^(n-2). Boolean polynomial degrees below are ordinary degrees in the q individual X entries. Products and squares are reduced using x^2=x before applying R. Taking A=I_m gives the intended unsatisfiable rank family when needed; the X-only marginal itself is independent of A.

## The full-space positivity theorem

For an integer D>=1 with 2D<=n-2, let

    L = sum_{j=0}^D binom(q,j),
    delta_t = 1 - product_{j=1}^{t-1}(1 - 2^(j-1)/N),
    delta = delta_(2D).

For t=0,1, take delta_t=0. If L*delta<1, then every nonzero multilinear X-only polynomial p of degree at most D satisfies

    R(p^2) >= (1-L*delta)/(1-delta) * E_mu[p^2] > 0,       (1)

where mu is the genuine product distribution in which all m X rows are independently uniform odd vectors. Distribution mu is only a comparison measure; it is not claimed to satisfy the source rank constraints.

An explicit sufficient choice, allowing D=0 as the trivial constant case, is

    D = floor((n-4)/(log_2(mn)+2)).                         (2)

For D>=1 this choice gives L*delta<1/4 and hence the uniform lower bound R(p^2)>=(3/4) E_mu[p^2]. There is no global conditioning on all m rows: such a frame is impossible when m>n. Each Gram entry uses the source's own local marginal on the rows touched by that entry.

### Proof

Index Boolean Fourier characters by coordinate subsets S of [m] x [n]:

    chi_S(X) = product_{(i,j) in S}(1-2x_(i,j)).

The characters with |S|<=D are a basis of the multilinear polynomials of degree at most D. On one uniform odd row, the expectation of a character indexed by a nonempty proper coordinate subset is zero. Indeed, it is the restriction of a nontrivial character to the affine parity hyperplane, and its linear functional is neither zero nor the full parity functional. Independence between rows then gives

    E_mu[chi_S chi_T] = 1 if S=T, and 0 otherwise,         (3)

because a nonempty S symmetric-difference T has size at most 2D<n, so no row can carry the full n-coordinate character. In particular, for p=sum_S c_S chi_S, E_mu[p^2]=sum_S c_S^2, which is positive for nonzero p in this multilinear space.

To compare a source entry, let t be the number of rows touched after the product chi_S chi_T is reduced. Those t rows are iid uniform odd rows under mu before conditioning. Quotient by span(e). Since n is even, parity descends to a nonzero linear functional on the quotient, and its odd affine hyperplane has N points. Each quotient point has two odd lifts, so the quotient samples are iid uniform on those N points. The source condition is exactly that these quotient vectors be linearly independent.

After j>=1 independent odd quotient vectors have been chosen, their span contains precisely 2^(j-1) odd points: parity is a nonzero functional on their j-dimensional span. Consequently, the exact probability that a t-tuple fails the frame condition is delta_t displayed above. In the allowed range it is less than one, increases with t, and, for t>=1, obeys

    delta_t <= sum_{j=1}^{t-1} 2^(j-1)/N
            = (2^(t-1)-1)/N.                              (4)

Conditioning iid samples on the frame-success event gives exactly the uniform source law. For S!=T, write h=chi_(S symmetric-difference T) and E for this local frame event. Equation (3) gives E_mu[h]=0 and |h|=1, whence

    |R(chi_S chi_T)|
      = |E_mu[h 1_E]/Pr_mu(E)|
      = |E_mu[h 1_(not E)]/Pr_mu(E)|
      <= delta_t/(1-delta_t)
      <= delta/(1-delta).                                 (5)

For S=T the entry is exactly one. Every product uses at most 2D rows, inside R's actual domain. Thus the real symmetric L-by-L Gram matrix G has diagonal one and each off-diagonal entry bounded in absolute value by delta/(1-delta). For every real coefficient vector c,

    c^T G c >= [1-(L-1)delta/(1-delta)] sum_S c_S^2
            = (1-L*delta)/(1-delta) sum_S c_S^2.            (6)

For completeness, the first inequality follows from
sum_(S!=T)|c_S c_T| <= (L-1)sum_S c_S^2, by applying 2|ab|<=a^2+b^2 to each unordered pair. Equations (3) and (6) prove (1). No exact simultaneous diagonalization is required.

For (2), the case D=0 is immediate. If D>=1, q>=2 and

    L <= sum_{j=0}^D q^j <= 2q^D,
    delta < 2^(2D-n+1),
    L*delta < 2^(D(log_2 q+2)-n+2) <= 1/4.                (7)

The domain condition follows from log_2 q+2>=3 and 2(n-4)/3<=n-2. Finally (1-L*delta)/(1-delta)>=1-L*delta>3/4. This completes the proof.

## Matching-order failure scale and what changes

For m=n^2, (2) is floor((n-4)/(3log_2 n+2))=Omega(n/log n). The previous note exhibits a polynomial p of degree at most 2k with R(p^2)<0, where k=2ceil(n/(2log_2 n)), and its reduced square has row-degree at most 2k<=n-2. Therefore the minimum ordinary degree of an X-only polynomial with a defined negative square is **Theta(n/log n)** along even n with m=n^2. The lower statement is an asymptotic order bound, not an exact threshold or an optimal constant. The upper argument is recalled next from its existing independently reviewed proof; no new finite experiments establish either bound.

To recall that upper argument, write f_i=(1-2x_(i,1))(1-2x_(i,2)). In V=F_2^n/span(e), let a be parity and b(v)=v_1+v_2. The covector b is outside {0,a}. The group preserving a acts transitively on covectors outside {0,a} and preserves the uniform independent odd t-frame. Averaging b over that orbit computes its moment on a fixed frame. Restriction of all covectors to that independent frame has equally sized fibers; removing 0 and a removes one copy of the patterns 0^t and 1^t. Consequently for positive even t<=n-2,

    R(product_(i in T) f_i) = -2/(2^(n-1)-2) = -1/(N-1).

For the M=binom(m,k) products g_S=product_(i in S)f_i indexed by k-subsets, Boolean cancellation gives diagonal Gram entries one and every off-diagonal entry -1/(N-1), since |S symmetric-difference T| is positive even and at most 2k. Thus for p=sum_(|S|=k)g_S,

    R(p^2) = M(N-M)/(N-1).

For even n>=16, k<=n/log_2 n+2<=(n-2)/2 and k<n, while k>=n/log_2 n. The middle domain inequality follows because (n-2)/2-n/log_2 n-2 is positive at n=16 and increasing thereafter. With m=n^2 this gives M>n^k>=2^n>N. The square is negative and its row-degree at most 2k remains in the source domain. Each g_S has ordinary degree 2k. This completes the upper half of the matching-order claim. The square has exponentially many indexed summands; its existence is not a short SoS refutation.

More generally, if n<m<=n^C for a fixed C>1, (2) is Omega(n/log n). In particular, for any fixed c, all nonzero multilinear X-only polynomials of ordinary degree at most c log_2 n have positive square expectation for sufficiently large even n. This includes every choice of row characters and mixtures of degrees fitting that degree budget, not just characters descending to the quotient. High-weight row characters do not become low ordinary degree merely because they are indexed as single characters.

This changes the next feasibility question. A search for a constant/logarithmic-degree negative square using only the X variables of this unchanged functional is asymptotically excluded. Any such earlier failure must involve Y or auxiliary variables, a different variable encoding/degree notion, or a different family outside the declared parameter assumptions. The result does not show that the full source functional is positive at these degrees: mixed X/Y/auxiliary blocks and constraint identities remain separate obligations. It also does not produce a replacement functional that works above this window. No source generator or size-to-degree transfer follows.

## Significance and verification boundary

The mechanism is elementary: rare local conditioning, low-degree Fourier orthogonality, and an entrywise matrix perturbation estimate. None of those generic tools is claimed as novel. The source-specific result is a matching-order positivity/failure window for the entire X-only ordinary-degree space, answering the concrete strengthening question left open by the earlier principal-block obstruction. Whether that application warrants publication requires the separate novelty/significance assessment; absence of a search match is insufficient.

No repeated finite experiments, Lean implementation, commit, push, publication, outreach, or paid computation were performed. The author derived this positive-space theorem. The independent proof reviewer checked its early statement without supplying the construction; final independent proof review is now PASS.

## Three-lens closeout

| Lens | Actual record | Scope |
|---|---|---|
| Independent proof | [Proof review](2026-09-12-weak-rank-extension-proof-review.md) | PASS for the full X-only lower window, upper witness, and exact public extraction. |
| Source and significance | [Source/significance review](2026-09-12-weak-rank-significance.md) | GO for the actual source-specific two-sided theorem and modest note; priority unknown. |
| Non-claims | [Non-claims review](2026-09-12-weak-rank-nonclaims-review.md) | GO for bounded claims, attribution, and curated candidate; publication requires its separate gate. |

These are distinct AI-agent reviews, not formal verification or human peer review. The non-claims reviewer prepared the public extraction; its mathematics was checked by the independent proof reviewer. The reviewed six-file release-ready local candidate is commit `6d09b0966df5ab3847a6283aab677507b7e9cf5c`, intended for `Quantyra/weak-rank-positivity-window`. The CFF metadata passes the official 1.2.0 schema, local links resolve, and private-path/story/credential hygiene passes. No remote or release was created by this increment. Publication status remains HOLD until the root records the exact-candidate decision. The larger research objective remains unresolved; this is no complexity-gain edge.
