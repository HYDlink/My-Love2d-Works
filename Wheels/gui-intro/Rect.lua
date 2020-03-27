require 'Class'

local Rect = {
    x = 0,
    y = 0,
    w = 0,
    h = 0,
}

Rect = Class:new(Rect)
local oldNew = Rect.new
function Rect:new(x, y, w, h)
    
end

function Rect.isRect(r)
    local function isNum(n)
        return type(n) == 'number'
    end
    return type(r) == 'table' and r.x and r.y and r.h and r.w and isNum(r.x) and isNum(r.y) and isNum(r.w) and isNum(r.h)
end

local function pointInsideRect(r, x, y) 
    return x > r.x and x < r.x + w and y > r.y and y < r.y + r.h
end

function Rect:isPointInside(x, y)
    if type(x) == 'table' and x.x and x.y then
        pointInsideRect(self, x.x, x.y)
    elseif type(x) == 'number' and type(y) == 'number' then
        pointInsideRect(self, x, y)
    else
        error("param error")
    end
end
return Rect