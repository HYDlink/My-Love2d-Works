local Bird = {
    x = 24,
    y = VIRTUAL_HEIGHT / 2,
    vel = 0,
    jumpSpeed = -256
}

local birdImage = love.graphics.newImage('bird.png')
local GRAVITY = 700
local MAX_FALL_SPEED = 1024


function Bird:new(x, y)
    self.__index = self
    local o = {}
    setmetatable(o, self)
    o.x, o.y = x or o.x, y or o.y
    return o
end

function Bird:update(dt)
    -- self.vel = self.vel + GRAVITY * dt
    self.vel = math.min(self.vel + GRAVITY * dt, MAX_FALL_SPEED)
    if love.keyboard.keyPressed['space'] then
        self.vel = self.jumpSpeed
    end
    self.y = self.y + self.vel * dt

    if self.y > VIRTUAL_HEIGHT then
        self.y = VIRTUAL_HEIGHT / 2
    end
end

function Bird:draw()
    -- 依赖速度来变化角度，在跳跃的过程中，会给人不自然的抖动
    love.graphics.draw(birdImage, self.x, self.y) --, math.rad(self.vel / 20))
end

return Bird