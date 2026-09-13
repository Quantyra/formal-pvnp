# Independent hypercontractivity import review

2026-09-13. S3137. Reviewer: compact_source_encoding_audit. Source-only mathematical challenge, with no compiler, paper/Lean edit, Git or public action. I authored several lower encoding/constructor components and reviewed the finite matrix/spectral arguments; those activities provide no acceptance of this analytic theorem. No destination AGENTS.md was present at the formal repository root or companion.

**Verdict: bounded GO for conditional import adequacy; the analytic foundation and the proposed repaired dyadic proof remain unaccepted.** The exact weaker inequality used in the manuscript follows from the named EKL theorem statements, with the existing 500 constant and no new ambient parameter. This does not constitute a proof of those source theorems or a completed Lean proof.

## Exact evidence

I read the complete occurrence audit `2026-09-13-realizable-hardness-hypercontractivity-dependency-audit.md`, initial SHA256 f189607c66146baa899ad43f26c7ce007f66778af0af0884c03c63ea31328b9e, then read its added historical-version qualification and rehashed the final audit at SHA256 dba4baaa544e6ab2a413cd19e485c9c76171e1dbb601bc3c54a1e1d2c6858c8e. This review binds to that final version. Current manuscript `paper/submission-manuscript.md` SHA256 b34e466e110ffe2d6b46cc802130cef7e07c0f588df1f0b2c4c444ce3696cc48 was rehashed and its actual inverse hypothesis/application checked.

Primary evidence independently read: preserved MZv1 `s3123-mz2510.23991.pdf.txt` (e8cb21fb8279f7881a5cf5c53b87b09b215f0bb3c8466b8fbdfcd4517ee5fbce), MZ24 v1 `s3123-mz24.pdf.txt` (7457efd82898b827e2bb88a8d1a10d5a37b7888ebf31106813f44a8a805647c4), ECCC revision1 `s3124-mz24-r1.txt` (d7dff096e13c2b3c46a0a708d4fb4b6c1481ce0bfe0c323733241094f3fc33d7), and EKL v2 `s3134-ekl2404.00641v2.txt` (7fb002153b3ac62a3238c61574b65b3a2a28de3ce253fe6272d697a63247ab1a), all in C:/Users/Dan/AppData/Local/Temp. The EKL and revision1 hashes were freshly checked. The exact-version [EKL HTML](https://arxiv.org/html/2404.00641v2), sections 2, 4 and 5, independently confirms the disputed printed formulas; these are not extraction-only artifacts.

A useful version distinction: old MZ24 v1 A.7 prints the stronger exponent (p-1)/p. The preserved ECCC revision1 A.7 already prints (p-2)/p and weakens its moment bound accordingly. Thus the old A.7 discrepancy must not be attributed indiscriminately to every version. MZv1 Theorem4.6 and the current manuscript use the weaker exponent.

## Restriction contract and rank i <= r

Set V=F_2^D, W=F_2^n, D=2h. A consistent matrix restriction MU=Vtarget, XM=Y, based at one solution A, has difference space exactly L(V/V0,W0), where V0=span(columns U) and W0=ker X. Translation by A is a bijection preserving the uniform probability measure. Conversely choosing bases expresses every EKL affine restriction by such equations. No distribution on full-rank matrices is inserted: the Boolean lift is already zero on deficient matrices.

MZv1 Definition2.4 counts nominal numbers of vector equations, not ranks of independent equations. An EKL restriction of effective budget i<=r can therefore be expressed by i independent equations and padded with r-i zero=zero equations. Its conditional density is unchanged. The exact-r matrix hypothesis consequently supplies all rank-i restrictions required by Theorem5.5. Mean density is also <=delta by the all-zero padded restriction. For an independent-equations convention one would instead prove uniform refinement; the present route does not silently switch conventions.

For a Boolean function with conditional density a, the squared L2 norm is a, but its L^{p'} norm is a^(1/p'), with p'=p/(p-1). Consequently density <=delta supplies precisely the input delta^((p-1)/p) to EKL Theorem5.5. Using delta directly there would be an unjustified stronger assumption. Neither the theorem nor this restriction correspondence requires basis invariance. The later spectral argument does require it, separately.

The paper explicitly assumes h>=r and e<=1/2. Hence 0<delta=2e<=1 and r<D<=n. At i=0, the desired bound follows directly from the mean, so no positive-degree edge case is hidden. At delta=0 the Boolean function vanishes. No claim for delta>1 is needed by this application; the exponent weakening below must not be used with reversed monotonicity there.

## Independent arithmetic check

For i>=1 and dyadic p>=4, EKL Theorem5.5 and Proposition3.6 supply the level-i function f with globalness parameter

    eta1 = 2^((10+500p)i^2) delta^(2-2/p).

Theorem1.13 and Parseval then give

    ||f||_p^p <= 2^((450p^2-495p-10)i^2) delta^(p-2+2/p).

Here 200p^2+(10+500p)(p/2-1)=450p^2-495p-10 and 1+(2-2/p)(p/2-1)=p-2+2/p. For delta<=1, this is <=2^(500i^2p^2) delta^(p-2). Taking roots yields exactly the manuscript's bound. The older delta^(p-1) moment conclusion is not licensed by these inputs. The weaker conclusion is licensed, without changing the inverse epsilon-prime, S, or K_inv.

The actual moment is P, the least dyadic integer >=mT. Uniform probability norms satisfy ||f||_(mT)<=||f||_P. Since P>=mT, m-2m/P>=m-2/T, and the paper explicitly uses 2e<=1. Its resulting (r+1)^m 2^(500mr^2P+m) e^(m-2/T) estimate therefore has the correct direction. There is no use of an arbitrary non-dyadic exponent in the source theorem.

## Printed proof issues versus an unproved replacement

Direct inspection of EKL v2 section4 confirms two genuine displayed-argument gaps. Applying its stated induction hypothesis to f^2 of degree 2d at moment p/2 contributes 200(2d)^2(p/2)^2=200d^2p^2, whereas its displayed line uses 50d^2p^2. Also Lemma4.1's argument has only established a higher-order restriction parameter 2^(41d^2)epsilon before bounding that restricted squared L2 norm by epsilon. The referenced fourth-moment theorem assumes small generalized influences; globalness is a different hypothesis requiring conversion. These observations identify missing justifications in the printed route, not counterexamples to the theorem statement.

The audit's conservative replacement constants pass an arithmetic-only check conditional on the requisite derivative/globalness lemmas: globalness-to-influence costs 11d^2, the original fourth moment costs 103+11=114d^2, enlargement to 3d costs 41d^2, and a restricted fourth moment with both factors retained costs 103+11+41+41=196d^2. This gives A_4=114 and A_p=4A_(p/2)+49p-82. The proposed stronger invariant A_p<=200p^2-100p closes algebraically: substitution gives 200p^2-151p-82<=200p^2-100p. No need to increase the advertised 200 solely on this arithmetic.

This is NOT acceptance of that replacement proof. In particular it still needs the exact projection-to-influence conversion, order-lowering/orthogonality, restriction composition, product rank-degree bound and nonvacuous dimension boundary treatment on successively smaller spaces. I have not reconstructed the full EKL22 fourth-moment theorem or all inductive dependencies. The audit appropriately records the replacement as candidate review debt; retain that label.

## Actionable remaining obligation

The next substantive formal target is the binary finite-matrix generalized-derivative fourth-moment inequality and its exact restriction/globalness conversion chain, not a new wrapper assuming Theorem4.6 or a caller-provided influence bound. A short specialization can avoid the unrelated SL representation results, but cannot omit those derivative inequalities. Current theorem-statement imports suffice conditionally for the manuscript application; their complete analytic derivation and kernel proof remain open. This review neither changes the manuscript nor certifies the full analytic foundation, upstream hardness, novelty or publication readiness.
