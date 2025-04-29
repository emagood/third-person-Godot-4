extends Control

@onready var lfps:= $SubViewportContainer/fps_label
@onready var menu:= $SubViewportContainer/Window

func _ready() -> void:
	get_tree().set_auto_accept_quit(false)

func _process(delta):
	lfps.text = "FPS: " + str(Engine.get_frames_per_second())


func _on_menu_pressed() -> void:
	prints("hola emanuel")
	var menu = preload("res://escenas/menu_config/menu_config.tscn").instantiate()
	add_child(menu)
	prints("instancio escena")
	await get_tree().create_timer(3).timeout



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
