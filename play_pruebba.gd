extends CharacterBody3D
#player.anim_tree.set("parameters/RootState/transition_request", "crouching")
#	player.anim_tree.set("parameters/Crouching/blend_position", player.horizontal_velocity.length() / 4.0)

@onready var anim_tree = find_child("AnimationTree")

func _ready() -> void:
	
	#if self.anim_tree == null :
		#self.anim_tree = $"../modelo/AnimationTree"
	#anim_tree.set("parameters/RootState/transition_request", "crouching")
	#anim_tree.set("parameters/Crouching/blend_position", 4)
	prints(anim_tree)
	pass
func _process(delta: float) -> void:
	pass
