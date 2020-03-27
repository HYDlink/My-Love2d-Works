require 'flux'

width = 400
height = 400


function love.load()
    love.window.setMode(width, height)
    targetRad = 80
    radius = 100
    rads = { 0, 0, 0 }
    fastSpeed = 100
    slowSpeed = 10
    speed = { fastSpeed, 0, 0 }
    startT = { 0, 0.3, 0.5 }
    t = 0;
end

function speedDown(sp)
    flux:slowSpeed()
end

function love.update(dt)
    t = t + dt
    for i = 1, 3 do
        if t > startT[i] then
            speed[i] = fastSpeed
        end
        rads[i] = rads[i] + speed[i] * dt
    end
    if rads[1] >= targetRad then
        print('rad1 speedDown')
        speed[1] = slowSpeed
    end
    if speed[1] == slowSpeed and rads[2] >= rads[1] then
        print('rad2 speedDown')
        speed[2] = slowSpeed
    end
    if speed[2] == slowSpeed and rads[3] >= rads[2] then
        print('rad3 speedDown')
        speed[3] = slowSpeed
    end
end

function ellipse(rad, mode)
    mode = mode or 'line'
    love.graphics.ellipse(mode, width / 2, height / 2, rad, rad )
end

function love.draw()
    love.graphics.setColor(122, 0, 23)
    love.graphics.setLineWidth(20)
    ellipse(rads[1])
    love.graphics.setLineWidth(10)
    ellipse(rads[2])
    love.graphics.setColor(30, 0, 5)
    love.graphics.setLineWidth(40)
    ellipse(rads[3])
end