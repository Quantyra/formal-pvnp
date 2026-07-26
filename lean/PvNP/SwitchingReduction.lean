/-
# Reduction: an injective Razborov encoding ⟹ the switching lemma

This proves the assembly half of the switching lemma OUTRIGHT, reducing the full
`SwitchingLemma n` to a single clean hypothesis: that for every (D, w, s, ℓ) with
`widthDNF D ≤ w` there is an injective `encode : Restriction → Restriction × Code`
sending each bad restriction (ℓ stars, deep canonical DT) to one with `ℓ-s` stars
plus a code in `Fin s → Fin w × Bool`.

`HasInjectiveEncoding n → SwitchingLemma n` is PROVED here (via the injection
cardinality backbone `card_le_mul_pow_of_injOn` and `(2w)^s ≤ (8w)^s`).  Thus the
ONLY remaining content of the switching lemma is the construction of that injective
encoding (the Razborov encode/decode), now isolated as `HasInjectiveEncoding` —
exactly the DagNarrows-style staging.  `HasInjectiveEncoding` is an isolated `def`,
NOT an axiom, NOT asserted true.

INTEGRITY: no `sorry`, no `admit`, no new `axiom`, no `native_decide`.  NOT a lower
bound, NOT P≠NP.
-/
import PvNP.SwitchingCardLemma

namespace PvNP
namespace SwitchingReduction

open PvNP.BoundedDepthCanonicalDT
open PvNP.BoundedDepthRestriction
open PvNP.SwitchingLemmaStatement
open PvNP.SwitchingCardLemma
open Classical

/-- The isolated remaining content of the switching lemma: a width-respecting,
injective Razborov encoding of the bad restrictions into
`(restrictions with ℓ-s stars) × (codes : Fin s → Fin w × Bool)`.

This is an isolated `def` (a `Prop`), NOT an axiom and NOT asserted true — it names
exactly the gap between the proved scaffolding and `SwitchingLemma`. -/
def HasInjectiveEncoding (n : Nat) : Prop :=
  ∀ (D : DNF n) (w s ℓ : Nat), widthDNF D ≤ w →
    ∃ enc : Restriction n → Restriction n × (Fin s → Fin w × Bool),
      (∀ ρ ∈ badSet D s ℓ, (enc ρ).1 ∈ restrictionsWithStars n (ℓ - s)) ∧
      Set.InjOn enc ↑(badSet D s ℓ)

/-- **The reduction (PROVED).** An injective Razborov encoding discharges the full
switching lemma. -/
theorem switchingLemma_of_hasEncoding {n : Nat} (h : HasInjectiveEncoding n) :
    SwitchingLemma n := by
  intro D w s ℓ hw
  obtain ⟨enc, hmem, hinj⟩ := h D w s ℓ hw
  have hc : (badSet D s ℓ).card
      ≤ (restrictionsWithStars n (ℓ - s)).card * (2 * w) ^ s :=
    card_le_mul_pow_of_injOn (badSet D s ℓ) (restrictionsWithStars n (ℓ - s)) w s enc hmem hinj
  refine le_trans hc ?_
  apply Nat.mul_le_mul (le_refl _)
  exact Nat.pow_le_pow_left (by omega) s

end SwitchingReduction
end PvNP
