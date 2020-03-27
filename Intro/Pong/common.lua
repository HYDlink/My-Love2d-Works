function isRectIntersect(a, b)
    local x1, x2 = a.x, a.x + a.w
    local x3, x4 = b.x, b.x + b.w
    local y1, y2 = a.y, a.y + a.h
    local y3, y4 = b.y, b.y + b.h

    if x1 < x4 and x3 < x2 and y1 < y4 and y3 < y2 then
        return true
    else
        return false
    end
end

function clamp(min, max, v)
    if v < min then
        return min
    elseif v > max then
        return max
    else
        return v
    end
end