local V2 = {}

setmetatable(V2, {
    __add = V2.add,
    __mul = V2.scale,
    __eq = V2.equal
})

function V2:new(x, y)
    local o = {x = x, y = y}
    -- self.__index = self
    setmetatable(o, {
        __index = self,
        __add = V2.add,
        __mul = V2.scale,
        __eq = V2.equal
    })
    return o
end

function V2.unpack(self)
    return self.x, self.y
end

function V2.isV2(self)
    return type(self) == 'table' and self.x and self.y
end

function V2.calc(self, other, func)
    if not V2.isV2(other) then
        other = V2:new(other, other)
    end
    return V2:new(func(self.x, other.x), func(self.y, other.y))
end

function V2.add(self, other)
    return V2.calc(self, other, function (a, b)
        return a + b
    end)
end

function V2.scale(self, other)
    return V2.calc(self, other, function (a, b)
        return a * b
    end)
end

function V2.equal(self, other)
    if not V2.isV2(other) then
        other = V2.new(other, other)
    end
    return self.x == other.x and self.y == other.y
end

local function test()
    local v1 = V2:new(1, 2)
    local v1c = V2:new(1, 2)
    local v2 = V2:new(3, 4)
    local v3 = V2:new(4, 6)
    local v4 = V2:new(3, 8)
    assert(v1 == v1c, 'equal failed')
    assert(v1 + v2 == v3, 'add failed')
    assert(v1 * v2 == v4, 'multiply failed')
end

-- test()

return V2