vector = require 'vector'
lume = require 'lume'
Line = require 'line'

-- TODO 使用 Class 导致不能同时存在两个turtle
local initLine = Line()
local turtle = {
    position = vector.zero,
    movedDist = 0,
    targetDist = 0,
    lineQueue = {initLine},
    lastLineIndex = 1,
    curLineIndex = 1
}

function turtle.init()
end

function turtle.curLine()
    return turtle.lineQueue[turtle.curLineIndex]
end
function turtle.lastLine()
    return turtle.lineQueue[turtle.lastLineIndex]
end

function turtle.update(dt)
    if turtle.curLineIndex >= #turtle.lineQueue then
        return
    end
    turtle.movedDist = turtle.movedDist + turtle.curLine().vel * dt
    turtle.targetDist = turtle.curLine():length()
    if turtle.movedDist >= turtle.targetDist then
        turtle.movedDist = 0
        turtle.curLineIndex = turtle.curLineIndex + 1
        if turtle.curLineIndex >= #turtle.lineQueue then
            return
        end
        -- turtle.targetDist = turtle.curLine().length()
        print('Next Line' .. turtle.curLineIndex)
    end
    turtle.position = turtle.curLine().v1 + turtle.curLine().dir * turtle.movedDist
end

function turtle.pushLine(l)
    turtle.lineQueue[#turtle.lineQueue + 1] = l
    turtle.lastLineIndex = turtle.lastLineIndex + 1
end

function turtle.draw()
    for i = 1, turtle.curLineIndex - 1 do
        local l = turtle.lineQueue[i]
        l:draw()
    end
    turtle.curLine():draw(turtle.position.x, turtle.position.y)
    -- love.graphics.line(turtle.curLine().v1.x, turtle.curLine().v1.y, turtle.position.x, turtle.position.y)
end
function turtle.info()
    for k, v in ipairs(turtle.lineQueue) do
        print(v:info('all'))
    end
end

function turtle.setPos(x, y)
    if turtle.lastLineIndex == 1 then
        turtle.position = vector(x, y)
    end
    turtle.lineQueue[turtle.lastLineIndex].v1 = vector(x, y)
end
function turtle.setVel(vel)
    turtle.lineQueue[turtle.lastLineIndex].vel = vel
end
function turtle.setWidth(width)
    turtle.lineQueue[turtle.lastLineIndex].width = width
end
function turtle.setColor(r, g, b)
    turtle.lineQueue[turtle.lastLineIndex].color = { r, g, b }
end
function turtle.left(angle)
    local angle = angle or (math.pi / 2)
    turtle.lastLine().dir = turtle.lastLine().dir:rotated(angle)
end
function turtle.right(angle)
    local angle = angle or (math.pi / 2)
    turtle.lastLine().dir = turtle.lastLine().dir:rotated(-angle)
end
function turtle.forward(dist)
    -- assert(dist and type(dist) == 'number')
    local lastLine = turtle.lastLine()
    local from = lastLine.v1
    local to = from + lastLine.dir * dist
    lastLine.v2 = to
    local nextLine = Line(to, nil, lastLine.strokeWidth, lastLine.color, lastLine.vel, lastLine.dir)
    nextLine.v1 = to
    turtle.pushLine(nextLine)
end

-- tur = turtle()
-- tur.setVel(100)
-- tur.setPos(500/2, 400)
-- tur.forward(100)
-- tur.left()
-- tur.forward(200)
-- tur.right()
-- tur.forward(100)
-- tur.info()
-- tur.update(2)
-- tur.update(2)
-- tur.draw()

return turtle
