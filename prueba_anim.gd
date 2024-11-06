extends Node3D
@onready var label = $Label
var a
var b
var i = 100
var debug = EngineDebugger
func _ready() -> void:
	
	#Engine.debug.log "Value: ", script_debug_value
	## Godot Debugger: add_variable name, value; 1+ ' '
	
	print_debug(log,debug , "    ","prueba")
	
	#seed(12345)
	var my_seed = "Godot Rocks".hash()
	
	seed(my_seed)
	while  i :
		a = randf() + randi()
		i -= 1
		#prints(a)
	i = 100
	seed(my_seed)
	while  i :
		b = randf() + randi()
		i -= 1
		prints(b)

	
	
	prints(a ,"primera semilla   ", b)
# a and b are now identical
	#randomize()
	pass

func _process(delta: float) -> void:
	#print_debug(log, "    ","prueba")
	label.text = str(Engine.get_frames_per_second())
