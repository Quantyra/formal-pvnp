# Independent non-claims review: executable sampling policy

2026-09-13. S3131/S3137 under S3126. Reviewer specialization_nonclaims_review, independent of Policy authorship and proof/complexity lenses. **GO-WITH-NOTES for the selected sampling policy, concrete padded executor agreement, and the stated concentration probability.** No blocking overclaim found. Full encoded-runtime and source-hardness certification remain open.

## Evidence and scope

Read complete ExecutableSamplingPolicy main and Checks, author crosswalk/verification narrative, completed independent proof review, and actual imported Good, precision, sample-count and prefix-probability interfaces. The Input/parser/execution semantics were independently reviewed earlier in this reviewer session, along with applicable planning protocol, three-lens protocol and inbox. No satellite AGENTS.md was found. No separate Policy complexity review was present during inspection; this verdict does not substitute for that lens.

Both current source files are raw-identical to freeze `fea288ecc4e6a5aaf226c49b9ee331242d049a2d`:

- Main SHA256 `c7faedec1867adc13b45a439888da7eaa1483c6b7ae85de9d91f3c73d7c5112c`.
- Checks SHA256 `cd2b3d69ec98c7e5aee91c1e0f274ec17d4cf5f57f92401f7bdd63524ed27fc7`.

Current independent proof markdown SHA256 is `221c30b63371fc345907d7567bd977d96f873bad4490b2bd43e922b6afd1d047`; JSON is `be7bd55bf6786530a670bca3eb8eccd2bb32963bbc55cb83e97026ec34851d0e`. Its completion records actual session 73339 pair EXIT 0, unchanged sources, 23 profiles using only standard axioms or none, eight examples and four signatures. This lens does not claim a fresh compiler run or replace root's 45-dependency/four-receipt verification. The deprecated if_pos warning and historical unlaunched/source-only labels do not invalidate the recorded result; final current-facing text should reconcile those labels without erasing provenance.

## Exact content supported

For externally fixed positive rational policy eps, the module computes P=ceil(1/eps), the actual sample count M from weights.length and P, and the actual dyadic precision b from stored rows.length and eps. It derives positivity, the learning threshold and grid bound. N and S count actual list entries; S includes zero-mass and repeated rows, not just positive support atoms. Their separate encoding subtrees prove N,S<=n for the selected deterministic encoding length n, yielding c=M*b<=Q(n), where

    Q(n)=512*P^3*(n^2+11n).

This is a length-only numerical coin ruler for each fixed eps. Including selected M/b in n is not an assumed circular cap: the proof uses the weight and row subtrees independently. It is not a uniform polynomial in the binary encoding of a varying epsilon, nor a bound in the original SAT/source-instance length. Explicit table construction and the source-to-selected-input size relation remain unproved here.

paddedRunOption actually parses the deterministic tape, checks both policy-selected fields, exact Q-bit tape length and c<=coins.length, then calls the existing runOption on the first c bits. These are executed guards rather than premises supplied by the caller. The selected-input theorem discharges them, allows arbitrary surplus bits, and proves equality to the same checkedBits. With valid arithmetic Parameters and stored-row leaf bounds, paddedRun_selected_valid gives exact Pipeline.bits byte equality for every full tape. No desired output equation is supplied as an assumption.

The finite tape type is c+(Q-c); padded_length_eq_ruler proves this is exactly Q, so natural subtraction does not conceal a shorter tape. Parser digit conventions are connected to the accepted flatten/unflatten equivalence. Uniform prefix probability is proved by finite probability transport, not assumed independence. The exact byte equality and the recovered draws' Good event are then conjoined in padded_executor_good_probability with probability at least 5/6 under uniform Q-bit tapes.

Good has a specific meaning: simultaneously for every assignment x, empirical frequency of the supplied Boolean row predicate F x differs from its original rational-law mean by strictly less than policy eps/4. It is not a CMMSA YES/NO promise, a rounded-output correctness event, a decoder success theorem or a hardness conclusion. The final equality conjunct holds on every tape and contributes no extra failure probability; the nontrivial probability is precisely this Good event. Instantiating F with the actual source predicate and transporting the bound through repair/rounding remain assembly obligations.

## Limits that must remain explicit

Policy eps is independent of q.eps and the epsilon in valid arithmetic Parameters. No equality is inferred. The author's intended q.eps=eps application must choose or relate them and prove the semantic conditions. Probability guarantees require eps>0; total definitions at zero/negative eps do not imply success. Positive M is derived; b may be zero for sufficiently large positive eps, without contradicting the explicit grid/concentration conditions.

selected retains weights, source rows and arithmetic scalars while replacing M/b. The draft's statement that no input is deleted describes that constructor's retained data. It must not be read as saying paddedRun accepts every old arbitrary-M/b input or preserves unrestricted run on that entire domain: its new guards expressly reject nonselected policy fields. This addresses the prior unrestricted-count obstruction only on the intended selected domain. It remains essential to show that every intended hard source instance reaches this domain; choosing a convenient subset is insufficient.

The parser runs before the guards, and computing the guards has its own arithmetic cost. Neither early guard order, the coin polynomial, byte equality nor concentration establishes FP of the selected constructor or padded executor. No FP ruler machine or completed RandomizedReduction.SeededMap instance is supplied by this pair. Original-source size, exact rational arithmetic, intermediate magnitudes, table enumeration, output construction/validation and final machine integration still require proofs.

This is known sampling/encoding machinery applied to the actual policy, not evidence of novel sampling or a quantum algorithm. It does not establish source NP-hardness, complete PCP/decoder, full CMMSA hardness, learning, P=NP/P!=NP, publication readiness or full-paper Lean certification. This non-claims verdict is not publication approval.

Only this separate review file is authored here and is left untracked for scoped root freezing. No compiler, source, package, configuration, Git or public changes are performed for this Policy review; the preceding Table review freeze was a distinct authorized task.

Remaining to-do list: S3137 completes all lenses and root verification before bounded acceptance; S3131 proves actual selected construction/runtime, original-source bounds, epsilon alignment and RandomizedReduction integration; S3132 supplies source hardness; S3134/S3135 finish decoder and compatible parameters; S3136 completes learning; S3128 reconciles and consolidates the finalized proof into the paper repository with fresh-checkout verification. Full S3126 remains open.
