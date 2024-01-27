extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game


func _on_start_button_pressed():
	$StartButton.hide()
	$QuitButton.hide()
	$Title.hide()
	$ScoreLabel.hide()	
	$Countdown.show()		
	show_message("The show will begin in")

	await $MessageTimer.timeout
	$Message.hide()
	$Countdown.hide()
	start_game.emit()

func _process(delta):
	$Countdown.text = str("%.1f" % $MessageTimer.time_left)
	
func _on_message_timer_timeout():
	$Message.hide()

func _on_quit_pressed():
	get_tree().quit()
	pass # Replace with function body.

func update_score(score):
	$ScoreLabel.text = str(score)
	
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Perdu")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Message.text = "Dodge the Creeps"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
