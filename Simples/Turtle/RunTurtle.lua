turtle = require 'OnlyOneTurtle'
lume = require 'lume'

local unpack = unpack or table.unpack

local funcTable = {
    forward = turtle.forward,
    left = turtle.left,
    right = turtle.right,
    setpos = turtle.setPos,
    setvel = turtle.setVel,
    setwidth = turtle.setWidth,
    setcolor = turtle.setColor,
}

function string.lines(s)
    local function iter(str, index)
        if index >= #s then 
            return nil, nil
        end
        lastLine = index
        index = str:find('\n', index)
        -- 没有继续找到换行符 - 达到EOF
        if index == nil then
            return nil, str:sub(lastLine, #str)
        end
        return index + 1, str:sub(lastLine, index - 1)
    end
    local init = 1
    return iter, s, init
end

function turtle.LoadOne(str)
    -- comment
    if str[1] == '#' then
        return
    end

    funcName = str:match('(%a+)[%s*%(]'):lower()
    params = {}
    for i in str:gmatch('[%d%.]+') do
        params[#params + 1] = tonumber(i)
    end
    print(funcName, lume.serialize(params))

    assert(funcTable)
    funcTable[funcName](unpack(params))
end

function turtle.LoadAll(s)
    for _, str in s:lines() do
        turtle.LoadOne(str)
    end
    turtle.info()
end

-- f = io.open('input.txt', 'r')
-- s = f:read('a')
-- turtle.LoadAll(s)
