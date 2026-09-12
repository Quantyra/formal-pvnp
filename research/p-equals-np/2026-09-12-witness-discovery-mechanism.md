# Witness discovery: product-kernel test and corrected-source PPSZ recombination

2026-09-12. S3085 / E004 / S008. Technical research in the active formal-pvnp satellite. This is a bounded research increment; the overnight P-versus-NP objective remains unresolved. This scoped source increment is committed locally; external publication belongs to the separately reviewed S3086 curated artifact. No source push, paid computation or external message was performed.

## Outcome and provenance

The proposed product-kernel ordering measure has exact normalization and entropy calculations, but no improved full forcing bound. It is not selected as a new SAT algorithm: its core Markov-chain idea already appears in Scheder's discussion. The missing control of conditional dependencies is substantive.

During comparison, an independent reviewer identified a source-version mismatch. A separate exact calculation now gives a feasible recombination of the corrected 2022 PPSZ inequalities. It has certified limiting unique-case bonus

`0.0000684193054602820920 < gamma_* < 0.0000684193054602820921`.

This is an algebraic consequence of specified imported estimates, not an independent proof of those estimates, a new algorithm, a priority claim, or a disproof of a later theorem. It supports the conservative bonus `gamma = 0.0000684193` after finite-strength error is paid. Independent proof and source/complexity reviews are GO for this scoped consequence; the final public claims review recommends PUBLISH for the separate curated certificate snapshot, subject to the recorded planning gate.

Reproducibility: [exact certificate script](2026-09-12-corrected-ppsz-certificate.py), [deterministic output](2026-09-12-corrected-ppsz-certificate.json). Python standard library only; no SAT benchmark or generic solver experiment was run. The named computational uncertainty was whether corrected coefficients admit a strictly positive common-coordinate dual improvement over the older coarse bonus.

## Closest primary results and precise difference

[Jiang–Cai, July 2026, v1](https://arxiv.org/html/2607.10697v1), Theorem 1.1, gives unique-case bonus 0.0000687793 and Corollary 1.2 gives general-case base 1.307031578. Its operation is common-coordinate recombination of earlier regular/irregular estimates, with the original PPSZ and existing lifting theorem unchanged. Equations (5) and (10) import the ECCC coefficients and 18/17 structural factor. We do not reuse those imports here. The proposed product measure would instead require a new forcing estimate; the corrected calculation below only reapplies the published recombination method to different source coefficients.

[Scheder, arXiv:2207.11071v1, 2022](https://arxiv.org/pdf/2207.11071v1), Sections 7.1, 7.8 and 8.4, supplies our imports. Its printed page 88 explicitly corrects the earlier edge-cut and regular TwoCC-bias issues. The corrected structural factor is 12/11 with components of at most 22 edges. The informal synopsis on printed pages 29–30 already discusses Markov-chain ordering and the difficulty of nonneighbor conditional dependencies. Thus exact path entropy alone does not establish novelty. The 2024 journal version omits the detailed 3-SAT calculation; source versions matter.

The [ECCC revision 1](https://eccc.weizmann.ac.il/report/2021/069/revision/1/download/) is the older source cited by the July paper. A cycle with 19 edges requires at least two deleted edges to leave components of at most 17 edges: zero deletions leaves a cycle, and one leaves a path with 18 edges. Two exceeds 19/18. This verifies the old graph-cut construction's failure independently. It does not show that every alternative choice of sibling subgraph fails, nor that the July theorem is false. We have not exhibited a unique-SAT instance realizing all disputed graph assumptions. The later source already records this correction, so the counterexample is not a new result.

## Concrete operation and first quantitative test

Let placements t_v lie in [0,1], with product uniform measure U. Define

\[
\gamma(t)=t(1-2t)^{3/2}\quad(0\le t\le1/2),\qquad
\phi(t)=\gamma'(t)=\sqrt{1-2t}(1-5t),
\]

and set both to zero above 1/2. For a finite path H propose the density

\[
D_\epsilon(t)=\prod_{uv\in E(H)}(1+\epsilon\phi(t_u)\phi(t_v)),\qquad 0\le\epsilon\le0.13.
\]

This proposal retains long paths instead of splitting every component into bounded pieces. In the actual algorithm, PPSZ still chooses a uniform permutation and guesses unbiased bits, with bounded implication. The solution-dependent graph is only an auxiliary proof measure. No procedure receives a satisfying assignment or feasibility oracle. If an implementation tried to sample this graph-dependent measure, graph discovery would become an additional unprovided operation.

The intended new guarantee was a larger worst-case forcing-minus-relative-entropy lower bound after all affected variables, repeated labels and adverse correlations are charged. Cheap normalization is only its first obligation.

### Exact path identities

Integration gives `integral phi = 0` and

\[
m_2=\int_0^1\phi(t)^2dt
=\int_0^{1/2}(1-12t+45t^2-50t^3)dt=3/32.
\]

Moreover |phi|<=1: the positive maximum is 1 at zero; the negative minimum is -1/sqrt(5) at t=2/5. Each factor is positive for epsilon<1. Integrating leaves successively proves integral D=1, uniform vertex marginals, and adjacent-pair density 1+epsilon phi(s)phi(t). Equivalently this is a stationary Markov chain with that transition kernel. Consequently

\[
\mathrm{KL}_2(D_\epsilon\Vert U)=|E(H)|d_\epsilon,
\quad d_\epsilon=\iint(1+\epsilon\phi(s)\phi(t))\log_2(1+\epsilon\phi(s)\phi(t))dsdt.
\]

Writing m_j=integral phi^j, the uniformly convergent Taylor expansion for epsilon<1 yields

\[
d_\epsilon=\frac1{\ln2}\sum_{j\ge2}
\frac{(-1)^j\epsilon^j m_j^2}{j(j-1)}
\le\frac{\epsilon^2m_2^2}{2\ln2}
\left(1+\frac{\epsilon^2}{6(1-\epsilon^2)}\right).
\]

Indeed odd summands are nonpositive, even moments satisfy |m_j|<=m_2, and j(j-1)>=12 for j>=4. This is at most 0.0064 epsilon^2 for 0<=epsilon<=0.13, strictly below for positive epsilon. It is an entropy bound for this different measure, not permission to replace the entropy term inside the source's forcing proof.

On a simple cycle of length ell>=3, the same product has normalization `1+(epsilon*m_2)^ell`. Only the empty and full edge subsets survive integration. A vertex marginal is

\[
\frac{1+\epsilon^\ell m_2^{\ell-1}\phi(t)^2}{1+(\epsilon m_2)^\ell},
\]

which is generally not uniform. Thus the path calculation cannot silently cover cycles.

### Why entropy does not finish the mechanism

At an internal path vertex, condition on neighbor values with a=phi(t_left), b=phi(t_right). Let M_2(r)=integral_0^r phi(t)^2dt. The exact conditional cumulative distribution is

\[
\Pr[t_v\le r\mid a,b]
=\frac{r+\epsilon(a+b)\gamma(r)+\epsilon^2abM_2(r)}{1+\epsilon^2abm_2}.
\]

Its difference from r includes both a first-order bias and a second-order term `epsilon^2 ab(M_2(r)-r*m_2)`. Unconditional distance correlations decay, but the proof exposes placements under root/ancestor conditions. Those conditions are exactly where adverse effects must be controlled. We do not have a bound summing these losses over full critical-clause trees that beats the source estimate. Transfer-matrix normalization does not supply it.

An earlier half-sign kernel was screened: for the direct event that both children precede a critical-clause root, the first derivative is +1/12 for a sibling edge and -1/24 for each root-child edge. Counting only the positive term is invalid. The refined phi avoids spending bias above the forcing saturation threshold, but does not resolve conditional losses. No easy instance is presented as a hardness result, and no product-measure impossibility follows.

## Corrected-source recombination: exact finite certificate

All following source estimates are imported. Let i0,i1 be the fractions of indegree-zero/one variables outside TwoCC, and tau the TwoCC fraction. They are nonnegative. Use distinct regular and irregular auxiliary measures; they bound the same uniform-order algorithm's success probability and need not be sampled together.

Put f(x)=(1-x)ln(1-x)+x. The corrected regular coefficients and structural inequalities give

\[
c_L=.00168728r-.00638r^2,\quad c_T=.009307-.0577r-.1503f(r),
\]
\[
A=(11/12)c_L,\quad T=2A/.9,\quad P=1.0302rT,\quad S=c_T-5A,
\]
\[
L_R=A-P-2Ai_0-Ai_1+S\tau.
\]

The factor 5A accounts for the 3A TwoCC loss in the edge partition and the further 2A when indegree counts are restricted outside TwoCC. The unchanged irregular expression is

\[
b_1=.030966i-.0028i^2-.4027f(i),\quad
b_0=.06259i-.344f(i),
\]
\[
b_T=.009307-.2405i-.03125i^2-.06183f(5i),\qquad
L_I=b_0i_0+b_1i_1+b_T\tau.
\]

Fix r=1/10 and i=73/1000. Both are at most .1; the irregular constraints i<=4/5, i<=256/600 and 5i<=1 hold. T<1/4678, within the corrected high-label estimate's threshold cap. The regular and irregular TwoCC bias functions are different and are not interchanged.

Define lambda=b1/A. For every nonnegative triple,

\[
\max(L_R,L_I)\ge\frac{\lambda L_R+L_I}{1+\lambda}
=\frac{\lambda(A-P)+(b_0-2b_1)i_0+(b_T+\lambda S)\tau}{1+\lambda}.
\]

The i1 coefficient vanishes identically. The exact certificate gives

| Quantity | Outward enclosure |
|---|---|
| b0-2b1 | (0.0013383343013574221959, 0.0013383343013574221960) |
| bT+lambda*S | (0.0139781228441146605913, 0.0139781228441146605914) |
| gamma_* = b1(A-P)/(A+b1) | (0.0000684193054602820920, 0.0000684193054602820921) |

This proves the affine lower bound gamma_* using rational interval arithmetic and no optimization oracle. It exceeds 1/15218 and is below July's stated 0.0000687793. Comparing to that older rounded bonus does not establish priority, optimality or a literature-wide best bound. This calculation does not repair every potential issue in the July paper; it supplies its own specified-input implication.

For logarithms the script uses the first 100 terms of -ln(1-x)=sum x^k/k and bounds the omitted tail by x^101/[101(1-x)]. Every interval operation is exact rational arithmetic. Decimal output is rounded outward. The script also encloses ln2 by its atanh series and exponentiation by its positive Taylor series, verifying

\[
2^{2\ln2-1-0.0000684193}<1.306969924.
\]

### Quantifiers, costs and relationship to P versus NP

Conditional on the cited corrected forcing estimates with their finite-strength convergence, choose gamma=.0000684193, strictly below gamma_*. First choose a finite implication strength w so its normalized error is smaller than a fixed fraction of gamma_*-gamma, and then choose n0 so the remaining o(n) term fits the remaining slack. For all n>=n0 and uniquely satisfiable 3-CNF inputs,

\[
\Pr[\mathrm{PPSZ}_w(F)\text{ returns its witness}]
\ge2^{-(2\ln2-1-\gamma)n}.
\]

One run costs n^{O(w)} for fixed w (polynomial input factors are suppressed in O*); implication is sound and exact. Independent repetitions to constant success probability cost O*(1.306969924^n). All outputs are checked against the original CNF. No explicit useful numerical w or n0 is supplied by this certificate. Bounded implication, preprocessing, run count, verification and input reading remain charged. The auxiliary graph and measure are proof objects, not uncharged discovery preprocessing.

The known unique-to-general lifting supplies a smaller positive general-case improvement under its hypotheses; this note does not assert a newly certified numerical general-case base. The result remains randomized exponential time. A polynomial randomized SAT witness algorithm with one-sided verification would yield RP=NP, not automatically P=NP. A uniform deterministic polynomial SAT witness algorithm with a known polynomial timeout on all satisfiable inputs would decide SAT and yield P=NP. Neither is obtained. This is potentially useful quantitative source reconciliation, with no established P-versus-NP implication beyond those explicit conditional statements.

## Selection boundary

The product-kernel forcing campaign remains unproved; no new mechanism is selected for implementation. The corrected-source arithmetic is a reviewed, reproducible imported-theorem consequence, not a novel application of PPSZ or a discovered SAT solver. A narrowly scoped computational reproduction note could be useful without claiming algorithmic novelty. Its precise public claim, attribution and source boundary passed the [final nonclaims/publication-readiness review](2026-09-12-witness-discovery-nonclaims-review.md). The curated candidate is fa16d31e620af06d965225a85938c766d3a89950; the draft retained here is its preparation evidence. Publication execution awaits the root planning decision. No automatic successor, formalization or publication is launched here.

| Review lens | Actual evidence and scope |
|---|---|
| Independent proof | [GO](2026-09-12-witness-discovery-proof-review.md) for path/cycle identities and exact corrected-source affine implication; no proof of improved product forcing or of the imported source estimates. |
| Independent source/complexity | [GO](2026-09-12-witness-discovery-complexity-review.md) for the bounded imported-estimate consequence; product forcing INCOMPLETE; publication requires separate readiness assessment. |
| Final scope/public readiness | [PUBLISH recommendation](2026-09-12-witness-discovery-nonclaims-review.md) for the isolated reproduction snapshot; no improved product forcing or overnight-objective closeout. |
