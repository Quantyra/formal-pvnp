# Full-encoding positivity audit: an exact mixed negative square

2026-09-12; S3093 / E004 / S008; [integrity](../../INTEGRITY-CLAIMS.md). Analytic author record. **The requested asymptotic full-encoding positivity window for polynomially many rows remains unresolved.** The result below is an exact mixed-variable obstruction in a different asymptotic regime, with two finite polynomial-size examples. It is not a SoS lower bound, a rejection of every possible functional, or a P-versus-NP result. No public artifact is updated.

## Actual source and domain

The primary source is [Garlik--Gryaznov--Ren--Tzameret, TR26-133](https://eccc.weizmann.ac.il/report/2026/133/), Definitions 6.1--6.7 and the functional R in the proof of Lemma 6.4, printed pages 68--71. The cached primary text was read. The live PDF request timed out. This is the strengthened, restricted bamboo encoding BT-bullet-Rank-prime, not the paper's distinct perfect-matching SoS result.

Work over even n>=6, m>n, A=I_m, e=(1,...,1), and N=2^(n-2). The source local law on row sets I,J samples full-rank matrices with extra all-ones row/column, prescribed pairwise dot products, and odd X rows and Y columns. It assigns u_(i,j,k) to the first k dot-product terms modulo two. In particular u_(i,m+1,2)=x_(i,1)+x_(i,2) modulo two is an actual source auxiliary variable.

R acts on multilinear monomials of row-degree at most n-2, and row-degree is counted per monomial. Each internal auxiliary touches one X row and one Y column. Thus all full-variable squares of ordinary polynomial degree D are in its domain under 4D<=n-2; particular squares can use fewer rows, as this one does. Products throughout are Boolean reduced.

## Exact mixed square

Define

    b_i = 1-2u_(i,m+1,2) = (-1)^(x_(i,1)+x_(i,2)),
    p = sum_(i=1)^m b_i,
    q_(j,l) = (1-2y_(1,j))(1-2y_(1,l)),       j<l,
    Q = sum_(j<l) q_(j,l),      M = binom(m,2),
    P = p + (m-4)/(N-1) * Q.

P has ordinary degree at most two in the actual U,Y variables. Every monomial in p^2 touches at most two X rows, in pQ at most one X plus two Y rows, and in Q^2 at most four Y rows. Thus P^2 is defined for every even n>=6, without requiring the more conservative generic full-space degree bound.

The exact formula is

    R(P^2) = m(N-m)/(N-1) - M(m-4)^2/(N-1)^2.             (1)

Consequently it is negative precisely when

    (m-1)(m-4)^2 > 2(N-m)(N-1).                          (2)

In particular, at n=12, m=144=n^2, (1) equals -728960/10571. Here R(p^2)>0: the negative direction is created by coupling to the Y-pair aggregate. This single finite point does not refute an asymptotic Omega(n/log n) full positivity window.

### Proof of all moments

The known X-only frame calculation gives

    R(p^2) = m(N-m)/(N-1).                               (3)

This is applied to the even row character b_i. It does not require new X-only positivity or threshold experiments.

For distinct Y columns j,l, the source Y-only law is uniform over odd vectors v,w with e,v,w independent. Given any even vector d outside {0,e}, exactly 2N ordered pairs have v+w=d: each odd v gives the uniquely determined odd w=v+d, and independence holds. There are 2N-2 possible differences. Therefore

    Pr(v+w=d) = 1/[2(N-1)].                              (4)

Fix an X-row index i. By the source's consistency and uniform extension property, conditional on v,w, its row X_i is uniform on

    e dot X_i=1,  v dot X_i=A_(i,j),  w dot X_i=A_(i,l).

The three equations are independent. Because e is even and X_i is odd, the X-side full-rank requirement imposes no further exclusion. Put beta=(1,1,0,...,0). The average of (-1)^(beta dot X_i) on this affine space vanishes unless beta lies in span(e,v,w). Since beta is even and outside {0,e}, this happens exactly when v+w=beta or beta+e. Its conditional average is respectively s or -s, where s=(-1)^(A_(i,j)+A_(i,l)). Meanwhile q_(j,l)=(-1)^(v_1+w_1) is respectively -1 or +1 on those events. Combining both events with (4) yields

    R(b_i q_(j,l)) = -(-1)^(A_(i,j)+A_(i,l))/(N-1).       (5)

For A=I_m and j!=l, exactly two indices i give the negative sign in the numerator. Hence

    R(p q_(j,l)) = -(m-4)/(N-1),
    R(pQ) = -M(m-4)/(N-1).                               (6)

Finally the Y-only odd-frame law is invariant under replacing any individual column v by v+e. This preserves parity and independence with e, and flips its first-coordinate sign. If two distinct pairs index q_(j,l) and q_(j',l'), their product has an index appearing just once, so this involution makes its expectation zero. Each q_(j,l)^2 is identically one. Consistency allows all these pairwise moments, each on at most four Y rows. Thus

    R(Q^2)=M.                                           (7)

Expanding P^2 with (3), (6), and (7) proves (1). Multiplication by the positive factor (N-1)^2/m gives criterion (2).

### The exact kernel diagnostic that led here

At m=N, (3) is zero. Taking just q=q_(1,2), equations (5)--(6) give R(pq)=-(N-4)/(N-1), while R(q^2)=1. Therefore

    R((p+q)^2) = (7-N)/(N-1) < 0.

For n=8,m=64=n^2 the value is -19/21. This directly exposes a failure of the necessary PSD rule that a zero-square vector be orthogonal to all vectors. Its general m=N family is exponential in n, so it must not be promoted to a large-n polynomial-m obstruction.

## What the result does and does not settle

For m much smaller than N, criterion (2) has transition scale m of order N^(2/3)=2^((2n-4)/3). More precisely the ratio of the left side to the right side is asymptotic to m^3/(2N^2) when m tends to infinity and m/N tends to zero. For every fixed C, taking m<=n^C makes that ratio tend to zero. Thus this particular degree-two family supplies no asymptotic counterexample in the requested polynomial-m regime. The n=12,m=n^2 example remains a valid finite counterexample, not such a family.

The actual progress is an explicit negative square involving a source auxiliary and Y variables, including a source-local mixed-moment formula and an explanation of how a null X-side direction can couple incorrectly. It does not establish the complete full-variable PSD theorem or falsify it at the sought asymptotic degrees. A proof or obstruction for that target is still required.

The ordinary-degree gain here uses the real parity auxiliary: b_i is degree one in U but degree two after eliminating U into X. It would be incorrect to claim that these are the same degree model.

## Constraint compatibility and comparison obstruction

For a source axiom h and monomial t, the source's common local assignment proves R(th)=0 whenever the union of their row supports is at most n-2. By linearity this covers polynomial multipliers monomial by monomial. All Boolean, output, and bamboo gate equations are therefore compatible in that support range. Clause falsification polynomials enjoy the same property. For an arbitrary degree-D polynomial multiplier square, 4D+2<=n-2 is a sufficient support bound because each source axiom touches at most two rows. This does not prove PSD: the square above obeys the available local constraint identities and is nevertheless negative.

A simple iid-odd X,Y comparison with U set to true prefixes has output residual u_(i,j,n)-A_(i,j) of square expectation 1/2, whereas the source assigns it square expectation zero. Defining early U variables by prefixes and late ones by the output and suffix merely moves this discrepancy to the intervening gate: writing a=x_(i,k), b=y_(k,j), c=u_(i,j,k-1), d=u_(i,j,k), the gate residual h=d-c-ab+2cab has square expectation 1/2 at the seam under that comparison and zero under R. Thus a small perturbation estimate for this naive comparison cannot establish full positivity. A valid alternative must handle the exact source kernel, not just ignore these ordinary-degree-three relations.

The source review also derives an exact normalized Fourier operator bound 1/sqrt(N) for one X row against one Y column. That is a useful genuine mixed correlation estimate, independently checked, but it is not a full Gram theorem for arbitrary prefix auxiliaries. It has not been promoted to one here.

## Verification and closeout boundary

An exploratory exact integer Gauss-sum computation supplied moments of midpoint U signs on at most two X and two Y rows. A numerical eigensolver on the centered midpoint-U-only degree-one Gram at n=8,m=64 found smallest eigenvalue approximately 0.09677419. This diagnostic found no witness; it is not a proof of positivity and is not used in (1)--(7). The larger sweep was canceled. The analytic mixed witness above supersedes that diagnostic; it requires no numerical eigensolver or approximation.

Independent proof and source reviewers read this actual aggregate record and returned the bounded decisions below. The source reviewer contributed the auxiliary, constraint, and operator observations; the separate proof reviewer independently checked the adopted operator and constraint mathematics and did not supply the negative-square construction. These are AI-agent reviews, not formal verification, external human peer review, or novelty certification.

| Lens | Actual-file decision | Boundary |
|---|---|---|
| [Independent proof](2026-09-12-weak-rank-full-proof-review.md) | PASS | Exact mixed square, domain, moments, arithmetic, and adopted source-review mathematics; asymptotic polynomial-m target INCOMPLETE. |
| [Source/complexity](2026-09-12-weak-rank-full-source-review.md) | GO | Actual source and bounded aggregate theorem; mathematical contributions disclosed; asymptotic polynomial-m target INCOMPLETE. |
| [Independent non-claims](2026-09-12-weak-rank-full-nonclaims-review.md) | GO | Bounded main record and graph entry; no full-target or novelty claim. |

This increment is preserved as a scoped local documentation commit. No Lean proof, paid computation, outreach, push, publication, or public-note update is part of this increment. The previously published X-only note remains valid and unchanged; this mixed result uses a different variable sector and does not contradict its asymptotic polynomial-row statement. The full asymptotic research goal remains ACTIVE and unresolved; this is bounded-result preservation, not route-final completion of that target.
