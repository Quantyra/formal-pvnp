"""Exact bounded affine-span feedback; no semantic SAT oracle in saturation."""
import hashlib, importlib.util, itertools, json, time
from pathlib import Path
HELPER=Path(__file__).with_name('2026-09-11-decomposition-mechanism.py')
spec=importlib.util.spec_from_file_location('s3056_linear',HELPER)
helper=importlib.util.module_from_spec(spec); spec.loader.exec_module(helper)
rref,solve,parity=helper.rref,helper.solve,helper.parity

def xor_sum(values):
    total=0
    for v in values: total^=v
    return total

def holds(clause,x): return any(parity(a & x)^c for a,c in clause)
def models(rows,clauses,n):
    return [x for x in range(1<<n) if all(parity(a & x)==b for a,b in rows) and all(holds(c,x) for c in clauses)]
def cnf_to_forms(clauses): return [tuple((1<<(abs(v)-1),int(v<0)) for v in c) for c in clauses]

def coordinates(vector,basis):
    pivots=[(a & -a).bit_length()-1 for a in basis]
    code=sum(((vector>>p)&1)<<j for j,p in enumerate(pivots))
    return code if vector==xor_sum(a for j,a in enumerate(basis) if (code>>j)&1) else None

def normalized(clauses,base,kernel):
    output=[]
    for clause in clauses:
        false_rows=[(sum(parity(a & v)<<j for j,v in enumerate(kernel)),c^parity(a & base)) for a,c in clause]
        canonical=rref(false_rows,len(kernel))
        if canonical is None: continue
        if not canonical: return None
        output.append(canonical)
    return output

def saturate(rows,clauses,n,w):
    assert w>=1
    current=rref(rows,n); rank_history=[]; passes=[]; learned=[]
    while True:
        if current is None:
            return {'status':'UNSAT','rank_history':rank_history,'passes':passes,'learned':learned}
        rank_history.append(len(current))
        base,kernel=solve(current,n)
        free=[j for j in range(n) if j not in [(a & -a).bit_length()-1 for a,b in current]]
        residual=normalized(clauses,base,kernel)
        if residual is None:
            return {'status':'UNSAT','rank_history':rank_history,'passes':passes,'learned':learned}
        if not residual:
            assert all(holds(c,base) for c in clauses)
            return {'status':'SAT','witness':base,'rank_history':rank_history,'passes':passes,'learned':learned}
        vectors=sorted({a for clause in residual for a,b in clause})
        scopes=set()
        for size in range(1,min(w,len(vectors))+1):
            for chosen in itertools.combinations(vectors,size):
                scopes.add(tuple(a for a,b in rref([(v,0) for v in chosen],len(kernel))))
        new=[]; tested=0; largest=0
        for basis in sorted(scopes):
            grouped=[]
            for clause in residual:
                mapped=[(coordinates(a,basis),b) for a,b in clause]
                if all(a is not None for a,b in mapped): grouped.append(mapped)
            if not grouped: continue
            tested+=1; largest=max(largest,len(basis))
            allowed=[u for u in range(1<<len(basis)) if all(any(parity(a & u)!=b for a,b in clause) for clause in grouped)]
            if not allowed:
                passes.append({'scopes_generated':len(scopes),'groups_tested':tested,'largest_rank':largest,'empty_local_relation':True})
                return {'status':'UNSAT','rank_history':rank_history,'passes':passes,'learned':learned}
            equations=[(a,parity(a & allowed[0])) for a in range(1,1<<len(basis))
                       if all(parity(a & u)==parity(a & allowed[0]) for u in allowed)]
            for a,b in rref(equations,len(basis)):
                quotient_row=xor_sum(v for j,v in enumerate(basis) if (a>>j)&1)
                original_row=sum(((quotient_row>>j)&1)<<v for j,v in enumerate(free))
                new.append((original_row,b))
        passes.append({'scopes_generated':len(scopes),'groups_tested':tested,'largest_rank':largest,
                       'equations_proposed':len(new),'empty_local_relation':False})
        if not new:
            return {'status':'OPEN','rank_history':rank_history,'passes':passes,'learned':learned}
        learned.extend(new)
        updated=rref(list(current)+new,n)
        assert updated is None or len(updated)>len(current)
        current=updated

def bowtie(w):
    a=list(range(1,w+1)); b=list(range(w+1,2*w+1))
    cnf=[(-1,a[0]+1)]+[(-(a[i]+1),a[i+1]+1) for i in range(w-1)]+[(-(a[-1]+1),-1)]
    cnf += [(1,b[0]+1)]+[(-(b[i]+1),b[i+1]+1) for i in range(w-1)]+[(-(b[-1]+1),1)]
    return cnf

def affine_hull_rank(points,n):
    return None if not points else len(rref([(p^points[0],0) for p in points],n))

def run_checked(rows,clauses,n,w):
    result=saturate(rows,clauses,n,w); actual=models(rows,clauses,n)
    assert result['status']!='UNSAT' or not actual
    assert result['status']!='SAT' or result['witness'] in actual
    assert all(all(parity(a & x)==b for a,b in result['learned']) for x in actual)
    assert len(result['rank_history'])<=n+1
    return result

def main():
    started=time.monotonic(); output=[]
    controls=[([],[],2,2),([], [()],2,2),([], [((0,1),)],2,2),
              ([(0,1)],[],2,2),([], [((3,0),(3,1))],2,2),
              ([], [((3,0),)],2,1),([], [((1,0),(2,0))],2,2),
              ([],cnf_to_forms([(1,2,3),(-1,-2),(-1,-3),(-2,-3)]),3,3)]
    for args in controls: run_checked(*args)
    # A genuinely non-affine local OR relation must remain, not be replaced by its full hull.
    assert saturate([],cnf_to_forms([(1,2)]),2,2)['status']=='OPEN'
    exactly_one=controls[-1]
    eo=saturate(*exactly_one)
    assert eo['status']=='OPEN' and eo['rank_history']==[0,1]
    assert all(parity(a & 7)==b for a,b in eo['learned']) and not all(holds(c,7) for c in exactly_one[1])
    for k in range(2,7):
        rows=[((1<<i)|(1<<(k+i)),0) for i in range(k)]
        cnf=[(i+1,i+2) for i in range(k-1)]+[(-(k+i+1),-(k+i+2)) for i in range(k-1)]
        result=run_checked(rows,cnf_to_forms(cnf),2*k,2)
        assert result['status']=='SAT' and result['rank_history']==[k,2*k-1]
        output.append({'family':'paired_paths','k':k,**result})
    cascade=cnf_to_forms([(-1,2),(1,-2),(1,3),(-2,-3)])
    result=run_checked([],cascade,3,2)
    assert result['status']=='SAT' and result['rank_history']==[0,1,2]
    output.append({'family':'two_round_feedback',**result})
    for w in range(2,5):
        n=2*w+1; cnf=bowtie(w); clauses=cnf_to_forms(cnf)
        assert not models([],clauses,n)
        low=run_checked([],clauses,n,w); high=run_checked([],clauses,n,w+1)
        assert low['status']=='OPEN' and low['rank_history']==[0] and not low['learned']
        assert high['status']=='UNSAT'
        windows=0
        for size in range(1,w+1):
            for subset in itertools.combinations(range(n),size):
                support=set(subset)
                local=[c for c in cnf if {abs(v)-1 for v in c}<=support]
                allowed=[]
                for u in range(1<<size):
                    x=sum(((u>>j)&1)<<v for j,v in enumerate(subset))
                    if all(helper.holds(c,x) for c in local): allowed.append(u)
                assert affine_hull_rank(allowed,size)==size
                windows+=1
        output.append({'family':'bowtie_scope_hierarchy','w':w,'n':n,'checked_coordinate_windows':windows,
                       'scope_w':low,'scope_w_plus_one':high})
    data={'scope':'bounded local affine-hull feedback, OPEN is not a SAT verdict','controls':len(controls),
          'cases':output,'elapsed_seconds':time.monotonic()-started,
          'script_sha256_lf':hashlib.sha256(Path(__file__).read_bytes().replace(b'\r\n',b'\n')).hexdigest(),
          'helper_file':HELPER.name,'helper_sha256_lf':hashlib.sha256(HELPER.read_bytes().replace(b'\r\n',b'\n')).hexdigest()}
    Path(__file__).with_suffix('.json').write_text(json.dumps(data,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'controls':len(controls),'family_cases':len(output),'elapsed_seconds':data['elapsed_seconds']}))

if __name__=='__main__': main()
