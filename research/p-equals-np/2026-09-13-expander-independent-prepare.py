import hashlib, json, pathlib, shutil, subprocess
R = pathlib.Path('C:/Users/Dan/Desktop/Projects/formal-pvnp')
C = R/'certifications/realizable-hardness'
A = C/'.lake/build/expander-cut-author-20260912'
W = C/'.lake/build/expander-cut-independent-review-20260913'
W.mkdir(parents=True, exist_ok=True)
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
freeze = '3be6295e08492c766c42406714244e40fa1703e7'
author = json.loads((A/'author-verification.json').read_bytes())
sources = []
for item in author['sources']:
    p = pathlib.Path(item['source'])
    frozen = subprocess.check_output(['git','-C',str(R),'show',freeze+':'+p.relative_to(R).as_posix()])
    assert sha(p) == item['sha256'] == hashlib.sha256(frozen).hexdigest()
    sources.append({'name':item['name'],'path':str(p),'sha256':sha(p)})
deps = json.loads((A/'dependency-provenance.json').read_bytes())
copies = []
for m in deps['modules']:
    assert sha(pathlib.Path(m['source'])) == m['source_sha256']
    for a in m['artifacts']:
        origin = pathlib.Path(a['source'])
        assert sha(origin) == a['sha256'] == sha(pathlib.Path(a['copy']))
        target = W/'lib/lean'/pathlib.Path(a['copy']).relative_to(A/'lib/lean')
        target.parent.mkdir(parents=True,exist_ok=True)
        assert not target.exists(), str(target)
        shutil.copyfile(origin,target)
        assert sha(target) == a['sha256']
        copies.append({'source':str(origin),'copy':str(target),'sha256':sha(target)})
(W/'lib/lean/PvNP/RealizableHardness').mkdir(parents=True,exist_ok=True)
runner = (A/'author-runner.py').read_text(encoding='utf-8').replace('expander-cut-author-20260912','expander-cut-independent-review-20260913')
check = '\nexpected = '+repr({x['name']:x['sha256'] for x in sources})+'\n'
runner = runner.replace('for name in sys.argv[1:]',check+'for name in sys.argv[1:]')
runner = runner.replace('before=sha(source)','before=sha(source)\n    assert before == expected[name]\n    assert not out.exists(), str(out)')
rp = W/'independent-runner.py'
rp.write_text(runner,encoding='utf-8')
compile(runner,str(rp),'exec')
plan = {'status':'INCOMPLETE: source review performed; independent compiler not launched; awaiting exclusive grant','freeze':freeze,'sources':sources,'dependency_modules':len(deps['modules']),'dependency_copies':copies,'runner':{'path':str(rp),'sha256':sha(rp),'raw_utf8':runner,'text_normalization':'LF normalized; SHA256 hashes raw file'},'author_verification_sha256':sha(A/'author-verification.json'),'manifest_sha256':sha(C/'lake-manifest.json'),'build_results':[],'scope':'Four targets only; reused pinned upstream artifacts, not a fresh upstream build. No full hardness, FP or novelty certification.'}
out = R/'research/p-equals-np/2026-09-13-realizable-hardness-expander-independent-proof-review.json'
out.write_text(json.dumps(plan,indent=2),encoding='utf-8')
print(json.dumps({'plan':str(out),'sha256':sha(out),'copies':len(copies),'runner_sha256':sha(rp)}))
