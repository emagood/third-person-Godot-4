shader_type spatial;
render_mode specular_disabled;

uniform sampler2D albedo_tex:source_color,filter_nearest_mipmap;

uniform vec3 leaves_color:source_color=vec3(1.);

void vertex() {
	float mv = (1.+UV.y);
	VERTEX.x += sin(TIME)*mv*0.05;
	VERTEX.z += cos(TIME)*mv*0.08;
	VERTEX.y += sin(TIME)*mv*0.05;
	//NORMAL = vec3(0.,1.,0.);
}

void fragment() {
	vec4 albedo = texture(albedo_tex, UV);
	ALBEDO = albedo.rgb*leaves_color;
	ALPHA = albedo.a;
	ALPHA_SCISSOR_THRESHOLD = 0.4;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
