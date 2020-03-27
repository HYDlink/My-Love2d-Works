-- 画棋盘，
-- 固定下棋点击反应，如果这个地方不能下棋，那么失败
-- 先手和后手，下完则进行切换（AI需要等待一段时间再切换）
-- 检查棋盘是否存在连通的路线

-- 悔棋

-- 0 表示空棋

width, height = 640, 640
panel = require 'panel'

function love.load(args)
    love.window.setMode(width,height)
    panel:init()
end

function love.update(dt)
    
end

function love.mousereleased(x, y, button)
    if button == 1 then
        panel:handleMouse(x, y)
    end
end

function love.draw()
    panel:draw()
end