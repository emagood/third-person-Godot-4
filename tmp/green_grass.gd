extends MGrass


@onready var terrain:=$".."

func _init():
	connect("grass_is_ready",Callable(self,"_on_grass_is_ready"))

func _on_grass_is_ready():
	var fnoise = FastNoiseLite.new()
	fnoise.fractal_gain = 0.9
	fnoise.frequency = 0.02
	for x in range(get_width()):
		for y in range(get_height()):
			var tpx = grass_px_to_grid_px(x,y)
			var normal = terrain.get_normal_accurate_by_pixel(tpx.x,tpx.y)
			
			var has_grass:bool = normal.y > 0.85
			var n = fnoise.get_noise_2d(x,y)
			has_grass = has_grass and n > -0.2
			
			#rand
			randomize()
			var rand = randf_range(0,1)
			has_grass = has_grass and rand > 0.1
			set_grass_by_pixel(x,y, has_grass)
	
	save_grass_data()
	update_dirty_chunks()
