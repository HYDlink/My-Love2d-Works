require('common')
local Bullet = require('bullet')
local Player = {
    w = 0.03,
    h = 0.06,
    color = { .3, .3, .3 },
    bullets = {},
    shootInterval = 0.3,
    lastShootTime = nil,
}

local ShootDelayType = { 'Time', 'ShoootNum' }

local VELOCITY = 0.5

function Player:new(o, vel, shootDelayType)
    local o = o or {}
    local vel = vel or VELOCITY
    self.__index = self
    setmetatable(o, self)
    o.x = 0.5
    o.y = 0.9
    o.velocity = vel
    o.lastShootTime = love.timer.getTime()
    return o
end

function Player:update(dt)
    if love.keyboard.isDown('a') then
        self.x = self.x - dt * self.velocity
    elseif love.keyboard.isDown('d') then
        self.x = self.x + dt * self.velocity
    end

    -- shoot
    if love.keyboard.isDown('w') and
        (love.timer.getTime() - self.lastShootTime) > self.shootInterval then
        table.insert(self.bullets, Bullet:new(V2:new(self.x, self.y)))
        print('palyer shooted ' .. os.date('%X'))
        self.lastShootTime = love.timer.getTime()
    end

    for k, bullet in pairs(self.bullets) do
        bullet:update(dt)
        if bullet.pos.y < 0 then table.remove(self.bullets, k) end
    end
end

function Player:draw()
    love.graphics.setColor(self.color)
    love.graphics.rectangle('fill', Scaler.Rect(self))
    for _, bullet in pairs(self.bullets) do bullet:draw() end
end

return Player