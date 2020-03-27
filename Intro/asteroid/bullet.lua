require('common')
local V2 = require('V2')
local Mover = require('mover')


local Length = 0.1

local Bullet = {
    velocity = -1,
    enabled = false,
    color = HexToFloatColor('F12678')
}

Bullet = Mover:new(Bullet, V2:new(0, 0), V2:new(0, Length), V2:new(0, Bullet.velocity), Bullet.color, 'line')

function Bullet:new(pos, vel)
    assert(V2.isV2(pos))
    local o = {}
    self.__index = self
    setmetatable(o, self)
    o.pos = pos
    o.enabled = true
    return o
end



return Bullet