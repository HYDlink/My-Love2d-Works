--- TODO
--- random shuffle
--- check win
--- maybe only use love.graphics.scale to draw grid (no! because of swappingRect are not align on grid)

local flux = require 'flux'
local Game = require 'game'

-- readonly global variable
width = 480
height = 640
gridWidth = 0
gridHeight = 0
win = false

function love.load()
    love.window.setMode(width, height)
    Game:init(2, 2, 0.2, 0.6, 0.5, 1)
    gridWidth = width / Game.sizeX
    gridHeight = height / Game.sizeY
    radius = Game.selectedCircleRadiusScale * math.min(Game.sizeX, Game.sizeY)
end

function love.mousepressed(x, y)
    -- Important, lua除法要记得不是默认整数, 类型还是number的, 带自动转换到精确浮点数
    -- lua5.3 支持 // 不留余数除法
    local curX = math.ceil(x / gridWidth)
    local curY = math.ceil(y / gridHeight)
    -- 如果点击位置和专注点一样, 取消专注
    if curX == Game.focusX and curY == Game.focusY then
        -- 之前没有 focus 过，那么设置专注点
        Game.focusX = -1
        Game.focusY = -1
    elseif Game.focusX <= 0 or Game.focusY <= 0 then
        -- 否则进行交换
        Game.focusX, Game.focusY = curX, curY
    else
        Game:swapGrid(curX, curY, Game.focusX, Game.focusY)
    end
    -- TODO 推迟到方块交换结束再设置
    win = Game:isWin()
end

function love.update(dt)
    flux.update(dt)
end

function love.draw()
    Game:draw()
    if win then
        -- Draw wined message
    end
end
