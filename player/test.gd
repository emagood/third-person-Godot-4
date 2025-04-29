extends RayCast3D


func _process(delta):
	var raycast = self
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		print("Colisionó con: ", collider.name)
