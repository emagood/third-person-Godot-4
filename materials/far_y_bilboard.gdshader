shader_type spatial;
render_mode vertex_lighting,shadows_disabled,specular_disabled;
uniform sampler2D color_tex:source_color,repeat_disable;

uniform vec3 albedo_color:source_color=vec3(1.0);
uniform float alpha_scissor:hint_range(0.0, 1.0, 0.01);
uniform vec2 uv_scale;
uniform vec2 uv_offset;

varying float dis_mask;

void vertex() {
	vec3 dir = CAMERA_POSITION_WORLD - NODE_POSITION_WORLD;
	//dis_mask = length(dir);
	dir.y=0.;
	dir = normalize(dir);
	mat3 tb = mat3(cross(vec3(0.,1.,0.),dir),vec3(0.,1.,0.),dir);
	VERTEX = tb * VERTEX;
	//NORMAL = dir;
	UV = UV*uv_scale + uv_offset;
	//dis_mask = smoothstep(1300.0, 900.0, dis_mask);
	NORMAL = vec3(0.,1.,0.);
}

void fragment() {
	vec4 color = texture(color_tex, UV);
	ALBEDO = color.rgb*albedo_color;
	ROUGHNESS = 1.0;
	ALPHA = color.a;
	ALPHA_SCISSOR_THRESHOLD = alpha_scissor;
}