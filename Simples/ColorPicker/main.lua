
pointPos = {
    x = nil,
    y = nil,
}
r, g, b, a = 0, 0, 0, 0

colors = {
TopLeftC     = {1., 1., 1., 1.},
TopRightC    = {1., 0., 0., 1.},
ButtonLeftC  = {0., 0., 0., 1.},
ButtonRightC = {0., 0., 0., 1.},
current = {0., 0., 0., 0.}
}

canvasW, canvasH = 400, 400
canvasMagin = 4
circleRadius = 10

function lerp(t, a, b)
    return a + t * (b - a)
end

function getCanvasPixel(x, y)
    local x, y = x - canvasMagin, y - canvasMagin
    x, y = x / canvasW, y / canvasH
    return lerp(lerp(x, lerp(y, colors.TopLeftC, colors.ButtonLeftC), lerp(y, colors.TopRigthC, colors.ButtonRigthC)))
end

function love.load()
    w, h = love.window.getMode()
    canvas = love.graphics.newCanvas(canvasW, canvasH)
    shader = love.graphics.newShader('shader.glsl')
    shader:send('ScreenWidth', w)
    shader:send('ScreenHeight', h)
    shader:send('TopLeftC',     colors.TopLeftC)
    shader:send('TopRightC',    colors.TopRightC)
    shader:send('ButtonLeftC',  colors.ButtonLeftC)
    shader:send('ButtonRightC', colors.ButtonRightC)
    love.graphics.setBackgroundColor(1, 1, 1, 1)
    love.graphics.setColor(1, 1, 1, 1)
end

function love.update(_)
    if love.mouse.isDown(1) then
        pointPos.x, pointPos.y = love.mouse.getX(), love.mouse.getY()
        colors.current = getCanvasPixel(canvasMagin+ pointPos.x, canvasMagin+pointPos.y)
        for k, v in ipairs(colors.current) do
            print(v)
        end
    end
end

function love.draw()
    love.graphics.setShader(shader)
    love.graphics.draw(canvas, 4, 4)
    if pointPos.x and pointPos.y then
    love.graphics.ellipse('line',pointPos.x,pointPos.y,circleRadius,circleRadiuss)
    end

    local x = canvasMagin + canvasW + canvasMagin
    -- for y = canvasMagin, love.graphics.getFont()
    -- love.graphics.printf
end

function love.mousepressed(x, y, button)
    if button == 1 then
    end
end