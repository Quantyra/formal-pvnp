"""S3047 fixed batch: no outcome-based selection; reuse immutable S3045/46 kernels."""
import os
for key in ['OPENBLAS_NUM_THREADS','MKL_NUM_THREADS','OMP_NUM_THREADS']:os.environ[key]='1'
import argparse,hashlib,json,runpy,time
from datetime import datetime,timezone
from pathlib import Path
import numpy as np

ROOT=Path(__file__).resolve().parent
PREFIX='2026-09-11-qaoa-fixed-batch'
SEEDS=list(range(20260912,20260928));N=16;RATIO=176.54;KCLAUSE=8
GRID=[(.01,.01),(.1,.1),(1.,1.)]
ENGINE='2026-09-11-qaoa-source-replay.py'
COST='2026-09-11-qaoa-independent-cost-screen.py'

def sha(path):return hashlib.sha256(Path(path).read_bytes().replace(b'\r\n',b'\n')).hexdigest()
def canonical(obj):return json.dumps(obj,sort_keys=True,separators=(',',':'),allow_nan=False)
def object_sha(obj):return hashlib.sha256(canonical(obj).encode()).hexdigest()
def save(path,obj):path.write_text(json.dumps(obj,indent=2,allow_nan=False)+'\n',encoding='utf-8')

def prepare():
    formulas=[]
    for seed in SEEDS:
        rng=np.random.Generator(np.random.PCG64(seed));m=int(rng.poisson(RATIO*N));clauses=[]
        for _ in range(m):
            variables=rng.integers(1,N+1,size=KCLAUSE);signs=rng.integers(0,2,size=KCLAUSE)
            clauses.append([int(-x if b else x) for x,b in zip(variables,signs)])
        formulas.append({'seed':seed,'n':N,'clauses':clauses})
    fp=ROOT/(PREFIX+'-formulas.jsonl');fp.write_text(''.join(canonical(f)+'\n' for f in formulas),encoding='utf-8')
    source=json.loads((ROOT/'2026-09-11-qaoa-recovered-angles.json').read_text(encoding='utf-8-sig'))
    assert object_sha(source['arrays'])=='7d49c1c721937c876896f067cddb6803e1c793df43fe55d52aba868d5616e8f8'
    angles={p:{'beta':v['betas'],'gamma_journal':[-g for g in v['gammas']]} for p,v in source['arrays'].items()}
    m={'story':'S3047','frozen_utc':datetime.now(timezone.utc).isoformat(),'n':N,'k':8,'r':RATIO,'seeds':SEEDS,'historical_excluded_seed':20260911,
       'rng':'NumPyPCG64','numpy_version':np.__version__,'generation':'Perseed drawmPoisson(176.54*16); perclause8variables1..16 replacement, then8bits1negates; noSATrejection.',
       'formulas_file':fp.name,'formulas_sha256_lf':sha(fp),'formulas':[{'seed':f['seed'],'clauses':len(f['clauses']),'canonical_sha256':object_sha(f)} for f in formulas],
       'depths':[14,60],'canonical_angles':angles,'source_arrays_canonical_sha256':object_sha(source['arrays']),
       'operators':'journal phaseexp(-i gamma_journal E/2), then Rx(beta), storedorder; gamma_journal=-storedgamma, betaunchanged',
       'cost_grid_H_over_R_V_over_R':GRID,'cost_model':'Same S3046: R=fullmark+reflection, A=H+pL, inverse charged, verification/resetV; hypothetical commonunits, known-a diagnostic global restart optimization, offline/amortized training/compilation',
       'budget':{'pair_seconds':120,'total_seconds':600,'peak_memory_bytes':512*1024**2,'processes':1,'numerical_threads':1},'norm_tolerance':1e-10,
       'stop_rule':'Retainall16; K0 no evolution; p14/p60 on everySAT; no substitution/extension; budgetfailure leaves laterIDs pending not deleted.',
       'engine_sha256_lf':sha(ROOT/ENGINE),'cost_sha256_lf':sha(ROOT/COST),'batch_script_sha256_lf':sha(__file__),'outcomes_examined':False}
    mp=ROOT/(PREFIX+'-manifest.json');save(mp,m)
    print(json.dumps({'manifest':mp.name,'manifest_sha256_lf':sha(mp),'formulas_sha256_lf':sha(fp),'count':len(formulas),'outcomes_computed':False},indent=2))

def summarize(results):
    sat=[r for r in results if r['K']>0];unsat=[r for r in results if r['K']==0]
    out={'processed':len(results),'SAT':len(sat),'UNSAT':len(unsat),'conditioning':'QAOA/threshold summaries conditional onSAT among thisfixed16; no populationinference','depths':{},'cost_thresholds':[]}
    for p in [14,60]:
        vals=[r['replays'][str(p)]['success'] for r in sat if str(p) in r['replays']]
        if vals:out['depths'][str(p)]={'count':len(vals),'zero_overlaps':sum(a==0 for a in vals),'mean_success':float(np.mean(vals)),'median_success':float(np.median(vals)),'min_success':min(vals),'max_success':max(vals)}
    if sat:
        out['p60_overlap_greater_count']=sum(r['replays'].get('60',{}).get('success',0)>r['replays'].get('14',{}).get('success',0) for r in sat)
        for index,(h,v) in enumerate(GRID):
            item={'H_over_R':h,'V_over_R':v,'depths':{}}
            for p in [14,60]:
                thresholds=[r['cost_screen'][index]['QAOA'][str(p)] for r in sat if len(r['cost_screen'])>index]
                positive=[t['max_L_over_R'] for t in thresholds if t['status']=='conditional positive break-even']
                item['depths'][str(p)]={'evaluated':len(thresholds),'positive_count':len(positive),'no_positive_count':len(thresholds)-len(positive),'positive_min':min(positive) if positive else None,'positive_median':float(np.median(positive)) if positive else None,'positive_max':max(positive) if positive else None}
            out['cost_thresholds'].append(item)
    return out

def run(expected):
    mp=ROOT/(PREFIX+'-manifest.json');assert sha(mp)==expected
    m=json.loads(mp.read_text());assert sha(__file__)==m['batch_script_sha256_lf']
    assert sha(ROOT/ENGINE)==m['engine_sha256_lf'] and sha(ROOT/COST)==m['cost_sha256_lf']
    fp=ROOT/m['formulas_file'];assert sha(fp)==m['formulas_sha256_lf']
    forms=[json.loads(s) for s in fp.read_text().splitlines()];assert [f['seed'] for f in forms]==SEEDS
    for f,pin in zip(forms,m['formulas']):assert object_sha(f)==pin['canonical_sha256']
    engine=runpy.run_path(str(ROOT/ENGINE));cost=runpy.run_path(str(ROOT/COST))
    checks={'engine':engine['self_test'](),'cost':cost['self_test']()}
    r={'story':'S3047','manifest_sha256_lf':sha(mp),'checks':checks,'results':[],'pending_seeds':SEEDS.copy(),'status':'RUNNING','nonclaims':'Independent16draws, no source-replay or population/scaling/compiledcost/hardware/classical/P=NP claim'}
    start=time.perf_counter();rp=ROOT/(PREFIX+'-results.json');save(rp,r)
    try:
        for f in forms:
            if time.perf_counter()-start>600:raise RuntimeError('total600secondscapexceeded')
            pairbudget=engine['Budget']();E,cs=engine['energy_vector'](N,f['clauses'],pairbudget)
            for x in [0,2**N-1]+[(i*104729)%(2**N) for i in range(1,65)]:assert E[x]==engine['literal_energy'](N,f['clauses'],x)
            K=int(np.sum(E==0));g=K/2**N
            row={'seed':f['seed'],'m':len(f['clauses']),'K':K,'uniform_success':g,'clause_stats':cs,'replays':{},'cost_screen':[]}
            r['active_partial']=row
            if K:
                for p in [14,60]:
                    angles=m['canonical_angles'][str(p)]
                    psi,drift=engine['evolve'](N,E,angles['beta'],angles['gamma_journal'],pairbudget)
                    row['replays'][str(p)]={'success':float(np.sum(np.abs(psi[E==0])**2)),'max_norm_drift':drift};del psi
                    if time.perf_counter()-start>600:raise RuntimeError('total600secondscapexceeded')
                for h,v in GRID:
                    base=cost['optimum'](g,h,1,v);item={'H_over_R':h,'V_over_R':v,'uniform':base,'QAOA':{}}
                    for p in [14,60]:item['QAOA'][str(p)]=cost['threshold'](row['replays'][str(p)]['success'],p,h,v,base['expected_cost_R_units'])
                    row['cost_screen'].append(item)
            if time.perf_counter()-start>600:raise RuntimeError('total600secondscapexceededaftercost')
            row['budget']=pairbudget.check();del E
            r['results'].append(row);r.pop('active_partial',None);r['pending_seeds'].remove(f['seed']);r['summary']=summarize(r['results']);save(rp,r)
            print(json.dumps({'seed':row['seed'],'K':K,'overlaps':row['replays']},separators=(',',':')),flush=True)
        r['status']='COMPLETE';r['elapsed_seconds']=time.perf_counter()-start;r['peak_working_set_bytes']=engine['memory_peak']()
    except Exception as e:
        r['status']='INCOMPLETE_STOP';r['error']=repr(e);r['elapsed_seconds']=time.perf_counter()-start;save(rp,r);raise
    save(rp,r);print(json.dumps({'status':r['status'],'elapsed_seconds':r['elapsed_seconds'],'summary':r['summary']},indent=2))

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--prepare',action='store_true');p.add_argument('--run');a=p.parse_args()
    if a.prepare:prepare()
    if a.run:run(a.run)

