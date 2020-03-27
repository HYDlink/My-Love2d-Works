local pipeImage = love.graphics.newImage('pipe.png')
local Pipe = {
    image = pipeImage,
    w = pipeImage:getWidth(),
    h = pipeImage:getHeight()
}

function Pipe:new(x, y)
    assert(x and y)
    self.__index = self
    local o = {}
    setmetatable(o, self)
    o.x, o.y = x, y
    return o
end

function Pipe:draw()
    love.graphics.draw(self.image, self.x, self.y)
end
function Pipe:inverseDraw()
    love.graphics.draw(self.image, self.x, self.y, 0, 1, -1)
end

return Pipe