Input = require 'Others.input'

function love.load()
    input = Input()
    input:bind('mouse1', 'test')
end

function love.update(dt)
    if input:down('test', 0.5, 2) then
        print(math.random())
    end
end