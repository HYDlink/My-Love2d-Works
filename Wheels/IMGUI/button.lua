theme = require 'theme'
return function(core, text, ...)
    opt, x, y, w, h = core.getOptionsAndSize(...)
    id = opt.id or text
    opt.font = opt.font or love.graphics.getFont()
    w = w or opt.font:getWidth(text) + 4
    h = h or opt.font:getHeight() + 4
    state = core:registerHitbox(id, x, y, w, h)
    core:registerDraw(theme.button, text, opt, x, y, w, h)
    return {
        id,
        hit = core:clicked(id),
        hovered = core:hovered(id),
        entered,
        leaved
    }
end