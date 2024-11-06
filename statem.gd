
extends Node
@onready var player = get_parent()
#@onready var anim  = find_child("AnimationTree")
func _ready() -> void:
	prints(player)
	prints(player.anim_tree)
	prints(randf_range(-1,  6))
	if player.anim_tree == null :
		return
	player.anim_tree.set("parameters/RootState/transition_request", "crouching")
	player.anim_tree.set("parameters/Crouching/blend_position", randf_range(-1,  1))


func _on_timer_timeout() -> void:
	player.anim_tree.set("parameters/RootState/transition_request", "crouching")
	player.anim_tree.set("parameters/Crouching/blend_position", randf_range(-1,  1))
	pass # Replace with function body.
