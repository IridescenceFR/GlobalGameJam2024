extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game


func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
	pass # Replace with function body.
