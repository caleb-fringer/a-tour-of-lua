-- Implementing a Reactive Programming model by following
-- "Reactive Programming from Scratch (JavaScript) - Ep1" by Christopher Okhravi
-- https://www.youtube.com/watch?v=zAPTohhQpg0
local fp = require("fp")

Observable = {
    subscribers = {},
}

function Observable:new(o)
    o = o or {}
    self.__index = self
    setmetatable(o, self)
    return o
end

function Observable:subscribe(callback)
    table.insert(self.subscribers, callback)
end

function Observable:emit(x)
    fp.map(fp.thrush(x), self.subscribers)
end

local myObservable = Observable:new()
local double = function(x) return x * 2 end
local tapPrint = fp.tap(print)

myObservable:subscribe(
    fp.pipe(
        tapPrint,
        double,
        tapPrint
    )
)

for i = 1, 10 do
    myObservable:emit(i)
end
