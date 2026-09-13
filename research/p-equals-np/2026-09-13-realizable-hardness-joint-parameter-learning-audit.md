# Joint-parameter and learning-transfer audit - 2026-09-13

S3126/S3128/S3137. Independent paper-source audit by incidence_complexity_review; not the manuscript author. Prior authorship of lower Lean encoding components is disclosed; none supplies the decoder theorem audited here. No compiler, implementation, Git or paper/public edit. Only this private audit note was written.

**Result: GO-WITH-NOTES for the reviewed parameter order and enlarged-ambient query-law bridge.** Keep the prescribed J. The relevant multi-leaf observable has an exact random-complement identity, proved below; a raw-leaf coupling error is unnecessary. The source exposes explicit improving ambient errors, not an arbitrary unknown threshold. This is a bounded paper-source audit, not full source-proof reconstruction, formal certification, novelty or publication clearance.

## Sources and prior work

Read destination README.md, paper/README.md, SOURCES.md, REVIEW.md and the actual generated paper/body.tex, together with its editable source paper/submission-manuscript.md. No destination AGENTS.md was present. Body raw SHA256: `4f67ef020f7cb3b03d0d4d9499e24ca2598ab857e41c63b8cfaa5320a4a2240a`; submission raw SHA256: `491f54667880a85efe47fc5fd15cd371d6a945b21647a88f1acf6f748a99590b`. Paths and line references below are in C:/Users/Dan/Desktop/Projects/realizable-cmmsa-hardness. Body is generated; proposed changes must ultimately be made in the editable submission source.

Also read formal-pvnp's 2026-09-12-realizable-hardness-dependency-audit.md, source-directed-frontier-fresh-review.md and realizable-hardness-critical-source-obligation-audit.md. They already document the modified repetition order, joint posterior multiplication, threshold ladder, fixed-L convention and missing formal decoder/source-hardness implementation. This note does not rediscover those results. Its additional content is an explicit A-independent quadratic exponent and the narrower quantifier test for the ambient-growth sentence.

Fresh primary-source check: [MZ v1 Sections4.1-4.2](https://arxiv.org/html/2510.23991v1#S4) delegates amplification and side conditions to MZ24, with the higher-arity inverse theorem substituted. Its matrix step needs (2h+2rho*m*h)2^(2h-n)<=1/2; the spectral ambient residual is3*2^(d-n), d<=2h. Both improve as n increases. The displayed high-degree estimate contains dropped-positive-term/index shortcuts; retain the safe residual3*2^(2h-n) with a constant margin instead of certifying those displayed equalities verbatim. No ambient upper bound was found in this chain.

[MZ24 v4 Section5.1.2 and AppendixB](https://arxiv.org/html/2404.07441v4#S5.SS1.SSS2) use a random complement of the side-condition space, then randomize table entries to obtain many useful zoom-ins. The final disjointness correction is2^(r-2J). The AppendixB failure bound has an exponential-of-exponential term in ambient n; it improves at n=2J. Its one-leaf complement identity alone does not establish a multi-leaf joint identity. The manuscript's narrower maximal-pair contract already requires dim(V)>=2^h (body61), which J satisfies. HN's internal proof is not newly certified; the downstream calculation uses the previously audited imported contract at body73.

## Explicit decoder constant before A

Fix m,rho and r=10m/rho first. In body186-224, let the good-U mass be at least K_U^{-1}2^{-B_U h}, and the maximal-pair list size at each guessed threshold be at most K_M 2^{B_M h}. These are names for the two existing displayed fixed-parameter bounds, not additional generic theorem assumptions; their independence from J is the source-interface issue isolated below. Enlarge K_U,K_M to at least1 and B_U,B_M to nonnegative values.

The existing favorable-Q mass is at least2^{-8h^2}; favorable-V conditional probability is at least C/8, with C>=2^{-2h}/5. Both provers' advice-dimension guesses and the threshold guess cost at worst (r+1)^{-3}; random extension costs at worst2^{-r}. Therefore the paper's strategy, after the already-budgeted posterior/transversality losses but before the vector-advice correction, has success at least

    K^{-1} 2^{-8h^2-Bh},
    K = 40 K_U K_M (r+1)^3 2^r,   B = B_U+B_M+2.

For h>=max(1,B+log2 K), Bh+log2 K<=h^2, so this is at least2^{-9h^2}. If J>=9h^2+r+1, subtracting the actual vector-law error2^{r-J} leaves at least2^{-9h^2-1}>=2^{-10h^2}. Thus body240 can use the concrete coefficient C_*=10, with the sufficiently-large-h cutoff still depending on m,rho. No reciprocal posterior likelihood factor enters this lower bound.

Choose integer A>20/kappa, where kappa is the fixed outer-game exponent from body242. Since beta J=A h^2, the outer upper bound, even with the legitimate-tuple factor2, is at most2*2^{-kappa A h^2}<2^{-10h^2} for h>=1. A is now chosen before h. The tail, covering and posterior estimates may require a cutoff H(m,rho,A); this is allowed and does not force C_* to depend on A. This concretizes the numerical step in body240-248; it does not independently validate the imported list or decoder hypotheses.

## Exact observable-law bridge for the actual star queries

Review chronology: the earlier unfrozen draft a82ccededf18a2b86ff3cc2afe295520895981272456a020d9c17d6c22918f13 considered an arbitrary ambient threshold; the next draft cafc2407244e5c6e9711399b737968797e3948eae86f0d571eabc0d5efbb9e60 gave a raw-leaf coupling and proposed a16S input margin. Both concerns are superseded for the actual observable by the exact identity below, identified by root and independently checked here. Do not install either an enlarged J schedule or an extra coupling loss.

Body57 specifies the actual test: a transverse center K and independent transverse leaves L_i containing K, but the leaf vertex is D_i=H+L_i. The queried label is transported from the clique of D_i and then restricted to K. It is not a function of a particular lift L_i. This is exactly the quotient observable needed here, including repeated leaves and arbitrary dependence among projected spans.

**Finite counting lemma.** Let U=H direct-sum Z, dim(H)=J, dim(Z)=2J, t<=d<=2J. Draw a uniform transverse t-space K, then independent uniform transverse d-spaces L_i containing K. Let D_i=H+L_i. Equivalently, draw a uniform complement A of H, a uniform t-space K in A, and independent uniform d-spaces L_i' in A containing K; output (K,H+L_i'). These two output distributions are equal.

Proof: fix K and write Kbar for its projection into Z. Each possible D corresponds to a d-space Dbar containing Kbar. For every such D, the lifts L containing K are graphs of extensions of the fixed map Kbar->H to Dbar. There are exactly2^(J(d-t)) such extensions, independent of D. Thus original independent leaves push forward to independent uniform D_i. Draw A uniformly among complements containing K, independently of these D_i, and set L_i'=A intersect D_i. Then dim(L_i')=d, K is contained in L_i', and H+L_i'=D_i exactly. For each fixed A,K this is a bijection between possible D and d-spaces of A containing K, preserving the independent uniform law.

Finally, the number of complements containing each transverse K is2^(J(2J-t)), independent of K. Every complement contains the same Gaussian-binomial number [2J choose t]_2 of centers. Consequently the joint uniform incidence law of (K,A) can be sampled in either order. This proves the equivalence. In particular no direct-sum condition on projected leaf increments is needed.

For any fixed tables on the actual center and leaf vertices, acceptance is a function of (K,D_1,...,D_m), so its probability is exactly the average of the complement-restricted acceptance probabilities. If labels are chosen through the source's random clique representatives, couple those choices identically for equal D_i: the clique, label transport and final restriction to K are unchanged. Alternatively apply the identity after the already-budgeted clique-consistency conversion. This bridge creates no additional clique-collision event and no new threshold loss. A joint identity for the unobserved tuple (K,L_1,...,L_m) would generally be false and is not being asserted.

### Explicit ambient conditions and proposed narrow clarification

At n=2J, the matrix bound (2h+2rho*m*h)2^(2h-n)<=1/2 and spectral residual3*2^(2h-n) improve with J. For the latter, retain a constant margin between the exact high-degree spectral sum and its relaxed exponent. Counting uses dim(V)>=J>=2^h. Side-condition transfer loses at most2^(r-2J), and is valid even though dim(H)=J varies: complements have dimension2J and W=W' direct-sum H. These are explicit bounds, rather than an inference that one function dominates every conceivable h-dependent threshold.

For the amplification's randomization estimate, retain the source exponent E=-4h+2+(2h-r)(n-r-2h). The elementary sufficient conditions h>=max(r+4,16), n>=8h+4r+16 imply E>=hn/2. Hence the exponentially small failure dominates the union over triples and exponentially many steps, with logarithmic costs O_m(rn+h). In the higher-arity adaptation, changing a marginal family of measure x changes acceptance by at most m*x, by union bound over leaves; this changes fixed factors, not an ambient-dependent success exponent. This audit checks the growth direction and the query identity, and does not reconstruct every analytic step of the imported amplification theorem.

There is no new16S requirement caused by ambient transport. If spelling out constant-factor slack in the imported amplification is desired, the existing outer test density delta=2^(-2h(1-xi)m) compared with S=2^(-2h(1-1000rho)m) has ratio2^(2hm(xi-1000rho)). For rho=xi/4000 this grows exponentially, so any fixed-factor good-U cutoff is available with its explicit sufficiently-large-h condition. The exact complement identity preserves that cutoff. Do not alter rho merely to absorb constants, since it determines the center dimension.

**Proposed manuscript clarification, not applied:** add the finite counting lemma and its proof after body113 (before the posterior calculations), specialized to t=2(1-rho)h and d=2h. Replace body231's ambient-control cell by: 'Counting uses dim(V)>=J>=2^h. Complement decoding has ambient2J; the exact query-law identity above preserves the local test probability, and the matrix-rank, spectral and uniform-Q errors decrease with J. The sufficiently-large-h conditions depend only on the fixed local parameters.' This replaces overbroad wording with the relevant quantitative facts. Keep J, beta, rho and all theorem statements unchanged. It does not assert that every displayed source proof line is independently certified.

## Fixed-L and learning dependencies close downstream

The intended dependency chain is

    fixed target L -> m,rho,b_m -> K,B,kappa -> A -> admissible h
    -> J,beta,R -> sigma,Gamma,epsilon,tau -> outer YES error
    -> actual instance/list/rounded denominator A_0 -> HN length parameter.

Here 'A before h' means A(m,rho) is fixed before the final admissible h is selected; body328's formula for h(L,m) must be tested against the resulting H(m,rho,A). Every fixed m eventually qualifies as L grows, which supports the diagonal selection in body331 without a common polynomial exponent across L. R is the PCP alphabet, not a learner-description length. Tau=Gamma/(64q sigma) (body280) is selected after R and is positive and fixed for each fixed L; outer epsilon_1 is selected afterward (body250-256). HN's later string-length parameter does not feed back into h,R or tau.

For fixed sufficiently large advice cap a, L=a-2ceil(log2(a+1))-c_U is positive and L<=a. Hence L+2ceil(log2(L+1))+c_U<=a by monotonicity of log and ceiling. Also L/a->1. Thus floor(.49 sigma_L) preserves the nearlinear exponent, and 5 gamma_L remains in(0,1] eventually and tends to0. Rounding the gap down only weakens the NO quantifier over program-description lengths. The common-denominator choice A_0 is polynomial in the actual instance, so a polynomial multiple can accommodate HN integrality and polynomial lower bounds without changing the fixed advice cap. Exact realizability is supplied by the completed list, not by approximate sampling (body299,316-322).

Consequently no new circularity was found in body32-38,301-347 once the modified PCP joint-parameter application is justified. The exact next paper step is to insert and independently check the finite query-law lemma and narrow ambient ledger above; the imported analytic decoder remains an explicit source dependency, not a newly proved Lean theorem. No new J schedule is needed on the evidence inspected. This result neither completes the full Lean formalization nor certifies source hardness, learning hardness, novelty or publication readiness.


## Concrete candidate insertion/replacements (not applied)

Use the editable submission source at the paragraphs corresponding to the cited body lines; generated TeX is shown to remove ambiguity.

After body113, insert:

```latex
\paragraph{Exact complement identity for the star queries.}
Fix $U=H\oplus Z$, with $\dim H=J$ and $\dim Z=2J$, and
$t=2(1-\rho)h$, $d=2h$. The law of
$(K,H+L_1,\ldots,H+L_m)$, where $K$ is uniform transverse to $H$
and the $L_i$ are independent uniform transverse $d$-spaces containing
$K$, equals the law obtained by choosing a uniform complement $A$ of
$H$, a uniform $t$-space $K\subseteq A$, and independent uniform
$d$-spaces $L_i'\subseteq A$ containing $K$.
Indeed, for fixed $K$ each $(J+d)$-space $D\supseteq H+K$ has exactly
$2^{J(d-t)}$ transverse lifts containing $K$. Thus the $D_i=H+L_i$
are independent and uniform. Given a uniform complement $A$ containing
$K$, set $L_i'=A\cap D_i$; this is a bijection of the containing
fibres and $H+L_i'=D_i$. There are $2^{J(2J-t)}$ complements containing
each transverse $K$, and every complement contains the same number
of $t$-spaces, so the order of sampling $A,K$ reverses uniformly.
The test reads the leaf table at $D_i$ and restricts its transported
label to $K$. Therefore its acceptance probability is exactly preserved,
even when the projected leaf increments are dependent. This also holds
for the random clique representatives, coupled at the identical $D_i$.
```

Replace the ambient row of body231 by:

```latex
Ambient dimensions in local decoding &
Counting uses $\dim(V)\ge J\ge 2^h$. Complement decoding has ambient
$n=2J$ and the preceding identity preserves its query law exactly.
The matrix-rank bound $(2h+2\rho mh)2^{2h-n}\le 1/2$, spectral
residual $3\cdot2^{2h-n}$, and uniform-advice correction
$2^{r-2J}$ improve with $J$. The fixed-parameter sufficiently-large-$h$
conditions are retained.\\[5pt]
```

After this row/table, before the decoder-success paragraph, add this bounded explanatory sentence (not a new theorem premise):

```latex
In the many-zoom-in randomization argument, changing a family of leaf
entries of marginal measure $x$ changes the $m$-leaf acceptance
probability by at most $mx$. This union-bound factor is fixed with $m$;
it is retained in the constants below. The amplification failure
exponent $-4h+2+(2h-r)(n-r-2h)$ is at least $hn/2$ when
$h\ge\max(r+4,16)$ and $n\ge8h+4r+16$, dominating its
$O_m(rn+h)$ logarithmic union costs at $n=2J$.
```

This is bookkeeping for the source's declared higher-arity adaptation. It does not substitute for its proof. If reconstructing that adaptation independently, check its randomization event and count the same marginal family before installing the stated fixed constants.

Replace body240-245's unspecified quadratic coefficient/A choice by the following, preserving the ensuing legitimate-conditioning discussion:

```latex
Write the good-question mass as at least $K_U^{-1}2^{-B_Uh}$ and the
maximal-list bound as at most $K_M2^{B_Mh}$, where these fixed-parameter
constants are independent of $J$. The displayed strategy then succeeds,
before the vector-law correction, with probability at least
$K^{-1}2^{-8h^2-Bh}$, where
$K=40K_UK_M(r+1)^3 2^r$ and $B=B_U+B_M+2$.
For $h\ge\max(1,B+\log_2 K)$ this is at least $2^{-9h^2}$.
Taking $J\ge9h^2+r+1$, the error $2^{r-J}$ leaves at least
$2^{-10h^2}$. Choose an integer $A>20/\kappa$ before $h$.
The outer-game upper bound, including the factor two for legitimate
conditioning, is at most $2\cdot2^{-\kappa Ah^2}<2^{-10h^2}$.
All subsequent lower bounds on $h$ may depend on this fixed $A$.
```

The constants name the already imported and displayed estimates, not a desired conclusion supplied as a generic assumption. The learning/advice formulas need no alteration on this audit. These candidate changes are confined to the parameter proof and do not remove other formalization or release obligations.


## Reconciliation with the independent amplification review

Read the complete independent repetition-ambient note at SHA2569f29d6b243dc6f53613d2466e42e4937ad83e656f46f69e20ec1d1d687ff2c89 and checked the preserved source AppendixB in `C:/Users/Dan/AppData/Local/Temp/s3123-mz24.pdf.txt`, especially its process and ClaimsB.1-B.2 (text lines4120-4231). The robust8S proposal is accepted for this derived application. This supersedes the earlier suggestion that only an explanatory m-factor sentence need be installed. The exact complement identity has zero error;8S pays for amplification/averaging slack, not a fictitious coupling loss.

The basic inverse theorem is used at threshold S=2^(-2(1-1000rho)hm). Input density at least8S gives complement-average density at least8S exactly; since acceptance lies in[0,1], complements of density at least4S have mass at least4S. On any such complement, run the source randomization process until density drops below epsilon_A/2. Before termination it is at least2S, so it stays above the basic inverse threshold. The source randomization event is about individual table entries and every(Q,W,g), hence applies unchanged to the m-query test. Its probability and termination use the explicit ambient estimates already recorded.

Let X be the union of all reassigned entries. Original and current predicates agree unless one of their m leaves lies in X, regardless of repeated leaves or correlations. Each leaf marginal is uniform, so absolute acceptance change is at most m*mu(X). At termination, mu(X)>=epsilon_A/(2m). This uses the initial consistency epsilon_A, not the epsilon-prime agreement parameter: the latter appears as a typo in the source ClaimB.2 prose and is not used in this reconstruction.

Each distinct a-space Q covers at most2^(4h^2-a*n) of all d-spaces; count the union of containing-Q families, not the number of algorithmic visits (the same Q may recur with different W). Pigeonholing over at most r+1 advice dimensions gives

    N_a >= epsilon_A * 2^(a*n-4h^2)/(2m(r+1)).

The number of a-spaces is at most4*2^(a*n), so the fraction is at least epsilon_A*2^(-4h^2)/(8m(r+1)). Pigeonhole across complements over at most(r+1)^2 dimension pairs, a conservative extra loss. Since epsilon_A>=4S and the good-complement mass is at least4S, the resulting uniform-complement/conditional-Q success is at least

    2*S^2 * 2^(-4h^2)/(m(r+1)^3).

Here pair selection can depend on A before pigeonholing, but the final selected pair is fixed. For that fixed a, averaging over all uniform complements and uniform a-spaces in them gives exactly the uniform H-disjoint Q marginal. Selecting only successful complements bounds a subset of this marginal; it does not assert a new uniform law after conditioning on successful A.

A sufficient quadratic absorption condition is h^2>=4mh+log2(m(r+1)^3)+1. It gives at least2^(-5h^2) before the marginal correction. Require2^(r+1-2J)<=2^(-5h^2-1), equivalently2J>=5h^2+r+2. The remainder is at least2^(-5h^2-1)>=2^(-6h^2). Source ClaimB.1 bounds the contribution from previously randomized entries by2^(1-2h). For large h this is at most half of the basic inverse agreement epsilon'=2^(-2(1-1000rho^2)h). Thus the original table retains agreement at least epsilon'/2, stronger than the required C=epsilon'/5, and the exact quotient identity lifts this to W'+H. No new ambient-dependent factor is hidden in these counts.

Global availability is explicit: let delta=2^(-2(1-xi)hm). After the already recorded clique loss, keep density at least delta/2. If delta/4>=8S, the fraction of U whose local density is at least8S is at least delta/4. The condition is delta/S>=32, or2hm(xi-1000rho)>=5, met for rho<=xi/4000 and sufficiently large h. The lost factor four changes K_U only, so the proposed2^(-10h^2) success and A>20/kappa order survive unchanged.

### Final required candidate addition

Keep the exact complement insertion, narrowed ambient row and explicit A-before-h replacement above. Replace the proposed standalone amplification bookkeeping sentence with the following derived-lemma statement and the counting proof in this reconciliation (adapt notation to the editable submission source):

```latex
\paragraph{Robust enlarged-ambient local application.}
Put $S=2^{-2(1-1000\rho)hm}$ and
$C=2^{-2(1-1000\rho^2)h}/5$.
For sufficiently large admissible $h$, a transverse star test of density
at least $8S$ in the present $3J$-space has some fixed $a,c$ with
$a+c\le r$ for which at least $2^{-6h^2}$ of the uniform $a$-spaces
$Q$ admit a codimension-$c$ space $W\supseteq Q+H$ and a linear
function respecting $H$ with agreement at least $C$.
The complement identity is exact. Good complements have density at
least $4S$ and mass at least $4S$. In the many-zoom-in procedure,
run until the density is below half its initial value $\epsilon_A$.
The reassigned leaf family then has measure at least
$\epsilon_A/(2m)$. The distinct-$Q$ covering count and dimension-pair
pigeonhole give lucky probability at least
$2S^2 2^{-4h^2}/(m(r+1)^3)$ before the marginal correction.
The bounds $h^2\ge4mh+\log_2(m(r+1)^3)+1$ and
$2J\ge5h^2+r+2$ imply the advertised lucky mass.
The randomization preservation event and its ambient bounds are as
above; its contribution $2^{1-2h}\le\epsilon'/2$, where
$\epsilon'=5C$, leaves agreement stronger than $C$ on the original table.
```

In the global application at body227-240 explicitly use good-U cutoff8S, not the exact-threshold source statement at a modified ambient size. Retain the original imported theorem as its source contract and distinguish this derived application. Insert the delta/4, delta/S>=32 calculation from this reconciliation. Do not assert that8S is required by the exact query-law lemma; do not change J or rho.

**Reconciled verdict:** no mathematical blocker found in this bounded counting/parameter reconstruction. The exact candidate needs normal independent paper review after integration, including the displayed randomization preservation event and all symbols in the final typeset proof. This is not a claim that the entire paper or its Lean formalization is complete. The independent note contains several apparent literal `h?` formula tokens; use the ASCII h^2 formulas verified here and have its author correct that note before copying any text.

For consolidation, route only this paper-specific lemma, proof, parameter ledger and their evidence to `C:/Users/Dan/Desktop/Projects/realizable-cmmsa-hardness/paper/submission-manuscript.md` and its normal generated body/PDF workflow after root review. Preserve the audit as private evidence. Do not copy the formal-pvnp general library, build roots, or unrelated certificates into the paper destination. No such copy or paper edit was performed here.
