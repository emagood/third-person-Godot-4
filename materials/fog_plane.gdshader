shader_type spatial;
render_mode unshaded,shadows_disabled,specular_disabled;

uniform sampler2D noise_texture;

uniform vec3 fog_color:source_color=vec3(0.0);

const float start_fade = 900.0;
const float end_fade = 100.0;

varying float dis_fade;
void vertex(){
	vec3 dir = CAMERA_POSITION_WORLD - NODE_POSITION_WORLD;
	float dis = length(dir);
	dis_fade = smoothstep(end_fade,start_fade,dis);
	dir.y=0.;
	dir = normalize(dir);
	mat3 tb = mat3(cross(vec3(0.,1.,0.),dir),vec3(0.,1.,0.),dir);
	VERTEX = tb * VERTEX;
	//NORMAL = dir;
}

void fragment() {
	float mask = length(UV - 0.5);
	mask = smoothstep(0.5,0.0,mask)*smoothstep(1.0,0.2,UV.y);
	vec2 uv = UV + vec2(0.0,1.0)*TIME*0.03;
	float n = texture(noise_texture,uv).r;
	ALBEDO = mix(0.2,1.0,n)*fog_color;
	ALPHA = n*dis_fade*mask;
	
	
}
