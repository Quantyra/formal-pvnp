# Independent rank-incidence fourth-moment review

2026-09-13. S3137. Reviewer compact_source_encoding_audit. Source-only; no compiler, Lean/paper edit, Git or public action. Existing satellite protocol context applies. I authored lower encoding components and the separate finite derivative-core review, not the counting candidate. None of that is acceptance of the fourth-moment foundation.

**Bounded GO:** the counting/averaging deduction of coefficient 103 is valid conditional on the exact Theorem58 and normalized Fourier orthogonality. No mathematical correction to that core is needed. Theorem58, Lemma64/Proposition63 and the complete hypercontractive/Lean proof remain outside this verdict.

Reviewed full candidate `2026-09-13-realizable-hardness-rank-incidence-fourth-moment-derivation.md`, SHA256 37b1c64799afcc38006c12376aa7ec685a05c70b2d5f96d963fb12d26ab574e1, freshly rehashed. Direct primary read: Ellis/Kindler/Lifshitz arXiv:2209.04243v1, `C:/Users/Dan/AppData/Local/Temp/s3134-ellis2209.04243v1.txt`, SHA256 9259246e882f05e02fb8585400fed15b6a1d9e68106cbcd813c8851ecfdc468a, Theorem58 (printed p.35), Proposition63/Lemma64 (p.37), Corollary65 (p.38). This is not the later Evra paper.

## Exact conditional theorem and normalization

Theorem58 assumes a complex-valued function on Hom(V,W) of Fourier rank degree at most d. It concludes

    ||f||_4^4 <= q^(100d^2) sum_(A<=V,B<=W) E_T (||D_(A,B,T)f||_2^2)^2,

with T uniform on the entire Hom(V,W). The derivative's inner L2 norm is on Hom(V/A,B). This is the square of its energy, not its fourth-moment norm. The theorem's restricted-sum display has a subscript typography issue; the candidate's order dim A+codim B agrees with the actual derivative definitions and follows independently from the selector argument below.

Writing D_(A,B,T)f(R)=L_(A,B)f(T+jRq), each fixed R makes T->T+jRq a permutation of Hom(V,W). Therefore normalized finite averaging gives

    E_T ||D_(A,B,T)f||_2^2 = ||L_(A,B)f||_2^2.

No index of a subspace, number of representatives, or reciprocal fiber factor occurs. Parseval turns the right side into the sum of |fhat(X)|^2 over retained labels. Absolute squares are essential for complex functions. This argument survives singleton domains and does not assume the residual Fourier labels are distinct.

## Exact multiplicity checked independently

Fix X:W->V of rank j. Its retained pairs satisfy A<=im X and X^(-1)(A)<=B. For dim A=a, rank-nullity gives dim X^(-1)(A)=dim W-j+a. There are [j choose a]_q such A. After choosing A, the space W/X^(-1)(A) has dimension j-a, and B corresponds bijectively to its codimension-b subspace, where b=codim_W B. Hence the count for given a,b is exactly

    [j choose a]_q [j-a choose b]_q,  0<=a<=j, 0<=b<=j-a.

The second Gaussian coefficient may equally be written [j-a choose j-a-b]_q; symmetry explains why the codimension notation gives the displayed answer. In particular a+b<=j is forced, so above-degree Laplacians vanish directly. This is not a loose bound on two independently chosen image/kernel conditions.

For j<=d, all retained pairs obey the budget and their count is

    C_j = sum_(a=0..j) sum_(b=0..j-a) [j choose a]_q [j-a choose b]_q.

The candidate's bound [u choose v]_q<=q^(uv) is valid: ordered independent v-tuples surject onto v-subspaces and are a subset of all v-tuples. It does not require an incorrect one-to-one correspondence. Thus each summand is at most q^(ja+(j-a)b)<=q^(j^2). There are (j+1)(j+2)/2 terms. For j>=1, this is <=(j+1)^2<=2^(2j)<=q^(2j), yielding C_j<=q^(j^2+2j)<=q^(3j^2). At j=0 there is exactly one pair, A=0,B=W, so C_0=1. These estimates have no ambient-dimension factor.

## Influence hypothesis and coefficient

The required premise is the actual pointwise bound I_(A,B,T)=||D_(A,B,T)f||_2^2<=epsilon for every order<=d and every T, with epsilon>=0. Nonnegativity gives I^2<=epsilon I. Combining Theorem58, the averaging identity, Parseval and the exact count yields

    ||f||_4^4
      <= q^(100d^2) epsilon sum_X |fhat(X)|^2 C_(rank X)
      <= q^(103d^2) epsilon ||f||_2^2.

No Booleanity, basis invariance, globalness assumption, full-rank conditioning or arbitrary norm certificate is smuggled into this implication. Such conditions may be needed to obtain the influence premise elsewhere, but are not needed for this finite deduction.

For d=0, f is constant and the order-zero influence is |f|^2, proving the inequality directly. For epsilon=0, order-zero derivatives are translates of f and have energy ||f||_2^2, forcing f=0. If d exceeds min(dim V,dim W), use the smaller effective rank-degree bound in Theorem58 and the corresponding subset of influence hypotheses, then weaken the coefficient to q^(103d^2). If either ambient space is zero, the map space is a singleton and the only retained rank-zero pair is still A=0,B=W. No nonexistent-restriction premise is needed for these cases.

## Explicit non-acceptance boundary

The candidate's separate Proposition63 paragraph is not part of the counting proof. Its primary statement uses all restriction orders <=d; the nominal exact-r padding convention of the MZ interface is a separate bridge. The proposed all-orders induction amendment has a correct scalar inequality, 4q^(4d)q^(10(d-1)^2)<=q^(10d^2) for d>=1,q>=2. That arithmetic does not prove Lemma64's arbitrary translation, level selection, dual case or derivative factorization. Those must be reviewed with the actual operators. Likewise the coefficient-100 theorem has not been discharged by counting its consequence.

This review accepts a finite mathematical deduction conditional on a precisely stated theorem, not an analytic axiom for the eventual Lean development. It does not establish Theorem58, full hypercontractivity, kernel acceptance, upstream hardness, novelty or publication readiness.
