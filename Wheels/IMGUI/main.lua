Imgui = require 'core'

function love.load()
    imgui = Imgui.new()
end
function love.update(dt)
    if imgui:button('test', 4, 4, 60, 20).hit then
        print('clicked')
    end
end

function love.draw()
    imgui:draw()
end