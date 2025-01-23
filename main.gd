extends Node3D
@onready var label_text = $Control/Label



# Called when the node enters  the scene tree for the first time.
func _ready() -> void:
	get_tree().set_auto_accept_quit(false)
	
	
	prints("config")
	var menu = preload("res://escenas/menu_config/menu_config.tscn").instantiate()
	add_child(menu)
	menu.queue_free()
	prints("instancio config")
	await get_tree().create_timer(3).timeout
	pass # Replace with function body.
	## Luego cargar la escena principal
	#var main_scene = load("res://ruta/a/tu/escena_principal.tscn")
	#get_tree().change_scene_to(main_scene)
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label_text.text = str(Engine.get_frames_per_second())
	pass




func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_K):
	
		prints("hola emanuel")
		var player = preload("res://player/Player.tscn").instantiate()
		add_child(player)
		prints("instancio escena")
		await get_tree().create_timer(3).timeout





func _on_menu_pressed() -> void:
	prints("hola emanuel")
	var menu = preload("res://escenas/menu_config/menu_config.tscn").instantiate()
	add_child(menu)
	prints("instancio escena")
	await get_tree().create_timer(3).timeout
	pass # Replace with function body.
	
	
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		prints("hola emanuel")
		var menu = preload("res://quit.tscn").instantiate()
		add_child(menu)
		prints("instancio escena")
		await get_tree().create_timer(3).timeout
		prints("quit")
		#get_tree().quit() # default behavior NOTIFICATION_WM_GO_BACK_REQUEST
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		prints("hola emanuel")
		var menu = preload("res://quit.tscn").instantiate()
		add_child(menu)
		prints("instancio escena")
		await get_tree().create_timer(3).timeout
		prints("quit")



	# Cambiar configuración de renderizado



func _on_timer_timeout() -> void:
	
	pass # Replace with function body.
