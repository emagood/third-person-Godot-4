extends Node
@onready var save
@onready var camera: bool = false
@export var SAVE_DIR = ""
var es_touch = false
var data: Dictionary = {
		#"name" : "Paw Bearer",
		#"jump_height" : 2.5,
		#"max_health" : 6,
		#"health" : 4,
		#"strength" : 11,
	}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	save = save_load.new()
	add_child(save)

	prints(data,"del singleton")

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func save_(data):
	self.data = data
	prints("data singletonshbkhhgygybhjkn " ,self.data)
	save._save(SAVE_DIR,data)
	prints(self.data,"datos singletoins")

	prints(data,"desde auto")
func load_(datai):
	save._load(SAVE_DIR,self.data)
	prints(self.data , "carga de singleton")
