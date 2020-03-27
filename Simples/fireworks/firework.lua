Firework = class{
    blasted = false,
    balls,
    blastNum = 40,
    -- staytime = 4,
    timer,
    velOffset = 50,
    fade = 0.8
}

function Firework:init(x, shootVel, minheight, maxheight, blastNum)
    self.blastHeight = math.random(minheight, maxheight)
    print(self.blastHeight)
    self.blastNum = blastNum or self.blastNum
    self.timer = 0
    self.balls = { MovingBall(vector(x, height), vector(0, -shootVel)) }
end

function Firework:update(dt)
    if not self.blasted then
        if self.balls[1].pos.y < self.blastHeight then
            self:blast()
        else
            self.balls[1]:update(dt)
        end
    end
    if self.blasted then
        for k, v in ipairs(self.balls) do
            v:update(dt)
            v.radius = v.radius * self.fade
            if v.radius < 1 then 
                lume.remove(self.balls, v)
            end
        end
    end
    self.timer = self.timer + dt
end

function Firework:blast()
    -- allow multiple blast time
    -- assert(#self.balls == 1 or not self.blast, "ball can only blast once")
    self.blasted = true
    local pos, veld = self.balls[1].pos, self.balls[1].vel:len()
    lume.clear(self.balls)
    for i = 1, self.blastNum do
        local vel = vector.fromPolar(math.pi * 2 * i / self.blastNum, veld + math.random(self.velOffset))
        local acce = vector(0, -500)
        self.balls[#self.balls + 1] = MovingBall(pos, vel, acce)
    end
end

function Firework:draw()
    for k, v in ipairs(self.balls) do
        v:draw()
    end
end

return Firework