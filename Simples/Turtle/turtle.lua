vector = require 'vector'
Class = require 'class'
lume = require 'lume'

local turtle =
    Class {
    position = vector.zero,
    direction = vector(0, -1), -- normalized vector
    vel = 40, -- number
    curVel = 0,
    strokeWidth = 8,
    movedDist = 0,
    targetDist = 0,
    funcQueue = {},
    funcIndex = 1,
}

local unpack = unpack or table.unpack

--[[ 海龟不会记忆方向和位置，他只会前进后退，左转右转
    路线是已经订好了的，我需要存储接下来要做的事件
--]]
local function setPos_p(self, x, y)
    self.position.x = x or self.position.x
    self.position.y = y or self.position.y
end

local function setVel_p(self, vel)
    assert(vel and type(vel) == 'number')
    self.vel = vel
end

local function rotate_p(self, angle)
    self.direction = self.direction:rotated(angle)
end

local function forward_p(self, distance)
    self.curVel = self.vel
    self.targetDist = distance
end
local function backward_p(self, distance)
    self.curVel = -self.vel
    self.targetDist = distance
end

function turtle:pushFunc_p(t)
    self.funcQueue[#self.funcQueue + 1] = t
end

-- 每次更新画一个圆非常不真实，这是拿笔在不断地点，很平常的速度都能发现出来
-- TODO 路径记录，每次重新画线，这样甚至不需要事件队列了！
function turtle:update(dt)
    if self.movedDist <= self.targetDist then
    local moveDist = self.curVel * dt
    self.position = self.position + self.direction * moveDist
    self.movedDist = self.movedDist + moveDist
    end
    while self.movedDist >= self.targetDist and self.funcIndex < #self.funcQueue do
        local temp = self.funcQueue[self.funcIndex]
        if temp and temp[1] then
            temp[1](self, unpack(lume.slice(temp, 2)))
            self.funcIndex = self.funcIndex + 1
        end
    end
end

function turtle:draw()
    love.graphics.circle('fill', self.position.x, self.position.y, 8)
end

function turtle:setPos(x, y)
    self:pushFunc_p {setPos_p, x, y}
end
function turtle:setVel(vel)
    self:pushFunc_p {setVel_p, vel}
end
function turtle:left(angle)
    local angle = angle or (math.pi / 2)
    self:pushFunc_p {rotate_p, -angle}
end
function turtle:right(angle)
    local angle = angle or (math.pi / 2)
    self:pushFunc_p {rotate_p, angle}
end
function turtle:forward(dist)
    assert(dist and type(dist) == 'number')
    self:pushFunc_p {forward_p, dist}
end

-- tur = turtle()
-- tur:setPos(500/2, 400)
-- tur:forward(100)
-- tur:update(10)

-- 一个简短的测试用例
function turtle:load()
    turtle:setVel(100)
    turtle:setPos(width/2, height / 2)
    turtle:forward(100)
    turtle:left()
    turtle:forward(100)
end

-- hook love.run 取消每次 love.draw 之前的 clear
function love.run()
 
	if love.math then
		love.math.setRandomSeed(os.time())
	end
 
	if love.load then love.load(arg) end
 
	-- We don't want the first frame's dt to include time taken by love.load.
	if love.timer then love.timer.step() end
 
	local dt = 0
 
	-- Main loop time.
	while true do
		-- Process events.
		if love.event then
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a
					end
				end
				love.handlers[name](a,b,c,d,e,f)
			end
		end
 
		-- Update dt, as we'll be passing it to update
		if love.timer then
			love.timer.step()
			dt = love.timer.getDelta()
		end
 
		-- Call update and draw
		if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled
 
		if love.graphics and love.graphics.isActive() then
			-- love.graphics.clear(love.graphics.getBackgroundColor())
			love.graphics.origin()
			if love.draw then love.draw() end
			love.graphics.present()
		end
 
		if love.timer then love.timer.sleep(0.001) end
	end
 
end

return turtle
