from pathlib import Path
import json,hashlib,shutil
w=Path(__file__).parent;p=json.loads((w/'plan.json').read_text());cache={}
def sha(x):
 h=hashlib.sha256()
 with Path(x).open('rb') as f:
  for b in iter(lambda:f.read(1048576),b''):h.update(b)
 return h.hexdigest()
for e in p['dependency_original_records']:
 for key,expected in [('source',e['sha256']),('receipt',e['receipt_sha256'])]:
  path=e[key]
  if path not in cache:cache[path]=sha(path)
  assert cache[path]==expected
 dst=Path(e['output']);dst.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(e['source'],dst);assert sha(dst)==e['sha256']
for name in ['ActualFoldedParityVerifier', 'ActualFoldedParityVerifierChecks']:
 assert not list((w/'lib/lean/PvNP/RealizableHardness').glob(name+'.olean*'))
(w/'preparation.json').write_text(json.dumps(dict(records=len(p['dependency_original_records']),originals_receipts_and_copies_verified=True,target_outputs_absent=True,plan_sha256=sha(w/'plan.json'),runner_sha256=sha(w/'review-runner.py')),indent=2))
print('PREPARATION_COMPLETE',len(p['dependency_original_records']),flush=True)
