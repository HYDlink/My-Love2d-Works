require 'util'
-- virtual resolution dimensions
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288


function love.load()
    love.window.setTitle('Match-3')
    love.window.setMode(VIRTUAL_WIDTH, VIRTUAL_WIDTH)

    gImage = {
        ['main'] = love.graphics.newImage('res/match3.png'),
        ['background'] = love.graphics.newImage('res/background.png'),
    }
    gFrames = generateQuad(gImage.main)
end

function love.draw()
    
end