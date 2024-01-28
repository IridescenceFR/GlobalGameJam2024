extends Node2D

var score: int = 0
var combo: int = 0
var under_spotlight: bool = false
var spotlight_child


# Called when the node enters the scene tree for the first time.
func _ready():
	$StartTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spotlight_under():
	under_spotlight = true
	if $SpotlightScoreTimer.time_left == 0:
		$SpotlightScoreTimer.start()
	

func _on_spotlight_outer():
	under_spotlight = false
	combo = 0




func create_spotlight():
	var spotlight = load("res://projector.tscn").instantiate()
	spotlight.position = Vector2(960,0)
	spotlight.connect_to_parent(self)
	spotlight_child = spotlight
	return spotlight


func _on_start_timer_timeout():
	add_child(create_spotlight())
	$SpotlightTimer.start()


func _on_spotlight_timer_timeout():
	if combo > 8:
		score += 300
	spotlight_child.queue_free()
	$StartTimer.start()


func _on_spotlight_score_timer_timeout():
	if under_spotlight:
		$SpotlightScoreTimer.start()
		combo += 1
		if combo > 2:
			score += 150
		else:
			score += 100

