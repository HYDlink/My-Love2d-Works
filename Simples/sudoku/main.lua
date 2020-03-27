
-- #F12678,#6574C7,#D5F941,#705484,#F639B9,#F12678,#6574C7,#D5F941
function love.load()
    ScreenWidth, ScreenHeight = love.graphics.getDimensions()
    lineWidth = 2
    GridWidth = (ScreenWidth - lineWidth) / 9
    GridHeight =(ScreenHeight - lineWidth) / 9
    love.graphics.setBackgroundColor(unpackHexColor(0xF12678))
end

local function draw_grid()
    for i = 0, 9 do
        -- 支持圆角矩形
        love.graphics.rectangle("fill", i * GridWidth, 0, lineWidth, ScreenHeight)
        love.graphics.rectangle("fill", 0, i * GridHeight, ScreenWidth, lineWidth)
    end
end

function love.draw()
    draw_grid()
end