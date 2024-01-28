extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game


func _on_start_button_pressed():
	$StartButton.hide()
	$QuitButton.hide()
	$Title.hide()
	$ScoreFinal.hide()

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
	$ScoreLabel/ScoreBar.value = (float(score) / 14700 * 100)

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	$StartButton.text = "RESTART"
	$StartButton.show()
	$QuitButton.show()
	$Title.show()
	$Pastis.show()
	$ScoreFinal.show()
	$ScoreFinal.text = "Final score: " + $ScoreLabel.text
	$ScoreLabel.hide()

func _on_pastis_pressed():
	$StartButton.hide()
	$QuitButton.hide()
	$Credits.show()
	$CreditButtonQuit.show()
	$music_pastis.play()
	$Music.stop()


func _on_credit_button_quit_pressed():
	$StartButton.show()
	$QuitButton.show()
	$Credits.hide()
	$CreditButtonQuit.hide()
	$Pastis.show()
	$music_pastis.stop()
	$Music.play()

