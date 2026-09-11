"""S3046: one frozen independent instance; ideal replay plus symbolic cost screen."""
import os
for key in ['OPENBLAS_NUM_THREADS','MKL_NUM_THREADS','OMP_NUM_THREADS']:
    os.environ[key]='1'
import argparse,hashlib,json,math,runpy,time
from datetime import datetime,timezone
from pathlib import Path
import numpy as np

ROOT=Path(__file__).resolve().parent
PREFIX='2026-09-11-qaoa-independent-cost-screen'
N=16;KCLAUSE=8;DENSITY=176.54;SEED=20260911
COST_GRID=[(.01,.01),(.1,.1),(1.,1.)]

def digest(path):return hashlib.sha256(Path(path).read_bytes().replace(b'\r\n',b'\n')).hexdigest()
def save(path,obj):path.write_text(json.dumps(obj,indent=2,allow_nan=False)+'\n',encoding='utf-8')
def success(a,j):return math.sin((2*j+1)*math.asin(math.sqrt(a)))**2

def optimum(a,A,R,V):
    if not 0<a<=1:return {'status':'no finite positive-overlap restart cost'}
    if min(A,R,V)<0 or 2*A+R<=0:raise ValueError('invalid costs')
    best=(A+V)/a;jbest=0;j=1;D=2*A+R
    while A+j*D+V < best:
        s=success(a,j)
        if s>0:
            cost=(A+j*D+V)/s
            if cost<best:best=cost;jbest=j
        j+=1
    s=success(a,jbest)
    return {'status':'global known-overlap restart optimum','j':jbest,'success_per_trial':s,'expected_cost_R_units':best,'expected_A_and_inverse_calls':(1+2*jbest)/s,'expected_R_calls':jbest/s,'expected_verifications':1/s,'first_excluded_j':j,'exclusion_bound':'trial cost >= incumbent and success <=1; all larger j cannot improve'}

def threshold(a,p,h,v,Cg):
    if a<=0:return {'status':'zero overlap: no positive layer-cost advantage'}
    best=-math.inf;bestj=None;checked=0
    while h+checked*(2*h+1)+v < Cg:
        s=success(a,checked)
        L=(Cg*s-(1+2*checked)*h-checked-v)/(p*(1+2*checked))
        if L>best:best=L;bestj=checked
        checked+=1
    if not math.isfinite(best) or best<=0:return {'status':'no admissible positive L/R in this cost scenario','largest_threshold':best if math.isfinite(best) else None,'tested_j_count':checked}
    return {'status':'conditional positive break-even','max_L_over_R':best,'threshold_j':bestj,'threshold_trial_success':success(a,bestj),'tested_j_count':checked,
      'at_half_threshold':optimum(a,h+p*best/2,1,v),
      'above_threshold':optimum(a,h+p*best*1.01,1,v),
      'meaning':'A=H+pL, inverse same cost, R=S_F+S_0; advantage exists iff0<=L/R<max in this diagnostic model; no actual layer cost measured'}

def self_test():
    assert optimum(1,.1,1,.2)['j']==0
    assert optimum(0,.1,1,.2)['status'].startswith('no finite')
    a=.0123;A=.07;V=.03
    fast=optimum(a,A,1,V)
    brute=min(((A+j*(2*A+1)+V)/success(a,j),j) for j in range(10000) if success(a,j)>0)
    assert abs(fast['expected_cost_R_units']-brute[0])<1e-10 and fast['j']==brute[1]
    g=.001;cg=optimum(g,.1,1,.1)['expected_cost_R_units'];t=threshold(.1,14,.1,.1,cg)
    assert t['at_half_threshold']['expected_cost_R_units']<cg
    assert t['above_threshold']['expected_cost_R_units']>cg
    return 'PASS: a0/a1, global optimizer vs10000j independent grid, threshold both sides'

def prepare():
    rng=np.random.Generator(np.random.PCG64(SEED))
    m=int(rng.poisson(DENSITY*N));clauses=[]
    for _ in range(m):
        variables=rng.integers(1,N+1,size=KCLAUSE)
        negated=rng.integers(0,2,size=KCLAUSE)
        clauses.append([int(-x if sign else x) for x,sign in zip(variables,negated)])
    fpath=ROOT/(PREFIX+'-formula.json');cpath=ROOT/(PREFIX+'.cnf')
    save(fpath,{'n':N,'clauses':clauses})
    cpath.write_text('c S3046 independent instance; no SAT filtering\np cnf '+str(N)+' '+str(m)+'\n'+''.join(' '.join(map(str,c))+' 0\n' for c in clauses),encoding='utf-8')
    apath=ROOT/'2026-09-11-qaoa-recovered-angles.json';source=json.loads(apath.read_text(encoding='utf-8-sig'))
    angle_digest=hashlib.sha256(json.dumps(source['arrays'],sort_keys=True,separators=(',',':')).encode()).hexdigest()
    assert angle_digest=='7d49c1c721937c876896f067cddb6803e1c793df43fe55d52aba868d5616e8f8'
    canonical={p:{'beta':v['betas'],'gamma_journal':[-x for x in v['gammas']]} for p,v in source['arrays'].items()}
    manifest={'story':'S3046','label':'independent paper-defined experiment; not S3045 source replay','frozen_utc':datetime.now(timezone.utc).isoformat(),
      'n':N,'k':KCLAUSE,'r':DENSITY,'seed':SEED,'rng':'NumPyPCG64','numpy_version':np.__version__,'m':m,
      'generation':'DrawmPoisson(r*n); then perclause8variablesintegers1..n replacement, then8bits0/1;1negates. Keepallclauses/noSATrejection.',
      'formula_file':fpath.name,'formula_sha256_lf':digest(fpath),'cnf_file':cpath.name,'cnf_sha256_lf':digest(cpath),
      'source_angle_semantic_sha256':angle_digest,'canonical_angles':canonical,'angle_mapping':'beta=stored;gamma_journal=-stored;phaseexp(-i gamma_journal E/2),thenRx(beta),storedorder',
      'depths':[14,60],'cost_grid_H_over_R_V_over_R':COST_GRID,'cost_model':'R=S_F+S_0 includes compute/uncompute; A=H+pL; A inverse same cost; Vverification/reset; all costratios hypothetical; sharedpublishedangletraining/compilation offline/amortized,not included in perinstance kernel',
      'cost_objective':'global known-overlap expected restart cost; j0 included; exclude allj with trialcost>=incumbent. Conditional diagnostic, not executable unknown-a SATsolver.',
      'budget':{'wall_seconds':120,'peak_bytes':512*1024**2,'processes':1,'numerical_threads':1},'norm_tolerance':1e-10,
      'engine_sha256_lf':digest(ROOT/'2026-09-11-qaoa-source-replay.py'),'screen_sha256_lf':digest(__file__),
      'outcomes_examined_before_freeze':False,'on_UNSAT':'record K0 and stop no reselect no targetevolution'}
    mp=ROOT/(PREFIX+'-manifest.json');save(mp,manifest)
    print(json.dumps({'manifest':mp.name,'manifest_sha256_lf':digest(mp),'m':m,'formula_sha256_lf':digest(fpath),'outcomes_computed':False},indent=2))

def run(manifest_hash):
    mp=ROOT/(PREFIX+'-manifest.json')
    if digest(mp)!=manifest_hash:raise ValueError('manifesthashmismatch')
    m=json.loads(mp.read_text());assert digest(__file__)==m['screen_sha256_lf']
    enginepath=ROOT/'2026-09-11-qaoa-source-replay.py';assert digest(enginepath)==m['engine_sha256_lf']
    fpath=ROOT/m['formula_file'];assert digest(fpath)==m['formula_sha256_lf']
    engine=runpy.run_path(str(enginepath));checks=engine['self_test']();cost_checks=self_test()
    budget=engine['Budget']();f=json.loads(fpath.read_text());E,clause_stats=engine['energy_vector'](N,f['clauses'],budget)
    for x in [0,2**N-1]+[(i*104729)%(2**N) for i in range(1,65)]:
        assert E[x]==engine['literal_energy'](N,f['clauses'],x)
    K=int(np.sum(E==0));g=K/2**N
    r={'story':'S3046','manifest_sha256_lf':digest(mp),'screen_sha256_lf':digest(__file__),'engine_tests':checks,'cost_tests':cost_checks,
      'n':N,'m':len(f['clauses']),'source_preserving_clause_stats':clause_stats,'K':K,'uniform_success':g,
      'enumeration_scope':'offline independent diagnostic only, not a free quantumalgorithm operation','replays':{},'cost_screen':[]}
    if K:
        for p in [14,60]:
            print('Starting frozen independent depth '+str(p),flush=True)
            a=m['canonical_angles'][str(p)];start=time.perf_counter()
            psi,drift=engine['evolve'](N,E,a['beta'],a['gamma_journal'],budget)
            r['replays'][str(p)]={'success':float(np.sum(np.abs(psi[E==0])**2)),'max_norm_drift':drift,'seconds':time.perf_counter()-start}
            del psi
        for h,v in COST_GRID:
            base=optimum(g,h,1,v);cost={'H_over_R':h,'V_over_R':v,'uniform':base,'QAOA':{}}
            for p in [14,60]:cost['QAOA'][str(p)]=threshold(r['replays'][str(p)]['success'],p,h,v,base['expected_cost_R_units'])
            r['cost_screen'].append(cost)
        r['status']='completed independent ideal screen'
    else:r['status']='UNSAT generated instance; retained; no QAOA evolution or reselection'
    r['budget_observed']=budget.check()
    r['nonclaims']='One independent instance; hypothetical commoncost ratios; no compiledcost/hardware/classicaladvantage/generalSAT/P=NP or S3045 reproduction.'
    save(ROOT/(PREFIX+'-results.json'),r)
    print(json.dumps(r,indent=2))

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--prepare',action='store_true');p.add_argument('--run');p.add_argument('--self-test',action='store_true');args=p.parse_args()
    if args.self_test:print(self_test())
    if args.prepare:prepare()
    if args.run:run(args.run)
