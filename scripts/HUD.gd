extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game


func _on_start_button_pressed():
	$StartButton.hide()
	$QuitButton.hide()
	$Title.hide()
	#$ScoreLabel.hide()
	$Countdown.show()
	$Pastis.hide()
	show_message("The show will begin in")

	await $MessageTimer.timeout
	$Message.hide()
	$Countdown.hide()
	$ScoreLabel.show()
	start_game.emit()

func _process(delta):
	$Countdown.text = str("%.0f" % $MessageTimer.time_left)
	
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
	$StartButton.show()
	$QuitButton.show()
	$Title.show()
	$Pastis.show()
	$ScoreLabel.hide()

func _on_pastis_pressed():
	$StartButton.hide()
	$QuitButton.hide()
	$Credits.show()
	$CreditButtonQuit.show()
	$music_pastis.play()


func _on_credit_button_quit_pressed():
	$StartButton.show()
	$QuitButton.show()
	$Credits.hide()
	$CreditButtonQuit.hide()
	$Pastis.show()

