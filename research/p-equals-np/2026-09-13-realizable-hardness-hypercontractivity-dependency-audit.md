# Global hypercontractivity dependency audit

2026-09-13. S3134/S3137. Bounded source audit by occurrence_gadget_author. No compiler, new Lean module, paper edit, Git or public action. Prior lower-component authorship does not establish these analytic inputs. Current paper source was read at e6ed023ea58dbdf87eeb609acae1ec83eb0dee06; submission-manuscript.md SHA256b34e466e110ffe2d6b46cc802130cef7e07c0f588df1f0b2c4c444ce3696cc48. Inverse7cf271d, matrix lift8e69918 and spectral8dbc0ce are separate bounded reviewed arguments.

**Result:** the weaker MZv1 Theorem4.6 bound actually used by the repaired inverse follows with its stated constant from the precise EKL inputs below. The stronger exponent printed in the preserved MZ24 A.7 does not follow from its displayed algebra. No ambient-n dependence appears in the needed inputs. The real remaining foundation is the finite-matrix generalized-derivative hypercontractive inequality and its influence/globalness bridges; a citation or axiom for4.6 would not finish the Lean proof.

## Source identities and version scope

MZ arXiv:2510.23991v1 text SHA256e8cb21fb8279f7881a5cf5c53b87b09b215f0bb3c8466b8fbdfcd4517ee5fbce at C:/Users/Dan/AppData/Local/Temp/s3123-mz2510.23991.pdf.txt. Theorem4.6 p.16 (also visually inspected during the spectral audit) states the power-of-two moment bound with exponent(p-2)/p. Definitions2.1-2.4 specify actual uniform matrix restrictions.

MZ24 arXiv:2404.07441v1 preserved text s3123-mz24.pdf.txt SHA2567457efd82898b827e2bb88a8d1a10d5a37b7888ebf31106813f44a8a805647c4. Appendix A.1, pp.58-60: DefinitionsA.1-A.4, LemmaA.5, TheoremsA.6-A.7. Its header is v1; this note does not call it v4. A.5 explicitly says it is a derived combination of two EKL results, not a theorem literally appearing in EKL.

The needed EKL primary text was absent locally, so obtained the explicit version [Evra, Kindler and Lifshitz, arXiv:2404.00641v2](https://arxiv.org/html/2404.00641v2), dated19Dec2024. Preserved PDF C:/Users/Dan/AppData/Local/Temp/s3134-ekl2404.00641v2.pdf SHA256fa4c9ebaf56104957b2cbb5dc3cb06f45e86152104e6311ed00a9491ddeb58c4; layout text SHA2567fb002153b3ac62a3238c61574b65b3a2a28de3ce253fe6272d697a63247ab1a. Definitions1.4/1.5 and2.1/2.4; Theorem1.13, Proposition3.6, Theorem5.5 are the exact relevant statements. This is an explicit version replacement/check, not an assertion that a2024 v1 paper originally cited the later v2 text.

The ancestry cited as EKL22 is Ellis, Kindler and Lifshitz, [arXiv:2209.04243v1](https://arxiv.org/pdf/2209.04243v1), a different first author. Preserved s3134-ellis2209.04243v1.pdf SHA2564455f4a757b2abc1b7a3dd41f3495b68bf2e2b9aa4d05a5b0953fe4e751a991f; text SHA2569259246e882f05e02fb8585400fed15b6a1d9e68106cbcd813c8851ecfdc468a. Theorem58, Proposition63 and Corollary65 are the finite bilinear results behind the cited EKL24 preliminary statements. No group-representation/SL mixing theorem is needed here.

## Minimal sufficient theorem for this paper

Work only over F_2 and the uniform probability space Mat(n,D), with D=2h, n>=D, Boolean F, and actual affine restrictions MU=V, XM=Y as in the matrix-lift audit. Let0<=i<=r<D, let0<delta<=1, and assume every nonempty nominal-budget-r restriction has conditional E[F]<=delta. Let p>=4 be a power of two. The required conclusion is

    ||F^{=i}||_p <= 2^(500*i^2*p) * delta^(1-2/p),       (HC)

where F^{=i} is the explicit rank-i Fourier projection and all norms are normalized uniform probability norms. Basis invariance is not required by(HC); it is used later by the spectral step. Delta=0 can be handled separately: global mean is zero, hence Boolean F=0. i=0 is elementary since F^{=0}=E[F]<=delta<=delta^(1-2/p).

For the actual non-pseudorandomness contradiction, delta=2e from the matrix lift, with large-h e<=1/2. The inverse uses p=P, the least power of two >=mT, then probability-norm monotonicity to bound the mT norm. That rounding has already been budgeted; an arbitrary integer mT must not be substituted directly into a dyadic theorem. No inverse theorem assumption or oracle is part of(HC).

## Exact restriction and normalization bridge

EKL works on L(V,W), with V=F_2^D, W=F_2^n. A restriction is an affine coset A+L(V/V0,W0). Given a consistent MU=Vtarget, XM=Y and any solution A, its difference space consists exactly of maps vanishing on V0=span(columns U) with image in W0=ker X. Translation by A is a bijection, so the normalized conditional matrix measure equals EKL's normalized restriction measure. The effective budget dim V0+codim W0 is at most the nominal matrix budget.

Conversely every EKL restriction is expressed by those equations using bases of V0 and the annihilator of W0. To apply rank-i results with i<=r, append redundant0=0 equations to reach nominal r; the original distribution is unchanged. This uses MZ's nominal-equation definition. Under an independent-equations convention the same implication follows by uniform refinement, but the two conventions should not be silently conflated.

For Boolean F, a conditional L2 norm squared equals density, while its conditional L^{p'} norm is density^(1/p'), where p'=p/(p-1). Thus the hypotheses imply (i,delta^((p-1)/p),L^{p'}) globalness. Full-rank conditioning is not added to these analytic norms: the lifted indicator already vanishes on rank-deficient matrices.

Theorems1.13/5.5 and Proposition3.6 are stated for finite V,W and prime-power q, not only square invertible matrices, large q, or bounded ambient aspect ratios. The bilinear constants below do not contain n,D. The unrelated SL-group results have additional assumptions and are not imported. Rank degrees and restriction budgets must be meaningful for the finite spaces; the paper has r<D<=n. Intermediate full proof formalization must handle smaller restricted spaces and zero projections explicitly rather than quantify vacuously over nonexistent restrictions.

## Deriving exactly the weaker bound, with constants

Take i>=1 and let f=F^{=i}. Theorem5.5 gives f generalized influences bounded by

    eta=2^(500*i^2*p) * delta^(2(p-1)/p).

Proposition3.6, at restriction order i, turns this into globalness with parameter

    eta1=2^((10+500p)*i^2) * delta^(2-2/p).

Theorem1.13 then gives

    ||f||_p^p <= 2^(200*i^2*p^2) * ||f||_2^2 * eta1^(p/2-1).

Parseval and Booleanity give ||f||_2^2<=E[F]<=delta. Substitution yields the exact exponent calculation

    ||f||_p^p <= 2^((450p^2-495p-10)*i^2)
                         * delta^(p-2+2/p).

For p>=4 and0<delta<=1, this is at most

    2^(500*i^2*p^2) * delta^(p-2).

Taking the p-th root proves(HC), with its actual500 constant and without an ambient-dependent loss. In particular no stronger indicator level estimate is needed.

The preserved arXiv MZ24v1 A.7 writes a delta^(p-1) moment conclusion after the same inputs. But

    1+(2-2/p)(p/2-1)=p-2+2/p,

which is smaller than p-1 for p>2. One cannot upgrade the exponent when delta<1. This arithmetic discrepancy does not invalidate the weaker MZv1 result used here: p-2+2/p>=p-2 is precisely the direction needed. Do not formalize the stronger source display as if the shown proof established it.

### Corrected revision qualification

The preserved ECCC Revision1 of Report27(2024), `C:/Users/Dan/AppData/Local/Temp/s3124-mz24-r1.txt`, SHA256d7dff096e13c2b3c46a0a708d4fb4b6c1481ce0bfe0c323733241094f3fc33d7 (PDF SHA25613b8eb55f86cfe28ac8b283fe83612889b335e14b7a87d64d479451693c7dff4), already states TheoremA.7 with the corrected weaker exponent(p-2)/p, matching MZv1 4.6. Thus the stronger-exponent discrepancy above is historical to the preserved arXiv MZ24v1 text, not a new unresolved error in the corrected revision or the current MZv1 import. The explicit algebra explains why the weaker statement suffices; it is not a claim to have discovered a new correction. The separate EKLv2 internal-induction bookkeeping and foundational Lean obligations below remain explicitly distinguished.

## What must actually be proved, rather than assumed

The minimal route can specialize to binary matrices and real-valued functions, retaining the same full finite theorem. It does not need the entire general finite-field/SL representation library.

1. Define the normalized character transform and rank projections; prove Parseval, projection orthogonality, rank degree of products, norm monotonicity and Holder. Most of these are finite sums and standard analysis, but their concrete normalizations must agree.
2. Define the actual generalized Laplacian: on the dual maps X:W->V keep Fourier terms with im X containing V0 and X^(-1)(V0) contained in W0. Its derivative is that Laplacian restricted to the affine coset; generalized influence is the derivative's normalized L2 norm squared. Prove the order-lowering and composition identities (EKL24 Lemma2.2/Proposition2.3, citing EKL22). These are not the same as merely restricting F.
3. Prove the dimension-independent fourth-moment theorem for degree-at-most-i functions with generalized influences<=eta:

       ||f||_4^4 <= 2^(103*i^2)*eta*||f||_2^2.

   This is EKL22 Corollary65 / EKL24 Theorem2.6. Its substantive foundation is EKL22 Theorem58, which bounds the fourth moment by a sum over squared-L2 fourth powers of actual derivatives, followed by a finite rank-incidence count. Theorem58 itself uses a nontrivial degree-reduction induction; it has not been reconstructed or proved in Lean in this work.
4. Prove influence-to-restriction globalness (EKL24 Proposition3.6), the dyadic Bonami inequality1.13, and the L^{p'}-global-to-level-influence bridge5.5. Their definitions must cover all actual restrictions, not an assumed influence certificate. Then the short algebra above proves(HC). The precise bottleneck is the generalized-derivative inequalities, not fresh tests of already-known inverse exponents.

## Internal proof arithmetic to preserve as explicit review debt

Tracing the primary proofs, rather than only theorem statements, exposes two further bookkeeping shortcuts in EKL24v2. In the1.13 induction, applying the induction hypothesis to f^2 of degree2i at moment p/2 contributes200*(2i)^2*(p/2)^2=200*i^2*p^2, not the printed50*i^2*p^2. Its square-globalness proof4.1 also bounds a higher-order restricted L2 norm by eta although the preceding enlargement only supplies2^(41*i^2)*eta; and Theorem2.6 is an influence hypothesis, so a globalness-to-influence conversion cannot be omitted. These are not counterexamples to1.13; they mean its printed induction should not be copied mechanically into Lean.

A conservative candidate bookkeeping repair retains the advertised200 constant: degree-i globalness plus the cited projection/influence conversion gives a fourth-moment coefficient114*i^2. Enlarging to3i-globalness and retaining both restricted factors gives square-globalness with coefficient196*i^2 instead of144*i^2. Dyadic iteration then has exponent recurrence A_4=114 and A_p=4*A_(p/2)+49p-82, which stays below200p^2 (for example by the stronger invariant A_p<=200p^2-100p). This explicitly accounts for the doubled degree. These calculations support feasibility of the same bound, but their restriction-space boundary cases and foundational derivative lemmas still require proof/review; this audit does not promote the candidate into a certified substitute theorem. No alteration of the paper's use of(HC) is authorized here.

## Strongest unresolved obligation and outcome

The matrix-lift and spectral bridges are now finite reviewed derivations. The remaining analytic import is specifically the binary finite-matrix derivative hypercontractivity theorem and its globalness/influence conversion chain. A complete kernel proof must supply those inequalities for the actual Fourier/affine-restriction definitions, including dimension boundaries and dyadic induction bookkeeping, rather than add Theorem4.6 as an axiom or caller field. This is a substantive mathematical proof obligation, not generic missing library infrastructure.

Conditional on the named precise primary theorems, the repaired manuscript's weaker exponent and500 constant are adequate, uniform in n, and keep S,epsilon-prime and the fixed-parameter order unchanged. The stronger MZ24 exponent is unnecessary. Full verification of the EKL ancestry, Lean acceptance, upstream PCP hardness, complete paper certification and publication remain open. The native diagnostic remains disabled; no run or experiment was performed for this audit.
