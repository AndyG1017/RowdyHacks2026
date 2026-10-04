shader_type spatial;

uniform sampler2D grass_tex : source_color, repeat_enable;
uniform sampler2D rock_tex : source_color, repeat_enable;
uniform float tex_scale = 0.1;
uniform float slope_start = 0.6;
uniform float slope_end = 0.8;

varying vec3 world_pos;
varying vec3 world_normal;

void vertex() {
	world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	world_normal = normalize((MODEL_MATRIX * vec4(NORMAL, 0.0)).xyz);
}

void fragment() {
	vec3 grass = texture(grass_tex, world_pos.xz * tex_scale).rgb;
	vec3 rock = texture(rock_tex, world_pos.xz * tex_scale).rgb;
	float t = smoothstep(slope_start, slope_end, world_normal.y);
	ALBEDO = mix(rock, grass, t);
}
