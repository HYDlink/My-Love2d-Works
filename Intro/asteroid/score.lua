local Score = {
    score = 0
}

function Score:new(fontSize, fontname)
    -- read high score
    self.score = 0
    self.fontSize = fontSize or 16
    self.__index = self
    
    if fontname then
        self.font = love.graphics.newFont('C:\\Windows\\Fonts\\' .. fontname)
        self.font:setLineHeight(self.fontSize)
        love.graphics.setFont(self.font)
    end
    return setmetatable({}, self)
end

function Score:draw()
    love.graphics.print(self.score)
end

return Score