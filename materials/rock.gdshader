shader_type spatial;
render_mode specular_disabled;

uniform sampler2D rock_tex;
uniform sampler2D rock_colors_tex;

varying vec3 rock_color;

void vertex() {
	int color_id = int((NODE_POSITION_WORLD.x + NODE_POSITION_WORLD.z)*10.0);
	color_id = (color_id*100)%textureSize(rock_colors_tex, 0).x;
	rock_color = texelFetch(rock_colors_tex,ivec2(color_id,0),0).rgb;
	UV *= 6.0;
}

void fragment() {
	vec3 rock = texture(rock_tex, UV).rgb;
	ALBEDO = rock.b*rock_color;
	NORMAL_MAP = vec3(rock.rg , 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
