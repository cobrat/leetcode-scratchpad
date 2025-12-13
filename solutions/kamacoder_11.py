import sys


def get_generation(node, parents):
    gen = 0
    curr = node

    while curr in parents:
        curr = parents[curr]
        gen += 1

    return gen


def solve():
    input_data = sys.stdin.read().split()
    if not input_data:
        return
    iterator = iter(input_data)

    try:
        while True:
            n = int(next(iterator))

            parents = {}
            for _ in range(n):
                child = int(next(iterator))
                father = int(next(iterator))
                parents[child] = father

            gen_xm = get_generation(1, parents)
            gen_xy = get_generation(2, parents)

            if gen_xm > gen_xy:
                print("You are my elder")
            elif gen_xm < gen_xy:
                print("You are my younger")
            else:
                print("You are my brother")

    except StopIteration:
        pass


if __name__ == "__main__":
    solve()
