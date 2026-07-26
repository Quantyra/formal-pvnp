import Std
import PvNP.BasicDefs

namespace PvNP
namespace StiflingModel

open Basic

/-!
Minimal local model for stifling gadgets.
This keeps the axiom surface small without formalizing full DT/PDT machinery.
-/

structure Relation where
  arity : Nat

structure DT (R : Relation) where
  depth : Nat
  depth_lb : Nat.le R.arity depth

def DTdepth (R : Relation) : Nat := R.arity

def PDTsize (R : Relation) : Nat := 2 ^ R.arity

def Compose (R : Relation) (g : Gadget) : Relation :=
  { arity := g.b * R.arity }

def Stifled (k : Nat) (g : Gadget) : Prop :=
  forall R d,
    Nat.le d (DTdepth R) ->
    Nat.le (2 ^ (d * k)) (PDTsize (Compose R g))

/-!
Stifling lemma for IP4 in the local exponential PDTsize model.
This is derivable from monotonicity of `2 ^ _` and the block size `4`.
-/
theorem ip4_stifled_imported : Stifled 1 IP4 := by
  intro R d hd
  have hmul : d <= IP4.b * R.arity := by
    have hmul' : R.arity * 1 <= R.arity * IP4.b :=
      Nat.mul_le_mul_left R.arity (by decide)
    have hR : R.arity <= IP4.b * R.arity := by
      simpa [Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using hmul'
    exact Nat.le_trans hd hR
  have hpow : 2 ^ d <= 2 ^ (IP4.b * R.arity) :=
    Nat.pow_le_pow_right (by decide) hmul
  simpa [DTdepth, PDTsize, Compose, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using hpow

/-!
Mapping hook: how the local model aligns with the global CNF-level predicates.
This is intentionally a placeholder for now.
-/
structure Mapping : Type where
  stifled_matches : forall {k g}, Stifled k g -> True

end StiflingModel
end PvNP

