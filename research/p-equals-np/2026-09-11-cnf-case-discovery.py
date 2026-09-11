"""S3059 ordinary-CNF exhaustive case-group discovery; no family annotations enter discover()."""
import hashlib,importlib.util,itertools,json,math,time
from pathlib import Path
HELPER=Path(__file__).with_name('2026-09-11-global-parity-learning.py')
spec=importlib.util.spec_from_file_location('case_linear',HELPER)
h=importlib.util.module_from_spec(spec); spec.loader.exec_module(h)

def discover(cnf,n,budget):
    current=(); clauses=[tuple(c) for c in cnf]; known={tuple(sorted(c)) for c in clauses}
    history=[]; learned=[]; nogood_records=[]
    for width in range(min(budget,n)+1):
        scopes=[s for size in range(width+1) for s in itertools.combinations(range(n),size)]
        bound=sum(math.comb(n,j)*(1<<j) for j in range(width+1))
        while True:
            stats={'budget':width,'initial_rank':len(current),'scopes_available':len(scopes),
                   'case_bound_per_sweep':bound,'scopes_attempted':0,'cases_attempted':0,'failed_cases':0,
                   'unit_steps':0,'gaussian_calls':0,'gaussian_input_rows':0,'new_equations':0,'new_nogoods':0,
                   'peak_surviving_bases_per_scope':0}
            new=[]; bad=[]
            for scope in scopes:
                stats['scopes_attempted']+=1; survivors=[]
                for code in range(1<<len(scope)):
                    assignment=[(v,(code>>j)&1) for j,v in enumerate(scope)]
                    result=h.closure(current,clauses,[],n,assignment)
                    stats['cases_attempted']+=1
                    stats['unit_steps']+=len(result['steps'])
                    stats['gaussian_calls']+=len(result['certificates'])
                    stats['gaussian_input_rows']+=sum(len(c['inputs']) for c in result['certificates'])
                    if result['conflict']:
                        stats['failed_cases']+=1
                        c=tuple(sorted(-(v+1) if b else v+1 for v,b in assignment))
                        if not c:
                            history.append(stats)
                            return {'status':'UNSAT','rank':len(current),'history':history,'learned':learned,'nogoods':nogood_records}
                        if c not in known and c not in bad: bad.append(c)
                    else: survivors.append((code,[a|(b<<n) for a,b in result['rows']]))
                stats['peak_surviving_bases_per_scope']=max(stats['peak_surviving_bases_per_scope'],len(survivors))
                if not survivors:
                    history.append(stats)
                    return {'status':'UNSAT','rank':len(current),'history':history,'learned':learned,'nogoods':nogood_records}
                basis=survivors[0][1]
                for code,other in survivors[1:]: basis=h.intersect_spaces(basis,other,n+1)
                for v in basis:
                    row=(v & ((1<<n)-1),v>>n)
                    if row in current or row in new: continue
                    for code,other in survivors: h.combination(v,other)
                    new.append(row); learned.append({'budget':width,'scope':scope,'row':row})
            stats['new_equations']=len(new); stats['new_nogoods']=len(bad)
            stats['cases_attempted_complete']=stats['cases_attempted']==bound
            history.append(stats)
            for c in bad: nogood_records.append({'budget':width,'clause':c})
            final=h.gauss_cert([(a,b,['previous',j]) for j,(a,b) in enumerate(current)]+[(a,b,['new',j]) for j,(a,b) in enumerate(new)],n)
            if final['contradiction'] is not None:
                return {'status':'UNSAT','rank':len(current),'history':history,'learned':learned,'nogoods':nogood_records,
                        'final_gaussian_certificate':final}
            updated=tuple((a,b) for a,b,p in final['rows'])
            if len(updated)==len(current) and not bad: break
            assert len(updated)>len(current) or bad
            current=updated; clauses.extend(bad); known.update(bad)
    return {'status':'OPEN','rank':len(current),'history':history,'learned':learned,'nogoods':nogood_records}

def parity_cnf(variables,charge):
    return [tuple(-(v+1) if (code>>j)&1 else v+1 for j,v in enumerate(variables))
            for code in range(1<<len(variables)) if h.parity(code)!=charge]

def tseitin(edges,charge):
    vertices=max(max(e) for e in edges)+1; cnf=[]
    for v in range(vertices): cnf+=parity_cnf([j for j,e in enumerate(edges) if v in e],int(v==0 and charge))
    return cnf,len(edges)

def php(holes):
    pigeons=holes+1
    def var(p,hole): return p*holes+hole+1
    clauses=[tuple(var(p,j) for j in range(holes)) for p in range(pigeons)]
    for p in range(pigeons):
        clauses += [(-var(p,a),-var(p,b)) for a,b in itertools.combinations(range(holes),2)]
    for j in range(holes):
        clauses += [(-var(a,j),-var(b,j)) for a,b in itertools.combinations(range(pigeons),2)]
    return clauses,pigeons*holes

def matches(cnf,x): return all(any(bool((x>>(abs(v)-1))&1)==(v>0) for v in c) for c in cnf)
def input_pin(cnf,n):
    blob=json.dumps({'nvars':n,'cnf':cnf},sort_keys=True,separators=(',',':')).encode()
    return hashlib.sha256(blob).hexdigest()

def main():
    started=time.monotonic(); records=[]
    controls=[([],2,1,'OPEN'),([()],2,1,'UNSAT'),([(1,),(-1,)],2,1,'UNSAT'),
              ([(1,)],2,1,'OPEN'),([(1,2)],2,1,'OPEN')]
    for cnf,n,w,status in controls:
        result=discover(cnf,n,w); assert result['status']==status
        actual=[x for x in range(1<<n) if matches(cnf,x)]
        assert all(all(h.parity(item['row'][0] & x)==item['row'][1] for item in result['learned']) for x in actual)
    graphs={'K4':[(i,j) for i in range(4) for j in range(i+1,4)],
            'prism3':[(0,1),(1,2),(2,0),(3,4),(4,5),(5,3),(0,3),(1,4),(2,5)]}
    for name,edges in graphs.items():
        cnf,n=tseitin(edges,1); result=discover(cnf,n,2)
        assert result['status']=='UNSAT' and max(s['budget'] for s in result['history'])==2
        assert not any(matches(cnf,x) for x in range(1<<n))
        records.append({'family':'ordinary_CNF_Tseitin','graph':name,'budget':2,'nvars':n,'cnf':cnf,'input_sha256':input_pin(cnf,n),'result':result})
    for holes,w in [(3,1),(4,2)]:
        cnf,n=php(holes); result=discover(cnf,n,w)
        assert result['status']=='OPEN' and result['rank']==0 and not result['learned'] and not result['nogoods']
        assert len(result['history'])==w+1
        assert all(s['cases_attempted']==sum(math.comb(n,j)*(1<<j) for j in range(s['budget']+1)) for s in result['history'])
        records.append({'family':'functional_PHP','holes':holes,'budget':w,'nvars':n,'cnf':cnf,'input_sha256':input_pin(cnf,n),'result':result})
    # Reindex every variable; all-group examination is not a privileged-prefix test.
    cnf,n=php(3); renamed=[tuple((n+1-abs(v))*(1 if v>0 else -1) for v in c) for c in cnf]
    result=discover(renamed,n,1)
    assert result['status']=='OPEN' and result['rank']==0
    records.append({'family':'functional_PHP_reverse_labels','holes':3,'budget':1,'nvars':n,'cnf':renamed,'input_sha256':input_pin(renamed,n),'result':result})
    dependencies={HELPER.name:hashlib.sha256(HELPER.read_bytes().replace(b'\r\n',b'\n')).hexdigest(),
                  h.HELPER.name:hashlib.sha256(h.HELPER.read_bytes().replace(b'\r\n',b'\n')).hexdigest()}
    data={'controls':len(controls),'cases':records,'elapsed_seconds':time.monotonic()-started,
          'script_sha256_lf':hashlib.sha256(Path(__file__).read_bytes().replace(b'\r\n',b'\n')).hexdigest(),
          'dependency_sha256_lf':dependencies}
    Path(__file__).with_suffix('.json').write_text(json.dumps(data,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'controls':len(controls),'cases':len(records),'elapsed_seconds':data['elapsed_seconds']}))

if __name__=='__main__':main()
