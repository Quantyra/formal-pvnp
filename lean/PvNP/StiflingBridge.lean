import Std
import PvNP.BasicDefs
import PvNP.StiflingModel
import PvNP.ExternalTheorems

namespace PvNP
namespace StiflingBridge

open Basic

def relationOf (F : CNF) : StiflingModel.Relation :=
  { arity := ExternalTheorems.Axioms.DTdepth F }

def bridge : ExternalTheorems.Axioms.StiflingBridge :=
  { toRelation := relationOf
    dtdepth_lower := by
      intro F d hd t
      exact Nat.le_trans hd t.depth_lb
    pdt_size_matches := by
      intro F g
      rfl }

end StiflingBridge
end PvNP
