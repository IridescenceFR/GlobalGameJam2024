extends Button

signal player_joke(color: int, time_left: float)

var color:int = 0
var has_parent:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_hide_joke_timeout():
	queue_free()

func _on_pressed():
	$hideJoke.set_paused(true)
	player_joke.emit(color, $hideJoke.get_time_left())
	queue_free()

func connect_to_parent(parent):
	if (parent) :
		self.player_joke.connect(parent._on_bubble_player_joke)
