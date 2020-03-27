local hex = {}

function table.map(tab, func)
    local newtable = {}
    for i, k in ipairs(tab) do
        newtable[i] = func(table[i])
    end
    return newtable
end

-- 怎么做出多参数的map呢
local function map(func, ...)
    local newtable = {}
    for i, k in ipairs(table.pack(...)) do
        newtable[i] = func(k)
    end
    return table.unpack(newtable)
end

function hex.rgb(hexstring)
    r, g, b = hexstring:find("(%x%x)(%x%x)(%x%x)")
    return map(function(x) return tonumber(x, 16) end, r, g, b)
end

function hex.complicateRgb(hexstring)
    return tonumber(hexstring:sub(1, 2), 16),
        tonumber(hexstring:sub(3, 4), 16),
        tonumber(hexstring:sub(5, 6), 16)
end

print(hex.rgb("F12678"))
print(hex.complicateRgb('F12678'))
