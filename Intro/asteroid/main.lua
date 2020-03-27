Player = require('player')
Enemy = require('enemy')
local Mover = require('mover')
local Score = require('Score')
V2 = require('V2')

player = Player:new()
enemyList = {}

generateInterval = 1

function generateEnemy()
    table.insert(enemyList, Enemy:new(V2:new(math.random(), -0.1)))
    lastGenerateTime = love.timer.getTime()
    print('enemy Generate ' .. os.date('%X'))
end

function love.load(arg)
    -- if arg[#arg] == '-debug' then require("mobdebug").start() end
    screenWidth, screenHeight = love.graphics.getDimensions()
    lastGenerateTime = love.timer.getTime()
    score = Score:new(16, 'MISTRAL.TTF')
end

function love.update(dt)
    for enemyTabPos, enemy in pairs(enemyList) do
        enemy:update(dt)
        
        -- collision detection
        for bulletTabPos, bullet in pairs(player.bullets) do
            if(Mover.checkBound(bullet, enemy)) then
                table.remove(enemyList, enemyTabPos)
                table.remove(player.bullets, bulletTabPos)
                score.score = score.score + 1
            end
        end
    end
    if love.timer.getTime() - lastGenerateTime > generateInterval then
        generateEnemy()
    end
    player:update(dt)
end

function love.resize(w, h)
    screenWidth, screenHeight = w, h
end

function love.draw()
    for _, enemy in pairs(enemyList) do
        enemy:draw()
    end
    player:draw()
    score:draw()
end

function love.keypressed(key, u)
   --Debug
   if key == "rctrl" then --set to whatever key you want to use
      debug.debug()
   end
end