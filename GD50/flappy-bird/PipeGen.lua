local PipePair = require 'PipePair'
local Pipe = require 'Pipe'

local PipeGen = {
    gap = 64,
    randomness = 128,
    interval = 128
}

local pipeList = {}

function PipeGen.setSeed(seed)
    math.randomseed(seed)
end

function PipeGen.updateInfo()
    PipeGen.pipeNum = VIRTUAL_WIDTH / PipeGen.interval + 1
    PipeGen.startPos = PipeGen.interval
    PipeGen.genPos = (VIRTUAL_HEIGHT + PipeGen.gap) / 2
end

function PipeGen.setVar(gap, randomness, interval, speed)
    PipeGen.gap = math.max(PipeGen.gap, gap or PipeGen.gap)
    PipeGen.randomness= randomness or PipeGen.randomness
    PipeGen.interval = interval or PipeGen.interval
    PipeGen.speed = speed or 0
    PipeGen.updateInfo()
end

function PipeGen.randY()
    return math.random(-PipeGen.randomness, PipeGen.randomness) + PipeGen.genPos
end

function PipeGen.Gen()
    for i = 1, PipeGen.pipeNum do
        table.insert(pipeList, PipePair:new(PipeGen.startPos + i * PipeGen.interval, PipeGen.randY(), PipeGen.gap))
    end
end

function PipeGen.update(dt)
    local mink, maxk = 1, 1
    for k, v in ipairs(pipeList) do
        if pipeList[k].x <= pipeList[mink].x then
            mink = k
        end
        if pipeList[k].x >= pipeList[maxk].x then
            maxk = k
        end
        v.x = v.x - PipeGen.speed * dt
        -- v:update()
    end
    if pipeList[mink].x < -Pipe.w then
        pipeList[mink].x = pipeList[maxk].x + PipeGen.interval
        pipeList[mink].y = PipeGen.randY()
    end
end

function PipeGen.draw()
    for k, v in ipairs(pipeList) do
        v:draw()
        love.graphics.print(string.format("No.%d\tY:%d", k, v.y), 0, k * 16)
    end
end

return PipeGen