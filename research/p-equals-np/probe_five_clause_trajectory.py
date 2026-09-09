"""One bounded, NON-VALIDATED numerical probe of the specified nine-state IVP.

Run: python research/p-equals-np/probe_five_clause_trajectory.py
No tolerance sweep, random restart, or formula search. Float errors are not
certified by solve_ivp tolerances. Boolean witness verification is exact.
"""
import json
import math
import scipy
import numpy as np
from scipy.integrate import solve_ivp

CLAUSES = ((-1, -1, -1), (-1, 1, 1), (1, -1, 1),
           (1, 1, -1), (1, 1, 1))
HORIZON = 512


def residuals(spins):
    return np.array([math.prod(1-c[i]*spins[i] for i in range(3))/8
                     for c in CLAUSES])


def field(active):
    def rhs(_, y):
        s, b, rho = y[:3], y[3:8], y[8]
        k = residuals(s)
        g = np.array([sum(2*b[m]*c[i]*k[m]
                         * math.prod(1-c[j]*s[j] for j in range(3) if j != i)/8
                         for m, c in enumerate(CLAUSES)) for i in range(3)])
        h = k.copy()
        h[active] += 1
        mean = float(b @ h)
        return np.concatenate((g, rho*b*(h-mean), [-rho*rho*mean]))
    return rhs


def verify(witness):
    return all(any(c[i]*witness[i] == 1 for i in range(3)) for c in CLAUSES)


def main():
    y = np.array([1/8, 1/4, 3/8] + [1/5]*6, dtype=float)
    records = []
    nfev = 0
    hit = None
    for slot in range(HORIZON):
        sol = solve_ivp(field(slot % 5), (slot, slot+1), y,
                        method="DOP853", rtol=1e-11, atol=1e-13)
        if not sol.success:
            raise RuntimeError(sol.message)
        y = sol.y[:, -1]
        nfev += sol.nfev
        witness = tuple(1 if v >= 0 else -1 for v in y[:3])
        record = {"xi": slot+1, "spins": y[:3].tolist(),
                  "weights": y[3:8].tolist(), "rho": float(y[8]),
                  "max_residual": float(max(residuals(y[:3]))),
                  "rounded_witness": witness, "boolean_verified": verify(witness)}
        if slot < 5 or (slot+1) % 10 == 0:
            records.append(record)
        if verify(witness) and min(abs(v) for v in y[:3]) > 1/100:
            hit = record
            if not records or records[-1]["xi"] != slot+1:
                records.append(record)
            break
    print(json.dumps({"scope": "nonvalidated floating IVP probe; exact Boolean check",
                      "scipy_version": scipy.__version__, "horizon_cap": HORIZON,
                      "method": "DOP853", "rtol": 1e-11, "atol": 1e-13,
                      "clause_order": CLAUSES, "records": records,
                      "first_integer_margin_hit": hit, "nfev": nfev}, indent=2))


if __name__ == "__main__":
    main()
