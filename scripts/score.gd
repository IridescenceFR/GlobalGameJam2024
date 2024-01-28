extends Node2D

#+100
#+200
#+250
#+300
#+500
#+1000
#var texture100 = "res://assets/.png"
#var texture200 = "res://assets/.png"
#var texture250 = "res://assets/.png"
#var texture300= "res://assets/.png"
#var texture500 = "res://assets/.png"
#var texture1000= "res://assets/.png"


var score : int = -1
# Called when the node enters the scene tree for the first time.
func _ready():
	match score:
		100:
			get_child(0).texture = load("res://assets/Score_100.png")
		200:
			get_child(0).texture = load("res://assets/Score_200.png")
		250:
			get_child(0).texture = load("res://assets/Score_250.png")
		300:
			get_child(0).texture = load("res://assets/Score_300.png")
		500:
			get_child(0).texture = load("res://assets/Score_500.png")
		1000:
			get_child(0).texture = load("res://assets/Score_1000.png")
		_:
			pass
			
	rotation = randf_range(-0.3, 0.3)
	#$timerScore.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2.UP * 10 * delta
	modulate -= Color(0,0,0,1) * delta
	
	if modulate == Color(255,255,255,0) :
		queue_free()
