local Input = {}
Input.__index = Input

Input.all_keys = {
    " ", "return", "escape", "backspace", "tab", "space", "!", "\"", "#", 
    "$", "&", "'", "(", ")", "*", "+", ",", "-", ".", "/", "0", "1", "2", "3", "4",
    "5", "6", "7", "8", "9", ":", ";", "<", "=", ">", "?", "@", "[", "\\", "]", 
    "^", "", "`", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
    "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "capslock",
    "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "f9", "f10", "f11", "f12", "printscreen",
    "scrolllock", "pause", "insert", "home", "pageup", "delete", "end", "pagedown", 
    "right", "left", "down", "up", "numlock", "kp/", "kp*", "kp-", "kp+", "kpenter",
    "kp0", "kp1", "kp2", "kp3", "kp4", "kp5", "kp6", "kp7", "kp8", "kp9", "kp.", "kp,", 
    "kp=", "application", "power", "f13", "f14", "f15", "f16", "f17", "f18", "f19",
    "f20", "f21", "f22", "f23", "f24", "execute", "help", "menu", "select", "stop", 
    "again", "undo", "cut", "copy", "paste", "find", "mute", "volumeup", "volumedown",
    "alterase", "sysreq", "cancel", "clear", "prior", "return2", "separator", "out", 
    "oper", "clearagain", "thsousandsseparator", "decimalseparator", "currencyunit",
    "currencysubunit", "lctrl", "lshift", "lalt", "lgui", "rctrl", "rshift", "ralt", 
    "rgui", "mode", "audionext", "audioprev", "audiostop", "audioplay", "audiomute",
    "mediaselect", "brightnessdown", "brightnessup", "displayswitch", "kbdillumtoggle", 
    "kbdillumdown", "kbdillumup", "eject", "sleep", "mouse1", "mouse2", "mouse3",
    "mouse4", "mouse5", "wheelup", "wheeldown", "fdown", "fup", "fleft", "fright", 
    "back", "guide", "start", "leftstick", "rightstick", "l1", "r1", "l2", "r2", "dpup",
    "dpdown", "dpleft", "dpright", "leftx", "lefty", "rightx", "righty",
}

function Input.new()
    local self = {}
    self.state = {}
    self.prev_state = {}
    self.repeat_state = {}
    self.functions = {}
    self.binds = {}
    local callback = {'update', 'keypressed', 'keyreleased'}
    local emptyfunc = function() end
    local oldfunc = {}
    for _, f in ipairs(callback) do
        oldfunc[f] = love[f] or emptyfunc
        love[f] = function(...)
            oldfunc[f](...)
            self[f](self, ...)
        end
    end
    return self
end

function Input:bind(key, action)
    if type(action) == 'function' then
        self.functions[key] = action
        return
    end
    if not self.bind[action] then self.bind[action] = {} end
    table.insert(self.bind[action], key)
end

function Input:unbind(key)
    
end
function Input:down(action, interval, delay)
    if action and interval then
        delay = delay or 0
        for _, key in ipairs(self.binds[action]) do
            if self.state[key] and not self.prev_state[key] then
                self.repeat_state[key] = {pressed_time = love.timer.getTime(), delay = delay, interval = interval, delay_stage = true}
                return true
            elseif self.repeat_state[key] and self.repeat_state[key].pressed then
                return true
            end
        end

    elseif action and not interval and not delay then
        for _, key in ipairs(self.binds[action]) do
            if (love.keyboard.isDown(key) or love.mouse.isDown(key_to_button[key] or 0)) then
                return true
            end
        end
    end
end