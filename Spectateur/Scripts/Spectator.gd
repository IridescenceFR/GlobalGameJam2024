extends Node2D

class_name Spectator

# Déclaration d'une liste qui contiendra les nodes d'aura
var auraArray : Array

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


# Déclaration d'une array contenant les variables contenant le chemin des ressources
var textureSpectatorArrayBack : Array
var textureSpectatorArrayFront : Array


# Déclaration d'une variable qui contiendra l'indice de la prochaine aura à affiché dans l'array
var index_newAura : int = -1



# Called when the node enters the scene tree for the first time.
func _ready():
	auraArray = ["res://Spectateur/Sprites/violetCrown.png", "res://Spectateur/Sprites/greenCrown.png",
	"res://Spectateur/Sprites/blueCrown.png"]
	
	#met une texture aléatoire au node SpectatorSprite2D
	is_go_up = randi_range(0,1)
	if is_back:
		textureSpectatorArrayBack = [textureSpectator1fonce, textureSpectator2fonce, textureSpectator3fonce, 
		textureSpectator4fonce, textureSpectator5fonce, textureSpectator6fonce, textureSpectator7fonce, 
		textureSpectator8fonce]
		get_child(0,false).texture = load(textureSpectatorArrayBack.pick_random())
	else:
		textureSpectatorArrayFront = [textureSpectator1, textureSpectator2, textureSpectator3, textureSpectator4,
		textureSpectator5, textureSpectator6, textureSpectator7, textureSpectator8]
		get_child(0,false).texture = load(textureSpectatorArrayFront.pick_random())
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
	
	position += direction * (idleSpeed + randi_range(speedRange,-speedRange)) * delta
	

func show_aura():
	get_child(0).add_child(Sprite2D.new())
	get_child(0).get_child(0).position.y -= 20
	get_child(0).get_child(0).texture = load(auraArray[index_newAura])

	
func suppres_aura():
	if get_child(0) != null and get_child(0).get_child(0) != null:
		get_child(0).get_child(0).free()

# Ecoute le signal suppress_aura et rend invisible le node d'aura courant
func _on_test_spectateur_suppress_aura():
	suppres_aura()

func _on_test_spectateur_show_aura():
	show_aura()

