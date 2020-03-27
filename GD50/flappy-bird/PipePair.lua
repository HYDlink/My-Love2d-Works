local pipeImg = require('Pipe').image

local PipePair = {}
--[[
function PipePair:new(x, y, gap)
    assert(x and y and gap)
    self.__index = self
    local o = {}
    setmetatable(o, self)
    o.x, o.gap = x, gap
    o.top = Pipe:new(x, y)
    o.bottom = Pipe:new(x, y - gap)
    return o
end

function PipePair:setX(x)
    assert(type(x) == 'number')
    self.top.x, self.bottom.x = x, x
end

function PipePair:update()
    self.top.x, self.bottom.x = self.x, self.x
end
function PipePair:draw()
    self.top:draw()
    self.bottom:inverseDraw()
end
--]]
function PipePair:new(x, y, gap)
    assert(x and y and gap)
    self.__index = self
    local o = {}
    setmetatable(o, self)
    o.x, o.y, o.gap = x, y, gap
    return o
end
function PipePair:draw()
    love.graphics.draw(pipeImg, self.x, self.y)
    love.graphics.draw(pipeImg, self.x, self.y - self.gap, 0, 1, -1)
end

return PipePair