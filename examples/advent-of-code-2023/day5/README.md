# Advent of Code 2023 Day 5: If You Give A Seed A Fertilizer

This example solves Advent of Code 2023 Day 5 in Lua.

- `solution.lua` solves part 1 by mapping each seed through all seven conversion layers.
- `solution_pt2.lua` solves part 2 by splitting and transforming seed ranges as intervals instead of enumerating every seed.
- `interval.lua` models closed integer intervals and overloads arithmetic-like operators for union, difference, and intersection.
- `set.lua` models sets of disjoint intervals from the original solution exploration.
- `layer_util.lua` contains helpers for walking the ordered layer names.
- `sample.txt` is the official sample input.

Run with a file named `input.txt` in this directory:

```sh
lua solution.lua
lua solution_pt2.lua
```

For the bundled sample:

```sh
cp sample.txt input.txt
lua solution.lua      # 35
lua solution_pt2.lua  # 46
```

The full explanation is in `../../../docs/aoc-2023-day5-solution.md`.
