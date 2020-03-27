-- x, y, z, w are the positions to sample
-- iter is how many iterations (octaves) of the noise (default: 1)
-- amp is the amplitude factor (default: 0.5)
-- freq is the frequency factor (default: 2)
 
-- returns a fractal noise value in the range [-1.0, 1.0]
function genFractalNoise1(x, iter, amp, freq)
	val = love.math.noise(x)*2-1
	freq = freq or 2
	iter = iter or 1
	amp = amp or 0.5
	local n = 0
	while n < iter-1 do
		val = val + (love.math.noise(x*freq)*2-1)*amp
		freq = freq * freq
		amp = amp * amp
		n = n + 1
	end
	return math.max(math.min(val, 1.0), -1.0)
end
 
-- returns a fractal noise value in the range [-1.0, 1.0]
function genFractalNoise2(x, y, iter, amp, freq)
	val = love.math.noise(x, y)*2-1
	freq = freq or 2
	iter = iter or 1
	amp = amp or 0.5
	local n = 0
	while n < iter-1 do
		val = val + (love.math.noise(x*freq, y*freq)*2-1)*amp
		freq = freq * freq
		amp = amp * amp
		n = n + 1
	end
	return math.max(math.min(val, 1.0), -1.0)
end
 
-- returns a fractal noise value in the range [-1.0, 1.0]
function genFractalNoise3(x, y, z, iter, amp, freq)
	local val = love.math.noise(x, y, z)*2-1
	freq = freq or 2
	iter = iter or 1
	amp = amp or 0.5
	local n = 0
	while n < iter-1 do
		val = val + (love.math.noise(x*freq, y*freq, z*freq)*2-1)*amp
		freq = freq * freq
		amp = amp * amp
		n = n + 1
	end
	return math.max(math.min(val, 1.0), -1.0)
end
 
-- returns a fractal noise value in the range [-1.0, 1.0]
function genFractalNoise4(x, y, z, w, iter, amp, freq)
	local val = love.math.noise(x, y, z, w)*2-1
	freq = freq or 2
	iter = iter or 1
	amp = amp or 0.5
	local n = 0
	while n < iter-1 do
		val = val + (love.math.noise(x*freq, y*freq, z*freq, w*freq)*2-1)*amp
		freq = freq * freq
		amp = amp * amp
		n = n + 1
	end
	return math.max(math.min(val, 1.0), -1.0)
end