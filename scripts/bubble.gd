extends Button

signal player_joke(color: int, time_left: float)

var color:int = 0

# Called when the node enters the scene tree for the first time.
func _process(delta):
	fill_progress_bar(delta)
	pass

func fill_progress_bar(delta):
	print(delta)
	print($Panel/ProgressBar.value)
	$Panel/ProgressBar.value += 25 * delta
	
func _on_pressed():
	$ClickBubble.play()
	player_joke.emit(color)

func connect_to_parent(parent, given_color):
	if (given_color == 0) :
		self.text = "Y e a E"
		self.add_theme_color_override("font_color", Color("#ba65c9"))
		self.add_theme_color_override("font_hover_color",  Color("#ba65c9"))
		var new_stylebox_normal = self.get_theme_stylebox("normal").duplicate()
		new_stylebox_normal.border_width_top = 3
		new_stylebox_normal.border_color = Color("#ba65c9")
		self.add_theme_stylebox_override("normal", new_stylebox_normal)
	if (given_color == 1) :
		self.text = "m V N n"
		self.add_theme_color_override("font_color", Color("#85ba46"))
		self.add_theme_color_override("font_hover_color",  Color("#85ba46"))
		var new_stylebox_normal = self.get_theme_stylebox("normal").duplicate()
		new_stylebox_normal.border_width_top = 3
		new_stylebox_normal.border_color = Color("#85ba46")
		self.add_theme_stylebox_override("normal", new_stylebox_normal)
	if (given_color == 2) :
		self.text = "q Z s Q"
		self.add_theme_color_override("font_color",  Color("#56a7be"))
		self.add_theme_color_override("font_hover_color",  Color("#56a7be"))
		var new_stylebox_normal = self.get_theme_stylebox("normal").duplicate()
		new_stylebox_normal.border_width_top = 3
		new_stylebox_normal.border_color = Color("#56a7be")
		self.add_theme_stylebox_override("normal", new_stylebox_normal)
	if (parent) :
		self.player_joke.connect(parent._on_bubble_player_joke)
