-- global require
require 'class'
require 'lume'

Turtle = require 'BetterTurtle'
local RunTurtle = require 'RunTurtle'

width, height = 640, 480

local turtle = Turtle()
local runTurtle = RunTurtle(turtle)

function love.load(arg)
    -- print(arg[1])
    -- TODO argParse
    if arg[1] == nil then error("need a input file") end
    content = love.filesystem.read(arg[1])
    runTurtle:LoadAll(content)

    -- clear = love.graphics.clear
    -- love.graphics.clear = function(...) end
    love.window.setMode(width, height)
    -- turtle = Turtle()
    -- turtle:setVel(100)
    -- turtle:setPos(width/2, height / 2)
    -- turtle:forward(100)
    -- turtle:left()
    -- turtle:forward(100)
    -- turtle:info()
end

function love.update(dt)
    turtle:update(dt)
end

function love.draw()
    turtle:draw()
end