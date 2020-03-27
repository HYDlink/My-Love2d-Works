local Class = require 'class'


Tile = Class{
    color = 0,
    variaty = 0
}

function Tile:new(c, v)
    self.color = c
end

-- xg, yg means 
function Tile:draw(xg, yg)
    love.graphics.draw(gImage.main, gFrames[self.color][self.variaty], xg * grid, yg * grid)
end