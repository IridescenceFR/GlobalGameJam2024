extends Node

var score = 0;

func game_over():
	$ScoreTimer.stop()

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_hud_start_game():
	$HUD.update_score(score)
	$ScoreTimer.start()
