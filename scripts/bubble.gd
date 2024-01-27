extends Button

var color:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
	print($hideJoke.get_time_left())
	queue_free()
