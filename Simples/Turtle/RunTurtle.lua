local Turtle = require 'BetterTurtle'
local RunTurtle = Class()
local unpack = unpack or table.unpack

--[[
local funcTable = {
    forward = Turtle.forward,
    left = Turtle.left,
    right = Turtle.right,
    setpos = Turtle.setPos,
    setvel = Turtle.setVel,
    setwidth = Turtle.setWidth,
    setcolor = Turtle.setColor,
}
--]]

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

-- 绑定要执行的 turtle
function RunTurtle:init(turtle)
    if turtle == nil then
        error('Need to bind a turtle')
    end
    self.turtle = turtle
end

function RunTurtle:LoadOne(str)
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
    -- 直接调用 turtle 里面的名为 funcname 的函数, 
    -- 因此把 BetterTurtle 的函数名 都改成了小写
    self.turtle[funcName](self.turtle, unpack(params))
end

function RunTurtle:LoadAll(s)
    for _, str in s:lines() do
        self:LoadOne(str)
    end
    self.turtle:info()
end

-- f = io.open('input.txt', 'r')
-- s = f:read('a')
-- turtle.LoadAll(s)
return RunTurtle