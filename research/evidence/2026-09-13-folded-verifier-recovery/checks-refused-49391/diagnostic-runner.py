import ctypes,ctypes.wintypes as wt,hashlib,json,os,pathlib,subprocess,sys,time,datetime
w=pathlib.Path(__file__).parent.resolve();root=w.parents[2];repo=root.parent.parent
cache={}
def sha(p):
 h=hashlib.sha256()
 with pathlib.Path(p).open('rb') as f:
  for b in iter(lambda:f.read(1048576),b''):h.update(b)
 return h.hexdigest()
def cached(p):
 key=str(p).lower()
 if key not in cache:cache[key]=sha(p)
 return cache[key]
def utc():return datetime.datetime.now(datetime.timezone.utc).isoformat()
def save(p,x):p.write_bytes(json.dumps(x,indent=2).encode('utf8'))
p=json.loads((w/'plan.json').read_bytes())
assert p['compiler_launch_authorized'] and p['source_equivalence_review_accepted'], 'Separate root compiler grant and packaging acceptance required'
assert p['dependency_accepted'] is False and p['diagnostic_only_dependency_use']
assert p['preparation_complete'] and not p['missing_dependencies']
assert not p['unresolved_direct_mathlib_modules']
assert sha(p['original_dependency_inventory'])==p['original_dependency_inventory_sha256']
for e in p['dependency_original_records']:
 assert cached(e['source'])==e['sha256'];assert sha(e['output'])==e['sha256'];assert cached(e['receipt'])==e['receipt_sha256']
for e in p['direct_current_package_exports']:assert cached(e['path'])==e['sha256']
for e in p['direct_source_pins']:
 f=pathlib.Path(e['path']);assert cached(f)==e['sha256']
 if 'original_source' in e:assert cached(e['original_source'])==e['original_sha256']
 parts=f.relative_to(root/'.lake/packages').parts
 blob=subprocess.check_output(['git','-C',str(root/'.lake/packages'/parts[0]),'show',p['pins'][parts[0]]+':'+pathlib.Path(*parts[1:]).as_posix()]);assert f.read_bytes().replace(b'\r\n',b'\n')==blob
for pkg,pin in p['pins'].items():assert subprocess.check_output(['git','-C',str(root/'.lake/packages'/pkg),'rev-parse','HEAD']).decode().strip()==pin
assert sha(root/'lake-manifest.json')==p['manifest_sha256']
for f in p['fallback_paths_checked_absent']:assert not pathlib.Path(f).exists()
for s in p['sources']+[p['reused_verifier_source']]:
 assert sha(s['path'])==s['sha256'];a=pathlib.Path(s['archive_path']);assert sha(a)==s['archive_sha256']
 assert a.read_bytes().replace(b'\r\n',b'\n')==subprocess.check_output(['git','show',p['draft_freeze']+':'+a.relative_to(repo).as_posix()],cwd=repo)
 # Future isolated proof repairs may differ from archived source only with explicit per-source root repair authorization.
 assert s['diagnostic_only'] and s['original_uninstrumented']
 if 'root_repair_authorized' in s:
  assert sha(s['prior_source_path'])==s['prior_source_sha256'] and sha(s['prior_patch_path'])==s['prior_patch_sha256']
  assert sha(s['earlier_repair']['source_path'])==s['earlier_repair']['source_sha256'] and sha(s['earlier_repair']['patch_path'])==s['earlier_repair']['patch_sha256']
  assert sha(s['intermediate_repair']['source_path'])==s['intermediate_repair']['source_sha256'] and sha(s['intermediate_repair']['patch_path'])==s['intermediate_repair']['patch_sha256']
  assert sha(s['products2_repair']['source_path'])==s['products2_repair']['source_sha256'] and sha(s['products2_repair']['patch_path'])==s['products2_repair']['patch_sha256']
  assert sha(s['products3_repair']['source_path'])==s['products3_repair']['source_sha256'] and sha(s['products3_repair']['patch_path'])==s['products3_repair']['patch_sha256']
  assert sha(s['localproof_repair']['source_path'])==s['localproof_repair']['source_sha256'] and sha(s['localproof_repair']['patch_path'])==s['localproof_repair']['patch_sha256']
  assert s['root_repair_authorized'] and sha(s['repair_original_path'])==s['repair_original_sha256']
  assert pathlib.Path(s['repair_original_path']).read_bytes()==a.read_bytes() and sha(s['repair_patch_path'])==s['repair_patch_sha256']
 else:
  assert sha(s['checks_prior_source'])==s['checks_prior_sha256'] and sha(s['checks_prior_patch'])==s['checks_prior_patch_sha256']
  assert s['checks_repair_authorized'] and sha(s['checks_original_path'])==s['checks_original_sha256']
  assert pathlib.Path(s['checks_original_path']).read_bytes()==a.read_bytes() and sha(s['checks_patch_path'])==s['checks_patch_sha256']

lean=pathlib.Path(r'C:/Users/Dan/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/bin/lean.exe')
version=subprocess.check_output([str(lean),'--version']).decode().strip();assert '6a10ac8c22beadecabdbb0919c2b50214762f91d' in version
class MS(ctypes.Structure):
 _fields_=[('length',wt.DWORD),('load',wt.DWORD)]+[(x,ctypes.c_ulonglong) for x in ['total','avail','totalpage','availpage','totalvirtual','availvirtual','extended']]
def memory():
 m=MS();m.length=ctypes.sizeof(m);assert ctypes.windll.kernel32.GlobalMemoryStatusEx(ctypes.byref(m));return m.avail
class PMC(ctypes.Structure):
 _fields_=[('cb',wt.DWORD),('PageFaultCount',wt.DWORD)]+[(n,ctypes.c_size_t) for n in ['PeakWorkingSetSize','WorkingSetSize','QuotaPeakPagedPoolUsage','QuotaPagedPoolUsage','QuotaPeakNonPagedPoolUsage','QuotaNonPagedPoolUsage','PagefileUsage','PeakPagefileUsage','PrivateUsage']]
kernel=ctypes.windll.kernel32;psapi=ctypes.windll.psapi
kernel.OpenProcess.argtypes=[wt.DWORD,wt.BOOL,wt.DWORD];kernel.OpenProcess.restype=wt.HANDLE
kernel.CloseHandle.argtypes=[wt.HANDLE];kernel.CloseHandle.restype=wt.BOOL
psapi.GetProcessMemoryInfo.argtypes=[wt.HANDLE,ctypes.POINTER(PMC),wt.DWORD];psapi.GetProcessMemoryInfo.restype=wt.BOOL
def process_memory(handle):
 m=PMC();m.cb=ctypes.sizeof(m)
 if not handle or not psapi.GetProcessMemoryInfo(handle,ctypes.byref(m),m.cb):return {'available':False}
 return dict(available=True,working_set_bytes=m.WorkingSetSize,peak_working_set_bytes=m.PeakWorkingSetSize,private_usage_bytes=m.PrivateUsage)
env=os.environ.copy();env['LEAN_NUM_THREADS']='1';env['LEAN_PATH']=';'.join([str(w/'lib/lean')]+[str(root/'.lake/packages'/n/'.lake/build/lib/lean') for n in p['pins']]+[str(lean.parent.parent/'lib/lean')])
assert p['start_memory_bytes']==3758096384 and p['stop_memory_bytes']==671088640 and p['threads']==1
assert [s['module'] for s in p['sources']]==['ActualFoldedParityVerifierChecks']
assert not subprocess.check_output(['powershell','-NoProfile','-Command',"Get-CimInstance Win32_Process -Filter \"Name='lean.exe'\" | Select-Object -ExpandProperty ProcessId"]).strip(), 'Another Lean process exists'
diag=w/'diagnostics';diag.mkdir(exist_ok=True);assert not list(diag.glob('*.json')), 'No automatic diagnostic retry';prior=[]
base=dict(inventory=p['original_dependency_inventory_sha256'],manifest=p['manifest_sha256'],pins=p['pins'],current=p['direct_current_package_exports'],source_pins=p['direct_source_pins'],runner_sha256=sha(__file__),version=version)
for index,s in enumerate(p['sources']):
 source=pathlib.Path(s['path']);name=s['module'];out=w/'lib/lean/PvNP/RealizableHardness'/(name+'.olean')
 fingerprint=hashlib.sha256(json.dumps(dict(base=base,sources=[(x['module'],x['sha256']) for x in p['sources'][:index+1]],prior_outputs=prior),sort_keys=True).encode()).hexdigest()
 assert not out.exists(), 'Fresh diagnostic output required; no automatic reuse/retry'
 stamp=str(time.time_ns());log=diag/(name+'-'+stamp+'.log');meta=log.with_suffix('.json');telemetry=log.with_suffix('.jsonl');snapshot=diag/(name+'-source-'+s['sha256']+'.lean');snapshot.write_bytes(source.read_bytes())
 cmd=[str(lean),'-Dprofiler=true','-Dprofiler.threshold=0','-DstderrAsMessages=false','-DElab.async=false','-R','lean','-o',str(out),str(source)]
 with log.open('wb') as f,telemetry.open('w',encoding='utf8',newline='\n') as tf:
  started=utc();t0=time.monotonic();pre=memory()
  if pre<3758096384:
   save(meta,dict(exit_code=None,launched=False,reason='below_3.5GiB_start_threshold',memory_pre=pre,start_utc=started,source_sha256=s['sha256'],fingerprint=fingerprint));print('NO_CHILD_LOW_CAPACITY',pre,flush=True);sys.exit(2)
  proc=subprocess.Popen(cmd,cwd=w,env=env,stdout=f,stderr=subprocess.STDOUT)
  handle=kernel.OpenProcess(0x410,False,proc.pid);low=pre;stopped=False;maxws=0;maxprivate=0;samples=0;lastbytes=0
  print('LIVE',name,proc.pid,str(log),flush=True)
  try:
   while proc.poll() is None:
    avail=memory();pm=process_memory(handle);samples+=1;low=min(low,avail);maxws=max(maxws,pm.get('working_set_bytes',0));maxprivate=max(maxprivate,pm.get('private_usage_bytes',0))
    logbytes=log.stat().st_size
    tf.write(json.dumps(dict(utc=utc(),elapsed_seconds=time.monotonic()-t0,pid=proc.pid,global_available_bytes=avail,process=pm,log_bytes=logbytes,new_log_bytes=logbytes-lastbytes))+'\n');tf.flush();lastbytes=logbytes
    if avail<671088640:proc.terminate();stopped=True
    time.sleep(.25)
   rc=proc.wait()
  finally:
   if handle:kernel.CloseHandle(handle)
 ended=utc();r=dict(exit_code=rc,launched=True,pid=proc.pid,command=cmd,cwd=str(w),source_sha256=s['sha256'],source_unchanged=sha(source)==s['sha256'],snapshot_path=str(snapshot),memory_pre=pre,memory_min=low,guard_stopped=stopped,start_utc=started,end_utc=ended,elapsed_seconds=time.monotonic()-t0,working_set_sample_max=maxws,private_usage_sample_max=maxprivate,telemetry_samples=samples,telemetry_path=str(telemetry),telemetry_sha256=sha(telemetry),log_path=str(log),log_sha256=sha(log),output_sha256=sha(out) if rc==0 else None,fingerprint=fingerprint,version=version,pins=p['pins'],manifest_sha256=p['manifest_sha256'],LEAN_PATH=env['LEAN_PATH'],LEAN_NUM_THREADS='1',memory_boundary='global available bytes guard; process working set/private usage are separately sampled, not substituted for guard',diagnostic_only=True,export_not_proof_evidence=True,diagnostic_cli_flags=['-Dprofiler=true','-Dprofiler.threshold=0','-DstderrAsMessages=false','-DElab.async=false'])
 save(meta,r);print('ACTUAL_EXIT',rc,'METADATA',str(meta),flush=True)
 if rc or not r['source_unchanged']:sys.exit(rc or 99)
 prior.append((name,r['output_sha256']))
