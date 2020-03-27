local animation = {}
function animation.new_animation(image, width, height, duration)
    local animation = { image = image, width = width, height = height, duration = duration };
    
    function animation:update() 
        
    end
end

return animation