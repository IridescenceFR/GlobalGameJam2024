extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game

signal hard_mode
signal speed_mode
signal spotlight_madness

var max_score = 15600


func _on_start_button_pressed():
	$ClickButton.play()
	$StartButton.hide()
	$QuitButton.hide()
	$Title.hide()
	$ScoreFinal.hide()
	$FondSmoke.hide()
	$Difficulties.hide()

	$Countdown.show()
	$Pastis.hide()
	show_message("The show will begin in", 3)

	await $MessageTimer.timeout
	$Countdown.hide()
	$ScoreLabel.show()
	start_game.emit()

func _process(_delta):
	$Countdown.text = str("%.0f" % $MessageTimer.time_left)
	
func _on_message_timer_timeout():
	$Message.hide()

func _on_quit_pressed():
	get_tree().quit()
	pass # Replace with function body.

func update_score(score):
	$ScoreLabel.text = str(score)
	$ScoreLabel/ScoreBar.value = (float(score) / max_score * 100)

func show_message(text, time):
	$Message.text = text
	$Message.show()
	$MessageTimer.set_wait_time(time)
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
	$FondSmoke.show()
	$Difficulties.show()

func _on_pastis_pressed():
	$ClickButton.play()	
	$StartButton.hide()
	$QuitButton.hide()
	$Credits.show()
	$CreditButtonQuit.show()
	$music_pastis.play()
	$Music.stop()
	$ScoreFinal.hide()
	$Difficulties.hide()


func _on_credit_button_quit_pressed():
	$ClickButton.play()
	$StartButton.show()
	$QuitButton.show()
	$Credits.hide()
	$CreditButtonQuit.hide()
	$Pastis.show()
	$music_pastis.stop()
	$Music.play()
	$Difficulties.show()
	if $ScoreFinal.text != null:
		$ScoreFinal.show()



func _on_difficulties_hard_mode(is_active):
	hard_mode.emit(is_active)


func _on_difficulties_speed_mode(is_active):
	speed_mode.emit(is_active)


func _on_difficulties_spotlight_madness(is_active):
	spotlight_madness.emit(is_active)
	if is_active:
		max_score = 20100
	else:
		max_score = 15600
