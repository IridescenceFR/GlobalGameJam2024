extends Node

var score: int = 0
var combo: int = 0
var spectators_array : Array
var round_number = 0
var color_list = range(3)
var under_spotlight: bool = false
var spotlight_child
var round_with_spotlight = [4,6,8,10]
var right_answer:int = 0
var wrong_answer:int = 0

signal show_aura()
#signal cherchant à déclancher le changement de la couleur de l'aura d'un spectateur
signal suppress_aura()

func _ready():
	create_spectators()
	add_child(load("res://Scenes/onion.tscn").instantiate())	

func game_over():
	$HUD.update_score(score)
	$HUD.show_game_over()

func _on_hud_start_game():
	score = 0
	round_number = 0
	$HUD.update_score(score)
	give_spectators_color()
	spawn_bubble()

func spawn_bubble():
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
	round_number += 1
	
func give_spectators_color():
	var random = RandomNumberGenerator.new()
	random.randomize()
	
	# RÉPARTITION DES COULEURS
	var spect_count_color_0 = random.randi_range(1, 4)
	var spect_count_color_1 = random.randi_range(5, 7)
	var spect_count_color_2 = 20 - (spect_count_color_0 + spect_count_color_1)
	var count_array = [spect_count_color_0, spect_count_color_1, spect_count_color_2]
	
	# RANDOM QUEL COULEUR QUEL %
	randomize()
	count_array.shuffle()
	var color_array = []
	for i in range(3):
		if count_array[i] == spect_count_color_2 :
			right_answer = i
		if count_array[i] == spect_count_color_0 :
			wrong_answer = i
		var tmp_array = []
		tmp_array.resize(count_array[i])
		tmp_array.fill(i)
		color_array += tmp_array

	color_array.shuffle()
	for i in range(spectators_array.size()):
		spectators_array[i].index_newAura = color_array[i]
	show_aura.emit()

func remove_spectators_color():
	suppress_aura.emit()

func _on_bubble_player_joke(color):
	# DISABLE DES RÉPONSES 
	var array_of_nodes = get_tree().get_nodes_in_group("bubbles")
	for b in array_of_nodes:
		b.disabled = true
	
	# CALCULE DU SCORE
	if color == right_answer:
		score += 1000
		create_score(1000, Vector2(950, 100))		
		var time_left = $OutOfTimeTimer.get_time_left()
		$OutOfTimeTimer.stop()
		print(time_left)
		if time_left > 2 :
			score += 200
			create_score(200, Vector2(950, 50))				
	elif color == wrong_answer:
		score += 250
		create_score(250, Vector2(950, 100))		
	else :
		score += 500
		create_score(500, Vector2(950, 100))		
	$HUD.update_score(score)
	
	
	# START NEW ROUND
	$NewJokeTimer.start()

func _on_start_new_round():
	remove_spectators_color()
	
	# SUPPRESSION DES ANCIENNES RÉPONSES 
	var array_of_nodes = get_tree().get_nodes_in_group("bubbles")
	for b in array_of_nodes:
		b.queue_free()
	
	# CACHE LE SCORE 
	
	if spotlight_child == null :
		$BreatheBetweenJokesTimer.start()

func _on_breathe_between_jokes_timer_timeout():
	# RESTART DES BULLES + SPECTATOR
	give_spectators_color()
	spawn_bubble()
	if round_with_spotlight.has(round_number):
		add_child(create_spotlight())
		$SpotlightTimer.start()

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

################################################################################
##########                        SPOTLIGHT                           ##########
################################################################################
### Promis je commente demain !!!


func create_spotlight():
	var spotlight = load("res://projector.tscn").instantiate()
	spotlight.position = Vector2(960,0)
	spotlight.connect_to_parent(self)
	spotlight_child = spotlight
	return spotlight
	
	
func _on_spotlight_timer_timeout():
	if combo > 4:
		score += 300
		create_score(300, Vector2(950, 150))
	$HUD.update_score(score)
	if spotlight_child != null:
		spotlight_child.free()
	if round_number == 10:
		game_over()
	else:
		$BreatheBetweenJokesTimer.start()

func _on_spotlight_score_timer_timeout():
	if under_spotlight:
		$SpotlightScoreTimer.start()
		combo += 1
		if combo > 2:
			score += 200
			create_score(200, Vector2(950, 150))		
		else:
			score += 100
			create_score(100, Vector2(950, 150))					
	$HUD.update_score(score)


func _on_spotlight_under():
	under_spotlight = true
	if $SpotlightScoreTimer.time_left == 0:
		$SpotlightScoreTimer.start()


func _on_spotlight_outer():
	under_spotlight = false
	combo = 0

func create_score(scoring : int, pos : Vector2):
	var Score_scene : PackedScene = load("res://Scenes/score.tscn")
	var newScore= Score_scene.instantiate()
	newScore.position = pos
	newScore.score = scoring
	add_child(newScore)
