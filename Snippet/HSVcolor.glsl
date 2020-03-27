vec3 HSV(float h, float s, float v) {
	if (s <= 0 ) { return vec3 (v); }
    h = h * 6;
	float c = v*s;
	float x = (1-abs((mod(h,2)-1)))*c;
	float m = v-c;
	float r = 0.0;
    float g = 0.0;
    float b = 0.0;

	if (h < 1) { r = c; g = x;b = 0.0;}
    else if (h < 2) { r = x; g = c; b = 0.0; }
    else if (h < 3) { r = 0.0; g = c; b = x; }
    else if (h < 4) { r = 0.0; g = x; b = c; }
    else if (h < 5) { r = x; g = 0.0; b = c; }
    else  { r = c; g = 0.0; b = x; }

	return vec3(r+m,g+m,b+m);
}

vec3 hsv(float h,float s,float v) { return mix(vec3(1.),clamp((abs(fract(h+vec3(3.,2.,1.)/3.)*6.-3.)-1.),0.,1.),s)*v; }