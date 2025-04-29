extends CanvasLayer
var active = false
var swich = false
func _on_h_slider_drag_ended(value_changed: bool) -> void:
	prints(value_changed)
	pass # Replace with function body.




func _on_button_pressed() -> void:
	active = !active
	prints("buton")

	$HSlider.visible = active
	$HSlider3.visible = active
	$HSlider2.visible = active

	pass # Replace with function body.


func _on_h_slider_value_changed(value: float) -> void:
	prints(value)
	var vel = $"../Movement/Crouching/Moving"
	vel.move_speed = value
	#queria acelerar caminar no agachar pero esta bueno 
	pass # Replace with function body.



func _on_h_slider_2_value_changed(value: float) -> void:
	prints(value)
	var vel = $"../Movement/OnGround/Running"
	vel.move_speed = value
	pass # Replace with function body.




func _on_h_slider_3_value_changed(value: float) -> void:
	var vel =$"../Movement/InAir"
	vel.max_jumps = value
	$HSlider3/Label.text = str( vel.max_jumps)
