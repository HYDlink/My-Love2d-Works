MovingBall = class{
    pos = vector.zero,
    vel = vector.zero,
    num = 5, -- 残影数量
    time = 1,
    radius = 5
}

function MovingBall:init(pos, vel, acce, color)
    self.pos = pos
    self.vel = vel
    self.acce = acce or self.acce
    self.color = color or {1, 1, 1}
    self.poses = {}
end

function MovingBall:update(dt)
    if self.acce then
        self.vel = self.vel + self.acce * dt
    end
    self.pos = self.pos + self.vel * dt
    lume.push(self.poses, self.pos)
    while #self.poses > self.num do
        lume.remove(self.poses, self.poses[1])
    end 
end

function MovingBall:draw()
    r, g, b = unpack(self.color)
    for k, v in ipairs(self.poses) do
        love.graphics.setColor(r, g, b, k / #self.poses)
        love.graphics.ellipse('fill', v.x, v.y, self.radius, self.radius)
    end
end

return MovingBall