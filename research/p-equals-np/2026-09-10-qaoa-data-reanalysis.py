"""S3044 frozen-data diagnostics. No SAT search or quantum circuit simulation.
Pre-outcome choices: PCG64 seed 3044001 (strata), 3044002 (paired), 2000
formula-bootstrap replicates; linear quantiles; j=0,1,2,4,8,16,32 four times each.
Input JSONL rows: formula_id, depth, n, a (null if missing), optional K.
Manifest must assert frozen_before_analysis and explicit pairing_verified.
"""
import argparse
import hashlib
import json
import math
from pathlib import Path
import numpy as np

SEED = 3044001
PAIRED_SEED = 3044002
REPS = 2000
SCHEDULE = np.repeat([0, 1, 2, 4, 8, 16, 32], 4)

def clean(x):
    if isinstance(x, dict): return {str(k): clean(v) for k, v in x.items()}
    if isinstance(x, (list, tuple)): return [clean(v) for v in x]
    if isinstance(x, np.ndarray): return clean(x.tolist())
    if isinstance(x, (np.floating, float)):
        if math.isnan(x): return None
        if math.isinf(x): return 'Infinity' if x > 0 else '-Infinity'
        return float(x)
    if isinstance(x, np.integer): return int(x)
    if isinstance(x, np.bool_): return bool(x)
    return x

def invroot(a):
    with np.errstate(divide='ignore'): return 1 / np.sqrt(a)

def schedule(a):
    a = np.asarray(a, dtype=float)
    theta = np.arcsin(np.sqrt(a))
    q = np.ones_like(a)
    attempts = np.zeros_like(a)
    iterations = np.zeros_like(a)
    for j in SCHEDULE:
        attempts += q
        iterations += q * j
        s = np.sin((2*j+1)*theta)**2
        q *= np.clip(1-s, 0, 1)
    return attempts, iterations, q

def metrics(a):
    a = np.asarray(a, dtype=float)
    if not len(a): return {}
    roots = invroot(a)
    mean = float(np.mean(a))
    mean_inv = float(np.mean(roots))
    attempts, iterations, failure = schedule(a)
    return {
      'count': len(a), 'zeros': int(np.sum(a == 0)), 'mean_a': mean,
      'a_quantiles_q01_q05_q10_q50_q90': np.quantile(a, [.01,.05,.1,.5,.9]),
      'mean_inverse_sqrt_a': mean_inv,
      'inverse_sqrt_mean_a': 1/math.sqrt(mean) if mean else math.inf,
      'jensen_ratio': mean_inv*math.sqrt(mean) if mean else math.nan,
      'mean_scheduled_attempts': float(np.mean(attempts)),
      'mean_scheduled_iterations': float(np.mean(iterations)),
      'mean_symmetric_A_calls': float(np.mean(attempts+2*iterations)),
      'mean_fallback_probability': float(np.mean(failure)),
      'failure_quantiles_q50_q90_q99': np.quantile(failure, [.5,.9,.99]),
      'inverse_root_quantiles_q50_q90_q99': np.quantile(roots, [.5,.9,.99], method='inverted_cdf')
    }

def bootstrap(a, seed):
    if not len(a): return {}
    rng = np.random.Generator(np.random.PCG64(seed))
    roots=invroot(a)
    attempts, iterations, failure=schedule(a)
    values={k:[] for k in ['mean_a','median_a','mean_inverse_sqrt_a','jensen_ratio','mean_scheduled_attempts','mean_scheduled_iterations','mean_fallback_probability']}
    for _ in range(REPS):
        idx=rng.integers(0,len(a),len(a))
        am=float(np.mean(a[idx])); im=float(np.mean(roots[idx]))
        vals=[am,float(np.median(a[idx])),im,im*math.sqrt(am) if am else math.nan,
              float(np.mean(attempts[idx])),float(np.mean(iterations[idx])),float(np.mean(failure[idx]))]
        for k,v in zip(values,vals): values[k].append(v)
    # Inverted CDF avoids undefined interpolation between finite and infinity.
    return {k:np.quantile(np.asarray(v),[.025,.975],method='inverted_cdf') for k,v in values.items()}

def normalize(rows):
    unique={}; duplicates=0
    for raw in rows:
        r=dict(raw)
        k=r.get('K')
        if isinstance(k,float):
            if not math.isfinite(k) or not k.is_integer(): raise ValueError('K must be finite exact integer-valued')
            r['K']=int(k)
        for key in ['formula_id','depth','n','a']:
            if key not in r: raise ValueError('Missing explicit field: '+key)
        if not isinstance(r['formula_id'],str): raise ValueError('formula_id must be explicit string')
        key=(r['depth'],r['formula_id'])
        a=r['a']
        if a is not None and (not math.isfinite(a) or not 0<=a<=1):
            raise ValueError('Invalid probability for '+str(key))
        if r.get('K') is not None and (not isinstance(r['K'],int) or not 0<=r['K']<=2**r['n']):
            raise ValueError('Invalid exact K')
        if key in unique:
            if unique[key] != r: raise ValueError('Conflicting duplicate formula/depth '+str(key))
            duplicates+=1
        else: unique[key]=r
    return list(unique.values()),duplicates

def paired(rows, verified):
    if not verified: return {'status':'not performed: formula identity across depths unverified'}
    depths=sorted(set(r['depth'] for r in rows))
    if len(depths)!=2: return {'status':'not performed: requires frozen two-depth comparison'}
    maps=[{r['formula_id']:r for r in rows if r['depth']==d} for d in depths]
    ids=sorted(set(maps[0])&set(maps[1]))
    ids=[i for i in ids if maps[0][i]['a'] is not None and maps[1][i]['a'] is not None]
    a=np.array([maps[0][i]['a'] for i in ids]); b=np.array([maps[1][i]['a'] for i in ids])
    positive=(a>0)&(b>0)
    ratio=np.sqrt(a[positive]/b[positive])
    delta=b-a
    rng=np.random.Generator(np.random.PCG64(PAIRED_SEED))
    boot=[np.mean(delta[rng.integers(0,len(ids),len(ids))]) for _ in range(REPS)] if ids else []
    return {'status':'paired by source IDs; formula bytes not independently compared','depths':depths,'pairs':len(ids),
      'both_positive':int(np.sum(positive)), 'zeros_excluded_from_ratio':int(np.sum(~positive)),
      'fraction_second_overlap_larger':float(np.mean(b>a)) if ids else None,
      'mean_overlap_difference_second_minus_first':float(np.mean(delta)) if ids else None,
      'difference_bootstrap95':np.quantile(boot,[.025,.975]) if boot else None,
      'ideal_amplification_ratio_second_over_first_quantiles_q10_q50_q90':np.quantile(ratio,[.1,.5,.9]) if len(ratio) else None,
      'caveat':'ideal inverse-root ratio excludes all preparation/iteration cost; not runtime advantage'}

def analyze(rows, manifest):
    if not manifest.get('frozen_before_analysis'): raise ValueError('Missing pre-analysis freeze')
    if 'pairing_verified' not in manifest: raise ValueError('Pairing must be explicit')
    unique,dups=normalize(rows)
    if len(set(r['n'] for r in unique)) != 1: raise ValueError('Frozen configuration must have one n')
    if 'n' in manifest and any(r['n'] != manifest['n'] for r in unique): raise ValueError('Manifest n mismatch')
    if 'depths' in manifest and set(r['depth'] for r in unique) != set(manifest['depths']): raise ValueError('Manifest depths mismatch')
    config_ids=set(r.get('config_id','not_supplied') for r in unique)
    if len(config_ids)>1: raise ValueError('Cannot pool configurations')
    if manifest.get('config_id') and config_ids != {manifest['config_id']}: raise ValueError('Manifest configuration mismatch')
    if 'ids' in manifest:
        for depth in manifest['depths']:
            if set(r['formula_id'] for r in unique if r['depth']==depth) != set(manifest['ids']): raise ValueError('Frozen IDs mismatch')
    strata={}
    for depth in sorted(set(r['depth'] for r in unique)):
        group=[r for r in unique if r['depth']==depth]
        values=np.array([r['a'] for r in group if r['a'] is not None],dtype=float)
        exact=[r for r in group if r.get('K') is not None and r['a'] is not None]
        uniform={'status':'not computed: no verified exact K'}
        if exact:
            g=np.array([r['K']/2**r['n'] for r in exact]); qa=np.array([r['a'] for r in exact])
            valid=(g>0)&(qa>0)
            headroom=np.sqrt(qa[valid]/g[valid])
            uniform={'status':'subset with supplied exact K only','count':len(exact),
              'metrics':metrics(g),'matched_qaoa_metrics':metrics(qa),
              'zero_K_count':int(np.sum(g==0)),
              'positive_overlap_with_zero_K':int(np.sum((g==0)&(qa>0))),
              'ideal_allowable_iteration_overhead_quantiles_q10_q50_q90':np.quantile(headroom,[.1,.5,.9]) if len(headroom) else None,
              'caveat':'sqrt(a/g) is asymptotic iteration-cost headroom, not a compiled or exact runtime advantage'}
        strata[str(depth)]={'rows':len(group),'missing_a':sum(r['a'] is None for r in group),
          'missing_K':sum(r.get('K') is None for r in group),'n_values':sorted(set(r['n'] for r in group)),
          'metrics':metrics(values),'formula_bootstrap95':bootstrap(values,SEED+int(depth)),
          'uniform':uniform}
    return {'protocol':{'seed':SEED,'paired_seed':PAIRED_SEED,'bootstrap_reps':REPS,
      'schedule':SCHEDULE,'numpy_version':np.__version__,'quantiles':'a linear; inverse-root and bootstrap CI inverted_cdf','primary_materiality':'Jensen ratio lower 95% formula-bootstrap CI >2 rejects inverse-root-mean proxy for tested configuration; always report continuous results','conditioning':manifest.get('conditioning','unknown'),
      'missingness':'only supplied rows counted; omitted source population not reconstructed'},
      'rows_received':len(rows),'exact_duplicate_rows_removed':dups,'unique_formula_depth_rows':len(unique),
      'strata':strata,'paired':paired(unique,manifest['pairing_verified']),
      'cost_units':'attempts*A_initial + iterations*(A+A_inverse+S_F+S_0) + attempts*verification + failure*fallback; no compiled costs or seconds inferred'}

def self_test():
    z=metrics(np.array([0.])); assert math.isinf(z['mean_inverse_sqrt_a'])
    assert z['mean_scheduled_attempts']==28 and z['mean_scheduled_iterations']==252 and z['mean_fallback_probability']==1
    one=metrics(np.array([1.])); assert one['mean_scheduled_attempts']==1 and one['mean_scheduled_iterations']==0 and one['mean_fallback_probability']==0
    tail=metrics(np.array([.01]*99+[1e-12])); assert abs(tail['mean_inverse_sqrt_a']-10009.9)<1e-7
    r={'formula_id':'f','depth':14,'n':12,'a':.1}
    rows,dup=normalize([r,r]); assert len(rows)==1 and dup==1
    try: normalize([r,dict(r,a=.2)])
    except ValueError: pass
    else: raise AssertionError('conflicting duplicate not rejected')
    assert paired([r,dict(r,depth=60,a=.2)],False)['status'].startswith('not performed')
    assert normalize([dict(r,a=None)])[0][0]['a'] is None
    # Missing K is retained, not inferred from SAT conditioning or a positive overlap.
    assert 'K' not in normalize([r])[0][0]
    print('PASS: zero, one, nonlinear mean, duplicates, pairing gate, missingness, missing K')

def main():
    p=argparse.ArgumentParser(); p.add_argument('--input');p.add_argument('--manifest');p.add_argument('--output');p.add_argument('--self-test',action='store_true'); args=p.parse_args()
    if args.self_test:self_test()
    if not args.input:return
    src=Path(args.input); mp=Path(args.manifest)
    rows=[json.loads(l) for l in src.read_text(encoding='utf-8-sig').splitlines() if l.strip()]
    manifest=json.loads(mp.read_text(encoding='utf-8-sig'))
    result=analyze(rows,manifest)
    result['input_sha256']=hashlib.sha256(src.read_bytes()).hexdigest()
    result['manifest_sha256']=hashlib.sha256(mp.read_bytes()).hexdigest()
    result['manifest']={k:v for k,v in manifest.items() if k not in ['ids','selected_records']}
    # Post-freeze schema/consistency safeguard; not an outcome selection rule.
    normalized,_=normalize(rows)
    k_records=[r for r in normalized if r.get('K') is not None]
    uniform_records=[r for r in k_records if r.get('source_uniform') is not None]
    mismatches=[r for r in uniform_records if not math.isclose(r['source_uniform'],r['K']/2**r['n'],rel_tol=1e-12,abs_tol=1e-18)]
    by_id={}
    for r in k_records: by_id.setdefault(r['formula_id'],set()).add(r['K'])
    result['source_consistency']={'source_uniform_records':len(uniform_records),'uniform_mismatches':len(mismatches),'uniform_tolerance':'relative1e-12 absolute1e-18','max_uniform_absolute_difference':max((abs(r['source_uniform']-r['K']/2**r['n']) for r in uniform_records),default=None),'paired_K_mismatches':sum(len(v)>1 for v in by_id.values()),'K_min':min((r['K'] for r in k_records),default=None),'K_max':max((r['K'] for r in k_records),default=None),'K_zero_positive_a':sum(r['K']==0 and r['a'] is not None and r['a']>1e-12 for r in k_records),'K_all_assignments_nonunit_a':sum(r['K']==2**r['n'] and r['a'] is not None and abs(r['a']-1)>1e-12 for r in k_records)}
    result['cost_contrasts']={}
    for depth,st in result['strata'].items():
        if st['uniform'].get('count') == st['metrics'].get('count'):
            q=st['metrics']; g=st['uniform']['metrics']
            coef={'H':q['mean_symmetric_A_calls']-g['mean_symmetric_A_calls'],'L':int(depth)*q['mean_symmetric_A_calls'],'R':q['mean_scheduled_iterations']-g['mean_scheduled_iterations'],'V':q['mean_scheduled_attempts']-g['mean_scheduled_attempts'],'F':q['mean_fallback_probability']-g['mean_fallback_probability']}
            result['cost_contrasts'][depth]={'Q_minus_uniform_coefficients':coef,'layer_cost_upper_bound_coefficients':{k:-v/coef['L'] for k,v in coef.items() if k!='L'},'assumption':'common fixed component costs; A=H+pL, symmetric inverse; fallback budget in same unit'}
    result['post_freeze_changes']='Integer-valued source K float coercion, consistency/configuration safeguards, derived cost coefficients and compact manifest; metrics/seeds/sample/schedule unchanged.'
    Path(args.output).write_text(json.dumps(clean(result),indent=2,allow_nan=False)+'\n',encoding='utf-8')
    print('Wrote '+args.output)

if __name__=='__main__':main()
