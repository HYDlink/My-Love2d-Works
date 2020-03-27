#pragma language glsl3

uniform vec4 TopLeftC    ; // = vec4(1., 1., 1., 1.);
uniform vec4 TopRightC   ; // = vec4(1., 0., 0., 1.);
uniform vec4 ButtonLeftC ; // = vec4(0., 0., 0., 1.);
uniform vec4 ButtonRightC; // = vec4(0., 0., 0., 1.);

// uniform float ScreenWidth;
// uniform float ScreenHeight;

vec4 lerp(float inparam, vec4 a, vec4 b) {
    return a + inparam * (b - a);
}
vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ) {
    vec2 pos = texture_coords;
    color = vec4(lerp(pos.x, lerp(pos.y, TopLeftC, ButtonLeftC), lerp(pos.y, TopRightC, ButtonRightC)));
    return color;
}