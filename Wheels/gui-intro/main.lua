local GUI = require 'GUI'

function love.load()
    button = GUI.button:new(32, 32, 32, 32)
end

function love.update(dt)
    button:update()
end

function love.draw()
    button:draw()
end