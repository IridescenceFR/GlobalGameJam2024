extends Node2D

signal send_parent(parent: Node2D)

# Called when the node enters the scene tree for the first time.
func _ready():
	var color_list = range(3)
	randomize()
	color_list.shuffle()
	for color in color_list:
		var bubble_scene: PackedScene = preload("res://Scenes/bubble.tscn")
		var bubble = bubble_scene.instantiate()
		bubble.color = color
		bubble.connect_to_parent(self)
		add_child(bubble)

@warning_ignore("unused_parameter")
func _on_bubble_player_joke(color, time_left):
	print(color)
