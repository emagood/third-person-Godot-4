shader_type spatial;
render_mode cull_disabled,specular_disabled;

uniform sampler2D albedo_tex:source_color;


varying vec3 ygrad;
varying float sc;
void vertex() {
	float mv = sin(UV.y*100.0)*0.1;
	VERTEX.x += sin(TIME)*mv;
	VERTEX.z += cos(VERTEX.x + TIME)*mv;
	float dis = length(CAMERA_POSITION_WORLD - NODE_POSITION_WORLD);
	sc = smoothstep(30, 200, dis);
	NORMAL = vec3(0.,1.,0.);
}

void fragment() {
	vec4 albedo = texture(albedo_tex, UV);
	ALBEDO = albedo.rgb;
	ALPHA = albedo.a;
	ALPHA_SCISSOR_THRESHOLD = 0.4 - sc;
	ROUGHNESS = 1.0;
	if(!FRONT_FACING){
		NORMAL = - NORMAL;
	}
}