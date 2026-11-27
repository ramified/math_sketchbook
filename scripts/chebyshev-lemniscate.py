"""Compute the exact lemniscate derivative table in the Chebyshev chapter."""

from fractions import Fraction
from math import comb


def derivatives(limit):
    """Differentiate sl'' = -2 sl^3 using multinomial coefficients."""
    values = [0] * (limit + 1)
    values[1] = 1
    for n in range(5, limit + 1, 4):
        degree = n - 2
        for i in range(1, degree - 1, 4):
            for j in range(1, degree - i, 4):
                k = degree - i - j
                multinomial = comb(degree, i) * comb(degree - i, j)
                values[n] -= 2 * multinomial * values[i] * values[j] * values[k]
    return values


def valuation(value, prime):
    if value == 0:
        raise ValueError("The table uses nonzero derivatives only")
    exponent = 0
    while value % prime == 0:
        exponent += 1
        value //= prime
    return exponent


def main():
    orders = (13, 29, 53, 105)
    inert = (3, 7, 11)
    split = (5, 13)
    values = derivatives(max(orders))
    header = ["n", *(f"p={p}: v, floor" for p in inert), *(f"p={p}: v" for p in split)]
    print("| " + " | ".join(header) + " |")
    print("| " + " | ".join("---" for _ in header) + " |")
    for n in orders:
        cells = [str(n)]
        for p in inert:
            bound = int(Fraction(n * p, p * p - 1))
            observed = valuation(values[n], p)
            assert observed >= bound
            cells.append(f"{observed}, {bound}")
        cells.extend(str(valuation(values[n], p)) for p in split)
        print("| " + " | ".join(cells) + " |")


if __name__ == "__main__":
    main()
