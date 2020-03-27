var = "LT,LB,RT,RB"
function string.split(str, split)
    local t = {}
    for subs in string.gmatch(str, "([^"..split.."]+)") do 
        table.insert(t, subs)
    end
    return t
end

strs = string.split(var, ',')
for _, v in ipairs(strs) do
    print("self.Color"..v..' = c'..v)
end