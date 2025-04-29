shader_type spatial;
render_mode vertex_lighting,specular_disabled,ambient_light_disabled;



uniform sampler2D mterrain_heightmap:filter_nearest;
uniform sampler2D mterrain_normals:filter_nearest;
uniform sampler2D mterrain_tcolor:source_color;

uniform sampler2D ground_tex0;
uniform sampler2D ground_tex1;
uniform sampler2D rock_tex0;


uniform sampler2D noise_tex;
uniform sampler2D leaves_tex:source_color;
uniform sampler2D rocks_tex:source_color;
uniform sampler2D rocks_normalmap:hint_normal;

uniform vec3 region_world_position;
uniform float region_size;
uniform float region_a;
uniform float region_b;
uniform int min_lod;
varying vec3 world_pos;
varying vec2 region_uv;

varying float mask_ground1;
varying float mask_rock0;

varying float close_mask;
varying vec2 close_uv;
varying vec2 far_uv;

const float close_scale = 0.15;
const float far_scale = 0.01;

const float close_distance = 110.0;
const float close_blend_amount = 40.0;

void vertex(){
	world_pos = (NODE_POSITION_WORLD + VERTEX);
	region_uv = (world_pos.xz - region_world_position.xz)/region_size;
	region_uv = region_uv*region_a + region_b;
	VERTEX.y = texture(mterrain_heightmap, region_uv).r;
	world_pos.y = VERTEX.y;
	vec3 n = texture(mterrain_normals, region_uv).rgb;
	n = fma(n,vec3(2.0),vec3(-1.0));
	NORMAL = n;
	float nxz = abs(n.x) + abs(n.z);
	mask_ground1 = step(0.3, nxz);
	mask_rock0 = step(0.7, nxz);
	float dis = length(CAMERA_POSITION_WORLD - world_pos);
	close_mask = smoothstep(close_distance+close_distance,close_distance,dis);
	close_uv = world_pos.xz*close_scale;
	far_uv = world_pos.xz*far_scale;
	//Scale world uv for terrain texture
}

vec4 distnace_texture(sampler2D _tex){
	vec4 final = texture(_tex, far_uv);
	final = mix(final,texture(_tex, close_uv), close_mask);
	return final;
}

void fragment(){
	vec3 tcolor = texture(mterrain_tcolor, region_uv).rgb;
	vec4 ncr = distnace_texture(ground_tex0);
	ncr = mix(ncr, distnace_texture(ground_tex1), mask_ground1);
	ncr = mix(ncr , distnace_texture(rock_tex0), mask_rock0);
	
	ALBEDO = tcolor * ncr.b;
	NORMAL_MAP = vec3(ncr.r, ncr.g , 1.0);
	ROUGHNESS = sqrt(ncr.a);

	float rock_inv = 1.0 - mask_rock0;
	float noise = texture(noise_tex, world_pos.xz*0.02).r;
	vec4 leaves = texture(leaves_tex, world_pos.xz*0.3);
	leaves.a *= smoothstep(0.5,0.52,noise)*rock_inv;
	ALBEDO = mix(ALBEDO, leaves.rgb, leaves.a);
	NORMAL_MAP = mix(NORMAL_MAP,vec3(0.5,0.5,1.0),leaves.a);
	ROUGHNESS = mix(ROUGHNESS,1.0,leaves.a);
	
	vec2 rocks_uv = world_pos.xz*0.4;
	vec4 rocks = texture(rocks_tex,rocks_uv);
	rocks.a *= rock_inv*smoothstep(0.7,0.68,noise);
	ALBEDO = mix(ALBEDO,rocks.rgb,rocks.a);
	NORMAL_MAP = mix(NORMAL_MAP,texture(rocks_normalmap,rocks_uv).rgb,rocks.a);
}
