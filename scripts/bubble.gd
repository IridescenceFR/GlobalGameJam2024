extends Button

signal player_joke(color: int, time_left: float)

var color:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_pressed():
	player_joke.emit(color)

func connect_to_parent(parent, given_color):
	if (given_color == 0) :
		self.text = "Y e a E"
		self.add_theme_color_override("font_color", Color(255,0,0,2))
		var new_stylebox_normal = self.get_theme_stylebox("normal").duplicate()
		new_stylebox_normal.border_width_top = 3
		new_stylebox_normal.border_color = Color(255, 0, 0)
		self.add_theme_stylebox_override("normal", new_stylebox_normal)
	if (given_color == 1) :
		self.text = "m V N n"
		self.add_theme_color_override("font_color", Color(0,255,0,2))
		var new_stylebox_normal = self.get_theme_stylebox("normal").duplicate()
		new_stylebox_normal.border_width_top = 3
		new_stylebox_normal.border_color = Color(0, 255, 0)
		self.add_theme_stylebox_override("normal", new_stylebox_normal)
	if (given_color == 2) :
		self.text = "q Z s Q"
		self.add_theme_color_override("font_color", Color(0,0,255,2))
		var new_stylebox_normal = self.get_theme_stylebox("normal").duplicate()
		new_stylebox_normal.border_width_top = 3
		new_stylebox_normal.border_color = Color(0, 0, 255)
		self.add_theme_stylebox_override("normal", new_stylebox_normal)
	if (parent) :
		self.player_joke.connect(parent._on_bubble_player_joke)
