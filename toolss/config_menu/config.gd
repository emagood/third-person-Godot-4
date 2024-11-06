# The root Control node ("Main") and AspectRatioContainer nodes are the most important
# pieces of this demo.
# Both nodes have their Layout set to Full Rect
# (with their rect spread across the whole viewport, and Anchor set to Full Rect).

extends Control
@onready var ncontent_scale_stretch = $Panel/AspectRatioContainer/Panel/CenterContainer/Options/GUIMaxAspectRatio/OptionButton
@onready var select_windows_size = $Panel/AspectRatioContainer/Panel/CenterContainer/Options/WindowBaseSize/OptionButton
var on_window_base_size_item_selected = 0
var gui_aspect_ratio_item_selected

var base_window_size = Vector2(
		ProjectSettings.get_setting("display/window/size/viewport_width"),
		ProjectSettings.get_setting("display/window/size/viewport_height")
)

# These defaults match this demo's project settings. Adjust as needed if adapting this
# in your own project.
var stretch_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS
var stretch_aspect = Window.CONTENT_SCALE_ASPECT_EXPAND


var scale_factor = 1.0
var gui_aspect_ratio = -1.0
var gui_margin = 0.0
var content_scale_stretch
@onready var panel = $Panel
@onready var arc = $Panel/AspectRatioContainer
var data: Dictionary = {}
func data_up():



	self.data = {
		"int" : 1,
		"stretchmode" : stretch_mode,
		"stretchaspect" : stretch_aspect,
		"guimargin" : gui_margin,
		"scalefactor" : scale_factor,
		"guiaspectratio" : gui_aspect_ratio,
		"content_scale_stretch": ncontent_scale_stretch.selected,
		"_on_window_base_size_item_selected": select_windows_size.selected,
		"gui_aspect_ratio_item_selected": gui_aspect_ratio_item_selected
	}
	prints(Data.save_(data),"guardo")
	self.data = Data.data
	self.stretch_mode = data["stretchmode"]
	self.stretch_aspect = data["stretchaspect"]
	self.gui_margin = data["guimargin"]
	self.scale_factor = data["scalefactor"]
	self.gui_aspect_ratio = data["guiaspectratio"]
	prints(gui_margin," ",scale_factor," ",gui_aspect_ratio)
	get_viewport().content_scale_factor = data["scalefactor"]
	
func _ready():



	prints(Data.load_(data),"guardo")
	data = Data.data
	aply()

	#
	#get_viewport().content_scale_aspect = stretch_aspect
	#get_viewport().content_scale_factor = scale_factor
	#get_viewport().content_scale_mode = stretch_mode
	#get_viewport().content_scale_stretch = stretch_mode
#
	##get_viewport().set_msaa_3d(2)
	#prints(get_viewport().get_msaa_3d())
#
#
	#prints(gui_margin," ",scale_factor," ",gui_aspect_ratio)
	## The `resized` signal will be emitted when the window size changes, as the root Control node
	## is resized whenever the window size changes. This is because the root Control node
	## uses a Full Rect anchor, so its size will always be equal to the window size.
	#update_container()

	update_container.call_deferred()

func aply():
	self.stretch_mode = data["stretchmode"]
	self.stretch_aspect = data["stretchaspect"]
	self.gui_margin = data["guimargin"]
	self.scale_factor = data["scalefactor"]
	self.gui_aspect_ratio = data["guiaspectratio"]
	self.gui_aspect_ratio_item_selected = data["gui_aspect_ratio_item_selected"]
	get_viewport().content_scale_aspect = stretch_aspect
	get_viewport().content_scale_factor = scale_factor
	get_viewport().content_scale_mode = stretch_mode
	#get_viewport().content_scale_stretch = stretch_mode
	var index = data["_on_window_base_size_item_selected"] 
	ncontent_scale_stretch.selected = data.content_scale_stretch

	select_windows_size.selected = data["_on_window_base_size_item_selected"] 

	update_container.call_deferred()
	match index:
		0:  # 648×648 (1:1)
			base_window_size = Vector2(648, 648)
		1:  # 640×480 (4:3)
			base_window_size = Vector2(640, 480)
		2:  # 720×480 (3:2)
			base_window_size = Vector2(720, 480)
		3:  # 800×600 (4:3)
			base_window_size = Vector2(800, 600)
		4:  # 1152×648 (16:9)
			base_window_size = Vector2(1152, 648)
		5:  # 1280×720 (16:9)
			base_window_size = Vector2(1280, 720)
		6:  # 1280×800 (16:10)
			base_window_size = Vector2(1280, 800)
		7:  # 1680×720 (21:9)
			base_window_size = Vector2(1680, 720)

	get_viewport().content_scale_size = base_window_size
	index = gui_aspect_ratio_item_selected 
	match index:
		0:  # Fit to Window
			gui_aspect_ratio = -1.0
		1:  # 5:4
			gui_aspect_ratio = 5.0 / 4.0
		2:  # 4:3
			gui_aspect_ratio = 4.0 / 3.0
		3:  # 3:2
			gui_aspect_ratio = 3.0 / 2.0
		4:  # 16:10
			gui_aspect_ratio = 16.0 / 10.0
		5:  # 16:9
			gui_aspect_ratio = 16.0 / 9.0
		6:  # 21:9
			gui_aspect_ratio = 21.0 / 9.0
	data_up()
	update_container.call_deferred()
	
func update_container():
	# The code within this function needs to be run deferred to work around an issue with containers
	# having a 1-frame delay with updates.
	# Otherwise, `panel.size` returns a value of the previous frame, which results in incorrect
	# sizing of the inner AspectRatioContainer when using the Fit to Window setting.
	for _i in 2:
		if is_equal_approx(gui_aspect_ratio, -1.0):
			# Fit to Window. Tell the AspectRatioContainer to use the same aspect ratio as the window,
			# making the AspectRatioContainer not have any visible effect.
			arc.ratio = panel.size.aspect()
			# Apply GUI offset on the AspectRatioContainer's parent (Panel).
			# This also makes the GUI offset apply on controls located outside the AspectRatioContainer
			# (such as the inner side label in this demo).
			panel.offset_top = gui_margin
			panel.offset_bottom = -gui_margin
		else:
			# Constrained aspect ratio.
			arc.ratio = min(panel.size.aspect(), gui_aspect_ratio)
			# Adjust top and bottom offsets relative to the aspect ratio when it's constrained.
			# This ensures that GUI offset settings behave exactly as if the window had the
			# original aspect ratio size.
			panel.offset_top = gui_margin / gui_aspect_ratio
			panel.offset_bottom = -gui_margin / gui_aspect_ratio

		panel.offset_left = gui_margin
		panel.offset_right = -gui_margin
	data_up()

func _process(delta: float) -> void:
	pass

func _on_gui_aspect_ratio_item_selected(index):
	match index:
		0:  # Fit to Window
			gui_aspect_ratio = -1.0
		1:  # 5:4
			gui_aspect_ratio = 5.0 / 4.0
		2:  # 4:3
			gui_aspect_ratio = 4.0 / 3.0
		3:  # 3:2
			gui_aspect_ratio = 3.0 / 2.0
		4:  # 16:10
			gui_aspect_ratio = 16.0 / 10.0
		5:  # 16:9
			gui_aspect_ratio = 16.0 / 9.0
		6:  # 21:9
			gui_aspect_ratio = 21.0 / 9.0
	
	data["gui_aspect_ratio_item_selected"] = index
	data_up()
	update_container.call_deferred()


func _on_resized():

	update_container.call_deferred()



func _on_window_base_size_item_selected(index):
	
	match index:
		0:  # 648×648 (1:1)
			base_window_size = Vector2(648, 648)
		1:  # 640×480 (4:3)
			base_window_size = Vector2(640, 480)
		2:  # 720×480 (3:2)
			base_window_size = Vector2(720, 480)
		3:  # 800×600 (4:3)
			base_window_size = Vector2(800, 600)
		4:  # 1152×648 (16:9)
			base_window_size = Vector2(1152, 648)
		5:  # 1280×720 (16:9)
			base_window_size = Vector2(1280, 720)
		6:  # 1280×800 (16:10)
			base_window_size = Vector2(1280, 800)
		7:  # 1680×720 (21:9)
			base_window_size = Vector2(1680, 720)
	data["_on_window_base_size_item_selected"] = on_window_base_size_item_selected
	get_viewport().content_scale_size = base_window_size
	update_container.call_deferred()


func _on_window_stretch_mode_item_selected(index):
	stretch_mode = index
	data_up()
	get_viewport().content_scale_mode = stretch_mode

	# Disable irrelevant options when the stretch mode is Disabled.
	$"Panel/AspectRatioContainer/Panel/CenterContainer/Options/WindowBaseSize/OptionButton".disabled = stretch_mode == Window.CONTENT_SCALE_MODE_DISABLED
	$"Panel/AspectRatioContainer/Panel/CenterContainer/Options/WindowStretchAspect/OptionButton".disabled = stretch_mode == Window.CONTENT_SCALE_MODE_DISABLED


func _on_window_stretch_aspect_item_selected(index):
	stretch_aspect = index
	get_viewport().content_scale_aspect = stretch_aspect




func _on_window_stretch_scale_mode_item_selected(index: int) -> void:
	get_viewport().content_scale_stretch = index
	aply()


func _on_button_pressed() -> void:
	prints(Data.save_(data),"guardo")
	queue_free()
	pass # Replace with function body.
