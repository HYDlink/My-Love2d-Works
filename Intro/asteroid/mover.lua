local V2 = require('V2')
require('conf')
local Mover = {}

-- 线，第一个是起始位置，第二个是相对于起点的offset
local DrawFunc = {
    rectfill = function(a, b, x, y ) love.graphics.rectangle('fill', a, b, x, y) end,
    rectline = function(a, b, x, y ) love.graphics.rectangle('line', a, b, a, b) end,
    line = function(a, b, x, y ) love.graphics.line(a, b, a + x, b + y) end
}
local ScaleFunc = {
    rectfill = Scaler.RectV2,
    rectline = Scaler.RectV2,
    line = Scaler.LineV2
}
local Bound = {}
function Bound.RectV2(self)
    return self.pos.x - self.size.x / 2, self.pos.y - self.size.y / 2, self.pos.x + self.size.x / 2, self.pos.y +
        self.size.y / 2
end
function Bound.LineV2(self)
    local x1, x2 = self.pos.x, self.pos.x + self.size.x
    if x1 > x2 then
        x1, x2 = x2, x1
    end
    local y1, y2 = self.pos.y, self.pos.y + self.size.y
    if y1 > y2 then
        y1, y2 = y2, y1
    end
    return x1, y1, x2, y2
end
local BoundFunc = {
    rectfill = Bound.RectV2,
    rectline = Bound.RectV2,
    line = Bound.LineV2
}

function Bound.Check(a, b)
    local x1, y1, x2, y2 = BoundFunc[a.shape](a)
    local x3, y3, x4, y4 = BoundFunc[b.shape](b)
    return x1 < x4 and x2 > x3 and y1 < y4 and y2 > y3
end

function Mover.checkBound(self, other)
    return Bound.Check(self, other)
end

function Mover:update(dt)
    local newpos = self.pos + self.vel * dt
    self.pos = newpos
end

function Mover:draw()
    if self.color then
        love.graphics.setColor(unpack(self.color))
    end
    DrawFunc[self.shape](ScaleFunc[self.shape](self.pos, self.size))

    love.graphics.setColor(love.graphics.getBackgroundColor())
end

-- @param w 如果是矩形则代表宽度, x, y为中心点
--          如果是线则代表长度, w, h为末端
function Mover:new(o, pos, size, vel, color, shape )
    assert(V2.isV2(pos))
    assert(V2.isV2(size))
    assert(V2.isV2(vel))
    
    local o = o or {}
    o.pos, o.size, o.vel, o.color = pos, size, vel, color
    o.shape = shape or 'rectfill'
    self.__index = self
    setmetatable(o, self)
    return o
end

return Mover