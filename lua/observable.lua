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
local printDouble = function(x) print(double(x)) end

myObservable:subscribe(print)
myObservable:subscribe(printDouble)

for i = 1, 10 do
    myObservable:emit(i)
end
