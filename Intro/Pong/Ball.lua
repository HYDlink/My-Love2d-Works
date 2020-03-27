local Ball = {
    w = 4,
    v = 0,
    angle = 0,
    v = 400,
    moving = false
}

-- x, y为中心，这样也便于计算
function Ball:reset()
    self.x, self.y = gameWidth / 2, gameHeight / 2
    self.moving = false
end

-- 仅仅是发射的方向
function Ball:setDir(player)
    assert(player == 1 or player == 2, 'wrong player No')
    local x = player * 2 - 3
    local y = (math.random() - 0.5) * 4
    self.angle = math.atan2(y, x)
    print(self.angle)
end

function Ball:setMove(move)
    assert(type(move) == 'boolean')
    self.moving = move
end

function Ball:isMove()
    return self.v > 0
end

function Ball:rect()
    return {x = self.x - self.w / 2, y = self.y - self.w / 2, w = self.w * 2, h = self.w * 2}
end

function Ball:update(dt)
    if not self.moving then return end
    self.x = self.x + self.v * math.cos(self.angle) * dt
    self.y = self.y + self.v * math.sin(self.angle) * dt
end

function Ball:draw()
    love.graphics.circle('fill', self.x, self.y, self.w)
end

return Ball