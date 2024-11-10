extends Node

func _init() -> void:
	ProjectSettings.set_setting("renderer/rendering_method", "mobile")#Vulkan
	#ProjectSettings.save()  # Guardar la configuración
	ProjectSettings.save_custom("user://override.cfg")
	print(ProjectSettings.get_setting("renderer/rendering_method"))
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ProjectSettings.set_setting("renderer/rendering_method", "mobile")#Vulkan
	#ProjectSettings.save()  # Guardar la configuración
	ProjectSettings.save_custom("user://override.cfg")
	print(ProjectSettings.get_setting("renderer/rendering_method"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
