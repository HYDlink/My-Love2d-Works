local grid = {}

GridXCount, GridYCount = 4, 4
PieceSize = 100
local emptyX, emptyY

local function setGrid()
    local c = 1
    for i = 1, GridYCount do
        grid[i] = {}
        for j = 1, GridXCount do
            grid[i][j] = c
            c = c + 1
        end
    end
    -- grid[GridYCount][GridXCount] = 0
    emptyX, emptyY = GridXCount, GridYCount
end

local function move(str)
    local newEmptyX, newEmptyY = emptyX, emptyY
    if str == 'left' then
        newEmptyX = emptyX - 1
    elseif str == 'right' then
        newEmptyX = emptyX + 1
    elseif str == 'up' then
        newEmptyY = emptyY - 1
    elseif str == 'down' then
        newEmptyY = emptyY + 1
    else
        error('not corret move string: ' .. str)
    end
    if grid[newEmptyY] and grid[newEmptyY][newEmptyX] then
        grid[newEmptyY][newEmptyX], grid[emptyY][emptyX] = grid[emptyY][emptyX], grid[newEmptyY][newEmptyX]
        emptyX, emptyY = newEmptyX, newEmptyY
    end
end

local rollTable = {'left', 'right', 'up', 'down'}
local function shuffle(times)
    for _ = 1, times do
        local roll = math.random(4)
        move(rollTable[roll])
    end
end
local function isComplete()
    local count = 1
    for y = 1, GridYCount do
        for x = 1, GridXCount do
            -- local count = (y - 1) * GridXCount + x
            if grid[y][x] ~= count then
                return false
            end
            count = count + 1
        end
    end
    return true
end

function love.load()
    love.graphics.setNewFont(30)
    love.window.setMode(GridXCount * PieceSize, GridYCount * PieceSize)
    love.window.setTitle('fifteen')
    setGrid()
    shuffle(1000)
end

local keyToMove = {
    w = 'up',
    s = 'down',
    a = 'left',
    d = 'right'
}
function love.keypressed(key)
    if keyToMove[key] then
        move(keyToMove[key])
    end
end
function love.draw()
    if isComplete() then
        love.graphics.print('you win')
        return
    end
    for y = 1, GridYCount do
        for x = 1, GridXCount do
            if x ~= emptyX or y ~= emptyY then
                local pieceDrawSize = PieceSize - 1
                love.graphics.setColor(.4, .1, .6)
                love.graphics.rectangle(
                    'fill',
                    (x - 1) * PieceSize,
                    (y - 1) * PieceSize,
                    pieceDrawSize,
                    pieceDrawSize
                )
                love.graphics.setColor(1, 1, 1)
                love.graphics.print(
                    grid[y][x],
                    (x - 1) * PieceSize,
                    (y - 1) * PieceSize
                )
            end
        end
    end
end