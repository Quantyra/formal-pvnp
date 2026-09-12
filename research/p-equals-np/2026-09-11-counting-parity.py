"""S3060 exact ordinary-CNF counting/parity feedback; bounded diagnostic."""
import hashlib, importlib.util, itertools, json, math, time
from pathlib import Path
P=Path(__file__).parent
H=P/'2026-09-11-mechanism-discovery.py'
s=importlib.util.spec_from_file_location('affine',H); A=importlib.util.module_from_spec(s); s.loader.exec_module(A)
def pin(p): return hashlib.sha256(p.read_bytes().replace(b'\r\n',b'\n')).hexdigest()
def mask(s): return sum(1<<(v-1) for v in s)
def implied(rows,a):
    b=0
    for r,c in rows:
        if a & (r & -r): a^=r; b^=c
    return None if a else b

def cliques(cnf,n,stats):
    adj=[set() for _ in range(n+1)]
    for c in cnf:
        if len(c)==2 and all(v<0 for v in c):
            u,v=sorted(-x for x in c); adj[u].add(v); adj[v].add(u)
    out=set()
    for u in range(1,n+1):
        for v in sorted(adj[u]):
            if u>=v: continue
            stats['clique_candidates']+=1
            S=tuple(sorted({u,v}|(adj[u]&adj[v])))
            good=True
            for x,y in itertools.combinations(S,2):
                stats['pair_checks']+=1
                if y not in adj[x]: good=False; break
            if good: out.add(S)
    return sorted(out)

def aggregate(cnf,groups,n):
    pos=[c for c in cnf if c and all(v>0 for v in c)]
    L=[sum(i in c for c in pos) for i in range(1,n+1)]
    U=[sum(i in c for c in groups) for i in range(1,n+1)]
    nz=next((i for i in range(n) if L[i] or U[i]),None)
    if nz is None or not L[nz] or not U[nz]: return None
    g=math.gcd(L[nz],U[nz]); alpha=U[nz]//g; beta=L[nz]//g
    if any(alpha*l!=beta*u for l,u in zip(L,U)): return None
    return {'alpha':alpha,'beta':beta,'lower':alpha*len(pos),'upper':beta*len(groups),'L':L,'U':U}

def run(cnf,n,mode='hybrid'):
    cnf=sorted(set(A.normalize(cnf))); fixed={}; rows=(); log=[]
    stats={'sweeps':0,'literal_scans':0,'clique_candidates':0,'pair_checks':0,'membership_checks':0}
    def done(status,reason): return dict(status=status,reason=reason,stats=stats,log=log,rows=rows,fixed=fixed)
    while True:
        stats['sweeps']+=1; before=(tuple(sorted(fixed.items())),rows,tuple(cnf))
        # Unit propagation on retained original/learned clauses, with explicit reasons.
        while True:
            changed=False; residual=[]
            for c in cnf:
                stats['literal_scans']+=len(c)
                if any(abs(v) in fixed and fixed[abs(v)]==int(v>0) for v in c): continue
                d=tuple(v for v in c if abs(v) not in fixed)
                if not d: return done('UNSAT',{'empty_clause':c})
                residual.append(d)
                if len(d)==1:
                    v=d[0]; fixed[abs(v)]=int(v>0); log.append({'unit':v,'clause':c}); changed=True
            if not changed: break
        residual=sorted(set(residual))
        if mode!='counting':
            seed,_=A.extract(residual,n,3)
            if seed is None: return done('UNSAT','empty affine bucket')
            rows=A.rref(list(rows)+list(seed)+[(1<<(v-1),b) for v,b in fixed.items()],n)
            if rows is None: return done('UNSAT','Gaussian contradiction')
            for v in range(1,n+1):
                b=implied(rows,1<<(v-1))
                if b is not None and v not in fixed: fixed[v]=b; log.append({'Gaussian_unit':[v,b]})
            if tuple(sorted(fixed.items()))!=before[0]: continue
        if mode!='parity':
            groups=cliques(residual,n,stats)
            cert=aggregate(residual,groups,n)
            if cert and cert['lower']>cert['upper']: return done('UNSAT',{'aggregate':cert,'groups':groups})
            if mode=='hybrid':
                pos={tuple(c) for c in residual if all(v>0 for v in c)}
                additions=[(mask(g),1) for g in groups if g in pos]
                if additions:
                    rows=A.rref(list(rows)+additions,n)
                    log.append({'exact_one_parities':additions})
                    if rows is None: return done('UNSAT','exact-one parity contradiction')
                for g in groups:
                    stats['membership_checks']+=1; b=implied(rows,mask(g))
                    if b==0:
                        log.append({'even_AMO_zero':g})
                        for v in g: fixed[v]=0
                    elif b==1 and g not in cnf:
                        cnf.append(g); log.append({'odd_AMO_ALO':g})
                cnf=sorted(set(cnf))
        after=(tuple(sorted(fixed.items())),rows,tuple(cnf))
        if after==before: return done('OPEN','fixed point; no SAT assertion')

def interaction(k,odd=0):
    assert k>=3
    X=list(range(1,k+1)); y1,y2=k+1,k+2
    cnf=[(-u,-v) for u,v in itertools.combinations(X,2)]+[(-y1,-y2),(1,y1),(2,y2)]
    prev=1; nxt=k+3
    for x in range(2,k):
        cnf+=A.xor_cnf([prev-1,x-1,nxt-1],0); prev=nxt; nxt+=1
    cnf+=A.xor_cnf([prev-1,k-1],odd)
    return cnf,nxt-1

def php(h):
    cell=lambda p,j: p*h+j+1
    cnf=[tuple(cell(p,j) for j in range(h)) for p in range(h+1)]
    cnf += [(-cell(p,a),-cell(p,b)) for p in range(h+1) for a,b in itertools.combinations(range(h),2)]
    cnf += [(-cell(a,j),-cell(b,j)) for j in range(h) for a,b in itertools.combinations(range(h+1),2)]
    return cnf,h*(h+1)

def obstruction(copies):
    cnf=[]
    for b in range(copies):
        for t in itertools.combinations(range(5*b+1,5*b+6),3): cnf += [t,tuple(-v for v in t)]
    return cnf,5*copies

def main():
    start=time.monotonic(); cases=[]
    controls=[(0,[], 'OPEN'),(0,[()], 'UNSAT'),(1,[(1,),(-1,)],'UNSAT'),(1,[(1,-1)],'OPEN')]
    for n,c,e in controls: assert run(c,n)['status']==e
    for k in range(4,8):
        c,n=interaction(k); out={m:run(c,n,m) for m in ['counting','parity','hybrid']}
        assert [out[m]['status'] for m in out]==['OPEN','OPEN','UNSAT']
        halves=[0]*n
        for v in [1,2,k+1,k+2]: halves[v-1]=1
        assert all(sum(halves[abs(v)-1] if v>0 else 2-halves[abs(v)-1] for v in cl)>=2 for cl in c)
        G=cliques(c,n,dict(clique_candidates=0,pair_checks=0))
        assert all(sum(halves[v-1] for v in g)<=2 for g in G)
        assert A.brute(c,n)==0
        cases.append(dict(family='interaction',k=k,n=n,cnf=c,half_units=halves,groups=G,results=out))
    for k in [4,5]:
        c,n=interaction(k,1); out=run(c,n); assert out['status']=='OPEN' and A.brute(c,n)>0
        cases.append(dict(family='odd_SAT_control',k=k,n=n,cnf=c,result=out))
    for h in [3,4]:
        c,n=php(h); out=run(c,n); assert out['status']=='UNSAT' and 'aggregate' in out['reason']
        cases.append(dict(family='PHP_known_control',h=h,n=n,cnf=c,result=out))
    for copies in [1,2]:
        c,n=obstruction(copies); out=run(c,n); assert out['status']=='OPEN' and A.brute(c,n)==0
        cases.append(dict(family='NAE_obstruction',copies=copies,n=n,cnf=c,result=out))
    output={'scope':'exact finite checks and policy-specific ablations; no solver advantage claim','controls':len(controls),'script_sha256_lf':pin(Path(__file__)),'helper_sha256_lf':pin(H),'cases':cases,'seconds':time.monotonic()-start}
    Path(__file__).with_suffix('.json').write_text(json.dumps(output,indent=2)+'\n',encoding='utf8')
    print(json.dumps({'controls':len(controls),'cases':len(cases),'seconds':output['seconds'],'sha256':output['script_sha256_lf']}))
if __name__=='__main__': main()
