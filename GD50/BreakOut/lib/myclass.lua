local Class = {}
function Class:new(o)
    local o = o or {}
    self.__index = self
    return setmetatable(o, self)
end

return setmetatable(Class, {
    __call = function (c, ...)
        return c:new(...)
    end
})