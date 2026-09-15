# Actual-star span intersection closeout

Date: 2026-09-14
Repository: C:\Users\Dan\Desktop\Projects\formal-pvnp
Scope: S3126/S3137 actual-star coherence route.

## Exact definitions and theorem

The frozen main module is certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualStarSpanIntersection.lean. Its exact definitions are:

def equationVector (row : E → Finset X) (e : E) : X → ZMod 2 :=
  fun x => if x ∈ row e then 1 else 0

def equationSpan (row : E → Finset X) (U : Finset E) :
    Submodule (ZMod 2) (X → ZMod 2) :=
  Submodule.span (ZMod 2) (equationVector row '' (U : Set E))

def coordinateSpace (row : E → Finset X) (U : Finset E) :
    Submodule (ZMod 2) (X → ZMod 2) :=
  { carrier := {v | ∀ x, x ∉ questionSupport row U → v x = 0}
    zero_mem' := by
      intro x hx
      simp
    add_mem' := by
      intro v w hv hw x hx
      simp only [Pi.add_apply]
      rw [hv x hx, hw x hx, add_zero]
    smul_mem' := by
      intro a v hv x hx
      simp only [Pi.smul_apply]
      rw [hv x hx, smul_zero] }

The exact theorem declaration is:

theorem equationSpan_inf_coordinateSpace
    (row : E → Finset X)
    (hthree : ∀ e, (row e).card = 3)
    (hlinear : ∀ e f, e ≠ f → ((row e) ∩ (row f)).card ≤ 1)
    (U U' : Finset E)
    (hU : GoodQuestion row U) (hU' : GoodQuestion row U') :
    equationSpan row U' ⊓ coordinateSpace row U =
      equationSpan row (U' ∩ U) := by

No theorem statement, quantifier order, definition, or main-module import changed during Checks strengthening.

## Frozen sources and certification

- Main source SHA256: f3ce6ed0bf8fb9164f16eb846a3378fd2f3471016ece35f5db8c091e967042a5.
- Final Checks source SHA256: d2fecc62df0ab53de600e70ea89ffc0b1974a36d854b0211fd851185288dcbeb.
- Unchanged certified main object SHA256: decc2eaa887ac7c8c1db4f121fc0b5a9ba03369fa191e1de6b7cca3fce748dbd.
- Final Checks object SHA256: ca6511ffd164fa888d3b263be48aea597060b1b10dd29be1420a628d0d5bfba6.
- Both cached and fresh main/Checks compilations exited 0. Fresh source before/after hashes agree.
- Exact #check and #print axioms appear in the Checks transcript. The axiom profile is propext, Classical.choice, and Quot.sound.
- The final Checks fixture has U={old, other}, U'={new, other}, U' intersect U={other}; old/new overlap in exactly one coordinate; both GoodQuestion hypotheses are proved; and U'.erase new is nonempty.

## Evidence bundles

Initial main+Checks bundle: research/evidence/2026-09-14-actual-star-span-intersection-fresh-run/; manifest SHA256 be2451706bfabcce636c6befa8145a1531123ad1d6ad16e58c9603735cca1f4b.

Strengthened Checks-only bundle: research/evidence/2026-09-14-actual-star-span-intersection-strengthened-checks-fresh-run/; manifest SHA256 c3232c760ab83ca067272327d97865c301a4b9b67493eab9510b8a60c6a440b6.

The bundles contain raw stdout/stderr, terminal metadata, object/source hashes, and the strengthened bundle contains the forbidden-scan transcript. The scan command was rg -n -i forbidden-token-expression over both Lean sources; it exited 1 with no matches.

## Three-lens review

| Lens | Disposition | Evidence SHA256 |
|---|---|---|
| Proof adversarial | GO | ed226dc9409c6aa05cb63e214d565449a762a77ad72dce84c1d1c551e13cbfdf |
| Complexity theory | GO-WITH-NOTES | c1335a90f38d0915fb60b1dcd082e80468915edec614b9240bec619aee850923 |
| Non-claims boundary | GO-WITH-NOTES | e59805c143813287d8e4a0fa86d83d9b243a54ebc21d32828039c985021d565e |

The result is the bounded abstract incidence span identity under the stated GoodQuestion hypotheses. It does not establish actual-source realization, label transport, acceptance, hardness, randomized reduction, P versus NP, or manuscript completion.

## Consumer and risk boundary

The exact consumer is the actual-source specialization, followed by the RHS functional construction and overlap agreement, then minimal gluing and unique transport.

Risk audits:

- Actual-source assumption bridge: CONDITIONAL, SHA256 7e7568a9e8dd965905f49e32c3b581bcc204a5d485830e5c96d752830109ba6.
- Headline randomized reduction: NO-GO, SHA256 fce2006af49a36ddc362f6f4e2746f6c5626d3d5d306907fee1e201cac9b6410.

## Next exact risk-first obligations

1. Prove the actual-source specialization supplies the two GoodQuestion instances for the emitted questions, with its retained-law assumptions explicit.
2. Formalize the RHS functional construction and overlap agreement, then the minimal gluing and unique-transport theorem needed by the manuscript route.
3. Resolve the headline randomized-reduction risk audit before making any headline hardness or P-versus-NP claim.