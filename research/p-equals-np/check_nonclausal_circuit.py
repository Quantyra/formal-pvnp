"""Minimal exact checks for the specific shared-cofactor candidate, not a solver claim."""
import json
from itertools import product


class Dag:
    def __init__(self):
        self.nodes = [('const', 0), ('const', 1)]
        self.ids = {v: i for i, v in enumerate(self.nodes)}
        self.dep = [frozenset(), frozenset()]
        self.visits = 0
        self.lookups = 0
        self.cache = {}

    def intern(self, key, dep):
        self.lookups += 1
        if key not in self.ids:
            self.ids[key] = len(self.nodes)
            self.nodes.append(key)
            self.dep.append(dep)
        return self.ids[key]

    def var(self, name):
        return self.intern(('var', name), frozenset([name]))

    def op(self, op, a, b):
        a, b = sorted((a, b))
        if op == '+':
            if a == b:
                return 0
            if a == 0:
                return b
        if op == '*':
            if a == 0:
                return 0
            if a == 1 or a == b:
                return b
        return self.intern((op, a, b), self.dep[a] | self.dep[b])

    def cofactor(self, root, var, value):
        key = root, var, value
        self.visits += 1
        if key in self.cache:
            return self.cache[key]
        if var not in self.dep[root]:
            out = root
        else:
            node = self.nodes[root]
            if node[0] == 'var':
                out = value
            else:
                out = self.op(node[0], self.cofactor(node[1], var, value),
                              self.cofactor(node[2], var, value))
        self.cache[key] = out
        return out

    def exists(self, root, var):
        a = self.cofactor(root, var, 0)
        b = self.cofactor(root, var, 1)
        return self.op('+', self.op('+', a, b), self.op('*', a, b))

    def eval(self, root, env):
        cache = {}
        def visit(r):
            if r not in cache:
                node = self.nodes[r]
                if node[0] == 'const':
                    val = node[1]
                elif node[0] == 'var':
                    val = env[node[1]]
                else:
                    a, b = visit(node[1]), visit(node[2])
                    val = a ^ b if node[0] == '+' else a & b
                cache[r] = val
            return cache[r]
        return visit(root)


def mixed_check():
    d = Dag()
    x, y, z, u, v = [d.var(s) for s in 'xyzuv']
    f = d.op('+', d.op('*', x, y), z)
    g = d.op('+', d.op('*', x, u), v)
    s = d.op('*', d.op('+', 1, f), d.op('+', 1, g))
    projected = d.exists(s, 'x')
    # Independently evaluate the expanded squarefree projection derived in note.
    monomials = ['', 'z', 'v', 'zv', 'yz', 'yzv', 'uv', 'uzv',
                 'yuz', 'yuv', 'yuzv']
    for bits in product((0, 1), repeat=4):
        env = dict(zip('yzuv', bits))
        expected = any(((a * env['y']) ^ env['z']) == 0 and
                       ((a * env['u']) ^ env['v']) == 0 for a in (0, 1))
        expanded = 0
        for mon in monomials:
            term = 1
            for var in mon:
                term &= env[var]
            expanded ^= term
        assert d.eval(projected, env) == expanded == expected
    # XOR cofactors alone is wrong when both witnesses are valid.
    assert d.eval(d.op('+', d.cofactor(s, 'x', 0), d.cofactor(s, 'x', 1)),
                  dict(y=0, z=0, u=0, v=0)) == 0
    assert d.eval(projected, dict(y=0, z=0, u=0, v=0)) == 1
    after_y = d.exists(projected, 'y')
    for zb, ub, vb in product((0, 1), repeat=3):
        expected = 1 ^ vb ^ (ub & vb) ^ (ub & zb) ^ (ub & vb & zb)
        assert d.eval(after_y, dict(z=zb, u=ub, v=vb)) == expected
    after_u = d.exists(after_y, 'u')
    assert all(d.eval(after_u, dict(z=zb, v=vb)) == 1
               for zb, vb in product((0, 1), repeat=2))
    return {'outside_assignments_checked': 16, 'second_projection_checked': 8,
            'third_projection_checked': 4, 'nodes': len(d.nodes)}


def equality_case(k, interleaved):
    d = Dag()
    root = 1
    for i in range(k):
        xi, yi = d.var(f'x{i}'), d.var(f'y{i}')
        root = d.op('*', root, d.op('+', 1, d.op('+', xi, yi)))
    initial_nodes = len(d.nodes)
    order = ([f'{p}{i}' for i in range(k) for p in 'xy'] if interleaved else
             [f'{p}{i}' for p in 'xy' for i in range(k)])
    midpoint = None
    for i, var in enumerate(order):
        root = d.exists(root, var)
        if i + 1 == k:
            midpoint = len(d.nodes)
    assert root == 1
    # Count generated product gates whose Boolean function is a full y minterm.
    # Only for k<=4: independent truth tables, no semantic merging by algorithm.
    distinct_minterms = None
    if not interleaved and k <= 4:
        seen = set()
        for r in range(len(d.nodes)):
            if d.dep[r] and d.dep[r] <= {f'y{i}' for i in range(k)}:
                ones = tuple(j for j, bits in enumerate(product((0, 1), repeat=k))
                             if d.eval(r, dict(zip([f'y{i}' for i in range(k)], bits))))
                if len(ones) == 1:
                    seen.add(ones[0])
        distinct_minterms = len(seen)
        assert distinct_minterms == 2 ** k
    return dict(k=k, order='paired' if interleaved else 'all_x_then_y',
                initial_nodes=initial_nodes, midpoint_nodes=midpoint,
                total_nodes=len(d.nodes), cofactor_calls=d.visits,
                hash_lookups=d.lookups, distinct_minterms=distinct_minterms)


class LocalDag(Dag):
    """Add only syntactic complement/involution; no global factorization."""
    def negated_child(self, a):
        node = self.nodes[a]
        return node[2] if len(node) == 3 and node[:2] == ('+', 1) else None

    def op(self, op, a, b):
        if self.negated_child(a) == b or self.negated_child(b) == a:
            return 1 if op == '+' else 0
        if op == '+':
            if a == 1 and self.negated_child(b) is not None:
                return self.negated_child(b)
            if b == 1 and self.negated_child(a) is not None:
                return self.negated_child(a)
        return super().op(op, a, b)


def affine_xor_pivot(d, root, var):
    """Recognize S=x+G, x absent from G, by memoized XOR-spine traversal."""
    cache = {}
    def visit(r):
        if r in cache:
            return cache[r]
        node = d.nodes[r]
        if var not in d.dep[r]:
            out = False
        elif node == ('var', var):
            out = True
        elif node[0] == '+':
            a, b = visit(node[1]), visit(node[2])
            out = None if a is None or b is None else a ^ b
        else:
            out = None
        cache[r] = out
        return out
    recognized = visit(root) is True
    return recognized, len(cache)


def bucket_project(d, factors, order):
    scanned = 0
    pivot_visits = 0
    joined_sizes = []
    for var in order:
        scanned += len(factors)
        dependent, independent = [], []
        for f in factors:
            (dependent if var in d.dep[f] else independent).append(f)
        joint = 1
        for f in dependent:
            joint = d.op('*', joint, f)
        if dependent:
            joined_sizes.append(len(d.dep[joint]))
            pivot, cost = affine_xor_pivot(d, joint, var)
            pivot_visits += cost
            new = 1 if pivot else d.exists(joint, var)
            factors = independent + ([] if new == 1 else [new])
        else:
            factors = independent
    assert all(f in (0, 1) for f in factors)
    return int(0 not in factors), scanned, joined_sizes, pivot_visits


def bucket_case(k, hub_first):
    d = LocalDag()
    z = d.var('z')
    factors = []
    for i in range(k):
        x, y, u = [d.var(f'{p}{i}') for p in 'xyu']
        # Connected overlapping quadratic equations x_i+y_i+z*u_i=0.
        factors.append(d.op('+', 1, d.op('+', d.op('+', x, y), d.op('*', z, u))))
    if hub_first:
        order = ['z'] + [f'{p}{i}' for p in 'xyu' for i in range(k)]
    else:
        order = [f'x{i}' for i in range(k)] + ['z'] + [f'{p}{i}' for p in 'yu' for i in range(k)]
    result, scans, joined, pivot_visits = bucket_project(d, factors, order)
    assert result == 1
    return dict(k=k, order='hub_first' if hub_first else 'local_first',
                total_nodes=len(d.nodes), cofactor_calls=d.visits,
                factor_scans=scans, pivot_visits=pivot_visits,
                max_join_support=max(joined))


def factor_equality_check(k):
    d = LocalDag()
    factors = [d.op('+', 1, d.op('+', d.var(f'x{i}'), d.var(f'y{i}')))
               for i in range(k)]
    result, scans, _, pivot_visits = bucket_project(d, factors,
                                    [f'{p}{i}' for p in 'xy' for i in range(k)])
    assert result == 1
    return dict(k=k, total_nodes=len(d.nodes), cofactor_calls=d.visits,
                factor_scans=scans, pivot_visits=pivot_visits)


if __name__ == '__main__':
    print(json.dumps({'mixed': mixed_check(),
                      'equality': [equality_case(k, p)
                                   for k in range(1, 9) for p in (False, True)],
                      'factor_equality': factor_equality_check(8),
                      'mixed_buckets': [bucket_case(k, p) for k in range(2, 7)
                                        for p in (True, False)]},
                     indent=2))
