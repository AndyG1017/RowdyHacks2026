shader_type spatial;
render_mode cull_disabled;

uniform sampler2D water_tex : source_color, repeat_enable;
uniform sampler2D normal_tex : hint_normal, repeat_enable;
uniform vec3 tint : source_color = vec3(0.1, 0.4, 0.6);
uniform float tex_strength : hint_range(0.0, 1.0) = 0.5;
uniform float tex_scale = 0.05;
uniform vec2 scroll_a = vec2(0.02, 0.01);
uniform vec2 scroll_b = vec2(-0.015, 0.02);
uniform float alpha : hint_range(0.0, 1.0) = 0.75;
uniform float wave_height = 0.1;
uniform float wave_speed = 1.0;

varying vec3 world_pos;

void vertex() {
	world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	VERTEX.y += sin(world_pos.x * 0.5 + TIME * wave_speed)
			* cos(world_pos.z * 0.5 + TIME * wave_speed) * wave_height;
}

void fragment() {
	vec2 uv_a = world_pos.xz * tex_scale + TIME * scroll_a;
	vec2 uv_b = world_pos.xz * tex_scale * 1.7 + TIME * scroll_b;

	vec3 tex = mix(texture(water_tex, uv_a).rgb, texture(water_tex, uv_b).rgb, 0.5);
	ALBEDO = mix(tint, tex, tex_strength);

	NORMAL_MAP = mix(texture(normal_tex, uv_a).rgb, texture(normal_tex, uv_b).rgb, 0.5);

	ALPHA = alpha;
	ROUGHNESS = 0.1;
	SPECULAR = 0.6;
}