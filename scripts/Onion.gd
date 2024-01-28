extends CharacterBody2D

var speed = 550

func _ready():
	$AnimatedSprite2D.play()

func _process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("move_left") && position.x > 550:
		direction = Vector2.LEFT
	if Input.is_action_pressed("move_right") && position.x < 1450:
		direction = Vector2.RIGHT
	
	if direction == Vector2.ZERO:
		$AnimatedSprite2D.animation = "idle"
	else:
		$AnimatedSprite2D.animation = "walk"
	
	position += direction * speed * delta
