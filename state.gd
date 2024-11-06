extends Node
@onready var player = get_parent()
@onready var anim = $"../modelo/AnimationTree"
func _ready() -> void:

	anim.set("parameters/RootState/transition_request", "crouching")
	anim.set("parameters/Crouching/blend_position", 4)
