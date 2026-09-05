-- Implementing a Reactive Programming model by following
-- "Reactive Programming from Scratch (JavaScript) - Ep1" by Christopher Okhravi
-- https://www.youtube.com/watch?v=zAPTohhQpg0
local fp = require("fp")

-- My reactive library
Observable = {}

function Observable:new(o)
    o = o or {}
    o.subscribers = {}
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

function Observable:pipe(other)
    self:subscribe(function(x)
        other:emit(x)
    end)
    return other
end

Mapper = Observable:new()

function Mapper:new(f)
    -- The object needs to be constructed as an instance
    -- of Observable first. This is like calling super()
    local o = Observable.new(self)
    o.f = f
    self.__index = self
    setmetatable(o, self)
    return o
end

function Mapper:emit(x)
    -- Here, self refers to the Mapper instance.
    local transformed = self.f(x)
    -- Call Observable.emit() so we don't end up infinitely calling
    -- Mapper.emit(). Calling self:emit() would pass a Mapper instance to
    -- emit(), calling this function again recursively.
    -- If we used Observable:emit(), then the self passed to Observable.emit()
    -- would be Observable, NOT the current mapper instance.
    Observable.emit(self, transformed)
end

-- Examples
local myObservable = Observable:new()
local double = function(x) return x * 2 end

myObservable:subscribe(print)

local doubled = myObservable:pipe(Mapper:new(double))

doubled:subscribe(print)

for i = 1, 10 do
    myObservable:emit(i)
end
