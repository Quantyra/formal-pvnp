import hashlib,json,pathlib,re
R=pathlib.Path('C:/Users/Dan/Desktop/Projects/formal-pvnp')
C=R/'certifications/realizable-hardness'
W=C/'.lake/build/expander-cut-independent-review-20260913'
P=R/'research/p-equals-np/2026-09-13-realizable-hardness-expander-independent-proof-review.json'
sha=lambda p:hashlib.sha256(pathlib.Path(p).read_bytes()).hexdigest()
j=json.loads(P.read_bytes())
j['runner']['text_normalization']='LF normalized; SHA256 hashes raw file'
assert pathlib.Path(j['runner']['path']).read_text(encoding='utf-8') == j['runner']['raw_utf8']
assert sha(j['runner']['path']) == j['runner']['sha256']
records=[]
profiles=[]
for p in sorted((W/'diagnostics').glob('*.json')):
    r=json.loads(p.read_bytes())
    assert r['exit_code']==0 and r['source_unchanged'] and not r['guard_stopped']
    assert sha(r['log_path'])==r['log_sha256']
    assert sha(r['command'][-1])==r['source_sha256']
    assert sha(r['command'][-2])==r['output_sha256']
    raw=pathlib.Path(r['log_path']).read_text(encoding='utf-8')
    found=re.findall(r"'([^']+)' depends on axioms: \[([^\]]*)\]",raw)
    for name,axioms in found:
        vals=[v.strip() for v in axioms.split(',') if v.strip()]
        assert set(vals)<={'propext','Classical.choice','Quot.sound'},(name,vals)
        profiles.append({'name':name,'axioms':vals})
    r.update({'metadata_path':str(p),'metadata_sha256':sha(p),'raw_log_utf8':raw,'text_normalization':'LF normalized; SHA256 hashes raw file'})
    records.append(r)
assert len(records)==4 and len(profiles)==19,(len(records),len(profiles))
assert all(sha(a['source'])==a['sha256']==sha(a['copy']) for a in j['dependency_copies'])
examples=sum(len(re.findall(r'^example\b',pathlib.Path(s['path']).read_text(encoding='utf-8'),re.M)) for s in j['sources'])
assert examples==15
j.update({'status':'GO-WITH-NOTES: independent four-module build and proof-adversarial review complete; bounded component only','session_id':50193,'build_results':records,'profiles':profiles,'examples':examples,'dependency_prelaunch_and_postlaunch_rehash':True,'compiler_released':True})
P.write_text(json.dumps(j,indent=2),encoding='utf-8')
M=P.with_suffix('.md')
s=M.read_text(encoding='utf-8')
s=s.replace('**INCOMPLETE pending independent compilation.** Source review found no HIGH mathematical or hidden-assumption blocker. This is not independent kernel acceptance. Matrix author owns the compiler slot; no compiler was launched in this preparation.','**GO-WITH-NOTES for this bounded component.** Source review found no HIGH mathematical or hidden-assumption blocker. After the exclusive compiler grant, independent session 50193 compiled all four frozen targets successfully. This is not certification of the full paper theorem.')
s=s.replace('No run results exist yet. Expected source checks are nineteen axiom-profile queries and fifteen examples. They must actually compile and their emitted profiles must be inspected before changing this verdict.','Independent session 50193 returned four actual exit-zero results. All nineteen emitted profiles are subsets of propext, Classical.choice and Quot.sound; fifteen examples compiled. Sources remained unchanged; raw logs, output hashes, memory records, exact package revisions and metadata hashes are embedded in the JSON. All 299 original/copied dependency pairs were rehashed immediately before launch and again after completion. No RAM guard termination occurred. Compiler ownership was released after the terminal result. The build is fresh for these four modules and reuses pinned upstream artifacts; it is not a fresh rebuild of all upstream dependencies.')
M.write_text(s,encoding='utf-8')
print(json.dumps({'json_sha256':sha(P),'markdown_sha256':sha(M),'profiles':len(profiles),'examples':examples,'exits':[r['exit_code'] for r in records]}))
