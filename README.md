# A Tour of Lua

This repository is a Lua portfolio built from two projects I wrote in 2023:

- A CS 311 Programming Languages course project at CSU East Bay about Lua's
language design, data structures, modules, and object-oriented idioms.
- My Advent of Code 2023 Day 5 solution, which uses interval arithmetic to turn
a brute-force mapping problem into a tractable range transformation algorithm.

The goal of this repo is to show practical Lua fluency: metatables, modules,
tables as objects, string parsing, recursive data structures, operator
overloading, and performance-conscious algorithm design.

## Highlights

- `lua/` contains the original CS 311 sample programs and data-structure work.
- `examples/advent-of-code-2023/day5/` contains a standalone AoC solution with
supporting interval and set modules.
- `docs/` contains written explanations.
- `Project_final_draft.pdf` is the original course report from December 2023.

## Why Lua

The power of Lua is orthogonality: the language is extremely small, with very
few langauge constructs. Higher level idioms are built by composing these
constructs. The result is a delightful developer experience because the language
gets out of your way of being productive.

Lua rewards a small, composable style: tables are the central (only) data
structure, functions are first-class, modules are just returned tables, and
metatables let ordinary tables express object-oriented behavior and custom
operators. These examples use those tools directly rather than hiding them
behind a framework.

## Repository Map

| Path | Purpose | | --- | --- | | `lua/bst.lua` | Binary search tree module
using Lua tables and method syntax. | | `lua/main.lua` | Driver program for
exercising the BST module. | | `lua/oop.lua` | Small prototype-style OOP example
with metatables. | | `lua/linkedlist.lua` | Linked-list sketch from the original
course project. | | `lua/strings.lua` | String and long-bracket examples. | |
`lua/return.lua` | Control-flow example around `return`. | |
`examples/advent-of-code-2023/day5/` | Interval-based Advent of Code 2023 Day 5
implementation. | | `docs/aoc-2023-day5-solution.md` | Written walkthrough of
the interval algorithm and complexity. |

## Run Examples

Run the original course BST example:

```sh cd lua lua main.lua ```

Run the Advent of Code sample input:

```sh cd examples/advent-of-code-2023/day5 cp sample.txt input.txt lua
solution.lua lua solution_pt2.lua ```

The sample answers are `35` for part 1 and `46` for part 2.

## Notes

The course files are intentionally preserved as historical work from Fall 2023.
The Advent of Code code is included as a second, more algorithmic Lua example
showing how I applied the language to a larger parsing and optimization problem.
