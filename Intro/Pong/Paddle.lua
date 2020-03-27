require 'common'
local Paddle = {
    w = 16,
    h = 64,
    v = 400
}

function Paddle:new(x, y, up, down)
    local o = { x = x, y = y }
    self.__index = self
    setmetatable(o, self)
    o:setMoveKey(up, down)
    return o
end

function Paddle:setMoveKey(up, down)
    self.up = up or 'w'
    self.down = down or 's'
end

function Paddle:update(dt)
    local tmpy = self.y
    if love.keyboard.isDown(self.up) then
        tmpy = self.y - dt * self.v
    elseif love.keyboard.isDown(self.down) then
        tmpy = self.y + dt * self.v
    end
    self.y = clamp(0, gameHeight - self.h, tmpy)
end

function Paddle:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end
return Paddle