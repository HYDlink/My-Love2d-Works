local flux = require 'flux'
local Game = {
    focusX = 0,
    focusY = 0,
    ColorLT,
    ColorLB,
    ColorRT,
    ColorRB,
    sizeX,
    sizeY,
    selectedCircleRadiusScale = 0.4,
    grids = {},
    -- 保存正在移动的rect
    swapingRectA = {x = 0, y = 0},
    swapingRectB = {x = 0, y = 0},
    swappingPosA = {x = -1, y = -1},
    swappingPosB = {x = -1, y = -1},
    isSwapping = false
}


function Game:init(Xn, Yn, cLT, cLB, cRT, cRB)
    self.sizeX = Xn
    self.sizeY = Yn
    self.ColorLT = cLT
    self.ColorLB = cLB
    self.ColorRT = cRT
    self.ColorRB = cRB

    for i = 1, Yn do
        self.grids[i] = {}
        for j = 1, Xn do
            self.grids[i][j] = {x = j, y = i}
        end
    end
    self:shuffle()
end

function Game:shuffle()
    printTable(self.grids[self.sizeY][self.sizeX])
    local totalcount = self.sizeX * self.sizeY
    local function swapByIndex(i1, i2)
        -- 还挺麻烦的, 
        -- 要保证 x 得到的数是 1, 到 self.sizeX 区间, 因此单纯的取模不行 self.sizeX 不行, i = sizeX 的时候, x 得到的就是 0 了
        -- 保证 y 得到的数是 1 到 self.sizeY 区间
        local x1, y1 = i1 % self.sizeX + 1, math.floor(i1 / self.sizeX) + 1
        local x2, y2 = i2 % self.sizeX + 1, math.floor(i2 / self.sizeX) + 1
        -- print(x2, y2)
        self.grids[y1][x1], self.grids[y2][x2] = self.grids[y2][x2], self.grids[y1][x1]
        assert(self.grids[y1][x1])
    end
    local i2
    for i1 = 0, totalcount - 2 do
        i2 = math.random(i1 + 1, totalcount - 1)
        swapByIndex(i1, i2)
    end
end

function Game:isWin()
    for i = 1, self.sizeY do
        for j = 1, self.sizeX do
            if not (self.grids[i][j].x == j and self.grids[i][j].y == i) then
                return false
            end
        end
    end
    return true
end

function Game:draw()
    for i = 1, self.sizeY do
        for j = 1, self.sizeX do
            local x = self.grids[i][j].x
            local y = self.grids[i][j].y
            setGrayColor(self:getLerpColor(x, y))
            -- love.graphics.setColor(color)
            love.graphics.rectangle("fill", (j - 1) * gridWidth, (i - 1) * gridHeight, gridWidth, gridHeight)
        end
    end
    if self.isSwapping then
        --- 用背景色覆盖正在交换的图片位置
        love.graphics.setColor(love.graphics.getBackgroundColor())
        local sPAx, sPAy = self:getGridScreenPos(self.swappingPosA.x, self.swappingPosA.y)
        local sPBx, sPBy = self:getGridScreenPos(self.swappingPosB.x, self.swappingPosB.y)
        love.graphics.rectangle('fill', sPAx, sPAy, gridWidth, gridHeight)
        love.graphics.rectangle('fill', sPBx, sPBy, gridWidth, gridHeight)

        --- 并且绘制交换和移动中的rects
        local sRA = self.swapingRectA
        local sRB = self.swapingRectB
        setGrayColor(sRA.c)
        love.graphics.rectangle('fill', sRA.x, sRA.y, gridWidth, gridHeight)
        setGrayColor(sRB.c)
        love.graphics.rectangle('fill', sRB.x, sRB.y, gridWidth, gridHeight)
    end
    if self.focusX > 0 and self.focusY > 0 then
        love.graphics.ellipse("line", (self.focusX - 0.5) * gridWidth, (self.focusY - 0.5) * gridHeight, radius, radius)
    end
    -- love.graphics.print(tostring(self.isSwapping))
    love.graphics.print(string.format('%d, %d', self.swapingRectA.x, self.swapingRectA.y))
end

function Game:swapGrid(x1, y1, x2, y2)
    --  and not self.isSwapping
    if (x1 > 0 and y1 > 0 and x2 > 0 and y2 > 0) then
        -- 交换 table 引用
        self.grids[y1][x1], self.grids[y2][x2] = self.grids[y2][x2], self.grids[y1][x1]
        self.swappingPosA, self.swappingPosB = { x = x1, y = y1}, { x = x2, y = y2}
        
        local sRA, sRB = self.swapingRectA, self.swapingRectB
        sRA.x, sRA.y = self:getGridScreenPos(x1, y1)
        sRB.x, sRB.y = self:getGridScreenPos(x2, y2)
        sRA.c = self:getLerpColor(self.grids[y2][x2].x, self.grids[y2][x2].y)
        sRB.c = self:getLerpColor(self.grids[y1][x1].x, self.grids[y1][x1].y)

        local swapingTime = 0.5
        self.isSwapping = true
        flux.to(sRA, swapingTime, {x = sRB.x, y = sRB.y}):ease("quadout"):oncomplete(function() self.isSwapping = false; print('swaped') end)
        flux.to(sRB, swapingTime, {x = sRA.x, y = sRA.y}):ease("quadout"):oncomplete(function() self.isSwapping = false; print('swaped') end)

        print(self.grids[x1][y1].x, self.grids[x1][y1].y)
        print(self.grids[x2][y2].x, self.grids[x2][y2].y)

        -- 重置focus以重新选择
        self.focusX = -1
        self.focusY = -1
    end
end

--- Utility
function printTable(t, func)
    if func == nil then
        func = pairs
    end
    for k, v in func(t) do
        print(k, v)
    end
end

function lerp(a, b, t)
    if type(a) == "table" and type(b) == "table" and #a == #b then
        local ret = {}
        for i = 1, #a do
            ret[i] = t * (a[i] - b[i]) + b[i]
        end
        return ret
    elseif type(a) == "number" and type(b) == "number" then
        return t * (a - b) + b
    else
        error("type incorrect. expect a and b are same length array or number but " .. type(a))
    end
end

function setGrayColor(c)
    love.graphics.setColor(c, c, c)
end

function Game:getLerpColor(x, y)
    local colorT = lerp(self.ColorLT, self.ColorRT, x / self.sizeX)
    local colorB = lerp(self.ColorLB, self.ColorRB, x / self.sizeX)
    local color = lerp(colorT, colorB, y / self.sizeY)
    return color
end

function Game:getGridScreenPos(x, y)
    return (x - 1) * gridWidth, (y - 1) * gridHeight
end

return Game