extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	create_score(100, Vector2(1600, 666))



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func create_score(scoring : int, pos : Vector2):
	var Score_scene : PackedScene = load("res://Scenes/score.tscn")
	var newScore= Score_scene.instantiate()
	newScore.position = pos
	newScore.score = scoring
	add_child(newScore)


func _input(event):
		#selon la touche préssée, l'aura du spectateur change via une émission de signal
	if event.is_action_pressed("add_score"):
		var scoreArray = [100, 200, 250, 300, 500, 1000]
		create_score(scoreArray.pick_random(), Vector2(1600, 666 + randi_range(-100, 100)))
		pass
