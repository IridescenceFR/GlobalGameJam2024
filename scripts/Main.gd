extends Node

var score = 0;

func game_over():
	$ScoreTimer.stop()

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_hud_start_game():
	$HUD.update_score(score)
	$ScoreTimer.start()
	spawn_bubble()

func spawn_bubble():
	var color_list = range(3)
	randomize()
	color_list.shuffle()
	var pos_x = 0
	for color in color_list:
		var bubble_scene: PackedScene = preload("res://Scenes/bubble.tscn")
		var bubble = bubble_scene.instantiate()
		bubble.color = color
		bubble.position = Vector2(410 + pos_x, 200)
		bubble.connect_to_parent(self)
		bubble.add_to_group("bubbles")
		add_child(bubble)
		pos_x += 400
	$OutOfTimeTimer.start()

@warning_ignore("unused_parameter")
func _on_bubble_player_joke(color):
	# CALCULE DU SCORE
	print(color)
	
	$OutOfTimeTimer.set_paused(true)
	var time_left = $OutOfTimeTimer.get_time_left()
	$OutOfTimeTimer.stop()
	
	# START NEW ROUND
	$NewJokeTimer.start()

func _on_start_new_round():
	# SUPPRESSION DES ANCIENNES RÉPONSES 
	var array_of_nodes = get_tree().get_nodes_in_group("bubbles")
	for b in array_of_nodes:
		b.queue_free()
	# CACHE LE SCORE 
	
	$BreatheBetweenJokesTimer.start()

func _on_breathe_between_jokes_timer_timeout():
	# RESTART DES BULLES
	spawn_bubble()
