"""S3048 fixed-construction accounting; no statevector evolution or new samples."""
import argparse, hashlib, json, math, runpy
from pathlib import Path
from datetime import datetime, timezone
ROOT=Path(__file__).resolve().parent
PREFIX='2026-09-11-qaoa-logical-cost'
INPUTS=['2026-09-11-qaoa-fixed-batch-formulas.jsonl','2026-09-11-qaoa-fixed-batch-results.json','2026-09-11-qaoa-independent-cost-screen.py',PREFIX+'-preregistration.md',PREFIX+'.py']
def digest(p):return hashlib.sha256(p.read_bytes().replace(b'\r\n',b'\n')).hexdigest()
def save(p,d):p.write_text(json.dumps(d,indent=2,allow_nan=False)+'\n',encoding='utf-8')
def simplify(clauses):
 out=[]
 for c in clauses:
  v=set(c)
  if any(-x in v for x in v):continue
  if not v:raise ValueError('empty clause: no SAT kernel')
  out.append(sorted(v,key=lambda x:(abs(x),x)))
 return out

def vector(t=0,c=0,r=0):return {'Toffoli':t,'explicit_Clifford':c,'Rz':r}
def plus(a,b):return {k:a[k]+b[k] for k in a}
def scale(a,p):return {k:p*a[k] for k in a}
def gates(a,rho):return 15*a['Toffoli']+a['explicit_Clifford']+rho*a['Rz']
def blocks(n,clauses):
 cs=simplify(clauses);q=len(cs)
 if not q:raise ValueError('tautology-only formula: trivial predicate, no SAT kernel')
 ws=[len(c) for c in cs];t=sum(w-1 for w in ws);u=sum(w==1 for w in ws);pos=sum(x>0 for c in cs for x in c)
 L=vector(2*t,2*pos+2*u+2*n,q+n)
 SF=vector(2*t+2*(q-1),4*pos+2*u+2*q+1)
 S0=vector(2*(n-1),2*n+1)
 V=vector(SF['Toffoli'],SF['explicit_Clifford']-1)
 return {'original_clauses':len(clauses),'retained_clauses':q,'tautologies_removed':len(clauses)-q,'width_histogram':{str(w):ws.count(w) for w in sorted(set(ws))},'literal_occurrences':sum(ws),'positive_literal_occurrences':pos,'sum_w_minus_1':t,'unit_clauses':u,
 'H':vector(c=n),'L':L,'SAT_mark':SF,'zero_reflection':S0,'R':plus(SF,S0),'V_reversible':V,
 'ancilla_phase':max(max(1,w-1) for w in ws),'ancilla_predicate':sum(max(1,w-1) for w in ws)+q-1,'ancilla_zero_reflection':n-1,'peak_clean_ancillas':max(sum(max(1,w-1) for w in ws)+q-1,n-1),
 'classical_verification_per_trial':{'literal_inspections':sum(ws),'OR_operations':t,'AND_operations':q-1},'measurement_reset_per_trial':{'primary_measurements':n,'secondary_measurements':n+1,'data_resets':n}}

def self_test():
 assert simplify([[1,1,-2],[2,-2,3],[1,-2]])==[[1,-2],[1,-2]]
 b=blocks(3,[[1,1,-2],[2,-2,3],[-3]])
 assert b['L']==vector(2,10,5)
 assert b['SAT_mark']==vector(4,11)
 assert b['peak_clean_ancillas']==3
 assert b['V_reversible']==vector(4,10)
 assert b['classical_verification_per_trial']=={'literal_inspections':3,'OR_operations':1,'AND_operations':1}
 assert blocks(2,[[1]])['SAT_mark']==vector(0,9)
 for f in [[],[[1,-1]],[[]]]:
  try:blocks(2,f)
  except ValueError:pass
  else:raise AssertionError('trivial/UNSAT guard')
 # Truth-preserving preprocessing including duplicate clause multiplicity.
 f=[[1,1,-2],[1,-1],[1,-2],[-3]];c=simplify(f)
 def energy(f,x):return sum(not any(bool((x>>(abs(v)-1))&1)==(v>0) for v in cl) for cl in f)
 assert all(energy(f,x)==energy(c,x) for x in range(8))
 return 'PASS preprocessing, repeated clauses, unit/tautology/empty guards, independent small counts and energy'

def freeze():
 save(ROOT/(PREFIX+'-freeze.json'),{'story':'S3048','frozen_utc':datetime.now(timezone.utc).isoformat(),'files_sha256_lf':{n:digest(ROOT/n) for n in INPUTS},'rho_grid':[0,10,30,60,100],'target_counts_examined':False,'tests':self_test()})
 print(digest(ROOT/(PREFIX+'-freeze.json')))

def run(pin):
 fp=ROOT/(PREFIX+'-freeze.json');assert digest(fp)==pin
 freeze=json.loads(fp.read_text());assert all(digest(ROOT/n)==h for n,h in freeze['files_sha256_lf'].items())
 old=runpy.run_path(str(ROOT/'2026-09-11-qaoa-independent-cost-screen.py'));optimum=old['optimum'];success=old['success']
 prior=json.loads((ROOT/INPUTS[1]).read_text());forms={r['seed']:r for r in map(json.loads,(ROOT/INPUTS[0]).read_text().splitlines())}
 rows=[]
 for r in prior['results']:
  if not r['K']:continue
  seed=r['seed'];f=forms[seed];b=blocks(f['n'],f['clauses']);out={'seed':seed,'K':r['K'],'blocks':b,'comparisons':[]}
  for policy in ['classical_measured','reversible_measured']:
   for rho in freeze['rho_grid']:
    H=gates(b['H'],rho);L=gates(b['L'],rho);R=gates(b['R'],rho);V=0 if policy=='classical_measured' else gates(b['V_reversible'],rho)
    base=optimum(r['K']/2**f['n'],H,R,V);base['expected_unitary_gates']=base.pop('expected_cost_R_units')
    entry={'verification':policy,'rho':rho,'H':H,'L':L,'R':R,'V':V,'H_over_R':H/R,'V_over_R':V/R,'L_over_R':L/R,'uniform':base,'QAOA':{}}
    for p in [14,60]:
     a=r['replays'][str(p)]['success'];q=optimum(a,H+p*L,R,V);q['expected_unitary_gates']=q.pop('expected_cost_R_units');j=q['j'];s=q['success_per_trial'];nr=(1+2*j)*p*b['L']['Rz'];trial=(1+2*j)*(H+p*L)+j*R+V
     q.update({'a':a,'cost_ratio_to_uniform':q['expected_unitary_gates']/base['expected_unitary_gates'],'rotations_per_trial':nr,'required_per_rotation_operator_error':1e-4/nr,'conservative_fixed_j_cost_with_2e_4_probability_error':trial/(s-2e-4) if s>2e-4 else None,'A_vector':plus(b['H'],scale(b['L'],p))})
     entry['QAOA'][str(p)]=q
    out['comparisons'].append(entry)
  rows.append(out)
 assert len(rows)==7
 result={'story':'S3048','freeze_sha256_lf':pin,'tests':self_test(),'rows':rows,'T_only_primary':'j0 uniform repetition has zero T count; no positive-T advantage possible in that objective','nonclaims':'symbolic full rotation length; ideal overlaps; no synthesized circuit, full-runtime, unknown-a SAT, practical advantage, scaling or P=NP claim'}
 save(ROOT/(PREFIX+'-results.json'),result)
 for row in rows:
  e=row['comparisons'][0];print(row['seed'],row['K'],row['blocks']['retained_clauses'],row['blocks']['peak_clean_ancillas'],e['uniform']['j'],[round(e['QAOA'][str(p)]['cost_ratio_to_uniform'],4) for p in [14,60]])

if __name__=='__main__':
 ap=argparse.ArgumentParser();ap.add_argument('--self-test',action='store_true');ap.add_argument('--freeze',action='store_true');ap.add_argument('--run');args=ap.parse_args()
 if args.self_test:print(self_test())
 if args.freeze:freeze()
 if args.run:run(args.run)
