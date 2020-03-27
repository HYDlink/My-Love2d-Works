Class = require 'class'
vector = require 'vector'

local Line = Class {
    v1, v2,
    width, color,
    vel,
    dir,
}

local function serializeArray(a)
    str = ''
    for _, v in ipairs(a) do
        str = str .. v .. ' '
    end
    return str
end

function Line:length()
    return self.v1:dist(self.v2)
end

function Line:info(demand)
    if demand == nil or demand == 'simple' then
        return self.v1 .. ',' .. self.v2
    elseif demand == 'all' then
        -- 多个表链接的时候 并不会调用 __tostring() 元方法！
        return self.v1:__tostring() ..','.. self.v2:__tostring() ..'  vel: '.. self.vel ..'  dir: '.. self.dir:__tostring() ..'  w: '.. self.width ..'  color: '.. serializeArray(self.color)
    end
end

function Line:init(v1, v2, width, color, vel, dir)
    self.v1, self.v2 = v1 or vector.zero, v2 or vector.zero
    self.width = width or 8
    self.color = color or {255, 255, 255}
    self.vel = vel or 0
    self.dir = dir or vector(0, -1)
end

function Line:draw(x, y)
    love.graphics.setLineWidth(self.width)
    love.graphics.setColor(self.color)
    x1,y1,x2,y2 = self.v1.x, self.v1.y, x or self.v2.x, y or self.v2.y
    love.graphics.line(x1,y1,x2,y2)
end

function Line.move(v1, v2)
    
end

return Line
