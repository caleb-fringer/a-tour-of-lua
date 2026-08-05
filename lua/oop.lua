local Account = {
    balance = 0,
}

function Account:withdraw(amt)
    self.balance = self.balance - amt
end

function Account:deposit(amt)
    self.balance = self.balance + amt
end

function Account:new(o)
    o = o or {}
    self.__index = self
    setmetatable(o, self)
    return o
end

local SpecialAccount = Account:new()

SpecialAccount.limit = 100

function SpecialAccount:withdraw(amt) 
    if amt - self.balance >= self:getLimit() then
	error("Insufficient funds")
    end
    self.balance = self.balance - amt
end

function SpecialAccount:getLimit()
    return self.limit
end

local r = SpecialAccount:new()
local s = SpecialAccount:new{limit = 1000.00}

print(r:getLimit())
print(s:getLimit())

local meta = getmetatable(r)
local metameta = getmetatable(meta)

for k in pairs(metameta) do
    print(k)
end
