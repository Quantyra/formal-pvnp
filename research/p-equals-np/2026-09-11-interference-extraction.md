# Interference-to-witness extraction: a normalization barrier and its escape

2026-09-11, S3069. Informal mathematical investigation under [integrity](../../INTEGRITY-CLAIMS.md). No implementation, experiment, Lean theorem, novelty claim or general SAT result. The main derivation has three independent informal review verdicts; the updated ledger is awaiting its final claims-scope inspection. See the [prior-art consultation](2026-09-11-interference-prior-art.md), [actual rooted-walk construction](2026-09-11-global-fko.md), and [holographic companion](2026-09-11-holographic-extraction.md).

## Result and scope

The actual killed walk proposed in S3067 has a structural problem for witness extraction: on the random FKO-scale input, with high probability its normalization kills almost every trajectory before it could contain a nonempty even clause tuple. This statement follows from a uniform bound on the source's capped root-cell diagonal, together with the previously reviewed minimum-tuple estimate. It holds uniformly over starting states on that fixed rooted instance. It is not a statement that witnesses themselves are rare, nor a lower bound against quantum algorithms or the source's spectral refuter.

There is an immediate legitimate escape: remove killing and normalize by retained channel degree. Original-clause labels and the negative-walk witness identity survive. The remaining substantive question then concerns nontrivial parity-return mass and clause coverage in this different walk. Neither estimate is proved here. Thus the investigation identifies a normalization-induced obstruction and a precise next estimate, rather than ruling out interference.

## Exact operator and probability space

Fix constants A,C>0. Let m=ceil(C n^(7/5)) and ell=ceil(A n^(1/5)). Sample m independent uniform three-variable supports, indexed by distinct clause occurrence IDs. Independently choose each clause's root uniformly among its three variables. Literal signs are independent and uniform when sign averages are discussed. The geometric result below is uniform over all signs.

A rooted clause a has root u_a and residual pair C_a. A state S is an ell-subset of [n]; N=binom(n,ell). Write L_u(S)={a:u_a=u, |C_a intersect S|=1}. The source retains a channel labeled by original IDs {a,b} from S to T=S symmetric-difference C_a symmetric-difference C_b only when the residual pairs are disjoint and L_u(S)=L_u(T)={a,b}. Each root contributes at most one retained channel at a row. Parallel channels keep their labels even when their matrix entries aggregate.

Crucially, the source diagonal is

G(S)=sum_u 1[there exists a disjoint residual pair in L_u(S)].

This is one indicator per root, not the number of pairs and not the retained degree. If d_ret(S) is the number of retained channels, d_ret(S)<=G(S). Put Gamma(S)=G(S)+d_*, where the positive deterministic floor in the source's Equation 9.6 satisfies d_*=Theta(m^2 ell^2/n^3)=Theta_{A,C}(ell). The source's symmetric operator is H=Gamma^(-1/2) C_ref Gamma^(-1/2). These definitions are from [Schmidhuber-Hastings v1, Sections 9.2 and 9.3, Equations 9.5-9.7](https://arxiv.org/pdf/2607.29672v1), not an inferred replacement operator.

The selected S3067 sampler takes each retained labeled channel with probability 1/Gamma(S), and dies with the remaining probability. Its signed transition matrix Gamma^(-1) C_ref is similar to H. Rooting, retention, G and transition magnitudes are all sign-blind. For uniform starts, signed returns estimate normalized trace moments; arbitrary starts need not have that trace interpretation.

## Uniform diagonal bound

**Proposition 1 (random rooting and capped cells).** For the probability space just specified, there is a constant B such that, with probability at least 1-exp(-Omega(ell log n)),

max_S G(S) < r_n = ceil(B ell log n / log log n).

All asymptotic statements are for n sufficiently large depending on A,C. The statement is about the joint random supports and independent uniform roots, not arbitrary prescribed or adversarial rootings.

**Proof.** Fix S and u. The chance that one clause has root u and residual pair meeting S once is

(1/n) s_u(n-1-s_u)/binom(n-1,2) <= 4 ell/n^2,

where s_u=ell-1 when u is in S and s_u=ell otherwise. If G(S)>=r, choose r distinct witnessing roots and two witnessing clause IDs at each root. These 2r IDs must be distinct across roots: an ID has only one root. Discarding the disjoint-residual requirement only enlarges the event. Independence across clause IDs gives

Pr[G(S)>=r] <= binom(n,r) (m)_(2r)/2^r (4 ell/n^2)^(2r)
               <= [8 exp(1) m^2 ell^2/(r n^3)]^r.

Here (m)_(2r) is a falling factorial; if 2r>m the event is impossible. Write mu=m^2 ell^2/n^3=Theta(ell). For r=r_n and sufficiently large n,

log(r/(8 exp(1) mu)) >= (1/2) log log n,
log N <= 2 ell log n.

A union bound over all N states therefore proves the claim for, for example, any fixed B>4 with the asymptotic threshold enlarged as necessary. Independence between rows is neither asserted nor needed. This uses the capped diagonal; replacing it by raw cell-pair counts would require a different proof.

## From killing to useful-output suppression

Use the reviewed [S3064 minimum-even-tuple estimate](2026-09-11-fko-discovery.md), also used in [S3066](2026-09-11-focused-growth.md): for some a=a(C)>0, with probability 1-o(1) there is no nonempty even-incidence subset of at most k_0=floor(a n^(1/5)) distinct clause IDs. Briefly, for even e the pairing first moment is at most [D_C sqrt(e) n^(-1/10)]^e; summing through a sufficiently small multiple of n^(1/5), splitting off small e, gives o(1). Odd e cannot be even-incidence because 3e is odd. This global exceptional probability need not be exponentially small; repeated supports already produce polynomial-probability exceptions in the iid model.

Let E be the intersection of this event and Proposition 1's uniform diagonal event. Thus Pr(E)=1-o(1), over supports and rooting, with the two error terms retained separately if a quantitative statement is needed.

A negative labeled closed walk of L retained channels yields, after cancellation of original clause IDs modulo two, a nonempty even-incidence tuple T with |T|<=2L. Each channel uses two clauses sharing a root, so its boundary change equals the XOR of their complete incidence columns; closure makes their total zero. Its negative sign means the surviving tuple is inconsistent. Explicitly take b_a=1+(number of negative literals modulo two) and y_a=(-1)^(b_a). Every even-incidence tuple of 3-variable clauses has even cardinality, so changing every y_a to its negative does not change the tuple product. Product -1 is exactly odd total negative-literal parity on T. Positive or backtracking returns need not give a nonempty witness.

On E a useful negative return consequently requires L>k_0/2. At every state of this fixed rooted instance, survival of one step has probability

d_ret(S)/(G(S)+d_*) <= r_n/(r_n+d_*) = 1-eta_n,

where eta_n=d_*/(r_n+d_*) >= c log log n/log n. Taking L_0=floor(k_0/2)+1, conditional survival multiplication gives

Pr[one killed trajectory ever outputs a negative closed return | fixed instance in E]
 <= (1-eta_n)^(L_0)
 <= exp[-c' n^(1/5) log log n/log n] = q_0(n).

This bound allows any starting distribution, including one chosen using the actual instance. It also allows a stopping rule that checks several return times: every useful output requires survival of the first L_0 steps. It does not require a conditional random-residual hypothesis.

For R attempts on the same rooted input, even with starts chosen from earlier failed histories, a union bound gives

Pr[at least one output] <= Pr(E^c) + R q_0(n).

The shared input exception is paid once. In particular, log R=o(n^(1/5) log log n/log n) gives failure with high probability. This statement does not cover adaptively rerooting or changing the operator between attempts without new event accounting. It is an upper bound on success, not a matching success asymptotic. It does not contradict the source's refutation algorithm, which evaluates a spectral certificate rather than sampling our killed witness histories.

## Coherence and the exact limit of the conclusion

A reversible sampler retaining orthogonal channel, history and death records has the same measured history probabilities. Merely making this sampler coherent therefore does not remove q_0. A row can be generated by polynomial scans of the explicit rooted clauses and neighbor-cell checks, but a length-L preparation still charges L such operations, initial-state preparation, reversible workspace and history storage of order L log m plus the lifted-state index. Original-ID cancellation and tuple verification are also charged. Arbitrary input-dependent starting states have not been supplied for free by the uniform bound.

For this particular coherent preparation A followed by the standard amplitude-amplification iterate, marked probability q becomes sin^2((2j+1) arcsin sqrt(q)) <= (2j+1)^2 q. Thus q<=q_0 requires exp(Omega(n^(1/5) log log n/log n)) iterations for constant success in this prescribed scheme. This is an application of the [standard amplitude-amplification formula](https://arxiv.org/abs/quant-ph/0005055), not a lower bound against arbitrary quantum procedures. Each iteration charges A, its inverse and the marker/reflections. Approximate amplitude preparation must account for total error; injecting an error larger than the rare marked mass cannot be interpreted as certified improvement. The mathematical comparison above uses the ideal exact sampler.

History-erasing interference changes the output contract. Distinct histories may then combine, but measuring an endpoint no longer supplies their original clause IDs. A different unitary evolution, guide, reconstruction measurement or spectral method is not covered by the killed-history bound. The closest current quantum theorem uses the inference operator and planted-guide recovery, not this refutation operator or clause-tuple output; see the [accessed prior-art comparison](2026-09-11-interference-prior-art.md). No polynomial quantum advantage is established here.

## A concrete escape and the next estimate

For witness search alone, replace the killed transition by uniform choice among the d_ret(S) retained channels at each nonisolated S. Restart at isolated states. Keep every channel's original pair label and sign. This removes the survival penalty immediately and preserves the negative-closed-walk-to-odd-tuple verification argument.

The new signed operator is D_ret^(-1) C_ref, similar on nonisolated states to D_ret^(-1/2) C_ref D_ret^(-1/2). It is not H_ref. Consequently the S3067 moment and source refutation bounds cannot simply be reused. A witness-only branch does not need those bounds, however, so loss of that correspondence is not a reason to reject the change.

Here is the exact missing estimate for this escape. Fix an explicitly preparable starting distribution and length L=O(n^(1/5)). Group the probabilities of labeled closed histories by their surviving original-ID subset T, writing q_T^(L). Prove a sufficiently large nontrivial return mass

Q_L = sum_(T nonempty) q_T^(L),

then prove that the resulting verified tuples have enough distinct weight under clause capacities. Large total return probability is insufficient: backtracking can contribute only to T empty, repeated outputs may dominate, and useful tuples may share the same clauses. No inverse-polynomial Q_L or useful coverage guarantee has been derived for this non-killed rooted walk.

For independent random clause signs, conditional on unsigned supports and rooting, and with a sign-independent starting distribution and transition selection, the routine parity-character diagnostic is

E_sign[q_negative] = Q_L/2,
Var_sign[q_negative] = (1/4) sum_(T nonempty) (q_T^(L))^2.

Distinct nonzero GF(2) subset characters are pairwise independent, even when their supports overlap. This is the same elementary logic as S3065, not a new interference mechanism. It indicates exactly why both nontrivial mass and its concentration matter, while saying nothing by itself about clause loads. If transition selection or guide preparation reads signs, this conditional diagnostic needs a new justification.

## Disposition

The new local derivation is the uniform capped-diagonal estimate and its consequence for the actual killed sampler. Its novelty is not established; the proof uses standard factorial moments, a union bound and an existing minimum-tuple estimate. It supplies a useful normalization diagnosis, not progress to a polynomial FKO finder. The non-killed, labeled return process remains an explicit research possibility with an unproved mass-and-coverage obligation. The [holographic companion](2026-09-11-holographic-extraction.md) investigates a separate representation of that coefficient query; its conclusions should not be combined into a universal barrier.

Even an improved random-FKO certificate finder would be an average-case refutation advance, not P=NP or P!=NP. A worst-case algorithm or a suitable worst-case lower-bound bridge would still be missing. No new theorem is added to public or Lean claims by this note. The [persistent meta-graph](2026-09-11-research-meta-graph.md) records the reviewed bound separately from the non-killed possibility; its final independent claims-scope inspection is GO.

## Independent review

These are separate agent reviews of informal mathematics, not human review or Lean verification. No tests or experiments were run for this derivation.

| Lens | Verdict and scope |
|---|---|
| [Proof-adversarial](2026-09-11-interference-proof-review.md) | GO: exact capped-diagonal and killed-sampler result, with supporting representation checks. |
| [Complexity](2026-09-11-interference-complexity-review.md) | GO: probability, resource and restricted amplification accounting; requested wording correction applied. |
| [Non-claims](2026-09-11-interference-nonclaims-review.md) | GO: corrected main, companions and final updated meta-graph retain the restricted claims boundary. |
