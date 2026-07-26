import Std
import PvNP.DecisionTreeSearch
import PvNP.CNFData

namespace PvNP
namespace CNFDataBundleProvider

instance (F : CNFData.CNFData) : DecisionTreeSearch.CNFBundleProvider F.base where
  bundle := { data := F }
  base_eq := rfl

end CNFDataBundleProvider
end PvNP
