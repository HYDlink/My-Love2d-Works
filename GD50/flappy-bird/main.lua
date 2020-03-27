push = require 'push'
-- physical screen dimensions
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
-- virtual resolution dimensions
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local Bird = require 'Bird'
local PipeGen = require 'PipeGen'

local background = love.graphics.newImage('background.png')
local backgroundScroll = 0
local ground = love.graphics.newImage('ground.png')
local groundScroll = 0
local GROUND_HEIGHT = 16

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 413
-- local GROUND_LOOPING_POINT = 413

love.keyboard.keyPressed = {}


local bird = Bird:new()

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    PipeGen.setVar(nil, nil, nil, GROUND_SCROLL_SPEED)
    PipeGen.Gen()
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    love.keyboard.keyPressed[key] = true
end

function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH

    bird:update(dt)
    PipeGen.update(dt)

    love.keyboard.keyPressed = {}
end

function love.draw()
    push:start()

    love.graphics.draw(background, -backgroundScroll, 0)
    PipeGen.draw()
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - GROUND_HEIGHT)
    bird:draw()

    push:finish()
end