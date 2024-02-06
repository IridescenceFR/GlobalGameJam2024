extends Control

signal hard_mode
signal speed_mode
signal spotlight_madness

var check = load("res://assets/Checkbox.png")
var uncheck = load("res://assets/Checkbox_Case.png")


func _on_hard_mode_toggled(toggled_on):
	var button = get_child(0)
	hard_mode.emit()
	if toggled_on:
		button.icon = check
	else:
		button.icon = uncheck


func _on_speed_mode_toggled(toggled_on):
	var button = get_child(1)
	speed_mode.emit()
	if toggled_on:
		button.icon = check
	else:
		button.icon = uncheck


func _on_spotlight_madness_toggled(toggled_on):
	var button = get_child(2)
	spotlight_madness.emit()
	if toggled_on:
		button.icon = check
	else:
		button.icon = uncheck
