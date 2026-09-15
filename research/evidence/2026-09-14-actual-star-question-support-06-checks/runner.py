import ctypes
import hashlib
import json
import os
import pathlib
import subprocess
import sys
import time

B = pathlib.Path(__file__).parent.resolve()
def sha(p):
    h = hashlib.sha256()
    with pathlib.Path(p).open("rb") as f:
        for c in iter(lambda: f.read(1024 * 1024), b""): h.update(c)
    return h.hexdigest()
def save(p, x):
    assert not p.exists(), str(p)
    p.write_text(json.dumps(x, indent=2) + "\n", encoding="utf-8", newline="\n")
assert len(sys.argv) == 1
p = json.loads((B / "plan.json").read_bytes())
assert p["compiler_authorized"] is True, "DISABLED: fresh explicit root clearance required; no child launched"
assert p["no_lake"] and p["no_overwrite_or_retry"] and p["threads"] == 1
assert p["start_bytes"] == 3758096384 and p["stop_bytes"] == 671088640
r = p["sources"][0]
assert r["module"] == "PvNP.RealizableHardness.ActualStarQuestionSupportChecks"
assert sha(r["path"]) == r["sha256"] == "2bfe2ebd856cbb3d4f38cb37dabe8d241509bc0586ebc279a656176f5d25ebd8"
assert sha(B / "isolated-copy-inventory.json") == p["copies_sha256"]
inv = json.loads((B / "isolated-copy-inventory.json").read_bytes()); assert inv["copy_count"] == 10187
for x in inv["copies"]: assert pathlib.Path(x["path"]).exists() and sha(x["path"]) == x["sha256"]
assert sha(p["main02_source"]["path"]) == "d61e78cc98be9bff83e9f779b950dfed48aa8fa629efde5f6fd147e97442b8a5"
mt = pathlib.Path(p["main02_terminal"]); tj = json.loads(mt.read_bytes())
assert sha(mt) == p["main02_terminal_sha256"] and tj["exit_code"] == 0 and tj["source_unchanged"] is True
mainout = pathlib.Path(p["companion"]) / ".lake/build/star-formula-fresh-target-execution-20260914/deps/lib/lean/PvNP/RealizableHardness"
assert sha(mainout / "ActualStarQuestionSupport.olean") == "7b725fa38638b7c39d63dce1f83b558a21e0de05f30cb336f698d5a672cf307c"
assert sha(mainout / "ActualStarQuestionSupport.ilean") == "b8cb2ed95f1aac873150be248889dbbe181eae318e872e583a13d2184010741f"
root = pathlib.Path(p["companion"]); w = pathlib.Path(p["workspace"]); outroot = w / "deps/lib/lean"
assert sha(root / "lake-manifest.json") == p["lake_manifest_sha256"]
for name, pin in p["pins"].items(): assert subprocess.check_output(["git", "-C", str(root / ".lake/packages" / name), "rev-parse", "HEAD"], text=True).strip() == pin
target = outroot / "PvNP/RealizableHardness/ActualStarQuestionSupportChecks"
for ext in [".olean", ".ilean", ".olean.private", ".olean.server", ".ir.sig", ".ir"]: assert not pathlib.Path(str(target) + ext).exists()
class MS(ctypes.Structure):
    _fields_ = [("length", ctypes.c_ulong), ("load", ctypes.c_ulong)] + [(n, ctypes.c_ulonglong) for n in ["total", "available", "totalpage", "availablepage", "totalvirtual", "availablevirtual", "extended"]]
def memory():
    m = MS(); m.length = ctypes.sizeof(m); assert ctypes.windll.kernel32.GlobalMemoryStatusEx(ctypes.byref(m)); return m.available
q = 'Get-Process | Where-Object { $_.ProcessName -in @("lean","lake") } | Select-Object -ExpandProperty Id'
app_command = r'''$names=@("ms-teams","M365Copilot","PhoneExperienceHost","SearchHost","msedgewebview2","explorer","StartMenuExperienceHost","OneDrive","OneDrive.Sync.Service","Adobe Desktop Service","AdobeCollabSync","acrotray","logioptionsplus_agent","CrossDeviceService"); $stopped=@(); $errors=@(); foreach($n in $names){try{$ps=@(Get-Process -Name $n -ErrorAction SilentlyContinue); foreach($x in $ps){try{Stop-Process -Id $x.Id -Force -ErrorAction Stop; $stopped+=[pscustomobject]@{name=$x.ProcessName;id=$x.Id}}catch{$errors+=[pscustomobject]@{name=$n;error=$_.Exception.Message}}}}catch{$errors+=[pscustomobject]@{name=$n;error=$_.Exception.Message}}}; $live=@(Get-Process | Where-Object {$_.ProcessName -in $names} | Select-Object -ExpandProperty ProcessName); [pscustomobject]@{targeted=$names;stopped=$stopped;errors=$errors;live_after=$live}|ConvertTo-Json -Compress'''
try:
    app_raw = subprocess.check_output(["powershell", "-NoProfile", "-Command", app_command], text=True, stderr=subprocess.STDOUT)
    app_result = json.loads(app_raw)
except subprocess.CalledProcessError as e:
    app_raw = e.output or ""
    app_result = {"targeted": ["ms-teams", "M365Copilot", "PhoneExperienceHost", "SearchHost", "msedgewebview2", "explorer", "StartMenuExperienceHost", "OneDrive", "OneDrive.Sync.Service", "Adobe Desktop Service", "AdobeCollabSync", "acrotray", "logioptionsplus_agent", "CrossDeviceService"], "stopped": [], "errors": [{"command_exit": e.returncode, "output": app_raw}], "live_after": []}
save(B / "prelaunch-app-suspension06.json", {"command": app_command, **app_result})
pre = memory(); procs = subprocess.check_output(["powershell", "-NoProfile", "-Command", q], text=True).strip()
if pre < p["start_bytes"] or procs:
    save(B / "prelaunch-terminal06.json", {"launched": False, "reason": "below3.5GiB" if pre < p["start_bytes"] else "existing compiler/Lake process", "available": pre, "processes": procs, "target_outputs_absent": True, "source_sha256": sha(r["path"]), "runner_sha256": sha(__file__), "plan_sha256": sha(B / "plan.json")})
    raise SystemExit(2)
diag = w / "guarded-runs-question-support-checks06"; diag.mkdir(parents=True, exist_ok=False)
env = os.environ.copy(); env["LEAN_NUM_THREADS"] = "1"; env["LEAN_PATH"] = ";".join([str(outroot), str(pathlib.Path(p["lean_exe"]).parent.parent / "lib/lean")]); env.pop("LEAN_SRC_PATH", None)
d = diag / "00-PvNP.RealizableHardness.ActualStarQuestionSupportChecks"; d.mkdir(); before = sha(r["path"])
(d / "source.lean").write_bytes(pathlib.Path(r["path"]).read_bytes()); (d / "runner.py").write_bytes(pathlib.Path(__file__).read_bytes()); (d / "plan.json").write_bytes((B / "plan.json").read_bytes())
cmd = [p["lean_exe"], "-Dprofiler=true", "-Dprofiler.threshold=0", "-DstderrAsMessages=false", "-DElab.async=false", "-R", r["root"], "-o", str(target) + ".olean", "-i", str(target) + ".ilean", str(r["path"])]
low = pre; stopped = False; log = d / "raw.log"; tele = d / "telemetry.jsonl"; start = time.time()
with log.open("wb") as f, tele.open("w", encoding="utf-8") as t:
    child = subprocess.Popen(cmd, cwd=w, env=env, stdout=f, stderr=subprocess.STDOUT); print("LIVE", r["module"], child.pid, flush=True)
    while child.poll() is None:
        avail = memory(); low = min(low, avail); t.write(json.dumps({"time": time.time(), "available": avail, "pid": child.pid}) + "\n"); t.flush()
        if avail < p["stop_bytes"]: child.terminate(); stopped = True
        time.sleep(.25)
    rc = child.wait()
record = {"module": r["module"], "source_sha256": before, "command": cmd, "pre": pre, "minimum": low, "pid": child.pid, "launched": True, "exit_code": rc, "guard_stopped": stopped, "source_unchanged": sha(r["path"]) == before, "runner_sha256": sha(__file__), "plan_sha256": sha(B / "plan.json"), "log_sha256": sha(log), "telemetry_sha256": sha(tele), "diagnostic_only": True}
save(d / "terminal.json", record)
if rc != 0 or stopped or not record["source_unchanged"]: raise SystemExit(1)
print("CHECKS06 ONLY: unchanged main02 reused; actual geometric source and full theorem remain open", flush=True)
