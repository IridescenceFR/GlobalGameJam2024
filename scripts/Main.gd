extends Node

var score: int = 0
var combo: int = 0
var spectators_array : Array
var round_number = 0
var color_list = range(3)
var under_spotlight: bool = false
var spotlight_child
const ROUND_WITH_SPOTLIGHT = [4,6,8,10]
var right_answer:int = 0
var wrong_answer:int = 0
var onion
var speakers
var is_hardmode_active: bool = false
var is_spotlight_madness_active: bool = false
var is_speedmode_active: bool = false

# signal qui demande aux spectateurs de montrer leur aura
signal show_aura()
# signal qui demande aux spectateurs de supprimer leur aura
signal suppress_aura()
# signal qui demande aux bulles de se supprimer et au spectateur de supprimer leur aura
signal destroy()


# function qui se déclanche à la création de Main
func _ready():
	create_spectators()
	onion = load("res://Scenes/onion.tscn").instantiate()
	add_child(onion)
	speakers = get_tree().get_nodes_in_group("speakers")
	for anim: AnimatedSprite2D in speakers:
		anim.animation = "default"
		anim.play()


func _on_hud_start_game():
	score = 0
	round_number = 0
	$HUD.update_score(score)
	give_spectators_color()
	spawn_bubble()


func give_spectators_color():

	# RÉPARTITION DES COULEURS
	var spect_count_color_0 = 5
	var spect_count_color_1 = 7
	var spect_count_color_2 = 8
	
	if !is_hardmode_active:
		spect_count_color_0 = randi_range(1, 4)
		spect_count_color_1 = randi_range(5, 7)
		spect_count_color_2 = 20 - (spect_count_color_0 + spect_count_color_1)
	var count_array = [spect_count_color_0, spect_count_color_1, spect_count_color_2]
	
	# RANDOM QUEL COULEUR QUEL %
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
	if is_speedmode_active:
		$SpeedTimer.start()


func _on_speed_timer_timeout():
	suppress_aura.emit()


func _on_bubble_player_joke(color):
	# DISABLE DES RÉPONSES 
	$VoiceLine.stop()
	var array_of_bubbles = get_tree().get_nodes_in_group("bubbles")
	for b in array_of_bubbles:
		b.disabled = true
	
	# CALCULE DU SCORE
	if color == right_answer:
		score += 1000
		create_score(1000, 0)		
		$SuperRireLine.play()
		var time_left = $OutOfTimeTimer.get_time_left()
		if time_left > 2 :
			score += 200
			create_score(200, 1)				
	elif color == wrong_answer:
		$MalaiseLine.play()
		score += 250
		create_score(250, 0)		
	else :
		$RireLine.play()
		score += 500
		create_score(500, 0)		
	$HUD.update_score(score)
	$OutOfTimeTimer.stop()
	
	# START NEW ROUND
	$NewJokeTimer.start()


func _on_out_of_time_timer_timeout():
	$NothingLine.play()
	_on_start_new_round()


func _on_start_new_round():
	# Supprime les Bulles et l'Aura des spectateurs
	destroy.emit()
	
	# CACHE LE SCORE 
	if round_number != 10:
		if spotlight_child == null :
			$BreatheBetweenJokesTimer.start()
			if is_spotlight_madness_active || ROUND_WITH_SPOTLIGHT.has(round_number + 1):
				$HUD.show_message("Bonus spotlight!", 1.5)
				$SpotlightAlert.play()
				for anim: AnimatedSprite2D in speakers:
					anim.animation = "warning"


func _on_breathe_between_jokes_timer_timeout():
	# RESTART DES BULLES + SPECTATOR
	give_spectators_color()
	spawn_bubble()
	for anim: AnimatedSprite2D in speakers:
		anim.animation = "default"
		
	if is_spotlight_madness_active || ROUND_WITH_SPOTLIGHT.has(round_number):
		add_child(create_spotlight())
		$SpotlightTimer.start()


func game_over():
	$HUD.update_score(score)
	$HUD.show_game_over()
	destroy.emit()

################################################################################
##########                        BUBBLES                             ##########
################################################################################

func spawn_bubble():
	randomize()
	color_list.shuffle()
	var pos_x = -186
	for color in color_list:
		var bubble_scene: PackedScene = preload("res://Scenes/bubble.tscn")
		var bubble = bubble_scene.instantiate()
		bubble.color = color
		bubble.position = Vector2(560 + pos_x, 100)
		bubble.connect_to_parent(self, color)
		destroy.connect(bubble.be_free)
		bubble.add_to_group("bubbles")
		add_child(bubble)
		pos_x += 400
	$OutOfTimeTimer.start()
	round_number += 1
	$VoiceLine.play()
	
################################################################################
##########                        SPECTATOR                           ##########
################################################################################
	
func create_spectators():
	var newPos : Vector2 = Vector2(250, 920)
	var spectator_scene : PackedScene = load("res://Spectateur/Spectator.tscn")
	
	for i in range(10):
		var newSpec = spectator_scene.instantiate()
		newSpec.position = newPos
		newSpec.is_back = false
		spectators_array.push_back(newSpec)
		add_child(newSpec)
		show_aura.connect(newSpec.show_aura)
		destroy.connect(newSpec.suppress_aura)
		suppress_aura.connect(newSpec.suppress_aura)
		newPos.x += 155
		
	newPos = Vector2(120, 1000)
	
	for i in range(10):
		var newSpec = spectator_scene.instantiate()
		newSpec.position = newPos
		newSpec.is_back = true
		spectators_array.push_back(newSpec)
		add_child(newSpec)
		show_aura.connect(newSpec.show_aura)
		destroy.connect(newSpec.suppress_aura)
		suppress_aura.connect(newSpec.suppress_aura)
		newPos.x += 185

################################################################################
##########                        SPOTLIGHT                           ##########
################################################################################

func create_spotlight():
	var spotlight = load("res://Scenes/projector.tscn").instantiate()
	spotlight.position = Vector2(960,0)
	spotlight.connect_to_parent(self)
	spotlight_child = spotlight
	return spotlight
	
	
func _on_spotlight_timer_timeout():
	if combo == 4:
		score += 300
		create_score(300, 3)
		$ScoreSound5.play()
	$HUD.update_score(score)
	if spotlight_child != null:
		spotlight_child.free()
	if round_number == 10:
		game_over()
	else:
		_on_start_new_round()


func _on_spotlight_score_timer_timeout():
	if under_spotlight:
		$SpotlightScoreTimer.start()
		combo += 1
		var ss = "ScoreSound%s" % combo
		get_node(ss).play()
		if combo > 2:
			score += 200
			create_score(200, 2)
		else:
			score += 100
			create_score(100, 2)
	$HUD.update_score(score)


func _on_spotlight_under():
	under_spotlight = true
	if $SpotlightScoreTimer.time_left == 0:
		$SpotlightScoreTimer.start()


func _on_spotlight_outer():
	under_spotlight = false
	combo = 0

################################################################################
##########                        SCORE                               ##########
################################################################################

#type_0 = bouton; type_1 = bonus; type_2 = light; type_3 = light_bonus
func create_score(scoring : int, type: int):
	var pos = Vector2.ZERO
	var Score_scene : PackedScene = load("res://Scenes/score.tscn")
	var newScore= Score_scene.instantiate()
	if type < 2:
		pos = get_viewport().get_mouse_position()
		if type == 0:
			pos.y -= 50
		else:
			pos.y += 50
	else:
		pos = onion.position

		if onion.position.x > 960:
			pos.x = onion.position.x - 200
			if type == 3:
				pos.x -= 250
		else:
			pos.x = onion.position.x + 200
			if type == 3:
				pos.x += 250
		pos.y = onion.position.y
	newScore.score = scoring
	newScore.position = pos
	add_child(newScore)
