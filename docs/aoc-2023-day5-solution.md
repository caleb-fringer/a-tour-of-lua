# Advent of Code 2023 Day 5 Solution Walkthrough

## The Problem

The direct approach for part two is intractable because the seed input describes very large ranges. The key observation is that each mapping layer is a piecewise function over integer intervals. Instead of enumerating every seed, we can carry intervals through each layer.

For the sample input, the seed domain is `[79, 92] U [55, 67]`. Each mapping layer describes source intervals and destination intervals. Values outside the explicitly listed source intervals map to themselves, so each layer is a total function over non-negative integers.

## Interval Strategy

Represent each seed range as an interval object. For every mapping layer:

- Build the explicit source intervals from the puzzle input.
- Add the implicit identity intervals that fill the gaps in the layer's domain.
- Intersect the current set of candidate intervals with each layer interval.
- Translate each intersection into the layer's output range.
- Use the output intervals as the input to the next layer.

After the final `humidity-to-location` layer, the minimum location is the smallest lower bound among the resulting intervals.

## Why This Works

Each mapping row preserves ordering within its own interval because it only applies a constant offset. When a seed interval crosses mapping boundaries, intersection splits it into smaller pieces where the function is uniform. After all layers have been applied, every remaining interval accurately describes a group of original seeds and their final locations.

## Complexity

Creating an interval is `O(1)`. Intersecting two intervals is also `O(1)` because it only compares bounds.

For each layer, if there are `n` current intervals and `m` mapping intervals, the transformation performs `O(n * m)` interval intersections. The actual Advent of Code input has 10 initial seed intervals and 7 layers, with the largest layer containing dozens of mapping rows, which is easily tractable compared with enumerating every seed.

## Lua Features Used

- Modules implemented by returning tables from files.
- Metatables for object-style construction and method dispatch.
- Operator overloading via metamethods such as `__add`, `__sub`, `__mul`, and `__tostring`.
- Pattern matching for input parsing.
- Tables as arrays, maps, records, and object prototypes.
