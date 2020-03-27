local panel = {
    curChess = 2,
    state = 'play'
}

-- chess 只是一个绘画的函数集合。。
-- TODO CSS主题读取
chesses = {
    function(x, y) --do nothing
    end,
    function(x, y, gw, gh)
        -- print(x, y, gw, gh)
        local gh = gh or gw
        local w = math.min(gh, gw) * 0.8
        love.graphics.setColor(1, 1, 1)
        love.graphics.circle('fill', x, y, w / 2)
    end,
    function(x, y, gw, gh) --do nothing
        -- print(x, y, gw, gh)
        local gh = gh or gw
        local w = math.min(gh, gw) * 0.8
        love.graphics.setColor(0, 0, 0)
        love.graphics.circle('fill', x, y, w / 2)
    end
}

function panel:init(w, h, chess)
    local w = w or self.w or 3
    local h = h or self.h or 3
    self.board = {}
    for i = 1, h do
        self.board[i] = {}
        for j = 1, w do
            self.board[i][j] = 1
        end
    end
    -- assert(type(chess) == 'table' and chess)
    self.chess = chess or self.chess or chesses
end

function panel:checkWin(x, y)
    local d = {1, -1, 0}
    for i = 1, 3 do
        for j = 1, 3 do
            -- 去除中间的访问
            if i == 3 and j == 3 then
                break
            end

            -- 重复的数组
            local count = 0
            local dx, dy = d[j], d[i]
            local tx, ty = x, y
            while self.board[ty + dy] and (self.board[ty + dy][tx + dx] == self.board[ty][tx]) do
                ty = ty + dy
                tx = tx + dx
                count = count + 1
            end
            if count >= 2 then
                return 'win'
            end
        end
    end

    for i = 1, #self.board do
        for j = 1, #self.board[1] do
            if self.board[i][j] == 1 then
                return 'no Result'
            end
        end
    end
    return 'draw'
end

function panel:handleMouse(x, y)
    if self.state ~= 'play' then
        self.state = 'play'
        self:init()
        return
    end
    local gridW = self.board[1] and (width / #self.board[1]) or width
    local gridH = height / #self.board
    local x = math.ceil(x / gridW)
    local y = math.ceil(y / gridH)
    -- 说不定点到边角根本ceil不了呢
    if x == 0 then
        x = 1
    end
    if y == 0 then
        y = 1
    end

    print(x, y)
    if self.board[y][x] == 1 then
        self.board[y][x] = self.curChess
        local result = self:checkWin(x, y)
        if result == 'win' then
            -- TODO
            self.state = self.curChess .. ' Wins'
            print(self.state)
        elseif result == 'draw' then
            self.state = 'Draw'
        end
        self.curChess = self.curChess == 2 and 3 or 2
    end
end

function panel:draw()

    love.graphics.setBackgroundColor(0.4, 0.5, 0.6)

    -- 棋盘分界线
    -- TODO border / margin 如果存在边界的话，那么检测棋子放下和绘画线条以及绘画棋子是不是都使用一个函数呢
    -- love.graphics.push()
    love.graphics.setColor(1, 1, 1)
    local gridH = height / #self.board
    local gridW = self.board[1] and (width / #self.board[1]) or width
    love.graphics.setLineWidth(4)
    -- love.graphics.setColor()
    for i = 0, #self.board do
        local y = i * gridH
        love.graphics.line(0, y, width, y)
    end
    if #self.board > 0 then
        for i = 0, #self.board[1] do
            local x = i * gridW
            love.graphics.line(x, 0, x, height)
        end
    end

    -- 棋子的绘画
    -- love.graphics.pop()
    for i = 1, #self.board do
        local y = i * gridH - gridH / 2
        for j = 1, #self.board[i] do
            local x = j * gridW - gridW / 2
            self.chess[self.board[i][j]](x, y, gridW, gridH)
        end
    end

    -- 蒙版
    if self.state ~= 'play' then
        love.graphics.setColor(0, 0, 0, 0.3)
        love.graphics.rectangle('fill', 0, 0, width, height)
        love.graphics.setColor(0, 0, 0, 0.6)
        love.graphics.rectangle('fill', 0, height / 2 - 40, width, 80)
        love.graphics.print(self.state, width / 2, height / 2)
    end
end

return panel
