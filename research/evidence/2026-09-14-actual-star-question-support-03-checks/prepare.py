import pathlib, json, hashlib, os, ast
B = pathlib.Path(__file__).parent.resolve()
R = B.parents[2]
OLD = R / 'research/evidence/2026-09-14-actual-star-question-support-02-diagnostic'
def sha(p):
    h = hashlib.sha256()
    with pathlib.Path(p).open('rb') as f:
        for c in iter(lambda: f.read(1048576), b''): h.update(c)
    return h.hexdigest()
def save(p, x):
    assert not p.exists(), str(p)
    p.write_text(json.dumps(x, indent=2), encoding='utf-8')
p = json.loads((OLD/'plan.json').read_bytes())
oldw = pathlib.Path(p['workspace'])
w = pathlib.Path(p['companion'])/'.lake/build/actual-star-question-support-checks03-20260914'
assert not w.exists(), 'Do not overwrite an existing preparation'
w.mkdir(parents=True)
out = w/'deps/lib/lean'
oldout = oldw/'deps/lib/lean'
inv = json.loads((OLD/'isolated-copy-inventory.json').read_bytes())
assert sha(OLD/'isolated-copy-inventory.json') == p['copies_sha256']
records = []
for r in inv['copies']:
    src = pathlib.Path(r['path'])
    rel = src.relative_to(oldout)
    assert 'ActualStarQuestionSupport' not in str(rel)
    assert sha(src) == r['sha256'], str(src)
    dst = out/rel
    dst.parent.mkdir(parents=True, exist_ok=True)
    os.link(src, dst)
    assert sha(dst) == r['sha256']
    records.append({**r, 'path':str(dst), 'attempt02_path':str(src), 'copy_method':'hardlink; imported read-only'})
main = p['sources'][0]
assert sha(main['path']) == 'd61e78cc98be9bff83e9f779b950dfed48aa8fa629efde5f6fd147e97442b8a5'
terminal = oldw/'guarded-runs-question-support-02/00-PvNP.RealizableHardness.ActualStarQuestionSupport/terminal.json'
t = json.loads(terminal.read_bytes())
assert t['exit_code'] == 0 and not t['guard_stopped'] and t['source_unchanged']
expected = {'.olean':'7b725fa38638b7c39d63dce1f83b558a21e0de05f30cb336f698d5a672cf307c', '.ilean':'b8cb2ed95f1aac873150be248889dbbe181eae318e872e583a13d2184010741f'}
for ext,h in expected.items():
    src = oldout/('PvNP/RealizableHardness/ActualStarQuestionSupport'+ext)
    assert sha(src)==h
    dst=out/src.relative_to(oldout);dst.parent.mkdir(parents=True,exist_ok=True);os.link(src,dst)
    assert sha(dst)==h
    records.append({'path':str(dst),'attempt02_path':str(src),'sha256':h,'bytes':src.stat().st_size,'copy_method':'hardlink; accepted main02 imported read-only'})
checks = pathlib.Path(p['companion'])/'lean/PvNP/RealizableHardness/ActualStarQuestionSupportChecks.lean'
assert sha(checks)=='2bfe2ebd856cbb3d4f38cb37dabe8d241509bc0586ebc279a656176f5d25ebd8'
source = B/'source/PvNP/RealizableHardness/ActualStarQuestionSupportChecks.lean'
source.parent.mkdir(parents=True,exist_ok=True);source.write_bytes(checks.read_bytes())
assert not list(out.glob('PvNP/RealizableHardness/ActualStarQuestionSupportChecks.*'))
save(B/'isolated-copy-inventory.json', {'copies':records,'prior_inventory':str(OLD/'isolated-copy-inventory.json'),'prior_inventory_sha256':p['copies_sha256'],'main_terminal':str(terminal),'main_terminal_sha256':sha(terminal),'main_source':main})
p.update(compiler_authorized=False,workspace=str(w),sources=[{'module':'PvNP.RealizableHardness.ActualStarQuestionSupportChecks','sha256':sha(source),'path':str(source),'root':str(B/'source')}],copies_sha256=sha(B/'isolated-copy-inventory.json'),root_clearance='NOT GRANTED: preparation only',task_status='Checks only; reuse unchanged successful main02',main02_source=main,main02_terminal=str(terminal),main02_terminal_sha256=sha(terminal))
p.pop('partial')
save(B/'plan.json',p)
save(B/'pregrant-plan.json',p)
s=(OLD/'runner.py').read_text(encoding='utf-8')
s=s.replace("p['sources']+[p['partial']]", "p['sources']")
s=s.replace("=='PvNP.RealizableHardness.ActualStarQuestionSupport'", "=='PvNP.RealizableHardness.ActualStarQuestionSupportChecks'")
s=s.replace("=='d61e78cc98be9bff83e9f779b950dfed48aa8fa629efde5f6fd147e97442b8a5'", "=='2bfe2ebd856cbb3d4f38cb37dabe8d241509bc0586ebc279a656176f5d25ebd8'")
s='\n'.join(l for l in s.splitlines() if not l.startswith("assert p['partial']["))+'\n'
s=s.replace("for r in p['sources']:assert sha(r['path'])==r['sha256']", "for r in p['sources']:assert sha(r['path'])==r['sha256']\nassert sha(p['main02_source']['path'])==p['main02_source']['sha256']\nassert sha(p['main02_terminal'])==p['main02_terminal_sha256']")
s=s.replace("['.olean','.olean.private','.olean.server','.ir.sig','.ir']", "['.olean','.ilean','.olean.private','.olean.server','.ir.sig','.ir']")
s=s.replace('guarded-runs-question-support-02','guarded-runs-question-support-checks03')
s=s.replace('AUTHOR PAIR ONLY: actual geometric source and full theorem remain open','CHECKS03 ONLY: unchanged main02 reused; actual geometric source and full theorem remain open')
assert "p['partial']" not in s
ast.parse(s)
(B/'runner.py').write_text(s,encoding='utf-8',newline='\n')
save(B/'preparation.json',{'compiler_launched':False,'copies':len(records),'runner_sha256':sha(B/'runner.py'),'plan_sha256':sha(B/'plan.json'),'inventory_sha256':sha(B/'isolated-copy-inventory.json'),'prior_runner_sha256':sha(OLD/'runner.py'),'checks_target_absent':True,'main02_source_verified':True,'source_sha256':sha(source),'hardlinks_readonly_import_policy':True})
print(json.dumps(json.loads((B/'preparation.json').read_bytes())),flush=True)
