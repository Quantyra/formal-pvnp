from pathlib import Path
import json,hashlib,re
w=Path(__file__).parent;p=json.loads((w/'plan.json').read_text())
def sha(x):return hashlib.sha256(Path(x).read_bytes()).hexdigest()
records=[]
for s in p['sources']:
 ms=list((w/'diagnostics').glob(s['module']+'-[0-9]*.json'))
 if not ms:records.append(dict(module=s['module'],not_launched=True));continue
 assert len(ms)==1
 mp=ms[0];m=json.loads(mp.read_text());log=Path(m['log_path']);ls=log.read_text(encoding='utf-8');profs=re.findall(r"'([^']+)' depends on axioms:\s*\[([^\]]*)\]",ls)
 errors=[l for l in ls.splitlines() if 'error:' in l or 'error(' in l];warnings=[l for l in ls.splitlines() if ': warning:' in l]
 assert sha(s['path'])==s['sha256']==sha(m['snapshot_path'])
 assert sha(log)==m['log_sha256'];assert sha(m['telemetry_path'])==m['telemetry_sha256']
 if m['exit_code']==0:assert sha(w/'lib/lean/PvNP/RealizableHardness'/(s['module']+'.olean'))==m['output_sha256']
 records.append(dict(module=s['module'],source_sha256=s['sha256'],metadata_path=str(mp),metadata_sha256=sha(mp),exit_code=m['exit_code'],command=m['command'],guard_stopped=m['guard_stopped'],errors=errors,warnings=warnings,profiles=[dict(name=n,axioms=re.findall(r'[A-Za-z_.]+',a)) for n,a in profs],log_sha256=m['log_sha256'],telemetry_sha256=m['telemetry_sha256'],snapshot_sha256=sha(m['snapshot_path']),output_sha256=m['output_sha256']))
checks=Path(p['sources'][-1]['path']).read_text(encoding='utf-8');requested=re.findall(r'#print axioms (\w+)',checks)
result=dict(session=23366,prior_contributor_execution=True,independent_of_author_target_outputs=True,root_acceptance_pending=True,plan_sha256=sha(w/'plan.json'),runner_sha256=sha(w/'review-runner.py'),preparation_sha256=sha(w/'preparation.json'),records=records,expected_profiles=requested,examples=len(re.findall(r'(?m)^example',checks)),signatures=len(re.findall(r'(?m)^#check',checks)))
result['all_five_exit_zero']=all(x.get('exit_code')==0 for x in records)
last=records[-1];result['profiles_exact']=sorted(requested)==sorted(x['name'].split('.')[-1] for x in last.get('profiles',[]));result['profiles_allowed']=all(set(x['axioms'])<={'propext','Classical.choice','Quot.sound'} for x in last.get('profiles',[]))
(w/'verification-summary.json').write_bytes(json.dumps(result,indent=2).encode())
print(json.dumps(dict(all_five_exit_zero=result['all_five_exit_zero'],profiles_exact=result['profiles_exact'],profiles_allowed=result['profiles_allowed'],examples=result['examples'],signatures=result['signatures'],summary_sha256=sha(w/'verification-summary.json'))))
