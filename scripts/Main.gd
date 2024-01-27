extends Node

var score = 0;
var spectators_array : Array
var round = 0

signal show_aura()
#signal cherchant à déclancher le changement de la couleur de l'aura d'un spectateur
signal suppress_aura()

func _ready():
	create_spectators()

func game_over():
	$ScoreTimer.stop()
	$HUD.update_score(score)
	$HUD.show_game_over()

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_hud_start_game():
	score = 0
	round = 0
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
		bubble.connect_to_parent(self, color)
		bubble.add_to_group("bubbles")
		add_child(bubble)
		pos_x += 400
	$OutOfTimeTimer.start()
	round += 1

@warning_ignore("unused_parameter")
func _on_bubble_player_joke(color):
	# CALCULE DU SCORE
	print(color)
	
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
	
	if round == 10:
		game_over()
	else :
		$BreatheBetweenJokesTimer.start()

func _on_breathe_between_jokes_timer_timeout():
	# RESTART DES BULLES
	spawn_bubble()

func create_spectators():
	var newPos : Vector2 = Vector2(250, 920)
	var spectator_scene : PackedScene = load("res://Spectateur/Spectator.tscn")
	
	for i in range(10):
		var newSpec = spectator_scene.instantiate()
		newSpec.position = newPos
		newSpec.is_back = false
		spectators_array.push_back(newSpec)
		add_child(newSpec)
		show_aura.connect(newSpec._on_test_spectateur_show_aura)
		suppress_aura.connect(newSpec._on_test_spectateur_suppress_aura)
		newPos.x += 155
		
	newPos = Vector2(120, 1000)
	
	for i in range(10):
		var newSpec = spectator_scene.instantiate()
		newSpec.position = newPos
		newSpec.is_back = true
		spectators_array.push_back(newSpec)
		add_child(newSpec)
		show_aura.connect(newSpec._on_test_spectateur_show_aura)
		suppress_aura.connect(newSpec._on_test_spectateur_suppress_aura)
		newPos.x += 185
