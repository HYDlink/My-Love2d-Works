local Player = require("player")
-- Load some default values for our rectangle.

local myPlayer;
function love.load()
    x, y, w, h = 24, 24, 24, 24
    Player:new_player(nil, x, y, w, h);
end
 
-- Increase the size of the rectangle every frame.
function love.update(dt)
    x = x + 1
    y = y + 1
end
 
-- Draw a coloured rectangle.
function love.draw()
    love.graphics.setColor(0, 0.4, 0.4)
    Player:draw();
end