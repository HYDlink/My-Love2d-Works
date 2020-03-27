grid = 32
function generateQuad(image)
    local x = 0
    local y = 0
    for color = 1, 9 do
        for variaty = 1, 6 do
            image[color][variaty] = love.graphics.newQuad(x, y, grid, grid)
            x = x + 32
        end
        y = y + 32
        x = 0
    end
    x = 32 * 9
    y = 0
    for color = 10, 18 do
        for variaty = 1, 6 do
            image[color][variaty] = love.graphics.newQuad(x, y, grid, grid)
            x = x + 32
        end
        y = y + 32
        x = 32 * 9
    end
end