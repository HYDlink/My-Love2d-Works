Timer = require 'timer'

function love.load()
    player = {}
end

function love.update(dt)
    Timer.update(dt)
end

function love.keypressed()
    print('pressed')
    Timer.after(0.1, function() player.just_hit = not player.just_hit print('seted') end, 6, 'just_hit')
end

function love.draw()
    if not player.just_hit then
        love.graphics.rectangle('fill', 10, 10, 100, 100)
    end
end