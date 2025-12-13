import sys


def solve(s, k):
    if k <= 1:
        return len(s)

    ans = 0
    nums = [ord(c) - 97 for c in s]

    for u_limit in range(1, 27):
        cnt = [0] * 26
        u = 0
        v = 0
        left = 0

        for right, x in enumerate(nums):
            if cnt[x] == 0:
                u += 1
            cnt[x] += 1
            if cnt[x] == k:
                v += 1

            while u > u_limit:
                y = nums[left]
                if cnt[y] == k:
                    v -= 1
                cnt[y] -= 1
                if cnt[y] == 0:
                    u -= 1
                left += 1

            if u == u_limit and u == v:
                ans = max(ans, right - left + 1)
    return ans


if __name__ == "__main__":
    tokens = sys.stdin.read().split()
    iterator = iter(tokens)

    try:
        while True:
            s = next(iterator)
            k = int(next(iterator))
            print(solve(s, k))
    except StopIteration:
        pass
