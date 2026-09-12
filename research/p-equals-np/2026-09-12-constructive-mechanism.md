# Constructive mechanism test: external fields and exact de-biasing

2026-09-12; S3083 under E004/S008 and [integrity](../../INTEGRITY-CLAIMS.md). Status: author derivation complete; independent proof, complexity/source and nonclaims reviews GO for the bounded assessment. Publication HOLD. **Selection NONE for the proposed universal center stencil.** No SAT algorithm, novel application, new complexity lower bound, or publishable result is established.

## Candidate selected before calculation

A current result suggests a concrete constructive action: add a strong external field to make a soft constraint partition function accessible to zero-free interpolation; average over field orientations to remove the bias; use the resulting low-temperature value to decide satisfiability. The prospective difference would be a polynomial-cost, uniformly constructible de-biasing operation retaining the required decision accuracy. Merely evaluating the field-biased partition is already known machinery. The source does not give the de-biasing guarantee.

The first falsifiable obligation is whether a polynomial-size **formula-independent linear stencil of centers** can remove the bias exactly, or within constant relative error with nonnegative normalized weights. This is a specified mechanism, not the assertion that some arbitrary SAT algorithm must exist. We test it analytically below and stop when it fails. No experiment or solver benchmark is called for.

## Closest current result and source boundary

[Barvinok, arXiv:2608.03687v2](https://arxiv.org/pdf/2608.03687v2), posted August 16, 2026, Theorems 1.2-1.3 and Section 1.5, is the primary comparison. The first HTML inspected was v1; all parameter use below is pinned to the newer v2 PDF. For local potentials with Lipschitz constants L_i, Theorem 1.3 uses a parameter L with coordinate influence sums at most L/5 and product bias p=exp(-6L)/r. Approximation requires additional fixed slack. Section 1.5 charges m^(k+1) local moments, each evaluable in 2^(rk) work, where k=O_delta(log log M + log(1/epsilon)) and M=3 exp((1+2delta)r sum_i L_i). This is a quasipolynomial guarantee for fixed r, not a free polynomial-time evaluation oracle. Theorem 1.2's condition rp>=12 prevents using its logarithmic-field interpretation indefinitely while reducing p; fixed width r=3 cannot meet that condition for p<=1/2. Enlarging the declared r does not remove the absolute influence ceiling 1/(10 sqrt(12)) in that theorem.

The Boolean-noise diagonalization used below is standard; see [O'Donnell, Analysis of Boolean Functions](https://arxiv.org/abs/2105.10386). We claim no novelty for it, for averaging product biases, or for the ensuing elementary stencil obstruction. The bounded current search found no supported theorem supplying the proposed de-biasing operation. Absence of a hit is not evidence of priority. The source result is a preprint theorem used as an imported comparison, not independently reproved here.

## Exact decision target and charged field model

Let F be a CNF on n>=1 variables, with nonempty clauses of width at most 3, m clauses and maximum variable occurrence Delta>=1. Empty formulas, empty clauses and unused-variable-only inputs can be handled directly; they are not substantive cases. Let v_F(x) be the number of violated clauses and set

    beta=(n+3) ln 2,    t=exp(-beta)=2^(-n-3),
    f_F(x)=exp(-beta v_F(x)),
    A_F=2^(-n) sum_x f_F(x).

If F is satisfiable then A_F>=2^(-n). If it is unsatisfiable then A_F<=t=2^(-n)/8. Consequently a deterministic constant-relative-error approximation, for example error at most 1/4, to A_F in polynomial input time would decide SAT and hence give P=NP. Obtaining that algorithm is not claimed. The normalized values can be exponentially small; their exponent and required output bit lengths must be represented, rather than rounded to zero.

For a chosen center c in {0,1}^n, define the product measure with each bit flipped from c independently with probability p:

    K_p(c,x)=p^d(c,x) q^(n-d(c,x)),    q=1-p,
    Q_c(F)=sum_x K_p(c,x) f_F(x).

Each clause potential -beta times its violation indicator has Lipschitz constant beta; a variable has summed influence at most beta Delta. Fixing slack delta>0, choose

    L=5(1+2delta) beta Delta,    p=exp(-6L)/3.

This meets the displayed Theorem 1.3 condition and its approximation slack for r=3. In particular p<=exp(-30 beta Delta)/3. Reorienting bits by c preserves the support and Lipschitz conditions. Parameters depend on n and a declared occurrence bound, not on an unknown witness. Constants/transcendentals require certified numerical representation; no exact real-RAM operation is granted.

Averaging over all centers removes the field exactly:

    2^(-n) sum_c Q_c(F) = A_F,

since sum_c K_p(c,x)=1. This identity alone is not an algorithm: it names 2^n evaluations. A symbolic representation of the uniform center set does not supply its sum of Q-values.

## The missing step tested: a small center stencil

Choose weights w_c independent of F, allowing dependence on n, beta and p. Only centers with nonzero weights are queried. The proposed reconstruction is

    R_w(F)=sum_c w_c Q_c(F).

First require exact equality R_w(F)=A_F for every input in the class. For approximate reconstruction consider nonnegative weights with sum_c w_c=1 and relative error at most 1/2 for every input. Even these relaxed guarantees fail for a stencil omitting one center.

### Finite-temperature diagnostic using easy formulas

For each a in {0,1}^n let F_a contain n unit clauses, one fixing each variable to a_i. These are at-most-3-CNF formulas with Delta=1; a common larger declared occurrence bound is also permitted. They are easy SAT instances, **not a hard family**. Their role is to test the universal reconstruction identity without taking a zero-temperature limit:

    v_Fa(x)=d(a,x),    f_Fa(x)=t^d(a,x).

By multiplying the n independent one-bit sums, with d=d(c,a),

    Q_c(F_a)=(q+pt)^(n-d) (p+qt)^d
            =(1+t)^n K_s(c,a),
    s=(p+qt)/(1+t),    1-s=(q+pt)/(1+t),
    A_Fa=((1+t)/2)^n.

Here 0<s<1/2 because 1-2s=(1-2p)(1-t)/(1+t)>0. Thus exact reconstruction for this finite family requires

    sum_c w_c K_s(c,a)=2^(-n) for every a.

The matrix K_s is the n-fold tensor product of [[1-s,s],[s,1-s]]. Its one-bit eigenvalues are 1 and 1-2s, both nonzero; equivalently its Boolean Fourier eigenvalues are (1-2s)^|S|. It is therefore invertible. Its rows and columns sum to 1, so the unique solution is w_c=2^(-n) for every c. **Even signed or complex exact weights must use all 2^n centers.** This is linear-algebra uniqueness for the stipulated universal stencil, not a lower bound on SAT algorithms.

For the nonnegative approximate version, suppose some a is omitted. If c!=a, then K_s(c,a)<=s, since at least one factor is s and every other factor is at most 1. Hence

    sum_c w_c K_s(c,a)<=s.

But beta=(n+3)ln2 and Delta>=1 give p<=t^30/3, so

    s <= p+t < 2t = 2^(-n-2) < 2^(-n-1).

Relative error at most 1/2 would require the left side to be at least 2^(-n-1). Contradiction. Therefore this universal positive constant-relative-error stencil also has full support. The proof handles finite beta and the precise soft values requested by the proposed construction.

For signed approximate weights, the same omitted-a inequality gives

    |sum_c w_c K_s(c,a)|<=s sum_c |w_c|.

A relative error at most 1/2 forces sum_c |w_c|>=2^(-n-1)/s. This is only a conditioning statement. It is not an exponential bit-complexity lower bound; in the present finite-temperature singleton test s is of order t, so the bound is merely constant. In the hard-indicator/general-function model K_p would instead give 2^(-n-1)/p, potentially enormous, but that stronger model is unnecessary and supplies no SAT lower bound. We do not import its conditioning as a result for the finite-temperature class.

### Why the known accessible value remains strongly local

The SAT violation count is Delta-Lipschitz: changing d bits changes at most Delta d clause evaluations. Therefore, for any c,

    (q+p exp(-beta Delta))^n
      <= Q_c(F)/exp(-beta v_F(c))
      <= (q+p exp(beta Delta))^n.

Proof: bound exp(-beta(v_F(x)-v_F(c))) between exp(-beta Delta d(c,x)) and exp(beta Delta d(c,x)), then take its product-measure expectation. Under the selected field, p exp(beta Delta)<=exp(-29 beta Delta)/3. The upper ratio is at most exp(n p(exp(beta Delta)-1)); the lower ratio is at least (1-p)^n. Thus these available expectations closely track the already computable value at their center. This does not prove that their tiny corrections are useless to every algorithm; it identifies why simply adding a field is not an unbiased global search operation.

## Full cost and escape checks

- Explicit universal exact or positive relative-error reconstruction queries all 2^n centers by the diagnostic. This alone fails the proposed polynomial query contract.
- Each source-backed evaluation must also pay for its local moments. With beta=Theta(n), fixed width/slack, polynomial input size and constant requested relative error, the displayed source moment algorithm gives quasipolynomial rather than polynomial work in general. Approximating each positive Q_c to fixed relative accuracy propagates that accuracy to their full positive average, but does not reduce the center count.
- A varying field p approaching 1/2 would remove de-biasing, but the cited small-field parameter guarantee no longer certifies the needed beta Delta. This is a limitation of the cited guarantee, not evidence of actual zeros in every instance.
- Formula-dependent or nonlinear reconstruction, adaptive centers, a structural aggregate-sum identity, analytic paths outside the certified region and other algorithms are not excluded. On F_a, a is directly readable and such an algorithm can immediately recognize satisfiability. That explicit escape is why this cannot be called a SAT hardness result.
- Randomly selecting a polynomial number of centers does not supply the tested deterministic uniform stencil guarantee. No broader randomized lower bound is asserted. Quantum superposition of centers likewise does not provide free extraction of an exponentially small mean; no quantum model or speedup is derived here.
- No code, simulation, Lean proof, hardware work or paid service was used. This is a bounded analytical falsification and source comparison, subject to independent mathematical and scope review.

## Decision, novelty and publication posture

Park the specific proposed field-and-universal-stencil mechanism. The desired SAT-sensitive unbiased evaluation was the prospective new capability; it has not been supplied. The current source is genuinely recent, but using its theorem would not itself constitute novelty. The kernel calculation is a standard consequence, retained only because it decisively tests this concrete attempted use before a derivation or experiment campaign.

No new application, independently established novel theorem, P-versus-NP stepping stone or publication-ready result emerged. Publication is not selected. An adaptive de-biasing algorithm is not automatically the next task: reopening requires a concrete action exploiting formula structure, a charged aggregate/precision guarantee, and a source comparison showing a missing capability. Merely renaming that unfilled step is insufficient. The overall overnight objective remains unresolved.

## Review record

| Lens | Actual review | Decision and scope |
|---|---|---|
| Proof-adversarial | [Proof review](2026-09-12-constructive-mechanism-proof-review.md) | GO for identities and universal-stencil rejection; main and graph inspected. |
| Complexity/source | [Complexity review](2026-09-12-constructive-mechanism-complexity-review.md) | GO for main's scoped source contract, costs and diagnostic; publication HOLD. |
| Nonclaims/publication | [Nonclaims review](2026-09-12-constructive-mechanism-nonclaims-review.md) | GO for main and graph claim boundaries; publication HOLD. |

These are independent agent mathematical/document reviews, not formal verification or novelty certification. The graph adds no verified algorithmic edge. No research contribution was selected for publication.
