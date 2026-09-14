# Next theorem handoff: occurrence-weighted list decoding

2026-09-13. S3137/S3126, formal-pvnp. This chooses one finite theorem inside the missing star-to-formula bridge of gap map a6a33ec. No new Lean source, compiler, manuscript edit or literature research. The theorem below derives the list-decoding bound rather than assuming a target CMMSA NO promise. It does not claim the whole HN compiler has thereby been implemented.

## Concrete objects and exact target

Use a finite nonempty vertex set V, finite nonempty alphabet Sigma(v) at each v, finite nonempty edge-occurrence set E, and rational probabilities p(e)>=0 with sum p=1. Fix natural m>=1. An edge has center y(e), ordered leaf slots x(e,i), i:Fin m, and maps pi(e,i):Sigma(x(e,i))->Sigma(y(e)). Require y(e) different from every leaf; the same leaf may occupy several slots. The actual star construction must establish this role separation, not hide it in an arbitrary predicate contract. Define acceptance of a GLOBAL labeling ell by all pi(e,i)(ell(x(e,i)))=ell(y(e)). Define Val as the maximum p-weighted acceptance over the finite nonempty global-labeling set.

Let mult(e,v) count center plus all m ordered leaf occurrences. Define

    lambda(v) = sum_e p(e)*mult(e,v)/(m+1),
    Lambda = sum_v lambda(v)*|Sigma(v)|,
    w(v,a) = lambda(v)/Lambda,   s = 1/Lambda.

First restrict the edge-occurrence set to Eplus={e | p(e)>0}, retaining each positive occurrence and its original probability: do not renormalize, merge or deduplicate occurrences. Normalization makes Eplus nonempty, and removing zero terms preserves every weighted acceptance sum. Only then restrict vertices to endpoints of Eplus, equivalently the positive-lambda support. Every retained edge endpoint now belongs to this vertex set, so the restricted game is well typed. Every original labeling restricts to it, and every restricted labeling extends to discarded vertices using their nonempty alphabets. Both maps preserve weighted acceptance; hence the game value is unchanged. The same removal preserves weighted witness-event probabilities and the occurrence-weight identities. Then lambda(v)>0, sum lambda=1, Lambda>=1, every w(v,a)>0, sum_(v,a) w(v,a)=1, and 0<s<=1. The vertex support is nonempty because m+1>0 and p is normalized. Finite rational data make these rational weights; this lemma alone does not establish inverse-polynomial lower bounds on p or w for an encoded family.

Take an actual Boolean selection Z on variable pairs (v,a), and define A_v={a | Z(v,a)=true}. Let rho>0 be rational (or a positive real after casts), and assume the EXACT budget weight(w,Z)<=rho*s. Equivalently sum_v lambda(v)|A_v|<=rho. rho*s need not be <=1; no such hypothesis is used.

For each distinct leaf v of e and b in Sigma(y(e)), define

    P(e,v,b)={a in Sigma(v) | for EVERY slot i with x(e,i)=v,
                                pi(e,i)(a)=b}.

Define T_e(Z) by the explicit finite expression

    exists b in A_y, for every distinct leaf v,
                     exists a in A_v intersect P(e,v,b).

This is a constructed predicate from the projections, not a freely supplied predicate with assumed correctness. Let alpha=sum_e p(e)*1[T_e(Z)]. The one target theorem is

    Val >= (alpha-1/8)/(8*rho)^(m+1).                 (LIST-DECODING)

For alpha<=1/8 the lower bound is nonpositive and follows from Val>=0. For alpha>1/8 the following concrete proof applies. All denominators are strictly positive. Empty selected sets are allowed; they make any incident witness event false, not undefined.

## Noncircular finite proof route

Write H(e)=|A_y|+sum_i |A_(x_i)|, retaining slot multiplicity. Swapping the finite sums gives

    E_p H = (m+1) sum_v lambda(v)|A_v| <= (m+1)rho.

Consequently p{H>8(m+1)rho}<=1/8 by the direct finite Markov inequality. One can prove it by summing H over that event; no probabilistic oracle is needed. The intersection G of T_e(Z) and H<=8(m+1)rho has probability at least alpha-1/8.

Construct one GLOBAL random labeling: independently for each distinct vertex v choose uniformly from A_v if nonempty; otherwise use one fixed alphabet element. This is a finite product distribution, independent of the tested edge. On e in G, its witness supplies one center label and one label for each DISTINCT leaf, satisfying every repeated occurrence. The probability of choosing that entire coherent tuple is

    product_(v in support(e)) 1/|A_v|.

Every involved cardinality is at least one. Repeating factors of at least one can only enlarge their product, so the reciprocal above is at least

    1/(|A_y| * product_i |A_(x_i)|).

Finite arithmetic-geometric mean for the m+1 positive slot cardinalities gives their product <=(H(e)/(m+1))^(m+1)<=(8rho)^(m+1). Thus each good edge has acceptance probability at least (8rho)^(-(m+1)). Summing over edges and then exchanging the two finite expectations yields expected game acceptance at least (alpha-1/8)/(8rho)^(m+1). Some deterministic global labeling attains at least this expectation, proving LIST-DECODING. This does not sample independent answers for repeated slots and does not assume Val^u or any repetition theorem.

As the immediate numerical application, if 0<zeta<=1 and Val<=zeta, every budget ratio satisfying

    0<rho <= (1/8)*(5/8)^(1/(m+1))*zeta^(-1/(m+1))

has alpha<=3/4. Prove by contradiction with alpha>3/4, obtaining Val> (5/8)/(8rho)^(m+1)>=zeta. Equality alpha=3/4 is permitted; no unjustified strict contradiction is taken there. For implementation one may instead assume the equivalent integer-power inequality (8rho)^(m+1)*zeta<=5/8, avoiding fractional powers in the finite theorem. The zeta=0 case can be treated directly from LIST-DECODING if needed, but is not needed to divide by zeta in this application.

## Required actual compiler join, explicitly not assumed away

The manuscript's formula is the OR over b of z_(y,b) AND the AND over distinct leaves v of the OR over P(e,v,b) labels. By induction on these finite AND/OR lists its evaluation is EXACTLY T_e(Z); this is the named next join obligation, starFormula_eval_iff_listWitness. The pointwise coherent-label property follows directly from the definition of P and center/leaf separation. It must be proved for the constructed formula, not added as a field assuming the target hno.

There is a concrete syntax obstacle: current Formula has only var/and/or, no false/true constants. For a general star edge, some P(e,v,b) can be empty, and all b branches may be impossible. An identically false function has no representation in that positive constant-free syntax (all variables true satisfies every such Formula). Therefore do NOT assert a total arbitrary-star compiler into Formula without addressing this case.

For the actual manuscript game, a possible sufficient route is to prove that repeated occurrences of the same leaf use the same restriction map and that each leaf-to-center map is surjective via extension of the center functional respecting H_U and transversality. Then every P(e,v,b) is nonempty. Those properties require the actual star/transport definitions and their side-condition extension lemma; they are not proved by the generic list-decoding statement. If this route fails, a constant-capable intermediate syntax with a rigorously promise-preserving elimination must be supplied. Dropping impossible edge occurrences would alter p and is not licensed. The handoff should first implement LIST-DECODING on the explicit predicate above, retaining this exact unresolved syntax/application join.

The leaf bound also needs a separate proof on the actual formula: for each distinct leaf, the P(e,v,b) sets across b are disjoint (one fixed occurrence map forces b uniquely), hence total leaf-label appearances <=|Sigma(v)|. Adding center variables gives <=(m+1)R when each alphabet size<=R. This cannot be inferred merely from m+1 slots without counting repeated center branches.

## Reuse and completion boundary

Reuse current Formula.eval/leaves and its binary constructors for the eventual syntax proof; the finite weight definition in ExceptionRepair; finite sum/count/product and normalized probability machinery already used by FiniteSampling/FiniteConcentration. The only scalar ingredient here is finite AM-GM, or a direct equivalent product-versus-sum lemma; no HN soundness import is needed once that elementary inequality is established. SamplingFormulaPromises.computed_no_probability can later consume the derived distributional bound after the actual compiler, q-fold product and parameter conversion, not directly from an abstract list selection.

Expected implementation unit: one finite game/list-selection definition module with occurrence-weight identities and LIST-DECODING, plus Checks including repeated leaf with conflicting projection constraints (empty P), zero selected lists, zero-probability edges and a coherent repeated-leaf witness. No source edits are authorized by this planning handoff. Exact source-family bit-size/runtime, star-game construction, smooth/advice soundness, compiler syntax/nonempty-fibre proof and full hardness remain open. This is one concrete next theorem, not another certificate assuming their conclusions.
