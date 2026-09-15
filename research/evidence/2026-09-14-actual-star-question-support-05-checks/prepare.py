import hashlib
import json
import os
import pathlib

B = pathlib.Path(__file__).parent.resolve()
R = B.parents[2]
OLD = R / "research/evidence/2026-09-14-actual-star-question-support-03-checks"
OLD_INV = OLD / "isolated-copy-inventory.json"
OLD_OUT = R / "certifications/realizable-hardness/.lake/build/actual-star-question-support-checks03-20260914/deps/lib/lean"
W = R / "certifications/realizable-hardness/.lake/build/actual-star-question-support-checks04-20260914"
OUT = W / "deps/lib/lean"

def sha(p):
    h = hashlib.sha256()
    with pathlib.Path(p).open("rb") as f:
        for c in iter(lambda: f.read(1024 * 1024), b""): h.update(c)
    return h.hexdigest()

def save(p, x):
    assert not p.exists(), str(p)
    p.write_text(json.dumps(x, indent=2) + "\n", encoding="utf-8", newline="\n")

assert sha(OLD_INV) == "7d0713987d7c890452c0d80196c0b94a4a5e7b1517c4e07e04bab32e34f84b25"
assert W.exists() and OUT.exists()
old_inv = json.loads(OLD_INV.read_bytes())
assert len(old_inv["copies"]) == 10187
lower = [r for r in old_inv["copies"] if pathlib.Path(r["path"]).name not in {"ActualStarQuestionSupport.olean", "ActualStarQuestionSupport.ilean"}]
assert len(lower) == 10185
records = []
for rec in lower:
    src = pathlib.Path(rec["path"]); rel = src.relative_to(OLD_OUT)
    assert "ActualStarQuestionSupport" not in str(rel)
    dst = OUT / rel
    assert dst.exists() and dst.stat().st_size == rec["bytes"] and sha(dst) == rec["sha256"], str(dst)
    records.append({**rec, "path": str(dst), "attempt03_path": str(src), "copy_method": "reused existing checks04 hardlink; validated read-only"})

main_root = R / "certifications/realizable-hardness/.lake/build/star-formula-fresh-target-execution-20260914/deps/lib/lean/PvNP/RealizableHardness"
for ext, expected in {".olean": "7b725fa38638b7c39d63dce1f83b558a21e0de05f30cb336f698d5a672cf307c", ".ilean": "b8cb2ed95f1aac873150be248889dbbe181eae318e872e583a13d2184010741f"}.items():
    src = main_root / ("ActualStarQuestionSupport" + ext); dst = OUT / "PvNP/RealizableHardness" / src.name
    assert sha(src) == expected and not dst.exists()
    os.link(src, dst); assert sha(dst) == expected
    records.append({"path": str(dst), "attempt03_path": str(src), "sha256": expected, "bytes": dst.stat().st_size, "copy_method": "hardlink; accepted main02 imported read-only"})

checks = OLD / "source/PvNP/RealizableHardness/ActualStarQuestionSupportChecks.lean"
source = B / "source/PvNP/RealizableHardness/ActualStarQuestionSupportChecks.lean"
source.parent.mkdir(parents=True, exist_ok=True); source.write_bytes(checks.read_bytes())
assert sha(source) == "2bfe2ebd856cbb3d4f38cb37dabe8d241509bc0586ebc279a656176f5d25ebd8"
main_source = R / "research/evidence/2026-09-14-actual-star-question-support-02-diagnostic/source/PvNP/RealizableHardness/ActualStarQuestionSupport.lean"
main_terminal = R / "certifications/realizable-hardness/.lake/build/star-formula-fresh-target-execution-20260914/guarded-runs-question-support-02/00-PvNP.RealizableHardness.ActualStarQuestionSupport/terminal.json"
assert sha(main_source) == "d61e78cc98be9bff83e9f779b950dfed48aa8fa629efde5f6fd147e97442b8a5"
mt = json.loads(main_terminal.read_bytes()); assert mt["exit_code"] == 0 and mt["source_unchanged"] is True
inv = {"copies": records, "copy_count": len(records), "lower_reused_count": 10185, "accepted_main02_count": 2, "validated_against_attempt03_inventory": str(OLD_INV), "validated_against_attempt03_inventory_sha256": "7d0713987d7c890452c0d80196c0b94a4a5e7b1517c4e07e04bab32e34f84b25"}
save(B / "isolated-copy-inventory.json", inv)
base = json.loads((OLD / "plan.json").read_bytes())
base.update({"compiler_authorized": False, "workspace": str(W), "copies_sha256": sha(B / "isolated-copy-inventory.json"), "sources": [{"module": "PvNP.RealizableHardness.ActualStarQuestionSupportChecks", "sha256": sha(source), "path": str(source), "root": str(B / "source")}], "root_clearance": "NOT GRANTED: preparation only; one target disabled", "task_status": "Checks only; checks04 lower tree reused; accepted main02 reused; no Lean launched", "no_lake": True, "no_overwrite_or_retry": True, "lower_copy_count": 10185, "validated_against_attempt03_inventory_sha256": "7d0713987d7c890452c0d80196c0b94a4a5e7b1517c4e07e04bab32e34f84b25", "main02_source": {"module": "PvNP.RealizableHardness.ActualStarQuestionSupport", "sha256": sha(main_source), "path": str(main_source), "root": str(main_source.parents[3])}, "main02_terminal": str(main_terminal), "main02_terminal_sha256": sha(main_terminal), "prior_attempt03_preparation": str(OLD / "preparation.json"), "prior_attempt03_preparation_sha256": sha(OLD / "preparation.json"), "rejected_attempt04_preparation": str(R / "research/evidence/2026-09-14-actual-star-question-support-04-checks/preparation.json"), "rejected_attempt04_preparation_sha256": sha(R / "research/evidence/2026-09-14-actual-star-question-support-04-checks/preparation.json"), "rejected_attempt04b_preparation": str(R / "research/evidence/2026-09-14-actual-star-question-support-04-checks/preparation.json"), "rejected_attempt04b_preparation_sha256": sha(R / "research/evidence/2026-09-14-actual-star-question-support-04-checks/preparation.json"), "prelaunch_record": str(B / "prelaunch-terminal.json"), "diagnostic": str(W / "guarded-runs-question-support-checks05")})
save(B / "plan.json", base); save(B / "pregrant-plan.json", base)
save(B / "preparation.json", {"compiler_launched": False, "workspace_reused": True, "lower_files_validated": 10185, "copies": len(records), "inventory_sha256": sha(B / "isolated-copy-inventory.json"), "runner_sha256": sha(B / "runner.py"), "plan_sha256": sha(B / "plan.json"), "source_sha256": sha(source), "main02_olean_sha256": "7b725fa38638b7c39d63dce1f83b558a21e0de05f30cb336f698d5a672cf307c", "main02_ilean_sha256": "b8cb2ed95f1aac873150be248889dbbe181eae318e872e583a13d2184010741f", "attempt03_inventory_sha256": "7d0713987d7c890452c0d80196c0b94a4a5e7b1517c4e07e04bab32e34f84b25"})
print(json.dumps({"copies": len(records), "inventory_sha256": sha(B / "isolated-copy-inventory.json"), "source_sha256": sha(source)}))
