"""S3056 exact fixed-cut affine-syndrome decomposition checks. Stdlib only."""
import hashlib, itertools, json, time
from pathlib import Path

def parity(x): return x.bit_count() & 1

def rref(rows,n):
    rows=list(set(rows)); p=0
    for j in range(n):
        k=next((k for k in range(p,len(rows)) if (rows[k][0]>>j)&1),None)
        if k is None: continue
        rows[p],rows[k]=rows[k],rows[p]
        a,b=rows[p]
        for k in range(len(rows)):
            if k!=p and (rows[k][0]>>j)&1: rows[k]=(rows[k][0]^a, rows[k][1]^b)
        p+=1
    return None if (0,1) in rows else tuple(rows[:p])

def solve(rows,n):
    rr=rref(rows,n)
    if rr is None: return None
    pivots=[(a & -a).bit_length()-1 for a,b in rr]
    base=sum(b<<j for j,(a,b) in zip(pivots,rr)); basis=[]
    for k in range(n):
        if k in pivots: continue
        v=1<<k
        for j,(a,b) in zip(pivots,rr):
            if (a>>k)&1: v|=1<<j
        basis.append(v)
    return base,basis

def points(base,basis):
    for code in range(1<<len(basis)):
        value=base
        for j,b in enumerate(basis):
            if (code>>j)&1: value^=b
        yield value

def image(rows,x,mask):
    return sum(parity(a & x & mask)<<i for i,(a,b) in enumerate(rows))

def interface(rows,n,xmask):
    solution=solve(rows,n)
    if solution is None: return None
    base,kernel=solution
    generators=[(image(rows,v,xmask),0) for v in kernel]
    basis=[a for a,b in rref(generators,len(rows))]
    rankx=len(rref([(a & xmask,0) for a,b in rows],n))
    ranky=len(rref([(a & (((1<<n)-1)^xmask),0) for a,b in rows],n))
    rankall=len(rref([(a,0) for a,b in rows],n))
    assert len(basis)==rankx+ranky-rankall
    return image(rows,base,xmask),basis

def holds(c,x):
    return any(bool((x>>(abs(v)-1))&1)==(v>0) for v in c)

def leaf(rows,variables,clauses):
    # Cheap syntactic unit propagation before the explicit finite fallback.
    fixed={}; changed=True
    while changed:
        changed=False
        for c in clauses:
            if any(abs(v)-1 in fixed and fixed[abs(v)-1]==int(v>0) for v in c): continue
            remaining=set(v for v in c if abs(v)-1 not in fixed)
            if any(-v in remaining for v in remaining): continue
            if not remaining: return None,0
            if len(remaining)==1:
                v=next(iter(remaining)); fixed[abs(v)-1]=int(v>0); changed=True
    local=[]
    for a,b in rows:
        local.append((sum(((a>>v)&1)<<j for j,v in enumerate(variables)),b))
    for v,b in fixed.items(): local.append((1<<variables.index(v),b))
    solution=solve(local,len(variables))
    if solution is None: return None,0
    tries=0
    for z in points(*solution):
        x=sum(((z>>j)&1)<<v for j,v in enumerate(variables)); tries+=1
        if all(holds(c,x) for c in clauses): return x,tries
    return None,tries

def decide(rows,n,clauses,separator,left):
    S=set(separator); X=set(left); Y=set(range(n))-S-X
    assert not(S & X)
    stats={'separator_attempts':0,'syndrome_attempts':0,'leaf_assignments':0,'interface_dimensions':[]}
    for fixed_bits in range(1<<len(separator)):
        stats['separator_attempts']+=1
        fixed={v:(fixed_bits>>j)&1 for j,v in enumerate(separator)}
        fixed_x=sum(b<<v for v,b in fixed.items())
        residual=[[],[]]; impossible=False
        for c in clauses:
            if any(abs(v)-1 in S and fixed[abs(v)-1]==int(v>0) for v in c): continue
            out=tuple(v for v in c if abs(v)-1 not in S)
            if not out: impossible=True; break
            support={abs(v)-1 for v in out}
            if support<=X: residual[0].append(out)
            elif support<=Y: residual[1].append(out)
            else: raise ValueError('supplied separator does not split residual clauses')
        if impossible: continue
        smask=sum(1<<v for v in S); xmask=sum(1<<v for v in X); ymask=sum(1<<v for v in Y)
        # Keep the n-coordinate ambient space but fix separator coordinates to zero in this residual system.
        conditioned=[(a & ~smask,b^parity(a & fixed_x)) for a,b in rows]
        conditioned += [(1<<v,0) for v in S]
        boundary=interface(conditioned,n,xmask)
        if boundary is None: continue
        stats['interface_dimensions'].append(len(boundary[1]))
        rhs=sum(b<<i for i,(a,b) in enumerate(conditioned))
        for syndrome in points(*boundary):
            stats['syndrome_attempts']+=1
            lx=[(a & xmask,(syndrome>>i)&1) for i,(a,b) in enumerate(conditioned)]
            rx=[(a & ymask,((rhs^syndrome)>>i)&1) for i,(a,b) in enumerate(conditioned)]
            x,tries=leaf(lx,sorted(X),residual[0]); stats['leaf_assignments']+=tries
            if x is None: continue
            y,tries=leaf(rx,sorted(Y),residual[1]); stats['leaf_assignments']+=tries
            if y is not None:
                witness=x|y|fixed_x
                assert all(parity(a & witness)==b for a,b in rows) and all(holds(c,witness) for c in clauses)
                return True,witness,stats
    return False,None,stats

def verify_interface(rows,n,xmask):
    boundary=interface(rows,n,xmask)
    actual={image(rows,x,xmask) for x in range(1<<n) if all(parity(a & x)==b for a,b in rows)}
    generated=set() if boundary is None else set(points(*boundary))
    assert actual==generated
    # Each generated fiber-product agrees with the full affine relation.
    rhs=sum(b<<i for i,(a,b) in enumerate(rows)); ymask=((1<<n)-1)^xmask
    for x in range(1<<n):
        decomposition=image(rows,x,xmask) in generated and image(rows,x,xmask)^image(rows,x,ymask)==rhs
        assert decomposition==all(parity(a & x)==b for a,b in rows)
    return None if boundary is None else len(boundary[1])

def main():
    start=time.monotonic(); cases=[]
    fixtures=[(0,[],[],[],[]),(1,[(0,1)],[],[],[0]),(1,[],[()],[],[0]),
              (2,[(3,0)],[(1,),(-2,)],[],[0]),(2,[],[(1,-1)],[],[0])]
    for n,rows,cnf,sep,left in fixtures:
        answer,witness,stats=decide(rows,n,cnf,sep,left)
        assert answer==any(all(parity(a & x)==b for a,b in rows) and all(holds(c,x) for c in cnf) for x in range(1<<n))
    for m in range(1,11):
        cnf=[(1,i+2) for i in range(m)]
        answer,witness,stats=decide([],m+1,cnf,[0],list(range(1,1+(m+1)//2)))
        assert answer and stats['interface_dimensions']==[0] and stats['syndrome_attempts']==1
        assert stats['leaf_assignments']==2
        cases.append({'family':'star','m':m,'sat':answer,**stats})
    for k in range(1,7):
        n=2*k; xm=(1<<k)-1; ym=xm<<k
        families={'dense_global_parity':[(xm|ym,0)],
                  'row_mixed_independent':[(xm|ym,0),(ym,0)],
                  'independent_bridges':[((1<<i)|(1<<(k+i)),0) for i in range(k)]}
        for name,rows in families.items():
            t=verify_interface(rows,n,xm)
            assert t=={'dense_global_parity':1,'row_mixed_independent':0,'independent_bridges':k}[name]
            cnf=[tuple(i+1 for i in range(k)),tuple(-(k+i+1) for i in range(k))]
            answer,witness,stats=decide(rows,n,cnf,[],list(range(k)))
            expected=any(all(parity(a & x)==b for a,b in rows) and all(holds(c,x) for c in cnf) for x in range(1<<n))
            assert answer==expected
            mixed=rows[:]
            if len(mixed)>1: mixed[0]=(mixed[0][0]^mixed[1][0],mixed[0][1]^mixed[1][1])
            assert verify_interface(mixed,n,xm)==t
            cases.append({'family':name,'k':k,'pure_affine_minimum_rectangles':1<<t,'sat':answer,**stats})
    for k in range(2,9):
        rows=[((1<<i)|(1<<(k+i)),0) for i in range(k)]
        gx=[(i+1,i+2) for i in range(k-1)]
        gy=[(-(k+i+1),-(k+i+2)) for i in range(k-1)]
        answer,witness,stats=decide(rows,2*k,gx+gy,[],list(range(k)))
        survivors=[z for z in range(1<<k) if all(holds(c,z|(z<<k)) for c in gx+gy)]
        assert len(survivors)==2 and min(survivors)==(1<<k)//3
        assert answer and stats['syndrome_attempts']==(1<<k)//3+1
        boundary=interface(rows,2*k,(1<<k)-1)
        assert boundary==(0,[1<<i for i in range(k)])
        # Algebraically combine paired clauses after the explicit x_i=y_i substitution.
        repaired=solve([((1<<i)|(1<<(i+1)),1) for i in range(k-1)],k)
        assert len(repaired[1])==1 and sorted(points(*repaired))==survivors
        cases.append({'family':'paired_paths','k':k,'surviving_syndromes':len(survivors),
                      'first_syndrome':min(survivors),'repaired_affine_dimension':1,'sat':answer,**stats})
    assert verify_interface([(0,1)],2,1) is None
    data={'scope':'fixed-cut decision decomposition; exhaustive checks are finite controls, not an efficient generic leaf solver',
          'control_fixtures':len(fixtures),'families':cases,'elapsed_seconds':time.monotonic()-start,
          'script_sha256_lf':hashlib.sha256(Path(__file__).read_bytes().replace(b'\r\n',b'\n')).hexdigest()}
    Path(__file__).with_suffix('.json').write_text(json.dumps(data,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'controls':len(fixtures),'family_cases':len(cases),'elapsed_seconds':data['elapsed_seconds']}))

if __name__=='__main__': main()
