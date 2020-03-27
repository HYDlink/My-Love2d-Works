function mapfunc(t, func)
    local newt = {}
    for k, v in pairs(t) do
        newt[k] = func(v)
    end
    return newt
end

function unpack_all(...)
    -- TODO
end

Scaler = {}
function Scaler.Rect(self)
    return (self.x - self.w / 2) * screenWidth,
        (self.y - self.h / 2) * screenHeight,
        self.w * screenWidth,
        self.h * screenHeight
end

function Scaler.RectV2(pos, size)
    return (pos.x - size.x / 2) * screenWidth,
        (pos.y - size.y / 2) * screenHeight,
        size.x * screenWidth,
        size.y * screenHeight
end

function Scaler.Size(self, y)
    if type(self) == 'table' then -- and self.x and self.y then
        return self.x * screenWidth, self.y * screenHeight
    elseif type(self) == 'number' and y then
        return self * screenWidth, y * screenHeight
    else
        return error('param not corrected')
    end
end

function Scaler.Line(self)
    return self.x * screenWidth,
        self.y * screenHeight,
        self.w * screenWidth,
        self.h * screenHeight
end

function Scaler.LineV2(pos1, pos2)
    return pos1.x * screenWidth, pos1.y * screenHeight,
        pos2.x * screenWidth, pos2.y * screenHeight
end


function HexToFloatColor(hexstring)
    local r, g, b = hexstring:find("(%x%x)(%x%x)(%x%x)")
    return mapfunc({r, g, b}, function(x) return tonumber(x, 16)/256 end)
end
