extends CharacterBody2D

var speed = 580
var direction = Vector2.ZERO

func _ready():
	$AnimatedSprite2D.play()
	position = Vector2(960,550)

func _process(delta):
	direction = Vector2.ZERO
	if Input.is_action_pressed("move_left") && position.x > 550:
		direction = Vector2.LEFT
		$AnimatedSprite2D.animation = "walk"
		if !$WalkSound.is_playing():
			$WalkSound.play()
	elif Input.is_action_pressed("move_right") && position.x < 1450:
		direction = Vector2.RIGHT
		$AnimatedSprite2D.animation = "walk"
		if !$WalkSound.is_playing():
			$WalkSound.play()
	else:
		$AnimatedSprite2D.animation = "idle"
	
	position += direction * speed * delta
