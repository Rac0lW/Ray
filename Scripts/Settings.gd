extends Node


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ESC"):
		get_tree().quit()
