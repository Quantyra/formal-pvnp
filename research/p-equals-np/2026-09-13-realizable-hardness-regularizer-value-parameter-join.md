# Actual regularizer: optimum sandwich and noisy-source parameter join

2026-09-13. S3132/S3137, formal-pvnp. This is the finite value-level consequence of the actual generalized allocation, normalization, completeness, soundness and coding definitions. It does not add an output certificate, change any Lean source, establish a new compiler result or prove the missing encoded FP realization. Historical source-draft headers in accepted files are not used as current build receipts; the prior accepted generalized closure and independent finite/code reviews remain the evidence basis.

## 1. Objects and fixed constants

Let S be ANY valid actual Source, a pair of equally long ordered lists of binary-Nat triples and Bool RHS values, with m>0 rows. Repeated source labels and row occurrences are permitted. Construct exactly

    I = ActualSourceFiniteBridge.instanceOf S hValid.

This uses the first-occurrence normalization of S, with variables in Fin(3m), and the stored RHS converted by rhsValue. The generalized Allocation Instance has only its actual vars and rhs inputs; there is no input distinctness condition. In particular all exceptional sources and the noisy parity source are admissible.

Set

    D = FixedPortCycleFamily.degree,
    kappa = FixedPortCycleFamily.kappa,
    c = min(1,kappa) = soundnessCoefficient,
    B = 1+18D,
    E = I.edgeCount,
    t = I.rows.length = m+4E,
    lambda = m/t.

D is a fixed positive natural from the chosen library family, independent of the source. kappa is the actual fixedCoefficient/[D(1+fixedCoefficient+D)] from the proved port-cycle cut bound, not a chosen expansion premise. Existing positivity yields c>0, and c<=1. Existing row counts give

    0<m<=t<=Bm,             1/B<=lambda<=1.             (COUNTS)

These are inequalities of positive real casts where division occurs. No fixed equality t=Bm or fixed edge density is assumed; E can depend on actual owner occurrence sizes and graph edges.

For an assignment a to the original source labels, let v_S(a) be its number of false source equations. Let v_I(x) be the number of false output equations under an assignment x:I.GlobalVar->GF2. Define

    s = min_a v_S(a)/m = 1-Val(S),
    s_out = min_x v_I(x)/t = 1-Val(I).

The minima exist. The source uses only finitely many labels, and an assignment to them extends by zero to all Nat labels. GlobalVar is finite, including empty unused clouds. GF2 is a nonempty two-element set, so both finite assignment spaces are nonempty. These are actual optimization values over all assignments, not a caller's promise field.

## 2. Normalization and Fin transport preserve the exact source minimum

ActualSourceNormalization proves ordered violation-flag equality in both directions: liftAssignment transfers each original assignment to the normalized source, and decodeAssignment transfers each normalized assignment back. These maps need not be inverse at unused labels; preservation of flags in each direction suffices.

The actual finite bridge then proves

    I.sourceViolations(liftSourceAssignment S a) = v_S(a),
    v_S(decodeFiniteAssignment S y) = I.sourceViolations(y)

for every original assignment a and every y:Fin(3m)->GF2, respectively. The first follows from instance_violations_lift, the second from instance_violations_decode. RHS values and every repeated source summand stay in place. In particular there is equality of sets of attainable violation counts between S and the finite source of I: each count on either side is attained on the other via its displayed map. Taking the minimum gives

    min_y I.sourceViolations(y) = m*s.                 (MIN-SOURCE)

This proves the universal NO transport as well as the YES transport. A one-way existence of a near-satisfying finite assignment would not justify the lower bound below.

## 3. Actual extension and majority bounds give the value sandwich

The existing sourceExtension y puts y(v) on every port in owner cloud v and uses the actual equality-gadget internal extension. Each cloud then has zero violations, and every original output row has exactly its source value and RHS. The proved count identity is

    v_I(sourceExtension y) = I.sourceViolations(y).     (EXT)

It preserves violation COUNT, not the fraction. Applying EXT to an assignment attaining MIN-SOURCE yields s_out<=lambda*s.

For an arbitrary output assignment x, decoded x is the majority value over all ports in each owner cloud. The actual charging proof injects changed source rows into disagreeing occurrence anchor slots, then into minority ports. Thus the number of source violations after decoding is at most original-row violations plus total minority ports. Actual cloud expansion bounds cloud violations below by kappa times that minority. Multiplying the first term by c<=1 and the second by c<=kappa yields the proved inequality

    v_I(x) >= c*I.sourceViolations(decoded x).           (MAJ)

This statement uses the actual all-port majority and actual distinct occurrence anchors. It remains valid when a source equation uses one owner several times, because the anchors are distinct even when owners repeat. Combining MAJ with MIN-SOURCE, dividing by t>0, then minimizing over x proves

    c*lambda*s <= s_out <= lambda*s.                    (SANDWICH)

Equivalently, for every valid nonempty S,

    1-lambda*(1-Val(S)) <= Val(I)
       <= 1-c*lambda*(1-Val(S)).                        (VALUE)

This is the finite optimum lemma needed for the source join. Its only hypotheses are the actual constructor and the stated valid nonempty input, and its proof has been derived from concrete assignment maps and inequalities. It does not assert exact equality of output optimum with an extension value: an output assignment not constant on each cloud may improve that value. Nor does MAJ assert that this cannot happen.

## 4. Noisy YES and normal NO, without perfect-completeness substitution

The reviewed dyadic source on a NONEMPTY satisfiable CNF has optimum exactly1-epsilon, where epsilon=2^(-b), b>=2. The original CNF is satisfiable; the noisy equation source is not perfectly satisfiable when epsilon>0. Its honest assignment has exactly epsilon*m violations.

Use that honest source assignment in the finite lift and sourceExtension. EXT proves that its actual regularized extension satisfies exactly the fraction

    1-epsilon*m/t = 1-lambda*epsilon.

VALUE supplies the complete optimum interval

    1-lambda*epsilon <= Val(I) <= 1-c*lambda*epsilon.    (YES-INTERVAL)

In particular Val(I)>=1-epsilon. Since c,lambda,epsilon are positive, Val(I)<1: this actual regularizer does not convert noisy completeness to perfect completeness. The exact honest witness fraction is not described as the exact output optimum.

For a source of value at most5/8, s>=3/8. VALUE and COUNTS imply

    Val(I) <= 1-(3/8)c*lambda <= 1-gamma,
    gamma = 3c/(8B)>0.                                 (NO)

This applies to every output assignment, not only to constant-cloud extensions. It is the uniform NO threshold supplied by the actual existing constants. The input-dependent lambda could sharpen the threshold on an individual instance, but it is not replaced by a fabricated constant edge density.

## 5. Parameter order and a separated uniform promise

The uniform YES lower bound and NO upper bound established above are separated whenever

    epsilon < gamma = 3c/(8B).                         (SEPARATION)

It is therefore insufficient to select b merely from b>=2 and then declare the final regularized gap established. Indeed D>=1, c<=1 imply B>=19 and gamma<=3/152<1/4. For b=2 the sufficient condition SEPARATION fails. This does not prove that every actual instance at b=2 lacks a gap; it says the proven uniform thresholds do not establish the required one at that choice.

An explicit safe choice is

    b=max(2,ceil(log2(2/gamma))),
    epsilon=2^(-b)<=gamma/2.

The ceiling/real-log existence is legitimate since gamma is a fixed positive real constant; these parameters are selected once with the fixed regularizer, not recomputed from the varying input. A constructive numeric parameter implementation would have to supply an effective certified bound for those chosen constants rather than treat an arbitrary real logarithm as a primitive. The finite mathematical reduction needs only the fixed integer choice. No new numerical value for the library's chosen expander base is asserted.

With this choice the uniform promise is

    YES: Val(I)>=1-epsilon>=1-gamma/2,
    NO:  Val(I)<=1-gamma,

with an additive separation at least gamma/2>0. For multiplicative maximum-satisfaction approximation conventions the corresponding threshold ratio is at most (1-gamma)/(1-epsilon)<1; no approximation convention is silently imposed on a later matrix objective.

The parameter order for the whole finite construction is:

1. Fix the actual regularizer and hence D,kappa,c,B,gamma.
2. Fix the actual initial-gap PCP specialization, giving a fixed source-CNF gap eta>0.
3. Choose b as above, then choose integer

       u>=ceil(648000(b+2)/eta^3).

4. Run the fixed initial-gap reduction, then the fixed dyadic producer with these b,u, then the actual regularizer.

The initial-gap specialization and D are independent fixed choices, so the first two steps can be interchanged. What is essential is that the noise is small relative to gamma, and the repetition length is selected after that noise. The finite repeated-game proof still gives normal source NO5/8 for this larger u. Enlarging fixed b,u changes constants but not their independence from the input.

## 6. Exceptional sources before and after regularization

The dyadic typed producer handles empty original CNF by the one-row fixed YES source ((0,0,0),false). That source has s=0. SANDWICH implies s_out=0 exactly, so its regularized value is1. The repeated input label causes no issue: the three occurrence anchors in its actual original output row are distinct. The initial PCP-to-gap construction always emits a nonempty CNF, so this empty-CNF case does not occur in that particular composed reduction, but totality is preserved.

The global empty-conditioned-domain branch returns the two-row fixed NO source with the same triple(0,0,0) and opposite RHS bits. For EVERY source assignment it has one violation, so s=1/2. Its regularized value therefore satisfies

    1-lambda/2 <= Val(I) <= 1-c*lambda/2 <= 1-c/(2B).

The last upper bound is at least as strong as the normal NO bound, since c/(2B)>gamma. It is NOT asserted that its regularized optimum remains1/2. The added satisfiable equality rows change the denominator. Likewise any malformed raw input routed to that same fixed NO source by the strict parser has this regularized bound. There is no application of the noisy Fourier law to an exceptional branch.

All sources actually emitted by the upstream constructor have m>=1. For the unrelated genuinely empty typed Source([],[]) the actual occurrence construction has no rows and no violations. We do not divide by t=0 or assign it a value by the nonempty formulas above. An external convention such as value1 for an empty equation list can be added separately; it is unnecessary for this producer's image.

## 7. Actual structural output properties and exact encoded transport

The accepted generalized construction supplies these properties of the SAME row list I.rows:

- Every row map Fin3->GlobalVar is injective, so its support has exactly3 variables.
- Distinct row indices have supports intersecting in at most one variable. This is a pairwise linearity property, not an assumption that the graph has no loops or parallel darts.
- The ordered list is exactly rowIndices.map(row,rowRhs), and it is nodup. Repeated SOURCE rows are allowed; their actual distinct occurrence anchors and private gadget variables distinguish output rows.
- Each output variable belongs to at most4 row occurrences. Since every row has three distinct entries, this is also its total literal-occurrence count. It implies the looser degree-ten bound; it is not exact degree4 for every variable. Actual internal gadget variables have degree exactly2; unused external codes have degree0.
- The exact row count is t=m+4E<=Bm. The finite variable count is 3Dm+5E<=26Dm; the sharper proved inequality is twice that count <=51Dm.

These facts come from ActualRegularization, ActualOccurrenceDegree and the generalized actual allocation/counts. They do not use an input bounded-degree or distinct-label promise. There is no claim that a variable occurring several times in the original triple remains a repeated output variable: the actual construction deliberately uses distinct ports and enforces their agreement through equality clouds.

ActualOccurrenceCode maps GlobalVar injectively to VarCode and maps every row and RHS in order. Its codeRows_length equals t, codeRows_nodup follows from row-code injectivity, and rhsValue_rhsBool is the exact RHS roundtrip. For every assignment to all codes, restrictAssignment along codeVar preserves ordered violation flags. For every GlobalVar assignment, extendAssignment assigns its values on the image and zero off the image, and preserves the same flags. Both violations_restrict and violations_extend are proved. Therefore the attainable count sets, minima and VALUE bounds are identical for the coded rows. The semantic extension is not an executable inverse decoder assertion.

The code's support map transports exact support3 and pair-intersection<=1. Its degree_codeVar and degree_outside_image prove the all-code degree<=4 bound. Finally rowsWire is DataEncode of that actual coded row list; serialization changes no decoded row or RHS. It is a LIST of coded row/RHS pairs, whereas the upstream Source wire is a PAIR of component lists. The existing exact producer/Code theorems are required to connect these formats; this note does not equate their raw words by notation alone.

## 8. Runtime and completion boundary

The finite input normalization, counting, extension/majority inequalities and parameter choice above establish a mathematical gap for the typed/coded output. O(m) rows/variables for fixed D is not, by itself, a same-function FP theorem. The coded regularized producer must actually construct these rows in the established order from the upstream wire, with exact RHS, validity branches, fixed-family rotation computations and the same variable codes. Its full entry-function/constructor realization, including the paused gadget producer, remains a distinct obligation; individual accepted lookup/normalization/Code functions are not a substitute for that whole producer proof.

Similarly, the earlier ordinary raw source algorithm and initial-gap polynomial derivation are not newly promoted here to extracted Lean machines. Conditional composition of actual polynomial implementations would preserve polynomial time because the intermediate sizes are polynomial, with u,b,D fixed. That statement does not supply the missing implementations. No theorem field assuming their runtime is added.

This increment closes the finite optimum/parameter join, including the necessary ordering of epsilon relative to the regularizer constants. It does not close kernel formalization, pinned-library FP realization, later matrix-instance objective transformations, or the full paper theorem. Paper-specific source consolidation remains conditional on final Lean completion. No public action is authorized.

## 9. Exact inspected source identities and disclosure

Current raw SHA256 identities (paths relative to formal-pvnp):

| Source | SHA256 |
|---|---|
| certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualRegularization.lean | 1519a97bca309cb055deb428965d902fdf56e1d22b57a276424581a3af4cb95a |
| certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualOccurrenceSoundness.lean | 3793f4e54764a35f69f73a466a88adc53ad78e8e9eed4288b05906d2c4077172 |
| certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualOccurrenceCompleteness.lean | 71292cc306c22dc48bef7fc90edf448e8884038c421b67bacd81733db60bafa9 |
| certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualOccurrenceDegree.lean | 18a4151cd131776efee7b1c5925daa7438eebd9d1098a644e133f0d4545ca31e |
| certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualOccurrenceAllocation.lean | b8e813395f689f0b4cb24ce306d1e8d99655ff35fd8e2bd261c16ed95a967972 |
| certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualSourceNormalization.lean | c0c967e5fcaadf0f8388969da96285f4a22caa56a5461c8949bcc9a56cfca7a4 |
| certifications/realizable-hardness/lean/PvNP/RealizableHardness/FixedPortCycleFamily.lean | a33cfe1e21f85937f33edad0d722cb81927a003ae2f5896dd9f352e580681ef1 |
| research/p-equals-np/drafts/2026-09-13-source-finite-bridge/ActualSourceFiniteBridge.lean | 08a248f3081cca00a94521a94e7b13e2f84cba2c18689386cadaaf962dd94a3f |

The Code source and its current hash are recorded below. ActualRegularization/Completeness/Soundness/FixedPortCycleFamily and the finite bridge were read in full for this increment; the Code assignment/support/degree section was read directly. Relevant structural theorems were inspected in Degree and the previously accepted generalized allocation records. Prior accepted generalized independent5164 closure, finite bridge33913, and Code15478 evidence remains the basis for their prior bounded acceptance; no new build is inferred from these hashes.

The author previously authored Allocation, Counts, Completeness and several upstream notes, and independently reviewed other listed components. Those prior independent acceptances are relied on; this note itself requires a distinct review. Target source join archivebb68fa567d9787195237a949da418942948ee369 and initial-gap archive0ed53890f0e59713dd9ce982bfec4ec7437ab310 supply the finite upstream interfaces. Nothing is claimed as a novel hardness or regularization result.

Code source: research/p-equals-np/drafts/2026-09-13-occurrence-code/ActualOccurrenceCode.lean, raw SHA256 dd20ce025431950d6d348d7744b120c70ad3bdea14502009d6313990493f18e9.
