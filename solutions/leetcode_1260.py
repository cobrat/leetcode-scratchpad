import sys


def core_logic(m: int, n: int, k: int, flat_grid: list) -> list:
    total = m * n
    k %= total

    if k == 0:
        return flat_grid

    return flat_grid[-k:] + flat_grid[:-k]


def run_acm_mode():
    input_data = sys.stdin.read().split()

    if not input_data:
        return

    iterator = iter(input_data)
    output_buffer = []

    try:
        while True:
            m = int(next(iterator))
            n = int(next(iterator))
            k = int(next(iterator))

            total_elements = m * n
            current_grid = [int(next(iterator)) for _ in range(total_elements)]

            result_grid = core_logic(m, n, k, current_grid)

            for i in range(m):
                row_slice = result_grid[i * n : (i + 1) * n]
                output_buffer.append(" ".join(map(str, row_slice)))
                output_buffer.append("\n")

    except StopIteration:
        pass

    sys.stdout.write("".join(output_buffer))


if __name__ == "__main__":
    run_acm_mode()
