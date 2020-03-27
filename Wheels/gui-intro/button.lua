local Class = require 'Class'
local Rect = require 'Rect'
local Button = {
    focus = false,
    -- rect = Rect:new()
    highlight = { r = 128, g = 128, b = 128},
    normalCol = { r = 64, g = 64, b = 64}
}
Button = Class:new(Button)

local oldNew = Button.new
function Button:new(rect, y, w, h)
    local function isNum(n) return type(n) == 'number' end
    if Rect.isRect(rect) then
        -- rect = rect
    elseif isNum(rect) and isNum(y) and isNum(w) and isNum(h) then
        rect = Rect:new(rect, y, w, h)
    else
        error('error param')
    end
    assert(rect.w > 0 and rect.h > 0)
    
    self:oldNew({rect = rect})
end

function Button:update()
    if self.rect:isPointInside(love.mouse.getPosition()) then
        self.focus = true
    end
end

function Button:draw()
    if self.focus then
        love.graphics.setColor(self.highlight)
    else
        love.graphics.setColor(self.normalCol)
    end
    love.graphics.rectangle(self.rect)
end

return Button