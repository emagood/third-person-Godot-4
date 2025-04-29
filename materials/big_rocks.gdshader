shader_type spatial;

uniform sampler2D rock_tex;
uniform sampler2D rock_orignal_color:source_color;

uniform vec3 rock_color:source_color=vec3(1.0);

varying vec2 scale_uv;

void vertex() {
	float scale = length(MODEL_MATRIX[2]);
	scale_uv = UV * scale*2.0;
}

void fragment() {
	vec4 rock = texture(rock_tex, scale_uv);
	vec3 orginal_color = texture(rock_orignal_color,UV).rgb;
	ALBEDO = orginal_color*rock.b;
	NORMAL_MAP = vec3(rock.rg,1.0);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
