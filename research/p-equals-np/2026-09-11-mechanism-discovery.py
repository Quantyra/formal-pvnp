"""Exact bounded checks for S3055; no numerical approximation or SAT oracle."""
import itertools, json, time, hashlib
from pathlib import Path


def parity(x): return x.bit_count() & 1


def rref(rows, n):
    rows = list(set(rows))
    pivot = 0
    for j in range(n):
        k = next((k for k in range(pivot, len(rows)) if (rows[k][0] >> j) & 1), None)
        if k is None: continue
        rows[pivot], rows[k] = rows[k], rows[pivot]
        a, b = rows[pivot]
        for k in range(len(rows)):
            if k != pivot and ((rows[k][0] >> j) & 1):
                rows[k] = (rows[k][0] ^ a, rows[k][1] ^ b)
        pivot += 1
    if (0, 1) in rows: return None
    return tuple(rows[:pivot])


def normalize(cnf):
    out = []
    for clause in cnf:
        s = set(clause)
        if any(-x in s for x in s): continue
        out.append(tuple(sorted(s, key=lambda x: (abs(x), x))))
    return out


def holds(clause, x):
    return any(bool((x >> (abs(v)-1)) & 1) == (v > 0) for v in clause)


def extract(cnf, n, width=3):
    """Partition by exact support; replace a bucket only if its relation IS affine."""
    buckets = {}
    for c in normalize(cnf):
        buckets.setdefault(tuple(sorted(abs(v)-1 for v in c)), [])
        # A clause has distinct variables after normalization.
        buckets[tuple(sorted(abs(v)-1 for v in c))].append(c)
    affine, residual = [], []
    for support, clauses in sorted(buckets.items()):
        if len(support) > width:
            residual.extend(clauses); continue
        allowed = []
        for z in range(1 << len(support)):
            x = sum(((z >> j) & 1) << v for j, v in enumerate(support))
            if all(holds(c, x) for c in clauses): allowed.append(z)
        if not allowed:
            affine.append((0, 1)); continue
        equations = [(a, parity(a & allowed[0])) for a in range(1 << len(support))
                     if all(parity(a & z) == parity(a & allowed[0]) for z in allowed)]
        local = rref(equations, len(support))
        if len(allowed) != 1 << (len(support)-len(local)):
            residual.extend(clauses); continue
        for a, b in local:
            affine.append((sum(((a >> j) & 1) << v for j, v in enumerate(support)), b))
    return rref(affine, n), residual


def quotient(rows, n):
    if rows is None: return None
    pivots = [(a & -a).bit_length()-1 for a, b in rows]
    free = [j for j in range(n) if j not in pivots]
    particular = sum(b << j for j, (a, b) in zip(pivots, rows))
    basis = []
    for k in free:
        vec = 1 << k
        for j, (a, b) in zip(pivots, rows):
            if (a >> k) & 1: vec |= 1 << j
        basis.append(vec)
    return particular, basis


def count_terms(cnf, n):
    rows, residual = extract(cnf, n)
    q = quotient(rows, n)
    if q is None:
        return {'count': 0, 'affine_inconsistent': True, 'residual_clauses': len(residual),
                'stage_peak_keys': 0, 'transient_new_keys': 0, 'history': [], 'dimension': None}
    particular, basis = q
    d = len(basis)
    terms = {(): 1}
    history = [1]
    max_coeff_bits = 1
    transient_new_keys = 1
    for clause in residual:
        forbidden = []
        for v in clause:
            j = abs(v)-1
            mask = sum(((vec >> j) & 1) << k for k, vec in enumerate(basis))
            target = int(v < 0)
            forbidden.append((mask, target ^ ((particular >> j) & 1)))
        old = terms
        terms = dict(old)
        for space, coeff in old.items():
            intersection = rref(list(space) + forbidden, d)
            if intersection is not None:
                terms[intersection] = terms.get(intersection, 0) - coeff
                max_coeff_bits = max(max_coeff_bits, abs(terms[intersection]).bit_length())
                transient_new_keys = max(transient_new_keys, len(terms))
                if not terms[intersection]: del terms[intersection]
        history.append(len(terms))
        max_coeff_bits = max(max_coeff_bits, max((abs(c).bit_length() for c in terms.values()), default=0))
    count = sum(c * (1 << (d-len(s))) for s, c in terms.items())
    return {'count': count, 'affine_inconsistent': False, 'affine_rank': len(rows),
            'residual_clauses': len(residual), 'stage_peak_keys': max(history), 'transient_new_keys': transient_new_keys, 'history': history,
            'dimension': d, 'max_coefficient_bits': max_coeff_bits}


def xor_cnf(variables, charge):
    return [tuple(-(v+1) if (x >> j) & 1 else v+1 for j,v in enumerate(variables))
            for x in range(1 << len(variables)) if parity(x) != charge]


def brute(cnf,n):
    return sum(all(holds(c,x) for c in cnf) for x in range(1 << n))


def checks():
    fixtures = [(2, []), (2, [()]), (2, [(1,-1)]), (2, [(1,1)]),
                (2, [(1,),(-1,)]), (3, xor_cnf([0,1,2],1)),
                (3, [(1,2),(1,3)]), (3, [(1,2),(-1,2),(2,3)])]
    for n, cnf in fixtures:
        result = count_terms(cnf,n)
        assert result['count'] == brute(cnf,n)
        eqs, residual = extract(cnf,n)
        for x in range(1 << n):
            represented = eqs is not None and all(parity(a & x)==b for a,b in eqs) and all(holds(c,x) for c in residual)
            assert represented == all(holds(c,x) for c in cnf)
    # Canonicalization invariant under row ordering and redundant XOR sums.
    rows = [(0b011,1),(0b110,0)]
    canonical = rref(rows,3)
    for perm in itertools.permutations(rows + [(0b101,1)]): assert rref(perm,3)==canonical
    assert rref([(1,0),(1,1)],1) is None
    return len(fixtures)


def main():
    start = time.monotonic()
    output = {'scope':'exact finite mechanism checks, not a general performance study',
              'controls': checks(), 'families': []}
    graphs = {'K4':[(i,j) for i in range(4) for j in range(i+1,4)],
              'triangular_prism':[(0,1),(1,2),(2,0),(3,4),(4,5),(5,3),(0,3),(1,4),(2,5)]}
    for name, edges in graphs.items():
        vertices = max(max(e) for e in edges)+1
        for odd in [0,1]:
            cnf=[]
            for v in range(vertices):
                incident=[j for j,e in enumerate(edges) if v in e]
                cnf += xor_cnf(incident, int(odd and v==0))
            result=count_terms(cnf,len(edges))
            assert result['count']==brute(cnf,len(edges))
            assert result['count']==(0 if odd else 1 << (len(edges)-vertices+1))
            output['families'].append({'family':'Tseitin', 'graph':name,'odd_charge':odd,**result})
    for m in range(1,11):
        cnf=[(1,i+2) for i in range(m)]
        result=count_terms(cnf,m+1)
        assert result['history']==[1 << j for j in range(m+1)]
        assert result['count']==(1 << m)+1==brute(cnf,m+1)
        satisfying = [x for x in range(1 << (m+1)) if all(holds(c,x) for c in cnf)]
        hull_rank = len(rref([(x ^ satisfying[0],0) for x in satisfying], m+1))
        assert hull_rank == m+1
        for x in range(1 << (m+1)):
            first = bool(x & 1)
            second = not first and all((x >> j) & 1 for j in range(1,m+1))
            assert int(first)+int(second) == int(all(holds(c,x) for c in cnf))
        output['families'].append({'family':'connected_star','m':m,
            'global_affine_hull_dimension':hull_rank,'factored_positive_pieces':2,**result})
    for m in range(1,9):
        # Variables z=0,w=1,x_i=i+2. x_i=z, with residual x_i OR w.
        cnf=[]
        for i in range(m): cnf+=xor_cnf([0,i+2],0)+[(i+3,2)]
        result=count_terms(cnf,m+2)
        assert result['count']==3==brute(cnf,m+2)
        assert result['stage_peak_keys']==2 and result['dimension']==2
        output['families'].append({'family':'quotient_coincidence','m':m,**result})
    output['elapsed_seconds']=time.monotonic()-start
    output['script_sha256_lf']=hashlib.sha256(Path(__file__).read_bytes().replace(b'\r\n',b'\n')).hexdigest()
    destination=Path(__file__).with_suffix('.json')
    destination.write_text(json.dumps(output,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'controls':output['controls'],'family_cases':len(output['families']),
                      'elapsed_seconds':output['elapsed_seconds'],'result_file':destination.name}))

if __name__=='__main__': main()
