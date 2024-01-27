extends Node2D

class_name Spectator

# Récupération des node d'auras dans des variables 
@onready var auraRouge : Sprite2D = %auraRouge
@onready var auraVert : Sprite2D = %auraVerte
@onready var auraBleu : Sprite2D = %auraBleu


@export var idleSpeed = 50.0
@export var idleRange = 20
@export var speedRange = 200

var direction : Vector2 = Vector2.ZERO
var is_go_up = true
var is_back = false
var currentPosition : Vector2

# Déclaration de variable contenant les chemin vers les ressources du sprite du spectateur
var textureSpectator1 = "res://Spectateur/Sprites/Spectateur1.png"
var textureSpectator2 = "res://Spectateur/Sprites/Spectateur2.png"
var textureSpectator3 = "res://Spectateur/Sprites/Spectateur3.png"
var textureSpectator4 = "res://Spectateur/Sprites/Spectateur4.png"
var textureSpectator5 = "res://Spectateur/Sprites/Spectateur5.png"
var textureSpectator6 = "res://Spectateur/Sprites/Spectateur6.png"
var textureSpectator7 = "res://Spectateur/Sprites/Spectateur7.png"
var textureSpectator8 = "res://Spectateur/Sprites/Spectateur8.png"

var textureSpectator1fonce = "res://Spectateur/Sprites/Spectateur1fonce.png"
var textureSpectator2fonce = "res://Spectateur/Sprites/Spectateur2fonce.png"
var textureSpectator3fonce = "res://Spectateur/Sprites/Spectateur3fonce.png"
var textureSpectator4fonce = "res://Spectateur/Sprites/Spectateur4fonce.png"
var textureSpectator5fonce = "res://Spectateur/Sprites/Spectateur5fonce.png"
var textureSpectator6fonce = "res://Spectateur/Sprites/Spectateur6fonce.png"
var textureSpectator7fonce = "res://Spectateur/Sprites/Spectateur7fonce.png"
var textureSpectator8fonce = "res://Spectateur/Sprites/Spectateur8fonce.png"

@onready var dark_layer = %darkLayer

# Déclaration d'une array contenant les variables contenant le chemin des ressources
var textureSpectatorArrayBack : Array
var textureSpectatorArrayFront : Array

# Déclaration d'une variable aura courante qui contiendra le node d'aura couramment affiché, 
var currentAura : Sprite2D

# Déclaration d'une variable qui contiendra l'indice de la prochaine aura à affiché dans l'array
var index_newAura : int = 0

# Déclaration d'une liste qui contiendra les nodes d'aura
var auraArray : Array


# Called when the node enters the scene tree for the first time.
func _ready():
	#met une texture aléatoire au node SpectatorSprite2D
	is_go_up = randi_range(0,1)
	if is_back:
		textureSpectatorArrayBack = [textureSpectator1fonce, textureSpectator2fonce, textureSpectator3fonce, 
		textureSpectator4fonce, textureSpectator5fonce, textureSpectator6fonce, textureSpectator7fonce, 
		textureSpectator8fonce]
		var rand_index = randi() % textureSpectatorArrayBack.size()
		get_child(0,false).texture = load(textureSpectatorArrayBack[rand_index])
	else:
		textureSpectatorArrayFront = [textureSpectator1, textureSpectator2, textureSpectator3, textureSpectator4,
		textureSpectator5, textureSpectator6, textureSpectator7, textureSpectator8]
		var rand_index = randi() % textureSpectatorArrayFront.size()
		get_child(0,false).texture = load(textureSpectatorArrayFront[rand_index])
	currentPosition = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_go_up:
		direction = Vector2.UP
	else:
		direction = Vector2.DOWN
	if position.y < currentPosition.y - idleRange:
		is_go_up = false
	if position.y > currentPosition.y + idleRange:
		is_go_up = true
	
	position += direction * (idleRange + randi_range(speedRange,-speedRange)) * delta

# Lance la fonction affichant les nodes d'aura avec comme argument un node aléatoire à la fin de timer TimeShowColor
func _on_timer_show_aura_timeout():
	auraArray = [auraRouge, auraVert, auraBleu]
	var randIndex = randi() % auraArray.size()
	set_new_aura(auraArray[randIndex])
	$TimerHideAura.start()

# Lance la fonction rendant invisible le nodes d'aura courant à la fin de timer TimeShowColor
func _on_timer_hide_aura_timeout():
	supress_current_aura()
	#$TimerShowAura.start()
	
	
# Rend invisible le node d'aura courrament affiché et rend visible le node passé en argument 
func set_new_aura(newAura : Sprite2D):
	if currentAura != null :
		if newAura != currentAura :
			currentAura.set_visible(false)
			newAura.set_visible(true)
			currentAura = newAura
	else :
		newAura.set_visible(true)
		currentAura = newAura

# Rend invisible le node d'aura couramment affiché
func supress_current_aura():
	if currentAura != null:
		currentAura.set_visible(false)
		currentAura = null

# Ecoute le signal add_aura et update le node d'aura affiché selon l'argument reçu 
#func _on_test_spectateur_add_aura(color):
	#auraArray = [auraRouge, auraVert, auraBleu]
	#set_new_aura(auraArray[color])
	##$TimerHideAura.start()
	

# Ecoute le signal suppress_aura et rend invisible le node d'aura courant
func _on_test_spectateur_suppress_aura():
	supress_current_aura()


func _on_test_spectateur_show_aura():
	auraArray = [auraRouge, auraVert, auraBleu]
	set_new_aura(auraArray[index_newAura])
	pass # Replace with function body.
