extends Node2D

var score: float
var under_spotlight: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_projector_body_entered(body):
	under_spotlight = true



func _on_projector_body_exited(body):
	under_spotlight = false

