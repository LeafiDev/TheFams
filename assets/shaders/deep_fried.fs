// deep_fried.fs - example "deep fried" fragment shader

extern number time;
extern number intensity;
extern number posterize;
extern number rgb_shift;
extern number grain;

// Engine-provided externs to map atlas texture coords to the sub-image
extern vec4 texture_details; // (x,y = offset, z=??, w=??) engine provides packing info
extern vec2 image_details;   // image size multiplier used by engine
extern bool shadow;

vec4 deep_fried(vec4 color, Image texture, vec2 texture_coords, vec2 pix) {
    // Map engine texture_coords (which are atlas coords) to the sub-image UV
    // Pattern borrowed from vanilla shaders (see negative.fs):
    vec2 uv = (((texture_coords) * (image_details)) - texture_details.xy * texture_details.ba) / texture_details.ba;
    vec4 center = Texel(texture, uv);

    if (posterize > 1.0) {
        center.rgb = floor(center.rgb * posterize) / posterize;
    }

    center.rgb = ((center.rgb - 0.5) * (1.0 + intensity)) + 0.5;

    float t = time * 2.0;
    vec2 off = vec2(cos(t), sin(t)) * (rgb_shift * 0.004);
    vec4 r = Texel(texture, uv + off);
    vec4 g = Texel(texture, uv);
    vec4 b = Texel(texture, uv - off);
    center.rgb = vec3(r.r, g.g, b.b);

    float n = fract(sin(dot(pix.xy ,vec2(12.9898,78.233))) * 43758.5453);
    n = (n - 0.5) * grain;
    center.rgb += n;

    center.rgb = clamp(center.rgb * (1.0 + intensity * 0.1), 0.0, 1.0);

    return center * color;
}

// LOVE expects an entrypoint named `effect`. Provide a thin wrapper so both
// the engine's shader-key/name check (deep_fried) and LOVE's entrypoint work.
vec4 effect(vec4 color, Image texture, vec2 uv, vec2 pix) {
    return deep_fried(color, texture, uv, pix);
}
