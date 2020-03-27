require 'global'
MovingBall = require 'movingBall'
require 'firework'

math.randomseed(50)

function love.load()
    width = 1080
    height = 720
    love.window.setMode(width, height)
    move1 = MovingBall(vector.zero, vector.fromPolar(math.pi / 4, 500))
    move2 = MovingBall(vector(200, 400), vector.fromPolar(math.pi * 3 / 4 , 250))
    -- firework = Firework(width / 2, 250, height / 2, height / 2 + 100)
    fireworks = {}
end

function love.update(dt)
    -- move1:update(dt)
    -- move2:update(dt)
    -- timer控制发射
    if math.random(0, 100) > 98 then 
        fireworks[#fireworks + 1] = Firework(width / 2, 250, height / 2, height / 2 + 100)
    end
    for k, firework in ipairs(fireworks) do
        firework:update(dt)
        if #firework.balls < 2 then
            -- TODO 在遍历的时候 remove 元素会不会出现错误
            lume.remove(fireworks, firework)
        end
    end
end

function love.draw()
    for _, firework in ipairs(fireworks) do
        firework:draw()
        if firework.balls[1] then
            love.graphics.print(firework.balls[1].vel.x .. " " .. firework.balls[1].vel.y)
        end
    end
    -- move1:draw()
    -- move2:draw()
    -- love.graphics.print(move1.pos.x .. " " .. move1.pos.y)
    -- love.graphics.print(move2.pos.x .. " " .. move2.pos.y, 0, 40)
end