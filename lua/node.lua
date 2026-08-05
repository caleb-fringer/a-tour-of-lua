local Node = {}

function Node:new(v)
    local o = {
        value = v,
        left = nil,
        right = nil
    }

    self.__index = self
    setmetatable(o, self)

    return o
end

function Node:getLeftChild()
    return self.left
end

function Node:getRightChild()
    return self.right
end

function Node:setLeftChild(node)
    self.left = node
end

function Node:setRightChild(node)
    self.right = node
end

function Node:delete()
    self = nil
end

function Node:getValue()
    return self.value
end

function Node:setValue(v)
    self.value = value
end