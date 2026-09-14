import pathlib,json,hashlib,subprocess,os,ctypes,time,sys

w=pathlib.Path(__file__).parent.resolve(); root=w.parents[2]

def sha(p):return hashlib.sha256(pathlib.Path(p).read_bytes()).hexdigest()

def save(p,x):p.write_text(json.dumps(x,indent=2),encoding='utf-8')

class MS(ctypes.Structure):

 _fields_=[('length',ctypes.c_ulong),('load',ctypes.c_ulong)]+[(x,ctypes.c_ulonglong) for x in ['total','avail','totalpage','availpage','totalvirtual','availvirtual','extended']]

def mem():

 m=MS();m.length=ctypes.sizeof(m);assert ctypes.windll.kernel32.GlobalMemoryStatusEx(ctypes.byref(m));return m.avail

p=json.loads((w/'plan.json').read_bytes());assert p['compiler_authorized'] and p['diagnostic_only']

assert sha(w/'current-closure.json')==p['closure_sha256'];c=json.loads((w/'current-closure.json').read_bytes());assert not c['missing']

for r in c['modules']:

 assert sha(r['source'])==r['source_sha256']

 for o in r['outputs']:assert sha(o['path'])==o['sha256']

for n,pin in c['pins'].items():assert subprocess.check_output(['git','-C',str(root/'.lake/packages'/n),'rev-parse','HEAD']).decode().strip()==pin

assert sha(root/'lake-manifest.json')==p['lake_manifest_sha256']

assert not subprocess.check_output(['powershell','-NoProfile','-Command','Get-Process | Where-Object ProcessName -eq lean | Select-Object -ExpandProperty Id']).strip()

lean=pathlib.Path(r'C:/Users/Dan/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/bin/lean.exe')

version=subprocess.check_output([str(lean),'--version']).decode().strip();assert '6a10ac8' in version

outroot=w/'lib/lean';(outroot/'PvNP/RealizableHardness').mkdir(parents=True,exist_ok=True)

env=os.environ.copy();env['LEAN_NUM_THREADS']='1';env['LEAN_PATH']=';'.join([str(outroot)]+[str(root/'.lake/packages'/n/'.lake/build/lib/lean') for n in c['pins']]+[str(lean.parent.parent/'lib/lean')])

for name in p['modules']:

 source=root/'lean/PvNP/RealizableHardness'/(name+'.lean'); assert sha(source)==p['source_hashes'][name]; stamp=str(time.time_ns());d=w/stamp;d.mkdir()

 save(d/'plan.json',p); (d/'runner.py').write_bytes(pathlib.Path(__file__).read_bytes()); src=d/(name+'.lean');src.write_bytes(source.read_bytes());before=sha(src);out=outroot/'PvNP/RealizableHardness'/(name+'.olean')

 if out.exists():assert p.get('reuse_green_main') and name!='StarListDecoding';raise AssertionError('Output exists; explicit scope required')

 pre=mem();assert pre>=3758096384,('below3.5GiB',pre)

 cmd=[str(lean),'-Dprofiler=true','-Dprofiler.threshold=0','-DstderrAsMessages=false','-DElab.async=false','-R',str(root/'lean'),'-o',str(out),str(source)]

 log=d/'raw.log';tele=d/'telemetry.jsonl';start=time.time();low=pre;stop=False

 with log.open('wb') as f,tele.open('w',encoding='utf-8') as t:

  child=subprocess.Popen(cmd,cwd=root,env=env,stdout=f,stderr=subprocess.STDOUT)

  print('LIVE',name,child.pid,str(d),flush=True)

  while child.poll() is None:

   a=mem();low=min(low,a);t.write(json.dumps({'time':time.time(),'available':a,'pid':child.pid})+'\n');t.flush()

   if a<671088640:child.terminate();stop=True

   time.sleep(.25)

  rc=child.wait()

 record={'module':name,'exit_code':rc,'pid':child.pid,'guard_stopped':stop,'pre':pre,'minimum':low,'source_sha256':before,'source_unchanged':sha(source)==before,'snapshot':str(src),'log':str(log),'log_sha256':sha(log),'telemetry_sha256':sha(tele),'output_sha256':sha(out) if rc==0 else None,'command':cmd,'elapsed':time.time()-start,'version':version,'lean_binary_sha256':sha(lean),'closure_sha256':p['closure_sha256'],'runner_sha256':sha(__file__),'plan_sha256':sha(w/'plan.json'),'diagnostic_only':True,'new_closure_independently_accepted':False,'LEAN_PATH':env['LEAN_PATH']}

 save(d/'terminal.json',record);print('TERMINAL',name,rc,str(d/'terminal.json'),flush=True)

 if rc!=0:sys.exit(rc if rc>0 else 1)

