-- require 'global'

lume = require 'lume'

arr = { 1, 2, 3, 4, 5}
lume.push(arr, 6, 7)
arr[#arr + 1] = 6
print(lume.unique(arr))

print(lume.uuid())

local function identity(x)
    return x
end

local function isarray(t)
    return t[1] ~= nil
end

local function getiter(t)
    assert(type(t) == 'table', 'must be table type')
    if isarray(t) then return ipairs end
    return pairs
end

local serialize
local serialize_map = {
    ['nil'] = tostring,
    ['boolean'] = tostring,
    ['number'] = function(x)
        if x ~= x then return '0/0' -- nan
        elseif x == 1 / 0 then return 'inf' -- inf
        elseif x == -1 / 0 then return '-inf' end -- -inf
        return tostring(x)
    end,
    ['string'] = identity,
    ['table'] = function (t, stk) -- stk用于保存当前遍历过的表, 检测是否发生循环引用
        stk = stk or {}
        if stk[t] then 
            error('循环引用表发现')
        end
        rtn = {}
        local iter = getiter(t)
        for k, v in iter(t) do
            rtn[#rtn + 1] = '[' .. serialize(k, stk) .. '] = ' .. serialize(v, stk)
        end
        return '{ ' .. table.concat(rtn, ', ') .. ' }'
    end
}

-- 使用__index元方法来为不支持的类型报错
setmetatable(serialize_map, {
    __index = function (_, k)
        error("Not supported type: " .. k)
    end
})

serialize = function(x, stk)
    return serialize_map[type(x)](x, stk)
end

print(serialize(s))