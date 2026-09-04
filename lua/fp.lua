-- Some higher order functions
local thrush = function(x)
    return function(f)
        f(x)
    end
end

local map = function(f, xs)
    local result = {}
    for i, x in pairs(xs) do
        result[i] = f(x)
    end
    return result
end

local pipe = function(...)
    local fs = table.pack(...)
    return function(x)
        local result = x
        for _, f in ipairs(fs) do
            result = f(result)
        end
        return result
    end
end

-- Apply f to x (possibly for side-effects), then return x
local tap = function(f)
    return function(x)
        f(x)
        return x
    end
end

return {
    thrush = thrush,
    map = map,
    pipe = pipe,
    tap = tap,
}
