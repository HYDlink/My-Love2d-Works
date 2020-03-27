require('common')
local Mover = require('mover')
local V2 = require('V2')
local Enemy = {
    color = HexToFloatColor('6574C7'),
    enable = false
}

Enemy = Mover:new(Enemy, V2:new(0, 0), V2:new(0.1, 0.1), V2:new(0, 1), Enemy.color)

function Enemy:new(pos, vel)
    assert(V2.isV2(pos))
    assert(type(vel) == 'nil' or (type(vel) == 'table' and V2.isV2(vel)))
    local o = {}
    self.__index = self
    setmetatable(o, self)
    o.pos = pos or o.pos
    o.vel = vel or self.vel
    o.lastShootTime = love.timer.getTime()
    o.enabled = true
    return o
end

return Enemy