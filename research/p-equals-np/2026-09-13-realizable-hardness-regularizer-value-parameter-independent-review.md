# Independent review: regularizer value and parameter join

2026-09-13. S3132/S3137, formal-pvnp. GO for the finite optimum sandwich, parameter ordering, and coded semantic transport. This is not a runtime or new kernel acceptance.

Candidate: 2026-09-13-realizable-hardness-regularizer-value-parameter-join.md, SHA256 05ed832983b1abb9327d1eba2e941daf417375bb73efb0efd74ca6f35f363820, 18115 bytes. I read the complete candidate and verified its hash, all eight raw Lean identities in its source table, and the separately recorded Code hash dd20ce025431950d6d348d7744b120c70ad3bdea14502009d6313990493f18e9. These are current byte checks, not a new compiler or Git-provenance audit.

Role disclosure: I authored the source normalization/finite bridge and downstream producer drafts and previously reviewed the generalized allocation closure and Code. Their prior independent acceptances are relied upon. I did not author this join, but before its drafting I identified the existing transfer formulas and necessary epsilon-versus-gamma choice to root. This is a disclosed mathematical challenge and interface review, not a claim of wholly noncontributing certification.

## Exact finite argument

Let m>0, t=m+4E, B=1+18D, lambda=m/t and c=min(1,kappa). The actual Regularization row count and positivity results give m<=t<=Bm and 1/B<=lambda<=1. FixedPortCycleFamily defines kappa as fixedCoefficient/[D(1+fixedCoefficient+D)] and proves it positive. Hence 0<c<=1, with D,c,B independent of the input. No equality between actual t and the upper bound Bm is used.

The minimum over Nat assignments is legitimate despite the infinite label universe: only finitely many labels occur, their assignments form a finite nonempty set, and each extends by zero. FiniteBridge.instance_violations_lift and instance_violations_decode give both inclusions between attainable source violation-count sets. Unused labels need not be reconstructed identically. Repeated summands and every RHS survive these exact flag/count equalities. Thus the minimum finite source count is m*s, where s=1-Val(S).

ActualOccurrenceCompleteness's sourceExtension_violations gives an output assignment with exactly that count. Dividing by t yields s_out<=lambda*s. Conversely ActualOccurrenceSoundness.violations_lower_decoded, inspected directly, gives v_I(x)>=c*sourceViolations(decoded x) for every output assignment. The decoded source count is at least m*s. Division and minimization yield s_out>=c*lambda*s. Neither step assumes output assignments are cloud-constant. Therefore

    c*lambda*s <= s_out <= lambda*s

and the candidate's reversed satisfaction-value inequalities have the correct directions. Finite attainment avoids an unattained-infimum issue. Generalized allocation has no per-row owner-injectivity requirement; its distinct occurrence anchors make the inherited charging argument applicable to repeated source owners. This review uses the already accepted generalized proof rather than re-proving that full charging closure.

## Noisy completeness and separated parameters

The upstream nonempty satisfiable-CNF source has exact optimum 1-eps and an honest assignment with eps*m violations. Extending that specific assignment gives exact satisfaction fraction 1-lambda*eps. The output OPTIMUM is only constrained to

    1-lambda*eps <= Val(I) <= 1-c*lambda*eps.

The strict upper bound below 1 follows from c,lambda,eps>0. Thus this join cannot silently restore perfect completeness or identify the extension with an optimizer. Its uniform lower bound 1-eps is valid because lambda<=1.

For source value<=5/8, s>=3/8. The sandwich and lambda>=1/B give Val(I)<=1-gamma with gamma=3c/(8B)>0. All scalings are by nonnegative quantities. The target NO statement covers every output assignment, as required.

The choice b=max(2,ceil(log2(2/gamma))) gives eps=2^(-b)<=gamma/2. Since D>=1 and c<=1, gamma<=3/152<1/4, so merely imposing b>=2 is insufficient for these proven uniform thresholds. The note correctly avoids inferring failure of the actual construction at b=2. With the chosen b, YES>=1-gamma/2 and NO<=1-gamma have positive separation at least gamma/2. The ratio (1-gamma)/(1-eps)<1 is well defined since eps<=1/4 and gamma<1.

The expander constants and initial PCP gap eta are fixed first; b is selected relative to gamma; u>=ceil(648000(b+2)/eta^3) is selected after eta,b. All are fixed independently of the input. A finite fixed integer may be selected using the Archimedean/logarithmic inequality without computing an arbitrary real as a runtime primitive. The note correctly leaves an extracted numerical parameter implementation distinct. Increasing these constants does not change polynomiality of already justified fixed-parameter stages, and does not supply missing stages.

## Exceptional cases and coded structure

The one-row fixed YES source has s=0, so both sandwich endpoints give output value exactly 1. It is outside the nonempty original-CNF noisy-equality assertion and does not contradict it. The two-row opposite-RHS fixed NO source has s=1/2, giving output value in [1-lambda/2,1-c*lambda/2], and hence at most 1-c/(2B). Since c/(2B)>3c/(8B), this suffices for the same NO promise. Its optimum is not claimed to remain 1/2 after adding cloud rows. The malformed raw-input fallback has this same semantic analysis. No Fourier argument is applied to either exceptional source.

All actual upstream outputs are nonempty. The unrelated empty typed source is expressly excluded from division, so no 0/0 convention enters the proof.

The actual Regularization certificate gives support size three, pairwise intersection at most one, row nodup, degree at most four, t=m+4E and the stated variable bounds for the same output list. Source repetitions do not imply repeated output variables because occurrence ports are distinct. Degree four is an upper bound, not exact regular degree; the candidate preserves this distinction.

Code.violations_restrict and violations_extend, inspected with its ordered flag statements, preserve attainable counts in both directions and codeRows_length preserves t. Its support embedding and degree_codeVar/degree_outside_image preserve the structural conclusions for all codes, including unused codes of degree zero. This supplies value equality for the coded row list. The semantic extension uses a noncomputable inverse on the finite image; no executable inverse is inferred. DataEncode serializes the actual coded row/RHS LIST, which differs from the upstream Source PAIR of lists. The candidate explicitly retains the missing producer requirement for that exact wire join.

## Completion boundary

The optimum sandwich is a valid finite consequence of existing count-level results; the consolidated parameter choice closes the identified value-level interface. It does not claim a stronger new cloud theorem. No mathematical repair is requested for this exact candidate.

Full construction runtime remains separate: O(m) semantic rows and finite variables do not prove the paused gadget/global producer computes them in pinned FP. Nor does this note newly compile normalization, finite bridge, Code or the upstream finite proofs. Later matrix objective transformations and the full manuscript theorem remain outside this bounded result. I made no source/candidate edits, ran no compiler or experiments, and performed no Git or public action.
