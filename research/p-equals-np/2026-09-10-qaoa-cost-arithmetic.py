"""S3043 arithmetic checks only; no SAT/QAOA simulation or hardware forecast."""
import json
import math
from pathlib import Path

def main():
    theta = math.pi / 4
    theta_a = math.pi / 8
    rounds = math.ceil(math.pi / (8 * theta) - 0.5)
    stage_success = math.sin((2 * rounds + 1) * theta_a) ** 2
    assert rounds == 0
    assert abs(stage_success - (2 - math.sqrt(2)) / 4) < 1e-14
    assert stage_success < 0.5
    n, depth, colors, phase_cycles, distance = 179, 623, 2112, 27, 28
    clauses = 176 * n
    assumed_success = 2 ** (-0.69 * depth ** (-0.32) * n)
    ideal_iterations = math.pi / (4 * math.sqrt(assumed_success))
    iteration_cycles = (2 * depth * (colors + 2 * phase_cycles + 12)
                        + 4 * colors * math.log2(8 * clauses / colors)
                        + 4 * math.log2(n))
    iteration_seconds = iteration_cycles * distance * 1e-6
    serial_seconds = 2 ** (0.176 * n + 19.369) * 1e-9
    parallel_speed = (6.8 + 1 / 0.00098) / (6.8 + 1 / (0.00098 * 46))
    parallel_seconds = serial_seconds / parallel_speed
    threshold_assuming_factor4 = (math.pi * iteration_seconds / parallel_seconds) ** 2
    mean_success = 0.99 * 0.01 + 0.01 * 1e-12
    # Exact one-round schedule test, repeated until success, dimensionless cost.
    a = 0.1
    theta_test = math.asin(math.sqrt(a))
    one_round_success = math.sin(3 * theta_test) ** 2
    assert abs(one_round_success - 0.676) < 1e-12
    out = {
      'scope': 'Scalar arithmetic audit; fits and architectural assumptions not validated',
      'eq13_boundary': {'theta': theta, 'theta_a': theta_a, 'rounds': rounds,
                        'success': stage_success, 'claimed_stage_floor': 0.5},
      'source_equation_substitution': {
        'assumptions': {'n': n, 'p': depth, 'c': colors, 'n_P': phase_cycles,
                        'd': distance, 'cycle_seconds': 1e-6, 'cores': 46,
                        'warning': 'c and n_P are representative; not exact archived crossover inputs'},
        'assumed_success': assumed_success, 'ideal_iterations': ideal_iterations,
        'iteration_logical_cycles': iteration_cycles, 'iteration_seconds': iteration_seconds,
        'ideal_hours': ideal_iterations * iteration_seconds / 3600,
        'unverified_factor4_hours': 4 * ideal_iterations * iteration_seconds / 3600,
        'classical_serial_hours': serial_seconds / 3600,
        'assumed_parallel_speed': parallel_speed,
        'classical_parallel_hours': parallel_seconds / 3600,
        'unverified_factor4_classical_success_threshold': threshold_assuming_factor4},
      'synthetic_tail_counterexample': {'distribution': '99% at a=.01; 1% at a=1e-12',
        'mean_success': mean_success, 'inverse_sqrt_mean': 1 / math.sqrt(mean_success),
        'mean_inverse_sqrt': .99 / math.sqrt(.01) + .01 / math.sqrt(1e-12)},
      'schedule_formula_sanity': {'a': a, 'j': 1, 'success': one_round_success}
    }
    target = Path(__file__).with_suffix('.json')
    target.write_text(json.dumps(out, indent=2) + '\n', encoding='utf-8')
    print(json.dumps(out, indent=2))

if __name__ == '__main__':
    main()
