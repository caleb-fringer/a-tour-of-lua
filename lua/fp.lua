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

local pipe = function(f)
    return function(x)
        return f(x)
    end
end

return {
    thrush = thrush,
    map = map,
    pipe = pipe,
}
