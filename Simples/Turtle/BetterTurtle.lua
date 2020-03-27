vector = require 'vector'
Class = require 'class'
lume = require 'lume'
Line = require 'line'

-- TODO 使用 Class 导致不能同时存在两个turtle
local initLine = Line()
local turtle =
    Class {
    position = vector.zero,
    movedDist = 0,
    targetDist = 0,
    lineQueue = { initLine },
    lastLineIndex = 1,
    curLineIndex = 1,
}

function turtle:init()

end

function turtle:curLine()
    return self.lineQueue[self.curLineIndex]
end
function turtle:lastLine()
    return self.lineQueue[self.lastLineIndex]
end

function turtle:update(dt)
    if self.curLineIndex >= #self.lineQueue then return end
    self.movedDist = self.movedDist + self:curLine().vel * dt
    self.targetDist = self:curLine():length()
    if self.movedDist >= self.targetDist then
        self.movedDist = 0
        self.curLineIndex = self.curLineIndex + 1
        if self.curLineIndex >= #self.lineQueue then return end
        -- self.targetDist = self:curLine():length()
        print('Next Line' .. self.curLineIndex)
    end
    self.position = self:curLine().v1 + self:curLine().dir * self.movedDist
end

function turtle:pushLine(l)
    self.lineQueue[#self.lineQueue + 1] = l
    self.lastLineIndex = self.lastLineIndex + 1
end

function turtle:draw()
    for i = 1, self.curLineIndex - 1 do
        local l = self.lineQueue[i]
        l:draw()
    end
    self:curLine():draw(self.position.x, self.position.y)
    -- love.graphics.line(self:curLine().v1.x, self:curLine().v1.y, self.position.x, self.position.y)
end
function turtle:info()
    for k, v in ipairs(self.lineQueue) do
        print(k, v.v1, v.v2)
    end
end

function turtle:setPos(x, y)
    if self.lastLineIndex == 1 then self.position = vector(x, y) end
    self.lineQueue[self.lastLineIndex].v1 = vector(x, y)
end
function turtle:setVel(vel)
    self.lineQueue[self.lastLineIndex].vel = vel
end
function turtle:left(angle)
    local angle = angle or (math.pi / 2)
    self:lastLine().dir = self:lastLine().dir:rotated(angle)
end
function turtle:right(angle)
    local angle = angle or (math.pi / 2)
    self:lastLine().dir = self:lastLine().dir:rotated(-angle)
end
function turtle:forward(dist)
    -- assert(dist and type(dist) == 'number')
    local lastLine = self:lastLine()
    local from = lastLine.v1
    local to = from + lastLine.dir * dist
    lastLine.v2 = to
    local nextLine = Line(to, nil, lastLine.strokeWidth, lastLine.color, lastLine.vel, lastLine.dir)
    nextLine.v1 = to
    self:pushLine(nextLine)
end

-- tur = turtle()
-- tur:setVel(100)
-- tur:setPos(500/2, 400)
-- tur:forward(100)
-- tur:left()
-- tur:forward(200)
-- tur:right()
-- tur:forward(100)
-- tur:info()
-- tur:update(2)
-- tur:update(2)
-- tur:draw()

return turtle
