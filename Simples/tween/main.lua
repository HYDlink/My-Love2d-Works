flux = require "flux"
lume = require "lume"

local t = { x = 100, y = 100}

function love.load()
    love.window.setMode(1200, 600)
    flux.to(t, 4, { x = 400, y = 100 }):ease('elasticin')
end

function love.draw()
    love.graphics.rectangle('fill', t.x, t.y, 40, 40)
end

function love.update(dt)
    flux.update(dt)
end