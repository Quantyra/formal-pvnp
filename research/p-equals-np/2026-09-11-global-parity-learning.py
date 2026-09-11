"""S3058 deterministic guard case analysis with certified Gaussian row operations."""
import hashlib,importlib.util,itertools,json,time
from pathlib import Path
HELPER=Path(__file__).with_name('2026-09-11-decomposition-mechanism.py')
spec=importlib.util.spec_from_file_location('linear_helper',HELPER)
h=importlib.util.module_from_spec(spec); spec.loader.exec_module(h)
rref,solve,parity=h.rref,h.solve,h.parity

def xor_sum(values):
    x=0
    for v in values: x^=v
    return x

def gauss_cert(inputs,n):
    work=[(a,b,1<<i) for i,(a,b,tag) in enumerate(inputs)]; p=0
    for j in range(n):
        k=next((k for k in range(p,len(work)) if (work[k][0]>>j)&1),None)
        if k is None: continue
        work[p],work[k]=work[k],work[p]
        a,b,proof=work[p]
        for k in range(len(work)):
            if k!=p and (work[k][0]>>j)&1:
                c,d,q=work[k]; work[k]=(c^a,d^b,q^proof)
        p+=1
    contradiction=next((q for a,b,q in work if a==0 and b),None)
    for a,b,q in work:
        assert a==xor_sum(v for i,(v,c,t) in enumerate(inputs) if (q>>i)&1)
        assert b==xor_sum(c for i,(v,c,t) in enumerate(inputs) if (q>>i)&1)
    return {'inputs':inputs,'rows':work[:p],'contradiction':contradiction}

def closure(base,cnf,guarded,n,assignment):
    fixed={}; steps=[]; certificates=[]
    def setbit(v,b,reason):
        if v in fixed: return fixed[v]==b
        fixed[v]=b; steps.append({'variable':v,'value':b,'reason':reason}); return True
    for v,b in assignment: assert setbit(v,b,['assumption'])
    while True:
        before=len(fixed)
        for j,c in enumerate(cnf):
            if any(abs(v)-1 in fixed and fixed[abs(v)-1]==int(v>0) for v in c): continue
            remaining=set(v for v in c if abs(v)-1 not in fixed)
            if any(-v in remaining for v in remaining): continue
            if not remaining:
                return {'conflict':True,'clause_conflict':j,'steps':steps,'certificates':certificates}
            if len(remaining)==1:
                v=next(iter(remaining)); assert setbit(abs(v)-1,int(v>0),['clause',j])
        inputs=[(a,b,['base',j]) for j,(a,b) in enumerate(base)]
        active=[]
        for j,(guard,a,b) in enumerate(guarded):
            if all(abs(v)-1 in fixed and fixed[abs(v)-1]==int(v>0) for v in guard):
                inputs.append((a,b,['guarded',j])); active.append(j)
        inputs += [(1<<s['variable'],s['value'],['unit_step',j]) for j,s in enumerate(steps)]
        certificate=gauss_cert(inputs,n); certificates.append(certificate)
        if certificate['contradiction'] is not None:
            return {'conflict':True,'steps':steps,'certificates':certificates}
        rows=[(a,b) for a,b,p in certificate['rows']]
        for j,(a,b) in enumerate(rows):
            if a.bit_count()==1: assert setbit(a.bit_length()-1,b,['gaussian',len(certificates)-1,j])
        if len(fixed)==before:
            return {'conflict':False,'rows':rows,'active_guarded':active,'steps':steps,'certificates':certificates}

def intersect_spaces(left,right,bits):
    # Kernel coefficients express equal combinations of the two row bases.
    equations=[(sum(((v>>j)&1)<<i for i,v in enumerate(left+right)),0) for j in range(bits)]
    _,kernel=solve(equations,len(left)+len(right))
    images=[xor_sum(v for i,v in enumerate(left) if (z>>i)&1) for z in kernel]
    return [a for a,b in rref([(v,0) for v in images],bits)]

def combination(vector,basis):
    code=sum(((vector>>((v & -v).bit_length()-1))&1)<<i for i,v in enumerate(basis))
    assert vector==xor_sum(v for i,v in enumerate(basis) if (code>>i)&1)
    return code

def learn(base,cnf,guarded,n,common=True):
    supports=[()]+sorted({tuple(sorted(abs(v)-1 for v in guard)) for guard,a,b in guarded if guard})
    current=rref(base,n); clauses=list(cnf); known={tuple(sorted(c)) for c in clauses}
    history=[]; passes=[]
    while True:
        if current is None: return {'status':'UNSAT','rank_history':history,'passes':passes}
        history.append(len(current)); logs=[]; new=[]; nogoods=[]; learned=[]
        for support in supports:
            branches=[]
            for code in range(1<<len(support)):
                assignment=[(v,(code>>j)&1) for j,v in enumerate(support)]
                result=closure(current,clauses,guarded,n,assignment)
                index=len(logs); logs.append({'scope':support,'pattern':code,**result})
                if result['conflict']:
                    c=tuple(sorted(-(v+1) if b else v+1 for v,b in assignment))
                    if not c:
                        passes.append({'contexts':logs,'learned_equations':learned,'new_nogoods':nogoods})
                        return {'status':'UNSAT','rank_history':history,'passes':passes}
                    if c not in known and c not in nogoods: nogoods.append(c)
                else: branches.append(index)
            if not branches:
                passes.append({'contexts':logs,'learned_equations':learned,'new_nogoods':nogoods})
                return {'status':'UNSAT','rank_history':history,'passes':passes}
            if common:
                basis=[a|(b<<n) for a,b in logs[branches[0]]['rows']]
                for index in branches[1:]:
                    basis=intersect_spaces(basis,[a|(b<<n) for a,b in logs[index]['rows']],n+1)
                for v in basis:
                    row=(v & ((1<<n)-1),v>>n)
                    if row in current: continue
                    witnesses=[{'context':i,'combination':combination(v,[a|(b<<n) for a,b in logs[i]['rows']])} for i in branches]
                    new.append(row); learned.append({'row':row,'scope':support,'witnesses':witnesses})
        record={'contexts':logs,'learned_equations':learned,'new_nogoods':nogoods}
        passes.append(record)
        final=gauss_cert([(a,b,['previous',j]) for j,(a,b) in enumerate(current)]+[(a,b,['learned',j]) for j,(a,b) in enumerate(new)],n)
        record['batch_certificate']=final
        if final['contradiction'] is not None: return {'status':'UNSAT','rank_history':history,'passes':passes}
        updated=tuple((a,b) for a,b,p in final['rows'])
        if len(updated)==len(current) and not nogoods:
            return {'status':'OPEN','rank_history':history,'passes':passes}
        assert len(updated)>len(current) or nogoods
        current=updated; clauses.extend(nogoods); known.update(nogoods)
        assert len(history)<=n+sum(1<<len(s) for s in supports)+1

def ring(m,length):
    x=list(range(m)); g=list(range(m,2*m)); hh=list(range(2*m,3*m)); z=list(range(3*m,4*m))
    n=4*m; clauses=[]; guarded=[]; targets=[]
    for i in range(m):
        clauses += [(-(z[i]+1),g[i]+1), (-(z[i]+1),hh[i]+1),(z[i]+1,-(g[i]+1),-(hh[i]+1))]
        targets.append((1<<x[i])^(1<<x[(i+1)%m])^(1<<z[i]))
        for a,b in itertools.product([0,1],repeat=2):
            guard=(g[i]+1 if a else -(g[i]+1),hh[i]+1 if b else -(hh[i]+1))
            path=[x[i]]+list(range(n,n+length-1))+[x[(i+1)%m]]; n+=length-1
            rows=[]
            for j in range(length):
                row=((1<<path[j])^(1<<path[j+1]),(a & b) if j==0 else 0)
                guarded.append((guard,*row)); rows.append(row)
            # Exact endpoint projection: XOR of all rows gives charge, and every compatible endpoint extends.
            assert xor_sum(a for a,b in rows)==(1<<x[i])^(1<<x[(i+1)%m])
            assert xor_sum(b for a,b in rows)==(a & b)
    return [(sum(1<<v for v in z),1)],clauses,guarded,n,targets

def prism(k):
    edges=[(i,(i+1)%k) for i in range(k)]+[(k+i,k+(i+1)%k) for i in range(k)]+[(i,k+i) for i in range(k)]
    n=len(edges)+2; guard=(n-1,n); rows=[]
    for v in range(2*k): rows.append((sum(1<<j for j,e in enumerate(edges) if v in e),int(v==0)))
    assert xor_sum(a for a,b in rows)==0 and xor_sum(b for a,b in rows)==1
    return [],[],[(guard,a,b) for a,b in rows],n

def main():
    start=time.monotonic(); results=[]
    # Elementary propagation/offset/empty-context controls.
    controls=[([],[],[],1), ([(0,1)],[],[],1), ([],[(1,),(-1,)],[],1),
              ([],[(1,)], [((1,),1,0)],1)]
    expected=['OPEN','UNSAT','UNSAT','UNSAT']
    for args,status in zip(controls,expected): assert learn(*args)['status']==status
    for k in [3,4]:
        args=prism(k); result=learn(*args)
        assert result['status']=='OPEN'
        expected_clause=tuple(sorted((-(args[3]-1),-args[3])))
        assert expected_clause in result['passes'][0]['new_nogoods']
        assert len(result['passes'][0]['learned_equations'])==0
        results.append({'family':'guarded_prism','k':k,'n':args[3],'result':result})
    for m,length in [(3,1),(4,1),(3,3),(4,3)]:
        base,cnf,guarded,n,targets=ring(m,length)
        baseline=learn(base,cnf,guarded,n,False)
        assert baseline['status']=='OPEN' and not baseline['passes'][0]['new_nogoods']
        result=learn(base,cnf,guarded,n)
        assert result['status']=='UNSAT'
        learned_vectors=[item['row'][0]|(item['row'][1]<<n) for item in result['passes'][0]['learned_equations']]
        span=[a for a,b in rref([(v,0) for v in learned_vectors]+[(a|(b<<n),0) for a,b in base],n+1)]
        for target in targets: combination(target,span)
        results.append({'family':'guarded_AND_ring','m':m,'path_length':length,'n':n,
                        'conflict_only_status':baseline['status'],'conflict_only_contexts':len(baseline['passes'][0]['contexts']),
                        'target_equations':targets,'result':result})
    data={'controls':len(controls),'cases':results,'elapsed_seconds':time.monotonic()-start,
          'script_sha256_lf':hashlib.sha256(Path(__file__).read_bytes().replace(b'\r\n',b'\n')).hexdigest(),
          'helper_file':HELPER.name,'helper_sha256_lf':hashlib.sha256(HELPER.read_bytes().replace(b'\r\n',b'\n')).hexdigest()}
    Path(__file__).with_suffix('.json').write_text(json.dumps(data,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'controls':len(controls),'family_cases':len(results),'elapsed_seconds':data['elapsed_seconds']}))

if __name__=='__main__':main()
