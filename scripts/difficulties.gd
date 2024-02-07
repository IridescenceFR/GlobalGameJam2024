extends Control

signal hard_mode(bool)
signal speed_mode(bool)
signal spotlight_madness(bool)

var check = load("res://assets/Checkbox.png")
var uncheck = load("res://assets/Checkbox_Case.png")


func _on_hard_mode_toggled(toggled_on):
	var button = get_child(0)
	hard_mode.emit(toggled_on)
	if toggled_on:
		button.icon = check
	else:
		button.icon = uncheck


func _on_speed_mode_toggled(toggled_on):
	var button = get_child(1)
	speed_mode.emit(toggled_on)
	if toggled_on:
		button.icon = check
	else:
		button.icon = uncheck


func _on_spotlight_madness_toggled(toggled_on):
	var button = get_child(2)
	spotlight_madness.emit(toggled_on)
	if toggled_on:
		button.icon = check
	else:
		button.icon = uncheck
