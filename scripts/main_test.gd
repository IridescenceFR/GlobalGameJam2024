extends Node2D

signal send_parent(parent: Node2D)

# Called when the node enters the scene tree for the first time.
func _ready():
	var random = RandomNumberGenerator.new()
	random.randomize()
	var color_list = range(3)
	randomize()
	color_list.shuffle()
	for color in color_list:
		var bubble_scene: PackedScene = preload("res://Scenes/bubble.tscn")
		var bubble = bubble_scene.instantiate()
		bubble.color = color
		self.send_parent.connect(bubble._on_send_parent)
		send_parent.emit(self)
		add_child(bubble)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_bubble_player_joke(color, time_left):
	print(color)
