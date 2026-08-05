local linkedList = {}
local Node = {}

function Node:new(v)
    local o = { value = v, next = nil }
    self.__index = self
    setmetatable(o, self)
    return o
end

function Node:delete()
    self = nil
end


function linkedList:new(v)
    local o = {}

    self.__index = self
    setmetatable(o, self)

    o.head = { value = v, next = nil }

    return o
end

function linkedList:append(v)
    local curr = self.head
    while curr.next do
        curr = curr.next
    end

    curr.next = { value = v, next = nil }
end

function linkedList:remove(v)
    local prev = nil
    local curr = self.head
    while curr.value ~= v and curr.next do
        prev = curr
        curr = curr.next
    end

    if curr.value == v then 
        local next = curr.next

    end
end

function linkedList:print()
    local curr = self.head
    while curr do
        io.write(curr.value, " ")
        curr = curr.next
    end
end

local myList = linkedList:new(1)
myList:append(2)
myList:append(5)

myList:remove(5)

myList:print()