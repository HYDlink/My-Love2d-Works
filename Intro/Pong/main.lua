require 'common'
local push = require('push')
local Ball = require 'Ball'
local Paddle = require 'Paddle'


gameWidth, gameHeight = 640, 480 --fixed game resolution
local windowWidth, windowHeight = 1080, 720
push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {
    fullscreen = false,
    resizable = true,
    -- pixelperfect = true
})
function love.resize(w, h)
    push:resize(w, h)
end

local gameState, player1, player2, servePlayer
local score1, score2 = 0, 0

function love.load()
    love.graphics.setDefaultFilter('linear', 'linear')
    love.graphics.setBackgroundColor(0, 0.3, 0.5, 1)
    smallFont = love.graphics.newFont('font.ttf', 32)
    largeFont = love.graphics.newFont('font.ttf', 64)
    
    local playerToBorder = 16
    player1 = Paddle:new(playerToBorder, gameHeight / 2, 'w', 's')
    player2 = Paddle:new(gameWidth - playerToBorder - Paddle.w, gameHeight / 2, 'up', 'down')
    servePlayer = 1
    Ball:reset()
    Ball:setDir(servePlayer)

    gameState = 'pause'
end

function love.update(dt)
    player1:update(dt)
    player2:update(dt)
    Ball:update(dt)

    if(Ball.y - Ball.w < 0  or Ball.y + Ball.w > gameHeight) then
        Ball.angle = -Ball.angle
    end

    if Ball.x - Ball.w < 0 then
        score2 = score2 + 1
        servePlayer = 2
        Ball:reset()
    elseif Ball.x + Ball.w > gameWidth then
        score1 = score1 + 1
        servePlayer = 1
        Ball:reset()
    end

    if isRectIntersect(Ball:rect(), player1) then
        Ball:setDir(2)
    elseif isRectIntersect(Ball:rect(), player2) then
        Ball:setDir(1)
    end
end

function love.keypressed(key, scancode, isrepeat)
    if key == 'space' then
        Ball:setMove(true)
        Ball:setDir(servePlayer)
    end
    if key == 'return' then
        Ball:reset()
    end
end

local fontInterval = 32
function drawScore()
    love.graphics.setFont(largeFont)
    love.graphics.printf(score1, -fontInterval, 4, gameWidth, 'center')
    love.graphics.printf(score2, fontInterval, 4, gameWidth, 'center')
end

function love.draw()
    push:start()

    --draw here
    love.graphics.setFont(smallFont)
    love.graphics.setColor(1, 1, 1, 0.2)
    love.graphics.printf("Hello Pong", 0, gameHeight / 2, gameWidth, 'center')
    love.graphics.setColor(1, 1, 1, 1)
    drawScore()
    Ball:draw()
    player1:draw()
    player2:draw()

    push:finish()
end
