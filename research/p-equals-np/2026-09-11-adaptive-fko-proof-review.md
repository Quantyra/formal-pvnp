# S3065 proof-adversarial review

2026-09-11. Independent top-level proof review of [adaptive derivation](2026-09-11-adaptive-fko.md) and [source contract](2026-09-11-adaptive-fko-sources.md), under [integrity](../../INTEGRITY-CLAIMS.md). **GO for the conditional sign lemma, deterministic capacity accounting, and precisely limited Moore-theorem substitution.** The required adaptive discovery/progress theorem remains unproved. This review is not an endorsement of a successful finder, novelty, publication readiness, or a general complexity result. No experiment, implementation, or Lean proof was performed.

## Sign filtering

Conditioning on unsigned supports and every sign-independent random choice fixes the entire selected tuple family, including stopping, duplicate rejection and load decisions. In the independent signed-clause model, the clause negative-parity bits remain independent fair bits under this conditioning.

For distinct nonempty subsets Ti,Tj of occurrence IDs, their indicator vectors are different nonzero vectors over GF(2). Two such vectors are linearly independent, so their two inner products with the independent sign vector are uniform on GF(2)^2. This proves pairwise independence even for heavily overlapping tuples. Thus t odd-parity indicators have mean t/2 and variance t/4. The displayed Chebyshev bound follows for positive t; its asymptotic use explicitly assumes t>=t0 with t0 tending to infinity. For conditionally fixed rational weights, the variance formula (1/4) sum yT^2 follows by vanishing pairwise covariances. Duplicate tuple copies would invalidate that variance calculation, and the selected policy rejects them.

Filtering preserves every clause load cap. Reusing the sound all-input FKO certificate from S3064 gives retained normalized mass t_odd/d. The argument correctly bounds the sign-dependent spectral quantity H using a separate deterministic threshold H0 on a high-probability event. It does not condition H to be a fixed constant or assume independence between H and the sign count. On discovery success, sign-filter failure is at most 1/(4 epsilon^2 t0); adding discovery and spectral bad-event probabilities proves the stated conditional sufficient result when inequality (2) has actual slack.

The without-replacement comparison transfers joint asymptotic run events by the signed-clause collision coupling. Exact conditional sign independence is not asserted for every unsigned multiset in that other model. This distinction is necessary and correct.

## Policy and missing progress

The first coefficient dependence after an independent prefix yields a nonempty fundamental circuit on at most K selected occurrence IDs. Its extraction is ordinary elimination, not a hidden minimum-support computation. Every acceptance increments only available clauses, hence loads stay <=d. Previously accepted circuits are rejected on repetition. None of these facts guarantees that the trajectory reaches a dependence before K or produces a new circuit.

After t accepted circuits, total charged incidences are at most Kt. Each saturated ID accounts for d charges, so at most Kt/d clauses are saturated. Condition (3) therefore leaves at least theta m available IDs until the target is reached. Availability alone proves neither residual randomness nor new-circuit probability.

The fixed-set expected two-overlap count is O(m u^2/n^2), which at u=Theta(n^(1/5)) is O(n^(-1/5)). Applying it to a support-informed adaptively selected U would be invalid; the note identifies rather than commits this error. The four-triple counterexample is also correct: its binary incidence matrix I+J squares to I in dimension four, so a minimum-degree-three core need not contain a dependence.

The proposed sufficient progress hypothesis is stated with the needed conditioning: a new short circuit with probability at least p after each reachable pre-target history. If such a bound held and Qp>=2t0, adapted Bernoulli lower-tail domination (extending trials by automatic successes after reaching the target) would indeed bound failure by exp(-Omega(t0)). The author does not prove that hypothesis, and the review supplies no such proof. Seed failures, duplicates, capacity depletion, and adaptive support biases remain part of this exact missing obligation.

## Uniform even covers under deletion

I independently opened the current [Moore-bound primary preprint, Theorem 1.2 and notation](https://arxiv.org/pdf/2607.14068v2). Its statement concerns simple uniform hypergraphs and supplies the stated density-to-even-cover existence implication. This is a theorem-statement scope check, not an independent certification of that paper's full proof.

Using its arity-three instance with rho=Theta(n^(1/5)) at residual size >=theta C n^(7/5) gives cover length L=O(n^(1/5) log n). The implication is uniform over residual hypergraphs, so arbitrary prior deletions are allowed. After deleting disjoint covers until the residual falls below theta m, the number deleted is at least (1-theta)m/L, up to integral rounding. This is a LOWER GUARANTEE on available disjoint packing, not an upper bound on its actual optimum. Choosing the covers without consulting signs permits the earlier sign lemma; indeed disjointness gives even stronger independence if desired.

The resulting guaranteed count Omega(n^(6/5)/log n) does not establish the desired comparison with the available O(n^(6/5)) spectral threshold bound at fixed constants. It does not establish that the actual count is small or that the actual numerical certificate fails. Replacing rho by rho/log n raises the required density by sqrt(log n), so it cannot remove this guarantee gap at fixed C through that substitution alone. No finder runtime for these covers is credited to the selected policy.

Unsigned support collisions have probability at most binom(m,2)/binom(n,3)=O(n^(-1/5)); conditioning on initial simplicity therefore costs o(1). Subsequent edge deletions preserve simplicity. The distinction from signed collisions is handled correctly.

## Disposition

No blocking mathematical correction is required. The proved facts isolate sign concentration and load feasibility from the still-open geometric discovery requirement. Polynomially bounded execution of the specified policy is not a refutation success theorem. No claimed improved FKO algorithm, lower bound on adaptive algorithms, or novelty conclusion follows from this GO.
