local theme = {
    cornerRadius = 4
}

theme.color = {
	normal   = {bg = { 0.25, 0.25, 0.25}, fg = {0.73,0.73,0.73}},
	hovered  = {bg = { 0.19,0.6,0.73}, fg = {1,1,1}},
	active   = {bg = {1,0.6,  0}, fg = {1,1,1}}
}

-- HELPER
function theme.getColorForState(opt)
	local s = opt.state or "normal"
	return (opt.color and opt.color[opt.state]) or theme.color[s]
end

function theme.drawBox(x,y,w,h, colors, cornerRadius)
	colors = colors or theme.getColorForState(opt)
	cornerRadius = cornerRadius or theme.cornerRadius
	w = math.max(cornerRadius/2, w)
	if h < cornerRadius/2 then
		y,h = y - (cornerRadius - h), cornerRadius/2
	end

	love.graphics.setColor(colors.bg)
	love.graphics.rectangle('fill', x,y, w,h, cornerRadius)
end

function theme.getVerticalOffsetForAlign(valign, font, h)
    if valign == 'up' then
        return 0
    elseif valign == 'down' then
        return h - font:getHeight()
    else
        return (h - font:getHeight()) / 2
    end
end

function theme.button(text, opt, x, y, w, h)
	local c = theme.getColorForState(opt)
    theme.drawBox(x, y, w, h, c, opt.cornerRadius)
    love.graphics.setColor(c.fg)    
	love.graphics.setFont(opt.font)

	y = y + theme.getVerticalOffsetForAlign(opt.valign, opt.font, h)
	love.graphics.printf(text, x+2, y, w-4, opt.align or "center")
end

return theme