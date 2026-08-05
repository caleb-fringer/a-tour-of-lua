local Interval = require("interval")

io.input("input.txt")

local seeds = {}

for begin, size in io.read("l"):gmatch("(%d+) (%d+)") do
    begin, size = tonumber(begin), tonumber(size)
    table.insert(seeds, Interval:new(begin, begin + size - 1))
end

local layers = {}
local currentLayer

for line in io.lines() do
    if line == "" then goto continue end

    local srcName, destName = line:match("(%a+)%-to%-(%a+) map:")

    if srcName and destName then
        currentLayer = {
            name = srcName .. "-to-" .. destName,
            ranges = {}
        }
        table.insert(layers, currentLayer)
    else
        local destStart, srcStart, length = line:match(string.rep("(%d+)", 3, " "))
        if srcStart and destStart and length then
            srcStart, destStart, length = tonumber(srcStart), tonumber(destStart), tonumber(length)
            table.insert(currentLayer.ranges, {
                source = Interval:new(srcStart, srcStart + length - 1),
                delta = destStart - srcStart
            })
        end
    end

    ::continue::
end

local function subtract(interval, overlap)
    local result = {}

    if interval.lower < overlap.lower then
        table.insert(result, Interval:new(interval.lower, overlap.lower - 1))
    end

    if overlap.upper < interval.upper then
        table.insert(result, Interval:new(overlap.upper + 1, interval.upper))
    end

    return result
end

local intervals = seeds

for _, layer in ipairs(layers) do
    local nextIntervals = {}

    for _, interval in ipairs(intervals) do
        local remaining = { interval }

        for _, range in ipairs(layer.ranges) do
            local stillRemaining = {}

            for _, candidate in ipairs(remaining) do
                local overlap = candidate * range.source

                if overlap then
                    table.insert(nextIntervals, Interval:new(overlap.lower + range.delta, overlap.upper + range.delta))

                    for _, rest in ipairs(subtract(candidate, overlap)) do
                        table.insert(stillRemaining, rest)
                    end
                else
                    table.insert(stillRemaining, candidate)
                end
            end

            remaining = stillRemaining
        end

        for _, identity in ipairs(remaining) do
            table.insert(nextIntervals, identity)
        end
    end

    intervals = nextIntervals
end

local min = math.huge

for _, interval in ipairs(intervals) do
    if interval.lower < min then
        min = interval.lower
    end
end

print(min)
