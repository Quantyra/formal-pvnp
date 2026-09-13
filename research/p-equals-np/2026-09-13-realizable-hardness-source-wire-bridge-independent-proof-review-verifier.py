from pathlib import Path
import hashlib,json,re,subprocess
repo=Path(r"C:/Users/Dan/Desktop/Projects/formal-pvnp")
root=repo/"certifications/realizable-hardness"
base=repo/"research/p-equals-np/2026-09-13-realizable-hardness-source-wire-bridge-independent-proof-review"
hash_cache={}
def raw(path):return Path(path).read_bytes()
def digest(b):return hashlib.sha256(b).hexdigest()
def verify(path,h):
 p=Path(path);k=str(p)
 if k not in hash_cache:
  hh=hashlib.sha256()
  with p.open("rb") as f:
   for block in iter(lambda:f.read(1048576),b""):hh.update(block)
  hash_cache[k]=hh.hexdigest()
 assert hash_cache[k]==h,(str(path),"HASH_MISMATCH")
def artifact(a):
 verify(a["path"],a["sha256"]);b=raw(a["path"])
 if "raw_utf8" in a:assert b.decode("utf-8")==a["raw_utf8"],a["path"]
 return b
verify(str(base)+".json","9ae18e947698693fc92ec5fda397ab3d3b86c755545f403fbc6db75bcaefcde2")
verify(str(base)+".md","4875eba2c6bfeaff6bea62fb014db7ba411723a2c4303db53f3fe6d0c6df4bb4")
jb=raw(str(base)+".json")
d=json.loads(jb)
assert d["actual_session_id"]==52598 and d["actual_terminal_exit"]==0
assert d["final_source_freeze"]=="c0c4fbde6a70345d537bdda7c5620671205016cc"
for e in d["dependency_copies"]:
 verify(e["source"],e["sha256"]);verify(e["output"],e["sha256"])
 verify(e["receipt"],e["receipt_sha256"])
 assert "actual-source-wire-bridge-author" not in e["source"]
for e in d["dependency_receipts"]:artifact(e)
for e in d["direct_current_package_exports"]:verify(e["path"],e["sha256"])
for e in d["direct_source_pins"]:
 q=Path(e["path"]);verify(q,e["sha256"]);b=raw(q)
 if "original_source" in e:
  verify(e["original_source"],e["original_sha256"])
  assert raw(e["original_source"]).replace(b"\r\n",b"\n")==b.replace(b"\r\n",b"\n")
 parts=q.parts;idx=parts.index("packages");pkg=Path(*parts[:idx+2])
 blob=subprocess.check_output(["git","-C",str(pkg),"show","HEAD:"+q.relative_to(pkg).as_posix()])
 assert b.replace(b"\r\n",b"\n")==blob
manifest=root/"lake-manifest.json";verify(manifest,d["manifest_sha256"])
for e in json.loads(raw(manifest))["packages"]:
 h=subprocess.check_output(["git","-C",str(root/".lake/packages"/e["name"]),"rev-parse","HEAD"]).decode().strip()
 assert h==e["rev"]==d["pins"][e["name"]]
for e in d["sources"]:
 verify(e["path"],e["sha256"]);b=raw(e["path"]);a=Path(e["archive_path"])
 verify(a,e["archive_sha256"]);assert b==raw(a)==e["raw_utf8"].encode("utf-8")
 blob=subprocess.check_output(["git","show",d["final_source_freeze"]+":"+a.relative_to(repo).as_posix()],cwd=repo)
 assert b.replace(b"\r\n",b"\n")==blob and digest(blob)==e["frozen_blob_sha256"]
 assert not re.search(r"\b(sorry|admit|native_decide|axiom)\b",b.decode("utf-8"))
for key in ["authorization","runner","preparation","reviewer_preflight","accepted_pregrant_plan","pregrant_plan","granted_plan","initial_inventory","actual_runner_copies"]:artifact(d[key])
verify(d["author_packet_identity"]["path"],d["author_packet_identity"]["sha256"])
assert json.loads(artifact(d["pregrant_plan"]))["compiler_launch_authorized"] is False
assert json.loads(artifact(d["granted_plan"]))["compiler_launch_authorized"] is True
finalreceipt=d["final_author_receipt"];verify(finalreceipt["path"],finalreceipt["sha256"])
fb=subprocess.check_output(["git","show",d["final_source_freeze"]+":"+Path(finalreceipt["path"]).relative_to(repo).as_posix()],cwd=repo)
assert raw(finalreceipt["path"]).replace(b"\r\n",b"\n")==fb and digest(fb)==finalreceipt["frozen_sha256"]
for e in d["source_snapshots"]:artifact(e)
for e in d["raw_logs"]:artifact(e)
assert len(d["results"])==2
for e in d["results"]:
 assert e["exit_code"]==0 and e["source_unchanged"] and not e["guard_stopped"]
 assert e["LEAN_NUM_THREADS"]=="1" and e["memory_pre"]>=805306368 and e["memory_min"]>=671088640
 meta=json.loads(artifact(e["metadata"]))
 for k,v in meta.items():assert e[k]==v
 verify(e["log_path"],e["log_sha256"])
 out=e["command"][e["command"].index("-o")+1];verify(out,e["output_sha256"])
 assert any(x["sha256"]==e["source_sha256"] for x in d["source_snapshots"])
 assert str(root/".lake/build/lib/lean") not in e["LEAN_PATH"].split(";")
for p in d["fallback_paths_checked_absent"]:assert not Path(p).exists(),p
log=d["raw_logs"][-1]["raw_utf8"]
profiles=[{"theorem":n,"axioms":[a.strip() for a in aa.split(",") if a.strip()]} for n,aa in re.findall(r"'([^']+)' depends on axioms: \[([^\]]*)\]",log)]
profiles += [{"theorem":n,"axioms":[]} for n in re.findall(r"'([^']+)' does not depend on any axioms",log)]
assert profiles==d["profiles"] and len(profiles)==9
assert all(set(e["axioms"])<={"propext","Classical.choice","Quot.sound"} for e in profiles)
assert all("error:" not in x["raw_utf8"] for x in d["raw_logs"])
warnings=[line for x in d["raw_logs"] for line in x["raw_utf8"].splitlines() if "warning:" in line]
assert warnings==d["warnings"]==[]
checks=d["sources"][1]["raw_utf8"]
assert len(re.findall(r"^example\b",checks,re.M))==d["examples"]==6
assert checks.count("#check ")==d["signatures"]==3
assert json.loads(artifact(d["accepted_pregrant_plan"]))["compiler_launch_authorized"] is False
print(json.dumps({"verdict":"READONLY_VERIFIED","session":52598,"pair_exits":[0,0],"originals":len(d["dependency_copies"]),"unique_receipts":len(d["dependency_receipts"]),"current_exceptions":len(d["direct_current_package_exports"]),"source_pins":len(d["direct_source_pins"]),"package_pins":len(d["pins"]),"fallbacks":len(d["fallback_paths_checked_absent"]),"profiles":len(profiles),"examples":6,"signatures":3,"raw_json_sha256":digest(jb)},indent=2))
