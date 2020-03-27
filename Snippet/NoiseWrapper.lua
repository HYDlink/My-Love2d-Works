local function clamp(v, M, m)
	return (v > M and M or v) < m and m or v
end
 
local function fractalNoise2(x, y, n, a, f)
	local ca = 1
	local cf = 1
	local val = 0
	for _=1, n do
		val = val + (love.math.noise(x*cf, y*cf)*2-1)*ca
		ca = ca * a
		cf = cf * f
	end
	return clamp(val, 1, -1)
end
 
local function fractalNoise3(x, y, z, n, a, f)
	local ca = 1
	local cf = 1
	local val = 0
	for _=1, n do
		val = val + (love.math.noise(x*cf, y*cf, z*cf)*2-1)*ca
		ca = ca * a
		cf = cf * f
	end
	return clamp(val, 1, -1)
end
 
local function fractalNoise4(x, y, z, w, n, a, f)
	local ca = 1
	local cf = 1
	local val = 0
	for _=1, n do
		val = val + (love.math.noise(x*cf, y*cf, z*cf, w*cf)*2-1)*ca
		ca = ca * a
		cf = cf * f
	end
	return clamp(val, 1, -1)
end
 
-- Giving less than or equal to 2 arguments will generate normal simplex noise
-- normalized from -1 to 1. For 2 or 3 parameters, it will generate Perlin
-- noise. Giving more than 4 arguments will generate fractal noise.
-- When generating fractal noise, the last 3 arguments will be the
-- amount of octaves, the amplitude scale factor, and the frequency scale
-- factor, respectively.
--
-- noiseWrapper(x, [y, [z, [w, [n, a, f]]]])
function noiseWrapper(...)
	local l = #{...}
	if l <= 4 then
		return love.math.noise(...)*2-1
	elseif l == 5 then
		return fractalNoise2(...)
	elseif l == 6 then
		return fractalNoise3(...)
	elseif l == 7 then
		return fractalNoise4(...)
	else return nil end
end
