local core = {}
core.__index = core
function core.new()
    return setmetatable({
        drawQueue = { n = 0 },
        idSize = 0,
        mouseX = 0,
        mouseY = 0,
        mouseDown,
        hover, lasthover,
        clickedID,
        button = require 'button'
    }, core)
end

-- 第一个参数可选, 是否为表
function core.getOptionsAndSize(opt, ...)
	if type(opt) == "table" then
		return opt, ...
	end
	return {}, opt, ...
end
function core:getID()
    self.idSize = self.idSize + 1
    return idSize
end

function core:mouseInRect(x, y, w, h)
    return self.mouseX > x and self.mouseX < x + w and
        self.mouseY > y and self.mouseY < y + h
end

function core:clicked(id)
    return self.clickedID == id
end

function core:hovered(id)
    return self.hover == id
end

function core:registerHitbox(id, x, y, w, h)
    if self:mouseInRect(x, y, w, h) then
        if self.mouseDown then
            self.clickedID = id
        else
            self.hover = id
        end
    end
end

function core:updateMouse(x, y, clicked)
    self.mouseX, self.mouseY, self.mouseDown = x, y, clicked
    
end

function core:registerDraw(func, ...)
    args = {...}
    self.drawQueue.n = self.drawQueue.n + 1
    -- 因为...不能被闭包捕获
    self.drawQueue[self.drawQueue.n] = function() func(unpack(args)) end
end

function core:draw()
    for i = 1, self.drawQueue.n do
        self.drawQueue[i]()
    end
    self.drawQueue.n = 0
    self:updateMouse(love.mouse.getX(), love.mouse.getY(), love.mouse.isDown(1))
end

return core