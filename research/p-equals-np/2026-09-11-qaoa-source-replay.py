"""S3045: one frozen paper-defined QAOA convention check, not a SAT solver.
Canonical journal convention: phase exp(-i gamma_journal E/2), then Rx(beta)
on every qubit. DIMACS literals, variable i is basis-index bit i-1. No tuning.
"""
import os
for key in ['OPENBLAS_NUM_THREADS','MKL_NUM_THREADS','OMP_NUM_THREADS','NUMEXPR_NUM_THREADS']:
    os.environ[key]='1'
import argparse
import ctypes
import hashlib
import json
import math
from pathlib import Path
import time
import numpy as np

NORM_TOL=1e-10
ABS_TOL=1e-8
REL_TOL=1e-6
MAX_SECONDS=120
MAX_BYTES=512*1024**2

def sha(path):return hashlib.sha256(Path(path).read_bytes()).hexdigest()

def memory_peak():
    if os.name=='nt':
        class PMC(ctypes.Structure):
            _fields_=[('cb',ctypes.c_ulong),('PageFaultCount',ctypes.c_ulong)]+[(x,ctypes.c_size_t) for x in ['PeakWorkingSetSize','WorkingSetSize','QuotaPeakPagedPoolUsage','QuotaPagedPoolUsage','QuotaPeakNonPagedPoolUsage','QuotaNonPagedPoolUsage','PagefileUsage','PeakPagefileUsage']]
        pmc=PMC();pmc.cb=ctypes.sizeof(pmc)
        ctypes.windll.kernel32.GetCurrentProcess.restype=ctypes.c_void_p
        f=ctypes.windll.psapi.GetProcessMemoryInfo
        f.argtypes=[ctypes.c_void_p,ctypes.POINTER(PMC),ctypes.c_ulong]
        if not f(ctypes.windll.kernel32.GetCurrentProcess(),ctypes.byref(pmc),pmc.cb):raise RuntimeError('memory monitoring failed')
        return int(pmc.PeakWorkingSetSize)
    import resource
    return int(resource.getrusage(resource.RUSAGE_SELF).ru_maxrss)*1024

class Budget:
    def __init__(self):self.start=time.perf_counter()
    def check(self):
        elapsed=time.perf_counter()-self.start;peak=memory_peak()
        if elapsed>MAX_SECONDS:raise RuntimeError('120-second wall budget exceeded')
        if peak>MAX_BYTES:raise RuntimeError('512-MiB process peak-memory budget exceeded')
        return {'elapsed_seconds':elapsed,'peak_working_set_bytes':peak}

def energy_vector(n,clauses,budget=None):
    if not isinstance(n,int) or not 0<=n<=20:raise ValueError('n outside frozen engine bound')
    idx=np.arange(2**n,dtype=np.uint32);energy=np.zeros(2**n,dtype=np.int32)
    patterns={};tautologies=0;repeated=0
    for clause in clauses:
        pos=neg=0;seen=set()
        for literal in clause:
            if not isinstance(literal,int) or literal==0 or abs(literal)>n:raise ValueError('invalid DIMACS literal')
            if literal in seen:repeated+=1
            seen.add(literal)
            if literal>0:pos|=1<<(literal-1)
            else:neg|=1<<(-literal-1)
        if pos&neg:tautologies+=1;continue
        key=(pos|neg,neg);patterns[key]=patterns.get(key,0)+1
    for j,((mask,target),multiplicity) in enumerate(patterns.items()):
        violation=(idx & mask)==target
        if multiplicity==1:np.add(energy,violation,out=energy)
        else:energy+=multiplicity*violation
        if budget and j%64==0:budget.check()
    return energy,{'clauses':len(clauses),'tautological_clauses':tautologies,'repeated_literal_occurrences':repeated,'distinct_nontautological_patterns':len(patterns),'empty_clauses':sum(not c for c in clauses)}

def literal_energy(n,clauses,x):
    return sum(not any(bool((x>>(abs(l)-1))&1)==(l>0) for l in clause) for clause in clauses)

def mix_bit(psi,beta,bit):
    stride=1<<bit;view=psi.reshape(-1,2,stride)
    oldleft=view[:,0,:].copy()
    c=math.cos(beta/2);s=-1j*math.sin(beta/2)
    view[:,0,:]=c*oldleft+s*view[:,1,:]
    view[:,1,:]=s*oldleft+c*view[:,1,:]

def evolve(n,energy,betas,gammas,budget=None):
    if len(betas)!=len(gammas):raise ValueError('angle length mismatch')
    psi=np.full(2**n,2**(-n/2),dtype=np.complex128)
    levels=np.arange(int(energy.max())+1)
    max_drift=0
    for beta,gamma in zip(betas,gammas):
        if not math.isfinite(beta) or not math.isfinite(gamma):raise ValueError('nonfinite angle')
        lookup=np.exp(-.5j*gamma*levels)
        psi*=lookup[energy]
        for bit in range(n):
            mix_bit(psi,beta,bit)
            if budget:budget.check()
        drift=abs(float(np.vdot(psi,psi).real)-1)
        max_drift=max(max_drift,drift)
        if drift>NORM_TOL:raise RuntimeError('norm drift exceeds frozen tolerance; no renormalization')
    return psi,max_drift

def self_test():
    clauses=[[1],[-2],[1,1],[2,-2],[],[3,-1,3]]
    E,stats=energy_vector(3,clauses)
    assert np.array_equal(E,[literal_energy(3,clauses,x) for x in range(8)])
    assert stats['tautological_clauses']==1 and stats['repeated_literal_occurrences']==2
    # Check a specific bit against direct basis-index matrix action.
    vec=np.array([complex(i,7-i) for i in range(8)],dtype=complex);vec/=np.linalg.norm(vec)
    for bit in range(3):
        got=vec.copy();mix_bit(got,.37,bit)
        want=math.cos(.37/2)*vec-1j*math.sin(.37/2)*vec[np.arange(8)^(1<<bit)]
        assert np.max(np.abs(got-want))<1e-12
    E,_=energy_vector(3,[[1,-2],[3],[2,-2],[1,1]])
    bs=[.2,-.7,.4];gs=[.8,.1,-.3]
    got,_=evolve(3,E,bs,gs)
    ref=np.full(8,1/math.sqrt(8),dtype=complex)
    for b,g in zip(bs,gs):
        rot=np.array([[math.cos(b/2),-1j*math.sin(b/2)],[-1j*math.sin(b/2),math.cos(b/2)]])
        matrix=np.kron(np.kron(rot,rot),rot)
        ref=matrix@np.diag(np.exp(-.5j*g*E))@ref
    assert np.max(np.abs(got-ref))<1e-12
    for bs,gs in [([.3,.7],[0.,0.]),([0.,0.],[.4,.9])]:
        psi,_=evolve(3,E,bs,gs);assert np.max(np.abs(np.abs(psi)**2-1/8))<1e-12
    E,_=energy_vector(1,[[1]])
    psi,_=evolve(1,E,[math.pi/2],[-math.pi]);assert abs(abs(psi[1])**2-1)<1e-12
    psi,_=evolve(1,E,[math.pi/2],[math.pi]);assert abs(psi[1])**2<1e-12
    assert memory_peak()<MAX_BYTES
    return {'status':'PASS','checks':['signed/repeated/tautological/empty clauses','basis-bit order','small dense Kronecker reference','zero mixer/phase uniform probabilities','one-qubit analytic sign example','norm conservation','process memory monitor'],'dense_absolute_tolerance':1e-12}

def main():
    parser=argparse.ArgumentParser();parser.add_argument('--self-test',action='store_true');parser.add_argument('--manifest');parser.add_argument('--manifest-sha256');parser.add_argument('--output');args=parser.parse_args()
    checks=self_test()
    if args.self_test:print(json.dumps(checks))
    if not args.manifest:return
    if not args.manifest_sha256 or sha(args.manifest)!=args.manifest_sha256.lower():raise ValueError('frozen manifest hash missing/mismatched')
    path=Path(args.manifest);m=json.loads(path.read_text(encoding='utf-8-sig'))
    if m.get('evidence_label')!='paper-defined convention check':raise ValueError('wrong evidence label')
    if m.get('formula_id')!='101678_3_1653518225511123992':raise ValueError('wrong fixed source ID')
    if m.get('depths')!=[14,60]:raise ValueError('wrong frozen depths')
    fpath=path.parent/m['formula_file']
    if sha(fpath)!=m['formula_sha256']:raise ValueError('formula hash mismatch')
    formula=json.loads(fpath.read_text(encoding='utf-8-sig'));n=formula['n'];clauses=formula['clauses']
    if n!=20:raise ValueError('wrong source n')
    for p in m['depths']:
        angles=m['canonical_angles'][str(p)]
        if len(angles['beta'])!=p or len(angles['gamma_journal'])!=p:raise ValueError('explicit depth/angle mismatch')
    budget=Budget();E,clause_stats=energy_vector(n,clauses,budget)
    # Fixed arithmetic checkpoints do not depend on outcomes or satisfying assignments.
    probes=[0,2**n-1]+[(i*104729)%(2**n) for i in range(1,65)]
    for x in probes:
        if E[x]!=literal_energy(n,clauses,x):raise RuntimeError('independent literal evaluator mismatch')
    actual_K=int(np.sum(E==0))
    if actual_K!=m['source_K']:raise RuntimeError('source solution count mismatch')
    result={'story':'S3045','evidence_label':m['evidence_label'],'formula_id':m['formula_id'],'manifest_sha256':sha(path),'formula_sha256':sha(fpath),'script_sha256_lf':hashlib.sha256(Path(__file__).read_bytes().replace(b'\r\n',b'\n')).hexdigest(),'numpy_version':np.__version__,'budget':{'wall_seconds':MAX_SECONDS,'memory_bytes':MAX_BYTES,'processes':1,'numerical_library_threads':1},'tolerances':{'source_absolute':ABS_TOL,'source_relative':REL_TOL,'max_norm_drift':NORM_TOL},'self_tests':checks,'formula_checks':clause_stats|{'independent_literal_probes':len(probes),'K':actual_K},'replays':{}}
    for p in m['depths']:
        print('Starting frozen depth '+str(p),flush=True)
        ang=m['canonical_angles'][str(p)]
        started=time.perf_counter();psi,drift=evolve(n,E,ang['beta'],ang['gamma_journal'],budget)
        success=float(np.sum(np.abs(psi[E==0])**2));target=m['source_probabilities'][str(p)]
        tol=ABS_TOL+REL_TOL*abs(target)
        result['replays'][str(p)]={'success':success,'source_success':target,'absolute_error':abs(success-target),'allowed_error':tol,'match':abs(success-target)<=tol,'max_norm_drift':drift,'elapsed_seconds':time.perf_counter()-started}
        del psi
    result['observed_budget']=budget.check()
    result['all_match']=all(r['match'] for r in result['replays'].values())
    result['scope']='One paper-defined ideal circuit comparison; not a recovered original-driver replication, ensemble result, logical-cost advantage or P=NP claim.'
    Path(args.output).write_text(json.dumps(result,indent=2,allow_nan=False)+'\n',encoding='utf-8')
    print(json.dumps(result,indent=2))

if __name__=='__main__':main()

