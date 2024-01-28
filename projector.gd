extends Area2D

var speed = 600
var direction: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	$SpotlightConeback.set_visible(false)
	if randi() % 2 == 0:
		direction = Vector2.LEFT
	else:
		direction = Vector2.RIGHT


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	position += direction * speed * delta
	


func _on_body_entered(body):
	$SpotlightConeback.set_visible(true)


func _on_body_exited(body):
	$SpotlightConeback.set_visible(false)
