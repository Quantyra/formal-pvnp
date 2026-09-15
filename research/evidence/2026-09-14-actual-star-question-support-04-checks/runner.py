import pathlib,json,hashlib,subprocess,ctypes,os,time,sys
B=pathlib.Path(__file__).parent.resolve()
def sha(p):
 h=hashlib.sha256()
 with pathlib.Path(p).open('rb') as f:
  for chunk in iter(lambda:f.read(1048576),b''):h.update(chunk)
 return h.hexdigest()
def save(p,x):p.write_text(json.dumps(x,indent=2),encoding='utf-8')
p=json.loads((B/'plan.json').read_bytes())
assert p['compiler_authorized'] is True, 'DISABLED: fresh explicit root clearance required; no child launched'
assert len(sys.argv)==1,'This runner accepts no alternate command or target'
assert len(p['sources'])==1 and p['sources'][0]['module']=='PvNP.RealizableHardness.ActualStarQuestionSupportChecks'
assert p['sources'][0]['sha256']=='2bfe2ebd856cbb3d4f38cb37dabe8d241509bc0586ebc279a656176f5d25ebd8'
assert p['partial_only'] and p['reconstruction_is_new_current_provenance'] and p['do_not_run_lake']
assert p['threads']==1 and p['start_bytes']==3758096384 and p['stop_bytes']==671088640
assert sha(B/'isolated-copy-inventory.json')==p['copies_sha256']
for r in json.loads((B/'isolated-copy-inventory.json').read_bytes())['copies']:assert sha(r['path'])==r['sha256']
for r in p['sources']:assert sha(r['path'])==r['sha256']
assert sha(p['main02_source']['path'])==p['main02_source']['sha256']
assert sha(p['main02_terminal'])==p['main02_terminal_sha256']
assert sha(p['lean_exe'])==p['lean_sha256']
root=pathlib.Path(p['companion']);w=pathlib.Path(p['workspace']);assert sha(root/'lake-manifest.json')==p['lake_manifest_sha256']
for name,pin in p['pins'].items():assert subprocess.check_output(['git','-C',str(root/'.lake/packages'/name),'rev-parse','HEAD']).decode().strip()==pin
assert not subprocess.check_output(['powershell','-NoProfile','-Command','Get-Process | Where-Object { $_.ProcessName -in @("lean","lake") } | Select-Object -ExpandProperty Id']).strip(), 'Existing compiler/Lake process; stop'
class MS(ctypes.Structure):
 _fields_=[('length',ctypes.c_ulong),('load',ctypes.c_ulong)]+[(n,ctypes.c_ulonglong) for n in ['total','available','totalpage','availablepage','totalvirtual','availablevirtual','extended']]
def memory():
 m=MS();m.length=ctypes.sizeof(m);assert ctypes.windll.kernel32.GlobalMemoryStatusEx(ctypes.byref(m));return m.available
outroot=w/'deps/lib/lean';outroot.mkdir(parents=True,exist_ok=True)
for r in p['sources']:
 rel=pathlib.Path(*r['module'].split('.'))
 for ext in ['.olean','.ilean','.olean.private','.olean.server','.ir.sig','.ir']:
  assert not pathlib.Path(str(outroot/rel)+ext).exists(), 'No automatic retry or overwrite; preserve prior outputs and get a new reviewed plan'
env=os.environ.copy();env['LEAN_NUM_THREADS']='1';env['LEAN_PATH']=';'.join([str(outroot),str(pathlib.Path(p['lean_exe']).parent.parent/'lib/lean')]);env.pop('LEAN_SRC_PATH',None)
diag=w/'guarded-runs-question-support-checks04';diag.mkdir(exist_ok=True);assert not list(diag.iterdir()), 'A prior attempt exists; no automatic restart'
for index,r in enumerate(p['sources']):
 name=r['module'];d=diag/(str(index).zfill(2)+'-'+name);d.mkdir();source=pathlib.Path(r['path']);before=sha(source);(d/'source.lean').write_bytes(source.read_bytes());(d/'runner.py').write_bytes(pathlib.Path(__file__).read_bytes());(d/'plan.json').write_bytes((B/'plan.json').read_bytes())
 out=outroot/pathlib.Path(*name.split('.'));out.parent.mkdir(parents=True,exist_ok=True)
 flags=['-Dprofiler=true','-Dprofiler.threshold=0','-DstderrAsMessages=false','-DElab.async=false']
 if r.get('package')=='mathlib':flags+=['-DautoImplicit=false','-DmaxSynthPendingDepth=3','-Dpp.unicode.fun=true']
 elif r.get('package')=='aesop':flags+=['-Dlinter.unusedVariables=false']
 elif r.get('package')=='batteries':flags+=['-Dlinter.missingDocs=true']
 cmd=[p['lean_exe']]+flags+['-R',r['root'],'-o',str(out)+'.olean','-i',str(out)+'.ilean',str(source)]
 pre=memory();meta={'module':name,'source_sha256':before,'command':cmd,'partial_only':True,'old_acceptance_transferred':False,'pre':pre,'LEAN_PATH':env['LEAN_PATH'],'closure_inventory_sha256':p['copies_sha256'],'runner_sha256':sha(__file__),'plan_sha256':sha(B/'plan.json')}
 if pre<p['start_bytes']:
  save(d/'terminal.json',{**meta,'launched':False,'reason':'below3.5GiB','exit_code':None});raise SystemExit(2)
 low=pre;stopped=False;log=d/'raw.log';tele=d/'telemetry.jsonl';start=time.time()
 with log.open('wb') as f,tele.open('w',encoding='utf-8') as t:
  child=subprocess.Popen(cmd,cwd=w,env=env,stdout=f,stderr=subprocess.STDOUT);print('LIVE',name,child.pid,flush=True)
  while child.poll() is None:
   avail=memory();low=min(low,avail);t.write(json.dumps({'time':time.time(),'available':avail,'pid':child.pid})+'\n');t.flush()
   if avail<p['stop_bytes']:child.terminate();stopped=True
   time.sleep(.25)
  rc=child.wait()
 outputs=[{'path':str(f),'sha256':sha(f),'bytes':f.stat().st_size} for f in out.parent.glob(out.name+'.*') if f.is_file()]
 required=['.olean']
 complete=all(pathlib.Path(str(out)+ext).exists() for ext in required)
 record={**meta,'launched':True,'pid':child.pid,'exit_code':rc,'guard_stopped':stopped,'minimum':low,'elapsed':time.time()-start,'source_unchanged':sha(source)==before,'outputs':outputs,'required_outputs_complete':complete,'log_sha256':sha(log),'telemetry_sha256':sha(tele),'diagnostic_only':True}
 save(d/'terminal.json',record);print('TERMINAL',name,rc,'complete',complete,flush=True)
 if rc!=0 or stopped or not complete or not record['source_unchanged']:raise SystemExit(1)
print('CHECKS04 ONLY: unchanged main02 reused; actual geometric source and full theorem remain open',flush=True)
