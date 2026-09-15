import hashlib
import json
import pathlib
import subprocess

B = pathlib.Path(__file__).parent.resolve()
def sha(p):
    h = hashlib.sha256()
    with pathlib.Path(p).open("rb") as f:
        for c in iter(lambda: f.read(1024 * 1024), b""): h.update(c)
    return h.hexdigest()

plan = json.loads((B / "plan.json").read_bytes())
runner = (B / "runner.py").read_text(encoding="utf-8")
assert plan["compiler_authorized"] is False
assert plan["start_bytes"] == 3489660928 and plan["stop_bytes"] == 671088640 and plan["threads"] == 1
assert plan["do_not_run_lake"] and plan["no_lake"] and plan["no_overwrite_or_retry"]
src = pathlib.Path(plan["sources"][0]["path"])
assert sha(src) == plan["sources"][0]["sha256"] == "8a79467f322e86f43a144397d9f7ac4f21d821623a97c492abd64d73b76d4203"
assert "8a79467f322e86f43a144397d9f7ac4f21d821623a97c492abd64d73b76d4203" in runner
assert plan["workspace"].endswith("actual-star-question-support-checks04-20260914")
assert "guarded-runs-question-support-checks09" in runner and "prelaunch-app-suspension09.json" in runner
inv_path = B / "isolated-copy-inventory.json"
assert sha(inv_path) == plan["copies_sha256"] == "17d4cc6caa1be5b63b41f73c76a453e73f695f56ea3295f2486d84c1734132dd"
inv = json.loads(inv_path.read_bytes()); assert inv["copy_count"] == 10187 and inv["lower_reused_count"] == 10185
for rec in inv["copies"]: assert pathlib.Path(rec["path"]).exists() and sha(rec["path"]) == rec["sha256"]
main = pathlib.Path(plan["main02_source"]["path"]); assert sha(main) == "d61e78cc98be9bff83e9f779b950dfed48aa8fa629efde5f6fd147e97442b8a5"
term = pathlib.Path(plan["main02_terminal"]); tj = json.loads(term.read_bytes()); assert tj["exit_code"] == 0 and tj["source_unchanged"] is True
out = pathlib.Path(plan["workspace"]) / "deps/lib/lean/PvNP/RealizableHardness/ActualStarQuestionSupportChecks"
for ext in [".olean", ".ilean", ".olean.private", ".olean.server", ".ir.sig", ".ir"]: assert not pathlib.Path(str(out) + ext).exists()
for ext, expected in {".olean": "7b725fa38638b7c39d63dce1f83b558a21e0de05f30cb336f698d5a672cf307c", ".ilean": "b8cb2ed95f1aac873150be248889dbbe181eae318e872e583a13d2184010741f"}.items():
    accepted = pathlib.Path(str(pathlib.Path(plan["companion"]) / ".lake/build/star-formula-fresh-target-execution-20260914/deps/lib/lean/PvNP/RealizableHardness/ActualStarQuestionSupport") + ext)
    assert sha(accepted) == expected
q = 'Get-Process | Where-Object { $_.ProcessName -in @("lean","lake") } | Select-Object -ExpandProperty Id'
assert not subprocess.check_output(["powershell", "-NoProfile", "-Command", q], text=True).strip()
print("VERIFIED: disabled checks09 wrapper; no runner/compiler/app suspension executed")
