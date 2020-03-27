local player = {}

function player:new_player(image, x, y, w, h)
--    if not image then
    self.image = image;
--    end
    self.x = x;
    self.y = y;
    self.w = w;
    self.h = h;
    return self;
end

function player:set_speed()
    -- body
end

function player:draw()
    if self.image then
        love.graphics.draw(self.image, self.x, self.y);
    else
        love.graphics.rectangle("fill", self.x, self.y, self.w, self.h);
    end
end

return player;