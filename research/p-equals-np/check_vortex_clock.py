"""Exact arithmetic checks of claims in 2026-09-08-vortex-clock-attempt.md.

Run: python research/p-equals-np/check_vortex_clock.py
No fluid realization, all-input complexity theorem or SAT claim is tested.
"""

from fractions import Fraction
import json


def check_clock(q, n):
    gate_count = (n * n + 1) * (1 << n)
    root = Fraction(q, q + gate_count)
    gap = root**q
    # root is a positive exact qth-root witness, not a floating approximation.
    assert root > 0 and root**q == gap
    assert q * (1 / root - 1) == gate_count
    next_gap = Fraction(q, q + gate_count + 1)**q
    reserved_gap = Fraction(q, q + 2 * gate_count)**q
    slot = gap - next_gap
    lower = Fraction(q**(q + 1), (q + gate_count + 1)**(q + 1))
    upper = Fraction(q**(q + 1), (q + gate_count)**(q + 1))
    assert lower <= slot <= upper
    assert 0 < reserved_gap < gap < 1
    assert gap.denominator.bit_length() <= q * (q + gate_count).bit_length()
    return {
        "q": q, "n": n, "gate_count_bits": gate_count.bit_length(),
        "gap_denominator_bits": gap.denominator.bit_length(),
        "phase_endpoint_identity": True, "slot_bounds": True,
        "reserved_pre_singularity_margin": True,
    }


if __name__ == "__main__":
    for q in (101, 1009):
        for n in (4, 8, 16, 32, 64):
            print(json.dumps(check_clock(q, n), sort_keys=True))
    # exp(4)>1+4+4^2/2!+4^3/3! bounds the contraction without floating point.
    exp4_lower = Fraction(1) + 4 + 8 + Fraction(64, 6)
    endpoint_error_upper = Fraction(33, 16) / exp4_lower + Fraction(1, 16)
    assert endpoint_error_upper < Fraction(1, 4)
    print(json.dumps({"rational_one_bit_error_upper": str(endpoint_error_upper),
                      "less_than_one_quarter": True}))
