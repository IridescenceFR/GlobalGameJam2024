extends Area2D

var speed = 300
var direction: Vector2
var girouette: int = 2

signal on_under_spotlight
signal on_outer_spotlight


# Called when the node enters the scene tree for the first time.
func _ready():
	$SpotlightConeback.set_visible(false)
	if randi() % 2 == 0:
		direction = Vector2.LEFT
	else:
		direction = Vector2.RIGHT


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.x < 550:
		direction = Vector2.RIGHT
		girouette = 2
	elif position.x > 1450:
		direction = Vector2.LEFT
		girouette = 2
	
	if girouette > 0 && randf() > 0.99:
		direction = -direction
		girouette -= 1
	
	position += direction * speed * delta

func _exit_tree():
	on_outer_spotlight.emit()

func _on_body_entered(_body):
	$SpotlightConeback.set_visible(true)
	on_under_spotlight.emit()

func _on_body_exited(_body):
	$SpotlightConeback.set_visible(false)
	on_outer_spotlight.emit()

func connect_to_parent(parent):
	if(parent):
		self.on_under_spotlight.connect(parent._on_spotlight_under)
		self.on_outer_spotlight.connect(parent._on_spotlight_outer)
