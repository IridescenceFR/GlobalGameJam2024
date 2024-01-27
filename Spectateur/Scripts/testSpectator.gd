extends Node2D

#@onready var spectator = %Spectator
#signal cherchant à déclancher le changement de la couleur de l'aura d'un spectateur
signal show_aura()

#signal cherchant à déclancher le changement de la couleur de l'aura d'un spectateur
signal suppress_aura()

# Called when the node enters the scene tree for the first time.
func _ready():
	create_spectators()

func create_spectators():
	var newPos : Vector2 = Vector2(250, 920)
	var spectator_scene : PackedScene = load("res://Spectateur/Spectator.tscn")
	
	for i in range(10):
		var newSpec = spectator_scene.instantiate()
		newSpec.position = newPos
		newSpec.index_newAura = randi_range(0, 2)
		newSpec.is_back = false
		add_child(newSpec)
		show_aura.connect(newSpec._on_test_spectateur_show_aura)
		suppress_aura.connect(newSpec._on_test_spectateur_suppress_aura)
		newPos.x += 155
		
	newPos = Vector2(120, 1000)
	
	for i in range(10):
		var newSpec = spectator_scene.instantiate()
		newSpec.position = newPos
		newSpec.index_newAura = randi_range(0, 2)
		newSpec.is_back = true
		add_child(newSpec)
		show_aura.connect(newSpec._on_test_spectateur_show_aura)
		suppress_aura.connect(newSpec._on_test_spectateur_suppress_aura)
		newPos.x += 185


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Called quand il y a un input
func _input(event):
		#selon la touche préssée, l'aura du spectateur change via une émission de signal
	if event.is_action_pressed("q_key_show"):
		show_aura.emit()
	if event.is_action_pressed("s_key_suppress"):
		suppress_aura.emit()
	
