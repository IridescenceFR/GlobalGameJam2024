extends Button

signal player_joke(color: int, time_left: float)

var color:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_show_joke_timeout():
	visible = true
	$hideJoke.start()

func _on_hide_joke_timeout():
	queue_free()

func _on_pressed():
	$hideJoke.set_paused(true)
	player_joke.emit(color, $hideJoke.get_time_left())
	queue_free()

func _on_send_parent(parent):
	self.player_joke.connect(parent._on_bubble_player_joke)
