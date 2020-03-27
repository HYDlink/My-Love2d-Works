local Timer = {}
-- 这两个分离好了, 不然如果用pairs的话, 还会遍历到Timer定义的函数
local timers = {}
-- tag 用于索引, 以取消/更新/记录指定timer
function Timer.after(delay, action, repeatable, tag)
    timers[tag] = {current_time = 0, delay = delay, action = action, repeatable = repeatable}
end

function Timer.update(dt)
    for tag, v in pairs(timers) do
        v.current_time = v.current_time + dt
        if v.current_time > v.delay then
            if v.action then v.action() end
            -- v = nil
            if v.repeatable then
                if type(v.repeatable) == 'number' then
                    v.repeatable = v.repeatable - 1
                    if v.repeatable <= 0 then
                        timers[tag] = nil
                    end
                end
                v.current_time = 0
            else
            timers[tag] = nil
            end
        end
    end
end

return Timer