extends CanvasLayer
var active = false
var swich = false
func _on_h_slider_drag_ended(value_changed: bool) -> void:
	prints(value_changed)
	pass # Replace with function body.




func _on_button_pressed() -> void:
	active = !active
	prints("buton")
	$HSlider4.visible = active
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
	#var ray_val = $"../Movement/InAir"
	#var neg = -2 * value / 2
	#prints("valor de neg ",neg)
	#ray_val.ray_post = Vector3(0.0,neg , 0.0)
	vel.move_speed = value
	pass # Replace with function body.




func _on_h_slider_3_value_changed(value: float) -> void:
	var vel =$"../Movement/InAir"
	vel.max_jumps = value
	$HSlider3/Label.text = str( vel.max_jumps)


func _on_h_slider_4_value_changed(value: float) -> void:
	var val = $"../Skin/AnimationTree"
	var t = true
	
	if value >= 1:
		t = false 
	else:
		t = true
	val.active =  t
	$HSlider4/Label.text = "animaciones: " + str(t)
	pass # Replace with function body.
