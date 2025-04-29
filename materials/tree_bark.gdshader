shader_type spatial;

uniform sampler2D bark_tex;

uniform vec3 bark_color:source_color;

varying vec3 color;

void vertex() {
	UV *= length(MODEL_MATRIX[0])*0.1;
	float rand = fract(sin(NODE_POSITION_WORLD.x+NODE_POSITION_WORLD.z)*201.0);
	rand = mix(0.6,1.0, rand);
	color = clamp(mix(0.3,1.0,VERTEX.y),0.0,1.0)*bark_color*rand;
}

void fragment() {
	vec4 bark = texture(bark_tex,UV);
	ALBEDO = color*bark.b;
	NORMAL_MAP = vec3(bark.rg, 1.0);
	ROUGHNESS = mix(1.0, 0.5, color.b);
}